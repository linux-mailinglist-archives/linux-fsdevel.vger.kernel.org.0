Return-Path: <linux-fsdevel+bounces-36803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7C9E97BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEF61669A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC121B0429;
	Mon,  9 Dec 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEHg4nfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA341B0434
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752028; cv=none; b=lEd73oqaFeZJHnAwnuEPjOZ05HF2nyah8qErCDIa0qKdLgIH5835rp7jRJPM+x/GpB7121HFMyKZhr9UyiHxEQMNRwpo20k1NYrssEEVjSp74hruJCdZQzAT+ts9ZxbvVitW1SZYRLXXVDEOlwOeGDpdKGa9lYlogw3mcKmxrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752028; c=relaxed/simple;
	bh=/2zpMRmPsrQSzbSEf2C2nZojHi5wr7s19M4sieAUDEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxGPAz7xVF8nvbyrPugxixLZMJW0GDd2/3adkzdXseWpYOvpfuO+1pU7lZDLcD+YjaqOjTNL6nFV1bhg9Tas+OQJXAAneuhK1WyrMjeACuyQecvGWGmvLcCA7DVEx8N5cXN/ar8b7OvVuPms9iejAze5FSaqSg+5twsrHGzLF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEHg4nfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D905EC4CEE0;
	Mon,  9 Dec 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733752028;
	bh=/2zpMRmPsrQSzbSEf2C2nZojHi5wr7s19M4sieAUDEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UEHg4nfpj5lwCuG2Qi9/Ep/ZW8I1AflBJaQA2CgcIjGGCf2l5MH1LEKneS/HJD0ra
	 tOJV2ze+DeutVFxsZzeYeYIZX7FvPpVQ8fNMabOKZoOeyBBm5/OH/th1J6R/Zt2vtA
	 DdohznuEBgzq8oU9c8R8/90SYzPyjOmj4V5NYX5wh7vY4N/tRsGMd2JQA6uSPj3DrL
	 1T456rEE2h/Mzz9cR7iWRrSvKKIOFTE7C0uCNZiA8UP3InDq2w1etIM9mJwj8VAas6
	 WOvDAXutWRdPD+sYdjUWtGYD9MKl7Oeolk2MZj6mqjyfEj6y7ZOA0da52fjb6qw+yA
	 p7e+2k5JUHUbw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 09 Dec 2024 14:46:57 +0100
Subject: [PATCH RFC v2 1/2] maple_tree: make MT_FLAGS_LOCK_IRQ do something
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-work-pidfs-maple_tree-v2-1-003dbf3bd96b@kernel.org>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
In-Reply-To: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/2zpMRmPsrQSzbSEf2C2nZojHi5wr7s19M4sieAUDEA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSHfbkx19WH69myioKe/xUC4stuXLXQvmSfdkH62GSd0
 Pscb+fzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk1ReG36zJQmVXF/7+Y54a
 VNUerb1urkPGvln89iw6WzkrYm7/ecbwP9hGbq9y17V7fB6rfI2WiMYsuby84YD3viCfTj6O7fa
 K/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I'm not sure what the original intention was but I take it that it wsas
to indicate that the lock to be taken must be irq safe. I need this for
pidfs as it's called from alloc_pid() which expects irq safe locking.
Make mtree_{un}lock() check MT_FLAGS_LOCK_IRQ and if present call
spin_{un}lock_irq().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/maple_tree.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index cbbcd18d418684c36a61a1439c3eb04cd17480b0..5cb9a48731f97e56b2fe43228808043e2f7e98bc 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -268,10 +268,22 @@ struct maple_tree {
 #define DEFINE_MTREE(name)						\
 	struct maple_tree name = MTREE_INIT(name, 0)
 
-#define mtree_lock(mt)		spin_lock((&(mt)->ma_lock))
+static __always_inline void mtree_lock(struct maple_tree *mt)
+{
+	if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
+		spin_lock_irq(&mt->ma_lock);
+	else
+		spin_lock(&mt->ma_lock);
+}
+static __always_inline void mtree_unlock(struct maple_tree *mt)
+{
+	if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
+		spin_unlock_irq(&mt->ma_lock);
+	else
+		spin_unlock(&mt->ma_lock);
+}
 #define mtree_lock_nested(mas, subclass) \
 		spin_lock_nested((&(mt)->ma_lock), subclass)
-#define mtree_unlock(mt)	spin_unlock((&(mt)->ma_lock))
 
 /*
  * The Maple Tree squeezes various bits in at various points which aren't

-- 
2.45.2


