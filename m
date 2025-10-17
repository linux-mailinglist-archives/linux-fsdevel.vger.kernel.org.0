Return-Path: <linux-fsdevel+bounces-64498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90949BE8F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34084405773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D692350D6D;
	Fri, 17 Oct 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sxkTAfo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9392F693D;
	Fri, 17 Oct 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708243; cv=fail; b=jPymFuY/c8wtQv86v88ZeLO7HcgW2FBsoIKT9l6Z1Ode5LXrK+mnBcwPWiiWDJaHFCx0bhTq9X2IkNbb8s5KxMh8BbsJVD9sNHDGtKboumUbh1pru2BLtnxhjg/Uhyd/0NBN0QtDspLJrbTIuDFTBUQJl0v8iqXFLYinTBF6hSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708243; c=relaxed/simple;
	bh=h8LEGlhdDDDXpkU//qvmfp86WauihlMtNrQg4HTvcxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UDz9cbroU20m19i0phvWtooAnqkEhDK8QbnIQc4Eg74PaL2Srdr+49YkE6ACNul5vdMQsdlnS0QSXB++bQatiWkE68ARZpAIQSXUzQOwT35hjWGxO/tw6BHK/Km4C0Z/i7/pvJHtJ0eZOjzLG16yBJZsrk4a5yquvYfTSS55vEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sxkTAfo+; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkQ3Mx/kDdedd1L+FcwagJP0nfh6U1Qtk4PYvEdZNqV7ZX0E3Nf7KCZ5bY3BqDx7B8XNR8HCPZ7ZeZlKzcVEl1W+TfN3/FUBnSDkX+HWA2eP99VwlVzoxLTawuiboxOwR5AZenNDpKUtj5+nPG0rSsDSESLswvf2oyY29C6yZ1sh1QmA6vQhO27sDyB7q07AQXXEDQFYbXLg7eL0p796hAmeGK9Y8jhxaeBndSjovTyIFYv7cYBns4aSnQ5WeUzSQGSwx/VOvmrO/h6WHVxV/JLzvuI15pkLR8k4OIIIvNn1X7vyx0gdnmWHjqzda/B9axxeWLfZgrcWI/020kQVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XuC4DMjljqzjiUOdzBpjppA2nysGfqfpd0GsJmLJmI=;
 b=LJ9Qr8t+t1IfjEWbAMaIgf73hAvzQMRkjYQV2uCPfw3M7+eLroxvpu21oXMycgwY2eCFSmGrWc/gGojOX5ne2xS0/K1vuYVxNunrYT5Fk5+dfMZsO/DK6sCI0IsH9yJYxvoTo4Mw3DjmG2tvBcvQqvR7qhcQ0nc03Xum1Ouq23Kmw2CSXv3D6LOfd194cQ6RiykHnhkhBPkzJM3thHXYS33lQ6ccOkySI41RZe49x7lx7OMc5V6ltiyhnNXLsAV2lATC+1r2IEgeFHDb8oZDHvAqGKAB2j8tLhIdVD95roviB9+EL3uqGnTnA9m6PzUK+cxu7osPs6PzOICXpWv0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XuC4DMjljqzjiUOdzBpjppA2nysGfqfpd0GsJmLJmI=;
 b=sxkTAfo+RwhkujYNCkeBp/7hYCtSJhXc0R//hoqVKi082FNPiRcvSatJubXIDe9i//zh04naa9WFaFR86QFvKthiBQ8Vm4+Qk09LVgt8Tn3PEqr8iVt6VnDa+tc3kT+Rb1obUGnu7RAdc455LwZ36iY/e5qY9oOUscM30YMdgzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) by
 BN9PR03MB6188.namprd03.prod.outlook.com (2603:10b6:408:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:37:18 +0000
Received: from DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9]) by DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:37:18 +0000
Message-ID: <41d62605-0d17-4504-8dae-8e9d126eb58b@citrix.com>
Date: Fri, 17 Oct 2025 14:37:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 11/12] x86/futex: Convert to scoped masked user access
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.506939239@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper@citrix.com>
In-Reply-To: <20251017093030.506939239@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0656.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::12) To DM4PR03MB7015.namprd03.prod.outlook.com
 (2603:10b6:8:42::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB7015:EE_|BN9PR03MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f05f3db-2cef-4ec4-6132-08de0d824a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2tmZkRKZDZQVXcvNkRYN1BVYjc5SjhIUUovK2lQdGpIVFF0ZFU5SmUxNE41?=
 =?utf-8?B?T2IvUStkeWlSbmRTd3J5c3pvSlRJdHhhVGd3M29HMWpnOFhRYXdUbjhXU3JV?=
 =?utf-8?B?NUpzT2N0Mnd6Njk2UWxBY1R5YlZqa04wcElWeW9WZXpSN0tsVlpWNGM5N0Uy?=
 =?utf-8?B?NE0wZHVXblRVU3NrWHJtWXo4MGVOR05maHRSSWpPVU1jNmN5aUg5aGRiNjZQ?=
 =?utf-8?B?cVRzYjVmckQvY2psalpQRGwwaEpTbjVIdHB4V09PRFpMb3ErTmVoM3kxVWE1?=
 =?utf-8?B?U3RhR3I5bXEzTDU5cEI2QTRKcnVuQ1hWb1JGMHdQQlhyRXlJZzhSK2lyMG5o?=
 =?utf-8?B?MzVUd1RSZTBNMjZvQlNPbVptNUx2Yk4vb0o2QmRTNTh4d0lQWFNscUZERXhj?=
 =?utf-8?B?dHdSdWFDZTJ6WVlTMzVEekJLNmxpTnRJMWsrT1FQYmk4OVBLa3VRZngzNkFx?=
 =?utf-8?B?V3pNd3lYaGJSM1U5aTVHNnNLN2Q5dzFTUHJFWVNEN2hDSFN3SFVrRm5HdVZq?=
 =?utf-8?B?bVdycEEwKzJpUWV4WklNR2JHUnhlNnpuWWU0N2FESE8xY1U5dGFTZ04vNmpN?=
 =?utf-8?B?eUdaV1EyVlFXOG1mV0NnY09FcUlTNlY4RjFSM1lhaU91ZTZiVktPSE4yZS9p?=
 =?utf-8?B?cytUR3UxOEg5VHBQSWdmYnErd3RHdWcvYUZLOTN0UTJlL3RWdlVXektBbVlK?=
 =?utf-8?B?VVdWSjcrdHhuckk1dkJoNEY2aEVkbE1qTkpaUGU2Y1NKS09STmZZSDlKR25G?=
 =?utf-8?B?enZPQ3dtZTBaSjdkWWIxazlDRXc2QnNsWGphcXJxL1hScEZ5QUdLYTBTK0FW?=
 =?utf-8?B?RXJEZjcyb3gyMjQrQlVsazNqajY2cUNUUEtmN0xraGdYSE5BUlVEVDdGN1dl?=
 =?utf-8?B?N0VZUGE4eHJQbmNPak9aVlFWc2xMWE00SGZCNExyT1BqZmM3NGlpY3ZNZS8x?=
 =?utf-8?B?T0gvdS9zSUtZY3hHeEkrcGV0YjdXMTZjWmZ1NDBUektGcFdBckp0NzlZY0xl?=
 =?utf-8?B?SFF5b2dFQ2hBUlQzZUZvSGlUWFZpU0RYT1RMMmxQV29vSmMxbllFdDFGKzN6?=
 =?utf-8?B?T1hvdlZXWDVHbVpXZUU1cXlPK2lqcFhSMkMwZkd4N3dCbjIzVFVOeXkwN0dN?=
 =?utf-8?B?c01WamwyL3VZNW5WMjltYWEwMlFPM0ZXai9VT2dBcmhzK2lpb3pHaDQ3amVK?=
 =?utf-8?B?eGRnaEhaT3gwUTVHb2xLMnoyejFYeWQ3NHAzdjh0VzFCbXRXZi9hSFBaK2hB?=
 =?utf-8?B?ZEtyMGVDWlRuazYyWHdJZVhZSUh0bDBoTFZKNHlyOVkweHE1Nm8rRUdzZDB1?=
 =?utf-8?B?SmczK0NUTHI3Y0ZDYkZoMjZERGlNcGN5T1h0elpHTnEvM3IyRTZWSVFXL0ly?=
 =?utf-8?B?ZWNEbEdqVkhGZUVaMWtDQzdhYzlQNzVrSHdGSE90YXFXcVFER2VheEFqWDlK?=
 =?utf-8?B?WTM5ZDJzbkJKdWpId0FzbHhwSVNLbUpwUFNqSTlicXVSdkd1OXVDNGplQ0xq?=
 =?utf-8?B?UjlzSzcvalZWNGtUclVFd3Z0TUUyNGZuckZjNjZ5M3dyZXY0bENnKy9oTlpY?=
 =?utf-8?B?a1JkUkdwTkM2T2pvM0tFczh6VGlXKzlnZWRSZ3JQMmxkOFZwNnNpdkxRUU9M?=
 =?utf-8?B?Q1puZTViVk8zMmdveFlaVWNlR2xtRUYrWXBWdU9iTnNlM2Vub20wbEEzRVRh?=
 =?utf-8?B?WUJLR3JrNHhOODNoTWpCNC9ieFc1OG1qNE9Ba3JwUGdyVUJCOXZrakNIdFgr?=
 =?utf-8?B?OTFFTFNnY01wQ1gralMvNXE1Uml4a2YzTHVqajdsbjNaUG9aNDgvcXJ2R1Fk?=
 =?utf-8?B?MCtvRHFzc2hlSnFJY0ZnZnFFWkZmRnJhOU5rZnN1UloyYSs3dmt5V0VabWw3?=
 =?utf-8?B?RGJRdGxWNzVCb3RzdlgxUHd4SnZEMEV0dzZ6cVlTanlnRUpxSlV5eVhDamxj?=
 =?utf-8?Q?S1XGAINPlQBeujG5TRCw8oWkKsoN1Lo5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB7015.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXB0SGN0VXRyRERyL0hEYkdTc2dBUld1ckhDYUQveFZML2FDT01Jai9la0Y1?=
 =?utf-8?B?ZVN6Qk9Mb2trckE3WGtpbnZ4RHdYbmczZ0NzeDF2bkNEM0JKNXRSNVFrMXdJ?=
 =?utf-8?B?empadHI3RFEyT2g2Q01UTEdjRjF2NDJYdXBsWkRVVU5jZmxBZ2prNGRPTEJx?=
 =?utf-8?B?RXVwa1RzTnVlYmFqMklZMk5ZWVllT2l1V1N5RDBGU2dwRm03elJKTkZ4cGg2?=
 =?utf-8?B?d08wTDZjais0bzZQZmtSQitMZk9nVGJhWnFYRmZtTTUrN2xsR2o5aVdrbjBq?=
 =?utf-8?B?cXJTQ0djVUtJT3dMY1NZYVZKS2FVc3Z2WTRaUDl2WjBhcjJaSzNpNXNTVHlK?=
 =?utf-8?B?SFZBaWpSRUQzN1NuUGZrTVRyU2R3Z3l1QlU4RmFTWTg5eDBMUjl6R0IvOG5x?=
 =?utf-8?B?dGI0NzZWUkdITmRMOHZDYUg2V29ZWW1zVTRIYlBDRXRobWU2NmkxampGTVFE?=
 =?utf-8?B?emdPeGFsRkJFSlZLcGtkTThRZkYrczRYYjVEWFAwQjBnNHNsc0l4SWFMbS9l?=
 =?utf-8?B?c2FQUFlOOXlTNXFLa1h0OVNNK1NCZlNFcGYzSjZ6Q2c3ZW5FVGRhS05yVElw?=
 =?utf-8?B?U1QzdUx3c2VUUDBqNUVPYVd6ZWhoTjM2ajBoS0tNQlZIc2VxakJRc3B4MkxU?=
 =?utf-8?B?SVF2NXN3NjB2ZkxkTzFCdVJEbDJIaWFoVys3STArSFRFZnpBZDFUa3UyeTdh?=
 =?utf-8?B?OEtUVEMvb2hyWmlvRkVtczhEdStid0VmN3ZKT2I5bUxMWG5LblNjd2k3M3Az?=
 =?utf-8?B?WkxZaHZiY2RscGR4akUxakYwb1ZzN1hycE5XQmwvNXJtWE9iZlhMcFpOclZl?=
 =?utf-8?B?Rnk1MnVBTGV6WExxczNjazJNLzA1KzliYWJ2Yk44eE1ieTVHaGRnbThhNm5X?=
 =?utf-8?B?L2ZGOVJITWR3KzVPTSsydWpzNTQxSVdLSTZ3RG5Dd2Q0UjZjd2ZhTTlvdGhs?=
 =?utf-8?B?cHh5ZEZHQ3VBSW1pTFUyb1FtVHhJcjFKckVUYjFQbnhkZGRiWTJ4RTZMSy9J?=
 =?utf-8?B?NEp2T3RCNFV5V204RFdxQ1Y5V01lTEZUcnU3VkRlVExOL2ladTJCUHdNcE9y?=
 =?utf-8?B?TkpIVUdvSndjdTE4d09send6MGJOeUNpblMvTWNuNkhjNkpjNFlRTzdiYmdH?=
 =?utf-8?B?ZVRqbGpmWDM3NGlUdFh6anpBTE5aNkhhWFZWd2pmZmp5UHUzbDlkWkhKWUo3?=
 =?utf-8?B?bi84Mi9uWWZhbXRMbTdFSXFXTUxjcjhLTDJ5U2FQajVKWHgrQTEwZ2Q1UDZv?=
 =?utf-8?B?VWhSUUZSbjNibURiZW5HaTdUWStnOVVUZ2RlWWF0VzZiN3BEN0lMd0ltZTZ3?=
 =?utf-8?B?L25IWEwyRzFIbllmbWpudlJNRUppWjFMMGg1L3d6R2NWS2I4ZW5ZS0RZMlVV?=
 =?utf-8?B?NjRDc0VYck16dDJvZVlBNVg0RFlHM1l4aEMrMkhFK3Y5Z2tidjRZaFJieUhy?=
 =?utf-8?B?SGpCNmxIWVowYW16dkZoZFE3aVR0WmZESUluSDJ5YXlXZktwd1JCWmFFUXhj?=
 =?utf-8?B?ZHRCR2w2Kys1dVF0cGxzd3R3cFJmWDBvL0I0RjhVSlJtczJwaGRhdGRySTl2?=
 =?utf-8?B?VCtyYkFXaEkxb1NQUm5Fa04wMmN3azZqZ1FQaVArRisrRUQ2QnhxeCtKSVpV?=
 =?utf-8?B?V0ZwWUlHb2lNVlNMbURycXB5OEhoT0RpWmo2QkFmdkV6VmI5dzZsWHY0ekdh?=
 =?utf-8?B?aEZaN1I0c0EzdXVBNkJlUkk3V29RUkt3enpsQjh5Y0pvZFVGOFh4ZTdFa3cy?=
 =?utf-8?B?ZVNXU050Y2tDNzA3aG0wUjRyTVQ2MGZKTHFQM1N5M2pCYkpiNHp1cGNTVUxq?=
 =?utf-8?B?MW9aRnJndVcyNjI5S2FacWZ0bDJObE94eWdjL0hpQ0UvQ1NOVXIwUDE0MHhi?=
 =?utf-8?B?S3F1YVZaRi9MTTFReDhhR3VUMGI0Wm1Cam52UDUrNHIzRzNjM01IbG11dG5I?=
 =?utf-8?B?QlQ4aVVqWkk1VzFPY1h0ZHcvckZrOERRNDhOazZ0cmFaMWxjdEIzY0ZUdklh?=
 =?utf-8?B?Wk45SlRrdEt6ZXA5RlIwcGZmT0tVUUpNSUlVakI3TjNvenVKQWtNQmNqdmdz?=
 =?utf-8?B?cXFCOFo1V2hpRmdEQ0tnbzBXcERnbUpPTExQY0JnZDRnZWRnRW5BdzdiQnJx?=
 =?utf-8?B?Vjg1ZU1pYmQyMHVGRTVocE5RcElFZnJFZmdkaExlL3VYcEt1ZlFwTU1LMWI1?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f05f3db-2cef-4ec4-6132-08de0d824a64
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB7015.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:37:18.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w+LVgDiEi5H08F96saqMVESGhpij/KRd/P7vgP/u6FHC7DtBPMNWK7EbojapHiFEeJXxx1L8g+IyZ+CHjoOwWKIovT25mHBEhfUdGdtqWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6188

On 17/10/2025 11:09 am, Thomas Gleixner wrote:
> @@ -86,21 +79,19 @@ static inline int futex_atomic_cmpxchg_i
>  {
>  	int ret = 0;
>  
> -	if (can_do_masked_user_access())
> -		uaddr = masked_user_access_begin(uaddr);
> -	else if (!user_access_begin(uaddr, sizeof(u32)))
> -		return -EFAULT;
> -	asm volatile("\n"
> -		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
> -		"2:\n"
> -		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
> -		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
> -		: "r" (newval), "1" (oldval)
> -		: "memory"
> -	);
> -	user_access_end();
> -	*uval = oldval;
> +	scoped_masked_user_rw_access(uaddr, Efault) {
> +		asm volatile("\n"
> +			     "1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
> +			     "2:\n"
> +			     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
> +			     : "+r" (ret), "=a" (oldval), "+m" (*uaddr)
> +			     : "r" (newval), "1" (oldval)
> +			     : "memory");

Minor points, but as you're rewriting this, it wants to be asm_inline
volatile.

There's also a useless line continuation on the end of the ASM_EXTABLE
which can be dropped.

~Andrew

