Return-Path: <linux-fsdevel+bounces-28293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4419196901F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 00:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008BF284664
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94588189BB9;
	Mon,  2 Sep 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M+XOwtWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2D18951C;
	Mon,  2 Sep 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317749; cv=none; b=bMJ56nphjlPe8xskJroTBXC+rr9PMvMli9DAJzhCUY0aqunfb4Ch7pbaV6gtL40Y5DEvPu1hjQjA0qPnWUakaG9mozYCi71FUq2R0bx8P7g+CWZC9rpHoSvklAcW7Yqil6YxtkXwwmlqq1WJnR7jcGethr90Uj/DfyPLwbMQiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317749; c=relaxed/simple;
	bh=pllEocAQQbEfyzYUaynT+ursiJrWlijkoKcIoWNuRUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqjAY+wjx5e76NcKo3dNBN4X3e4w1MIf2IwfhrIV3/K03ONmte0YkTGz6BEpDq0i6TL7SNgJ2LXQXp55g4fENVJDxfItprvJajlplg1wA1c4ZeRdNlZML1N3g6EzlYlWI+dPalX+AC1Z/m0viLDg2K/+8Jdo+WjZ1aq9yUDOeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M+XOwtWh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AgFFNkqn5/cUGlfr18a5Dx7qJiLmYYoj79VenxCQGNs=; b=M+XOwtWh6PCY2iI37gV+1uD0TB
	PFrzcYHjocykhzsyfGxMB/cYuLDeDi3CXLxa8cSADb2aqf6NE+EN9ZJvqDytsW7gg0OOBcfY3qVbG
	X1gdcoA4Irzbo9/bcltCFQwQdV/piCR/37Eder7MTLuKvJXq5c62PQ9NhX18T/vHoOM3I+fopxM9D
	e2MxZ0GGqjlbPB/iD+hQpotuT/2Lm5gIaNebSwuppcbuzEsWbqunMiToozAtmiAEGaMJuLPD8oOpl
	GjK+WrAyBpF6M91dTEq4sRB9V7/U0yL3P2EbQFnLFLf6WVvpFqGtni8cmlJ54szj1DgtSL6BnRV5g
	rZuzGNuA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxE-008VrL-8I; Tue, 03 Sep 2024 00:55:24 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 1/8] unicode: Fix utf8_load() error path
Date: Mon,  2 Sep 2024 19:55:03 -0300
Message-ID: <20240902225511.757831-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

utf8_load() requests the symbol "utf8_data_table" and then checks if the
requested UTF-8 version is supported. If it's unsupported, it tries to
put the data table using symbol_put(). If an unsupported version is
requested, symbol_put() fails like this:

 kernel BUG at kernel/module/main.c:786!
 RIP: 0010:__symbol_put+0x93/0xb0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? die+0x2e/0x50
  ? do_trap+0xca/0x110
  ? do_error_trap+0x65/0x80
  ? __symbol_put+0x93/0xb0
  ? exc_invalid_op+0x51/0x70
  ? __symbol_put+0x93/0xb0
  ? asm_exc_invalid_op+0x1a/0x20
  ? __pfx_cmp_name+0x10/0x10
  ? __symbol_put+0x93/0xb0
  ? __symbol_put+0x62/0xb0
  utf8_load+0xf8/0x150

That happens because symbol_put() expects the unique string that
identify the symbol, instead of a pointer to the loaded symbol. Fix that
by using such string.

Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/unicode/utf8-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 8395066341a4..0400824ef493 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -198,7 +198,7 @@ struct unicode_map *utf8_load(unsigned int version)
 	return um;
 
 out_symbol_put:
-	symbol_put(um->tables);
+	symbol_put(utf8_data_table);
 out_free_um:
 	kfree(um);
 	return ERR_PTR(-EINVAL);
-- 
2.46.0


