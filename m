Return-Path: <linux-fsdevel+bounces-48482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32FAAFB74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3244E5430
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059E22B8CC;
	Thu,  8 May 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsv0hO7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0B84D13
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711281; cv=none; b=Nac7aA5vqROl8ZowjD8hfDmLEmEgWr1Wc0qKcM+zFRBYs3pCSkkZBNCTYNCeYIKVHMdsLpZzchX35QNF3zBULZUFSYgieuJcVGmREdcQ8FJGZP33yoSQflJULEDzFPTtQSdCN1ckUxRp+RspxBqIqz3T707WeiR6JdHipvXPW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711281; c=relaxed/simple;
	bh=dXJo6xT3X4StmukgG0J1x/4N1eBtRLP2eaWY5Iz32N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUU7k2oe/YosT3YMTxZtZWksrpwZw5hOW48jrFbdqAXDC4vTIe8t0sSFTYpAj1K7FoLNsFsgvfTTomKU2bVQDrSDDW4LGlz5AxTIcAfQ1C22deswjh7NYb6zES6Js6tRYrthD5ApyFm7211Cbw+GvnP/WFqCBYGh4hX08eR6EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsv0hO7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746711279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cyPu7yVaEwUyJheEgQju3oSahudlYdZcp8FfBQF1IXc=;
	b=hsv0hO7wNaDBYkr8DfKPfoCfrBJsk+EdQhSZbpKBsKA36IQAyoVjeMB2woiAVsLn9rUJ9m
	utW2/qRCuuypr68EN7Dx4NY3m6V9F2yg2S9fVkZJbAox/1oTiDIgVwikA6yBF61e518/ja
	y9c4RkBea/LTC1J4/jzGBZmjy5VW3cw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134--09fyjhnNjK7XIntaX1S2g-1; Thu,
 08 May 2025 09:34:35 -0400
X-MC-Unique: -09fyjhnNjK7XIntaX1S2g-1
X-Mimecast-MFC-AGG-ID: -09fyjhnNjK7XIntaX1S2g_1746711273
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12C1819541B9;
	Thu,  8 May 2025 13:34:33 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 202C91953B89;
	Thu,  8 May 2025 13:34:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Date: Thu,  8 May 2025 15:34:27 +0200
Message-ID: <20250508133427.3799322-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since commit eb65540aa9fc ("iomap: warn on zero range of a post-eof=0D
folio"), iomap_zero_range() warns when asked to zero a folio beyond eof.=0D
The warning triggers on the following code path:=0D
=0D
  gfs2_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)=0D
    __gfs2_punch_hole()=0D
      gfs2_block_zero_range()=0D
        iomap_zero_range()=0D
=0D
So far, gfs2 is just zeroing out partial pages at the beginning and end=0D
of the range, whether beyond eof or not.  The data beyond eof is already=0D
expected to be all zeroes, though.  Truncate the range passed to=0D
iomap_zero_range().=0D
=0D
As an alternative approach, we could also implicitly truncate the range=0D
inside iomap_zero_range() instead of issuing a warning.  Any thoughts?=0D
=0D
Thanks,=0D
Andreas=0D
=0D
--=0D
=0D
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>=0D
=0D
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c=0D
index b81984def58e..d9a4309cd414 100644=0D
--- a/fs/gfs2/bmap.c=0D
+++ b/fs/gfs2/bmap.c=0D
@@ -1301,6 +1301,10 @@ static int gfs2_block_zero_range(struct inode *inode=
, loff_t from,=0D
 				 unsigned int length)=0D
 {=0D
 	BUG_ON(current->journal_info);=0D
+	if (from > inode->i_size)=0D
+		return 0;=0D
+	if (from + length > inode->i_size)=0D
+		length =3D inode->i_size - from;=0D
 	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,=0D
 			NULL);=0D
 }=0D


