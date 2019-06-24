Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BA501AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 07:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfFXFw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 01:52:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfFXFw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SxtantLTym8Sxm+/4cS16A4CoJY95WzKWymqcLE4tHI=; b=VyJug3L8MgLDPE7BbcSTv67OT
        DfAD5sz/T56LHhfzREs+GPDlQbpOGRy5UYSQegrb1f0sfGpIQQBjfG9G3SxEtayXo0+JsSy1jDCVf
        8MIVXGYEvuqgWkcsWZaMGJZHz2ArFL4II5C9o6zAV52tmA3F8hgyYhj5O32DpaEzF/Tn2Rcjfcq5a
        ueMCxcqxuFv/dpaEBI3AotHJlGDK9FkHaYapCZr1tjxVywEI1DKKHCq9Wj2G6k2qFdKaP2p1Lt9JR
        UpMYxTe2nwKtqhBjujf07yDN5qkG1EBRRxJBiWJxJxedCRHCHt2jp/EInVLruJHL9N5gnhNHx/t6i
        AiEQKAvxA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHuR-000426-ON; Mon, 24 Jun 2019 05:52:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lift the xfs writepage code into iomap
Date:   Mon, 24 Jun 2019 07:52:41 +0200
Message-Id: <20190624055253.31183-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up the xfs writepage code and then lifts it to
fs/iomap.c so that it could be use by other file system.  I've been
wanting to this for a while so that I could eventually convert gfs2
over to it, but I never got to it.  Now Damien has a new zonefs
file system for semi-raw access to zoned block devices that would
like to use the iomap code instead of reinventing it, so I finally
had to do the work.
