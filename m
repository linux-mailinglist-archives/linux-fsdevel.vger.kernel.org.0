Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95073E10F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjFZNwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFZNwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:52:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EFBB;
        Mon, 26 Jun 2023 06:52:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 477451F896;
        Mon, 26 Jun 2023 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687787520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28aS9ByuuiqDDCRAZtpdiiacSEiL5jJK4uYo0x6Y0gM=;
        b=II2ZJr0BVlN9WjvvVm+s9zLlwDmzjCO3IPMtVIRBY6zVwGAlUbCGumVNscsxNQnNy7YBeZ
        TF5y9V4rsneS38fPo75JQo6DQeyeXrb5k1As5SRZQ0+HJPpS6Zvun4DSDXZJuonSWdRauU
        qS98WAghX8OgVidUQR54MDQpcJoYYI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687787520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28aS9ByuuiqDDCRAZtpdiiacSEiL5jJK4uYo0x6Y0gM=;
        b=VOKu3XSd+j8oj8MGm2n21dtl46QOczKzDz4GQBgkfuDsfyROKlcokH4MHzpcmaHzbu2hDx
        gW5QZgZnh+78yXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38E6213483;
        Mon, 26 Jun 2023 13:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /hLbDQCYmWRPcwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 13:52:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9B5AA0754; Mon, 26 Jun 2023 15:51:59 +0200 (CEST)
Date:   Mon, 26 Jun 2023 15:51:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <20230626135159.wzbtjgo6qryfet4e@quack3>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-06-23 14:57:55, Ahelenia Ziemiańska wrote:
> On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemiańska wrote:
> > > splice(2) differentiates three different cases:
> > >         if (ipipe && opipe) {
> > > ...
> > >         if (ipipe) {
> > > ...
> > >         if (opipe) {
> > > ...
> > > 
> > > IN_ACCESS will only be generated for non-pipe input
> > > IN_MODIFY will only be generated for non-pipe output
> > >
> > > Similarly FAN_ACCESS_PERM fanotify permission events
> > > will only be generated for non-pipe input.
> Sorry, I must've misunderstood this as "splicing to a pipe generates
> *ACCESS". Testing reveals this is not the case. So is it really true
> that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?

So why doesn't poll(3) work? AFAIK it should...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
