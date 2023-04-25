Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA96EE681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjDYRTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYRTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:19:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAE5FE5;
        Tue, 25 Apr 2023 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yDubOCq/+Vw3wavnP55GMuOqZln836LcQTpmhi0jZi4=; b=ghMeWmxhirt11vOp4eAtKZbadH
        B6ePNjFGtgZhoU0MLHVdAgLjV6Bpum94P7zP3n/I7H45jfufZ7y5CUgkLKDLLIwJFvWpVqz0zoiD2
        GffHpPmrhNrgA0G4mRVfHwtjNlPlf+8XL7szZbJF9UPOANZ9XL9vadnX44tP+DscVDrPXdjwql/dx
        70bOR+67suUyLL7IUh/UlX8P9u4lmpnEGj8t5VA9zt4C3OqDNPASWhiztGYy2vMFMqU3en7g1YCTM
        eF2cUuue3hPHpJ383f+DnxdgZuGV8bcKkqKn7crEkoMjrOUvGE+D3E35LCPLDsHcfQCycOybXgxlP
        t+U0CwAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prMJt-00CTTD-1K;
        Tue, 25 Apr 2023 17:19:13 +0000
Date:   Tue, 25 Apr 2023 18:19:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425171913.GT3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:28:54AM -0700, Linus Torvalds wrote:

> Now, since they are inline functions, the code generation doesn't
> really change (compilers are smart enough to not actually generate any
> pointer stuff), but I prefer to make things like that expliict, and
> have source code that matches the code generation.
> 
> (Which is also why I do *not* endorse passing bigger structs by value,
> because then the compiler will just pass it as a "pointer to a copy"
> instead, again violating the whole concept of "source matches what
> happens in reality")
> 
> I think the above helper could be improved further with Al's
> suggestion to make 'fd_publish()' return an error code, and allow the
> file pointer (and maybe even the fd index) to be an error pointer (and
> error number), so that you could often unify the error/success paths.
> 
> IOW, I like this, and I think it's superior to my stupid original suggestion.

We'd better collect the data on the current callers first.  There are
several patterns; I'm going through the old (fairly sparse) notes and
the grep over the current tree right now, will post when I get through
that.

That's one area where we had a *lot* of recurring bugs - mostly of
leak/double put variety.  So we'd better have the calling conventions
right wrt how easy it is to fuck up in failure exits.  And we need
to document the patterns/rules for each/reasons for choosing one over
another.

Note that there's also "set the file up, then get descriptor and either
fd_install or fput, depending on get_unused_fd_flags() success";
sometimes it's the only approach (SCM_RIGHTS, for example), sometimes
it's better than "get descriptor, set the file up, then either install
or release descriptor", sometimes it's definitely worse (e.g. for
O_CREAT it's a non-starter).  It should be a deliberate choice.
