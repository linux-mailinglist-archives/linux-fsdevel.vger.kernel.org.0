Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570AC662084
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 09:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjAIIt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 03:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbjAIIsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:48:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9D167D3;
        Mon,  9 Jan 2023 00:43:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFACB80D1F;
        Mon,  9 Jan 2023 08:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15AC433F1;
        Mon,  9 Jan 2023 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673253805;
        bh=myQoVYVwu0xpFEjib9aRjzoJPSgF2dGhxXTVvYigO18=;
        h=Date:From:To:Cc:Subject:From;
        b=iWxO8EK/yv7zohUYziC5XgjaW0HbP60L2g54Fsp6NPuQhygoH4HkYc+G+slCJCOVi
         AP+HbwLsP7ARc0f3H7V4G4Ge6gXQd5NGqjL6rAUDk4qC2zsa9eH2G3NmaN+tv8ybmh
         xq1UQX+6fJYhLVdIsVHPiqAlhkp9X3mQGI8UA5u88PuU/tLQ95NHtStPaP/UIK+v2m
         SPukr4mIcL6vn3LfxuCRGhtHolPxGNit4n9bJ4B6ChOp3DyxNQ5ODsqP3IjljDaQqj
         Ao9t1/KCu+VAnpAkE7Hy/XOYLgTTI7ryri9k2pIZqqb27D06GYYZv+EBQPshNZRtHJ
         mIDkVKpVkG2gA==
Date:   Mon, 9 Jan 2023 16:43:17 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use
 cases & directions
Message-ID: <Y7vTpeNRaw3Nlm9B@debian>
Mail-Followup-To: lsf-pc@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

* Background *

We've been continuously working on forming a useful read-only
(immutable) image solution since the end of 2017 (as a part of our
work) until now as everyone may know:  EROFS.

Currently it has already successfully landed to (about) billions of
Android-related devices, other types of embedded devices and containers
with many vendors involved, and we've always been seeking more use
cases such as incremental immutable rootfs, app sandboxes or packages
(Android apk? with many duplicated libraries), dataset packages, etc.

The reasons why we always do believe immutable images can benefit
various use cases are:

  - much easier for all vendors to ship/distribute/keep original signing
    (golden) images to each instance;

  - (combined with the writable layer such as overlayfs) easy to roll
    back to the original shipped state or do incremental updates;

  - easy to check data corruption or do data recovery (no matter
    whether physical device or network errors);

  - easy for real storage devices to do hardware write-protection for
    immutable images;

  - can do various offline algorithms (such as reduced metadata,
    content-defined rolling hash deduplication, compression) to minimize
    image sizes;

  - initrd with FSDAX to avoid double caching with advantages above;

  - and more.

In 2019, a LSF/MM/BPF topic was put forward to show EROFS initial use
cases [1] as the read-only Android rootfs of a single instance on
resource-limited devices so that effective compression became quite
important at that time.


* Problem *

In addition to enhance data compression for single-instance deployment,
as a self-contained approach (so that all use cases can share the only
_one_ signed image), we've also focusing on multiple instances (such as
containers or apps, each image represents a complete filesystem tree)
all together on one device with similar data recently years so that
effective data deduplication, on-demand lazy pulling, page cache
sharing among such different golden images became vital as well.


* Current progresses *

In order to resolve the challenges above, we've worked out:

  - (v5.15) chunk-based inodes (to form inode extents) to do data
    deduplication among a single image;

  - (v5.16) multiple shared blobs (to keep content-defined data) in
    addition to the primary blob (to keep filesystem metadata) for wider
    deduplication across different images:

  - (v5.19) file-based distribution by introducing in-kernel local
    caching fscache and on-demand lazy pulling feature [2];

  - (v6.1) shared domain to share such multiple shared blobs in
    fscache mode [3];

  - [RFC] preliminary page cache sharing between diffenent images [4].


* Potential topics to discuss *

  - data verification of different images with thousands (or more)
    shared blobs [5];

  - encryption with per-extent keys for confidential containers [5][6];

  - current page cache sharing limitation due to mm reserve mapping and
    finer (folio or page-based) page cache sharing among images/blobs
    [4][7];

  - more effective in-kernel local caching features for fscache such as
    failover and daemonless;

  - (wild preliminary ideas, maybe) overlayfs partial copy-up with
    fscache as the upper layer in order to form a unique caching
    subsystem for better space saving?

  - FSDAX enhancements for initial ramdisk or other use cases;

  - other issues when landing.


Finally, if our efforts (or plans) also make sense to you, we do hope
more people could join us, Thanks!

[1] https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
[2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
[3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
[4] https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
[5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
[6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
[7] https://lwn.net/Articles/895907

Thanks,
Gao Xiang
