Return-Path: <linux-fsdevel+bounces-69271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1CEC762A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31A0F4E1C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCD2BE7D6;
	Thu, 20 Nov 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pb2m4DaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB882B2D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669872; cv=fail; b=Qm+2kdR9pPucjyRkYWeJgegEPp9ivIerfr92FgQbAWfdf211DwtSsjz/tWD0v8/K7sBwlvArQnodqPzjulaEcQVrd0BbFYGkw2JsiVlKB0KPXkbQCsIjhRpiKh3KyKu7+w46ay76Pfoe2ryXy0L3jDXXKpS4g+wVb0mzVOjvTfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669872; c=relaxed/simple;
	bh=QzQMHEgBUlMSXDbktXIaeUSlXddTTFxZi/BHMv1607I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GjPICRYnfoy71eDEvvY2fBBkcdhJgrqtYh/9ZLhWKo7ytiD60353mpXF5JG/PvcY6rttViDfDgLse/58VbFqYyt/sfqmByCFAQCZecCKj+szrI408zfd+Or6qPE8RH9DsfqmBZcKhOvwAsWFFMCgAcks4XuVU0epYuATtkutSrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pb2m4DaE; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCkrgN012645
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 20:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=G6i/gEWeaaKjXaMLkJAc13CVfA4DBrJGHZnNJRpWb+I=; b=pb2m4DaE
	5IO4HTpbFolzDHPQOGqUl/7Mxdtp+/mV46A8QVTEp9zDc2isYDhDFCKJLztMcheh
	MGGx+3+SPd6ZAxV3UJF26oJ9ee9rTnOBfkOO/rzmFBBhI77bf1/PkhKnoHXpZLqT
	8bNLrRo80+BfuTrsf6ygydSgNfsRzjYuRJoU61HFDyyTxsTQq4LtPug5yhZ6IxeT
	Byu8KRRSfEgSDRyWbMVW8j4buB4OEDVNj8atk/3zzIMdMZL4OCY4Lz2g90aFj/le
	E8CCuvEgwU+EDdFALBt57IPfpSzQqPeruVIPSao/svoVuXgRkxaBojWDjbW6MPxM
	CsIlMwflaxZAFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgx72dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 20:17:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKKHmj2020811
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 20:17:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgx72dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 20:17:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKKHbqv020439;
	Thu, 20 Nov 2025 20:17:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgx72db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 20:17:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcrHsfrpkJmsbJqjMsxoChpuJarTul1Sr/wWFFRU55cPRJ4TcK0jDJPjRpdlPy7m87tVz1wzHKbL2qtsNjRyq/lND0MJ8xlAwKxKv1SeDk4c7vtr7+fRtB00LZRgl2va/seblNZGPNzHXpJcopxZyiPLJZr19NNGKKItptQnMmilbLoz739VQN7/86ZUVLG5qVeiNThf9dXwIcZkcW+zk88AEPnUm7owYgMlHjX3pXlIirlDGku8tPanxRKc+Umg4DkocOS6/aAZfiyuOSClofIi7kyUS8+mvUUaJQYg1/lT8NTB+ncN3ACghAxo8u47iaTSa3ZesdeApZYa6Vk1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFYy1LPNB/b1UdzSbtlsqTezfk6Ost4Lvyv5rmfr9Qo=;
 b=HxA5VkKLWvsbBkzCv0YOgwtfNdmfgx1n2liUQXFx3KR7zpRUYZyBZ+QNrp5qOyNWam0Fk+4kPZiaospp1Drb9rU3lIli0TJ3n0HazLIpMBEW1fEBdb+1fcs+i0CXhT36KSVxCIiUUUHTqDeoZXYgI34bNxBlpNt+riUnof/0AIU5TbzBshGD81U99KWTGc71YvQnF4D1fh7A/bXZfhFDomdBs5G35vdG4uyX1VzUST2b/z9R/yBPw1kY9LTcdhbOgay/O6wy5azjSgxBxrlBOUl121teazAHH8NkpTQZbHuG9tLwPqTh3KHgoyioqur3uig34AChLGsoum74e5ylcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPF5E46643E4.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 20:17:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 20:17:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Gregory
 Farnum <gfarnum@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcWaV/RIaAnir5XkifXtXvNFHQibT6mqKAgAADQICAAAQCAIAA/JgAgABjqoA=
Date: Thu, 20 Nov 2025 20:17:41 +0000
Message-ID: <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
References: <20251119193745.595930-2-slava@dubeyko.com>
	 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
	 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com>
	 <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
	 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
	 <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
In-Reply-To:
 <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPF5E46643E4:EE_
x-ms-office365-filtering-correlation-id: fc39cc7a-ac20-4848-eb29-08de2871dbd8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZSsrT2xMem5EdEZwR055Q05ORzdOQ2tqdFlsd0FrUW5TQnBYZ0lYL2g0NWox?=
 =?utf-8?B?bWdDdE01eVJ4VzNJSkNMTUhwU2lxL2pBNWQ2NWRsbG1PZW9hS29TZVc5ZlpK?=
 =?utf-8?B?YStqTXI1eEFwVzlGNFg3T1ZNMFgrS2VaR0xoaHNRM1dISit1akVUVTQrbk9a?=
 =?utf-8?B?WTVMeFdGVGt1MFZXaEhsZE03a2F2djcyRWpyOWZCSThRNFZXaEIyL3VSMHNs?=
 =?utf-8?B?bkFlTXYxWGJaOXNCUUl5V21uR3B2YTFVREJlMlF1Qk9qNzdqaFRuS2Z6Z0lM?=
 =?utf-8?B?SGl6Q2dWdmVMTmlncWRlZ1lsUC9sbGJ5aHlEejFQeXpnRUJoRW43d2lya2Qv?=
 =?utf-8?B?bUpsdE5USmVJVHhaNGFNd2NHb2xMS2lBVlRXb1dBcXkvZXJJWUVqZDRaeHhr?=
 =?utf-8?B?Q0xyaG5EemM2VGJNaVdabDFOejluMXRqbTlad0FmN2MrZnlmM2twdDJpbWEz?=
 =?utf-8?B?MUQ4Vkt1WjM3cFJyYWlzZ3lheUkrdHZMS3lsYi9hVlRyaVk1aEpGQ0N1aG1P?=
 =?utf-8?B?QnVlZS9aaTJneXpvakl5TlZFY2ZtQmFSZmhteUtoQjl2bzFYNzl3Vk5NaDBK?=
 =?utf-8?B?SlZLTzc0aVpyNzU5eC9zcEUvN05neGpRbkc1dng4YUI4d2dyTHNhUXFwWGNn?=
 =?utf-8?B?WElhTWdaeDEzLzFKeHRSd3o0MTlyYkdHY0hwYWthaDQrVW41SzBISDg5VmlS?=
 =?utf-8?B?bDJrajA4dGdXZWV2Q3BwUFhVTFFELzZMc0NzRzZVZU4xdWxGV08zZ1RxdzZx?=
 =?utf-8?B?eVVlVkNsVFU0WnBUUmF5S2ZCSm1zRTM2a2tScHNEc1Z0Wms0WkZOQzdlVFhw?=
 =?utf-8?B?RHk2ZVJFWU9FbnJkRXdyaUpKamhvbVBHNENncUFMQ2h1QlhnRXd2cEg2UG5m?=
 =?utf-8?B?SDNEUEg2QU4rQXhFcnVUS1pHWUJZb2sxRzAwbk9pQ1VyNVZlTmVyODVHVjZU?=
 =?utf-8?B?NmRtZ0VDclVWUzB3S05tYlJza3JZYUNWYWp3MUNFT0ZBVDRGZVlRZk5sbGUx?=
 =?utf-8?B?TThPYlpITlBjbEllQTJCZFR1UkgxRkpmS3ZSYXhNVVJGU0FsK09LMldwTDZG?=
 =?utf-8?B?SnB3R0ZPK3R1NWt4VkloSit0VG50Z01xYmFyRk1tbE44VXNDK2hBS2lGWjZL?=
 =?utf-8?B?d3ZRVXFod1hhRzd2K1k2ekhjMzFpS1hZRXkzU0F2MkR5ek9FVWQwQmltN255?=
 =?utf-8?B?SUxNUlZXRU5PTzhqYWlCRzJOU1FHTU80RXZjNG1GMmttR1l4T2lOUmwrMTk1?=
 =?utf-8?B?dWNGWWZoU0Q0cUJ5QXlRUkZtZlEyclIzUTdFN3ZibE5TQlByaHVSVGU2RGlQ?=
 =?utf-8?B?SHAvLzY5WGdPcjRqRUdhTGQxZWNFUDRUbmtSYkc1U1dqNnNOK1NXNjJTSE13?=
 =?utf-8?B?V2hia3k5NlZySm4ydS9GSWR3UFR0SHM4TjQ1NGtTUVZWQ1pHY1hlSlozR1Fl?=
 =?utf-8?B?dGlZMWxFQUFxeXZQZjRXeTVweEdEZXV3bHFFeDFlK2VWMXF6aExZQ1Bvc2oz?=
 =?utf-8?B?d3VpMkFUQnovdUVxMjdEVzVCNmM0d3c3YkpsWWVWYmc5L0ZoYWxZOUlXMXN3?=
 =?utf-8?B?aHU0ZUMxeDV0TWlXQXlLS0MxUDA5Mjc1bXlOMjlKSWRNb0pWOUw3QzZhQUYv?=
 =?utf-8?B?M2M2TzlKMld2eVliOHBNSlBaNjgvMXRQU25EZU1zN2F6anJUTE5QSHRyOWM1?=
 =?utf-8?B?WDkwZDUya0FMbTJ4cXBSNmtKV2dWQUJsMmhsakZZQWJxNWJpcTBQTlI1OUla?=
 =?utf-8?B?L3ljSEJwVEorZEdteTI5OUlWY3ozRFVoeTRyd3NraHNJTHYwcXljaDRPNk8y?=
 =?utf-8?B?WHlaWDZmWWdnR0JXaHhnQUFSR2dlZk9tYUJmNjl1bk9WTmxCbVFQVGNiTTMv?=
 =?utf-8?B?cGxvMmpTVWdpaDlyYndiUjlFdWhqZkFWNXdGL0JKSUFNRFMvRXdtYUZCTjYv?=
 =?utf-8?B?WFRwa1NjdlZkVGYzcEtEM3A5clNpQVpLb09CckNpRCtJRExXcEkwc3lEWlZ2?=
 =?utf-8?B?d3BJUUpVd2FRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEQwMlJLKzdBMmIweHRtUyt1ZllxRUw5SnFQc2p4OWpmamc3WE1XMWdFcy9C?=
 =?utf-8?B?b3YycVhYWUM5S1hJc01VYXJLcUZBNzZKd1Z6WmVCeDZhc2c5TkFRZ0xKdHJS?=
 =?utf-8?B?NFpFS3hUM1pIVjdpNkZrbnFQTUsyeFN2M3lmZUFkZXFvUFV1RWZkTW5FRHk2?=
 =?utf-8?B?NUZHS09CaTZpMEdCRnU3NGR1dW5EcExMM2I3RkpTU0xwVHhUSy9leGllV1Fs?=
 =?utf-8?B?cEs2UUVkaTdLRzdtaGx4V25UTURkUnVwS2FWY0RCbVlqajVxdm95RmZqTE1B?=
 =?utf-8?B?NW4yQklzOWpHRmFGbnE4UG91UFRuYmJYOFh4YmRIdDd4ak10YUJpRzhhdVVQ?=
 =?utf-8?B?enQ3Qkc4amxQRGVHbkFhREx1SXZBdUhvU0l4b0QvQTQzSFJOeEh0MXViV1pN?=
 =?utf-8?B?NHhBbTNkMnFVVlM1bDhoUjlLbzRJOFpCU0lCS0xRVlNndVdJTGhXd0JNRlhj?=
 =?utf-8?B?cUdxQ3YxWnVWYnhOdThORnJ0RWVmVnU2UVpTdm03bWp1YisyY0NFdVprWTNs?=
 =?utf-8?B?ekNqTDlrUUNJb2g1ZXN6cmxsemw3WnIzbHVPVmxNc0ZtZEtoTWRycEVBejNW?=
 =?utf-8?B?S0JTb3RYYTNPZXRDaERJWm1ESnNSaTBjbUtIM2F3SlJsekR3VTVjRmdUazhh?=
 =?utf-8?B?YzFIWU53YnZpS2NlT2UxSEN5ZUtBeVdmVFozNDJnTTJkbDFlVVhYNjkzMjMv?=
 =?utf-8?B?NllCajAyTlRFSDUwQU1DRnNhOGxYa1Z0aGtTa3FUY1AwcjFZODNLQWh1UURF?=
 =?utf-8?B?MkUvMmlQUDExajJRNk5hOW1RWW81RGJiNUxoOHBCdll2M1cvczJPbnN1dWZ3?=
 =?utf-8?B?YmtPdDNIS3JpYXN4em96VkprTkNoLzFXQjZXSlhzdXlXeTZ2K3VvVU9PTjNM?=
 =?utf-8?B?aVkvaWFuQktrMkVWeUhZdWpmc1g4K2EvYlFISTYxdXhVbDdrR3I1RWthaEZ5?=
 =?utf-8?B?em50dWpuR2E3VHJJVHRZNkttcEp1RlZ1UHVwbmIrUy94RGhhUzRiRWtSWUZT?=
 =?utf-8?B?V0Z0dmtvVHBCdFFya1p1anhoV2tHbGtnNlI0U3U0KzJmNW5pamdNQ1cwTGZ2?=
 =?utf-8?B?K1hYN0dTbG95NzhyeVVVamwxTEczcnhrZDdHenp0em1JY0I5eVlFQjZMTm5n?=
 =?utf-8?B?MWFQWFNKRmxWUGJ5QnRIM2ZrMHBMaFlhNWRNVWV6bHUvRDVMLy9obmFkdTFv?=
 =?utf-8?B?Y2RYRTc1RmcyanZhMnNXSmVZQXlOYWp3VDI2eDM0OTlDT3VETjhReUV1M2pk?=
 =?utf-8?B?dTB0SVg1aVBRa0JhQUwvY1hGbmpnUEp1SXMxRVQ1U2VKQmN1WTNtR0dRUjRY?=
 =?utf-8?B?RkIxd2ErbkpzclhuaEVzYm9kQWc3UDU2MDYra29PSmZGajF2R3JkQzBwMXps?=
 =?utf-8?B?eEsxZ2ZZaEJIOFdZd0RFZFEzQUh4OHNKb1kyK1dpdVlYOHFwajYxTmkwNUkw?=
 =?utf-8?B?MUdMMDRhbjNDREpDOXVUditqT0plVGFsZG9CazZmcTZUZ1h6aTdqbDMzamQr?=
 =?utf-8?B?YUFqMzFTQU1pRTV1ZXltTUQ5bzZ0SzJJM21pSy96T1lRcEtoOXhsY2RVUGYx?=
 =?utf-8?B?cUkrYWxBQXNIZ3JsNTY3SkgwVzNRbzhISEJSWDA2S0lWdWdhV2VlL1RmU3VV?=
 =?utf-8?B?VVU5Mkozdkp1a0pZcjlLZytwNy9UdE04QWorL1RyelJNaXdxRWM1c3pyalQ4?=
 =?utf-8?B?S0xXaDVtUjdyZE01VzZQSlU3UVNmK3B4bVg3SFMybWJib2xIeHovS2tXNWQ4?=
 =?utf-8?B?YjlqcnlFNTk3K1Ric3VHYk42WU9nWUtIM2dJMDd5VlloQWJUZmlObWlzNzNv?=
 =?utf-8?B?dEQwdGxYTDdPU1gvWjZmZjNseU9rUEo3VTAwQmZYWlhHU3pTckxDYU01eDg0?=
 =?utf-8?B?QnlYZGtvS2dZcnIyUFZDamJBc0hhZmMyWXZHdGtvck0ycmJoc3RXSXZhR1hO?=
 =?utf-8?B?ZXJ1UVpNZyszcTAvRE15bk5zejFMdSs0K2pSRTh3QloyWGY2UUp4d2NjVGRa?=
 =?utf-8?B?RCtWZEVjczdmNURNNFFxR04zd1Z2RjNwempDRlhKTE1nYUtlN1YzRHNXRGlq?=
 =?utf-8?B?S3ZIRUFrSGVpYkV3MXRsRm9nUDllYmlCdmpZSWIwTVJoK2JlWDBGUHRHcito?=
 =?utf-8?B?ZVBTNG9GWWVCanNJZjZHOUZPZzlEQ3RRUHVoWU9wTnZseXdIeWt0R1N0c2lP?=
 =?utf-8?Q?iXcl2n/UomjJU7R2u8Bzf/Y=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc39cc7a-ac20-4848-eb29-08de2871dbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 20:17:41.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTOs3oYsQmOyxya/MrgvEBPHSy6UVGtIUT/a5oU5cmmiKleL0hodipkRXnez48yQ/HGDTj51190QI7SeeRWRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF5E46643E4
X-Proofpoint-GUID: VFkATLf-q46FqqAtxn56YTcIv3LKKfd6
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=691f776c cx=c_pps
 a=UPJ12yLMGL5ZZCNrBMA7tw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=wCmvBT1CAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=kdeKMrbvqRx3kLKz8b0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: LbIHprJ36a1sR2x2EhFWyuhcjXia2fSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8XJPkHDKhW5R
 36wiSA1cXMY4AFP74d0cRdCYAKt+kI99zhz0R6+kefafPh2htHBRV0LyG9Zc3Ay66hNsWPnvsZx
 J5By7g+9r+gvNHJALVpsCTxm9ud/rOjuVfOHZtIqaDYP99BLXKJpPRVm/NMqmsIpH7j5EBY9QWm
 RV7fuqT4odyzH40P4AkYTtqKToedqBcPx3Jn35Dv0XoGr+4082Gm/Whr2LgUK7bHUQHqUOBZaIC
 vuQ4zAKHDTbGrx4m3AAxO2DTPpBGBlzkZaKbD9jWXaRkQe7nojz05ABnMeWHoyhqjhKtIX66GXS
 MY22dwWm0vt/xZxkuRB0Bd6FtBIlmKiYrdLL+TRpVkSAGSBzJqNZqv1zaXk+u0Kh1F0VPBxQA/G
 4j5qrD0I0tdaHGtK9oZWl3REmXFIWA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <013552575358CA4F9914026FF92B8749@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_08,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511150032

On Thu, 2025-11-20 at 19:50 +0530, Kotresh Hiremath Ravishankar wrote:
> Hi All,
>=20
> I think the patch is necessary and fixes the crash. There is no harm
> in taking this patch as it behaves like an old kernel with this
> particular scenario.
>=20
> When does the issue happen:
>    - The issue happens only when the old mount syntax is used where
> passing the file system name is optional in which case, it chooses the
> default mds namespace but doesn't get filled in the
> mdsc->fsc->mount_options->mds_namespace.
>    - Along with the above, the mount user should be non admin.
> Does it break the earlier fix ?
>    - Not fully!!! Though the open does succeed, the subsequent
> operation like write would get EPERM. I am not exactly able to
> recollect but this was discussed before writing the fix 22c73d52a6d0
> ("ceph: fix multifs mds auth caps issue"), it's guarded by another
> check before actual operation like write.
>=20
> I think there are a couple of options to fix this cleanly.
>  1. Use the default fsname when
> mdsc->fsc->mount_options->mds_namespace is NULL during comparison.
>  2. Mandate passing the fsname with old syntax ?
>=20

Anyway, we should be ready operate correctly if fsname or/and auth-
>match.fs_name are NULL. And if we need to make the fix more cleanly, then =
we
can introduce another patch with nicer fix.

I am not completely sure how default fsname can be applicable here. If I
understood the CephFS mount logic correctly, then fsname can be NULL during=
 some
initial steps. But, finally, we will have the real fsname for comparison. B=
ut I
don't know if it's right of assuming that fsname =3D=3D NULL is equal to fs=
name =3D=3D
default_name.

And I am not sure that we can mandate anyone to use the old syntax. If ther=
e is
some other opportunity, then someone could use it. But, maybe, I am missing=
 the
point. :) What do you mean by "Mandate passing the fsname with old syntax"?

Thanks,
Slava.

>=20
> Thanks,
> Kotresh H R
>=20
>=20
>=20
> On Thu, Nov 20, 2025 at 4:47=E2=80=AFAM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > On Wed, 2025-11-19 at 15:02 -0800, Gregory Farnum wrote:
> > >=20
> > > That doesn=E2=80=99t sound right =E2=80=94 this is authentication cod=
e. If the authorization is supplied for a namespace and we are mounting wit=
hout a namespace at all, isn=E2=80=99t that a jailbreak? So the NULL pointe=
r should be accepted in one direction, but denied in the other?
> >=20
> > What is your particular suggestion? I am simply fixing the kernel crash=
 after
> > the 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"). We didn't h=
ave any
> > check before. Do you imply that 22c73d52a6d0 ("ceph: fix multifs mds au=
th caps
> > issue") fix is incorrect and we need to rework it somehow?
> >=20
> > If we will not have any fix, then 6.18 release will have broken CephFS =
kernel
> > client.
> >=20
> > Thanks,
> > Slava.
> >=20
> > >=20
> > > On Wed, Nov 19, 2025 at 2:54=E2=80=AFPM Viacheslav Dubeyko <Slava.Dub=
eyko@ibm.com> wrote:
> > > > On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> > > > > On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko <slava=
@dubeyko.com> wrote:
> > > > > >=20
> > > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > >=20
> > > > > > The CephFS kernel client has regression starting from 6.18-rc1.
> > > > > >=20
> > > > > > sudo ./check -g quick
> > > > > > FSTYP         -- ceph
> > > > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PRE=
EMPT_DYNAMIC Fri
> > > > > > Nov 14 11:26:14 PST 2025
> > > > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213=
:3300:/scratch
> > > > > > /mnt/cephfs/scratch
> > > > > >=20
> > > > > > Killed
> > > > > >=20
> > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > > > > (2)192.168.1.213:3300 session established
> > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: clien=
t167616
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NU=
LL pointer
> > > > > > dereference, address: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: superviso=
r read access in
> > > > > > kernel mode
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_cod=
e(0x0000) - not-
> > > > > > present page
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 00=
00 [#1] SMP KASAN
> > > > > > NOPTI
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 =
PID: 3453 Comm:
> > > > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name:=
 QEMU Standard PC
> > > > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strc=
mp+0x1c/0x40
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90=
 90 90 90 90 90
> > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 =
90 48 83 c0 01 84
> > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f=
6 31 ff c3 cc cc
> > > > > > cc cc 31
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff=
8881536875c0
> > > > > > EFLAGS: 00010246
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 000000000=
0000000 RBX:
> > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 000000000=
0000063 RSI:
> > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff88815=
36876a8 R08:
> > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 000000000=
0000000 R11:
> > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff88810=
61d0000 R14:
> > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85=
c082840(0000)
> > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: =
0000 ES: 0000
> > > > > > CR0: 0000000080050033
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 000000000=
0000000 CR3:
> > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > > > ceph_mds_check_access+0x348/0x1760
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > > > __kasan_check_write+0x14/0x30
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get=
+0xb1/0x170
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x3=
22/0xef0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_=
open+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > > > __pfx_apparmor_file_open+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_ope=
n+0x7bf/0x10e0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_=
open+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d=
/0x450
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0x=
ec/0x370
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0=
x2017/0x50a0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_=
openat+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > > > __pfx_stack_trace_save+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > > > stack_depot_save_flags+0x28/0x8f0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot=
_save+0xe/0x20
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+=
0x1b4/0x450
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_fi=
lp_open+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_obje=
ct+0x13d/0x2b0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > > > __check_object_size+0x453/0x600
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_u=
nlock+0xe/0x40
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat=
2+0xe6/0x180
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > > > __pfx_do_sys_openat2+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_ope=
nat+0x108/0x240
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > > > __pfx___x64_sys_openat+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > > > __pfx___handle_mm_fault+0x10/0x10
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+=
0x134f/0x2350
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64=
+0x82/0xd50
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_=
64+0xba/0xd50
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_che=
ck_read+0x11/0x20
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > > > count_memcg_events+0x25b/0x400
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_f=
ault+0x38b/0x6a0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_che=
ck_read+0x11/0x20
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_ex=
it+0x43/0x50
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fa=
ult+0x95/0x100
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74=
a85bf145ab
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00=
 41 00 3d 00 00
> > > > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 =
ee bf 9c ff ff ff
> > > > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8=
b 54 24 28 64 48
> > > > > > 2b 14 25
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:0000=
7ffc77d316d0
> > > > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fffffffff=
fffffda RBX:
> > > > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 000000000=
0000000 RSI:
> > > > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc7=
7d32789 R08:
> > > > > > 00007ffc77d31980 R09: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 000000000=
0000000 R11:
> > > > > > 0000000000000246 R12: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000f=
fffffff R14:
> > > > > > 0000000000000180 R15: 0000000000000001
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked=
 in:
> > > > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common =
intel_pmc_core
> > > > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry=
 intel_vsec
> > > > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_in=
tel aesni_intel
> > > > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_sm=
bus vgastate
> > > > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parp=
ort_pc ppdev lp
> > > > > > parport efi_pstore
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 000000000=
0000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace=
 0000000000000000
> > > > > > ]---
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strc=
mp+0x1c/0x40
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90=
 90 90 90 90 90
> > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 =
90 48 83 c0 01 84
> > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f=
6 31 ff c3 cc cc
> > > > > > cc cc 31
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff=
8881536875c0
> > > > > > EFLAGS: 00010246
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 000000000=
0000000 RBX:
> > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 000000000=
0000063 RSI:
> > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff88815=
36876a8 R08:
> > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 000000000=
0000000 R11:
> > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff88810=
61d0000 R14:
> > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85=
c082840(0000)
> > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: =
0000 ES: 0000
> > > > > > CR0: 0000000080050033
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 000000000=
0000000 CR3:
> > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > > > > >=20
> > > > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > > > >=20
> > > > > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > > > > >      ...
> > > > > >      if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_=
name)) {
> > > > > >              / fsname mismatch, try next one */
> > > > > >              return 0;
> > > > > >      }
> > > > > >=20
> > > > > > The patch fixes the issue by introducing is_fsname_mismatch() m=
ethod
> > > > > > that checks auth->match.fs_name and fs_name pointers validity, =
and
> > > > > > compares the file system names.
> > > > > >=20
> > > > > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/m=
ds_client.c#L5666 =20
> > > > > >=20
> > > > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > > > ---
> > > > > >   fs/ceph/mds_client.c | 20 +++++++++++++++++---
> > > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > > index 1740047aef0f..19c75e206300 100644
> > > > > > --- a/fs/ceph/mds_client.c
> > > > > > +++ b/fs/ceph/mds_client.c
> > > > > > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_mds_se=
ssion *s)
> > > > > >          mutex_unlock(&s->s_mutex);
> > > > > >   }
> > > > > >=20
> > > > > > +static inline
> > > > > > +bool is_fsname_mismatch(struct ceph_client *cl,
> > > > > > +                       const char *fs_name1, const char *fs_na=
me2)
> > > > > > +{
> > > > > > +       if (!fs_name1 || !fs_name2)
> > > > > > +               return false;
> > > > >=20
> > > > > Hi Slava,
> > > > >=20
> > > > > It looks like this would declare a match (return false for "misma=
tch")
> > > > > in case ceph_mds_cap_auth is defined to require a particular fs_n=
ame but
> > > > > no mds_namespace was passed on mount.  Is that the desired behavi=
or?
> > > > >=20
> > > >=20
> > > > Hi Ilya,
> > > >=20
> > > > Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"), we h=
ad no such
> > > > check in the logic of ceph_mds_auth_match(). So, if auth->match.fs_=
name or
> > > > fs_name is NULL, then we cannot say that they match or not. It mean=
s that we
> > > > need to continue logic, this is why is_fsname_mismatch() returns fa=
lse.
> > > > Otherwise, if we stop logic by returning true, then we have bunch o=
f xfstests
> > > > failures.
> > > >=20
> > > > Thanks,
> > > > Slava.
> > > >=20
> > > > > > +
> > > > > > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D%s\n",
> > > > > > +             fs_name1, fs_name2);
> > > > > > +
> > > > > > +       if (strcmp(fs_name1, fs_name2))
> > > > > > +               return true;
> > > > > > +
> > > > > > +       return false;
> > > > > > +}
> > > > > > +
> > > > > >   static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
> > > > > >                                 struct ceph_mds_cap_auth *auth,
> > > > > >                                 const struct cred *cred,
> > > > > > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct cep=
h_mds_client *mdsc,
> > > > > >          u32 gid, tlen, len;
> > > > > >          int i, j;
> > > > > >=20
> > > > > > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%=
s\n",
> > > > > > -             fs_name, auth->match.fs_name ? auth->match.fs_nam=
e : "");
> > > > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, =
fs_name)) {
> > > > > > +       if (is_fsname_mismatch(cl, auth->match.fs_name, fs_name=
)) {
> > > > > >                  /* fsname mismatch, try next one */
> > > > > >                  return 0;
> > > > > >          }
> > > > > > --
> > > > > > 2.51.1
> > > > > >=20
> > > >=20
> >=20

