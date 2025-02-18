Return-Path: <linux-fsdevel+bounces-41912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE4A39188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA23D7A3999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570031AF0B5;
	Tue, 18 Feb 2025 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C649wbCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD151AA1F4;
	Tue, 18 Feb 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850965; cv=fail; b=KWZrEzEQcJTF5+awndmujkjB4MUsxOHsZJt/7d9tRh0tq4hWHKxw0O2PJQHqz5kio5loy164aZEFDo2x2oz7ipCL2/aIhWzVtjWuzdExmaS8fhP+Xw3s4/KnyTX+un7p3E7+eYm9FJ1SlCEKbSwXW11MhdExgSQKHAPj3K3Zo6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850965; c=relaxed/simple;
	bh=ZYIms6S2C4O6hU49b/BIZ6D/RvqTOmpsqbzgfZzGbwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X75ylJZdyFcDMQPYdr929Vt4Njxo3ArKaG1VeoAza1P7BpkQOVzOKFPYYfZ28ZYrgzPd7joDo8mZEbnaJzKXB6fKYW0KTtugpqAjfFJMVMkB/uY9aL2gTaH6zdORXTvfcp+DbnJI8yi3sGmL8SSqUMbkizY7S715zn/IA8ZVimg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C649wbCc; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdaCPR8msZgKM8bZsejGqK9otKPxSrIgdE+qxCp8awFgYrDx2RvrYmqzPV3mTpTE3fVGg2Vsgm8JqF65xqBvZtHAIA3kXAQ/Q1//v2PD/MpoFpcWuXYSrZebpjox/De241D1/LfJ/aJmxph+6cRFvRt+2EvR4ODpN+HgC3goR90Lk+vCXTu0RzoBMt22GWTl18TtOTeh+Ao293m2IjZYoT3DOpH5JfgBH9+ehd2xa0wgSCQfYFEdKMoX0aWMuaOslLcfSeziu8EaX1LVbvmyvD5V8mF/RxEqzeqLBm+L5AM2//FvFrAUSYH34ZlUupjaYLmuJ456Snau3MrNDr85hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+P+HGRiqDCmj10CrZO8lY35WcAxWTj70gicDvDjINU=;
 b=VlRk8fV4QV84SfA76ln1wqYheSQLkMDZd39gUoDawwuMRuQ2WIl2tT5Ra0F+kgBuNQQ3foZgAgY6ewBJuv+e4s5OwhdddbUi/0VWdTZd071dZF0R4cg6JIQX8fYWYvzKXTaqae6BYatltqhkRL8Y1LVOrJwgsAVI2q7yH/yZDldkR0QJxuzEBcdYTh5MBBWeV5+S+2bvfqhtv5b2frBTiY8Jw6XjgBlXTkSScyyx/qk1CXYp9CekrGCv20Mo1WLQQAWNIKruKyyA+VqU+a6DwXdR7aARG59z7YYpmkUxxh+QrkmotH/73VjJGCpy+Ud/EcBrubgk2w0ADe+/lx4QSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+P+HGRiqDCmj10CrZO8lY35WcAxWTj70gicDvDjINU=;
 b=C649wbCcsfrXxC8dYPukFSqI0TGt3nmPFx3qDTDL4F11Q+H35IBSxp3u9GrtTzZRWUDXRIAjMYw5wIPcjCQCK+Wei8FjHn4dNe9vi7NjsiHmRmWEXzxyadAptE2tuZsI/LxHgLEvCOcWRRNSeEIcgZuNSKl64t1rOmR6BDZOvcOB/GXrsWQ7+G5/o9GlSFWTHcpCpcKHA7d5LILuaHJJ2oFTuibpVqaM/nyq6EP8VzToOltYKvzli3kHZ+pDhddiXdRgOUQyhrWRULG166Nx2+7zUatuLAC17J5H7wRV5cD0Qqpd17rtN08A5cw6pykVTIxjmc40+SBu/ElxvCyTQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:55:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:55:58 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>
Subject: [PATCH v8 02/20] fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
Date: Tue, 18 Feb 2025 14:55:18 +1100
Message-ID: <d85ce6c2d1400ff111ed7302d9eef223d0243c57.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 655b936b-d9b4-4e22-42c9-08dd4fd02721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBW+tiFiA7utGLWZCYsTvgiEOA3UKz7fxFOiWBetl35tDYqjeO+sjxS+9c3A?=
 =?us-ascii?Q?1eQhkM0VqXtBh6D+2P3JtgXejZBIZWYEOPpLTbUNjaR+dUxxe9/ra07fH8Bq?=
 =?us-ascii?Q?1f6tIsaPFkrzG0jC2dRxw6RVtSyAi/u3LBhGysY3aGfucXB9nsj73BUD7bmC?=
 =?us-ascii?Q?MliVi1kLEYPaQsaOiwwuDC5U4nj8D2yEzuFQq07iZB++/RgYQDEB+wumzyy6?=
 =?us-ascii?Q?yXzJQeFPU+pxfdQuLQXYz/N3dxN6P07fg/yfXnEBCjNzdpAAj3u7Bp/UGIlY?=
 =?us-ascii?Q?On/ZZ2mxrcoNZ59OQqZwNw9r59aqfFpFHIUWILyvmUhUgQT8mrsLzVTyTZC5?=
 =?us-ascii?Q?g28ri68hBHqCXwVSCq0UIkyckSOuRlwYvfxuB9kadQ+hYYG+AyTKuIp9RS9T?=
 =?us-ascii?Q?Rxq41iWrBW3RlH2Z9uJSN7tAwtuk3EDBHW4rHEaRTRkS/Eod6zUeWgBl+vK1?=
 =?us-ascii?Q?Xhm63LqQIsJpndWYc9ZG05+r8iq2VNiG/f8vPzrd/85q6tuivUBSts0gTnsF?=
 =?us-ascii?Q?MZzwUueoTXJkcIElP2z7a/A1l53QtqaFrpfEWoZf4vESfh4rFepQGe1Z1IjB?=
 =?us-ascii?Q?5cFWWfSzazMroKJENLuZeCO9k0v5q2FefejzkSf+qBo+AUXXbEXLTDncwGj4?=
 =?us-ascii?Q?jIqRRDZ0L0uydcg+OgUANy+DAPBaBzhQhdeED3068MTGTJDXq4M2VdoI3B0j?=
 =?us-ascii?Q?aSdMoV3Ze2yh91G48fAfHkSgNmuiz/xdFwVgRF7mc2D3HAUxLrqD4y7ZeXC1?=
 =?us-ascii?Q?uC8Wldt6rWeO8O70Ud4jScKxgtsXLESCY2wDUFQrJme2Cbm+O3h9oVr5c8er?=
 =?us-ascii?Q?+e1e23qvFdtuI0flU7LHs3mHwN0bitT8CYX0QDEUb0p/BzctAmSl/90/XcEz?=
 =?us-ascii?Q?nWZjcsiNONONYg9MTEKN54l/jEaZ++rpLpR9KAxIx7guSIKr1c3mDAsExWGh?=
 =?us-ascii?Q?NTJGjebMgGSEzMxD7rwclPWiLoASFXCT275bvw5w1otgZbbtYU+oLdE39zkL?=
 =?us-ascii?Q?jvA015KoxscSKo+GqVS8jiRPj2SeR3MpgL37cw5j2aR2KjANaL/+FypWSGUb?=
 =?us-ascii?Q?mivua+5fXGkN2Wl53nUBGuQL9GFRwoke3z843iEZTkEusii4XI/y9Ztn+Mhb?=
 =?us-ascii?Q?8uNhLTq44gN8q4Ibt82nQcG3P9W0FF587kdzY0/QXLyqazBxeolFND1iBofH?=
 =?us-ascii?Q?+BG8adP6J9yJC6tninTSJ2xH76G2cSuQN5hbGpIepK4uKQSiYO1WzkpKkMe0?=
 =?us-ascii?Q?HD1czJ0xRJkgVmDoCgLSYWciJG/Gr0rkgxESq3BJbDfMYfo1EPFgwRkCnKmX?=
 =?us-ascii?Q?lupZiJSJDG7LL41P4xpcSCepXk0mKKdSkJpQ8UoYT/3d0rYnfZifYbrXyZZc?=
 =?us-ascii?Q?CaDqyjW6/1C5dK9INFpeaMgSW8zk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+FGkh0L85vVaaF2MzY9zZjS9PWibQRrYUNjZ9n7kyORQlEuskuOzh7BpOW+?=
 =?us-ascii?Q?nmrBiLGI1bodT/y33dy78XEkagYotwqd2Dm0UPbPv6fmtQSr4xrHOVJ3OTHd?=
 =?us-ascii?Q?zB6VL4tTdRznbTb+Gs3gLeJIw5QoJB5nqdGAFh0Lps9ZR2hv/M9ClcdSHt2W?=
 =?us-ascii?Q?Dq1SJG336Ys7wTR0BLOnz5jvrktPZgv5wDs5uRqNCBrctoH0tJuGqd4dZiuu?=
 =?us-ascii?Q?K3umcC7X3wklqzHeAHIIvnh0XaQC+cjRSexblYr6WCq0c5cvX+9xUgzwv/rR?=
 =?us-ascii?Q?f7WgfaMSMPp2f9JmErHQ5o1iHlFn/jTglOdDxtOi7m2TMruVJwdV9eFD61Hh?=
 =?us-ascii?Q?ocxd99J4FpHeYrPT6C7A95ufR1Aw3XJ2JbsCqCRhm13GwpwxizlXfL7JCfkb?=
 =?us-ascii?Q?vTtOlZOSMJqxQ56TB3QYl8w7mMvEV1JnrDGzH3eyz0cPjnHggTHviYJBIAOe?=
 =?us-ascii?Q?RlIw9AC+FOldTH1ri34KXQvQUNWVBmTZLr+B2Q0ECYC+q3JxE7ZHnWtntHLm?=
 =?us-ascii?Q?E9kZXOPLG5laBLHtqVQjhqP6r4hBlYtHdQu5YbYf4guCvA+QdyGj2Yh3GJui?=
 =?us-ascii?Q?b1NcR0K8sl2Hb0pMFzqzT57TllB3Vftw8Bs6ZdohIONqucLQRNEb83+SApch?=
 =?us-ascii?Q?LsiNA5hGpWicwuxeU7dWUKrKe+WFWdb4bX4x9XO16vpJWjNIefsZWx4S6AEw?=
 =?us-ascii?Q?+Fs5aScqckieS1xAyou+MjgrYf/nvtMSiEc8i/qEVUHJQnDPBnvAbR7ojqhe?=
 =?us-ascii?Q?nOONH8+CyJQyegwhZJIy94Hu2p028UomumqWoOZphQjVLEnpC+2URA1sQ7Ll?=
 =?us-ascii?Q?47ikj5KITACJpjSyuxd+JA8zYxGonM16IGU840+w/9P6/LWXU6t1QNvCaguA?=
 =?us-ascii?Q?ORfoYyZsrvfkjP8mLpviKq8SkoLd9iYclt4VUPA5HBgUBTXNuslimAVAgyEh?=
 =?us-ascii?Q?VSergz4EwMsSdlAV18Y/sn7PyltaVdEzjHAdnIhtpb/+p2cY2YXOefzJYQo/?=
 =?us-ascii?Q?c40FLrQXErajzWzDiJ5AkZvkILp+iyMwuXDw07WW0Hsj8bPQ4SUQ4rdnE9Bi?=
 =?us-ascii?Q?eUz6v9zxuhb0BwbB+gqUCCN6/CWqAt5kzGEF2bPbjIxovxBw4KCGi+fYAD0E?=
 =?us-ascii?Q?5RPNxPu9Sh5LqvBlFVyK6PWcpVv+6X4zsY420Ch+bAdvH5DoF9lsfF5UWuWX?=
 =?us-ascii?Q?G7DKHBy+NYi4y+Da83yg6uuHWf+1b9ArkfjQrrdp0IAx66FWkCOgFLio1wRg?=
 =?us-ascii?Q?qwtPlXelrxKSWAx+W+mTKt7x1lqMHl29xCsPXSzVQOlmumsEH8nxR+uwki37?=
 =?us-ascii?Q?yuBlVMqNxrfC2ubQ20b1mfooC17aeuGjt5nOqeTQ+dEF5F28B/u2YN+y7V8e?=
 =?us-ascii?Q?oEJ2LDuq2r1KUhWU2DAWHMkVbiolGv/9OgHF0jhcDFIa02AIVXvQ0kDUGXlO?=
 =?us-ascii?Q?wVHDidiPg1/VnK3OyQYRyTs01y6zuQQyIxnkldsHkFl1EA96IqEPTJ/ssfeu?=
 =?us-ascii?Q?8BKHDfEraJxCAWFLxyR2iaNp+wuqmXup/XSIV5QVZ9xjjPkxwhqg7t+o6J/u?=
 =?us-ascii?Q?Kj3rV0bbyggS5yhQCQ1bCxDgfNkeo2cE5+FyhzUP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655b936b-d9b4-4e22-42c9-08dd4fd02721
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:55:58.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGXJ9q7YuR0Lha9NjlRnMMr0ah4CV11UhRKcjgmFz2ZLEfohwD/064WTDH8pxXK/CQbh07kNI+8aefLDialr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

dax_layout_busy_page_range() is used by file systems to scan the DAX
page-cache to unmap mapping pages from user-space and to determine if
any pages in the given range are busy, either due to ongoing DMA or
other get_user_pages() usage.

Currently it checks to see the file mapping is mapped into user-space
with mapping_mapped() and returns early if not, skipping the check for
DMA busy pages. This is wrong as pages may still be undergoing DMA
access even if they have subsequently been unmapped from
user-space. Fix this by dropping the check for mapping_mapped().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 972febc..b35f538 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -691,7 +691,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return NULL;
 
-	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+	if (!dax_mapping(mapping))
 		return NULL;
 
 	/* If end == LLONG_MAX, all pages from start to till end of file */
-- 
git-series 0.9.1

