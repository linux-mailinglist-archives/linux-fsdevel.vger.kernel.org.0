Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D968740FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjF1LIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 07:08:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51636 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjF1LIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:08:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CA7A1F8BE;
        Wed, 28 Jun 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687950488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AG7ZIcsXvWrO80s3KVhNL/4d1gbhKmpfq8tI2CThs2Y=;
        b=njPHuxvS+CpjvvQMfW5UBER7+ce44ljnaaT0niTSSkz7sGpCMnUrZQ/UJc2A5hcGBPh7GN
        caQzcMGMPrDBSxqhgRDL0LmuYbXAZHvGN9TL5EXvRNaiLKzp3dvRPcjbYZaVeN58LTJ2qB
        lgPeObreP7Nll/jbrRFIV3DCLfPtmwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687950488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AG7ZIcsXvWrO80s3KVhNL/4d1gbhKmpfq8tI2CThs2Y=;
        b=+7a/8C/uTZ3PezOpZGSV3zHsGfUoqZIYhHHoDupO42ANs4s5+UCmcjDmutTf3H0ZQb2htf
        1iaGf36cocrRtfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BA20138E8;
        Wed, 28 Jun 2023 11:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EWzRDZgUnGS5MAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 11:08:08 +0000
Date:   Wed, 28 Jun 2023 13:01:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: port to new mount api
Message-ID: <20230628110140.GC16168@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
 <b9028f9d-d947-3813-9677-c49bd2b72d53@wdc.com>
 <20230627140809.GA16168@suse.cz>
 <20230627-wahlunterlagen-zappeln-df12371cad14@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-wahlunterlagen-zappeln-df12371cad14@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:03:42PM +0200, Christian Brauner wrote:
> On Tue, Jun 27, 2023 at 04:08:09PM +0200, David Sterba wrote:
> > On Tue, Jun 27, 2023 at 11:51:01AM +0000, Johannes Thumshirn wrote:
> > > On 26.06.23 16:19, Christian Brauner wrote:
> > > > This whole thing ends up being close to a rewrite in some places. I
> > > > haven't found a really elegant way to split this into smaller chunks.
> > > 
> > > You'll probably hate me for this, but you could split it up a bit by 
> > > first doing the move of the old mount code into params.c and then do the
> > > rewrite for the new mount API.
> > 
> > The patch needs more finer split than just that. Replacing the entire
> > mount code like that will introduce bugs that users will hit for sure.
> > We have some weird mount option combinations or constraints, and we
> > don't have a 100% testsuite coverage.
> > 
> > The switch to the new API needs to be done in one patch, that's obvious,
> > however all the code does not need to be in one patch. I suggest to
> > split generic preparatory changes, add basic framework for the new API,
> > then add the easy options, then by one the complicated ones, then do the
> > switch, then do the cleanup and removal of the old code. Yes it's more
> 
> You can't support both apis. You either do a full switch or you have to
> have a lot of dead and duplicatd code around that isn't used until the
> switch is done. I might just miss what you mean though. So please
> provide more details how you envision this to be done.

Temporarily there will be unused code from one or the other part, this
is IMHO acceptable as it's supposed to make future debugging possible.
If it's not understandable from my description above then I'll need to
basically split the patch myself. I don't mind as the API conversion has
been done by you, only the patch separation is my concern. I'll get to
that eventually.

> > work but if we have to debug anything in the future it'll be narrowed
> > down to a few short patches.
> 
> I don't think you'll end up with a few short patches. That just not how
> that works but again, I might just not see what you're seeing.

Yeah, we'd need something more concrete. I'm basing my suggestion on
previous work in other areas where the first version was a big chunk of
code replacing another one, and then we'd have to fix that one big
commit repeatedly.  I've been burned too many times to let such things
happen again.  This costs more time and distracts any current work so
I'm taking the pessimistic attitude and try to do it right from the
beginning, at some small cost like additional intermediate changes.
