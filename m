Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6848F432546
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhJRRnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 13:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhJRRni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:43:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB3C06176A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 10:41:26 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w10so15701246ilc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qLOjd0XBTgNB6PyT/azLzYqk1pAiNcBYGjkEFHfKgY=;
        b=ZE5P9Htq137UIuHXfQNwUAIKhDIMd9qrsf2igHVAQuchPEiM5CYAiYWAoanrP3BRK5
         +/zJf8ePrK0Jj6aFsn7k0tzQbJ4NIDDMS4qGg/dQVgP7xeIzNbMsehSUes1emc0Oq6i/
         b6ICW3jovK3RTwBeONavI1LGEeT5qNNyH2iVw4n2pIKcaseVQByWqsfKNZFTjpPf5UvA
         tpNrRtk1mQcQRK3VxXa7JqUP3X1jxKk0Yj8Qmo4sy3Salsx557cd92uesoLNkG+Oovkp
         2TGEAb9D58ouYeCPhAyavPDnIjaxSOtdxSB7Ig/cShPev5FkLkYvoHlXTljZivC8+XlA
         UOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qLOjd0XBTgNB6PyT/azLzYqk1pAiNcBYGjkEFHfKgY=;
        b=LMSAmESYq7BVC6ApuUma3D0G19JEHhUj0bTt9S9DnfR5AOnLP6KD6Nra5gNUHSUq0N
         ZA9sJvd6SgMiubUV6b1GoZwLAEs0ZiaKCxCwzSMLT/y3LYlWhMJhGsLDB/lD8Izf1ezH
         0E44ID7yhCT8PFdrlTRI0BCH7sN928R0j+Q/EPxkxduL7eQSyskVvBql7bXBpLxIycrR
         gAqTr2dO1yzXSZsKhhZ1Mv8XFt6sdt2tJJ7IfCM7KtClRa2ZzbGMZdPu+LzE74EaLSDg
         OI1AN3iSEMK6g00O8jwlJjch01wTXzKjJRd5Wj5fR4SIhlazhNzwGc2dAJ40FtRMlKiD
         NMyA==
X-Gm-Message-State: AOAM531RvkjprG40TIIQaYsGgP9gy6wfWnbait7vXpsu+sqqOS7RuepC
        oQUBjeScz45piSdNVCDEbHSOGA==
X-Google-Smtp-Source: ABdhPJwUV70oibJYf8iw/UP9RU8rrzgiQ8l+cK/EH1A19nZcoh+uCtduaCjXDIwHeCteveuemeWXlw==
X-Received: by 2002:a05:6e02:bf4:: with SMTP id d20mr15751146ilu.146.1634578885728;
        Mon, 18 Oct 2021 10:41:25 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b4sm7342594iot.45.2021.10.18.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:41:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        linux-btrfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        Josef Bacik <josef@toxicpanda.com>, Song Liu <song@kernel.org>,
        linux-bcache@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Jan Kara <jack@suse.com>, linux-nfs@vger.kernel.org,
        target-devel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-ntfs-dev@lists.sourceforge.net,
        David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-nvme@lists.infradead.org,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: don't use ->bd_inode to access the block device size v3
Date:   Mon, 18 Oct 2021 11:41:22 -0600
Message-Id: <163457887855.397824.18265513445295974558.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Oct 2021 12:11:00 +0200, Christoph Hellwig wrote:
> various drivers currently poke directy at the block device inode, which
> is a bit of a mess.  This series cleans up the places that read the
> block device size to use the proper helpers.  I have separate patches
> for many of the other bd_inode uses, but this series is already big
> enough as-is,
> 
> Changes since v2:
>  - bdev_nr_bytes should return loff_t
>  - fix a commit message typo
>  - drop a redundant note in a commit message
> 
> [...]

Applied, thanks!

[01/30] block: move the SECTOR_SIZE related definitions to blk_types.h
        commit: ac076a376d4c1fa7f01bedad76bab96a981b7464
[02/30] block: add a bdev_nr_bytes helper
        commit: 449c780f68d9adbab2373c996d4341e61c088685
[03/30] bcache: remove bdev_sectors
        commit: 519070e1b8411c93b483fb50511c9d5d7932f62a
[04/30] drbd: use bdev_nr_sectors instead of open coding it
        commit: eee1958b9a7b912fff33319e5737d861703c3a47
[05/30] dm: use bdev_nr_sectors and bdev_nr_bytes instead of open coding them
        commit: 34d7526093779e26c1a281992c7e91662f3afa85
[06/30] md: use bdev_nr_sectors instead of open coding it
        commit: 1a70a0364bbbf29eab22c9fa4b3d71087df940a5
[07/30] nvmet: use bdev_nr_bytes instead of open coding it
        commit: d61ec9eeaa161c6e385f4adebc5d671bc5290687
[08/30] target/iblock: use bdev_nr_bytes instead of open coding it
        commit: 30de91d3df67291093736890b7496620d5025df9
[09/30] fs: use bdev_nr_bytes instead of open coding it in blkdev_max_block
        commit: 011bb9476ef8f9867330e2bce22cf124d034cd33
[10/30] fs: simplify init_page_buffers
        commit: 957c50dd8af9945fde3a3fb6c8baf5d638ef3177
[11/30] affs: use bdev_nr_sectors instead of open coding it
        commit: ec003894a9db3858165dd61fb4cabf9a402aabe0
[12/30] btrfs: use bdev_nr_bytes instead of open coding it
        commit: 167a1c754eae512e45de682e2cb4ea05f080fda5
[13/30] cramfs: use bdev_nr_bytes instead of open coding it
        commit: cdf881e14aa127c7602110d208b3412b1412c1ab
[14/30] fat: use bdev_nr_sectors instead of open coding it
        commit: 4513b8c903782c4f3963172d81414e08f48a0317
[15/30] hfs: use bdev_nr_sectors instead of open coding it
        commit: 311b610de54a52c199e2a129da2c26ad5953edb3
[16/30] hfsplus: use bdev_nr_sectors instead of open coding it
        commit: 03b67c1de5d3b085360f3d6dcf37560f44e8cb4b
[17/30] jfs: use bdev_nr_bytes instead of open coding it
        commit: c1e80b87c3acd52817bea278310900ad2825686c
[18/30] nfs/blocklayout: use bdev_nr_bytes instead of open coding it
        commit: 6b1b53cf606d70dc6dd375aaaab42558cfe7e945
[19/30] nilfs2: use bdev_nr_bytes instead of open coding it
        commit: a24d8bcfd590de5dc4a9e806c9e76558676c2eef
[20/30] ntfs3: use bdev_nr_bytes instead of open coding it
        commit: 9242c8b0b4432b6929b030c729a1edd9d9116d4c
[21/30] pstore/blk: use bdev_nr_bytes instead of open coding it
        commit: 989ab34bd83f075efdae2cf6026cec0507374696
[22/30] reiserfs: use bdev_nr_bytes instead of open coding it
        commit: 8d147b3353c7fd853313521c4f66430d38d66391
[23/30] squashfs: use bdev_nr_bytes instead of open coding it
        commit: 8538360bb42955166d0073ffb6dff6a4b0caa4ec
[24/30] block: use bdev_nr_bytes instead of open coding it in blkdev_fallocate
        commit: 7ad94c3008a3f5e0ff8af1e3ff1c7061955ccec4
[25/30] block: add a sb_bdev_nr_blocks helper
        commit: 5793a4ebc76566fd24d7afdbcefb3311355fd077
[26/30] ext4: use sb_bdev_nr_blocks
        commit: 3a10af74c8f1d390857cf87648573bc4f157e4ca
[27/30] jfs: use sb_bdev_nr_blocks
        commit: cd8ac55f93923c65e18204c99b08a8c4cba3d187
[28/30] ntfs: use sb_bdev_nr_blocks
        commit: 8e2c901e6d1c97bf862514901beaae3e248655d8
[29/30] reiserfs: use sb_bdev_nr_blocks
        commit: 93361ef44a8931d281583ea9c608247fe8127528
[30/30] udf: use sb_bdev_nr_blocks
        commit: ea8befeb35c47cf95012032850fe3f0ec80e5cde

Best regards,
-- 
Jens Axboe


