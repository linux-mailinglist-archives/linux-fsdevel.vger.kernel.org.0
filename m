Return-Path: <linux-fsdevel+bounces-41747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC96EA36642
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F4516CA95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D771ACED1;
	Fri, 14 Feb 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQjsl1kS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535719644B;
	Fri, 14 Feb 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561927; cv=fail; b=DLJNjkkumc8fMUUW3mw58Xld2NOWLmP0nEtr/D7L76CmQFXqkE5aFHqAVnmQ8zepv1kWCLxOIxP6hp0qsxoiZqJ4e8qma5NkFqH+fAer5UIJQAV6CDdg5MGgBURw9jF1bopMP6ur1QufdJf3m5M6sDBYyEr4mD89PLDvvBYQgqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561927; c=relaxed/simple;
	bh=INXvGJtRRFWTtQQGjjdKWuMEFz/grfTMkQ3NHx8xQ8A=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OQHQjS4661z90QQ4sMry1VGlwodMT/8l30r39cSzbQdvtlUr6ZtBz3AM28Oni81A6bHPP1vy1xIMkCtZ6VKRHA0QXMq9wWUc1l7WnoHDdHW1V04XdnGGqpcJhPIkMcZPwjyr3NFEVjLwB0R/43ij40PsGUDlF94ymdZPLjph+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQjsl1kS; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtoqR013132;
	Fri, 14 Feb 2025 19:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=INXvGJtRRFWTtQQGjjdKWuMEFz/grfTMkQ3NHx8xQ8A=; b=dQjsl1kS
	1Hyj63pGv/Nnrx0dXN8eSG9jCdiMDz24zFZb0Znq5vb03jg5Q/Op3GD5fNnc5dAt
	d5fFs1lU6mqdH3k0y+J81ERy7yZ/JcevxrqZgbqeg7ZuHeI1RIoQyINdXVoAuwO0
	FZXSFsjhfLGtQ23AU14t0DQ3mQff7vXwoIxDzZ9fkVNywISZNLD1y5hCjJOfJ579
	9/1sNcK7Wh3Oc7Dn9hfWqeuMHGVBy8hpmsCUQcphJ/HmHafxGHcIO1OZodGgvS4x
	R6x3NQ6F1SKpyDkDo9YzHh8lN5rhXdAtxtb7KeoWzWih6efO0HOuij7OKceMQdPA
	9lAtFbRjbpomJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp0cn6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:38:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EJZcFR000571;
	Fri, 14 Feb 2025 19:38:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp0cn69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 19:38:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3yGnGG+pr9Nf/JttC9LgVnBjhMbooV7AkwlN2ZMB8nQRu1vKFlIJeqsRx+TSuZIQrsHIjWnO22yaag2+PFCxZYr5SuxwUSohG5czynAW4LHfCQD+8gAlJmqZsaBQJSJXKjZtkMPP1ar2lCuGt85M9W/ZyH4KbbtgyhI0f8Mqe42Vl+FO93n+CIhLMZnmL0WRGqJHjMForyTXHNvknAFG6WfpQCxlEyN5rFK/6cbRwBC41wRwquyDS1+Ctkn3hB++6aUNbm7VuZd6ZLD4RR59MPh4QBS26qWqUDhjcSWfSEwiO9bHm/QICpTNL/JyC3vcRjWpENjBFXxT0LEhb2qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INXvGJtRRFWTtQQGjjdKWuMEFz/grfTMkQ3NHx8xQ8A=;
 b=C3n3T1Kn2v7EbnL0oVYHk+t9PdVHE8Yb4cpnEaCNpydimyAp2cIat/h/Oir1J8X3Rixb8m+hJGdLnB7HjrMZx99zmPqxLT6me3xceo5rU7IFg2KayD6aJdDFHVRAf/HLdPnx8fWtCqDBsm6cxibpEXeTOQm3sVUDxWgp/XmlZa6QhPF0zYGjvW4ElkfvrCSEhoUMxJdJMxdp4sQPyRL2z4hTDX1jqUyeI2SS3GA48hpwo4XnJ64/9KWlQtFs+czzauCEVcYh3ed8tR3HAzDXxhlwfvTrBU3WNbWpAB2zB+QsC6zNyVJ4eLkhpXYh/e+n2U6l1npgMDqdiDrmSlG2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5736.namprd15.prod.outlook.com (2603:10b6:510:28c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:38:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 19:38:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 5/7] ceph: Convert
 ceph_readdir_cache_control to store a folio
Thread-Index: AQHbfxeGMyDWFT0hoEykUrYFtclw9rNHMeQA
Date: Fri, 14 Feb 2025 19:38:36 +0000
Message-ID: <534604620a32f0416d89d1e613263326e9631d23.camel@ibm.com>
References: <20250214155710.2790505-1-willy@infradead.org>
	 <20250214155710.2790505-6-willy@infradead.org>
	 <da997962ce076d3962948d5404f51074a6829bf8.camel@ibm.com>
	 <Z6-a2Qml3Bb8azaG@casper.infradead.org>
In-Reply-To: <Z6-a2Qml3Bb8azaG@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5736:EE_
x-ms-office365-filtering-correlation-id: 163a934f-42f7-4ac1-c251-08dd4d2f2cfe
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDJXQTNzZmtLcFQ0ekhwK2VMWFNyNkQ4VHlTY2FveHdOR3dWRFIzMWZhcjgr?=
 =?utf-8?B?SDAzT3A0b2lHNkRkRm8yYXZDN2hJalZISmNHUUtkajR6S1N1QWdWTWNJZkcw?=
 =?utf-8?B?RzZFK2IzRUNtQVk1SllER2hUeUNhUXhSNkZ1YTd1bEpiUmowOWZlYU8xYW1P?=
 =?utf-8?B?V1RqUSszTkZwdWlIdlQzWU5NQXU4L3pHRWFVblVkK2E0bGVrVSs1Y3JkL1Ja?=
 =?utf-8?B?aGQrWDZUNW9WR29YOWdDM1NXR0gwWmRpS2gxQm5CSCtZVTBya3VwMm9zOEla?=
 =?utf-8?B?S3FlODNVcjRVL3RoTk04MXJtYWYzUWpDSkx6aUhGckFoZDk0K21UYkxGc1ZV?=
 =?utf-8?B?Vk5RNGNwK1ZYcjAvQVkzOTdYSENUYXJFb21GNDk4NFZ4MS9hakkrVFFFRk9M?=
 =?utf-8?B?NlFUMnhSOE5QUjdQeHBFYTBqWVBxeS9qM2ZqdWdCekd2YndlOW1QdmhuSW8z?=
 =?utf-8?B?OVRhYU5WcEtjZTlKRTVyWnA0eWJrNFRiVHRhQXZzWVpOTks3UisxQXY1bEhj?=
 =?utf-8?B?eXRPM1Q3Y2xRbGVKaGQ2R042UjdLeFNQRUFrczNWblE2SG9BRGlZbmhFdy9m?=
 =?utf-8?B?aGYxT1RNZkt0YkR6RCtHVFlzTnphWHo4MkQ4M1NiMzRIb2I2ZHFUU01oVFgz?=
 =?utf-8?B?Z2JyTFlibFNVKzM0bWNDem5KbkV2V2NwTTYwUG1wLzFJZE5MUnA5MUdUaHNW?=
 =?utf-8?B?ZkNwQnBkZ3JLc21uRC9UdURDcGFjQnlUZndKeVZnNWt4S2lWNE5mS1NiYnZn?=
 =?utf-8?B?R2VLSG4yazA2UzRoSFRTMXk4QytXd2crWkxicWoxcjJYSWZVWldNS3BITlh5?=
 =?utf-8?B?bmZuMWh0SzYxZVZTZGVJUWdVN0luc2daWEI3NllsdHhpYjgzWmxwSEg1RXBE?=
 =?utf-8?B?MHRKRWlZVWFjUkJ2Q2JGV3RaRWJVaTZwczlqR1BkZGtCT29pK3l2bEVuSTIw?=
 =?utf-8?B?cXdFUU1JR3RuV1pvNklPNThMR1lEbkF6NG5ZNERydjV2eCs4aGRweGxFMnZl?=
 =?utf-8?B?d3RNRjB1S2p1ZExOYzhiSXlPMXZUL3dSdVByRUdLblg2UGcwSEt4eTh0dG0z?=
 =?utf-8?B?VTlTcllHazYwMHY1SzFianI0Y1FBNEF0VUl4SkY1clZBTFZ2N25OeDhhb3Mz?=
 =?utf-8?B?ZGpBRWlZNEx1OUxXbTg2SnRQUytaK2pBY2dVdHIxK3FMTTZCYkN0L3B4OXEr?=
 =?utf-8?B?RGRzWjVsQTlWY3RSY3RKc3pwd3BLOUNGSTY3cFJhbzZyeUxjZzRXNmFyQTVZ?=
 =?utf-8?B?NUx5N1hwWXBpOGt3d1lwMEcyU2V4TnNoQWV4TkpVMGZ0Q2RtSHh3Z3RVN0dW?=
 =?utf-8?B?c2kvUk5NUzFqQ2FOeXJ1YnBZUks1MFZiYVVyV1BSRHJ5OEF2QWNpNW1IamEv?=
 =?utf-8?B?MFViMlRkOWNqWEFFY2RPRzZ4VkdLWlBDSXpmY0RJbkNBcWF5aHA5NFlvWHVz?=
 =?utf-8?B?SU9Xa3lzbkVzUzY0cG1OWGdDQnMxdmgxRjNsRkNFbGNEU3JDSFVML3pwTDR4?=
 =?utf-8?B?MGp3SDEwMDhJbVNNNmF4U3pWYU5rb0twOFgyalFTTWRhWTUwNlpuS0J3eDJn?=
 =?utf-8?B?TkkxeW1vSkEvZ0x3RzZZS2hSNVNCMHJsR3p6SVhxU0piSDJkTkNKTVZRK2pW?=
 =?utf-8?B?ZS9uYnJuUmhuSm9PNWowS1dLSnFBOFBwNmRFQmdRMzN3Tkg1dWQ2TW5iZSs2?=
 =?utf-8?B?M3lmZk5pUzlLblYrR2xmejk3ODV5dTFBeS9KZ1licFpxbkVlVzh3NkRrQXRM?=
 =?utf-8?B?V25XYnVXQmdjaFl6NXNDRnJzU01Lem1UYXNtaXlhYTRFSndIMGpvc3l2eXIw?=
 =?utf-8?B?bHRBOFVUT3BaaWpBeVBHenBxcFB0TmVBVExwYWpHT1U0eG5yeEh3UnIrVEZn?=
 =?utf-8?B?djFDY1JBcUpyWnF4NW1PWThKRmZ5WWd5bFZncFhxSnBVa29CdUtpNFNuOTMx?=
 =?utf-8?Q?AB0WKwWmF37wRXooAJFa8mly6USsGO7H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUJRU1J3N0NjQVZBUFRoZlEydTN1Z0RaNE9JYTV4TVVMZHJ6UFJ2V29rRnJa?=
 =?utf-8?B?RVhYMlVZOHBkV1hxSUEzNVkxV2FzRGJkM3RpT0JGT1BmejN4K0hDZnBTRldD?=
 =?utf-8?B?ZGJUVGdQY0FzQ3FEakpubGQ2VWxBR09XUG1TZjV0VHlGZFUwdlE0cjFleTVy?=
 =?utf-8?B?bjBpcFpRTk1teC8yM0RJSGt5amNkVEE5VmRYRjlrTWtwT1AyREhkU1M3MFFK?=
 =?utf-8?B?aXFmMTRTR2dCRHBnMlJyYldTTUd2R1lqRFJrS2NGWHFZQTMvQWhLdWo4Kzkv?=
 =?utf-8?B?UFVFQVZqVFZDdlZUSHpKVmR6YnVuaGhST2hMSFhtQ3JoYUZXR0pxSUoxVzFn?=
 =?utf-8?B?MDlOV09GVmpSVndLeVN3aUNjRHZabGxVQk9DNnFEUlRNWktLNVlLTHFwa3R0?=
 =?utf-8?B?TTFvRXhuZXROM2FyTVhpamlXNS9zSkdaVXdFVVZFWlFTUjhieXp1Wk45bHFm?=
 =?utf-8?B?TC9lWCs2ZHF0RndRM3pNdDJGTTU2dThQczlOK2VjUEhwM3gwbXJaaGh3UDhZ?=
 =?utf-8?B?QU5HKzZ1eHBwTlhwd3JQOUpBNmVXY29qZFF2bVRkbXBFR1ZYbWhzbFBqbm9S?=
 =?utf-8?B?V0NZdDVZNW5kblZMc0JXSkNMWnN0Q3ZXQTcwV00rK0U0ODUxMjU4YUwwNjJ1?=
 =?utf-8?B?eUdxT1dRcmZhdC9uNmdVbmR5b1YxVTlqKysvKys1N2FKVFIvNFVzT21tc1Jz?=
 =?utf-8?B?OGtWcjBaRzBLNEFOSWg5K2VwdmdVaEh2OXVkTkNPazIwMmRRUEVFOHdpZ1pG?=
 =?utf-8?B?RGRWOFdxcDNzMzl1eWpmZzNobTdTSEc4SjhtdWtlVnJpR1hTWFBBUlI0Vkgx?=
 =?utf-8?B?UFhlcWZZVGlLRFExREJzV0lqaTBYamVEdXNqazNFSzFUZmI0MFBFTFIzZlF1?=
 =?utf-8?B?UnZtZFNGOWh1ZGY1bi9ZbnBuM0VORmNhMnZvUHRPL2VTZk5xWmJRQnlvQkc2?=
 =?utf-8?B?ZU9NUzB3KzJoc3FkL29qVFlWOTUrL2VGb25xbzI2aXQ1Z0NmbTU3S2VoUmZC?=
 =?utf-8?B?bG9ZOTNHRThYYUNYSUxaczF2eEdGMi9WVGtJNDhFQ3IzUzJVbVMvZEpFcXNL?=
 =?utf-8?B?L25weHUrTVZBMDZ6bWh4ZFJMQjhzdE8yWjBrS0VVb3FxZi9pWENDeHp6MkxH?=
 =?utf-8?B?amEyMzBITWZUSUVaa01CQWpacndTM1IvaGhsa0tTR3o3NjhHN1N4Tm0wb0M5?=
 =?utf-8?B?NVpFamNRNHVMdkYzT2Y4ZXNxUXlsZEtYT1p2cEVLUTJkaDhOalZkbFpaVUJu?=
 =?utf-8?B?NzU2cm82K1lJSy9mYUZ0RjFHampOYU44aDBuT0RkY2g1TUJaajFNeCtNZUZI?=
 =?utf-8?B?SFZORjhaSVlLMXNMNlZJeXBzMEpUMmNjNFdHTEZsbUFtaXJsem5DYVk5M09G?=
 =?utf-8?B?SE9uZkdLTzBlaFd1NGtYTXM1aFBONGd0a21rUjgxc0sySFFDQlllVkdOOUd6?=
 =?utf-8?B?ejM3U0NDem10aUxad29JRWovVjZKbU1sOEN4VmoxRDlpREpwZjJCczBESFR3?=
 =?utf-8?B?c1pnV0ZSZ3FBTndGM0xyUDM3KzRyYzNJNEg0Rlp4VUJxbjBlaDlyZlc0Nzds?=
 =?utf-8?B?UDd5RFBNQWY0b2ZQZFN0WlExdTY5RlJLb3V4RnlZQVJSclJhMCtRbDZiR3Av?=
 =?utf-8?B?aGpCcGxTYnlnQU1FZStzYWd5UWNYeTRBWHA1TEt6dTNvdjVEUVNlVitucUF4?=
 =?utf-8?B?SmNCcWRjZ2VmTXQzQjluMlZWQlR1WHFmaUNLYkRkNVdLdjBwZloyODU2dVNZ?=
 =?utf-8?B?azZGNVphazVZSTVwbk4yUnpzQU9KdVNWOU9WVHNLa094Tm5SOXhrQUpxRUtn?=
 =?utf-8?B?MGdvRm5zNU1sa2ZDSG1yVFNCc3ZQbUlZVGd0bmZiV0FRZU94M0t2WFhZOTVl?=
 =?utf-8?B?TUFLOUdBeFFFeGpWT0d2ejhyK1ZYdW55c0pwRzVqSFd6NGhyV243UUZtNjA2?=
 =?utf-8?B?MkRVeUw1R2ZneTBnY01Ccy9HcGhrRDJqSW83eTBBcXNGaXJoMmpBV0o4bFVl?=
 =?utf-8?B?YmNKMFF4S0ZsdWtxR3JJQnZXVW1rY2dpZ2hjcFZnRVpUWXN3OENxUjJKOFZW?=
 =?utf-8?B?N21oYXhaN3A1ZkpNV0ZVZE83eWFUY1c1QUlaRDZhcmRadjNyVVpIMStkdkZ0?=
 =?utf-8?B?QzR4ZHNVQTZuU1k5UXBDL2VJRngvUDdmVDRYVVU2K2c2MWNYM2NrU1dsNjlI?=
 =?utf-8?Q?bB3E+dXxvouEtrJBMs1bc6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <920515F39A6F324B8AE66CE2C275DCA8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163a934f-42f7-4ac1-c251-08dd4d2f2cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 19:38:36.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XarFeVr4GgP3xkZB7edqgBQO4cVSu5CqoetANTX09su+Ry9hc29Xr3gwJeFeo1Df6GkGv8Q9dA8gZzDRMmKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5736
X-Proofpoint-ORIG-GUID: NgRK1esFkst0Y8nfHeNNEqh22Gj7qL1z
X-Proofpoint-GUID: 3ZJ5VywqnNZPGg9rBYMhg5b-380cfVeL
Subject: RE: [PATCH v2 5/7] ceph: Convert ceph_readdir_cache_control to store a
 folio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=972 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140134

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDE5OjM0ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gRnJpLCBGZWIgMTQsIDIwMjUgYXQgMDc6MTA6MjZQTSArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+ID4gLQkJY2FjaGVfY3RsLT5wYWdlID0gZmluZF9sb2NrX3BhZ2Uo
JmRpci0+aV9kYXRhLCBwdHJfcGdvZmYpOw0KPiA+ID4gLQkJaWYgKCFjYWNoZV9jdGwtPnBhZ2Up
IHsNCj4gPiA+ICsJCWNhY2hlX2N0bC0+Zm9saW8gPSBmaWxlbWFwX2xvY2tfZm9saW8oJmRpci0+
aV9kYXRhLCBwdHJfcGdvZmYpOw0KPiA+ID4gKwkJaWYgKElTX0VSUihjYWNoZV9jdGwtPmZvbGlv
KSkgew0KPiA+ID4gKwkJCWNhY2hlX2N0bC0+Zm9saW8gPSBOVUxMOw0KPiA+ID4gIAkJCWRvdXRj
KGNsLCAiIHBhZ2UgJWx1IG5vdCBmb3VuZFxuIiwgcHRyX3Bnb2ZmKTsNCj4gPiANCj4gPiBNYXli
ZSwgd2UgbmVlZCB0byBjaGFuZ2UgZGVidWcgb3V0cHV0IGhlcmUgdG9vPw0KPiA+IA0KPiA+IGRv
dXRjKGNsLCAiIGZvbGlvICVsdSBub3QgZm91bmRcbiIsIHB0cl9wZ29mZik7DQo+IA0KPiBJJ20g
aGFwcHkgdG8gbWFrZSB0aGF0IGNoYW5nZSBmb3IgdGhlIG5leHQgdmVyc2lvbiwgb3IgZm9yIHNv
bWVib2R5IHRvDQo+IG1ha2UgdGhhdCBjaGFuZ2Ugd2hpbGUgYXBwbHlpbmcgdGhlIHBhdGNoZXMu
DQoNCkl0J3Mgbm90IGNyaXRpY2FsIG9uZS4gVGhlIHBhdGNoIGxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhh
bmtzLA0KU2xhdmEuDQoNCg==

