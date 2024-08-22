Return-Path: <linux-fsdevel+bounces-26582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC295A8B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E021F21D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A879FD;
	Thu, 22 Aug 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="esR2YdKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF914C81
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=rxJLD/pOze+hKHbE9SzjP+0NTzjEM7ZNZaDU9ZQRbArOaz7iXM2OE6fX+IL3gF/EDWyQixQoQXRIxXDxSYhfl6hBgkxoGK0LnTFUuAV2z5CAz2y0jxhVK6e0l4+sAIM53gVbelZSgKepCvWen6bEpgbB1LmzJBjpPbvRHIzwPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=IfCOCOHa/HUGzhy2lqDG8flRZjbQX24LPm/blVU/T2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKbo2Pl0tXTRlrI+HKOyHQvTiY8sS2VoKMJ+ivyNtibnp9zHGjiywKLEnV1xIpfwC08zrWrX3pu8JL8EeO8mPS8q/Q+DNcZBraTiqm5sykzG1NrJA5peqZ9dDZQwppQLbAT6xdN3QuBHRWiBNJd8dmxyUWklrCcaiK6UNEkKXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=esR2YdKI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/R/upX1JiHEaQTrEoXVDf3grjZJPCfys+OZPKtqY8rA=; b=esR2YdKIgtUEXMCUo5VSmfT6k6
	yr9WkVwgPYIGzjcGjpMmVhcH7GCsxe3QJL3h355y+7zEiVawv2Uix32/PrxaRX7QU69k3UHAgySkm
	oA/TQX7r1GKbolNqQfo8lMAKRNuNRfv2xNOVE3BOuVyfYWJQe9VbZcUmvpXe8xdts2xE9SqpI94bY
	1iIbW4360s8GP2KjsBMKRME6wfCDrAD9XWDRuth27zs+0eb3yEmNUe1BryC63CMn6HwxaKA/Yjy/j
	bHNhjI4rbcvO1AK+lsEcOMxiecuISuagoBwyXKnnTH9SwgY4zXuSpwexRkwj/Mzmva3Z1eDf4nas6
	ouXTs6DQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbG-00000003w7k-3ar0;
	Thu, 22 Aug 2024 00:22:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 04/12] close_files(): don't bother with xchg()
Date: Thu, 22 Aug 2024 01:22:42 +0100
Message-ID: <20240822002250.938396-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

At that point nobody else has references to the victim files_struct;
as the matter of fact, the caller will free it immediately after
close_files() returns, with no RCU delays or anything of that sort.

That's why we are not protecting against fdtable reallocation on
expansion, not cleaning the bitmaps, etc.  There's no point
zeroing the pointers in ->fd[] either, let alone make that an
atomic operation.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 8c5b8569045c..4ea7afce828c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -413,7 +413,7 @@ static struct fdtable *close_files(struct files_struct * files)
 		set = fdt->open_fds[j++];
 		while (set) {
 			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
+				struct file *file = fdt->fd[i];
 				if (file) {
 					filp_close(file, files);
 					cond_resched();
-- 
2.39.2


