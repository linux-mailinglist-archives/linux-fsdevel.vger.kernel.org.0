Return-Path: <linux-fsdevel+bounces-22104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC409121BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735D11C231A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D98178394;
	Fri, 21 Jun 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V3hs5Hc5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k+RgRC7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2656F176ADB;
	Fri, 21 Jun 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964450; cv=fail; b=JO6/lrotAEX8MW60DSR/8d0ad6YvdJdxBChuvvkxiDFOsBzKWK5zJ0J9d6WNa0NOT0CKBLNVglrhVNUauC7G1KEYX9USab8XrrnuRLujBIEFm8ryg/OIqLIotcyDJNU3SbtfEuZx+4wA6lBHO+/+JV840dpuKNvKv8Vt/+Hxpq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964450; c=relaxed/simple;
	bh=7A0UP1knvLD46RpasWbfGfM2XP1F/TaSAZuhe2gGZUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeqO3JJ+FVbqE9pZkRLnSWxjrs8RuGwPo1DlNnYk2eVSJEO6Wf7PY5Dx9LTEycZqiWhd9g2D6h2I/BnKLdI8WPgsFYvm3mt1qIcPmbbudGpQd72SUwZ11uSkN+niueWYxe3QBPPLKPfBzBXPKPkuext38BUsBUNCqkLBYa7mpNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V3hs5Hc5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k+RgRC7Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7gQJV013807;
	Fri, 21 Jun 2024 10:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=HDhvO5bYGBhBuZX0wWVjWzM0MXq1wQKWMu6+eCFTp1U=; b=
	V3hs5Hc5SOYIqWzcVoBbubWWDBMCUBMqI75m8yB8ad1ijCDI9xWE9WcYz4ozJu8j
	qZWBlUeDv/zNXGsqbJSnKOEZJOztjyxt7MIIzRWIp2NhEYPc8JT9PaEA/EtguTY6
	thlRuHPYBD3MdxXZFMkeIQ6LCkdNlu/L+auBpQ5ZIJkTPb+Dzf3couzzBxqGXRBV
	EaiCBMozvo61duKZQ++Y9bEdU7nJe8pfI3x7UlT0iP81w95YviutGxV8yDClLtF7
	z40M0J58JR7IWA9ciJ1RpaoJ7XOjG8Xp+QtL6x8glDqqTeJZWjH3rZtkvb7nDVqz
	XpQvUNTXPMB9gYVans6mgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrka1e8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L933vW025228;
	Fri, 21 Jun 2024 10:06:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5wcnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg/yg/qOy0Mx/AcCiERQslpm58rquRECOrdT9IaCYxUlDlRsmFqQujpRRPpoNO3IFcPdFaFVFD6/iqAGNuSdCeyO0JpmGThXHfGX06Mvw/7r4HwE0MBAsQEBMLcwoC8lYu8Rz/I5fNKSKQd6SYdv1MzkosfmsHGkBhPzIZlP/TwNEc8qOPRyrCdgyX3s1Hlg1tVmkkDzYzGpGSMjfAqbAmdx+1NLJwS/0DGHWr1YPYG865M8p282oQKy/PQep4vWzIj0rbpoinQEnHlEQk1TDJWE+8RRUitLOudR7ct13UI7TX0TzuyH0KD550RrliBVY2bi46CBh1i5ci2ladw1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDhvO5bYGBhBuZX0wWVjWzM0MXq1wQKWMu6+eCFTp1U=;
 b=j8o1bWRSywywQJq//Wio+eYBqIT/lby2fMZ246VCdDMuWoLnrZlbl3RYvEeR9yYfrUHvvQRsFSGumOio9awJ79d77RL7cpbytLoNbuysdahctGN7Iy38N6AVWy/z00bROwxwWQH5SH2/6mFsFQV5MYgP/luagpu/jR/W5Nje48UvwcpaPaXlDWXl0+Pnt5inEPgO2fKjCDijVvUdHGjwq9sXC8dqBdvdU2j4/1ipb2NdctiWBadstqr+g1VMnykvqcojHIdiR1RcGxCWtEZiml2STiHqVsF4u5Uj/q7+7CQ6JNgRt4jbGXpzxnKRy+8OqScmRR2E/RdQWIm5QLl0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDhvO5bYGBhBuZX0wWVjWzM0MXq1wQKWMu6+eCFTp1U=;
 b=k+RgRC7YoFIiapushX1f5afEFuW3FG99DiNCmCdT3E7BBbTsiyck4063248YVKjjtbvAbmcghrmL8Dq7RmPW3Ki5VzZWDfgsXmoqcLt9JAoib+pSW0/aMq5ERmXlosf60fk+JYHBlNepOTvE0K6dopTevmBLS8KBJd3FCw4mu4Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 11/13] xfs: Only free full extents for forcealign
Date: Fri, 21 Jun 2024 10:05:38 +0000
Message-Id: <20240621100540.2976618-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:208:19b::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c0e5a9-ff9d-4467-146e-08dc91d9caeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MTEQkDqh0y7OX6wy03VBznTVXwMrlfyehxYE7VhCeaL0ds4nqj+BtFxrIMej?=
 =?us-ascii?Q?w7zb/jt4wcz9N/ETyccNga/H1u71VpPcdhUWC64V3feCtLLtzxgIIOIXNP/T?=
 =?us-ascii?Q?JmQ/D7GS3r7jk18qVX7csYgH48J+K9Oond7J8HNRojHYNA8BNoED3B+pSnDO?=
 =?us-ascii?Q?pl97FFcy76VhuecnkNKp4/RvjUQC2cHd8F5q7Ga7lVmahlBUZF67WvoW5d+6?=
 =?us-ascii?Q?AvP4GuR9KgXvMPMj/J7W/9O+YTJVYnjQorstCKA/6OnycSV5NsDA9CSEExLd?=
 =?us-ascii?Q?03fD9FewTNbZqxhUrR/kFaEnGQAKDLhxaxIceosRM46pM3XBmpB7v4Ze0U4a?=
 =?us-ascii?Q?8QrCOq7+Uc5PN9zjdXCHB08XuDlAJm88tJUhpUF5gnPaEeNJOOsOb2d1nHl/?=
 =?us-ascii?Q?ILu+Fay6+gIgLBUIlzT68GYE1NghW+G7RJrX+zzWJ/+ErfXP/LdpEznRdc0K?=
 =?us-ascii?Q?4vrMlZZxuQ8uV1WhoF/D9m5I1q8/ry3L0HHIBATbDNWn6Yy3elnzwibgtJg0?=
 =?us-ascii?Q?BC0RLW3k5yosO1gznVH2f83fXmKJpVjYlvAEAMwjrLWIQRjNm1Obn7CTdRuY?=
 =?us-ascii?Q?3fx0NdYQRXXH1As1tjqubD5CRY7P0/79rSPRnYOQ9oIP0/Kx/2pL3zQj4NbN?=
 =?us-ascii?Q?6GQTXmZsiWUh8N7kTNapr0gN6X4+pYrJuuwaz/HSm3t6pqxX0m1ofp7VOsmv?=
 =?us-ascii?Q?9TAR/GTa9jBJSi3sSWIURgHW6E0P/3apEEuLC0fFw26+ahvTqR2Y1Zdlf5Oc?=
 =?us-ascii?Q?NEJjv6KL5tGQbSBLOybC/gHY0PShWXTj/YIkSoUShuEeDjpNnaV35CT4p9TH?=
 =?us-ascii?Q?mIzwxyhmjkqcjyA+ocPesqxet0jDe7qyj7dAa5nE4T0ZniFgWBvNhrUZVPri?=
 =?us-ascii?Q?3FS/hqp8BHeuZHf3WOakOR3SE4Az9kwvRaqENF1tK2MBGngkv9/hQKfhsVT1?=
 =?us-ascii?Q?vysDoH/FcTKtLYH/lWbh4wFib6V3QT/aCrwhNwXScUNa+vYUjhzjAXw7XrNh?=
 =?us-ascii?Q?v8PmkNqrVESFIbEjjnqpZdyj4x7o8ubokuRo5CpIlkiOrg7iAPej53MS97xK?=
 =?us-ascii?Q?+csuPvb9DZuzKxrHRB8+dM3KmBlBuImsG8uOvwLZgo2xMy928MmHG0+Ztx04?=
 =?us-ascii?Q?FQBBkcQkWP7P+4uccISgu1kIVdV3MhvjjMx2al25kh8xF8J4MuGxmJGNCWni?=
 =?us-ascii?Q?OnN/MWB+Trfc+KTdCQqqpLWfRQScF4F6ZRFEnSnHpOGkO+fIVx1+Bxaz0f7e?=
 =?us-ascii?Q?BbYD0D98ueMyAaP/8Ny/8jwEB79TRo4j2OkFhCe9DfqlwhaHjTbrJBLI89hV?=
 =?us-ascii?Q?LlE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w1pj6d3e7DL6K4DVgw60j68aUlMXsA1Fw32+7hvJ6D9+2qTk7PywLmWD/gKB?=
 =?us-ascii?Q?mka3GTqDITKZsLy0JQ334n2ij13WMmag0ZiVRaQXeRmztl+LCnU1p/5SvwZT?=
 =?us-ascii?Q?pAZgabo2RCihMgNBOxgVcp8lq/LaHuG1uwgndTAj/oiQ8crJ5Stix+hez443?=
 =?us-ascii?Q?hhsOTnbjcMNtq9wceRTalAkpAl8nax8/8FK7T+r5LaxMIi51m2V4j0k2tYHT?=
 =?us-ascii?Q?n9hvghDumzvFyygmKnmxNp7M2kuQELEOvxBR+lbq+cBPFaR/SPdjgwdLBGWr?=
 =?us-ascii?Q?thPXR6UiqXU5AH6egtsNW6M+MXtMYTv/GRzfpUSehdr33GjBMR1tqKIskZmk?=
 =?us-ascii?Q?kLhecvbSuKjv1kDhcDQQ82QiTltSvA8ekZYCGqBtDehj3STrgVNeO1zhJQiB?=
 =?us-ascii?Q?BTpgZWocr9wr7oaXuJ4ThyIr33fn7Arr9qkv67f8vC/vTy9jG/a8xfsyC8zU?=
 =?us-ascii?Q?4BIcvR0EWvkY+Oz8qW/tLlN0/MhHQofYxLO+pJ38D1PC+Ezc/htUbaM4qHe2?=
 =?us-ascii?Q?UCFHJDbWwRUD2GI/I/KANI8Q/M+DX5hdA8n+NbtzzF+CFg/fxzeFH7hDIW1H?=
 =?us-ascii?Q?Oq+fktLMNcpn8xuRmf6BdIgWU/oUG+GpBANlVY88Oc0STFGAc4og+acPjZNq?=
 =?us-ascii?Q?VaFzoSEOhHmmXqFCTRsECGJAMOfUayVJwXTOueLzwVnj8jUU5ZH0D8uzkNQK?=
 =?us-ascii?Q?XsTCnSgFmIbatvFzRLYslddNV1GB8IjWPApO6rKKqPiN6rQJaoo6y1jVTESV?=
 =?us-ascii?Q?VYu4uUrUi68ln7Kyw/iuykVZuxFN/Nr4gdrmcX82P53YdTZoYU18dnIV8QtD?=
 =?us-ascii?Q?5G9pHd/TenNpQj+MtynLg2FOVHNslaiXuJRXULHsRwbGp+0Oo3bY8DO1iA7v?=
 =?us-ascii?Q?ZopSEWi1m39+2f4CWDghEyZUFVGOadR9DhxsjlKZL7cNvrjcommS50cbnXdI?=
 =?us-ascii?Q?Kj0zfYh/qZoFg88VQ/mLQRENTm9WDBGvwqcx7E8U45WieYuZMd2pg5PJI28W?=
 =?us-ascii?Q?39ECYkJsM0T1TpJ5+a48a1AiigdXqG9H67qTbtfOYtNal4PeZ+x65TxwP624?=
 =?us-ascii?Q?rmprrglS/Shki0Hn/PI28bEw7PmcIlsIM8NxFCcm9JcpWXD7XGdnrAsI/J6Q?=
 =?us-ascii?Q?8iDi9DczCk7yt0/J3hJEc76ibiyaqJgvWgk0z//XExKAt6rb/BKD+pEXReDC?=
 =?us-ascii?Q?RATrjuV5flz1covRZuzTWRhC2Ln6OGy0R77KFXg6r0Lg4X9V+5zJoN0gN34p?=
 =?us-ascii?Q?NpQ4iO0PbsQccHLfAmwzzHJJ80OMxMcqPhrcyRNC0q4O0LIMCJEWdZx4fF5i?=
 =?us-ascii?Q?iEENHFwymNNI9WR6Uh22st1SycES3ujOFZbDYT74EIvv/wTHKAEUovYkwqKk?=
 =?us-ascii?Q?YzmFqxJO9rWyMwLnMcmVK6Km2IKihjXr1hKt4YVjroRGS3qspFGt9JimsOMa?=
 =?us-ascii?Q?Mzy8QWZIHyJbn8IeAz3jeZOWtxEAuIAXH0ryTypZ+T7nGlUS14i/QybjeKPd?=
 =?us-ascii?Q?bVdR/q80OQd4mj6DJlc7QyO2U6gFCje2pOYtS/AxEKH60slAe/2yGtvG1b5Z?=
 =?us-ascii?Q?AGxWh/un90IhABkrpKxH9BOU3tXddsfMXqnGToCWBRljXWugBCDgEhdvdP9O?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cdMriZG/U70YBp2dRUPkuZNGB7A9DqxgzghA8cXeXQXEExH6zkioJff/Hh5+UEVLZPFOvmBUvNUktETQ/98+0zWGk8zkMdnq23rLDzlX8+R+xVv6jp6WvEKG1xcHqvy+bXHxjCywpvqnWbUr5eEOuGhM7Lokg3bko/5qSt8AsZ7NjW/k2YhEmdHA5efRhG0IIgygWxmUS9wbrcL1xIM0uga5N+0qompRy7F0vemPmQVScwrVw56hXrBSUe6cPLKrRn52uICr/7VXkunPrUDUPxQUQhHfd66/Y2NkUdbZBEAFEc3wbw+2U9MH3igbYiFWMBnFR+8KPsZ0lAnU7ePiINWeldfOkJ9WmZIoCadj7gB/WOZ7unKBwGQLanN18lnt8tq2awVUeojmzIL1QTFkbUyRCY8ApaogLE9OprtfsWajswSr1zLBkW2i2RHGdVhpVK4+HqxGdMVZmDJN8noF9Of3tZSOrSTpP1xjhcJJlqeMSBIKyeX/yota91YgYfqwSL5tBQSBl8WjrgRvmCn9ukYjxamrfXN1BLEwBL9OTxyDkNRhODR2WOTc8XkkJzQ+jSpQe3VpJUVr4oCnaUgkIfH/PEtZie1Zj8VtOXM6Hgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c0e5a9-ff9d-4467-146e-08dc91d9caeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:17.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrotsF2OWP3kIg7XXtiH7lQrQ6SeVx70NKxVfEXl0vm4rcccALMqSwNh5SYCC9UJueg783LgYUZBQOv31yM1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: klsB1kQm12IFT3t2iQAn-mU1MhI6iY1Y
X-Proofpoint-ORIG-GUID: klsB1kQm12IFT3t2iQAn-mU1MhI6iY1Y

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 56b80a7c0992..ee767a4fd63a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -842,8 +842,11 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (xfs_inode_has_bigrtalloc(ip)) {
+	/* Free only complete extents. */
+	if (xfs_inode_has_forcealign(ip)) {
+		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
+		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
+	} else if (xfs_inode_has_bigrtalloc(ip)) {
 		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
 	}
-- 
2.31.1


