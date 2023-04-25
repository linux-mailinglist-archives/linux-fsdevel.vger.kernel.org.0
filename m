Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D76EE1A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjDYMJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjDYMJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB24EDF;
        Tue, 25 Apr 2023 05:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C2F562363;
        Tue, 25 Apr 2023 12:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D4C433EF;
        Tue, 25 Apr 2023 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682424539;
        bh=QFaQ3a5JdgyAlWcYXx4avxLN05OkSnBdW7e+aeMmq3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAWRjHoVQn6c/Zg21sEjOsH7d6hcrzNZTnSJaeVCk9U52Ouwj1elXOl+8hEA0/XsI
         R9eyHJiacojuVOrg90rj22CF6fsF66z6HhmQOImlGDvFrITUaJFg8qf1OcS/7EW17I
         fQYmYqMhbqjglyd9ob4up7XyitEr4YAi+0Ew3O8sCR4nUSs3l7pDq/QRhgDQ5J95pn
         dpjdE8fsdL8b9xB5DP2N+Hwk6cnXV1QyewDxo3DwOySWjehW0hqK7wbu/YsqOwJ8wV
         m/JNX0OsNKVjrJKomVdgyOnJFnLJa4OtSDhiK0kXYzHcribQOv2TVJD3gL5WjnAyYU
         UjAORhK84ZhAw==
Date:   Tue, 25 Apr 2023 14:08:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425-sardinen-bespannt-c19a6bb8e74e@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <CAHk-=wgFt+rPoEH1bPG2A9K3GNebraLNcbnDiKK=Wp0i6D_0Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgFt+rPoEH1bPG2A9K3GNebraLNcbnDiKK=Wp0i6D_0Ww@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 01:35:03PM -0700, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 1:24 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I really think a potentially much nicer model would have been to
> > extend our "get_unused_fd_flags()" model.
> >
> > IOW, we could have instead marked the 'struct file *' in the file
> > descriptor table as being "not ready yet".
> 
> Maybe that isn't worth it just for pdfd, but I have this feeling that
> it might make some other code simpler too.
> 
> That pidfd case isn't the only one that has to carry both a file
> pointer and a fd around.
> 
> Looking around, I get the feeling that quite a lot of users of
> "fd_install()" might actually have been happier if they could just
> install it early, and then just have a "fd_expose(fd)" for the success
> case, and for the error cases have "put_unused_fd(fd)" also do the
> fput on the file descriptor even if the low bit was set. One less
> thing to worry about.
> 
> I dunno. Maybe not worth it. That "two return values" just made me go "Eww".

I'm not fond of "two return values" - in C at least - as well I think
open-coding get_unused_fd() is pretty nasty as well...
Let me see...
