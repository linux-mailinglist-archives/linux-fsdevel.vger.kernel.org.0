Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9F1D0924
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEMG5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMG5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFBC061A0C;
        Tue, 12 May 2020 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rXtaZ1o/KEZPUZSWEL2q4wXgiltZU/5g4tfpDlbXLdY=; b=pLg5Kt6QBe/gTDZYWUaFlA1FTD
        24J+oa+KLkw0xpCmIUI1XPHhRyM6GL25rsb5CogQdpQ/OHd67+yePhl/Z7U5oAAzmexDEb6fjALrZ
        fRmjrmp/NCElzHmUC1zYFfNYIH7ihr4ZMaT+ZgEVARqiRLLuI2ccxAVOm0RCZqqUsMJ1qrfiJOGLB
        6lWWEVb8ddKF1fJtiFL2R3HNCJAMG3chYWwjDFO07SwyVKJ15wmHtQr1/GsSC33lLEk4IxtEMCtdW
        IK9T69Y9wNRvXsaKBvVlDsd1fNeZycc366CvQVKfrvb1UrE4xOXusW6qIgfUz40D5RldTXv8OZWPt
        GktUnNbA==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlKB-0003Uw-J1; Wed, 13 May 2020 06:57:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 02/14] autofs: switch to kernel_write
Date:   Wed, 13 May 2020 08:56:44 +0200
Message-Id: <20200513065656.2110441-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While pipes don't really need sb_writers projection, __kernel_write is an
interface better kept private, and the additional rw_verify_area does not
hurt here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/autofs/waitq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index b04c528b19d34..74c886f7c51cb 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -53,7 +53,7 @@ static int autofs_write(struct autofs_sb_info *sbi,
 
 	mutex_lock(&sbi->pipe_mutex);
 	while (bytes) {
-		wr = __kernel_write(file, data, bytes, &file->f_pos);
+		wr = kernel_write(file, data, bytes, &file->f_pos);
 		if (wr <= 0)
 			break;
 		data += wr;
-- 
2.26.2

