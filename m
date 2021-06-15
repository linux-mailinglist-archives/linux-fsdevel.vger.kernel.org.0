Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC73A8304
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOOjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhFOOjN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2475F61464;
        Tue, 15 Jun 2021 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623767828;
        bh=xBkTfMcRJbm0r2yuh07T27aOb/wH4z9qzwDyOpM5Gls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo0UExwt0A314sDdrtZxUnok0jEzA4xHWLtCJ6GRMW6uQytwGSGmdCtapFX9IuM7t
         q7QoKS2cHRKztaK18sa2Hwx5Iao5tcUkvauEVln7nz7R4iOdfq5QwlxfHh4YeZCTfP
         gflDfbYrqueDUJxxSRMDnIGznkbUlDZiLjUI4YDywOIf6beuTxlog2G+tiA04ESbto
         TsQW5PNpzZyiGgT3JMLOTC18yEWx+4xoiDcyyF8t1M5fY2WAXwxxEPX+MD25GoyhB+
         BpubDUTmwWljXOIcs9yJJvHeMgmHoTMgezora00weH5XisSOBqXvMzlwgPEciidjuk
         tlVIUwSlDN0kg==
Date:   Tue, 15 Jun 2021 07:37:06 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:10:18PM +0200, Christoph Hellwig wrote:
> Chances since v3:
>  - rebased to the latests for-5.14/block tree
>  - fix the refcount logic in __blkdev_direct_IO
>  - split up a patch to make it easier to review
>  - grab a queue reference in bio_poll
>  - better document the RCU assumptions in bio_poll

It still doesn't look like a failover will work when polling through
pvsync2. We previously discussed that here:

  https://marc.info/?l=linux-block&m=162100971816071&w=2
