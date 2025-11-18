Return-Path: <linux-fsdevel+bounces-68927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B8C68CD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D514F1D28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E71347FD2;
	Tue, 18 Nov 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="plKh0ck8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wLBxxKa/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5A34403F;
	Tue, 18 Nov 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461183; cv=fail; b=su7JmByQSt7EBnJ3R6NuIn2F8X4SLDPbfDyU2w5GvzHd/naR4brJbfQ7a90LGV2jhShnNJE2uc8Yg7kYePCt5rVISNMfNXJeGDXzF3ZTr0OCINJG9ZQqHq+Lf9J0XHXVg/UPiNj+yMx0fqoynohDKcybe4xT/C4oJhLPNw38+lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461183; c=relaxed/simple;
	bh=hfdKGLQtMYsNmNl0TS6XPu+tNNVf5km3AALylzgHi7I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=McMtcWu7Fh391p4VkYKS9GbPKp0nMqHJnRE4qsgt/eSWjSfGw7+uz3dADct1AiRL3oenaZCfDTM56pvXGZlLiXIpedFN6aWMe5J8jJw9yzcYw1tLAVJXnGXC2a7u5jvz5OjHso4M6M/e81yJpfYVDMrjrVi5qbG5UD7RBghOvA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=plKh0ck8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wLBxxKa/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CdOG024855;
	Tue, 18 Nov 2025 10:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=PdJ3SFBvGXp2vYbJ
	7jzavcFopYUxA1tIqjLRYoiuP+U=; b=plKh0ck80qUNPkCiGIaup30/8vTyDy6J
	iVRELMHktTzirK7NZtGGJDRCjK62pn9ArzhiTDMp9XdnTXmJ71AmleRCtKGhCNHD
	BO7HV8fCiYtEy9G9WTnm9ooyc6QsuW2OQCxouXQKAKfc9a8vWZhZ48INDQ84J7R5
	ewxuec8mFiYUj1trNt7oR9SCwyoQ5kbfwefK2Nc17C8yOyys0Goj3+O8x1hUL28g
	llzWU2wVBhN4I2wC35bvGJPRq2TU60EqbaOeH1uFYnuUQ/ijA8KjfD9z2niJMCJw
	QVpeEth/SZ2dDxgXjBlplqfdoFdOAqYmTdvYXrU0yUBdYlwBtaryew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpvjfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI8wjfl004268;
	Tue, 18 Nov 2025 10:18:37 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8pp85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX6R9qllKMkfKAkQaas64vt1mHYWH6jZXGzoX3Shu8mDOO8tlUizj78CIZTj4t5jqofAs0McI/5yJ763+Ng3KjDY0QNflUBtAhB1F4AdrUu+YpNO3j5FjibCPy86m4gwoVZLPyUGYptfke4e+G5g638Duzdl8Tm2tzyaJO2Tt6+uzB0SnK8DykoBQhGc/Y4D5hyu0XD4j2LMFexpVa8/b5hhZbM//oeMM6Vif4QxI4q45pL9hRNhebe3YJGrd+OL9Wrxq+BWHim9+Wiv+87Km9t57erApV/nlwKe0Tc5SddfvA4SH6OhqOlsKwnp18SWiIPS5EkgDpNDa7+QMipYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdJ3SFBvGXp2vYbJ7jzavcFopYUxA1tIqjLRYoiuP+U=;
 b=lHAdvSUNOX2De0k00GG9WNW2rDdJaSpvKY39aftYNga3zT9gSZDJcvOPCVNkrqSb1EKz6ImAl0hP9kMqepACVf3K9ALUVLUhoBg5eDWxNX02SVTQxL0RVB0H5oMQ5eWJ4Cd4EwjZD5092419zfTJx6eMfxCSMp5ZB3tIX2FonKC6e7DJ9eOzfCBqLE1XXy35J4B5XmL+QggYK+8aV/fRm0lVQlbU3c9zPOKNttqkVO67a6BuXT/1mj0f7NdV7PH3DHZiLVez8tQs4eTA9zLVYXBDynvkCQaeooVy66xTlKLvlC/sNHsynlLat6UIo5b7a1g6oqRs5y8QgE+eg/QyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdJ3SFBvGXp2vYbJ7jzavcFopYUxA1tIqjLRYoiuP+U=;
 b=wLBxxKa/2vpIBuQWJY6PC8CMd5i6bL7u1hs576SY+cjBVHzGGkH1DRBjPqsD7nn8J8P1ENqiXcjrBR+/kclG1OUnFF8chWkJhyJxYZSAo3vT3hs+4oaLmb6/rYEsla8Ou2IFy0zfWQvBU4pwrYk4VFMsy6tLnZUrHLQY8JATMlw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v4 0/9] introduce VM_MAYBE_GUARD and make it sticky
Date: Tue, 18 Nov 2025 10:17:42 +0000
Message-ID: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e22d3d-3b8f-4c51-617d-08de268bcb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26iXhO9UCVR6L/eAG57vejjioLA00DdC3/YFRaBYxDLub6fZCjwM0vcmbA9/?=
 =?us-ascii?Q?OWncrZCKgsUEhuwdZTKeQpCjUl8a2Qvy6M5bJmZX+xkSGWklr1FEDv9zzdFv?=
 =?us-ascii?Q?f7OiKVRd9rWp5uoyZ0ZjyIWAJJyrWnTUaQ/ZOTv+VwhsK1Y2YgSWw6eRlD6O?=
 =?us-ascii?Q?9/7ECNJ3b2HZX7MebObQUJ+BfMdM+IMWkwDcYztmIu05O0iyE/Ba5oVi0ED0?=
 =?us-ascii?Q?mIW5WAYZLmBVOUxnf8Q4hK7//eKuRaQxbncRgK6Rt+pipkx/36WAQqvYkdTN?=
 =?us-ascii?Q?u8ZDIDJAGReqY4dxDDnah3PXT/8jZnMBGrVLzORWpWxt4ncC3PmAxThn6gcj?=
 =?us-ascii?Q?W5xT1BWXbHw+QLtUVhOodzINoiobXJFNBbQiHG+peje3ewm6yjytJzW7fQ3C?=
 =?us-ascii?Q?2SOZUEaMr6Bcjs7xahagNatVfdT4cvV65T8L/I7i034JaQcQUPI7WtAgtI4W?=
 =?us-ascii?Q?KF9M5fXQSKfexDqxf1/bXnRetYI7AR3B9SJOsspGgHsC41JgB06Qd/QyJ4Q6?=
 =?us-ascii?Q?6JFqRMsviIlZ62Pas7cO7r1RaJAvD4MCCSjrybM1NA7ea/Sh+SJSHLkP2NjB?=
 =?us-ascii?Q?ay5qie8LLcQQg5DOlM0J21v13E5fIRM8NF68iM0uEeI2drxE1yTZXi92IVWB?=
 =?us-ascii?Q?MH1FAvY+/arc6rUxkgnSXI+V2Sj8pjlSey1bfP3HFHJ65PITCIqMPHJD/+1m?=
 =?us-ascii?Q?W7FN5WhYPY4HdtYTTBsn7+y1Ksp+3mUrJ1Qz9AZBAFKQiQaM8gtvmSoVm41z?=
 =?us-ascii?Q?haForYsZ/iXJkd45ZaOw92U1EcryC8Pgelf7e0vPjqnnYgCEIA44SnCsXJCB?=
 =?us-ascii?Q?z13Lz0LnnqFZ75wH0JKYzZCfbKpvr95/Rqo/4PCCqcVbV4qSfg/RkjUsgyL3?=
 =?us-ascii?Q?EfMcVr9XOWjMPOT5sEnxG9PqKVm3OLFNCDV+spaJPcWt1KV7MG1ALHDHM9ym?=
 =?us-ascii?Q?hve2qi0sXDzwoO+FL4PCj8ogzRyRXndvTVj5MD4VagZ35OKPjaqjFenOCGhV?=
 =?us-ascii?Q?TZ7Q+kZVqFAW/hOhJx4O+3IDjLuf254CLu8nMslih2TRC50Z/5eAu/U02dvy?=
 =?us-ascii?Q?jJtx3lJjioPW2CA/+d2cEhh/TcEDwLqA083jwoVQ5skvQNC5D6O2C+TN7AWN?=
 =?us-ascii?Q?owFf7mpkt5ZXf+knckGg4Sj8tXD3thc/pjRSPbgtD1zuRoFiuC5SSgpE2Nh9?=
 =?us-ascii?Q?UKwPJtSjz/q0KxTbCsOo+Z4QzdKDk7+PFXWDrWBiRmUlOXUzdGlP32lS9Wl3?=
 =?us-ascii?Q?KjC/xRy+FII3YvwWCtvsUURyj8686yzni3d6xTY0fLJ3bXuUz4wooBrfUXox?=
 =?us-ascii?Q?5m7EpbckRwo6kXIpNUokWsWFiLYZ50PRKFc6BWSnrTyOGeHywZvICebhfsZl?=
 =?us-ascii?Q?fEDn1m1wQpz4V8PJfdE5XmPfTYFoRMCGeHtlFzIStVyPUPTWpvzp1EwQVsWi?=
 =?us-ascii?Q?66Cao4xsZSphoO0pq1Qj0QnMTxtAUVwgqyjRdt7of/+7O/AudKmokg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eWM/qq+XeNaTsFOuxWtwmZCf/xNIHaYvtweAE4QcOLaSnFehu6qtYCMIzJA?=
 =?us-ascii?Q?57p2UxHBAnJ1sSdFOWc2IwlOA2C2BvZ7cxqnFIRhWrrAmOLv0TGjqt30asf9?=
 =?us-ascii?Q?OxRLvTLtglChE/BD9Rypqr5MdHNhcUTH62eYHpeeNeDq9Sl5DYpwvrNe7ecn?=
 =?us-ascii?Q?mSFBPUC26K9WIYEK4hJIyf+/MYELJYjzZHMSNLmP1GXP+ufMtUHy7Hojs9+N?=
 =?us-ascii?Q?9u0jASzzax+RJ13QCx5Q6eiW8PlxxbL7RDJjQJXh47SA93/g9gFSHIAoLDXk?=
 =?us-ascii?Q?RYior07BAGkv8bm8hljtplT+srXZH4f+qq1x6OmC9OOOGADfaaARfVaEkXdP?=
 =?us-ascii?Q?GRAMV5F+UJGU1D1e1HaSdpMzRBaQxGX7d4HHTe0rsWrOTxTUTTHEcv3Bjn/4?=
 =?us-ascii?Q?9T+8oU8MwfLTIqapiz1+E8nuOFFs7VP3MUEG/y146+y5QnhcQvNHZ3DD0FxU?=
 =?us-ascii?Q?bqs/kheFkgb9/3LW/oV9d3PZUFcKuJHYph67LyH7uQIb0moV2DdzEBBdvuFC?=
 =?us-ascii?Q?iQulAAhewrBzpBGxYa6VESS9NobTjjmRqK0QNDhxuKrIh62fxPZaAS8iCJV7?=
 =?us-ascii?Q?zrpiIjZVLgTGtl6tWvhpME9SbU1pqhUZn1QLgXGF7g+8Wc5iPn7L8Mw39mdx?=
 =?us-ascii?Q?T64fU0lJzcdYf5l79TlInfnFnHl43y1QfLWvR1C5ryQQbo8T1L4xnR81pv4K?=
 =?us-ascii?Q?gzpgMzMgkbsMxdM83oYVwic2W0vLC9mHYe4vJQXPXk9kRZVKKfDuUL0AhECU?=
 =?us-ascii?Q?bQn9Pthd1sQE7G4/SCMH5jQz/FQhpvF/XJCrjx793cw2LoLMyvwom4uL+evb?=
 =?us-ascii?Q?KB6Q35+ze8esyiSAj8g4kX/moY52ds7b0Ib87Q7j6meejK+ALcWYn39WoDxI?=
 =?us-ascii?Q?FLieQ2w/zdVF/PSHW6eJ+sJoke98/307dyXSpZm5Sn/N/05+j/HlKGMOZSok?=
 =?us-ascii?Q?ljph1P/M5aCG2USPj5sjLukxIejMJXwYzKZMZN64IpckTmImfMOPChig4psO?=
 =?us-ascii?Q?bdaYucL4DnWSi6H8+DBQI2pu9zfOFnITePIU9F/hhr7Pn5sn8x7ZsRCRDow/?=
 =?us-ascii?Q?zIQzr/Tcabk3hPL/0jxvkrG1b99WGadWdnSeOjirMeFF19f/DqRvHu4dPdeg?=
 =?us-ascii?Q?Vm36d+CHTyo6w3Gg99wxXWSfTduq+fXanExyKCk6zUmtPJKP/uoNDfvTpBqc?=
 =?us-ascii?Q?UWw1hsMGOQsi0ZJ1ugE3+AABfxuyZzdhH7GD/wMgzD8G3lzGxLHLYkIP/as5?=
 =?us-ascii?Q?52/3Q6carKqs7Yyh6jxa6XkAdr61mUIgssNvDK42kHhKck2Lt4wMOqdmW6V6?=
 =?us-ascii?Q?60zJHkS0WMv80NGiYoC8RMn2UKih+Bgidt9NGQV+8yQzBoYl8aKHjwSBPJJH?=
 =?us-ascii?Q?p5NVdD+fhK9+DqWP9kj+vPiixFoqW/7cAmMVb6yfix0L2aFnEpvRI2HznYwJ?=
 =?us-ascii?Q?Q0Wlos6nizAMopw2lsHgC+8GrmK2tlX6RDjNWtmytl9Zy/AUMDJFxr4PASau?=
 =?us-ascii?Q?uM+3daFdmNGzggnLNE2KWxPzdwGGeabexRm3FTJv84MopRa6NRUDbJF+sCSG?=
 =?us-ascii?Q?0N0nHytYZ45P/Ke6wK1THh6uiY0pSOwQlfhJAIVOuyHbeuvg3v2mRaHkvznY?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RMH84heOxqi2IRjlD5uql3A6CLxFzGhCgkVPlL64nHA/pdKxsMxkNDebq/cJGwtQhiKe3yjIlNhGj+9aEuR5Eb1o2ubm9pZDxUP/twFLDFmIq3CtfOZn7aoowDRm2rWshAhlgaruda1nAsLcB9FbHz/Zw3zGcipCxeQyBZGYPJXqj5k91Sa7v9CTLntu0/+9ZAQ+Mk3DHCWP5VLRn+G+3GO1bCLKWKBtRCglJGqC+apFhWJ9xYgp4dqNF6wmFC6UD2FLp+mXVSggrM6lwf7uwlEQqbs53prMODDXTuUlIn+kpMrdiZ3wK2wqVtTRdxprMxe92C2PzaR325+mG5Y3uE0kin9NiKaesnTMOLXnu3opwizswZVM2V522Le2uEveb/MKE9itPvhzpR1xFEsCRiSk7OHBSSosZouyLuVokBjdCldTxV+5n4tTxi23SCbh9V4/QmUgKZOG6kbFGZn7hKgTH9Fls4RYOGPDGSMkGaEs4ymoDs8SPkXedpVVBSWHFUHpj7bXYYvvHKE/MW24c5sE79ppzlEi4hKapClaj351px5HG99NvnMGKBks2Lo60HVTtkwZmmsxUGKi6teenAJs64Enxw2HrpC8se9ILEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e22d3d-3b8f-4c51-617d-08de268bcb1d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:18.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHBTd3tNuAO9tD7AKEN06Xb82zq12pbcC6/nuWZrpK59cNlCWx7VHJU1/d0qmTLsSEekhp+Iz1I8ZhnpclvziHJeYb9vmvDwHu5bxQky7UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1DCej9Z4TIE0
 LHA7n+wNyEfXYqaznSTprqMeQDLAsJBSI+fUJMGGGDLXFp18lGmhDuSlGfFEsTIhzuGln5OE17D
 ij3NM/gfEa4ZaFmaREGWtOTfMx5TZxhesbhisdTyMEmnMLU/CBrJRyafOCkAM5Gj8kWzqScFOMH
 g+vGCzBAMMxMdNm1/N4ECHvPmruWHZsEmm+rHWr8K/HGqLqvYrcfhi5mvTJXM/W4hPK0HCDg9P5
 lMdeN7mUWqPD+ytUMlPHym8Bf/eXcorUZzCu2jDKK0cB6pkNNbhO51SrrC/Ryat2e4OwHuKEmDW
 68/gUd+5Z1Ns6jlfJAzSfyz17Dww30TjndF0i0SiGI7/h7Yb41V8OOabVoR/kS4eg4m/LtO4Au9
 UNFf3Ghm1qNENgAHorDMJmH5MQ3Rhw==
X-Proofpoint-ORIG-GUID: Yi6oFdgPhlNyTWT4uCA2P-C_w88CG4ZW
X-Proofpoint-GUID: Yi6oFdgPhlNyTWT4uCA2P-C_w88CG4ZW
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691c47fe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=1nac1dKDC91mST8csvcA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22

Currently, guard regions are not visible to users except through
/proc/$pid/pagemap, with no explicit visibility at the VMA level.

This makes the feature less useful, as it isn't entirely apparent which
VMAs may have these entries present, especially when performing actions
which walk through memory regions such as those performed by CRIU.

This series addresses this issue by introducing the VM_MAYBE_GUARD flag
which fulfils this role, updating the smaps logic to display an entry for
these.

The semantics of this flag are that a guard region MAY be present if set
(we cannot be sure, as we can't efficiently track whether an
MADV_GUARD_REMOVE finally removes all the guard regions in a VMA) - but if
not set the VMA definitely does NOT have any guard regions present.

It's problematic to establish this flag without further action, because
that means that VMAs with guard regions in them become non-mergeable with
adjacent VMAs for no especially good reason.

To work around this, this series also introduces the concept of 'sticky'
VMA flags - that is flags which:

a. if set in one VMA and not in another still permit those VMAs to be
   merged (if otherwise compatible).

b. When they are merged, the resultant VMA must have the flag set.

The VMA logic is updated to propagate these flags correctly.

Additionally, VM_MAYBE_GUARD being an explicit VMA flag allows us to solve
an issue with file-backed guard regions - previously these established an
anon_vma object for file-backed mappings solely to have vma_needs_copy()
correctly propagate guard region mappings to child processes.

We introduce a new flag alias VM_COPY_ON_FORK (which currently only
specifies VM_MAYBE_GUARD) and update vma_needs_copy() to check explicitly
for this flag and to copy page tables if it is present, which resolves this
issue.

Additionally, we add the ability for allow-listed VMA flags to be
atomically writable with only mmap/VMA read locks held.

The only flag we allow so far is VM_MAYBE_GUARD, which we carefully ensure
does not cause any races by being allowed to do so.

This allows us to maintain guard region installation as a read-locked
operation and not endure the overhead of obtaining a write lock here.

Finally we introduce extensive VMA userland tests to assert that the sticky
VMA logic behaves correctly as well as guard region self tests to assert
that smaps visibility is correctly implemented.


v4:
* Propagated tags, thanks all!
* Folded all fixups into series (thanks to Andrew for his patience with
  these :)
* Added patch to correct an issue raised by Pedro - we can't
  unconditionally set newflags |= vma->vm_flags because on split/noop we're
  overwriting them.
* In new patch, corrected horrible formatting of vma_modify_*() while we
  are here.
* In new patch, added kdoc as 3 kernel developers, including the author of
  the code (!!) have been confused by this. Make explicitly clear what each
  does.
* In new patch, make vm_flags_ptr parameter a pointer for vma_modify_flags,
  and have the function correctly update the flags on merge, abstracting
  this mess somewhat and avoiding case-by-case open-coding of the
  fix. Describe clearly what's going on in the kdoc.
* Fixed typo reported by Jane and Liam, I must have been very tired... :)
* When introducing the new patch, we couldn't reference sticky VMA flags
  yet as the concept had not yet been introduced. So update the patch that
  introduces sticky flags to change the comments to reference the concept
  now established.

v3:
* Propagated tags thanks Vlastimil & Pedro! :)
* Fixed doc nit as per Pedro.
* Added vma_flag_test_atomic() in preparation for fixing
  retract_page_tables() (see below). We make this not require any locks, as
  we serialise on the page table lock in retract_page_tables().
* Split the atomic flag enablement and actually setting the flag for guard
  install into two separate commits so we clearly separate the various VMA
  flag implementation details and us enabling this feature.
* Mentioned setting anon_vma for anonymous mappings in commit message as
  per Vlastimil.
* Fixed an issue with retract_page_tables() whereby madvise(...,
  MADV_COLLAPSE) relies upon file-backed VMAs not being collapsed due to
  the UFFD WP VMA flag being set or the VMA having vma->anon_vma set
  (i.e. being a MAP_PRIVATE file-backed VMA). This was updated to also
  check for VM_MAYBE_GUARD.
* Introduced MADV_COLLAPSE self test to assert that the behaviour is
  correct. I first reproduced the issue locally and then adapted the test
  to assert that this no longer occurs.
* Mentioned KCSAN permissiveness in commit message as per Pedro.
* Mentioned mmap/VMA read lock excluding mmap/VMA write lock and thus
  avoiding meaningful RMW races in commit message as per Vlastimil.
* Mentioned previous unconditional vma->anon_vma installation on guard
  region installation as per Vlastimil.
* Avoided having merging compromised by reordering patches such that the
  sticky VMA functionality is implemented prior to VM_MAYBE_GUARD being
  utilised upon guard region installation, rendering Vlastimil's request to
  mention this in a commit message unnecessary.
* Separated out sticky and copy on fork patches as per Pedro.
* Added VM_PFNMAP, VM_MIXEDMAP, VM_UFFD_WP to VM_COPY_ON_FORK to make
  things more consistent and clean.
* Added mention of why generally VM_STICKY should be VM_COPY_ON_FORK in
  copy on fork patch.
https://lore.kernel.org/all/cover.1762531708.git.lorenzo.stoakes@oracle.com/

v2:
* Separated out userland VMA tests for sticky behaviour as per Suren.
* Added the concept of atomic writable VMA flags as per Pedro and Vlastimil.
* Made VM_MAYBE_GUARD an atomic writable flag so we don't have to take a VMA
  write lock in madvise() as per Pedro and Vlastimil.
https://lore.kernel.org/all/cover.1762422915.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1761756437.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (9):
  mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
  mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
  mm: update vma_modify_flags() to handle residual flags, document
  mm: implement sticky VMA flags
  mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
  mm: set the VM_MAYBE_GUARD flag on guard region install
  tools/testing/vma: add VMA sticky userland tests
  tools/testing/selftests/mm: add MADV_COLLAPSE test case
  tools/testing/selftests/mm: add smaps visibility guard region test

 Documentation/filesystems/proc.rst         |   5 +-
 fs/proc/task_mmu.c                         |   1 +
 include/linux/mm.h                         | 101 +++++++++++
 include/trace/events/mmflags.h             |   1 +
 mm/khugepaged.c                            |  71 +++++---
 mm/madvise.c                               |  24 ++-
 mm/memory.c                                |  14 +-
 mm/mlock.c                                 |   2 +-
 mm/mprotect.c                              |   2 +-
 mm/mseal.c                                 |   9 +-
 mm/vma.c                                   |  78 +++++----
 mm/vma.h                                   | 138 +++++++++++----
 tools/testing/selftests/mm/guard-regions.c | 185 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 tools/testing/vma/vma.c                    |  92 ++++++++--
 tools/testing/vma/vma_internal.h           |  55 ++++++
 17 files changed, 650 insertions(+), 134 deletions(-)

--
2.51.2

