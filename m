Return-Path: <linux-fsdevel+bounces-53548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D2AF003D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3835E447013
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1328468D;
	Tue,  1 Jul 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDYpm/nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ABD283FD9
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387990; cv=none; b=QqNyjZc3abrISVp7X+01NHSM3zwphKLkS2U5NIPx6kB19EMOfBYgGrhef3xZn1wnYqnF/nNE3SoGFheTMOa0X4blOldut8dRQ5GAB7aqbD8yN1UnqIVdpccHnrgV95MsQX//pNE44bNHeeFBHJpTa1uWQ32cxEFNV325LV080sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387990; c=relaxed/simple;
	bh=Ai/gf3uGkLRLoXka8lUFvs/gDdKfo7rbbnzJr3GKMgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqXZ17cPmRgS0xjvj8Re3l285BY363EStA96uhcxKjBrb3i2lDIJQIYauOeHsrCfY+FTkuqvIMvbvP10YCrsuK7FU5SBRliZufAQrjlIACOI8suUp7i+tqgaEYalm4LaqU8r9k+ny4ePeFoBiJUiJMXR6pLt1U0GTHE4NKIbXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDYpm/nt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foPbgornqT4ubp6e+8XgYiPshzBkLnc0dUVl3cCX6A0=;
	b=WDYpm/ntG3CKwS/4On/8pSF5iuK33BcEFkw96q4IG5cSXYtRiHmRNsLwF3izTo3d8P5GIG
	+5GMK62+da/4/yO4dqUZkHZ9ue3UKmd2y2KhSsJHZEsCP632gCjLdDskDRsNWi3zUILhKf
	JMY3QeUGx/rUfllcUOavaO+WWn1OHSc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-l2A0ZYtrMX2-pPI2DVaFqw-1; Tue,
 01 Jul 2025 12:39:42 -0400
X-MC-Unique: l2A0ZYtrMX2-pPI2DVaFqw-1
X-Mimecast-MFC-AGG-ID: l2A0ZYtrMX2-pPI2DVaFqw_1751387980
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBA319373D7;
	Tue,  1 Jul 2025 16:39:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35A091956048;
	Tue,  1 Jul 2025 16:39:37 +0000 (UTC)
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
Subject: [PATCH 08/13] smb: client: set missing retry flag in cifs_writev_callback()
Date: Tue,  1 Jul 2025 17:38:43 +0100
Message-ID: <20250701163852.2171681-9-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Paulo Alcantara <pc@manguebit.org>

Set NETFS_SREQ_NEED_RETRY flag to tell netfslib that the subreq needs
to be retried.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Steve French <sfrench@samba.org>
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


