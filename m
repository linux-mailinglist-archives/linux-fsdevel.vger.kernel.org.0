Return-Path: <linux-fsdevel+bounces-67956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D87C4E7F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45B274F9E2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96C2FB99D;
	Tue, 11 Nov 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EsHN3WED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C506A55;
	Tue, 11 Nov 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871220; cv=fail; b=uamFVW27s+ZJKD0oJiziXadKdJp8YKVa9o4Ii1Y8Yomog44oiM27sDNvF6Abtxa2WNqR/jZFXXcG9Sks/MpyZW4Mg4fRbE1pxUwaTj1iO+yxeSNS2h88tC3cd3wbkDsQ/icJ8okMr25K4g8IZZDlsw8fldsHNP0vXO1ljA294Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871220; c=relaxed/simple;
	bh=HVsSv0IOXVzJitdha9rqe6pkZF6jmIOXECF2q+9JhPY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CeC8iC3T18AKkgg4DcsmeqoVrgkmlOvAm0MeMebcvbaoiXzB0Cao886wDVOiJtry6bpsjvn9dsYDn2QcMI2lvQiIFrjK3ihbCk0fHLQgirgT9p1OeZGPopti7GKwbWzwAbsXmCDxchqSTOlGdHSdlBIU6+q0T1BjjneC3HWR6d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EsHN3WED; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABA1jem1733035;
	Tue, 11 Nov 2025 06:26:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=boOrOMDu57I4+kY1ClrRWSh8CW35791TYbCJNKdR1p0=; b=EsHN3WEDxJfA
	ILSuKBqsNKlOdxzJb8t4ZlCPr2uAwnSM19IIyAk87i0Tdn259UUd8DflBi43ezgq
	3yR8E9jZQbPe5w/zkBE07MsPjKUXvWJGtolkP1fxfZv0sZq9edWzYk2hxqiQc6/N
	CeILhujks+5DPFjVFCoFH/bm0i8yR9pZP4ZWAG/hfsTFT80hhvU511sUwADm+LgZ
	Q/TksNt+VjEfVV3ipfVMJPYXm/U9ng25xc/8aFIGPbhjdZYCCOK2iJhDz2WzOROE
	MXy/BUSbnXX10wGTrDo5B7mMtqCFHpRUvBoxBJUpZ/4T+tZzI4tHOoU/EIwY1e1W
	/wgFQJHLQQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac31c1gdq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odfNO7aSLtUu/Kle1pUV10wE1KA60VuSn0uzLd1ZPhbxYYHkj0CiChdWaNKumNQoZqbTsi41S1Lr7seVQcQPpLWGTXHqO/T+OHc0VasNEfzsaHrvXWIIAGt3nZqDaMicBNvXlfHgQtiU4mYwygbM6y6sebr0Fyls+XPZzJZwmwCaaU1/BQ9JZwva/GMvdRNrV7YOVy/ugbVgMdMfqh6zKrbalAx2jam+KHQ4kxDqOoUX/Jo5w4Lt0abvlQ2y+343G8VU27aJ7CN2u+dx70Frvqm3A2iGJ+pctuI4GwhK4VNZHw1UVVYEoYY39EKTuQudCF73uQj14WLk6t76nqEMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boOrOMDu57I4+kY1ClrRWSh8CW35791TYbCJNKdR1p0=;
 b=Wf32on9mxinYoMsw8VEsETCA2mVTMXHdsEOz4KSjV7BsBj2gT1Jb3lKBeJKZmWhLH3ngl7j+Mfkw3BYIDLTW4toPUz6hzV6TC0vJI7Hh++8p/nB+UIZX+k2XctlOnnRthfGXIrrKGseTMDLF6QDQka2pGFyOUWcSbF+hj3fWM4/MkdADwzjOthwM+CF6aiF1TJrVbH77oIoY1OhT1QW0LImQpiLlya0U/rhF/1ALSkkftuDNF+3N2k+v16J1k4Kpw+kiIN2fUBdJ3DrHLZXX4Kt16ti7uuN6xGhfE5ei1YeqiTI5NW/4jI3JMeIFupUBfZT3b8QDOCeNpncjluP5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3851.namprd15.prod.outlook.com (2603:10b6:303:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:25:58 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Tue, 11 Nov 2025
 14:25:57 +0000
Message-ID: <e8e46c2c-b207-4074-9186-b1d395fe2438@meta.com>
Date: Tue, 11 Nov 2025 09:25:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net,
        miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
        linux-mm@kvack.org, linux-efi@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <20251111-verelendung-unpolitisch-1bdcd153611e@brauner>
 <20251111100115.GU2441659@ZenIV>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251111100115.GU2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8086c4-238c-4783-bb67-08de212e3b0e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmhmVkptcjdPckpxRlJFRlhLamFMMDJYcG5XVXlsVGorVkVZelBldGVnRmhD?=
 =?utf-8?B?RjlYOTlWVzU0N3RmUWJMemhZV3F1WkhRaU9YeWNVanRvZjNvMWF3WFViaHlh?=
 =?utf-8?B?OEs2OS80MzFORTRYVmdVTTI2dFV4NjNtRllJSXY4Y0ZyMU5WbUZZbEI0aTVn?=
 =?utf-8?B?dVFHZEdHSFZlUDJKRnF0YTZhcDZKbWkzOWdHRW1makNkMkJDN09IS0xiLzdI?=
 =?utf-8?B?OVRuc3FMaWJCZ1ErUGJTVEVFejVDdG1oV1doS1BrR1NMRi9YaEprOXZXQkpB?=
 =?utf-8?B?dUJuSCs0UzkremhTeFFCQlY0TzBWZ084eU5uV1A1WnVNVEI2TGRXUTZSOE9P?=
 =?utf-8?B?K3JRMEdPc3RCS3ZwRkpOOUE3SmVCNHNmNGRoNmZlbjJlQkdTVzdKOGRJUTZ6?=
 =?utf-8?B?RlE1S2JOazd0akMzMFY3VklGR3EzeDlnUnhvN1FJNENLUCtnUlBkR0t4Ty9G?=
 =?utf-8?B?bFNheWpsU0J1SUJzczdkdFRRRWNudzRkVWRxZ1BQamZLVzgwNWlBUmtDMG43?=
 =?utf-8?B?dEJONmdhSWVld3ZmV0hOZlhLbEhSTEJYYXhWejR1MytJRERrL2VPOXlHZ3BB?=
 =?utf-8?B?dXJscUxOUnAzcmpmNnBvWEdpMjJlMVN3VE5ZQ3BxZkVkaGcvbDY3STUwa0lT?=
 =?utf-8?B?bURvZVgzZTlDNm9LWTRaVXVzZ0hkbUY1b1d4d3RNRkZHSExFQlhuQkF1a1VM?=
 =?utf-8?B?SjVsOWNKV0hwNDArVTFhKzdpVHNTcUIrdURZL0pYRWoycWZWemtVZGY5WDEz?=
 =?utf-8?B?WWFGQ2V0QkZvR0VSKzJoTWF4SGdGbWJubG53SmxkSmVqZVpyTjdlUTVzcm4w?=
 =?utf-8?B?dDFRRlU5b3QyUmh4NDR2RnJtQXlDdTBTR3VmMjdNcU9Nc0M0MW8wcnFUZUJZ?=
 =?utf-8?B?YzVwK3kyWU1mOGFhZmVNVDF5UjJqY3FKUjFkN25oRDRQMzkybjdyODlWZDU1?=
 =?utf-8?B?UW9zVE1rcUV3d3UvV1JTQWNQK2tTcExHNnkwVlVDaUQxQXpZMmFRL0JncXpE?=
 =?utf-8?B?YzIwSFo4dlUwWU5tcGt4SGZEWGt3c21YYlN2Y3VlbFcrZGZzVVAyYWRzSHly?=
 =?utf-8?B?WFRUV2d3M0sza0lDNjZIV1VGY3VKbFZJZjRycFpoQ3N2RUN1dnlhUFdDSHN6?=
 =?utf-8?B?TGppUDRHdXZuNGVPdEtmaGk1YWkwdjZUOWpkSFN3MHgzNEpmOSsrcXFhWDl1?=
 =?utf-8?B?Z2FGNWpqaGRFVVNyOGQ1cXBPb3Z6S280VXMydGx1RHJJaEI3MjhWcFdsS1dK?=
 =?utf-8?B?Z3p3K3FjYUhsd2NxQm82WG1KVXcrMzFmaFZBcWdTVk9kQkt0em5OOGlDTmdr?=
 =?utf-8?B?T1ZPMklVUElRN2FWcDZZQzVpR3FIUDg5dm9Ed05Ha3NSVVM4M1RudTN2V2NX?=
 =?utf-8?B?RDlPYTlRRzFJME8rSlZFd0NWc3NQT291eHE1b011SUc2V25heElnV2lvQkQw?=
 =?utf-8?B?Y2x0bzNJVjYvZkRVakJmQXFhc2RRWXNUSFRwSFQxRTA0SGs0eXlaemlpUXYv?=
 =?utf-8?B?YnFXQlBza21oL0RNVGJiUlBLRCtpQm9oNjV3c3VxclpZM25xM05nMUlVQUtH?=
 =?utf-8?B?MnR6TXJhWXhZNGMwWnRCc0ZYeWFFMlljQkhUWUZOY09DL0RpYzhEREM2UExF?=
 =?utf-8?B?czk3WmZUUDJmV0s4UXlsTWpOUElpZ3NVRmR6Rmk3VXBwNXNBTmtmUW9VN0Uy?=
 =?utf-8?B?ZXBmWEhEK2Zuc3JTbW1TcGd4c1UvTWhiSi8rd2I1bGlqWnIyRFF1M3RaeEl0?=
 =?utf-8?B?d1ZqeG9wMTh0bDREV2pMam1ScHFkK00zbitQbStETElJd2h0RDJoWTVFdXVD?=
 =?utf-8?B?VDlVS25walh5MHBUakRqd05SamxSbVowMHlyaG1Ja2lNQjNvMVV2aUZlWEtU?=
 =?utf-8?B?QVZ5dW9XWlI3dDNueFBsSkkzNnI2bWdhR1l4ZUxzWkdDTERjWEtxTkhBSGFB?=
 =?utf-8?Q?qe/Hh3fPdic+YTrkpbwK8XoyrtP513f6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDM3NGNHNDNlMjhVNEhSWlhzM0huM0Y5dzNFSXpkR09qSW1aV0JkRWcweVJN?=
 =?utf-8?B?dVVyQmpxbWlUSkFEWWhXeFg5WHltRUx1YzZoZkk4R0ltcCtia0JGK1VNcDM2?=
 =?utf-8?B?bHE4UEhpKzNnQThobS9Oa3R0Q2x3ZWZsNzhPZ1Ird2FVY1lUVnQ1QnJlRFov?=
 =?utf-8?B?N0RneWlxdVJUU2I3WEV5ekRXTFd3UUZlSzBHV1lnL3UwTHE5QVNOZDM1ajMv?=
 =?utf-8?B?RVc1eGRRUWlTK01IMnFLOHpOb1NQcGJVM2xHQktsbVZPYmJCNlZ2OUwzdlYr?=
 =?utf-8?B?cmZJM1htNjVNNnRXVHVucUhvVE11c2tpeGFCWlBVd0huNXdITWt5c3N4MmZm?=
 =?utf-8?B?ZFhNUVptNnpmZzZTdGovR0NUc0ttOWZsQmpKb0NJK2p3YzgxUUVVZjhZTTdv?=
 =?utf-8?B?WlFKZFBNRGpsMFh3ZHlsenRiNVFtcXlrWk1RdGFDSkVTdGRYeDFKQjZOeWVu?=
 =?utf-8?B?TXJSOWJKZUcvNmlCVGxZWTJkaUxzL0M1TDUwZ2xZMG9UM1FFaG55UHRtb2d2?=
 =?utf-8?B?OGZwMi9JNXMxTWZndDgyL1JwVEF5elc5d2M0N1dZTk5GZGJDOUVUR0o4Q0dD?=
 =?utf-8?B?T3l6SkJ4SVIxc0FkNjNDZS94NVh2elFObFpkRVBTUFNHNXJjVUpOQkwxdm00?=
 =?utf-8?B?R3hMcFJyZTZnc3NjUVZlOGl0c0dRMXBYV1VtMlJ6R1VaaWhPNEJkU1g0ejJh?=
 =?utf-8?B?M3JyL2VDUzVaVWxHZGJWOFNubk95b3VqOVR2NGhRbE5sZmkzNXZHNmk2SG1X?=
 =?utf-8?B?a2hPTm1Ja0RCZ2lVaTAxVHloaklSaDZoMVpMZjdacDdkYWxiNkxZb1BmZ3dn?=
 =?utf-8?B?NHNmL240Q2tFZUxJbmY4UDF0SWh2TEdqNHp5OElhL3N4akVMVE1kU2FFdzlL?=
 =?utf-8?B?NVNIQnVYNWk5TnRrZm1rTVpRcWtKM2JNU3p4UkI4OHVOcTlaMmxibE9ZTXhm?=
 =?utf-8?B?MHI5b3RpVHlWSW42d005VzJ0dW1vZW5UcFlZdDFFUUY3TDgvVDQvb3lYcnl5?=
 =?utf-8?B?SnVtYWp0MGMzUnNTL1pHRUlvVkhkTzhjSWF5QmVnTE5XR0R2TytZWmlKdy9L?=
 =?utf-8?B?QkJKUWJPamYyYkNaYlZyai9LcTNqMnEweVRhbEF5bmVBRFZselZMeVUvK1N6?=
 =?utf-8?B?RU8wc3dOWnkwVmlGT1llbFVwbmNDeHdjTisrWEF4U3NPbDdwckpYRE5OdGZl?=
 =?utf-8?B?bmh5RjJYWGFpK0wzYStaY1IzQTNyRmdIUkZYSGd5Z0p5VDFmOGYyd3dhZWZR?=
 =?utf-8?B?a24veDFUTEN2NWJtKzRIbUgwVllqSHZBTk9wQ0ExWEx6UHA3bk56SnNjQXZC?=
 =?utf-8?B?RjhuWXZDYnBXSTRDUGVyaWtZOWlMcWQ2Mm9VSjFYYW9Ja2ducktZeWg3TjBs?=
 =?utf-8?B?YklieEMxNDZNZUkwTHlZVDBkZDh6ZUwzR293QUdSUzlLdU1Hc1BFZjAyUUJO?=
 =?utf-8?B?S01OQVE5TUFnOFBIeWxZQy9XSDhwWnBJZi9lSlIwN2R1YS8zaTdvZDhVYU5j?=
 =?utf-8?B?QU1ZV1Ntcm0vb3R3eVJEQVJpT014bm9yOGpzVTFaOXExZVc5NHNvOHRCdFVX?=
 =?utf-8?B?M2Q4cG8zVGpqaWFkRDZBQ1JqSHA3cno3NmFBbkN4Y2loOFBkbTJTWjlTRzdt?=
 =?utf-8?B?L0NqNE5nS0x1Qi9UTTBtOHRPL0JHU2lyeHZzNjVTQXlUQnd5YzdIdmcrYXM3?=
 =?utf-8?B?KzMrRC9qNGVLYW1STXlHYjdiSmpsbEhWQ1phTjF2QXRKY2E0WUdkeDhKL2VD?=
 =?utf-8?B?cTVtc3A4Z3FRTnhnazUyK0g0ckFRUVN5Zzc4eDNQWG5YdFJHY3J5OEVpRXBF?=
 =?utf-8?B?V0QwMUJha2x4dE5wblhud0ZTZHp4WDQ5V2ZJZEpCQkdZYUlUalV4a3B2cWN1?=
 =?utf-8?B?K0ZtWCtoNENrZkl1SHhHSmpwVzN4VW5HdGRKWUR2c2Z4cGtsNUtJNjY5ZkQw?=
 =?utf-8?B?MGRGQUFpR0t5Z0JXcTF1Q3hqWG1EeGlUZkJPTWF1NVpxbnlscjE0OHRyZDdS?=
 =?utf-8?B?M1ByVlFwMC9JVEg2NEl4ZEs4NFl4emF2alcxaWJXemVXK3Z5MWtrUGVZOTRu?=
 =?utf-8?B?eFYrUXBpRHdWTnFpanVLbm43Unl2aXJHSGhqU1pxVkNEb2pLNW1ZS29qTXQr?=
 =?utf-8?B?cDF1YUdHRWp3WjllaERsSjI0UHBqZnlTNVZqTXh3WFlzdWM2UlE4eDJHU1hT?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8086c4-238c-4783-bb67-08de212e3b0e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:25:57.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ur6nK8SJJI9DgFWkAi5RfG6J0dd9tdJ5tfJK7Uw5v40rVWYskbTWlQj/Xq3oQBr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3851
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExNiBTYWx0ZWRfXx6R1u7j431OF
 +i/EeviSpCSz/JneGVdBccl1w/bOlXhdn5bbfwr9VLXhTxuD4zXy6n0gIbGL91Stb8l8uQ/Z50d
 nCBf6YLJU3r3qv6di4Dhor+dE+rsTf9jJKeSjmR4JjSVqoCh9v6+nSCV/npg0fE3zN4KGvNP2u3
 UUDyVsMoOJYI5XKgXbT1VOmP/hOr5OgtxvwjZJmuFTcLe8X5760yX6eyiE5NXHDC6406s4OS2Ci
 6oQ8gL/XTGPs0104XyD7sZU0uUWmrPFljy0bKY4whqaL3g3LHdkR4uQFJu4P8x3xGljNa5B8yvn
 Li6FIDqxQzpgIFyVFRQp+Fxovo67KWMsBV6sfTedpDt+omC7CvcTwImAzDGbdha+Z9cGB7OjxZi
 wNiAnnVrpE7MDO2piVMfWVYydhJNkA==
X-Proofpoint-ORIG-GUID: Mum_HfmTDKPMH7kI7VvEW91TsKLxbQ6N
X-Authority-Analysis: v=2.4 cv=frLRpV4f c=1 sm=1 tr=0 ts=6913477a cx=c_pps
 a=eOcJweQzB5mT18+DdV5GwQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DHR8f4Ps571lumA2_d0A:9 a=QEXdDO2ut3YA:10
 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-GUID: Mum_HfmTDKPMH7kI7VvEW91TsKLxbQ6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

On 11/11/25 5:01 AM, Al Viro wrote:
> On Tue, Nov 11, 2025 at 10:30:22AM +0100, Christian Brauner wrote:
> 
>>> Incorrect.  The loop in question is
>>
>> Are you aware that you're replying to a bot-generated email?
> 
> I am.  I couldn't care less about the bot, but there are intelligent
> readers and the loop _is_ unidiomatic enough to trigger a WTF
> reaction in those as well.  Sure, they can figure it out on their
> own, but...

Also, I try to fix every false positive, and explanations like this
always make it easier.

-chrisA


