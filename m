Return-Path: <linux-fsdevel+bounces-45104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A9A71ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E944B188E7E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E124EF67;
	Wed, 26 Mar 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FqFFRoJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C31FE44D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016149; cv=fail; b=Jh15Zkq+ZNDGy2oydza2mQwKJXEY+d9+IJiw+pEr1PfPI79/ZP7u1DhcRat/CR4DtZLIBajO2vcCfY4fl1PERwVny9XPiGDcHmyNbB1fAT/KwCygMACYAVeBkAU7WvQtKG2n0GxHKBKT8UoMrMTmiItNYmcOuDFyiULWwDLJxos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016149; c=relaxed/simple;
	bh=DAaXliGNC6KUvi4fSb34vt9rwD/7kxYVlxcli4EWpVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KapMK79tXuxTOSMOYVOqK//F+Auapa2tdUzBnj0blA5CYIeIgE01PMCU0czA33wvT8RlyPFQ35Taauc9AxUVJzgbDWOji3ZST9KO0+To7SYK/0wgikz034Qe1a+J/EEoDlA5NlSOzfmjjBZg07S/Fk5Iwu4xWgQZdN34EJLLBIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FqFFRoJy; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QIKoTc017723;
	Wed, 26 Mar 2025 12:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=xdlqp8iwRZHdIsT/dfI5kYa1NueNuU+x2nec8XqpGOs=; b=FqFFRoJy4vsq
	TxNXo+6g/3zm/8l1iGHRkMHtUocUwW5j6tn+qn81sJa6qQcmlkdbp+LwWSzNSnHO
	L+t26MogvT+5sraoAb2NkpbuaPP5maWJAAwn0Ee67tXlD/4vYz0pDIHSZ5NFs50p
	gQTClE44/Y3shE3YsRCbaikEVJ3m0USOKT8/XbgIr7smRvqlNBs5arXQNcTDRqhe
	aH8mlUZk/CQHSbcVFllfYv4XQ6yBcBdzYa4OdZ2Ta9JP/5VEs9VjWc07TkJ52ep/
	WXeRXFfX9gxaZuNKIt4ahU3uIkMaJp0QT0kWVNc5NwuapDnOV6oJjRgWbaFpmJ8y
	MS0WotaNDQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45mmtvsryw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL+DDmsiPf7rA8SdcuCQVJea1Id9mIyMZHPNRr2/P2tmBIKFzdfYFdg2t243JG+4bUt6/BklUbaymMXjigrNGok1Xc7bQddrEVCUFfDgGA7CRE1tdhUE9wF9pPad6ntVUOjmY2NkToCu7ei64glVjFBvb0OffX522453eejIw9HJtsng394AyYZTEJqKLAtFxCCPfzdoOsXU8glLVhaRKPv4/PjULb7Z/2USpjx4hT6PD1G+RrOLwev8qyLGJu6C0Qvm66Fz/mP8Y7WMPc4Gv7OcqSH2iF51jIGumUGUHxxNpeVwGqid5MIHXb6qzvNw8YweWP+vJpzYYrdHvfOaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdlqp8iwRZHdIsT/dfI5kYa1NueNuU+x2nec8XqpGOs=;
 b=k4sC6dmGbuORID5L+i78IiUJeBfL/gWRU9qagJAiiUmOA7DnumnFPptuhMEs+hAltCePKOJS1IMLW4DOWE3afV9Cynz3DOQMZsQOUYPIU88TyFV/cqYpB9we3mLAQThBKAs1AWd4VyNR/8lyRdMxOI2sqHT06PUGRk3RvlkTjWyRbyFhmIwHJDjUS5tun8Px80MJz/v9EhDBr08eaoGWDHfmTA4DdeZV/mggWvCeWt1BEqRabm+vNKcSXU27QtFOzwGThYAY/Fb7bhLCb9ofUNktO08jnAdXbQZ3k/YMxONeQvNbk1U7N7PdGLlX08PvCjnPlAOuxeoB9S67Ph0exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DM6PR15MB3958.namprd15.prod.outlook.com (2603:10b6:5:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:08:42 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::32d1:f1b2:5930:7a24]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::32d1:f1b2:5930:7a24%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 19:08:42 +0000
Message-ID: <3bfe1da1-a3ab-4028-954f-3a28c3e2a85c@meta.com>
Date: Wed, 26 Mar 2025 15:08:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF Topic] Filesystem reclaim & memory
 allocation BOF
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
 <20250326155522.GB1459574@mit.edu> <Z-QpFN4sW6wNXNBP@casper.infradead.org>
 <pmj2eec6neqnd4rnxu4vdjo3jtokjv6tywhixst6yp3favurko@gmlswga5ihmb>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <pmj2eec6neqnd4rnxu4vdjo3jtokjv6tywhixst6yp3favurko@gmlswga5ihmb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:ee::10) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DM6PR15MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: c14ffefc-1089-44f9-2301-08dd6c999fe1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3B3VE5FYU9ETkZ2UUpYM0wxbm40L1RSNmNLVWUzelhCQkd0SVMrajFRQUNI?=
 =?utf-8?B?MHFtaERGZkhDUEJ1dUVwR1ByQnMzd2NFakdRWGdGamxKRDNXaEw2UWNYWU5t?=
 =?utf-8?B?UURGTjZBSGRNaDRJeHdKU3RUWW1ZQUU4dDB2Wnl2anRjOEtIYkJaS2VyOEND?=
 =?utf-8?B?QnJ6Vyt2cEQzV1JYbU9WbXJOV2t0dVJkUWFrUHdFbDh5U2x5SXJVbkxLOHNT?=
 =?utf-8?B?bVFWd0E3dTZlNUFiMzJwRyt0Mlg5T2hWalZqb01Kdkc2bHFkTXJaVFg0dWdJ?=
 =?utf-8?B?Mzk2MjVzUHV3dnN6MDc3TXoyaElwZWJKckRzVWk2YjRVdXdQR2ZvSHNmTEh0?=
 =?utf-8?B?S21yV2phRk1XeGowUFpEamFtQ1krNHFJVnc3eFBCbk1EMVVKM0laK3pzMmdK?=
 =?utf-8?B?WkNtdjB2c1QxTHI2ejd6bWxiMWg4Rm1aaXpsRmFxc0dJOTBVU0pCcEpKcm1s?=
 =?utf-8?B?VWFNSFRQM2NkNlJLaGF2SHpKVEhUejZMSEM3QlVhSXlHUExVYXpuWVVYejlw?=
 =?utf-8?B?MnlIek5DcFBjSU03czM5NDQ5bVBkUWxHK0swZ2tFV2NOZnRRamlQVGVrUVVk?=
 =?utf-8?B?UklMTXRQRlZEQ0xEUzFkWDhhNXpXWE91a2lJNnJtdytoaVpTTWJSUmRJNit5?=
 =?utf-8?B?QnpRdUIyQ2lzVytoNDRPU2k0aEZFNEEyaFFOSHJwT1R3Tmd0dEdZWGNNbTVF?=
 =?utf-8?B?bnFiaDMzMjh1N1hjWG5GY0M4NVJHZmllWlRiS2Q5R0x4QndKamhTY0l4d0gx?=
 =?utf-8?B?R3RDQTkvWTEyaTU3R2dHQ1FFbnlUY3JEUUI0Wk84dGVaeDhveHJxb3Y0OTdL?=
 =?utf-8?B?enV1QjVndkt1azBMbjhWd2NyNWdtUk9JN2I3YXlqdjBldkt0ZDhWaldjaDJz?=
 =?utf-8?B?bGFIeGJhZGxJanhlemhabmFaLzNRS2tjeDJUa0NYUVlTUnNtaTNMNDc3Q2sx?=
 =?utf-8?B?SnNnK1Vaam50WTA1ZFVVTnFsNDNVK0s4TTlLeENFLzkzd2NrSDhrUUpsSnJT?=
 =?utf-8?B?ajBuTW13cmVqYmE3RFczQ3o0ZitlWnB5Vk1LOU0zZ05OS2xmZmZpWDJwaGJn?=
 =?utf-8?B?dktDME9NYmhEQlVHWXBEQUVZN0twcSt3cS9WZCtVWTdOQlg0WEtHc29lUFVY?=
 =?utf-8?B?WHBKd0xUeStmelRkb1lNWHpkWGU0Tm1wK24yN0RmOG1BK29KcmZIMGFlbUs4?=
 =?utf-8?B?WWc5UUtkVzkrT2Nlc1lCVm1UYllLbi9lMGQzL0JEN2VzbDVlUlBDSVM4Rys2?=
 =?utf-8?B?UFhnRmc2cy91VnN6UVpSUE1SV3V4TTluZG9TUURCZ2pncXA2Rk04WnpFTFhN?=
 =?utf-8?B?WFMxNldxVmZoZWNKYXlwcy9rK2RUa3ZDc0NQVlNnU2kwSkF6bFdDdlYzNXdU?=
 =?utf-8?B?RE5XSitjZnpFNWlrdytCQnhncHZOMTNlU0ltaUNTSEgvMWJOMXRtdFRDOUhL?=
 =?utf-8?B?NUhtd2dvQUdyUHpLT3huTElNMWVQbXV5Mk1RTi9LY01YY3B4Nyt1NFNIVmFv?=
 =?utf-8?B?WWFFTTNaSHJZNmxST3NWZGtLY0NYaWRkT0hnZk0zYWFqclFHcUp2WDBmSXlv?=
 =?utf-8?B?U1JJa1g0bEFvaUhLeWxOaEEzZWpBd1ErZk9QcWJiU2xuT0o0MEVHOFM4RFYy?=
 =?utf-8?B?UVRBWlRQUExrbi9jL0tvdHBBSVZXWEZGblJER0VXaklYeWc2aEkxTzAxNTlz?=
 =?utf-8?B?dHRGNnBJeUIwVXpmSnh0aDhGTVZaT2RPZ3pYN0IxVzVlWnZ1Q2pIYjlSZnlR?=
 =?utf-8?B?ZGlKREZ0R0ZYN2RuRjZjTFRNZEJ2cUlNc0F4NWtlNGpRSGZ3UGYvRjNQSWhX?=
 =?utf-8?B?Z3JGaFlHL1BLRzA0ajJJK2QyczJHZGU5L2xuMDcza0hpbUFzKzRMY0d1d1c5?=
 =?utf-8?B?bE9CS051MFV4SjFxdEg1ZTRXVFRGRE1BbUx2NUNEa3RiUkNzaUR3WHQ5TjVQ?=
 =?utf-8?Q?5ipCzQqp9yQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0VhMmNwNWptREtQMmk4MmVOS3NJRUFTN05kcGM1bk1VMXVCZUI1ZWFGRVdN?=
 =?utf-8?B?RnhNZXNmUW1DVUhkaHNMR1EraDlWT0VMMEMrY0h2bUhFT3U2aFUvTUl3L3FP?=
 =?utf-8?B?OWk5NStkbmdaa2psTjRLTk9weXNEUkJsdmRPUzFScFhwejV2Vy9OWmx4U2VN?=
 =?utf-8?B?WElqZEcvWkh6SEVMS3BDcHNsYXRkU1BUdWZhaDRrQUVyYWN1dkFuTU9jMmtU?=
 =?utf-8?B?ckFDZk9HRGNNT2FFN3JBdHEyaXRtRGZtY3lJWXhneU1TME1xR3VJdXJmc3Zl?=
 =?utf-8?B?Z0dQb0tNNXh1NHRoQnhick5GODNUVEw1M05HVEFoazB2a3N2dUVVTlRhdDd1?=
 =?utf-8?B?UUZKSDJmcjIydy9UVGt3SEs5QkQ2dm9WTGVxcTlkSm5jQ3JqNFpDaDlKNFJZ?=
 =?utf-8?B?U3ZnK0ljak9BQjNvSEpZdytJbGlsenpOeE9YQ2hhL3Jmem1ydEMralBvSlIv?=
 =?utf-8?B?eFhuUG5DaTFYa2VtTENYTGE1VWVVOXhaaE9VaFNHNzdYYXRJanJ3Q1I4MTVW?=
 =?utf-8?B?d01hQ2k3UU50bElFUzYyRUZCZlkxL0ptMy9OcE1RSTNHTnpmMlRBMWRkZ2xV?=
 =?utf-8?B?TXRQTFlZaFNXRVVuV2FZUUlCRHJUakVBcENESWhWbS8waTBPL0pmYXZ3cWk3?=
 =?utf-8?B?RERZVTlvMit1OXZCTFdqVlVaMlRzNUpXRndUbSt6MVpjVWU4MU4yOWNkUXJQ?=
 =?utf-8?B?UUIwMFloOEtXRnZTeTBDR0J2VUwzTVo0NjNHUlB0WHJKN0JwV25DZWxpQkxN?=
 =?utf-8?B?WHkzMndXTWNqT3JNOFJkM0ZjVk9RVzcrc0MvRDFpckZuQURaV1E2RldiN1Bh?=
 =?utf-8?B?aTlieFZnQllRWWxIbEJuc3kwUnZ0QjBRYjUwR3F1VXZ3L3h5WFR0aU5vQlQy?=
 =?utf-8?B?bXdFM01tQVJaVitiTUdwMC9kdHAxaXZwMkt3SGNjMnhvMUYwN05mUkhMK3JS?=
 =?utf-8?B?NVRKNnk2dHlTRkRrWiszQXQwZkpLa01XQjlpaHNRMk1iWFZMcEhIN1hhMUJz?=
 =?utf-8?B?YTFlbHpUL0FQU2pQUlhmb2JLdHRLUXNmWlAxWjFjNnhZRVQzR1JQeVdPN0NI?=
 =?utf-8?B?WlpXdmdzL2hnS2dqOFkrbzZpVUkrdU5RMUQ1VURQdE5jeFNJUXNRaGV5VDNx?=
 =?utf-8?B?REd4eHJzeTRkY2JJajRuQ2JCOWt5RVpSK1RtdDlXYitCdVJrSzQvS3VEdDB6?=
 =?utf-8?B?TENid1dCMHBYZUx5MURJcHZyRGN3ZzdScFJiTnhzaFpIZW1rc3BZKzdxK0xO?=
 =?utf-8?B?QU1VQ1FzdHgvNXc2SUdVcGpxUFVZUTd1K002cFNwMlA1R3lBM01udzI2S0VJ?=
 =?utf-8?B?Qnh1QS93UDhVeXF2aEFtbUFMZUMvVTFHZXF6TmNWalFrRVBLcVBRalh4R1dw?=
 =?utf-8?B?SFRYNTErTXNiUTVRajgranl1Q1JqVEZoRUF0ZmxOVXROZFFMa2dYeWhTVFVC?=
 =?utf-8?B?QytBSVNRZ093eUVxOTBZc1RPd0YzdFBqcEJERHV5NmliajBGOG1TeUczWlly?=
 =?utf-8?B?bzA2VGhJc3h3cXo0OG4xSkZwZTdRdXVxN3QxQ2J0ZGR0ZmJqNmRYZXRqamdJ?=
 =?utf-8?B?M29uVEFiWUkrVHhKamM4T3cwUGlHbTh3aXRjRW0wSndidmtGT0hZMktBZmNn?=
 =?utf-8?B?RkdGZTk2MVpxL3ByVGdkM2tldkt0MERMdmhKeE5RSVR0S0cyQ1drdExqU2s2?=
 =?utf-8?B?c1V6dVdtV3ZHZGo2U0FxajZxVnFOb1hGYmlkSmRaVjRONVRqZjhXT3g4SGpV?=
 =?utf-8?B?YUVsczEydGQ0QjBNUEFaUFRoLzdzbmRFY010SkZvcjRMUGRrYnlSdmt4SlRs?=
 =?utf-8?B?ZFpMbzJRa3NyTmtIaTBXZzdySlFqdUQ0QVd2dVZlNWdENUcwK1VEMzhZK05r?=
 =?utf-8?B?MVdOa2hDeS8rend1eXBHeVZGMld6SEhmeGhEVDBFd2haZytNQTdtTXp1YWNM?=
 =?utf-8?B?eVB0dWpadVNHMUpRRXpYOEh1enJmMHR5aVRhRWVSYkVYTXUra3djNkpvcjAy?=
 =?utf-8?B?dVB2Q0Y5b0dhamJVRDJTb1RxdmNUa3hwaHBta2d1ZThBUWgyTjJCSERxV3Fu?=
 =?utf-8?B?eEErQU84QjgrRFBpWkc3QUhjcmIrSXR5YVZTcVN2ZGduYjZBSTVuSFZlK2R6?=
 =?utf-8?Q?tqFE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ffefc-1089-44f9-2301-08dd6c999fe1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:08:42.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVmgU40RBSWpNWbT/rX0K8NQEwIlNoSPnUtYtIGWlp74nknGVaX64FI/VH0msQaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3958
X-Proofpoint-GUID: y7J-2arqAxsQ90nh9z_nCTLgArw_Apcr
X-Proofpoint-ORIG-GUID: y7J-2arqAxsQ90nh9z_nCTLgArw_Apcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01

On 3/26/25 1:47 PM, Jan Kara wrote:
> On Wed 26-03-25 16:19:32, Matthew Wilcox wrote:
>> On Wed, Mar 26, 2025 at 11:55:22AM -0400, Theodore Ts'o wrote:
>>> On Wed, Mar 26, 2025 at 03:25:07PM +0000, Matthew Wilcox wrote:
>>>>
>>>> We've got three reports now (two are syzkaller kiddie stuff, but one's a
>>>> real workload) of a warning in the page allocator from filesystems
>>>> doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
>>>> context.  This got me thinking about bs>PS and I realised that if we fix
>>>> this, then we're going to end up trying to do high order GFP_NOFAIL allocations
>>>> in the memory reclaim path, and that is really no bueno.
>>>>
>>>> https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/ 
>>>>
>>>> I'll prepare a better explainer of the problem in advance of this.
>>>
>>> Thanks for proposing this as a last-minute LSF/MM topic!
>>>
>>> I was looking at this myself, and was going to reply to the mail
>>> thread above, but I'll do it here.
>>>
>>> >From my perspective, the problem is that as part of memory reclaim,
>>> there is an attempt to shrink the inode cache, and there are cases
>>> where an inode's refcount was elevated (for example, because it was
>>> referenced by a dentry), and when the dentry gets flushed, now the
>>> inode can get evicted.  But if the inode is one that has been deleted,
>>> then at eviction time the file system will try to release the blocks
>>> associated with the deleted-file.  This operation will require memory
>>> allocation, potential I/O, and perhaps waiting for a journal
>>> transaction to complete.
>>>
>>> So basically, there are a class of inodes where if we are in reclaim,
>>> we should probably skip trying to evict them because there are very
>>> likely other inodes that will be more likely to result in memory
>>> getting released expeditiously.  And if we take a look at
>>> inode_lru_isolate(), there's logic there already about when inodes
>>> should skipped getting evicted.  It's probably just a matter of adding
>>> some additional coditions there.
>>
>> This is a helpful way of looking at the problem.  I was looking at the
>> problem further down where we've already entered evict_inode().  At that
>> point we can't fail.  My proposal was going to be that the filesystem pin
>> the metadata that it would need to modify in order to evict the inode.
>> But avoiding entering evict_inode() is even better.
>>
>> However, I can't see how inode_lru_isolate() can know whether (looking
>> at the three reports):
>>
>>  - the ext4 inode table has been reclaimed and ext4 would need to
>>    allocate memory in order to reload the table from disc in order to
>>    evict this inode
>>  - the ext4 block bitmap has been reclaimed and ext4 would need to
>>    allocate memory in order to reload the bitmap from disc to
>>    discard the preallocation
>>  - the fat cluster information has been reclaimed and fat would
>>    need to allocate memory in order to reload the cluster from
>>    disc to update the cluster information
> 
> Well, I think Ted was speaking about a more "big hammer" approach like
> adding:
> 
> 	if (current->flags & PF_MEMALLOC && !inode->i_nlink) {
> 		spin_unlock(&inode->i_lock);
> 		return LRU_SKIP;
> 	}
> 
> to inode_lru_isolate(). The problem isn't with inode_lru_isolate() here as
> far as I'm reading the stacktrace. We are scanning *dentry* LRU list,
> killing the dentry which is dropping the last reference to the inode and
> iput() then ends up doing all the deletion work. So we would have to avoid
> dropping dentry from the LRU if dentry->d_inode->i_nlink == 0 and that
> frankly seems a bit silly to me.
> 
>> So maybe it makes sense for ->evict_inode() to change from void to
>> being able to return an errno, and then change the filesystems to not
>> set GFP_NOFAIL, and instead just decline to evict the inode.
> 
> So this would help somewhat but inode deletion is a *heavy* operation (you
> can be freeing gigabytes of blocks) so you may end up doing a lot of
> metadata IO through the journal and deep in the bowels of the filesystem we
> are doing GFP_NOFAIL allocations anyway because there's just no sane way to
> unroll what we've started. So I'm afraid that ->evict() doing GFP_NOFAIL
> allocation for inodes with inode->i_nlink == 0 is a fact of life that is very
> hard to change.

From a memory reclaim point of view, I think we'll get more traction
from explicitly separating the page reclaim part of i_nlink==0 from
reclaiming disk space.  In extreme cases we could kick disk space
reclaim off to other threads, but I'd prioritize reclaiming the pages.

(also, sorry but I'll miss the bof session today)

Related XFS thread:
https://lore.kernel.org/linux-xfs/20190801021752.4986-1-david@fromorbit.com/

-chris


