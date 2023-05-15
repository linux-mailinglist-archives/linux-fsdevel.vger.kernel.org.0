Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500F9703B06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbjEOR6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244931AbjEOR6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2215EC6;
        Mon, 15 May 2023 10:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE94062FD3;
        Mon, 15 May 2023 17:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D1C4339B;
        Mon, 15 May 2023 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684173309;
        bh=SYlCjJPnIAZdtaEsyaIOZnccee9nZDPfMhujZGhqFjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGcKw72kuHN2ccXAOuanzXd76CVT0crojUORzv13lleH5LEok6pSrx+8DsTRsvDY3
         W3rMAW/t+vzogqhgWDEfnvwQvrIBX4TbK9VaLzJHUF3Zpfqktm6mtYhYknkR7xKvd/
         1RZ+UbWdFDUsd8gmFLIOSkkEVbmRlA/1nZWDhnIiCElJQNO5Cubn74MA9t3bQkFPEF
         iNLuEvA0F/ZL7De7DRIRgf9tkZxQ5yF54rxQb3TzEFH3fCUaUg1+PRnPeVtA8FQmgL
         zqiM1Eg2avKeoOs48YC7QAlpEORSrBXK6RFqP2pK2UciN8lscVkjHXT8r99VKtrf4F
         1kuy+U8svNK6g==
Date:   Mon, 15 May 2023 19:55:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of
 O_RDWR
Message-ID: <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 06:15:41PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Gently ping.
> 
> Is there any interest?

The question that I would've loved to have an answer to was why was it
made O_RDWR and not just O_WRONLY in the first place. Was there a time
when this was meaningful? Because honestly this looks innocent and
straightforward and then it always makes me go and think "Oh, there's
probably a good reason and something super obvious I'm missing.".

Funny enough, this code was originally:

    if (open_namei("core",O_CREAT | O_WRONLY | O_TRUNC,0600,&inode,NULL)

and then became:

    if (open_namei("core",O_CREAT | 2 | O_TRUNC,0600,&inode,NULL))

in

    commit 9cb9f18b5d26 ("[PATCH] Linux-0.99.10 (June 7, 1993)")

Author/applier of said patch Cced (more for the fun of referencing
Linux-0.99.10 than anything else).

So after this commit the flag combination just got copied over and over.
First when coredump handling was moved out of fs/exec.c into the
individual binfmt handlers and then again when it was moved back into
fs/exec.c and then again when it was moved to fs/coredump.c.

So that open-coded 2 added in commit 9cb9f18b5d26 ("[PATCH]
Linux-0.99.10 (June 7, 1993)") survived for 23 years until it was
replaced by Jan in 378c6520e7d2 ("fs/coredump: prevent fsuid=0 dumps
into user-controlled directories"). 

So no one could be bothered for 23 years to use O_RDWR instead of that
lonely 2 which is kinda funny. :)

In any case, I don't see anything that suggests this would cause issues.
So I'm going to pick this up unless I'm being told I'm being obviously
stupid and this absolutely needs to be O_RDWR...

> 
> On 20.04.23 15:04, Vladimir Sementsov-Ogievskiy wrote:
> > This makes it possible to make stricter apparmor profile and don't
> > allow the program to read any coredump in the system.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >   fs/coredump.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 5df1e6e1eb2b..8f263a389175 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -646,7 +646,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >   	} else {
> >   		struct mnt_idmap *idmap;
> >   		struct inode *inode;
> > -		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
> > +		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
> >   				 O_LARGEFILE | O_EXCL;
> >   		if (cprm.limit < binfmt->min_coredump)
> 
> -- 
> Best regards,
> Vladimir
> 
