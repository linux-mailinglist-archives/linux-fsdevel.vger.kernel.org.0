Return-Path: <linux-fsdevel+bounces-53502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B0AEF949
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D843AAA5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285B2741B0;
	Tue,  1 Jul 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vr2GeMTT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XZXUeYzd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E041E515;
	Tue,  1 Jul 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374430; cv=fail; b=I8mo4Auib6B/GjNte4B1bnTDFw2I6AZZsUe6+KlSjWLvdId8j7hPVgwiPSlWEPDzT3neGZb7LR2oD9XPjUM/zxWY4Q2eDLCg7Jc+2r0A7LceeL7M5PGzD2g2LrgObc27cHZWXAKNe6wcflw2agVs5L9CWeptwmUSUf2b6NWy/bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374430; c=relaxed/simple;
	bh=OiLoKc/9uFkAkYJCqZkhCKbyd2TPj2B1RFzqT02VoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=edxrO2EhINsfkK1h2Ika59FKasTjHysVGo5VR8Lf95i5kFGujQQ5uR0jUhwQo15PIuTe5C6YPHheXI8qEOHHejJc3Kj8uHxnSHf73Bcikm8UN30Xu+2LuqNjzPdgo9fC4xskOgEdQsy6oMriyHC6u33WGYCLdV62v+w+EPfhDkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vr2GeMTT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XZXUeYzd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561CZ7v8003482;
	Tue, 1 Jul 2025 12:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HKvYTwzSqPssF1mpZs
	SoAUKVbL+wbPgWbQUjrJ6x8g8=; b=Vr2GeMTTTMj783DNNEkd4w697hCrjZBGTa
	my3+U90R9Z70XzZ3znme5OW906Rb7r9RJ/eEJFGgnTEUcQ6sDe3+YeNUEvGG1uJp
	6bXQ6bCPtYLDR6j/MJpu1yT88APWsz8K8yTL7HQSwpQxxT9tQPF5Cgh9fXcvPema
	CHn7++0ydM/VUz4EhvF6kCK67KQvauIkMPqJu1kN++MzXKe9i+9mFfMNbFGwRswb
	xaoVyu8ZTkatw837tthojPdGpfl/GUAgOUegXWVlo0St58dk8ZO/dYGBboJB93AS
	bJwA8GQOEhQ2pJ+s/z8DfG9p+H90sbHhYfQxHKjfhqWfReIKyqcA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w4n9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:52:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561CbNWb005735;
	Tue, 1 Jul 2025 12:52:01 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ugye2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/1RQ/eK8fK7Hc534wfddbstI1tjEB+l15QNOLoqWbLKYPs9zd44TmvAZyKmBeM7Vj1mi1NOG0x5QhFl2cBsSLO+gHqBAIdFL67m3ouNuDJMG8WRvzjQAjhtM8y35w0w/W2bMKoxXmyEA8quCpqzjY4QjchNAWTQrlVp/8b5uKcZ7WOOBHGqfWvhgqF9+SY4qIGUwCqHK5csLiRKuFfmGwhDFq5fOATVWVY3nDNB8ZCNm9sVhdcnBJKIsMkMegx/h/EONIpZBkNDEV/hSLYnAieDGAvjdO1FK8ERoi+dbcjW2OWNJESqr11y3L+YHkWZYfuNExhLS8KhNHK2rwu1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKvYTwzSqPssF1mpZsSoAUKVbL+wbPgWbQUjrJ6x8g8=;
 b=P2dQ5hJTc1Btjvsa3qCMfFEc/6IM3Vz6q2jWME8aPEuQCzxqmtWG7KWK5TZvd1PXPVts3MPCiaQ5VKaOuG2R1/8Qa2HEfXfpk7JEZN1+MwoJKMEhXTOngW1OMR5KZi016KEArltr0heMWDzSvyN/3v0k5J2RoAbXbRvibvP7vgKPrnULkLQg4mo7cirsd3yceBNGTuXHahkwaLghi11ZHv0YquI0rnCzzO7USavPm0Gk1Nzlq2zadculPdzeHeIvtL4a1VXKsJFmGFeLF/kX6yu22iY5ACvT/YG703jH32LfIAUOX2bc0dUND85b9ptXVbNUvGQ2sSi9XRHUeMllRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKvYTwzSqPssF1mpZsSoAUKVbL+wbPgWbQUjrJ6x8g8=;
 b=XZXUeYzd8eofndJHHYsJgfA1DlGeruep5KZf7FVlHzVWGj4nGdgWJfEuvYNdHs/aw1dn2x/555gD/7LpgSF06Zh1RlIABAFsRcAUSidUq/gm20YNGSYJmHgGoZ8n2SnGDqI6O07Cnojs0KtrQLGqv4bOYFBHYXDzqmYIJWqkLAs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8205.namprd10.prod.outlook.com (2603:10b6:806:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 12:51:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 12:51:53 +0000
Date: Tue, 1 Jul 2025 13:51:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 21/29] mm: rename PG_isolated to
 PG_movable_ops_isolated
Message-ID: <443de491-4ade-45f3-9c9b-b4428b0f0aaa@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-22-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-22-david@redhat.com>
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 080f5f1e-29d6-4b21-5fb4-08ddb89e0db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K6fYmfPrM1zClMNdXhhTJVTQ8dvyG5ji6JxrYDp61OAg+ESzN14YFpUIiWiw?=
 =?us-ascii?Q?MXKmHq6pkNLcLcfyJsgcD8ONT/r5/wQogOawxdLrWOo2L01/nlbQN3jce4xf?=
 =?us-ascii?Q?uG2WRQ4xJ1jG4rYbcqD6djLDPQsvrTfS5ihMLlp6EY8hsTjcmz7OvRnH5azr?=
 =?us-ascii?Q?LNwGWC8X7p4tixUiyRPYWIuZzHsNAD+QL1YHEKt9+sQo6TEH17G4FjNxq9Hf?=
 =?us-ascii?Q?F8X806Fo94OG/rPtzCUlb5sSKg3fGPZB0XpOYJneG+HjAbIlGcKt9DRyXj+9?=
 =?us-ascii?Q?WoxNjIaVQTJuXo/UJc9GhjcTNcnKZnwpjMnwkJnjdUd4XtzqEkMYy3ihN9uS?=
 =?us-ascii?Q?U6fkEbzXJ7Zgfj4pcJs9UyPlyqbyAl3YiZMCc4c3NxAK08pZeXzFGHYD0YnO?=
 =?us-ascii?Q?tB0Uj9YwD2ysMW0yO8Y0EvYYER295rcNj97ympdUahlfn/wRCCQ1neHZLf6U?=
 =?us-ascii?Q?0ew01m95XBD/YZHcm95tEurxPm4s1USswzn/mZhmyT/Jv/PEPaS3C1kcTy7p?=
 =?us-ascii?Q?3ELMx9/g5aiM0I8kbfmsBpdaI/DpmaRt/5JbvQv39vJ49Qk30xtbGgHDI6Bu?=
 =?us-ascii?Q?5LDxBzC10QA89wOHPKE/0qamwX1LpkrFpFj3MQkwvch0E5lHYqJuc6GRl22H?=
 =?us-ascii?Q?yPb9hxcEGy5hgRTybVHmkTH/Z5P+igttU1Dr5L8MGg0tT6Ed1Qz0BDZrC8y+?=
 =?us-ascii?Q?AeKumC2NRjkofyoYdmRfgyUfRvp0A/e/GSNeRFjE0uwLqCMsNNHjIbZdDI4+?=
 =?us-ascii?Q?Zd0T6TyIAdmPu47btoTJ+uMT7B7v91sYeM+SmM+9QEwB/l18TuaEjFWFWQ5k?=
 =?us-ascii?Q?H25KD54fen53ownri0WTcEB1E4A5+NRFqqYzM3YsN9K3/hrBUPS5nfnMy8Yo?=
 =?us-ascii?Q?bVSRZiqqOy1e7uMkkPrskk05VLxIl6NDsDpKt8Of/ZG/eFjpW8fxc9QJMv0r?=
 =?us-ascii?Q?m+xmFCtwETnj9M8kMa+R6BMSvnb53KRk4cRmYXr8fHPumAmkZ5Zl84W+Myc7?=
 =?us-ascii?Q?7SPkVXj3EOHWnDQ2TPDzRGVkugGK0gwx44odxL/18gxXc0m6ChWevSq4hrZ9?=
 =?us-ascii?Q?RM5PDnS0A8/N9kMHk9LaMlTwAWlnbdAiFr9fzQeva1IAmGivfrdi08O/rDpW?=
 =?us-ascii?Q?DA+AaaikASFu4OeEwv6o3fnZvZAN7mMrfmnMcpixu6/hp64DsdLee9jzarw6?=
 =?us-ascii?Q?E4STRRg64BB1ROtS9Dcqe3Urp5UhEmJSQsz+nIaT0Z0jUg9YocnjowAgno1/?=
 =?us-ascii?Q?7rS8+bH58sekgupsEOVmKiNdUjZXtCUkpA+lGalEJ5JzqOZYzZLJQBaC0cJQ?=
 =?us-ascii?Q?3A+ZtA4AZ3a0usgicHPEY2qIaCvSNyC/ELElpeJ7qq/bjy3hLKnUy64YhQrQ?=
 =?us-ascii?Q?VIuKx1QrOEPATJpavXymB270YIQ2u4G9GySDp9qIO22malCUW/lmMmVKdHM2?=
 =?us-ascii?Q?c/DJ8upPTmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBDbz63xFuOioWGoLiZZaaFrCUn0FqMTwvq6iYyv8B/WI47OOqtzgX5GdbbS?=
 =?us-ascii?Q?7LEduLcdv0ixHpnB/Vw1qfxh6550jQ7QLBjCtijh2qe/58qtAs7VLuFps3IL?=
 =?us-ascii?Q?wwvNPNVXyPjXQVYM+G/nSC20bZozS2iNO8nfgBkYsC6OSsiCAE494e/NCOiN?=
 =?us-ascii?Q?vxvGvGkAlidLcfJ1cEbxFHhTCVaMvS2BK9WdItrK3YMsq/Jm2jFgRM2HzfeE?=
 =?us-ascii?Q?784EdJUvpybvLcrt33bkblroRoivvFKIvZHMTzp+QGTO7uOcrnTs5vnLr0IE?=
 =?us-ascii?Q?pNvt6Wm4TELwGWlQIH8ikYEum9EQvEuNEWsvq6TC6LYUjVeva1dg216qJm0t?=
 =?us-ascii?Q?azZAzMHBJaQqrT5NXaLlzB6RqIWeSqRaG+lzZjz4vmumRK2UNgaa4C1WnRbG?=
 =?us-ascii?Q?XupcN414LJhq7L6DZZfxFmsQ8VK2aOY4fahjHqKPPw3HYNt1u5k3ThqmFWIJ?=
 =?us-ascii?Q?YtrVXRCVc4JRC35gu6YNDpwIVtl8tYSGjZkM2lF4BkmgET3knl6UC8tS3+ya?=
 =?us-ascii?Q?IVu0JPU6RDZ75KbI7lFmaF4mwTAFAjoTPvY0dBOAr7HTAwtan0kLUzNkewRi?=
 =?us-ascii?Q?97HWW9uZiK7FPu7qu3Ujb95C44PJY4wLIfC5SUdpfNExmYA5yWR65jF8DayL?=
 =?us-ascii?Q?weWuKqtH6aMyZwybRZLWXJjj6unK2o12bIQ31TQGbIfHGGV0+KSm2LXQa4mn?=
 =?us-ascii?Q?FUbsyFaCwN+uB/Ub9EKsZybJLkzj2zSzv72WwG3AwWG84DxxFKLcWnu2T14q?=
 =?us-ascii?Q?W1mcdK2sO+QI4+4AHMFwjNLxfsiHkLpZhqzjfnR46z7O9EUGcxKF1cob+/89?=
 =?us-ascii?Q?gWC1Eoqlgm/UsRlqd4jgGXIRE6JIoe+1CsqVVz0UlhyKbbnkvIl6xp2a5GM9?=
 =?us-ascii?Q?rIzu35L8oyT0a7wqa6gdJSMSMqXMPyztT11/9ETRPwQ+5zDkkmZKMvnVXc6e?=
 =?us-ascii?Q?pTtPn5pXceokffAVL86O1E95iFNRK1c+lLcQ2/8QmBwOD2+6mXaKCm4F95F9?=
 =?us-ascii?Q?4xD+80FTt7IUTWJXmpQscNWUkvp1ZUlqaFsWPoluG46U/HQ3sZBHP9z2+He5?=
 =?us-ascii?Q?ZZLiO1x3mxPuF27Taw/aFPYtDCmbsUBRYjLynREf1NhzKO/AUi3b2ufyh9J5?=
 =?us-ascii?Q?OCHkjGylWe1wFHA4tXKkSWcCBqgap7FRoI9NyVC2+zynovECe5dAU5MiewfD?=
 =?us-ascii?Q?+9vGpFHopJhYdVQn3OjqMvKNiyrEi8BuUS4rnG6efb/wII42z74W5OHL9mYV?=
 =?us-ascii?Q?/G4cFjYH8XdlmWZEPG2kCNjp3Dt/+iepsZO+mzJ64xxzf1HAmttHSawTqX/L?=
 =?us-ascii?Q?4C48X6GEy/uBHOeP8pciT5SPJfRHBOsC6tdSwPX9VE5cK13F6J2IOphdeC4l?=
 =?us-ascii?Q?HSDOPZ/NvC43ShWqNK8S28kVpJVBBaPLm2U9aH6ei9/EczsaWFniwa/qaoBX?=
 =?us-ascii?Q?Lo53S2lDA3wVBT8qpI+9ksq6uOdhrzm9zXEsOBnFA0AYmAHtW8eOZneZduWg?=
 =?us-ascii?Q?FYRVNKNimYXkmNamXbIbZ6vzEvG5t2t+byk1CmjvJgbwnmgQtX38h5d81rEV?=
 =?us-ascii?Q?2Ur+PfP/kjLNV44I+t5BG09qRVIR0H9n0L3VSOOgpL/IZJA/UFqUuL5Oca8T?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cmmTTQ0zirbN7ZAPTzSlHAUfURIg/rYdYFn5jIhrU2/bmMpq9jUenFHdIUT+Z2QeQJJYrmSfpLcM60DaUWfOTDsT4qeiR77gfReek2dLCT1zlX2bXQ5PHnVDciu4UkAiE1UQ7IyU2/C5CaqDa01dgZptSpSyjxF+WnNLwVKOFLyosx2QqHRCJ9A8M2XWzA/i54P5qHbQ+s4HU1SoPE/919TFOXGDcGDfgZjWcgeccol2SH+fd+7rY4Tt/oTpHwPs9JlDd4wt9tVthr2uqwCTMhwthNWdF3UAvjsdL0UA68X+6Frm7itNmJX3ethZ9NYaWLTPav0UL/4+uqIj3zaJUECiOnVKodTCERDkAHR+KHx74DlVuDogsYeIVdNaK0ZRvExsY+qTq7W6KbIOvi9uIGE++uqCwDaDZD7277jrou5l68zjZltf/t73hAdTuoLjUiTgCn2CzmyCGtyt0opqaNeP6Y3m8wHZcA0FQQleUaSUbW5lHSzNUYO7n1CMiizljZF1DxnN3hbX9Wo9eXpTomks8xkz+Whtoo/CmpGcqTbCjdf/fqBVQRN8wmyARfSXkflKbaNH/AeURaPVe+Na3r6OWQJvn+1KNJgNafIwszQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080f5f1e-29d6-4b21-5fb4-08ddb89e0db6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:51:53.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liNrMVqAjAxr+eI9ed2XWeMVIrQre8nkgBLHHwJaV6hFSqy6bUTeBeci1HDEvaBAvgb94xHT/atDMCSg4iw+ehrRBH/gyVJO9qgRqAU2fxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010081
X-Proofpoint-GUID: SslypWA6UvTxcgTmWeYxyIdazTIaOC90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MSBTYWx0ZWRfX3ynQjabUqdGJ sgWrDvGJsaIo1wkpgp4q8caiutBIl/Ngp1DXDN9yc/mT852anQBWqyxYXzUxW0KbJyVpLzKlwEi mrTaY/isXC3dOiDWtByPj6p0Y4vBdrDl7pugf3F342HIao+KbHuWW4njNmn7siUqbMC51BQeGzb
 nFN4PMAuwx664xaIatkgOSnm+kK2f9qVLshryjJ63uH/RK0J+aswaw6YPHdFJdhsTytzrUTunM7 HJsPpzQaGa7wH0MINHezgJre5VxrZK6edc/DdtIzwVxyHO2MuhZ1OtwghH2D80c4jne4HwLOe8M tR+Lnjzy7cYRdz7jRSzShami6YcfUJK9Pa+3ILxDZka8c1W/Xvoc+kF0V9DUfiLRkrzUWwS/bZ/
 LkhLvLvBbW+BOI1pLmjW47hFCrnxIt433K6ibFtLuNku6KY5749jIhWbuX+0FVwa3ubQtxqs
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6863d9f1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=FrCxi9fzp1qHROjybSYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: SslypWA6UvTxcgTmWeYxyIdazTIaOC90

On Mon, Jun 30, 2025 at 03:00:02PM +0200, David Hildenbrand wrote:
> Let's rename the flag to make it clearer where it applies (not folios
> ...).
>
> While at it, define the flag only with CONFIG_MIGRATION.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/page-flags.h | 16 +++++++++++-----
>  mm/compaction.c            |  2 +-
>  mm/migrate.c               | 14 +++++++-------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 016a6e6fa428a..aa48b05536bca 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -167,10 +167,9 @@ enum pageflags {
>  	/* Remapped by swiotlb-xen. */
>  	PG_xen_remapped = PG_owner_priv_1,
>
> -	/* non-lru isolated movable page */

Ah nice to drop another confusing reference to LRU when really meaning
'non-could-be-lru-possibly' :P

> -	PG_isolated = PG_reclaim,
> -
>  #ifdef CONFIG_MIGRATION
> +	/* movable_ops page that is isolated for migration */
> +	PG_movable_ops_isolated = PG_reclaim,
>  	/* this is a movable_ops page (for selected typed pages only) */
>  	PG_movable_ops = PG_uptodate,
>  #endif
> @@ -1126,8 +1125,6 @@ static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
>
>  bool is_free_buddy_page(const struct page *page);
>
> -PAGEFLAG(Isolated, isolated, PF_ANY);
> -
>  #ifdef CONFIG_MIGRATION
>  /*
>   * This page is migratable through movable_ops (for selected typed pages
> @@ -1146,8 +1143,17 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
>   * page_has_movable_ops() instead.
>   */
>  PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
> +/*
> + * A movable_ops page has this flag set while it is isolated for migration.
> + * This flag primarily protects against concurrent migration attempts.
> + *
> + * Once migration ended (success or failure), the flag is cleared. The
> + * flag is managed by the migration core.
> + */
> +PAGEFLAG(MovableOpsIsolated, movable_ops_isolated, PF_NO_TAIL);
>  #else
>  PAGEFLAG_FALSE(MovableOps, movable_ops);
> +PAGEFLAG_FALSE(MovableOpsIsolated, movable_ops_isolated);
>  #endif

Nit, but maybe worth sticking /* CONFIG_MIGRATION */ on else and endif? Not a
huge block so maybe not massively important but just a thought!

>
>  /**
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 349f4ea0ec3e5..bf021b31c7ece 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1051,7 +1051,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (!PageLRU(page)) {
>  			/* Isolation code will deal with any races. */
>  			if (unlikely(page_has_movable_ops(page)) &&
> -					!PageIsolated(page)) {
> +			    !PageMovableOpsIsolated(page)) {
>  				if (locked) {
>  					unlock_page_lruvec_irqrestore(locked, flags);
>  					locked = NULL;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c6c9998014ec8..62a3ee590b245 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -135,7 +135,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  		goto out_putfolio;
>
>  	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> -	if (PageIsolated(page))
> +	if (PageMovableOpsIsolated(page))
>  		goto out_no_isolated;
>
>  	mops = page_movable_ops(page);
> @@ -146,8 +146,8 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  		goto out_no_isolated;
>
>  	/* Driver shouldn't use the isolated flag */
> -	VM_WARN_ON_ONCE_PAGE(PageIsolated(page), page);
> -	SetPageIsolated(page);
> +	VM_WARN_ON_ONCE_PAGE(PageMovableOpsIsolated(page), page);
> +	SetPageMovableOpsIsolated(page);
>  	folio_unlock(folio);
>
>  	return true;
> @@ -177,10 +177,10 @@ static void putback_movable_ops_page(struct page *page)
>  	struct folio *folio = page_folio(page);
>
>  	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> -	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
> +	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(page), page);
>  	folio_lock(folio);
>  	page_movable_ops(page)->putback_page(page);
> -	ClearPageIsolated(page);
> +	ClearPageMovableOpsIsolated(page);
>  	folio_unlock(folio);
>  	folio_put(folio);
>  }
> @@ -216,10 +216,10 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
>  	int rc = MIGRATEPAGE_SUCCESS;
>
>  	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
> -	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
> +	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
>  	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
>  	if (rc == MIGRATEPAGE_SUCCESS)
> -		ClearPageIsolated(src);
> +		ClearPageMovableOpsIsolated(src);
>  	return rc;
>  }
>
> --
> 2.49.0
>

