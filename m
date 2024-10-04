Return-Path: <linux-fsdevel+bounces-31028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF06991047
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71C21C234C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2201DE4DB;
	Fri,  4 Oct 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K6fP5qwc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rG0rJpLB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K6fP5qwc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rG0rJpLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31B1DDC32;
	Fri,  4 Oct 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072335; cv=none; b=jkEoEMxiRcpHQZPkG6Bq1jfIsHi934+dEOcGRUNzvCxMkBFKY4c2F+iNf0qwUpFp1PLLHTyS1sRqVdKLFJ1s40ePU/GrK1XfOh4GeSUgPSwwMpXvDSQXwfqLUuLKyinAkQo/E1QE4YBhL71sR+TARwJYni8sZJ7uNda2W5CExtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072335; c=relaxed/simple;
	bh=i45K8c1WWp5r4r6Kd7srRGmTePqEUfFgPSQuFbh8ukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeGoo4+VFfE/9Svh+KdO/P+OH7nZ5l+YiWHzKVLSWSJSj4RjGDOZHihIZI+fH5thvagSWeeRTdslHQA3tOnHR+dec9eUCBV3DdUur4rkqTn4pemhTwXKxGDGyPTfE1Y+12nn4imwcKwDR0MPK73JaBvJt3JGmZQiGgKAnzoIQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K6fP5qwc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rG0rJpLB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K6fP5qwc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rG0rJpLB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85ECF1F7B3;
	Fri,  4 Oct 2024 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBLypl0tLX7MbtwoiCqucZErfjtV7PifuXn4xwONsDw=;
	b=K6fP5qwc5/hNLZPMfJCnF50MR2/vY9eJU0tyZgPvMO1Vz7oztiqbhi8BF7PdkUhYswE0XZ
	g1AoTe3p6PUa8fgisLoO1L24mkLlWCfTKHHFeBOFidX7FZxo7EcfXwHfNnorButGz5dMMq
	1cUTOZhy/l6RDG0XnYsIhpsnMyOar/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBLypl0tLX7MbtwoiCqucZErfjtV7PifuXn4xwONsDw=;
	b=rG0rJpLBNC+/le/x8aJVGx9Fi989CTdQ7BaxgaWOPoxvbC5O29bg7K/PTFyp/YCladNfz1
	CdyvmFXRvlWKLUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBLypl0tLX7MbtwoiCqucZErfjtV7PifuXn4xwONsDw=;
	b=K6fP5qwc5/hNLZPMfJCnF50MR2/vY9eJU0tyZgPvMO1Vz7oztiqbhi8BF7PdkUhYswE0XZ
	g1AoTe3p6PUa8fgisLoO1L24mkLlWCfTKHHFeBOFidX7FZxo7EcfXwHfNnorButGz5dMMq
	1cUTOZhy/l6RDG0XnYsIhpsnMyOar/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBLypl0tLX7MbtwoiCqucZErfjtV7PifuXn4xwONsDw=;
	b=rG0rJpLBNC+/le/x8aJVGx9Fi989CTdQ7BaxgaWOPoxvbC5O29bg7K/PTFyp/YCladNfz1
	CdyvmFXRvlWKLUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C23A13883;
	Fri,  4 Oct 2024 20:05:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j241NotKAGf7RQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:31 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 06/12] iomap: Introduce read_inline() function hook
Date: Fri,  4 Oct 2024 16:04:33 -0400
Message-ID: <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728071257.git.rgoldwyn@suse.com>
References: <cover.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Introduce read_inline() function hook for reading inline extents. This
is performed for filesystems such as btrfs which may compress the data
in the inline extents.

This is added in struct iomap_folio_ops, since folio is available at
this point.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 12 +++++++++---
 include/linux/iomap.h  |  7 +++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4c734899a8e5..ef805730125a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -359,6 +359,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t offset = offset_in_folio(folio, iomap->offset);
+	int ret = 0;
 
 	if (folio_test_uptodate(folio))
 		return 0;
@@ -368,9 +369,14 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (offset > 0)
 		ifs_alloc(iter->inode, folio, iter->flags);
 
-	folio_fill_tail(folio, offset, iomap->inline_data, size);
-	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
-	return 0;
+	if (iomap->folio_ops && iomap->folio_ops->read_inline)
+		ret = iomap->folio_ops->read_inline(iomap, folio);
+	else
+		folio_fill_tail(folio, offset, iomap->inline_data, size);
+
+	if (!ret)
+		iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
+	return ret;
 }
 
 static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a5cf00a01f23..82dabc0369cd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -163,6 +163,13 @@ struct iomap_folio_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Custom read_inline function for filesystem such as btrfs
+	 * that may store data in compressed form.
+	 */
+
+	int (*read_inline)(const struct iomap *iomap, struct folio *folio);
 };
 
 /*
-- 
2.46.1


