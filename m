Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D673E5D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFZQw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFZQw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:52:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BAD1B1;
        Mon, 26 Jun 2023 09:52:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 066651F896;
        Mon, 26 Jun 2023 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687798341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix/uWItcnnwsKrXY7YkKCqWMvLxQFgNVJE2AJR1BvvM=;
        b=3AdjnVjh+55mJOWVxSTPtswQuxxsNYoASuG3LhbZls0wQtg6HMooN6NhLAe4D4D67hPrIK
        L5aPVXoomk3R8gAJNOkGwlJdJYmhnURezZH3WChSmdgmMoD5ud4l2AnOGx42U1E+jSAzR2
        S4Arr/8lkUNgUJqoeLv5PT2PmU9H93g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687798341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix/uWItcnnwsKrXY7YkKCqWMvLxQFgNVJE2AJR1BvvM=;
        b=GBDSwTaixfVefWGt/NTLHkhLaMhQ99c3l4DAY2EUmv+fY2mslsTHYAZTIwySkgvNg8p4qc
        clD0OYP0XiYJx2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA32013905;
        Mon, 26 Jun 2023 16:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kacnOUTCmWR3TAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 16:52:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74AE3A0754; Mon, 26 Jun 2023 18:52:20 +0200 (CEST)
Date:   Mon, 26 Jun 2023 18:52:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <20230626165220.elo4xwfqq6sjboh7@quack3>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
 <20230626135159.wzbtjgo6qryfet4e@quack3>
 <bngangrplbxesizu5kbi442fw2et5dzh723nzxsqj2b2p5ikze@dtnajlktfc2g>
 <20230626150001.rl7m7ngjsus4hzcs@quack3>
 <sw26o55ax3cfaaqhlbd2qxkdroujnfxtbxrmt2rpjztmedz3mn@uauqn6hexwdq>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sw26o55ax3cfaaqhlbd2qxkdroujnfxtbxrmt2rpjztmedz3mn@uauqn6hexwdq>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-06-23 17:15:23, Ahelenia Ziemiańska wrote:
> On Mon, Jun 26, 2023 at 05:00:01PM +0200, Jan Kara wrote:
> > On Mon 26-06-23 16:25:41, Ahelenia Ziemiańska wrote:
> > > On Mon, Jun 26, 2023 at 03:51:59PM +0200, Jan Kara wrote:
> > > > On Mon 26-06-23 14:57:55, Ahelenia Ziemiańska wrote:
> > > > > On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemiańska wrote:
> > > > > > > splice(2) differentiates three different cases:
> > > > > > >         if (ipipe && opipe) {
> > > > > > > ...
> > > > > > >         if (ipipe) {
> > > > > > > ...
> > > > > > >         if (opipe) {
> > > > > > > ...
> > > > > > > 
> > > > > > > IN_ACCESS will only be generated for non-pipe input
> > > > > > > IN_MODIFY will only be generated for non-pipe output
> > > > > > >
> > > > > > > Similarly FAN_ACCESS_PERM fanotify permission events
> > > > > > > will only be generated for non-pipe input.
> > > > > Sorry, I must've misunderstood this as "splicing to a pipe generates
> > > > > *ACCESS". Testing reveals this is not the case. So is it really true
> > > > > that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?
> > > > So why doesn't poll(3) work? AFAIK it should...
> > > poll returns instantly with revents=POLLHUP for pipes that were closed
> > > by the last writer.
> > > 
> > > Thus, you're either in a hot loop or you have to explicitly detect this
> > > and fall back to sleeping, which defeats the point of polling:
> > I see. There are two ways around this:
> > 
> > a) open the file descriptor with O_RDWR (so there's always at least one
> > writer).
> Not allowed in the general case, since you need to be able to tail -f
> files you can't write to.

Hum, fair point.

> > b) when you get POLLHUP, just close the fd and open it again.
> Not allowed semantically, since tail -f follows the file, not the name.

Well, you can workaround that by using /proc/<pid>/fd/ magic links for
reopening.

> > In these cases poll(3) will behave as you need (tested)...
> Alas, those are not applicable to the standard use-case.
> If only linux exposed a way to see if a file was written to!

I agree that having to jump through the hoops with poll for this relatively
standard usage is annoying. Looking into the code, the kernel actually has
extra code to generate these repeated POLLHUPs because apparently that was
how the poll was behaving ages ago.

Hum, researching some more about this, epoll(7) actually doesn't have this
problem. I've tested using epoll(2) (in edge-triggered case) instead of
poll(2) and that doesn't return repeated POLLHUP events.

> For reference with other implementations,
> this just works and is guaranteed to work under kqueue(2) EVFILT_READ
> (admittedly, kqueue(2) is an epoll(7)-style system and not an
>  inotify(7)-style one, but it solves the issue,
>  and that's what NetBSD tail -f uses).
> 
> Maybe this is short-sighted but I don't actually really see why inotify
> is... expected? To only generate file-was-written events only for some
> writes?

Well, inotify similarly as fanotify have been created as filesystem
monitoring APIs. Not as general "file descriptor monitoring" APIs. So they
work well with regular files and directories but for other objects such as
sockets or pipes or even for these "looking like files" objects in virtual
filesystems like /proc, the results are pretty much undefined.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
