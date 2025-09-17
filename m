Return-Path: <linux-fsdevel+bounces-62005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7068BB81A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC8362044F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249C30CB58;
	Wed, 17 Sep 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c6pUSN+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F68309F02;
	Wed, 17 Sep 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137593; cv=fail; b=nyE1t9k+1XTow4QlStt16/0Gv05/Ga5fwii9A+UJqwsArKLLrwYFFiYZKWbjvZr3HF7QANUvJ10kGi8zo07Dp+3rpcfePP9TyeI7xzkD0LdbAxqnGSnV+PaLnBWOK6m6MeFE4RNzMeoB+/cJKJ3RYrotFSp1pDt69xTeX1KbVRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137593; c=relaxed/simple;
	bh=sU6rAepTYrYa5MXB6nCL2fXMc1D7/+jGVpr57uAoC0g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GqP14BlwJCqgZuNIkYBmt9/ch+aqS74CraLE2DxfPhZgHN1kMKOXzO++gfk5Les80ut1m8FptQDeilQ0o8fZcbg+3z8ziWopdAKTxqLCubTt4VoVl9TOTuaAEpdRqrdFHqethZsvdMNHa885Y0NZajGH84y8l78SmfU8nEPhu6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c6pUSN+X; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HILpIU023772;
	Wed, 17 Sep 2025 19:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sU6rAepTYrYa5MXB6nCL2fXMc1D7/+jGVpr57uAoC0g=; b=c6pUSN+X
	sW5Vmpp0QbFgUsTVZ3sQLh5h/2go/mINJ+YGAY3uZPpdAnTIUWqjRlTAwZdmp6wb
	WlsOxtEXByP3SPanc4C64bNJJC7xLWjFeIvirc4uYezvDLaoQyP0AECtgMVReh/w
	/V1tVA/MVwjIo777q+rmwTtR5v5xTppZUdH1X2PM0dM38xntRSIsVrqnAPVTKe7j
	PifM+17WS3v2CjxAEX2Yxj2lCpPkyny4oc+/CduwFQ4NIdIukhFkYZR2Y9c+j1Rp
	hlyMT0XniY/gGq0YGb7qCBO5I63pPzrAoeJelB+RNcrlgCixcbhcFw5a9e39IhUh
	AZeS9rrPVMcZUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qnkja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 19:33:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HJRxLQ010241;
	Wed, 17 Sep 2025 19:33:05 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qnkj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 19:33:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siNSObfRNsS2/XBMddDEmC+7mHcH03q6d2A68wpfMvzmba0LN1CPMM5fSzih13YeXDZUhQyMxyBEP+1JqDfpaLxqm4gOeU/OFoM9cDbmOJ6ViwejAbLkT8fe1ufQ0ad2OEs9BHEMagHZDtjzNAcWkzpPNceL47zQ+CrHzvDfjisjFS5cl3DL9y1F0sr3ZlclrTuiP3vKJvgABJ8PN97QHoZehuiolNTOXPUPGj+87B23B/e1hRhRM6l4YTQCaS+VUVM9MBjV0ES/08bB1miesdJXi8CTYyQeT0rZH12VdnRbGicjNGE30bAVFFHYcQrH0X2AHQmQc0I8KpoK2EFDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU6rAepTYrYa5MXB6nCL2fXMc1D7/+jGVpr57uAoC0g=;
 b=xO+od01VQ+OdVuA/gqNtU4WM5E5VZb6kSODqRlyuRmEqqwhfBJi96dXE/LA8BH7yj8CQZKgPsMa+07xy2oBiV7FwXh6rLvM1oguA9G12dSkvQDgwsJKz/o3YJs2G2F6jmVvJH4da3ReHUdH1doXmFTFYgSfNHGsXxArsaZG5iTdn6+QeetE4N0ImRMtIHDFKnK9EJlDBXxQynYVYxyMH3apFexInl/KaxoF55wt3zVd1y1SnVn8/ueRFsZR+9aCv6pLzZu/hOWCjioN0qnxWnN2eS6PoOd4a/PDc4UJBddBbxjG6WKmI2bMn5bCgu77qgwYl8ko+Z0xzwJhW4Qzv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4389.namprd15.prod.outlook.com (2603:10b6:a03:35a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:33:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 19:33:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netfs@lists.linux.dev"
	<netfs@lists.linux.dev>,
        Alex Markuze <amarkuze@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix deadlock bugs by making
 iput() calls asynchronous
Thread-Index: AQHcKAY0W320v/BEJ0iP4JgktOT1tLSXwBIAgAABoQCAAAIDAA==
Date: Wed, 17 Sep 2025 19:33:02 +0000
Message-ID: <f309b34e4ffb72d725bc8757434893600d4f1101.camel@ibm.com>
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
	 <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
	 <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
	 <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
	 <CAKPOu+8b_xOicarviAw_39b2y5ei9boRFNxxkP19zE5LGZxm=Q@mail.gmail.com>
In-Reply-To:
 <CAKPOu+8b_xOicarviAw_39b2y5ei9boRFNxxkP19zE5LGZxm=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4389:EE_
x-ms-office365-filtering-correlation-id: 4b76ffa5-1252-4879-c481-08ddf6210472
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFRNbEF3VmMvZ202OFQ1UGl3YTQ2TEY1QXFhZ0JJRG9FRm1mRk96MjN0SGxn?=
 =?utf-8?B?L21nU255aDlMbnpZdVlHSXdUVEJPTEJ6Tkd3d0V0OWprbEs4c05zci82YXVx?=
 =?utf-8?B?MHlzWjBNeTVwd1lySUIyUG5CWDg4ZEcyODFnODVNa05LYkgzY3BCNjU1VW9O?=
 =?utf-8?B?QVFvSWhNc0wwVWpBUis4U04zcHdsaTlaTVVYdFBOT043WmdKUUtsZEhVdTBR?=
 =?utf-8?B?a1VtbXFpb1Jab0ZxUzRiRG5FS1M2MWxQQ3JWREwrVWkxZGN2dkd3bEN5Mnpm?=
 =?utf-8?B?U2Q4dnVJTW5MaE5FYnlFV3dJaGRadHlXTTFka2FFY2lZSENvSDdsL3lta0VT?=
 =?utf-8?B?dE03M2RTclFBUEdJWTc5bmN6bEtWbWNDckZ1V1h2WUxCNjBiRHdZcDlXYW9S?=
 =?utf-8?B?QmlQMGdnajdKSnE3UHVPQ1YvNDgrYnY4TllDa3gzK05YeTA1a05YNkQ4dUhZ?=
 =?utf-8?B?SUdGNHpQSnd1RmdtVldyQUZZQ1l3RFVVdy9VcCsyRUZtblpZZHNlc3QyRVZi?=
 =?utf-8?B?cG5ySXFUOEllWXYxUkJpbFJyQ2VSWjJzVGRKQS82SU1EWHR0amdBVUR1SElB?=
 =?utf-8?B?UUZ3UEJtWGpkVDR0aVNSQzhBSFlWcndJMTFXeGhaR2RhK2pBRldJdGtNd0xn?=
 =?utf-8?B?M21RdEhLUEZJSDNmc2QrNFNrY2x6TTNRMTB1TkZYZFY0Y1JFenZrc2tUMUxL?=
 =?utf-8?B?dHpOU0VKM2pKUElXQ2RrODNtUHNVTjM1YjYrK3RjcHpxOVdRakxrRUEvL2pn?=
 =?utf-8?B?RUlvTlFwbUgvVzh5T0c4MXNtOHJteE1ZdUNQV2lnVWVSWnNlZ0xIeHRGZjNa?=
 =?utf-8?B?dktaOS95aFQwRTdZOWd0WE5aWmtOaVRrRHdRem5GOWtCZitzajY3QUZHU0hE?=
 =?utf-8?B?YlZJWkFVYUF0T0VmSzRHU3FqRW1QdDBSOXM2RHNvMDBiRTJuOU5Cb20wUTBx?=
 =?utf-8?B?alBTbGNpYXZMTnp6WVNSUGtkVmZuQ3c5bENLY1F4TEVURlJ0MFRFVDN0ZjBD?=
 =?utf-8?B?UWxGYVlMT1BQb3NWL2tYWlBsS2dGSjgyM2l3Mm1oWFhhL1NpdFM5bzdlcmow?=
 =?utf-8?B?OGtIcnJDY1pQQmJQdjZzNmJqcXk1VU9rc3ZjT0gzR2Fnd1ZHY2JiUzlyeTZl?=
 =?utf-8?B?OGN4OTdHakRDaFNHbzd1M1YxSjF5ZVVWcWlESnEzVGE2clpNKy9mbnQ5T3Y5?=
 =?utf-8?B?RUJBME9FMkpjNjdnUTExZUNEYUtCUjVyc1pTWWNKbGZNTXFjYjJUOElnQ0g2?=
 =?utf-8?B?RUpMcnl2YlNVaGFSWENhQ0hTbjcyeHhrSjR0c3J4d2k2bG5WWmgvWk5OajFJ?=
 =?utf-8?B?blpGcFRRSmhTTEx6ZmpyOW5wTlFIeGVUSUZmanptY1gyMm9KNjk5Ykx5cVF5?=
 =?utf-8?B?WVBhOGJSdFFCeWRkbnRYZHVGU2kyV0d0WkQwSDNYZHE5Vy90Z3hkZG1PQkFa?=
 =?utf-8?B?eXdnZjhWMlhyNk1wK0k2aUZxb3gzVVB5ZW5nekhhNGZVQ3FVbldEODJvYnBK?=
 =?utf-8?B?SmRPRjd6ZXlaeTJvZFM3cDlDTkxMTGw1eUZ3MWZkVFpmQi9iS2F4QzdvaFc4?=
 =?utf-8?B?WHRaSjBiZ3ZvSFd1UkxPbkZGTGlhSWNiL1BidzB1RzlqY1YvT3Y2TVc2UUZo?=
 =?utf-8?B?Ym0zNjE4VGwrdDJiK3ZxVnNqWUFpZGtMc09oQ0dCNmRwNTdNU2NqOFgyTEpW?=
 =?utf-8?B?b0Y1VFk5cnlPYkxPamwySnJxYW9NK0htT05jSFR0NkhXRlBueXB3Z2FuemxL?=
 =?utf-8?B?Z040NW9hMFhsUFlmWE9wcjFGY1ZreldrNFJwSktiRHMwZ0U0SGQ4M3ZBc2lG?=
 =?utf-8?B?cG14QlZmczRnbnl3eG1uRjZXWjlST1V5THdHeStFeFJmYW1Call6clZoLytV?=
 =?utf-8?B?LytwVkF6eDRyWlZBWnFjYjFKMkI5YTdRa05jbDBYMy96ZmdMdkcwRGc5Mnps?=
 =?utf-8?B?M3pNV1Z0dzdPVEx4cTFOazhHNW9mbHQxSUJtcDdaSHdJQTZLeXVQc3VCcVpt?=
 =?utf-8?B?aU45aXN2QmtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmdPajBVWkhkNDFCL3hncFBGeXBXS2lWeXpxeFN2SDhXcnl0K3JRZ29sQjd2?=
 =?utf-8?B?QzFQL3ZpZjJkOFlFR3Z0K1k0ejRvd1REck9OU3FTWHd0V3FmNndzTU9WVjU4?=
 =?utf-8?B?c3ptUm1uc2NWWGVMTTI2SWR1NWNib201Z09TVVFPc3NTMXBoZjBqWUR6Zkox?=
 =?utf-8?B?Tkh1Tm14UFVOSXpTTU00emZ0a1hCYzFLUFNGMlg3anQ2YUhWajV2SmhCWXlO?=
 =?utf-8?B?MnhpUmRsOFp2MVhKcHVNZEx1bGxOQnZHdU9GOGpTOFpKazVvVDFpMW1zRnk5?=
 =?utf-8?B?Q0F1SWRuZmhqeUZUblJUNmorS2JlTVd4MjB4UlNBT1RISm9vZEp0dVhaM2Zr?=
 =?utf-8?B?V2FIZStuT212WGhlQkVSVmVZTXFHaE44OHVna3pFaHI0SHlLMWxvYVpQejB6?=
 =?utf-8?B?bnpzcTdqQW0vMk50U2VsREZkTmdLYm05NVpGRjdKc2hqd1Zibzd1VktPWW5L?=
 =?utf-8?B?eW5JdUVMaVFZbDdxVVlMeGlkY3FvNVZQSWNsRnhNdUI0MnB6OWk3RTdJL2cz?=
 =?utf-8?B?ZTNoRmpPdGkxZU1LWU9qeUUxVkxiMUVYbVRUZ3kzMlh2ZS9wSWxYNStYWWxv?=
 =?utf-8?B?NE5CNy9UV3YydzZ2Z25nc1FoM3ZwVlgycGRhYUdzVW1peFpEUU1aNGg5dTgr?=
 =?utf-8?B?UzZhNjNWNyt4Mmw1ejBoOGRYYkhocFM3MUhGMk9MYmNMTGdXdU9FaXh2YXV1?=
 =?utf-8?B?dFc1MER6NjNKTFlpS2dYVWFiT1hhcFhxbEhSLzJpRTlmQWdFdEpDUzB3amly?=
 =?utf-8?B?UTdDMVpHaDFlU2tXbi9vMzBXZU53T0tYRVdHdXFjdVA1M0dJSFJSY0hjVHBl?=
 =?utf-8?B?clR1My9QRWw1OUZPQkhEZUdPVjBHTHJZYnRTYlRhS2ZRZXlYNWhwRU4vNkZ0?=
 =?utf-8?B?bm8wK29iZmVoaUtxaVcyRENMUmdvcnIweUgrODk1VGVZSlo5Z0UyMW5pdW9l?=
 =?utf-8?B?Qkw3YnhPSk1wNHdjd0ZBamVDbUZ5N0lYYVJKQVE4VkwxOXg1bWFQdERoRURw?=
 =?utf-8?B?NjA3RkhLTXVZaStxbkN0RzdQeDliZlE2V1YyOHBKZ2t4RG1LYkV3dzRSbmVi?=
 =?utf-8?B?ZnJ4UmNRcUVhcnlUQ0hVNERuMWNqRERLazhrNXFpQW1QK0JMUkZob1N5SFAx?=
 =?utf-8?B?ZnEwZHB5N0oyY1czOVlVUE9EbUVNbjhPVHJ5R1VTWmhXSlZIWFExSWRITkEr?=
 =?utf-8?B?S0NlRXlldkIvVXh2MFl0QnI2aXVpcmYzK0d2bzBPakhpdzRyZzBZQjN6RTlh?=
 =?utf-8?B?cTBPMHdJdWVxRGkyTlc4S1ZXN2xOenN4MzV4UXk1dWtLMzZPSUtDK3hhRFBP?=
 =?utf-8?B?cnhtSFdRa0NwTHczKzVnWFYxYlMwVGUveWdhYm82bUk1WWRiU056VGtPaGZl?=
 =?utf-8?B?OWI0OGJlQ281OW9TeUVqeTlQOGNLZEdmT3RCbHA3b3FkRDJBSVorM2o1ZFRZ?=
 =?utf-8?B?a3duNi9Kb1N6NXhRZlI5K0ovQkFEVE44WkhyeXBQT2RwZGZnaTV5YUhCTUpK?=
 =?utf-8?B?eXorQ3p6a0tHanF6dDEyenFFSjNwcUFLdmt0VFJlMGhSOTZjVTc5YmNjQkxT?=
 =?utf-8?B?QnliWUtqTmFqSXczM1JFWDdBWVlzTWF3ZytTdHlqZC9DMXpmQ1R3clRyQXpW?=
 =?utf-8?B?ZVBEdThwV1pIalhKMktmU1ZTemlBMWVkeFdrK2VVWGF5VTJ1eUJIbWVTSVJN?=
 =?utf-8?B?V1V5ckw0VVE4ZjFqc1REdjA4V0NWVDJFTXU2Nm9yV3ZFamhJdUpHbi9tV3FN?=
 =?utf-8?B?cGhrQnFLTVM1SkVvNEFkeU8yK2pTeWxtUWJocm9zdmFNa2JKUElXZkFMMm4z?=
 =?utf-8?B?RmswUTZNcHBQOEVsWmdDQkdjQXZINEJpTWtQMDVjTXcyWjZpUm00Ykxzdnd1?=
 =?utf-8?B?aTM4bnQ0OWF6RzB5NGVPSWFKcmdSMGM1SkdZcURDVzZmaHBUMFNBMFQ5TmVm?=
 =?utf-8?B?RE1Ud0RWMUFzbGRWeTdhWVFCam5aMldYSzN4NmNGUEpLVTZzamdSRjhVZnpq?=
 =?utf-8?B?K01kZC9tdTFCbUgvckVxb2pKTGVScjhYbjZEMjM1S3lvZXlYYkhnZDZzZk4y?=
 =?utf-8?B?QzlUbFE1QTFmcDA3SWcvVEhHM3FZSWZrdE13Q3g4V3FDOGNBYlhGVnpuVlF1?=
 =?utf-8?B?aHZ6d2RFUjJBcVgrL3hhRWh4Q0tTdW9wYjArWEdSOXJrSW1kTE9NOGpyRUZa?=
 =?utf-8?Q?xvnVU9uFlaYa95jfTZvj0QE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3234E4D103A584F9A1A168F52D78EF7@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b76ffa5-1252-4879-c481-08ddf6210472
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 19:33:02.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsIz8Wc6vpN636iDAzinwj3us2N3L2G1qAAKLJabGzPrrDuBqlkYOkAarX24rQi5FwR/9UvjcZICQw45Zc4STA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4389
X-Proofpoint-ORIG-GUID: RG3rSBifSEfy4_l0NsOMpMB5Py8uhdpu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXyFjDItZN1aae
 +XJVgpv1FLAsA/CpgaJTeKj74/U2c6Q5cq1rxpbDzCprHEUvf+91Ye9Ph1SmLM6vhmXdZ7IsO4T
 jqcFpvU24u9Kespsnne2V9Jst2MXIYmgNZslS7H6WPKXVrCbSaOP6Qfo52K2Uj9mPkkNlrG1aUg
 1Bd8nZpoOKdxeuPaSoSDVVrERicMw/TvcDm45FBYMot8La2NNykWvyVDkZwJC34O9wXLkGPJGco
 pkYAEcGm9fx0KnL6XA99JIbP2GJn5DF4SjhlFRuPkEiWdIx3te85bDnGqNAilJ9MZrQg4mz6pRJ
 q5ZxAJOmxeYdfpCe9m49aDSHTxBWqiedtCvhOfo9HXByBYRr/06k3Yy0YZMk90Zr4GR1duGp22w
 RZICrLzg
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cb0cf1 cx=c_pps
 a=I1DPz4bLegk/AyvijR/I8w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=DvcZX5NVlVdFoamNkGQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MFPVs4aWe4wNXMAM2ZODBpR8af2YJ_XR
Subject: RE: [PATCH v2] ceph: fix deadlock bugs by making iput() calls
 asynchronous
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

T24gV2VkLCAyMDI1LTA5LTE3IGF0IDIxOjI1ICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gT24gV2VkLCBTZXAgMTcsIDIwMjUgYXQgOToyMOKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbw0K
PiA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ID4gPiArICAgICBXQVJOX09O
X09OQ0UoIXF1ZXVlX3dvcmsoY2VwaF9pbm9kZV90b19mc19jbGllbnQoaW5vZGUpLT5pbm9kZV93
cSwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNlcGhfaW5vZGUo
aW5vZGUpLT5pX3dvcmspKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgZnVuY3Rpb24gbG9va3Mg
bGlrZSBjZXBoX3F1ZXVlX2lub2RlX3dvcmsoKSBbMV0uIENhbiB3ZSB1c2UNCj4gPiA+ID4gY2Vw
aF9xdWV1ZV9pbm9kZV93b3JrKCk/DQo+ID4gPiANCj4gPiA+IE5vLCB3ZSBjYW4gbm90LCBiZWNh
dXNlIHRoYXQgZnVuY3Rpb24gYWRkcyBhbiBpbm9kZSByZWZlcmVuY2UgKGluc3RlYWQNCj4gPiA+
IG9mIGRvbmF0aW5nIHRoZSBleGlzdGluZyByZWZlcmVuY2UpIGFuZCB0aGVyZSdzIG5vIHdheSB3
ZSBjYW4gc2FmZWx5DQo+ID4gPiBnZXQgcmlkIG9mIGl0IChldmVuIGlmIHdlIHdvdWxkIGFjY2Vw
dCBwYXlpbmcgdGhlIG92ZXJoZWFkIG9mIHR3bw0KPiA+ID4gZXh0cmEgYXRvbWljIG9wZXJhdGlv
bnMpLg0KPiA+IA0KPiA+IFRoaXMgZnVuY3Rpb24gY2FuIGNhbGwgaXB1dCgpIHRvby4gU2hvdWxk
IHdlIHJld29yayBpdCwgdGhlbj8gQWxzbywgYXMgYSByZXN1bHQsDQo+ID4gd2Ugd2lsbCBoYXZl
IHR3byBzaW1pbGFyIGZ1bmN0aW9ucy4gQW5kIGl0IGNvdWxkIGJlIGNvbmZ1c2luZy4NCj4gDQo+
IE5vLiBOT1QgY2FsbGluZyBpcHV0KCkgaXMgdGhlIHdob2xlIHBvaW50IG9mIG15IHBhdGNoLiBE
aWQgeW91IHJlYWQNCj4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uPw0KDQpUaGlzIGZ1bmN0aW9uIGNh
biBjYWxsIHRoZSBpcHV0Og0KDQp2b2lkIGNlcGhfcXVldWVfaW5vZGVfd29yayhzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBpbnQgd29ya19iaXQpDQp7DQoJc3RydWN0IGNlcGhfZnNfY2xpZW50ICpmc2Mg
PSBjZXBoX2lub2RlX3RvX2ZzX2NsaWVudChpbm9kZSk7DQoJc3RydWN0IGNlcGhfY2xpZW50ICpj
bCA9IGZzYy0+Y2xpZW50Ow0KCXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9k
ZShpbm9kZSk7DQoJc2V0X2JpdCh3b3JrX2JpdCwgJmNpLT5pX3dvcmtfbWFzayk7DQoNCglpaG9s
ZChpbm9kZSk7DQoJaWYgKHF1ZXVlX3dvcmsoZnNjLT5pbm9kZV93cSwgJmNpLT5pX3dvcmspKSB7
DQoJCWRvdXRjKGNsLCAiJXAgJWxseC4lbGx4IG1hc2s9JWx4XG4iLCBpbm9kZSwNCgkJICAgICAg
Y2VwaF92aW5vcChpbm9kZSksIGNpLT5pX3dvcmtfbWFzayk7DQoJfSBlbHNlIHsNCgkJZG91dGMo
Y2wsICIlcCAlbGx4LiVsbHggYWxyZWFkeSBxdWV1ZWQsIG1hc2s9JWx4XG4iLA0KCQkgICAgICBp
bm9kZSwgY2VwaF92aW5vcChpbm9kZSksIGNpLT5pX3dvcmtfbWFzayk7DQoJCWlwdXQoaW5vZGUp
OyA8LS0gd2UgY2FuIGNhbGwgaXB1dCBoZXJlLg0KCX0NCn0NCg0KSSBhbSBjaXRpbmcgeW91OiAi
Tk9UIGNhbGxpbmcgaXB1dCgpIGlzIHRoZSB3aG9sZSBwb2ludCBvZiBteSBwYXRjaCIuIFRoaXMN
CmZ1bmN0aW9uIGNhbiBjYWxsIGlwdXQoKS4gQW5kIHRoaXMgaXMgbXkgcXVlc3Rpb246IFNob3Vs
ZCB3ZSByZXdvcmsgaXQsIHRoZW4/DQoNClRoYW5rcywNClNsYXZhLg0K

