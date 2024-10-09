Return-Path: <linux-fsdevel+bounces-31440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14100996C49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382751C20CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03B194AE6;
	Wed,  9 Oct 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC3eiNBG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NshZmfbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24419644B;
	Wed,  9 Oct 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481028; cv=fail; b=QDn9sqn3FZjhJDN8/zBWpj0vOyQvjZJPqhF4CCYyMU1ukTyN/wfpFkMiyvga4MvG62uFl/JzkCOu82tnV8i3zYPUw/YBPmKIGt8ZZaoRVzGHPSvHkkpnrPS6UvqWE1RW8eG8LKk5taOfNZqPOH8cxL+TCPT0xqoOALLH3Lg0paM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481028; c=relaxed/simple;
	bh=B36TGe39dglaABi7tGT0X64AoBxqvBCINKTm69P86So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nj+hwXnVH6VA4Qv5l8xBOAQukaTDTvdpoehdHFAla1KMfuKXcfOBAoNd3Z2E2O7ClxgILKZjlC42OwIK64oxiiC+Eb48CsYv1mb0AYuFjlCUK9s5bMqG0byIbxEOdFh3BdBHChvJ6dYA4m/FJ5awoOM2IMNozY/fGgRHnahjeP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XC3eiNBG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NshZmfbk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DMeQp030269;
	Wed, 9 Oct 2024 13:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VqBBC/s7Hf2RmCxykD
	brmy9uHXQPtn87qGlWAjQUoTg=; b=XC3eiNBG474vXvrX+uW5OhwU+s06v769aM
	SCmtIG5vKUW7O449zz4QmHqFGEIa+DShiNQ/FbaD+o/glQxrACUIdSsiKMofX0WZ
	pgpPIMQA5lzrPWICkSXtFf1bNR9Xf+wWSKHLjOb6RNyW5OVxHf865ucxVByXODNE
	IPhRVPi9TFtxNessLuDsmUByJKgWBG3YVhQ94dK6LvMSUA4Bm8PcGXHrpt/SeIrY
	nZ2xiWuZOCeqLm828xjQP/MKoT4a4jtUugwcnf8sSDNHF7MKHDn0tjcJEA/CFgNz
	MZ/YhQAeyNloFz9mLymAQElaR52yM9ztbbUMa380ImNBhc1Zdm7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306eg9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 13:36:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499BomLj019119;
	Wed, 9 Oct 2024 13:36:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwevtjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 13:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ5zUJzAuVWgxCEpazBeNIK2Xs45WYyXs2J3h+sEFHj1wfnf/mmmBD2YqE1TYL2k5xobZpsAVPSdR7hc86rO5EbjXeiQoEvqgH7VzlpsnRfwh9xjcBz9kwhi74w3yMyXYEp+cfnJyECHVLQAxTmSgYO2srd8bRJI/UObGGx+k7/3jh2HIUebe1kkWxvZrf/ii9raqx177xIPotASxQo0OdAcSnyL7euBVk5PEhkrajykD2I78xvZ5t3MqgNqSWm2cuSFnHBOrgaypyu8Kn9o1V7zWnNrjLujBLPWC0HJdbynwW6fZCcTquAm0OmOb7E4T2yeRXUD9X9WHI8E06JkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqBBC/s7Hf2RmCxykDbrmy9uHXQPtn87qGlWAjQUoTg=;
 b=hLYVJgGCXnKjVD15Z2fmBzQIUK1D7oPmc0OCMyEa9jCNRWZ+Mhf/nD8IRpFX7eZAq9MnizoxoSMz4pppzeu/m32gdpm4bdAIN6ibK/fRS1iLkHqmDVlskAd6bdWeki6fW2Tyi68wT0CNVEmJhcKdAw8Ug8V78XZNlwdenT15kzwErUxKxA9LE1QMi6n0U4lw4xZCaLBoQB/QtWr6Gx10QD09YVoj4tTIA+q6XuKAb3daon5G+xTtN6hG17hJakf1TWsK/TJgzFgCGEsmysm89bl8MzwGVQKcNZrvk3CDHqcnEeClnoTcNMw+OEQp46PqZqTDDZtzgENiBCR6YtAcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqBBC/s7Hf2RmCxykDbrmy9uHXQPtn87qGlWAjQUoTg=;
 b=NshZmfbktg5+2of4IQXkOwUNVFSHs8dltBxtIsyUsj7ia5eTTZx2dLCsy/OjHS3BBdsECnA1KekjjO5hczQ1JrVOb/W+iquFW+APSswdMll82cru16ab95XJnDgk8rGMXJWlIw8RVWkfFLtSdUJweBOj7MpPn0tWZxSXWL7uwIg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6579.namprd10.prod.outlook.com (2603:10b6:510:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 13:36:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 13:36:17 +0000
Date: Wed, 9 Oct 2024 14:36:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        alistair.francis@wdc.com, richard.henderson@linaro.org,
        jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
        charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
        cleger@rivosinc.com, alexghiti@rivosinc.com, samitolvanen@google.com,
        broonie@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 11/33] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Message-ID: <22972e7b-0844-4ebc-8d82-a0838b83c3a0@lucifer.local>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-11-60d9fe073f37@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-11-60d9fe073f37@rivosinc.com>
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: f693ca50-cb77-4bdf-61ff-08dce86759f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFirn0/qP6xKBoQ2tc42JX+QiDmsGhMxZh/hZgVjEy+ipHPPPEZEXQa10nJ6?=
 =?us-ascii?Q?w/YaH6OD9mTOrUBbOjsFpp1HmkNifZYvFpqlMFStvwAWdJTfw5Lsuks+IWQv?=
 =?us-ascii?Q?ajfUOf/XddNHfJqaa+5G61cKyA/FJSrW+9FLh2qAYFDMiFO0XSgUSKWaShMw?=
 =?us-ascii?Q?UuyUObWOsI+Y1hNYuoknCHyY7hG8pVrfaAWBorLyyEWy7FueJOZCR1M6HRjK?=
 =?us-ascii?Q?bSqYSd/+2TnN3bPOVexPUduax7+e8ru44YVPhsBGjqS6FOBxM/xYc3feF2tm?=
 =?us-ascii?Q?Ie2FvhLPjEG4qH3ZGDcsFbmqwhq7N+uTUYPc2m040zt9YtaCCgwNURxJ/UyA?=
 =?us-ascii?Q?/iEBUW+nZS2L4Jb6fkI2zT8z5p2WYv1G6RbOJ+mfRgdEJjDO6cfY7XdNPprf?=
 =?us-ascii?Q?J/q/KNWI4LdFGF4IC8yNdDzCf8Baox9L3kXvgCneY3jo4Gp5Anj52+e1sBK3?=
 =?us-ascii?Q?RfevSTiLsRuCnhnuvfF24BGkjQAlGcbKsMiRHxOSwiniZi3p0D0zzJkqQhGZ?=
 =?us-ascii?Q?zY56wa8ta5HrUvMT4ervpFqK/zrw/JJ5ogXXZQfT6DYjmjrByWEIjRaF7EWz?=
 =?us-ascii?Q?Xrtme+IEmLR6+7gjwt4BbQ4V415tzYAh0A0DHlfPS9VC9FLTL0KMYMR5f5PG?=
 =?us-ascii?Q?fp4u+Libm5RmZIFCPQD6sXccLaq/1ZaLejoRzhUppeEDX3xBd2gc2wQsqtjK?=
 =?us-ascii?Q?Lcrs4+C2+R3HIvDLFjYxODEe4mcLb9pAlIVrDOZ1v8qAT7vN/qWNUxgPXF96?=
 =?us-ascii?Q?nTRYAfcn3YZrrvQTBCzKaxSbtUqfgUYiAN1PaUMurZ013vjR4xNgEY1r5Hna?=
 =?us-ascii?Q?YQ+Tcaqd+ghDRAju4r8kEHuhfSRzPweUHTcSVnlG/kd1GLL1OKYFYWctDk3F?=
 =?us-ascii?Q?QPM21CZNFpwBsWR4EmBB6LDsA3qupjvFBFsHgq6v51vRTbZdMhW95L1iu0BC?=
 =?us-ascii?Q?yUS/M/JZBkEfQLf5JDhsjdgEu+Za9HVmeh48hyzCFe2hN70mCoiAj+hcPOnv?=
 =?us-ascii?Q?3N9p50YYRmlyqswwgLgcMkdW+Y1zHaHNg2SAFsdXg1D3oHYP/cehaxq/VKRp?=
 =?us-ascii?Q?k4dY8Kocp9I3Zkhk5oM514v6Z38vZbhmMseSg/fqB4LpInM2zIthELq9dMFl?=
 =?us-ascii?Q?GqUXxbqN5+UOTNE6iDnIkBGP6q3BSiBznbK9u/BWozXD2DluG8Cam6Zs7mbN?=
 =?us-ascii?Q?OV4KYZ5VZ71sio3QNLBKb7LxlqdQMHuVuT+OB7LH9H6dOjTCplis0ah9oKQZ?=
 =?us-ascii?Q?oUFXO/yCmV+oR+raGPx/eVgICr2A+oGpx08kokEC+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6Uos6CtgYcSld3dzgDI1z2j599smNAh23MBH3L5Cm73Srja9Fe2DzoBPSBY?=
 =?us-ascii?Q?n6PYkw7FOFKIyBHjBBOhzoTa4wxRG3del33eOwo9telGvF6xFcIH2viznyjS?=
 =?us-ascii?Q?Rtl/z6h4b1HbvzTAUhBsryzPAMfCOJjAHv51WewLWGQU3G8CGdnjFKex1Q0p?=
 =?us-ascii?Q?kuM10pnY3brGDBdDB7geP9GusHwO9DZJT6KNyRFNfNffM4hM68DWOnBbYjvy?=
 =?us-ascii?Q?gyA7c0mBq6rO95XZZNaFU9klajgbU98hjaSMQTVgihdRNsfckOhl7dzCEjwE?=
 =?us-ascii?Q?urazlhRLsgC3pYZoxjrOWMTE+wQPJX7e/ajsZCg1XID26uWVmGd4TaTRF9b/?=
 =?us-ascii?Q?ABJnPlyulQNXq4+i/jlZU8sZztMQGU1VpZP6BDjkrVqhHRGvLdBdP4/cw5Xk?=
 =?us-ascii?Q?16d0cPjS1Ye1qbBH68QWIuk1mJev78N5EvJpKIba9hWJ/Q0GOIPtNaciMo7I?=
 =?us-ascii?Q?smwvl3aYvOqRxS0j/Wuo2A1WKwM/Nsqgh23uU6Ba6XnXpLcZROERYS9QOzDs?=
 =?us-ascii?Q?etr9wHsYB+JdfXf4Gw4dUXIe1uJDOl2zk+P8VZygtYgHsHvFeKlvcxBLVICr?=
 =?us-ascii?Q?K9jn3ZERTQeMjdmCiE8fIjf/zfo47onwHsSE/kxEbplkmnY19d+9ceCOKjZb?=
 =?us-ascii?Q?GG5RFa6OgzNhLFdVrDYBTr6gZXi+t8S4kFSWo4jf0PperZBKc0OeJN14Vqbm?=
 =?us-ascii?Q?rtgZuZPYShjf8qLTgveRMvV5hDVw6gs7ybBPWg0z31aSxFVjPpLC97gxGL6V?=
 =?us-ascii?Q?O93oxsnZN0nbtsX1tuBPyE79/plFYBuJ+vWhwM8fPMrxFZyw5hJiR50RL7Ez?=
 =?us-ascii?Q?cFoJznCW04sSfp7l9py5y8DALXSXKDx/1gabuz8lZykHlRvkFWDKzJEdycHe?=
 =?us-ascii?Q?2k6puO+2fNJtmiq8F3tpYWkLE3wayRXygpGGPdpahE8X7w5V7XAztmvkAw2+?=
 =?us-ascii?Q?oZg0oRLdAYkx4G/DplJr4HHIbbdSZ1084Otk6ORDTSXxl3F2WjjH8eMPa0b4?=
 =?us-ascii?Q?TuikfoQ/zNLAkf5kKowiHpF8aWgF80M10IAnQpA7THt67kAVPhP4NL4IQ79v?=
 =?us-ascii?Q?0UI6ekNkzoNg2mFQDAhzERKHNR8TUgJnMnUiPRFaKHMrA0cG8wk/tvSCRSgH?=
 =?us-ascii?Q?FkgIPrbf9USgBMPBUp5dc+y4KxZT5KOPTsn5DbJ8mGqM4v1b0yLC2WU4HM5G?=
 =?us-ascii?Q?2LMsV6rAICWPuMalRMxo8Jjt5wO0bB8RF4TI0fKNlW0g+/4FEOgjatFnDWUU?=
 =?us-ascii?Q?QtKgGMAqGKCi+umsM+L9XCzvoXDOqKN7G3s3wIZ/I1GqFHRgHPquHri4Geqa?=
 =?us-ascii?Q?TJ2JClkZXHwaSChwR/xwcAWOsbPswf2/0aKFzbKEjEsaq7tVIuYVB3vxQrIZ?=
 =?us-ascii?Q?H8/YO5FUiLkSANki2jdR6P5Hl6/ZZeOK3Kj2pLAZR2EK0ji3rixKEinVPIiq?=
 =?us-ascii?Q?P36z3ms3/fEmKT7ocePadYDVHrDkU+6BNBF2UinRcUBGVq7EJwETlOuHUfR3?=
 =?us-ascii?Q?Qr7i5dXKHMKxpP6GXuileh03hDflWSTfjGeu8ebaauSvVq2MAgN5SHwFxjzZ?=
 =?us-ascii?Q?NYlq6zMkWmjl8qDYOZX8YrEZj5dl5r34jlx573DCqYva+JbAxY6jvd+K5Qhn?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1J0vCurLjpjNOErAZsRACH5thYc++KOfKEwZN+3abfqXpeZVomBTnMdLCXzNtyLT7j9KsNFS2gQ7UjJdmDVhJWLVmTMWVZBkHWVdvctsJV2tgopIoJcn9VCHvbsk9Xg9j1UkXh/7VbhZKqfXYkihQBr3IKNBSskMz7UxksuXhUB+9rOarCcXE2pJm0a+6aROPrIB5hWcScEOCwK3bcl4RSa8Hh0+l084ql92f3DFsbj564WQlKPsI/qwn+MmEk6ZZr/17cGyCKfKRzzKzokKZpXi174xYhjQqPnJFAOnN6iUerQoauilUNtMvixchuQ1QsdKCn3z3dBp/R5tenQGWP7WkFepD2+IHPpqBBG5PRtH6H0fvdQm5+V+R5ZRz8zu/i/98zGmxzD8T3j9+kdm1CE1b7/RDyO32+7CgLY2d0XuFKVfS70vLtT1u+i/fMWEkItPkMoTj8KHWhh2HxhvBw2F84yt6X35iUppInll0sSNPJzZ02mVdn2iccx7mrV4uAL+CrGVeiRh5LTIevBdaUzZWaWu8ISibG+NgPDnA7MIda9gZTRqPMxXamuUQi8IJZQC41WSxpBvJ36lkIM/1+VInU996HfU8L3SHavkPEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f693ca50-cb77-4bdf-61ff-08dce86759f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 13:36:17.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niRK2T6cvQoeAg9P85W+6HBFHeELZRT5Hb6hxecqK/XZoZF23jGCZnVWcPAfsK8e9pcrSh7Jek10dJVgqqoSi+Tkkq89+dUup/Jbi2bDel8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_09,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090085
X-Proofpoint-GUID: dSOX4wnTZYE3AqLHczdzj12QVC0y1SiB
X-Proofpoint-ORIG-GUID: dSOX4wnTZYE3AqLHczdzj12QVC0y1SiB

On Tue, Oct 08, 2024 at 03:36:53PM -0700, Deepak Gupta wrote:
> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> This is to make sure that any existing apps using PROT_WRITE still work.
>
> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> encodings for shadow stack. Above changes ensure that existing apps
> continue to work because underneath kernel will be picking
> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
>  arch/riscv/mm/init.c             |  2 +-
>  mm/mmap.c                        |  1 +
>  5 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
> new file mode 100644
> index 000000000000..ef9fedf32546
> --- /dev/null
> +++ b/arch/riscv/include/asm/mman.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <uapi/asm/mman.h>
> +
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +	unsigned long pkey __always_unused)
> +{
> +	unsigned long ret = 0;
> +
> +	/*
> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
> +	 * Only VM_WRITE means shadow stack.
> +	 */
> +	if (prot & PROT_WRITE)
> +		ret = (VM_READ | VM_WRITE);
> +	return ret;
> +}
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index e79f15293492..4948a1f18ae8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -177,6 +177,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>  					 _PAGE_EXEC | _PAGE_WRITE)
> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>
>  #define PAGE_COPY		PAGE_READ
>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..43a448bf254b 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/syscalls.h>
>  #include <asm/cacheflush.h>
> +#include <asm-generic/mman-common.h>
>
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  			   unsigned long prot, unsigned long flags,
> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>  		return -EINVAL;
>
> +	/*
> +	 * If PROT_WRITE is specified then extend that to PROT_READ
> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
> +	 */
> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> +		prot |= PROT_READ;
> +
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..964810aeb405 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -326,7 +326,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READ,
> -	[VM_WRITE]					= PAGE_COPY,
> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>  	[VM_EXEC]					= PAGE_EXEC,
>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..b56f1e8cbfc6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
>  #include <linux/ksm.h>
> +#include <linux/processor.h>

This seems benign enough, just wonder why you need it?

>
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
>
> --
> 2.45.0
>

