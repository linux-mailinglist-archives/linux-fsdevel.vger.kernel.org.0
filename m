Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3BFCF348
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJHHPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B+KZ2CWthn3qi8frDFdu82EATrRyublF5XnZOEvZyjo=; b=Qy8OitjIKa6k/e9/4wWp8KmWL
        HXQD07MhpTIakI1wWi/RVv57dM1RooZS6Q58D1huHDafGEUTI+2Ynys1y1F1+ra1kpj8BOkemZntG
        BIJJvCkOLGsN/+T4MrATcqRRwCABS9c8sDOorIncqsBabG1vBH8X2ModVI/jo61h6CUf+ZEiCD/f2
        Pb0OOPt1Es6DbGe3WlZQ2PfuqsAOM8JIL1gCXGCI4T0Xu+aD15ODxkc0MCpgmOoHtNjf/02Q4ik22
        hbXD2MPZydnDyWfCdSxuAsRrcEjcvwW5mMJt2foQrQ76sWNeOS7ghNVZA1eZ3aLgKD5igBvqfIavo
        IhIsIbu+g==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjiV-0005KI-CH; Tue, 08 Oct 2019 07:15:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: iomap and xfs COW cleanups v2
Date:   Tue,  8 Oct 2019 09:15:07 +0200
Message-Id: <20191008071527.29304-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series started out based on a review of the btrfs iomap series
from Goldwyn.  I've taken his main srcmap patch and modified it a bit
based on my experience of converting xfs over to use the feature.
That led to comments that the xfs code is a mess, so I resurrected
an old series to clean that up and merged it in.  That series also
happens to massively clean up the unshare path in the iomap and xfs
code as well.  The series is on top of the move of the xfs writeback
code to iomap.

Changes since v1:
 - renumber IOMAP_HOLE to 0 and avoid the reserved 0 value
 - fix minor typos and update comments
