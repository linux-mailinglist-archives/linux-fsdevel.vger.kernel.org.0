Return-Path: <linux-fsdevel+bounces-55264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D7B090AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1199A3AEF16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975A2F8C59;
	Thu, 17 Jul 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+ZgjM6z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SPZ/ix1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0B237180;
	Thu, 17 Jul 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766511; cv=fail; b=O32HhMoELhbSQqbrv962ScmEkOjYs6fPAW9jg7A600kaqDmeCbnbaf0O6XCMgQdVhDG54pwdRdAjFoCOFMnkQxHcsCjPZTal4AfIG2hQ8SCeLp9nGWQNdJ1XGAzd1yMJ50odPkY6UZepOq5zj8Pl1G2XtcDyK5blXtFHTP/r5JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766511; c=relaxed/simple;
	bh=4egk9fVkQdYKo+3Ooy4+BNTaWMrbjdSf5BwVUn1usB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDyGestLIsXN14uEjgN7OYMnd/HVNqud7bdBjwHHM5TGho426KU8olEBcaODzF/6SYh3xeKHsowlcgQSakcZt5ltc0F1O+FN+KY9mCluGtp+hObXRANdFr1q9Oe+DTKr+jhoS44U3gTnWxY7IOQrXpHP/S/8pGN6+BIjyQl+FSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+ZgjM6z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SPZ/ix1r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HEfwdX005270;
	Thu, 17 Jul 2025 15:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KoYqtUwcXqM6LVGFet
	mCdSB+k416dc2TXAq9hisQOQk=; b=m+ZgjM6zD+052DnnAY7Z4O3elANFr1z4Jp
	33SPUDYuD9kjJRIJ90SlPJp3zd1/LTyymprEdM9On4veLweWjbflFjcAVXuo20aC
	d0YGxtnsNbE8VirUVBXPX4/9C0r2obbi1q+1uoyKmumKmpBKPIwHqLn+r76nnRC1
	cD779PSnvPno1YdZHWPbSesekiSJa7xkrKHgrAB7eUEVprz+qAyMeihNjQ05y8yH
	KFwIHgfiZA1KXhWaw89lMzDfHNjTDY75QZCInKYsym1OZoaAeN9FBXyP2cRKNtxt
	/NNxLFsix16Sobviky4ZTpSH3AAnuI6ho7zazbTrWvmqrwZKGr1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqv6dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:34:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HEOw6L029626;
	Thu, 17 Jul 2025 15:34:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ckjh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK6uohta5yoY47t19zEij0H2n4wzIwHwGPGJ+yITSwRWZ9hq64RzWFfo5fCuAQSH/OeSCU78HV99Y4zhyytf8K/ioB0NGFdbxd6eRXZaTpCp2m568oiLemGyDWJQoVva8PbVXaUkBCqRbhksafiKQbZ9TMVgwtpmZ32kjDhDVWWfsBu1FKqa+Gt+I9vr3tzW+wwy5DgugB8tc8qRpelnyS16s0Ra8B2Aa1aOj7PFelTIi3xsEcL418L0IhYe6abfYEW4rFYQmuW4z+1DCjd1ctnirTSuvsTGgm054CkN0QnUp+dYK1P1/3sRG1CdoIlu7HJ51mXKPfJICONis4Mk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoYqtUwcXqM6LVGFetmCdSB+k416dc2TXAq9hisQOQk=;
 b=UP2Zrkxs/tBwTu48NZmYjeBgq3PZzKIWYgcckjdkzNg3Nn0xvJu76gAeeYvmqQNntUgakgz/asMoYB3WZxg/uVwG5FjNdSPwdP5GSHl86zERIBlH5eZ1xzqlrHzwe5HxltKQVQaDADlqeiYLG0L6QSrS+b/L/CLqfQsacHCVPRUgFtZW0HApSK67C94duUT/qsg8z1CDfcTZqOA1YFU2rY/GLT7CkIMTkLM91P5wN6n3AwkLNmD3eN50h5bO3N2oZ0q376GEuNVdqKZAsiidQ5aa9yArYqQviCZOzoL+L8lYhkP0Hfw6aeCfbKRbL06cjtIVQMsdYTNyDUdJLE0D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoYqtUwcXqM6LVGFetmCdSB+k416dc2TXAq9hisQOQk=;
 b=SPZ/ix1rV++3OKjZGSXOoC9ygNPai+hF6BK/wQvwuXsST3N8XFyre0Xu8K7XYXQwT7ZAlrqcq0fEEyAOBN3orVUR2zIVSeR8MToHI/1sneIo2if46Kvn2gZQ9i0S/Md/27j5dMN2amVPPyT5tl0eS9EAQXN8R4nqcdbIkB5hcOk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:34:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:34:22 +0000
Date: Thu, 17 Jul 2025 16:34:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 1/9] mm/huge_memory: move more common code into
 insert_pmd()
Message-ID: <22331b7c-93a1-4fa9-b7dd-5c8455dbb9aa@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-2-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-2-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0585.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbb7b7a-ed79-42ba-127f-08ddc5476725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZ09s18q9ef+vnq7dl4WHgztJYMmzfv4kEqB3zfm904a++OVsMeCjllDPF63?=
 =?us-ascii?Q?9L6RYawE1bkO4G4aKNf5B3dikYVgbidPv30+UqSMv0GEF42I+k6cHjwKpOZ/?=
 =?us-ascii?Q?ji/TYnGWd6uJlGpD83qmcXVvHB53PMLSmnKKjULtggq+GzlSHCuL9c+uH26E?=
 =?us-ascii?Q?2b9XYwQeWXtvZkoQZsv8FJikaBEVdEzLG5eijB44NQnn5Nr7mgzt+00aGwIu?=
 =?us-ascii?Q?e9/DRuxgjzUPruilPCACaJ1D1PPJ4+JW2cV9i8jkXzsi0jzb/wyC6Tk/cdHj?=
 =?us-ascii?Q?5sBV5uMs7PdxI0laJmGQz4ak8HKGvfLeB+WX4o74rHo4ILOdiMha6z7QQuC1?=
 =?us-ascii?Q?WAFVyYCjkmNpGH44J5W7E7GF4jBm5IBPiZ8W2B15+aJglgt36NgvoPUJ2f09?=
 =?us-ascii?Q?kYharerrQ1aK2bSYgLV+BAvfkAMxNnO6y9/bpOnLwgBkj9JAI1OhkQoIUB1b?=
 =?us-ascii?Q?riVwvr+EAm5D3uDvwK+D6JJOGIVhcT6xMbgl1QdtTYysNH8uefJcDzGFBo3N?=
 =?us-ascii?Q?pdx/Mc7yybHW6UAnLBAsDICKJS72rQGy+tasn9xWFtR2h3qKVsiOeOlS7PSF?=
 =?us-ascii?Q?9QRTENV4Qc58D8iiiD4gGvVBIKOp0Y17J6vecI6Q7YUGigL1YDy4zKhVz1gr?=
 =?us-ascii?Q?8UnyW0BGoVhkTEpKfFC5XSLNg13Vdi0dhqLyDF6wDGq9tsmiAPmohvB4oCOz?=
 =?us-ascii?Q?4zsJ0UITPf49Ui61BwZqItqbZJ+gVsyxBkr1OS0qvy0panV1cg2wlipktX+Y?=
 =?us-ascii?Q?rlWS8dYx6HDOiVF4YNnMjGezZL2AecrTbtDBqHbAbg/m38Z4cdlWXjwByv6S?=
 =?us-ascii?Q?orIMltMaV20WK+0gsGIH/nB//JOEIImUs46lMfNc1z61nLK//VKmO6SYWX1d?=
 =?us-ascii?Q?2fQtAdoJny3SxRX+M64010kjsJLK9xmWTejWtSORvUK8KmrcMtmqeA0yacrS?=
 =?us-ascii?Q?DfoDHyAOEr+EvENxjsnH2ElECDlEXfIUGn47DCJh9L/15eVjceMHN+X6bTMW?=
 =?us-ascii?Q?e3jPzwjhRw7Jdd0xWbC1OfaxJedieBWoZmyIErd9+m1ZaFHyP9PFTBya8atw?=
 =?us-ascii?Q?g6h5XGtItHjuGBCYBkCoD5s32hpNz+POljMlAoAfjWUWITQM77CVVXh3y/hn?=
 =?us-ascii?Q?kuNrHARDWWMrZQDC5DQvm7BIrSHLarTI1JyUkIpkNyidLcP97r0TUTkI2RjL?=
 =?us-ascii?Q?oNcc5yGSiHvonrWxJFlpnzwZlgmhkZizGzG7JMLcZSfdlnDQlFMgvqbeJfHi?=
 =?us-ascii?Q?wt1FyAylWDxTMD6aW0kb8YAU6y5EYx62UOI+8UuELI6NSnP39kowRI5nBWQy?=
 =?us-ascii?Q?8VO5AuVHaIgDGJBgkjyd20ShE4FFavEzw03OsmGt16Jpy4ZaNKyiIkKkbCy7?=
 =?us-ascii?Q?zzReElGSiyfm7wFFPlTaq4QpUzv2kWqSXPPG1a64jvcINxm2o9uW4sMyPxpg?=
 =?us-ascii?Q?hFiDlWjjgpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gToGlMN3K4NxSD2okFuji/taSeXnbPJ1m9pbPoPrpfiWETGAjlCAj4rn9Ha5?=
 =?us-ascii?Q?NCSGbNC5Ocyza7OGmjFHs3r6EOMIZz0m0+wb1I3KQCD6mH7afkrA++sJ+IJO?=
 =?us-ascii?Q?fFUbVieFAqQTP9AGvGyKxYwhKYQZ/XWKKFpdoAsJe4qoCIgr64nWTaWjbH5Q?=
 =?us-ascii?Q?8g0grmDYawY2sqtSPhSMLge1KNWnML2ZzBLrwlNRwo9eL6I7iIU/jsLUe/rY?=
 =?us-ascii?Q?w1LfOdtlBerblDVFfSPhImKG4PxvukhWpV0sDoXkZSK7NG5Ed20cyIi6lbLm?=
 =?us-ascii?Q?aQ6ceBqrPtoCVsFd0WF5c877CAjMyoQ9T6kWC+YZ1P9dL0/n8+PEK8POTBSe?=
 =?us-ascii?Q?+hGbGKXpWnnNbPXoO2oe9HintJg50uxBvEu2Y3QcDtC28380mrXCe0FP+iQJ?=
 =?us-ascii?Q?6z0tMqkmsB0I6p10Fm6e1I+2Fnhzpk54IcqJhvLz9ACBV7+9hnGOYyhDAx31?=
 =?us-ascii?Q?6h95D5jgEu75ApqFcKtvebZyZn9QXIotEcMIYLyYb8HiqZLgGX/0qy3eXaOk?=
 =?us-ascii?Q?vV720pnpFmJ7C6uGpm/pntmNIpMyKPauOJsuNOE5T1oWm7om/ES65ScSLY5e?=
 =?us-ascii?Q?5nWZDFGhxE5plGSKI7FiTi6hygz6ub4Ml3+vveU5s/KTt+h1en1VdzNwi9AH?=
 =?us-ascii?Q?zirqTjCfSaBujjUSaUAPbBPEj600EGOhCufF3PKoJqdRytrDS1tlJzvUjT/N?=
 =?us-ascii?Q?d5ZjAXgiJmeVl6iGDXNsWGbzq3u7HPQGsjCdsAbs6/JzYRb7DyQnkyZzmTHu?=
 =?us-ascii?Q?w7cq18mAE3l/HEdCwoEoW9JRzdFzOIPoKKgdG8oqBzH6FtS97Du5S/FsW8o9?=
 =?us-ascii?Q?+lRochKwBiQuFgXhTfrAPVG4AmZDz8ITZZK/drQs0iPspvS9Zp7C1epMRS3o?=
 =?us-ascii?Q?S0PrPbVV6gzbKuAI39Y4h4VkSuM8nmT1c6lVgLcq7ySyZMebCSwIQk5qZL3Y?=
 =?us-ascii?Q?ZjdLX6iMovhNZt4a6rerdD4emdr5Y6QXiE5Nfhs6MPZ1pciUy735S1FAgQ9v?=
 =?us-ascii?Q?GB/RsyOc6gUGRlElyLTvftVXru5SQA4BFNVLysbJaMnKo2cxVBybE6kRUl6N?=
 =?us-ascii?Q?Fl05/9mjCbv6K71J78U/Y0G94weLcW8SCaFqWdPQDgJgUffaVLusbznuaAcQ?=
 =?us-ascii?Q?O8JUe8DjQzSRlrb5TnbYSmrkybkRD1zKpS7/M2ub+GYTdjF9QGL80YNB6Bzn?=
 =?us-ascii?Q?CR5SqsvPo7ajDRcBh2lZkM3wr20wwDd2mPFXJ6PNM1fJoRkYTeTdu2y/P5xd?=
 =?us-ascii?Q?gtKV7YpTIuDiz2brqLQGF/mS9msYIM/l6NJIcVAncDVSDnf/K0bS0QzkuKVG?=
 =?us-ascii?Q?KsoomkzopGHM2Iw3eIqB7xB+nvwCoj0ihezGmJdurNfCoqtxtQFdfL8aVDVk?=
 =?us-ascii?Q?3mFmlZxRpVeuZuqjiztrcQ20ahQrZaFzGeP/uvWhCZ/qoIXca5xMxrViUIfh?=
 =?us-ascii?Q?bBDWOAHXaYCaT72a2Lu7L6Woqce8y71EWeRLeBdZhZ+PuiLwrRbtotBFvwpz?=
 =?us-ascii?Q?vni/h6m+gNvSQBiLx2viURUJpZ/rkMDtCiZY76pXvovkXyYwnhjNY9C4xisV?=
 =?us-ascii?Q?nnbLgEBvhj0LyPs3fwhICZ5aBgzdA9yhVAnCWL3lNdeOK7R6U1gS58dVUP4X?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ARdvQsahxOrjY4a4Z6Duu6huCjYzZKvuUiH/0U/fFaWU7ndtql/WVMUH9ZNKT8FMgF2V3YGGYuadZcz2XslSRU0LhQuaUyLvRxgysfP6eHy1msX7t8FPCWXWLsqTtnMd5JT/OwvdzIfr3EiJQ0jhkFcYx0gU2ScO2yx0kGgbQVfSd8SLAXtqFZj+seonPXfwgyvn7UuORNKOPfBB4Vwg95LJHH/Np9BoMdptSnE/TpJUWkI6DKgtNcE2GNPrkBbztAXIWRqIQcGtF1K9p/V1Mygka47gFhQOA9sIeqXKKZQripzYclBdLayso1rB98vPhxZz2a3iYzwr2zwYyqde/DbfkRdlGPFbdxSvrBt4S82uqMt1KivZ+nfoyZNFrCXOr2vPXwbIxf1D1TQOb5hmJqQOiauKwuyu+1BjHS1WB2SzWSXpVvOlLJQhukj09k67Jop/bWet+sxdS/iqK0ByUd3knNrWyzvRCC2jFt2QzpxojXM2EFlz/E/g4m7+Kpp9uaWOKFiaYLHH8FNXVbQrEY4INWC7rtL1orWYiKRyopbpKVKMzBdy5dejygncmdqkYBeAvb7LCY664Dy2nLyvrnm1BWxVzATnSIISSbfeiEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbb7b7a-ed79-42ba-127f-08ddc5476725
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:34:22.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQIEfhYu5pd8hAzNhpFqtDu9xCjZjNQGfoXvCaKyT3PJ4POgWClGcao71RVy7D/dp6XulxXZpe8VW5nU22wmdBl1X4y7WUp8rVVILLuzavI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170137
X-Proofpoint-GUID: uYzcgfnX_sihDq1A9LZYCSotedHGVvVL
X-Proofpoint-ORIG-GUID: uYzcgfnX_sihDq1A9LZYCSotedHGVvVL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzNiBTYWx0ZWRfXzDRU5gU0dbOZ mNkKvJxbwH5GRRP0OrFZAQ2qrIGPYmAfH0jNVgqgkcN/CYUyzG6nWxUkDbK0PfQp01HOTamubXt 0buq7xGC89vKK1W0wAx68dtAtV1TtiBHSURt/S2eDS9tPPEmlmzFcOAs6Ske4MJb4FuqyFk0eo5
 HFuvotJuXeuRF4ZqtjbqTukIIylrHHWIPyp6DX4ko3KXC7u2QCMscGMgHHC8rtqQIWZ+b6sSCc4 G9r91IS5rDaWoxf56rKtBPGNKjoSYonZ7xPkKPVFM6O76LFCUJuKBwxUUqNpS3zatOAgZ6BYKS0 JjAdzR3bO5wXzpHqNJWXN3m2cG09HFyeoTnisQw9dFMfX7w+DYKRmkmrcu0sR2Q53AzpPipsQFv
 ZQLLD7xHAspEYez3DLdOw1yxyrBF0TETyD0V7hRkbopeZqp0sEfRr0cr+gTq620HR7OjhNJ3
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68791803 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=jwnsAkHm-7i1EoQiDSYA:9 a=CjuIK1q_8ugA:10

On Thu, Jul 17, 2025 at 01:52:04PM +0200, David Hildenbrand wrote:
> Let's clean it all further up.
>
> No functional change intended.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Very nice!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 48 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fe17b0a157cda..1178760d2eda4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1390,15 +1390,25 @@ struct folio_or_pfn {
>  	bool is_folio;
>  };
>
> -static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> +static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		pmd_t *pmd, struct folio_or_pfn fop, pgprot_t prot,
> -		bool write, pgtable_t pgtable)
> +		bool write)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	pgtable_t pgtable = NULL;
> +	spinlock_t *ptl;
>  	pmd_t entry;
>
> -	lockdep_assert_held(pmd_lockptr(mm, pmd));
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
>
> +	if (arch_needs_pgtable_deposit()) {
> +		pgtable = pte_alloc_one(vma->vm_mm);
> +		if (!pgtable)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	ptl = pmd_lock(mm, pmd);
>  	if (!pmd_none(*pmd)) {
>  		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>  					  fop.pfn;
> @@ -1406,15 +1416,14 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		if (write) {
>  			if (pmd_pfn(*pmd) != pfn) {
>  				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
> -				return -EEXIST;
> +				goto out_unlock;
>  			}
>  			entry = pmd_mkyoung(*pmd);
>  			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>  			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
>  				update_mmu_cache_pmd(vma, addr, pmd);
>  		}
> -
> -		return -EEXIST;
> +		goto out_unlock;
>  	}
>
>  	if (fop.is_folio) {
> @@ -1435,11 +1444,17 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (pgtable) {
>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  		mm_inc_nr_ptes(mm);
> +		pgtable = NULL;
>  	}
>
>  	set_pmd_at(mm, addr, pmd, entry);
>  	update_mmu_cache_pmd(vma, addr, pmd);
> -	return 0;
> +
> +out_unlock:
> +	spin_unlock(ptl);
> +	if (pgtable)
> +		pte_free(mm, pgtable);
> +	return VM_FAULT_NOPAGE;
>  }
>
>  /**
> @@ -1461,9 +1476,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
>  	struct folio_or_pfn fop = {
>  		.pfn = pfn,
>  	};
> -	pgtable_t pgtable = NULL;
> -	spinlock_t *ptl;
> -	int error;
>
>  	/*
>  	 * If we had pmd_special, we could avoid all these restrictions,
> @@ -1475,25 +1487,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
>  						(VM_PFNMAP|VM_MIXEDMAP));
>  	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
>
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
> -
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
>
> -	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
> -			   pgtable);
> -	spin_unlock(ptl);
> -	if (error && pgtable)
> -		pte_free(vma->vm_mm, pgtable);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
>
> @@ -1502,35 +1498,15 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address & PMD_MASK;
> -	struct mm_struct *mm = vma->vm_mm;
>  	struct folio_or_pfn fop = {
>  		.folio = folio,
>  		.is_folio = true,
>  	};
> -	spinlock_t *ptl;
> -	pgtable_t pgtable = NULL;
> -	int error;
> -
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
>
>  	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
>  		return VM_FAULT_SIGBUS;
>
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
> -	ptl = pmd_lock(mm, vmf->pmd);
> -	error = insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot,
> -			   write, pgtable);
> -	spin_unlock(ptl);
> -	if (error && pgtable)
> -		pte_free(mm, pgtable);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
>
> --
> 2.50.1
>

