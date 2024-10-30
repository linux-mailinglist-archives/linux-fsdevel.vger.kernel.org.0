Return-Path: <linux-fsdevel+bounces-33295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC4A9B6DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 21:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3348282D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDC1DE8B1;
	Wed, 30 Oct 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="INYMn0tu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA91BD9DA;
	Wed, 30 Oct 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320241; cv=fail; b=P/QuYlu0tKPCAVkSnYZwOtvNkiBquiSaAfydjXnBoBvQU4S2krBmUy4S+GJcSWkVTBTZnPFCMfYe/Ir1iWXR/YiCk+n9ShUeh17AYPqPFFHm4Gz8PGf4B/9ZJFxbPg5eoROCcdRaa9hDb05U3h4nMPFkpQgbopIInoJ/kDoew0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320241; c=relaxed/simple;
	bh=UZjx3ckvSaTnSdf+JWiO7oNDnOTNIq0DdVzGw7OwrYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q122AJEWE0Bc69hlH3ZlruzMT9fuAKOoUdVF2IgMDzVbvOajmfl+o54TMEMo/1unFJ1Tlg0Q832rYuXSvkjeANIqaV684To9DiZb7lxuk9AvvhWg3dcDOlHp8ZXwkpcLbQ2TDOslsQAgDgJGFc5dXsV1ZwMWpBl8NTIIijffryY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=INYMn0tu; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJJHSk023151;
	Wed, 30 Oct 2024 13:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=UZjx3ckvSaTnSdf+JWiO7oNDnOTNIq0DdVzGw7OwrYY=; b=
	INYMn0tuf1/pMT+8+sPrj6XNJbPzMCGkLjUhmRUakc0faU/S1KrfDnpNkpH3g0qs
	2tV1iCqb38CVJ1YMTdWPEp7A58dEE6l3O4NSz3U0u6OGwsCc3sqclavBxoBeKtQ0
	bAvhq6+v169VPE2H8kL2gtEawkJ5wPOu7k+9pt52lo2G9NQSs7UAIPrwYGtf6+gM
	YrSXMwFpPKb5IKDk0+NhqbvwOM4XhRz7Bkpc2ig7Jjks+9pzBczNuYWO4vKr51mo
	hDS0e5qCPYqMIr1lqzeJswED6wtZjkyU4O6Ctt2sSIqAfWX883tMMEYGLYJSYGqI
	KoNFSXxo7iWWQwfLqDfIOA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42krwy26hk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 13:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNWrtXVOFAdAtM7Vkfo//s1ci3g1/eIDd8cr04RG+HF7MlBv5b9BYVcZoIFJARzBFx6cLTGBzTbNpSBs8mjwiBgCi4qlC+TdWI3rwivZ4181Ff1iqfczUqCavpTneprn3cj8L0n7uxkkTIIZNIkrBOPPi8N7wBBep4j5TlwjtMRUsp1lQfQ87bwbMJRHgzJ4FcK/aruzIvUZHRqoisyrvvVNLO9oprmLX3ztQs1ohf55mfpz4uXMeT1wvp5RWEGEonZtuN9TWA/Ee5b2z86ZyOlyhwF2zzXxbQZS5+fREGTh7ix8h5VBimfka9HSoBJuTSSBFzVwdSEkjLr9/WOarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZjx3ckvSaTnSdf+JWiO7oNDnOTNIq0DdVzGw7OwrYY=;
 b=qLdAcgKpDaoIU3pVU+3Pf53LVb+mAonWXCuusWdwnqHwVV0sIUgbNOzzEeR4CZgeW6ObrHAJO5WgmG+knCT5WGp7MJjv/u1HCmqwyjJ+CkieZtM3bEvic4RenwPiQ1uz2DKirD3hY4p9dNBPQSO8oQbd28BsszeIW1gDwUxv6/40RmMVkE2dan55mbzZ8vxSsJTsU2tX3UOxOlzlL5a+vAE0QYH1LjsQICJvkgKXGks98CvivKT1vvSMF5D3Dmc1rr0GgANbZDm7OaR/j6hFb7CUI+kAVWd4+Bjn38XKEH4FpQAEejytZ9HqjuBry0bmSToTpg6Vo7vfFjYqGkfp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB5682.namprd15.prod.outlook.com (2603:10b6:806:349::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 20:30:30 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 20:30:30 +0000
From: Song Liu <songliubraving@meta.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index: AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKfQ4eAgAB824A=
Date: Wed, 30 Oct 2024 20:30:30 +0000
Message-ID: <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
In-Reply-To: <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB5682:EE_
x-ms-office365-filtering-correlation-id: bcf865a7-32d6-4e80-7f72-08dcf921b279
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzhYNU1wSTJaNnpBeGFxbEtRbGdnOE1NclRUd2ptMHBEWVRsMkJJNFd3S2ph?=
 =?utf-8?B?YTI5VjJNcm82bHdHbS9odjBjekJpa1NWKzdzbEVDNGZqeXdNL241bUl1V0tP?=
 =?utf-8?B?dkFjaG8yM0hHclpLcVF5dVBRK2MzbFZXK1VaV1hhaHNzZ2FkZ1NmclVoaXpY?=
 =?utf-8?B?Ym9FVFZaNWtmSDVaWmhhRnZWSUtnZnZ2Z1E4MDd2ZXFUclBTTUVkN1A4RFBw?=
 =?utf-8?B?eGRRYmFyejRrcklNODZPNk01cllCNXhVbHY4QjdVSkpma2d1a2xmYnAwWGQy?=
 =?utf-8?B?UWJ5dm1NdXlPd1dwengyQnpjYS9YNU44RGtROUdnMFNkYW5neFB4ODRVQWhy?=
 =?utf-8?B?MldSNVpqMTdIcU5SSVJXcVNCNzRFa3hoOVhsZFhZc2huS3YzczEwZkx2eXZv?=
 =?utf-8?B?MEQrK2xpRmtreE9oNTFvdjQyRWR3Y1FlNDhLUytwMUNvOERkaDg1aUZBVnFS?=
 =?utf-8?B?WkVJc05xWEZEZ2NFenI2ZldWdFR0bFlVM29TQlM5UldZN205dUhoaVoxZUFC?=
 =?utf-8?B?SGRqaGhtN0lrSzhBNERQaFVXZTVrVlJwNmhocnNoNVIrTWhnSHRLaTBxU1ND?=
 =?utf-8?B?Tlc5ZTM2Y05qMjFJT09Ia1JHVk9YQmVpc21md0hjb2V3WlBxWlA0djRFbzVB?=
 =?utf-8?B?aE92RCtaL0orZFFPQXIxdXVieWlhb09rbVFEOVNtNkJEK2N6ZlljeWFIYmR5?=
 =?utf-8?B?QmpJWG5tY3pDR1V5SkhCOXNGOU9DcnN5WGJnMUhPUnlqajF3SG8vSXVyTy9S?=
 =?utf-8?B?RG9hb2ZmS3BnQ1QxN3dUVmhvYnVnVWJWREU5dUg2cWNiTUlpTUNjMkpWQUxL?=
 =?utf-8?B?bFB3TTh2SUN6VVgvaUZnWHRVdXNZZUdRaVlLMGJKK0N3dXlkaVlOWVhCS0NC?=
 =?utf-8?B?S0FFNWVHR2dWQ0RGa25ZUGl2blp5U043QkVoSE5BYkxDNkhkWGFscHNkWWVM?=
 =?utf-8?B?dmJYNHRkNG1tYTkzLzA0L0dHeVVoZ01mUFNhenJNUGRRVXcrUHE5Z3JUTlIv?=
 =?utf-8?B?SjhtQ25jdHVCcUwzakQwYzdYT1grTWtKUlJSWFFCNWpSQUV1WWpVbTlJbm8v?=
 =?utf-8?B?cjQ5VnMxZmd3SFdlUmxiTXJpZys3QWhMT3BPSGFNdms4Szl5dUsxeVEzaldW?=
 =?utf-8?B?Z1Y1OS9SMTN6OFJ0aUtZbkV1Vkpoa3RmY1lWeGJHT2doemVCS3NzVDhVUFNh?=
 =?utf-8?B?eS9HT08vVkszOHpCOWhRay9aZ0F1TlF2VW5qR3dBb1VCTXk0N3lSSUh1V1gv?=
 =?utf-8?B?SWlMWTlKNXA1ZVFlQmdYY1FKRC9IaWVVRjJmaFh3S0NQTmpQanp0RFREVFlV?=
 =?utf-8?B?NW5KYWE3Y2hCRVg0RitPT1RvZ01QdDUxRTIyYVRJQWVhczhGNUNtby8rUjNU?=
 =?utf-8?B?QldaNkJkb1FNclRQclVWQ3BPdXB2Zkx1S3BreG9KZlFHbDFvTGZwdlJuREts?=
 =?utf-8?B?RnhtSi9sQ0U0d3ZBYUNJaHRMSmtOdUFHczk4U3g3RjhhVzFhWlpkMXFjNUsw?=
 =?utf-8?B?WkwxaHRDcHFQWnhrckZlMnhvRW9NejhBbUFoSWJzYlM2YVFVZ2YvMmZLYy9q?=
 =?utf-8?B?SHQrZC9pT2JQenRzdUk0YTYyOGg4N240dGVnWlVuZmtDaThJSWNJUWRMb25S?=
 =?utf-8?B?U2VHMVNXMWRLTk9rOXV2a3dZQ3ZTOVNPRS85b0dZZm9RWFlJZ05CSkR2RGlZ?=
 =?utf-8?B?NExRakxmbm5JeWZsak55c3FIVHlhVHFSSUdTcTJMMUY1VzQ3Z2Q1T1FaaVBk?=
 =?utf-8?B?c2RBaUFRd3FoeUd6OEtUUGR2eFZWU1haM1V1QkNGYkp5MTJtSHhTdzl3eWdr?=
 =?utf-8?Q?tBNBzztotEpQ4NCkA4mQ1D3C1gFUg9rc0ZxhI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEJtWmkzQlllcitaOWNEb09NdXpORnVUU2ZrU0xCalZIYmwxTko4MWw2VHlD?=
 =?utf-8?B?WDJ6TitIOWRCcGhac3ZUdGQyU1oyM2F4ZUFvSzBnK041cXRqV1ZJR0tOQ3dk?=
 =?utf-8?B?d1d5UzFhR0x6UkNreHE2MnNPaCs0L0xkbFUzeTQ1YjZxYlZJSjNwTjZqMDNv?=
 =?utf-8?B?QThzdHZyQ3IyUnBnQk84b28vYXhaMm9oa1JsdEsvQ2w4a2UxdmN4MFo4cC9T?=
 =?utf-8?B?WHlxTmtVL2xnK0NSSFF3TzZFVjdSajdaQWNoSmR1NkpxaE9jN1hnZm84a3ZL?=
 =?utf-8?B?S3UybmJLSVZmVzNMMmNDVnJwaWhpMGlYNmxaZUdwNEkwVnIwQUlvZUxROWhk?=
 =?utf-8?B?dlZ3RmVlMFpnbDhLWXhvRVV5SlVpSDQrQVBWT0tJNUhSQ0o4dHZZOXdmUVNC?=
 =?utf-8?B?cHZhcyt6eERpVHhQcCtBQk5leUQ4R3hFbUFrMlkxT0hnOFpTZjltTHpzQ0oz?=
 =?utf-8?B?WGJQRENORlcwdUxIOXUyUG1iVm41VHNGSy9XSW1mUzhBTEtNV01Jd29lWXNy?=
 =?utf-8?B?Wk9rSkhXczlwcTVaemxJVGowellONEFLSXhhYTJGUUhGVUtDc3NhaVZiRjB1?=
 =?utf-8?B?akpJY1JQbmxtb3VzSDl4WjZYT0EwTmVSZ003NGozRyswc3NxUm92TkZoTDVJ?=
 =?utf-8?B?TzdHSi8yUTBvYW1QYUw0VHVITmdKaVJqK0NEWUlWRUMzUFo2OCtBLytPWlJP?=
 =?utf-8?B?aWdTS2RCcHJXeFpGRHRVeVdEdWF1N1NPdG45SDFEaDkyc1JpRzRMbkR0OHZu?=
 =?utf-8?B?K0NTVEY4aWxqMmI5Ukk2T2wxU2lzYm14WEdST3crS3FUcFZBVGJiSFdpc094?=
 =?utf-8?B?Ujc0dS9PU1B5Q21YcmE4R0kvYnBZRFo0bXhCQi9CTEsxdFJCcUEyQVN1VjZm?=
 =?utf-8?B?Z1lMYkFjeC9nUXp2bjBham1Ubm4yYVRic1RDMXQ3bmlYZ2xCSHQ2L1BEaXJZ?=
 =?utf-8?B?WHZ5Mkx3bkFCZklXQXpBaUI3cEgyeTlWYWU5N2lJV2VVRVdaRFZFVWdtN0Vi?=
 =?utf-8?B?WXFOZXBKb3dzZ0RRWUdnVS9qVWlVS1NObHNCaDZBeEdQOVN5aG9maG83Vi9G?=
 =?utf-8?B?RHZCeUJJbStIK1VxK0tCVjVMejBIMmoxYk56WVB1eE96V05Fc1RYRS8rbUhE?=
 =?utf-8?B?eGw1MzFEL3BaSWJXdC95OEtVMk12K1dnM3FRUmc0V2FWeEg5MmZIUG1va3ZM?=
 =?utf-8?B?bTNMWFEzNkZMSFMzV2tpMkNXa0dva2xnSllneUFGVEVnODZWbCs1WEZFVTYw?=
 =?utf-8?B?NHIvcHFibTFPeThMWm53SWZ2c3YyQXJXblh0RzR4dzE5bHIxSG5YalNXSkJY?=
 =?utf-8?B?YUp6VitnVjBTUmMyb1EyZXdxTzRuNTR0S0VnYTg0M2NiZkx5MVQzNDlYdkoz?=
 =?utf-8?B?enhkUWRsTDZ0MXpqQkErRHEzN3pmd1pNaXI1Nko0N0MrVnBvYzM5emRPTEd5?=
 =?utf-8?B?VFVMbUMweExYUmdacGlvNTlQMnhRSW92OWtCNjN0WmF4aFNGNzZTYnN4TXBG?=
 =?utf-8?B?bC9kVWVBR041d1lTeU1PTGR4bS9YNjJ4MU12V1FTUWZoRTNQcUNxdUN1L1VM?=
 =?utf-8?B?cHhUZDJUZldhZjYxRXppQ1dpdTFRWHNBSXZHNUtLTG1IWVFKbHp3MzkxaFlS?=
 =?utf-8?B?UWUzNVl0UmtNZUdMS3AzYTByTk1KUlJpVy9zQkQ4V09ZRFl5Z3ZhSmZrNGxZ?=
 =?utf-8?B?anhJTWZlMjk4KzJqa0ZvKzRId3lQdTRhTEU5L2lmeWZIRk9MbGcxVE5MRERl?=
 =?utf-8?B?Z2o0VEhIZFFxQy9UY3dvY0k4YTNDYVVKbjBDLytnS0JFWjM0amFJa1Q5S1NR?=
 =?utf-8?B?Z2F1ZFF3R3pseVVNK1ZXUXI4ZStrZnZWQ2NlSlZvN3RmWVhTYUZ4S3hEQlpa?=
 =?utf-8?B?SFhWbVJpSWFVSDZ2cW1mdEIvUVY5SjBKdzY4M3JHa2h3MUY0UTlmV25tb0x3?=
 =?utf-8?B?UEU5ZjFPS1Q3QWlPUU9RNStLK1lSbFcwTkd2T1J3UmR1TDZJYWF5bXZmQ3F6?=
 =?utf-8?B?N1N5RDg2MDZGWWxtQ2ExWlVJYzdiNzQ5M0dWUnNwRk1KbkdMaHpnbEZsaWRC?=
 =?utf-8?B?bGoyNlpnZ0Fld0NXVWkveVBwQ0V4ZEFwQVpZQ1poSlVZZG9QWW1DOGpHb0Zt?=
 =?utf-8?B?OFdwVXFMRmNUa0kyY25zczk0dkh2NnJnczBRMUZlaWdjWUsvNXNKWU5HTWdv?=
 =?utf-8?Q?taPMKn+4vERvPhyz2yg2bN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39B75C84A5E7E4A86F0ADE734E26D5E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf865a7-32d6-4e80-7f72-08dcf921b279
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 20:30:30.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNbNYff9zOsLoZrUf+XuAxgYKPOMx/Li9zxigkKkEIcqzoIBaGddK5nGfpWaKLXPL72OTuOQJ9rWh1feohwtxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5682
X-Proofpoint-ORIG-GUID: IIEfurIgAl0h9w3hlZ8qV8ewo6YqIWLx
X-Proofpoint-GUID: IIEfurIgAl0h9w3hlZ8qV8ewo6YqIWLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgSmVmZiwgDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCkkgd2lsbCB1cGRhdGUgMS8y
IGJhc2VkIG9uIHRoZSBmZWVkYmFjay4gKFJlcGx5aW5nIGhlcmUgdG8gc2F2ZSBldmVyeW9uZSAN
CmFuIGVtYWlsLi4pDQoNCj4gT24gT2N0IDMwLCAyMDI0LCBhdCA2OjAz4oCvQU0sIEplZmYgTGF5
dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiArDQo+PiArc3Rh
dGljIGludCBzYW1wbGVfZnBfaGFuZGxlcihzdHJ1Y3QgZnNub3RpZnlfZ3JvdXAgKmdyb3VwLA0K
Pj4gKyAgICAgc3RydWN0IGZhbm90aWZ5X2Zhc3RwYXRoX2hvb2sgKmZwX2hvb2ssDQo+PiArICAg
ICBzdHJ1Y3QgZmFub3RpZnlfZmFzdHBhdGhfZXZlbnQgKmZwX2V2ZW50KQ0KPj4gK3sNCj4+ICsg
Y29uc3Qgc3RydWN0IHFzdHIgKmZpbGVfbmFtZSA9IGZwX2V2ZW50LT5maWxlX25hbWU7DQo+PiAr
IHN0cnVjdCBzYW1wbGVfZnBfZGF0YSAqZnBfZGF0YTsNCj4+ICsgc3RydWN0IHByZWZpeF9pdGVt
ICppdGVtOw0KPj4gKw0KPj4gKyBpZiAoIWZpbGVfbmFtZSkNCj4+ICsgcmV0dXJuIEZBTl9GUF9S
RVRfU0VORF9UT19VU0VSU1BBQ0U7DQo+PiArIGZwX2RhdGEgPSBmcF9ob29rLT5kYXRhOw0KPj4g
Kw0KPj4gKyBsaXN0X2Zvcl9lYWNoX2VudHJ5KGl0ZW0sICZmcF9kYXRhLT5pdGVtX2xpc3QsIGxp
c3QpIHsNCj4+ICsgaWYgKHN0cnN0cihmaWxlX25hbWUtPm5hbWUsIGl0ZW0tPnByZWZpeCkgPT0g
KGNoYXIgKilmaWxlX25hbWUtPm5hbWUpDQo+PiArIHJldHVybiBGQU5fRlBfUkVUX1NLSVBfRVZF
TlQ7DQo+PiArIH0NCj4+ICsNCj4+ICsgcmV0dXJuIEZBTl9GUF9SRVRfU0VORF9UT19VU0VSU1BB
Q0U7DQo+PiArfQ0KPiANCj4gVGhlIHNhbXBsZSBpcyBhIGxpdHRsZSB1bmRlcndoZWxtaW5nIGFu
ZCBldmVyeW9uZSBoYXRlcyBzdHJpbmcgcGFyc2luZw0KPiBpbiB0aGUga2VybmVsIDspLiBJdCdk
IGJlIG5pY2UgdG8gc2VlIGEgbW9yZSByZWFsLXdvcmxkIHVzZS1jYXNlIGZvcg0KPiB0aGlzLg0K
PiANCj4gQ291bGQgdGhpcyBiZSB1c2VkIHRvIGltcGxlbWVudCBzdWJ0cmVlIGZpbHRlcmluZz8g
SSBndWVzcyB5b3UnZCBoYXZlDQo+IHRvIHdhbGsgYmFjayB1cCB0aGUgZGlyZWN0b3J5IHRyZWUg
YW5kIHNlZSB3aGV0aGVyIGl0IGhhZCBhIGdpdmVuDQo+IGFuY2VzdG9yPw0KDQpJZiB0aGUgc3Vi
dHJlZSBpcyBhbGwgaW4gdGhlIHNhbWUgZmlsZSBzeXN0ZW0sIHdlIGNhbiBhdHRhY2ggZmFub3Rp
ZnkgdG8gDQp0aGUgd2hvbGUgZmlsZSBzeXN0ZW0sIGFuZCB0aGVuIHVzZSBzb21lIGRnZXRfcGFy
ZW50KCkgYW5kIGZvbGxvd191cCgpIA0KdG8gd2FsayB1cCB0aGUgZGlyZWN0b3J5IHRyZWUgaW4g
dGhlIGZhc3RwYXRoIGhhbmRsZXIuIEhvd2V2ZXIsIGlmIHRoZXJlDQphcmUgb3RoZXIgbW91bnQg
cG9pbnRzIGluIHRoZSBzdWJ0cmVlLCB3ZSB3aWxsIG5lZWQgbW9yZSBsb2dpYyB0byBoYW5kbGUN
CnRoZXNlIG1vdW50IHBvaW50cy4gDQoNCkBDaHJpc3RpYW4sIEkgd291bGQgbGlrZSB0byBrbm93
IHlvdXIgdGhvdWdodHMgb24gdGhpcyAod2Fsa2luZyB1cCB0aGUgDQpkaXJlY3RvcnkgdHJlZSBp
biBmYW5vdGlmeSBmYXN0cGF0aCBoYW5kbGVyKS4gSXQgY2FuIGJlIGV4cGVuc2l2ZSBmb3IgDQp2
ZXJ5IHZlcnkgZGVlcCBzdWJ0cmVlLiANCg0KSG93IHNob3VsZCB3ZSBwYXNzIGluIHRoZSBzdWJ0
cmVlPyBJIGd1ZXNzIHdlIGNhbiBqdXN0IHVzZSBmdWxsIHBhdGggaW4NCmEgc3RyaW5nIGFzIHRo
ZSBhcmd1bWVudC4NCg0KVGhhbmtzLA0KU29uZyANCg0K

