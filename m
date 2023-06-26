Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4443773E2A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjFZPAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZPAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:00:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A398AE3;
        Mon, 26 Jun 2023 08:00:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BDE91F898;
        Mon, 26 Jun 2023 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687791602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/fcn1wEBMDdvJkCRUpesNLbZjcfRf1Q6JhGJbtYFGM=;
        b=kNPTIn5F4pQQdYxCdqkjSDtrhtS6wCYfy//PxaiScW5+w9czZ50b47LQdo0HadTtcAd592
        f6Yy0WLwZLe/7cl/50nNPAnLJTzfzifHq7ZbHQYETgtSLV+aNrVxwrW0zD9EVjBPgR7Cc0
        +bxv0z356jtET4U9Fpokg/c5GQlcwmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687791602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/fcn1wEBMDdvJkCRUpesNLbZjcfRf1Q6JhGJbtYFGM=;
        b=yleeCvhSwIf7GKb0Ikeh9xTqqSJ4gEotTr9+CRjmYu5s5qgCPIlw3FQBcnKGz2WeXvsGaE
        VdcDytLIwDorsqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C4F113905;
        Mon, 26 Jun 2023 15:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0nCVEvKnmWSeFwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 15:00:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C87A4A0754; Mon, 26 Jun 2023 17:00:01 +0200 (CEST)
Date:   Mon, 26 Jun 2023 17:00:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <20230626150001.rl7m7ngjsus4hzcs@quack3>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
 <20230626135159.wzbtjgo6qryfet4e@quack3>
 <bngangrplbxesizu5kbi442fw2et5dzh723nzxsqj2b2p5ikze@dtnajlktfc2g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bngangrplbxesizu5kbi442fw2et5dzh723nzxsqj2b2p5ikze@dtnajlktfc2g>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-06-23 16:25:41, Ahelenia Ziemiańska wrote:
> On Mon, Jun 26, 2023 at 03:51:59PM +0200, Jan Kara wrote:
> > On Mon 26-06-23 14:57:55, Ahelenia Ziemiańska wrote:
> > > On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemiańska wrote:
> > > > > splice(2) differentiates three different cases:
> > > > >         if (ipipe && opipe) {
> > > > > ...
> > > > >         if (ipipe) {
> > > > > ...
> > > > >         if (opipe) {
> > > > > ...
> > > > > 
> > > > > IN_ACCESS will only be generated for non-pipe input
> > > > > IN_MODIFY will only be generated for non-pipe output
> > > > >
> > > > > Similarly FAN_ACCESS_PERM fanotify permission events
> > > > > will only be generated for non-pipe input.
> > > Sorry, I must've misunderstood this as "splicing to a pipe generates
> > > *ACCESS". Testing reveals this is not the case. So is it really true
> > > that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?
> > So why doesn't poll(3) work? AFAIK it should...
> poll returns instantly with revents=POLLHUP for pipes that were closed
> by the last writer.
> 
> Thus, you're either in a hot loop or you have to explicitly detect this
> and fall back to sleeping, which defeats the point of polling:

I see. There are two ways around this:

a) open the file descriptor with O_RDWR (so there's always at least one
writer).

b) when you get POLLHUP, just close the fd and open it again.

In these cases poll(3) will behave as you need (tested)...

								Honza

> -- >8 --
> #define _GNU_SOURCE
> #include <errno.h>
> #include <fcntl.h>
> #include <poll.h>
> #include <stdio.h>
> #include <unistd.h>
> int main() {
>   char buf[64 * 1024];
>   struct pollfd pf = {.fd = 0, .events = POLLIN};
>   size_t consec = 0;
>   for (ssize_t rd;;) {
>     while (poll(&pf, 1, -1) <= 0)
>       ;
>     if (pf.revents & POLLIN) {
>       while ((rd = read(0, buf, sizeof(buf))) == -1 && errno == EINTR)
>         ;
>       fprintf(stderr, "\nrd=%zd: %m\n", rd);
>     }
>     if (pf.revents & POLLHUP) {
>       if (!consec++)
>         fprintf(stderr, "\n\tPOLLHUPs");
>       fprintf(stderr, "\r%zu", consec);
>     } else
>       consec = 0;
>   }
> }
> -- >8 --
> 
> And
> -- >8 --
> $ ./rdr < fifo
> 
> rd=12: Success
> 
> 1779532 POLLHUPs
> rd=5: Success
> 
> 945087  POLLHUPs
> rd=12: Success
> ^C
> -- >8 --
> corresponding to
> -- >8 --
> $ cat > fifo
> abc
> def
> ghi
> ^D
> $ echo zupa > fifo
> $ cat > fifo
> as
> dsaa
> asd
> ^C
> -- >8 --


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
