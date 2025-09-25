Return-Path: <linux-fsdevel+bounces-62693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A15B9DF09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25D93AF907
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375B2750F3;
	Thu, 25 Sep 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="ajmt7OO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E25611E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787062; cv=none; b=KANkrp4x1HDXgasdfQuXBdsXqhRLJAWIQmIrXtiC9jRDeIJEXbvSPakmAwURX9ma9Dseqs6s0VSFHufQ17DxeyhHS6Aw7rK7tk5AoU23F//tODm2lLIoE284V0h+5HIBL9e8e95hbXvVeQ9pt00/R4IkMFPnr47m62Gc36csjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787062; c=relaxed/simple;
	bh=ogWET+bnYNZg1SmgRfmtT1pdLeW3cnXbyZfTtcsQmhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ftq3p9Ta/X7FlTO0ueU90s5njPEL/gc2dpGT9DmJwzd2biNF/BI6JhPoWVexYCXhq7ovvDggoDUtsM/g1tgc4Bi0ZMYkzU/ilzRcCRNbqE/krtMAK6HDQLRinznipHWMI+VpsfbyDqVmYKQtOApy6QMJWO8oPMZkfypN0Zh20WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=ajmt7OO6; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1758787056; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=ogWET+bnYNZg1SmgRfmtT1pdLeW3cnXbyZfTtcsQmhE=;
 b=ajmt7OO6wwlAPnx9/Ue5lkrwVh+FBB865/+cHVHN7iLTrXJpq1H6AUczpmCwA9JwfAh4c
 b/2bUuC5jamM2SD3knL1BnwTFBigawb/VqpTs75kvpEpEMi4OZjqoGX44gloqKyxTc/vmHl
 oR4VRDzbj9cJkjd0p8ANc+nwNeTQVdEI4ofpF00HVkupQzHfO3cKj7TfEIXtiOzFkNwLTKV
 ox2laC7HOG0Xypdkm307W46Qbl9YUk9o49ne0VIGAkxK6wJqJaZeeQnpHS/wXibGmUQ48dj
 Sc+bYczouls6c7H47+krBDL03tYtStvbZoT3u+U/LLmZEaga+jI1nQ0RDbvQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id A29ED5FDAA;
	Thu, 25 Sep 2025 09:57:36 +0200 (CEST)
Received: from silenos (unknown [141.24.207.96])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 78A8D5FC47;
	Thu, 25 Sep 2025 09:57:36 +0200 (CEST)
From: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
To: idryomov@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	Pavan.Rallabhandi@ibm.com,
	xiubli@redhat.com,
	Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
Subject: [PATCH v1 0/1] ceph: Fix log output race condition in osd client
Date: Thu, 25 Sep 2025 09:57:25 +0200
Message-ID: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,
I have updated the code according to our previous discussion. The
refcount_read() call now occurs only once per debug output, and the
increment/decrement information is included directly in the log text.
I hope this addresses all our concerns.

Best Regards
Simon

Simon Buttgereit (1):
  ceph: Fix log output race condition in osd client

 net/ceph/osd_client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--
2.51.0


