Return-Path: <linux-fsdevel+bounces-60437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A1B46A98
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D38A63445
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103602D2385;
	Sat,  6 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c4Cl3iJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A812BDC28
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=n2CEEhPMyzJ6mEzziQM12GKbzsu3CSRL/1XA8POxEI1owJD9synsuu9IdBLAjygGXljS3m6OdPyUz9t2wQNj/rCpCzzpK9iqte1GKgZNzGZVh+BoeKzftIJnqsiiLTCqJpddqW1x19HpfIFW86MkwxORXckk758un1f0RIfd13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=2vtxpa24kozJTh9sfg4IE5tGVrk8Dzny/R4lTJDnAIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tww+jEFLrq/+HKXSrfkz7I2h5RvzDgoLx9cZc5n1MqYrp6BoMtjgAHQ2JV94gAEeLX0GHJJTwP7YEKK3nJAUzcfLTuQK2/DGJt1BSrBsia18rcnh4ojqnXSwnRbet0f4oZL64g7b7w7OPPDkeNq1vYIQKE7psJAXD6AzcSeMTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c4Cl3iJP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fAL0m5VnMkcvw75TS6JMlOnMOgfzDPMC6DgYFswY2DI=; b=c4Cl3iJPoMZQ52+KpFrKJehodw
	pCeSwL9gJIKSvwXn4MqT2BL/iSQeBTURam4nFmOEAHj5XJh2zw4Bd/TvpsIuGR2y9yzziCv5uNydl
	e4E5DqNd2XokrUKluEkCxxK0GM9OluI/+JliF9fXSQM5XObcfIXA90/KQee9y1U7x+iAaEFvBE41t
	cDOYnRcv4DdicW+5I4Q8g1VpoYp1ir8QmEfFKkrgpH4k6GgeMAaRweraz6jtiaceOQjuops8X7CI2
	Wce8oZTl/32aVF1q5kA6TYDr/l3NG3zg6onEP5/Q2vyX5uA1cHTpw/YKmYvfaLfeZZqaZeP08ts1k
	td6bpr/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxQ-00000000Ouq-3mzo;
	Sat, 06 Sep 2025 09:11:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 18/21] ovl_sync_file(): constify path argument
Date: Sat,  6 Sep 2025 10:11:34 +0100
Message-ID: <20250906091137.95554-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 27396fe63f6d..59630b8d50b6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -242,7 +242,7 @@ static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
 	return 0;
 }
 
-static int ovl_sync_file(struct path *path)
+static int ovl_sync_file(const struct path *path)
 {
 	struct file *new_file;
 	int err;
-- 
2.47.2


