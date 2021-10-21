Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3E436203
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhJUMrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUMrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4805C06161C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tyuxQN/9l/MuuY3VK3hJBq6XTpOt/wE7olURc0cZxQU=; b=UhASpoQLMrBRxrddKcCl9CeJ/R
        4On8jwx63mNHF/qzicrm2l2O6wJUt1wnDB4A/Xstc9HBbDM7NLNY7HL7RYPAhxCdlSx9Sn8tQtG9X
        9PcpICnBunfWJ25Iks7wCa7CN81x6xfHbHLe17LF6eaeErr7SaPUMc+pD8kWy1VHq05ZjE6sNA/2i
        9aPUGJFpXTJlvIyP2nAF4JGVEXyXN2VIH8Ve6CAS/Kt8PWTWcvMil1zFCavW+sEUNy9b2sJ+CEA2b
        MhZl4DODlrxPTSZo8FE3T43KYwa1VgL5N1hxP/F/G/+3VilWc7BmdH8FkvoCItwWbw8znBV5MD5tt
        WxdZYlVQ==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXR8-007WxN-3g; Thu, 21 Oct 2021 12:44:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: simplify bdi unregistation
Date:   Thu, 21 Oct 2021 14:44:36 +0200
Message-Id: <20211021124441.668816-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

this series simplifies the BDI code to get tid of the magic
auto-unregister feature that hid a recent block layer refcounting
bug.

Diffstat:
 drivers/mtd/mtdcore.c |    1 +
 fs/super.c            |    3 +++
 include/linux/fs.h    |    1 +
 mm/backing-dev.c      |   17 +++++++----------
 4 files changed, 12 insertions(+), 10 deletions(-)
