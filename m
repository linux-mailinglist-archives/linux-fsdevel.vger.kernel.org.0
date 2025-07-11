Return-Path: <linux-fsdevel+bounces-54626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939FB01AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3680C76646C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0D2C08D7;
	Fri, 11 Jul 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kT4kxRe1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XTZ063DV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32D2BE7B6;
	Fri, 11 Jul 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234003; cv=fail; b=HVgZtuclNpqy6VIqG2wrGlHvDH8h+qNMIhWji6gGhef+lg3ZDP/qRQXf5Qyo8T+yd6MNMcF9LcZctziRc40cpcGiqxtjzlEoaoz6ugZMK2aCs18FU/NMNZQdMZYbSZUZI2ynix1J/eEKKMLmULUJ72RlR/KGwEZJwbKkLiQegCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234003; c=relaxed/simple;
	bh=KkOGjKdq2IJKxxmFZySovX7PfYXzZ29GwuKJbFX2uVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DhzrtSdzSZsNhvQlmbMp5LNsIZf9ocMw/yDU95XWlS1Ttp4DuVn4inDzCUjrQNwrHq4IRliTAqTWpf4JN4Z7XozFpLI4V7LV9gjGOuzaH2vR3bQeRyZ3t7fUm2+wS4CFN/a5B8Li+nWAwPofKHuQLhjHOBcisite/8rIvOTSr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kT4kxRe1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XTZ063DV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBMBki007627;
	Fri, 11 Jul 2025 11:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=; b=
	kT4kxRe1FDh2CzZWbDdv2bNaQzMLvKhp/agSVHzYXFMECkO9fYJekUq77esl/DlB
	TzY/S4R7T3WmZlhWsiFadHkhWkpCoJcLdDXMYki7c7+D+lYuP1t731CBRMYk9ifG
	x3SRFUlpnXsctu2ylCXS4uOcFWMLZsVMhoctNef+RiTKXQDL5nf2ESL/PkAP7NoX
	92Y8DraK91rkhpG6JyOq+5A9UB9gmTG1n6wbPt26ld0YaotDDTStGW4JWmpqRTCD
	SRRP/yYWw+MYM9w8NI8nRDoFFOP3aLva/ZazLdqMnXUi+Xb5JLYJzCKN3nDWk/Vx
	ejVupLZKZVU29p42LT10oA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1p200kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9exme024212;
	Fri, 11 Jul 2025 11:38:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qql8mh38hhGIDXEgKKBQb/rcAfa1jRNxsS97c5euDLhEwSxiLUO3Iqqkv0WorMPIbzKVfkffAb9Jy+SDhCFSaWoG6NTQuD+zLHVJdSLA8dz0pRFLzEEd+ZR40UtGyjjd3kScP99wnzPfBVbj+GjkTN88ImfKqNh32wbsv2chcOJS4qtA9zPoQzxRGyupPjKD6l11WJZfyzk53pjvxTaqHD0xW4V1uHc9pLfHQkw6PUzyO5Y6cqNYpOIQPuV0hOhvu86Wc/UMPV/alQsalAw9MdeMBghgxI/ps7fKjk0mjjbsTWTD3IrRMtmdHcKvH8sNYwqwlQlwFPlTIkOhHuQR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=;
 b=FKx1otjyI5yyWFQtoSRIBuq+ru3AoNBTDGYMvLIxPT0fH7hZySb1kK7HXwOJK9+a5Bva9KhmH7cG1Kl01isKqA5BbS6mN6Nkp+fNGc5+fIuzWgFl92YrBXH9vjZQmpsJtNccQR7TRe9zkqwjChz+J4V9hpwzGt5e7uHGrIycyBS3sztUxsbV9CaPmOpbgxtbukZaqRyp4KLMZV/mpCf5kVVNqG44jdEzyFMB94J7u5jXt8BxMWaHstNme/It3T0pGA62XamHN7tUdsF01otxI8MidXYPAYeCdWB7AxQBEUUCdWw47/Efa1fDm26wdnIHU7uQogacn98Jn4NIauX2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=;
 b=XTZ063DVlSQrwJtvIYMblBG+CSw/WTHp1H+1/vU7+zy8qEqNn57eHSus8d90jGbgqvSdzE4bID9GFVBgYE8HV6yivH7tUHfLw0pwPm76mXntAJx2XlgrvKmijNPQ8eUJgrPJajQG5sdI0ofVGKiEmh+fQNtYlZS5StjFam1GNoM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:43 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 06/10] mm/mremap: check remap conditions earlier
Date: Fri, 11 Jul 2025 12:38:20 +0100
Message-ID: <ffa58050a544e0a8b9077f24d238cbdbba9c1858.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0696.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 507cbc3e-cbf9-4de4-7b4e-08ddc06f7cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HR5AivZzz4R+O59GT8cKf4xTERIc2NfwX0N+u+Ag0BfQ7l/9vO6V5nmzqT3h?=
 =?us-ascii?Q?hVVtBhZzf/AGrc8bb0J+cczLe7CVq40j9Bjq/IqHgPzFIOo2latNvyYBSWv0?=
 =?us-ascii?Q?IFzB9XhgpdxSSDY+Kr6sSXApaVj2D9gakTpF1KGP59u0gWpnRxMSTuN9cZzC?=
 =?us-ascii?Q?Tds4P7pXf3LnCZEisv88oohmDho4KqgI1YnVZY4LJ3dBPMOGBqY/l+8/mK0i?=
 =?us-ascii?Q?xltS7cqfRWEWq+qkObk9cmYcHS0WBEs5j1p+v5L4cDX1ZrCjOoX6CtWU+fId?=
 =?us-ascii?Q?4pbVWIByGszJZcCGDESAM6XE+RUO5SmX6J+6Qv2hGS3BdVPUzWnQaLetUU4C?=
 =?us-ascii?Q?8DQWb2L0rPo1jZphpBqY2qrtPvKSqVFshp5wSBbBP37FVBvoJLqbodz5rQIY?=
 =?us-ascii?Q?rMLHHehU4n4PaEYHc+7BGnXDvcd8ZKjwkQxazNuJUsqC+DubEnsHC99NqyEy?=
 =?us-ascii?Q?ZqV0q5n9vioyMt78kS4OzS5pCABlrsyUl+Hk8NSZFWN4dyMtlHCRdzN1I9/2?=
 =?us-ascii?Q?1wg1e72pUBqWDphLp7uBuoAunr8CkQdM96atRtqUQ70FJqO9VJujG6uLw7bx?=
 =?us-ascii?Q?5SzdfeS0we/XnkCIPNJUg3NrhOoiKNsBtbGjgyXrSXYBFMRU7hyLDaaJ+43o?=
 =?us-ascii?Q?B8PJRlfYHbkL9q8TiKVxstSHkrdRpeA0nsyexubrZpQRGduKwV6rehcVKJiX?=
 =?us-ascii?Q?zKVyN5wXQrJuYvIlGmdvG+tnBAeekuLyVQk0xsNw9nHNGvrvmgJY5BZjbRHl?=
 =?us-ascii?Q?Dbf7+eY2yIsBxZ7EXVDJ/GAQnXo6OXzfv9XZjenRrN5Qow11eW+YLnKaUqkk?=
 =?us-ascii?Q?wjyZMadvPnlQUSR4VrbghWXVjzqua65sv3IBHj+xJkDPTfC9OdbkReJuOUuH?=
 =?us-ascii?Q?tXiGBFpdDTxFC/XqUKmyPWmv8TeM6Bshi8F41dTLGjFuDAAlNhh1z9y84Z+M?=
 =?us-ascii?Q?fCBw/NyHkssqbLMXsWaWxK8XsHQUzeP5tSEGYWDYCj2YP9sbOUqS2O1Xpzqb?=
 =?us-ascii?Q?JQV3Z8ukVdprHecKqMN+nba6vulCH0Re8Pdusp7LambAS8uyF7QsTOTTPmUa?=
 =?us-ascii?Q?iz280Cje98gEh44fQMol7IHHPxdZdziTAz7I0rvy3B7clvlRpmJOMe81fCz7?=
 =?us-ascii?Q?uAJ2F16Mt7fBqE/KZIZGPOahaYMOVp9Gm4OIv1An6hnovGSHG/9azV8e1ofZ?=
 =?us-ascii?Q?XCNvEwogiU1zgo/v+RFvER0eUOo/xFS+g4of+n6pvQCCuSnZ5jMQDyybqQQQ?=
 =?us-ascii?Q?LwFnGIhPuy2NZy35rGgxDmK721bUWH5DUEFVDS1lYnxqowrdUxJMn02b39Fc?=
 =?us-ascii?Q?BkXBxmWdSU6q2MJb7xfvJu2ird//zVflbkndfA7twTqTE/dE1w8/6bwQzgnz?=
 =?us-ascii?Q?MvuwavpdbSdHDwESoRhuuUFPcMzztoSDNfb2fBSZqEjsThvv0cPmBE5H38QI?=
 =?us-ascii?Q?Jdqlc0/yeeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwMO1HhTg176tEKPfc3mWBESN+j7ZzXj8JxB/Nlv1a1+paJOyw1YQ+v4nnxZ?=
 =?us-ascii?Q?RElsiKdWzNNRQGrvMjiNBImiv8LJdrLKJpwLRnu+QQUnw2ip6Su61dtKdNm2?=
 =?us-ascii?Q?eZKasBGo+J7MpTvfCxXcTOFCKCXzGrTEb0WBiZg0rLdASvARtCPnpq1rsej9?=
 =?us-ascii?Q?+CcnCAzm3mDkbcI88DdTkp8zUn9RRw4nJlB0JAPKBkKEguvPDZb2jmyvee14?=
 =?us-ascii?Q?j0sjIqoqNzu1PaBi5ta40Rpfop2qgTIpmqUijgWC04UpsKoaDyWOueBx6BMY?=
 =?us-ascii?Q?kBEO/gRRTGmWAhLo19CNv1J86unD3exVgyal67e2SZBX+DNgkfkgkXzWfuPm?=
 =?us-ascii?Q?Vz++ZPLam+nL8HXO0tHkAWo9ypE+rBIBR0tCmVzWzc8GgO6HO8AOeri6k/a/?=
 =?us-ascii?Q?yhdFqo3SsWAMjtzbgIrD9+nFmkPbL08j2HePfdkbdBWN8qVprb/A6OrLDr/u?=
 =?us-ascii?Q?hykIRBbXxeDaFyMIxAKe2hUEWtorl9hnyQiv7OOAaqrTY6gL76SreYnrNxoU?=
 =?us-ascii?Q?wYPmUDD3ri/3zJcogiQToFAz32a7kI0GL9NGD+63QRVFB1AUKVAM84/TNB8a?=
 =?us-ascii?Q?UwJOo4ApFPSgEO7oxk//n8Nk72i5V2SwAdzY0rGVNWQzlb55Q+fmtb6vLvFQ?=
 =?us-ascii?Q?v+liLFKjYMaxwWD2aomzDYuloKYNAvPDJM3A+u3BG3k4vptErWRsTktb3d4S?=
 =?us-ascii?Q?cnNJwCQUsox446EocnMBIBB8jLI9lJcC4tZBREZMMt7bgEmIX/YpC3+JSf6V?=
 =?us-ascii?Q?XGPrqZRMWmV6/oIx/n2gQ/lOSzxs0YZmBgT/W7Navt2cK1gEEEmv9ScDY4mn?=
 =?us-ascii?Q?u9NyJ8IxoyPvdswobTbHmg+1FLbEs9PY9JuppQ/q6CLyBbFhynaTXOC+gARh?=
 =?us-ascii?Q?MmQQFuq/C9+iBYM6vIZqWXVPEPSzBjLgPBbF6/9GEZmPMNArXzM9vm9FYhr5?=
 =?us-ascii?Q?cfTDLc5I5P6uMWXfkbBgyiVmcq4WJmJwjvJ5uEpANQDrgAvtYy12sDfHYnP+?=
 =?us-ascii?Q?Bd6CjP3WOI6PYEXI0+4RZNNIeXQ6Wt62r16T//P+MJRZGUuWhjsypomscTsf?=
 =?us-ascii?Q?37d7wR2neNkl5JChweVcw0Lxnrzkbglm6PRiu+xPOj1EGBv9KL5lLLRhSNua?=
 =?us-ascii?Q?Rxndwy+avhCzq1yMjqv6vwgLWH+SLu65qAFOQdtpgBFNpHx5tmhDgHIYLi7m?=
 =?us-ascii?Q?KLRsoo/QUeJ6lLA0OFucgA7y329KJo+GFP2cDb8x4G8Tld+oXHVhFvrbo0qD?=
 =?us-ascii?Q?1dMRBCKUDCNytNvDH9RPQ4C/TRnBGmBYSg9H6Xc3ZeioHmIgYM3A+8keRA/0?=
 =?us-ascii?Q?gBz1h+J4JkAappvIu6o3k4TDlhjCQU175BHhiclM2KprdUdMMeBZupVC1+lA?=
 =?us-ascii?Q?/QOCillXDmSv7GD3VzYl6On7mPTCOAp/yQp7BJN40UCbaYwKOU2ZILpKVkwt?=
 =?us-ascii?Q?Zjl7iD7QCLdr9R1j8+Tlmsom4YcnerlVwztZfeL+YmXM3fA7CdV75OaHIWGb?=
 =?us-ascii?Q?Xqp8qMX1FqCTzzPMMI59ijWi00Xa/+jPaxugfl0LZJxMZE6lvCtpHIGlvx4u?=
 =?us-ascii?Q?cCPsxAxNq4ZCbJFasKGTLgUq182/wd0eFt/Hss8rVNW20DcqTM/worCikqiZ?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wzoaAAfSH/4GxTYQQw5VUrOCUfvSe1FiMHG2mjScLw5Wb58eaZWInjnRU2e0I77E623mBcrKPuQJ3Vq7d7J5Bv24zBfFYohVdXwZM6DMN+d/OaX6TQAFag983KI9IKlt04iLCpU0XmYe8yxbxIXgK/y+0VF2rl5YrP7kal2gJ4Uzz5Rn4hLWjt4bZ8X1mt6CBWuxO/gN/chVNjBz+Io9G0s/lQBtDQcETDhcFECKEOGIoL174bJH6vLfVhZEQs4PmOdF4z15kF5qPLDtMdlyHMOmxiFIB+GsHEMcPGtEWD5stDxTtvR4ZCZ2lsUxeQlCQN5bvYI6SFGCsWSPPbA1lzWk/R3q+Hwm6AMjjmM/ypBgEvpRGrnJfQvvLMEIsrn2bKGyodmxDRgtZAtiHqlbAAa+J/jICxS82z2BuvW9lXKgA6xqIOt52Ir1rlqkAIqbaI1PqcyDjQr2A6g1MxBUTFbYeAIUILl2TYdzDyafK2upgLqqTP+cqYvMVDJwIjT3MFtMAFungkgrV9wBe370AnB29sBfSF+iA/xfjHNnNkvegINxiUiowHe4VmK74bXUrbgIIgFU1tNDt2tEVhIZU8ej5pgt5OkCNnirxi6CwAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507cbc3e-cbf9-4de4-7b4e-08ddc06f7cd3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:42.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ehZItZ+we5jLrwyFrrVcWGVxzdE6dmG8bF6qZZyK3WpQZwCjwu0T242XoN9jiP58WZlVVecVhVG4AZ8qO7CmiklgLhFZvphIeD2PC+H8WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: G_YMDGz2Yk7UCYLMEKpXvlImlinoHC-4
X-Authority-Analysis: v=2.4 cv=YN2fyQGx c=1 sm=1 tr=0 ts=6870f7c6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QQFbvnUwB9Dxs2rSiigA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX6LZf/qYjuJyT IaFIHpretZN+kUewqbCkLSu+z3uYlMmbzYB6C5y+3xuDU7qpXpc/NS/lI8ziRPYfuFYAOi9+SDv Q3lYz6gf5YG4Z1ocBiQ2Msl5BihDiLPnAExn+1GV+mN4FjYRwY5dJ2T/+iU99SCaFOlVbXMkZtV
 amDO4MYIypfEc0nB36Mk7RgT/kDkr3KYJN+pwPC1xbQEzq2VbUpv9QQaDcsNfBH3wHgVXXeIovr kptq6YLPMzruuo7DX/HxiaaRIohZ7uyAc6c2TO8G2pxUK8ziWc5fNsL0zUELYEzw+rulD30wy8I tlJf+2b0GvOau4j6jmhBYupw2r2PInAeBcV6iexAaAYMlifKxIbvRVgsny98+EkPj42a70U2Ne+
 veS+JGfvJUD8qXBcKuVnT67ivzLZEvVrdB41khvrBPMVfBPTsrPBrwYslh6WIufeLt+waaPl
X-Proofpoint-ORIG-GUID: G_YMDGz2Yk7UCYLMEKpXvlImlinoHC-4

When we expand or move a VMA, this requires a number of additional checks
to be performed.

Make it really obvious under what circumstances these checks must be
performed and aggregate all the checks in one place by invoking this in
check_prep_vma().

We have to adjust the checks to account for shrink + move operations by
checking new_len <= old_len rather than new_len == old_len.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index b2ee95182b36..116203766ce0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1345,7 +1345,7 @@ static int remap_is_valid(struct vma_remap_struct *vrm)
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
-	if (new_len == old_len)
+	if (new_len <= old_len)
 		return 0;
 
 	/* Need to be careful about a growing mapping */
@@ -1445,10 +1445,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (vrm->flags & MREMAP_DONTUNMAP) {
 		vm_flags_t vm_flags = vrm->vma->vm_flags;
@@ -1637,10 +1633,6 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/*
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
@@ -1707,6 +1699,21 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+/*
+ * Will this operation result in the VMA being expanded or moved and thus need
+ * to map a new portion of virtual address space?
+ */
+static bool vrm_will_map_new(struct vma_remap_struct *vrm)
+{
+	if (vrm->remap_type == MREMAP_EXPAND)
+		return true;
+
+	if (vrm_implies_new_addr(vrm))
+		return true;
+
+	return false;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1728,6 +1735,9 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (!vrm_implies_new_addr(vrm))
 		vrm->new_addr = vrm->addr;
 
+	if (vrm_will_map_new(vrm))
+		return remap_is_valid(vrm);
+
 	return 0;
 }
 
-- 
2.50.0


