Return-Path: <linux-fsdevel+bounces-52944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDD2AE8A90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041A53B9162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C352E6D30;
	Wed, 25 Jun 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPYZamPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2552E62B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869790; cv=none; b=StlHN7RWwZXi1iNGXc23oIoVUIltzgU0XzeNwV4vrICLKQcuNQZpJsTsOT9+ADlD0UON2blWj4k1zWnC9WRrlV/tvcd3PbtlIgS69ARgVZr7tdDx2uDA4CJI0jVA13A5mXqBhYwyv9cSripqntm5JnIRSFSv3SNJasDiUiLurlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869790; c=relaxed/simple;
	bh=Ynqc+JaLEgmHa7UoXc62ltP7Rd2llOzFUZOZer8qBBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjCl+28kDLy4FKKm4GndsGd3o//BkPLV40kb5VQwpAMfWwcz24x8vxUCsuVbOdw3bxzmbIcIewUIQGXw4p1LNwVfacIANOoCYifOKQvr0NgaVZJTa/efAeHP2b3iOBejZqy6rHm7IhrHld9yDMWiHQUYff39u3s25qQULiWXNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPYZamPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NXWDABj5NyKjctFkfbdE94f4ZG/vaH3QTHnLzhErNo=;
	b=RPYZamPrF3RxAizNc0AL5wl3pq9n1Pz54eiMZchYob+e4Xnq6pHa5IYID1wLO1ch9uTEMY
	unXADvbNWO5wbLgddM40z4DWoihEtHvKEZhN+WUDO28u6OlnQGbGtPDjLCL+g54wWHB7EK
	WKYrIY+BYoDSPiNZ8gcnroRVWYtejOA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-XUJH4Nb2Oh6TCap3vG3jzA-1; Wed,
 25 Jun 2025 12:43:04 -0400
X-MC-Unique: XUJH4Nb2Oh6TCap3vG3jzA-1
X-Mimecast-MFC-AGG-ID: XUJH4Nb2Oh6TCap3vG3jzA_1750869782
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6102218011EE;
	Wed, 25 Jun 2025 16:43:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E0C519560A3;
	Wed, 25 Jun 2025 16:42:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH v2 08/16] smb: client: set missing retry flag in cifs_writev_callback()
Date: Wed, 25 Jun 2025 17:42:03 +0100
Message-ID: <20250625164213.1408754-9-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Paulo Alcantara <pc@manguebit.org>

Set NETFS_SREQ_NEED_RETRY flag to tell netfslib that the subreq needs
to be retried.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
Cc: netfs@lists.linux.dev
---
 fs/smb/client/cifssmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f9ccae5de5b8..0e509a0433fb 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1715,6 +1715,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	default:


