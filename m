Return-Path: <linux-fsdevel+bounces-41757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D629EA36723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C7170D0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451D1D7E47;
	Fri, 14 Feb 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTmYxx6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924A1C8611
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566653; cv=fail; b=ZPdtf6DgCJjOqUOpuZ1OgtY8jfuJDZaTJLmp1RO4qMpdEQgqQLsF1W+AsxdP7tl4170aZ1J5ZtvHBL39igKZu4t/eh0A7Lq/vLwyjmaetWCIbBoBQ7HQHQ57VPwvIxPtpEMC+IobCz/d5XiA7bVBjeubMEgnNObGlsYrUD4RMH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566653; c=relaxed/simple;
	bh=dRD5Jm3VJ2APDMHVpasPSSNYuWPuFf1NkXp8Ol53YYw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=bBsoYJu4ZlRxnaF2Aj8v8kj+qjbYW4iDIIGJZ2OiG4beRbZ3Ux0oxazcZ5KRo/xX/tZYK/JAcbEqvtZ5maNMak+TblW2p2UEknm61w76jpJL7UsHSPLRLaoJhyruUXcP9xHKzurZaw46/WySd4WkXroa+EuoPHjaxw9zSX0zg3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTmYxx6a; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EI0muG000657
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rFUoMXDTMLIFoGHk6p9c9c4firRZ0sifMj0+WrzWTtA=; b=OTmYxx6a
	lHRNSqwYHIgPmcWixaJx2btcltCZRa9kUPbmQhq3T89xv37hB4CZh+dCq5NEktOP
	AV4LWKYCi/nFnxeW/dmNkgZyb5Fr50AOd6ADSyb3q8bTacrtUliA7xIlgh5RZpTu
	lxAmHFzjQGBy6ywCRU8fe8mteWmdJ4uN8YPZBxGXVfiojuUyUA3c27O1Ub+cyW7M
	/C6sie63ksCwOWJihTsSKVS6/fc/8QsokUIm3sjNnza3o7E7wZG+iB0GGK+hjPxp
	ax1qxDp0N/x4sRhvuxe5gl2vjyRDE+FXVHbPJ4JzhmdJDbG4K2PrVT55vl6Mwo+J
	l2wlXxLgPSfkYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvadmt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:57:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EKvTNA031342
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:57:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvadmt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:57:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EKvAIS030457;
	Fri, 14 Feb 2025 20:57:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvadmst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:57:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVUl2XxYJqE29wWsVRzYpNKXe47OJMft1nF8smnBU7pJi2f9S2jDZlL5SIyqAS5ZROPRoWcDRT4ngL+79smGitzLAEuedRzgDHvugBkeFmPIjM5PT3Cdv/dQHrDBxLobY3xlsJEIfDvEYy/r7qAhjrxvjDUC/cHoBR9v4woCfyAGT9JPRqKv5wZUCHwY54WXnOotWXG54Gxfa5100HQiUYg9EgutJTv3MfwmBRWbrDiTwn2tv44v4/7hglu2nHyeJojON6eeNgFohTYQ5xzpGjQi5rwesZGvCm0BcJQbqNugXVOrcG7F7nBsEeiom0GTG8w8Pyd0yW9ic8KcAbpZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xoe+x2AXZrEYZJN3RzwCFgzZbOoeISKe44tHyAksjsA=;
 b=uZfhnik0jld6pnKSTJmnnyIxjKRsvSDQjK9zud8Q55t7k4+tRW6Sg1Di8dXboDNEnrE1VWURxDUpEIWadpyE2RG7peFBEvxAhSkzFBaMCJiCO2CdNLyLmMAbpnSLTRwTQquWeB43JZzpQACObuJrmfTwfx5TiynD2aQQtrYO88s14AoyjRJy5jg0nFJ4deyehoXdsp2GzNu9nnSnagjb56NeyUxhaL7qIDYffZ0mnUZeEImHYhljAhvq5KNMiM7oj2EZM7QO/P1TK9WWF6yE+nwDn9im0fjgQDMYwfUE887I5HKowHmBt45Qgsmz5M/jwo9yg/NC8aHZ8dtrqWWlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB4158.namprd15.prod.outlook.com (2603:10b6:806:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 20:57:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:57:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 0/4] ceph: fix generic/421 test
 failure
Thread-Index: AQHbfwSitHI2EkU8vkKyDr1N+60bsbNHD9oAgAAyHQCAAALggIAAAcgAgAABcIA=
Date: Fri, 14 Feb 2025 20:57:25 +0000
Message-ID: <b7150622107a70abf80fa9cab7f14ab768efc5a8.camel@ibm.com>
References: <7596dd297239c4226a0ff6005bbb368733d38b4a.camel@ibm.com>
		 <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com>
		 <20250205000249.123054-1-slava@dubeyko.com>
		 <4153980.1739553567@warthog.procyon.org.uk>
		 <18284.1739565336@warthog.procyon.org.uk>
	 <36588.1739566336@warthog.procyon.org.uk>
In-Reply-To: <36588.1739566336@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB4158:EE_
x-ms-office365-filtering-correlation-id: 30301579-faef-49d4-87dc-08dd4d3a2fa7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUxkazVFTExWMUVwWmluQ0JadjIxQ081ODlJM3gzVEo3ZTFaejlrZVZEODRE?=
 =?utf-8?B?NFl0bk1EVk1LdXdMMG1PWmNUWk1udDhjZWtLTWdnbm5IN2RVLzJEenBUUzh3?=
 =?utf-8?B?YXRUZ1UzeEp2WnVQSVRra1pZR3B2NVc4YUp1ZzY1NDJocVNpakJNV1JuUmNp?=
 =?utf-8?B?QU9uWVVEZjRjQkhuVzBIdVdTTms0SnVuMjJ6N2Q3THhURHpNVlRZZXpadDU3?=
 =?utf-8?B?ZFQzMFVFTUpkcXF2RjFjeWNUNzh5dUdUWE94eG1qRW8rd0NBQ0hhOHIvMC8x?=
 =?utf-8?B?R2VLc1hDZUljOEd1N2VMVXk2THNLY09IdTBqYUlQd1k4c3BMQlNaVlVjUVA0?=
 =?utf-8?B?S01SWE5LemJJaFZhcFRESDVTRklicWRHWXp2QWxoYkRhWENNMHV6cW9MQkdM?=
 =?utf-8?B?MllnSjNUMmtPdUZWRmNJbnlDZ0tSNVdNY09vRjIzNnJoYWNqZDg4WWViUUMr?=
 =?utf-8?B?VXlyVUxNdXZHVGVXcEJCVVV1TVFYeXNPcko5aEZVeHZDR0RmTFp4SVZiTFZu?=
 =?utf-8?B?dnVzb0tNY3VUZzA3TURjNW9uNkdEbFpWb1pXa1RSR0tyZ0E0eFpuSFZwVmRq?=
 =?utf-8?B?eVppdzJXNGJCZXNIYnd3aXFoSmo0dTJaNnhZRXdRZGYydGdDMmNLTUhXaGpL?=
 =?utf-8?B?TjJyMDdUb3QxOHQyVCt5b3ZwWnQvajQ5ZUR2OHI4Q1EzT2RLSXlKVkxHWDFN?=
 =?utf-8?B?ekJhejRPdzNZSmV2bVVsUSsxeVNIYUJEUWszazlJNFhNRERRbnpjbzBKdHFF?=
 =?utf-8?B?eEdHQUZJemlDWm0rejRWVXY3UGN4amxyRVJQT0V5TlZjeXRhODJUN0ZlNkJN?=
 =?utf-8?B?WUxCMzJ4TnZEVk5ZMFlCVEp4ZFhlZUdCbnNsU1U5d0tXbThzT3BRclF2RXdk?=
 =?utf-8?B?RW04M3ZTVGRFY00rbW9ZdTNhb0hGb2FMaDRDb1ZyVVNlS1BMdGh4RTRsTkIr?=
 =?utf-8?B?QnZwUHZnRmlCT1VjTmRXY1BQb2VscG5xbVcyYUZzUVY2RVAwYTNmYzVYVVlq?=
 =?utf-8?B?cGZMNTNPUVhVMnllWnM5aXdGODJ6M1hSQ1lzeERXMGREeXdyQ1NBcHpZcGRF?=
 =?utf-8?B?NGcwWFJua0F6ak5VZ0M1SUZMelBDSlZselRTZnJxL3ovbUVwdHRrckpJSlM4?=
 =?utf-8?B?M0VBckhrcDI3T045emJ3aFRld0lJMGJnQlJxb1Z6cGhJcWNIQWgzZitrQ0c5?=
 =?utf-8?B?Zzh1MDBWTmhTRFZQYkEvem90Um5xM1lwZkFPQzBNK2JtektuVlMzUXM1R1dm?=
 =?utf-8?B?ZEczY1NzVHF4ZTEvOUpoV3Y3S0ZWUHhadjJHWEs4a1dQTUpZKysyQW9yWWNO?=
 =?utf-8?B?d2J0aDFaUFFBbUNVL1liMWFlalVNbElualJtL2UyRmUyaXI2aGhVVUZzaFV4?=
 =?utf-8?B?cGhidzFjeUZDdVBQeFZEb3JnMFVSZE1GN3hObTlQVDJHY0EzTjNtWXY0cVAz?=
 =?utf-8?B?VmZEZmt2Q1g3MVh3OWRMSTZoaE10QXpSdE96QnlVeHJkN3VtSEJNaGwyOHg2?=
 =?utf-8?B?anR0Um41akQxaE0yZExhUklLZXZTekdiVkJmVXNGVC8wdzBmd29yd29qVmdk?=
 =?utf-8?B?eXh2c3NpR1pWVzNqVmpQNkhHVGdrVks5bytjMW1Cclp5V0VXOVg0aGpubGI3?=
 =?utf-8?B?akEvWlJybXAvSEtUSElyRUszd0ZlUUY3SG0rS3NHNFlIbExrV0VNZWV0cGJN?=
 =?utf-8?B?RG1JdFl0M1dxcVdUblBTVHJIcmhuRlF5N2FDVW81RXoxOW1ra1RJcmZSUVFW?=
 =?utf-8?B?VWNPeU9tV0tJOGdjOWc4eTEyVUw2alppc0x4RmFwdmk0Ti95NlhDcU5NOXRE?=
 =?utf-8?B?Zmh6L2lGaXljME50RGs4bU1lOXR4bzl1RWJ6Qk1ZYzF3ZXFzbHJ6bjgvYlg2?=
 =?utf-8?B?TXNoOXRLazQ1WlIzNktKbG5JOTVXaW4wM3UwVzIxTmxYMTdzUVZia09iUTl3?=
 =?utf-8?Q?ULkG6Yio7XC4+ifreNyIpdWIn4EpxztZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGZJVWFYOTlQMUdCdFN1eU13N0YzNFdRcEU0cTVTTTkxL2tHMDMya0tnc3cx?=
 =?utf-8?B?TmVTdnhXQUtsWlJzYWE2OXp2SDNqV0xFa21RSWh4eFAwVTBVVWQrOWhtRkd2?=
 =?utf-8?B?VUJubWlYYWtCRSsxd2RTTHVrMHE2ZUFsVFhQK1RRaG5CZ1k2SGZ0MEN6Y0lU?=
 =?utf-8?B?Qjlmb21idE01ODBMQXIyY0RNZ3pMeUx0RE03MTh0Rkh6cTJXSDZuSnAzU0kx?=
 =?utf-8?B?YUk1dFFUNSs3cXlhcmNyejdJaVZ4dlNEc3krVndrOVlNcU5JbWdLdUVLaFZD?=
 =?utf-8?B?OFFYY1NrODcrSXN1Ri95dnZRUTVKUnJJaG1iNW0ybU1ub09VNGlEWTh5QzJ0?=
 =?utf-8?B?YnNSaytUYzRIZXNJRjMwZkRHTzVqcUlXNnRlZE5ydlF1Q0xtbGlJNFYrdnU5?=
 =?utf-8?B?ZDl3eTMvVnE3OGR0S3hxdGVOR1dTY2IyM3c3eE9EWHkreFRlQTRxKzJkQm9T?=
 =?utf-8?B?a3lOWDc5SjdEeWhaNDJEVSt3SExlQnJ4N0UxZTNza2c3cDZyeFJMQ25tZzBY?=
 =?utf-8?B?Y2FaVXRBeVN4REZYMWdoZ1ZHMjBvWm9iOFhNc3ZCMEdTc3RWOVQwcUdhLzlv?=
 =?utf-8?B?N3p4UzRGbTFWSnJLanhKZTBsL2pKeVg3K09VNHY5RlhYUHZib3llKy8zZkF0?=
 =?utf-8?B?clJXU0J4VXM5QzNCZ1hlSW8zMk1BQWN2djQ3S2lnVkQ4REUzbFZVaTVWSXZL?=
 =?utf-8?B?NS9EdnNLZWR0SEk1cnU4UXlIck80aTVDajJUNlN3U3Jsa3RrbDhhZm9PR0xs?=
 =?utf-8?B?SVhLQ25CNXlPWHdsQ3hpVXRDenhoenFRTzBVd2ExR3h2UWdWV2ZxLy9VeVZL?=
 =?utf-8?B?VmllTlZpWk4zQWNjK29Ub0FRZjMvVzdrakFWa2V0ay81WkQ2ekJPOTRScE4x?=
 =?utf-8?B?SVZYMTdMM3ZkZXpaUThFck81TUhHem9rdTNoZjAxOVQrMVNiSVF5b3VmOWhq?=
 =?utf-8?B?SVBBSjE1TDgzTTV1VFVST3plRmhjeHJWTnVOeFdYeTl6OTVsaUFRZlhrdmJE?=
 =?utf-8?B?dFZZMXFvUk52d3ZxTFVRMnU1RXM2WE84MmszSU5SRUtKYlp4WERPZGhOMko4?=
 =?utf-8?B?dllyUnU5NCswNWxhMFZpYjZla01taERjNHNFdjJwRHZSWjlLU1FsT3NFN0RC?=
 =?utf-8?B?T3dac1lsWUVpQ2xZM2JsKzhlK1h0OEFWVWhrS1NqSkp6RUxJNjJtRHo4Mkk0?=
 =?utf-8?B?UlNaUTZXR0d1V1REQnR0bDExRUZLaHh3dXB6L29yVVVpU042ODNONE0vdWpi?=
 =?utf-8?B?dWhrRm85YWhVU244OTlaNmQxa2ptMW82eEFnbXNzZ3UxUHYrOW0rYlFmemQv?=
 =?utf-8?B?OUxCSzIxVTQzVW9aOTJBaU1NUU1pRVJKbFdBVzR0TnRwMXFBanM3V2xsYjRX?=
 =?utf-8?B?dzlUVndYNlZRZENBSXA3eU15S1FRY2E1Z3cvRms5WUlkc0ZKOHpycGFXYUpq?=
 =?utf-8?B?TTFKTWFsVDF1YjVNcGN4SjI0eEZZYURHYkx2eHBydEE4VEFjdnhrS1VnaVh4?=
 =?utf-8?B?WGhoL2U2OGtRZGIralFtd1Rhak8zZ3p0elorY21NU2U5emcySFI1QXZtRm85?=
 =?utf-8?B?ODZITnBVTGdMZko4L2tEYk0vWjMwQ3lTcEFKZUtTT05OMnllNS93OVVNL0t6?=
 =?utf-8?B?anJzQWUyVDNuNm5PeFZEU3lHK2Nicm14QnZtdFNQZ3Z4Wm5kSEwvS1FEcm9y?=
 =?utf-8?B?dVFSNUloQlFVM3pJZ3FKZTE3MTc2bFFkMGdQTnlWdm5NbUsxSXJ4enUyTDNO?=
 =?utf-8?B?TjZjU3VJaXNqQUtKU0lkMWRYK21PZE9sSjhUMWZSU1pqL1dSbUNUekpub1Qv?=
 =?utf-8?B?QXdmclVRZ1lYSEt2TTlGVmJpMFJybDJXdTA4dFFnVStqRTg3NTMvbWxFYmo5?=
 =?utf-8?B?d2JmNFpScTEzbVRRWnpvQVR0T2Q0TC9BMFg3SUdHdC9ETHVoVmxSUzFZbk9k?=
 =?utf-8?B?WmFLUnhuREhsT3pEb1R0d0Mrc2tPbC9mamJRNEZTMUozdFIxSXJGNHVHc3Nm?=
 =?utf-8?B?WElON1ZGQVkwZlRhNytOcUNMNDRTVW02eWhzZkluYWMzKzBjd3NYdjV6UENr?=
 =?utf-8?B?NzhJWVNsalNOR01ZZUJRS2s1dmY0RzhXSmwzV3NTTkVDOTRGV21GdXJlZ20x?=
 =?utf-8?B?d3c2S295VXpPV3QwSGFjckRHVUxJV2NQYmxBcThXN00waU9BNnVEdEpEekMr?=
 =?utf-8?Q?u83bzlOyHs4gkG5oTGuHk0g=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30301579-faef-49d4-87dc-08dd4d3a2fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 20:57:25.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jsrl87bkxpzoqwchnrQPfRxexcFONVewjNhAnlG4gl/Xrq+EOSyxchWoU4KA+cFCDqAwkW+KLisFmDpWNsTMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4158
X-Proofpoint-GUID: 8vOHJcsB59vf34YiwokhxFccpCSeJ2s7
X-Proofpoint-ORIG-GUID: DjLePK1uKRC652Ehf20kpMYTSncvnT0T
Content-Type: text/plain; charset="utf-8"
Content-ID: <629A3DC5B5B1CD42B498E7388867095B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH 0/4] ceph: fix generic/421 test failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=797 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2501170000 definitions=main-2502140140

On Fri, 2025-02-14 at 20:52 +0000, David Howells wrote:
> Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
>=20
> > Do you mean that you applied this modification?
>=20
> See:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes =20
>=20
> for I have applied.
>=20

OK. I didn't see such output during the testing:

generic/397       - output mismatch (see /root/xfstests-
dev/results//generic/397.out.bad)
    --- tests/generic/397.out   2024-09-12 12:36:14.167441927 +0100
    +++ /root/xfstests-dev/results//generic/397.out.bad 2025-02-14
20:34:10.365900035 +0000
    @@ -1,13 +1,27 @@
     QA output created by 397
    +Only in /xfstest.scratch/ref_dir:
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyy
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyy
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyy
yyyyyyyyyyyyyyy
    +Only in /xfstest.scratch/edir:
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyy
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDSd=EF=BF=BDS=EF=BF=BDe=EF=BF=BD=EF=BF=BD[=EF=BF=
=BD@=EF=BF=BD
=EF=BF=BD=EF=BF=BD7,=EF=BF=BD=EF=BF=BD
                                                                           =
   =20
[=EF=BF=BDg=EF=BF=BD=EF=BF=BD
    +Only in /xfstest.scratch/edir: 70h6RnwpEg1PMtJp9yQ,2g
    +Only in /xfstest.scratch/edir: HHBOImQ7cdmsZKNhc5yPCX+XKu0+dn4VViEQzd0=
q3Ig
    +Only in /xfstest.scratch/edir: HXYO3UK3FrxqwSZaNnQ5zQ
    +Only in /xfstest.scratch/edir: PecH6opy8KkkB8ir8Oz0pw
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/397.out /root/xfstests-
dev/results//generic/397.out.bad'  to see the entire diff)

Let me double check the test again.

Thanks,
Slava.




