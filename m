Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8847844A869
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbhKIIgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhKIIgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9689C061764;
        Tue,  9 Nov 2021 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ic2T9j1dV01vrbRbp14kmcdJ50GDWCWzLE3tdNoxo6s=; b=q9jK8+4QzqazcHke6j4emluPNp
        gvM4AQoU0if2PLeCTuSf52oHmL4S2x6bGaWf/FvEkzdXybaIPyiA9hqIkSq+7AyNYtp1zJGZrI3nw
        dvIrX50uqbaw/zv2juhsVeQxcvaEULYMkh9M4+iT8wg5aLZmoI6oFUA7GofhSvVSqGll8iElobfPx
        PBktYxovHBFjfoGN1EcqHm023qS4L+VqBjgU0VNI2UwCSlUVcXUSwATdtmmRWHd/SdUsOUdur/s68
        /9ydjmkZL5SbSFG5gc3wZJHqhdmUYCCAVUqkSiaxjvXx11f49n5l0WB5DRgDdn9TlS9PpVTO9InmS
        3jvYAVuQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZ3-000ry2-Kv; Tue, 09 Nov 2021 08:33:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: decouple DAX from block devices
Date:   Tue,  9 Nov 2021 09:32:40 +0100
Message-Id: <20211109083309.584081-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

this series decouples the DAX from the block layer so that the
block_device is not needed at all for the DAX I/O path.
