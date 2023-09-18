Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C37A503A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjIRRCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjIRRCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067EAF;
        Mon, 18 Sep 2023 10:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD72C32788;
        Mon, 18 Sep 2023 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047715;
        bh=ZLM4uoXja+zAiLIjYwhVmMEy6VOFuum0PgmoPN9LGCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPBwd5dgOfqaXViVkdRXK1DtwA3TsAKmBHOLsoJZyq7Rx6xum+24NFGop6AbEB/fx
         aZ9PhThcmToXryHNCGbAazkNY04lInBATmbAWvq+bBef+uSOJ/FIanVNR4Pj8TGnhw
         xG921yK0Zl7KC8Hjszekg5FL/JfZcBHhTaOliV08OcfrOXA13RRe7IgnEME3HZ3a9L
         7fNCJh4afGhuMkdL4joRtsvjJ5xVtsZquIS+S4Ske6vDlx19VqSBIixn45Mf67bKrA
         960XkmwQvSnTpkauN1AI0itVwLwAVlsOuP45TKgZLBj+34Etm9URXbgIkh6bA+euo5
         WXEB7mZcHvULg==
Date:   Mon, 18 Sep 2023 16:35:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-geber-kruste-f9491ce3de41@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <3183d8b21e78dce2c1d5cbc8a1304f2937110621.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3183d8b21e78dce2c1d5cbc8a1304f2937110621.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Fixed size structs are much nicer to deal with, and most of the fields
> we're talking about don't change ofetn enough to make trying to strive
> for perfect atomicity worthwhile.

I think we can live with mnt_root and mnt_mountpoint in struct statmnt
if we add a length field for both them and make them __u64 pointers.
That's what we did in clone3() for the pid array and bpf is doing that
as well for log buffers and pathnames.

So if Miklos is fine with that then I'm happy to compromise. And I think
that's all the variable length data we want in struct statmount anyway.

> ...and then if the mnt_change_cookie hasn't changed, you know that the
> string option was stable during that window.

Meh, I would really like to sidestep this and keep it as simple as we
can. I like the proposal overall I just don't want it to get diluted too
much by exploding into another overly broad solution.
