Return-Path: <linux-fsdevel+bounces-78945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNMgDTPJpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:30:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5561DDD3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE1B304500F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EDC427A03;
	Mon,  2 Mar 2026 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWBphbH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3141B37F;
	Mon,  2 Mar 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472603; cv=none; b=sxeCnU8tC4i3MktrdjHrkhQjUIfI9WjKmHxjFw/nNp4ysEw6xDS0cz9NjzV+kPyWMrmBOWFbEclp5XEEvrPOp13l5sktUlQhN3F0AP8F59YXoLpRg1j/g6fN6BCqv2kl2BDM4iFeIsbHkNa5BRKAciBdWhWCDlRJFSwrdwcaoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472603; c=relaxed/simple;
	bh=Nly5sXHSZSElEXvap2Gcu05FIOb2vvEenOSgirA+vEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgoeXfcf3pjsr57lAA3KG8EHB5q/iB9ME9jxKOyBdj0UwnANwX8y5jwNMPjbrZDY59ed0bqxdVHuzaAaJQsYbOP59mQ2+1njj4ZEd1iiCnOAqvYdJYSLqGlBPM2TXh6QrAgXBiRgDq2CSylWEWpeGKsHnyj9liiomMSzlIhy3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWBphbH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F5C19423;
	Mon,  2 Mar 2026 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772472602;
	bh=Nly5sXHSZSElEXvap2Gcu05FIOb2vvEenOSgirA+vEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWBphbH+Xdo3l/R44g/YUF6AhyMeiMnaK0s/sj+cknNPMTHNX1NpaKuLnVZ7a6xjM
	 9BclTTehkK+eN7eW+mkrNqIUcGskok/H4kam/jOVgWmQJLAaaCkEjzq35LZF1hO3Jl
	 XrNNLj322ibSF1h3xNhIQ3lXEq9DXakLaish79rqPQP5E5OmWMWgiELXNl6ZD8t0WM
	 brjfOiutGGbT0HHW3Ii6je00Dnr8wyEU5u7oFFL+ErdXIsCFwpVbdytNKgHCorPnUc
	 UJgw+hvAplL8XxDuDzTJuPu/4mJtU5wgGerTQR/kfCmVvOJRhee6AAuHxb4qSPqhaO
	 PpJyZI5QlfQSg==
Date: Mon, 2 Mar 2026 09:30:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v3] iomap: reject delalloc mappings during writeback
Message-ID: <20260302173002.GL13829@frogsfrogsfrogs>
References: <20260226233442.GH13853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226233442.GH13853@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 8B5561DDD3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78945-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Filesystems should never provide a delayed allocation mapping to
writeback; they're supposed to allocate the space before replying.
This can lead to weird IO errors and crashes in the block layer if the
filesystem is being malicious, or if it hadn't set iomap->dev because
it's a delalloc mapping.

Fix this by failing writeback on delalloc mappings.  Currently no
filesystems actually misbehave in this manner, but we ought to be
stricter about things like that.

Cc: <stable@vger.kernel.org> # v5.5
Fixes: 598ecfbaa742ac ("iomap: lift the xfs writeback code to iomap")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
v3: add review tags
v2: futureproof new iomap types
---
 fs/iomap/ioend.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 4d1ef8a2cee90b..60546fa14dfe4d 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -215,17 +215,18 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
 
 	switch (wpc->iomap.type) {
-	case IOMAP_INLINE:
-		WARN_ON_ONCE(1);
-		return -EIO;
+	case IOMAP_UNWRITTEN:
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+		break;
+	case IOMAP_MAPPED:
+		break;
 	case IOMAP_HOLE:
 		return map_len;
 	default:
-		break;
+		WARN_ON_ONCE(1);
+		return -EIO;
 	}
 
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
 	if (folio_test_dropbehind(folio))

