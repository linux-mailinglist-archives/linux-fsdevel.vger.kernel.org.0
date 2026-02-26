Return-Path: <linux-fsdevel+bounces-78619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCBiCpeNoGkokwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:14:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 983911AD6A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 335C8322183A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C1334C14;
	Thu, 26 Feb 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c748izqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1350273D8D;
	Thu, 26 Feb 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128858; cv=none; b=sR9iHWrUohayp990Q63lJ6FWXjD4r2MeO2MAaSrvFyzgFjesK4cqq0hlsbvBzuYiABLDEbq+HPO01ZPB/cTRCSF5BT6TyWqxwpf0Wa+E03O3PD9Jlimb5XQh+LGb74TsdfUvYLVAtRC1vtewGNe8lzd4mOg4Hnz24kKAetlx+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128858; c=relaxed/simple;
	bh=tSa5hiZicrhBi+QNoJvAJrtUetEQAG+5OISR6HExzek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hN5OHfJ/EwWvWh4ZHTP/5ax9Aw1JFmWVJqP8UOIMzg5FkYuBicQro+txFHvukC4S5c0KIU/fkb2HoKXD88tVIP5zE/7JQc20/zgD8nRywC0NQAEr4nMPjRaV6s423pdzKTjjm8Yhyg3ttMk2uKOIMSHjqu5BbHYW5FtHI6jnBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c748izqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90356C116C6;
	Thu, 26 Feb 2026 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128858;
	bh=tSa5hiZicrhBi+QNoJvAJrtUetEQAG+5OISR6HExzek=;
	h=Date:From:To:Cc:Subject:From;
	b=c748izqFEo4LcM8ySrqe6h0bV0E+M1eaxAFHGkvsSPzV48C3p9fR73VONdMbVrAfp
	 KEho9eKTTTwA2FWZ77ombT8gTOUUWP9b/9QhCLvrbH2Dg4wRH6gxD5cIubUm5U6YTM
	 VuDfvgO4aOganUR/YdUskSdLCfIJAOMFkup1sW10w96EA4fX7o+oVCF6zIRy9j/K42
	 2/kWvui0eXjjXaDkW9JidBGV6GhKdT1pKWCrdX/w3CSdN6KWnrAVTYnuiawKVabvsf
	 BV6CJbLx42c9hMWU2+vQLEuLJ0vRj4PZ8ItlYm5VIm+5dXTmxYjVdugUz0CZ/3g0rp
	 CINLNcp9aAICw==
Date: Thu, 26 Feb 2026 10:00:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH] iomap: reject delalloc mappings during writeback
Message-ID: <20260226180058.GF13853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78619-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 983911AD6A9
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
---
 fs/iomap/ioend.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 4d1ef8a2cee90b..62dd539e087c7d 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -216,6 +216,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 
 	switch (wpc->iomap.type) {
 	case IOMAP_INLINE:
+	case IOMAP_DELALLOC:
 		WARN_ON_ONCE(1);
 		return -EIO;
 	case IOMAP_HOLE:

