Return-Path: <linux-fsdevel+bounces-72928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3940D05E70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E74302D2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30F32D0D4;
	Thu,  8 Jan 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjIahBvS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M45wtpnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7071327206;
	Thu,  8 Jan 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767901686; cv=fail; b=qYCMlXvH6gyfBX0mO3naqBWxFs37ufHLgdUgBd2Q0VdvNFLg3P8RWZXXoTnfvQrCn5zMJTTaEm8dt9DAzyj6Esr6XNuvT4sivztvWwIp+tdau3GJkUN2pa/sqsWjwLbRXCP5c6wkn04XeS+MLx6R2bL/xK1eC/H9E65Lq/BE+ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767901686; c=relaxed/simple;
	bh=8wmODxNOF6Gpbj1PncaySL+zAx67708kCK+8gAq62cA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EsdR8pG0Lio3TAapU9ws9zQbuFe5WNF75eTPPd60AQmyvVvgRXwp1rFA7BP3GUojB7geGv2MhEXyZtmCrBd+4THm6qYbSq2NQUW/N+5JqPQ/5CqoNfUJAezoU80FZBr9XGJvmktgON02ytB0Ma+o6Wiq+9xCeNTRdigJ9zXoClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XjIahBvS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M45wtpnC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608HMGBN610876;
	Thu, 8 Jan 2026 19:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6kSzGqjjmpKoi9SJc3YbyyjK6se1+IkIbRsVWbwwR+Q=; b=
	XjIahBvSQ+EDMbU40BZfIlvd3vX2tUzOSS6yJYke8zTxgB9bEh/A1a5iCTVF9RfM
	n/ARdUY7Sr0Ciu8SKmT/Gm6xlphAMFlHhSNBZC97ZIQwn+H5Mq/DpEOIlNrKjEX/
	NVaWYUKSghLSVl+suwnXiENTe6Xid7ONnlqAFNKL1cc+8uNZpMOuJVkneP7KcOQt
	SbkjZNxAa7wXMZ++c0CcciZsdL4dyjiblEKH1zKoBvW7PsxE2BTqLCXhWq5b9vlQ
	0SeVp8yipJ1BVE0vb+mQkSu+10/522KaNpejJcB+YwNfq5D4d2G6xhbCgxG/YZAp
	X8Ao9MZfRG7Fe87wvWAS8A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjgwx07th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 19:46:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608IFm7e020371;
	Thu, 8 Jan 2026 19:46:39 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjngrnp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 19:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISDs3KpT/qnxkgko4tBsb827Yt6HnBMPsS/mD+JGRfNhsNy9dYyiSjZIYuJbM1Y0OUlyOw3LSshcka2KzX6/Y1tJAd3puAuAdbLlE+YxfT4mifv+jeifKG0TFTYhnZ6/02aqj1ph3tTLas9EUZGMQQs4iOkRva/KWAHd+oW/WidsSovhBU/AKPzXjeEAdapxrXrEjt/hrLXYbxLXqFRfO6LoelCzFp/B0jldyfFMAGWJYiLkFY5dO4QEh0VN2nfjft1bskEl5hqctctVNZRIUvf/jMM8mMBXp+1IyCH2U1CFM4+7GgBCPenoje1GgF1DHeFjtQSiq+5UsfYV4n2iwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kSzGqjjmpKoi9SJc3YbyyjK6se1+IkIbRsVWbwwR+Q=;
 b=zPwrVfK2oY7bEmLawBhxI2kSKpx47oThf4m12EhxUCJXIsKbxzy5eRLz7onP+grFUZyRxVJqXpwjUtJhTX4bnXp/MGP1PxeqXf1Ouh8y7bqOKl27BXu2YCCTwTw8qLB26+Y0gtlde0SLatEl+CId5UZ53Z0MVzNIgHrFLVlSHqvfJTHnb6avynz5vbjqClH8FjXxjqGDrQ/2KZ6wf+ieAET9l/Ks2vLpTHjUUzURsT4U9HaTsPZ2QSk+Hzx5j1RGn6cttw2zki+26imTsFX6UuxBRHLA0cD/W7E/uzCMGu2Vc+OLf5R4TgpPto1Yy2Lw26GEa8yepZCuRjWy7sE6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kSzGqjjmpKoi9SJc3YbyyjK6se1+IkIbRsVWbwwR+Q=;
 b=M45wtpnCi1yCAFnheC4hmTzyAXiucAy09TG1/GMnhUBgl3vvxBWJn7m7cK3iwYd738+m3QVysBUjrBQRXpLRKVDX3hYAnm+T1vxH80GzfpNM1hvcFjc/JJgNRto4Jbv9FvRxWzt1NQo7X4NS1OQ9XxjroZ5wlKxv2DU+EFnQDRo=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by DS7PR10MB7277.namprd10.prod.outlook.com (2603:10b6:8:d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 19:46:33 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%3]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 19:46:33 +0000
Message-ID: <e16a8bff-9192-45fa-a349-79b16fdd3ba5@oracle.com>
Date: Thu, 8 Jan 2026 13:46:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] jfs: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>, Luis de Bethencourt
 <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Anders Larsen <al@alarsen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall
 <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
 <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
        v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-12-ea4dec9b67fa@kernel.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20260108-setlease-6-20-v1-12-ea4dec9b67fa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:610:119::19) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|DS7PR10MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: b37609bc-adbd-47b4-bb70-08de4eeea04a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ekZ4cE9TZGdUVzNmVThIVzl3TldEOHQrN056S3BNbHFQZm9hODEyMzZobG56?=
 =?utf-8?B?S09ZOEN6UTlBM2pWaVV5Vnh2SCtGVFhQTHlMdUpmRFdLWVpzamdFdVk0Ym5t?=
 =?utf-8?B?MXlFKzNoL0RFQThkY3NZdTJ0RXdOQldFbUFzemtGRHphQWRmZTBpYUtrd25L?=
 =?utf-8?B?YWxNdEY0UEhpRFRXRUlURW9tZFFRQ3Y4ZHRWeGQ5eDlMdGQwZllUUWRoTFBF?=
 =?utf-8?B?T2pTelVpNFpualp1NGtXdjFOTDl3UnVwNHJjNmcvTlExenpza0dDZ1RUc1Qy?=
 =?utf-8?B?SWlpVDROQ09hZjFHY1ZoekIzQ0I3MlVqRTBLcmRSeDdTOE93c0IrUmdZNjhq?=
 =?utf-8?B?Q1RDeG5iaGMxQTRVSWEwenpQNkRlUDJ1YTRSSUJyVnRGQmxOOEJoN2IxaVJY?=
 =?utf-8?B?VnJBM2pHZVFOWGJsUlIrWmtlQUIrSnVpU3FiL0VMN040aDFNejhKejBUYWF3?=
 =?utf-8?B?UGUzWHppc2RkQ3BBNlhkSG4veFdEUXhxNDkvY1NUVnpFTFVCdi8rUFF6aEtl?=
 =?utf-8?B?RHNOaS9JN0pxVWUzdFVVR1ZOSTBnY0dmdk9Nc1NqYjEvQWhoWmlNR3VScWUr?=
 =?utf-8?B?Z2h3SS95VXdIV2tpQXRXWCtBNzZnN3pSSHRFdVVVQWxDOHllU1NBdTdxVXlm?=
 =?utf-8?B?ZkNDZFFXaU9jODh6SnVFeDZGd2l4RGk2WjV6NHhnd1VmQmZiOURPVEw1RGlL?=
 =?utf-8?B?YWhMdlpCUkZYeWViZys5L0lCaU5Sb09wNVZ5ZzhVamJWbCtWZzhiRXdyUEg2?=
 =?utf-8?B?ellaaUZpWk5neHZSRFlXVXlJM1RwSmNuMXdtS3Y3UEpXaGNzeEc4N0N6TVE3?=
 =?utf-8?B?bjZTZVlWcS9XUCtlTHFyQ29DZXRQM3pmY0dNVHNDaCtzQnpET2U4K2VxOFZh?=
 =?utf-8?B?MTBpRDJ0aHVBWDFaaWxIRnNjNW92M0kwYW44WTByQzVldVVUUlRTdTVvYm45?=
 =?utf-8?B?RnZZN3hpcUFNZnpJZ3ZadFl2dWI3cWQ3MHl4alpMbFNtanUvTUw4U2kxcVpY?=
 =?utf-8?B?aVoxZzFFS05lcWtwM1pWOTJsNjhVT2hmU09Tc0Y0ODJpYUx3SFhxVXBMZ29W?=
 =?utf-8?B?a1cxU2xTWk5oc1VHQ1VwemRFYVZMbGJVVzdRaFdOMjFUcGp6ODJKbnlOVk9P?=
 =?utf-8?B?NXBkZkJaNTBOcytNWUE0M2Y3ZTRLdjZRSG5wbTB1TkZCMTN2b0RHMkVJeXV3?=
 =?utf-8?B?WlUrcTQ1cmFrTkkxMHZ4VEdkV1dOMjVjUnRKVVJHZFlGTzJ5QmdETmhqSVBJ?=
 =?utf-8?B?OFBkQWhiNFp0WitsTTFxT3NrL3hPTXNBbUY0Vnp1VlU4dVZ4SEJWS3FQbmVZ?=
 =?utf-8?B?b2xUR2U1S0FvNzByK0pvNHkwMVJmQnN3NzZrUnV0R1VzaS9tTjNPNGF4S0d6?=
 =?utf-8?B?cVUrNFVUVWM4ZTlLc3dqV1o2UmxGTUZmYVk1eWRFWDI1L1hjcE9KOGhMNEt4?=
 =?utf-8?B?anFLY3c1ajdnRVdUalplYWp2VUZ1NytUTWRoV0p6YVNsRElDV044TS9rcVpY?=
 =?utf-8?B?V1NOeHpxZndBQWFtZVJTa0hhR2taQzFLQTN6b2xWL3pGcHA4U0xCVU9iQnJL?=
 =?utf-8?B?VHk5UFB5U0dVQlZ6dW91ems2RzZGUmQ5U1FvcG5SRkRaMVF6d3JTZ0NKVkx3?=
 =?utf-8?B?bWxZRE1DOG1QZzBYOXJNazlDMVRmZTQwOVEvR1pLWGx6M3Zuemo5NUZLKzJT?=
 =?utf-8?B?SDdZWnAyeXhYQkMzaE9pZEJRdHgyOWdDVzd1Um9hZStQZ1plYkR5YUdvdCtE?=
 =?utf-8?B?dWFvM3liMnEyaWNZbnZ1VCtqS2grZGcvUTJ6TUVoWkRrZEFvdWNqbXZQZDh5?=
 =?utf-8?B?ZGd4eVVLQ2NNTXBpVnptQWl2Vm8yUFd3WFhiS1dDN28vWmVNZHQxZlRPc0RH?=
 =?utf-8?B?RHFKSU5EK2JmVWhBWThEajJqZ0hPSTQzQVhWMGtBUU53bjNLVmZONlpvWXN0?=
 =?utf-8?B?MlFxbVN0YkJMTDQvM3pCYVFna01lSk12dlRJcm1YRWVjYzgrUWtidjd6ZEti?=
 =?utf-8?Q?+HiAcK5KQqqQqfJEeCMbOXKGk0ZYO4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y3pBbzJFTVgxMUtUc2RTeWluMFdWa0tTUTk3M1RVQkJOU3FQcHBzNHdVaDhM?=
 =?utf-8?B?MmVqT2xNNzdOdWE3SHRpbHd5aU5PNkZ0dXVDOUNDYlpQTEE1eFRxcUpqa3J3?=
 =?utf-8?B?bDVTWTh3Tkd5UGVXU1JQcE00QmdXaEZGd0NFVFRoR2dlYVJmbFkwV0FETG9C?=
 =?utf-8?B?WUpEdjFjcWw3S1BJWmhyWk9lUzJtc3hoV0Y0a2hlcnBGTzBoTEh4MWNibStY?=
 =?utf-8?B?TjRkeTE4ckpvSkM0WXRnTm42S0VtQitSMDh1QTRTY21EbmYwZGNid2JaemJ4?=
 =?utf-8?B?R0NqcUpCVm9uOU5vYlc0U3o4RHNtNUpQci9XZy82Y25HcFl4eTY5V0x5eWhL?=
 =?utf-8?B?VUhoK3V2WlNiNjRrMndiRUhhSit1MGdZQVIxQnpNdDFpSk5PL3gzekZqSHlR?=
 =?utf-8?B?ZDBWWnpSemxvd3RKK1dmYStiZjhBS2ZDeFNkL21IWjRTNzlIbnZNWWQvVmVx?=
 =?utf-8?B?RW44alo5Q1dWODVNUGtJZkt6cWgxSUxWME5nWjBvWE1iVXNWT1E5NzV3MGph?=
 =?utf-8?B?emkycWhtSE9IeGN0NFNuemU1aTdPZ2l6N0twQmdSbXhKWGdJRjNBOFhqMGdn?=
 =?utf-8?B?b0I4T2hiVnFYQXIyMUpIRk9vWFJhUjU0WFNVMTJpTEJaeVU2Q0I2RlZqWmx3?=
 =?utf-8?B?amNMWC9ZT3FKT3ZsaFVRSFZUb0l0TlgyZkFocnoyRXpidGtGK1VRbit1MDBM?=
 =?utf-8?B?WjJZaUJvb1FZZWxuajRFS3F5dS9CYnRFOTI5K0hoRUkzMXRqdUt4MmFuUDBj?=
 =?utf-8?B?VmFmQTd0aENCTWd0eUdvL0cxVGVIUGozT2VPVFpyRG5rakZqRmVHU3pnY2p5?=
 =?utf-8?B?a0pXNUJZUGJPeHdFVXdZcm5BVktDV0tOemNNMDlVeFo0SStwZTd1eCsvblgr?=
 =?utf-8?B?WUZoWFFnb3l0ek5KVDFXd0xhek1xR21TaklzcnFCRTRlVlpQK3lLNFVtbi9U?=
 =?utf-8?B?dERZdGdWZCt2MlYxTTZqZFV4L0JLMkZSdmY3Tll0L1ZQRGwvamdyajJ2ZDBv?=
 =?utf-8?B?aXhpMVU4YktKcVVaWW96ZmF3UE1lNGFHL3Z3L2JJWnVzbXJHeUo0dXk1dFVJ?=
 =?utf-8?B?UnlGNUM0RzZjaTBwZUFoNzd3eTNoSUszelhUWENBSjRWV2NPS3pxK0ZEeHVH?=
 =?utf-8?B?N2Y1TWNSVUNaWHRzNFRvM0gvNWVYVnlSc1NZQkpxY2U4T1JlQjIxNHlJdkFm?=
 =?utf-8?B?RVhjQUU1T0Y2RitXYnRSVHVtaUtaazZNc3JNbDBOYU5GZVVqejQwUDAxUHRJ?=
 =?utf-8?B?KzkxcVFpTzYya1dBTXJPVEJnV3Y4QnBzM292aGhZdXEzVnArNnh1cms0Y2Yr?=
 =?utf-8?B?ZWVtcTZwYTNWU1RuWmdEVVl4bWZvM2dHblc4a0ltZDBTUHF2N2VFcEV0a01q?=
 =?utf-8?B?YkxHOElVeE5oRWU4SE5LbUJuUXczc0FSeEdhclYyY0hVUFdCNGpUeDJla0Rx?=
 =?utf-8?B?VE9ZM0JtYzFuNVdyRFZ4WXVjSUhteWJtL0FoRFhyY29vOHN4WjRNSEptNXBH?=
 =?utf-8?B?STZuY2IwRmFqN3Z0NWltT3hFOUtpckJaK2FrQXF3RjByQStKbzdadENZblE4?=
 =?utf-8?B?cWx4N0ZvTTUrZFE3NVJIMUNOZzlFZ25OczhpYlUzRk45T1RDQjJDWk9UcTY0?=
 =?utf-8?B?SUZkNXk3eVo4bWp0QkpaS0dZZlViNHFtRmh5U2xldWJIUXB0bGZIdTdvamNy?=
 =?utf-8?B?WG93L0NZK3dmNVpNRjN5cEE3ajNLcG5teWpUMFVBbGxyTUIzTFFGVFNkcjBy?=
 =?utf-8?B?ZUNPMlhvaThNTmR1WDNhQk5aUTFaajErMVdJTkREamprbWMwQkJUaVNsL2pw?=
 =?utf-8?B?MHFUcWdQY3ozMUhVdjNsZ2pLMDB4N2NCZ0M2YWdUVWhCeE54L2NDdHgvSW9m?=
 =?utf-8?B?K3dyWm5FNXpKYnBGaGF0UklNd2FPV2xtZHhYOE5WRXNHYkplYzBUbkpPelJL?=
 =?utf-8?B?SS9panJVSit5bFY2QVRwZzZQbnJpamxHRlNLWlA1S3lSRm1SWmdzS2JtVDRh?=
 =?utf-8?B?NHlGWEpLRU9BQTQ2SUMzSjc3VXIrdDREdXNNTjNzUUUzWjFkelNpdW5ITEZV?=
 =?utf-8?B?RTR2aEp4b2orZlVJdkRKZXN1ZlE4bHAyNHZxd1RHV2pyZjRSWlRUZmF5M3Vi?=
 =?utf-8?B?d29CcGVmbEJqcjJwK0xwb0tGbXpiSzV0T2ZkM21sdW1kOSsvU2F4dDFJMUls?=
 =?utf-8?B?OGZHamtFeVVjd0xkTmdKaTduZVRnbWVHRXh4d2VCR3ZodFBvM0ozS0hLT1lj?=
 =?utf-8?B?N3BDanhZNFVYencxOGxTRXJ4SEhkblVEZ1R6ZjA2UDRwK0Zab3ViTTVYY2dn?=
 =?utf-8?B?bFBFSWUwczJDMjBncFl5QXM4aXV0dE9KWjZ6QzNpT3NjYzZQUHVQeEFBcENQ?=
 =?utf-8?Q?E8hHTZQbxBDaCz6w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NfuEG8YxZWhHy0COKGz9aqo6/UO+QsJ8CW8cIsp3Sa4uOHTXWVC3nFgP7CdTBMbJgOuCQ9+XG6XZRHOQdKF/Dtond6ysLgaqDjgr9a+doAXN++mau+i43StBRD6+FxJ46SksqK3/8E0Dxxvz84n/WQGbTu6ETvcliF84RbzqLxEjVgCqAmvLIMThryhI7MajIQLNZ1RFE0g7cJwjctK0iHy948wA93w2fbOatJWkM8C8/BAbbtqrLg80UlmtU2OMlhSdyo+Ln37EvN5XnivGDHhOaMhNxpgvnmhfPewFH0d9DRgE99hKGkmZcA5pmZPkh7zv5V8liIL9YsL9Oy4zBJGmQNoe/UAt5Yy/Znuu1LYiEbOzHBIoI5rT6W4LyIBG2xc1HJPNgVqm0UVREpzXZBbqHMvYYKyIn3W/rfgX3BRcEvoVeSiHdT31pQyo5xW39pQiXVLGbEnmYZbtwvn+T9K5hXv6lsS+9SdHPlz5oKc7TD2kYG1yj4vzCdb4jCm2yJVQU02Zz5PVWKLBelkWk6zccSCnZR4gPBXDB/naQwJ+F4R3c5Ir7Q2BrzXE+DA26gIbxfJ7+aFujSxXwKCgtPMA32YeOfO5Vtle+4FhpVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37609bc-adbd-47b4-bb70-08de4eeea04a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 19:46:33.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTWEHrHUhSFIVZyxSAt7JiuZXHOcW+XAh2h9Zu9PqKxKzta+nZ0nbkngnrxNPgzXdA0TCi0F7Jy8CxKOvcqL2uiMm/5EbicGbHkv1ZyXIiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080147
X-Proofpoint-GUID: sf2jjOwZv1Ke0FSQAq0leWYEjSMDHTcy
X-Authority-Analysis: v=2.4 cv=JYSxbEKV c=1 sm=1 tr=0 ts=6960099f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=5M8K4nvISJ18i9EF2vkA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: sf2jjOwZv1Ke0FSQAq0leWYEjSMDHTcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE0NyBTYWx0ZWRfX45GzYFa2HhIF
 rbm9MGga4dJF5QsGJeGD+In6BQ9ncOe52zHx4EycFSktIxLGIr48TnBoHe+sQZd8UWtCbmUiuc+
 iIlOtyscHNt/PpSsqAx1q3+EbMCxfFGEo0Wx8w32bBrJn6nv2pmrepRzcrXor1IYJosVA22PchK
 KM6BXXIj7fP/8GVSgOlg/AFCMJYU5YoBaPyU7oFvxSwkbC4Hsz0iWKTnWEbwro53BexWsZ03VrZ
 y7+GPS8ZZUMg2/7IrqNn212Yhpn7IgTozq1VOf8BTapoDeWXtG9wuR0cBY6D1M4zKA7nVBlXlzr
 YCe2mg0t0feM+HvgxUVuGayVGvyBiZRQ9yD0FDYjOvJgu5/qAauTzMZQXtEHXvaqCAUP6Q0kRDZ
 AdgnkPS6yR2F31EKX43QZ3lO73FuUU4t6XJnjOvcYAzgujEoWkWXjxtNEauv1fDlmCrTMDCBOuy
 YZ6f13xqhTb3qHn6Ez+mivCf8dAhaSyT1hX79lzo=

Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>


On 1/8/26 11:13AM, Jeff Layton wrote:
> Add the setlease file_operation to jfs_file_operations and
> jfs_dir_operations, pointing to generic_setlease.  A future patch will
> change the default behavior to reject lease attempts with -EINVAL when
> there is no setlease file operation defined. Add generic_setlease to
> retain the ability to set leases on this filesystem.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/jfs/file.c  | 2 ++
>   fs/jfs/namei.c | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/file.c b/fs/jfs/file.c
> index 87ad042221e78959200cce12a59a3ffd6d06c0d7..246568cb9a6ec144831eb3592712cce323d8cf1d 100644
> --- a/fs/jfs/file.c
> +++ b/fs/jfs/file.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/mm.h>
>   #include <linux/fs.h>
> +#include <linux/filelock.h>
>   #include <linux/posix_acl.h>
>   #include <linux/quotaops.h>
>   #include "jfs_incore.h"
> @@ -153,4 +154,5 @@ const struct file_operations jfs_file_operations = {
>   	.release	= jfs_release,
>   	.unlocked_ioctl = jfs_ioctl,
>   	.compat_ioctl	= compat_ptr_ioctl,
> +	.setlease	= generic_setlease,
>   };
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 65a218eba8faf9508f5727515b812f6de2661618..f7e2ae7a4c37ed87675f0ccb3276b37e6ce08cb4 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/fs.h>
> +#include <linux/filelock.h>
>   #include <linux/namei.h>
>   #include <linux/ctype.h>
>   #include <linux/quotaops.h>
> @@ -1545,6 +1546,7 @@ const struct file_operations jfs_dir_operations = {
>   	.unlocked_ioctl = jfs_ioctl,
>   	.compat_ioctl	= compat_ptr_ioctl,
>   	.llseek		= generic_file_llseek,
> +	.setlease	= generic_setlease,
>   };
>   
>   static int jfs_ci_hash(const struct dentry *dir, struct qstr *this)
> 


