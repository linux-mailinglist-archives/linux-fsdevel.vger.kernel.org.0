Return-Path: <linux-fsdevel+bounces-64468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BFBE8300
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16516E1BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EA32AAA1;
	Fri, 17 Oct 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ppgZ71Nd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884C3203BE;
	Fri, 17 Oct 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698250; cv=fail; b=ofpoPPP17E7dqGG80DFThA5YCBQwMxZu54h18DfU9oEIBxfuQ4B+7xUmW0uAsNdBAmhL438DJZgaoSr1UKTfbrcVxvXOFeMIE376DYFn7jcXRTUz+RcKw6p99BzrltWzBT2r2oHdJU+j+HfRiJpgO786Yr6fJrCmwuRbGFvpYDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698250; c=relaxed/simple;
	bh=jXo12UdeBYvYSePreEAlQ9sWn3C8AZrhqo3rpR7IdDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lYBAg1Da2/EhuyGQNBytn+ddiIQsGcsnck3sSCPmz/9GVccACAI4bHNycTXf8TdjX3dlgWroY3IGmDtE4+6Sm7YVbpi0gY3YDzZyCy2yGOajXMoFUR0dk37gbRRiYAVIXtyUUEePF3u4U2baS2ahNqLtJTnyyJCv/2AY5Et5Edw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ppgZ71Nd; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5/yHmT8W7MjykdSqF756TrwM1OagilAhmQiLKwdyJFx+JQiQlzcJKIsoAsMp0mW2vQOahPoke6LbCHN0jeKptAW9kcX1j+N/R05r1btpiJmDIl71d509E9rz1bsq9kW0RskicNJ/XsMsFZjG14/sBu0/OYgBp6iSv+xW/+yg0qp4gIfP5tcdot9xtvzwczJNW2TwFROosPV0FSKE8Lswrq7/HWHx93hetnexN5E/rs2v09OIfEVlf6pMtT4NW5uST6iSrglM0fW1guZ/sOV8l5oR6d04i3CtE5o5b4QzoMs35vy1I4tqBv0H98Hxs9UbnB8P9xZXMSEXv+asFcamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXo12UdeBYvYSePreEAlQ9sWn3C8AZrhqo3rpR7IdDA=;
 b=vGei25lWMiNOOLXo8cn0T5qnsM+KdOOvqahFBytA/4O/w14WLK1Nn3ixiByEStuO8uDRXMfAztJpxo5OKLGv7cWh13c170OBv/cenpKZIHJcAOObE11Ej1PGk5MvJ6y1WVfWA54kZTkO6G313zL4jsnMk/UcDz6m39jhy/8c8BkyGUjl/vLKLVoOQhjkZ7DpFqijcZjzPTsFnIUd88r7YjnmP/SnvUidv8EgIRZsIiJUqrQHBHL1yN2IV5sMaqHhVGZEr6RcYFAryiBN79n7WCOIoJ95nt5EB1zi3u0RQUdtL6YmCOGeadewrmDeFC5nCxrRxE7vQycRi8LR3k/eQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXo12UdeBYvYSePreEAlQ9sWn3C8AZrhqo3rpR7IdDA=;
 b=ppgZ71Nd8jI/oh4PbVvGZ/qhucdFlkE3bgpOHuGv+awJ6uXBefxtLdYEHJoitjCQz1Mv7gxdaq8KCidnczuAAGn/evLSYSeb/R1xKpyBT1/hxgUy1q9vMguu+jDWRAK2FixB/Ypp/9Srnp3PXaszkpueGmQJzjr406BFaZteCNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) by
 DM6PR03MB5161.namprd03.prod.outlook.com (2603:10b6:5:240::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 10:50:44 +0000
Received: from DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9]) by DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 10:50:44 +0000
Message-ID: <fa0b436f-d0c7-4a5c-b2c5-edfa963c97b1@citrix.com>
Date: Fri, 17 Oct 2025 11:50:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] uaccess: Provide and use scopes for user masked
 access
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
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
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017103755.GZ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper@citrix.com>
In-Reply-To: <20251017103755.GZ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To DM4PR03MB7015.namprd03.prod.outlook.com
 (2603:10b6:8:42::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB7015:EE_|DM6PR03MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8f8b1f-1f3f-4c66-ec61-08de0d6b05b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFScjRvc1RNSTV4T2hqSXAwRVl4Qm1Yb3Y1NUNWRHdLS01xYVQ5ZWQ5RWNQ?=
 =?utf-8?B?NGZuZFZqY0Y5Ni9NN2k1YWtiSXZycDNtb1AxeEVzdDk1NVNDOFF4UHZyQk9o?=
 =?utf-8?B?aVpDYkpmcnBtMVU2V2NpN2JpMTh1RVBpWHg1TXQxZkJ4M3ZvQ0I2M0Y4d09P?=
 =?utf-8?B?ZVRXdkpOL0xlRnNGUm0wbWxXbCtNb040S3ZFY2swU2puNlZsVTRvVEpKM2Vv?=
 =?utf-8?B?WXhDY28ydlJoSWZ2d0pxWnBCQ0lMSnNJdWFWbHdCcFZDOHpJVk5ZYnBMazJP?=
 =?utf-8?B?aUowNEJSRzF1akMyTUNNUU94Q3VOZncvaGU3UHlITEtWRzZ2NjdwN0pHbDRp?=
 =?utf-8?B?MjVybTBFUnRUVFp0NUU4S1lOd0VmelRuZDdUbGhQL3BwWFRzK2hySlhDT0hX?=
 =?utf-8?B?RCt4S0ZNNHpHR2NGZmVTanZvZS9GVFd5OEl0V2dWbktTbDdrZ2s5V0tkVDdV?=
 =?utf-8?B?bXd4dERlUnlLYVZYcklPZnpvSTQwemsyYnNmWXU0Q0x4SnpRSTVaYU9OV0M1?=
 =?utf-8?B?TUhLMnREcTFYMTFDU1FtRWdHTlR6ZDR6cEk1VzdKTXc5SDFPaU5DUHhRQW56?=
 =?utf-8?B?WnVzaFRXSDhzdGUvVXowblFPYmlGdXJuYkRWcVpRMGUrYU5WUVhDSHVpaWZv?=
 =?utf-8?B?V2FlQnBvZndkRm1VTmRaRjZtZUFQM211MGpiazR0cjNWWFY1Sml4Q2hvZHhC?=
 =?utf-8?B?U3pQOGpqa1dQcmlTU1RrNWJFQVA5KzNaaFl3VVl1a1AwSVhXVVVOTkdkVUVu?=
 =?utf-8?B?T2dBbnUvRmV3U1c4TEZ4QkVKK2JBa0lpNTFPd2JYNzVmSU1oMHNHT3JaMTBY?=
 =?utf-8?B?SWVnWS92T0dJNW1WNHVXeTVLczdaM3pTWVYvSUdNV2dJS1pXNUlITmFCVGlZ?=
 =?utf-8?B?TnZ3SU5GbG1obnYrN3dXN1lTaCtBTE42d05uenZUaGdnNnBLQWp2YlZQNTlK?=
 =?utf-8?B?VE5OcTZBUXV5RllrSnRIaW4zcFV0dlB6UjNjU3J2TGpLRFIxNUJTNXd3NGNz?=
 =?utf-8?B?eVh3dXpIOXlhZnYxWnpFRmhUc2cyUGhxWmh0cVRmVjZiTUcwcGl1V1EwaUg1?=
 =?utf-8?B?Sk0vNEFlbFdaRENUZit5MklYVmRGNjh3a2ljTWNDSFcwNi9tV1F2VCtQWlcw?=
 =?utf-8?B?MVVNNmpOd3hYejAvTldOT3Vld3dHaXluTm50QmdKcVd3VkljTHdpc2h6UHcx?=
 =?utf-8?B?M0k4Q29IUEpVZ0dFRXFEQ0NyNlEvdld1aXVJODhaZ1U5YkFFa0pIT3NPQkp1?=
 =?utf-8?B?VkI5bXZwMytyb01QTFZCSUpLT295L1ZWTEdINnFYeTVFTGRkTU41cDNpMVd3?=
 =?utf-8?B?UGhNQ0M2eXQvNzZERzVmVHNkRURWcFR3MVN1cEpVNWhVQ095UGltcjNSUXBR?=
 =?utf-8?B?dWgxcDRYbTVZTWdURCtkWS96RDUybVNWcDlUTlcwU2lQWUxYY09BakpGZXJt?=
 =?utf-8?B?VkpHUG9xdEJIQ2c2WTFoRUxkQ1JFQnZRc2ZuaDV4T0ZWWksrcEh6eThLZDcw?=
 =?utf-8?B?eURVRkdBb3NBRmtCTGRqaHhiN2hUekE5NjhLZ0VjNEdBaXJua2VuM3Ntb2V0?=
 =?utf-8?B?TGpaMzg4R0xJNGgwbWY5aCsvZ1d4MndxQzBFM2FmZ1pLQ1RRTDRzbUZuVEJ4?=
 =?utf-8?B?djFEeEthTm9YcHJoSmNZdG4vdWc0WGVPcTdTRlRzVkR4UEczYnh4V1dFb1NU?=
 =?utf-8?B?MExmUktxSmdWbXQyTWs5T2hsRnlBRnJuZVVPbXFRdnJxdm5GbGY3ejVYT3Rp?=
 =?utf-8?B?bjh5Wmp4bGovaVArM05oV2phM2Vaa0M2YzFuLzRLeU5VRmtIb0NTQ3RwVTBV?=
 =?utf-8?B?SW1LUFdITWl0V043c2x3MWpVc2I3S1pGZnpPZUxvRzM5cCs2dkY2c3N5cE5z?=
 =?utf-8?B?b3FVMUQ3d0dJbTAwL0pSRlRrZXZxb1MwU0x1bEFXT0MrcnBwWkhjZUMwNXl3?=
 =?utf-8?Q?BmIIBCEZwfeBg9WT4hUw7gRNCee89Ilf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB7015.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5uNDlyeXpaYjlDZkllZzRITi9qQ0RTWjMzMHhrNzNDanlFQW9nMEwzbGYr?=
 =?utf-8?B?OTgrZmQvMTBHM1lhZjVBODdONUlHanhITFIrSC84eXdyaHpQQmJhdld0M0Zh?=
 =?utf-8?B?cGtiZlBIV2tvLzYyc1psK2dZRDhtczhLdXdJRHVEbWw0ZVdsbzVwQzZKMGNC?=
 =?utf-8?B?K2ZQeVh2dlQ0SVBOZXIwSjdUVzFnTGdzRnF3NU9WQ3QyT1JDVytqUHE1T1or?=
 =?utf-8?B?eDJMZVdqSW0vUnc3RXpTNEExVjkvYWYvL25vV1hLTnNvS3BJNUdienc4Znlm?=
 =?utf-8?B?TFQ2RjgyYkFMRWFOTk91S1FqTk81OU1td0R3c3hrck1kcmZLdkdNYldXRllv?=
 =?utf-8?B?Zm1YOU44M203V2xvZHBwajN5YXpDalRTWEZ6cEJMdDF3TlZaQThJMWJWRndv?=
 =?utf-8?B?UGxMQVBNLzI0UzZUc2tlMEdUVzdVM09nOS9kVTN4OFVyWkNON1h5N1luakls?=
 =?utf-8?B?eEFoS1JaREJ2RVRsajZ1NENLV2M2eHo5U1Bpb1lBMjhRbko4dkFDVHZpOGVK?=
 =?utf-8?B?M3dWWXVISXVMU2Q5UXYxMFNjdnU1Zy9BSVhmY3lEY3lxODhtSlIyQVhFcHRl?=
 =?utf-8?B?ZWFsSTNxYzhmT0RrN0V2L2pxR1FnMTU2N0IwS3BVTjhOUjJTdGs1YWsrNyth?=
 =?utf-8?B?N2tjUDhIY21EZmdrNERkTzVoRjB1emhGK3dPNjFYYnNkT0NXSkVRMmhZUHpa?=
 =?utf-8?B?bU1vSC9sUDdVYTBNcGFOM0k1eFhHOHJlei9aYUdWZExaRTdNZkdVYmdDaUdp?=
 =?utf-8?B?NWpJaDMydjFFUTJqQzNTcDBGc09LeUJoMTZQNFBTRzRnZnFxb25Za1JkaU5X?=
 =?utf-8?B?bXl1R3I0eUg5S3RuL0pLVzBsZEtjWVlHMXRONVY3cUkrbGllZkt0YjVHb2Nz?=
 =?utf-8?B?TlREblEwRDZLdUhoR2JEVTczSFRjZmlFWnJ6SG1zL1A5NlVPYTQwdGpWRC95?=
 =?utf-8?B?VWhNVmZHcnZrcmhpaU1VaGR0bGw4NWJBR29oc1pDOW0yem1JUnQ5YVJnYVdp?=
 =?utf-8?B?V21NY2l0YVM0S0VYMHA5REJ1VEpDL0d4cW1oZGZyeE0xUGFsZ28zUU50WkdF?=
 =?utf-8?B?WHNnU052MmFQK3RscGdqSlRwZTlQZmJEd01wS256dTlzSzYxeHJGOGlzMnVB?=
 =?utf-8?B?cmV6R0NENk1nVHV4dm9pMFJjL0ZpMVdMckorcXk4VG9KK0FBSmlIRkxoNGQw?=
 =?utf-8?B?LytFRzl0N1RueEFJQmM3WXFScHI0M1hJcmFjcVZzUlpGM0Rab3dIU3dZaHBW?=
 =?utf-8?B?YlFrc0h4NU9FRVhUWFJzUTJKcnZxbzhFYmJHQWdROTkvNnBUbXo0RW5vOHh4?=
 =?utf-8?B?dTVqZW51ZW1hZ2xzVXdQbXhBOVk2b2NPN05iS2RwcC9XMXM1US9adU5WbzZ6?=
 =?utf-8?B?cTRoSHk5Mk1rbFpRTk9TUVhkZDM4c0dia1U1SnhieThDM1U1WWVPOHhTMm1p?=
 =?utf-8?B?alVJR1NOZ0wrcG9zazZaTnJXOXlYTnR0cFIxbEJkTGhzNmxNdzczUzFOQWtv?=
 =?utf-8?B?dEFiYnNGOTMxZ01TRW1kdzZVMEV3OSt3eFV2K1hwSGpsempOcXF6Q3lkUURL?=
 =?utf-8?B?b1dkVUhDY3puWVVacG1GM3hnVkhZWnJYbk1Mek54bUs0bmc4Z2JmYmY3eWVZ?=
 =?utf-8?B?MXFXaEI5eWFTL2QxL213YzZQRnBEcCtMaCtxeHBXUVRZclFXVXVhNDlpUGFt?=
 =?utf-8?B?ZG42bXpOK2sxYWNaSWZIRCtBSEhURHk4bmUzTk9CUkNKdlVya2pET1ZDei9P?=
 =?utf-8?B?NitCblFjY3lQOHhPQnRJc3dGWDdyZTg3VU5Sd2VMTlNLOHVUNFZpNnNRV3F1?=
 =?utf-8?B?U2RHNVhRdjJXb01KY3p0SkZEd3Ntd1dYcmVOMWtRSDFaVStrYm03dTI1MFcx?=
 =?utf-8?B?dFBXUlRTNDdacWJMQUkyeHU0WWM1Umt5RFQweHlqbklIMDl1WHNoY05jZzQ2?=
 =?utf-8?B?RjdEaUlWUmlMZGZEYmRvZVo3OXpvaW41bGJMV1d1NHBrWXJNdHB0b0VxaFBN?=
 =?utf-8?B?R0Z1cU9QbmN0RXo0aU5vbVlxZTd4a1lSVVVZSVVqZ0ErenZYVUEvblJtUCtk?=
 =?utf-8?B?N25mMTZ4WDJoSURIb3p4cW5sSDJRVWlMUVV1YnQybXBEanBwR3VtYU1naGF0?=
 =?utf-8?B?VUFlckYwSnNkVHp0b2NnSVVFNXdsZ1FsYXpnclVyOWJ1ZzNIbkhuSzhlMjRa?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f8b1f-1f3f-4c66-ec61-08de0d6b05b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB7015.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 10:50:44.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoVGZY641HKqmMa9VGV2uR7v6Ho/C+IGl9KjCjUbrBiTDLyyjzG9svn8oN1EmaSso4NV+5MwQWvp9G0MkWpuARXtsMMaEJDR1+lCLn3tUgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5161

On 17/10/2025 11:37 am, Peter Zijlstra wrote:
> On Fri, Oct 17, 2025 at 12:08:54PM +0200, Thomas Gleixner wrote:
>> Andrew thankfully pointed me to nested for() loops and after some head
>> scratching I managed to get all of it hidden in that construct.
> These two hacks are awesome and made my day; thanks!

It's a new four loop paradigm, brought to you by a silly restriction in C99.

~Andrew

