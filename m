Return-Path: <linux-fsdevel+bounces-73256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FCD13666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08FA330B87A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873B2DCBF4;
	Mon, 12 Jan 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BApWoSxE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y94NZauG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950D2DB79E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229503; cv=none; b=n++cJQZXY9WHjzkVNmjibpAupMVEHZUDNjYt3eQYKPKh7fKXRQ8PRElIChQX8HFFIKgfySTylmwPuIrmphLXx+k2JygFEJ/uVgk9DAGo19c4FiW9MDqKpHX1mQDJpkc6GA+PzIXU/YF3u9RBpLzzWGl0WGcqr9rsYkZ85o7AF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229503; c=relaxed/simple;
	bh=KuVncpruotZd/UsOXvAmuKf4QdktlGEPoHD59smbXrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXV5LE4bICNUwZ2Z1QDR6NHizJCND+1GN2t18pdBScaFlGIGbEJsyz76ffJ6BV49mOlZaFDpwJhq/X9ZrH5r9pnqY9FCzvfIkvIg5ZK14+m6oDxCWpMoWgneU+QOTl0ZLPpAN3WWgxDTgvksvlFrR/PxtN9U/10Y0o4w/hLyh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BApWoSxE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y94NZauG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBkDD6Fi/bpRn7zVUlo8hSmg4I+N+3/I24mCz3Q7/v4=;
	b=BApWoSxEzUKGwjTrV5dgshfOn09vc4OCNIKgnJmWAYNuoGMYWq3up03ut1RBqcFJoKrEPy
	jqp6AVuO0tB5P9arNMBZT+3SIrmTm6X+cx8wHPkKzsdrY/W7k9Q9rHTpgRkNdlnHoGb2tP
	IjQHD5mxxGUrMCzocxyrYisHvqlLGxc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-_nF-X0nFMGmSBsxoRYQTNg-1; Mon, 12 Jan 2026 09:51:39 -0500
X-MC-Unique: _nF-X0nFMGmSBsxoRYQTNg-1
X-Mimecast-MFC-AGG-ID: _nF-X0nFMGmSBsxoRYQTNg_1768229499
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8704795d25so179397666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229498; x=1768834298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBkDD6Fi/bpRn7zVUlo8hSmg4I+N+3/I24mCz3Q7/v4=;
        b=Y94NZauGel3DewOYthCeEdIELMiG5RI5w12oGnPFExihxpEvtNLysYty59VWQvWtLT
         lKO5yzm/ck3crPWYOYNZnuULbsB2pEfSsPWj3TsPM2MNy1cfQD3gyxB57Nnb+jc1rcW9
         hznN0raSXIhej9EB3HqZmB0/xGGUgHKKCW82i/ZE0U7oogRdWDNIyqIbCeVkAs/kG+aX
         ADSHa8kPsbGTRdEMGRCRtWvaGtl/+HACXGAzPh390sPgTwKcZO+83O5hpFiW7v0tKQ3s
         8Xwgrly70PObOPaOatFyUeOQ1U2GfXkS4c6OQ+jIvaWKpugVVLwcwMQRhmGEdLU1HbRX
         5+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229498; x=1768834298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBkDD6Fi/bpRn7zVUlo8hSmg4I+N+3/I24mCz3Q7/v4=;
        b=rjClLuT4jj15/D3y6/UPZVPqKObmiHMa3g/sRQ9ipxTnj2HjVZYhTRoTV9qYC43qWj
         Ly5hJoJ2VC/a5j+i2A7kShSbwzQ7oKcTw/fHr+HRITmQDJJQ8igdtcC7IM4GZ9v5g4Wz
         1hNvvJu/5UXLlEueQKSvXvZRj8+1OMQwIaZGLY74zR7WbSLzzq76fuykxT/D2ys4Dklr
         hyJLEmm0l8cbJk2lGejAtf+8l11jtHxD2pmcVwMQglpQ84pUCYuqJdZWCqiFnl5stMAE
         tZLInW0YbFmxdXo6n8PzElx4mQAo3Y7ioPaTlLvjjoxar6BNafOrRidiEJ16PKZRWvFG
         9zIw==
X-Forwarded-Encrypted: i=1; AJvYcCU+IZEzCaBzI0+G0jQKdNStRzJDWDnnAIZv+hyazD2Wi1UDRKuH+nOF9H9g+L4nN8aVbhPn1wnS4cflnvI3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ci8pcLymJGFAq8n+VEdmGMsOmQIYyI2lQ6hWS70CLyK/ulnO
	naKQqKwVpft8f++UFIRa318XbUMFvjQz2KCudRvQF0meDMn3A77UemOTIMseztuJdqwq98sIE7F
	HVA8u6ZAIxfH7nL//af63ty3wpbOH7Nkz0zhPh469qfn7akx+jpYUlhtZYJ3kRGCM0xJEsTQ90g
	==
X-Gm-Gg: AY/fxX4ScSDDoYCk9FqnN8+xVOmYhSQm6V1khZjz4XBuetPr3WTusbZlBNl7XVJvrah
	nGTDzKReZjendJTu071es0wmBBOh5X+bB8uNJw+VF6PEZ58z7CyKEV+ys8t7/Zw9M9GM0nnhsaN
	b9o9NGB3QSCXF0KT3i6LgZTw/sjPfioKZnaGR6M0u4YIbIarApCUkAbVpHxxNT4EdMYGzVvqDUT
	iqa9CW1EIzgkwLP7+xdN2tvlfqd7nclEG4eYPYGMp886qeycBscuk9fjG2TV3M7IhBLm+Tlnn/e
	QJrPdUBKqS6v6YVGjqqDbHHK3rSSMyNBnjtjSR4ty3JLptNCjSSIimNMxF/WNoCJRfjXpJhvZEk
	=
X-Received: by 2002:a17:906:f599:b0:b83:288a:2bce with SMTP id a640c23a62f3a-b84451f1870mr1947368366b.24.1768229498096;
        Mon, 12 Jan 2026 06:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKhlt85YSYPpY/hF5ITXGpTLxb6PAI0j39GqviSICFmscjl6cOBil351MZnv+wZM9aM3V+qQ==
X-Received: by 2002:a17:906:f599:b0:b83:288a:2bce with SMTP id a640c23a62f3a-b84451f1870mr1947366166b.24.1768229497631;
        Mon, 12 Jan 2026 06:51:37 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm518177766b.16.2026.01.12.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:37 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:36 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 15/22] xfs: add writeback and iomap reading of Merkle tree
 pages
Message-ID: <bkwfiiwnqleh3rr3mcge2fx6uucvvj2qzyl3sbzgb4b4sbjm27@nw2i3bz7xvrr>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

In the writeback path use unbound write interface, meaning that inode
size is not updated and none of the file size checks are applied.

In read path let iomap know that data is stored beyond EOF via flag.
This leads to skipping of post EOF zeroing.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 56a5446384..30e38d5322 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include "xfs_fsverity.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -334,6 +335,7 @@
 	int			retries = 0;
 	int			error = 0;
 	unsigned int		*seq;
+	unsigned int		iomap_flags = 0;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -427,7 +429,9 @@
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		iomap_flags |= IOMAP_F_BEYOND_EOF;
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
@@ -470,6 +474,9 @@
 			wpc->iomap.length = cow_offset - wpc->iomap.offset;
 	}
 
+	if (offset >= XFS_FSVERITY_REGION_START)
+		wpc->iomap.flags |= IOMAP_F_BEYOND_EOF;
+
 	ASSERT(wpc->iomap.offset <= offset);
 	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
 	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
@@ -698,6 +705,17 @@
 			},
 		};
 
+		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
+			wbc->range_start = XFS_FSVERITY_REGION_START;
+			wbc->range_end = LLONG_MAX;
+			wbc->nr_to_write = LONG_MAX;
+			/*
+			 * Set IOMAP_F_BEYOND_EOF to skip initial EOF check
+			 * The following iomap->flags would be set in
+			 * xfs_map_blocks()
+			 */
+			wpc.ctx.iomap.flags |= IOMAP_F_BEYOND_EOF;
+		}
 		return iomap_writepages(&wpc.ctx);
 	}
 }

-- 
- Andrey


