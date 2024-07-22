Return-Path: <linux-fsdevel+bounces-24061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA07938E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B48A1F21E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7516D4C1;
	Mon, 22 Jul 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/X/NT9W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YM6GkthB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD116C6B2;
	Mon, 22 Jul 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649062; cv=fail; b=WKzyEqN8fc4rGCbNfLHaQ53oAnF5CyZliGvx+ZO+QX60LSzKVr2hoGRedL284XsQgk3wgTKbjNksYZPmbSLMcQyYmN931iw9mgwHyjkQTKHxpAHmrzstzj74KyXyj3ckZrabf6UfUlFGc3wtHZz2C7yQG2LJDil8CE3r8WPelu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649062; c=relaxed/simple;
	bh=Su9rVjksNigTFBcAAlMAIihFH8dMaCCkpHIP02Lssr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZ9Pm/SVpVihF9SttPIIVsjtYztQfuLBqA+4pyp04wg5RzH/HXlPCX1FmtM4Z/8Iu7mcwORwLajFha7OJrhF4U2Ru/HmjG2HkmUo+psRqREKFP5oiFmrT+9ozuadzHbLWyQ9mIdciga1rB8VCvWOsJ80MKUfOlnLas59s1SGTiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i/X/NT9W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YM6GkthB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cxNb003143;
	Mon, 22 Jul 2024 11:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DVjITTBjDNa4l4ig8Wdby7roD6jAwlZCu3WT1v2W5A0=; b=
	i/X/NT9WKXllCWc49VLvmaPMUzHkJdibyXsjBBzgPFJIPpK12n19HzfADwdHYS9u
	acggytHWZaMwo0KGWBX/LzVEBNaGphOcxabcgIaGR54GgLbSVqeyKYqrzIwBbRpM
	D7OCu+b6/bJfPX8wGZjxoEqr+jsdapGI7tQcjzN1y3l0oi6UuO8xODWjmW+7pRr+
	0DI5epAzs/XTbQL0Ep9yGsjHnJwFcGb+xyNkiOpzdbswZO5sPt3p0zfcUhxVZwgq
	VSC431Yes/NjZ9dJ1BPBB5eXt/s3+vVeCC7CXX2pks1Xu9i8lhgFqj2PjNb7A59g
	rRcmkJ47uUzo/9IgvYGD4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft09j11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARV4i039234;
	Mon, 22 Jul 2024 11:50:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29pka80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6TU0q53IXtaS8zreDnz28YEM08QjOo8w/x4xv/bsv4eCrGYkPrYe0VhwuDAmFj9z0qpwYvr3mlSvXI54aFd1SqnMyvO+lsiqv23KbBhAXJ1j0AAPomqxISF9BhNvBi9rbFaq3rVka/4nXVAS62k31ETL337Ygr2UhzFXJLNgP9CDIvF20XKfqrE6gDUBVQNyoZRrZijctMUk0M3FkLGaJNh24DvVdq+ktNROScDX5AqaWjBQ+c7f247Rz52pGYkV4rigeS7qF0RF+RsgewFVLjmGJ80dxeJQby7OpfqeuguCRb+hEDcM9d6xhCIQqBiAzBvoESvT2j24ug/HZg3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVjITTBjDNa4l4ig8Wdby7roD6jAwlZCu3WT1v2W5A0=;
 b=w+wTz27q3RS8ovjS0EOTxoJCvO91SsZcaKNcOm4Mmk92eKVcn17TntqZXQZ1rC/b97yqypqBRA9oXov/XyeRsEretCAaCV9ZzNBQawjB/YymqRn3HslvIbT/zLGOXi7iTe1LQxx3rOKYnIwdbrgReDtZbKnEpuR5dZR7k5yU4V6KaLjR7EyFpXlofd98PeRKL2KdhOXmRNhSvYmzioIMbFQGU+UoWkYFxzIwWEWvUx0yJE5Dfq4hvfUnJ6RCtl65eC5KSxQ25OBF1irc+r54/fe54qgRbaFOR/HARkDTAtC781xT6bqpeTN6sCopjRoeKLvbGNHOf2jLp0NbmCTa3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVjITTBjDNa4l4ig8Wdby7roD6jAwlZCu3WT1v2W5A0=;
 b=YM6GkthBSbJ83yqF2OCSEPWxCJHHJU76OTjDW49pKnko5KBqv0g8KVtRKwoZPZV+KRmunkUyGKmmBN9br5uJxoROofX1PMrISLLNLVhuwYQPU4Q+JQZykUf1Rt0L8vsM0Y0WmM4gWCSLwV7pXOaqVrFe5E5GP0ngzJJgKCN4D7k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v3 2/7] mm: move vma_modify() and helpers to internal header
Date: Mon, 22 Jul 2024 12:50:20 +0100
Message-ID: <4fbcf354df31e90e41242724cb7cf1c56ab7f50a.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: e3291491-20c0-47b6-9b7f-08dcaa44829f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbqSxuQQ0xFHN4fq/I7vSrLPWBOWVit/8slGfUw3ZPPAW7MrpDssiapr+Cu+?=
 =?us-ascii?Q?AXZUhjbNKdOeuC4aqCqXDFRqKs/4VMjwwK7IaplJjmajE5M/EZBM4IUVkknN?=
 =?us-ascii?Q?zaulhugdq6S72MaS79+gqg5cYcqQNYopErNHcvWh/7t8iB/Fi3dvSo/TJBPa?=
 =?us-ascii?Q?HOa4WCdN+278XqdT5ydIdIBlB2mOUi6nOKwtoLxNrp6us9JJwrZss5UXRsxp?=
 =?us-ascii?Q?vxrPdTcRqkTMo5eleH5rz1g0ARZXbSNq38iilugS4gHk/omzI8MDRQsVGt7N?=
 =?us-ascii?Q?fJDpIbTZzoPRONKmaof9ls15S/xuq5nBhG21+KlwFz6Lf7x9LZqzpe9PSbFE?=
 =?us-ascii?Q?d1VhR/wxcNc/At/FGMXIYykAWXEKkSkrH55B+/aK4DUfhEj1ia9KnhuRjuRC?=
 =?us-ascii?Q?Li+0bsdGaihcQ0+KdIp0RF6GOEtcGHi/GApz4YctUxi6bVAMQS5L2HFadjIf?=
 =?us-ascii?Q?JSGiV60A682F7+6X9JwqJPMCFqja7mqkI0TnViTQL8QEKu7el2RZ/dFRo7hn?=
 =?us-ascii?Q?meMD2MHFUFxoHGIcf3oevNTjS/bHoE+deXdP/eo0pXeTKL1meCC5LPDgUe9u?=
 =?us-ascii?Q?bq6RtzjGSTTm3fQJr2B55W+Dl3nDO6s2hjlmb7TaG4UmNNgGx6EwPXBoDyFU?=
 =?us-ascii?Q?T3sUAoM1Awq1FzzUijUlQYaMl/kSxBjsR1HROPKI1F0i6D+QPMSoRY8H25k+?=
 =?us-ascii?Q?9rWVSNqWHOMXrJC/SWBl8sjgzF0cWAyy6axSHcCMBtUR/ap9iJW9GjVXUE8s?=
 =?us-ascii?Q?bipnk+dRcIu1kh6oTVLg7/uoJ+q6IrrsoQfz5cEDUExwEi6hiuz0/ZrAFlT0?=
 =?us-ascii?Q?3FKQtFjpprgs/4tZMPbFBP5SaswZ2mB/4hZM2Yw643DnoQiJdOuKfvgP9HPU?=
 =?us-ascii?Q?pb7cOm/mwrCKqp0kPK8CPhLunTINT5RZ/5SZkeT363+54k6ER88ZH1qdIO4f?=
 =?us-ascii?Q?Zb8YLIjheABOr1SKuqiWeKxzMAvcxbasipd6zEtgAoLbbMY7Lx9GXxXS9gKl?=
 =?us-ascii?Q?lFe0Adgma6N/dp/nWO7Z68YFutypa4b2LRC2UAF8lAd8CtzRJCE/OcpcDEvF?=
 =?us-ascii?Q?koTQ0gYY84Ft8l+yHt7FeHG4fpQ/+ydnAcQ7Sr0yxs6ZG/LP1+6VDpb/BjDR?=
 =?us-ascii?Q?HaiYsmz4scwLqnIk3mOQmzbzpuU8i5gpAdvY3UV+LFmTJKzDBKtcp4KXWCqB?=
 =?us-ascii?Q?hoOOX8yE/E7gMnXJquGkWrizT+vu/dQP+tykmsubviFEZGQeOmnwag3U0i4V?=
 =?us-ascii?Q?j6EGjfQrdedCEqLHHztZwGRHMINEDjufq72vbI8PH2BXexnESU6Ona8gmIvP?=
 =?us-ascii?Q?S2j1VJPyc06Kpvqb5ONgKjFwqJOpNUQAz8uGqEGFvTdFlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3V8oEOku2ZIcn8D9cCh+HqKPgiAP0EdAk355lc1HnnhZ2NfCOBCnnd1s2gpP?=
 =?us-ascii?Q?uKz52ZKNeO9EkiXUL+QWEsDCmAFfp+oP50n22lTPb5bmTubpoPLYWmtZbMuY?=
 =?us-ascii?Q?WefaDXeqSRNEkE2mfKXFoJc2tvl0jDtzvtygErMsb3uuSk66GgiyYKUld1ay?=
 =?us-ascii?Q?KKYeEqj/v9PQoI9a4/yehfreURLex47J1e0ZyeAXdy+ybnIHbOYZO0EpPytv?=
 =?us-ascii?Q?wGY+C0CteVg4VyBVI1xVtU9Ju3oDOxVeRPa2u66iiU0COzEfqeVIW6LYn4dw?=
 =?us-ascii?Q?JN+DKevmsnYW8UUM0bD7mpKJQZBJRKFylYG/t8jDMkmZrMlskJGg4/v5yUmt?=
 =?us-ascii?Q?ZyxB4EH8A4QUVJJLAUaVpZxu1NujMOTnKjngmQkyn3qZvUlzjmRO/XanSM/A?=
 =?us-ascii?Q?X4jXYAErYM0WJBnlkipO2Z1lJOjbXo3HADMVszbS8Hyn/lq2eM/KVQ2H4ZtU?=
 =?us-ascii?Q?b83mTlPgKWXt7EE61HCp6CLJakkXfI5WWxJIxvmrrIJGdyhjRF5xsm+x3arp?=
 =?us-ascii?Q?MKWRqKaEA38hgYhETKm6pZ9GikXdtHFhiOGsvNlwK6O7O0h6JyZW299MuLS2?=
 =?us-ascii?Q?I8iHXh5HhomKY0pKWTgrCAVoQE79+PfVv1Cb7XD33RCK1gZ2kB+E9D0gbWPl?=
 =?us-ascii?Q?eDCB+OJ9RzTfvOh+PjEq23VNRXKM9hmGqOBin/wtQZrgFJqDCJTHqMZZjnok?=
 =?us-ascii?Q?f4Oi1G3uVafojuKnfnji+b8MadPcJI1ITSn9sWXW4ea5XnIg6T7tWyzZBGO7?=
 =?us-ascii?Q?6DMQT+M1/ps0Gmg3REj3HJ2M/B7lrg0X6dwlPry5d6VTgNP+uWVrQOjvK6/V?=
 =?us-ascii?Q?btFTpHW9ka/qSG8dlbOH3Y+xoRIYMKc3gVHPDBY/E9LwWvdZ2qQgLq2yub79?=
 =?us-ascii?Q?U510fO7f3h9q8ZRMtb3zO5PQy1hmadOVUnLt1C0StzAkbb0zoauqzOtdcRcf?=
 =?us-ascii?Q?dVst15iYBG1FPJpjv/wE2gnLy/1LebgE9BNQK3D8svhBx8RsAe3P6NxLttlW?=
 =?us-ascii?Q?QZ0ay0sievIHy5ndEwFQSVZnHKM55PO7R9emhFcEYR8GUYnQpYkSU5LOkMK5?=
 =?us-ascii?Q?iM53YhfejGCMUcFQBu2scvHNRGJrvIOswR8syTWwdpBLMhpvgdBqGPyNvdAs?=
 =?us-ascii?Q?26U0X454o8PqHrQelX2naj8gfRlky2dxUUIxYZSGavSsIVA1tQv19gVU0ftn?=
 =?us-ascii?Q?xvxHddsQWtMkq636IJctF+U7G91O105FtQwYpskXOZbo/HyfXNuxLjUDvKYc?=
 =?us-ascii?Q?i7kU0N93/84a4R0gNs/0BZj3vp5Z6H6G2Rb8XeNdPufOj1BpBwAenwThWZaH?=
 =?us-ascii?Q?q+i9i2uF+HtrS08EgY58BLnJaHwMo4ixrIdmmOBqgGwKmNM9On011xPQeEea?=
 =?us-ascii?Q?Vr1Bkd86Dg0vQUeqci3hncuEPt6WCwgzFweKsB7FRKRmsHGy101M578/bMwd?=
 =?us-ascii?Q?BlCDxca07FVWjT0OA4zeXn6QMxfjlIzUFxbEFDfr6VRhsN09ek8ReF31yKat?=
 =?us-ascii?Q?jO1nNqSqQkW+Yv150rVYB9FOuNE57gtA6KuLO9Qeu6nwwNVV/BRaZ3rIDuSk?=
 =?us-ascii?Q?qi2l951Q12E4h6PXg1wovCMYmgS+o1VjiSgtfyUFBbyoJtk3h6n9gflrpwkS?=
 =?us-ascii?Q?jV7VCkccX5zidXc0LURWodbMCzB9/TePIUz0tBrQzzuudho+HU22560BFK/e?=
 =?us-ascii?Q?tf0kxA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BKetl9y3k2K8jvYyuCo5/U8ePkgm6GulISWF55C6j1RxnbcUpAMLBgc7+ooAoTTq+6DtfCzIHE4btVB3i5mwW/Lw9OzgGabbqAizgRpCFYxzFv5ZDun0AnxQlWbAmhuf8+gnEsEcqWUxtlU39Jqt2wweQQ8Bv9kE2XcvtW5yk4oLlex1UHKTDWFjypGNz9cN2p9c9E5bGNaRi1g7txpElhTEm41AnpLJGBvT9EvFuWfzvKtaRibVNDgPIlMaiFgJ0nInKX6JaQ6toOsuZdpVa6rJScdklseplDMGFRuhAOrxLyt0BVxmnqBTq0qBQlbHTiGI50zef6xURhWyOyXtDIKNYxTJSweFCoE9arOe+E1ufnRmiQQR3WrJHTeAG2wnnjmjtAE+slRAouf/DreOdVTiTAtO59QchrjSvH3P1e0JtdUQrHxnxn8y6OcE+XLjMGRFfY4QfS0WBam2wFzp7WceJT6OPkuOnsyevAmMtd26/CAuNbpEq/o1zLGYqAPCqzcqydrnyBxcWhsd/cjcEeMvhDMIctQ2slT4f6diT/VNuxJ9X9BoIwIIzMdMnAWs3bPSejms6wP7Krl16VTai6TatonYejB0bzXp6WdbY08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3291491-20c0-47b6-9b7f-08dcaa44829f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:40.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrl1KnngOd0f0F3aR3MjnFHsw2eRx2uqHMf0fWZOIJSRPfMeDAL3cgP46L0MjOsLG6ulgwhSAszrgQ5J9teAc4Q6BW6aS/Ry6dHlibdVrD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: QMiFFZ-6ExUjBhtCA59eeJGdaJIyZ2iA
X-Proofpoint-ORIG-GUID: QMiFFZ-6ExUjBhtCA59eeJGdaJIyZ2iA

These are core VMA manipulation functions which invoke VMA splitting and
merging and should not be directly accessed from outside of mm/.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 60 ---------------------------------------------
 mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d044e737dba..f02532838f42 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..81564ce0f9e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);
 
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
-- 
2.45.2


