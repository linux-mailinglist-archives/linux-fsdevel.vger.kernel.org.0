Return-Path: <linux-fsdevel+bounces-62694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC7B9DF0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A6F1B27278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A32DEA97;
	Thu, 25 Sep 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="ENWYEQu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD382266EEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787065; cv=none; b=dleGFbud/LkSoDIXZ5IXYZaj9Y5v/YmRGpy9M+h8sHbb94klUesrtIxbt6Vptflt+6zUkOLvo6tK1ROtDsc8T7pWYpOSsWHbWdNH99h4r2sV/8UGACGxFzPAJ8o/Ce7Ld+1AxQhB/3wbRNcsfsIjdven4s82KjnsZrj5PeBFXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787065; c=relaxed/simple;
	bh=fyfrpn5hK8Gk9J6vAit761jHvYBowu2rg4WAvee3mXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0OPrS0IY1k191lrmCnF1F8bKK6iKQCBbRAMcQYHqyoDAgQUv5M/JXidDcnjqsLlFee6/vOm/XG+HBG3NmBDoDKEGRFLde3PW84RRDRkPlE2ZXLgYRbH0oLUQRDxU9oYeZBfEp2cLs9nFJRIiEXbgEXuaufzNuFahrsAieCK+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=ENWYEQu9; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1758787060; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=fyfrpn5hK8Gk9J6vAit761jHvYBowu2rg4WAvee3mXM=;
 b=ENWYEQu9+K6DCR41lirAgElipUGAKJhu0z/XaD9Pz2Aw/TNM/TsQPDjbmPcWs0ws6DVrq
 Guru4goy8WFS5ZYkQfqWBOLmGZysZduPsVXx4rOmj+uySlCCe1vZ0UVzZnG1zUxa33Hnwkd
 x3elzEVqDVU1EpNVGIuKLHMGv90NCGVA6ZgxjQ0lMUAWhfOxGApujuyNHyUUsEb8rtynooi
 FI370PaU8DrKGjl1HNAog5mYSuDBsHez0JDiEnorgzoq44R4cNJ8OWGxaBkS8SxD8T/ghv3
 b+qUi9f68KcE0jaPU8ZIfOBctzzMT1bIHvFrpUGT/lskh6qu0ZgsSgFe3eGA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 8C3345FDAB;
	Thu, 25 Sep 2025 09:57:40 +0200 (CEST)
Received: from silenos (unknown [141.24.207.96])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 74D985FC47;
	Thu, 25 Sep 2025 09:57:40 +0200 (CEST)
From: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
To: idryomov@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	Pavan.Rallabhandi@ibm.com,
	xiubli@redhat.com,
	Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
Subject: [PATCH v1 1/1] ceph: Fix log output race condition in osd client
Date: Thu, 25 Sep 2025 09:57:26 +0200
Message-ID: <20250925075726.670469-2-simon.buttgereit@tu-ilmenau.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
References: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OSD client logging has a problem in get_osd() and put_osd().
For one logging output refcount_read() is called twice. If recount
value changes between both calls logging output is not consistent.

This patch prints out only the resulting value and adds to the text
whether it was incremented or decremented.

Signed-off-by: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6664ea73ccf8..9cf91eed8020 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1280,8 +1280,7 @@ static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
 static struct ceph_osd *get_osd(struct ceph_osd *osd)
 {
 	if (refcount_inc_not_zero(&osd->o_ref)) {
-		dout("get_osd %p %d -> %d\n", osd, refcount_read(&osd->o_ref)-1,
-		     refcount_read(&osd->o_ref));
+		dout("get_osd %p; increment refcnt to %d\n", osd, refcount_read(&osd->o_ref));
 		return osd;
 	} else {
 		dout("get_osd %p FAIL\n", osd);
@@ -1291,8 +1290,7 @@ static struct ceph_osd *get_osd(struct ceph_osd *osd)
 
 static void put_osd(struct ceph_osd *osd)
 {
-	dout("put_osd %p %d -> %d\n", osd, refcount_read(&osd->o_ref),
-	     refcount_read(&osd->o_ref) - 1);
+	dout("put_osd %p; decrement refcnt to %d\n", osd, refcount_read(&osd->o_ref) - 1);
 	if (refcount_dec_and_test(&osd->o_ref)) {
 		osd_cleanup(osd);
 		kfree(osd);
-- 
2.51.0


