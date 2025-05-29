Return-Path: <linux-fsdevel+bounces-50086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D1AC8194
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD19D188E33E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C400A22FF4E;
	Thu, 29 May 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKOZlzIJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcKOJkYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F522F770;
	Thu, 29 May 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538997; cv=fail; b=BdOdbVOPseQ/T9dJVoZf3PyAeiWPqxyozmXCF00PGyZRix86ihC6HswcqBYr2yxgaDlActvWAZ2KvmFzNC1G+UW9Sfq9lNoq0Vl7hAqFAMP2sqMC6r6zxpKMa3iw4eLX5V/hC9GLS/n0jhoVSyTy8bDZarehQRXv3yikFnwD3sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538997; c=relaxed/simple;
	bh=NiURaO2rEiQ0YuOYkCf6sdzXgJy+1J4PGTD3/a8Ky+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBqYCTJChfqiwmW3tichj8t0lgC3DR82oaFxnJbw/Exq4LWLTjTL8ZU16E8RMa4mHgqFUJnN1obkjLxz5JblvBgZhdBP+iI6kTxdCH7bEbbLrSdmjfDhx7n1WuN/Xuhw3AP5DcpyDu5qGHREPt4uP4Xe+kVBhFDOtC05RIIgE9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OKOZlzIJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcKOJkYG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfpDc020706;
	Thu, 29 May 2025 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M8gQJDoNfE0EnHon9FFWl7uRYAHR+D4EMOLLOzBp9xs=; b=
	OKOZlzIJM3xgMS//CcdRUe1EtDHX+TN+hK1Lmwv6/w6zVh0c45zB+Uv1YPRHD+D9
	SYGE88sIn9zS4hn+JCMN8Wr8KD4A6yH2ZY9dHF9DTxiYY/qXaHYLvgRyJnSalpOE
	YQBaRw65ya6rbRPCCVnAVzbE9EpHVKiVRXESoWt8Pf9Le9cw6C48Ye6itIv9f+zw
	tAf8zK650zGCS9aFmLvNoTikAvMuhE2vWNvMRr93SXHmFnT7T7HjpfdO/l7wOA25
	bEtCk1aOxNKL7lGt8NN53NAIOSaB9qbuOwHRMG9kVaXL/sc0E2507HxxJuVWnzgx
	hh/GBk7wg90f+ce1etRgeQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcmnu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFr56R025467;
	Thu, 29 May 2025 17:16:07 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jjfrtc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKUgTqRpiLYshWd4/uisThvZ0x0PBB2506serlYFWr0OUehaSTcBEigJHy4FJlMQ84JwNAyg4uxtKoFkpKRKOgfwUzVnyfqqILM3XpsaxqgFZnxSM0Gk4NtwvKNn/rQsZwZEcvfotx7a/c4yFgMm+Kh5P0N3OZGvwgvWFBMHiXpMpqzwfaAEx5Cgc85k1RtRC3DBWyFtZjbL6JH6k7E27DBgZ0zsgtY79OW1UGqWdbgfGc45Tna1IOQojIckP3UEtA5SfrAvNdBlK+XLvaMUir1cR6CEuZt7+2IZhMHa/4I0aWPOtpNLUw7txbPM9zUJ6D6guMBFefRX92n8hm1Owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8gQJDoNfE0EnHon9FFWl7uRYAHR+D4EMOLLOzBp9xs=;
 b=y03fumOARbRyGRFOu0XhM4FgAWx3d3gVP0BM9u4SvZDIBNNMFJwsfbF8MfuLBeLpqM2L4Rnc47oluIYGfV3vYv2OshcorRessBd2yVduHgoSW3ZRR2+ikM+bdHTUdwS3I1L5HAOdIBYzwYXf3FVc32NrtYAf+jGh/jqp43m+4de1HB6NpjE1ED0PrUyRaaOvtfJ2j3XiXajZwyicm+aUDlAUJDoFgK9xYnxPWYRS48a2IsIpMAUp/zVA8SebW0ADuzBY3cXOTEX3cE5Fuw8xZJU7Q0Qv+fA1GNwzjdWanHxTi6E32xsXwfJYqcEJHF1HAC7TLxJWgf5Vb9oIvKBLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8gQJDoNfE0EnHon9FFWl7uRYAHR+D4EMOLLOzBp9xs=;
 b=zcKOJkYGi49qfojssbL00kkfL1xXBCizyDqklTOiCDJH0QY3WORezSV++5++rTz0/UqEEkPXYp8cXEkDFpZFtCZHfMMqfV1eTZJK8dgRFn2fjq2PG0kEnA98vRFMHQztf+aCdRMOM2rhpSIOn9QZyUkDP4/LbT3a5mcklyyUBP8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 29 May
 2025 17:15:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 17:15:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH v3 1/4] mm: ksm: have KSM VMA checks not require a VMA pointer
Date: Thu, 29 May 2025 18:15:45 +0100
Message-ID: <36ad13eb50cdbd8aac6dcfba22c65d5031667295.1748537921.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: ee739bad-336f-463e-8648-08dd9ed47ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCZHy/7+OeaTe6lEh7Lxf5UqfTYjjaglCwXBwSeU1c/3d8muP2Fzp3qL2fqG?=
 =?us-ascii?Q?cBriRt7VKtgr0AdfKhKPUWSTV0GiFNIkGk92XgGkH/qDiaIus0QLL2jCcFxl?=
 =?us-ascii?Q?jxomjMn9bBW6JTWi7jkxGLsc6ybCawiqaOABaY56wlpPl7X6zQOYyiTQjhY2?=
 =?us-ascii?Q?oiV5WdqD3NrXzGU7aAHal5Waj9FBBYEdL2rEEezDdOX3LiHwu6+ZEw3YUlUe?=
 =?us-ascii?Q?fPucYqLwVgGwacN3ihgtFGdIZ86guy/kRne4Xb1o86QKnjx9iZIfcA/VDDch?=
 =?us-ascii?Q?NoD8U14N9xBwOX+OVy+5if1JdZHmcIONBFbHHe4WTHi+2XBOdSw8uvm2oyaq?=
 =?us-ascii?Q?2Navfb6jgzMW9DfDMnnSWa+pQ3U66gd+LcpflIVElMloUv7Qj6ggxgcAF+Bs?=
 =?us-ascii?Q?JxdxkOH5B0ZVnf/Ylr+xjjIvyfJAIULBV4i841MqG5DEIBEvq9jXazY4+tzo?=
 =?us-ascii?Q?qDZVwKYoTAHfrDvrWA1QIBRGc9+xxXYlWc8T9i2lZlp3NzXC+4PpcaQ5QpXQ?=
 =?us-ascii?Q?zuwVFIE2Djof2x5hk+l44ifTKFVNZ6sUirnjkR2/dPwYyMoS30h5X5lMf/wK?=
 =?us-ascii?Q?iDv03guYTMLZnlmLUP2f7hLB7KEdjXEVA05RCxjcfci6BTJp9yusrtLA1cUT?=
 =?us-ascii?Q?BLqzRmclT2T3rhZF9FaGshn6CHI0U0FhB2UxFDTPwS7hZp454A4JKZAsITng?=
 =?us-ascii?Q?6//r4He1p0iaJuzmEBHdDIgxz8wu0ylF5tUt9gku34Cz0dzwDTAGlfzQ2o4V?=
 =?us-ascii?Q?YFGONLU1QZY2LYWFiGR2Yu8a69hl7JsusnQEnC4T3eJm67sIVWzH7PBBkS/P?=
 =?us-ascii?Q?YnrdoFbbfugvKhJcn3jX/xuiOvRgmSfzzFnEICMXoh1Lh8f4tf3eDkMEYAEi?=
 =?us-ascii?Q?FyHDhlI1ezzeHjfDLbHgYKX8QET8Au5HQli8WYmPe75RayBhPBVfkOdMeXWE?=
 =?us-ascii?Q?6wAsK8t3LSTG9A7C2HHaYWniL25wxTX9lazBHJk+0o4qLh4napcxvmu82SPZ?=
 =?us-ascii?Q?DECoI0CK90PRe1qcOIAzzGelfDl8BY8J+ZI0yprkqc2l2hz2/pVaxAo8x6bf?=
 =?us-ascii?Q?JtJsBvZv4wgL219pePc75zZOY8wCgB8KehOGbsnZEuLO6FcTQjbrT/LrrC14?=
 =?us-ascii?Q?Gi+5vVCFtRaJ3cRTaDz7bcc2HocVAEllO5VvvnVadwjDmIvCeEuJ6APUXzzR?=
 =?us-ascii?Q?qtMU9q/Nitd1uIkFh6/8y1jIofKTV2IlyBJd47GF6uxLhc64FjwE6jQ2XN+B?=
 =?us-ascii?Q?Y09bCNnBP57HWZ/+EcVMwmPF/2ZAwoyGAuA9Am+JoNQIRQiHnnVA5L9rlY4+?=
 =?us-ascii?Q?IWLaoFq9IXdjpRtmV5e3z/coQrUXy61+vClYpEjaJ9M/96XAobQumCZw576A?=
 =?us-ascii?Q?5xWXZnwGE6M6ocx+xMuJUMcVGiUEBkVnMXoILIPzC23ny09xlb/1bZEqHXXZ?=
 =?us-ascii?Q?kMxG0kc/a5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvIQn/Vf7eA69WUv9e9KwkBwtFk0ay9jZt7KwEohE7c2soZUyGbuyAVDNzaP?=
 =?us-ascii?Q?AcQQeUoYw7GUQoG4RdYMOVXkarkHoGmUtwkNvM2SsiKA6o8eAi6gAr8M4mUq?=
 =?us-ascii?Q?R/i/31Lw74D8kTDOXXK+vjCaRYDVf8qXuc8YZEi1z4vKxd5Eth/AVQAWHF/k?=
 =?us-ascii?Q?C+F4FRjEbneGY8Z5QMW3FPco9zpicjy2wBm5aOgefMS5BYYPbRBS55so1Pm7?=
 =?us-ascii?Q?qivycql5NKRNnr2kvVzohYGRiE8lF21n429YNvXuOf3iMzqWUobdiOb5EN2y?=
 =?us-ascii?Q?keyhlDH67d9vj49eiOUD7VySuuoWbDFyvJU0xz/9Ef7bPbcDhIdRs+19bj9L?=
 =?us-ascii?Q?BWZvJNGqJdqaXr+QoowJbwkPmRWQ+5yoePnOYWZYTAR4duVyyMV0DZMAFkyv?=
 =?us-ascii?Q?OTex75WB33GlKU/SaYLr/4BAHbOWFweOpp3moBE+3/s4gdeORc9ypnJ+K2Sw?=
 =?us-ascii?Q?rtucL/fyYffytTHciPuEOmb9ti3znEWZpo937wNPfS2YzyDqFZxbyFanSmWh?=
 =?us-ascii?Q?Ii4dy4gPzt+0pL9XS3RXX2QPJVFVyDWigAjVdcwZRN19TU4EvlNItvjojVgs?=
 =?us-ascii?Q?vHO26ItJ/WI21NMTTljKLNSQKegoeEoZvW8xTM12WXEhXpD62ujJrri9d0Jc?=
 =?us-ascii?Q?vyVfKCvoK3Aa8YnDQ2ZkZhjC6H3Es78VjByW3BgJL70VJQH9SyMkFznl5Zly?=
 =?us-ascii?Q?CSXlPC2NMhyBHfiUwdWwy9AEKiKwVSzryWBbUO+9MpI28qDHv1nHx9QK8Ng2?=
 =?us-ascii?Q?IsUZY8pwnsm20+FmU/yO+mNqtzrBIAtcr1jp0zLiVmS5jr1tkn3kXE2g0BCs?=
 =?us-ascii?Q?kNu9o4cWXgh9JnxYsi27DxTNJdfIyNlFwQXU/rodDEonJ56j5Dxcmd/20HwE?=
 =?us-ascii?Q?9bf7JwEOaBHTgP1Ug/kc0ZkLIRgMKIpEaAeNnRDhVpGwL2yN+CI34cfV0ju+?=
 =?us-ascii?Q?B3ESipx/d4SMot7UliIfjZX3ZHIrJzwGAkSsYnEAaay1vpoaih7/pdP054AQ?=
 =?us-ascii?Q?0ZAavUD2I+WobfZ4ofhDEjtSPhepF4CEhj9zLStu/7LGxRZ9fvnjtxx2TN1C?=
 =?us-ascii?Q?tPW0/v6dbD3C0WF1hhbt5XHPqDi6pYX5PRJrAKpu5m3V0hRkqHrVwW73YCr4?=
 =?us-ascii?Q?PyC5vgupU0QmWt2yoDq73YqPv8DuKigJ81oXNjzmTI0bPxFiGawWNSUqPBMb?=
 =?us-ascii?Q?XmUCtZpaHMP8m/VZq5QAZXKV2y2DbTYJbqyW4P0GjtfOpz5iXmJggipWIEOn?=
 =?us-ascii?Q?EonkiLha9/qmMLMsvicZkho6zkVVAY7WuMmaxbjPeAIILkE9K91ZWhzPmsHR?=
 =?us-ascii?Q?ylbTbk/nYJLuHvu5L2A8zFebaTjmrrufSj6fzeaP1ZnVvkysB5sMivMg56pW?=
 =?us-ascii?Q?kgAguGNGqFGeQhzAp7/n9BqlXJOOf3aV3gQPZ6Q9gkNJtg0E35zoGVJ82EyE?=
 =?us-ascii?Q?nkDhLrRP91ncM97XqlDgCsO693S34VIPDP6C132BKFJQM4sBq4moQ8tpGf4j?=
 =?us-ascii?Q?SI08+fC05Qpe9aqb0/MfGb7noRjwd2B82CBa9q/8wrz1Fh8txK7TPTpO7yDA?=
 =?us-ascii?Q?IgKNJq3/YuiSYBPEBawkWfJhoPtcV9Gej1LacuVlevJBDgmYrjFOsC/oTXco?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SawfHd4nDpDnAUNwsYaldi2GUUDulBPqWOw4Igt8YUoHKzRdZTkCuXs5sW0tPnsst7oHv8UCPGg1QvRzSLgLdVax2mSvsue2/PpjSN3sSl5ycGiaLlEV2F7XcF0Xfpw5+iGe+6i+/Yiadn3p3KXaY9X5jwA6ko1gD0bYA1ehNHAs+oThqikM9syEUhLAsEqC9tDZR4Id33m9Yr+n29ssuODXWM0v6r2kHD2v+BuZQMzoG2qVEX2/j6kKO+DuWdRZrjpFk0oxlKFaKXHgO/5TCVHmpWmZEy5mbfHUsGAPcoV0tk7os7JzI1PFQeIv+UWnuf969qHRR2dTX4r/iLghJgK7NtcK0l3mK16j3iSFrM6GoDHjEuyPS9rJACqknfoS+ZQ1/+ysYP0TC8U90sOclzoWgkaW3TM+uki1qqbbSBAPwhNneTkxJ2QtTPhp3v5neIkJXHC1V+6Zmp3an/jkcG49DtSyntwBKhp7txQ+HOjJTnv9MDVlHfnWTOmwLVshDXZeGCdZxNv47KvnuhG2ufh1QhXYBoHZG8El5/NydoCJX71mBERN7Lu2OcJxni8DLOrh9IaGkXnvF8aIplc4wnHJqiA7LWrKInDF0UZXgVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee739bad-336f-463e-8648-08dd9ed47ad1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 17:15:58.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvmZi0/A0MqgbSR8c2zV0brp3Kk7TqUhcEjXcRs+th1FOju7Qzu50+EQKvX8Du9SUK3qmAN4nrKoDaiLLqbd87XsCtGkGD3Rm6YQdTm3jPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290167
X-Proofpoint-GUID: dzpkHJ2CHPQWH3qsDW7qlwW-03gpKMB1
X-Proofpoint-ORIG-GUID: dzpkHJ2CHPQWH3qsDW7qlwW-03gpKMB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfX12PetNaNtE5r ZMiqgmnuPiWd5cm2ucMFGO/LX5PHxNfW6B0dI+W0x0Q0aXsr+WTNpNY0Ymectknso354WMQh4kb r2v4FulEf/IT16QelGkFQt1/qO+Cr2yAvKSbIqluizqNPgu9MghaTvU7lZrFjIFvE27T5c1X9O/
 R+HkiLndb+mO3C+8BlmOwIxTD5YYDdiy8YXuXVSNpb0ITt6lUY+fePwrBiacI/2ycYYLES6+KC7 PeZOBlrC33JcsOJcRW56BjX0vHjtJRETRIXFtwgF+So0AxdKo7H/5JSQWue5Y/QwPMO9foG4Wf6 LJeg3CblniAJwyIDtM85VW82GKiaIAOz3lvU79QjKTrVthu20U2TJin7kzWYHcvI30Qt3M/eCpp
 AJ8UmJv5vNK5IP+jtXhZNY4Dg0ADdAEL/mafj3OyuFACzZXAEBJ0FNEmji4CYUuQBrr1t3Ik
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68389657 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=1RTuLK3dAAAA:8 a=QDyvSBjo4wWH3DWLQTAA:9 a=kRpfLKi8w9umh8uBmg1i:22 cc=ntf awl=host:13207

In subsequent commits we are going to determine KSM eligibility prior to a
VMA being constructed, at which point we will of course not yet have access
to a VMA pointer.

It is trivial to boil down the check logic to be parameterised on
mm_struct, file and VMA flags, so do so.

As a part of this change, additionally expose and use file_is_dax() to
determine whether a file is being mapped under a DAX inode.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/fs.h |  7 ++++++-
 mm/ksm.c           | 32 ++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09c8495dacdb..e1397e2b55ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3691,9 +3691,14 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
 
 extern int file_update_time(struct file *file);
 
+static inline bool file_is_dax(const struct file *file)
+{
+	return file && IS_DAX(file->f_mapping->host);
+}
+
 static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
-	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
+	return file_is_dax(vma->vm_file);
 }
 
 static inline bool vma_is_fsdax(struct vm_area_struct *vma)
diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..08d486f188ff 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -677,28 +677,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
 }
 
-static bool vma_ksm_compatible(struct vm_area_struct *vma)
+static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
-			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
-			     VM_MIXEDMAP| VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
+			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
+			VM_MIXEDMAP | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
-	if (vma_is_dax(vma))
+	if (file_is_dax(file))
 		return false;
 
 #ifdef VM_SAO
-	if (vma->vm_flags & VM_SAO)
+	if (vm_flags & VM_SAO)
 		return false;
 #endif
 #ifdef VM_SPARC_ADI
-	if (vma->vm_flags & VM_SPARC_ADI)
+	if (vm_flags & VM_SPARC_ADI)
 		return false;
 #endif
 
 	return true;
 }
 
+static bool vma_ksm_compatible(struct vm_area_struct *vma)
+{
+	return ksm_compatible(vma->vm_file, vma->vm_flags);
+}
+
 static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 		unsigned long addr)
 {
@@ -2696,14 +2701,17 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-static void __ksm_add_vma(struct vm_area_struct *vma)
+static bool __ksm_should_add_vma(const struct file *file, vm_flags_t vm_flags)
 {
-	unsigned long vm_flags = vma->vm_flags;
-
 	if (vm_flags & VM_MERGEABLE)
-		return;
+		return false;
+
+	return ksm_compatible(file, vm_flags);
+}
 
-	if (vma_ksm_compatible(vma))
+static void __ksm_add_vma(struct vm_area_struct *vma)
+{
+	if (__ksm_should_add_vma(vma->vm_file, vma->vm_flags))
 		vm_flags_set(vma, VM_MERGEABLE);
 }
 
-- 
2.49.0


