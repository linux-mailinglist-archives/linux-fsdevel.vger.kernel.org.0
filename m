Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A662C7CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiKPSjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 13:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiKPSjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:39:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2D2A70E;
        Wed, 16 Nov 2022 10:39:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b185so18265973pfb.9;
        Wed, 16 Nov 2022 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYF3Hj9rSyQp4X4qzG1/mtul7nlvlXjBvw9fIIZhTos=;
        b=X/3VlFQOq/F4K880LRk9TjjvLSZlvu7/kRCnM9p5B3rYiLfewmE7LcvkodiAPiM7DU
         raLagsEw7CdstzIfRRDQz9Le/ayij3LC1LTJRZHZxZkqIdDJj+AgU3FGWfWpEYNI63hd
         JHT6SvBQ94N/ok8vRWKDzFTw0PvRImdHoqK9ezlfgiLhWQpzYE91xtGeyNwOlJistHMc
         UGjhbEzpM/cIjmxjL/mrzcDHpeePSLDv0f7N4d6JVNznieNE4hs4/NJOZBhlox3hzYej
         zUlZxtCAbtrkFHhBGxuKAuuS96kObNhGGMwm9Pv+FlRMqdlXaO+8r+jE/zxwLpwZYYsk
         NOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYF3Hj9rSyQp4X4qzG1/mtul7nlvlXjBvw9fIIZhTos=;
        b=JABuWZBbFW69CwWffnn5zErKb4qbKaqWrJDXR6Cmk7QDJvSczkThiYTfcsoJ3Br1rx
         yiW07bWmIBLEsKieN88VAlSUyA7EhSML06STtmTgMzM7OWGz/8c8Ebu9LBfCSjjdNuD2
         M28IgoTTuhozg9zjYUCyOnMT/TMR5y6+VG6aZNQFouAwKodhFRVPt+V/Ua4uGUzSphyg
         6IukrLOdN1l5QMfZoE74uoBrFa1WQ9fsD3gKTLRd4O3n5i97ycaFB/OTDtPEtekGSoE7
         xXXLeYLhrf1Vt0EpSNKtxyWzHg0VCJOEVBl0jibSI7YJl+oMmk86FNLnPGmwtmNrMgGG
         aN7g==
X-Gm-Message-State: ANoB5plSV5mQjnOT61f/31D49pkClKNRcriJEiYnVGlIsyPO6oi1AuID
        GFaaQS/F7u0uLmTCSKMw7qY=
X-Google-Smtp-Source: AA0mqf5CWC9cDzSsVhgoM5hzB1p88qRacHWHl2gRD4exiTbTBQYf+GC47C06p+H1E34QifQ+npSGkQ==
X-Received: by 2002:a62:1ad4:0:b0:56b:add7:fe2f with SMTP id a203-20020a621ad4000000b0056badd7fe2fmr24188517pfa.51.1668623947228;
        Wed, 16 Nov 2022 10:39:07 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id a4-20020aa795a4000000b0056d7cc80ea4sm11234366pfk.110.2022.11.16.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:39:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 00:09:00 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: start removing writepage instances
Message-ID: <20221116183900.yzpcymelnnwppoh7@riteshh-domain>
References: <20221113162902.883850-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/11/13 05:28PM, Christoph Hellwig wrote:
> Hi all,
> 
> The VM doesn't need or want ->writepage for writeback and is fine with
> just having ->writepages as long as ->migrate_folio is implemented.

Ok, so here is, (what I think) is the motivation for doing this. 
Please correct me if this is incorrect... 
1. writepage is mainly called from pageout, which happens as part of the memory
   reclaim. Now IIUC from previous discussions [1][2][3], reclaims happens from
   the tail end of the LRU list which could do an I/O of a single page while 
   an ongoing writeback was in progress of multiple pages. This disrupts the I/O 
   pattern to become more random in nature, compared to, if we would have let 
   writeback/flusher do it's job of writing back dirty pages.

   Also many filesystems behave very differently within their ->writepage calls,
   e.g. ext4 doesn't actually write in ->writepage for DELAYED blocks.

2. Now the other place from where ->writepage can be called from is, writeout()
   function, which is a fallback function for migration (fallback_migrate_folio()).
   fallback_migrate_folio() is called from move_to_new_folio() if ->migrate_folio 
   is not defined for the FS.

So what you are doing here is removing the ->writepage from address_space
operations of the filesystems which implements ->writepage using
block_write_full_page() (i.e. those who uses buffer_heads). This is done for 
those FS who already have ->migrate_folio() implemented (hence no need of
->writepage).
...Now this is also a step towards reducing the callers from kernel which uses
buffer_heads.

[1]: https://lore.kernel.org/all/1310567487-15367-1-git-send-email-mgorman@suse.de/
[2]: https://lore.kernel.org/all/20181107063127.3902-2-david@fromorbit.com/
[3]: https://lore.kernel.org/all/1271117878-19274-1-git-send-email-david@fromorbit.com/

Is above a correct understanding?

> 
> This series removes all ->writepage instances that use
> block_write_full_page directly and also have a plain mpage_writepages
> based ->writepages.

Ok.


> 
> Diffstat:
>  fs/exfat/inode.c   |    9 ++-------
>  fs/ext2/inode.c    |    6 ------
>  fs/fat/inode.c     |    9 ++-------
>  fs/hfs/inode.c     |    2 +-
>  fs/hfsplus/inode.c |    2 +-
>  fs/hpfs/file.c     |    9 ++-------
>  fs/jfs/inode.c     |    7 +------
>  fs/omfs/file.c     |    7 +------
>  fs/udf/inode.c     |    7 +------
>  9 files changed, 11 insertions(+), 47 deletions(-)
