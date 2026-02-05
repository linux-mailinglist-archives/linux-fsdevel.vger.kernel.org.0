Return-Path: <linux-fsdevel+bounces-76418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC/QBouKhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:18:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76079F2511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BAD3066BCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F623D1CD1;
	Thu,  5 Feb 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8H7V2Bh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sGaVHPbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0E35CBAF;
	Thu,  5 Feb 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293617; cv=fail; b=BB7s1Q0+oBqipejq4z9o3eEcPoKSNfPdpUfqoq2mv3/MRsdEOyM585X/GReAfcR5txkeaRZxSQHNqRXyzjTUO7OYNYjekJknc8CLUBL+idiSc968tQgRoYrQh2YaKndysxkRL3ouWvgTeUNtMNOWHndqw6Ut5kw+u+kf9hVBx1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293617; c=relaxed/simple;
	bh=DYpBxRlGw3GFEdoi5KX5EGozF5x6lhARfhTFbTdP7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cotpzT+nNzIJ5DBx0P63gTs9YXr/eCy7shc/c1RIGWUgEjHi4a1t7XfC/Q/vZdK8VfLT7pPu4w+pwX23OeaHXQ+WYr0nVdGrcgiT3sUidyq+FMCLLLmKfqN+A3nxylZ3PPznxX5vwRbDfVWywMBE022AJykUknXh1G4tO8921kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K8H7V2Bh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sGaVHPbh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N8gjV2146435;
	Thu, 5 Feb 2026 12:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DYpBxRlGw3GFEdoi5K
	X5EGozF5x6lhARfhTFbTdP7S4=; b=K8H7V2BheyzMk3gySvS+rG2ChWWoeSjNIm
	7x3ftRiMZRoz3sH0vrl6v09JmU3l5sffbBHS2ODgahp1FHC4akxmeWVbFv0ZqnNU
	8Al7WyvCvMqgmv5lMH+49KRNNj14Gkuf7Gen0dkLlgFnVyJH14/j3v+QOEOm5pVm
	pAYzqhQbYMMXJcGnPrUl5FFhkaV4Q/vF1BP77hrYJ6N7ybneBTLzRIzTIe/gxG4R
	/mT2tsyJ1XJwxLdyuqeEce2II/0sLNKQR7obcsAJ5R9Y0mtN9jkd5SiFis98s+oa
	NRBKODQTq1KaCi8NzDeCvNbAB8TsZY3tb2xV6H85VxEj5GdCGg+g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7ukg1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:12:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615BmQKK002083;
	Thu, 5 Feb 2026 12:12:43 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186qm1bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMP9qxQvjS8yJAFB0U8LNv/XCgsOFdGuCjbR3YLVnYVI2cjs3obm4fh/n5zVndUHI/D2HbcIR0XBHzQ23Ivj+DslpmVhZUN1+XTPEH3qm+TiXKP67u/pNxjIS7h+I99fo7VUuLFtV1YJwDyKPb+33k67CQHEAF73qu9hQ2GqR+8YR2b27kF5JyezlHrorQr8f9H5MN2moAeKiVOsBEJLhx9AKZ7OlgHgJb034kItmpSyb15M6/Bo0YGZGlIykFEscVe/jQk+qJa/ai2LAPx/Ij71nx2Z5Wx7d8L6ywdQ9N0Vv3ai1q3PwbyHSK/5WoFwXdUHIAwDreFDIjE4X2NuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYpBxRlGw3GFEdoi5KX5EGozF5x6lhARfhTFbTdP7S4=;
 b=HbjTdoyi7oReCgyd6fgTNcA+0EIdV1+TXMqvHkMnXE4984Nm+f9s+Voj+5gl1wPCq3GId8MKdm9MSZL25dVqJ00yfECZcLhkkbL9AQfbFTlFjIyCJAMc3NGLhXrJpfI26sLSP6IMaY6mMIaGb0bg00Ie399RWax5fwZ8YcsZd1ajcSkC06pBjmfkCfzuKEK6p7VOJzmAaH2nhjvp27gZh2Sez9HdWL1Q8Opjes0is8PDoYBmlsp76S8n8s9BJvKxT+fLz81s7GmD9FNfly0BPBwrF8tCm3SzBDiE0n+iIN3pL4NF6WFsW+DJhjDQUr/vtHKnS5l0Uxn/1DZNSr7lUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYpBxRlGw3GFEdoi5KX5EGozF5x6lhARfhTFbTdP7S4=;
 b=sGaVHPbhhyWTmiOYq7jmxpvBBnolwGzYPztaJNEStZet0xe951gtLvtM4Feg/++hG0dAWRIdec5AZ1NyC5wLc6USTwX/cnGHmk3KU+p4cbIqrd+TdW9Q4LbtHY37bWlS66pqsTPBX6XAk52I5UhC/hdHD52moQlvzdS8P+Y65xE=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by PH0PR10MB5779.namprd10.prod.outlook.com (2603:10b6:510:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 12:12:15 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 12:12:15 +0000
Date: Thu, 5 Feb 2026 12:12:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
Message-ID: <a0894efd-bb67-4ec9-9801-4c52b381396c@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
 <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
 <507d24e0-4563-4b33-864c-cd1a499fe517@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507d24e0-4563-4b33-864c-cd1a499fe517@kernel.org>
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|PH0PR10MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ec0947-50e4-4fc3-6474-08de64afccb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsgJSe38R6stkDgE1HbFlzthPYcAU+12GRJGGIk1PAdX+pxyBbRwr6/7ZEwH?=
 =?us-ascii?Q?r0tuaipAkSqqARfzFOXLcZ4LXzdk095bwm9UFsnkfVT/DviTEFrvHyn5n+/d?=
 =?us-ascii?Q?wxkpNWtu3aga9NNrt05R0hMN/8nXr3wpjX68g0ECkYqtADbll3w8m/g+a3fY?=
 =?us-ascii?Q?3Q8Y9oNczUR/wRCaFpd84uYIlgAKGzO/PvZ5BYZupSzu+1uvd5kGCHnV8VhS?=
 =?us-ascii?Q?EG3EUuSzLL5QXG6E1seo3kr8dq1WyzNUWq2dOUG8Qo8bJSNYlwNNgZJZngTL?=
 =?us-ascii?Q?CeiPmffzMzydcdCn0Rk9SroLqi4yCTNGQb9Z/gSaefbgpJ2vPVFL+4uuqVBy?=
 =?us-ascii?Q?FQy2JKKb4FOj5uV/BcrzGjLqg0kowgjAI1ingtxpgHQKB+zO+1NbG6VIp6IK?=
 =?us-ascii?Q?oAYAA3G2fiH/urPjPqMyS3oJN6ZPsWAjbQSgXd0w6GlMsrfKQ9vXNmr+FQaY?=
 =?us-ascii?Q?9OS+NtsJ77sSjm8GauAbywZ1ZnYdLm/tlJcEgpT2ZTWs03FUmiU4BPXgvxnm?=
 =?us-ascii?Q?dLr2T13vaiGR7Ob1+mC+ZRH2joKgJtVsCmnhgW1T0Myq9KetKPgNaI1DwQ2A?=
 =?us-ascii?Q?Xhg1jVa4lS5UV6SItk07zlNvIiRfVuCApEBly1J0kO+2jmwNYeulsbHd1jgr?=
 =?us-ascii?Q?m495lc6YqbfHcS+aoO7A6ynYZHn14SgvDKGyH4ZlHypQZ0nBxTwF7QzAB5Lb?=
 =?us-ascii?Q?hdzbHCkSZzotoxN8q1cKNLQf25DlH4OAA4MtMayf17P/yKGYa3zUvDSpxdb2?=
 =?us-ascii?Q?NLiJf5xA5xS+zlTXPTOtbERwj489JegQmRiC8NIlLDcxrPqFQnX3p0Sb0gbe?=
 =?us-ascii?Q?CWwb5p/O5PIta6ptaYUNK3TOlr/9ZhTp6HO5OumpFzg6f6pmhMet9kIE6yk1?=
 =?us-ascii?Q?iZubQqERV9BnSaazm2P+DDGf/ef1u3lZE17vrjh8uoKrLC4nkIWBUYJt8Btk?=
 =?us-ascii?Q?2bG+QzVFr6b9mw0iyfdRKvnCacmq2EyOEv8cp5q1mTkxaKTwntucfbWtz/Z1?=
 =?us-ascii?Q?yqLWBHEMgubttQAW2+d8a+ICVnJg8/HPF5Jd+7S//hq6Twu82j83vpK1ybZQ?=
 =?us-ascii?Q?L1Ad28ub+YDuBl8aaDtJ+ro+uU+hmIuLM9p99AUyiWt0saftzd4qFQBJoOOz?=
 =?us-ascii?Q?RXiWH12BEM1aJ4TokIWayYFRLlsKy7ys9ldCK7IrfGzKDJl2ibDJS2p71tC1?=
 =?us-ascii?Q?oM2dUqJ60JCkAP5O0kDxgKSS/AvhlpsGKbAeOl6TZoBAHjkq+6cZBdP58UjP?=
 =?us-ascii?Q?qrB8A9YIGnoiRzl4bMQFwMNsKJ2h3J0XIwwh+ej0YbJuDpwRHndCnD4O4LJC?=
 =?us-ascii?Q?IuHygherKDkftHv6Qzyf1KVUBbSWO/XLFigXg3gpq0o2RNXyV7mbxqE0lasK?=
 =?us-ascii?Q?HNdo1EGY4NfgDC+sep6vWE9Dt5KQeYrUrI1bIXwoG6gZaN1cwoJcrAhSs5/V?=
 =?us-ascii?Q?edS9Qn7yr8Vn7dy6gOh36wKD7EX25rycKiEoDElMHUPkoLYYgn/os50EKE7y?=
 =?us-ascii?Q?uqPShhWvuS0soM4rHRy0rYJ5B7GUo11dYR8/j+n3CRU91EMGMH4mmyUobk8a?=
 =?us-ascii?Q?BU+V5+h14ycQ7MJFFz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KEBjxez9doh71TEUEje2GOaztvsPE1pBuzBNJ+lA5yo8y9RTZoFT95EWSg5w?=
 =?us-ascii?Q?m5twBfIKTFDqQMGUa64vqg4W1jc2xDI6yy7ImoZBngZZc6ut+UmGrIFjhfoi?=
 =?us-ascii?Q?xPv2lSRJQK9797/XJ8aPvSgeT2g6Bc89vO6OOgoWwi91OQUkq+4MY/w46mDU?=
 =?us-ascii?Q?ixYeEZ8rReJQX87uauljS8p2bGsF75G7qbAxrP7grq/cHw97FoyEabb5UT33?=
 =?us-ascii?Q?tlcl9etjxZHSufJn7mK+VNQh5I4h+kqXBYETJDVUg5X8ri7tsmcQZbMIlZAg?=
 =?us-ascii?Q?hhYRGZuMqKYCnZSeniTQrgn9fRQCKy5m50y5PGkhtpBCHca36LoHx+Da8hvQ?=
 =?us-ascii?Q?/XZoUPsV6/XypZaai6kVlwmgeIi+AqvLrdxtGFVIsYAf+/VvIoy2UDjaxlZj?=
 =?us-ascii?Q?bYL+5+IuNG6cseoKvHdfy0tYIy5ykIoq8wzG2Nu7l7zA5FqIfvRq/GLWIcfZ?=
 =?us-ascii?Q?+FZvyOzqUe6RYOfpq7ktGCkHLxbTnM3qhq+DizCb+k8rFcKKlkXyWCcpaC7x?=
 =?us-ascii?Q?Qst+MytByMaiYOvqSB46qfk5M5/XVSC0DfDJ3W45quFxXR9SvftfaefG/5Wc?=
 =?us-ascii?Q?uXGR0U7d7zM/w3q8RfxRq+Ey0CM0U1nKWWOhZPkgHszxZzD36V+8gf0XcTF1?=
 =?us-ascii?Q?FSYpSlbPx6k360EM1qb6TRAWyk9g61hLX04JVg3X7+yE6EBcNTda2TKZ/JrV?=
 =?us-ascii?Q?MRiuTdZPkUWJauhCOnI6FPkpph3k1xCGDRBdxoEZnfl3ghIzDsExMozCdwev?=
 =?us-ascii?Q?DAAZSwXnPMyCtBD2WiDGdu7Lkqyoqn19ElDSWJ/5RGey7oF/UJV1EKTQoKjt?=
 =?us-ascii?Q?L0sRoThmQy6kX2BiguOM/8OsrviGzVORtYqWKlNH3Qiix3xekiw/cDK33Zih?=
 =?us-ascii?Q?51YPDSjy4j4Du1Y7X7xDKeiNl2MGxM+hdeD1469UbVKofflj2IbwEGT3XJAk?=
 =?us-ascii?Q?7aR7aq/YPQD82l7JK5OKxD1fxj6ViXgt3g05DSojpMC9y86yGPjelkEA4TFU?=
 =?us-ascii?Q?/xKP7D87rclWHzL6+tJTj8h5U/RDSQX+7pAq+6IMZOajC4jtWdRa008Be9yx?=
 =?us-ascii?Q?82PK6zh5Lv9jCXuKyn+ENKPj+VnurTtzURqYAXR5J7ye0OiVGPwbtXuyMZJ1?=
 =?us-ascii?Q?UUvKj5RLNBMPAigZ2tMrgPxqTmoc7gz6YoDcgdi7goR/cReUN/MkP5XLQhB4?=
 =?us-ascii?Q?7y2py0B1v5ft9cOHzle1QbqxwpH+2W9pPt59j6q+oNRJvO1fW2BC+c+g5hN6?=
 =?us-ascii?Q?k2cmJNhuoc6boYvv1SGw2IejOyOod+QGe65L1ekUN9jBX5AFkmOiyaXW7ykh?=
 =?us-ascii?Q?jripxmhjywIT1hj97hgE1BHOowCefRLbvMjDzDyfhJomVHVdAvCeteTKSfqP?=
 =?us-ascii?Q?r7HA8VoNVdqrucDDYaR8rycJcxjJ/bH6WAAwZ0GPdzlpg17pzxeSv4NKq0kS?=
 =?us-ascii?Q?L0rlLsl4butC02PbJ4cdmtQZ730t8YMu2uH7dcJJgAL9aRsQemgxdZ5sm8aG?=
 =?us-ascii?Q?w7coNcAb9hmnqaXwZCbwqsdHIbTxDFS2abzAVH1Ibj58yA+iFwE9vZcKdO3l?=
 =?us-ascii?Q?cGFYXBtBfFzQS7DqZQeNS0E5y+XYeEKCBn8J+cPJx/P7Oz7AoUSzq907PAh/?=
 =?us-ascii?Q?fbo7yhwFQNvtHhjQI3pQr8a7Pp/ws4xoCvBlGX3zBaXPziOJOeA+u1/kqVdh?=
 =?us-ascii?Q?ZCK9FCeqARXOMBIzqE6BI5j98Ye5bUfTbu/upEiOXZWbhUfeLWovMcnZFLLQ?=
 =?us-ascii?Q?UjNUH8do/iy8Sc34CpPE7oUyH7x+V0A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wePcqfy15mmK1L/gxuwQHqyxc+hEof+MW+pLeTiyakZfB3lHDi619YU4UMv+m0WkOr0MAu5pqPQye/9ZuzmVhJiv5ST9qSoW1+BpIHnM/QOL1d5baEsw7wOEpDkpT/k4xbwVXvCtLhglmR8oiuhsK9z5dOKzKP+XDTDW+ef8VFctqjw47gsdO6m8rBdeocG0vWbxt/sYPKqx6Ii4fG/fWG66gJjEN/pe1oNgERs04FpqdmsJ1gSQD9hxHcFqjlmkSA/eLXQPEqP0pUejxmpIhmeslmaX5PW+a6ilYnSrWwOm47mQCFY0eAeFtAxxzW76NWZKZdOj9p+CycJJdMpMOvlnmrQy/H6yPj0RzgL0Xu9JA+OhIudKm3CnTi9wc3v39pxSVeDNFEaCY1h54QH1SL02AIJ68DOgObN8AXQAt3Hsou6qyFi6S7RlQL0Bbul0W8w0OUEHOuVuf72vcG7V/mTRwZBQOtNBqzqcXrtg51Eq9Z/eo5iAfuEBZv3DcO9f/R4Kb65mAs/ucF0CHXH30HcRIFDdbbbL9KP9Nb9nrHo5KNJ4zTlkKXztPOWW4mnOWQw2sQKzG4lEf9g97xOoOruOnYH8ihxrsx11Kbcwra4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec0947-50e4-4fc3-6474-08de64afccb8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:12:15.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VixRmjf2UQdwpa/eWSm9e9DqqpXIGvmGjT4hvcZuXv77Ddn3So0P0OdDK2MG59fEZLZGV7ihq6tF210o4RjfyLrcZfR7l1nm1vsrXidTsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MCBTYWx0ZWRfX48H/KYr6In9R
 Kajv10XUyAVy8yNGu4y4usWdOlAlY1Wfby4w/gGVTK+RulmtenM/GOTWEgHHQ+CQZ1hk4/bxzSU
 WsdUd7ae4Cf+rwmfmYcXPdUaUFmJdSLOR7vLXrBGpKHV/kFxBxKkbiNoXjLkQ8wYoAs88/Zy4Pc
 EXROmWcF/Fy0NN+7G/kSk+UA8JvBr/t4+dQFhPWR9VmW8x25G/ozkJmSuPHHjM42vOgAZmXULX4
 AjqjXh0BiXGRAfmU5Nce+X5LSIUVDUy9lWVqM/j4jRIGlpnn2KUlBem3aytYxNz/oZsNGbtq7q3
 12aFf/liw6ug4XjbEKRlLwvhBviNVmdOoTJKTnbvl10kmKbR811g/70VnUc42HATkiHQBmzJ/Rk
 GMmj80wB2qXU+Rm23wD9+6nFq16kEHbNj9kza4zdb+7nyJMyExXmHjXfpB33L0+rXJnvHwUzx50
 JUQ+ipXYk5rftKVlc7gc1LmfHQAGHJ2uMhiJJdJQ=
X-Proofpoint-GUID: UpznKvGUKE_Q51xnEgm2Hbwy5wfkOQbW
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=6984893d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=c5W_LfdYUKB9E4yShOkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: UpznKvGUKE_Q51xnEgm2Hbwy5wfkOQbW
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-76418-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 76079F2511
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:03:35PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 12:57, Lorenzo Stoakes wrote:
> > +cc Christoph for his input on exports here.
> >
> > On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> > > On 2/5/26 12:29, Lorenzo Stoakes wrote:
> > > >
> > > > Same point as before about exporting symbols, but given the _obj variants are
> > > > exported already this one is more valid.
> > > >
> > > >
> > > > Sorry but I don't want this exported at all.
> > > >
> > > > This is an internal implementation detail which allows fine-grained control of
> > > > behaviour via struct zap_details (which binder doesn't use, of course :)
> > >
> > > I don't expect anybody to set zap_details, but yeah, it could be abused.
> > > It could be abused right now from anywhere else in the kernel
> > > where we don't build as a module :)
> > >
> > > Apparently we export a similar function in rust where we just removed the last parameter.
> >
> > What??
> >
> > Alice - can you confirm rust isn't exporting stuff that isn't explicitly marked
> > EXPORT_SYMBOL*() for use by other rust modules?
> >
> > It's important we keep this in sync, otherwise rust is overriding kernel policy.
> >
> > >
> > > I think zap_page_range_single() is only called with non-NULL from mm/memory.c.
> > >
> > > So the following makes likely sense even outside of the context of this series:
> > >
> >
> > Yeah this looks good so feel free to add a R-b from me tag when you send it
> > BUT...
> >
> > I'm still _very_ uncomfortable with exporting this just for binder which seems
> > to be doing effectively mm tasks itself in a way that makes me think it needs a
> > rework to not be doing that and to update core mm to add functionality if it's
> > needed.
> >
> > In any case, if we _do_ export this I think I'm going to insist on this being
> > EXPORT_SYMBOL_FOR_MODULES() _only_ for the binder in-tree module.
>
> Works for me.

:)

>
> Staring at it again, I think I landed in cleanup land.
>
> zap_vma_ptes() is exported and does the same thing as
> zap_page_range_single(), just with some additional safety checks.

Yeah saw that, except it insists only on VM_PFN VMAs which makes me question our
making this more generally available to OOT drivers.

>
> Fun.
>
>
> Let me cleanup. Good finger exercise after one month of almost-not coding :)

:) I am less interested in cleanups at this stage at least for a while so feel
free to fixup glaringly horrible things so I can vicariously enjoy it at
least...

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

