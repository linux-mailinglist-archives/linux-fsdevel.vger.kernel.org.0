Return-Path: <linux-fsdevel+bounces-32098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3909A06F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA031C26A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C32071E5;
	Wed, 16 Oct 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxKoo3cS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K26Mndjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE9206E9D;
	Wed, 16 Oct 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074064; cv=fail; b=FFvn09VsN8g7lwzrPQCHEDBbJ+EejoB67Oj1WtUGGmPBM3QHzWJFKae0JUPHM7o7TPj1Wezs5Qk6Po0p9MrhWyt1QWrRprQl0T45iHy1408gXsC+ZOWZ+YjcUBKzdNJLBkQCt7jOuYAqhYBdF/Ib1X4WmedRbkJa6Zz4sdoMMp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074064; c=relaxed/simple;
	bh=sHG+NL6SiICmhySDopX0nirslObGKD3KKnsfmat1bzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sRb+GTipMrYc6xEY0TFTUt9e/VMTn9KNX1G48BNBjD2YAjN2wY2aGr4piGIIziwUnvq/AnCA/NviK1K9KIAlr/2inWHf0OC7kM1K9ooSmxTPrBSFJ5+lkb4wFM++kBzxMfxeu0lhPU0VXhVFQBQszjLptGOZftKB67F/0PotjDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KxKoo3cS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K26Mndjd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tdpR001094;
	Wed, 16 Oct 2024 10:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JHJgtDsWIsDsEYWeq5BH9WNV9u/wLw2axBkIj7l9KrU=; b=
	KxKoo3cSivDumOMk1/twXMM6lUKRh/h5XEesTLxhYjDpjg1O+agHRvRj5NCMfm/h
	9X3ln9XQHhFKJmheqE1BENB+OJw63+DnujiPfvUm1j4hjyqYuhtdAd5zVzQohwha
	OitD8pUC6THcuOsL9761B/PqxS0V1nfdGpyHdrl2zdVeCDGDc1rqYPeBv/wDR3vV
	Bvp4w0yGShPOpWli0mOW9Y1u2V+XUtBLhLOiGRNMhs7sQNnvMpqy5TtKipGH4+7w
	OJga0+LIJL895/Fu80rZ9OFeF8Jh93IPOsoQWr2ZvvVy3ju4PNB1ohekFXi1OOWK
	MquTTEBGJohGXf/9W1GaoQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ckqms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8hKuJ019983;
	Wed, 16 Oct 2024 10:20:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8naje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+JYv9guearlTL7SVwq+v5/g2KKRCyuC9DswEnIJfWrX2OVd87hqELPX9eZgc9dJtaydMX0kGhBFyKDWakHzwUyTiAEA00Yz/EJhuxMQnC98mDpCht+YcIwnaDrMOd/3qF1t/jhK+bZ3S7ujqyOtcInXdEsoC0sWAsAyivnhI3ObxikT1kxNcFrE9diFCrnMrEn2AaD95zwSVc1qh/Cjx15QVPqWSHWCDyWD1pdYdQ3abIz+A1BMINlOwmceFZ+W7FpLg9fLRMGelTZKdr0DCaL907A4KX3cXqtvSKha3ardBZo/1tpCs3x9VkDILTpL/WTi6tXq/nSPQdH0o3gHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHJgtDsWIsDsEYWeq5BH9WNV9u/wLw2axBkIj7l9KrU=;
 b=Vukgd+/p437s3+d3TQCYVexjCGgw/L/UJOiEkC8zKYXp6WWDq7JZxEQkOJ9dp7pt9YxcGsEx4I1TwUarbGni0Dl/58vP8CtUuYEk/fVrRQegTQItcP6TzNdtiXGMcnp3AVEUv0rUDAHscEIjcZC8/mp8Kqgqbk9fTEvJnBZjPpXiqukoR1cmTUZZEbXz9e7IlYI6ZMhe0mzCYG22a5jIa7Cd5EAMqmSdfxRnCG6DaEAd2lUv8mRyz6n7bOsgV5L1o5WLHyBIZLlD/FN/+Ea/3WjtYR5pudM24lftqCJxP8CnY1EndDoMpbbbJllISuic76qDnj778jCArsaaFJwWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHJgtDsWIsDsEYWeq5BH9WNV9u/wLw2axBkIj7l9KrU=;
 b=K26Mndjd5pXcZSwcsIYsrE1HUSRQbNRj+AwR6HHMAPwvAG2NpEQe7bva5FQCybGVkd90VZRTCcHkWyLl1H/hLtUe7GI3KlI+11ahIzvl44NKiNX/fApkPDQoyFUtRRMpZ1n5LslnDWWOwvQ3nyNS6WhnzuLwQ0KZKJbJxYZlcAk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:20:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:20:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Wed, 16 Oct 2024 11:20:37 +0100
Message-ID: <308d25458297a859e514132dfbe5c28a338ba63d.1729073310.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: c597b00e-a428-4853-1af1-08dcedcc331a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATKJ3BIUWRe7MMAq+ZtmnrsQ0LJdLUX88zBAHoOlaZe9+5/MKTa8v4y3jWe4?=
 =?us-ascii?Q?5CSfTp+UgzuXJRp90iYubbb4mNkRt3HLXpIl/mqm2MYJzwr8mchuRcmT33QR?=
 =?us-ascii?Q?b0fX5r/umXbSxBY1zrlNzsr0DBmgj51opIQUH4UEQwinogSQbsQwDVBR1oCS?=
 =?us-ascii?Q?+aPKP7TgdeEfWzgSkSwaT5d6WOL9tidUGA00ONdpEDL3R06BvAbKLF55wuzG?=
 =?us-ascii?Q?suLqf2DsYMGOGPZgxRKYR+iISqFHqx4PAt0Azxhpr3vQaLdgww7rP2m80D+L?=
 =?us-ascii?Q?XodclfQCEh0I64IIL1tm+T1di73174XMkMr45iWeY0UZYVTdRbySqWyXfBTD?=
 =?us-ascii?Q?w+H88JIgeesvwNLhAwoE7Iy6hFv0q+/G+R59G5QrkET9bLxDJLf+H1GIcmvx?=
 =?us-ascii?Q?ErhsQSvwHfGSME61rBPbCxFSyix3d1l2gGPmKU7iDb5Gw3RUl5k4NSBRP/t6?=
 =?us-ascii?Q?sNs8l/PVShyxUQC9RS+eQ9Mu8BAODomC/qd9Vba9aJRGsh8BngkmDwl8iOMY?=
 =?us-ascii?Q?e8gjQLd01ulkwuMTfssSjTOBl0oEPmUkdE6r3tqtcMqYFKhmItANAyfxGTmj?=
 =?us-ascii?Q?qL3BjP6VscXpVPa++dCxdPwYFONf4B+bXjyvMygO03scDbxGeY7ipj2sMIUw?=
 =?us-ascii?Q?QFCD08MyXLInM+sfNJm0ru2WGV+9qzNSghBdcl/Zy6zPMJmV5aaw7NdTL0vt?=
 =?us-ascii?Q?VKeVOT3Fa9lTaL5gVA2BIICCq00fF0JRpXz6TNp+RR1/6nyt5XXDMiAOO07z?=
 =?us-ascii?Q?6r+UWLZwR53qgcj2YKAXb5Md9BDQ6VA2FFEW+kl5HqVMe2KaoL8opssMwcbJ?=
 =?us-ascii?Q?JQIv8ILPGGlHK8jX4BmRmlzWmZHEAZD1S1Tc7r5V7vptFzFi2tbGDP1vpq6D?=
 =?us-ascii?Q?HZ6hd8RDNvXSwOQnQJ2jvueVOxJ3DGdatoUgUa0Ir0/YnwNEX0kT6gFgC9MD?=
 =?us-ascii?Q?EYtDErsm3V4YrExuxAwG75atcRirf36LCYE9fLF+K/ZdepVanN8U/UbGSxwZ?=
 =?us-ascii?Q?k5iJI1p01UkS9uJaeZoD0zloe9PgSMFEtE9UHSqPGZZinvpMDuLIzBcM8QAL?=
 =?us-ascii?Q?NnPUkXlIChvd4AsemBUffFxvdiE1vA8w6UQB1vQsHG7GRzqztyhzicgOIpX3?=
 =?us-ascii?Q?mL8iHKP7gCPIeO7ldzzMvdSDtHR23efMxPZlbGcP9dDdxEpXGt258eN2xWjj?=
 =?us-ascii?Q?fgdFiRmc9bgRkhRAmihzZKYwxjkIzgb9xUDXb6HvzxxIhbCKqhq4MPfHUgxa?=
 =?us-ascii?Q?XYvrQnQhuzTXgxdJHEljB4aI5Mx9cLP8GpRurFKjXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?awlMvH82YoA5zBti/3uL6PG+/j75pS2+0DVC31Hz6VXFFhyqhlO9o55W6M+2?=
 =?us-ascii?Q?x4S5wSMOO0E2di/y6M5HfcyQklHdK88iaFOEyK8h4XWVksi8cczKsDVLEKUt?=
 =?us-ascii?Q?5HBHL0YVbnABnPn3+9o/ZTXnFpnTW0FC2OwkM2FLZstCalJld6Es2FTZEE0K?=
 =?us-ascii?Q?z26rmUZYWqr0PvvdSjgGkDTtV6HtoACzqgRfeogKHimZANKfESDUDFNdF+Cx?=
 =?us-ascii?Q?tKrh8H3GExVUCbqwzf/JeqyPtH4+hD+1YinONYlGmfFUqBQogqxIbxJ9NRwM?=
 =?us-ascii?Q?xq8GkZXuKf2C/FOai+BP6TcwjLirIrqPwZYgUerVuupCMipBYz8f0F6pRFab?=
 =?us-ascii?Q?DPmjfE964zCYN86jmXJzsI6eCBkXz7aqupg26E1cX3DLpF6cMUV5ofgOEDSU?=
 =?us-ascii?Q?/ONlFP/ShOoMQTtZmKQbR5hX25gOtGKZro18bOKhM7yP6BruZWsArR94T/ig?=
 =?us-ascii?Q?ValEavAvZklukvbpScG+oGDXH0hQy5edcoz6MYO0ujeA28uP0orOtCeKfhRC?=
 =?us-ascii?Q?Ay7Usn3Vk4GUw5oCEseZqf/9EwJxMmoz/WL6O5UxucLqypQDNspeUg7TEbf6?=
 =?us-ascii?Q?9ytPDeAjyMK29dpLBwIkvYhv2UYIPp9b4tjFKTS+mEg/Ah22+Cnhf4x/Yq+e?=
 =?us-ascii?Q?kLSWUdBUeycYOwIOIaqdIcBFWrLEyCURwCff8a9TOcLxwexo8gW+rYWtEGyv?=
 =?us-ascii?Q?RQ2fxpLp8gBRNHb4SMvlrkOT/MOu3TvI+6wlJ9t9P/jsMlIxUKt1GW9BM4di?=
 =?us-ascii?Q?anYiLNMw+3Vg3pvthBRo+o7tsg+ok77tGa2TL2T9iXRRzin+nOX1pvaQRa2e?=
 =?us-ascii?Q?LoYiTF8/RQNvviFLTQFJ6LpT5SSa/SCurQEpzWe3pzDeTvugOmERt9Z1wVco?=
 =?us-ascii?Q?ddd0EpNomSCU07kYrv9BHQFXR5a0DvvN5vyuvuivOvtnyVEMHkuYLg5AiNss?=
 =?us-ascii?Q?gaLkuDD3Qnt1S212VuPW6eLvkusB1Bn2KVr/yv2Og2/pmh8jWym4yx5w5fCz?=
 =?us-ascii?Q?XP0T/OBKHStMr6j8nJRkQNved5agwHsp0ELF4rd5AqfoQXG/lARhWCNsb6TO?=
 =?us-ascii?Q?xs1XX+KJBd4KKpA+DWxSs/qGT/Gv47A3Q+TEEhLHRMtWivijbptoZ2Ct32Ll?=
 =?us-ascii?Q?2F1uTnMiF0Y5KYHIeJjTVrMGxDOW7QX5dpTjVxB9KrtdqSizI5y9fUIh4AyU?=
 =?us-ascii?Q?pp6oUSK/IkIyQX19fQhp2y25larD6s4zP1EQZlnscul42kffNvDCl6qBigGz?=
 =?us-ascii?Q?fOGJi6rHU1GgKLFBECDFUQPt2Mxosnh2g68W/EnNbm8AFSRxhhNKtufVeNrU?=
 =?us-ascii?Q?rK76IyM5QTO7isFrEQ3j873E8BDNZa+q/+VwBrDc4rK0bsVSwBW8HBkaJ/R2?=
 =?us-ascii?Q?3STkklaLrMHiCuimeCk27xdrKrC9yfMD4hS5eU6i6d/5cLHOLzc8i77qkKvg?=
 =?us-ascii?Q?jJlPAPov/3M0RK4tN7yzFr9EWL2jGXairXkN1+BWAYrtn4TT27NPKJm1qJ5v?=
 =?us-ascii?Q?m3yWCOuYCuahCtseQaUmOnZjv00vQty/kaDx9Q+osd8FZyWiXNwdb04hnHRI?=
 =?us-ascii?Q?Hx9BHGWn9HlssCOc71aYz0bkDD1xjd//9VbqPjvvlLHuFXoJLkZ4Qm+P9S9L?=
 =?us-ascii?Q?RYeoGRke07Z6O/35cIDp7zM9dtYepR3Fo3OQxfa7AQOJdbOXNPbB+Bb4LXup?=
 =?us-ascii?Q?cjE9AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c748uBcxPmK4+ky1qNX4TfJFKW1YgsDo54FrLxbV1v3ke13zjsazE6Y7REO37lu6FLe2aHLNAKATLR5Aj0dwc3f3jCv0Lpcp2QLB1tdVC3kcANvguX2xxHVvNFNQ13reIikzQJylcLHeTHJXc4VLKrx/ZWaWMXve/XN77DQTRW+zjiZkSb1xhHqYoFUrlhrZxtvO2g9eVSrn2DRJVzumlE0HtpEhDfFPx2feiPeuw3CmK2ygOPq5i9AaZcU5US95jLahrHrlSU/YxC25mBdRuXSYr9WyiJEsdAsNVCvea32CkJhViuObHd13+aOv0EtCMnlM51dPPY+vhoauoFmechrIAr4u4DPYQygPHZJWbPfQyfGnuc2nW0wuWbGI5q5KOwYI3KfdOuhlcp3zKXdhiCUc8a1dJXgIIeSJdQ9GC1rRfWM5jv/j8JvUIhDqk8yUCt22dCfp4gv9dT0WDCU+yXkr7mjCYyZj1HSvQAlyH6Wuywhtx7O26c46qKf0avdrK1Wd9KFli+BRsp7ypwrAZHDowjmhXvaqFU35RLEBbj3drBrITEQOAKeCAo6ilutNpg84LiSw0sL04QgyicesFt40P596y0EWf++gakFxkOc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c597b00e-a428-4853-1af1-08dcedcc331a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:20:46.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHLtQlUSDWpukzs9fGPZaEAgnHtBIyWmf01s3sF4ze0KmDbvvlR0MVpYvesiHTToupa4nc+ErDSZTLWCRvcCvU1gFZ49gH48H1d15lhnuwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_08,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160064
X-Proofpoint-ORIG-GUID: Zjm7jSMIl3mRK6LCXShV_4m-KTrK6dDf
X-Proofpoint-GUID: Zjm7jSMIl3mRK6LCXShV_4m-KTrK6dDf

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which abstracts both approaches and provide
optional output parameters for file->f_flags and the fd (the latter of
which, if provided, prevents the function from decrementing the fd's
refernce count).

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
 kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
 kernel/signal.c     | 26 ++++----------------
 3 files changed, 85 insertions(+), 41 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..68b02eab7509 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @pin_pid:    If set, then the reference counter of the returned pid is
+ *              incremented. If not set, then @fd should be provided to pin the
+ *              pidfd.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ * @fd:         Output variable, if non-NULL, then the pidfd reference will
+ *              remain elevated and the caller will need to decrement it
+ *              themselves.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
+			       /* allow_proc = */ false,
+			       flags, /* fd = */ NULL);
+}
+
+static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
+					    unsigned int *flags,
+					    struct fd *fd)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
+			       /* allow_proc = */ true,
+			       flags, fd);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..25cc1c36a1b1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd)
 {
-	struct fd f;
+	struct file *file;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	file = fd_file(f);
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
-	fdput(f);
+	if (pin_pid)
+		get_pid(pid);
+	else
+		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
+
+	if (flags)
+		*flags = file->f_flags;
+
+	/*
+	 * If the user provides an fd output then it will handle decrementing
+	 * its reference counter.
+	 */
+	if (fd)
+		*fd = f;
+	else
+		/* Otherwise we release it. */
+		fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +772,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..e64da346a90b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3912,6 +3901,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,16 +3911,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	pid = pidfd_to_pid_proc(pidfd, &f_flags, &f);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
@@ -3939,7 +3923,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
-- 
2.46.2


