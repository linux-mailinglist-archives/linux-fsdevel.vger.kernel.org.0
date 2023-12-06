Return-Path: <linux-fsdevel+bounces-5014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D280752D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748B4B20E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230248CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FOwzIfud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AACBD7F;
	Wed,  6 Dec 2023 07:12:26 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0ECBE1E1A;
	Wed,  6 Dec 2023 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875160;
	bh=oUVQuELufd+5uJnO89HaHyCbduYubrq21BOGdkAjVXA=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=FOwzIfudC9bkRwbf6E0CtzufD/ejcjuSxV7Z5x/uEjKnx7LMxtYMRpGMY3a0f+Xj1
	 VTN9Wid82R80TU43j6P6Id0vICyjWksAudOq7xKWIgihy04fyxDrpW81CcbUOoqSiM
	 4rGdNcNiGvt9vbbsKkj/CzhrpECl0PL2b3/cdjq8=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:12:23 +0300
Message-ID: <61494224-68a8-431b-ba76-46b4812c241c@paragon-software.com>
Date: Wed, 6 Dec 2023 18:12:23 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 08/16] fs/ntfs3: Fix detected field-spanning write (size 8) of
 single field "le->name"
Content-Language: en-US
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/ntfs.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86aecbb01a92..13e96fc63dae 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
      __le64 vcn;        // 0x08: Starting VCN of this attribute.
      struct MFT_REF ref;    // 0x10: MFT record number with attribute.
      __le16 id;        // 0x18: struct ATTRIB ID.
-    __le16 name[3];        // 0x1A: Just to align. To get real name can 
use bNameOffset.
+    __le16 name[];        // 0x1A: Just to align. To get real name can 
use name_off.

  }; // sizeof(0x20)

-- 
2.34.1


