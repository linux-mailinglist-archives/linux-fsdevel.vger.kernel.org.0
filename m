Return-Path: <linux-fsdevel+bounces-59263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711F4B36E76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF021BC0A9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AE36932D;
	Tue, 26 Aug 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sEstQBzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529D3680A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222895; cv=none; b=k+KusiruhJP88iC1QYbasfXjmChvtzoAQzl3bTZ26vsbM5Q89/nD82+H7+WEwpUjToMiWIb9DLJ4xfV1FCR/xUia5vp3vj/hGN+BS1/RENDlH9GIuoF9xzNNfAP/RQyi5+sVcLrkUKF+nG/2IZOL/C7GA+uoQF4PN2/nIqSOGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222895; c=relaxed/simple;
	bh=HO3qn6E2mu4iKLp4ae70vUhOoqfZurpCVV09CRALkRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ4qFdLLLvjb1i9D0PAAw2UuzVN7A9pKpQJ0chuuqpyl0cH5DmOVy9irhZFD7gxGVnNT83xNXgXyCA/rVGJuTiDp6sIEO7EgHHbAZQslBCZ4OKs79AtFf4wj8GeL5JRPCg2cYY+zPycs76Dexa9XSE3hNItUyAqm5kFe/ze2nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sEstQBzG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60110772so49945597b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222892; x=1756827692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=sEstQBzGN1LPfhVQ2Rz5gE9Q1fD8N/GQEnAqr8Svk8lo2CdmDjEQF4SGIAR45zluP0
         eYc9gFHTsGaJ+dtZ1b/J9RQz2D49IKVzp/y2VeyjzmQ4bx3hzQc5RCDknQ+Km2/yp/S4
         a/QKOnWyx53s6PTckNaPJO1JPJbcp4TurWvzaWUfjUJuoUM84QgQ93egZUHK1rQswQmx
         Zv4Z0enm/kpHqLBS1+a6J1orIP2n65XxzvFIHtFc6xB2YHRhvhC2gOq8mCNS8ptOyljd
         g7Hb1T/EyczmSiiYX3ANbXTUywkeRBNRQ+e6tN6SyQjgCozQuF/0uAbpu265w3FrJLc3
         zu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222892; x=1756827692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=MFOXI/W1Hx6o1T5MNmVqL1lLiaeZbKyp9wCW1FGIwbcIrmDu5uV9keAwEKQKOXAi8V
         DWSxEl7AuOBAXGbdrbylfwr5cG6jcoQqBrZFToSNhM6bfZOhiDMsb55VuzKGBIAAKRN4
         v4dbOFrgg2iPauK8G3GqPLAFg5Xs6E0iUgWeAq+tm2ZeIfmh8Oh/7HOSOsoE3smu/qWv
         byMytsjseeU+KkXJQ9yXs9gblg3oOj+YObPPcAvLcAqbzS/fDvbLWogy6arjjC6tIWUF
         XX5CWBhhU/qBCC7owqGVcEAicRFlc7KgApwWsHPv0sZWQmdqP+9/qtnNUii6cTbw+Etn
         OZeA==
X-Gm-Message-State: AOJu0YwRqEU/4NN3VigocfQkqKp+DHHTDzlHLX3pG2EtpxU0tcLhGOZf
	/I4p+WldjLPbwxogEdxGY6zGxKD11P2rvYvfWyCId6rHYpkWxJsUPaNijnQAYyeG8V05TSwFthr
	Rk715
X-Gm-Gg: ASbGncu+57w9BwuYW6GfF/TLWK05Tbiiispv9gzr4A6Po6AYW60uSbSTmbDgo/moKKh
	3ccqYmhWmd2sKnpXZyk/cHKzkJ1qY6fOeM4MLvJ3XWZm6hJ5bNhn7t24Tb+RNA67CF09wWOOTD1
	hY9QJcWuJojZ9E/Ectb4befd56SN9JfKSsc4wcdk6MolBACdupxQJ7N/meNo9FTmr/pPL7NCZzP
	rhiiFl+riQBI2POV21wmIJ6hCqdOcemP/WLAOdH9lYZTUUTQAvOTeLfYi7SIRNV2RL3VAEnLc3R
	3QD3NFll72D8THfdPaWvYCP09LjJLUGigl0Ld6nidX6WSx3nE1KyHTQwzI3gAcP5rrH5Co3jJVH
	VsLa655GVknbjrvbXkmrHhu5grI4xGOjtwYmm6yW4+IkvgsEpeWGkUO1TH+M=
X-Google-Smtp-Source: AGHT+IEGTe9J6APE8G1RzLna9v2A4NhqUMcOqyHW3B9fdF1qoADqmNsdHuHOZlvMk5nr/NaX035KJQ==
X-Received: by 2002:a05:690c:7009:b0:720:999:cc91 with SMTP id 00721157ae682-7200999d319mr90958807b3.28.1756222892428;
        Tue, 26 Aug 2025 08:41:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f657f58b61sm2303577d50.2.2025.08.26.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes to use refcount
Date: Tue, 26 Aug 2025 11:39:30 -0400
Message-ID: <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
make sure we have a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..969db498149a 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -956,13 +956,16 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
+
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&mk->mk_decrypted_inodes_lock);
 
 		shrink_dcache_inode(inode);
-- 
2.49.0


