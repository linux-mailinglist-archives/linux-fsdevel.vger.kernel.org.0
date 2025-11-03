Return-Path: <linux-fsdevel+bounces-66850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C4C2D7AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11833B71A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589F31D388;
	Mon,  3 Nov 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kb6sqknY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L2KmtlJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266931AF3E;
	Mon,  3 Nov 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190920; cv=fail; b=d3ncwaXJfNFJrzxZHAMmnsElx064WZRoHoiWb8thi4VYqGayizi/oczlG0nHOImpnhLo4Q4CtVDI497iZkp/49aaS3eRm41IAExKEt4oNci413pFSGedh7iGcI+a43twiz8G09eGGZk2lTAgqbIdthpWL4/xEykcpJb4pwH9GAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190920; c=relaxed/simple;
	bh=SnhNRMaTOiHKfxRfsAepJTb2gUJYqGeUZFYqsBgO/qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=txSGbuPxUDXftS4IKklSFCx4uo1q15o9/j5tRGEDR1B+zjnyZkEj25t7p/YopgKbmCbQNno9RzFy4pmB0N0pnBviDqE/Aw8D+tuJvdfkwlMOjNnDeN3TQvwUEEsAL0tDi0MzLjicLP9Z9ub71MfFDUY4e6fqrY4Vg4mQxRIZ3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kb6sqknY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L2KmtlJe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3HP2Jo001867;
	Mon, 3 Nov 2025 17:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FSxJm2g57KK73F73Sc
	2SKMLGSMFUSgiUUX8NCh7PimI=; b=kb6sqknY0PbAdsxkh4Q7rTXHhkuIs3M2ew
	WBiRH4WmyQ3/82UT2CPKvb9whhIjPL2ZCmE+OUOUEQKefuOtj4XM9sVtPojmCcsU
	6ot9rkg8ph3L2FD++3ORH5ov9nNtK6Hl8dCwRAHMQt6/vHjxJdhMkTqpHmUjTe4k
	gfiTVoEWcZCYOIwr/aYEmRLUoSt8PgE5/nfAJH2V/kECt/+xrb6zEwpbsPS7gvV+
	ptIg8C7HDJHQFBL2GgI6razLqkdOjKL0F1+tns/nspmc2nrQNC5iwXqSh7L6/1H5
	TDJVbSMvV6bHq7bPpqSw8rfFgylQRSd5AYpY37CquW/NDxJIcY9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a70s00058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 17:27:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3HL1uF017143;
	Mon, 3 Nov 2025 17:27:26 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n86t0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 17:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMDtbmVmyPtFWMqydrPXb0gkRvw19tBDaORUWcvB9/Ic16d5TN4l+tZkmK8Rtc5/zIP9+uHrBvMUm9y3aBlVaywh+p6dhV+e+qTYVj0698mI+IA6GfuzxK7A2YvgfyhitPdErDYS2x+OIcijkcu1ye1hxwN060rHfpRT286NfuwiObjbSphuMlELkqOdv9hyt5cMSh4fED6tT5j0suPb6X7MMJTdGRX5XiA0myrSQ3OLZWzTa0KpnLIFfepowJwFrXGpmQWiTKGegEyb+p7KB1B4yPxvBA9UpkAzTNbIy3rEHQ/RRgGxJ1dLy2eC3mhuWvt5KQcm4dM7jqNOD5bwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSxJm2g57KK73F73Sc2SKMLGSMFUSgiUUX8NCh7PimI=;
 b=zVu0bA4n0xWEZ3I3dFPDIE4TLUq6qWrCzpm5V+jACXOcMzC5VWDX8ALiXbzGuoAsF0cnjzC3ol3rXBZrErx8WrI3UIqi+JVAo/NIzTbLEPVr4C4qSE+1C2UMwjN+NIcj9+n9XSBKNKilBgZuie5lgYoZIqQn2RrBV2RJ1MUC19ao1iKFaGIMBruI1dx6kI7zZ7GjkhQerZ9k2PMhciSbdpDFxplGoxmxKLbdk3m/3QtBM37KK0hEBHL437VSKa6SwpcdOK1UbT0xEmyBfqYP2DCVmUc8pAPVXvXDUGdmROjR6ToFzz60/ZVykslKN1E9sTxKbQXi9MG3r687LOziHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSxJm2g57KK73F73Sc2SKMLGSMFUSgiUUX8NCh7PimI=;
 b=L2KmtlJeswzDRJpNY1z6Yk2As4/BWe0G1W2AVR+QBPm86bK7rE4xzs5C0YO10Kd79Z8PW5i9RMaHObWrUdgFtJ+uH1uxT+aLcSw3KADOfV7oNwnx8WyJXhhNUiDcAOvKiBzW9A7Czqe8tnrmAZMB5XuSlard8CR57KrG2HguMxg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 17:27:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 17:27:21 +0000
Date: Mon, 3 Nov 2025 17:27:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <9958f105-c728-46ed-b0c6-7fbfcd2bd55b@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: e16816a3-d8da-480d-f9d0-08de1afe3f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3YKDC4yO0Xas3Wqn13e9f10KRc+Xv7xtsVM4PytN/s4YKec1PGE3lU07cEsY?=
 =?us-ascii?Q?x6Q2HssVi35Y30OILg/6J1cAC72Wi6Wa2XH2myYD+xmN7x9pOk4HvWYBkM5U?=
 =?us-ascii?Q?dzmS+UGP0EFmhgRbNa+Kdp5nTTnpfdxvgUQWfc/+CZGvQULDM1kkGUCem6Hc?=
 =?us-ascii?Q?hs2+Nst9RF+H2oS3ilFF7RoqUly6Vb4GyWVBc1pB1FGMouF+P0u4aNxXfFCI?=
 =?us-ascii?Q?EebycrvNQbvk7KAXCatFeOKdAWWnf9Ps7ehRbxyS2z/zOoEPQho/JxGGAali?=
 =?us-ascii?Q?1AFT9PAVt5a3Yk+qHxJQnphsXcU4AQd4cdrddjbajYadD6abnIpjyEvvPEt+?=
 =?us-ascii?Q?aS9J8mR84zqtptun9DlVtHkOSfqA7ArtZpAVGai51ZTxZha5uH5pyLyOUG/6?=
 =?us-ascii?Q?OUFmnbr49B9PSYO3Rma8CCWBv7ckn9T6ydfbLjscNJnLujjQY7JcAAPxP5IF?=
 =?us-ascii?Q?3b9H85yoEt4/Ko/DRH3Nc5WlMdqswJXgQf0xWmoR0JbQ8BAnBkScS0Q2qHtD?=
 =?us-ascii?Q?g6ISd+ideSXR/bRTz150rKvaRo14KqjlrA9B7iPW6byoiRm24mF8vV677JGt?=
 =?us-ascii?Q?vKL9GEFa3jrHV9lF7rVN5MU/THxVqPA+qUPh75RShkiHtN5EGhcpyZPbge4w?=
 =?us-ascii?Q?mEd/+mP+ILz6V230L42r0bCLhSSaZLTQoht6tZ/bgx0gCvIZV+ZJ95XFJCSb?=
 =?us-ascii?Q?VCU1KXOb3U0ClbdnWDciSlxCQE3H03zKoBsINF3H5BfvPNehwa8ngJYvgeDw?=
 =?us-ascii?Q?leQWtqUdtf0hJK6LYntd2B5HbKUv+XJtRORoqbGndFnx0Ktx9m4YiVJAcUQ9?=
 =?us-ascii?Q?2HHeWvXBsOlH4mRlUQsYeeypjo+1IvAunBuOwLxcaA9+vBJHF6l6dbb6aPFk?=
 =?us-ascii?Q?yz7vSrG5OjARS47Dw/L7x9LfX5sLdsR2CPizA2KkwRicbag9jOSuSvw7XOqe?=
 =?us-ascii?Q?XprJqBMqbPZEMRyv1RSM3NOKmZXBxgV0YjI9lyxEwxglJgBqAakwiLnsxADR?=
 =?us-ascii?Q?bngKKdnGSteZjXWDQXjQNDTBh+IDJsEW96WdwGLX4Ir16MeDVKGhZWWndbcw?=
 =?us-ascii?Q?OvOQr2TRg12WdjnzPnBiUt1GutnJLpfzzZZI/AYcyCKOjh9r0Aw7XQnslrN9?=
 =?us-ascii?Q?Kr1wa9uoGmXKS8u+VgNNNYXD8j60MTRRv/wgQbXf/VAnBJmEcdwbAV6TcnLq?=
 =?us-ascii?Q?YjrXzzCPINx2+xQkmzvfOBtK+d/meuCmZ2Vnk7YaBQjsK5iCnn/5BSrMH6St?=
 =?us-ascii?Q?URvLLLAqtDK4fXN+Pn1nAWtLGz0Nmbrmw+69nub+/DrTIsrR9I6PKTi+W4mS?=
 =?us-ascii?Q?ZHStjkRwCy3/9lsmFM8MXK8qpONgISCTimcEAtmZkZWOBwkYkoVVMvGvSXGo?=
 =?us-ascii?Q?VXuauHc+byAdtYdhBjvOQRYLO7nptObfvAeFmdFHTpK43ftwKt2KFxN8NTdf?=
 =?us-ascii?Q?y2o8w5owyif4OY4Ib6UtUw9a4tEV6kVD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8s0hzbUxVYCPcNpVhuBuzGRMpsTerG+49k2ewcK1VUDtcMA+iF3MgOgU9UXA?=
 =?us-ascii?Q?/NAKCfIhFwT4xJTQEBjPyyzj5JQwmk9oPCCXZ8YbPp0y2Tr+N5KmmMxPeYRj?=
 =?us-ascii?Q?bbOCmJ3bc+HWRmhVEMtX4rJ5zsh6Usurx8UA3Na/iyubVgONfNNSDet4DAeu?=
 =?us-ascii?Q?7T8U/NMALajLR4cePzOvi6rMPgc8oQh5UEZc3M7ITYkkeAlg5TVcH68m8dLO?=
 =?us-ascii?Q?tGlQkb//e6C9IVOWNVFWn3JkMbtpaMGrHl5wz3j0h+++Xt8vlrnx3h2qYkTj?=
 =?us-ascii?Q?fMiWDsOSpJJLT0y0+9RSqvUwPJDoa36JfNtnS+J/A7Di67Ry0c7CMOy9Zw9E?=
 =?us-ascii?Q?mHfSjVMMALT1IXm5jlRm0ns2i+8/QXzrvD0wwYPEOcb3zcYzEykKpg8QfGAe?=
 =?us-ascii?Q?KxUz93Dubw17znrlDZWQdefZ1Sxe1yINbG6iy874eg7n6mH4LeOApPjKIAZr?=
 =?us-ascii?Q?3QSL8O9jgwMVjB9FP07dbdXpZTBbU8FqPeou4RQutir7oudYco4/S2Q4wGRv?=
 =?us-ascii?Q?20pwWXgCA+wXVJvqA/EcTXu8o0cpuK417B926M9cB7XGKoTcOfYdEejgVbGn?=
 =?us-ascii?Q?0gs/DglKBkATqxVBjKrJnmdKA11KbMTrmmFeLSrf72hkfczJ8ef1CCLH7OKa?=
 =?us-ascii?Q?UIhPUVCUqzLgvkmVshwjj8EIRxOWZO1wrDZ61q9hh1NgBcHZXnmyB8rqHfd9?=
 =?us-ascii?Q?VTH3LAjH26UeIiHC7jLN3uIqynBTX41VSp9xW3qsQpQZCVboJHPVfHyWnqrt?=
 =?us-ascii?Q?zN1NoAWJT67FafJEU24/nLLpKW7gZ9ddnlXp3JvCbMUV8sPGK8W8XQVdJZPq?=
 =?us-ascii?Q?y8iFxeYeT6iN81zbEhlmYm+zb+W9ZDBnk0BK9573cEdwwWbqklnk+JusRsQK?=
 =?us-ascii?Q?wjBPUl0GYhZnq1/YA8y+C5g17ffbQ2qR1HPU1GKb3fVARgpAWi4ngcYxFTXB?=
 =?us-ascii?Q?cb54vxzgWJ7Ph2imhDmVMsJW09LhRyCwy+ITk1iDjMXZJEAxaZWDWamR9Iyk?=
 =?us-ascii?Q?MxsbAg7LFDDkya+wSu/1JEiQUDyoI5XoMU8sGochC6aYC6jW23+/HsgmrIYf?=
 =?us-ascii?Q?BVoprlHWprQhRBLEGc4Z9wy6WZgKexgj+Z+rWCp53k405wIgzT1VFSQ8YGwC?=
 =?us-ascii?Q?Wv8I9fTYWaveWejLUp6iJGn/rRa6YZown77JzR5DQ2KnyJ1OrqpWaaFkYxbs?=
 =?us-ascii?Q?w/mL5jteVDJuWj6zAIDWLuANoxF6SGlRk/k/Ph265oY8NrNVw/XaSrXx+WYt?=
 =?us-ascii?Q?hc8iQJ/pda4qkPsvFMpgS3S0dJqYeDu6kVW1H11bGJk4fiN8KBli2MyKXo/h?=
 =?us-ascii?Q?nc7K+UqS8X2hAfD786fhD2grcjswrnRaSZRtBHGAwqCpslfm7HEboYAMeTFO?=
 =?us-ascii?Q?BuvDejT8+Ly9cYDTg1eGRR+VRaCLYsd5RPSIsBF3gx3tLuS00Oqy6moRyk37?=
 =?us-ascii?Q?3MLkbmwK2j1c9JRDjVPetlEbzprDkT9sGmiOwewp/nxuyHjZSw4R5oazXUaU?=
 =?us-ascii?Q?fCHWA+7KA0lclkXdll8S8yGXKC6PyCicq8ORVnfdE3Abkq5hpeCpihnjRDCs?=
 =?us-ascii?Q?Z29jKEhkzKqSiIXOxP/G5FH+kbrPVkH3oZ+5OVgFUWvHETw6Pujik3v/2rAe?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aY0/GKr+8muMl6lfo72HguUrAanPSWj784RP6ANNMJMocvTyj0QgyQzc/wnLpH7Svd5RaX+9IfrnsvTDCKos7x7UwOqAYQ3rOdm6Wr1edxclt42x7LJKkjDwOlIiKa0ZWs9gjBE8vXd2VFzeDqUrC8kzdrxuGfXoyCrG4cexZRhUHb7iU0mzH0iAEeotoIo6RT6Uyf1q1z39Iu5+4LBWL6xAZrjxj7H3omjxUkmb9mrVD1CNc0pmV+PhrUdMIkam3cZB3eQjjT1f4vA63mXo6aPBLaVG4rWKpjGhSDlxr1Glu4NhxsS8sHJT5SyAn9P171hIRad42pfxzK3Q6rAZ3f6TvZQa1JPCJEbKcU9Pw8nax64RvYutWXN3BtweLmnxMNnCoDBIfYElwnd6RcD7VJhgcqY4+OeECpMywhSv91J3uUbNa8xnfECiL4wKrNycDwcTV7wz7n+6BsNhEv8w+51/6a4AtJjL7Bk/hIvIGyE1zqFpzXSTEZ6ZhFLBAyy8PSo38sjQR7morAixY2QEx21WOLrkz/SyOj1vgqsWC7NsrrJv82mJ7LXC52xaijJKX3OeI/BY/FDjFJzoBNcvou3zt9D6qKWfw6aJbspBjvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16816a3-d8da-480d-f9d0-08de1afe3f2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:27:21.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkZ5fIu9OHfSRV/8HBI/OGmOageyhwageZIPZV1Htw2trtp4TwwTUoCv+4SJYnhZJ2PTa1xwQ1H4wF3Y4iSINTXxxD+Aqi+XgbNazeBVJjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=974 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030156
X-Authority-Analysis: v=2.4 cv=bJAb4f+Z c=1 sm=1 tr=0 ts=6908e5ff cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=TIXUd_ttslWzcKyjHksA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE1NiBTYWx0ZWRfX8/AOqFDvR1zA
 qt0ZWB1JCf2RXcAgLxI5sz8lr6Hlj4OPtGVuZGUW4gMdA6ckdW4rA8PBxRCczC/9d3NIHo+Onj1
 6cUDNGWxbchKAoaorUE8sJ7AFH+KBtMZgLpMUndVx+I1ICa4m4NUNhb4sDWkp7C0Gxazwi8jHT2
 nVjczetqgczWsqBdzKKeiexfS7OKhYujXRuuCxVPkckP+tY7z2Ro/rxIWneAKqV8DRNsyEsip2D
 1qbwG5Ldx2wFm5HsqpI8/DLHrF0RuLgq6o/+9avECGoRKz4ddwsgzBl5XijbfF8M1x4htYAjVfZ
 DGkxfxwzbUyQ2NQRmmNRYhKs/YCKRNVCRsbjro3djq6L1XIUnsEueWcAM6CYZwNJ6AmdfWRE9cE
 csIpwAn3EmTTfuVYCZ4oQknIlizAeA==
X-Proofpoint-GUID: jEdjPLA1p6ecEa4EUNg23lEEYYHAzJh5
X-Proofpoint-ORIG-GUID: jEdjPLA1p6ecEa4EUNg23lEEYYHAzJh5

Hi Andrew,

The wonders of configs and include dependencies strikes again, could you
apply this fix-patch to declare leaf_entry_t in mm_types.h so we avoid a
later dependency issue in migrate.h?

Thanks, Lorenzo

----8<----
From 663deb7591f3ff5e14f42f09f89aa3c871c1cf29 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 3 Nov 2025 17:23:52 +0000
Subject: [PATCH] fixpatch

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/leafops.h  | 17 -----------------
 include/linux/mm_types.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index a1a25ca152ff..414b45a37886 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -6,23 +6,6 @@
 #include <linux/swapops.h>
 #include <linux/swap.h>

-/**
- * leaf_entry_t - Describes a page table 'leaf entry'.
- *
- * Leaf entries are an abstract representation of all page table entries which
- * are non-present. Therefore these describe:
- *
- * - None or 'empty' entries.
- *
- * - All other entries which cause page faults and therefore encode
- *   software-controlled metadata.
- *
- * NOTE: While we transition from the confusing swp_entry_t type used for this
- *       purpose, we simply alias this type. This will be removed once the
- *       transition is complete.
- */
-typedef swp_entry_t leaf_entry_t;
-
 #ifdef CONFIG_MMU

 /* Temporary until swp_entry_t eliminated. */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5021047485a9..c9c2359ddf38 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -285,6 +285,23 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;

+/**
+ * leaf_entry_t - Describes a page table 'leaf entry'.
+ *
+ * Leaf entries are an abstract representation of all page table entries which
+ * are non-present. Therefore these describe:
+ *
+ * - None or 'empty' entries.
+ *
+ * - All other entries which cause page faults and therefore encode
+ *   software-controlled metadata.
+ *
+ * NOTE: While we transition from the confusing swp_entry_t type used for this
+ *       purpose, we simply alias this type. This will be removed once the
+ *       transition is complete.
+ */
+typedef swp_entry_t leaf_entry_t;
+
 #if defined(CONFIG_MEMCG) || defined(CONFIG_SLAB_OBJ_EXT)
 /* We have some extra room after the refcount in tail pages. */
 #define NR_PAGES_IN_LARGE_FOLIO
--
2.51.0

