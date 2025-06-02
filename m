Return-Path: <linux-fsdevel+bounces-50378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B819ACBAB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2E3BE5E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B3230D35;
	Mon,  2 Jun 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b9xfwJoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDD22A7E7
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887340; cv=fail; b=kMDplTW9oqMEk/JOT0r34RMZS5NERCI4ST8MqFuAarzU/iO/Sk8nCgY0uElJnVxu6d/FLbKoqOS0R7k78QZRzfOg4WECVOF9PyusGXX/T8jstV11kQ8wwlcXrhkr3FRp9NpbHm/3F93ShWHX4HwoRNMQqbQAr5zCP3z9zM3XMPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887340; c=relaxed/simple;
	bh=11IRZviKEU5saIwZWMYTJfbbNdq6m4neVVLkPRAaZGg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tNKUXxtc2lr3ZrfpdKhxVY1PfNt/BrNjIpASQn2vvlYNwKQ5U7TI13DoUXW+8n4w5oc+Qn6oZVSW3uSVWjOc87dqNQzNvLFtx/WlgLjV9ECaWWKe22HMkWyKIQupKeEF9q7otirgNwkWhkFbdmkqdFE452wpmcwSEl2PuJ2ERJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b9xfwJoV; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HXg1m020652
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Jun 2025 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uJgz6n7YkfNKzF4c3/D53jgLyS64FnPiAwPJLPRWzwA=; b=b9xfwJoV
	9S5Su0uPuwRoenPeA7rtAfFbd1vnhbeDi7jkFkySjS6P2wzJmHmhnITMH4tEXq9c
	6eMpBXShRx3qzp/E6b1/dh0SjukQJ9MjFGFXdsoaFRqLqZm6+k69kbn22WKziRHy
	eoJXDEWOcGA69A7rAtOsc/7D9foFtx5uqIo7FvB8MXjJPVvFYZtylz88Mmogbb/0
	Q83Wct/XnvOaMQ0WG024QxpqGhsIBYs/yroLzZaxZ53+cB1gS6vgS3vObFnYCv3M
	gJ4eO3BWkZO6DGV++07/pZKWzoKYGGd7GKYj0kMFtmN8vQvHuBLDhtgXhr+OX4Ak
	+mCJrUDUUU8jZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyg3dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 18:02:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 552I2HUP011054
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Jun 2025 18:02:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyg3dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 18:02:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 552HkMaD013712;
	Mon, 2 Jun 2025 18:02:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyg3da-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 18:02:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSEs4t6/kIhgeWPJd+JyZvsjNWHvFCxd/xxVxOjmB64OiL3pykQY3WZauvmItBKLaYOTVA0f+lM83Sf+gLNFFiwvWmuhvkyCorOmcu8M8VdNUA9ogSjl4rwRnJbRD6eW3jjWjBKhym8bueqAH/oBeG+KZm+zzEHBHJWTnDc8X0Sq3I9u7iqECODw91sMSJ1D6u0Onc3ya2oU135foSmEphwrbkk8wkT+REdLEMl9rynmtrky82nj7J8oEhvFui6Hp/pqG5WPiK7mAmeUcvx0cYssFpsIfteS8EecSCSGh3iIuznvyCm3kOFaqqzLf7owRuVmY8pGl93okeQX28xQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIp/Ra2i9WLjlICIdLTca9mXW4TxuLXuAp4oo6Hu9eg=;
 b=w552lWtCi+T3yC1ge9ovXiY6jDOgVCW39FqxiCUWpIPIkLm7ilnXl0WfuIsruABnvlkqGnlo25S2X2YkgaCPvqZz6Y0tDkCF9f9Tmo2lOzEeM+DLZshFOZ1nHLrK/K75jEGNKGAoDeQ5aw8gHJw59iRMe9jSKl8Ezl1krnUtdluS/9pRbEx8LNG0QouwdOWUxO+/NrZ2LS/IiwNmplisv3WOboLCo9BFQTXOS6/L9m1xz7GaASSvonN3s+AUWp9exC9s5W7+Ov3XcRl7LiSZ9MmCxyUcvBd95wUykjUR6BKpEYBduATA5e7lAjhzluZ8DMGYklhcMUt9SX6iCNEKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4381.namprd15.prod.outlook.com (2603:10b6:510:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 18:02:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 18:02:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "lkp@intel.com"
	<lkp@intel.com>, David Howells <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix variable dereferenced before
 check in ceph_umount_begin()
Thread-Index:
 AQHboBFWOIOjo1BdNEKndu3nF/bxmbOI74AAgAW05oCAAINcgIACfQoAgF4y4oCAALkUgA==
Date: Mon, 2 Jun 2025 18:02:06 +0000
Message-ID: <0cab1bafe0ce610e4d5ce3ab5e886e3dc54845a1.camel@ibm.com>
References: <20250328183359.1101617-1-slava@dubeyko.com>
	 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
	 <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>
	 <20250401-wohnraum-willen-de536533dd94@brauner>
	 <3eca2c6b9824e5bf9b2535850be0f581f709a3ba.camel@ibm.com>
	 <20250403-quast-anpflanzen-efe6b672fc24@brauner>
	 <CAOi1vP957QhFQnvNeJpN+v9zTYEtXaNcHMsZMheeRNNnnYdSKw@mail.gmail.com>
In-Reply-To:
 <CAOi1vP957QhFQnvNeJpN+v9zTYEtXaNcHMsZMheeRNNnnYdSKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4381:EE_
x-ms-office365-filtering-correlation-id: 84e4599a-5a63-4bc0-1005-08dda1ff95f5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2xEQ0szUURBK2x6WTVZMUtpUWM0Mkx0Rnlic2JENVFBdEdGeW1Eb1RIbGd1?=
 =?utf-8?B?OGR6cmJVNXEwaVcwcnl5ZnByU0U2NjlxYW13MVVZL09qdU55b3diSWk4c0Rx?=
 =?utf-8?B?dGFiWkZYZXQ0Mm1HYXdjbFNwNHB4bmlONGtkQnJHL0FGcWlYK0Q4a0dyckdQ?=
 =?utf-8?B?RVZ6YklENU9TZkoyeTkyK0pqT0N2R1JCUTlvWStrWGpWS1NJWGIxYUVUTEc1?=
 =?utf-8?B?aDFycy9TRlo1RlRsTXl1czAzOFdYKyswY1ExK1lZNmFiNmFRODFFQWkzSGRL?=
 =?utf-8?B?L05PN1l3NzFDTXFLVmFJVGFGOHpLVitaVWZueFVGTWw0dE4yYlZwYmdSQko0?=
 =?utf-8?B?RVAvSGUzbnlTb1JaY3BvcitOcnkrT1pmcHlBRkovTmgrdFU4Ynp2dlBzRmVi?=
 =?utf-8?B?eE9lQktOYk1PQ2N1TWRYSkJ2YkhCQUoyK0hnZDl1eVlPYjBtM21LVEdyV1RH?=
 =?utf-8?B?SktmS0x0Vm5HaW1lcE9lV0lGYjhPcFYrczBOU2FmdEZPZTE1TUhCRzAwaTgw?=
 =?utf-8?B?d0dZVzFMQlV4WS9rYUpHTDhXVWhLSUgwSnkrT1BMYUdwTkdvRWxGbjlaaUVE?=
 =?utf-8?B?eWdDTFdkQXpFZEFhOHZpbXRpd0FDWXNXY25jOHRuUlQ5YUN2K3hTTW15K1Ra?=
 =?utf-8?B?Mmg3VXVXY3dTZkF5V09QVUxGaFEzSWt0dU43QTJYSWhjY25OSGJSWDJkQ0xm?=
 =?utf-8?B?Z2NUYW04RmJ3RnEydXFXeUd5cXZqSGE4b0Z6aHBFRHB1VHdzbGpuTjRTUU1n?=
 =?utf-8?B?TXdDNFlHY1dwWUp2a1M4N250bmtaa25zZkIrbEorcjhRSVFpRWVtWXJNdzZP?=
 =?utf-8?B?Ykk5bndmWFhqVGx1dlg3aDQ5Q0hsTGRoV205UHFKZlNwYXF4Nzk3czNyVEov?=
 =?utf-8?B?MWsrQWVCUVdsQmhLam5CdlZMOTJJYnZaTkdrWjdvTGhQejBzTXBLYlFKRVpl?=
 =?utf-8?B?clFSaWlLRythVkxBZU9ZQjVuY1FZeW9ybVMzb09Fb1dJN1pSZ0dTVFlBYnhJ?=
 =?utf-8?B?Q2k3YmVLV2YzQTJ2WUNKSUs5b0lEQXplaC91M1o2L3o4ME5SOEtvMVhTb28z?=
 =?utf-8?B?dHFVaWJBaHRsckY1U3FTZ1o3K3N3QnRBQk13ODNOTVdtaEdxb3dEK3pRalky?=
 =?utf-8?B?MlZDaXVqMitzUkxqNnVyR3lmMndWeG9hdVg4a1NmWVpIZ1FTTlQrMzdIeCtJ?=
 =?utf-8?B?bXgxN050aE9FK2MyWFBLM2psamVFTzFlVitXWk1Nd25RWTl2Tlp1c1pkUXVl?=
 =?utf-8?B?OU8xRXhnb0E3Z29sd3l2SEZrQW5kNjk1bExIMXdVd3AxUDFCeUF6b2JSK2p3?=
 =?utf-8?B?WGNIK0RtdlcxaXJzVThvQzJIZ2VOQm9FczZud1FncE9FUE5xVG12WWg0Qldi?=
 =?utf-8?B?Y2Z0MHpuSkNZVEFpOFduRk5ua3ZiY1JBK2ZBcEwrRGxmK0MvZVEwVUh0ZjNz?=
 =?utf-8?B?QlErOUMxVklGZGtYYjV4ZkI1OWFBTFFrWnBtWlp5ZnNJUUxJbjZ1WnBpM0lx?=
 =?utf-8?B?cVkyQ3NPWWhvbmtLcWx4VVlKTFl4Q3NWVW9CWHVFQnJUMDIzeXJTS3dzU0Rz?=
 =?utf-8?B?UjlhbFZiYk1yRUxJQzFDMk9mZnZ6bUlQczBISm9SVUVscGZOdS9zcHNFMUU0?=
 =?utf-8?B?dlZyWnNmMll6TlRidEd5bWJLWTVtV0cwdTB2M1MyWDRPeWlST01vRytibDNT?=
 =?utf-8?B?cFpnQWxHSk1TNE9CUWNUZHBnNnNjVDBxaGVTVzB6WUpiMDN0UTRZTDVYbVZj?=
 =?utf-8?B?QkFpcXRSbUE0VGpoWTY5MzFsWFFhWE1ycHJmeVBOSTRrMFpJbndoRnVza2lM?=
 =?utf-8?B?QmI0cDlzTXMxTHNIa21kOXlUbUVRa1JFV0xTOUpWQWwvK3Yzd3JJWlViaGQr?=
 =?utf-8?B?V3ZRcm4zV2JoRjJVQVdpZHNzSTZDcDhXcTA3Mk1QVE02VlhuVkh6SmJlU201?=
 =?utf-8?B?U2s0Q1E1SGxOYm5OT3BvZndlS0k3V0FuQ25XQ2ZWOUhIeWE5SzVjQXUzaGdh?=
 =?utf-8?Q?vpkduFcSHA+VehQxRSooM1KE54X6s4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnRqMXliN3Y1WEwwcnhHU2hFL2xJSXQ5U1g4VzloeENXQW5BYTlTcTlIdjdj?=
 =?utf-8?B?bTdDT1A5RnRSTS9JWEVTTm5EZ0RWREZJU1JHdHdBQ240Q3JwZXIydXVFTGxv?=
 =?utf-8?B?TTBiNGtNbHl2Y2w1UldieDUxVXlVMWZmTEE3RWdGSXJvR3FtaEZwVEt6dlNN?=
 =?utf-8?B?bXhZQlBaRWUvRnovSkdZRWJ6VnNKVGJUN0VHNjZ6OUdhYzMrV2hHTnI2Z2tU?=
 =?utf-8?B?c2QvMlFJeFNWOUhnVVlKanJEbFpSdGtlYkRaVjVYbGNHV3Z2RS9qUWpjdG8z?=
 =?utf-8?B?eG9tYUdralhDeDJFUlJ0MXRndWQrRDN2b0tnbmFWWVRRM1JiVitYQU9DWE1C?=
 =?utf-8?B?cXFjMm9aV1NnTGl0SERMMmwvMmZpT0trakxHWnNoc1N3eWZwN2FTUXpkUEFj?=
 =?utf-8?B?V1JjcTVkNWUxNzE4V3ZnMW52UDBHdmgrVEoxK2NtZUovR3hCM282a042N081?=
 =?utf-8?B?L2NzNENsSmNOWEJ4b0thNnJiK3pDSUEzTU9ZNGNWUlBIVUZjQVRqOGFMOWJ5?=
 =?utf-8?B?MlJWQkczYVFROWhOVXR5QnFwTTZEZE5PTlJjV3dNWjRoNjdoZGFvOFZ2UDVW?=
 =?utf-8?B?ZlNsNUVZMWhDV0RtakxvVGVWQnFJVGJrTGtGWDZzQnVBbmVFVHVXL09lOExC?=
 =?utf-8?B?UzNoZXdpVGNtZTlyRkhtdlc3d1pqVXlDNkdpYzh4NkwzLzdmYmhFZlZMZm9H?=
 =?utf-8?B?K0JNTjlLN205akc5L3E3SitYbjc2RFlOU0dFR3JYUTZQTFNCbWluMjdoVzJy?=
 =?utf-8?B?Zmp4M3g2c1dBYnhsQjl3WVcrcWJrOHZWKzRycXQwM3hGRkZDcnlJZURNbTRX?=
 =?utf-8?B?TUkxemsycW5kSzlPQkU2TEs5Z1pQRHM2VU1ueUd4N05ONis1NXNrUTViQ0c1?=
 =?utf-8?B?SXh2S3UrdENsdTJUYTA5SmVkYXUwQ1Y4dG1pVHd4VGdnSk93VTlzbThDc2JM?=
 =?utf-8?B?aXZ1Vys1U09hVVR5K3BXYVlrdjVBSEwvZWVpc241c1oxMlhFNmhRQ1hGR0Zx?=
 =?utf-8?B?UGN1TTZ0djdzeGpTaGQxSXFKZXhoNTBKWlphNElOSm5xZzNKMUJxdU43S2NX?=
 =?utf-8?B?aHV2U1AzMU41aDlCS2xPdXFVOXhhMTYxeXcrbk5tWURzWWhSWUQ1R0ZWVFhS?=
 =?utf-8?B?RUhydlVMZmFPR1RNVGsrd29hdkVrY3pKbk5aYmVOSlJlRENsZFJ3RktQUVBE?=
 =?utf-8?B?SVltdWVXTGtNdVp1N2ZISUR5cGcvQ3BXeEJReGF3dWxVRWRQNnk1SURFRVV2?=
 =?utf-8?B?ZWwxbGJtNGpWRDIxaWdzcUk0T1lGcy9vZ20wREdYTHVXNGNWL0F5MkZwdWJm?=
 =?utf-8?B?eDE3bVE1S1dhTU9RSEpjaVk5REg0RDVzTVM5ZG1sQ1M4T215M211NkZwems1?=
 =?utf-8?B?VFdYaTF5YktnN1R4MXZBWklzUitwZndyVi9RQkl5cTlxeUVZVGlSWnNCdDJk?=
 =?utf-8?B?UlN0elB0S2diSDlLUDlDQXV1dnBaQlBDLzlYRFBYbFZvNUQrVFV2K2NYVlE1?=
 =?utf-8?B?T2tpUmhVZlB2NVMvRUVFY1JDMDFOdWU1RUZmVENhTzEybVMrUVJGOStKQ0Na?=
 =?utf-8?B?MG52Uy9jNUI2L1hSczAvbHBkUC8wVWUwTXh4eXAzQnJ6YVNyQzVDTzZDVGtm?=
 =?utf-8?B?NDJVclhMTnJVMFYzVVIyWE5JVXlrbllaVUhoUnlhaFVCaGdIT09ZenAwVFBI?=
 =?utf-8?B?OW9kSkUvbkdtUi8wemdWRFJuUHRpWDBnellTaTZYT0RUVUI0bGV2UFg1OWM5?=
 =?utf-8?B?U1hMcWlQWCt1cXZKYk16MkNRcFQwZUd4QVUraHFjdDhialJIL05TK1JPYkpl?=
 =?utf-8?B?MzYvSjkwOTFkMUZURSt4T3hUem53bXlEYTdtZHQzZngwblQ3dERNdHhHVU9h?=
 =?utf-8?B?WHVXczV3TVVCZEhVYm1FMUYrWEpPRmNML0IycU44cEswOVZ0eDB3MUNtQW50?=
 =?utf-8?B?bzVBblhMRW0wQzhhRHQxVVRSYk5XdFE5YUpCTWRjRG9nSi9Mb1QzbnpDMGFz?=
 =?utf-8?B?SkZHQ05ua0NtN3JNZGQ4RUlGOUVVMldoekRWdlpLeXYxSFdPNWlmdWNuWXlC?=
 =?utf-8?B?WkpkOGlYM3Q5UkpwbkZaQXZaRHFVUUtmZHJBd2pROExtak9IWnd6djRPWGw1?=
 =?utf-8?B?WVgrUnNHMzg0aHBFOWw1NTk5cHZiMXVrQ1FDUkVWcFVEbFRVUG5FMUs4Y0lh?=
 =?utf-8?Q?ZOSVAr8oo5MYlTVj4Qhg83I=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e4599a-5a63-4bc0-1005-08dda1ff95f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 18:02:06.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RDxOX307r/zrlaBFxj5OYa/x0EloVhqBNqMnqLepKf84eRGIagnfSh77KW03FpvZbDDs2XAPKUSolRIQSqyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4381
X-Proofpoint-ORIG-GUID: Y4qk7-5Q_cD0fuRqauiLdH1M4wLNQxL3
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=683de728 cx=c_pps a=YNtVZP3g3G3IEJniYGmi4w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=p0LAs7SLpMyctwHygUwA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hRUvI3cRfYQ4wOE6ytBbbvzGuXvGWzBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE0OCBTYWx0ZWRfX9oRgzAwbUOJu KV8WHDKHCo1JD4e3UgPu7vIeu86wCVNoM3WPSF3eQk7SPl81QMieFaeraQrL1fjFiHg9s7RM153 JGYQszbbkJkapMYClNjW/70ZotlY8o8tQKH2E4ULZy4KOCrbAzm1ShU2QntQ3jzh43ailyOEmdc
 BZsRME4NbZs7neZhz8FuHqcyY7xrjb3tT7Y7Ax66DhGL1tAgCWhCMb4KXthi0A4x6QdQzFPFA/w MKKshaga3FmEVW1tuZAY0E19uzenEVH18dXqEdq39UZsVB6vl3LH+KI+a2v/bI8RSUfZy+/u062 v0YKZPq5j3IAz93GqZsrTjHXYHaq5ZBzVADzTqOBgH36f74J/KgW8BLjHeSV7rfLx4KrNKNEhqg
 3Z9/4qPe5jhcE+eUlZr+v2FiX9jzP7/yoJUHuMIk4c4t/67UY7GxV4FRwDgmRUTJG4kC6Jbe
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CBB1A2419DFB442B8BFC423465DFD50@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=790 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506020148

On Mon, 2025-06-02 at 08:59 +0200, Ilya Dryomov wrote:
> On Thu, Apr 3, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >=20
> > On Tue, Apr 01, 2025 at 06:29:06PM +0000, Viacheslav Dubeyko wrote:
> > > On Tue, 2025-04-01 at 12:38 +0200, Christian Brauner wrote:
> > > > On Fri, Mar 28, 2025 at 07:30:11PM +0000, Viacheslav Dubeyko wrote:
> > > > > On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> > > > > > On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wr=
ote:
> > > > > > > This patch moves pointer check before the first
> > > > > > > dereference of the pointer.
> > > > > > >=20
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > > > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@i=
ntel.com/ =20
> > > > > >=20
> > > > > > Ooh, that's not good.  Need to figure out a way to defeat the p=
roofpoint
> > > > > > garbage.
> > > > > >=20
> > > > >=20
> > > > > Yeah, this is not good.
> > > > >=20
> > > > > > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > > > > > index f3951253e393..6cbc33c56e0e 100644
> > > > > > > --- a/fs/ceph/super.c
> > > > > > > +++ b/fs/ceph/super.c
> > > > > > > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_bl=
ock *sb)
> > > > > > >  {
> > > > > > >       struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> > > > > > >=20
> > > > > > > -     doutc(fsc->client, "starting forced umount\n");
> > > > > > >       if (!fsc)
> > > > > > >               return;
> > > > > > > +
> > > > > > > +     doutc(fsc->client, "starting forced umount\n");
> > > > > >=20
> > > > > > I don't think we should be checking fsc against NULL.  I don't =
see a way
> > > > > > that sb->s_fs_info can be set to NULL, do you?
> > > > >=20
> > > > > I assume because forced umount could happen anytime, potentially,=
 we could have
> > > > > sb->s_fs_info not set. But, frankly speaking, I started to worry =
about fsc-
> > > >=20
> > > > No, it must be set. The VFS guarantees that the superblock is still
> > > > alive when it calls into ceph via ->umount_begin().
> > >=20
> > > So, if we have the guarantee of fsc pointer validity, then we need to=
 change
> > > this checking of fsc->client pointer. Or, probably, completely remove=
 this check
> > > here?
> >=20
> > If the fsc->client pointer can be NULLed before the mount is shut down
> > then yes. If it can't then the check can be removed completely.
>=20
> Hi Slava,
>=20
> Have you had a chance to follow up on this?  Given the VFS guarantee
> confirmed by Christian we don't need to check fsc and I don't think
> fsc->client is ever NULLed -- the client is created right after fsc is
> allocated in create_fs_client() and destroyed right before fsc is freed
> in destroy_fs_client().  It seems like the check can just be removed.
>=20

Yeah, makes sense to me. I can rework it.

Thanks,
Slava.

