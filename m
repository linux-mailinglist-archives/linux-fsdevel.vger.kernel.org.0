Return-Path: <linux-fsdevel+bounces-43982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57EA605FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5AC3BF76C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D72135B1;
	Thu, 13 Mar 2025 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWEH5HPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC61FA26C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908964; cv=none; b=KSR33wyYUB58eNaOfaXxiSD+HJfepzDl/ckoTPQFFT6B858qMQ+9BWoOiveEhP70qPhcsoEpTN6rxUJAqIKWP8nx4HKg1i7E9c7UCduu/htJc4xZDhds4GYNVyYXxC2SwCfX1TQzLINBV8S3YcmlRdDhNyJIfVEnNAITc1r8Vho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908964; c=relaxed/simple;
	bh=6wx3nsqEiunJAujERA5+1OowUi6IHLPi7uf+FD2TuoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5KepYb3gaGePrSaQPAu1KhFPYd5t6302v3RNGUg4BLcX7LzTg79eiyd+ulVR44ELY9tGSWTMimEF2b63APmJk0SBIr8ggDrtRf+wskQJJkwMeNvaszpVu/tTc8WUH2OJTQK+Kf+dXEyRyk6BT7wSFULbU/YUkbjf49ojZ+q6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWEH5HPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q78YRNQpD6xsITKm16cqESA0LOSKT47Tzy7RuuPnluw=;
	b=gWEH5HPqmEGP84V5xYxnPfjV9q64tuHqPuQYQS6//nyVaofidI407ZNlsvl6u15X2V2tl9
	RiQscV4u8S+V3+atZ0HIBML8zPC2QbPOMa5LbolMcltn3pHPWgtz9lkLD3gTI9EoOVw2d8
	ln7Rc3kR79Cs9oX4MS26dfbs0dpVXsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-PuDbLpdIPNmkgWK93z-qmA-1; Thu,
 13 Mar 2025 19:35:57 -0400
X-MC-Unique: PuDbLpdIPNmkgWK93z-qmA-1
X-Mimecast-MFC-AGG-ID: PuDbLpdIPNmkgWK93z-qmA_1741908956
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 169AA18001F7;
	Thu, 13 Mar 2025 23:35:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4B7D1955F2D;
	Thu, 13 Mar 2025 23:35:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 34/35] ceph: Enable multipage folios for ceph files
Date: Thu, 13 Mar 2025 23:33:26 +0000
Message-ID: <20250313233341.1675324-35-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Enable multipage folio support for ceph regular files.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8f73f3a55a3e..d9215423e011 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1184,6 +1184,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	case S_IFREG:
 		inode->i_op = &ceph_file_iops;
 		inode->i_fop = &ceph_file_fops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case S_IFLNK:
 		if (!ci->i_symlink) {


