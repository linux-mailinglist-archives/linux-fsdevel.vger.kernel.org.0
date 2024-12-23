Return-Path: <linux-fsdevel+bounces-38082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE59FB7C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 00:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711BA7A0436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E41D7E4F;
	Mon, 23 Dec 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8d8OYpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983C18A6D7;
	Mon, 23 Dec 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734995642; cv=fail; b=tPS0rAa62qxydq6T8nmcLtpPlmvcok0e2oJkKzsTyEMEXe1vRJJTXCJNWOjQb83L2dw89mDHLT3gG6w5BLQhR7OtK8JfSqACxs5B1V0wEBM/uKjCCGmLVnx6YJbmAgv7UHvG5RVJP7RbPgzNwM6NGV2bQ/dZTD/0fuVupCsWErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734995642; c=relaxed/simple;
	bh=HezcShkXHMiA9NE8tzeuRv/Jo/iuY1JyxtLugh2ZBGU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=YWgW7E0SLWw/JNqcTWWjGcHyW6AV5Brfed3YKqX8a8dMtbi/5MUi9oQfoz4EicNSEfLhTdioXb7tNjdwUfNTrCIpdw9ckcSTIgogBy9F6G53kpwpOB5kymejmq3NAjjASTJV09HEMq0ck7PKKzx1sf/Ij9h+cSQPHC22xLcPRos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a8d8OYpJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNDZBMn017387;
	Mon, 23 Dec 2024 23:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HezcShkXHMiA9NE8tzeuRv/Jo/iuY1JyxtLugh2ZBGU=; b=a8d8OYpJ
	K02ARiBAoQ4X7z1Fnxsf/hhD6nwOpHqyup/OCjKMQAoQSIZjzVt+oEEcMuIxSo//
	FA2ILy244hS6+71GuK0Dhv+Udq0wFkp7ePTGvT4Pc3RBSgrNHjDOM3/c6dRT1lHZ
	y0C6TWb0+u2RPeaUdiMDM92Mmxbv1pnFxjgGJdxaEyCHpQf09CIidB7mBQiTsAUc
	D32gUkDfZzEVaGkKIa/cfWpOJFXvBTKxXBG7mn0MWLscI4IzFjkox1qgRlS8x2JD
	+zXbpbiQ5Em+gnSBgAyWelREQ1f1qwm8a1bD3iO/6qeDca+046VVpRUv7XRbXdHk
	iwwm4oY3PrRXuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pvkacunm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 23:13:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNNDrYC018842;
	Mon, 23 Dec 2024 23:13:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pvkacunj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 23:13:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llhsTg7C17gC1kNg3H7BqiRfYXLUaguH8t3vNeRGmojDECfTxDqvORhQgRzhAGl2n7PeD1ZNZIR648D0sw3sdqtKRR0o3s+dM4WVinolCxr92COC+Aemunh7bH4CONGCLvCurLyMRKPJg1nmFEp4vcekfFrg3SnTkdAeX/TNMQZZE5ixiohmJGecMnG7msHsnVYe8V04P1LrbxB7Z9AsddTJzjzG/Ns0K7nUh1Y43i8b4ZW69EZm5Lvrf9qxCVAr3opeJArodfnPu07rdMKmsL+OebnsgcyXmgXzlOikcDn0yKylVQaZrw3nR4igE+REsbDyBjaCVmlpgwUbTM2d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HezcShkXHMiA9NE8tzeuRv/Jo/iuY1JyxtLugh2ZBGU=;
 b=TIKXXKhVjJJ1sv0IeZQsTEjpBY3Y3fPX5mK5qykhaNr2gL1YJykpId5UOhF5TSz0/IjHUgXJI/w8DHF+Emm4YI+OYlBZT6Bi8nyDSn7bueihDrlmJo2d2bg8Hs1K1RLdWPDPoxCP6gV/C8UhNRPCeMXgpJdOcZxnoZC91kmocS7T7xWv8DNG0eoAWkN/5GkJ4I1Us9ILp9KXIIIKpb/A4hUsQug5NLD9nTgDYH82/MHFhsFvGM+P5f+herF7CUjexJkzOy6adr62MyfeDPm3SJ1sKnG56elkPH7UqNGSFMKKKmWkrrBJQ+1+Wd2BfL1Jfk3IAvvcYM2UEHTPUqJnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4417.namprd15.prod.outlook.com (2603:10b6:806:194::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 23:13:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 23:13:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: Xiubo Li <xiubli@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>
Thread-Topic: [EXTERNAL] Re: Ceph and Netfslib
Thread-Index: AQHbUYXLTU7JxE5eTkerRf23TGd+kLL0fZYA
Date: Mon, 23 Dec 2024 23:13:47 +0000
Message-ID: <690826facef0310d7f44cf522deeed979b6ff287.camel@ibm.com>
References: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
		 <3989572.1734546794@warthog.procyon.org.uk>
	 <3992139.1734551286@warthog.procyon.org.uk>
In-Reply-To: <3992139.1734551286@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4417:EE_
x-ms-office365-filtering-correlation-id: 8ef2ede9-742b-4cc5-5ecd-08dd23a77418
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VE5ubkc2SFd1amQ2SmVZWmxtWGUycTF2eHdIWlBaY3M1YllpeGNxYi96aTZj?=
 =?utf-8?B?VmpKczdkZFN0VkpWQkoxclpid2tkZUo5NzBRNXBVVkFsMitlQXY4bUpVWXFE?=
 =?utf-8?B?K2VnUjZHSXBSSGZHcDZaMXByNmt3TUdhUDJWTUVHaTNNRk5sKzFNQnY4akZW?=
 =?utf-8?B?L0RmUFJrSEFWYTBiVU11OWVDWDd2azZIaTdlZzFjYVpYQW43cThIdG40V2I0?=
 =?utf-8?B?OW5xeHByS1I5Q3JTVU9hNFdxU0JWT1dWemExYnowN2IzVlBJWmFJcENZTUFj?=
 =?utf-8?B?Zjl1RGVEQWEvdWpkQmhFOGp1K2NhVXlMKzQxVjk1bXA2cEo1RHozMi9vVnpq?=
 =?utf-8?B?aUZhcWY4NDJtajdKMDdPYTlSeFdiRFNaYUtXTFI2SkRyL3pweGFKQ29FdHdI?=
 =?utf-8?B?UEtvdWc3dXMzcHQ0eGRxSXpuTzNhK1c4cDNrVFJhS1ZNQlVYQzlRUWFMUFBq?=
 =?utf-8?B?cUZnM3BoSTU0dmZ0eis5emc4S2hZd1Y2VTJpVTMwTm9RaWdrK0lVaUJEZmZJ?=
 =?utf-8?B?WjNXRDZHVU1HdDd2N2J1bXhDMXk3THZyb2gxYk9qOUJtN3Bid095R2ZlU1d0?=
 =?utf-8?B?L0g4MHNjN1ZXN2xaOVg0MlV2NkRmM3AvL3VaNmZidXpubm1KTEQwclZJSW5E?=
 =?utf-8?B?NUJHR2hhSHVmR014YjNvZDl2SDBaY2J6aW1qamRBRlhGWHJmeTduODBUcGJF?=
 =?utf-8?B?NVlmTkI1M2pLTWtrYk1VV29wQTV2SFBQN05Yb0h0dkpRaDFsc3l1ZVRnVHpN?=
 =?utf-8?B?OS9oQW1GNEZnYmpibWEzaTlGRU5YaG5nTTV4cWwwYlFBb1VmWW9tdEVyVW10?=
 =?utf-8?B?SU1qY1U3NmZQbytUdzJoTXBaK1Mydm4zWGFQSWdsQzdxSXMxRkFrZ2F2Y21I?=
 =?utf-8?B?Yk4vemxURVBUYUMveSsrVHVJL1JOaXRVbE9KUm5CcmV0dWxBK3dJRE52dXVv?=
 =?utf-8?B?c29Ga1FZK1dRK1gxNGM5QTcrS0UwdmczV0ZSOXB4WUF1SEFzOTQzV25rYkxU?=
 =?utf-8?B?Ti9yaXhIYUFDVVVHTnpFdGtIVzR6ZHZGZDByYytTdHBNUHZjb3lDMUU1dGN3?=
 =?utf-8?B?QW12aXNKcHMzZDVaMU1mTjNXWXFYRHd4aUdIdGtEODhYL3p4NjlXWU5lK0Zr?=
 =?utf-8?B?N3hScDVadHFiOTdKN1h3Mmo1Y2ltcms2cy92VUdRRHpyYzlyLzZrWU1EazhW?=
 =?utf-8?B?bDQwN1R2Wm9GVkdmSU5Vakg1UnZyNVZ6c2E0ZUxlQjA5QklrcDJXeGd0Nm9k?=
 =?utf-8?B?S0lvRzNSNzYzd1B3NHBYeElMazI1SUhSYXd4Q0pxNk81c3hZUktvak1ob1Nz?=
 =?utf-8?B?V3VKYmFwTmZjek5yYzcyc1pnSS9RUGZycVJIaHBxaHUrL1huTVZHT1ozQS9X?=
 =?utf-8?B?QkVXeVBYbkpjRmJNREFZMmR5VERBSG9WTFp2VGhHbkpLUkRXVjlUeDNNQ2R0?=
 =?utf-8?B?dDN1TUtkNlBpbWovc243aWhyRFd2aEU4MDhxbTNVWWdYTDJ3cEgyYk40YWI2?=
 =?utf-8?B?eUVkdXdjTnVhL05EVXpGcWk2MDRJN1ZLMHBCa29RMWp2ZDVjbFNwREg4M3Fu?=
 =?utf-8?B?QS94WitGcU5Hcm1VUFZCbXhoeXVweC9YV2l4YkhwSVV5V0NSZ1dDSWpUUXE0?=
 =?utf-8?B?TytnMElRL0xUN2VBVHRBK1RwKy9uM1N3My9tYlU2ZDVTL1V0Qk1ySlFqY092?=
 =?utf-8?B?MDVRVWl3WWVHOHA0VWhxc0xkY0JZTFk0eld4aXkyK0Q1S3RCVERJaHJRdmR1?=
 =?utf-8?B?NXpCV2MvM3IvZXptdXhGYUt5NVZJay8vTW5VaENCcDNScDVxZ3dRVE52NVFN?=
 =?utf-8?B?NzlyVkFZZmJqVVErNndGclBMSWxWejRWWDBMeTZSNm9wdEFtcVJ3Uk9DOWMx?=
 =?utf-8?B?R0VxZE96emJNVnBwTnVTNi8rcTE0SHNqM3Rjak4vNTAvU0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzBvVWNBcHEyMjZXYlc5ZEVhRytnM2dnd1dDQlNrYUFVYy9GYmxWeGdQTjBj?=
 =?utf-8?B?WkRQeTEzRWlFa0RKMUgva3hON0psL2Q3clhnTU9HdXBZZkpiamRLbllQeWZ3?=
 =?utf-8?B?M2k5czMrSzJLUW4vQ3NteDhBTXJuM05WOUx2dXlUbi9mbThyTmhnUC9jUEtt?=
 =?utf-8?B?cGlRb0s3dUNzVXVsQkxFbktjT3kvYVJubXJweXRmMGEyTFhiejQ4RlRsMUlV?=
 =?utf-8?B?bGd2WnR5UGtWRVJVMXlpUkQ4V2tVYVBrQXlGaFZSUStxSlRoWkx3NGY2VjRq?=
 =?utf-8?B?ZGVnNTIrcUhXZnZDWE1tT0xFMVBKcDV2MjEzVFlHZzR4bnNkSnFpMTF3NUNQ?=
 =?utf-8?B?UzV4VWVKbnRLYk9lOVFwdnBXY2t4VDZoTEo4U3A3cEIrS21NaUtiSWFWSDYx?=
 =?utf-8?B?dFpWU2pFRldsYnl1ckhLS3U4ZXdyaG82Yk40V2h4MWYxM1llMkMyOW5lK3Jh?=
 =?utf-8?B?cnVNQnhkcmxOOXgwNFpnRHhHd3J3QkxnRFE2eFc5YVBaS0U1OG1ScFFCaFpt?=
 =?utf-8?B?TTBFMGljWVpBRmZjSyt6bk5KdmlZKzNCMTZ0RVlDb3dhcTNCMHQvNGtMN2RG?=
 =?utf-8?B?Vjd4eUNGaDFLQ2VyVlN2TkVXajhyeTFkTEpFN2tjSGo5TFA4NFY1SktONE1q?=
 =?utf-8?B?a0NiZTYxaEEyZ3M2UE5qVUxQcXRtaW5LYnpmcThvd0dXS2VKc0paOGdCWCt3?=
 =?utf-8?B?VzIxdHpWbjA4dHJtL2dheWFIUmh2S0xNeU9jb05PaE41WndSRENkbTB4RXBC?=
 =?utf-8?B?K3dnbnJTSWNwbWxkZGZPbW9meXRLK21tc0dXT21mQ0p3ckVOR0JyaHBMZjlI?=
 =?utf-8?B?d0ZHc2ZNejYxYWg4bFpFRng3cTFwclA1TWNnWk9pd1FXS05KRzEzdmo1ZEtw?=
 =?utf-8?B?SlRNcVgyS3oyRnl3aHFwNmwveWdVVDltb3BSYWszL2NOSlhZaWxRN0FhNHNP?=
 =?utf-8?B?cjBZa2FtWUVHTFRHVEorVjRhQzg2dFJGVzZqRnlFQzhvM3VINVMzblZqVmtL?=
 =?utf-8?B?Ynk3K2RaRVMwd1ZxRXl1b2ZTU3ZqT3MyTUhyUmFSN29aTisrSlpvc042YTR3?=
 =?utf-8?B?eUI1M1RYNG91RUx5dTVMTXg1bVlRV3lxOWhFUUhEWnZmcS9UQm82QW5zMGdW?=
 =?utf-8?B?SDhkNk5hdFJVMjRldzhzY2xUQmZjYTAvZkJvak0zdkxCQWhGbXlVMk5Lc3NZ?=
 =?utf-8?B?alNicHh0SzA5MUtycXU5UGsvYzZ6R0poS1JRMFhwNmxTUittbEdOUnVoL1Bn?=
 =?utf-8?B?MHhrcXRudHBaK0w4WndDTHdEQlJ4OWdpRHlQU0U5SUUxNnEzYnU2b3lucWpE?=
 =?utf-8?B?VjVqU1prQzduVnNmaFNTdmRXd3RPRForcDgwUHc3ajZ5K3JucEFEVFdMc2dU?=
 =?utf-8?B?Q2RVK2FnZGI0bmFBb0E2Q3pMaHgzVlJST1pvcjk4UUtKRTltMHR4ZjdBbUZM?=
 =?utf-8?B?NUFtbnk0VVd2bmhjOWtpQm96eFdGUzFYRXBVOFBLTHJ0MXErT2U1bEdLbWo5?=
 =?utf-8?B?ODFpOUhkT3drTHJPVTNHNkdGTWFNdXA2aWdCeVltK25qbnJaanRrbG5tS09P?=
 =?utf-8?B?aXRpZlBBVFo4MitGN2RoTW1aRnFvcjlLNHJoYkFGV0xJVllQeDJrSW55SE9z?=
 =?utf-8?B?OTNVL2hibWpwaXZ0Uy82WkZoZ2prUUhRcEhmR01jWmhpZVlzTXVlWWlqajAv?=
 =?utf-8?B?UEdzVWJhV0tQVGpqZ0wrMGhwcHNrKzZHZkZINVJxcU9pMi9UNGx5Y2J6MVlq?=
 =?utf-8?B?ZHdEMWF0OTRvM2VyUVRwRlRkSitWWUhXd1lOUStrVmFqdVRpS1Z3dDdqTU9K?=
 =?utf-8?B?MUgwTzFwUmZQbjhLZUVMU24xMDlUOWlZUTcvdFVCSDdtempnTTVYMVk3SG9T?=
 =?utf-8?B?RUZ1NjJ3TmJtZHgyeXFvZU81YTNURmx6eC9Wa2k0a2tXQ2NxNTB5dmdoeUxh?=
 =?utf-8?B?SVlwcjBVejBjak9KZjBpZDkxVTl0RlBSSkJnSXA2ZjRISkZ0ZDR1am4vRzhF?=
 =?utf-8?B?VkxGclB1R2FYLytBQ1lZZEhyK0QrcjFUWXJIdEJmejBNZVlVVG12ditqN0hP?=
 =?utf-8?B?TnJyQnRKRStxSk96RFN5aVlOK09qclFDUkVha09vYTdQUnE1UVRKd05rYkxJ?=
 =?utf-8?B?QnE1MDBXWW5NK2tIQkhKaWFSRkVIa3Y0dEdBNjZlMGhLc0pQTGZTQkk2QTZr?=
 =?utf-8?Q?C4L68TQ/n0D+2a0V7G2oJgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D29F0E0621694C439897C3D8EBB86F8B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef2ede9-742b-4cc5-5ecd-08dd23a77418
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 23:13:47.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvtxPxcgmJiwTI+z0C5GWuNsF8wJGzrk2j3kCkL8K2iTeIQdgTQ3KDTTRS8c0f0VIupCiu11zcLa3j2ywE9BAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4417
X-Proofpoint-GUID: alQ_MSudteXmHvMvsqhbfBX_1OLFTJqV
X-Proofpoint-ORIG-GUID: UtyoBhdArOVP1nePKjEAt8h2jjIc3lRJ
Subject: RE: Ceph and Netfslib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=811 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230205

T24gV2VkLCAyMDI0LTEyLTE4IGF0IDE5OjQ4ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4g
PiANCjxza2lwcGVkPg0KDQo+ID4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcmRseSwgSSB3
YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCwgZm9yIGFueSBnaXZlbg0KPiA+ID4gcGFnZS9m
b2xpbywNCj4gPiA+IG9ubHkgdGhlDQo+ID4gPiBoZWFkIHNuYXBzaG90IGNvdWxkIGJlIGFsdGVy
ZWQgLSBhbmQgdGhhdCBhbnkgb2xkZXIgc25hcHNob3QgbXVzdA0KPiA+ID4gYmUNCj4gPiA+IGZs
dXNoZWQNCj4gPiA+IGJlZm9yZSB3ZSBjb3VsZCBhbGxvdyB0aGF0Lg0KPiA+ID4gDQo+ID4gPiAN
Cg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgY2VwaF9kaXJ0eV9mb2xpbygpIGF0dGFjaGVzIFsxXSB0
byBmb2xpby0+cHJpdmF0ZQ0KYSBwb2ludGVyIG9uIHN0cnVjdCBjZXBoX3NuYXBfY29udGV4dC4g
U28sIGl0IHNvdW5kcyB0aGF0IGZvbGlvIGNvdWxkDQpub3QgaGF2ZSBhbnkgYXNzb2NpYXRlZCBz
bmFwc2hvdCBjb250ZXh0IHVudGlsIGl0IHdpbGwgYmUgbWFya2VkIGFzDQpkaXJ0eS4NCg0KT3Bw
b3NpdGVseSwgY2VwaF9pbnZhbGlkYXRlX2ZvbGlvKCkgZGV0YWNoZXMgWzJdIHRoZSBjZXBoX3Nu
YXBfY29udGV4dA0KZnJvbSBmb2xpby0+cHJpdmF0ZSwgb3Igd3JpdGVwYWdlX25vdW5sb2NrKCkg
ZGV0YWNoZXMgWzNdIHRoZQ0KY2VwaF9zbmFwX2NvbnRleHQgZnJvbSBwYWdlLCBvciB3cml0ZXBh
Z2VzX2ZpbmlzaCgpIGRldGFjaGVzIFs0XSB0aGUNCmNlcGhfc25hcF9jb250ZXh0IGZyb20gcGFn
ZS4gU28sIHRlY2huaWNhbGx5IHNwZWFraW5nLCBmb2xpby9wYWdlDQpzaG91bGQgaGF2ZSB0aGUg
YXNzb2NpYXRlZCBzbmFwc2hvdCBjb250ZXh0IG9ubHkgaW4gZGlydHkgc3RhdGUuDQoNClRoZSBz
dHJ1Y3QgY2VwaF9zbmFwX2NvbnRleHQgcmVwcmVzZW50cyBhIHNldCBvZiBleGlzdGluZyBzbmFw
c2hvdHM6DQoNCnN0cnVjdCBjZXBoX3NuYXBfY29udGV4dCB7DQoJcmVmY291bnRfdCBucmVmOw0K
CXU2NCBzZXE7DQoJdTMyIG51bV9zbmFwczsNCgl1NjQgc25hcHNbXTsNCn07DQoNClRoZSBzbmFw
c2hvdCBjb250ZXh0IGlzIHByZXBhcmVkIGJ5IGJ1aWxkX3NuYXBfY29udGV4dCgpIGFuZCB0aGUg
c2V0IG9mDQpleGlzdGluZyBzbmFwc2hvdHMgaW5jbHVkZTogKDEpIHBhcmVudCBpbm9kZSdzIHNu
YXBzaG90cyBbNV0sICgyKQ0KaW5vZGUncyBzbmFwc2hvdHMgWzZdLCAoMykgcHJpb3IgcGFyZW50
IHNuYXBzaG90cyBbN10uDQoNCg0KICogV2hlbiBhIHNuYXBzaG90IGlzIHRha2VuICh0aGF0IGlz
LCB3aGVuIHRoZSBjbGllbnQgcmVjZWl2ZXMNCiAqIG5vdGlmaWNhdGlvbiB0aGF0IGEgc25hcHNo
b3Qgd2FzIHRha2VuKSwgZWFjaCBpbm9kZSB3aXRoIGNhcHMgYW5kDQogKiB3aXRoIGRpcnR5IHBh
Z2VzIChkaXJ0eSBwYWdlcyBpbXBsaWVzIHRoZXJlIGlzIGEgY2FwKSBnZXRzIGEgbmV3DQogKiBj
ZXBoX2NhcF9zbmFwIGluIHRoZSBpX2NhcF9zbmFwcyBsaXN0ICh3aGljaCBpcyBzb3J0ZWQgaW4g
YXNjZW5kaW5nDQogKiBvcmRlciwgbmV3IHNuYXBzIGdvIHRvIHRoZSB0YWlsKS4NCg0KU28sIGNl
cGhfZGlydHlfZm9saW8oKSB0YWtlcyB0aGUgbGF0ZXN0IGNlcGhfY2FwX3NuYXA6DQoNCglpZiAo
X19jZXBoX2hhdmVfcGVuZGluZ19jYXBfc25hcChjaSkpIHsNCgkJc3RydWN0IGNlcGhfY2FwX3Nu
YXAgKmNhcHNuYXAgPQ0KCQkJCWxpc3RfbGFzdF9lbnRyeSgmY2ktPmlfY2FwX3NuYXBzLA0KCQkJ
CQkJc3RydWN0IGNlcGhfY2FwX3NuYXAsDQoJCQkJCQljaV9pdGVtKTsNCgkJc25hcGMgPSBjZXBo
X2dldF9zbmFwX2NvbnRleHQoY2Fwc25hcC0+Y29udGV4dCk7DQoJCWNhcHNuYXAtPmRpcnR5X3Bh
Z2VzKys7DQoJfSBlbHNlIHsNCgkJQlVHX09OKCFjaS0+aV9oZWFkX3NuYXBjKTsNCgkJc25hcGMg
PSBjZXBoX2dldF9zbmFwX2NvbnRleHQoY2ktPmlfaGVhZF9zbmFwYyk7DQoJCSsrY2ktPmlfd3Ji
dWZmZXJfcmVmX2hlYWQ7DQoJfQ0KDQoNCiAqIE9uIHdyaXRlYmFjaywgd2UgbXVzdCBzdWJtaXQg
d3JpdGVzIHRvIHRoZSBvc2QgSU4gU05BUCBPUkRFUi4gIFNvLA0KICogd2UgbG9vayBmb3IgdGhl
IGZpcnN0IGNhcHNuYXAgaW4gaV9jYXBfc25hcHMgYW5kIHdyaXRlIG91dCBwYWdlcyBpbg0KICog
dGhhdCBzbmFwIGNvbnRleHQgX29ubHlfLiAgVGhlbiB3ZSBtb3ZlIG9uIHRvIHRoZSBuZXh0IGNh
cHNuYXAsDQogKiBldmVudHVhbGx5IHJlYWNoaW5nIHRoZSAibGl2ZSIgb3IgImhlYWQiIGNvbnRl
eHQgKGkuZS4sIHBhZ2VzIHRoYXQNCiAqIGFyZSBub3QgeWV0IHNuYXBwZWQpIGFuZCBhcmUgd3Jp
dGluZyB0aGUgbW9zdCByZWNlbnRseSBkaXJ0aWVkDQogKiBwYWdlcw0KDQpGb3IgZXhhbXBsZSwg
d3JpdGVwYWdlX25vdW5sb2NrKCkgZXhlY3V0ZXMgc3VjaCBsb2dpYyBbOF06DQoNCglvbGRlc3Qg
PSBnZXRfb2xkZXN0X2NvbnRleHQoaW5vZGUsICZjZXBoX3diYywgc25hcGMpOw0KCWlmIChzbmFw
Yy0+c2VxID4gb2xkZXN0LT5zZXEpIHsNCgkJZG91dGMoY2wsICIlbGx4LiVsbHggcGFnZSAlcCBz
bmFwYyAlcCBub3Qgd3JpdGVhYmxlIC0NCm5vb3BcbiIsDQoJCSAgICAgIGNlcGhfdmlub3AoaW5v
ZGUpLCBwYWdlLCBzbmFwYyk7DQoJCS8qIHdlIHNob3VsZCBvbmx5IG5vb3AgaWYgY2FsbGVkIGJ5
IGtzd2FwZCAqLw0KCQlXQVJOX09OKCEoY3VycmVudC0+ZmxhZ3MgJiBQRl9NRU1BTExPQykpOw0K
CQljZXBoX3B1dF9zbmFwX2NvbnRleHQob2xkZXN0KTsNCgkJcmVkaXJ0eV9wYWdlX2Zvcl93cml0
ZXBhZ2Uod2JjLCBwYWdlKTsNCgkJcmV0dXJuIDA7DQoJfQ0KCWNlcGhfcHV0X3NuYXBfY29udGV4
dChvbGRlc3QpOw0KDQpTbywgd2Ugc2hvdWxkIGZsdXNoIGFsbCBkaXJ0eSBwYWdlcy9mb2xpb3Mg
aW4gdGhlIHNuYXBzaG90cyBvcmRlci4gQnV0DQpJIGFtIG5vdCBzdXJlIHRoYXQgd2UgbW9kaWZ5
IGEgc25hcHNob3QgYnkgbWFraW5nIHBhZ2VzL2ZvbGlvcyBkaXJ0eS4gSQ0KdGhpbmsgd2Ugc2lt
cGx5IGFkZGluZyBjYXBzbmFwIGluIHRoZSBsaXN0IGFuZCBtYWtpbmcgYSBuZXcgc25hcHNob3QN
CmNvbnRleHQgaW4gdGhlIGNhc2Ugb2YgbmV3IHNuYXBzaG90IGNyZWF0aW9uLg0KDQoNCj4gPiA+
IEZvdXJ0aGx5LCB0aGUgY2VwaF9zbmFwX2NvbnRleHQgc3RydWN0IGhvbGRzIGEgbGlzdCBvZiBz
bmFwcy7CoA0KPiA+ID4gRG9lcw0KPiA+ID4gaXQgcmVhbGx5DQo+ID4gPiBuZWVkIHRvLCBvciBp
cyBqdXN0IHRoZSBtb3N0IHJlY2VudCBzbmFwIGZvciB3aGljaCB0aGUgZm9saW8NCj4gPiA+IGhv
bGRzDQo+ID4gPiBjaGFuZ2VzDQo+ID4gPiBzdWZmaWNpZW50Pw0KPiA+ID4gDQo+ID4gDQo+ID4g
DQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBtYWluIGdvYWwgb2YgY2VwaF9zbmFwX2NvbnRl
eHQgaXMgdGhlDQphY2NvdW50aW5nIG9mIGFsbCBzbmFwc2hvdHMgdGhhdMKgaGFzIHBhcnRpY3Vs
YXIgaW5vZGUgYW5kIGFsbCBpdHMNCnBhcmVudHMuIEFuZCBhbGwgdGhlc2UgZ3V5cyBjb3VsZCBo
YXZlIGRpcnR5IHBhZ2VzLiBTbywgdGhlDQpyZXNwb25zaWJpbGl0eSBvZiBvZiBjZXBoX3NuYXBf
Y29udGV4dCBpcyB0byBmbHVzaCBkaXJ0eSBmb2xpb3MvcGFnZXMNCndpdGggdGhlIGdvYWwgdG8g
Zmx1c2ggaXQgaW4gc25hcHNob3RzIG9yZGVyIGZvciBhbGwgaW5vZGVzIGluIHRoZQ0KaGllcmFy
Y2h5Lg0KDQoNCkkgY291bGQgbWlzcyBzb21lIGRldGFpbHMuIDopIEJ1dCBJIGhvcGUgdGhlIGFu
c3dlciBjb3VsZCBoZWxwLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xMy1yYzMvc291cmNlL2ZzL2NlcGgvYWRkci5jI0wxMjcN
ClsyXQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTMtcmMzL3NvdXJjZS9m
cy9jZXBoL2FkZHIuYyNMMTU3DQpbM10NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjEzLXJjMy9zb3VyY2UvZnMvY2VwaC9hZGRyLmMjTDgwMA0KWzRdDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xMy1yYzMvc291cmNlL2ZzL2NlcGgvYWRkci5jI0w5MTEN
Cls1XQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTMtcmMzL3NvdXJjZS9m
cy9jZXBoL3NuYXAuYyNMMzkxDQpbNl0NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjEzLXJjMy9zb3VyY2UvZnMvY2VwaC9zbmFwLmMjTDM5OQ0KWzddDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xMy1yYzMvc291cmNlL2ZzL2NlcGgvc25hcC5jI0w0MDIN
Cls4XQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTMtcmMzL3NvdXJjZS9m
cy9jZXBoL2FkZHIuYyNMNjk1DQoNCg0K

