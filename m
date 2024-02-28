Return-Path: <linux-fsdevel+bounces-13105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79C86B40C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C5128A2D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198115D5CD;
	Wed, 28 Feb 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGC8LbGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6815D5CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136168; cv=none; b=luBv+BrjQvefCjKe4ZGGTnf70ySfU0fsZ6EAjFj11ty4D3rkPK/Y7NUOMxSLJ27OKRA/mJdkfy+wF8YcbmxHjyTieUeaY3vYojnAVSOA2Nb8iEU8h4GuDs5edatA0gNfmfmZkelMyVNh07CUSQk8qmeq37xyi1eORmiBOzVRXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136168; c=relaxed/simple;
	bh=gcmDylT5tOFHkuXUNsAiv9r7CLlIpQpP+An4L8BC66A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ3Bq95xV69basFmTQHmrmJblRdqBEzcYo+D6kXLlWPdO3Tf04sp1UL9eEY6m3bRoy3k9k8rOL8MmLoDqVxgzL2tbZTrOdQGQuouwnj7JG37gNFX35JXOYcCYTQqbmSTHU1d/kTI8Q+OGYDOFUt6xrdDlIOVHKd9v49kjbmfCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGC8LbGN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkI08nI25MBj/Qiu+niSA2+bh8FbCRap2BNxrenMQ/8=;
	b=iGC8LbGNFSdHKUVUNzt9pe0WoSRbKp4D7qHVD1D7jNIXwMmo9w6T/No7PKe95jPLImZD2F
	0O+ytopFVO7XssA5KxOU4i7zGZ9ylKC15/lKuj4lpPfw7mzJn21BmK86FZbBOtIbt7bF8h
	Pj0ceCzgsx74DZBQZVTZXg2HqcAon4s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-YL5EFRPINW6N4BKxRyTcDA-1; Wed, 28 Feb 2024 11:02:41 -0500
X-MC-Unique: YL5EFRPINW6N4BKxRyTcDA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a30f9374db7so109489266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136158; x=1709740958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkI08nI25MBj/Qiu+niSA2+bh8FbCRap2BNxrenMQ/8=;
        b=KqSou26DAm69Vhh50IZDf8rCZp2LLiXbYGlgXW/ouJvR3w/ttIcb1dhlXtjLsgJ3Zw
         aOrYxDtUJ4Ixy+0b7ZQsZAEJe0Ox1bwK+tI0tkjRzg5/7dprGSby+xO7ve38s4Ua3YvS
         T40VIRbqvUt9QWxG1qstmiEuyMzRbcqvoBn5Qkm2cRXhwx5H1Ti1MYbUBuIBh1+11PG1
         cuvSRFnFcuL4GNIAibBsB+28gNY7mfyAKd3sF980CXFXEa1iZw/gwqmeIbwhtAcMuJHD
         fwRyfhtS+xwpM7SyyZ5hAnvtnWyzKJAqjiAN1RlzyTfOMZg3CLw3Wfo5l1J1gVwbrrBY
         +1Fw==
X-Gm-Message-State: AOJu0YxSyL6RrdiHTZTIiLT8uNcE4OplH95Kb3IxZ6x70Mc4BiJnkCpS
	t/zePinkUTQPCax8DEydGBpgNflLruO//B/xBsQiZlM5l3XOWQYxjM0Avr/mMZBd94hE3MsPaE1
	Y2fZwXLu3uyD82GZSwGzXwxmxG57Dnb/FUKXvQWC/jTaZ7LJkYiwpShwbmEjuzAq3MZE0LDD0Eq
	Q5tORVzmAhPdiSV0SRfYaLO0cqJsapJop0rrNoJ4TnGnlI0EI=
X-Received: by 2002:a17:907:7651:b0:a3c:5e17:1635 with SMTP id kj17-20020a170907765100b00a3c5e171635mr2323536ejc.30.1709136158708;
        Wed, 28 Feb 2024 08:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtyaqg0sFs0DnrHSFhtt4BzD32gz96J4Ljw+YU+3qg/ul93g5YaYWv0q12i7xhgLuFYcajjQ==
X-Received: by 2002:a05:6402:3192:b0:566:ef9:1883 with SMTP id di18-20020a056402319200b005660ef91883mr2676894edb.6.1709136137560;
        Wed, 28 Feb 2024 08:02:17 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>,
	Antonio SJ Musumeci <trapexit@spawn.link>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] fuse: fix root lookup with nonzero generation
Date: Wed, 28 Feb 2024 17:02:07 +0100
Message-ID: <20240228160213.1988854-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228160213.1988854-1-mszeredi@redhat.com>
References: <20240228160213.1988854-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root inode has a fixed nodeid and generation (1, 0).

Prior to the commit 15db16837a35 ("fuse: fix illegal access to inode with
reused nodeid") generation number on lookup was ignored.  After this commit
lookup with the wrong generation number resulted in the inode being
unhashed.  This is correct for non-root inodes, but replacing the root
inode is wrong and results in weird behavior.

Fix by reverting to the old behavior if ignoring the generation for the
root inode, but issuing a warning in dmesg.

Reported-by: Antonio SJ Musumeci <trapexit@spawn.link>
Closes: https://lore.kernel.org/all/CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com/
Fixes: 15db16837a35 ("fuse: fix illegal access to inode with reused nodeid")
Cc: <stable@vger.kernel.org> # v5.14
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ce6a38c56d54..befb7dfe387a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -391,6 +391,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
+	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		outarg->generation = 0;
+	}
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
-- 
2.43.2


