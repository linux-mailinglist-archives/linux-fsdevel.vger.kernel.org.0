Return-Path: <linux-fsdevel+bounces-45954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C348FA7FCDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D763B6042
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA72267B02;
	Tue,  8 Apr 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oixkPm8C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EA50pMul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2426981A;
	Tue,  8 Apr 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108981; cv=fail; b=OsSVX4D1WiD0wGTnCIdK2c9Cl+k+7Ewzs34XNcI0J5wPI1UfrjAsLIDIvjAm8HXnWI9FQ087EbQ8aacqA/DGdEElTenkIz6/TsdViZu3L8P9P60eF7ymWJ1Wz0BMsY0chsMXgZbgrKXtV7JBcOW3b9IFQB5ZJghDgF9204DX+Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108981; c=relaxed/simple;
	bh=DmoYXG8M9VEMwX1r5hIKjbfa3Vl4uOv0bZiOEAZiRlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+Mgp1KrA8rfUXAAyTH2YbcGXXkER80AvC+RPDGMO1nztjGEOuoe2katpWU1xF/ee+NWb8tQt+OFtuSO7YDMZdaV3bcV8qmjdwT9xZApK8UlGCGnlik1kOnyMYmAHpfwhBHNYYfG4GZlBPjSnL3lb58WF/Z0Gd+CZx0R1X/LaW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oixkPm8C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EA50pMul; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382qZcH007946;
	Tue, 8 Apr 2025 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t6cdsL4fLBCKPWutRvB5gdlcGwcPSAfxdwEVorcUEOA=; b=
	oixkPm8Cnhl7E2vRppmaa7ph7d3BZyFe3YbAy1AxQHu7kKG37pOSEEbpB51Y0bGe
	MJ1nyUbsYk12TOYF6WaQYX2ssYwk+eKT1HnFmzMWheQV17hbgwIVTvYshiews21e
	XZ2Sg+kn+5sNb1NLhEqaUv5b/PGyza7EQmfKQnwZQJVPBWUyBNCdBi8NPuLTidK4
	mL7p4zcIBljK4Y3H2CYo5o2olR/kzubs9cxPT0sIUDS3ikUTcgmg7u2yzDQX3aFW
	zWvDH2qOXjfPFXqmUpGQ7o3RzxOoc5F1mn/XShsH6H8vQ/+AAyhRZ0gzHTbyVW+p
	TQt4rgNEhlpFyeCeLIMBNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tmfak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538A6fsO001900;
	Tue, 8 Apr 2025 10:42:48 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty93d71-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxhStvbZf1o29J0HHikO0ULuNua4/El4sGAD3AKPvX+ntW1m0Z4N0TkOKJa6Qo61k7lCcWOy4Z1216Czk5EaML7cJD0il3qWu50ij8YhhSJLWnglvrJPmp9+kj5VAaialPxS3kkDV79quUQwpJs7sOz31rq+yPyjXNKdwsZ/JTbfx1h5VoSE4Ezo9KK6O+wh2YKDbRfL4rrPOmyPBNmA7Lfog2q4Z3tFQwhoghlByMkx67lEw8JQ9vvn0t1D+dpkLIPYYC+dr4Uq1j3zESTM1vUh83EuIBuU8RBTQvBBD3y3c2FpsORQ7mjSIh2j7JoI677561yHxxvaraHcTVvtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6cdsL4fLBCKPWutRvB5gdlcGwcPSAfxdwEVorcUEOA=;
 b=mUbAJybU2dBC3KGF2eP4Yia8QdAnVQP3tNQipC2yS+vrxI4uDVXvW39UYAsxChJPpygXuErVWhDw7xoFTJaPDtseFoKKDOCiOgFgz6V9hCwFFJCVMgsSCZKtxLRmCwaRE/PM3OifxP7fgpTRRZNxJwiYRFpC3/Ud+Tv593OfjOiMcSr/Lpja4c/myXScg9DaQhNII45FJsUS4pER2J6lvSwj0v+9sfpVnl9C7nmmcVuaZML2vrUEjHeZRNpWPv2mmKMSkKopdRIWc7mRMqnma621gynuEO4UNHexLIWeBJNHIYTlouZCH/t7AiNGO2crWJf0resyTeIKRr8V9gy42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6cdsL4fLBCKPWutRvB5gdlcGwcPSAfxdwEVorcUEOA=;
 b=EA50pMulqyPkpm2DVSDIT8MpMsYVodUEXiNug3dMGLcaQZftaUUGTMfORQR7/e38CkfcJ9stphVXgVsAwm0GnoTCQSFZOM+GmsZkqqOMAJhrl0oL6M8Ize9jKFdHPq7E+rIP/nn05SL/UFfkr32vCuMOfDnttVHW9XM5xMK6Pao=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:46 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 06/12] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Tue,  8 Apr 2025 10:42:03 +0000
Message-Id: <20250408104209.1852036-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: db5bfca6-8f4a-49a6-e083-08dd768a198b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoBQ8J0P8BKvoC8ItdAwYCCKyeBhWhIBz4Sl6zc/ZhtR44aH5+2rYdtxdPWO?=
 =?us-ascii?Q?CiI6YyIiWLaQkKOlr2B5hQIjo6+9oQqxNEbiMcqMgyH7KVKd3ykGLjBGGzYn?=
 =?us-ascii?Q?CXr7VGDdQKbHnq2opZHWmpommh9LGhd1OB72ekELWSjdhqfg0yyBZhO6WFSr?=
 =?us-ascii?Q?SHvacjw0lfH7O12HPKzbSXQETOyACtVigaejLMw+TUs8rZkLP8qevAinNUCv?=
 =?us-ascii?Q?9X8Pyk8rFybKdxjXeCXoj4HGIF1ZqiaqLqeZy7fnUpPrFZo3+AEBhsDNEsl8?=
 =?us-ascii?Q?5sHVJKuGPllTzXhP40zNf4e9HMLQDsaQDE93Vmi4QNOQKtKD0+84HNdreVFB?=
 =?us-ascii?Q?AjrS2luX5aygMilwYEKpFGx9ZzzhOU2reXvDwc4il2tbARxjWu7lRYp90/FY?=
 =?us-ascii?Q?CfSgeWUJUhSMN4cVgEzAVjtiO95jLzFsFhrQDccx4j9bXbbkJ6RiUHcYpMJl?=
 =?us-ascii?Q?S6V8fYgGFvL1rww+ArRMCsWt8VtDqtqYmEThN37edf6vS22ScnLzPrVK2fSS?=
 =?us-ascii?Q?TJF04j912tLoWHwpji5fEOqYf5OA0GPJltOIz4ss380qr2wBdyh/nj/Dq1JQ?=
 =?us-ascii?Q?8ASzEcNc1rS2YUmDEvscrfl1UV/kbhLY+ltbNRP9cEeTUONSFWFI2WwhR2dS?=
 =?us-ascii?Q?WaUWCAtliZaDyh48gurVllTlp1OUv5JOdjmOUSqCJCyd1b1JDcDsT1Najhhr?=
 =?us-ascii?Q?IoxFpwPgDQm9OG6I0RyOM8+ZWuXklJJFUV5rL9S13p/8Tc8hy3GgEWAVEsNz?=
 =?us-ascii?Q?olofP1liipaEfL3vC6b4UEyw1umXqj7m3ZG5h87EkQywvU3PjPDBT09Xfyoh?=
 =?us-ascii?Q?OFuDRt6fFfLZNwTdH/rE7osilo+Y3/FzYfp9dh6UV2jQ3uBdhgxc1GABQnr2?=
 =?us-ascii?Q?UN7JYPLxP/7dELnDWhL/j615rzCqtsaLPp4lji5/CCx+WMEO66K+C1QXO/+0?=
 =?us-ascii?Q?D3OvnpMMIebE6RkWff22B5STRkOETyg5xh7dsD9VAV0ywEeKsVE4jzdU7wSR?=
 =?us-ascii?Q?2HTOvkNPu2WTiCWKgU2wUP4IltaIi4MITwjo7f1Qn0HpOfabrOIvBzzJJvaf?=
 =?us-ascii?Q?PFqxF5/9TMGDrFcTEnJDfao66pdkFpP3X3gptg1A4wxN6JO5rUliUNsSwmyi?=
 =?us-ascii?Q?XOUVLPzLdWLLOGu37AW39buuT8yrauCZgXsfgSmnpD0UQochAYCuS6HT/+H/?=
 =?us-ascii?Q?wUq6MH8Zyvv2Ji+GFiqD7348g4YbeyYj+k3suDgbyS8b8K8qN0+OGQ7DpOAC?=
 =?us-ascii?Q?jJPCRgCgrpBzTf3OhIJ/d9BoSBE+9RBfBRz0sSLRfLYcZ6g4CcQA1K5g0tku?=
 =?us-ascii?Q?CtPocf2IBF+c6oDUcpzJc14JzkN7aV92gEQjMbkC10vsdQ1vspnqimsM1Vzy?=
 =?us-ascii?Q?51u2ZXezd+oDqIIzWoEXAiwqmnym?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1aiCw/5rETrSrr68yRtzhAsZGf21wpAryKuwhTX6lUx8qdvjrMK4p57Gsp6v?=
 =?us-ascii?Q?hBm8xsVioNkK/0r4YtRkc/Mvv/TiypuslDVIndFapYfuKisoGxZAqmQXp6Mz?=
 =?us-ascii?Q?kavDPqVEAwH9EAN78nv4JpzoWoy9BUq+QHupgZfdcymQDxEsp6C2B7JYXyMC?=
 =?us-ascii?Q?eyeBoS1UD7U5SzgIc3cvIRBHytAqF9z+r81tEs3wY1sHRgI17Xyx0tHbC+O/?=
 =?us-ascii?Q?v55bgU4SafYnDDK/cXxiO1GTlnxhkNFVTOAN9lO3gNXAknSWJi9pcTVv6fQ7?=
 =?us-ascii?Q?6rUjlMmsVp6Oe4xDQEh/+gX7HoNOcoZyw1fILWWmKCZUNXBA854nWgwvz9I4?=
 =?us-ascii?Q?JZmaKq7G9HqIisvZoHtDMhqtkokZIA/plfHgo53f2M+3uR+l+oczKsrjfEek?=
 =?us-ascii?Q?/ZZpfL4hHKhPzh6Ttsh65uPl+/wQoa7syW6gDV/f66cwdP//7LlPA1Kx+wUy?=
 =?us-ascii?Q?+kGSiFFcKf71MyMXLZC/DgcgGp7vrtDDNC0KU5M+kxPwJl/I9KvBBirOlAip?=
 =?us-ascii?Q?1PVV84Ko/kKOrLApqrwcA7iGbaVzNyfLKngX9JkgGOuOQW8Vj/R78//lH3e8?=
 =?us-ascii?Q?iaXxoJtkXqyr0MfOX2TYtEjzC12sV67/obgn3lKf8W+HvwlqeNcoa7roSsbi?=
 =?us-ascii?Q?NUXRWtjHCdK/sPQWN+YHIU9ebThogmmXxR2ukykl9p5YbJRasF8+XuYx4yiy?=
 =?us-ascii?Q?4jhfJ2BmHxtpKTQxPwzMmKQr0NdAmtYnl3ySB7/rLUK61MUNQDoxTZ2w7eE3?=
 =?us-ascii?Q?mBAF5dXRMnee3RWLV06/BxAn1lZusO+hnGtLxOPfQJ5GD6YvCvIdUDECVH4T?=
 =?us-ascii?Q?dFJ/ZlqK5H65ncTQP2Ag9hgR4UIsj7vON+2fAPOFOfRjhNrlJoYxcFCGLUfI?=
 =?us-ascii?Q?6q6FN3SX5KqYAJksvuotehPqXTFL44/MNAWMctS8zIRDkRpuMLhLyXhMveNJ?=
 =?us-ascii?Q?5JM1DLyNPDpt5AqTbrkGN6fo0WQ9bMhPpNOrOYSZiJu2QSHw7/g43cAjAw1m?=
 =?us-ascii?Q?1VISXYUwgpW8cJ3JPL1AsZSXcENPgqbgTC6aNSWfsojbF0c/QyRbYRl48b8O?=
 =?us-ascii?Q?YV5nqsk81qdLIx4XNsgskrlPPpCoR95Lh+GRxQUCzJSU0RmbnZXkOaycatvz?=
 =?us-ascii?Q?7ChFxNDwzq2CVmqYEHUFXeS1h5NR5IXKVI6jFSwaNwwtmIt71ajP09Dw9+wL?=
 =?us-ascii?Q?TP2F+AEDJ/yuzMQoEuNl/R12LsTgpZCjQHSCUf2nLaZPGaKZxS2Tm2JPwexD?=
 =?us-ascii?Q?LR5SHsdyDZ9inNfIfHreqFhftfPhLOkXjpo3r20v8P9nXzjj/gUeFWKE+sY1?=
 =?us-ascii?Q?oKoNYvk+6E3uPuovxlkPbI+pnO8B/m+25pAvnJ/KBNc2w4s2/EW1VdxhW72n?=
 =?us-ascii?Q?3KWuqoYRNnnvxGjoYy2arXhT30qEEHNhltQGy9CGDRxkZdPXDNZ+7PBnYTJf?=
 =?us-ascii?Q?Fvve6JmzOQa/hXuMaP3u8y7kgkBqhVqn/wVkNvTa8mFCq10alk4jur/c7VB+?=
 =?us-ascii?Q?3fJYphVvtERHN4VTXYh/ccczDJ5gmJ3R6B0UWRL/Mj9JbFQcbhZAFgTUqC3g?=
 =?us-ascii?Q?XW0xdHcIiT117/EqyBSoE2ANMOo9liC73j6WUcStOhUXPePK3OUC8pCO4SC/?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v/HXbboRnFX6pnmfjdPjbrGphXzMkgi3Krr/1r9bsQxHA9ylRLSbDmISPT46Zd/7db3mplPjLFD5MUhmLc4Q4tqwcTfGZiPuzWjF4/RnGI08UHdtd9uZBOdJLkL5O10HlmfbAVneyJB6hyLFVKPD7Wb32jZts8agROenei78/61cFZMtT307D0gJDqEjEisJqgU38EELvkSToHd8NapByIP2Z4MT3eRGvFbTEiah4Yu7p0ROmnEmm9ErgjBksnCyKqbgpRyZNet/+/vMwxq8OP4FiaefKBLLGEmKdhWK6mv+KGmSN5yMHJQXSfj+C9bVqrjK5+iLdnasnZf1zaOdJB8dzTEuzGpBiAm1NWxko5fk9CK93JrHZ97amb3sEr0dR58fbatR7Ngf2lcAgVCfKYWB7HsKs3crvGdWc2jdAwuAhQ1LdqoyS8zeVSWx9fKRtRJywi5NKaJNQLfJlpoDvOdSPXfhIR9nXoNsmPf3CG6fWa6biKZtMZccOn0NQxge+Wg3TzyHcw7XmxNYl2NHJ53GKAjNgnFKwNTne5fYKesKXfeWkLMHEPlxXZ9zlDAo6oVWKR8LPzALftumjxs9+kP7Uhom2tHVE17Nhby4QeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5bfca6-8f4a-49a6-e083-08dd768a198b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:46.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC1t4jtkKHU+r1AJPOk18bthW8J8QcmAGDYZG9bw7s18yXgXuBqcvYmC51Cs0MNEpX/PWkcxVMrQS3OQKLl1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: KToAuZ595qUANdE-MbYrVVfoK87qVhDb
X-Proofpoint-GUID: KToAuZ595qUANdE-MbYrVVfoK87qVhDb

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Please check new function xfs_get_atomic_write_max_opt(), added since RB
tags were granted
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 653e42ccc0c3..1302783a7157 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d324044a2225..3b5aa39dbfe9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


