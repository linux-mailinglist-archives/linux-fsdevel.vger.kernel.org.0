Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE752B8BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiERL0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiERL0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 07:26:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03011448;
        Wed, 18 May 2022 04:26:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 543261F921;
        Wed, 18 May 2022 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652873159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzGqbB6W/4jJjPwTJUIMVwsso9o7Blm3R0BLht7tMSI=;
        b=f+6VssfOQNjRrpyZABnQm1ZJYRE361ARv7x8KnF355SG32w2Ax34yCjoPPRxBuaxVPOhV0
        Hm2GPKSqAIMqMPuMHudFaV8I6u1zYTIBm+V8pf1FMVTZ06nuyGcQe22FmaqLCGQumpQEZZ
        K6tTLvqVreUvJqYmDXQeMKL/Vw9ntF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652873159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzGqbB6W/4jJjPwTJUIMVwsso9o7Blm3R0BLht7tMSI=;
        b=sT0MzHwKutP4nbHRSXKZbIYvCH0qzaHplxeoyZZgFfGo8b8tDBuCsoErL2HuIA/5bv5Z2G
        TGabJCLWnc1UxcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0BAF13A6D;
        Wed, 18 May 2022 11:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 38XzOcbXhGL8TgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 May 2022 11:25:58 +0000
Date:   Wed, 18 May 2022 13:21:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     dsterba@suse.cz, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 07/13] btrfs: zoned: use generic btrfs zone helpers to
 support npo2 zoned devices
Message-ID: <20220518112140.GI18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce@eucas1p1.samsung.com>
 <20220516165416.171196-8-p.raghav@samsung.com>
 <20220517123008.GC18596@twin.jikos.cz>
 <2b169f03-11d6-9989-84cb-821d67eb6cae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b169f03-11d6-9989-84cb-821d67eb6cae@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 11:40:22AM +0200, Pankaj Raghav wrote:
> On 2022-05-17 14:30, David Sterba wrote:
> > On Mon, May 16, 2022 at 06:54:10PM +0200, Pankaj Raghav wrote:
> >> @@ -1108,14 +1101,14 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> >>  int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> >>  {
> >>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> >> -	const u8 shift = zinfo->zone_size_shift;
> >> -	unsigned long begin = start >> shift;
> >> -	unsigned long end = (start + size) >> shift;
> >> +	unsigned long begin = bdev_zone_no(device->bdev, start >> SECTOR_SHIFT);
> >> +	unsigned long end =
> >> +		bdev_zone_no(device->bdev, (start + size) >> SECTOR_SHIFT);
> > 
> > There are unsinged long types here though I'd rather see u64, better for
> > a separate patch. Fixed width types are cleaner here and in the zoned
> > code as there's always some conversion to/from sectors.
> > 
> Ok. I will probably send a separate patch to convert them to fix width
> types. Is it ok if I do it as a separate patch instead of including it
> in this series?

Yes, it's a cleanup for later, not directly introduced or affecting this
patchset. I've checked zoned.c, in btrfs_ensure_empty_zones it's the
only instance so it's not some widespread problem.
