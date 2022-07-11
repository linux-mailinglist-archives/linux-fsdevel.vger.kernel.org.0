Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41B456D3A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 06:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGKEPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKEPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:15:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD5183A8;
        Sun, 10 Jul 2022 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BDOTeFOO/FY7pwwFSR0eN21wouhgtH3k9FnygVND/RY=; b=NJMKpxLIc4Unlnzp8VLN/dGfEz
        ko2Hr/tYVCVUEvdT2Clsd1+57jBAkeDzHcTvjxCZ4KwnSqsYMitSRULRDCpJcirQtbdKP9t+uH92X
        ZRdmMs9avfqNDT2H3vM3kNg3wsmSo8g5IMb3ZORiUVvKJv5D7kjpa/sCeAvU6gW+SY/bP4v9aqF/L
        hxcHY+U7vYGNPl9Z2RSkdd5PlJK3KOSeLBs95zWpoQFWYlpYmoXPvwv/Qt/aXPU7lW6TKS8+/tAdH
        kbkYQhvoRUWys1O5pdX+HF/OMcx/rYmyTwLZjn/3PORAF1r//5sWuksgnVAzVkbCKRxM6HFQMAafA
        A7nMtxqQ==;
Received: from 089144197153.atnat0006.highway.a1.net ([89.144.197.153] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAkp4-00FpvP-G0; Mon, 11 Jul 2022 04:15:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove iomap_writepage
Date:   Mon, 11 Jul 2022 06:14:55 +0200
Message-Id: <20220711041459.1062583-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes iomap_writepage and it's callers, following what xfs
has been doing for a long time.

Diffstat:
 fs/gfs2/aops.c         |   26 --------------------------
 fs/gfs2/log.c          |    2 +-
 fs/iomap/buffered-io.c |   15 ---------------
 fs/zonefs/super.c      |    8 --------
 include/linux/iomap.h  |    3 ---
 5 files changed, 1 insertion(+), 53 deletions(-)
