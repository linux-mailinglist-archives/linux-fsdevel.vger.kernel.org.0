Return-Path: <linux-fsdevel+bounces-28884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B596FD0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 23:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5651F247AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0E1D79B7;
	Fri,  6 Sep 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpiWDfET";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FvbJPA2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355401B85F7;
	Fri,  6 Sep 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656958; cv=fail; b=keaAKwbBFSYrhQA5fwkEZ/3DrhEbHLhJ9UqUaY6b8PWHpW6K/lbLgBoxZOW8n441EXqs/UF0NpSeKbSklAVXd5pMQzjUNpiy6jYhz6bkJwzZKjccOcI5T+YAj7vc3tYSFcckxSLv0GMKLK7d6I5byiGPWr1pukIkuMFSXE57tEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656958; c=relaxed/simple;
	bh=fFS+eLcZx9MzoikfN3OzGrFy7kN4tiD0H1mtBPPgg5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OegupQ+N1UiHTyy6PKUOg6YoGvwNqtNUsO1NY099fFLfRoKOU1hFp3mlxwI0DxBOkUiL7gqL95QV8+HEN7t+Xj+CGCjAAJRvLXj5/jLsu08boDFu4im+1JscSOF5tEB+vkIYu/G4GQ5y0OkNE2WsArw+85IlDoKPuDpDeYPWaQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpiWDfET; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FvbJPA2p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486KXVjr011317;
	Fri, 6 Sep 2024 21:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=fFS+eLcZx9MzoikfN3OzGrFy7kN4tiD0H1mtBPPgg
	5Y=; b=kpiWDfETxHs2ffgSGaamMaB1D0PQt78Fv9qfpHzVDMa9EdgXLlFFenJMS
	2HVN6cC+/vdL54lV8oZBiUneDmRvXgbtFrXDk4kbhHrY7do2eW8hm08PY5kOv9zj
	9pmyctkVh2JFuRL2fLVZz4zWQIwFwgM7nvXRNjGbbbpX1c+3V1X9pKNwhYwvkC16
	rLpBHwbHTSYjYD1uD2J3plFvJTgBoMjy6GPo94xLBCQG2xmglc2OjKfGG6KqY6KM
	biEzIApyIgPBp2kIh2tE6IZ69Li8Z8vUw5HYd4L1xYyzuk7ZKlQZvb7dpr7kY+jg
	VbtOkWMapwaLAdoJ5/DG1Suds3T1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwkaj7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 21:09:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486KKIjj016213;
	Fri, 6 Sep 2024 21:09:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyjew79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 21:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+wO3tvdHAXV8cxC+kiOul6+rK5cKa3Aq00GwcIwL9p0XkQm1gre/SRgxdTdkY7VRH4Q1B4Maf8B3l4wm26AY4tYPjLtbmfk+hSzornWFURDnY0ID5XIaZyJQA5ETjE0xZhHIDMoVHb5TBoTCROezIpmDqdwtbEG20rmuBVbVoBSRX9R6vFFHkepd+HthnzaPZLqRUI7bKxsDoL8hQufPHdj1ys3VfKddyZPoQf9oFsm/A0+IeKbu5cks4H1jL94Mizq2Z03FLkfpol3NbqDTPwEGvEl+nAb0vYiaIbEdYb6sj+CQ8IiorZpe3QhjtCjXr60C/SnXKxsW6Yw8eLD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFS+eLcZx9MzoikfN3OzGrFy7kN4tiD0H1mtBPPgg5Y=;
 b=iIR5A8p3IT1t5lHpLdHClI8F9sLTHHasjgRbG2f991s6aXbL+qt/ziHrDM1Bpmd17Slvr9F8FkMn3/0DJjsz+tdCHOKfbXiQo8XMhIO62IyZa/858/6bpwZmmqLhApfn2EyUH94SSvkyQqv70tXfeYFkzS9F1DfchsMcOLFp1Qj907ML8z0Q/1VcTBrs4xw1xicQWxPwLlsR5+KA9NYE/X5pzZJfJggcDVPbr3Y1YSUqruJfkYuUCt7GRqiMMtMAXEfpWXRWdsToFYRqU2SsbIggnL0Ku1qVaoXsEKy0ewO8LsBMq7c3vhY+yIj5S5YVdCptdJ0lonttxone9uVWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFS+eLcZx9MzoikfN3OzGrFy7kN4tiD0H1mtBPPgg5Y=;
 b=FvbJPA2pMfDvjhFw+Ek7tc4rzQHKa+c+n2CAhrkEUncUJcl3ghKvBnQ2+ff6acBJ0wVgsnef1n1nsydxi2vFTww2396cLtn1thc3sCV0kbNu+2lYSwoqZudmxYnSLYYmL3ho39wljXAMFvee+7zx9jpaT9kdrZ5LUMo49sCj6Z0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4779.namprd10.prod.outlook.com (2603:10b6:806:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 21:09:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Fri, 6 Sep 2024
 21:09:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Anna Schumaker <anna.schumaker@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Topic: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Index: AQHa+/Z3Mom0zo7SI0muKVdY2xT3QLJLLt+AgAARfgCAAAm0gA==
Date: Fri, 6 Sep 2024 21:09:05 +0000
Message-ID: <488F97C3-EDB9-4364-89BA-D1EC45ABA456@oracle.com>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
In-Reply-To: <ZttnSndjMaU1oObp@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4779:EE_
x-ms-office365-filtering-correlation-id: b0491f8a-98b9-4206-54de-08dcceb82402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWhDWTNFUkgvWnNPTk5nZG9QNkJham9YeXZmREN6bFJNTHlXbkl0ZVhpQ05j?=
 =?utf-8?B?dXVWR1k4bWRyR0daZ0k0TEJBVFZrazZ6VGhVMEpDMzFCVXVnQ3V1L3VFZDRa?=
 =?utf-8?B?dUNER3UwZzhnTVVKNXp4RTZJZDdhQkt4RTE0SmlTZC9kNVFJaGlmdjZ0ZTVH?=
 =?utf-8?B?NmVHZXNzbjNrbDRJdHovYkZtdkZOcCtlbENGZHRjZ0hYeTQ5a3pFd1lSdVVT?=
 =?utf-8?B?MHBvKzVvQm9pRGNoYXRRaC9wdDZHaXJKQzJ2b3hYRmlRWVFBQW43ZWllSmtj?=
 =?utf-8?B?cm1tL0VjTFNzUnpZRDRoaEpOVjFmZUdtQU1NMWJDY1pWUzFCajlWdU9OUGxJ?=
 =?utf-8?B?eWhmckdVL0VGVHllSVEzNlpRRlROS1BJUG0wWEJZUnFrWkN0M1BQMHBkUHpP?=
 =?utf-8?B?TUlUL2lyWkpIdUl5TEswZ0FuSGlObnpuRCtHWldzYXhjcTRzZjRVbCtZNFJu?=
 =?utf-8?B?d0NYdmhyNFZmenp4VDNldm1DNWh0Ky9sK2JhVWVvS0dCSUFBMnU0WXIxYXBN?=
 =?utf-8?B?T0lOVVJlZHN1eVlLaEx6VGJ2MWJSanJTVGRldmwrYllyOFNJd1hOdFRIUlZG?=
 =?utf-8?B?VE9BdDFpVnZheVYzc1FoTHZjd29mMnNMcHhCd2t6WVNsTVd0ZHY2VERwZkVq?=
 =?utf-8?B?YkVOVTJmaDVXelZ5M2ljZVpZNkZVY1pXeFVjTGpETDRYY3FqbVVoZ0RKakpw?=
 =?utf-8?B?UFhZb0JDRUZoYUpoazlmMlhaek83RWttOVc3RU1wUVg3V3BiVWhxOW9DTm1R?=
 =?utf-8?B?Q3g5R1Zkc1FmaHpnWGRCOTNVT0NmcnJWWlE3UG4xemRlSGg2YlFXNnIydXND?=
 =?utf-8?B?bEpyZ0p3S3VmU2xDMkJpUUowcG5FM0lObHlOL3Y1cmRFWGVEeUFkRW9kVERV?=
 =?utf-8?B?TWg2bzBJZUJIeVdDbDRybHYzRXBkWmwvWW5kaDh4Z1JGZFoxek1SVlVrVHJG?=
 =?utf-8?B?RnR5WFdseVlrK0ZWRmw0Q0tWUnkzQmhwY0dBN2Z4bkcwUVc3RmFmTlkvVUw5?=
 =?utf-8?B?ZEJZZVVmSWFLWi9qUSsyenRCUUtQamRxTVlxUGkvOW5iOFl4cGxSZS91V2Uw?=
 =?utf-8?B?SmFIcU1GZ0VZckh0UWxMZkxTc3cyUGxZU2NHTDFRUlhFUE1lRVRTbzlId1hB?=
 =?utf-8?B?dzZZdlVmQmtxZHZvTnV3SDhQWkhUL1g5Ylozc2h0QUNMRi9DRDJ5aGVsK21V?=
 =?utf-8?B?bHhGMGtaZTJPZ3NLUGhlTmI5TnFFYnN0N1pOOFpXR1owc0hVaTRzUVg5VnZj?=
 =?utf-8?B?SktQREd5Sm5rdHRUaUErSWZoc25sazhZZDlUUlU4UmNvVWh3MXRHR3NLc0xQ?=
 =?utf-8?B?R1FLRHVQQTc2OTlncXBXR1ltSWdPd3lPTGJGdk4rTVROcDc0dnI1aDU3QjNp?=
 =?utf-8?B?djVvRlRoYmpvWlVqeEFsdnpaWU44NmxhOTlyalhRdnlIZ2kzN0xOTENRdFZT?=
 =?utf-8?B?a3N3ckZpekVvbktBcUhLSzlSdHNXN0VWL0FqVHNqZ09uYkFycWduRFQ5LzBU?=
 =?utf-8?B?VlV4eU8ya0FNYWllM1FxWWpWVG1MSlowbkpzcTZ6NjVLUWlKYy9ncmVPSlFU?=
 =?utf-8?B?UmhVWFB1VEx3ZkJPMmpwUmM4eDh0dmY1ZzBqcGR3b2taeU9wWGJFWElVaG5v?=
 =?utf-8?B?SDBwbzhCLzlnRW1kUmVFY1EyTkxLZWY0UVlKby8zQ2VUWnNXMFc4Z2xMdnJN?=
 =?utf-8?B?WFV0N2dtUzAzOTBFNm5GeHpCcDNjaDI4RUNmRTgvdCs4aXVVcjV6Wjh4QmxP?=
 =?utf-8?B?LzhiWFdYcWUxd2pRQk4yWHZzS3FsWUVZVTVJaFc4ejhXa28zMnVyYzlVRVpl?=
 =?utf-8?B?NDRDNG4yS0FSdVYva3dtajY4TWpkRUY5ZEtla0JxVldrQ3NmWUI1Z0FpV1hT?=
 =?utf-8?B?dVMzR2cvVzBVdGgxMkNHUlFpMTNYYWRqZy9rcWliNU9PY2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFB1a01pbkZNY3pYNjR6UjFocWovNHpYK3BCdG9NYjcrak50TFN3R3gxcUdU?=
 =?utf-8?B?bXY0UXErRzhkTUY3ZFo4VVZOZGFxVVlUU0NQRFNYZ3p3S2FnWmM3dDBXNGlV?=
 =?utf-8?B?a3I0M0dCaGFjNXhxSFZZa3BxU2dwbHNBeElEK3QvdTlJeEIrVGhkUjA1ZXFj?=
 =?utf-8?B?SS9TOGdqU2ROWjA3NkV0dTVrTzg3d2k2ay9TT1pFRUdEVkM0dUFiNFBQeUxi?=
 =?utf-8?B?dWhWTllhR0RVQkR6QTZYZ0RPMG1MMjlGNnZmK1VhdnBRWnU2UDFjWm80YkF6?=
 =?utf-8?B?WXNjRWI2TzRFU0JRR1l6bVVYQ1J1cjFZbDJIT3ExOE93eU9Kd3BlTFNLQlFi?=
 =?utf-8?B?KzJFalM1ODJoOERMUlhHYldSSWxsMGYvd3VudTdnOUNDVFNzd0pyTkFTWWhD?=
 =?utf-8?B?U093cUR5ME9FS2VQUlg3SThSSVVueVdaNmVSa3RlV1FFTTJVb2xFY3pWOUtG?=
 =?utf-8?B?cWhsbEIwd1BQRi9aUlRSUzRMeWhKTmlISDUrWWZrb1lNdUZBQW9PaUp5TFRl?=
 =?utf-8?B?bEdxdEF3ckQzdDNSM3gvM3V3MXY5Q3pUd3RWSHhhdTJvTk5zM2QzUy9yNjZZ?=
 =?utf-8?B?SHVQemtVeCtGV0VDYjdkSFhoSlpRbWIvK05zcXdXRnFac05kazVXYm9iVytQ?=
 =?utf-8?B?V1p3Z09LdHJwMjY4aDZQNkxVZ2tsNHpSV1V3L0Jhdm5mc2hucHQvMjVnQnJM?=
 =?utf-8?B?akIxY1NFTTZqOUZISGdMblgzTUlnMjE1dUNMMUJRWVV1VjBkV0JleThvdlZH?=
 =?utf-8?B?anRTUUltODg2cFhsaEtoWmIwS2U4SFJlMmw0elNmS080S0J0OUxmZUc3R2kr?=
 =?utf-8?B?MFpoWlozTGVYOWdBSnh5bzRyRlNFVWVSaDVtL3loZitOdGZsSHdpeTE3ZEFh?=
 =?utf-8?B?YmkvUllOYUNESzRWbGtpbllEQThjbEEwRzVTMDY2ZVJ5eEZaTWwwQXdwckZT?=
 =?utf-8?B?Z0diZFFLeDRjNVZGcWJnbUtuaU9wWFdhRkd4MmZKYUlaTkpSdGowVGdZNnkz?=
 =?utf-8?B?Qkc4WmRjREwvZ0Fla2dpRDkwb1ZmY0NmUDRWam52Y3dndmhXOHpzSFpvYmtT?=
 =?utf-8?B?dEZsR0gyUnRsem1pTmdnMUNHRnZlMzhGeHBKb0tUYlFkRHFYejJrM2I2ZFBR?=
 =?utf-8?B?WW1Jem9DclczcjBXaC94N2lJWlVxSXdyb2RVS1dVNys1aHF4c1ArRXhaeUwv?=
 =?utf-8?B?RnlFcXlJNXJEanpsNExFTkdBTEhMaTcvR3FEZkVNd1FsSFlNOW9QaGdDUm45?=
 =?utf-8?B?TFZxQjBkdVNkNGwzdmNaN2YrNlpyRDJSOElrSlYzRGVHVDBiK241alppbnli?=
 =?utf-8?B?MDJqcXFBeERNeTNlQmM3aUp3RVF4UkNhSFlEVitnWlV2cmt6NG40clhBTmUr?=
 =?utf-8?B?aTI4OHl5VHhEb3Rtc1ExTUdXZG5VL05BakhXRENlRHgxN0tXaUlsM2pQb3dJ?=
 =?utf-8?B?V01rVnhIODRhUXRXeTBWQU5hUExidUVEa0FVcm9ZREpVY0V6MldNV3VlWVpv?=
 =?utf-8?B?VG0ySkIrVURsbmhkOG83OElYU1dFWWlMRnZMMlJzNGphTGhWWXVsMVA2bVcx?=
 =?utf-8?B?N09yVzZ1cXF3ZTY1NjJFVlFXK2NPRTJKM3M2eXFPNUZxRmN4L2dVbjcxdmky?=
 =?utf-8?B?ZVdCMzQwenZSTnZWeTVibnJXL0VhMExuV0p2K3lyWVhHWDdBMksrcEVWSWI5?=
 =?utf-8?B?V0s3U1lWeFhJQlI1Q3YrbFFGUi9FTFVIWUo5ZnRyWGpiUXBCc1U2LysvVzRN?=
 =?utf-8?B?RFhuclQ4Wmd0bUc4Q2RZWTVuTlMyNDN0WXpOaXNYR0REaWk2MWF1ZTNXL0l3?=
 =?utf-8?B?YmZkRnhiM3BoZ3NYUnJteW9TM3p0S1lhSlJTT1FmMTlWcTRKemIvYlV5Vyty?=
 =?utf-8?B?ZSsyTGRMQ2NBaiszaGl4UFZ2MUdmVjhtcCtFVnN4bWd6TDQ4cWI4SzloeHpw?=
 =?utf-8?B?UVVxZmF3MitIY2t6bFFjb1BiK2pXOWNuY2hWeGMwRVhESE9MdkR3SGI5UTBH?=
 =?utf-8?B?bFNQNGZtYlV5cXJiWnNYdzBFaVVFTXVSRm5ucE9qUHlDQm5DUGpCOVpseEVa?=
 =?utf-8?B?Y3ZRUmRmemVNNSt3bldnQjdyMG41TWQ1aElRVi9lc2VjSkhmYmQyanV3M2hV?=
 =?utf-8?B?RnY3T3lNRWhGU1hXV3BETEwzbUVJdk9sN2k4SUNWdFNqdEgwY3VnaEJXREFO?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC852A943AD64A4B8F44319811967973@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UCfZopw9f5eik69XmE2YkudoR7Ld0Fg+9yiGk1HDUcRr72QhRN7vKDLlalliGB7OTNm3wu1eJ0It1WooqEcn8T9Zb7rPqMRD8VkwHemhfB1CNBPcQ7/UZxZ+dnTP3cP+3+6ObsfH7Jq/j/4dDBjtjGNNlgecyW9R4O7hNFlh9XtPL/JiGEFHu0Rg01j825HFv5w/a4piRx63gaGUBfE36IEcdd8qj3x5eGGXx7YMglnnWLYhoPGvoU+QxNV/vMMq2jk0mGXRGZzyBeL1B0aG49CZKe67JxXPcyPPSLQ5GP8cg8dC6dyCcDBWRL61ghWDv+e17nwtDqilW7cwUmyVMGBu8e2pVlfQwBSLmeBBvVYjf/R0G/BXKM+Jh8nRdGnmUIYWgBABzTp/93frxaV6faEeLCepzDF7aqHyWEbfJCPm/z7h/4JEjg05/gGj3Og4QnG5FDdUASr6/ygE2qk6OP597OWhN0HHoP9ZvTC26346TNQmdlOtYijlIDy/b2VDwlg+7v8XtoaGhNAA81qHQuzJjD1Lfil0mO3taG/HDQNYvlw0caFofEaAlfcVqsLPLUNCUfsTtUYdljcudXnrOc0ueUqefITUxWtKCX2Yk2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0491f8a-98b9-4206-54de-08dcceb82402
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 21:09:05.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFwPRY7LgoAUQOiuadaWWMCob/9RcA36znPwr8oN+UPuYXd+Xzx0MvC6FxdR1R5At4oK8MkHF6uWLFWGE8B2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_06,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060157
X-Proofpoint-GUID: rlhQ1WsrnVdxKeNC6lcfeJHwqEiAVmiA
X-Proofpoint-ORIG-GUID: rlhQ1WsrnVdxKeNC6lcfeJHwqEiAVmiA

DQo+IE9uIFNlcCA2LCAyMDI0LCBhdCA0OjM04oCvUE0sIE1pa2UgU25pdHplciA8c25pdHplckBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IEFuZCBJIGtub3cgQ2h1Y2sgaGFzIGJlZW4gdGVzdGlu
ZyB4ZnN0ZXN0cyBhbmQgbW9yZSB3aXRoIHRoZSBwYXRjaGVzDQo+IGFwcGxpZWQgYnV0IExPQ0FM
SU8gZGlzYWJsZWQgaW4gaGlzIGtlcm5lbCBjb25maWcuDQoNCk5vLCBhY3R1YWxseSwgSSdtIHRl
c3RpbmcgeW91ciB0cmVlLCB3aXRoIExPQ0FMSU8gZW5hYmxlZCwNCmJ1dCBJJ20gc3RpbGwgcnVu
bmluZyB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgb24gc2VwYXJhdGUgaG9zdHMuDQpTbyBMT0NBTElP
IGlzIGluIHRoZSBzdGFjaywgYnV0IEknbSB0ZXN0aW5nIHRoZSBjdXJyZW50IG5vbi0NCkxPQ0FM
SU8gY29kZSBwYXRocyBmb3IgcmVncmVzc2lvbi4NCg0KU2NvdHQgY2FtZSB1cCB3aXRoIGEgbWVj
aGFuaXNtIChwb3N0ZWQganVzdCB0aGlzIHdlZWsgb24NCmtkZXZvcHNAKSBmb3IgcnVubmluZyBm
c3Rlc3RzIHVuZGVyIGtkZXZvcHMgd2l0aCB0aGUgTkZTDQpjbGllbnQgYW5kIHNlcnZlciBvbiBv
bmUgaG9zdCwgc28gd2Ugbm93IGhhdmUgYSBwYXRod2F5IHRvDQpleGVyY2lzZSBMT0NBTElPIGlu
IHVwc3RyZWFtIE5GU0QgQ0kuIENvbWluZyBzb29uLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

