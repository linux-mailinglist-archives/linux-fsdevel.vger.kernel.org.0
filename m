Return-Path: <linux-fsdevel+bounces-9780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22753844D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892311F22850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C113C497;
	Wed, 31 Jan 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BDg5a++l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C13C465;
	Wed, 31 Jan 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744517; cv=fail; b=DXZPLf+MgloiGxOgxvvbw700+DMmFEUbbEJ6iNI6hEeNBVs4lASZ30vvAjVet9mxf5haF1XkzRMjCfIQAZm1FJSX5y/p77BAsfXTussmXfh/goLvFSj2c3CAxapz5LAodZCmJEQhy7yDgTriaLgUuWpMEL3cE4yFc72o4+IVux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744517; c=relaxed/simple;
	bh=w/qdrlQHUQFRXSYKDNwfuBKSHHOpOzbvT7jUkwdXmuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsHaGzXTpQtEMrpr8YDQxMSMywy2xzHI/LY/kFvPaOZ4z6XiZfcS/+ho2tTYyM4d+DhmfZMdBJcLWatJQ48v7F9lB/oD8hhIsiKi8bAX6RcrftVDQqVVt5lxEaCzlImNG2HbjZ9o9djDSxFCX7tX0v6NQOaHQhoQredHUwY7SPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BDg5a++l; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound42-190.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 31 Jan 2024 23:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0XmWcLHpwKZYqbs7mO34n1RKX04gL8+bEkkX7O3k4cniLoAT5PitAqmuYUjL0qxoxvDN4e4CrCCgwRtuLKiSbrlc9R1z8JoIaeXvVF+6ySIKZ2slU9GnPxLfDlssVI4R+EZKSan068wbvJoWZjuS3PZfZIthOsnWfuUIGBE3mp4sPNAT1sQqZWgQJ7eZlkOmKUflUL+v08sfsVpTxcnHO6ibPeKzUl70YFwcVXHg7LbgzWfbfPXAivzWu8qFEw8PsobMagwJXQzZPwNpRAYGferQA7j6HyYfXtYUkDqXbs2oYkNGVmxa5BMF2vi3Yb5jkYhtfe2g5mnapMO/LFB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlwMgrrYyb+E0Cc11FVK6rPXIMLM7rK/vKb6FfSFyjY=;
 b=HY0B2vP8HIufRxym/n8tD0vhv0KCDDKPfND72JWX1SkRU9n5ODA1+NT69XdANgxcE1odxIEJiHwqOnGs+440njkJ5pttkwdy0JPFlGR6vIecmx+6nBV5omIlHFCrG4KqVrts9tXGaZ4ReyeIRZ+v2C7EoPzs30a4H9yWG/9xdsSCJKqkQLd21BP14R70+8W5kaQbCO6RDg5bX136/v+RG+7obCNoqXOcof0HJk8HiJnfdqlmPZzXN67y4eMo3Kl1G7q38bXANbuEralbuW5N+OC1AZQ3VAxooqtJ375JgMGijy7UKU1A5jYqCI82pWgyIoC7v/09QJ30NjB5BtPXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlwMgrrYyb+E0Cc11FVK6rPXIMLM7rK/vKb6FfSFyjY=;
 b=BDg5a++l/ZJ9NSY6l+SEY8Xwi+wfIBE717gNmmOUNTSk5JdZZekKhaIWnXhjCpJfNZMRg6nkw8GOitE4dGsejf7dRnr24gIabGgQPwSa2mNtL7z4FeZDIjV8ARbU7FvBUL8YObJYTwHFK9M+DfXz9drnGzhsCAy+r55YDPng+q0=
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by DM4PR19MB5908.namprd19.prod.outlook.com (2603:10b6:8:6b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Wed, 31 Jan 2024 23:08:55 +0000
Received: from BN8NAM04FT056.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::f1) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 23:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT056.mail.protection.outlook.com (10.13.161.127) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.24 via
 Frontend Transport; Wed, 31 Jan 2024 23:08:54 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 661C820C684B;
	Wed, 31 Jan 2024 16:09:55 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Hao Xu <howeyxu@tencent.com>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Date: Thu,  1 Feb 2024 00:08:23 +0100
Message-Id: <20240131230827.207552-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131230827.207552-1-bschubert@ddn.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT056:EE_|DM4PR19MB5908:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e347a6d-9fb6-4ab2-efc2-08dc22b198a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rt6Z1jiLDmtKKylBmhdhBXlHQNyzdWJ/prO4z4ugN4gJ3q8I6gBFrzm99pp1pGrWu1UDQxvk/+c2UJ1JHhq8pdoqzDGHYv6ILdGSsk8ONgILfSXf6eSoGJsvd48USp/XCNFwvrrUIV5xkj/G0MaDWT/3rGrOuB6sS2og+Nf4jDB4PYq6JrylSE4NkVSjbmwyCx+aKaIbPRjMaH5xCMycmFNAw5nGBuBV5GcHuaI5AE/JmrzINxCssVNldjlE5zSsBEkiue5YHe24mVlgKLPC/KYEOuRoDPsUxChNVzilbzii0+gRngZgNlqtP7CS91xqi7yL2ZTOSOvJA0228qntNFPJFhSGEmT+HGlXv5/JFIQoPhDyOtO2AbmmT7zN088h4AKC6hgOY5AoDlRneziRbOZhmfrOlycs7JoSMvrarD5wHOlzx4fu1rlDEdQAHQ3apa0QP8AdbEVN0gRdemwnxv7E9gWeHCjeDffkuxJsG5LoIptmqduifxqlacF1FE2eKcEIK95HsZ7i3dml6p6Nrj8nnM35NiiUx+SEpTp6+Cxi8mn+xiK5TIpBJU79avRi2NN3JShvZjaJtBDGjcDCQft4SEdLZ9mWGhehmDu/RbqkEvE5qvUv6Zjfd+sMrQMuuYqakR3CGENxYB8S5vq2beK2Yh92iH+4lCvT/UO+8VB8qjyTY/KQqzptM+1bG0hIVt0+nwsLd7MBps0JEgPG8R+aAOPP3VMdxU2XzYQ24qp+zmhezP1Ro375pbrbBUlUu9oRvS//6po1Y1R3+/AuhyFCYDmmlU+9bN2+/x2Ixbg=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39850400004)(396003)(230922051799003)(230273577357003)(230173577357003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(1076003)(26005)(5660300002)(2616005)(4326008)(8676002)(47076005)(336012)(2906002)(83380400001)(6266002)(70586007)(70206006)(54906003)(478600001)(6916009)(316002)(8936002)(6666004)(81166007)(36860700001)(356005)(82740400003)(41300700001)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R1cig1SojKK0AyR43AOwpoBLr4lg3Isi5jt1G0KJcOq24oNyCzLdjll+hxA8pQxhn8Ckyfre26KImKCbtX/YnHMdI1QeTp1MRHa0rNzQsolj9cdSVz3lTCrug9Wbe8zmRjES1dqGK6sk5vHe+hPQDOPr8kIvUgo1z7KFqwcxvyK0gQ2NFd4Z6n9bdz0bfoo+r5jeyHZj6BlipywEmEv13KyYGMhOD7cuneGv+W9qH45rclDaBnUvee6QkVljA3WZ7lvGua1nlFopkf+fblsda1IvnFBfAw9wVRlxtGYFJltJQdU2B5bRprVdJOhW33pRIVgUYGwFwkFeQe4hstEsdTnwgT7UDeFOcRxkQhoLcup1MZ5ddbauM+uZmhjIXXi4qzBYlk7psegCxcG8kr1VjKrWij0IPOA8py25VlOacE+gmTLy077JO+c//sEMoyoIrCU3hFg8vk+SyfrvaBQCVbwuWqtfRWEkMc1SHTmqvy7YIFDYM8qWJtaI8etZkwxARjDmlYPa/4wu/hTQZiwe+kGZoc5LDfbRd7cRktpnqbfcMMmsjIIUsSIa65Dk/gXQk/lP18NteQlOt4kTEanUQyHnGEjbRyDzUlr3MrcxeHofwMubDze8GHlhbKRdsGR7RFx1s9g95SNzR5SrVWj6Wg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:08:54.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e347a6d-9fb6-4ab2-efc2-08dc22b198a2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT056.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5908
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706744514-110942-12526-2818-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxoZAVgZQ0NAoxTjJwtLYIN
	U0JdXYIsXS1MTYICXFwCA5NTHZyCBFqTYWALdr1FtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253897 [from 
	cloudscan8-162.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

There were multiple issues with direct_io_allow_mmap:
- fuse_link_write_file() was missing, resulting in warnings in
  fuse_write_file_get() and EIO from msync()
- "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
  fuse_page_mkwrite is needed.

The semantics of invalidate_inode_pages2() is so far not clearly defined
in fuse_file_mmap. It dates back to
commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
and writes out dirty pages, it should be safe to call
invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: stable@vger.kernel.org
Fixes: e78662e818f9 ("fuse: add a new fuse init flag to relax restrictions in no cache mode")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..243f469cac07 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2476,7 +2476,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
-		return generic_file_mmap(file, vma);
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			/* MAP_PRIVATE */
+			return generic_file_mmap(file, vma);
+		}
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-- 
2.40.1


