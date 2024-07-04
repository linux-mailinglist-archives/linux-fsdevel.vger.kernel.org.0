Return-Path: <linux-fsdevel+bounces-23158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5349927DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9C282B97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37013791C;
	Thu,  4 Jul 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oySubSe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BiCQVapV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAF4D112;
	Thu,  4 Jul 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121309; cv=fail; b=mbGY4v72ASPxw7F7KgGc7RVsI4UIOVEb8xUShlwuL2coQX99RTErQ8OBQnAri8LRKrK1ZRlznIUbHbpkRFONfIMi2UfgRw7ZAORc8RRi4KBtuyVVejGFg1M2gG1/YnYJ1tIXAxZyLlE0ds84dZ3heR8Zm/58aFczihKM6SdJeYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121309; c=relaxed/simple;
	bh=t7dpBi0zYIDJ2Eta/7SfLnBa+D2I4J7I04ZnQ0/xgh8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GBZOCP9JyitVhNfCMklYKSLV9/9rliYYfNBd1ypKR/OJDpGqbD07+hbkFJlNMLuHO8I+QsU7uWpwzj/bk5y34YtdylidPA5/YdH4B6fuqv1vXfgpX0ycJKsPA5XfPlvqwotW6Zm2rk258T5uAOfTu+e04KEKLuWIXhfO6sfB7gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oySubSe8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BiCQVapV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464EAli9032216;
	Thu, 4 Jul 2024 19:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=KKXgeMnRng9wgM
	CiGrEhv6Rvyn0Dg4Gglw+VeGucTgM=; b=oySubSe8x1Oi6uVewVHMVk0mAgpTWl
	qXbRaTHtRPGO4cljiXfvGNYqWSbgeWjlNlAdDfKQ8DCy0NbefNHmsG3H8UIqca1q
	zaI87vROnK7TAKWrgOne+uIzKyauYvv+Es7Bba4bkg5RINij4N+8/l5Y0pCgn8Hs
	g0AdohMNIkMPRPmFXvbPJlJJB+GN1QAqXqWO0zI9Rpa4aaezRpA0c89yTy3PBR+3
	XR4L9jex9iY8Dy5hwQUl6qrK5Onh+F3LZqtCVp9EFzJAbraFlLRQjinpoDaeSD6K
	vagNbHuoLA3ybbjfFGatv78SIVdy7+3mv0E/t0qUTpg59sttPgWumRlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59aggh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464IW65U024647;
	Thu, 4 Jul 2024 19:28:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb3mp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfyMwAH8+fN0igDyS3hF/K/5lsLKxE8PDGpwdmMyT1S8qMp2clF7fVQewqNnQsS2lIq41VMVKXpVfXJmzipOzA8Ri9OVGN8oPZTDJf0MWt2qadsVOtx1AjwXHhq9hIJecByrRv6chAQNuYEwSYn4MF7l7XKMszKGeEIwkLlrAe6WjXd1gx7MxToYH2VOSQjQoRpk8lyvJ3XhNPgxFGp++/iW9C9pNLtHnZlawotPeF5Ct+t+jgscVIOK79nXbBBK9BfQ9jqogVyT5qdln04GNctHf5OmNhsChF6OoksX7YAlBp83KXiaMDIHn/0fWu37U/YXp1+JIKSemEQHj3vDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKXgeMnRng9wgMCiGrEhv6Rvyn0Dg4Gglw+VeGucTgM=;
 b=blBqdMZBzVq6mBUgBtaRxkDaZkvL2On2uHmntt0RyioeH6GFgJNG0hfpfi6j9t+YPrEs7L9ON75XX749o377r9KXL6ISCOlyQbQQG5pYMNC7Q3ALuDWgSkVGx4TyZREdN38s0+Im4Fq+2rEDeHP+h2MHeYlRlvJF2LcNuLaLbQXDatrtsMRm5/U5jan8Px/TIxh21N1vUSVhvNcj90uZSW3X3cHYWUmrnfHuhAvCmX2iEFySpxvweYt8yQBCM8AYkOTVtfGXDVA4Jo43UpakGmngsQX9SUt2bx+u4ESBmxq5JEsrmZrE6YYJUWsLuBXyWehdUw7fWaNfskfpf0TQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKXgeMnRng9wgMCiGrEhv6Rvyn0Dg4Gglw+VeGucTgM=;
 b=BiCQVapVk1WlnVCLLd8EhAnjI0hOAHyQEWceWpfUxtTVCHsr917Dx3T+lnadAmzsNfQOWLNhYFuILu2I01yXRN0mdavmIGzXCaqdK2a0/oNddRRH9OUdEj2wOj2yE55hI+qHlQNjCBKNki43kEr50QovCJozYWq1gMSYcl0NuvA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:08 +0000
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
Subject: [PATCH v2 0/7] Make core VMA operations internal and testable
Date: Thu,  4 Jul 2024 20:27:55 +0100
Message-ID: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: ff16200c-6a68-4708-4169-08dc9c5f6f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TTOd8NAagSzaX6WV4AS+Rk6e1pKSOM0YTzPJ83r3YuVov/rwHeJVz96kL7BD?=
 =?us-ascii?Q?6ie1sg/c7cD9vv0bktseUUSz77fuqkW8i5zz0QY9Evn3xZPy7sWbC2hfrL1L?=
 =?us-ascii?Q?vziRJbO/nYobpItLIkgCeGuxXCNVydS73eYz+gh4Jq43skFOZYWUdQ659Ikf?=
 =?us-ascii?Q?J4dYodKQ4QrancT9qw/5EQUAcO77LFQrGf5R01vzbhEwrDFCbUPw/6I0C/0c?=
 =?us-ascii?Q?YoCUDQTWu7X2xRv0rHQqOOdIHfQLFFeuzn7XTDJfH/xjopyzb8kYiwj5lFG4?=
 =?us-ascii?Q?x61n3/lbpjjeV/DChI85/iJuunUdMoqR3uRFRxgFc7bo30CkgByXcSvPzU9Y?=
 =?us-ascii?Q?AEEOwSxHBMjyxAl9Q8supWOOXX1yzWgRZ4bj5esy2x32hZ6k+rnk+kXQ4Poy?=
 =?us-ascii?Q?/uHmRdwbauw9hnMhRJE/1MhR8Z3lEOstsy/kMULsVeMAcXqONpGNDsudBdGp?=
 =?us-ascii?Q?jiZywO8XOd35HEfq7/ApKmMhnA4Kdepl4EjYu5JvAj6ZsqRUemIPPLnuL5Xx?=
 =?us-ascii?Q?mtzKZ/77nKQ7HbcSL0Xedg9kHuCzR1PJoTc5YAGO9a+1dUoNLWBL/C2kRnVn?=
 =?us-ascii?Q?fM30czSA2Wh66HmUnPJK295HNbBqmyyHGcI8fU7OvxOM2SWli+ND2X9cUkZw?=
 =?us-ascii?Q?stmjnfXlZ3Maseg6yXX4wRW/lsMzosLV0G9eRzUVz6vUPHakyDB4XTQB/mPV?=
 =?us-ascii?Q?rXMmzXa1WMZnQewqyaSZP0hNySUL3LKlprmuVfKM4lt8Yj4z09y3BqY3oePz?=
 =?us-ascii?Q?vsnPr8hsblOFqulW7Loku0A1u5QNI+soABqsUZHcrA5igwA/Yl/665iDhSXG?=
 =?us-ascii?Q?OVaDfgBhqPmCy9ptQOntCHTLRIfBIM6exbAiyePBFXUq1rlRfO0iITNFLrs2?=
 =?us-ascii?Q?2Uzse783rZ/pCT+qjl01/wiQEsPUxbwXiD9vqG5DuP6kJY+I04MDEkNwvywY?=
 =?us-ascii?Q?XYjdWair1jn2mSjj5xn3g9IpZ9z09EDnZMiZ9ZCw9VP25LoMxNN5ZBL2O9aP?=
 =?us-ascii?Q?P6pXFA7iVkXWKHhjSd5CvKqOqKdlHL+XfJO8TNf0MaRIUrTOefHz81RbsQIN?=
 =?us-ascii?Q?GqSCAREFTXh52SV3nvl7KkZB5lH4RyLJqflAsiDeuJB0YEnk6i//Y6u0LVKH?=
 =?us-ascii?Q?lbosjCzrsKby3+EHZT8mNGB9L4Qwg26jQEV6+41JIcCpZo5zTCcZpmgI57TB?=
 =?us-ascii?Q?UsHSeaveyZS0Pwcd55DDUwsS0NztzV0tFTPZ6GW46y/c+ueK2IUpximWiTF1?=
 =?us-ascii?Q?WKwKbpQBESFo9GX8UJxJR4Sw6AL004GAibAhzNwenY/Tcc7mnwstUG0NF6TG?=
 =?us-ascii?Q?A+Cz6tyCzfHapewd/7KEOJAx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1tlpltTI8h5JSxgbnEmd995zszB3bS2gHrZiTAzVhmrtIQ0PdndCfIaLWiEX?=
 =?us-ascii?Q?sPpyZBCZj1gqKPrwBNaGKingt4FZVtpPZBJ0mqxIjjeFKRkw1Og0dMEGEJU0?=
 =?us-ascii?Q?8iWwGkV/5atIGXQmX+sTKpfkBgMmeBBBVewLvYrDNIe501koRTmJwym2frYX?=
 =?us-ascii?Q?xaeINKWEMl2X5mw/cKZb1+9K2ARzheNDUo272LIBzYwKhCCeXAzhWL0ySJdP?=
 =?us-ascii?Q?YGT7wt8eIXsNfvbMaGUwmGgyRNbxaSEa7SVD1QjMc5eL/ZJClFJiVVf4booa?=
 =?us-ascii?Q?COVKK5+8gVw4gxgdOQrFwDy8JXLOsRf7N2FKD3Y2WOGT6koYb2RVyGU7yVGv?=
 =?us-ascii?Q?cu1quaLmNblgm9OHNNYyHTbPZ38VQORxr9foQeKDvTtnzVU3AHhldsr6vkGU?=
 =?us-ascii?Q?xmr53zXSvCMfEFmF7iIhobqbe8cx2sLTfwfeXDkzGUFJYApznl290zhmUyZ6?=
 =?us-ascii?Q?t5PRWdhRg9xFGSHENk7c/jo3wEb509OoJUxtnKaW2mCddvZJgXW6VrwCHmyv?=
 =?us-ascii?Q?gAi9gSltf9y5/uXqPHwbKB7VCp5+6ywFqHJyJl2OA/b4/PE5f99+IcQX+t7E?=
 =?us-ascii?Q?sXVqomNKqgxO8YZr72pwgEW/nHzxU/+U4aaayLKpF4TMHwSfXWtWvqhoucj+?=
 =?us-ascii?Q?mWqXseZNVw3R+wzys2Kl5qXqQvclJiSAFW1HPGmYdgM09AEFIS4t0egt5M3f?=
 =?us-ascii?Q?Gk2Sn5DBS3Lt8NLONSdEUYm3vpxfF4LH5bQHv27u8qcr51KowTt5Dq3b/Hv9?=
 =?us-ascii?Q?tfn8SjeB1Qm272hn6a64d70LG2eDGLJ1SizrHRVUAXLA9c02u3X/vs3Cedfu?=
 =?us-ascii?Q?T60jjjGrnMjvVNzZsw99hdkpy7D/3o3RLdadDu3khWalZ8mDua9B4iZ75bn4?=
 =?us-ascii?Q?snniyd+r9YZ+NsDFZjA5c0rL3Rllr8K4hLdofZ2nP7jM/0CA5a/vTjLFTBaF?=
 =?us-ascii?Q?Rznp8CZv3kKkvHGLpHrC/VX8kF3uUTE2zzb41+/VsWsBT+9oXKJLna4FtrCG?=
 =?us-ascii?Q?WiQIskjURugrdwl7Gdthd81d+zo3s6ehEGY22h8m2Ne5SbgYu8xrAymsuE/x?=
 =?us-ascii?Q?ssA0IKtxqyD8RqZk/OINI+Oy5biIDgp/KWk2sVm3Pdn63McnQVfGBlAgIatt?=
 =?us-ascii?Q?rHS/g2fjd2my89o1atGTizu45HoPm/0GgBGs6af2XnO6KxVFjWfDOY8y8QSH?=
 =?us-ascii?Q?MDR4W5DC898yAoglpqnaHljyASPfWxpCXp7ZF3MFTwnPhzg6MD/Ry4dYp2q9?=
 =?us-ascii?Q?8BTnJbXz3EiTLzbFWTCHkggSS+sRXO7MLfrHAxf+EM5jTEuJ5AeE2yMc1bCV?=
 =?us-ascii?Q?idrlzM3VjsynBxDZwDTD8YOczLT8WRezl3zcHmVTp5SCr6NYVTw+HooNwSgV?=
 =?us-ascii?Q?VO8LYOLZM2rrX+iP2rE8FpksB3r91wsfe3EdPIG9E1HazHz96dsiAOLyYqNu?=
 =?us-ascii?Q?1lT7upxkKq3Uq1IPofSJuUcrTxGBidGpcrNndk79Vhi23nhGNKjX6aixPeJp?=
 =?us-ascii?Q?ObBqvBP2cFiIsOfN/PVbIleWgzxBgtNr536yZV2eosEETog3439oc9d6WSpN?=
 =?us-ascii?Q?GGFT+qMkHbuOk8qqItB0wubLUqiSFf7HhCjxVHviVrRS+F11R7oQptB0nUWv?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gIkIdhl36FLptBmPief4pzXEaqg2wBGFgtJybr/eVT4a6IzoHwxnfsIHdOw20cOEzSSgoAvXDcddT4R4osls87SVY2fuJafY/okBmA+kikCoaRFW5IkKcJv7WxO+uevttn8F51WxWOhQE4DN818hdwsiOz6XIEDlbKCbGYkhjx2IVm3SR8OdpHRyd4kVRCEDiya4kh96iV7RiTRrS4PCm59fPsm1igffTguTfsT5gljYnmGSCBDNXNQWeSFN3JgTUdcCeb2DXPckp9NBxJQvs9w8nUukRf0pFRb8L6XbHZhDpWNscE4x/XTqLmQAUMt65ldehi+zSSWzBU5zDucP1gDJNlLwRyITxDzuOYJHm7Kslq22GEzpVgNPa+yKxlCksDMCuNy+tI3AdKalv1z8aa+aeAsQPxs8TSWXMQZFDwgbCLmagCkT6ETscBS82li4pr03drQpNtlpWOuiRl6FKRzZatkY887bbajKeqCZbwWFUlwHF7dr7M0aeDsixTCk7QfnXM/owml9CpdHBhjnx2vHX3SWTfNJGGQVyTnfRanlroOJSYYWSz0q00VFNlVeg2c/3FvoH8zlxEEwNvYRL8UyAFnzAyMRqvuAX5RMe0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff16200c-6a68-4708-4169-08dc9c5f6f20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:08.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKljw1ElW0AkG+7t8bDqJnWXNYB7A4qlSpH5opEaXrUYeOLBLl/GksQV8IQC/XN9czk2L8PZeqBPxmLLetp7Fr6PK/A9rjvXCCstJWjvwNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040140
X-Proofpoint-GUID: hIdIzsBorcmd2gQQGhj0XSInxL7n_gRN
X-Proofpoint-ORIG-GUID: hIdIzsBorcmd2gQQGhj0XSInxL7n_gRN

There are a number of "core" VMA manipulation functions implemented in
mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
expanding and shrinking, which logically don't belong there.

More importantly this functionality represents an internal implementation
detail of memory management and should not be exposed outside of mm/
itself.

This patch series isolates core VMA manipulation functionality into its own
file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.

Importantly, it also carefully implements mm/vma_internal.h, which
specifies which headers need to be imported by vma.c, leading to the very
useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.

This means we can then re-implement vma_internal.h in userland, adding
shims for kernel mechanisms as required, allowing us to unit test internal
VMA functionality.

This testing is useful as opposed to an e.g. kunit implementation as this
way we can avoid all external kernel side-effects while testing, run tests
VERY quickly, and iterate on and debug problems quickly.

Excitingly this opens the door to, in the future, recreating precise
problems observed in production in userland and very quickly debugging
problems that might otherwise be very difficult to reproduce.

This patch series takes advantage of existing shim logic and full userland
maple tree support contained in tools/testing/radix-tree/ and
tools/include/linux/, separating out shared components of the radix tree
implementation to provide this testing.

Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
which contains a fully functional userland vma_internal.h file and which
imports mm/vma.c and mm/vma.h to be directly tested from userland.

A simple, skeleton testing implementation is provided in
tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality work
correctly.

v2:
* NOMMU fixup in mm/vma.h.
* Fixup minor incorrect header edits and remove accidentally included empty
  test file, and incorrect license header.
* Remove generated/autoconf.h file from tools/testing/vma/ and create
  directory if doesn't already exist.
* Have vma binary return an error code if any tests fail.

v1:
* Fix test_simple_modify() to specify correct prev.
* Improve vma test Makefile so it picks up dependency changes correctly.
* Rename relocate_vma() to relocate_vma_down().
* Remove shift_arg_pages() and invoked relocate_vma_down() directly from
  setup_arg_pages().
* MAINTAINERS fixups.
https://lore.kernel.org/all/cover.1720006125.git.lorenzo.stoakes@oracle.com/

RFC v2:
* Reword commit messages.
* Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
* Make move_page_tables() internal too.
* Have internal.h import vma.h.
* Use header guards to more cleanly implement userland testing code.
* Rename main.c to vma.c.
* Update mm/vma_internal.h to have fewer superfluous comments.
* Rework testing logic so we count test failures, and output test results.
* Correct some SPDX license prefixes.
* Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
* Update VMA tests to correctly free memory, and re-enable ASAN leak
  detection.
https://lore.kernel.org/all/cover.1719584707.git.lstoakes@gmail.com/

RFC v1:
https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/


Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: move vma_shrink(), vma_expand() to internal header
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   81 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/mm.h                            |  112 +-
 include/linux/userfaultfd_k.h                 |   19 +
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |  167 +-
 mm/mmap.c                                     | 2069 ++---------------
 mm/mmu_notifier.c                             |    2 +
 mm/userfaultfd.c                              |  168 ++
 mm/vma.c                                      | 1766 ++++++++++++++
 mm/vma.h                                      |  364 +++
 mm/vma_internal.h                             |   52 +
 tools/testing/radix-tree/Makefile             |   68 +-
 tools/testing/radix-tree/maple.c              |   14 +-
 tools/testing/radix-tree/xarray.c             |    9 +-
 tools/testing/shared/autoconf.h               |    2 +
 tools/testing/{radix-tree => shared}/bitmap.c |    0
 tools/testing/{radix-tree => shared}/linux.c  |    0
 .../{radix-tree => shared}/linux/bug.h        |    0
 .../{radix-tree => shared}/linux/cpu.h        |    0
 .../{radix-tree => shared}/linux/idr.h        |    0
 .../{radix-tree => shared}/linux/init.h       |    0
 .../{radix-tree => shared}/linux/kconfig.h    |    0
 .../{radix-tree => shared}/linux/kernel.h     |    0
 .../{radix-tree => shared}/linux/kmemleak.h   |    0
 .../{radix-tree => shared}/linux/local_lock.h |    0
 .../{radix-tree => shared}/linux/lockdep.h    |    0
 .../{radix-tree => shared}/linux/maple_tree.h |    0
 .../{radix-tree => shared}/linux/percpu.h     |    0
 .../{radix-tree => shared}/linux/preempt.h    |    0
 .../{radix-tree => shared}/linux/radix-tree.h |    0
 .../{radix-tree => shared}/linux/rcupdate.h   |    0
 .../{radix-tree => shared}/linux/xarray.h     |    0
 tools/testing/shared/maple-shared.h           |    9 +
 tools/testing/shared/maple-shim.c             |    7 +
 tools/testing/shared/shared.h                 |   34 +
 tools/testing/shared/shared.mk                |   71 +
 .../testing/shared/trace/events/maple_tree.h  |    5 +
 tools/testing/shared/xarray-shared.c          |    5 +
 tools/testing/shared/xarray-shared.h          |    4 +
 tools/testing/vma/.gitignore                  |    7 +
 tools/testing/vma/Makefile                    |   16 +
 tools/testing/vma/linux/atomic.h              |   12 +
 tools/testing/vma/linux/mmzone.h              |   38 +
 tools/testing/vma/vma.c                       |  207 ++
 tools/testing/vma/vma_internal.h              |  882 +++++++
 47 files changed, 3915 insertions(+), 2451 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

--
2.45.2

