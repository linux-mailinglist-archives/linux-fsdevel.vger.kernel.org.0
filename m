Return-Path: <linux-fsdevel+bounces-29209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA0977172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56ED28798E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F91BFDE5;
	Thu, 12 Sep 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMo8wfla";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bR0MBVje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE67DA6A;
	Thu, 12 Sep 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169364; cv=fail; b=aAAicxoZekv0p1/C/A/6nNtd7vXBPDWJqm3RmJehUgXma960pFp38W+KoH13pdGY7bwUeoD0+rhuc/utKqh/B41U+pD6tzp1oY89Ugw8MyvtMM3UHuVoX0ybGdYRh4tbKPawUSIuuYrwvACio+GGN3lZM2DB/WgJ765y6aH9Zik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169364; c=relaxed/simple;
	bh=p2ndJ/j9oBMgL3+j2wlvYQdoJ+wAX+I+rARzPbWQI7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtOYnnVlNXaWfgXzdeXrTN9P4dfWHfSLeF5au3xoR7Q00/WrhaZ2jhyZh5Kf1wEl14OJ6bMZN3GhDUE/DTgrrHA5FnqO38K+kTUkeuVTgxkcY6WEjoyZbyUjteZ6a54NFGLpj0jX7L78Iuxyk2XGUt+y8dqcSit7Ep4H0/q+kNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jMo8wfla; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bR0MBVje; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CJQmx8030133;
	Thu, 12 Sep 2024 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=p2ndJ/j9oBMgL3+j2wlvYQdoJ+wAX+I+rARzPbWQI
	7o=; b=jMo8wflauPGnL1DV1qdu2uAOCNCOevf4jgTcXlSxDKm++QZr7YyvM/M8/
	nV8Xy4LHoEGITJ/gHeobzFGJBN7homqEZxRGe03/n+eKOqcpv6hP6jP/+/IS4OMt
	T8XdxUejYrXZrVM54Srm/yOgEB8njE49y8Z6K9szEAoxrBoU88UtHV0iSkC+gju4
	vggJInjqQSDzyxPl7P12op9/QsXJwjKo7qVCZJMbvc45IzG5XFmbXWsGP7EORhTb
	iJx33Teg5WNYwf56nDFhvmjw22V5aNeQQpBi0+zx5PX1M5rAQ0M23KMf79WAJOjV
	GWbULjiaHEkuQK+veoQgpHXijLrXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0bupx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:28:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIrkCJ004967;
	Thu, 12 Sep 2024 19:28:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bs29t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMqp4taqacqTUk1TES6YSi/gVcmpI1T5BmiiUgYN3zMspSf81Lwr30zzJJy8lO2nabdN+2pkHtEF4KRo8mLpJJ7I589yPCoevTMjv9rCmkph9em6pe21KxM4juv7PVKwopHQ8neSlF5+TYI+rhQMswkZRh+TJ4KgfKqM2FoiGiiNzJEY/YSqD9wze5BwLRVZiDRUfu7h87rM9egtCgjSiI8IivdBJWCVA9WWgQB7dBdh6fRZ/EtAv67bfTlE6BcfGZ6g1fArHxd9a8qWvMaT8Xz8J6lfWf2W41+qXdsn4g25ZiVE8hnieG7b/rSxEHAxba3vNdxYX6DUhAbHXln9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2ndJ/j9oBMgL3+j2wlvYQdoJ+wAX+I+rARzPbWQI7o=;
 b=NcY3Q3GkWa8F4y90nzrIw6m9qktQiY0hGZMFa+fYQ6dI5tLxaWN9SQ0U8o7oodFKfoiE9tDQsLWTNb9+9egNU73maktRmNYQoEvkGgryeNHKNABF5eE2Icp0s9ktxlorIujITilyUJX1dFNRjus494WH51EpeztiaDJkZPpkHe6q6u4UKSQuhUkOj9TjaPoKKF3RUGEXuRAb0LrSBgGW3bXlBFjaC5fmkGRuCVzYiTaQWCLaFIhUCY7lIq66eOeQ52hfuRLc4oizU+YiLUnlZg/AF/xCXX+Lx48M9snPKbSYNISD9+vYf1kc7jUXBP4Q/6iUmwr2nKTeNhK4Lz+qSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2ndJ/j9oBMgL3+j2wlvYQdoJ+wAX+I+rARzPbWQI7o=;
 b=bR0MBVjeskxiny6hDQKt1UKA25RQr4eLqEr6NX7cUj+XeD2sp2WfPWx8FcS7VV0KijGf9c7//fNiiaq2x0RLn7tXV3BfM0BmTKDwHSTGSLQmmdrVcNxY72+GDMgl8n4Mk1/FiUyRTQfV+NXpqSrqhEkK0zvUtDXYEEk3Wsr4afQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Thu, 12 Sep
 2024 19:28:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 19:28:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Neil Brown <neilb@suse.de>,
        Trond
 Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mark
 Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi
	<joseph.qi@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
	<jack@suse.cz>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>,
        Linux FS
 Devel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        "gfs2@lists.linux.dev"
	<gfs2@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Topic: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Index: AQHbBILbIkQ42h8MOEqBVgYVsg2/vbJUL3IAgAASXICAADURgIAAD16AgAAErAA=
Date: Thu, 12 Sep 2024 19:28:49 +0000
Message-ID: <59A494E0-28C3-4D64-92AB-211CCB2EAD12@oracle.com>
References: <cover.1726083391.git.bcodding@redhat.com>
 <244954CF-C177-406C-9CAC-6F62D65C94DE@oracle.com>
 <E2E16098-2A6E-4300-A17A-FA7C2E140B23@redhat.com>
 <D0E3A915-E146-46C9-A64E-1B6CC2C631F4@oracle.com>
 <B51C0776-FF71-4A11-8813-57DD396AF68B@redhat.com>
In-Reply-To: <B51C0776-FF71-4A11-8813-57DD396AF68B@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5810:EE_
x-ms-office365-filtering-correlation-id: f8d3a46e-171c-431a-0ee2-08dcd36120c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDZobVRjeHNDTDRPb2lYdjJQWGFKWXFIMHd2Y3V6bzZCNFhWWGJOb0prTHJ5?=
 =?utf-8?B?aXFxODYydG5tYUgwTzJ5WllyakNwWGJvU01CbGlkQytkU1ZLRUEwRnNObXd4?=
 =?utf-8?B?RitIVEJUdnF2L1FFc2kydGgvR0l6RkRyRjMxTGpjZUJTVlhURXowdmRYNU9l?=
 =?utf-8?B?alBlczhkdkk4V2VxM1JiNjFqQ3d3MnVGTFFyWEFROG1mRzVwN0QvcFB6d2Fp?=
 =?utf-8?B?cVJ6YVZKMnJHVEdSeHpZN0lxMUZMWWF4YUxoT3piMk1kQ1hYaDFzR1JqT25C?=
 =?utf-8?B?bW1yTUNYejU2cGV6cXc1WWtlTEZrckFNVXRTKy96R0tVMVppQmR5Tk9Zak5G?=
 =?utf-8?B?MlFmTHV5ekF1VTFEMjR5NEJzOUYvVFh5ZkxLTXl3L0Qra1d2RHpsTXJ0Z1pk?=
 =?utf-8?B?TElHSGliMFlZUXRPZ3RQMnduSkErWlRkZE1adkpoV1N2WFo0M2EvcnIzUTNQ?=
 =?utf-8?B?R1NpQ2xlQ1R5YkI4dFdDd0s2SlNaSldWTXI4MVFQMCtZcTZaTCsvL2lrWEJJ?=
 =?utf-8?B?K2xwVEt2bmtkd1Y4aWVMOTNBOHNKbmZtVnBHY2VjWi95YS8rQ2dFd2JJYkF1?=
 =?utf-8?B?dmMramwvUDZvOFdVNzJvZkw2TTFvbUwvTHB2T0w0ZmlJNkZGZi94eWY4MFJJ?=
 =?utf-8?B?anpyenFqNmJxRnZoMElaSG02NDNBa0h4UkpDQ3FNRDNQN0h5eHRTUFdvSzVh?=
 =?utf-8?B?bW16Wldyd1FnWHR6YW5ucEJwazZUR2o1WjU1ZVovN05LRkJrQ1UxUDVsRElj?=
 =?utf-8?B?dlJCTlZKV2hhK2xBbE53V3FVamlFbXozSVlhZ1dXOGdwejFLV1ZVMTlsTTVs?=
 =?utf-8?B?NEtmTHFrWjRNNzJ6eW05amE0am5XQlBsMWp5b3gxMUhTYTZqNXdXUlRPQlBE?=
 =?utf-8?B?VDBQRWpoTFFhQ0xsUEZpbE1SaFhVMUFRMDNHeHNUbnpaZG5zaWVjR3ZxSVFh?=
 =?utf-8?B?MWRnRC95SktLT1pYcTA0VktRYTJPeldIc3hmWjh5MnBYblZDeGVEbE1nTnVk?=
 =?utf-8?B?RHMxNzc4N0loVkQ5a1NLQnAyQmhqTU9Vdm1jN3J6YUh1alkycTE0Y2pYQU0v?=
 =?utf-8?B?b1hnQnJTalIrVk5JYjEwTVNLUm1rS3FVMmM0NXdSelc5dmxtRlBXYUlweXNN?=
 =?utf-8?B?VXhlNno0L1NISUhVUVZzSUY5S3lGMkFCVTMyQVZScHhtdFBHOW1zeGxMYkpQ?=
 =?utf-8?B?Y3RQNVVqWlVTNU5OS3ZTUkEyaHhIYWFYUkg1R1NacW1jOFVZYnNHY0I0UG1S?=
 =?utf-8?B?ZmNwcjRGaUV3Vm40MXpsVTRZd3d6NHE4WHRlS09Wc1lXdTZtcXJGQlM1dzU2?=
 =?utf-8?B?WnVtdEdwbmF3UlNVam5SZTZOc0F4YmxmQnJ6NVJCeFZETkU1QWJGWXJzTFJJ?=
 =?utf-8?B?SmhyK2dzaEJGMUp4blpUci9GMzlzMlpiVlJJVFRGQklWbEUzY01jUXN6anZS?=
 =?utf-8?B?MGxWUURoWFpxcWZBakRZc3hoQ21zc1pWRDQ5ODFjMWM4L0tsR0p5QUNsMklH?=
 =?utf-8?B?MTVjaDkwWmZtREJTQkZLTWU0N2RoYU9xQ2Y5UGpUZXNIaWt5S3J2UGNheHI4?=
 =?utf-8?B?czdWcEd1SzA4dXg1eS9IZ2xJZ2JQS3pxdW4rSzZrekJPQ1RKU2xwallwUW9o?=
 =?utf-8?B?SThFYWUzOFp5MWhJUDRVT3RvWWpNUVcrUGpKQ0tpYU5zYk1CYVZVY2s5U1BR?=
 =?utf-8?B?NWFRaWVZWWpoQ1p0TlJhYmlYZ1FUc0MxWDg0VkhZL09yRHVpQ3RkVkVtYlNO?=
 =?utf-8?B?aEorSTdRQTVoR2VZWS9JSnJyKy9iY3VGZEkxNS9ESi9sTnFCSUludGhSYUor?=
 =?utf-8?B?bU4zbzI5ZGRzbncyT3BiNDB1V3NHbnlYZHVoVGNRbnZKWUhqNUpOUjh2eGgx?=
 =?utf-8?B?NTFtSVFFUGdoU3hTKzVHUmovM3l3Z3g1U2duY2JCeU40OHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2xqNjFSS040Smp2NnFGK05EQjZ6QzdZU0lodVRSdklzTkJTdExMTDRHUHJF?=
 =?utf-8?B?VUU5c3pqQ3JUYnhYaE91RXlGdGxZVFVaUVlKSkdaZUtEem5IU1ZWU0hBUndW?=
 =?utf-8?B?YjZSczBCNWRSZHR2b3hVOTQ5MHpLbjRJUmxETEZzZCt6ZTdVbDFtQVhCa1dq?=
 =?utf-8?B?WGNuL3FIZ0RCVEdDKy9oaEpiazNGSGU1Z01qMG5ITUNUQVRUbUpWV2RueEY4?=
 =?utf-8?B?K1ZMaTFrSVdTWHE4Ty8xcW5CTTVzMWc2L0VickZkRmg0ZjZtdHNoZ2dmM2kz?=
 =?utf-8?B?dnNIZkliRFhwQ1R5MEVlT3gzTjIweGlOOGdMcE82WVZBV0VoL3BnRlRpcDBM?=
 =?utf-8?B?a2ltcTVUSll5WUNoekFpUVF5emhDSUpDcHFMNGxtclhzTkxYL1BibW1qY3Yy?=
 =?utf-8?B?ZW5XYUsrQktmNjhzN0o1ZGtISnhGbHQ1Wm9NUEFER1ZmZ0JHbG5zT1NwUmkw?=
 =?utf-8?B?MzFjWXg2NUJtTUwrT2ZVVGI3U0tNTStscUF3SVVuZVVZSDhGVnpETG4vZVky?=
 =?utf-8?B?TVBRT0NuWGFoSXduU2MxME5DRTB5VXdubFZkWGQ4SWJ2cG9yQy82dHN3K3BY?=
 =?utf-8?B?QVdmZmhkeFFwNEU4ekxJb2c2MU5xR0hoUW13OTFoRlJXU2NSdkcvcUk0T3NK?=
 =?utf-8?B?dWEyeEtTOUFNR2xod1N2ZEkwY0IrNEV1M2VaTVRkZ0FyUFZCRjJVSFBxWTc0?=
 =?utf-8?B?alI2dXI1N2hwYVJFdGlnNkpxM3l5YkdiOVZvM0taWTBhMjEybFlBenV6Tyth?=
 =?utf-8?B?Q2Y4ZkJuMEdFbXowVjBIamtnVklDRlNXMmtDa0o3ajM1YWpveHhVUTlBZ0FI?=
 =?utf-8?B?WFdrcjIwOXRTMzdNQUdJak94a3JCalc4V2RiSktFV1lLZExwZWFRTTQrcHNq?=
 =?utf-8?B?WXB3Sk5YUXlsdGY3aGZFbTIvQVJpVFFMQnpCcmNDbFB4RHJIWEQvSEdLaUNi?=
 =?utf-8?B?K1BEbEk2cGppWXFpR3FqRlNDQzJpS1NudksyV3VraU5MbUs3QXdvOVBKM2xz?=
 =?utf-8?B?a2VPUkE0ODd1MlF2MTZhTVFORHF3R25CSDhBSWVnbHVoTEpNbnFSV2Rpd1JB?=
 =?utf-8?B?b2JkUTIwMnpCRWdsaUdOa1BUS1ZicC85eDc1M3pvRVBLQmhHZHpxVDcySG9D?=
 =?utf-8?B?V2loU0NqdWNNOWpxVzBzbHh6OUZZdklOR0I2TVJMSi9GUVJPUEtnbkgzRWo4?=
 =?utf-8?B?d1hnUC9GTk9MVVYrVnVxb0kwbUgrRGVkOGVBUFRsREg1YjcvMS9IdTFSOW56?=
 =?utf-8?B?UnhPS1VTR2ZjN3BpR2pNZjRUR0lrd2ppUXJoaUpTVlFqaG4wenJqdDNwanpa?=
 =?utf-8?B?MW4ycXJHQW1qdUkyMzBXQnQ4RVJMRmpnem95QzFIRHZqdkhJc2E4bkorbCtD?=
 =?utf-8?B?N3l5azBKNktHS2YycFlWcWVEWFVhdEVPbGh5d2g0eTZMb0FNUkR3NVM2dU5T?=
 =?utf-8?B?TzcxcElTTUtIU0NYektnT1FQTlM2SVpoMjZzOWZnTmQ3UHpBUS9nZ1I5VjEv?=
 =?utf-8?B?emdFbWk2cElGQWFwQlppVTJzQjRXYUNKWlFFRXd1SmV2bEFCS2dTclkxMHdk?=
 =?utf-8?B?RHFuUGk5NzhaRjE2SHlTS2szNTQ0Z1QxRXVxMnhIWGU1TkxEVGU4d2haWFBz?=
 =?utf-8?B?azI2WU92SGYvR24vMERDQ0ZucXE1OExUaGpzSVM5Z0QzWDY2M0xjeENNaEdN?=
 =?utf-8?B?dEhKRmRuYUNDNGRVZHdqWGZkWmN1bzZVWUE1VnR0K0JSQUtNeE5XU290R3lp?=
 =?utf-8?B?L3BHSTU0RmN3MEttWEF4TkR3cmFEN2RiUDE2TkpCRXM1NVl3L3ZPN0VINlo4?=
 =?utf-8?B?cVNmSjhtdnBvOGxpZ1VhaFZkSi8rTkhkVFp0Tm1iSEFTS1hxdFdUSzkya296?=
 =?utf-8?B?S1Zxd3AyaXZ2QjdqUFFCd2dEalVRUlFycXNJNkJOeDV0d0FFTnExRzkyOGFp?=
 =?utf-8?B?M09zSGRWNTZEaityUzkzZlRVb3IvMUNCaHVUenF0bUl4NG5RblRxb2wvOG1p?=
 =?utf-8?B?UUdOa25tYmdWSGdVdDdSQkp6S3VOY3F5WDBPbmdaQU5BREFQTUJtN1RvUEY1?=
 =?utf-8?B?RHlrRWV2QkpmY290eVU0WmhlVmdwaXRXV3FDbHI3dTVsMEh3c24zSExzMEdv?=
 =?utf-8?B?ekpRSkQ2djlTUTZsZWt1L2VVclFqNGEyS2g2ajF3TzNmSHVsMXUzQkFDNGxZ?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F135E728460EBC4CB34DD9288CCDE87D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cFZJqytUCwPmoPUCDX2os8zVGAHIluKlJDSx9QNMSfTuJ16xe3ztrvAeO8nu0gG4+Z9Ei+knAZrI/4qIvC09lR7jBiLMBq4l60SbmBOnE3sFctAWFr47UdY5hD3vE89kBdAw1w2ybVmOALad943hKImZ+SoJaP5F3qHG9B8GVJTJynpx/u6JnqE4JpMhQv0gze202IAzktBSsfy+v3s9MHnhixpASGXzTSVuYnU+1eDKdkX/L9OgEsqjoozCxrfnYt75K0VVV+poYn7HgDziUceNwaqStUOAo2aC4rRn0YKW+ql0TlqtJYvAY7gN825c5XHp+jOPaBSfi7PggXousOJXuGLJseHKnAIwKGYg/kB2+j3vSn/v85Dcxmf+Bc1xbG31KXTYgWYgMUQbJ+rg2Tu5seEP5xARwTK3ggtiNMWmY0okC/OqwXDUCHFVnM4oaDjhRSD2qlYG/kffSAzzIalxqKS8PuhgHUYuGqfmlqDfQDczCeYGIal7vT4+Hty0VLKJK0Px7UGL026ujgZstuVxJthSRgDm2oL7HodPiLDrIAqhh8sSCrakArfFbKKEjNYRQWmy+nt8jpznI7u9ywaep7iBtU36J34x3aHtcPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d3a46e-171c-431a-0ee2-08dcd36120c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 19:28:49.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxKYTDxEyycPqc4L5CEp5/E4pzgucIwSYP8/Yt5ua3uShR4y+lEj5mi9mPUIQ/xYHEuUS0eyjZ02TlAFhvM/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120143
X-Proofpoint-ORIG-GUID: Bw7oOOxNZuJzKdgRF7tZAoAyBOaGQTJO
X-Proofpoint-GUID: Bw7oOOxNZuJzKdgRF7tZAoAyBOaGQTJO

DQoNCj4gT24gU2VwIDEyLCAyMDI0LCBhdCAzOjEx4oCvUE0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTIgU2VwIDIwMjQsIGF0IDE0
OjE3LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+IA0KPj4+IE9uIFNlcCAxMiwgMjAyNCwgYXQg
MTE6MDbigK9BTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gT24gMTIgU2VwIDIwMjQsIGF0IDEwOjAxLCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+Pj4gDQo+Pj4+IEZvciB0aGUgTkZTRCBhbmQgZXhwb3J0ZnMgaHVua3M6DQo+Pj4+
IA0KPj4+PiBBY2tlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20gPG1h
aWx0bzpjaHVjay5sZXZlckBvcmFjbGUuY29tPj4NCj4+Pj4gDQo+Pj4+ICJsb2NrZDogaW50cm9k
dWNlIHNhZmUgYXN5bmMgbG9jayBvcCIgaXMgaW4gdjYuMTAuIERvZXMgdGhpcw0KPj4+PiBzZXJp
ZXMgbmVlZCB0byBiZSBiYWNrcG9ydGVkIHRvIHY2LjEwLnkgPyBTaG91bGQgdGhlIHNlcmllcw0K
Pj4+PiBoYXZlICJGaXhlczogMmRkMTBkZThlNmJjICgibG9ja2Q6IGludHJvZHVjZSBzYWZlIGFz
eW5jIGxvY2sNCj4+Pj4gb3AiKSIgPw0KPj4+IA0KPj4+IFRoYW5rcyBDaHVjayEgUHJvYmFibHkg
eWVzLCBpZiB3ZSB3YW50IG5vdGlmaWNhdGlvbnMgZml4ZWQgdXAgdGhlcmUuICBJdA0KPj4+IHNo
b3VsZCBiZSBzdWZmaWNpZW50IHRvIGFkZCB0aGlzIHRvIHRoZSBzaWdub2ZmIGFyZWEgZm9yIGF0
IGxlYXN0IHRoZSBmaXJzdA0KPj4+IHRocmVlIChhbmQgZm91cnRoIGZvciBjbGVhbnVwKToNCj4+
PiANCj4+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNi4xMC54DQo+PiANCj4+IDJk
ZDEwZGU4ZTZiYyBsYW5kZWQgaW4gdjYuNy4NCj4+IA0KPj4gSSBzdXBwb3NlIHRoYXQgc2luY2Ug
djYuMTAueSBpcyBsaWtlbHkgdG8gYmUgY2xvc2VkIGJ5DQo+PiB0aGUgdGltZSB0aGlzIHNlcmll
cyBpcyBhcHBsaWVkIHVwc3RyZWFtLCB0aGlzIHRhZyBtaWdodA0KPj4gYmUgY29uZnVzaW5nLg0K
Pj4gDQo+PiBUaHVzIEZpeGVzOiAyZGQxMGRlOGU2YmMgYW5kIGEgcGxhaW4gQ2M6IHN0YWJsZSBz
aG91bGQNCj4+IHdvcmsgYmVzdC4gVGhlbiB3aGljaGV2ZXIgc3RhYmxlIGtlcm5lbCBpcyBvcGVu
IHdoZW4geW91cg0KPj4gZml4ZXMgYXJlIG1lcmdlZCB1cHN0cmVhbSB3aWxsIGF1dG9tYXRpY2Fs
bHkgZ2V0IGZpeGVkLg0KPiANCj4gU28geW91IHdhbnQgIkZpeGVzOiAyZGQxMGRlOGU2YmMiIG9u
IGFsbCB0aGVzZSBwYXRjaGVzPyAgRml4aW5nIHRoZSBwcm9ibGVtDQo+IHJlcXVpcmVzIGFsbCBv
ZiB0aGUgZmlyc3QgdGhyZWUgcGF0Y2hlcyB0b2dldGhlci4NCg0KSSBkaWRuJ3QgaW5kaWNhdGUg
d2hpY2ggcGF0Y2hlcyB0byBhZGQgdGhlIHRhZ3MgdG8sIHNvcnJ5Lg0KMy80IHNvdW5kcyBsaWtl
IHRoZSByaWdodCBwbGFjZS4NCg0KSWYgNC80IGlzIGEgY2xlYW4tdXAgb25seSwgbm8gbmV3IHRh
Z3MgYXBwbHkgdG8gdGhhdC4NCg0KDQo+IE15IHdvcnJ5IGlzIHRoYXQgYQ0KPiAiRml4ZXMiIG9u
IGVhY2ggaW1wbGllcyBhIGNvbXBsZXRlIGZpeCB3aXRoaW4gdGhhdCBwYXRjaCwgc28gaXRzIHJl
YWxseSBub3QNCj4gYXBwcm9wcmlhdGUuDQoNCkZpeGVzIHNlZW1zIHRvIG1lYW4gZGlmZmVyZW50
IHRoaW5ncyB0byBkaWZmZXJlbnQgcGVvcGxlLiBJdCdzDQpPSyB0byBkcm9wIHRoYXQgdGFnLCBi
dXQgSSBwcmVmZXIgdG8gc2VlIGEgcG9pbnRlciB0byB0aGUgYnJva2VuDQpjb21taXQuIFRoYXQg
aGVscHMgZG93bnN0cmVhbSBjb25zdW1lcnMgb2YgdGhlIGNvbW1pdCBsb2cgdG8NCmlkZW50aWZ5
IHdoaWNoIHBhdGNoZXMgdGhleSBzaG91bGQgYmUgcHVsbGluZyBpbi4NCg0KDQo+IFRoZSBzdGFi
bGUta2VybmVsLXJ1bGVzLnJzdCBkb2N1bWVudGF0aW9uIHNheXMgZm9yIGEgc2VyaWVzLCB0aGUg
Q2M6IHN0YWJsZQ0KPiB0YWcgc2hvdWxkIGJlIHN1ZmZpZW50IHRvIHJlcXVlc3QgZGVwZW5kZW5j
aWVzIHdpdGhpbiB0aGUgc2VyaWVzLCBzbyB0aGF0J3MNCj4gd2h5IEkgc3VnZ2VzdGVkIGl0IGZv
ciB0aGUgdmVyc2lvbiB5b3UgcmVxdWVzdGVkLg0KPiANCj4gV2hhdCBleGFjdGx5IHdvdWxkIHlv
dSBsaWtlIHRvIHNlZT8gIEkgYW0gaGFwcHkgdG8gc2VuZCBhIDJuZCB2ZXJzaW9uLg0KDQpZb3Ug
ZG9uJ3QgbmVlZCB0byBzZW5kIGFnYWluLiBDaHJpc3RpYW4gY2FuIGFkZCB0YWdzIGluIGhpcyBy
ZXBvLg0KDQpNeSBvYmplY3Rpb24gaXMgdG8gdGhlICIjIDYuMTAueCIgY29tbWVudCAtLSB0aGF0
IGRvZXNuJ3QgbWFrZSBzZW5zZQ0KYmVjYXVzZSBmb3Igc3VyZSwgdGhlIHN0YWJsZSB0cmVlIHdp
bGwgaGF2ZSBtb3ZlZCBvbiBieSB0aGUgdGltZSB0aGF0DQp2Ni4xMy1yYyBvcGVucy4NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

