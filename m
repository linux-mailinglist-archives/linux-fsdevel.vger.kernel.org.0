Return-Path: <linux-fsdevel+bounces-32387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB29A49E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D8D283CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03A1917FE;
	Fri, 18 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kJ1fQRN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373718E758
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293560; cv=none; b=YF7kGH33ooxJJeG/+Q2mZRA/bMipIvhabkFsDQBk2oraf/UDpNf00N2liOA0dOF+oSXNMFLaVtxLKnc0Df6+sPavgCHGFvwy3cfl0jCKDGuKhxxdXpNNZts7v+p+LXI9SWa+Uo5augfjc5NmH05fZ7SGWrSYbQK70VcQLQFTFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293560; c=relaxed/simple;
	bh=9c1GEpmG8P1WjBS3aHlZgkSloQ/Eix7yHIdoWQhIOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/BdUC3IbKMF8t94rgtqNM1TXOJhC4PpdPLmjmSEHs38JD5blPKjTpudAzssbtNg3ZlGwDHyM87KhSaLyZRq17NBNC68rrwpc2aqOKErif8aLELMsHs8n0V7fvvhDe3wDYauPOjBKtx7Hz3g8bbGRy7z0nSo6AsLtOZRc0phWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kJ1fQRN/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lEAlhW5WGeSHUIINYiIBmYi15+zUGHQ/Gwg+oSFVaV8=; b=kJ1fQRN/yZBZaaUL554St+5ACe
	6AF2Lem0gYrM9iYXRns6nkwMGU39Q+/NahwhBMLRLXhht3u7OQ9Mjvoaev49lNQuIdkapN2oreuAg
	wtaGJO45i95NYQIW+tnDmWq1fchSdLsXACEHZSzbms1noBmRbHgVtIcyqnbankLHOEPb/TsVXGwpS
	m7qf9UK1V8QIBP4SDToMHU8TDmjSXJUMgj2Vmuv7KLmGPNf0Vkwb5JMIfJNp+sRptzi3vhClj1aIk
	u+zhaX4JUCh+bxJVoptR7fIP7lS+WrzQCkbQAlREa4Pq5WITxh7uVAtsLbV5mT6DbH3S/5WVY0Wrd
	kbLEwLUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFY-00000005E6H-49qL;
	Fri, 18 Oct 2024 23:19:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/17] ufs: missing ->splice_write()
Date: Sat, 19 Oct 2024 00:19:01 +0100
Message-ID: <20241018231916.1245836-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

normal ->write_iter()-based ->splice_write() works here just fine...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index 6558882a89ef..487ad1fc2de6 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -42,4 +42,5 @@ const struct file_operations ufs_file_operations = {
 	.open           = generic_file_open,
 	.fsync		= generic_file_fsync,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
-- 
2.39.5


