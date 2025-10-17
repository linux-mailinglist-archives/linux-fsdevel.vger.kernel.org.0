Return-Path: <linux-fsdevel+bounces-64476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF630BE853B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B436E1F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA7343D97;
	Fri, 17 Oct 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mnPWRD0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09719343D84;
	Fri, 17 Oct 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700564; cv=fail; b=Wf0aZqoe1eYowXB0BCj38Flx1qo7abXpkdBgikA3w/FR/xEB8KAzOdRf9dVHWaKdmC5IURmmyuq1pQo9Yj/J2ZnBb4tEua7D1a0EFmS80oAaPXA4e1M0GZ5h7oJPwdCc5nAtnSMGzorz2RJ60mNmsO5GTn0p5ZwEWwfGFhRXC0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700564; c=relaxed/simple;
	bh=An7hqBFCAFf042rJ5aIhjU0v0/r6Yyvdc7RDhwXETBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1ojXAENjGd9wsbEXqx2WsuAHQeRDX9QikSl0liCIfxiSvKsmy3qTFEsyU8PN2ZhSr1NHV6BanNP/pOcbtQOO2y2+iSbHRK8u1TL7fHMgpKvipFi2eXpCHGS5lpretjeIW16Q1EQOQQw442GeC7CrBaWEbBnR6phtMDR1HDUqjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=none smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mnPWRD0N; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUg3Z96JJtz9rtLQXOgV6tWBcr8RdlratWiOlvrVxEnMZv+20k8sDsbszJ6eosxgorYI/XxmMz9Ft3nGH5ka24hqmT1d1bku5HHLmM2QTEobmFw/BaoL22W2OQWbTIf/dbmv1u+1l2UvrS4ks3JwUi/Re1Hy2DO6Mq0KHR32KMxK25f41TD6kgxURFNSAQOyoAWAqVuOah2jLPLqURUGEmx0kWA+M3va7P6C8rEWSGW7off4bOj17tiK64ORh8BjNdOlKWi+1dbHvJnt46GVxeWrPL/uWLOmiaP0y6Vu2xJMfc10DxR5FOrAO6Oswrh19N4IJw+OMIJIGS9go7v7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g850FtYkjXhC2GNpU29LVJwhgpnFQeOXJ4gMScgrmNA=;
 b=k8YrSbvNeGUAlsndrM9D/yhl6baNOjHxfhOLBmTGAsKuaRdIKV7X4KLKUK77Rd6VTChrf8ELW1i7WH3w/Z+oBKsP81bJuu5mKVLUJmW01tqhZc0LQQLOXC5Sy68hjr0AVOXyCC/iPBHd37x8GhW55/lLjqlqDVraZuUscqjJRyWMYiNZui+sQyr134Divmu9Ksc2t+WOGPQjg3HDVIEHqnC5vPDLK5ro36vwFXp3kx3OU9BJJJQikuHE3uLAgs39ciPRIuZ56cGvwebTI4e29+gMs0DTrKe+TMZW7QTsADZ4QqIeUcyXIw7hnnr9BQvOs0Tw9iSqMrXZ5Vq+Q9UxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g850FtYkjXhC2GNpU29LVJwhgpnFQeOXJ4gMScgrmNA=;
 b=mnPWRD0NAtwE7dC1sUBoCyYrvVCDcxtGVx3y5eudSNi6as/UXicKiqha/qIj9chH6PrNjndTTPwQOWCJDRxoIFbODrzZ8n1v+ovkF94Ew9rWIb/jCdVI8j6RDRSvCqObGQDQBf5W/Tv+8suOyJDQdNVMnRVb8oYEKP6rvDv8Fvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) by
 BY1PR03MB7803.namprd03.prod.outlook.com (2603:10b6:a03:5b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 11:29:19 +0000
Received: from DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9]) by DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:29:19 +0000
Message-ID: <a60f6ea2-4f37-4e74-b626-acc3013e4ad7@citrix.com>
Date: Fri, 17 Oct 2025 12:29:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de>
 <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com> <871pn122qd.ffs@tglx>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper@citrix.com>
In-Reply-To: <871pn122qd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To DM4PR03MB7015.namprd03.prod.outlook.com
 (2603:10b6:8:42::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB7015:EE_|BY1PR03MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 967fb0af-3b26-4e7e-39da-08de0d7069c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2l0WkpRR1VZQUZDNUN1bXRaRmtBQmRKcmhyODV0MWR4TG0zdEpoeUkzWEt6?=
 =?utf-8?B?NytiUEkxOGs0MFJpbnQ4S05raThGV2JPckNYMUplSHFCNGJ1QThxc0Nyc0Nv?=
 =?utf-8?B?NUxmNk04cUJYWW1CdUgwVExpcUJNU0FOQllpZjhjMkxUS2J6K25QT1h1c2Vv?=
 =?utf-8?B?R3MxVkFBZEk5RWlNNHI4Nm5ST1FtT3hpdnVjV21KR1oxUUJZVGFlS1FqRHpM?=
 =?utf-8?B?TjlObnJLL1V0YUVpQk5lRFRITzFkb05UNDViNUJ0SFcvZkFqeDdyUHFpMm82?=
 =?utf-8?B?d0V5TUEwZGdweURoK3B2cklnM0RMQjhReWI3NE1ka1Z2dXlhSDdXNUwyam5m?=
 =?utf-8?B?ZHRSL21Ta1ExWHdiL0RhQ1VBU3B2MFExNnczVjAzWElDanJWQTdXOG9HTDBa?=
 =?utf-8?B?UkZncDZjSitueVFJNUgyY2FZNWxuY3RFZG9XRG5ta0l6UWZwWGJzcFJLOW5j?=
 =?utf-8?B?bXArdVlvWnB4RFNNdWx3VXp4dEg3U29jSnM1WGYrWFIrd2FhY2xsZE9OMzVQ?=
 =?utf-8?B?Rk5iRjM2QUZQeEhiS2x5SGROdk1KRnlzZDBlRVR4RDUxbE92ZFBWU3dmUnhJ?=
 =?utf-8?B?TDNVT3p4VUlsWmFHTmdNVitOaUtYL3p6YUd1WEtGTzI5R1VtUXNsWWtyZngv?=
 =?utf-8?B?M2d4ZDdqNzJOR3B3NUhoVEVFdGVjTzZISW9XTmE0b1J1QStyZ2R4Wi9ZTVly?=
 =?utf-8?B?bkRTMU5ZOVRZM1RMZjdJbEx5Qkh5Q21LN1FaRTJ3V0M2U0xMYStjR0I4eVph?=
 =?utf-8?B?TUxqUEFJSGVZUGZlUEtIU1BMK3FJQ2FrQmVPZ3d3cHF2RHFUVFVRL3hGQVNV?=
 =?utf-8?B?NkR6L0ZBSzRWWGQxNzc0VnVYdk5COUR1azFZWDdHekZaWXF3M1hxR3VuVWcv?=
 =?utf-8?B?MUFLbHA2TFI5OWhRb1FGam5XenRGNkRySlNxSW5DK3JRSzhMd0diMGJRSUtp?=
 =?utf-8?B?UVFlL1F0djRxS0hOUmNncVZuS3hwbVczQzBnWmgzamxscVlwMFFHUGUyc0tI?=
 =?utf-8?B?OUY3R1hqVmY2ZldYQ2JEQlBUbUp3azFuTnhFWm1DYklkTFRkaWIzK1p4dU4r?=
 =?utf-8?B?UVBvT0VnajVaOGhadjNWTDhZak80NFVtamZIZjBWaVArWWhNOWM1NEdJMC9C?=
 =?utf-8?B?RWgxdmtVM2x2RFl5QXcvdmpwMkFNK3dZdE5ycDBwTVFuSmkxUkU5Z3VrSTRO?=
 =?utf-8?B?MDRTaDd5TU9xVm9nSXN6VHkramh0ZGllWGJaV1RjVk9QWU9PZUMvQk93NWUr?=
 =?utf-8?B?MkVObXJ6OWlnK1NMa1grbW9LV2JiZnpjSjkxV05lamhCTS9acDdBZEhKdzdp?=
 =?utf-8?B?MjFSMEE2UzJDa1Z4Ri9udDEra0FaS1BqNzVsSlZBblVJaEhDYU1SNmhEMVFQ?=
 =?utf-8?B?b2R1QXlDa1VJVG1ZUStpRkk4d002SFhsYXFjTTAralorR0t6aGhUemhaTDJj?=
 =?utf-8?B?YW4ydmZGSXgxT1owMHRNSVZEOHpPaUtxVy95aDNXcjBYYnltMWIyTVVIWXJs?=
 =?utf-8?B?UnBPek5XTGZUTTR1WG1laHUwTWdIcFRzVldMbzV3b0dZejh1alVSRGl0bDQx?=
 =?utf-8?B?SDlUelNQVlBGa2xFZ2RaWVFKdlVWOTJCTVRmUlZ5NDFPOEFUNjRjVGtYK2pI?=
 =?utf-8?B?NDRQblRJOGF0Nkx0VmEzaFdNeWFUQUZHL0xHNU1LVTF4NEhtR21mcFFsVnpN?=
 =?utf-8?B?NUs1VVlxLzNpdlRDSCtDODNKOFI5QmluZkxRQVdSdXc4eVJuMm5vZzRPYlRQ?=
 =?utf-8?B?ejJGeGdpaVMzZE5iK0JvZU5CdHJoTTllVkdpa2lWNEdoblp4U0xJWlR6TWVE?=
 =?utf-8?B?ZUNHR21NKzh3VXpGS2szQ1pyd2Q1UG05QjB4N1NiR1o4RTlaTmpMMzlRY3N3?=
 =?utf-8?B?OHhTdi9GSVpraUVxd01OSmRKQmZXd0M5dS9PbDB3aVY4OGUwZGdxdE9vMmh4?=
 =?utf-8?Q?bkVPWt6jCADaxhV8Dkj6lhuPUnZAAse4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB7015.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNxbEhDaHpqZEhneUs3Z0V4dGFmaDIvSGxFTDQzdWk2ODZuQXZWQ205VTM0?=
 =?utf-8?B?c3d3cEkyZExEYXJhZmVtQ1BUaEFIKzJNOWJxWjVHM2Y5UmNISkpSUG5lRlZT?=
 =?utf-8?B?eWp5WHp6ZWVOUW5yeEgxUGtjQ29SVkdBS0xBS000RGFvYmx4RDJOc2I3eG83?=
 =?utf-8?B?NEIybitBZDgySzAvbkNSZGphVmxrN2RuWFY0VU5UZnZaSHdIcWcxQTM2Sk9y?=
 =?utf-8?B?VS9GSi9SbTN4KzZiQlNzazQyeGlwM0R1bnJVNGNhZzNzbEN3ejBVQUtHVTRO?=
 =?utf-8?B?dWk1MXI2OXBKN1hTMkJvK2JKcXl0RlF4MHU5WTZyZTBYc2N6SlhsUzg0aVRX?=
 =?utf-8?B?RnVBQW5PT3lHeDNKYi95SXQwRnZ0d2sxMVAzL2xDbUZ5dWJMQUpnc254Zzdx?=
 =?utf-8?B?R0JIRk53Vi9tbGZld09lSGNkWkFMbFhpWVdRUWsxN2VMMElKWG1qWkMwcjRa?=
 =?utf-8?B?MGJCaUp1aEtOOXVRNU1jVGRkZGRhdDJQOTVGcE4yYkJTZGZMTFhxVXpuKzht?=
 =?utf-8?B?T2hNRC9FZjg1TWtsemwwMG9nN0ZBdG1BMHNEY3k0SXRXYmJ0cWhPazR5UndM?=
 =?utf-8?B?Sm0rcHBybHFKTjlUOHFweVVlNFAzS1IzZGJVZWNUSVEvNlJVNVpwTFNZSTJZ?=
 =?utf-8?B?ZnFWRUZHWWEvOXF5bnBKckRTdDVhL3pPdWhNOHBCdjJFT2w2TGw4L3MwQVVk?=
 =?utf-8?B?Wm5SZHJ6eERKbTV4S1J4N2RRenBLbkJxSS94VWNJWkFnaTArRzVDQkJzbjV1?=
 =?utf-8?B?MVhaWnpidDludzI1WjI3M0pGRTRSREZDMTNuNHhhQnpZdjlXbUZTUUpqRnlp?=
 =?utf-8?B?UTh6VzRKSnhsdktSTmN5SDVyNC9PVHRNNm0zeGNJZi9KcmFZazRZb3RubDRx?=
 =?utf-8?B?aDhibjMxaVhQa1orc2pqaUIwNmErNWhHSGw3WVR2OXh1LzBCdEoxMmxldnBw?=
 =?utf-8?B?a3NnNXRpZmZhQ1pUNDh6L3kvUmNuUG5Od3ovWk45RmRVOW5vRHBiNDIrVnVS?=
 =?utf-8?B?YWkxK3RUczZmYkpjOUp0cjNzVzRQd3dyblUvVGgrU245MkpRUndxSzgxODI2?=
 =?utf-8?B?QTNkS2dJTVJvRU5mWVIyVUpvY2NwRnB0Q0NXa0FmY2VZS2ZtNHM0ZlZtYnIw?=
 =?utf-8?B?WDhLTENNV3hUc3NGZEdiMmJzbHhrb3pyeUNIY01SUE15SllvTGg1WW9VVEo0?=
 =?utf-8?B?Nm1lU2dWWi9pM3B1T05JSDJxUFBjK2x5clZkWitYWlJmeURHOTI4MXFLSk1E?=
 =?utf-8?B?TmVQSHFKKy9OQkJMRnFDL01VOWJoMUIrUG9SSHJCaUVDKytReVVaT1FxYmZW?=
 =?utf-8?B?dnBDRjBrcFBtMHg0T0NoSHBuK21heG1uK0h1WXNOVlhsb2tmL0V3bXVSZW0v?=
 =?utf-8?B?OFkrS3lLek5heHRNWlhHR2VvZ0VkUkM0bEV1em5tZWhxMUpIaERPd25UMEhj?=
 =?utf-8?B?VzllY0pjd0tlVlZTcGZEaUdSUzNZbi9FRUhISDZlUVVBdnA1UnB6QlVTVUR4?=
 =?utf-8?B?VkFoV1BiVnF0NytHMWRnYVhTVjZkbDhPZFdpNW9nYTl5L0FEdUduTEFPQnBX?=
 =?utf-8?B?NGtpS3VnczhuYjdkNndsZURlc3k1bDFPNWhoaXF1T3lGY3ZiNmpLc2N0UUFx?=
 =?utf-8?B?VzRDR1IyTUdpVjBtQnMycmlCOTlPbkpZaWxwelp0YStyZ3cvck10U0ZWdUhl?=
 =?utf-8?B?NHVKQnlNZE5zSC9LRkhhVFNJQWFnT1loY1Y3b0lqR3dQQ0NjQWMyMnNqNTJN?=
 =?utf-8?B?U0ZERlM0cXppaVIvc2E0bVBnTWVCNzVoTHVrWjFNRmlpODNjRDV3MUdrU1BI?=
 =?utf-8?B?Rk82US9SN2JHcE85Vmp5a01keWhmNzRwRUkrNXhUa0ozQjdPRXIrSnIweWtU?=
 =?utf-8?B?V3pmTXVtUWdOMHNSYVVNK2g0K1h1Y3FVNlZ5VitLaStyNzN0UGM4dUwwQmRL?=
 =?utf-8?B?dVE1cWE0S05mOG9Ud0c0Ym41bGRTSnZjNnlDdENJdzV4Qzh6YWpaMzIwZmZu?=
 =?utf-8?B?TzM1RVBHMG1RUU9RU0pTRGdmbUEwSkhvTnlkdENzQkNDSUlKWVRYUXJ1QUxx?=
 =?utf-8?B?cis4YWRJdyszYVFialRmQ25WdFZlcTRLWVJrYWpIRUtKMVB5alRjT1ZUYVZv?=
 =?utf-8?B?ZTZqNUxVN2pZekR5K0trUzlIRjluWjJCaWExU3MvVXFMeERrN2Q1NU5RNzE3?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fb0af-3b26-4e7e-39da-08de0d7069c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB7015.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:29:19.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qLuuiScfpTEVMId3Y9INOBtf/ISJKImiV9xoPKsDgPQ0+N4mdncD1HP+oqHw9gVq5nw+KYgrttdEogALKWPZzxOAyHNVto5Dv8iSqYdSfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7803

On 17/10/2025 12:21 pm, Thomas Gleixner wrote:
> On Fri, Oct 17 2025 at 12:08, Andrew Cooper wrote:
>
>> On 17/10/2025 11:09 am, Thomas Gleixner wrote:
>>> --- a/include/linux/uaccess.h
>>> +++ b/include/linux/uaccess.h
>>> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
>>> +for (bool ____stop = false; !____stop; ____stop = true)						\
>>> +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\
>>> +	     !____stop; ____stop = true)							\
>>> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
>>> +		     ____stop = true)					\
>>> +			/* Force modified pointer usage within the scope */			\
>>> +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\
>>> +				if (1)
>>> +
>> Truly a thing of beauty.  At least the end user experience is nice.
>>
>> One thing to be aware of is that:
>>
>>     scoped_masked_user_rw_access(ptr, efault) {
>>         unsafe_get_user(rval, &ptr->rval, efault);
>>         unsafe_put_user(wval, &ptr->wval, efault);
>>     } else {
>>         // unreachable
>>     }
>>
>> will compile.  Instead, I think you want the final line of the macro to
>> be "if (0) {} else" to prevent this.
> Duh. yes. But I can just remove the 'if (1)' completely. That's a
> leftover from some earlier iteration of this.

Oh, of course.  That works too.

>
>> While we're on the subject, can we find some C standards people to lobby.
>>
>> C2Y has a proposal to introduce "if (int foo =" syntax to generalise the
>> for() loop special case.  Can we please see about fixing the restriction
>> of only allowing a single type per loop?   This example could be a
>> single loop if it weren't for that restriction.
> That'd be nice. But we can't have nice things, can we?

Well, the worst they can say is no :)

~Andrew

