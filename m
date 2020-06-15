Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A11F961F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgFOMNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgFOMNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D3C061A0E;
        Mon, 15 Jun 2020 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Bo298b9PL3Uu2rIZ3OmLGqOnn53VokHDlRvRjRJg3qI=; b=jKPZ9uACRORYoVYfoI9BXm464h
        JAOZmm17I/gcyaUnBHlK+WlpVJukkJcI90F63eLmNjNozlT9vx8Tt5mWdVn/Dfjqb3Aw76UdwdRlz
        T5i2QqrD/mXLNdun/r67H+rr3o0KApAG+8q2Ypjm12fHXkSUJanraLSZVMD5k0eGHLbQ07c5wPeok
        MOJwbPJnNywbgSwsYVUOZ6J5UVLGo5nFsVp/Ggc9kCldQQ8J/VT3Gvc/sAYw6t3tPhypFnyAFAvlL
        KUThAWN2V1Gew5jobpg/iDOwnpHf9aSHWtZXV6yJf0VdqlDBeBiSty06lQ9fYXjwNb7S8Xh9N0jzh
        RUAmkXsA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknzD-00070N-6m; Mon, 15 Jun 2020 12:13:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 04/13] fs: unexport __kernel_write
Date:   Mon, 15 Jun 2020 14:12:48 +0200
Message-Id: <20200615121257.798894-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615121257.798894-1-hch@lst.de>
References: <20200615121257.798894-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a very special interface that skips sb_writes protection, and not
used by modules anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15eb7..2c601d853ff3d8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -522,7 +522,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	inc_syscw(current);
 	return ret;
 }
-EXPORT_SYMBOL(__kernel_write);
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.26.2

