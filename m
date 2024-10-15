Return-Path: <linux-fsdevel+bounces-32020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134F99F48C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636C4B227C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41C206E74;
	Tue, 15 Oct 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="McVIJNPr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BqYIDNc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21194207A37;
	Tue, 15 Oct 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014999; cv=fail; b=VK1ciIPyqroacbFQ0VqhU834SaOeFJYeZ1+ks2pNH1lRQGtR2uj2jX6LCsKWCoTpujqwW50UqjPz2C12CAiRqbnTxxauJq6bZ9L0VWhP9SRm54xXOAsqZzYs0lcuOGWkfFPK4iRD5YcKpZDl9GchxiOC9yxe66F0KuhY+rJ4AMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014999; c=relaxed/simple;
	bh=t1/+EbOrgsmz8cOVsebDUIsW+YFGoZ74x4xhhsTlfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGbiUxsr6SDNhj/2rpWbXHwdlDLHg/KiNOeEY8+BScRXSDNVxKgMrAusgaa28NXCa9gLeFPo7sx0piozys5ZlTjwH4t6jd+HEl0qGeJAJ/KcIj7pnqZnxoDPPM1CQuKhvWINSPJy9dvLPM64jLwVNDgncOQ9z+ajTIRHyVwzPng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=McVIJNPr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BqYIDNc/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtdmo011659;
	Tue, 15 Oct 2024 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Yugvb4V1/DaU9YPaXiZJXwYIK8KD9dleMPpB9SJ6Hp8=; b=
	McVIJNPrsacFgsRNFbiZEW5PheaABDt/ncGhNxnG5K5s5rX6xmJ1cPuxqJWKHqpV
	S6hvTN4XrxlGsZmZEzuUWtuL40H/N/RhK0AJgWJ9+8rm57jega9Cz3qT32rRDiiV
	qIafudG6Mdh6FYURL1JMZ/8539gYhYVKT4+fdHVdOCk/TrI92j/k637s1rulYW0F
	AA8hZsnTInR4x9auk+2HmcdL1WaO5pRYkqq7VTp5OjNGx+KcZTUyDqK0x7Hk6hYc
	Ges66A7KpKJgIJR+Mgyk1VCluTAECzYZrnSEuu4x+BbwTKv2BDrfE4+d0NZTi4bR
	vBAr8xUE0y6ei/t1laG7kg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt1s10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FH4Uno026283;
	Tue, 15 Oct 2024 17:56:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7swjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E56YhpGPsn/OMck1MrUZlutbg5olQwQc2X6hpMLREi5HDNVRZ5aUxu8fI7rSVbfyp7EAYmXv8qEcLlmzfaVTH0xJKj63bEfODwQa0PYiG8+Bj5izQo/GRc1igN/i4moCrQ3G5CL5metdokADYeBIgOw0+Q05Smkm2RazYjFFTn203M/fJXUNYNmnfz9Am0M40BSdfcwayVsyuIAY9ys5sMbgodFc9Vsjl4mutXqpbwWkOJHfyop13DCK084xsYhEJOD/6xwYPYkqjO23UC+hPI/pmi0sHm6q7SKpKPxMNEiEiUNooUR+S1i90rBmSoNa9py3LSud5Pjl1ZYGTJIQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yugvb4V1/DaU9YPaXiZJXwYIK8KD9dleMPpB9SJ6Hp8=;
 b=CkvtTRI/d8Bg4ahTWbkKTFNESQH+AA0T05d9C5poCqX5mzlCZvjMETW5fB95g8CSiNYdS+B6GXx9Pd2jyeFtHh+Atkaep2qJPO+U69bluSWgSg/h8ObbINfAa9o8uSWFOnvGmiCIh/LJC+xscxdYRRhncjq/d8mAlbzCTKEgAOaOauGX7sV3F02hkYcrnGhcXYYof9A8CTuLsdlWMNpBGC1Y/0yVSGyCaAT2cXgHN0o+ZHUYpPtST2PnCaYYZ4Ta1p8fNnweC+tOJRMd8Ufa+boMTujp5uCNIxanGGHMzJJ4jaienVCZ0X9HsC7S5y02nUVs9JI3EG8ztyHf0VOORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yugvb4V1/DaU9YPaXiZJXwYIK8KD9dleMPpB9SJ6Hp8=;
 b=BqYIDNc/8YlTMBZYwqUPDwylAN7SBkl0dtibxzY44osUDAZSEGKCI/RfPMVNx45zHO3ERDySZeDgZsZNJYjfSDJnUjFWr/HmMFqfcDK8R6AjMyg5RJQ3vOKIMAvHBaqWA4X4XtLlYE+E+EM7PDuu//TSfxdlDe7SMAtOG0c5xFc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 17:56:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:56:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH hotfix 6.12 1/2] fork: do not invoke uffd on fork if error occurs
Date: Tue, 15 Oct 2024 18:56:05 +0100
Message-ID: <d3691d58bb58712b6fb3df2be441d175bd3cdf07.1729014377.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729014377.git.lorenzo.stoakes@oracle.com>
References: <cover.1729014377.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d1b6c5-3501-45fb-dae6-08dced42ac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BVPOu6txGovq+WixrfBegcbdDrzOiqvpwlJmK8NYj9tPnNyBMtHHewbBZJRq?=
 =?us-ascii?Q?0CXr0byulKSnvkx4S5k6DljDQQKg/oG95tqlVWxIlBrSzum1PtCc0BxYL9Tu?=
 =?us-ascii?Q?2el4PSDus8VRAlyM9zPnY3ZNesl1qn6ScN46EaJX/Q0EFJ8JhUD26r9wn0mb?=
 =?us-ascii?Q?5yztV0YKMjMI6Z7oPzzc9q/0rKT8+5jrXAmbHE3ACjccS7RTJiHRD3Ny4LEa?=
 =?us-ascii?Q?6UP9Hh/CxXCj0nECfc/C3NvEBbRr6J1DFezeM36JaAgWvoPPmGXhzVRIlNvY?=
 =?us-ascii?Q?LTE1lMguAAPditmfOl3g8mKJuRdBbB5L0bRA5G+6GJVrrLfjn5mKXhq2bfmg?=
 =?us-ascii?Q?UyX9V/GeMl+jOBa6W0u/lR8vFZzgv/gaIFThvbFI0KMvrDDD49vS4iFO/048?=
 =?us-ascii?Q?c/KpGxRh1+/P4uVkVTQAIbxeEWZFEg5yQivI3sR4qm0JitwOcfsxSTJDP6gi?=
 =?us-ascii?Q?+A7WlA5kXn1b8HgXQyYbW8XrdrXU74144C163mLENyal0bzToZ40v65yUjcM?=
 =?us-ascii?Q?aCph7lIeJBiVKn/ZaNPtC2LjuV03474e9Fb1gHnlkfRw8r9j6/7/5vtkHfUR?=
 =?us-ascii?Q?22UqIQIoGlsKDkNFRhhqVQ3Sjz1cUJvqc4E6H/DRKhd1co6SgEIshgM5f3pm?=
 =?us-ascii?Q?LNXU7ZH1q4xPKnsGkKez2UAJ6qTvtST4+K6uZh6WAIkt6mnCSZ04ekLiAeMf?=
 =?us-ascii?Q?Wu/8NAJtYXowBU2fUm1IiXhRISGhaCfJtlgLNHSxluMJDcJj8OAsZXygXHYr?=
 =?us-ascii?Q?JtqYJPb1etgwiDVg0+MuVKmnaVNGsUyKYsOkqGsTUfKwKRqDAfqpYbZfYoV3?=
 =?us-ascii?Q?mVx/K4fEukZwyFu5bQZo3HxGPH8aARIF1qOFP0lLF31yT85Dz8yjm8J01chv?=
 =?us-ascii?Q?ZFh3L6tsiHrFsec5kFdZeW1ONG2YN5LCm8rFAC6IS8y+mOp3agOdnf2Uer4p?=
 =?us-ascii?Q?1qeQvstaGoysIcsqUc4TSaR6fAY5xdOq5UBJXCc/hP+rHpxsBjAMUsjhrSsp?=
 =?us-ascii?Q?CoGr2zAXNz9gDmjUYEsNcl6JMvfIlMChyEKrYwYa0jdSYaqP9mQv+0XUJOaw?=
 =?us-ascii?Q?Kee9jath7DxxYxOlE8zh3YF7uUSp5K1fXV5T1Q+Y1eHTU4LHhfwLB3ZpBqIR?=
 =?us-ascii?Q?1G/k72qoG6UGmYv+jMxhYI13oI7013fUrIU5D7acnKUy6dr049N/qKfi7bxa?=
 =?us-ascii?Q?QwYu57CZe/aZYEd8gi7hmBOx5YdTZGeIhI1A9/hABJbwo2c6GEubl+oWpD1f?=
 =?us-ascii?Q?tjAfYGAKXYepg8JuJoOxtdmtMLAs6rSmTk4Sb+5Wsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSnylwSjTB72bxXkZjOcCuSGQSxThxsQCrjrljQuSSQclVUVt0PxLPwuCaAo?=
 =?us-ascii?Q?ownFB5YrThnMTUUdx7Ih5hCYfMgDmYyq38VhvPJzHuxylK9JlQLt5Mol/qV/?=
 =?us-ascii?Q?xCTNt6Uod5Y8VgLP/NyppTPVEXhQHrabGjV6SvDkKPOnmHjzbXI+XA95JOrN?=
 =?us-ascii?Q?V1u7d7xqqGH5jw/lLkNIDVzwOknHFz3AIxdnOWdOxl2O5HEjGUpnBIZl+BiH?=
 =?us-ascii?Q?SlNJFRrctXvHWwKhSibPJ9+6A6y1mRn0MBOObDOFY6b7hirPJCGzACQHha9T?=
 =?us-ascii?Q?sXXCGyBMFNFFhndL+FeCEiuMM95jAReCRUNws95nX6ak4/8orYfgQiB50A2Z?=
 =?us-ascii?Q?91uniRoWpeUjLF7wGM0LdTfAdIKCORy4pHTltuFPAENsVzdZZMc0rGNRIeJj?=
 =?us-ascii?Q?E5Bq8f1k0IlgkuAOnCV7by5KtGGdsmY77AoDLb5M4cUWg7JLGWnLkjNgOHLB?=
 =?us-ascii?Q?c9LC9IcKy8gye+4bmi1Xuejku99dc+gJSW5RIyKTP7imGwBe6jfqCKAp9iYw?=
 =?us-ascii?Q?HacyWxXxnc93hFWNZVLZMshu4os6GSaHtTOy5ezt/Wm76tjPWhK6mgDP+uqv?=
 =?us-ascii?Q?loO6FLVUtYMku8nxtbBoOH7oKa/Xay3EoFiNV3wPNZMa391usO29XeEkdtPt?=
 =?us-ascii?Q?FJPxlWuUM+tHQZzjpnIl/3NmPUW7DWCO3YM8T90R10lkvgE5WlWAZSbJAm1d?=
 =?us-ascii?Q?N5xSP1C8gIiIU2P4nNpmQhRi3y+T9cc5MPkE4pZPEDMd4zazSfpZW45t0qEY?=
 =?us-ascii?Q?DX4S5MfpXgmx/i0XCLENqZ7HMK0Gntf5a55rQDJYy8FKDTmaVPgn9W6XZZBW?=
 =?us-ascii?Q?AybQ0Pn/wBdrWWvTFyIFv1MxJgIylHIUoDvRCpI1ToWJbY4hsYdWj8E+BpWi?=
 =?us-ascii?Q?/9J3tVZE8yWAumOM7hUFfUj1qJuT+VPIGNW6zgKn2a5rk20AZYGAa9neh02B?=
 =?us-ascii?Q?mMaR9X5jvmzK7BT5f+7X7BkDgbr5Iw1dTlakNhsACYwsQ87dPXumbjvpwuIm?=
 =?us-ascii?Q?Pw9hI11sUDpvjDj5c8ZrmxaCf84ph9pha1jkwbQZK2Gs/WiMqUSpLGvn/QZq?=
 =?us-ascii?Q?vW4NXqAkfgsTQhlnS5GAUpTVRMh8fGyaRaxw4gC+jG/skdUQv4Z6aB8oEWdi?=
 =?us-ascii?Q?EKmsrv92LmhiLq/+Ngu7R/o3eVoNN8fVLU4TAdb6E2tWVzGa+zPw7UyFFVlN?=
 =?us-ascii?Q?jbP/9xELQntvLbjCcqULqvgNKYkx4eYfuOMhffc+l6Vlkxx6XgAHI8R5FV5e?=
 =?us-ascii?Q?Qhxp4OGsyx8BGeF6Xwpu6Ad/xVCl65NLFd6ukQ/fJE/fl0EbIel3YZvyzdiL?=
 =?us-ascii?Q?YhJpsdbi3+JCNaIY/tuaxlmARhVlDAU5syvuW3AwGBRaSSwG53CecP34kG0c?=
 =?us-ascii?Q?f1uevtm/ZB93ZRKlvsSdHQexpkt6qJ7rJSsG4A1Mm3mVzUTV9rOti718Cidu?=
 =?us-ascii?Q?gCPhnowP9Y+I5+Q0M+7uIlzKmvviP7roCZAtHJu2tA7LtcnayOoz3yBCoaZf?=
 =?us-ascii?Q?HlOYdcpNu+SSHqAr+ldPuzcZiphOvy4+97pE6mqNhG+J1f2ac3w1/BNvpRVq?=
 =?us-ascii?Q?X+/l4q+DiMdM/g3ki4mNdgoFPFwerF3tFVEL29SEsO1KPGxWftjQYxrbRpaw?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wTm/A/4oc5OPke3Kns/Aq6f4GJ34YgoR1JxzovQvFtSnZkUirENX6bLzgRgug7jEptKcj1ud3hULrPMq3nmb+ZRY+b5bVCIbhey8uN+Vbd7/gxpoktWyKO0fdTdgNRDYmVcZYs4Xt7tyNyORpPQDm6z7K6CXnrzeh8U4QjryBN9dznPnisHg48NcXLaskJguKkJkfYAlmx4sY607rBIT8+gEwSmom3tTjnfA2u7yx1uTpVqFmYqoM0rsFdb2xXxtS32BxpVlsfJaUo0LzzTalFwIy7Lpv7Q6S/5Z/rvnF1Belgi/23qOIU3Lb1R44+G2SJOOvBz8U/xztLtLRnI8cJU6xfV6GF6G7OHrMowR4tb7JdrbJ5BwL8tlyIN0zGXjI83vsznaK7aqkHvzvYQd+zxFkU0rLvjgHbnpOZdGwhrmWB4ScyKYYzH9vLZ5fV1vLyA8MRhsCh4AzpOBMu0a8ubqcuXESbpfH53WRHHt7SmSt08QaDpGA3MsmzGyJJHsMk0lNNDUJQXO3uErSwXmEA7vtFHDntezb5PI18o4ohLHZc0sWd2vuy334goR7rTw99KGAG1BYXWCAOaHbgBv2N/JYnS9EcFl3QY2Tsqu8U8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d1b6c5-3501-45fb-dae6-08dced42ac4b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:56:19.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtFSLgDYCTz+BGX86lt177g7RaqJJZ1T2n/77IhH9w1eJN+J0IW0lE3u6IeOkm78oGaaUEkFZt6rvLXrPZ53W+6qY3Enyi1yfGtOrnfe/Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_13,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150122
X-Proofpoint-GUID: HXnmHst5Qkx1XkMSPtEYe8ZUwKq8VBPo
X-Proofpoint-ORIG-GUID: HXnmHst5Qkx1XkMSPtEYe8ZUwKq8VBPo

Currently on fork we expose the virtual address space of a process to
userland unconditionally if uffd is registered in VMAs, regardless of
whether an error arose in the fork.

This is performed in dup_userfaultfd_complete() which is invoked
unconditionally, and performs two duties - invoking registered handlers for
the UFFD_EVENT_FORK event via dup_fctx(), and clearing down
userfaultfd_fork_ctx objects established in dup_userfaultfd().

This is problematic, because the virtual address space may not yet be
correctly initialised if an error arose.

The change in commit d24062914837 ("fork: use __mt_dup() to duplicate maple
tree in dup_mmap()") makes this more pertinent as we may be in a state
where entries in the maple tree are not yet consistent.

We address this by, on fork error, ensuring that we roll back state that we
would otherwise expect to clean up through the event being handled by
userland and perform the memory freeing duty otherwise performed by
dup_userfaultfd_complete().

We do this by implementing a new function, dup_userfaultfd_fail(), which
performs the same loop, only decrementing reference counts.

Note that we perform mmgrab() on the parent and child mm's, however
userfaultfd_ctx_put() will mmdrop() this once the reference count drops to
zero, so we will avoid memory leaks correctly here.

Reported-by: Jann Horn <jannh@google.com>
Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 28 ++++++++++++++++++++++++++++
 include/linux/userfaultfd_k.h |  5 +++++
 kernel/fork.c                 |  5 ++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 68cdd89c97a3..7c0bd0b55f88 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -692,6 +692,34 @@ void dup_userfaultfd_complete(struct list_head *fcs)
 	}
 }

+void dup_userfaultfd_fail(struct list_head *fcs)
+{
+	struct userfaultfd_fork_ctx *fctx, *n;
+
+	/*
+	 * An error has occurred on fork, we will tear memory down, but have
+	 * allocated memory for fctx's and raised reference counts for both the
+	 * original and child contexts (and on the mm for each as a result).
+	 *
+	 * These would ordinarily be taken care of by a user handling the event,
+	 * but we are no longer doing so, so manually clean up here.
+	 *
+	 * mm tear down will take care of cleaning up VMA contexts.
+	 */
+	list_for_each_entry_safe(fctx, n, fcs, list) {
+		struct userfaultfd_ctx *octx = fctx->orig;
+		struct userfaultfd_ctx *ctx = fctx->new;
+
+		atomic_dec(&octx->mmap_changing);
+		VM_BUG_ON(atomic_read(&octx->mmap_changing) < 0);
+		userfaultfd_ctx_put(octx);
+		userfaultfd_ctx_put(ctx);
+
+		list_del(&fctx->list);
+		kfree(fctx);
+	}
+}
+
 void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 			     struct vm_userfaultfd_ctx *vm_ctx)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 9fc6ce15c499..cb40f1a1d081 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -249,6 +249,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,

 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
+void dup_userfaultfd_fail(struct list_head *);

 extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 				    struct vm_userfaultfd_ctx *);
@@ -351,6 +352,10 @@ static inline void dup_userfaultfd_complete(struct list_head *l)
 {
 }

+static inline void dup_userfaultfd_fail(struct list_head *l)
+{
+}
+
 static inline void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 					   struct vm_userfaultfd_ctx *ctx)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..597b477dd491 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -775,7 +775,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
-	dup_userfaultfd_complete(&uf);
+	if (!retval)
+		dup_userfaultfd_complete(&uf);
+	else
+		dup_userfaultfd_fail(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
--
2.46.2

