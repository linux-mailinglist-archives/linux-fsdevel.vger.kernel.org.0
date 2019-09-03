Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC205A6916
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICM5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:57:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICM5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gE0lAjT5KV53XSH79+iXLIgNXCpho5V7Qseo5fcvl8s=; b=RWe4oCQORqXHbZlPgMeQPdzuq
        z2UJXOpYn5vEYON+x+MNnYUWfLppi3KF+p1y7vU4J9rOBlA4k7X7xkGsD4w8UxwB4k2cknk7FSITv
        WbpkMF8HuupfIFZsFBfH+lE3eI7A2US24MrTnZlOGJl8vbBwEKfgeAV0PGmX/Jug34A2Fq7cb2ZVC
        5Hu8TwWfhMVmj6/G1Vp9pIfoF/SQkDo0Ot3AdEAPBbaufu534W6k+NvLU7X4Hr/9ZWLa15rxwZHPl
        BuFZo+9CINljguXcHzLrgsi7K/1gj/yoBVo0M4Gjmj1oLWraGq2JwLyOgUOBcPwmQ7lByu+t34e9q
        A9TEptEBw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58NW-0002AH-L5; Tue, 03 Sep 2019 12:57:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: xfs: use the iomap writeback code v2
Date:   Tue,  3 Sep 2019 14:57:38 +0200
Message-Id: <20190903125743.2970-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series cleans up the xfs writepage code and then lifts it to
fs/iomap/ so that it could be use by other file systems.  I've been
wanting to [do] this for a while so that I could eventually convert gfs2
over to it, but I never got to it.  Now Damien has a new zonefs file
system for semi-raw access to zoned block devices that would like to use
the iomap code instead of reinventing it, so I finally had to do the
work.

Changes since v1:
 - rebased to latest iomap-for-next
 - fix up a comment to use iomap instead of imap
 - update a commit log
