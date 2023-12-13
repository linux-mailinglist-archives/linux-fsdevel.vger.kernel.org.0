Return-Path: <linux-fsdevel+bounces-5953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B58117C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6671C20F22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDB85367;
	Wed, 13 Dec 2023 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="TVbuYacK"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 2045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 07:41:48 PST
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D040B3;
	Wed, 13 Dec 2023 07:41:48 -0800 (PST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound17-162.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 13 Dec 2023 15:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiABM9WpGV+rSLNpSsWoZIJYroi7DU/EgErUPlpzmTqcst+KMGOthF2PWGb+TLx8fw2SF8ajl2KfvILMm/08glWdaq/pDkq4DzNuiIGomJMRSjpaMNvIBDXFJww2p1JIDojOGTCHdiCRrZGGF+XtnALN0S/TtkJGLZoc84RelZIExwVSS/9/4Nzu1AWkMrF2CAkOsmyM9rRFtoJhvyalFboOk04e752wr5+dkOGsJi7HtCPWu0igMtzv1jD5cNvesHg546Hp56cWPcy89o/FR5nnv3ueIAWPUTzff+4rWpspyOEJ3RPSxOjhujt/5c2/GTehnaFtejq/2QZfZ6Pl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUk1/u+N23j5Zs5E0X+qZBOkMHuHKPr7n2VlLvkV19s=;
 b=ID3znf84CiigyuvQHfEe0nVwInsDArbZsS8itRpvQ18YWpSptSfpOpGcdMYCCcC7k7N2jOKjFgDxAbyjsgPyc5Ke7ZhOt7/dav06tgrFXq2EGkA8/q1oXTPDFl/IBYLguUp7jJSvSUaSOTDDLOCaUbktGiLH/1Qt8kTocOnyAjjWi5elgp7qKDw3a8DGFNejrgaX81siyGQbGg6J4FxZ5yXF/dRB/PRXj3QdZryA7/4hyVQldOY+6mQ3kaPrt8TW1FjsCd2/O6zb03ZD/KexP1bM+oewInb48UAYk6sceG1gArQF6DxQo0JE7fO4XBtoObxfRtLyYqfqNxDbVkYc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUk1/u+N23j5Zs5E0X+qZBOkMHuHKPr7n2VlLvkV19s=;
 b=TVbuYacKbr8KpVGWJAdbiwkyUALt5XSrFXVuY9TxLJn02myKbgzlqA5J1O1lRugoa/70nkZzQUaqpIQnVqxdQ7mSbJk27jAqpc6XNB0THU2dEX5PWpHUicufnTbR57tYrQMiBZfBkk1B+3KRu+tvhpM7NQBMD9NDi6v5KOKNW88=
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by DM4PR19MB7237.namprd19.prod.outlook.com (2603:10b6:8:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:07:07 +0000
Received: from DM6NAM04FT045.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::e9) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 15:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT045.mail.protection.outlook.com (10.13.159.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 15:07:06 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 1443E20C684B;
	Wed, 13 Dec 2023 08:08:08 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	Bernd Schubert <bschubert@ddn.com>,
	Hao Xu <howeyxu@tencent.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dharmendra Singh <dsingh@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Date: Wed, 13 Dec 2023 16:07:03 +0100
Message-Id: <20231213150703.6262-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT045:EE_|DM4PR19MB7237:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ea54e8d-74a9-4059-19bd-08dbfbed2bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yxuK1g+VL5o9DBK25in99SvlCLwIrNZ8An77MdGRer6z+AdZArsaT4hLU0Y1cmuHiDNL1SEJC5uqLNY4WuKIOhku7Y79wM5WNEjUP0jSboQNENFjYFUpNr8VPSGGvhXcgvU93XuFxd6/Nqc/Noif8Qko0xyeoYK7eWBmWWjwJNkoSBtb825S3FboHZUKSSwhH6wbf/PcrKSiSZ6jtHzO8Jxqx4swV/faOWYne0ALLm+V1tYU1PDDUL+0F31TYhWl3QvOyMjMWJKxe59/ztW/5mSVzeztm5YfmlIJLRftbAzUA+UDSC5jRohiw4SXrn64VJmi+GNQuQAtzYkwhsnDMyJQ0oODp22YBARxpQYpPBXQJK3FW1yBQqYkE/Q7R4hMcthC4OVfwfoWwFgyFZP8UO1YBNgpaSDaEq/nn/Kyktv8fDXOk22gml3cErKf60p3TnQ1BSffRUcDNwXVJ0ZPlpAWMO3QYx7cGFMI6Wci7Ib1Nap6/Mz0+Dzz6JNsMUt7V+IA/4D2lCH0zwr9WvVogNjYDnQtSdafuR3EbseAN831CjUpJel6xLYpZWIPfUHDKBMcmPbMMLo9XERy+aa5qa4ei6ovV2n67cEdkC25AQmat94YwM4ohP2pWx+VENYR9QCoN7N2H1Sp5RF3eWapN0kfc18DjKmf+4ityxN3u/y6yMyUjegOx7beVanh9zz/qKuEDqIORbcrp5XcMbC+9dXWrShcspDQJkbyKgaCDKnodlc6C/LRFyXAv4+xYW6Sz2qxPuvQlqvftAIUajxzjy3C/imtUKw1uwXZ1fsPOOQ=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39850400004)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(36840700001)(6666004)(478600001)(86362001)(1076003)(2616005)(70586007)(36756003)(316002)(8676002)(54906003)(6916009)(70206006)(47076005)(26005)(336012)(36860700001)(4326008)(81166007)(6266002)(82740400003)(8936002)(83380400001)(356005)(5660300002)(40480700001)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qwNS6RvTh1E8Rs21AO1ywqp+qFiv6vZ4JojROIyOgyjAFS0rkOFH43fk/HF6NyP1/PwDJgendyJ2LUBXFNhbzGROmPcYv/sIWG4UbyGjKgCFCqk7FU4AeHIf+JexT/SfvbNZ03Eug4taVKBow//FRtrPQM+wpCXkpH7dfMAi0RwmKJS2KzKRfjELAgSORIegK4JiRYkDoIKuivJc2Ok/D4T4jsMjsqp4Mm4SbQx8jY3uVvzIFusutUuyCfarIe30R2YedYUSk9v9TxEmFa11i9QFoxAdoJoJpi0kiCj1Na0xCpSi/k/VBlcjvlynr3byWE/sjtMkrG8DdudL/c9ALrYkbdsZrykfe75WKLwMVc/br5fZpiamulgXsg9weClb7xw0Z4eTiqvCxLD46w6IMAfsuBykUEYNRERv1XRxslaq/YvJoQtSz+nwTMnlj5PiBNYRWCalMMQd/E3azgYh2vqinctI7HQyiHoHM/kIsDgGmn6C1O/7pb6kb7xRsyD/58xMxdCvQ7sTN92Whqm5WubOKuF5joofUKaJMO3FuCp0MeuJ1PtXJtiJR1hFSJKaYf8zg1RSbod3gITKn3BqbML8+zwYUx/FbLBouQqIOanZ+qoiAJM1geP2JCl6QJWaHv43Hh6la9R9Qe+pzk8E5gRsJIpg4Jzbf2t3idsP6MA6m5XcQhtmGuilGiyMwRvZuVgn9e+iOJk9W77kRozlGSEHuigSQiLu71UgqLu81KW2hxZFcnxZ9d7JStbQYTPc6KOJpi5P5ROQJRKjLdK93U6EjRAVIlPbYQJRSCm+kVV065CQ2LaYIzZo9EqJq997GY/jLwhYgAEpTqZLYR6wXAelaykd+OLiHRyV8kTgqD7EYqdzKLbF6zSpoOsaPwkbAVdehWuIrKaZb8oBg2DE1Q9F/QCTgVGHwVDCHMd1vb4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:07:06.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea54e8d-74a9-4059-19bd-08dbfbed2bfb
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT045.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7237
X-OriginatorOrg: ddn.com
X-BESS-ID: 1702482107-104514-12599-7264-1
X-BESS-VER: 2019.1_20231206.1625
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmxsZAVgZQMCXJwiQl1czM1D
	TJJDnJyMjUwNIs1SI52dgwyTDR3NxMqTYWAPWRx6VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.252791 [from 
	cloudscan15-186.us-east-2a.ess.aws.cudaops.com]
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
and writes out dirty pages, it should be save to call
invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: e78662e818f9 ("fuse: add a new fuse init flag to relax restrictions in no cache mode")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..174aa16407c4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2475,7 +2475,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
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


