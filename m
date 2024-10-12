Return-Path: <linux-fsdevel+bounces-31806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC699B645
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51263B22591
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21679B8E;
	Sat, 12 Oct 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZWn8PpYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED54964D;
	Sat, 12 Oct 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754019; cv=fail; b=mpE24DtfVlp5Gvfpnk3Ro3DIazLXG91DAG5gissthhPEVmMNnxTcVXUofYnlN71k7dUUgth+jumHbZcrkv3Shb712Z/713J/o4RJmOoKeW6Eq7hOX3fVKzORICXAtdYQs2Nmswu1xawNTB9Em3O6rq/HsocK8MLMIoCal1SzywU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754019; c=relaxed/simple;
	bh=BhRA3eUqzKXjxLtcRp2Sl2B/F2PercKnISrU6/bYpIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YliZ9iFBIV0Ak3R840wyUXfUGqvuN7HpLX9Kx1ryGgzc3YCIUC9gxm4psmBerV7ne5eimAYq2WrhXNZcCWhhMUGO19E/NiaWweyv69xOqL0l0tCG/YEE7uychlz9Wpoj22jkTFRQiaucMNzVF7qlPyk5Xigvlm09N9c7DrkyE9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZWn8PpYi; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49CEDSAM013821;
	Sat, 12 Oct 2024 10:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=BhRA3eUqzKXjxLtcRp2Sl2B/F2PercKnISrU6/bYpIM=; b=
	ZWn8PpYiJqpaaDsjO9Djlz425hIRDA8mLb+Qh/cShA2mC0lEcpm65UYJOn14mIgP
	vbu1gIiIlL+v4+Yuy0VNzVVYBegCE/UHoeTKtf49PVlaBVDSzKAteFU3LtTBMMLT
	6QyOlj3sqC/Tl+K3M/D2jN96G3oQqNreXk8LdNTWXSUvEvnYD6w12faj5ucJOM5N
	7Tw8n9S9z/NUAFAwIU68AIVRkEOSgk2RT151DryUAH85aMuPVfMiLMP1k8JbvVBn
	OhQhBHddIBPC+BCO4A3lUDSxn4mGJEGvMWwvf5y3x7SOD4FDugy5/VDBbvvFfccf
	z12PvFNxq/hKWM+Kz7TXgg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 427pxuh8fw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Oct 2024 10:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogd9u+uWlzBClb0OlojhbecTc9QGZLD3XBOcD7Flngt8mKwES4PhK9QxQpH+pRSZIsKqQUD5qlUdIurkM+i3sqf3tzZC2a4PuVmrrlgHuU2ZpB+aKluERsROBjOGIlx95NnRpensM55geKosRCokHDQ/5K5yvCUqcb0qIo0fpyYm8GffpN5sRINCn2uFH9JwsRpzwcxQbHgQtt2Y0qF4EAPjRdQtOWGtlfmS6LCk1zA+lcFTPeelkx+rIkpKPF79FyopvdQZD4yTGocefYsEVx694JdsQW2ondC0LnR6WuQISlnWKEdJwiLKgG5HMM5r28DvIehEP9s2sq5S5SHKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhRA3eUqzKXjxLtcRp2Sl2B/F2PercKnISrU6/bYpIM=;
 b=o4T9HV0y3BK2go0zBIuGlDBlLkmWMRhz3lqs7EOHVmDD1rGVRKBpB89G+zTWwOhkcRZbXOEvzVJI8mEt61PftrGR5POswqLOBlcqqahB7aCQV4qhK4nnt6LDtYVNJrvUhNXkteyohW5leuYUR29Z7OjXderpC2h1Gxgo66mrttJCsGyQdbWfTsXs3zRiRaYpowMB24CqBCISmVmaCMRYgHCpjwopLJl9RMKbO6devm4guFSwdC36AebGwhtDLR/NOEsCKTCB6jJztcYYSGDEfXp4mgjbMQdP1glA3PE01B++1FGkSU2N+E8E7hGuoKokbbLJXmKSugyMfigbroZtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6500.namprd15.prod.outlook.com (2603:10b6:610:1b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sat, 12 Oct
 2024 17:26:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 17:26:52 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        James Morris
	<jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and
 security_file_open()
Thread-Topic: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and
 security_file_open()
Thread-Index: AQHbHHWt51pL7NhjCkOd760sPg5zBrKDXuAA
Date: Sat, 12 Oct 2024 17:26:51 +0000
Message-ID: <C4165EAD-23A7-4D62-BB31-26D872AC78EF@fb.com>
References: <20241011203722.3749850-1-song@kernel.org>
 <a083e273353d7bc5742ab0030e5ff1f5@paul-moore.com>
 <CAOQ4uxhg8zEZ4iOpUigv1paHMXvZNCFv_qTNfg-1CcehjE+7oA@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxhg8zEZ4iOpUigv1paHMXvZNCFv_qTNfg-1CcehjE+7oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6500:EE_
x-ms-office365-filtering-correlation-id: 50f143ea-ada7-4f49-e626-08dceae30f90
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0FBeTlHbDlNWmN6UjYrcjUzRkR1OWJhaDJuSUxsVHZHZEdpZUNLbjNyQ0FG?=
 =?utf-8?B?VUp3YmVRU3JKaEo4NmZKV2hWcWlHRkgxRk9tTEo3WmpQaXpXRXd5Z1VJc3pW?=
 =?utf-8?B?QjBndU9CTjU3clNKY3ZVdFpINndlZTVWWUJsYWR2NHF3Q3ZOdi93end0YTVi?=
 =?utf-8?B?WmdxeHJoNWlQcUdaTmtvVHdhU1lRSVJvVHM4UVBvZFI4WWpzOEROQytIN05w?=
 =?utf-8?B?cVpPWE9ueVI5eWRmdGZrS3lCbGNnNWNWZXFmWmhPUXRNVyt3OWN5U0VtdFZs?=
 =?utf-8?B?NVRiSDdaK1c4TFJXK2k2czhJVW1XTHRrQXA3MUJheVhPblRxdDIwak1hdG1m?=
 =?utf-8?B?RUN4SUJoeGEwUWdUWEc5eklGakRvUit5NGhORk80NEVIMTlwTnh3TnZrZmpS?=
 =?utf-8?B?QzhrcFMwdzFqQktkbGxob29iVFQyMmQrQWgzRWpMQkdZZTN1L1F5UmlvbmtX?=
 =?utf-8?B?eHF6Y3lxZnhvaExDbW4zQnZTaGlnQklHNXJtMnFweDdBWlgrWHppVGhMOXFY?=
 =?utf-8?B?TVQ3Y3I1czl4VlBFeVdjK3JJd01wdEdrMys1NlhXNy9EU0tRRFF0OXcyVXUw?=
 =?utf-8?B?aWZRTDdTTkdpT1NvQ1M3ajlOS2dGQnNtS0xkLzkxTlJBQ1VOKzlpa2owdmJw?=
 =?utf-8?B?MHBJSjRBTU1SSDVNUjBUSWZyNVVsa0tUa3hLSTJTWGVETnBJZkpOTkNLa3lQ?=
 =?utf-8?B?VlA4c0JsWjlndW9Db2JVaVQrMVg5MGR0VEJCVTFVMndxUmJNSGpkaXZUR0g0?=
 =?utf-8?B?NWNyeWhtS29ITHBUY0FpMGIrVUdzYy9GWGUzZ2JsYmROU0ZXampZNjd1dG55?=
 =?utf-8?B?VjcvSnI3OU5SNGtHdVNkd0UrcW93V2o3S2NCSVhEWlFLOUNFNEpjalhxbEVH?=
 =?utf-8?B?V2hMK3hOUzlZSGlDYlBhNC9nQWdaN2ZMbWcvMUgxbGZhTUhtTlV6T1FuUU5x?=
 =?utf-8?B?UklxOXN3QVdoOUx0emNtNmdWN2Q3ZlBVRU5QbzEzcjVmaVpVaVA2aU9RelBJ?=
 =?utf-8?B?cU1nTkRqV0FENG53SDJzYmpTdHZhMlViR0NLWGdocEVxUW94V2NmQmcwYVVy?=
 =?utf-8?B?ZWpOLzFJWS82cGxXbklKdHJpSXF1RnNpWEk5Q0x2Ty9wcGo1M2F2eVNudURL?=
 =?utf-8?B?ZDFjL3hVYU5WTXVUMEhTUDZGUXA0ZWNSZmY3V0Q5WUxFUEJxNEFmQUtPVCts?=
 =?utf-8?B?ZmkwTlpNS0o3aHdrcXBvVnJ5MHA0L3FtSDNwN1hSUHQ4Vml3WDJRd09YM2Jr?=
 =?utf-8?B?NlQvbmxuT0ZDeEV0dUs4bWx1WHZUencyMUlBc2xJVUhzYTMxcGxzclJFNkpS?=
 =?utf-8?B?SHdJODBTY1R3K1ptR1YzRzMvekk1eEFML3V4RXNvZjJXVWd4VHhtQmVRVGwx?=
 =?utf-8?B?QWNpQmx2eU9JY01IQ0N1VFphMStxMFlmNFE2d0dXNzlPZC9icDVwMXFyNm5a?=
 =?utf-8?B?Wm13YW9wTDVTbTdWU1JveDgwRUdhWUNnRlpkR1dWN2N5MURHblRPUnAwVVlG?=
 =?utf-8?B?empvYjJ3U3pua01SZnBueVcrU0hEdHBWMy8xTGtwWnJ3emVEMzJKc0ozaUJT?=
 =?utf-8?B?cFNEUVQzTmJpcndBdVhtNDBaVXpTZFFYSVBWSlRBYVAvd2lXR0F5TmpsVEFz?=
 =?utf-8?B?NjQ5YnJSOWc0U0lEVkpYUk1vWWhhbzg0WnlzWHdrTHVVZG44MWg4cG93b3gv?=
 =?utf-8?B?Z0crUXN6MCtRVmpBNzY2S3pGMC9jQlZYUkx3YlVlcjFTUkE0Uzl4TEFoeTZo?=
 =?utf-8?B?dk1jY1ptdzdvZnZROS9qWllIUUpnMC9ycml0Nzl0SnhwUlBZSnNkd0hvK0hZ?=
 =?utf-8?B?ampkV2pUZ2JjVmw4K0JPQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVBzTjE3bEZnV0ZUSjVsMU9lK0g4Y2FPSkIxMFRna25MSUpxYUJpdUNoQStz?=
 =?utf-8?B?NlhVQnZGNDNBdmN5RjdzRHBxZmpxWlN3QmJleE1nVmdRWTdTdXk5ZC91VDZW?=
 =?utf-8?B?UVp3QTJWTHFVSDQ2OEJXYitYZVZjc00xS2NYTG14OHRycFVWOFhjaWZib3RO?=
 =?utf-8?B?akdheEMrSVZiZlp0TThPMmw3TDFma1VoLzdLekpTbXNlVXlBcXJxN09acmtC?=
 =?utf-8?B?Q3hZZHozQVBLMThjRjdVbkt2OEtwTFZEWXYxRDgyeHVsUjVXenkwejdzTE1a?=
 =?utf-8?B?eGM3RmdjdkZOeGErd0k2eUQ2a2ZhUjdCaFlBQk1nNkt2RjdEWE5pSmVXM2Y1?=
 =?utf-8?B?QjcwaS95MXhaSTZVNjg4ZUtpMVR6ZXNac3p5Vk8zUVBxcGJwdmZZb2M3eXNm?=
 =?utf-8?B?OUs3RWswKzFzd29mV2dhSEI0VWQ0TVhsVzVzTkN3ajF6QmowR2w4SnUzNEUy?=
 =?utf-8?B?T3JJUk9BTUlIMGhmVGVDd2xJT0tmUVBPMllHczBRSFdLS0tnMjh0TTdBT1dx?=
 =?utf-8?B?Ymk1WTBtaWkvMmI0OURtb3FZSTNuNTBFdENQTmNMZDVrY3o0ZCtUOXNoVkZG?=
 =?utf-8?B?aWxZVE9QZElJM1gyMU02dElMQzJxUllZeFdGRGtocmFVZXJEVEtoNVp0SlI0?=
 =?utf-8?B?UUlpb01hNklyelFhSG91OWZNOFVYYXZqT3ZVZGMwMGlGUklOY0ZXbWVrSkUv?=
 =?utf-8?B?UWRwTG9YcmluOWg3SndPZUdhY1ZERy9BVXhNbUcxUVdjYmJLWXZ6dzJ6Mi96?=
 =?utf-8?B?Y2hEZmlmTDRJRGlCSytRWXZkczltOWd5M3dCZFdxVktPVWlzWlUrdzdVRHZz?=
 =?utf-8?B?eWo4SVlUVzU5ejc5c0dnRTFTeU10NU1rakpkTTdYb1N1OGUvd1ZqR3h6aTJ2?=
 =?utf-8?B?cXp2cnRyMUxnVWhIb3VsQmVtU01hbEUvUWFucGFKUTMxQnhPQXVIdFVqSWFn?=
 =?utf-8?B?dGp0VnI0Z213YmlpNXR0emNWRG5NUDdvUWtkMERkL0lZT1EvY3ZrRDdLNzBq?=
 =?utf-8?B?alpGdUhPRm9iQ3o5eXJXQjJ5c2lCMjhRRHc4OHdqZkFwUE1RVjVHMWw0MWJI?=
 =?utf-8?B?WEpnWDVtVTBMa2NqdkJiN0RadjY1MmpEN3N5d1hqTHovMGR0VWVSMmhpaW1W?=
 =?utf-8?B?VVowT2tyZnMwcTJXVHhFSStURjgwamo3MzZHMXBOZmZrMmxIN2lUbTc5Q1hm?=
 =?utf-8?B?d2ZGekEzZ2gxaDNJaGhRVGxZRFBMd3hCUER0ZGcrcmxiQ3AyaTNON2pYaHFN?=
 =?utf-8?B?RVpCR1d2KzZOSi9RbUViWnFFSlhFVUpIT1JURG9Pb2F1R3dCN0VNakhpRGM5?=
 =?utf-8?B?clhWZEw0T04wMllCcnlNOTRYeUEydkZDUStjTS9udUwvY2hZWGw1bWxEQlVn?=
 =?utf-8?B?cFRkZHZqQUl1YitEcFk1SXpBVHpQekVHUjM3WDZSTHpITjMwTUlnSGVYcTFi?=
 =?utf-8?B?eGkzRXNmUEVPTEZrVVZIb2YyVERQcURPa2M4N20yRlNqZnQrSVZyUXJxazlI?=
 =?utf-8?B?a0JtckFGeU5YaStvOEk2ZU5BMFU4Vm9pblp1bDR6VUtRNzlpcTlRMTg2NVZp?=
 =?utf-8?B?TzlLVDV0NXNkdVZWTVhlOXYvdDFTNkhadnRyczdQRWR6S290UVJvQXI4eUVp?=
 =?utf-8?B?MGdIZG9FSjNvMnRMUXptM1NXc25pa0ZhVkFxTERraGw3MXErWlRFcFcrMXAr?=
 =?utf-8?B?bTFQdmtTMzFuQW84MkhwYjcwd203bXBtS04zeVhHMGMrZlRJRlEzb3l1WEMz?=
 =?utf-8?B?djFncVIrMitrTHdVSGNDTWZOV3d5bGNFMk5ORzF2ZFFWbkNwdURodTVmS1Fq?=
 =?utf-8?B?ck9yWXltWGZqMncwZlBVbFY1Sno4Q2JCWHkzV0FXdWJFdHZ2U2dISFpUdXZh?=
 =?utf-8?B?VnlkdFBDM25uR3I0R085UWthVXQzL1QzRUFFd3lhS2g0VnVGSXpLbngra010?=
 =?utf-8?B?SzU0OHlOQlVOMU54QXdzRktxZStYQ1ZTTTYxb0EwcUMrR1EvTlg5RGNqWHZp?=
 =?utf-8?B?ZGIySmNzaHdjUnFvK2lwbnNDblJxV2RpZ20rY09DNFNNQWhQTVVMRkp5OGtU?=
 =?utf-8?B?MDlHelR3aERhK1pGOFlXekEvZDJVTGpOSGl2UGFkODFpQysxbnkyK1JQUzJa?=
 =?utf-8?B?T0d2TVlUcytiWG5lZXJHOWRuWVhSOC9KbW9LWFl5TVJnQTE0Q3Y5bTJTYkp4?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D234807EDC2844AA34B669C326AEB8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f143ea-ada7-4f49-e626-08dceae30f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 17:26:51.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbsyAlqvyOTBZMD7wXt9AfW+D99oE4wE7ZLARvtiEnPDXqRs0nkDav4hZf8JxGYYtYZ960iOvWK+XvxrV2uXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6500
X-Proofpoint-GUID: U63XJJRMPelvAiJT8KSFSJ09T9ZY5F5s
X-Proofpoint-ORIG-GUID: U63XJJRMPelvAiJT8KSFSJ09T9ZY5F5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQW1pciwgDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gDQoNCj4gT24gT2N0IDEyLCAyMDI0
LCBhdCAxMjowOeKAr0FNLCBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPiB3cm90
ZToNCj4gDQo+IE9uIEZyaSwgT2N0IDExLCAyMDI0IGF0IDExOjQy4oCvUE0gUGF1bCBNb29yZSA8
cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3JvdGU6DQo+PiANCj4+IE9uIE9jdCAxMSwgMjAyNCBTb25n
IExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBDdXJyZW50bHksIGZzbm90
aWZ5X29wZW5fcGVybSgpIGlzIGNhbGxlZCBmcm9tIHNlY3VyaXR5X2ZpbGVfb3BlbigpLiBUaGlz
DQo+Pj4gaXMgbm90IHJpZ2h0IGZvciBDT05GSUdfU0VDVVJJVFk9biBhbmQgQ09ORklHX0ZTTk9U
SUZZPXkgY2FzZSwgYXMNCj4+PiBzZWN1cml0eV9maWxlX29wZW4oKSBpbiB0aGlzIGNvbWJpbmF0
aW9uIHdpbGwgYmUgYSBuby1vcCBhbmQgbm90IGNhbGwNCj4+PiBmc25vdGlmeV9vcGVuX3Blcm0o
KS4gRml4IHRoaXMgYnkgY2FsbGluZyBmc25vdGlmeV9vcGVuX3Blcm0oKSBkaXJlY3RseS4NCj4+
PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4+IC0t
LQ0KPj4+IFBTOiBJIGRpZG4ndCBpbmNsdWRlZCBhIEZpeGVzIHRhZy4gVGhpcyBpc3N1ZSB3YXMg
cHJvYmFibHkgaW50cm9kdWNlZCAxNQ0KPj4+IHllYXJzIGFnbyBpbiBbMV0uIElmIHdlIHdhbnQg
dG8gYmFjayBwb3J0IHRoaXMgdG8gc3RhYmxlLCB3ZSB3aWxsIG5lZWQNCj4+PiBhbm90aGVyIHZl
cnNpb24gZm9yIG9sZGVyIGtlcm5lbCBiZWNhdXNlIG9mIFsyXS4NCj4+PiANCj4+PiBbMV0gYzRl
YzU0YjQwZDMzICgiZnNub3RpZnk6IG5ldyBmc25vdGlmeSBob29rcyBhbmQgZXZlbnRzIHR5cGVz
IGZvciBhY2Nlc3MgZGVjaXNpb25zIikNCj4+PiBbMl0gMzZlMjhjNDIxODdjICgiZnNub3RpZnk6
IHNwbGl0IGZzbm90aWZ5X3Blcm0oKSBpbnRvIHR3byBob29rcyIpDQo+Pj4gLS0tDQo+Pj4gZnMv
b3Blbi5jICAgICAgICAgICB8IDQgKysrKw0KPj4+IHNlY3VyaXR5L3NlY3VyaXR5LmMgfCA5ICst
LS0tLS0tLQ0KPj4+IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiANCj4gTmljZSBjbGVhbnVwLCBidXQgcGxlYXNlIGZpbmlzaCBvZmYgdGhlIGNvdXBs
aW5nIG9mIGxzbS9mc25vdGlmeSBhbHRvZ2V0aGVyLg0KPiBJIHdvdWxkIGVpdGhlciBjaGFuZ2Ug
dGhlIHRpdGxlIHRvICJkZWNvdXBsZSBmc25vdGlmeSBmcm9tIGxzbSIgb3INCj4gc3VibWl0IGFu
IGFkZGl0aW9uYWwgcGF0Y2ggd2l0aCB0aGF0IHRpdGxlLg0KPiANCj4gZGlmZiAtLWdpdCBhL2Zz
L25vdGlmeS9mYW5vdGlmeS9LY29uZmlnIGIvZnMvbm90aWZ5L2Zhbm90aWZ5L0tjb25maWcNCj4g
aW5kZXggYTUxMWY5ZDg2NzdiLi4wZTM2YWFmMzc5YjcgMTAwNjQ0DQo+IC0tLSBhL2ZzL25vdGlm
eS9mYW5vdGlmeS9LY29uZmlnDQo+ICsrKyBiL2ZzL25vdGlmeS9mYW5vdGlmeS9LY29uZmlnDQo+
IEBAIC0xNSw3ICsxNSw2IEBAIGNvbmZpZyBGQU5PVElGWQ0KPiBjb25maWcgRkFOT1RJRllfQUND
RVNTX1BFUk1JU1NJT05TDQo+ICAgICAgICBib29sICJmYW5vdGlmeSBwZXJtaXNzaW9ucyBjaGVj
a2luZyINCj4gICAgICAgIGRlcGVuZHMgb24gRkFOT1RJRlkNCj4gLSAgICAgICBkZXBlbmRzIG9u
IFNFQ1VSSVRZDQo+ICAgICAgICBkZWZhdWx0IG4NCj4gICAgICAgIGhlbHANCj4gICAgICAgICAg
IFNheSBZIGhlcmUgaXMgeW91IHdhbnQgZmFub3RpZnkgbGlzdGVuZXJzIHRvIGJlIGFibGUgdG8N
Cj4gbWFrZSBwZXJtaXNzaW9ucw0KDQpJIHdpbGwgc2VuZCB2MiB3aXRoIHRoaXMgY2hhbmdlLiAN
Cg0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VjdXJpdHkuYyBiL3NlY3VyaXR5L3NlY3VyaXR5
LmMNCj4gaW5kZXggNjg3NWViNGE1OWZjLi44ZDIzOGZmZGViNGEgMTAwNjQ0DQo+IC0tLSBhL3Nl
Y3VyaXR5L3NlY3VyaXR5LmMNCj4gKysrIGIvc2VjdXJpdHkvc2VjdXJpdHkuYw0KPiBAQCAtMTks
NyArMTksNiBAQA0KPiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICNpbmNsdWRlIDxsaW51
eC9rZXJuZWxfcmVhZF9maWxlLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9sc21faG9va3MuaD4NCj4g
LSNpbmNsdWRlIDxsaW51eC9mc25vdGlmeS5oPg0KPiAjaW5jbHVkZSA8bGludXgvbW1hbi5oPg0K
PiAjaW5jbHVkZSA8bGludXgvbW91bnQuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L3BlcnNvbmFsaXR5
Lmg+DQo+IA0KPj4gDQo+PiBUaGlzIGxvb2tzIGZpbmUgdG8gbWUsIGlmIHdlIGNhbiBnZXQgYW4g
QUNLIGZyb20gdGhlIFZGUyBmb2xrcyBJIGNhbg0KPj4gbWVyZ2UgdGhpcyBpbnRvIHRoZSBsc20v
c3RhYmxlLTYuMTIgdHJlZSBhbmQgc2VuZCBpdCB0byBMaW51cywgb3IgdGhlDQo+PiBWRlMgZm9s
a3MgY2FuIGRvIGl0IGlmIHRoZXkgcHJlZmVyIChteSBBQ0sgaXMgYmVsb3cganVzdCBpbiBjYXNl
KS4NCj4gDQo+IE15IHByZWZlcmVuY2Ugd291bGQgYmUgdG8gdGFrZSB0aGlzIHZpYSB0aGUgdmZz
IG9yIGZzbm90aWZ5IHRyZWUuDQo+IA0KPj4gDQo+PiBBcyBmYXIgYXMgc3RhYmxlIHByaW9yIHRv
IHY2LjggaXMgY29uY2VybmVkLCBvbmNlIHRoaXMgaGl0cyBMaW51cycNCj4+IHRyZWUgeW91IGNh
biBzdWJtaXQgYW4gYWRqdXN0ZWQgYmFja3BvcnQgZm9yIHRoZSBvbGRlciBrZXJuZWxzIHRvIHRo
ZQ0KPj4gc3RhYmxlIHRlYW0uDQo+IA0KPiBQbGVhc2UgZG8gTk9UIHN1Ym1pdCBhbiBhZGp1c3Rh
YmxlIGJhY2twb3J0Lg0KPiBJbnN0ZWFkIHBsZWFzZSBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgdGFn
cyBmb3IgdGhlIGRlY291cGxpbmcgcGF0Y2g6DQo+IA0KPiBEZXBlbmRzLW9uOiAzNmUyOGM0MjE4
N2MgZnNub3RpZnk6IHNwbGl0IGZzbm90aWZ5X3Blcm0oKSBpbnRvIHR3byBob29rcw0KPiBEZXBl
bmRzLW9uOiBkOWU1ZDMxMDg0YjAgZnNub3RpZnk6IG9wdGlvbmFsbHkgcGFzcyBhY2Nlc3MgcmFu
Z2UgaW4NCj4gZmlsZSBwZXJtaXNzaW9uIGhvb2tzDQoNCklJVUMsIEZBTk9USUZZX0FDQ0VTU19Q
RVJNSVNTSU9OUyBpcyB0aGUgb25seSB1c2VyIG9mIEZTX09QRU5fRVhFQ19QRVJNDQphbmQgRlNf
T1BFTl9QRVJNLiBJbiB0aGlzIGNhc2UsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBiYWNrIHBv
cnQgdGhpcw0KdG8gc3RhYmxlLCBiZWNhdXNlIHRoZXJlIGlzIG5vIHVzZXIgb2YgZnNub3RpZnlf
b3Blbl9wZXJtIHdpdGhvdXQgDQpDT05GSUdfU0VDVVJJVFkuIERpZCBJIG1pc3Mgc29tZXRoaW5n
Pw0KDQpUaGFua3MsDQpTb25nDQoNCg0K

