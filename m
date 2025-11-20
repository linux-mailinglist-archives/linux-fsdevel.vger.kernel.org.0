Return-Path: <linux-fsdevel+bounces-69224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C701C73E84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54987354C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF08330D4C;
	Thu, 20 Nov 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nWxDQkWz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VyKK7ICs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3A20459A;
	Thu, 20 Nov 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640573; cv=fail; b=SSVg+nEHoKSEnca/i7hKIofwYdavK8ytBPUaZ66gDafovbt1WsUAjd79hkgStzmiwDrOlJY0jCjHcHZPOjXIG4KPmfMtRrjy6vC/g7qb8ikvkAYh8fayXcIXTU0IbgVSO8rwqeSmDfmULtB5h2xqNyHmoB1neto73VCqiYGCE60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640573; c=relaxed/simple;
	bh=8N9Z2qz/aPaY1bwCKi4TrYhphlcItcxT/gq6xrr8ajY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oyhZPl1ECvXfgTYBEtIDEucxOPp+5Ig2AVWp3JqjauvXbbNQ1X2MsfVm01Axblryy8XNMCr20b3p1nBXWFoy/j20CIXdsj88Z3a3zQShg/3NKjBTA2wiZExpAVtDUQ7g6hl1x9+tdGte5xpYDeXRKaEuDb5BukAPfBz9TRBxwa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nWxDQkWz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VyKK7ICs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKB6feY008728;
	Thu, 20 Nov 2025 12:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kGx6rTnYT7Hd6AU8ED
	8gO8XCVsk/a3cuQttexsc+OpM=; b=nWxDQkWzgUujo5cOOwfVOdQPmPvbNuAd2q
	fzEbFYi49YTED8iDOxsn64ZK77AvXyLwGBAF8WvJ/p+CXwfbFsL9iSW0Kl5zkDbk
	451NUjmp8G2WR+t5d/wOuEkl2qZDZUErBxQLdsKkGSH0auOFLsP9cN1I406f6dzm
	lDhGj8ohRjEcY6/VghbyxjThp2nYwROuzPiLkmkvmJ5gIFK+lk5zPJUBqu/UUqpo
	CjymDdWbeEZajq0EbX5sLq5Dz257mrAkWhCD2iOGvDjWbjKP4NVY7oJ0VK5u+ODT
	rExSdOxk6Wq20VRXDU2Njefpg4em/ayvi4egwMpV8tKwGI4/iOEw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbursrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 12:09:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKBP62l004341;
	Thu, 20 Nov 2025 12:09:11 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybr42f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 12:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwVYYB3We2kkeOgo8QMaLhh7Dcs/HVZpbGWhod84wvnVeZqdrBQ2thmxF11b4+IveRBz1UB32KM9E98lcmcWLGgLAvvfnUh6G/lAOIZ61Nx7PoyKyfxYAC+qwEEHmEHrwDMICpHhT5cZ/o9dOp1gFHYNLYfCyX+anNhD18EkSpdezMTKDD35vx8laNQiULg8mzJE91UvBV2oxiTBBkkeYswcySJp/lI5n0G2YCOmyL1TYOoEDReJ9TYC1Y8yWtrsylawEZRfIfzG2D+qD0nacH6QDjPUsfrMD4USUEXQjbc0Noal6wQhlnyGdve+fDVGoLah98ymTo2gxIUjtC4dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGx6rTnYT7Hd6AU8ED8gO8XCVsk/a3cuQttexsc+OpM=;
 b=PFv0lj5xAhy3Bvqw0ZHsi3v1IfyyU/3G4l9wYbUqOO4PdF+nLV+jqUp67LVPCUCQnyu4sOxQee507z+y6o8p5wr0X+a4HtgrANpdUc2e36+RF/Akk9/km70/szIFlL3uksCxmUVJofp0PdLnqnB7AjxYoM9dDXIXCq9UuxNdonYHhicHMtLJfkueqWZev2Up4spDGEerKLD10L1joIlQbWDuPetSka6A2HNZPL5Kr+Azd1u5awec9mA/JEd8J8nMXnic84IR2+GEwOTLo0L1cepqjH0MDHdel4wB+Gr5OnfPcDWTBu4rmLCffEJa1Ay1fXSwqRUCE2Ju9BhKITLP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGx6rTnYT7Hd6AU8ED8gO8XCVsk/a3cuQttexsc+OpM=;
 b=VyKK7ICsnhXWLfAUKwvywr1G83jju9b7KDGOuZMnWhIz4iPxXtj1ntrBdG7SxoTdJ00piICqPeKPXpUVTaPMtW/cN4WxByM91bWi5diGH4XF87aMK2qepQ3JIH1pixgqPBfXZx7JdLgQS5r9qa/xWm/qLnKxQKRntGNP/AYv3ZM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5744.namprd10.prod.outlook.com (2603:10b6:a03:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 12:09:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 12:09:08 +0000
Date: Thu, 20 Nov 2025 12:09:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>, Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <3330fff1-5c45-4ba6-8f22-7501e0e6383b@lucifer.local>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
 <0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e516d0-5ba1-41fe-0bd1-08de282d9bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abmTJcyHBAYG/DjiKw5Y4RSKPx7EeRUtRhgcmfCtsbAF4q7qScLKxs7cTLeE?=
 =?us-ascii?Q?KkSPe4ZXbyXv59uDBBPtsBC9tlvwQ6q7O/4mcVOD5ZtLfaIVJNwJymbvTUrO?=
 =?us-ascii?Q?U4HTNPcDcuixIkvPFEmEBD+uR2PUbye0p7nzO2tysu4UELK1VrWeno+D54Pv?=
 =?us-ascii?Q?68GTd+Ad0PdMWdxF+od3sid6Qr6fNYqd4EmkNmzoCn0lY6cZDxXFij0jNQPi?=
 =?us-ascii?Q?T86yqWBJNerTFR9m2JfwCOmX96OUEf95qePTNFyOIkN4NLNnwjRvnjStE84B?=
 =?us-ascii?Q?S5nsORVIC5KeJ+DepFMypaBtffHaoTDmZoKXiRPC7/hzzp7/eZSDS4gpXNTj?=
 =?us-ascii?Q?U4ffxTFEMh7Dkrgiz8gKINEkjb4MUZayoWwjF50a97O9fCxtbstMFFPaJN3D?=
 =?us-ascii?Q?r9F5ghzK7P44viN49otgcjQ1TD/wMa19kUWoQzNEYkZMtqXe0CaVMsDItB3K?=
 =?us-ascii?Q?+fNRVbJZNgTFsndEkfPnb4nA54xQq8cDGRY8JqCf85WWIFuwO1SrUBdWSiDx?=
 =?us-ascii?Q?GaGCWT3Kv4/5MdKO2W0P1qaafjj9ntXpTS7d3FNo2UxVmF7fzYjdh94LSYXC?=
 =?us-ascii?Q?7fQCeFK5VEtdMgUQ22LQBzBA5M3Lpjqgcn5sULT89oysknOva6603kWw0W9s?=
 =?us-ascii?Q?pp/gcd2MkrCSRI+FY3EwrUc9LH6/Z+5f4qA3hJiwLKSMLRaqmCdsvgyPoldi?=
 =?us-ascii?Q?0dNuAzTccY1Egrn1Q/kx7pYoAgax6y8LU4RDBZsdh+gWy6i5pkO5PiKPRGVc?=
 =?us-ascii?Q?Y7n5fi1D5wSI2DAGlYrt/9ReVBQEr6RtcHLkXv6VOcFbXcFdPLKRN+DucPkr?=
 =?us-ascii?Q?x7ziMgBSDDysgudh0YhHE8KtdwqmWcV8q9DWZ/8dnP3MBt4XkVw0GWMQr/Q9?=
 =?us-ascii?Q?7gmctGi7qnqM2RZwPdqbf0qsM6KOvpXv3VCEDAhrtm+q/SPOERXIa6iFi8R5?=
 =?us-ascii?Q?U/ihi6fQuB2lyYD3f3U7DPKsjbsVqb4j0Amlqy8tSojn055lpgIE+GHbK2F7?=
 =?us-ascii?Q?VWCRMSjYXRtWF3KQ2d57ltFxyc1vSVrPKevocr6ZfTAiusbUl92ZsLrdzVpP?=
 =?us-ascii?Q?wxtNL2XwuV4TlbvEsE6IVvufF5u4tq+TcGmjDmIPNI1ocdlWIM2Ba1GtT3Be?=
 =?us-ascii?Q?Yjm4Ah1XOu50NQ5x2kc9XeAWmfQgUjz7h/IyqmdvX+d5vVTbAIcFxKpSe7Ly?=
 =?us-ascii?Q?kJ7ERv6FiQo3Ojojdj1lJIEX7rbx3nEdTb0G8omft/fMRBEAenvtnifhoUhB?=
 =?us-ascii?Q?o3VHPhCSvRPGzqufExPcdGqQhJ16GJd0SygoJ4c7In7Uev/g1McwIrt86B/o?=
 =?us-ascii?Q?qEOeay/91NSUWxFkrtTkkD16SnYMrHAlNbDIJ2GH+I0V41Krj8DDz2wRV5v0?=
 =?us-ascii?Q?HvlXGsOvH52Xkuj5dionVqQxpna4m2pp1NG/Y9ZVuVcS9lxy5HCzT/CNRl/K?=
 =?us-ascii?Q?Mngt2Ck48dIE8kabvrPmbhZC0elPfhK1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jM01guC0sPsnqONjAKvCDCTj6EsAI46hna2cLZ5zsQibfTOgCTEDHOk9udqi?=
 =?us-ascii?Q?2WWYG9cOqnWPxs1QUjA8WXq3+fr+EQrMvVZn8KwIKVcz35+o2iN/8dcxikrz?=
 =?us-ascii?Q?SNMV2cA1pP76el91awL6roaOKLzXnzVC6sq+UIlFwIsixeAn97GE95wPYQBa?=
 =?us-ascii?Q?CUalKZ1c7jFd3Fi8YhYGAAbsIucGiTVyOMqZGjN1Xs/TU5azxP6SUEb4RZEO?=
 =?us-ascii?Q?VfQk7Ir9bcGm3GTPPdC8F3EduAxdXs9k6jx34SgFNkNT4p+WKCq7nxO0irwi?=
 =?us-ascii?Q?GnPDaVYzfW5IRLqiERUcUyb5wXJXIEZ8t73ngJoHhH8bsehVrxza2ZsMHT/x?=
 =?us-ascii?Q?dP/PlOmsbInc+xMEuLwhvu0dHBXtEbyjKV9EPDd2jGFz1MNuDiaah0htbHfo?=
 =?us-ascii?Q?RB5X57KqtTVb7zaGZtCEsW+Avm4BJfWq4K1QFT4+lncrikOFMz78IJUM/R/j?=
 =?us-ascii?Q?VrbDcuqKbIoNrZliX9qmfLilNEh1tzPlQQO1pl3V3mi7J+PEWlpoqqx8V/Ho?=
 =?us-ascii?Q?jX3Q3L3WSxdNp9CeFXeCt0Ly7xC2AdEy+ROp8rm6AoMeGBqyudPABryibKCx?=
 =?us-ascii?Q?gGJO04Px49v5Ec/Kgf14txx+nsq1wkMFZ25ON0RiYC6bIb/Kyr0jTdsr2Uut?=
 =?us-ascii?Q?x9noczR/GoL1Wm7hM2gcG5Tw4KSimtI7z96tWydE6WxnDWwZ5Ohr0hkJu34e?=
 =?us-ascii?Q?cv3GBZtDiW/TnnFVueqL/hj6djYK0yaKldfVv4G8kwxsfsZk7mNKTUJsqccU?=
 =?us-ascii?Q?4ixMmQiB94lrB2Z4qESn2frFdzIiNaSZ/p9dPkavJi2dcjOS0XvbPuuD2/82?=
 =?us-ascii?Q?e+t7JSw/6bNZze3spAtrV4ofMOi0ep+SCJpcbsx997ZBsHy3Z3wsrapaQoeJ?=
 =?us-ascii?Q?GNdGG/OUiunNfW7ttSj1Rhni6GXpxQJW9uybFhXquiVu23JLoS5+fSx5xUYJ?=
 =?us-ascii?Q?SNDTQ7YLCo/BAWMRB8hk3pLpF06eLGKa5mksynxKCZaw+ZYVuXWbnixbtE/N?=
 =?us-ascii?Q?RIFew3F1UVQGqrC74xJUA7U9YopRcQMnt873sNj4a/7AsZFoNZyR+iYggPjz?=
 =?us-ascii?Q?P9QdzzFFcH7djxaoQ/uJdIVD5Bia7HsTbJlOh36kkGy9IctO4UTvHIeq7+QJ?=
 =?us-ascii?Q?mbusfQ+0NrDfx3MYFY7MfqdiqTnthY/JSNYthqyA9rpZCJD214CeInXYVd7y?=
 =?us-ascii?Q?e4P4MnY7XiVcn1LRUscDwYr7mVHWueDHjLNqyX34sDVjtiU+Od/vj2MSWSWC?=
 =?us-ascii?Q?ibodsP7Jjk6rgYfyqz1g4n8qqBsHy8z0po4nHnK15JV0z6WJBi5cla9j834p?=
 =?us-ascii?Q?seb9O8U/JwQj4zUrHlk8XVrtiLUwdbTG/fZc9zk7eaajYJJsOdEehTjUPs0s?=
 =?us-ascii?Q?2fP1ry2EiH/XC41ufeu0EwD+cOnXlbHhjPBvdyQ19p1mAXa75Lh0tjNfAE/1?=
 =?us-ascii?Q?RXjTGgga25DsrxjlZceyWP1nNfuDz3jmKEBQjJdoIjdAe/+e/tFfQZKFH02L?=
 =?us-ascii?Q?l39lwcfT8bU7VLCgeMk7oR7e6WcwzN9ZEFUSITE5epdj5++PYmm15pJaKSXi?=
 =?us-ascii?Q?Jx39lXGzZZP9PaUIY4k7lgQoMEVB6HGBqIre7JFvMPUSXqYYeARHcLzsMw8+?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9IuDX0qfFYEo44lE6cnuyTDxEOgvhZAG5anhMPGWDTGff3a854YDkdJ40JUsaMk+F0rcjcr1k22VFn3DdaA6OjrcDsduYa74bbrYeK2CU3fsQmzyJDJ17tF1/tOV6esncuVwl5/LxUvSUApU1X6swJnvR2/8VO3ZsJofdEgsDjXnZCxfrrWDK2OiRsZN/pL9TuHERcByaBHRB7yduSkywIf36I/l2kFNsRkODIxGAzCnxoKyq9OfKgKDK09cTWRZexmFcnPTb1o4iFj+BtWxyYFYRyYRf1WqxX5yGgKDOk1X2k57zsFOfmBKUDxpxtFSHRH6TqEXSycARMPnNhNO7ihbO98i1nQEwn+PjKUj/4rJbn7X2CDEWwduZG4v4gMSC3DjCOlUG74ny4Igs57TAfJEn0c425QS2l13BN9bzv3TnU6kfcgCG0rxglsu1xJKKjRC3SKPnRljO/rDixdSds925/UdiS4BYTi7yVZKT7d5BtIevjmIaH+wDdsgEGRXjUXxCTMN5J5A4H1R9+HsF5KNlA+iV12l/s4xRXnGxnu9091An4ENKdCiyST3Cr3nJRCYZk7dpadgYn4ig7PYnJhWCz6GCrbRghu9CGQumZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e516d0-5ba1-41fe-0bd1-08de282d9bca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 12:09:08.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRbLUrJzxO+vXU/7D13KD03NNOZkL1iPPluA2OC/HzQozoG6wt9FYFUcGLBiz8ONAzshxQovC3K9fdOZ1AEfQBjgLy7rFXdRUoVJbK1emVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0tmq55KyRNhF
 lAtz3M5yqX6NmPfwgdDtWWLUxIhHPOSQufGBewZjDuMDU76d5/7NaxYfJdTHv08JDzS8UQ4MeQL
 wlk/Eyua0HcyQVfjzS5Gnc2McEHUXKIKbJafA4ab/1+L66yeD29ShdTmHrW78er4HjlqLnx1/iy
 qiINukV5PU1P8q3LnWAyRQdMCKpNZB0j3rxE/5kIYQVsyfnBqC02o6NRUGrJZ7hhl6yhQtSlS2r
 aJ3dyu9LofCIWrV28vTBNa2lrcUidkVm1QV21BT9SPky+jmt4SPY050nackiFVQ1gXZ/K8fV5I8
 ytnP0Ria+Rv0G55pK8csWF8B8dayaL2X6l8WgrIh4TT95hPnD194hbKq5Z2ti3yA88mfcUHAzhR
 rViH4r/2nwbFHxGHWcoJiPbCmjElGQ==
X-Proofpoint-GUID: Hc0cyazDXvz2YFyQC0qOKsBxO9k-HL4g
X-Proofpoint-ORIG-GUID: Hc0cyazDXvz2YFyQC0qOKsBxO9k-HL4g
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691f04e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=kgHi4e0kVQvgMnxFnJMA:9 a=CjuIK1q_8ugA:10

On Thu, Nov 20, 2025 at 10:36:16AM +0000, Lorenzo Stoakes wrote:
> I guess you decided to drop all reviewers for the series...?
>
> I do wonder what the aversion to sending to more people is, email for review is
> flawed but I don't think it's problematic to ensure that people signed up to
> review everything for maintained files are cc'd...
>
> On Wed, Nov 19, 2025 at 10:41:35PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.
>
> you're changing min_t(int, ...) too? This commit message seems incomplete as a
> result.
>
> None of the changes you make here seem to have any bearing on reality, so I
> think the commit message should reflect that this is an entirely pedantic change
> for the sake of satisfying a check you feel will reveal actual bugs in the
> future or something?
>
> Commit messages should include actual motivation rather than a theoretical one.
>
> >
> > In this case the 'unsigned long' values are small enough that the result
> > is ok.
> >
> > (Similarly for clamp_t().)
> >
> > Detected by an extra check added to min_t().
>
> In general I really question the value of the check when basically every use
> here is pointless...?
>
> I guess idea is in future it'll catch some real cases right?
>
> Is this check implemented in this series at all? Because presumably with the
> cover letter saying you couldn't fix the CFS code etc. you aren't? So it's just
> laying the groundwork for this?
>
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>

I mean I don't see anything wrong here, and on the basis that this will be
useful in adding this upcoming check, with the nit about commit msg above, this
LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> > ---
> >  mm/gup.c      | 4 ++--
> >  mm/memblock.c | 2 +-
> >  mm/memory.c   | 2 +-
> >  mm/percpu.c   | 2 +-
> >  mm/truncate.c | 3 +--
> >  mm/vmscan.c   | 2 +-
> >  6 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index a8ba5112e4d0..55435b90dcc3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
> >  	unsigned int nr = 1;
> >
> >  	if (folio_test_large(folio))
> > -		nr = min_t(unsigned int, npages - i,
> > -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
> > +		nr = min(npages - i,
> > +			 folio_nr_pages(folio) - folio_page_idx(folio, next));
>
> There's no cases where any of these would discard significant bits. But we
> ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.
>
> But at the same time I guess no harm.
>
> >
> >  	*ntails = nr;
> >  	return folio;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e23e16618e9b..19b491d39002 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2208,7 +2208,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
> >  		 * the case.
> >  		 */
> >  		if (start)
> > -			order = min_t(int, MAX_PAGE_ORDER, __ffs(start));
> > +			order = min(MAX_PAGE_ORDER, __ffs(start));
>
> I guess this would already be defaulting to int anyway.
>
> >  		else
> >  			order = MAX_PAGE_ORDER;
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 74b45e258323..72f7bd71d65f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2375,7 +2375,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
> >
> >  	while (pages_to_write_in_pmd) {
> >  		int pte_idx = 0;
> > -		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
> > +		const int batch_size = min(pages_to_write_in_pmd, 8);
>
> Feels like there's just a mistake in pages_to_write_in_pmd being unsigned long?
>
> Again I guess correct because we're not going to even come close to ulong64
> issues with a count of pages to write.
>
> >
> >  		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
> >  		if (!start_pte) {
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 81462ce5866e..cad59221d298 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1228,7 +1228,7 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
> >  	/*
> >  	 * Search to find a fit.
> >  	 */
> > -	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> > +	end = umin(start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> >  		    pcpu_chunk_map_bits(chunk));
>
> Is it really that useful to use umin() here? I mean in examples above all the
> values would be positive too. Seems strange to use umin() when everything involves an int?
>
> >  	bit_off = pcpu_find_zero_area(chunk->alloc_map, end, start, alloc_bits,
> >  				      align_mask, &area_off, &area_bits);
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 91eb92a5ce4f..7a56372d39a3 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -849,8 +849,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
> >  		unsigned int offset, end;
> >
> >  		offset = from - folio_pos(folio);
> > -		end = min_t(unsigned int, to - folio_pos(folio),
> > -			    folio_size(folio));
> > +		end = umin(to - folio_pos(folio), folio_size(folio));
>
> Again confused about why we choose to use umin() here...
>
> min(loff_t - loff_t, size_t)
>
> so min(long long, unsigned long)
>
> And I guess based on fact we don't expect delta between from and folio start to
> be larger than a max folio size.
>
> So probably fine.
>
> >  		folio_zero_segment(folio, offset, end);
> >  	}
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b2fc8b626d3d..82cd99a5d843 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3489,7 +3489,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
> >
> >  static bool suitable_to_scan(int total, int young)
> >  {
> > -	int n = clamp_t(int, cache_line_size() / sizeof(pte_t), 2, 8);
> > +	int n = clamp(cache_line_size() / sizeof(pte_t), 2, 8);
>
> int, size_t (but a size_t way < INT_MAX), int, int
>
> So seems fine.
>
> >
> >  	/* suitable if the average number of young PTEs per cacheline is >=1 */
> >  	return young * n >= total;
> > --
> > 2.39.5
> >
>
> Generally the changes look to be correct but pointless.

