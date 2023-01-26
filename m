Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD667D36F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAZRnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 12:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjAZRnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:43:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76AD52E
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 09:43:04 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h24so1871809qta.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 09:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n8f/ZaA0DF1cGBFp+8fWPAvuN+H2UR763MDSJjtLDQ=;
        b=mqd8oyblK50pqgWM0k7weSQeKHOSmU0YGiwe880FqeeVgbRhYPp4/snCShI5rSB0B9
         bTFJNqIduG3qpNlPT7Gmp98QQ3/sx884jMM7ivzOUeqseAKdLQ5eNQOnzWkkbvkUhBp9
         DbGi4I4JtUjseknb5UP5Dsw5n73MCXHCd6vKktEFO7prtkqMSx/sAAd+9MhU3XRi1DAx
         3eZBXl0fT7vP4byPoNYlrAHPJZf7eVJ1CBh0YFgVl8tcD9jiTjhyib1/h5PoprY49YA0
         L9+c/2nx8176q9/YMh1XP6TGeNx/I9QMXqJnrHvO8eZtTt3LSQ2spt+D5dUmKcatGXVE
         4A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n8f/ZaA0DF1cGBFp+8fWPAvuN+H2UR763MDSJjtLDQ=;
        b=EmHVQy8nQp6cz+vhWk2MC2rwPIaOTFcrA9juX2nrrz+VkDmrr2S0FJ5mAoMRC5Ao7U
         fqU31n+677MPVROHQA6Fijj61EN8K/l/d9TW+G88BLqYO/DCWfqp4Q2vQ5WLcx0NvRIQ
         qoO8hkEE9WWyXoFShEjO/btVT8psJT7Q3cIAl2CCkw+bPSUsN/5L+5sOhjYk4Kk+9VAY
         jbYHvF+i09RRvjMNSQ/Mr2ZIT5053riTJT++XpWJFApgsf8Db9kutWKJLzMsh6J/yoyU
         cVrQhfu4r1QNsm500xknIWnUmV437heB3sUpi7GDzMYCtAsU0YmVW2TYoFesduv4XD96
         uepA==
X-Gm-Message-State: AFqh2kosyFeYjWejE5TNsx7RmvOnWec6HVxduL9wwfCXLIJDSqCvofS4
        FGY6mGdfhL+rDIpvLFPp0boZnw==
X-Google-Smtp-Source: AMrXdXsJM2cdIc/uwbgYYj6EDGr39yA/dYAmC0FcFl5/idkvEBzBIzOIl9tWHWxrb8ASHTpvFadRYg==
X-Received: by 2002:a05:622a:5917:b0:3a8:175a:fd48 with SMTP id ga23-20020a05622a591700b003a8175afd48mr58098269qtb.64.1674754983909;
        Thu, 26 Jan 2023 09:43:03 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s20-20020a05622a179400b003b81a90f117sm356865qtk.60.2023.01.26.09.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:43:03 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:43:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/34] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <Y9K7pZq2h9aXiKCJ@localhost.localdomain>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-24-hch@lst.de>
 <Y9GkVONZJFXVe8AH@localhost.localdomain>
 <20230126052143.GA28195@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126052143.GA28195@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:21:43AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 25, 2023 at 04:51:16PM -0500, Josef Bacik wrote:
> > This is causing a panic in btrfs/125 because you set bbio to
> > btrfs_bio(split_bio), which has a NULL end_io.  You need something like the
> > following so that we're ending the correct bbio.  Thanks,
> 
> Just curious, what are the other configuration details as I've never been
> able to hit it?
> 
> The fix itself looks good.

I reproduced it on the CI setup I've got for us, this was the config

[btrfs_normal_freespacetree]
TEST_DIR=/mnt/test
TEST_DEV=/dev/mapper/vg0-lv0
SCRATCH_DEV_POOL="/dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/mapper/vg0-lv8
PERF_CONFIGNAME=jbacik
MKFS_OPTIONS="-K -f -O ^no-holes"
MOUNT_OPTIONS="-o space_cache=v2"
FSTYP=btrfs

I actually hadn't been running 125 because it wasn't in the auto group, Dave
noticed it, I just tried it on this VM and hit it right away.  No worries,
that's why we have the CI stuff, sometimes it just doesn't trigger for us but
will trigger with the CI setup.  Thanks,

Josef
