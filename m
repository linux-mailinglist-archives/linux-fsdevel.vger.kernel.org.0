Return-Path: <linux-fsdevel+bounces-17467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8468ADDB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1B31F22F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946850291;
	Tue, 23 Apr 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HOBFpW/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115E481B8;
	Tue, 23 Apr 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854724; cv=none; b=X3XxUZFQhPEG9K3j2nTGzPfY3YD1cvNYgcM8k0f+LvAkK/FXh3VRoiZ/z4BDz0lhh/syL5y9wID94J+V8dQDrDrmb++TbSySssF7v/D7PAKn5Z5+LTXoNfzKF8MXr9wmAvtLGdpMa2hPkGd6qhTEEb4qHYsO+keeaKrVlUrpTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854724; c=relaxed/simple;
	bh=xDey/bPDIETOzyCtWip2cVT9cVPRQ8dkx4VUAGlDI9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUpEudRwUF0WOp7V0g9THz0mziHRPdRYPWRJvAC/ocrtfeR1TF6Ooed16JHsmXRh8xxTusLZpVs036gPLg+MEOR22XouoR/8spg71UkljzvhxePTa3gneYOr9k6UOQo+j/9XH0w9nhd95QdOR9je3huUIdi7OIrRjofPyLTzVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HOBFpW/J; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C0E061E80;
	Tue, 23 Apr 2024 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854269;
	bh=8abgFsR/Ui2xo5ZXw2cy57yMyvZkyHIC4gHtv2Ld0QM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HOBFpW/JtnMEXCelQPtYAct0c5gHYYXkLfw5GiGcTRJFo77gSQGlDQsubvBaxyXgi
	 VPIw/DsCPNMUqmoOxBzKjFngrj5oUaQHI9c5D6KebJkabfYURDGX5k81CETUlpZZ8F
	 OSPLQtsQV6ueiXWrlLVL+/0kpkF3E4+Y4NM2STlw=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 6/9] fs/ntfs3: Use variable length array instead of fixed size
Date: Tue, 23 Apr 2024 09:44:25 +0300
Message-ID: <20240423064428.8289-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Should fix smatch warning:
	ntfs_set_label() error: __builtin_memcpy() 'uni->name' too small (20 vs 256)

Fixes: 4534a70b7056f ("fs/ntfs3: Add headers and misc files")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202401091421.3RJ24Mn3-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9c7478150a03..3d6143c7abc0 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -59,7 +59,7 @@ struct GUID {
 struct cpu_str {
 	u8 len;
 	u8 unused;
-	u16 name[10];
+	u16 name[];
 };
 
 struct le_str {
-- 
2.34.1


