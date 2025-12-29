Return-Path: <linux-fsdevel+bounces-72208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C52CE81CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4416E3016CDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5B264627;
	Mon, 29 Dec 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p+vs7m8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAC253B59;
	Mon, 29 Dec 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767039195; cv=fail; b=MyUON1vmtFk7Vq4ENy1n130qOUDM9rJb1Qk6n6s5Nqb4ULnECoQaRtFN+9E03OsVXEO6D4aQlD6XOcnkzochd0yX41Nv3PqEtop5ArST5hRno3qesntigd5klxxDFCwOgaxsstPHmqAfdMmF/rD7WBd6oZ2WI1sL0MHc8XpSfuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767039195; c=relaxed/simple;
	bh=7S7qrBbIJZ958qb8mjFRLWRbxzQynM7RuakJAGOdU+Y=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lqA4Boq1aenTLd30YwpKM+ZYRyQlR1XmB1neL+0lM7x3Ci1O/dZJLQWizkIvD2jLAclcmBtPgmRISe79P1nzNrtF2qUxg1MAvczXlUAt/qUriNXYL1mh0j04+U7WbzHB02CJuipymrWN2ajqVIfzxc4m773fTu8M62aFHGx+Qj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p+vs7m8N; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTEGXUE004021;
	Mon, 29 Dec 2025 20:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7S7qrBbIJZ958qb8mjFRLWRbxzQynM7RuakJAGOdU+Y=; b=p+vs7m8N
	TUvBEbTFUAwUDa2uM6YxLkRccuA7cguh38sFN58uNUvCG9gqvq7lqs+b50MHbqUT
	gPvsh+9UIi1ZiVq1qbCHmJIpTWhkop2IwoiCeoPh84t62AoXuc0vO9p3/RQvX/MI
	1aE+EeMa9OqKUCb8y75nBw1a1PauF/FwLryei/iZUNkG+/uvoVvd5gFEmUkfaBW4
	jwrqMtil0EcYZ3DP8K+A0/YAQmIg7lmP8UP7ZKTVilCWx1pLVTdxXtPBb2ESYO7L
	TN3DWPDv4iI6k1XfFrHTOtIeab8HnpPmAEmNotR6ESgAGP7tmuVaLm39tQmL+xet
	pRRe4NpdPg0SjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjr300-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 20:12:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BTKCsg7015006;
	Mon, 29 Dec 2025 20:12:54 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjr2yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 20:12:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9gSvAfI2oktD7zBJsm9jb1txR3TNgxL4AjP1h7o7M2UwAgM2HE5Un4/T1M3JVNCjqkXx/S/rRgZkaRRBSJcAZSjIvvmFBjPsBJGlfZh7v0qIP/k9rH9UBZfy/knY0lVCzu/YIUyyYnTvI3r4WuZCUZgKibwr9s9Fw/g9LOq1SsChs/E2Ri/WcxN2JHr054E5v7HcFjq4y6+N5wRw4xHbl8kEH4QzzTZ28yE3mZPy8fJNCqHa3FRcq3Q48sMZP4dpXOTa222wDzhp6cbTXOkt9UfTpOXda3GRioZaO6xcREjKcoNeNxefDOflhyOMHNFZEb8cLZKc9QqOBLWKdRNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S7qrBbIJZ958qb8mjFRLWRbxzQynM7RuakJAGOdU+Y=;
 b=xkt/YnNM2TEoy/+pHiht9bwPMhKooEFC6J3Lj1kGmjrSfOTv4YNTDQD3XcXdQjppwyLwD2d0uHb2WTjO2cjx+zdKIh95ISQ+X6zib9a9hvM19QQtWRDfOMHj0jLxGaLo69F2u5KIykeZF1o8UYB1d8JQeaRXYPE0frg2yLY8iGdaFYqLkwhWgM7J6jhxhTATlhK832Tv0d97W0TYdApoPgh4tnSNmiajhoiwjYOchnAoXuBzi4jSmcHpdO/hbqzeS/1rlghLoHRKlYtspuYrMkg+i/dGQIdVcxCIy6ruK0+CessHsXPkte5sxRTfGYLckeJi4caA9CaGYEWUUXh9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4424.namprd15.prod.outlook.com (2603:10b6:a03:375::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 20:12:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 20:12:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "zippel@linux-m68k.org" <zippel@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "akpm@osdl.org" <akpm@osdl.org>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] hfsplus: skip node 0 in
 hfs_bmap_alloc
Thread-Index: AQHcdVPG+XF8OQT42kSTihp2oeWu3LUx5egAgAcucwA=
Date: Mon, 29 Dec 2025 20:12:50 +0000
Message-ID: <784415834694f39902088fa8946850fc1779a318.camel@ibm.com>
References: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
		 <20251224151347.1861896-2-shardul.b@mpiricsoftware.com>
		 <63e3ff1595ebd27e9835ae7057204b7eef0c1254.camel@dubeyko.com>
	 <de697a2fbf2464297d5e303a109b0edddddef207.camel@mpiricsoftware.com>
In-Reply-To:
 <de697a2fbf2464297d5e303a109b0edddddef207.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4424:EE_
x-ms-office365-filtering-correlation-id: 0f653b57-4288-48c1-495e-08de4716a4b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzlCL1pzUEEzOCtwOFpxdGJvZFNpaGNoM3RwVlU1L1N2Y3pUTWxjR1VRamZG?=
 =?utf-8?B?REJnb05QNnRIZlZmWUdpc2duN0hCU0xOWmNuZ2hqTU5MaFduOE5mVmk2Z0VZ?=
 =?utf-8?B?MDRlTHFqVTMxVVB1NjNnOFRkMXJGWm92eU5VYmtXS0czdk9acjhMQmY2eEFq?=
 =?utf-8?B?UGY0TmRWWWtnTXFLeFhYcWhscEkvYjB1dktJMnprbHRub3kzbVVCcHYyQ3Vl?=
 =?utf-8?B?UXFkZUV5bmtXRWhoNjV4OUNhZjI0cGtqb3FmZ0EzR1o3Q2RIRmpWSEFPZ2Iz?=
 =?utf-8?B?SzNVWk1xSVNFWGdBaVRwV2R1WVBFTk1rRGMvNlB2UVV6di9MQ2VRazcrak1o?=
 =?utf-8?B?Qk9JOW9CQjYzUG9XMk5mVi9BSXVDbUc5SWp6VU5QQW9FZkVYTzJXUGhsdFQ0?=
 =?utf-8?B?dEtZelcrNzdPN2pyUkNhb1g5V0IxV2ovS3FWRXd3NlhSU3F5azgvK3ljclZt?=
 =?utf-8?B?RlQ5Q3VoRHF2eCs1L3lmVlFJS2VUV0hEODh4eE96RU5qUlk1aUtqYUc1MnhN?=
 =?utf-8?B?SEFMczN0TkZPb21OVWs4eG1IZEhRY05zRnAxekVpSUFkbklKazJ0cjlqdkJE?=
 =?utf-8?B?dUhCeDl5SnZYMThkdS94WG5HUmE3VSttQjNkdXI5cjNjWDczT0FVbGNtWFgw?=
 =?utf-8?B?NzBFOGo3Y01VdjRLNlRyaFhKMTF4Mmx5THFPem9kYU9ZT0o0bzIxVkJXTGZI?=
 =?utf-8?B?bFRSeUpGeDVzbm5wckxkL25yUXZabGpueU1VR3pkbXZ5eThXdDhvZmFUUFNa?=
 =?utf-8?B?MWNvSFc0eHdOOHBubVBBMUpQUFlkNFRoTG1rWkdyZnlwK1g1Q2l6a1phZ2Zr?=
 =?utf-8?B?ZDRkemZWbGgyVjlpSzMxR3ZYdG5OZ0VFSWFtcDhQTDZya3U4QlNMTzNEN2Y1?=
 =?utf-8?B?bjNZdDFUVHRqMnZjY2N1eVdQVStDTWY3SWI1R3BwaUlOV1lpUHFweEpYd2xj?=
 =?utf-8?B?VFdEUmdJTGRYVzRNUytpOVZMUkpNNjNuNzhRL1hpamloajdJdWVBdkJzTmlz?=
 =?utf-8?B?czl3L25salI1NkJlMXhyUXVXWkpVelphWFpCZXZUVGR5cmp2T2wwNnduUWt0?=
 =?utf-8?B?TEpaMkhkVjlYSkV3ZmZSZVB0d1NORWFGQ0tQMlNmSXJCbEV4d1M5Um9STmI2?=
 =?utf-8?B?Z2J0L2lkWGZrY1FQVDEvNEg0eVNFY1VKWGJyem9mM0NzTnBtU0lBVXg5M01x?=
 =?utf-8?B?amRDZWluYUh2a3djbmRLdVJmbVpUdUNFa09rL3VNSVJPOEVXbnFDOHJnS0hL?=
 =?utf-8?B?Zjd5TmMyODA0SXNsOVAzMURQajZCb3NLcVhqREZJS1pKalErUjgwcEY4TW55?=
 =?utf-8?B?cnp5WTF1emlxNDNJUVh0NlhsVmpGUEhlZFJnQWNHQ1BiT1R3SVFPNG1xbjdz?=
 =?utf-8?B?cmpIQTNyc1V4R1BGNmtxSUdNNG9ya0R0THEvR0h6RzNjOHN2WE8rdi9LcDF2?=
 =?utf-8?B?L0h5WkN3UXlPYWxkSytsT2RRend2OHJtanFROGZlNTdBNnFua2dUWFBMV2VV?=
 =?utf-8?B?eXgzd1BMaDFoZE9kK21udWRYUHQ1OXZ4QnVGQy9qRkJzZVcrcWF1SHlOQTNh?=
 =?utf-8?B?OWxlelNXUmF6WFFPekJURGVnYmxUQTQ3OVJSK1NNeVlSejJ1aVdiZ2tJY2d1?=
 =?utf-8?B?Ung3NnkxeGh4VktKSVdIcnBWOTQwRTFYY09pZFJ1U0xpVzJsK0l6SDJWZ2hZ?=
 =?utf-8?B?WU51NlAyY1Vtd3NQWGs0VnhqOUJ3WG4rVmpVc0FwNWZSZnBWQ0JodWUzNHlB?=
 =?utf-8?B?bk15Umh6ZEFVUERFZVdYZFhDSjYzUS9tMFJPbjlQbFlqa1VHTDZnNE91eEtL?=
 =?utf-8?B?cmYwUEJLZmZjUU1GYVhGajExaU03NHc2QnFWUEZJNnc1VUJTcDJrZnBVWGF5?=
 =?utf-8?B?Z1pIR3ZoL3BPYUE4TUllTzFiMkZZRndNNHFmL1JNR0w3YStVZllsQU1qaS9X?=
 =?utf-8?B?Z0xqYjBsR2NacXhJaTMvSTg4ZHVSQkgveWpoSmN2VTlPMCtaLzhLa3VWVlU5?=
 =?utf-8?B?TUF5TDkxQkpKYkM0RDZXbnYyQUQ0TkMyMEdIbE5kTys2Mis5NFc3blNvcTFW?=
 =?utf-8?Q?djTi5z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjlVWVB0clJkNTNudDhiMHRkRU5aUHp1eExBVVZOQlJtaktjckdlUUlHUkFL?=
 =?utf-8?B?eUlPeUhYcW5hb1JEV0ZrNzNET1IyL3RUdVQ3UXlkYWZlZmJiSG42a1VuSWdu?=
 =?utf-8?B?MW43WHJlNkdORjhpL1hMSEE5T000d3hQcXRPMUViSSsyVnB3N2t1dDRUamll?=
 =?utf-8?B?QjRNdEUwZTJ0dThaOW44RUczd3puTmoycStZSXRHZVdHMWViQnNIMVBZREFG?=
 =?utf-8?B?TjJWTy91L2xrMGhYUUQ1SXlhdzhZdmduVTVvcm9XZ2NHYUNrcU9reTQvcnQw?=
 =?utf-8?B?bUZMbHlKeVYzb0l1Qmd3UUNLd3RkemJhUlkzTHpOcWZNajZIK0pQcWFxenl1?=
 =?utf-8?B?THRQajREbHVOL3A2UGQxTEFCOUEzei9yRkdXeEFkWjNwaGxWbWV5YTRYY1N4?=
 =?utf-8?B?RzFVejBQMUZTcXpwRlBsODg3Ny9xekhzbURWa1RSUHFiRFJGeml0MGZNYnBj?=
 =?utf-8?B?Z0xMTmJxV2hERGgwbkpJNzhmUjFjVUR1ZHpvci83dHVWRCtFZFoxZHpNUkQz?=
 =?utf-8?B?ZFhueDZ4amJOZjBEbDlwVTJhTXBJNWpFZUFDMWxXMmpRak1rT2YyYU43aktG?=
 =?utf-8?B?UG5Tb3dpNlNZRUpOa1dTaFJhZDB1YWhuUC9QL3FSWjcyMnZ3YXNISURvQnFw?=
 =?utf-8?B?QnlBUzF5K2xvTWh0ZTg4Njc5b3MrQVExZDBMWXNuSmZLRm5OL3ZFRldXanBw?=
 =?utf-8?B?OTJXVDgwcFNCY2tzdWdweVZ1U3BoeUdoYU1pOE9RczgwbE52b2dzUVAraCtL?=
 =?utf-8?B?d2NabHdaMWpPUG53bkNBZjhZOXkzOHczQVNJN1V6R0t3MldiLzFQdVZLU09G?=
 =?utf-8?B?ejZ1bEVXdnJzOUhicjltNnU4MitJMlpyaVlhYmxGVzZiTDgyc0ZsT3lqMTVH?=
 =?utf-8?B?K1NqU2lJODFQdlZTQUIra0FEK0RUclM1SE9JVWtwbXJBaWJWTGdJczU5WDFa?=
 =?utf-8?B?aDBwenVJQUdYWnNXVWFBcjN6ZlJXU2FzN3UxL3pzWk5zL0xqb01xaFVTbTdZ?=
 =?utf-8?B?dWp0djQ5b2FhcmxtaERyZTJQalF1ai9QajVaT1RBUUczcmhCM1QzdlJqQUlm?=
 =?utf-8?B?amZMdHlaQlc0eVBvV1AyT3RxdDBXVlpteDByQ0hIYXYyMGxnSkt1ZlVyNWp3?=
 =?utf-8?B?NkttdWNMRTFFVEQ4QmxOZWExVEloNkgwZzRES0VPR3JPUzJoT1RKTXlpRXBa?=
 =?utf-8?B?cTFMZEdyZWxxSERGcWd0a2N2ZUxOZ1pEU2Zoems0RFl6blRIZ3BNRlBaNVV4?=
 =?utf-8?B?OUlheW92TEJac2Z3T1pLUjlqZTV5TjFjTFRVeWJQR21OSTRYN3grQzlkbWFD?=
 =?utf-8?B?OGpzSFhlV0hWYWdyeGJIRXN6eTBFUG5OSENSYkNtVDJFYTFNYkxiRUJhZktD?=
 =?utf-8?B?c3BZTm9UdDY5VENmblZvOWlKK21TSzJrL3U1dkthNktHUDRqbmlyWWdkZUNi?=
 =?utf-8?B?dVYwbHhBaytlZTNMQ1ZMZU1XWDc1bU1jTlFXS09KZHVkYjlpbnM0RnByZEt5?=
 =?utf-8?B?dGlsV3d0ampmbCtMWlBYY2huU2ZvS1czZTFBU21ubFI5d0hiZkRPc3k5TmVo?=
 =?utf-8?B?TWxSTzZBb0hNajM1Rlh5U004MmwxV21nU1ZsQlVxODFscUJVL0xVcjljd04r?=
 =?utf-8?B?Y3lkNWtDTlBTNkdCSEVvM1JyblY2Z2c1KzJWODR0dFNFSGkveDVBaDFML3FT?=
 =?utf-8?B?Y2tTZEx2OFdzQ0dRK2EzRVJZbE9YcitxWVJJTW83UStQcG80ZytEYnU0U0Ir?=
 =?utf-8?B?elI0RE5IdWNuR2N5bjlmbXJTWWo4TkhYRFRvNnhzVEorY1kzNnV4Uk5QZkVi?=
 =?utf-8?B?aFZYaVc4UHhpRk5udGVzaldiVkxBTUlVbmZEUmZscDdHQWE3QUxBSGpMZEtI?=
 =?utf-8?B?STMrVDRrU2krTDBYWERSUzNxT0ZqdHVZUmtpd0MwMXhRN3pHQ2hDOEQ1Vzho?=
 =?utf-8?B?TENjUGRHVElJQzFoTytjVnAvSXBFY0hxeVdGRkRzU2h4TTJIeHQ2cWhyQWwx?=
 =?utf-8?B?b2tGMXpDMm9qajBEMzN4K0xUR0ZGd3hyNUR3eXA2alo5MW1RWEdLSUwwN01P?=
 =?utf-8?B?OWs4ZFVzQXQ2S3ZLSlk2UEk2enM3OERxL29NbldUOW05UFZHeVp1d25VQ0NV?=
 =?utf-8?B?VE9nTERhTDRQVkowRjNhWnRmWHdxcGptMkhsbUtRc1RDN0x0c1JQemdVNEVy?=
 =?utf-8?B?SHlNTlRLbGEzVEM3RFdWdS9Md0ZKWWxXOW9qNnpIVFdHdGxmbGRrTklrc0pj?=
 =?utf-8?B?Z1JtYk42bUFsdnIwaG5CL29EU0VqSktaQURTaytDY2RvcStkWENQdUY1VFBO?=
 =?utf-8?B?bzExYVV6eWppY2pySU56RzE0RWNVeE4yNUNFM1pibk82SHZRbFRXSlBHYmg3?=
 =?utf-8?Q?s94ohKa8e1i6zQSDOSFDsaGbyRU1gjL8M4QZK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <033184267924DC4D94E9A13A9BE71146@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f653b57-4288-48c1-495e-08de4716a4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 20:12:51.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQkvm16ZJr0Rc/G5aisZt+4lF8QvTATE8SBWfwfIBK1BB/90PT2/23PTTGl3nRZfwmjD+IDYvNpcZhVUpuNknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4424
X-Authority-Analysis: v=2.4 cv=I7tohdgg c=1 sm=1 tr=0 ts=6952e0c6 cx=c_pps
 a=ikyLliMNhLjillvDIwfXbw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=9tQOdTHS0FL3nxB3OnUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vlfNTgllSp38v25aOj84jawMVat1_eAr
X-Proofpoint-GUID: 3DIzhVUBoPDkrt3FNDIxKap1yhB0MmEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4MSBTYWx0ZWRfX9AKA6jXYz5Yz
 6j2NzxeT62tZbz7s3zudLWDfn1IHcKyrcnr5KLk0fYBh4LbXWOqzn0wLsyDtrMAT+HnpEe3cx/e
 8DStYrKLZKLsaqT1du0WZy9PT1uL4CnzxuoUHlnufhnEQ1sILGEDiylhYM0nZGa9uyhI7Bc0lqH
 E/2ZnOl85ZMj/CuxJg+UdkexaGlpkvlOeqIXJPPrynaEaB9qhuJgFkDWev0UXIs1s6CbMoPPPeK
 +G579jBgy+mR5OgrIhVgtLc1esxGGR431wZEE6JZQQdM0nHIUgkTNLUuFU/IPQdaLJofoR9FDA3
 dOI1nOV0ebps/vdUsb1rFgkd7DC9bzkbz319hIDwe8pGAJfzW4z7AkBV8ijDQxx6zKMP1VDumhb
 EaGaGKYUN5tg02vq4A/78sDALYth7gnP/yhVTyZFXdTACY8295PykFo+O4Zgipa4QQ3TJicjlWN
 1gmz+DC8mzlBWZP1gYw==
Subject: RE: [PATCH v2 1/2] hfsplus: skip node 0 in hfs_bmap_alloc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512290181

T24gVGh1LCAyMDI1LTEyLTI1IGF0IDEyOjAyICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gV2VkLCAyMDI1LTEyLTI0IGF0IDIwOjAyIC0wODAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gDQo+ID4gSSB0aGluayB0aGF0IGl0J3Mgbm90IGNvbXBsZXRlbHkgY29ycmVj
dCBmaXguIEZpcnN0IG9mIGFsbCwgd2UgaGF2ZQ0KPiA+IGJpdG1hcCBjb3JydXB0aW9uLiBJdCBt
ZWFucyB0aGF0IHdlIG5lZWQgdG8gY29tcGxhaW4gYWJvdXQgaXQgYW5kDQo+ID4gcmV0dXJuIGVy
cm9yIGNvZGUuIExvZ2ljIGNhbm5vdCBjb250aW51ZSB0byB3b3JrIG5vcm1hbGx5IGJlY2F1c2Ug
d2UNCj4gPiBjYW5ub3QgcmVseSBvbiBiaXRtYXAgYW55bW9yZS4gSXQgY291bGQgY29udGFpbiBt
dWx0aXBsZSBjb3JydXB0ZWQNCj4gPiBiaXRzLg0KPiA+IA0KPiA+IFRlY2huaWNhbGx5IHNwZWFr
aW5nLCB3ZSBuZWVkIHRvIGNoZWNrIHRoYXQgYml0bWFwIGlzIGNvcnJ1cHRlZCB3aGVuDQo+ID4g
d2UNCj4gPiBjcmVhdGUgYi10cmVlcyBkdXJpbmcgbW91bnQgb3BlcmF0aW9uICh3ZSBjYW4gZGVm
aW5lIGl0IGZvciBub2RlIDANCj4gPiBidXQNCj4gPiBpdCBjb3VsZCBiZSB0cmlja3kgZm9yIG90
aGVyIG5vZGVzKS4gSWYgd2UgaGF2ZSBkZXRlY3RlZCB0aGUNCj4gPiBjb3JydXB0aW9uLCB0aGVu
IHdlIGNhbiByZWNvbW1lbmQgdG8gcnVuIEZTQ0sgdG9vbCBhbmQgd2UgY2FuIG1vdW50DQo+ID4g
aW4NCj4gPiBSRUFELU9OTFkgbW9kZS4NCj4gPiANCj4gPiBJIHRoaW5rIHdlIGNhbiBjaGVjayB0
aGUgYml0bWFwIHdoZW4gd2UgYXJlIHRyeWluZyB0byBvcGVuL2NyZWF0ZSBub3QNCj4gPiBhDQo+
ID4gbmV3IG5vZGUgYnV0IGFscmVhZHkgZXhpc3RpbmcgaW4gdGhlIHRyZWUuIEkgbWVhbiBpZiB3
ZSBtb3VudGVkIHRoZQ0KPiA+IHZvbHVtZSB0aGlzIGItdHJlZSBjb250YWluaW5nIHNldmVyYWwg
bm9kZXMgb24gdGhlIHZvbHVtZSwgd2UgY2FuDQo+ID4gY2hlY2sNCj4gPiB0aGF0IGJpdG1hcCBj
b250YWlucyB0aGUgc2V0IGJpdCBmb3IgdGhlc2Ugbm9kZXMuIEFuZCBpZiB0aGUgYml0IGlzDQo+
ID4gbm90DQo+ID4gdGhlcmUsIHRoZW4gaXQncyBjbGVhciBzaWduIG9mIGJpdG1hcCBjb3JydXB0
aW9uLiBDdXJyZW50bHksIEkNCj4gPiBoYXZlbid0DQo+ID4gaWRlYSBob3cgdG8gY2hlY2sgY29y
cnVwdGVkIGJpdHMgdGhhdCBzaG93aW5nIHByZXNlbmNlIG9mIG5vdA0KPiA+IGV4aXN0aW5nDQo+
ID4gbm9kZXMgaW4gdGhlIGItdHJlZS4gQnV0IEkgc3VwcG9zZSB0aGF0IHdlIGNhbiBkbyBzb21l
IGNoZWNrIGluDQo+ID4gZHJpdmVyJ3MgbG9naWMuIEZpbmFsbHksIGlmIHdlIGRldGVjdGVkIGNv
cnJ1cHRpb24sIHRoZW4gd2Ugc2hvdWxkDQo+ID4gY29tcGxhaW4gYWJvdXQgdGhlIGNvcnJ1cHRp
b24uIElkZWFsbHksIGl0IHdpbGwgYmUgZ29vZCB0byByZW1vdW50IGluDQo+ID4gUkVBRC1PTkxZ
IG1vZGUuDQo+ID4gDQo+ID4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIHlvdT8NCj4gPiANCj4gSGkg
U2xhdmEsDQo+IA0KPiBZZXMsIHRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiBTa2lwcGluZyBub2Rl
IDAgaW5kZWVkIGxvb2tzIGxpa2Ugb25seSBhIGxvY2FsIHdvcmthcm91bmQ6IGlmIHRoZQ0KPiBi
aXRtYXAgaXMgYWxyZWFkeSBpbmNvbnNpc3RlbnQsIHdlIHNob3VsZG7igJl0IHByb2NlZWQgYXMg
aWYgaXQgaXMNCj4gdHJ1c3R3b3J0aHkgZm9yIGZ1cnRoZXIgYWxsb2NhdGlvbnMsIGJlY2F1c2Ug
b3RoZXIgYml0cyBjb3VsZCBiZSB3cm9uZw0KPiBhcyB3ZWxsLg0KPiANCj4gRm9yIHRoZSBuZXh0
IHJldmlzaW9uIEkgcGxhbiB0byByZXBsYWNlIHRoZSDigJxza2lwIG5vZGUgMOKAnSBndWFyZCB3
aXRoIGENCj4gYml0bWFwIHNhbml0eSBjaGVjayBkdXJpbmcgYnRyZWUgb3Blbi9tb3VudC4gQXQg
bWluaW11bSwgSSB3aWxsIHZlcmlmeQ0KPiB0aGF0IHRoZSBoZWFkZXIgbm9kZSAobm9kZSAwKSBp
cyBtYXJrZWQgYWxsb2NhdGVkLCBhbmQgSSB3aWxsIGFsc28NCj4gaW52ZXN0aWdhdGUgd2hldGhl
ciBvdGhlciBleGlzdGluZyBub2RlcyBjYW4gYmUgdmFsaWRhdGVkIGFzIHdlbGwuIElmDQo+IGNv
cnJ1cHRpb24gaXMgZGV0ZWN0ZWQsIHRoZSBkcml2ZXIgd2lsbCByZXBvcnQgaXQgYW5kIGZvcmNl
IGEgcmVhZC1vbmx5DQo+IG1vdW50LCBhbG9uZyB3aXRoIGEgcmVjb21tZW5kYXRpb24gdG8gcnVu
IGZzY2suaGZzcGx1cy4gVGhpcyBhdm9pZHMNCj4gY29udGludWluZyBSVyBvcGVyYXRpb24gd2l0
aCBhIGtub3duLWJhZCBhbGxvY2F0b3Igc3RhdGUuDQo+IA0KPiBJbiBwYXJhbGxlbCwgSSBwbGFu
IHRvIGtlZXAgdGhlIC1FRVhJU1QgY2hhbmdlIGluIGhmc19ibm9kZV9jcmVhdGUoKSBhcw0KPiBh
IHJvYnVzdG5lc3MgZml4IGZvciBhbnkgcmVtYWluaW5nIG9yIGZ1dHVyZSBpbmNvbnNpc3RlbmN5
IHBhdGhzLg0KPiANCj4gSeKAmWxsIHBvc3QgYSByZXNwaW4gc2hvcnRseS4NCg0KU291bmRzIGdv
b2QuDQoNCj4gDQo+IElmIHlvdeKAmXJlIE9LIHdpdGggaXQsIEkgY2FuIGFsc28gcG9zdCB0aGUg
aGZzX2Jub2RlX2NyZWF0ZSgpIC1FRVhJU1QNCj4gY2hhbmdlIGFzIGEgc3RhbmRhbG9uZSBmaXgs
IHNpbmNlIGl0IGluZGVwZW5kZW50bHkgcHJldmVudHMgYSByZWZjb3VudA0KPiB1bmRlcmZsb3cg
YW5kIHBhbmljIGV2ZW4gb3V0c2lkZSB0aGUgYml0bWFwLWNvcnJ1cHRpb24gc2NlbmFyaW8uIEni
gJlsbA0KPiBjb250aW51ZSB3b3JraW5nIG9uIHRoZSBiaXRtYXAgdmFsaWRhdGlvbiBpbiBwYXJh
bGxlbC4NCj4gDQoNClllcywgd2UgY2FuIGRvIGl0IGluIHRoaXMgd2F5LiBNYWtlcyBzZW5zZSB0
byBtZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

