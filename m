Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BC51D528
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390794AbiEFKJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390796AbiEFKIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 06:08:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F07C5BD22;
        Fri,  6 May 2022 03:05:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 091F51F8BD;
        Fri,  6 May 2022 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651831508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOduMzov7LmnmWKc/9KVSmPz2a6N3lKrkrPH5TFQYIc=;
        b=K4zZmj4v1fjdFM/RKx8Duu++qZaOr1W8AzpQcYAtGPMwOhjBprORx356zQus6XFWACBCQF
        3q93GJMPIcNCGWf1Vqdj2ZqZfWSjk620OnmXjshIrIxUny7uRwTMBMu7qq+LU2Z1neP7Gi
        IxTCtYC1flVRKGnh7NdXeIwsoAPvC6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651831508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOduMzov7LmnmWKc/9KVSmPz2a6N3lKrkrPH5TFQYIc=;
        b=emRyEKwz+9oRLLb8JPuF4fBjvsI2XyZaLLPkrB+CWkH8TWcBmagnWsk9b9EaOudwzxzjsW
        uIsIGyYYtdhQ2ODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6321513A1B;
        Fri,  6 May 2022 10:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uw3nFtPydGJYbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 May 2022 10:05:07 +0000
Date:   Fri, 6 May 2022 12:00:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        snitzer@kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, bvanassche@acm.org,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        Jens Axboe <axboe@fb.com>, gost.dev@samsung.com,
        jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/11] support non power of 2 zoned devices
Message-ID: <20220506100054.GZ18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com, axboe@kernel.dk,
        hch@lst.de, damien.lemoal@opensource.wdc.com, snitzer@kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org
References: <CGME20220506081106eucas1p181e83ef352eb8bfb1752bee0cf84020f@eucas1p1.samsung.com>
 <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
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

On Fri, May 06, 2022 at 10:10:54AM +0200, Pankaj Raghav wrote:
> - Open issue:
> * btrfs superblock location for zoned devices is expected to be in 0,
>   512GB(mirror) and 4TB(mirror) in the device. Zoned devices with po2
>   zone size will naturally align with these superblock location but non
>   po2 devices will not align with 512GB and 4TB offset.
> 
>   The current approach for npo2 devices is to place the superblock mirror
>   zones near   512GB and 4TB that is **aligned to the zone size**.

I don't like that, the offsets have been chosen so the values are fixed
and also future proof in case the zone size increases significantly. The
natural alignment of the pow2 zones makes it fairly trivial.

If I understand correctly what you suggest, it would mean that if zone
is eg. 5G and starts at 510G then the superblock should start at 510G,
right? And with another device that has 7G zone size the nearest
multiple is 511G. And so on.

That makes it all less predictable, depending on the physical device
constraints that are affecting the logical data structures of the
filesystem. We tried to avoid that with pow2, the only thing that
depends on the device is that the range from the super block offsets is
always 2 zones.

I really want to keep the offsets for all zoned devices the same and
adapt the code that's handling the writes. This is possible with the
non-pow2 too, the first write is set to the expected offset, leaving the
beginning of the zone unused.

>   This
>   is of no issue for normal operation as we keep track where the superblock
>   mirror are placed but this can cause an issue with recovery tools for
>   zoned devices as they expect mirror superblock to be in 512GB and 4TB.

Yeah the tools need to be updated, btrfs-progs and suite of blk* in
util-linux.

>   Note that ATM, recovery tools such as `btrfs check` does not work for
>   image dumps for zoned devices even for po2 zone sizes.

I thought this worked, but if you find something that does not please
report that to Johannes or Naohiro.
