Return-Path: <linux-fsdevel+bounces-73479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB3D1A943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC86302AE27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D472FE042;
	Tue, 13 Jan 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gL0OllHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718134FF49
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324731; cv=fail; b=H2U29TnmQB5FFsArkmsbJ+CjSQvXmVS9f8+vq2w7Xw9S57iPsh/XLzB2cBr3IBJxzUGgW2jLx/mhj5o0UCIIOXvc+2TjCytpnDpDtKboskkvQQOhRWOihmnj0CG+BaRvJ2SwBqu54PmY3+mTZfvkimaJnkO6TRweAvy/Py1OWy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324731; c=relaxed/simple;
	bh=Y65RouG9iK2ECWMN17htPFxBkSwef/Do/d9oWP6ICnI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Fn4927TvvfxR1gF0nrvFYohbpGQIcMDFPdJAb1jqXcXC7TXIsB+ox3Xk4K2w/2I1j5XzqSGuuFBw+HNLKgooDQ9iKZCV0zcm/1IeMR+dTTDk/ZoS/0lRUcX/WxvJrEXsV9yvuWkkT+tBN/RnGHg9fwWrTaoNsv4wZzqqX/QfW+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gL0OllHN; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D6KPb0019505
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+aL+SCgzU6XbCse+eTYu6b3q3hCRSyUZv64ucqFmvMM=; b=gL0OllHN
	Qpys0qx0SokwDAFPRpqUYw7K0mUwstXsbD4Oel7bd0E4KQ9pW82xG8QBYN48Ib/J
	ptUgz1PXizlaIKW7IGjs68eVc4LKbqHaBU46wSXqhcPbefoi9GLQcK73Bn7GLp7u
	CWZAVdHpU6DACE3k2eaABk61BIphNG4fTMK0dIO+lWC1xF09AqHrrQNgi2V/G/hI
	nV/xv7TwNKWcQnL08VWFmScf/F9Nb2nVkQVlClcirwdFFejA4AE08LgTWJPqO8Wf
	i8X/ROKyBdfkq6NjMwvtWwsj3bzKpWoxwaBQSVmurSmO/bWofUTzLDsezVSNTX7d
	EfNIAVO+65rqsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4dm8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:18:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DH7jB4006340
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:18:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4dm8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:18:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DHHZT2027731;
	Tue, 13 Jan 2026 17:18:44 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4dm87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:18:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4eQpE1GfFPMpV4CuWkF2JmBwl/y6dOcEvdQJNVHCYA9MWGfFxlcIOUqvJnVtwQCvqzmUVOOcQ6WXAoRFUHQ7nhOyNQPT3YGquU+6iD//sjEMxglc0uNUbVrWOJ8SU2l66+OYAWiADfsVE4k5cqISeFL3OCpvFGpZS+4OHvVInTTKDbIyZUtihzD6dL6dHz944loK0e3sK3ya40ayywyo7wHAQju2Bv5RPgaBoVlDNlhnCLETwkmCQzORMZ7cC0UnksjUPs8ki57PNCKR/+dDvvBfAgbDkeWcBrotn+q/XpFsoz1gEc8lvdUcAKPXNzmLV+JOouAXPShnooig9ldbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCx8NVORP6K2ff6gEwfsN6zK2/KZEAd+s2ad/GMFIuw=;
 b=VALUvtUv6S/0/Y5kbdDGE8cI3ODgA73KPQbRkyzhJGgfQu6Y9fry/K7goDuJ1YbZibwC+x4n4Am5TtdvOlMAA7mGQLklWML9FvHNnIzyP19N2qdvjH6tIlT4y5qUKGxvtu4RBbfr5jcedMZdloHxQmwHbT8Rha+w8vacqcZIgVnk3AEovf3XDTogEheG35tTB6k5HEoBkYz+Snn9dEBRJjlAhFN5CDGXAjvmFMWy+PF4/WfRs9EN5CuSOdKokZrqgaPuAdtUkKqxbvmYudlsb6mvE7Wry9+nRw8APxbdDPRH9Bpg1OBDzQ+duNts4oePEGlYQX5KvMW5uighIVRtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6519.namprd15.prod.outlook.com (2603:10b6:408:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:18:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 17:18:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com"
	<syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kapoorarnav43@gmail.com" <kapoorarnav43@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfsplus: pretend special inodes as
 regular files
Thread-Index: AQHchGprpbzFOmP7qkq/BjkOY+a4vbVQWHyA
Date: Tue, 13 Jan 2026 17:18:40 +0000
Message-ID: <92748f200068dc1628f8e42c671e5a3a16c40734.camel@ibm.com>
References: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
	 <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
In-Reply-To: <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6519:EE_
x-ms-office365-filtering-correlation-id: db1cbb39-e8b2-4703-da21-08de52c7cc0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eldjL1QrRXltWmVqUkpaTERqdXpvQ3pmVTVHbk1BU2ROK3JCOXVuR0tobFpY?=
 =?utf-8?B?bGJDb292ZXFNeW9KWHhyN2NKQ1dleDZkQmw2TkVNaVdSYzkzRlQ1V01MRSs4?=
 =?utf-8?B?cHdVeGY2am5GSWV4ZnAxSnJnK1B0N3dIQnZHVUtBdWVlRklFaDNrZVBmd0hL?=
 =?utf-8?B?MTV5eVd4TFBFNGhRNUJpZ0V4by85NGRaa3I5Q2hlbG0vRGRidHRpa1k3aWFT?=
 =?utf-8?B?WGNyVkY0QnluWEViRDBXTlY4OU56UE1TQkliZEM5U2ZjRW1hVTI3Wnd6WUVo?=
 =?utf-8?B?V1FlVXZVaGZhVGwzNGFMK2JhRTVWRE14Sk1mTFAybEFpMm03M0VLZy9LWUI3?=
 =?utf-8?B?SGF6SnRCN0dMSFdPbTZveWdVRTQ4MFhlQkMvVVhSZjVPbFFsMVZrUzZya2kr?=
 =?utf-8?B?S3hiM1NlWDNkRWV0cVNhemduWmx2RjFNWG9SUGJaazM0dkZiQUdxWStFdGJl?=
 =?utf-8?B?VUZXejA3NGwvTTRkaVRnaFZsV01yVGVFdGh4QjFlU2pvSFN6enZjUWgxT2Ju?=
 =?utf-8?B?NHZPMXhWZkdydUwwRCtDbkhSaEdUcjJqdWxuZnMwUzJJL29iMVV5Yy8wZnVo?=
 =?utf-8?B?RndEZDBxV1NzaEs4cytuSy8zT1UvWlJweDBTTk56OEp5dnRBeHFBNlk1SlhG?=
 =?utf-8?B?d3ljK2hSbnovQU5DREVMYVRDTEY5Kys2S3RYejBWWVJDQytJN3hvK3NZNllq?=
 =?utf-8?B?RWd0KzdBdXVDTHBNaGVvWForMzBlOFBTTmlITExnL0VEZWttMXdTaktmdDhn?=
 =?utf-8?B?K1NYbHVLZHUrcHIrK2xqMVVTaWFrWEFNQ1YzQWgyNkZxT1kxRUlSbmMrb0xL?=
 =?utf-8?B?TUloTTh1VG1NKzJheXlaK3RYSUdZdXFKRE1DKzNaU01CcGIzM0hDb2ppMFpi?=
 =?utf-8?B?YW1ablZnVzVGVy9sRDdKeFA5aDNXVVJBWDhLYjdKZ3ZLOUNOSEtDSzhSa3pX?=
 =?utf-8?B?TGMrRllmTWdkTnVidVh4b3Y3UXN0VmZNRG9TVitneG9EdnJQZFZqMVFYWm42?=
 =?utf-8?B?VkYwbXhzenRYcVo1T3ZEQkMwY0NSbkc3cWJNTmpjaStDeXVucnBZa205Y0FK?=
 =?utf-8?B?YUNrY2M1d2VRaTlRdWhJcVNTMHdsajBYZTlsNERXdldxYXFQekpPbkhJdEtl?=
 =?utf-8?B?clk1NTE5bHh1ZWtKbUNoeWFLSkRub29abGFHSkRDS3c1Z3VlT09zNFBZZU9n?=
 =?utf-8?B?aWdmendOVDkvRlluMlNkVzZPZlExWnd2d0lTWm5sOHBldlJsU3g4U1orYnJL?=
 =?utf-8?B?WWUrdmxSbU1DZzBNWFIyelRPaHR0THp4NWxNb2ZXbk04ZXpZQ2RWVDA0eEky?=
 =?utf-8?B?U3FGSXZ3YUx5WmhkaldVZURNZVhwcXhPcjBOVkhsekxjaWZHNGhuVU1pWDVz?=
 =?utf-8?B?QUJRNDZRZHIreUtYdXh1V25rMGZNck9XMzNEemVKRllmaWxud0JJdlcxb3Qy?=
 =?utf-8?B?bUhHSEQ3TnYzNnZBR1BwLzBQVzl3SlB2Q2hOeFVFOE91RWpQaFlVNUI1QUQx?=
 =?utf-8?B?MndRbTFMVlhnRUVtdkdjbmtuenZrOFJKUlhoakRmNjRUY1JyOGJzdUxiRlBi?=
 =?utf-8?B?bXRLb0FrK0dXMldkQkl1K1hhZzUwOWlrcWk2U2dJNnFIT2NNcWZ3YUVlTHd6?=
 =?utf-8?B?SGRlYjh1SWRyaFRENTBJMC9JckxPWE1LTnQxcUloZWNXYUpCeHJ6RTlEeExL?=
 =?utf-8?B?OGhvMUNSWFhuR2lFbmRtNjM5eHFYc3BrVHVBN3B5TTlyd21iWXZzSzhIK3Fk?=
 =?utf-8?B?Q2xzSFFwNDc4YnJCWFYwbVpzcVdBODgrUCtmNitiWWo0Vnd3bnlNMklxOTc2?=
 =?utf-8?B?eUlFRENZUFRnenhtUWg1Q1dabE13L2dOWDdLUk1EdjRwbXg1NEpCYVdJU2ls?=
 =?utf-8?B?NXlicFgxMjdZUEo5OUt3NXFmOUNkNjB1UDBpazhGOWpJNVMzbUg1cWJRVE16?=
 =?utf-8?B?RkxUMHV4WEhsbVl5eUpVN2NOVjdIcGMyZWZqWVNLNGhJQitLeEJBYVU4VWRY?=
 =?utf-8?B?UEdOTkFsNCsxRFVIL05nVWlCUmJxc1h5bUVwMUl5QzRVRW1Fblk2YUl1ZmFV?=
 =?utf-8?Q?ALXlXQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm5lVXhyV3c4MktLczFSOEg5V202aUJvUmxrb0c3d3VuQ0pob0FzL1BNMmJy?=
 =?utf-8?B?dXVSK2hFdnp1YXBGQ2hxV0l5aHJyYS9zcnoxVjRFSDBjVWMvRVhJaDl1dzdi?=
 =?utf-8?B?Y2RUMWNXdVhtOFI5RGYyN3FING5KVVNvS09uVXp6UWtoS3ZRSDBNUUVDQUQ4?=
 =?utf-8?B?K0dMT1AzSFpyTi82enQxU2d6VHZBUG94K0NnejJZcXR5SzRhK2lNUG5sUmJ2?=
 =?utf-8?B?OXFKTnNTeTduOUQ2V0NyL3J5Q3g0ZFBZaVZPakYvbEFPcytDTXZ0Wlh5M0p2?=
 =?utf-8?B?Yno3ZjR2bWdMREV6eGVDL0FXMGdkSGhEQWY3SExwellaQVpPZmhiL3loeTBk?=
 =?utf-8?B?UUNNMENJbkxMNmwvM3hOUVFQbVJ6VVUvSFJxQ2s3NmxVYjUrNGoyNy93azE1?=
 =?utf-8?B?VG5FQUoxWnI1UFMyOFhwWWZYTVpvaEdITGt2dzNBeDhsaEFza3RNYUdJSHRw?=
 =?utf-8?B?RktCZmR5WXk0SVNOWmZjR1ZoM3FrWC9GWVdjVy9HN21qNVRLQlU3NlB3dUMv?=
 =?utf-8?B?Vm9ham05N1JJM0ZoeVBNNFhuY2lqN0NuL1dWMFVVd3lSRlpFSXFSMUJPWkdH?=
 =?utf-8?B?cUJOT0NBdG9mNk94WkpmSzQycjl4RytDd3JxYTYyODVZYjBCdENLMU1ia1NO?=
 =?utf-8?B?Z213ZUZ6ZWhzZ2lhRlZwNG1JUXJaTWdLRzhTbU5rTWdhQlVNUytaRDErVHB1?=
 =?utf-8?B?QUxaRnA2K1QwbjI5c1NBWHlCbVdPenhDaVEwbU9vRFM0THo0ZytlRXZVV21o?=
 =?utf-8?B?Ujh1YzZaV0RiemxybUFXbUY1alVWZTNxR3dheEp3VStQazlTZHJzMHNFV1ds?=
 =?utf-8?B?NVRoN1lROVU1aGtEVStBNk5OZ1pDeHRONFdLNWluZjNVcHFWUEJXWlgxN0Zs?=
 =?utf-8?B?VUFHZUNyN1pxb3BRYlJhSVUzZjhMSGhjV3ZSWVpzOC9oNFc3WUtYbTBOVUJQ?=
 =?utf-8?B?NXlYaDJNckdvV0psSFBwMTZGeUVUdEx5dVdYc3VRc3htSXpoWjBvS3AxRnhx?=
 =?utf-8?B?ZXRvY1lHNXNndjA4Q0FlNW5FaEpEVnVzSjRiaWJNb0hSY09qUCtzMGt5cmlj?=
 =?utf-8?B?ZnordGk2d0dBMWY1SlBKd3E4UXV1WS9pS0NRdkdnOTFZOU5rbXBkaEYrUlly?=
 =?utf-8?B?L3JSMS9KNG5ORW9FeFBuVEtYV2JDMjh5VnlGYkg1cE1KRXl4Wi9ENEJXSW1y?=
 =?utf-8?B?bTZpWmlKWTh1SkQwV1FPZVhwRGczNDBycm44VDN1cXBvaGlxT0JKMEZQMmRT?=
 =?utf-8?B?SU92Z25ETDJiT3U3cExtdWZOeW85TitzaDM3d2FJS3p2MW9qNnh0b09oV1Zp?=
 =?utf-8?B?QkZLZDE5Zmo4MjdTRnVSV3o3cnZvOFJyVDlDQlhObFo1L1Jyc0lWRnBVeXRF?=
 =?utf-8?B?TDIyNmNVQXBJTEhWUGFqR0k4Y3J5eE82M1F1VDJ1WUxLbC9MTFVlNmpqUm9N?=
 =?utf-8?B?eUZySS93K2hFV1pWTFRubDNHTmF6M3VRd1pxekZ4Nm81R3VDTnA2elNwRjFP?=
 =?utf-8?B?V2RqT3FmZ0dDazZxZEtabGgwQzBkMitWVUpMWXIyS0RjNjgzSzZONjJzYlV6?=
 =?utf-8?B?bDVuYVYxRzhjdmpxelVlSCtSYUVENUQzaFNhUFQzQ2p6ZHY4VE1wcTZ3Q1BK?=
 =?utf-8?B?V0xBMS93Z2pZcjgwZ2NCT2VrN2pHclVtUkI3TDZWWVlWVUluclJkNXJ2YVd0?=
 =?utf-8?B?cHBsT1lPVllFaTJnTE9ELzFMKzhnYXhXd0x4QWVRT1pKZXVrbWJIVE1XLzln?=
 =?utf-8?B?WFFWOEtJNmdyMXVNOFNrbW1HOGpZNnB5R1cwSDdBQ1Yvc21zT3l1QzVGWVBU?=
 =?utf-8?B?RVl1dTRhbThVVEluS3FuM0ZwUTF6TkordkJ6MGE0WHQ5OEdqbjBTNERUZGdD?=
 =?utf-8?B?OUVOVHNtNjBuQ0RzN25JUDliMFRGK1VYN1VKU0paZmExRiszRUxCa3o4R21Z?=
 =?utf-8?B?SnJHWmJaU3BPbWx5VUkwQ3FVbHNwb1k1N25IZ2lyLzFGTVJUQzY2UFI4RnVC?=
 =?utf-8?B?WE5zKzNVc2FBVHRWZlJBd0J5ZVdGeXRDRnNRZXZBNzJPOWxRNTl5WW9YMjY0?=
 =?utf-8?B?T0hTTWpSRHU2ekUzRzZWY3Z0WkxwZFkvYUlPaU9KY3ZKYStSK25sY3BZOW1a?=
 =?utf-8?B?MTI1MUdKbGY0QVpXMDdBcWdyWmVjeVY5eHdBV2pMNys2eUNRemVBa2xPWkVC?=
 =?utf-8?B?enpva2I5QW0vanZ5WnFNcWkwMG8xTktzOHB4RW4wUkI5bmhFVHdxTXp3QUhH?=
 =?utf-8?B?MG11dTJMOVdsenJQRGxBYnRQYTZ1UWZDUFZkNjBwR2RJZU5SQk5SRDdKTnlK?=
 =?utf-8?B?bDJ3K1krcTlicXpzTzBDSkRXd3FQTGVFblZqMzg1YVBSNTFIMHZhN0lhbTM2?=
 =?utf-8?Q?TAvJc38zjBsxHzW20uEkLeS3RDt5yTkdwGvhb?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1cbb39-e8b2-4703-da21-08de52c7cc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 17:18:40.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfPCS4q9CUFPqQOojirnQyv/Ejn82/Yv4PRRUuqBaL6YsplNUwCwWz5aSSZn2Bp7A9WuDesNFwQc9nXwOZOk0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6519
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0NCBTYWx0ZWRfX/GebaJnH6iPh
 CQIsThCJqFGS76slPuw+z+1+RMgM39ZHV12ywR50bOw+tB8kga1DkLY18hRFoRjFbHR9D6u0Z5c
 BiwHm6TNFPwXMcGI99AJ+MoVTV0zQlz3grt5IgyYp4XS9keE4rkiDw4SXpS02tNldrw2tCZZ94e
 du0EkErP4DT5A9mx0QcU3zM/zlncPTTjmxXCBCYYAV9st93iSmAzCCUwuce0utIAhuIbzHK5JcD
 0aMjg0kNPaHMb3BKmWwD/VNxPCX2CXpt6oOFXIGHNqDCcucB1lxqTcztndBMVVHA5JkIBoWz2QS
 gI/MRWWxx/BBBHZp1k6dxD+HDeC1jUBgiV8YvnLg2XJOs6ZTbABNyIT2TBdNlL1wTTPk6AtGJkB
 hbAFMfulxnGgZAnD7PP84jSncTjYrsTpF4GNNF1rri+ebK/LaX53EEsjkIAfK6WPftjagioMxRV
 ftscgihs8yBXUzIZ/Wg==
X-Proofpoint-ORIG-GUID: hst5wlYL4C4n1L0HxXiLgVd5Kiwt5k6P
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69667e75 cx=c_pps
 a=xOYz1KraVtwoi73AohHYLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=MlpD_P3uYaA_5hYcKAUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WlXSFnRv-a_AJpim7OBs6L-uciHgVcE2
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DD576272EFAA42B525194DCF7E449A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] hfsplus: pretend special inodes as regular files
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601130144

On Tue, 2026-01-13 at 09:55 +0100, Christian Brauner wrote:
> On Mon, 12 Jan 2026 18:39:23 +0900, Tetsuo Handa wrote:
> > Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> > requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
> > S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
> >=20
> >=20
>=20
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git =20
> branch: vfs-7.0.misc
>=20
> [1/1] hfsplus: pretend special inodes as regular files
>       https://git.kernel.org/vfs/vfs/c/68186fa198f1 =20

I've already taken this patch into HFS/HFS+ tree. :) Should I remove it fro=
m the
tree?

Thanks,
Slava.

