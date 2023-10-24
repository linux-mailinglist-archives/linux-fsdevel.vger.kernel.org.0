Return-Path: <linux-fsdevel+bounces-1048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B47D527C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB332819BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F092FE07;
	Tue, 24 Oct 2023 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="X0z88TjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEC2C852
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:47:06 +0000 (UTC)
Received: from outbound-ip160a.ess.barracuda.com (outbound-ip160a.ess.barracuda.com [209.222.82.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60596FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:46 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168]) by mx-outbound12-146.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 24 Oct 2023 13:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCxHDRpZIKZMGBHh/0Y6BmBDJ+7Okd/vUTYHQCEu7ouf3dJMHqIPaVYypLzRTpqZUQa1Fp9tILVv2h+uR3BTJKd1wd9G3gnYfK3DFXnf+9MRTTGS5YaXLPr6bofGjp1+47PK1pA+tag4SKuyUbdt8Ae1DZjmh2muDX2/DBQpRjb3TerZmvB06V4bu/psA/dePGUoy7DdbChsfh2T7sHx/dfoJBGR4H6vd7//PkuMSCht501f2ZJyvjay8sX1pWf50euIezBEnT5UACDoL6Dk8AoJBCycFNi8vFFMxMZ4QC1WkGh+C+Wv0nyiVxyihIdc5dL3vTf9+xKFlQMeiStcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTKavM6dQWUgjB1urQVtWktr8pjlz5SZlYT6Jelyrtw=;
 b=e09WEELUL/QLQPSajJrUyTaz1Y+WqsPLcH5LCrrbNyHnh8sNBB3q7F9hAtyQqbf2SVpbor3nJ5h3k/eZh71O+tpZtCew0aG5P785JdWXws7EjMvvSbSi7nTj9LuYZ2JLCE1vY5AqNexkGuAHiXi0MMhdgpShTppchSoxeGx1Gso50Ik+cevNV5r7wpCTCJskybuh1UII8v6ti3z9pKgFIN6+TvvOS/PEjCEKTD3rnEdR4RlHvICQUudyWE+LfN72pmL5+rbZYppfXvyz+DyBC1r1Qc8ZfFwNUY7qSsF7rDTI1LcLpqW7gSS8lU8UoW5NUaVODBNIUQWBhMeQfi5eSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTKavM6dQWUgjB1urQVtWktr8pjlz5SZlYT6Jelyrtw=;
 b=X0z88TjPGDFsq+c+KxdPmrOtBAcqPFKbBjies/p4GGGb1LV+KwORK6wk3CBvMdCepnOTKZ+jp7NG98b5rfTNgGkEybTsL48ckdwyeW8TK+sDwYE9TafMPEhbENmo5UKJ/2KcR6ExhmXmdpqKVmA5SrRNSRnmL9iWYt1boZWVLBY=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BLAPR19MB4548.namprd19.prod.outlook.com (2603:10b6:208:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:46:34 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::74ca:a803:412c:fcb3]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::74ca:a803:412c:fcb3%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 13:46:34 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, Dharmendra Singh <dsingh@ddn.com>,
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v10 4/8] [RFC] Allow atomic_open() on positive dentry (w/o
 O_CREAT)
Thread-Topic: [PATCH v10 4/8] [RFC] Allow atomic_open() on positive dentry
 (w/o O_CREAT)
Thread-Index: AQHaBd8KxNswbvVa/kuhDgVV0JXrT7BY9UGA
Date: Tue, 24 Oct 2023 13:46:33 +0000
Message-ID: <f894db77-67a2-4452-a16d-7e21df5664c2@ddn.com>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-5-bschubert@ddn.com>
In-Reply-To: <20231023183035.11035-5-bschubert@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|BLAPR19MB4548:EE_
x-ms-office365-filtering-correlation-id: 77450efe-f91c-47bf-8b63-08dbd497a2e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yWvjuKNH+hn1Wtgvwvh6vy0LHzEO8yKGkOwqXDwmXXjDHKEjt0FRnefopAKgqBbCUfIZvih0LP2jW+zeuDO9aot32qEYWjb6B82VeiLr7ghzYKurmLzh/EeQCaKrhjf+S51++zrRloXnYCfPL496EhVJK3sYYnclQcN3Mis7fIsE5dk1VUDyHm+kOi0s+Kb/Ag6UMTbBYxSmMe8H/OzBLW9wroZMJ2hE4k/97YSlOVxXbuLDP77zn4qP3vRfPSaZ2W4Wi/MUMilM4QcHHQHQrcPy4yZwznYQdFO5sDqNKmGhkblZIuuj66r4RvaaJyqBOjSu8TBQwaKSmU30BCnjHqXW8RLNe82pFK+aKkSdlRhflWDHfM3uejQBJMAmEGSG5VUr2ay4YmNeQiVHW3W0wwwUWV30pE0V9EzydN4ze7pjBOy5fofGQd0U2vJ59zXEjnQsKT48R/p9jECLa0trKsR48ULK5niS8BCZ4AYAEQEapl1oiQt01ly/L5RA8AuOc2nCbIPy60vOhXBAODJwPzsoAvMprwZqq85x0YGwU3qtZs8EGXgOINTW1IH0Xo7EQ/l3++GRkjH4Cx8EYHMOSubtMINdN72Hkj+ku78GYlnHXPjDKxkkykHyf83+b8Dxc3vwL+PlWmbynmlJHQtRanDVkt2f/p/Ls+cWCIR55yJFADRz7bQsQqtOIaKAAagf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(38070700009)(83380400001)(2906002)(36756003)(8936002)(8676002)(4326008)(53546011)(71200400001)(2616005)(122000001)(38100700002)(5660300002)(6916009)(6506007)(31696002)(316002)(91956017)(6486002)(478600001)(6512007)(54906003)(64756008)(66946007)(86362001)(41300700001)(66476007)(66556008)(76116006)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXJsTE9wenJKZzJCclFkNGdBSHdyeGthVzlsRWQwWDZFMCtUMnp4ZTJiNUgv?=
 =?utf-8?B?RVFkRlgrTjJ3emluNmhGaTJwaGhnd0MxamdhcFZrbEJaeEd1V0k0TUxxbXBZ?=
 =?utf-8?B?d3NOUXZMY1E4NkhkUHgzeW9ZdldLNys2R3dZT0xDZXhxTDBoMzduUGV3VWFK?=
 =?utf-8?B?QVFESEVzeUpSMmppV3lLSy9hYndlVzlPaFdMWWF2bXpFeEVnZmVwaDF4NFl2?=
 =?utf-8?B?disvYjIrTmVyVlhJR0EvdklMTVJydkhBZTBCZGN1NVZEem02NlpCZjFrTmo1?=
 =?utf-8?B?N1hOUzdNRkdML2E2Zkx6bnZRZXJTQkVGRzI2NEVzUzBVMXYvb3dtUkFQOHJU?=
 =?utf-8?B?c2hkd0pmMmp4RTFEdHJwaFo3L0s4UmVXVk0rSEtQcW8wUWlMcEJBb1pIODRD?=
 =?utf-8?B?MGVqRnVra1JGMlNPUk1jKzY5aFRDMGF4ZlNhYUpiNDMwcXdMeHRwbzhCeU5r?=
 =?utf-8?B?U0N5eVdyQnBlaUxibzBBRTY1OWpGdnNXT3JWek9JUnpwQ093aG9nV2hWNm5D?=
 =?utf-8?B?SnBpYzF4bkVPWXA3RW1sNlZtUGsxdHNjZlJ2NGhldURGOEd5YTBJU2EwMUd5?=
 =?utf-8?B?aVNqazFRN0dTY3l4bmhNcExXSTdwNnRER1N4V2J4SUJVVEhtNXpjc3dKeHI5?=
 =?utf-8?B?cEU1ZndwQkcvclVrcnNMWU04ejFUWXNjdVAyVDQ3VFlTOTNrN0RnclBudnda?=
 =?utf-8?B?dXpEOWc1YTJ1clpFbURyNG1EVFcrWENpbDdBaG4wRzI3SCtIK3dLMiswQ0V1?=
 =?utf-8?B?SnZyZU56MGFCb01VRzdzc3NVMnU3VVlKY0dDeXN1eEJmZVl3bXpjQ25nZkw4?=
 =?utf-8?B?SjdKQWxlQmd2QUdoQjUxVjk2bE4reVJGU0FsVVo2TW1MTTJ5M1U1RnhqT2JP?=
 =?utf-8?B?aHIxZlAzR3RNOVBRMmpLK3BmazN3VnlwaHJocERINFJBT254OHdMSWJOQ1pF?=
 =?utf-8?B?MVhBYU10Z0FrUUhKOWc5OHhDb2hOd09ZZzI0ZjkrSjkxajkxYm1RVHc2WlFV?=
 =?utf-8?B?ZEpQSXdmc1pIbEVDeC9uZmxJRzF0TE5wUDI3OEdwVnU5STFjNjlTemVOczhB?=
 =?utf-8?B?dllSRnJ2a2kwTTRWNmRXVkt3V21vOFZOaXNtb2RIVjU3UjJtYkFnU3UwN3Rm?=
 =?utf-8?B?UFdDc1BuejR3WGJGVlBZSldUQXg0NTNuREh4anhKVzhPaWg1RVN6dThQd0xo?=
 =?utf-8?B?bFM3VVJORmJIbjdHeWV0QitYbG9LUENzOGRNakZjdk1QNVNUK2xKcVBzaWgw?=
 =?utf-8?B?bTJHMFpNUUZKV0xEZ0VlLzJSVi9IaklaaTcwalVDSzIzWjRjTDZKV0NWRlFU?=
 =?utf-8?B?enVlUUNsd3hicGozTHJMNFVvWkRZYWNZQ2hTZWQ1NzJiTCsreDREWU9pTVI2?=
 =?utf-8?B?aHExR2FFd0t6ZlkrbnRCbHYwR0gwVUtUMWxaR29kb2pDMHJ4UTk5Wi9kQTNL?=
 =?utf-8?B?clRmU0VxeWt5VEhoRTh5QWtTd0VVWmhyQ0plazh2alNQVGJxVEIxQm1vTGpp?=
 =?utf-8?B?dXorcWJLTGE0eW9peXp5Uy9MUDh6dzNKNVpZVTFuMTZxQzd5bmZ3Rms3dWZW?=
 =?utf-8?B?STdPYmFlbkJSbTdIbjJjZ25tV2JlWStlblI5cEFrUnV0S215UitwWlRDeStw?=
 =?utf-8?B?M0NVbURzZ0tUWm94TDd3NG1QcHpiYVRpaFY0NjNoV1dmT2dzZndJNEM0UHFk?=
 =?utf-8?B?ZVVRd3FiazUwTy9qYWpDZWZ4aHozeFhLKzk2VFpTeUhSV01UekUvSlFPZnVa?=
 =?utf-8?B?STRacW5aVDRyL3ZwZjhVdVRHWDN5cUFCcUJBQzVldkg1Z1BMSDlHczVNOXQy?=
 =?utf-8?B?eithMG5LN3BkWVVSekJnWUF0VUZwVFJCbmxJYXdlb2hnQzFiNXB6Q1JOeEJr?=
 =?utf-8?B?Y1U0dW1BY2F5dUVNV0Z5SFQ1YU8yMFN4TzRZTm45bTZ5eDhBeEZnNU9ZaDhC?=
 =?utf-8?B?QVpMNXFEQjlrYjdOVnM2Q214MG50M0M3dG9uVEdqRlUrV0srWGhPc1dOK1la?=
 =?utf-8?B?OEphd0UzYkl3OGZsUkdLdjUyTDJ6enB5REpaOXBBd0JYa1BMWUVsK2o5cms2?=
 =?utf-8?B?VXJ6S2tvNHArL3czMTBJV0xkQ05tUzdXUzVuTjNVSzdycFQwSnQzbEo4N2Ni?=
 =?utf-8?B?UXRxcVVQZGNPZ25IV1l0ODJMSysxa3c0SFp1OXVETURlVjVhYVBFdDFsZDUv?=
 =?utf-8?Q?sWj80gwSgieTTI8ZMXGsRlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA7C74775FDA5545B917A58370DCBF86@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?utf-8?B?KzFZUi9iRUFwMUF0NGtKaldZTjFBcnhzT3Iyd0I1azBGbldqeW1JYmwvUUVK?=
 =?utf-8?B?YXRsRkxhbE9rTWt6V1Vnam1WSUxxRmJGdVJ1c2lId1dDWit6QVgxcVd0QkRM?=
 =?utf-8?B?dDVmT09wTFJZS2dlZWNHUUJ3dXJKVnh0VlcwZ1d1dTdTbkY5QmFVcmpFS1Ba?=
 =?utf-8?B?QUdlZlhLc3RhU0t4Z2M2aERkKzFZcEwvcSsxZEZMTGdKbkh5SWVoeFR5eGUv?=
 =?utf-8?B?OUYxb0FwaDJma2Y5OXlaYW9xemZPUHA0OGtTZDRhdldQM3VSRWR5MG1NSXJL?=
 =?utf-8?B?ck45ZjBHNmM5dWQwcHVKeHFUOHAyK3BOL3d3dUt2SUQwM2NBTEp1dXNkMUNz?=
 =?utf-8?B?b2tCakt3OEFGYlpHWENxelVOQ2UrNXc5cWEvREl6eWM3R3owKzlCblZ6cDBK?=
 =?utf-8?B?THlMUkZSN0pNU0YrdXFJMzVKM0xYWUZFN2tvcDB3eXArNWJoRklSaWRyMU9D?=
 =?utf-8?B?YlJUWTZyeVhPbGx1SGZMMGs0M2I3OGx5WTVCOUtsMGJaUzl0cEVxd2wrNWtY?=
 =?utf-8?B?R1JlVTJBdmtvS0NzME8yeUhyNE8yQjJkbXBjU3NkZnI5cEVOMlNLRjZ2ak5N?=
 =?utf-8?B?TC81WkxpTVpLSnNadmx4Rk9vQkVNejluR0FucUxEYTVCMC9xU3lKS3ByeHdC?=
 =?utf-8?B?bmJZM0pnWjE1TGlJS2E2bitUclQrWDk2TUhxbFdRK3Y2dW9iTnpBd1Q3ZVdE?=
 =?utf-8?B?KytzVmd0dUR3NmlOTnB3S0ZUOU5CWnlRQnZibDVpSDg1VlgySWN1UnErUkUy?=
 =?utf-8?B?cHlYSDdKSHZRZElaQUwvUHZ1Rko2VS9WK2I5SjdqWm9zRlgzUTI2NHdTMWhU?=
 =?utf-8?B?RkFrYWJzUTAzS1dncURtWkFkQ3pqV21rSC9pUGhuWElmR0RDZTdQdTlzVTU2?=
 =?utf-8?B?R2dIakdUS2xyRzRSbnJ2K2JHYkZ5d0wwaW9udEZMaTlXTGdHOHhJVW5neVI3?=
 =?utf-8?B?V0twOUNNL2hWQmpqVzNXM0Iydlh0NkZLZ1VFbzQvUVVGWkFlc0ZvTVIvTzRy?=
 =?utf-8?B?eE5aZDNQbU1wK3h5Um5QYXRyN2pKYjlRMWRqTWEybHozekZ6WjlnbkowbjAy?=
 =?utf-8?B?MTFCaThWdTdob2NlSy9DbkVLWFNHSlJHQXFDRFNPYVEyeHkrOUsvYjNIUWgr?=
 =?utf-8?B?OEFsSjVReEUrNEhjb09aajI2elM5VVhrb0M3blN5NUYwN1N3YjJIaVJubUxK?=
 =?utf-8?B?Q2JRbzR4TDFCd01DL2Z6dWVvK0xHbkJ3V3JkdlNWWVIxaytuNkgvQkNwMGVw?=
 =?utf-8?B?dS80Y3Z4RUpET1RtenM1bFl0MHB2MXlpUWRyYkIrRVZmN2l2QT09?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77450efe-f91c-47bf-8b63-08dbd497a2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 13:46:34.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKNWhoPp61m2cLEMjzI0uOLBP7yEhvnIVw3ZJ/CPVU82YgqPQrlFdnuORkzFlOd0K3aqT/8S9sU6dABjMQKaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4548
X-BESS-ID: 1698155197-103218-6356-2905-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.55.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZGFsZAVgZQ0MTSLNXCPDHN0s
	DSxMzAPDUt0SI1xTjR1MjCNNkizcxMqTYWAHt9bGdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251658 [from 
	cloudscan23-174.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMjMvMjMgMjA6MzAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiBQcmV2aW91cyBwYXRj
aCBhbGxvd2VkIGF0b21pYy1vcGVuIG9uIGEgcG9zaXRpdmUgZGVudHJ5IHdoZW4NCj4gT19DUkVB
VCB3YXMgc2V0IChpbiBsb29rdXBfb3BlbikuIFRoaXMgYWRkcyBpbiBhdG9taWMtb3Blbg0KPiB3
aGVuIE9fQ1JFQVQgaXMgbm90IHNldC4NCj4gDQo+IENvZGUgd2lzZSBpdCB3b3VsZCBiZSBwb3Nz
aWJsZSB0byBqdXN0IGRyb3AgdGhlIGRlbnRyeSBpbg0KPiBvcGVuX2xhc3RfbG9va3VwcyBhbmQg
dGhlbiBmYWxsIHRocm91Z2ggdG8gbG9va3VwX29wZW4uDQo+IEJ1dCB0aGVuIHRoaXMgd291bGQg
YWRkIHNvbWUgb3ZlcmhlYWQgZm9yIGRlbnRyeSBkcm9wLA0KPiByZS1sb29rdXAgYW5kIGFjdHVh
bGx5IGFsc28gY2FsbCBpbnRvIGRfcmV2YWxpZGF0ZS4NCj4gU28gYXMgc3VnZ2VzdGVkIGJ5IE1p
a2xvcywgdGhpcyBhZGRzIGEgaGVscGVyIGZ1bmN0aW9uDQo+IChhdG9taWNfcmV2YWxpZGF0ZV9v
cGVuKSB0byBpbW1lZGlhdGVseSBvcGVuIHRoZSBkZW50cnkNCj4gd2l0aCBhdG9taWNfb3Blbi4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4N
Cj4gQ2M6IE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4NCj4gQ2M6IERoYXJtZW5k
cmEgU2luZ2ggPGRzaW5naEBkZG4uY29tPg0KPiBDYzogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVu
ZXJAa2VybmVsLm9yZz4NCj4gQ2M6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
DQo+IENjOiBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gQ2M6IGxpbnV4LWZz
ZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgIGZzL25hbWVpLmMgfCA2NiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9uYW1laS5jIGIvZnMvbmFtZWkuYw0KPiBpbmRleCBmZjkxM2U2YjEyYjQuLjVl
MmQ1NjlmZmUzOCAxMDA2NDQNCj4gLS0tIGEvZnMvbmFtZWkuYw0KPiArKysgYi9mcy9uYW1laS5j
DQo+IEBAIC0xNjE0LDEwICsxNjE0LDExIEBAIHN0cnVjdCBkZW50cnkgKmxvb2t1cF9vbmVfcXN0
cl9leGNsKGNvbnN0IHN0cnVjdCBxc3RyICpuYW1lLA0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9M
KGxvb2t1cF9vbmVfcXN0cl9leGNsKTsNCj4gICANCj4gLXN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICps
b29rdXBfZmFzdChzdHJ1Y3QgbmFtZWlkYXRhICpuZCkNCj4gK3N0YXRpYyBzdHJ1Y3QgZGVudHJ5
ICpsb29rdXBfZmFzdChzdHJ1Y3QgbmFtZWlkYXRhICpuZCwgYm9vbCAqYXRvbWljX3JldmFsaWRh
dGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZGVudHJ5ICpkZW50cnksICpwYXJlbnQgPSBuZC0+cGF0
aC5kZW50cnk7DQo+ICAgCWludCBzdGF0dXMgPSAxOw0KPiArCSphdG9taWNfcmV2YWxpZGF0ZSA9
IGZhbHNlOw0KPiAgIA0KPiAgIAkvKg0KPiAgIAkgKiBSZW5hbWUgc2VxbG9jayBpcyBub3QgcmVx
dWlyZWQgaGVyZSBiZWNhdXNlIGluIHRoZSBvZmYgY2hhbmNlDQo+IEBAIC0xNjU5LDYgKzE2NjAs
MTAgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmxvb2t1cF9mYXN0KHN0cnVjdCBuYW1laWRhdGEg
Km5kKQ0KPiAgIAkJZHB1dChkZW50cnkpOw0KPiAgIAkJcmV0dXJuIEVSUl9QVFIoc3RhdHVzKTsN
Cj4gICAJfQ0KPiArDQo+ICsJaWYgKHN0YXR1cyA9PSBEX1JFVkFMSURBVEVfQVRPTUlDKQ0KPiAr
CQkqYXRvbWljX3JldmFsaWRhdGUgPSB0cnVlOw0KPiArDQo+ICAgCXJldHVybiBkZW50cnk7DQo+
ICAgfQ0KPiAgIA0KPiBAQCAtMTk4NCw2ICsxOTg5LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmhh
bmRsZV9kb3RzKHN0cnVjdCBuYW1laWRhdGEgKm5kLCBpbnQgdHlwZSkNCj4gICBzdGF0aWMgY29u
c3QgY2hhciAqd2Fsa19jb21wb25lbnQoc3RydWN0IG5hbWVpZGF0YSAqbmQsIGludCBmbGFncykN
Cj4gICB7DQo+ICAgCXN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCj4gKwlib29sIGF0b21pY19yZXZh
bGlkYXRlOw0KPiAgIAkvKg0KPiAgIAkgKiAiLiIgYW5kICIuLiIgYXJlIHNwZWNpYWwgLSAiLi4i
IGVzcGVjaWFsbHkgc28gYmVjYXVzZSBpdCBoYXMNCj4gICAJICogdG8gYmUgYWJsZSB0byBrbm93
IGFib3V0IHRoZSBjdXJyZW50IHJvb3QgZGlyZWN0b3J5IGFuZA0KPiBAQCAtMTk5NCw3ICsyMDAw
LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKndhbGtfY29tcG9uZW50KHN0cnVjdCBuYW1laWRhdGEg
Km5kLCBpbnQgZmxhZ3MpDQo+ICAgCQkJcHV0X2xpbmsobmQpOw0KPiAgIAkJcmV0dXJuIGhhbmRs
ZV9kb3RzKG5kLCBuZC0+bGFzdF90eXBlKTsNCj4gICAJfQ0KPiAtCWRlbnRyeSA9IGxvb2t1cF9m
YXN0KG5kKTsNCj4gKwlkZW50cnkgPSBsb29rdXBfZmFzdChuZCwgJmF0b21pY19yZXZhbGlkYXRl
KTsNCj4gICAJaWYgKElTX0VSUihkZW50cnkpKQ0KPiAgIAkJcmV0dXJuIEVSUl9DQVNUKGRlbnRy
eSk7DQo+ICAgCWlmICh1bmxpa2VseSghZGVudHJ5KSkgew0KPiBAQCAtMjAwMiw2ICsyMDA4LDkg
QEAgc3RhdGljIGNvbnN0IGNoYXIgKndhbGtfY29tcG9uZW50KHN0cnVjdCBuYW1laWRhdGEgKm5k
LCBpbnQgZmxhZ3MpDQo+ICAgCQlpZiAoSVNfRVJSKGRlbnRyeSkpDQo+ICAgCQkJcmV0dXJuIEVS
Ul9DQVNUKGRlbnRyeSk7DQo+ICAgCX0NCj4gKw0KPiArCVdBUk5fT05fT05DRShhdG9taWNfcmV2
YWxpZGF0ZSk7DQo+ICsNCj4gICAJaWYgKCEoZmxhZ3MgJiBXQUxLX01PUkUpICYmIG5kLT5kZXB0
aCkNCj4gICAJCXB1dF9saW5rKG5kKTsNCj4gICAJcmV0dXJuIHN0ZXBfaW50byhuZCwgZmxhZ3Ms
IGRlbnRyeSk7DQo+IEBAIC0zMzgzLDYgKzMzOTIsNDIgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkg
KmF0b21pY19vcGVuKHN0cnVjdCBuYW1laWRhdGEgKm5kLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnks
DQo+ICAgCXJldHVybiBkZW50cnk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHN0cnVjdCBkZW50
cnkgKmF0b21pY19yZXZhbGlkYXRlX29wZW4oc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiArCQkJ
CQkgICAgIHN0cnVjdCBuYW1laWRhdGEgKm5kLA0KPiArCQkJCQkgICAgIHN0cnVjdCBmaWxlICpm
aWxlLA0KPiArCQkJCQkgICAgIGNvbnN0IHN0cnVjdCBvcGVuX2ZsYWdzICpvcCwNCj4gKwkJCQkJ
ICAgICBib29sICpnb3Rfd3JpdGUpDQo+ICt7DQo+ICsJc3RydWN0IG1udF9pZG1hcCAqaWRtYXA7
DQoNCkFzIGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQsIGlkbWFwIGlzIHVudXNlZCBpbiB0aGlz
IGZ1bmN0aW9uLg0K

