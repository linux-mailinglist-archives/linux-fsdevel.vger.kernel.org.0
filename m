Return-Path: <linux-fsdevel+bounces-1265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C667D88E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DABD1F232F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395153B2B6;
	Thu, 26 Oct 2023 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqcIoqmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10073AC35
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 19:28:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23C12A;
	Thu, 26 Oct 2023 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ToUeE8jlH67uNaR3XjokfMyr/EVi5kLp33HH0pq5Mw8=; b=iqcIoqmmABN4vQb9TcuI7xO06L
	+9xFV3rGU763GNNot3CgGUyn+WkmnlNbr8mbozea7ydt8jdiXQZ0m+tYOky12mTbafLqqsjlHEzoF
	BnwOn8xyLYr5TM8zvHVJynk3A3Hz7uVKEwC8RZ1Qted1xgFfh60qyd6BlIO2TLZBNptCCKDlLzTIV
	Mh7GknNMLRGBx63gZKP0GlpFbeqLLx6ItYgSMSeDPuXPFnGnrLmcjv+DPnTYL9jWp41KLhDX6gwIn
	+SHh/XfQTlejFP/Fwt8I8WT602eJMks6DMO+Wx0Y+kiPRge6nYQFeIfj66G15thQ3kdI75NWJAwiA
	9oQfp6KQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qw61v-00F3QG-00;
	Thu, 26 Oct 2023 19:28:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
Date: Thu, 26 Oct 2023 12:28:30 -0700
Message-ID: <20231026192830.21288-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_EXPORTFS=m, there are multiple build errors due to
the header <linux/exportfs.h> not handling the =m setting correctly.
Change the header file to check for CONFIG_EXPORTFS enabled at all
instead of just set =y.

Fixes: dfaf653dc415 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org

---
 include/linux/exportfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/exportfs.h b/include/linux/exportfs.h
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -314,7 +314,7 @@ extern struct dentry *exportfs_decode_fh
 /*
  * Generic helpers for filesystems.
  */
-#ifdef CONFIG_EXPORTFS
+#if IS_ENABLED(CONFIG_EXPORTFS)
 int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
 			    struct inode *parent);
 #else

