Return-Path: <linux-fsdevel+bounces-73362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C180D16385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D45302EF48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03327FB21;
	Tue, 13 Jan 2026 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UNFuL9RW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154F1F3B85;
	Tue, 13 Jan 2026 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269106; cv=none; b=npkuWK0A6WKIMTAKW9CxIBHnyIEYAP+4DL02F0g3gElWSizBqgduaIam1smGW2r5HN9gaegmKZpIvO+EccRvPlvFaH3Ehg4OUSrdwG5Ybs4vXPh0M4prX1kiqn2UL8rpJ1BkUA1/QGwIrBodw2QYBIXsuGL09UhNJvB+CtvYlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269106; c=relaxed/simple;
	bh=N5mJD84jjlTOcWQ/5lkZb0ciTA+kRswmgjHCiPQ4CSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YM/seHjWxV80muG+Mn/anJiAqsitus8FYspihcdW0Fjje9JgHAYSXc8Se6cLuJInXdg1sVddm4SJf9hVOhf8M2hRgaXYXFSW9KCQci0s/mbIR3b7EGwp8HrHCLwjwAjFC9jvvJVY8QE0jnpwnkCD91UcwgmSZF7C6ucIFLAZ2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UNFuL9RW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KvW2nbBjK1SsE1/dbKHi+WGWuDVP3eEQGp4M6t41xno=; b=UNFuL9RWa7hUCSGFtK5B+KHwYZ
	y1NWMSmaQ9rpECpg4i77RczHM/i6LGSrWMWZ1GfeOZeusX1ifPjEKbYkJO7BYkyBnz39kH8Mb7yZg
	98nO1dGmqb6bs/MzFrhZm5x0qBIJLm3wpLxopePNKX4JWOFDffLZr2f6kD1sb4SVmepLersVHhpRK
	8qxecRGkpSle+fbcZqAvmgd2NnlnoZaupI2cw8LqH2lG3kLpXpfxlKhzTUVHatDNF2+D1OB/CjxiS
	58rn/eF+QOwHReGTayNmPFXU2yC8SiLuERBUHe90KCRFeU7ob0AewDvd8S5joV50Gyt5QnTurphzJ
	lNpAVgoQ==;
Received: from [179.118.187.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfTZO-004eIK-58; Tue, 13 Jan 2026 02:51:42 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 12 Jan 2026 22:51:24 -0300
Subject: [PATCH 1/4] exportfs: Fix kernel-doc output for get_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-tonyk-fs_uuid-v1-1-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Without a space between %NAME_MAX and the plus sign, kernel-doc will
output ``NAME_MAX``+1, which scapes the last backtick and make Sphinx
format a much larger string as monospaced text.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/exportfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52..599ea86363e1 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -234,7 +234,7 @@ struct handle_to_path_ctx {
  * get_name:
  *    @get_name should find a name for the given @child in the given @parent
  *    directory.  The name should be stored in the @name (with the
- *    understanding that it is already pointing to a %NAME_MAX+1 sized
+ *    understanding that it is already pointing to a %NAME_MAX + 1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
  *    or error.  @get_name will be called without @parent->i_rwsem held.
  *

-- 
2.52.0


