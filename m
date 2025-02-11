Return-Path: <linux-fsdevel+bounces-41532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A2A313A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DDE3A525E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059131E376C;
	Tue, 11 Feb 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="li5vBXnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D41DA314;
	Tue, 11 Feb 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296890; cv=fail; b=CFGAovMQa8p08VfFOVAdOJAVRAtJNiM5Regh0UvHnR/3ESSN8K/gdkTOJMrJDyF1m0IgIunwKazr8FB8D6ZB4UY9/0/C9uIGQekcnBY0RRW6ovcz29zWXcblDkJQx2tuSHybG0oTuSJD2vkAftKdR91qK3tgmUIISF2uXLdR/Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296890; c=relaxed/simple;
	bh=ncSM5JvkW8QDCxD8LCEgZAfIuvGBA5xYJTip9B1xjiE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gAgbu2HNLLpCnranb11oT3/GqLBj3t4XGQLzUvwlSTtGFU6x61JsON8WQyMQXbveBV1/kjZv5GtiratahvTAk+btKcH1EYxiH67kVckMbOgNjAKwX+sWSwtJdNLaC494I1mUnFmiMvt4IGuPBCL4IoF4MMIStG04VkYiylrhJpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=li5vBXnf; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BHHXJ3016554;
	Tue, 11 Feb 2025 18:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ncSM5JvkW8QDCxD8LCEgZAfIuvGBA5xYJTip9B1xjiE=; b=li5vBXnf
	sMws1Ou8LD/Rhk5ZGFqSX5C/rcZXf/Fv35ZVSq69vt68bOxG3SgN6IEX6RwEHIKy
	XV77KkvtpmYvL8XGngsCTNzaX0/zYbKAtntGvzxepyDqQH8EYrdlepc7cYIX6Dul
	UzjykjnhKwqkAGA1m2rNI0Hu58u2TxJJVzUjtV1+ruE8ZpvtJ9MYU5+QOi9WMGxg
	ma2zPEAtD/TDGp8E8/XHFtPVK4MqbdDZjDbvUGXUDcKHTo2WYgjAPS7mn2lZmk58
	n/aJoYAPZfbpHCrixxmx7e4Wx77tDudLBli3KXpPV8uJOfvZ45JuiefNWY28taZg
	KIaBAfqib65+Ag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r28pu074-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:01:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51BI1OfZ013129;
	Tue, 11 Feb 2025 18:01:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r28pu071-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:01:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqKet4ovPqALTYENckUd020/c/pCBSIA9F0NG6Q66Ntzx96l5FpJP6aNDh8Njq152eopaGkrjgr0vSDW3JrFPB4wArdM7AT/6KV4VAaJAUwXKPmCiP3SEiErxyhCAN4Wnvlh2R/UuM/sm7F9YD/C+Tae5FqKfTcZqUL7VKGVHjQPBQVUrGxOKevAv8uDGpWPjJHY2ektho7F+4XKRysUiGmBpDzyz9scO6vokX5pEcHgt24sw5YQwZrexckSI3LX0o2RxvFyaper2rVzmUf6L4WfMQ0mltbrEGAWym/nM018WhbPyWaM145zePwb/CPJIv256pa5e+3MRIv1wjr9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncSM5JvkW8QDCxD8LCEgZAfIuvGBA5xYJTip9B1xjiE=;
 b=bM+rwaNjMBS7+6JUFwcj+VX/7eedDXVdM7IPnoe7DrZJBUb58MQ2TmH+MzuzJjVoFBJSF28HgoOSnAAIrdzPkO+SU+evVDKaUOF6bpyHDVknSZty+wV5mBgVvR3NVnRQqbWjBbDQiN3PZJszFD0TH6dkhUpErgKmk6jiwIHMJDyKP3XTkhtTVnMhwwN8rCRLodA8tqzLrbm46IQ1OumW2MqFn3/BUlmgT5HoJo4k4gz73kIeNqxwJXdlJZLectY5cFCf87PODmZOts2vlALcODzsBZsmXZl3/vHHETLZNEbZAS0maSSDlvHv47hQxtG0/FgR9/vf0SMAMfLi/58Maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV2PR15MB5335.namprd15.prod.outlook.com (2603:10b6:408:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 18:01:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 18:01:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Thread-Index: AQHbcTHI6MoXeV145U6GsShlXuSWerMs1eMAgAAdZwCAFFxvAIAAAfaAgAEp1oA=
Date: Tue, 11 Feb 2025 18:01:21 +0000
Message-ID: <01dc18199e660f7f9b9ea78c89aa0c24ba09a173.camel@ibm.com>
References: <20250128011023.55012-1-slava@dubeyko.com>
	 <20250128030728.GN1977892@ZenIV>
	 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
	 <20250129011218.GP1977892@ZenIV>
	 <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
	 <20250211001521.GF1977892@ZenIV>
In-Reply-To: <20250211001521.GF1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV2PR15MB5335:EE_
x-ms-office365-filtering-correlation-id: c5fc4300-a393-496c-2c65-08dd4ac617ce
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFg3eU9ydmI0eDNxWGhMZUgxWjgyM0l3RktTY01IWkpONDZpZlExNU5HMndI?=
 =?utf-8?B?WlhscmhQSHg0a0IvVlh4ZjdMaFJDSTg4b3R1MUYrSkh0bVRqdWdMWVZZRXA4?=
 =?utf-8?B?bWpTSkU4Q2EySWh5WnBiVkJBTDZkSGlSN3ZicStrNGNRS05qWkVrWG1kY2dr?=
 =?utf-8?B?SjV3eHJTR0h6RXU5WncvQ1RlRTdMSHpyU1hnSEpqVGdvcnY3VFFCczhOWHBp?=
 =?utf-8?B?K2tQcXhyTGFYMHl6NmZTMW5XSGZLOExUNFg5YzAycDFWTWhOS0ppY0JqUXZl?=
 =?utf-8?B?ZGowbXVwZGg0d3VKK21FR3V4d3Rjc2VXU2xVeTRhV3FQYnBqSXRJdkkzUy9S?=
 =?utf-8?B?c1UvR0NocmUvUDJSSm9FTzFYZjB1YXpvQitvMnJPaG9WTFR5NUV3QndjNFps?=
 =?utf-8?B?ODQ5WGsyMUgrc0s2WEkvNnNpYXhzcVFqc2Q2QkVndHlsOGkxdlpsRGNaTyt1?=
 =?utf-8?B?NzBmZ2tRVlVNcHg1YktnZmd6NjZidHUrSU5uZkg0YjhLN3dwUjVWMnVIaXg2?=
 =?utf-8?B?YWM0bG9JSWVMcDJCbnNyR2pWT2ZSK3dtQ1BVOTdUaEJxY2d3czlzZUFLWlZT?=
 =?utf-8?B?ekF2VUFVMjhpYUQ3YU1pRlZNM0tjeUNkeUFHN09TU3oyc2ZZKzJoNWJoWU5G?=
 =?utf-8?B?aXM1dEpGNE9HODRLdVpybldLbXRUS3ozNXB1NmxlMWh5VmJ4dnJqcUpwZ09T?=
 =?utf-8?B?L21uSVdOb0pXQTBtNU9uK1VqT3ltU0JFMWx4YWxIbEtMUU1zNXR6aHozKzFE?=
 =?utf-8?B?L1EwaTN2TW9UZkVwTlpmdUhoa2orZmppbGIyOVlnaVcrNDVxYnBDTXJadlZD?=
 =?utf-8?B?MHZQNUNaV0lOWS8wcVBJZEM3MDFvVDd6U3BidkFzYWhkYmlYeXgvS0p6Zjds?=
 =?utf-8?B?SjBtbzUvZW9YNE5jei83Tkc5Uk1kSG0wNWdHL3did3NVRjQzaldSdHd3a05L?=
 =?utf-8?B?Nm9VY3VrU05BK0ZBS2RYVi94dmxZMjNUUG83ckQ1WGlKYVNZSnpvUkcyc2FB?=
 =?utf-8?B?bDNMcEhoSll4YkNjazVGeGVLM01XVGJYRjZCQUVYcHl3cUpTVi9URG80UDZW?=
 =?utf-8?B?b2pOM3d2YkZtZlJlWnppMWVLNjRQTTlxajNmUUJsUlhOSXZaQWxEL1FaWDFw?=
 =?utf-8?B?M1UzcEpWQ09TZWlVbUQxNGFEcEtzSmxYbStXQUtpeU5oaDAzdWM5bmFDQlRw?=
 =?utf-8?B?ck10UFNmY0JZM1lmamVtMXRrQzJleDNlTUZrV1NZRElLWkcyUC80Yk9GeFZ5?=
 =?utf-8?B?dHo0eGVtMVltTFlwbCtKM00yWDg3WDQ0Y2RIYzVVUy9QVWx1SEtYSDdmZnRH?=
 =?utf-8?B?amxpWFZoRGJJZGI3V3BQa1lnMGNobHpYU2FiUU9abkV5blUzRks1bXVJdDky?=
 =?utf-8?B?VFJEV0dOdThwNG1mOFQyNnRGSm9UVWlrTUhyV3hGYThFL3gvQTEvQUJVdFZX?=
 =?utf-8?B?WHZ6eTdqeGtOaUVVTU9SL2RsQUk1a2hURG1lZVFUQlJsWW1wSkNRNWhTaWNJ?=
 =?utf-8?B?SHhKSEc0UG9obit0RmlKY2luSTFSMENocWg4SzZVeEh2ZmpjcVluWGs0OWRV?=
 =?utf-8?B?WXd1R0dQejBPR2dZU1hHcURKNlBWMDJwY1QwdFJ4M3JjS0ZsTGdKTXZYUGha?=
 =?utf-8?B?eHBYNlBTMEk0cEtMUitpdlY1c1NtWWJjeGRxRnAxYmlNZy9HTFhmYXM3cTJy?=
 =?utf-8?B?N1pvYWVoRC8wZFdHbGdZMFhDakZWc0FCWjZxK2FlUXhYQnZTYk1kdS83bUto?=
 =?utf-8?B?dHRBTFpCWFpQV0tMenpWcUU5ZklMTS9IZTdMSkVaMWdUUEh5dkJEaHh0Slhz?=
 =?utf-8?B?WmU2N3p0Ym9FY3RvRWlNSnkxUXZ1bUtpUDBNWHpjUzNha2dpeFJuOElmQnY3?=
 =?utf-8?B?UmdYRHdjdGl2Y2F4T2FWamJPT3dsYTNhdVcyUFZKajVvakZTVFZRMHk3aFpZ?=
 =?utf-8?Q?wYtrlBnoRba9nTJCyRCTMYbiWmXg0/dB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0NaaG5hNExoSGlTQllQTHJWdWlqbkE0OFdiSngzZ2Qvd0ZHd2JqU0I3TVk0?=
 =?utf-8?B?cjdzQy9ZaEFnWjVnT2dKUk85dWRQN01FV1krQUpkN2N6OU1PeEFXWTk0bE9W?=
 =?utf-8?B?VmJsSCtkSm0rZmJSckQxZ1J3dG1jZjNpSWdLWWYvd3hEdldpSEZFMVI3Sm9Z?=
 =?utf-8?B?Z2hxUTY0L2NHUGdiYmxYUlFlc1lnaWFpQ2N6WXRVeC9uOXpiQUoxR0YyWG9M?=
 =?utf-8?B?azVZK3lONGdFb1kwczI1VU14dTRBaEo4WWlrZTZPSEdYSTh0d1RPOVZ5SXJt?=
 =?utf-8?B?RC9JVzU0ZytFdUFWQVhXRDBaaThDbldNbkFzN0xPWW1TODhWM2hORWwxUEdH?=
 =?utf-8?B?R3VCU00zV1FoTkV4SnJHVzZnNTN4amErM3lIenBDb3g1QlNNZjVQQU9rMHVi?=
 =?utf-8?B?VnhrYU9GR050UG01bWVtTHZsbFV5LzM1b0Y0S0U4NzhUSjhJQ2t3bjQrTitz?=
 =?utf-8?B?Qllhb3JLVDFqRUZDd3gzNjNjWk95N09aVVRNa2t5d2lNanJNd0RBaTd4T1Z6?=
 =?utf-8?B?T0FSUW50WUtRaVBWZHJ5TXBTblpub2U3dFlMQ3Rqd1N3bVh5NGIrYm5HR1dJ?=
 =?utf-8?B?TVdJeFVMZFB1ZlJITkRmeWtrL1ZTNE80bWNpVGFxeEhoRzZyYVBoWUl5YUtY?=
 =?utf-8?B?NE1oTDBjRXhoakw4a3lseHlQTE1wQXhlVk83MzR5SXJ6T0tBSHZac0NYRklB?=
 =?utf-8?B?TklsL3hISmZzRTJxR3ZrYTg2T1hsUlBWcjJ1cmoveUFhU0ZJTFVQWVIzL1Jw?=
 =?utf-8?B?TVVWcWRvY1gzOERUV3dnbE4xWll5eXdqRDFDRzlOTmlxVTQ3T0JYRnE0SWtL?=
 =?utf-8?B?MWpSNS85TkNOdFBXWVZTdElDYlVGWXVGUHZYYzNVYXhWSVJtUlhMSE1LWVNC?=
 =?utf-8?B?Y3FRdFdWaVNWeVNFbDU3UHpEYXlzbzVZWFZYZUR2NXRmTG9IaFpQL0I5RVNU?=
 =?utf-8?B?b3haSGdGNTZBTWh1L05hRzFVVVh2N3l1VVJxWUl0aDg2ek5hWkNvbjJkcmxU?=
 =?utf-8?B?cVpMWFRsMEQ1NUx3VWpOckNhZk9Ya3F2c20xaEZ0ajlFNzdWc1hwNUd1V2hC?=
 =?utf-8?B?ekhZaU9ucTlLeU1ZTHI5UTFPbldqQUN1R1BuVEtLQ1cvV2xPUURlOUN6U0NP?=
 =?utf-8?B?NXRWTUhNNmxQbU5zOExYcDhHUzAveU5kbFlLdFJtTHltNHdBcDhRN0g3L2lw?=
 =?utf-8?B?alhlVW9lUjNPeG0veTdvbUd5dFErWW5rMFRNMmR5NUlPRUxWc3NrdU9jenZn?=
 =?utf-8?B?cFRQV0dqblRpR0Y3ellrcjNiRmYzaTc1RVdFT0I2LzgvbjIzUDJTdElod1Fy?=
 =?utf-8?B?VTZOVklXREFOaTdxY01KQWQ5L25nMTF0ZEUvRUNnV0hBYnNreFo1ZEJoRlkw?=
 =?utf-8?B?ZUUxbXFqZ0hBN3h0bDkraHdDb2RveERYWUc3SVZqRXBBanVtUEhVUEVqN1gz?=
 =?utf-8?B?VjJsQkJianBiaTBNRVcxWm9HaXBsVjJhRHF6RnNQcmpNQWlGRDdqd3daSndG?=
 =?utf-8?B?ZVVDOVVkQ1dxalpIbWhXOWhVUlpxUFdZekJlVlBscm1JWFNNck1SbEhpbVFH?=
 =?utf-8?B?ajJIVmt1MnBlTWc4N0hmaGJ2dTVnWmozSVNHWWQyTFB0L0RhUkhHamZucjd3?=
 =?utf-8?B?ZFdiR2F2Z1dMeXI4dHQvdlhlODdYcWRyRFZXT0U2aTY2MzRVQnF6OUtka0Jp?=
 =?utf-8?B?enN2UEorZkZ0cjZtWmZUQVVRaVFzV0xpODQvb1ZoUVY1cGpoN3BBQ0hDbE9i?=
 =?utf-8?B?ZlA0bGlsNHRJM2dHR1dQbkNQNDZHZkRQaFVGZ0FhVFI0Sjk1dWFUSm5qNnpU?=
 =?utf-8?B?ZGhEd0dpZjhPTHltL1cvcGo4cHhaa1dwbENWeWdGZ3FIOGRrS1UveVl1QnNX?=
 =?utf-8?B?Y1NQVzgrdWtXcE1Rby91RzVCaUt2V1BZa2xqL0JYSTh0MHIwTWg1eUZLNzNT?=
 =?utf-8?B?NDRHVkY5UFp5amN5MHh4ajBsV3VjRXpiNkNYTHZCWERBcEdPc0JEVFNUbnZu?=
 =?utf-8?B?YUVVOFRYb2VHcXBIK3JKRWI1VEFOaTJjQ0FRTm5xT1RYRjF0blE0Q0RGMGNm?=
 =?utf-8?B?ZTR6OFJod1BFQ1crcms2KzlqOGtkUXFBUHNPMG5WR2YzNGRiN1owamV3MGp3?=
 =?utf-8?B?T2UxdDdKTTY1cmQ3OVNPSk5UOEM4VkMyL1phNHQ0NlBSSEpGR3dLc2lFRlRH?=
 =?utf-8?Q?L+Ah50Hhbt4DdLtkbjdaUPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0AA035436F9140A8CC1E6B44C3C14A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fc4300-a393-496c-2c65-08dd4ac617ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 18:01:21.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8onuS9j7adSfqbmvhp9ERG6OA6KNgq15H/hhi/5mB6EW9rzjh5fYF2epk0qwSBbIstR6RANwoyj8X6xwuQoKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5335
X-Proofpoint-ORIG-GUID: _T4rl5T4HDcKCBgHk3sI4OvTOZIdkC1h
X-Proofpoint-GUID: OJE1eQeMj-hssM1L8DWrBi9IN9SIqwXc
Subject: RE: [PATCH] ceph: is_root_ceph_dentry() cleanup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=691 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110117

T24gVHVlLCAyMDI1LTAyLTExIGF0IDAwOjE1ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAxMSwgMjAyNSBhdCAxMjowODoyMUFNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IEluIGdlbmVyYWwsIHRoZSBNRFMgY2FuIGlzc3VlIE5VTEwgZGVudHJp
ZXMgdG8gY2xpZW50cyBzbyB0aGF0ICB0aGV5ICJrbm93IiB0aGUNCj4gPiBkaXJlbnRyeSBkb2Vz
IG5vdCBleGlzdCB3aXRob3V0IGhhdmluZyBzb21lIGNhcGFiaWxpdHkgKG9yIGxlYXNlKSBhc3Nv
Y2lhdGVkDQo+ID4gd2l0aCBpdC4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgaWYgYXBwbGljYXRpb24g
cmVwZWF0ZWRseSBkb2VzIHN0YXQgb2YgZmlsZSwgdGhlbg0KPiA+IHRoZSBrZXJuZWwgZHJpdmVy
IGlzbid0IHJlcGVhdGVkbHkgZ29pbmcgb3V0IHRvIHRoZSBNRFMgdG8gbG9va3VwIHRoYXQgZmls
ZS4gU28sDQo+ID4gSSBhc3N1bWUgdGhhdCB0aGlzIGlzIHRoZSBnb2FsIG9mIHRoaXMgY2hlY2sg
YW5kIGxvZ2ljLg0KPiANCj4gRXIuLi4gIE9uIHJlcGVhdGVkIHN0YXQoMikgeW91IHdpbGwgZ2V0
IC0+bG9va3VwKCkgY2FsbGVkIHRoZSBmaXJzdCB0aW1lIGFyb3VuZDsNCj4gYWZ0ZXJ3YXJkcyB5
b3UnbGwgYmUgZ2V0dGluZyBkZW50cnkgZnJvbSBkY2FjaGUgbG9va3VwLiAgV2l0aCAtPmRfcmV2
YWxpZGF0ZSgpDQo+IGVhY2ggdGltZSB5b3UgZmluZCBpdCBpbiBkY2FjaGUsIGFuZCBldmljdGlv
biBpZiAtPmRfcmV2YWxpZGF0ZSgpIHNheXMgaXQncyBzdGFsZS4NCj4gSW4gd2hpY2ggY2FzZSBh
IG5ldyBkZW50cnkgd2lsbCBiZSBhbGxvY2F0ZWQgYW5kIGZlZCB0byAtPmxvb2t1cCgpLCBwYXNz
ZWQgdG8NCj4gaXQgaW4gbmVnYXRpdmUtdW5oYXNoZWQgc3RhdGUuLi4NCg0KQWZ0ZXIgc29tZSBj
b25zaWRlcmF0aW9ucywgSSBiZWxpZXZlIHdlIGNhbiBmb2xsb3cgc3VjaCBzaW1wbGUgbG9naWMu
DQpDb3JyZWN0IG1lIGlmIEkgd2lsbCBiZSB3cm9uZyBoZXJlLiBUaGUgY2VwaF9sb29rdXAoKSBt
ZXRob2QncyByZXNwb25zaWJpbGl0eSBpcw0KdG8gImxvb2sgdXAgYSBzaW5nbGUgZGlyIGVudHJ5
Ii4gSXQgc291bmRzIGZvciBtZSB0aGF0IGlmIHdlIGhhdmUgcG9zaXRpdmUNCmRlbnRyeSwNCnRo
ZW4gaXQgZG9lc24ndCBtYWtlIHNlbnNlIHRvIGNhbGwgdGhlIGNlcGhfbG9va3VwKCkuIEFuZCBp
ZiBjZXBoX2xvb2t1cCgpIGhhcw0KYmVlbg0KY2FsbGVkIGZvciB0aGUgcG9zaXRpdmUgZGVudHJ5
LCB0aGVuIHNvbWV0aGluZyB3cm9uZyBpcyBoYXBwZW5pbmcuDQoNCkFzIGZhciBhcyBJIGNhbiBz
ZWUsIGN1cnJlbnRseSwgd2UgaGF2ZSBhIGNvbmZ1c2luZyBleGVjdXRpb24gZmxvdyBpbg0KY2Vw
aF9sb29rdXAoKToNCg0KaWYgKGRfcmVhbGx5X2lzX25lZ2F0aXZlKGRlbnRyeSkpIHsNCiAgICA8
ZG8gY2hlY2sgbG9jYWxseT4NCiAgICBpZiAoLUVOT0VOVCkNCiAgICAgICAgcmV0dXJuIE5VTEw7
DQp9DQoNCjxzZW5kIHJlcXVlc3QgdG8gTURTIHNlcnZlcj4NCg0KQnV0IGFsbCB0aGlzIGxvZ2lj
IGlzIG5vdCBhYm91dCBuZWdhdGl2ZSBkZW50cnksIGl0J3MgYWJvdXQgbG9jYWwgY2hlY2sNCmJl
Zm9yZSBzZW5kaW5nIHJlcXVlc3QgdG8gTURTIHNlcnZlci4gU28sIEkgdGhpbmsgd2UgbmVlZCB0
byBjaGFuZ2UgdGhlIGxvZ2ljDQppbiBsaWtld2lzZSB3YXk6DQoNCmlmICg8d2UgY2FuIGNoZWNr
IGxvY2FsbHk+KSB7DQogICAgPGRvIGNoZWNrIGxvY2FsbHk+DQogICAgaWYgKC1FTk9FTlQpDQog
ICAgICAgIHJldHVybiBOVUxMOw0KfSBlbHNlIHsNCiAgIDxzZW5kIHJlcXVlc3QgdG8gTURTIHNl
cnZlcj4NCn0NCg0KQW0gSSByaWdodCBoZXJlPyA6KSBMZXQgbWUgY2hhbmdlIHRoZSBsb2dpYyBp
biB0aGlzIHdheSBhbmQgdG8gdGVzdCBpdC4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

