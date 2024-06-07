Return-Path: <linux-fsdevel+bounces-21140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61D8FF9C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392711C20F41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913F134B2;
	Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pKGDb6Lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB95B64E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725601; cv=none; b=SDUsW81+bIwXNX0+joQ+7xGkpN4yrTXsJToI3xOedxN/uCOgEdxRcpX9nTdEunBoVg3hfSGO4oSjc7xbEKJ3igr52R8UAHjhgAQikbTYT63LwpSCtP3kAgHrsS8sEpnadvjbTNW/S+qMnKt7ndStMbA4lNcTO4VzcXOE1HAl+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725601; c=relaxed/simple;
	bh=asPw+EIjnVH1Y3HlM4gyBJkAHFPPy0t/6XR5Lt1CBVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Du2nJ9UsdRNLmi4G5g2/aTNZrXYMn/nLwnPZG+MAN/k6FnWgiHiRsp//Ix2An+O6pX2brVoneQpOdnO2dzSo9z0EOd8gwcnzhIiweyO8RdphO3cdJ6BkPY9fWLgX51beVp/YjPJZ8/xjdOLBk7tYNS4VPNSTWKc9R4Wngy9BlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pKGDb6Lm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pDm+7bMfN/J104Pmrczcz4Hx+PMRbSJvj6h8ja43b7M=; b=pKGDb6Lmz5cvAr7VYY22I0X2u2
	TvxQG5PEscthBb+jTmX+cQGQ69koef/o9SN8eBYljbQyqK1+rj6FnK5GdpY4sSrEBtS6eW+atbND8
	aUhZGTXVGHYrDVYUG/SPQQKLBcZOJvqkHoU7Uxq1kgW+kSfBgmhYKXdomu/SaBwb2r8PQJAHaaGp/
	6EN5os5HJqrYepeY2lByzUgVXVgp4rdlc7HIxW8lTnmtfOOLvYTAisxAjsPWJMg60+ObSY8pj1fIc
	M4n+RqA7UFxxaONNqGvlHQDFZDnpasBuI7HAYU7ojptKJ8KkTF69YLzjsGKAxCqmvk0AxCAY0ByqY
	V9cw/mDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtZ-009xB5-0y;
	Fri, 07 Jun 2024 01:59:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 01/19] powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
Date: Fri,  7 Jun 2024 02:59:39 +0100
Message-Id: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015656.GX1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

missing fdput() on one of the failure exits

Fixes: eacc56bb9de3e # v5.2
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kvm/powerpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index d32abe7fe6ab..d11767208bfc 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1984,8 +1984,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			break;
 
 		r = -ENXIO;
-		if (!xive_enabled())
+		if (!xive_enabled()) {
+			fdput(f);
 			break;
+		}
 
 		r = -EPERM;
 		dev = kvm_device_from_filp(f.file);
-- 
2.39.2


