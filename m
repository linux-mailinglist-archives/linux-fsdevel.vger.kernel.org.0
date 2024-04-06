Return-Path: <linux-fsdevel+bounces-16252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B598689A8EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 06:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1691F218BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6071B80F;
	Sat,  6 Apr 2024 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EpL60hls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588918C31
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379454; cv=none; b=EGOOV+1as06lrSC9OOFVM3l+3Bn24/M5TAPmgcECNnIWnvJSATXj4mval7XS6MNsL9GJs1eoQ7N9Pa6a9w6VlGGCgWFDeaN7J2GNi1CAcM8ui5D/G7xQ+8gJ9xV8odxZX7AG7gjQrobTL3PQKS3yBvqjP14a6n6YX7R32UG82Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379454; c=relaxed/simple;
	bh=Cm6CBdhHllU/asXgm4TMUIKKPJkKfETsSTCkttiZ0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvY3lMMqRUmTmvidsB+RagpY5nOwi91+iocSKvr/TZan3jAQ1VKz3uKeRg9Gcd/4JFrWLe0tEB33noXm5GcYsxJVyeBRZHA8kJQipyNk6fHXnRui2HqBnC7TAZ4qXcFz3rDYms3dTZWB2QTiv3aNBIRozESZ6uqu9c9OrvNw0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EpL60hls; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KmrVwDZnt++mPvaAOc1bGKKsxYFWBLqEFsn24V8OyGU=; b=EpL60hlst5HkcSlmfgC+cDKXjD
	8uqwd4JKeJX8yB6DPbXJJSecxkFrHrlf2IReOwg4+w4uypVO9q292tvKHRnYymWfPTgd7opp08AVR
	9EXUV44mbhzknBddiTB7BZ4TTRZlBQpVkzmE/pNb6z6XSiGF7RdzbASyKEB1VekI4Lrinf5oPfgfX
	10WBzbVII64OkUHU5x2UcB2r/ApPwNzciU7Pbdns8dE5KF6ZNb/N9az+fvZx43k2JHe6CQahrzO6w
	gRUf8AFt5WCqzyJkEzswlDWz39jN1Q3/kipisewGa838kk/49Q3VL/B0anAlM+I6GwLZmYVSsi+oA
	XSZ1BXcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsy7O-006qhZ-1x;
	Sat, 06 Apr 2024 04:57:30 +0000
Date: Sat, 6 Apr 2024 05:57:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/6] fd_is_open(): move to fs/file.c
Message-ID: <20240406045730.GB1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

no users outside that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c               | 5 +++++
 include/linux/fdtable.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index eff5ce79f66a..ab38b005633c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -271,6 +271,11 @@ static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
 }
 
+static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
+{
+	return test_bit(fd, fdt->open_fds);
+}
+
 static unsigned int count_open_files(struct fdtable *fdt)
 {
 	unsigned int size = fdt->max_fds;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index cc060b20502b..2944d4aa413b 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -33,11 +33,6 @@ struct fdtable {
 	struct rcu_head rcu;
 };
 
-static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
-{
-	return test_bit(fd, fdt->open_fds);
-}
-
 /*
  * Open file table structure
  */
-- 
2.39.2


