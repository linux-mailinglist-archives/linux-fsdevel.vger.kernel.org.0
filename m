Return-Path: <linux-fsdevel+bounces-44357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32910A67DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C23B67D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AA1F4CB4;
	Tue, 18 Mar 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KkyxmPNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36581B6D18;
	Tue, 18 Mar 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328162; cv=fail; b=K4xz6/RZDSNnxu2MSt/b1HvFj+BRisqeakPw1M1DeCd9qEYpJTOSTVE7aVZuVTqoeRkfXp6SaNolJ+0sNnzkC+c4qyf7qZt8zdMa9U0Q4iL9+pCG+solbCd2xtcv0zpnY2oCBw0s5e3i57uWLY43+GcinMTAd+UggEfvjr/tWsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328162; c=relaxed/simple;
	bh=YnpqUdoPtdeFws8SsFXAmOLdPi7NMj6KZvpCim2IKog=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=TJhGY7Njq49+dCimXsCDfbPecMpDDUXeeny4dcFQviC6u31WrSuZVYaRu4stW2IQ7vNr66hHmlNfZ1+LmpS4MH9TiKPpQKrTEbIOljlDguIf2Q1ouikj2MDIRlWu8aE+E1e/Eq1/P0/5BVFy+Z3wimLT8HkCm1gxMjBl0HTCEiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KkyxmPNx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IE3EXX027926;
	Tue, 18 Mar 2025 20:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YnpqUdoPtdeFws8SsFXAmOLdPi7NMj6KZvpCim2IKog=; b=KkyxmPNx
	hDArfJwO7GTxLyC4J4gYAoK8rmZhAmgjdw+0CoRD0tDEiucB/pAKjPEfOt3OJZdP
	E6TUlZ3nhD5DLwF4/aK03uI1N5BldC6YwB7nN1JjH0rWu4WqT5hD2LUi36mibyT9
	zSBjaowW+RPI6GjB2zgRwIeIpawP9nJjBy2rLY3R4l8n2Kd6JiVsjWGTPUrAJkws
	XZ2kV2YKWPrpRk0cROLyw9s+y5ZPe6IU/dBXLeh2O2w+tUvex8D40SaiuHebDsMo
	g4W6zsyZu6SHpU9xgv0pPYiO76bHRtB/gfdDsyStodjp173/0fnO6bf21t/DTcD/
	NCVggc+7unVpng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8p9vfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:02:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IJwAij031173;
	Tue, 18 Mar 2025 20:02:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8p9vfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:02:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIsm6kmR/KnSmLRQfaaQRd3fu0OUg4f1fwQ/xX7BWnesgth6AkIBx1pNez4M4DjclDg/UmM0Hp6pZEAKpURbTBBtLGM4Cq+V8ku+5zK0v9CHFvM193ozo+Pww0UZGB5OnomQhe30GwvJlsN7TK9oCuCyLmcscGSuQD1+iK+AJIet6JTcY0CpLEposdvsucQIdkMQe1azUuX3pVh3Ap+JUv2+/uIxFQsOEGZp1ULbweevAhBL5uFibrcC8yYm87KNFoKKuWc9VI6tfI1RnyNZnURmkFI35M358Ngf2hsCvtlz7caCzvj90Zb76oet/Ynu9iXWl0IJ9huLNkzc/L3yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnpqUdoPtdeFws8SsFXAmOLdPi7NMj6KZvpCim2IKog=;
 b=HRlg+2yOBYkv14GClZy/w4mwYmO7HZWl1PWIgW9DD58LYdONrNCOl5TmvgubxjAIGGGLPl6S67tmiSc5MVEIGKx+Edva+MVea9VR4vQCCdjYhLxICIS9+wFh/ndQ1e2r+EHhs0uEzOx+ffIj8fpEkobhzl613v9k++6PDnCIPjNlBAYdTDsonVeq0kMNVFxImJ1pO/TY7wZhvRH44QtuYVtFWWGv+lusnnDyROAWAvunjvphDDzl/JVuFXtMqKQk7epgCWlfP6ffiZE7YUt/zEuLInIXTh61ck/209PAxXfX6CvXwjqeaYQBjA65TF62MfDGRgXIgBbRMSs+bNXj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB6199.namprd15.prod.outlook.com (2603:10b6:a03:526::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 20:02:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:02:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "dongsheng.yang@easystack.cn"
	<dongsheng.yang@easystack.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 18/35] libceph, rbd: Convert some page
 arrays to ceph_databuf
Thread-Index: AQHblHFOjkyCBfZhwkOjcwLuiRDkwrN5WHEA
Date: Tue, 18 Mar 2025 20:02:25 +0000
Message-ID: <4413c4ed03696b76ccd7903a87bd4c72ad9c883e.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-19-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-19-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB6199:EE_
x-ms-office365-filtering-correlation-id: f57a6842-3f24-4bef-2310-08dd6657cdea
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejJNSUxtT2JsQ29ZdXE1L2JuMzhHa2RJcElwQlhZZnJQTWtMcU5pS1ZZaXFu?=
 =?utf-8?B?aEU2bE5RckFhaHpraHpDcHYyYnIyUXBPdEFiOVF6aFo2L2dlRlE5QXExOW5o?=
 =?utf-8?B?NmlPcXZVY2p2aGFpc01Lalk0a0YyY0NhMmFBbmRHSGdJaFRKUmFsUnc3ZDdt?=
 =?utf-8?B?eUpOQ2loQnBRQk1sRG5UejgrcTVvNGFPYTFmbG5ZZDNBN3kwc2grcUxyVkNJ?=
 =?utf-8?B?MUQrK0Y1bk1nQ0NXVGRFSVhPYlZRZFFtNkdUYzNENG9CbStSVFlwQjQzY3By?=
 =?utf-8?B?RGxselh0YW00RlpzOFZ4RXNtcVc2ZGdZYlNocHJObkFDSmRiZ0RwNEo0WDNG?=
 =?utf-8?B?VjNnejJmL045ZFlCVVp3R3Z6SGEzWm5DcjJ6N3RSMFN1MXE3c0JvbVNlcVpv?=
 =?utf-8?B?aUNTMWZHN0o0bzBIR1JpSzB2c25zaWNXVEJwSEthNlFGOUJGb2dnYXQ0dDZm?=
 =?utf-8?B?RVlZdzJDQmM0aUVlcGhabldIOHlHbUNZdURMaWhOZzd6SjV6WENuRGtEVzZL?=
 =?utf-8?B?SGZxRjZQSkEzeFhVbXFtc2ZUQ1krMDNwU2s5UFBBa3pYVmVUMTdMbDBSclZy?=
 =?utf-8?B?YWF6eTVFV2FSYnBZNmNWTTJIRml6SzZBMDhOL2NxZ3o3T29veXhLV29FUWRX?=
 =?utf-8?B?VWFKZDN0NUNlM0IxZDFodWNxS3JQSmE0cU1LaCtJKy9OdjJOb0kxTk5VWndM?=
 =?utf-8?B?aG5yb1NudHJTc2FVWGZpUldmSTVrOCsvaFZmdE1xTWRkZmMrUEN3d0dZRkNY?=
 =?utf-8?B?OG12b0k0RkJuY0RFMzNKbkVnYUx5VmhkM3RDUUF4QlBVR1ZTL2pVQnR5M1JS?=
 =?utf-8?B?TWFsekFCcGU1bzFIbXZDbE94SjBQMEZ1Y21HTGxmRmx6dmE5eEREdHJBTU5G?=
 =?utf-8?B?cy9ScXdmS24zTTcvL3lqYnBFRGl2aENmQ3d3dFk0SDUycStTQnczdW1SYXR2?=
 =?utf-8?B?UEhEVzkzQ1RWdktzVUlONVlrd1RiS2hEV000Uy82TGUyQnJWM2o2UnFpanBQ?=
 =?utf-8?B?NVhpZWhnZkp1bk9XQ084RmZjODVrdHBtV2gxa1Vxd1FFalVwR3gvRUpoR3I4?=
 =?utf-8?B?MEdsVEZpdkFaRU9zSnlBSjg3YVludVhSWEF0cHhtbTFicG1ZZXQ4WG5WVlJh?=
 =?utf-8?B?S1ZDNlViMkVmN25CMHBZNytBUmJXZVFxV2lidlFHQURsUDV0VWZlcG1UYjNt?=
 =?utf-8?B?ekZuKy95R083VFloWUhhTEZDNCtnbWFjMzAyNnpjV1JERzFBVnVEMlBnYy9p?=
 =?utf-8?B?ZFJKaUM3WTNNZVUxVHcwWjhWMGh6YU1wR2FHZXJlTG5ubys4dk5Nek5UNmZN?=
 =?utf-8?B?YktIM2NSYW5Ha21Ed2VOUUlyeWFpTE9aU1JINTZCRm41L1lEV2dyM0NheXFN?=
 =?utf-8?B?NWRCMURwTFlMWVkyV24vS0FDRTA5cU1OSUtOcU04dkYwdWVWWDR1TWNJbkVt?=
 =?utf-8?B?VjRtV1F5OEkzNVpJV21UTkd4aXVEWHZ0cVBxY1BMaWg3UEM2VWZ5TjdJbkcz?=
 =?utf-8?B?VWNVL0dySUJhNFo4RWwrSmREVXJ5cGJyMHM5V2ZJNE1nV0F6L285VUt1RWk5?=
 =?utf-8?B?QzZLbDBHbmZmUmJzZkh2S0VucUMyR2l4VS9pSEVhODZ1cFRlSU1UcVNZV0xp?=
 =?utf-8?B?L3o2Kzhra2RWSFZCZUR3VTVUVTh1WkVaY2ovckNGUm1PZG53VUEvLys0Sm1r?=
 =?utf-8?B?bEdkdXZrUy9SRnJnUmh5RUJPTHdhOHBzUnZ1QzJ1ZGRwODljNHBsdUVYcXh4?=
 =?utf-8?B?RVcwT2M1elJuWWNhK1Y0Y3V1M3NRS0REODVtTnNNc0dFeVZoZSszK2NqUnVP?=
 =?utf-8?B?VkZyL3dUcWRES05STmVZWVQ0T2lUU1dPMEtIbURMaG9CWU83ZXB0dzZIa1pX?=
 =?utf-8?B?SHlEUHRYNUFTaFQxNC9jQWgyZUl1cFVBMDNkQXdNdG1CN1JMRmZBYitEU00y?=
 =?utf-8?Q?6Fty5K9Y7R31XFugAXmcsg77CMrqAvmF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDBaRCtOOHRCUjRaMklPQkF5SmJqN2l3WDdiUG9ndnBtajNDRGRlckdZdkZK?=
 =?utf-8?B?ZWlCN1N1U0U3UmFCMTVXRFMyUTlBbVByUVBpMTR2dW5GWkpXRzNXMWRNMUI3?=
 =?utf-8?B?R0VoUUpqTDR5ODdoV1JJWVFwYTZqS0dJc1Z2Z0drbXliaFBvSHcxNExFVXps?=
 =?utf-8?B?RW14YW9NSDBIOVFsNU5ReHBFd3JnUXU5N214V01HSWlra3lBUjl0SVRMUGRz?=
 =?utf-8?B?eXB6d0tiYVpNQklabUJUOSs3RGhnaDZXOWlndTU5MWNQaURXYW5BTFozeDJs?=
 =?utf-8?B?MElXR3dVSzRnWnJEdlJqbitsV0huTHFmNENyelUzRitZVy8wekVlN3E1Q1lF?=
 =?utf-8?B?NnlhV2RTd3ViaE83NXlUa2xIRmU1ZVViTVpERGhzcUZ4RFd0Qk01R0Y1MGp0?=
 =?utf-8?B?MHRJWUxBeVdWMSszbUhyUHZYT0VNbmw5UzBmVXBscTl4WVZJd1NHS3p6SlB5?=
 =?utf-8?B?WVNadFhEWVFCOTJUSTZuSVJ2S05zMXNvbVIwTFA1QWNhNnBLRWhxc3BDQ2xR?=
 =?utf-8?B?S3dldlpWZlAxaXI1QlNrVzdCNUxWRzZWVWFtMjhRV2UralY5eWVNUlVEc25I?=
 =?utf-8?B?MmRPVDBCblJYZVNlQmhreHR0Vk42dnZzTEs5d2RPaGNFSW9HL3VRZk9FcHBB?=
 =?utf-8?B?Zy9BQSs4aEJjNGNjMnhmRmYvWjE3ekgrNFNPZnlIYm9DQ1c1ZExjeUJkbUVz?=
 =?utf-8?B?bEhFRDhaRnNvWkJ1NG9MWDB5ZUJmUVUrRXg4ZVd0QUVrVTNqamlSWnpScURl?=
 =?utf-8?B?ZkhiUzFibXVpcDZEd2dJUk5aNFp3NHZYOFNqMFJKQytaZFUxM1lPa0lQWldB?=
 =?utf-8?B?QkNmNGZXczkxSkJENytHRndqc0x0WkNvNnlZWjFFWVNJbjFSRUtWSlM1ekJY?=
 =?utf-8?B?Z2k5N1FoZ2FMampVOExHMzgzT0VjbWV5d2U4YjdFTVJIZ2FaZmErVVBWOTNX?=
 =?utf-8?B?V2ZWYUZEWE9KTW1Cak5YaEdJS00rQWxQSnFaa2tUcTU0d3NOM0taVmVSdTFT?=
 =?utf-8?B?MkJFYm42WVllQ1pnWGJTYllXMFJKTEJ4WDZMOGsycnZXamVaQkVkK2JzNkhm?=
 =?utf-8?B?Q211WVN5b1Y2dlA1MGlxY3lqYm5Sa2QvcUxkb0tEVG1leDRkVFRYL3g4SUlH?=
 =?utf-8?B?a2dHRWR4NTdlRE9WdDNZQk5LMXlxU3EyWUV1QXFyRnBmenhzL3ZnajNRTHIy?=
 =?utf-8?B?bVU1QmVkc2gzSC9LVVY5d3VOb2xEKzVtSlYzTFVtMGhRVEFpQmJuNXBNWW9F?=
 =?utf-8?B?S0pZZEcyaTRDbjY0SW1GOFJERzdsNE85RFduM05MdjJoTVR4VE54T0xURU1x?=
 =?utf-8?B?Y1RDS1FuMDExNkJPRk1OWVlIQkJHdkJ1OHNocjhnTHV1cTdIRTZUeFNvU2Ra?=
 =?utf-8?B?ZVh2QmJmV1lqblQ4NUx1SFEzK0llK1RzcC82SDJZRnZmOEFyQ3Z5RTZZY1JQ?=
 =?utf-8?B?am1sUjVUdjBlbFJEUVdFVmJUeU1qVnNQZXdTZnhDMFhvdzRaUFpQUFlZYkxS?=
 =?utf-8?B?d0dLaGFpUnN1anYyWE9DQWhYSFNkbGx0dHhBTS82NWJueEQydDFud1hzNS9B?=
 =?utf-8?B?ODh0RXpTb0liQlMyVUQ2SVB0OHF4Mm03ckNVUmZzeVJtRWMva2RyOW1zeWNY?=
 =?utf-8?B?NThybDBlWnMzUzluV0wzaTl2UDB5bzc4YURsT0pza1JpbnVCRjNPdmFvd2lJ?=
 =?utf-8?B?TXBheFAzS2ZGRFdJWk9sdk9TOXZENGYvZW8xYXJydEc2WXJjS1J5eXBSWFZw?=
 =?utf-8?B?RmtPUUtvM2ZiUXJDcnRlcTNJQll0REpsWWhya1hZVlBmbnYvOXhjcE1CUXpG?=
 =?utf-8?B?anI3a25XWXhvajNLRGVJb1pib3VqaXVBOTd5Rnp4RWdhRDAzaDlWbUZya2d1?=
 =?utf-8?B?cFZTS1hZMWdMZ2t5bHRWb2tnODJzcHpwaWVaUmNlY0dIZXFuS1NGbVhzOFBu?=
 =?utf-8?B?Ykk3blNDNTdEa3IzMUF1bkhiOGlKQWlXRU1UKzR1UXY5UElxVmMwM3ZaVlF2?=
 =?utf-8?B?SU9kZXBuMjJzN1pRSGc3SkJ1emF1NCtYMjgzWG1jNlk4R1IxSGQrZFRQQWxz?=
 =?utf-8?B?SzhjSmxtYkNVRW5hV0xFTEJRNEZuSExJOTBsRjY3cDc3OE1BMXpJVmNjUkRV?=
 =?utf-8?B?OWRvdzR2MTdUVytpMVRTZVJmVk15YklQMHZHbUkvWUNyQ0tSYnhnNUdNSUlY?=
 =?utf-8?Q?uSl4TlxhHHbDF2G9EAyTp0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2FD52C6A6AEC4798B19BD234719B80@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f57a6842-3f24-4bef-2310-08dd6657cdea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:02:25.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKMhfSG/bscP6DsAuB0+p35pZyBPtTVMHhsSJRVbR4qYwoSRQFkUJia/PneZhYZ4Kb9WGQARK4WV/oXbhoqJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6199
X-Proofpoint-GUID: qoDZMNp--j5Ddn0xnSniTlWXU6IvHRFh
X-Proofpoint-ORIG-GUID: TgRQy8xrHrXyE8S4UfpZHtB9EIKON39O
Subject: Re:  [RFC PATCH 18/35] libceph, rbd: Convert some page arrays to
 ceph_databuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180144

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMzICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBDb252ZXJ0IHNvbWUgbWlzY2VsbGFuZW91cyBwYWdlIGFycmF5cyB0byBjZXBoX2RhdGFidWYg
Y29udGFpbmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxz
QHJlZGhhdC5jb20+DQo+IGNjOiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29t
Pg0KPiBjYzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBjYzogSWx5YSBE
cnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBjYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2
ZXJzL2Jsb2NrL3JiZC5jICAgICAgICAgICAgIHwgMTIgKysrKy0tLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L2NlcGgvb3NkX2NsaWVudC5oIHwgIDMgKysrDQo+ICBuZXQvY2VwaC9vc2RfY2xpZW50LmMg
ICAgICAgICAgIHwgNDMgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svcmJkLmMgYi9kcml2ZXJzL2Jsb2NrL3JiZC5jDQo+IGlu
ZGV4IDA3OGJiMWUzZTFkYS4uZWVhMTJjN2FiMmEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Js
b2NrL3JiZC5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gQEAgLTIxMDgsNyArMjEw
OCw3IEBAIHN0YXRpYyBpbnQgcmJkX29ial9jYWxjX2ltZ19leHRlbnRzKHN0cnVjdCByYmRfb2Jq
X3JlcXVlc3QgKm9ial9yZXEsDQo+ICANCj4gIHN0YXRpYyBpbnQgcmJkX29zZF9zZXR1cF9zdGF0
KHN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0ICpvc2RfcmVxLCBpbnQgd2hpY2gpDQo+ICB7DQo+IC0J
c3RydWN0IHBhZ2UgKipwYWdlczsNCj4gKwlzdHJ1Y3QgY2VwaF9kYXRhYnVmICpkYnVmOw0KPiAg
DQo+ICAJLyoNCj4gIAkgKiBUaGUgcmVzcG9uc2UgZGF0YSBmb3IgYSBTVEFUIGNhbGwgY29uc2lz
dHMgb2Y6DQo+IEBAIC0yMTE4LDE0ICsyMTE4LDEyIEBAIHN0YXRpYyBpbnQgcmJkX29zZF9zZXR1
cF9zdGF0KHN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0ICpvc2RfcmVxLCBpbnQgd2hpY2gpDQo+ICAJ
ICogICAgICAgICBsZTMyIHR2X25zZWM7DQo+ICAJICogICAgIH0gbXRpbWU7DQo+ICAJICovDQo+
IC0JcGFnZXMgPSBjZXBoX2FsbG9jX3BhZ2VfdmVjdG9yKDEsIEdGUF9OT0lPKTsNCj4gLQlpZiAo
SVNfRVJSKHBhZ2VzKSkNCj4gLQkJcmV0dXJuIFBUUl9FUlIocGFnZXMpOw0KPiArCWRidWYgPSBj
ZXBoX2RhdGFidWZfcmVwbHlfYWxsb2MoMSwgOCArIHNpemVvZihzdHJ1Y3QgY2VwaF90aW1lc3Bl
YyksIEdGUF9OT0lPKTsNCg0KV2hhdCB0aGlzIDggKyBzaXplb2Yoc3RydWN0IGNlcGhfdGltZXNw
ZWMpIG1lYW5zPyBXaHkgZG8gd2UgdXNlIDggaGVyZT8gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoN
Cj4gKwlpZiAoIWRidWYpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+ICAJb3NkX3JlcV9v
cF9pbml0KG9zZF9yZXEsIHdoaWNoLCBDRVBIX09TRF9PUF9TVEFULCAwKTsNCj4gLQlvc2RfcmVx
X29wX3Jhd19kYXRhX2luX3BhZ2VzKG9zZF9yZXEsIHdoaWNoLCBwYWdlcywNCj4gLQkJCQkgICAg
IDggKyBzaXplb2Yoc3RydWN0IGNlcGhfdGltZXNwZWMpLA0KPiAtCQkJCSAgICAgMCwgZmFsc2Us
IHRydWUpOw0KPiArCW9zZF9yZXFfb3BfcmF3X2RhdGFfaW5fZGF0YWJ1Zihvc2RfcmVxLCB3aGlj
aCwgZGJ1Zik7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvY2VwaC9vc2RfY2xpZW50LmggYi9pbmNsdWRlL2xpbnV4L2NlcGgvb3NkX2NsaWVu
dC5oDQo+IGluZGV4IGQzMWU1OWJkMTI4Yy4uNmUxMjZlMjEyMjcxIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2NlcGgvb3NkX2NsaWVudC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvY2Vw
aC9vc2RfY2xpZW50LmgNCj4gQEAgLTQ4Miw2ICs0ODIsOSBAQCBleHRlcm4gdm9pZCBvc2RfcmVx
X29wX2V4dGVudF9vc2RfZGF0YV9wYWdlcyhzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqLA0KPiAg
CQkJCQlzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1NjQgbGVuZ3RoLA0KPiAgCQkJCQl1MzIgb2Zmc2V0
LCBib29sIHBhZ2VzX2Zyb21fcG9vbCwNCj4gIAkJCQkJYm9vbCBvd25fcGFnZXMpOw0KPiArdm9p
ZCBvc2RfcmVxX29wX3Jhd19kYXRhX2luX2RhdGFidWYoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3Qg
Km9zZF9yZXEsDQo+ICsJCQkJICAgIHVuc2lnbmVkIGludCB3aGljaCwNCj4gKwkJCQkgICAgc3Ry
dWN0IGNlcGhfZGF0YWJ1ZiAqZGF0YWJ1Zik7DQo+ICBleHRlcm4gdm9pZCBvc2RfcmVxX29wX2V4
dGVudF9vc2RfZGF0YV9wYWdlbGlzdChzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqLA0KPiAgCQkJ
CQl1bnNpZ25lZCBpbnQgd2hpY2gsDQo+ICAJCQkJCXN0cnVjdCBjZXBoX3BhZ2VsaXN0ICpwYWdl
bGlzdCk7DQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9vc2RfY2xpZW50LmMgYi9uZXQvY2VwaC9v
c2RfY2xpZW50LmMNCj4gaW5kZXggYjRhZGIyOTlmOWNkLi42NGEwNjI2N2U3YjMgMTAwNjQ0DQo+
IC0tLSBhL25ldC9jZXBoL29zZF9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9vc2RfY2xpZW50
LmMNCj4gQEAgLTE4Miw2ICsxODIsMTcgQEAgb3NkX3JlcV9vcF9leHRlbnRfb3NkX2RhdGEoc3Ry
dWN0IGNlcGhfb3NkX3JlcXVlc3QgKm9zZF9yZXEsDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKG9z
ZF9yZXFfb3BfZXh0ZW50X29zZF9kYXRhKTsNCj4gIA0KPiArdm9pZCBvc2RfcmVxX29wX3Jhd19k
YXRhX2luX2RhdGFidWYoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKm9zZF9yZXEsDQo+ICsJCQkJ
ICAgIHVuc2lnbmVkIGludCB3aGljaCwNCj4gKwkJCQkgICAgc3RydWN0IGNlcGhfZGF0YWJ1ZiAq
ZGJ1ZikNCj4gK3sNCj4gKwlzdHJ1Y3QgY2VwaF9vc2RfZGF0YSAqb3NkX2RhdGE7DQo+ICsNCj4g
Kwlvc2RfZGF0YSA9IG9zZF9yZXFfb3BfcmF3X2RhdGFfaW4ob3NkX3JlcSwgd2hpY2gpOw0KPiAr
CWNlcGhfb3NkX2RhdGFidWZfaW5pdChvc2RfZGF0YSwgZGJ1Zik7DQo+ICt9DQo+ICtFWFBPUlRf
U1lNQk9MKG9zZF9yZXFfb3BfcmF3X2RhdGFfaW5fZGF0YWJ1Zik7DQo+ICsNCj4gIHZvaWQgb3Nk
X3JlcV9vcF9yYXdfZGF0YV9pbl9wYWdlcyhzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqb3NkX3Jl
cSwNCj4gIAkJCXVuc2lnbmVkIGludCB3aGljaCwgc3RydWN0IHBhZ2UgKipwYWdlcywNCj4gIAkJ
CXU2NCBsZW5ndGgsIHUzMiBvZmZzZXQsDQo+IEBAIC01MDAwLDcgKzUwMTEsNyBAQCBpbnQgY2Vw
aF9vc2RjX2xpc3Rfd2F0Y2hlcnMoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYywNCj4gIAkJ
CSAgICB1MzIgKm51bV93YXRjaGVycykNCj4gIHsNCj4gIAlzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVz
dCAqcmVxOw0KPiAtCXN0cnVjdCBwYWdlICoqcGFnZXM7DQo+ICsJc3RydWN0IGNlcGhfZGF0YWJ1
ZiAqZGJ1ZjsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJcmVxID0gY2VwaF9vc2RjX2FsbG9jX3Jl
cXVlc3Qob3NkYywgTlVMTCwgMSwgZmFsc2UsIEdGUF9OT0lPKTsNCj4gQEAgLTUwMTEsMTYgKzUw
MjIsMTYgQEAgaW50IGNlcGhfb3NkY19saXN0X3dhdGNoZXJzKHN0cnVjdCBjZXBoX29zZF9jbGll
bnQgKm9zZGMsDQo+ICAJY2VwaF9vbG9jX2NvcHkoJnJlcS0+cl9iYXNlX29sb2MsIG9sb2MpOw0K
PiAgCXJlcS0+cl9mbGFncyA9IENFUEhfT1NEX0ZMQUdfUkVBRDsNCj4gIA0KPiAtCXBhZ2VzID0g
Y2VwaF9hbGxvY19wYWdlX3ZlY3RvcigxLCBHRlBfTk9JTyk7DQo+IC0JaWYgKElTX0VSUihwYWdl
cykpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihwYWdlcyk7DQo+ICsJZGJ1ZiA9IGNlcGhfZGF0YWJ1
Zl9yZXBseV9hbGxvYygxLCBQQUdFX1NJWkUsIEdGUF9OT0lPKTsNCj4gKwlpZiAoIWRidWYpIHsN
Cj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gIAkJZ290byBvdXRfcHV0X3JlcTsNCj4gIAl9DQo+ICAN
Cj4gIAlvc2RfcmVxX29wX2luaXQocmVxLCAwLCBDRVBIX09TRF9PUF9MSVNUX1dBVENIRVJTLCAw
KTsNCj4gLQljZXBoX29zZF9kYXRhX3BhZ2VzX2luaXQob3NkX3JlcV9vcF9kYXRhKHJlcSwgMCwg
bGlzdF93YXRjaGVycywNCj4gLQkJCQkJCSByZXNwb25zZV9kYXRhKSwNCj4gLQkJCQkgcGFnZXMs
IFBBR0VfU0laRSwgMCwgZmFsc2UsIHRydWUpOw0KPiArCWNlcGhfb3NkX2RhdGFidWZfaW5pdChv
c2RfcmVxX29wX2RhdGEocmVxLCAwLCBsaXN0X3dhdGNoZXJzLA0KPiArCQkJCQkgICAgICByZXNw
b25zZV9kYXRhKSwNCj4gKwkJCSAgICAgIGRidWYpOw0KPiAgDQo+ICAJcmV0ID0gY2VwaF9vc2Rj
X2FsbG9jX21lc3NhZ2VzKHJlcSwgR0ZQX05PSU8pOw0KPiAgCWlmIChyZXQpDQo+IEBAIC01MDI5
LDEwICs1MDQwLDExIEBAIGludCBjZXBoX29zZGNfbGlzdF93YXRjaGVycyhzdHJ1Y3QgY2VwaF9v
c2RfY2xpZW50ICpvc2RjLA0KPiAgCWNlcGhfb3NkY19zdGFydF9yZXF1ZXN0KG9zZGMsIHJlcSk7
DQo+ICAJcmV0ID0gY2VwaF9vc2RjX3dhaXRfcmVxdWVzdChvc2RjLCByZXEpOw0KPiAgCWlmIChy
ZXQgPj0gMCkgew0KPiAtCQl2b2lkICpwID0gcGFnZV9hZGRyZXNzKHBhZ2VzWzBdKTsNCj4gKwkJ
dm9pZCAqcCA9IGttYXBfY2VwaF9kYXRhYnVmX3BhZ2UoZGJ1ZiwgMCk7DQo+ICAJCXZvaWQgKmNv
bnN0IGVuZCA9IHAgKyByZXEtPnJfb3BzWzBdLm91dGRhdGFfbGVuOw0KPiAgDQo+ICAJCXJldCA9
IGRlY29kZV93YXRjaGVycygmcCwgZW5kLCB3YXRjaGVycywgbnVtX3dhdGNoZXJzKTsNCj4gKwkJ
a3VubWFwKHApOw0KPiAgCX0NCj4gIA0KPiAgb3V0X3B1dF9yZXE6DQo+IEBAIC01MjQ2LDEyICs1
MjU4LDEyIEBAIGludCBvc2RfcmVxX29wX2NvcHlfZnJvbV9pbml0KHN0cnVjdCBjZXBoX29zZF9y
ZXF1ZXN0ICpyZXEsDQo+ICAJCQkgICAgICB1OCBjb3B5X2Zyb21fZmxhZ3MpDQo+ICB7DQo+ICAJ
c3RydWN0IGNlcGhfb3NkX3JlcV9vcCAqb3A7DQo+IC0Jc3RydWN0IHBhZ2UgKipwYWdlczsNCj4g
KwlzdHJ1Y3QgY2VwaF9kYXRhYnVmICpkYnVmOw0KPiAgCXZvaWQgKnAsICplbmQ7DQo+ICANCj4g
LQlwYWdlcyA9IGNlcGhfYWxsb2NfcGFnZV92ZWN0b3IoMSwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYg
KElTX0VSUihwYWdlcykpDQo+IC0JCXJldHVybiBQVFJfRVJSKHBhZ2VzKTsNCj4gKwlkYnVmID0g
Y2VwaF9kYXRhYnVmX3JlcV9hbGxvYygxLCBQQUdFX1NJWkUsIEdGUF9LRVJORUwpOw0KPiArCWlm
ICghZGJ1ZikNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAlvcCA9IG9zZF9yZXFfb3Bf
aW5pdChyZXEsIDAsIENFUEhfT1NEX09QX0NPUFlfRlJPTTIsDQo+ICAJCQkgICAgIGRzdF9mYWR2
aXNlX2ZsYWdzKTsNCj4gQEAgLTUyNjAsMTYgKzUyNzIsMTcgQEAgaW50IG9zZF9yZXFfb3BfY29w
eV9mcm9tX2luaXQoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSwNCj4gIAlvcC0+Y29weV9m
cm9tLmZsYWdzID0gY29weV9mcm9tX2ZsYWdzOw0KPiAgCW9wLT5jb3B5X2Zyb20uc3JjX2ZhZHZp
c2VfZmxhZ3MgPSBzcmNfZmFkdmlzZV9mbGFnczsNCj4gIA0KPiAtCXAgPSBwYWdlX2FkZHJlc3Mo
cGFnZXNbMF0pOw0KPiArCXAgPSBrbWFwX2NlcGhfZGF0YWJ1Zl9wYWdlKGRidWYsIDApOw0KPiAg
CWVuZCA9IHAgKyBQQUdFX1NJWkU7DQo+ICAJY2VwaF9lbmNvZGVfc3RyaW5nKCZwLCBzcmNfb2lk
LT5uYW1lLCBzcmNfb2lkLT5uYW1lX2xlbik7DQo+ICAJZW5jb2RlX29sb2MoJnAsIHNyY19vbG9j
KTsNCj4gIAljZXBoX2VuY29kZV8zMigmcCwgdHJ1bmNhdGVfc2VxKTsNCj4gIAljZXBoX2VuY29k
ZV82NCgmcCwgdHJ1bmNhdGVfc2l6ZSk7DQo+ICAJb3AtPmluZGF0YV9sZW4gPSBQQUdFX1NJWkUg
LSAoZW5kIC0gcCk7DQo+ICsJY2VwaF9kYXRhYnVmX2FkZGVkX2RhdGEoZGJ1Ziwgb3AtPmluZGF0
YV9sZW4pOw0KPiArCWt1bm1hcF9sb2NhbChwKTsNCj4gIA0KPiAtCWNlcGhfb3NkX2RhdGFfcGFn
ZXNfaW5pdCgmb3AtPmNvcHlfZnJvbS5vc2RfZGF0YSwgcGFnZXMsDQo+IC0JCQkJIG9wLT5pbmRh
dGFfbGVuLCAwLCBmYWxzZSwgdHJ1ZSk7DQo+ICsJY2VwaF9vc2RfZGF0YWJ1Zl9pbml0KCZvcC0+
Y29weV9mcm9tLm9zZF9kYXRhLCBkYnVmKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIEVYUE9S
VF9TWU1CT0wob3NkX3JlcV9vcF9jb3B5X2Zyb21faW5pdCk7DQo+IA0KPiANCg0K

