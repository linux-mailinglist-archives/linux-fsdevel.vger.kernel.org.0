Return-Path: <linux-fsdevel+bounces-77267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIlLGr/rkmlSzwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:04:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C37EC14234F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D83AB30054D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2E29DB6C;
	Mon, 16 Feb 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I73bV5w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83823A9B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236284; cv=none; b=CszfflpdtonQZ08ee0T/+5CqcwTTxdIzR6d2NN5/vFN4vYnkeQQnYaEIseIe2cHLxn6FXa71O7BQyC8tGbglwPV5MuvVZ+nb2fp2I2UnO94UPG2iqE2Fz0WLKEygzrEhVRV+jmyW5jFVdXULa/IEbS0AFvS85VXNKvyFwj3FR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236284; c=relaxed/simple;
	bh=d8Qd12F18dz38cJG2jVNsi9Tc/YQOz/BnUkYP42iiNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Kc8PUemrd6yY74hi8dW1Ge8CdScnim5BbmSZNwmGYqyr34b9aVVK3zF/ykkbwdSfWL9HSnMFGfkqZck0A+SdAci7uvIKAob4zqKVPgllyJ+DyfDGGfRq1bHQzDbOs1z4P/jIZDzBKxQoyqUgqiyPzgVKSaYCEmgPCNzFSC3xQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I73bV5w5; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260216100439epoutp02d4a1a34f8d15bd629e80e1cb839c7943~UsgMD3BY22113621136epoutp02t
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:04:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260216100439epoutp02d4a1a34f8d15bd629e80e1cb839c7943~UsgMD3BY22113621136epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771236279;
	bh=fvoqRTjxxSqU0BzCrZxx9CepkQTakbT6f/JIM6TtTJE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=I73bV5w5uQrFUL2DZAlm2F5D3BqfQgSnweEmaUC6r/KCguxSjhMEzbPHLceDKLJKd
	 8m2Ca3Xk/mcymhnxeLcgnijMM+v7ATSjJkb6uSQoakTSDBFtf22SE0u28OYrJbyPhq
	 X1mofVMYPuThWB4WVOTzaWfWBP+cjxViFzc60d7s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260216100438epcas5p38d5f4caa4ff21eb796912c5440717ed1~UsgLjSUPv0793707937epcas5p3Y;
	Mon, 16 Feb 2026 10:04:38 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fDz056Z1lz6B9m5; Mon, 16 Feb
	2026 10:04:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260216100437epcas5p415590b08bb19d887bc065f5feba8346a~UsgKNrnRr1610516105epcas5p4W;
	Mon, 16 Feb 2026 10:04:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260216100434epsmtip2814a36ed09219e42d75f7f78e381d376~UsgHpKrol2109021090epsmtip2Q;
	Mon, 16 Feb 2026 10:04:34 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: anuj20.g@samsung.com, hch@lst.de, jack@suse.cz, djwong@kernel.org,
	david@fromorbit.com, amir73il@gmail.com, brauner@kernel.org, clm@meta.com,
	axboe@kernel.dk, willy@infradead.org, gost.dev@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com, mcgrof@kernel.org,
	pankaj.raghav@linux.dev, ritesh.list@gmail.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [LSF/MM/BPF TOPIC] Parallel writeback: design directions and
 sharding models
Date: Mon, 16 Feb 2026 15:28:52 +0530
Message-Id: <20260216095852.4611-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260216100437epcas5p415590b08bb19d887bc065f5feba8346a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216100437epcas5p415590b08bb19d887bc065f5feba8346a
References: <CGME20260216100437epcas5p415590b08bb19d887bc065f5feba8346a@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[samsung.com,lst.de,suse.cz,kernel.org,fromorbit.com,gmail.com,meta.com,kernel.dk,infradead.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-77267-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C37EC14234F
X-Rspamd-Action: no action

Good day everyone,

Parallel writeback was discussed last year at LSF/MM[1], and since then
me and Anuj have posted three iterations exploring different design
directions and sharding approaches:

v1 – Inode affined writeback contexts, introducing high-level parallelism
by mapping inodes to independent writeback contexts.
https://lore.kernel.org/all/20250529111504.89912-1-kundan.kumar@samsung.com/

v2 – Threads affined to XFS allocation groups (AGs), reducing cross-AG
contention by routing writeback work to AG local workers.
https://lore.kernel.org/all/20251014120845.2361-1-kundan.kumar@samsung.com/

v3 – XFS AG aware writeback using folio level tagging for more precise
geometry-based routing.
https://lore.kernel.org/all/20260116100818.7576-1-kundan.kumar@samsung.com/

Multiple approaches have been explored and the design continues to
evolve. In v3, folio level AG tagging improved scalability and routing
precision, but it also increased implementation complexity and expanded
MM filesystem interaction beyond traditional boundaries.

Following v3, Christoph suggested a stream ID based approach[2], where
per inode streams guide writeback routing and allocation decisions.
This transition adopts a sharding model by modifying the XFS allocation
policy, helping to reduce contention and achieve a more balanced
distribution.

Anuj and I would like to gather feedback on overall design direction and
appropriate sharding models for scalable writeback.

Discussion Points
=================

Stream as abstraction over AG locality
--------------------------------------
Is using stream IDs (mapping to one/bounded AG-set) the right way to
express AG-aware writeback and delayed allocation steering.

Allocation integration
----------------------
Is it reasonable for XFS allocation policy to incorporate stream bias,
while keeping the writeback core agnostic of AG semantics?

Folio-level routing
-------------------
v3 explored folio level routing but significantly increased the MM/FS
coupling. Is filesystem contained sharding the right model now?

Infrastructure
--------------
What minimal generic infrastructure is required in writeback, and what
should remain filesystem-specific policy?

Anuj and I intend to lead this discussion. Filesystem, MM, and block
maintainers participation would be highly valuable to converge on a
design direction.

We are currently working on the next version based on the stream ID
approach suggested by Christoph and will post the patches shortly.

Best regards,
Kundan Kumar
[1] https://lwn.net/Articles/1024402/
[2] https://lore.kernel.org/all/20260210153854.GA2484@lst.de/

-- 
2.25.1


