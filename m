Return-Path: <linux-fsdevel+bounces-53546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4BAF0027
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2E52341A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1A2820A9;
	Tue,  1 Jul 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep9DMSpf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF327E071
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387980; cv=none; b=T5GgAlHqio89wBYQcoQzkyzSx8KVYQANZg2Ahpmntu5ioRJo6/kDl813QLhTYLDVV2dXxsnYpRzkjkrWGTSY3vbVnFW/NaLl/I61zwel+J3PPDAMYMx0Xyw32RvroBTDDQkYaZplup9apC+5O2VbC9TOIfACybrRVMkVzd2ebBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387980; c=relaxed/simple;
	bh=DtBUBiNFHvR7C/HhGzfB06qLrQcUneE408Xu8XomrQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpFSXoK+8q/iHWd62RRyRAnJsrvPeCD0h/hD92xXAA2jZCP/IJmIEFHipjBkbL4bW5AK5SMOyoiKCRuCjUAcLOiueA4dRE5QfVBZ0Wvk/L9XWgR69tYUiXnUeRCAhCz7T79yVaJqpX6yOtqapPTEV9LIL+q6NEx+H0+if51z9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep9DMSpf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slKVWBo+cl2GZSnpgFvSgkokOtLAkXz0oiaEVWNXzk0=;
	b=ep9DMSpf3J22TCWSILsPvBxmQFm+TmH0ZEbmMpAfSyjdTHA8evgb97xKyDxDiiBGTA0JYj
	PNMkDemG6rNDFNgnXw4Y53IVJx7YaGC7KwJ9V6kM6yos4u2sVnvg4YhgTdor9EvB1c5Wjh
	ZwCqwitJQxyC/irXUmVoRm1/6NJz9HQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-Y5SKDLz2MluUSmF1_2l1mw-1; Tue,
 01 Jul 2025 12:39:32 -0400
X-MC-Unique: Y5SKDLz2MluUSmF1_2l1mw-1
X-Mimecast-MFC-AGG-ID: Y5SKDLz2MluUSmF1_2l1mw_1751387971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA35718089B7;
	Tue,  1 Jul 2025 16:39:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 879AD1944CF6;
	Tue,  1 Jul 2025 16:39:27 +0000 (UTC)
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
Subject: [PATCH 06/13] smb: client: set missing retry flag in smb2_writev_callback()
Date: Tue,  1 Jul 2025 17:38:41 +0100
Message-ID: <20250701163852.2171681-7-dhowells@redhat.com>
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
 fs/smb/client/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a717be1626a3..084ee66e73fd 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4862,6 +4862,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:


