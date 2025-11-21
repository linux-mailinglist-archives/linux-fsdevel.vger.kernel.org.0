Return-Path: <linux-fsdevel+bounces-69386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4AC7AF5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BA3A2D68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6412F25FE;
	Fri, 21 Nov 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFc/m7q0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IkmhUAf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338F23EAAB;
	Fri, 21 Nov 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744278; cv=fail; b=CX7uq19wkESt3lOq8YO9OH91xpzHsjTDxjqyRbZHdDBYmmcIlQCczd+8fHFOBTpEykrg/FgsQJOBzMmX4c3liDlDX4nacLg1H/oA5Rn6rI/gG3DRG0m3zvrUAPXb7gDcT6XfipKfosyI7dcwCMFOqJGbQlQYXVQKgZ2vvbdivMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744278; c=relaxed/simple;
	bh=EOCzR0ZqTLfINa3c5FUUo4voL/hBBBDsGEPJq93fwjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xf95utNU2iyqltViObRHddo5VNnqBR+cCUlzAVBdBbo+276DWjyhn1cx5tQZ/oo400yn1xb8t4NBi2K4jvcgGDP6ITA4e5aZ5WlnpO0P6u8h79UKRPrdB5IdPsP6ox4ufu4qBY/1A4JuN66wcLnElRDMkOURJhCSjAYIDG1bqQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFc/m7q0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IkmhUAf9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEhHpP009745;
	Fri, 21 Nov 2025 16:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TvQ7fb+n/sTyfAP+UI
	ZvHoxSoRFKVaMD+WNJQgepXWo=; b=hFc/m7q0TMpOaKY7b1KeSjCTqyPN9kvjHF
	TAji+sqdrydFjS1gNxzfW9Y8DfeE41ohFZ7rvqOqxsdwLoP9je+Ozk4MmOQAlIrh
	HWcWtsHCEgzE8k0WKA9Iy2Lb3pYdUdzpawQDNkK1tGsNCHQ3eRmyCJz1tAD9y4OD
	ABgU1QI3C5ioU52HOh53ht4seQEt8ktE+OGUdQbs9VtaILq6Uepk0Nx37y6z6h6W
	5zoGF78uBZldlmMHr+k9CAaHwXUZoa2Iyi9IWtLtd+eAmEaDSQWBg7DIklRmRO5N
	dXgU52zaT54w9N7gYABRT7pvoeNeqi58Y5VZxWSIVmDYeEfWvHdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1kvu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 16:57:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALGbsmZ004281;
	Fri, 21 Nov 2025 16:57:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydm3hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 16:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIMluov7dpmGZWyyWk40efuyps3eRe59VRILfm5m56WzLxg2fIVm535aL0rLIzWhriHqWfpkSjqB5MiWaCMDW9QbzMGxOUy/VkqE2rxYGSjEsWWGPj3naXvJY+nh/VC1iEfSFp4YWtKGtTWsQLlyuGns4QQcl47SbPPJzJ9AQKs/w5X++dr+sICDcqyk1HfImNmNJeV70tc0cprqSrIQZmDjCR0TtbLL5RWHfFoIc2eAgl8GuoLv269++vjxE3gKwOeZuHnzrXHMpNmzbJqd4aL6mniFLRf+UAKom+NI0ohVPbIH4Lso/DQVzF96B3jOyqzqkKB/FRauwArIBEUFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvQ7fb+n/sTyfAP+UIZvHoxSoRFKVaMD+WNJQgepXWo=;
 b=UaQv2NAjLINjKxd7VsqvBsU7ukHpQBXHytfgihuKjaNr19eCbot1qSXYQ65Yp8OF02198uZNKW84FP+5AHhEsOTZFbRmPNPxPzNwDxlw1ApVLJqpx6+q9a9vtKfmVYkF/J+T5s7BxI0HbCNs1Wj8Ng2o31MbtAaj6IelYwemgvn2KF7hs+weILG8Nqn5oCNtQEW3UILVQF7coowczMrNtsLalghmeBGk/EFsZbzroBsEO4gdKf6hz3Qf2agPZJGIlsyHVfBxvUbc4jcR/4fV0UK6fBh2OWAXk93HddWuCoweOCSTRRaB6LrML+bxyIIX0TUHxhGUmshgS/XPUC+YBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvQ7fb+n/sTyfAP+UIZvHoxSoRFKVaMD+WNJQgepXWo=;
 b=IkmhUAf9K+qo4MWARmt7v+tcuWJBBePn2RtX1C24Ma+sJFD6qtpsLfVcHm2oYeQ9gvcsqDdU9YstVtgnKRNn1Tx+gIzsxz1MBuHu+gyi3/3o8g+yhPZLMdT98RaLNEBGLieWMYnM4mFB+UcfK7Ac/LTr2CHR4whaPAaCCJPTUnI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB997556.namprd10.prod.outlook.com (2603:10b6:806:4b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 16:57:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 16:57:21 +0000
Date: Fri, 21 Nov 2025 16:57:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
        linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V15 1/6] mm: softdirty: Add pgtable_supports_soft_dirty()
Message-ID: <dac6ddfe-773a-43d5-8f69-021b9ca4d24b@lucifer.local>
References: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
 <20251113072806.795029-2-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113072806.795029-2-zhangchunyan@iscas.ac.cn>
X-ClientProxiedBy: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB997556:EE_
X-MS-Office365-Filtering-Correlation-Id: acd31eed-196b-4613-4ab1-08de291f0987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX7Y4dfjUDBpKFp9T1hYIZQL0YIn+7gCDphA7JyPDrXVThpbIs6qMkR++e41?=
 =?us-ascii?Q?KNtdthS33G3wiEHZ9aTIgDYHdaxcdUR5IkDpouzpHg9Li6r2rEeEpB4G48JO?=
 =?us-ascii?Q?WRZp1duNIGZJKAlhQ1pAQ096c3FZOaVrqtPVGC6acdiQ1nE8nV5dz9yQxf5k?=
 =?us-ascii?Q?Yb0XhS9Fo9oOjzviGCYQWN+KmDoV1eghn7aMlgC4AwiBCo33UUYbf/K+QLHM?=
 =?us-ascii?Q?Akr2UeRC+gIRZ4sVfMEws/QvfLviWkKL0eHiqEWTYDskqJ4XvN3EgjRmYpBi?=
 =?us-ascii?Q?Z03Gmvvm6g6aBStIWXWYbtNqD8xwFrNpbfRmfDHX0Osu5kgwGOo17yrAnAKn?=
 =?us-ascii?Q?f22+l3up0sGwCOYBmprHQcsLx1wAADLAxG5nDJAVb3rbNaqbOUf/FzLUlOlg?=
 =?us-ascii?Q?SMmCjrp/TLmO/+gfVscF8sMRmQJZKzxEGe2m6IRyn9QoGtOU8YjKGdqN6fYl?=
 =?us-ascii?Q?loD8Y/lwz2W/ppyCEm0Sk9QJprbwledZuYs4KoOVY6za8ApGjXJdQq4xirC+?=
 =?us-ascii?Q?gm+zm8pykZuaBlM8ZFYwjIK78us2VXCqbBmuCwQQJBbEDl2wjj+yI6rGdGk1?=
 =?us-ascii?Q?6x4uVy0dcRNaePjBTwhEETY+DIAFoT+2lKJRNoKmHC+FGJ9RDW/IeSHWxFoR?=
 =?us-ascii?Q?TSKiSJYVQqD8TZeKxuo+Cdv5TJnCW0QcKOalwEtKp1xiErlgi/JGp/8TyF/N?=
 =?us-ascii?Q?e6mCgUZ3jhVPwgqYdhQz7QrM2vrhTzOc6TxVjp4ft7hB/PzLvCWqgFTvxkYo?=
 =?us-ascii?Q?B9jHxVRabgJqpyVHBlfK+8eULfwJRh2Ki2MeQJ4ryvbIAm52jEj6kvyKmwcQ?=
 =?us-ascii?Q?jfLZXrma850E1ttS/Mxazxeu5jS4yDS5+BbBHZ1X8sDSBu/G3Wc/nuhYLD8p?=
 =?us-ascii?Q?GIcoSxWZUTmEOwHiNUUFs2lcqwW/BOB4vm2UizK4Rsm4gLy3bmyFNqp1ErRk?=
 =?us-ascii?Q?zXS90foEfzxtHtBaKi8+EwaxOmr2pVQNBb8JHgFVeUOOU0IhFES/tfAP6QmW?=
 =?us-ascii?Q?/LVxNArbST42H0UfbMirrfO+j4l0VmqyMFhDZua2ZX8O6+5ESgjkg4nQg4MD?=
 =?us-ascii?Q?wXQZTia0x1A/LfE+j675cU/rCi5A3D7BC/bIzdY2/trs2nUMD0Fxwua3aSYu?=
 =?us-ascii?Q?0xkFYVoHKkLi9Ks00EmsMsdbJSb9/byrSp0oeamy8iHPkVjLhg5AWt1LeMYA?=
 =?us-ascii?Q?prvTAQDO+UJFK4rqFQGNh5PUSGvAaDhB5ZWG8FpVQAr0/wJaD96f02adtH6u?=
 =?us-ascii?Q?/LCHRsWjYcb629iTtR0Db01UUwzrodY7ZBx/e8Cmr4jD3+zUJpNYol+NDi+e?=
 =?us-ascii?Q?XkjHtbCyuGVzmNOaqTfzx+ylzKC5K4mFD5WQ+j/Slkb0wI8uXVHWkLE1x2ZU?=
 =?us-ascii?Q?O5ZYjkSKdkmIyMluiBGTA8Roe0GcBckcjfXeJDQLMp+3iyBx8Ei0RR8If+Vg?=
 =?us-ascii?Q?8102rlhvYY2pjlvorizMQkWnyJ8XWRwL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HO5mYRBrqe2U6SU0C6+xHXJ/UaP+lhPWjQwF3UzLpC5L0WhXLE4IJui1GKK6?=
 =?us-ascii?Q?DwhQ+0ugEPEstFBCPxlS9L3myxy4xrqQtCHklL6GtwkVLdA2EJWWVCV7zNRj?=
 =?us-ascii?Q?o4g4BwhDXt/OkhnL0jckRXhJ9uHxoyLsM3qRin5hZyQ7pSKnpj7CHV3BFlXY?=
 =?us-ascii?Q?i03cUjCgK3XCIV4MhGZEIsw0aI+WC68IViJvNq+BpvGNbMC5gNwHenRpnvHq?=
 =?us-ascii?Q?UGmyhiGLaNf1YX9LyNd/eNE7NbLNyfnharcF9UCvqcOhj0NmuCwbzpD0JmeK?=
 =?us-ascii?Q?tVLJ9F5EagPPlPsPOl0tL0qqeImEfzQjhACjJImFXP1OV1ppP2WvARTqsAhg?=
 =?us-ascii?Q?scHxvmw7cson+2K3V8JZDSIS24Vw3ZezMJxooOQdr2HqcJvhwYFTrF4q9Qdk?=
 =?us-ascii?Q?GdKtcpphzSD0eKi2e+RE0OZPYQfFOBOGNlJGGMPdhyzRsH/7zMD7MBlM3twM?=
 =?us-ascii?Q?PqwxtAyb839B20YigaGe4O8DxmPNJ8tEwPgdd2rkFo4JmknJ9JomL6WoXPPF?=
 =?us-ascii?Q?e3ojjwddF/vnF5Stz+OE5wC3IpLOVxbk0Yl9yy7rHkC660iz2ImlvzlgBiTb?=
 =?us-ascii?Q?ONJSrTKMvssgbvyu30zBfxtkyOF9qsGy17ck3hSBm3lhC11e2kUaxObGhl8v?=
 =?us-ascii?Q?f0c2dajVZZU2tIVZmVz30bdZalfCWl15h5taTZ7J9ndNXEH9iD2+ArdTWZyo?=
 =?us-ascii?Q?1TWr04Oix6AJximem3BZyo23dgX3+HLs86LJxmFk75qEVDMzmY2hROjeYjbw?=
 =?us-ascii?Q?XfLeFDoQfwQy6mfB8q+jrgqOiDQQiakBDN/WOo88iDsgscBA90AetXFFAERT?=
 =?us-ascii?Q?/JaLTbt12Ot7UYDE8CWmz2D1QWy/1yDbqTlZfB0kLImVAE+eEImDp4rL4+bQ?=
 =?us-ascii?Q?8jjrkAhsEn8DKNc1MY8aMV8ctPPzaxpyFOpvuS7oIikBVK2TAbjLoPct+rL9?=
 =?us-ascii?Q?nStxgvXZ0NrdrNXXYaDXqK9iN41YSX0Px/n+kbRBfjzWpc9K1rVjd4+f4KdM?=
 =?us-ascii?Q?Z9ckuPM68Wmd15pY3lBEyNWVGkBcGw+YK8yr9s3/h64ERDc1eLZMN1aoGNWT?=
 =?us-ascii?Q?gzf2g7T76sdcwBAEy+xf1CmPlMZZmg3Ldgkm5c7uvo952VLM8YOc1QZo5h4T?=
 =?us-ascii?Q?1Tsklh9cPLH3ipixXESjNs9T14w9Y/b7uf5zlLAZbH9I5nwnBlitFMNrKupa?=
 =?us-ascii?Q?kgcwSw0qYd79BplItG2TXZBSL0Oz6PqSwSYBt4lw3uEzXq/vS1chAjEajvCV?=
 =?us-ascii?Q?+IzJFm7nIeNpLVMQnjQWl/2MKNngQhTH9BMvwZMZtNPqZlFomgMkntoGa9ln?=
 =?us-ascii?Q?XZFclDhvHqcpB1HBvi6p62mpYVdyR5qSQbY+EoQcfYoiU+jyp05sB/U6QIjQ?=
 =?us-ascii?Q?As2dvMZxPahFyZzGJt5iPDeKIvFn4jXragFNMDf4v3Gj0ZtuJX52V/eeU6oz?=
 =?us-ascii?Q?FuLshGGJoG6FVQ1x4mCUi6JUh8f28Dqzt/tQ/PCdJfzbVsZmzesrh5yecgta?=
 =?us-ascii?Q?518Uk16KaIHrP1Zeguw9oCsZuKpnrpD7zpXxPuZahq/Ni7Kbl3tfAzTKHTrY?=
 =?us-ascii?Q?J2Zpm5ImDsCLB1KRRrEeTLTXsxkHRp7ZvyR3UZLe7v1E6mxkgRlHHUdmZZUF?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B8HCbzq+xfPUZVzqs2uRjc89ogqd6CJ2Gv9czNFdPfqEBTs7gasgithx9aRlqcryXPD1aQeHAmtT2voHOqpj635xyyhVVi7eAboWkTQ6oYXmzw0b1g4E8lSOSfLysUcDc8OFhMRqcO4dOiZkzheRLhQvDYKMRFrvigchaacbcpuCzoHjiPS+cYkUVXZvNEdIt/vEnygRbiKI8kofGcaHI6+XYvSQZ8WrYIbWH/+v+pVetDaaZOOD9VY+0jXBVSMVS+NoEOkG5GkpJ3tnOoRPn4iTMmX85sJI0IZP12/14Hcon90jL9Zn5vrIGs6f6cAjG9EHL5HbAm89Aho++xNRjlXMQzHaa/HNQKVtDzQpD+wGi1V5np8JzAZUVUCWx4mcSFD0DOJQo3Mpp1QZXwd9ZUJgqMEtP4hhnhRQ1POhGjbFaC6Uqck9hGkriTOtNgRmzst9it+C8MsNVHWORNJFf4xJUBE1tcby7Xg6+hYw/YJslqCjSRXZ+qypXb9yqHsFCGO16V3Yyn+2FagaDoq4qMlVEu0Q/QBNF7bV8qdPOSaLHNWBwBjWpxCQo3pA3JGzcQfXglDjLzVNV/anSebcSqd0qlNYC9Qpz4RMMas47e0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd31eed-196b-4613-4ab1-08de291f0987
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 16:57:21.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgp+FGG7IvjqCe+9LS6KRoSIG8fldsEQOX/svf7Y0lVvcpRzL0e4v3DFfC2ov15WiZ142SrE9FsmWTr5TkYLp9RDhIHeDKdor3C0nZEkk4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511210125
X-Proofpoint-GUID: 8P3aeBL_gXmfDWW3bQbeIVm-gF8Jjirh
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=692099f5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Av7x5rYIwDzA8hTTfgUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX3YYE6nfml6FY
 4ozorjDwGEKRDeIPpD7w43sHoYQcEMGd6hNGax+oga51xQSMwgnwl3BNaOJKPhQ3FApbg7UVusJ
 U0gO9GAgsUf0g9ngEXLgw01gxlFVQj+8+tUlFkMr3d7WkWK5/6rPgbSd/Eoo54J/If6IOe1RNMg
 NsrCwPDKlqqvLQOJ5LsKtAqBUUhMra0itmP8LRRy1FebjVNpr4p7oaysBAjZ/bEyfSsJy2bVsqo
 olQapa8O82yqdbE7pxzwivR2+rnOphxLkgwZKAWJdJr/C7HNNu92yCpTf3vZwChchDkPaPELULJ
 63/mfm/1jlX9U6LlTZwf00yePH+XY8QcTLqyhbl/La/JqX23zbAevh2i7naJ434WExOA6ecaBcS
 m3VmldG8yQVJm+FkgCoBGPHsrdbwOA==
X-Proofpoint-ORIG-GUID: 8P3aeBL_gXmfDWW3bQbeIVm-gF8Jjirh

Hi Chunyan,

This breaks the VMA tests. Don't worry it's not exactly an obvious thing.

You can test this via:

$ cd tools/testing/vma
$ make && ./vma

(Currently we also have another breakage too which I'll chase up separately.)

Andrew - Could we simply apply the attached fix-patch?

I know this is in mm-stable now so ugh maybe we'll have some commits where VMA
tests are broken (not nice for bisection), but anyway we need to fix this even
so even if it has to be a follow up patch.

Thanks, Lorenzo

----8<----
From b68d84af7030ac6db6174749a5b822d9afad8ff6 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 21 Nov 2025 16:55:37 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 81b501f51948..be99056c5d56 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -212,6 +212,8 @@ typedef __bitwise unsigned int vm_fault_t;

 #define ASSERT_EXCLUSIVE_WRITER(x)

+#define pgtable_supports_soft_dirty() 1
+
 /**
  * swap - swap values of @a and @b
  * @a: first value
--
2.51.2

