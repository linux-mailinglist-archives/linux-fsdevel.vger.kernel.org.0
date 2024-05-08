Return-Path: <linux-fsdevel+bounces-19122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA188C03CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A741F21709
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074F12B171;
	Wed,  8 May 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cfjfF4qb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nJUPM+KQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AC20309;
	Wed,  8 May 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190911; cv=fail; b=T4Xgm8IoqdbGbJOBKUQJ8DvCsThtNFWBdUbTlXktMLEtNEABGJGsf5EksqPFIqgfhRlm+Ate1atxjoPpKcXzADRsfVR/sZ3zlJr3JuXcJDIQCjIhs2RwiRcHrBTjxSHiF4h7FpYj33nbPrnH6Dk0c+Ttj1dt91nIjjE5jS+RLu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190911; c=relaxed/simple;
	bh=hrqYPBlWrGkfAJ4i7qCQP5snADLYzVYyyNT4Qv5ozro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXUL3XYg/wyNCcf4cnxykH1wSFc8ikF7o+usXtQorkF9GhYHP1RKzwKMdrfkN7/kDlcnrQo+8ZLrht1mwTiRGN2ELR45TEgzyTk1dnopTXUEbViMHuvD0yS7p9po0XI02kDbkid/MHGav3MisFGlbikrxKj9ieMt3XN32bcKBC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cfjfF4qb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nJUPM+KQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPQPf022350;
	Wed, 8 May 2024 17:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hrqYPBlWrGkfAJ4i7qCQP5snADLYzVYyyNT4Qv5ozro=;
 b=cfjfF4qbP9IRtStfwnCQvnNFzKZFESRJ1+yKkUhlU+Hqoeeumf59RmdnbPAu5HVabgyd
 eMPiYusZUYu0z0BiHwUgGAu1+r2v3NFO7DagxeeKA6Bnc7rMmF2/60/bVxjSd02E5bdk
 DTPNT0EfQqnk7eUbovUxvXEt+9Fh/WtcKIVhzTt0UzxdkQcUH4vkJ1Tq/qNANWwFRl5v
 y1V5Fj8YAFQxU2lI45CsXs88LyKld/+iHao3xbAcYNbz5lOUqnSBY6pwGMyaNOkNeomL
 vUAAMZfB+pu3/R6Dw9wDIEqC2nv/il4IP3xwM3xl3p8J/PEJOnB6BEjIwklLMGfb34fe VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfvje2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:54:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448HAjXL035538;
	Wed, 8 May 2024 17:54:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpnrsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 17:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtYvVG6QsCOhuNl/GyyhcVRP/TwOzopFrn9Ek5uXbMwGvSRUfJCoPaykD24asMDDdqKK3PdcgnGFsLH77fd29Xer5sGfGJU55BExPKI7GI/mHpHSf05pnY9/cBMP5VXX2EZL16DZlS8WKdgh7oxy+UHKYFjUi0pgoMWE1HfKLsTdFIEbRMFXQzlVWs7d9akIOBqc2XF8pm1AvYNLamv2KB44w3tq067Zs9nahjsx3MmxQrppdf5fvVOJCpA3pmmougIa7tDkQ4KYcQEUU+kQQLoD6pPAoCIg8nrh9bJqsoVsONSvm4yywLWCAJQr+0VeIvzPvf5gp5XgzbtvYtMDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrqYPBlWrGkfAJ4i7qCQP5snADLYzVYyyNT4Qv5ozro=;
 b=JJgYaRPwyvkwqjdF3Mf8LiFTOhaM5OTK3cn7qGfhTsgmSBoVdp+7Oc5FoPNQmq1L1zjcGHId4jrzAnWchiwlB90KfAN+1ebdUoqF0bINHic2XGAimsynU8jNbPwj7tMsiUdznEyC2NzSL5s4lHvyCXr/ilSFz+DL/Y2D95sR8jVI+kX9p/EhsvOir1kH37ZYOshJD/HwH9fYR8k6g2GikkSedHtZmEUfMx3wGHlVa0KN/YPJRm0+Rvfj+dS6LKna5XtVDTV8Auh3XohvdNbiqeSTVKRCTctYkuJVOil3JPlxXPeh7ucdE4ZzDiVp6Y3hHBbmgokcrrsNDaNd99Ndxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrqYPBlWrGkfAJ4i7qCQP5snADLYzVYyyNT4Qv5ozro=;
 b=nJUPM+KQW6Op+WaOHDA4TpD4fQ6ark7Vo26Cyg374gfWON0u/8GDdju+iCjWN6KNWKfyKMlUMdcDaU+Hm2gHL9TL2GWHYC7//AR8QD2ocGqAOXi4UfbyGnG9loYM/WTui/68G1sEDATGTDQturYm1w+EMnHqDXjN+q2noK7v138=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:54:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 17:54:50 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Steve French <smfrench@gmail.com>
CC: Amir Goldstein <amir73il@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jan Kara
	<jack@suse.cz>
Subject: Re: kdevops BoF at LSFMM
Thread-Topic: kdevops BoF at LSFMM
Thread-Index: AQHaoK6kn/4s7u6OMUeGcEgiWsFjN7GM9gyAgACnmoCAAAKVAA==
Date: Wed, 8 May 2024 17:54:50 +0000
Message-ID: <E2589F86-7582-488C-9DBB-8022D481AFB3@oracle.com>
References: 
 <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
 <CAH2r5mt=CRQXdVHiXMCEwtyEXt-r-oENdESwF5k+vEww-JkWCg@mail.gmail.com>
In-Reply-To: 
 <CAH2r5mt=CRQXdVHiXMCEwtyEXt-r-oENdESwF5k+vEww-JkWCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7321:EE_
x-ms-office365-filtering-correlation-id: b1393bdc-a373-4ca8-c0e4-08dc6f87f539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cFo5ZFpaWWNsU0hJSURzRzUvQVVUcU1PZU5mQ01DaVlkZks0M09tRzREcERq?=
 =?utf-8?B?UGM5ZU5EZGp6cUtHUVUzL25ldE9NWDNUSk40bnRCbmFXTmFTYUc0bTRoQTJs?=
 =?utf-8?B?cVFkTnN4T2p0dzBlSmsveUJmcEpWSFBEZUFVVFZJOVJzMXYzNnNRVkVVLy9P?=
 =?utf-8?B?RFZIOGlwd2xkUFNDNGF6cERkTFltVThzdkVzUUNZVFJVZGFZQU4yRHk2cTVw?=
 =?utf-8?B?ZU5BTlJEQlhyZVlxVXZidHRSVVJ1OWhJNy9BVG5IdG42a3R3bFRraFFHbVJQ?=
 =?utf-8?B?TG5IYU9xbHpNWk45ai96Ym5TZWVTUTZIVjIvVVR1SFhadjZHQk9iT1FuZktw?=
 =?utf-8?B?ZFMwTmVVUC9tOWU5dnBxamJXRElaYkd4QVZrbzQvbDNaMkRCeG9zdXdKYU1W?=
 =?utf-8?B?R3k5NWhHOXJNVVAyc1NhOWNWNTBmMS9tWGJTeElGWVNnOExtSjM3Si9RUDUz?=
 =?utf-8?B?TlkydTBMMlBiZ1liSU5Keit0QUFwYUVCYkowQmsydC8ycVpCTmQ4SkQ0OFor?=
 =?utf-8?B?MkY4ZWdiV0xTY2dQbVZCaVJHTUo1ZVBwVEg1S1pCaTlwRVFxSGtTbFhpZUNl?=
 =?utf-8?B?ZXFzSWR6QUJJN0JMZll4ZHNUZlh2MkZUU1VZZWdWcVZ1dnZUWnNzUTJyZTV0?=
 =?utf-8?B?dUk0OEwvRHJNYnppZzRaR3hWQ3BOQ2RXSTB5d3J3SDJ5NFJKdmZtODhjNGJ3?=
 =?utf-8?B?WGRUUlZEL3Rmc3dpaUdFalNUa2YwS3BQcEFMVmJtQjFsVmJJb0VsRWhUaUEx?=
 =?utf-8?B?N0N2dDJsb3dmbTE1a05YVkFGMDZlUzd3OW42Mkg4dVZ0UjJqNHE4RllxRHBE?=
 =?utf-8?B?ZE5KKzNNU3hYajR4TklNOTN6NzdiM05iNUJldi94azZVNVFaWmg4RkUycGlQ?=
 =?utf-8?B?Mnl0Z01qQ0tNUS94cWx0cC9oNUR5c0RrMnVaYzZhYnppVVZXcjkwSFVIdm5Y?=
 =?utf-8?B?T3BUQVR5dmhWb0RKMUtFWjkwNnlMY1lzZUoyWmkzdzVpeUZiRXBxWjZ0eWh1?=
 =?utf-8?B?d01MejlhYzlwLzIvQ0UyMDJuYzdSNTczZDluUURIaUM5dVpkVTNiRTlMTjNP?=
 =?utf-8?B?TlBqQjYvVXdQSERiOEh6ek8wditaejhDa1lpcW5rTU5zdUk0dG9RaUVZMFlw?=
 =?utf-8?B?TlRHUzZhNkhxQmpuYUNReS9SUS9KQmVsZDRyNDNIdEZhd1RzYzEzbTlJbUJ3?=
 =?utf-8?B?VWRnQkxFdFBBVGlWVnNaMHhLdTRSbVBXT1JabTVKUkRXWVZQR3RZUU1Heksr?=
 =?utf-8?B?V0w5OFB1VkVUdWtRUERNVHpwb2J3RXRGcTRjMEpUK1M4L3Z5ZDhVbktSdDFz?=
 =?utf-8?B?WDN0WTR0ajRwRG40SG5LQUVLbUsyNHpWYSt4NFc2MHJpMWhUN0F4bUF4blN4?=
 =?utf-8?B?VVFwYmRMdjcxaHZDSjEvcnJXemxCYng5UkJ2SnNYQkxuc0lLVHVhSmJkTDlz?=
 =?utf-8?B?QmtwM2lWSk1Zc0FzZ1VtcmhUb2E0bVlQTlVobmwvZXhwVnIwYTltV2d4UUFB?=
 =?utf-8?B?U25TZjl2YUJ4dzN3UTFMdjBnQ1hMTEM1TzF4ckovTnQ1NVRjbDdsN3N5azYw?=
 =?utf-8?B?SUY4WjlkRGJLWVVXK3NMbEptR3ZPeGdUZHpoRHB2RDkwc3NQck05UnhyTjBF?=
 =?utf-8?B?dWVoWTdnL3ZnRjNWS3ZHUVJJVHl6MTdDSnNUcmI2cVFVQ3E4VWJsVDAweHA0?=
 =?utf-8?B?M05XZHBkeFFRQVNkTlZvRlhQZk96Wk4rTGR4akMxZ0NGYythcWp4c3p1WjRm?=
 =?utf-8?B?SExZcWxwRUZHR1g2WTlDR1BJQzU4TG1sOS8zcnBlNFJuN1Nqbm5vVVdzN01K?=
 =?utf-8?B?b0FDZjl1VG9WMDQ5WUxUZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TWxxeGM1RGNNN3VTTlBTbjBFbzA1dWhWM1RLVlBZRDNlK0F2Q1V4SjdwQ2Nv?=
 =?utf-8?B?MFFsVGdLYktBeDBNSE9NWmlIaHpJaWpyeWJpdnZaT2pmTndxUjl5Zk9sVUZl?=
 =?utf-8?B?bVlOTnhORzlVbC9YcURGaEswLzVNWEFJc3IrVzlqS1poM1VLVmRiY3BUN0tD?=
 =?utf-8?B?WUFqUllaU3dxbWZtYXNzQkVSeXZTL1YvQkZYTVo1cVlDSGFha29oK3UvUGFF?=
 =?utf-8?B?K0kwY0pjVHZaL3ltOVJ4TlhzekxxSXBvVzJEcytVOHVxejBCS3h5VjZuTU00?=
 =?utf-8?B?TG5UaHE1ZVdGUzVHdldYVnRsVTd5dGlNNjE4NmZ5WGlqSXNHSXRkQmlST0tu?=
 =?utf-8?B?bmFTNi92blV4UHNHZWZqSzhUcFMxSmxWQzhRTXNmQ3J1Z3UwSWpUZ3ErQkV2?=
 =?utf-8?B?eHk4LzBSMm1UeFZUYkxkenZjNE5PdGJ4NHgyQXVrRnlZRzdNQ1pvbjJSL1FG?=
 =?utf-8?B?OS9OMUppZ2d6c044bTZnaE1vZ1pteUpycE5vSXhjNUdEV3NST28wSGRZUHp1?=
 =?utf-8?B?eis2UlFxR25tZlZlb1dHVGhud090RjN6KzRIZzFQcGsrMGpZSTdaQmZBTnFi?=
 =?utf-8?B?QnNLR0JLWWlFM0hJR3JVTHorL1EzUUJTNVhyU05UckZ4bm1oUUFaOW1NZ2Yz?=
 =?utf-8?B?b2xKWCtEcTJHVnd1dFJnYmxLMklGM0Z6ZzZKQTdKVzFUZ2MxWENlT1ZmNE01?=
 =?utf-8?B?MXRDaW5iSlgreVBSMnJCbXZXaFkxRVN5T24vVjUvUTg2c3dzaXUwV09kbUhp?=
 =?utf-8?B?K3lyb1FwRW05S3BEYW5ZZHhxMGxMRC8yY1QxcnV0QTlHM3FWejFqSXVyUG01?=
 =?utf-8?B?d0JqMlozZEZzemZEc0Y5dllZTjkwckpXUysyTXNHNVdRQ2d1cWNVN1J2eXdm?=
 =?utf-8?B?ZWRHZ1RLK2oxZmJOUXpVcGZqOU1jNWFSdU5iZWhXNlRlYkF5ZEtKZlNSMHpL?=
 =?utf-8?B?Yk1JN2FBV2I4ZkNEWndPdW5oWGdaS2E4THFiVXo1SGNWVjhJR3NLOFkvOThj?=
 =?utf-8?B?Z3dVLzBsVXozQ05wWXE0WC9RZE51NWt4OE9mVitJcWRzN2ZVUGpJZWJtSktP?=
 =?utf-8?B?U0NyMzgveEswTEFURTNpY1N2WW9tMUY0YXFmSmx6SlFrRmQwWUp2Tkl2QzJj?=
 =?utf-8?B?VjU5Rk5FenlqQzl2bWRzdUtmZ2YzRHFIcE44MFNNWS85UEsxbGVwbi9QWG1W?=
 =?utf-8?B?YVVHWmRkais0YjJFbzl1MjRkVlpydTBmazBVdStqN1FKN0tFOGJyaGtYZ1hh?=
 =?utf-8?B?VjEzeVB6YmNKVCsvMjJ6RnpsaFYwRkZ6OFIyZ3lYMDVIUjBxb25zZkFFZHZ6?=
 =?utf-8?B?U3ZnYVl5UDdDeVZraWh6SmpRTUU1WnB3RVhOa3JrTGtDNzUwVlM5NVYrK0ZH?=
 =?utf-8?B?UTlVTTlMcTBxUnRQcVM4L0liL1NTVmNzREVLNXlBbTl3ZWlrZTMzTEswN0Zn?=
 =?utf-8?B?RU1CVTBFaHNSNTNWam1IWGh3Q1dJT2trb3NkUURGZk9UWTVZNkppQVY2cllW?=
 =?utf-8?B?RW5teWVlUXFrNCtSQjJLSVUrM2VBNWM1emFjKy9MK0puSkZKMURGWlRsSkZS?=
 =?utf-8?B?KzltQm9Sek9XN3k2Nlp3b2hqYWZ1R3RPazNuVy91dnVOd21GZ3pGSXpZQkU5?=
 =?utf-8?B?RWVaenBiMUk3dGpnRVlVbHBTZk1mc0MyRUlHbWpyb0w4YTBDQ3lwaFpFVjZp?=
 =?utf-8?B?RG9EU1h1TWpQZG9hUmFJNENkeVNiM3NtdVduWUNVR0dFcThrVkxlRXF3QkVN?=
 =?utf-8?B?bVppTVZzYWpMZDNHUWZyZVhRNm5OeE5INWtsMjBMK2t5T2NWUlA5KzFjU2NI?=
 =?utf-8?B?ektnZDJUZ1RYckVWQW1FUzVVTHl2aEpWejR2VjJ6RHBCVEgyanl5enMxWkZw?=
 =?utf-8?B?L2loSzFzcWIremdEc1ZHUVhTQWFXNUQ0N21mUzVUV2RiZVRTRHpob2NxOW1T?=
 =?utf-8?B?N0NIdXh2bUZ2VmIrSkNoblZDakVhV2hvSmdDcGVqanBZbHBsRXR0eTgrUlIr?=
 =?utf-8?B?NzB2am5YQXBpSWxQSjFRWnZFL1JWQXBoSVE2RG44TmhsK0pEMkpodXB6US9y?=
 =?utf-8?B?Y2VwNkFDVUpuckU3cGw3VE1ZMkFZc2FJVVVFQXBmOGFsWUtWZG1GVTZiZFQ3?=
 =?utf-8?B?amtYbTNoNXFSUE5CTnh2YktvNGhtQmp2Z3JZSmJYNDAvZUxUaGFiM0VuM2hK?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B6AA3264DB2EA41A7A3864A7ECA4B0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yk01nQFVEIWtn3EHnk/Aab//al663wqKZciW1qqJ5ASmLnJ1WzWiLZ1G+D5goXSuVw+sI8uU9hDPQ0oRexjf4iTha1O2fm1vl/I5qkNQkhqB1SDKyyywPoPshsSGFMI01AERRhpTPBLa5rkn7xkU7QFDC03l21L3HKm88ov3azGUrtlNeawf+J3oo1Wzsz7kmYLLbDxHH2QsFFn9oqQ0AYy8L40peJx3H1UIZfqEeUGa5R/dDnmMSz1rx4W0OnJmK2aRJGGxW14D3YKVxXzJIyszI9oc7SsFdTc0gZhVIRmQsegfCcLA+9HHKLqhlXU0VyUg+QoQfwUqfWRPt9vOWnNwnQgOFG27DHwCvnY+MkLwAQ9tHzoVDZbLmxN7GQaDkibhytlWsh4Xdt6Rwoi348lc4JZVKOELNoY5XCfJbrhDBbVRiuFvHwZYXMBETlgAyTwYYrFCqS6ghkhTMJnaVZdH60GtiZy6oV0iImUA0OsR7kT2Wf6uNyzpyNAdgMWVrPx8mgz8M3z7QipBWw28r3HPdd5ryKbRPeFxrKHv4i7YZd2b1cCg3EywD7qC0TqsVmucY4KmJKvyrzUvUQDgvU9z3L7J/9txojdORt7LlBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1393bdc-a373-4ca8-c0e4-08dc6f87f539
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 17:54:50.5134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LGPOZm/aKxwN0Ee8oFEOuZYpVS4yV4aYS5a7hfKTMJv7bNLINCuTZYAz8pUBFbIaiDPdN0DMZFy8yws/OIt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080131
X-Proofpoint-GUID: Qj8nfOERU_QehuA7_W4v2IntwlUzOwAY
X-Proofpoint-ORIG-GUID: Qj8nfOERU_QehuA7_W4v2IntwlUzOwAY

DQoNCj4gT24gTWF5IDgsIDIwMjQsIGF0IDE6NDXigK9QTSwgU3RldmUgRnJlbmNoIDxzbWZyZW5j
aEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSSB3b3VsZCBiZSB2ZXJ5IGhhcHB5IGlmIHRoZXJl
IHdlcmUgYW4gZWFzeSB3YXkgdG8gZG8gdGhyZWUgdGhpbmdzDQo+IGZhc3Rlci9lYXNpZXI6DQo+
IDEpIG1ha2UgaXQgZWFzaWVyIHRvIHJ1biBhIHJlYXNvbmFibHkgbGFyZ2Ugc2V0IG9mIGZzIHRl
c3RzIGF1dG9tYXRpY2FsbHkNCj4gb24gY2hlY2tpbiBvZiBhIGNvbW1pdCBvciBzZXQgb2YgY29t
bWl0cyAoZS5nLiB0byBhbiBleHRlcm5hbGx5IHZpc2libGUNCj4gZ2l0aHViIGJyYW5jaCkgYmVm
b3JlIGl0IGdvZXMgaW4gbGludXgtbmV4dCwgYW5kIGEgbGFyZ2VyIHNldA0KPiBvZiB0ZXN0IGF1
dG9tYXRpb24gdGhhdCBpcyBhdXRvbWF0aWNhbGx5IHJ1biBvbiBQL1JzIChJIGtpY2sgdGhlc2Ug
dGVzdHMNCj4gb2ZmIHNlbWktbWFudWFsbHkgZm9yIGNpZnMua28gYW5kIGtzbWJkLmtvIHRvZGF5
KQ0KPiAyKSBtYWtlIGl0IGVhc2llciBhcyBhIG1haW50YWluZXIgdG8gZ2V0IHJlcG9ydHMgb2Yg
YXV0b21hdGVkIHRlc3Rpbmcgb2YNCj4gc3RhYmxlLXJjIChvciBhdXRvbWF0ZSBydW5uaW5nIG9m
IHRlc3RzIGFnYWluc3Qgc3RhYmxlLXJjIGJ5IGZpbGVzeXN0ZW0gdHlwZQ0KPiBhbmQgc2VuZCBm
YWlsdXJlcyB0byB0aGUgc3BlY2lmaWMgZnMncyBtYWlsaW5nIGxpc3QpLiAgTWFrZSB0aGUgdGVz
dHMgcnVuDQo+IGZvciBhIHBhcnRpY3VsYXIgZnMgbW9yZSB2aXNpYmxlLCBzbyBtYWludGFpbmVy
cy9jb250cmlidXRvcnMgY2FuIG5vdGUNCj4gd2hlcmUgaW1wb3J0YW50IHRlc3RzIGFyZSBsZWZ0
IG91dCBhZ2FpbnN0IGEgcGFydGljdWxhciBmcw0KDQpJbiBteSBleHBlcmllbmNlLCB0aGVzZSBy
ZXF1aXJlIHRoZSBhZGRpdGlvbiBvZiBhIENJDQphcHBhcmF0dXMgbGlrZSBCdWlsZEJvdCBvciBK
ZW5raW5zIC0tIHRoZXkgYXJlIG5vdA0KZGlyZWN0bHkgcGFydCBvZiBrZGV2b3BzJyBtaXNzaW9u
LiBTY290dCBNYXloZXcgYW5kDQpJIGhhdmUgYmVlbiBwbGF5aW5nIHdpdGggQnVpbGRCb3QsIGFu
ZCB0aGVyZSBhcmUgc29tZQ0KYXJlYXMgd2hlcmUgaW50ZWdyYXRpb24gYmV0d2VlbiBrZGV2b3Bz
IGFuZCBCdWlsZEJvdA0KY291bGQgYmUgaW1wcm92ZWQgKGFuZCBjb3VsZCBiZSBkaXNjdXNzZWQg
bmV4dCB3ZWVrKS4NCg0KDQo+IDMpIG1ha2UgaXQgZWFzaWVyIHRvIGF1dG8tYmlzZWN0IHdoYXQg
Y29tbWl0IHJlZ3Jlc3NlZCB3aGVuIGEgZmFpbGluZyB0ZXN0DQo+IGlzIHNwb3R0ZWQNCg0KSmVm
ZiBMYXl0b24gaGFzIG1lbnRpb25lZCB0aGlzIGFzIHdlbGwuIEkgZG9uJ3QgdGhpbmsNCml0IHdv
dWxkIGJlIGltcG9zc2libGUgdG8gZ2V0IGtkZXZvcHMgdG8gb3JjaGVzdHJhdGUNCmEgYmlzZWN0
LCBhcyBsb25nIGFzIGl0IGhhcyBhbiBhdXRvbWF0aWMgd2F5IHRvIGRlY2lkZQ0Kd2hlbiB0byB1
c2UgImdpdCBiaXNlY3Qge2dvb2R8YmFkfSINCg0KDQo+IDYpIGFuIGVhc3kgd2F5IHRvIHRlbGwg
aWYgYSBrZGV2b3BzIHJ1biBpcyAic3VzcGljaW91c2x5IHNsb3ciIChpZSBpZiBhIHRlc3QNCj4g
b3Igc2V0IG9mIHRlc3RzIGlzIG1vcmUgdGhhbiAyMCUgc2xvd2VyIHRoYW4gdGhlIGJhc2VsaW5l
IHRlc3QgcnVuLCBpdA0KPiBjb3VsZCBpbmRpY2F0ZSBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24g
dGhhdCBuZWVkcyB0byBiZSBiaXNlY3RlZA0KPiBhbmQgaWRlbnRpZmllZCkNCg0KV2VsbCBzb21l
dGltZXMgdGhpbmdzIGFyZSBqdXN0IHNsb3cgYmVjYXVzZSB5b3UndmUgYnVpbHQNCmEgdGVzdCBr
ZXJuZWwgd2l0aCBLQVNBTiBhbmQgbG9ja2RlcCwgb3IgYmVjYXVzZSB0aGVyZSBhcmUNCm90aGVy
IGpvYnMgcnVubmluZyBvbiB5b3VyIHRlc3Qgc3lzdGVtLiBBbHNvLCBkdWUgdG8gYWxsDQp0aGUg
dmlydHVhbGl6YXRpb24gaW52b2x2ZWQsIGl0IG1pZ2h0IGJlIGRpZmZpY3VsdCB0byBnZXQNCmNv
bnNpc3RlbnQgcGVyZm9ybWFuY2UgbWVhc3VyZW1lbnRzLg0KDQpUaGlzIG9uZSBzZWVtcyBsaWtl
IGl0IHdvdWxkIGJlIGhhcmQgdG8gZW5naW5lZXIsIGJ1dCBtYXliZQ0KdGhlcmUncyBzb21ldGhp
bmcgdGhhdCBjb3VsZCBiZSBkb25lPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

