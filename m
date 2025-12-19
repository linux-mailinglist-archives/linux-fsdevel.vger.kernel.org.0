Return-Path: <linux-fsdevel+bounces-71782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229ECD1CE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F8230E04E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39F2C237C;
	Fri, 19 Dec 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M8RXFa/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CA2D7DC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176750; cv=fail; b=Uz7hp7HNlmftkl2HK8xhRasIN3/emn8YUfMozp5lqavZ+MIet5/LA2dliE9fCmugvxszD6NwOLmq9J5biKc2L0MZ6OSrIIexDL/zZbhTIRK7o41VYOChbF69m2UhS45JuEM2M5DyzNZN6PRxr7pXTO81GOySWxemE+K5YkeZ4DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176750; c=relaxed/simple;
	bh=d802Ohi2IG4ZzeHQ4y5e+LtgydnjwSfDuPPGPwJmpLM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Dmh7UGS0PLiz+6rXOFH4hEntyvz3iV5X+R36UhBvYVr+r0x/I/W2nBFtbxnE9r22HfDP3rZ6svObZhuo6atiQeISTmztDdy4aeasaYybXbpeMlNNOaCfjrSst8JS3QGCSgNb5qfVLuRv++DnqfRA79JWc+0GI7KUyAlvkO4CvCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M8RXFa/9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJJssKV025946
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=SPm7BBGu2NTGbg3+Hy5rFLwTrAep7jv/bhM+HKdV+sE=; b=M8RXFa/9
	UoIhuoCzfdxKJdWPLlWlo5EWfJYCpGy4+RR6oNd6Mg5T5vvg72J/fW+YJigf+09B
	1cRzzFIkBjHAOY3K7o3ZEuhvWyrnCIyVRboDl35X3LVAIDMsTKMFDVKq7ME7/TBh
	iuuXYhbhUPpzQoJuCSha+2mz2iQt1T9Dj43nj27G4u1DPjRGi2OCi2Qnbw0t1u2K
	a0u91qMj56qMVrkpdeSe1UZ0mMBtp0YKqYJlLsFoF+ZCSq21MVHk5rGR9YEF+zQK
	adA4YUR9Z5ofIHL3qb2+JerkFlsOiC9I410/Q/CysA4jqQxKgy4RBW3UoWk9heWw
	Uei9LtMA0KmUeg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwn25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:39:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJKS3d3001553
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:39:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwn23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:39:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJKapVn018975;
	Fri, 19 Dec 2025 20:39:04 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3hwn1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 20:39:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2p+NU0QOIs82Sw1W+Vong/Q3t44X6rZJkaovl6Lp+PjA1eU+mv/kJ0yMMgKtwTcLSG06Ap2S8ahvZuIhcZ3cmhVo/y5rpVJfYDqQ6qdbUeH0t7SfUm5eEbuaTIdSPgU9C1XTOi+pt8zSvpw0SBTaFe5uGxqHnY0Lr2nGL+6npK24amqeeEohe9vwTtpb7lQeheXO+fWtpx32SWcxbVYUsYacmCPSnyHnSvVjiUrhcXgbjbTeCx6/yTO+8V67Hr2xQZVXUcwYzAcL8xgdwWciDLDZkFwsYdWK53PZ+FihMZ7f6BOKGpM9vzaG9R6CwbAssdXrrR0TEB2czMeyfsIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p50zs5kmVHzAyljLhkzcS+X/19uR5ioCYlUe2EoaV4A=;
 b=MmEPGQlaH/bvB9HSYRs65luSGIsS4KkgKqTBKn0cANzEMLIaTUufqRmfaCJx13V+lnRIplGsVcr6ZrxJkRTGRCrM0tc+fpnsOurGy1qsBZXyzeo9P3sLVDn+mwteKiCnUl+owhBzHunbqNsMQR9fU3iFwGxHJ3j6SQhTKr5TA9avVgWai4TYpYGeSYUPvigB/QiSqbmIk4n73DLQ+ZY9JQCnZ3fmyfom0M2YxCs28oPb4NrmEfrtiHvD/Y7pvDE1QkAzje7e98QMKtkOGd4sM9m7dLUE7iZd4GJ68K/ZuKJ/MAImJ5KwVrcW3O/pSkLuWErbCP8dBk9EeTJ7ufhmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6731.namprd15.prod.outlook.com (2603:10b6:8:1ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:39:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 20:39:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Patrick Donnelly <pdonnell@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAP6yAIAAZyuAgAFGR4A=
Date: Fri, 19 Dec 2025 20:39:01 +0000
Message-ID: <87994d8c04ecb211005c0ad63f63e750b41070bd.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
	 <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com>
	 <CA+2bHPaxwf5iVo5N9HgOeCQtVTL8+LrHN_=K3EB-z+jujdGbuQ@mail.gmail.com>
In-Reply-To:
 <CA+2bHPaxwf5iVo5N9HgOeCQtVTL8+LrHN_=K3EB-z+jujdGbuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6731:EE_
x-ms-office365-filtering-correlation-id: 5aae21ef-ddb7-4418-a711-08de3f3ea4e4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUY2QkNubWh6RDJ1ZUpMTnVKaC8ycHpvZkVxTWE1b3lqRE9sT3ZEbjdreGts?=
 =?utf-8?B?ZmNmekJRR1d1aUdqOFZSbTNoWUx6ck1LMTFKVDFFa3I4NG9NckcweDYvT000?=
 =?utf-8?B?Tk5QN3A2SEY4SVREamlQVEdlWHpqbCtPSEJyQU5Xc01SWk5KWmc5d3RrRG4r?=
 =?utf-8?B?UlNXMXB5NytlcytvR1FvRXlhdmZOaENON2E4S21lQXQ3YzZxTEYwS2NjMFlk?=
 =?utf-8?B?MnJaQVM3dEZoUjNJK2o3ZXZQTDNzQnpWUlRFWmowR1NhSEplSFlQSmFWYVVa?=
 =?utf-8?B?aVhva0V3QWQxYkNORUR3aWxsSlNVUnVNenlYMFNHTEh2SzkybXRYSGRNOVQ5?=
 =?utf-8?B?Mk9XM2IzZU9PNTlnVEQzVDJBMGxxUEVFdmp4OHJVYkJMQnd1NGQxaWNua1pJ?=
 =?utf-8?B?L3pjZlNKeGZpOVBwYXBCRmlMc0N5WW5UeTVWc1dVTnoycVdWL05vZ0pseEVQ?=
 =?utf-8?B?SXFmM2ZSNVREb0U3ZmVhejVHa0RnYkVyK0tObmRIUEdxUXJHVFFja1BoVVE0?=
 =?utf-8?B?TXkxUlZBMTFMdEp6R2gxUmFkRkFQNjBhNVpnQnBQcGV4UzcwZTZBQy9wRzVk?=
 =?utf-8?B?ZGNtb1hVM05DM01RQzhnaXFXOUNCQm5EV2Y3b1RsN1VHR2oyWnVJUlBXa1p1?=
 =?utf-8?B?dy8xamt5ZllwbVlQR1Zzem1LTkxGQ1RzZ3lQVmVOeHI3SXIvd1F4Nzd5c0pW?=
 =?utf-8?B?Z2kwR2pQejJQOTZWYmJsTWxiWGExM3Nid3E2VE41OFRRa2FaVE9TbGVId2Z3?=
 =?utf-8?B?M09lTUpnelJyblZ0eWFaL1FRSjE5b2NHOTNRNzJ1ZFVtRHlTTUEvdWY1dGJY?=
 =?utf-8?B?SW9OWHg5ZGJ2MTg5VTZQcUZVOGpkZkJZaWVDNWVmbmd3Y0pvNFBoZ0UyWGdB?=
 =?utf-8?B?dFgrdzNNWlJrYmhtaDBzWTArUTFnMmNZSWU3V3VDMkVPYVRUZG02SDh0T1VN?=
 =?utf-8?B?M3dNUk11VmpDdWw0NDhIY0poVnluK0JaRkprNjkxd0pvR21tc0YyUXM0Q1JV?=
 =?utf-8?B?akdnUXNEWnZ6YjdvbitKcmt5ejArK3ZzK0FFN2xaVDlLSGhOSlh3bFNEKy9q?=
 =?utf-8?B?RUFBS0h1anpsK1cva28yVTVhMnlYZXphUU5WQ00wbHl1WVpqRTJUeGZQSWk1?=
 =?utf-8?B?UU9HdnJHYjNZU1ZSUTJVWUIzTVpKQThlOEliZm9LUmFqa3V5STJYbDM2L2tu?=
 =?utf-8?B?QmpoTjl5bnlTTjQ3ZCtxaWhqM0p1dU1tYlRTc0FkaGNHbEpRK0VmUk1BSlJ1?=
 =?utf-8?B?SitHeTNOZlZadytZOFp3YVNaTzRaQ0o4M0xOQ0VzdWplWURxeTdvalo0akNn?=
 =?utf-8?B?M1REK2lxNFh6dmE0c21jM0RMd2hHek5abythYVRBeWpwTGNET1Z2bWlsb3Vh?=
 =?utf-8?B?L0xmRDhwTVg1U2kzV3dYY2Y4aXI4REVNWGJhemNnTUdFaE40RGMvSUxDaWVP?=
 =?utf-8?B?dk1zTldSWDJiOW1MZkpyNEN2czJOMDJFZGdUWDlkV3RkczcyZzhseXNNMVZW?=
 =?utf-8?B?Qk94eGV1RVhBVUpuY1JlYm5scVlwZ2hGVEgyWmRIakRmblpzN1dhaGUrNHZN?=
 =?utf-8?B?QTMvN2YxcWcySFliWlBYRGcyYS8wZEIvT0VreEZQWWxvNFJyTVprYmtSNEJN?=
 =?utf-8?B?WDFwWDRxR2dsU0NqNUh1MEM1cmduREtrZmVzNlcwbFhsa2VxNjR2NVVnSXBD?=
 =?utf-8?B?ckNTMHlrWDd0MCtDSUNFb1lkcTVuejNkVjZQdGQ4WEIyTnUwNnBFZTNLbFBB?=
 =?utf-8?B?L1NROXBGQWtGNWNDaGx5K2hUNXVMZG94RG9YRFFweDQvbWhCSjJJbjhON21x?=
 =?utf-8?B?TnczVUJoM25SZlREUHBKNW9DZktYYUVieC9adENhYTc3TFpDUWNlUVdQMCtR?=
 =?utf-8?B?V0lmS0VNdDlVSVhXL1lRakV4VndvczU1d21VZ2hveFFWcWREaFNZOFo3dlZs?=
 =?utf-8?B?MTUvbXlSK0lkZkJKR3Y2aTVVTm5TRFJqbG55d3R2cEJ1WnFERE1xcVozZFNl?=
 =?utf-8?B?VWF3cWd2NlY0Nm5XU3oySDRxRFRFRkFuZTQwbWVJcVhHcTRDd0YxZUlzUlk0?=
 =?utf-8?Q?OF4+oJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmRaMW9ycm10b1JUVTRITFhoUVByM2NLeTgyZzRiZi9YWnNLakl6NkVuU0dp?=
 =?utf-8?B?ZkVrK2tkK2tFbkpuVDZyLzRQK09aeWJ0eElIL0lTMVlwWDFMOEdpckZYdkx6?=
 =?utf-8?B?NlpjaW0xMjR0RE1YczZQRkcwdFNhVFY4UWt3U1p6VHNXeVpIQUM0SXloT0Mz?=
 =?utf-8?B?L0ZWTmcxYllCQmtod1E4VklUZ1ZIV1kvTm5lN2c5VW9Mc0pyM3IvU1Q0WFhn?=
 =?utf-8?B?TUxIZDQ1aldNNnF4RFhjZmMyVCtkblNUdk5DZitnZE5PSWxQM3hmZGk0RWlH?=
 =?utf-8?B?dTFJMmNmZEJnS01sRU5uZGZhL1U5cmY5Qnh0SFpKU2trRDc1OWdHWGRocGdR?=
 =?utf-8?B?R0tyNXRobk1rejlva0I0QzVNWlJOcGtpTVU5WEF5WXh6UmpUR2Z3dURFNWJC?=
 =?utf-8?B?M0xhSUU1aEswVkorUE1rZ1U4YU5tV3d4TjBjN0lmN1ZqMHJvUWxHaWJnM2V4?=
 =?utf-8?B?TmhzUkRNS1k0dFlhcmo2SElTMXQyZDFhZHZCcFp5UkJtMGpLYUxqMVRxVUpy?=
 =?utf-8?B?cEE1QVl3N0VTZytpeXNKVFpxZVdibDJWc1U1WlM5L1RuTTF1bWF5bE1xOG1J?=
 =?utf-8?B?cDNQRGhWZmd2akIrZ2NGZWVTZmkra2x2bjdMOVoxSUNtbHJndE5XbTBFSmpw?=
 =?utf-8?B?YlJiZkUzYzc5UXlrdmllRDRqNlNXbDJHWjZScHN6aHRDOEZLUUk5TVF2c1g2?=
 =?utf-8?B?MnJ5NXJTL0pWN2FzSXBqSitnOE1VbHN0bUhpaHJoenhLQzdGQWhOVzVOZ0JX?=
 =?utf-8?B?L2NLODBEQVF4d2x4bHQ0Mk5YMzhjNE1kM0lIU1dBcmlwSGVGbVgzelZVRnhR?=
 =?utf-8?B?RzJOSGEzZFQ4M05pUk9tNWRDMVFqY3B2WElrZXVLUU1ZVW1CVnJ5MnczMHhV?=
 =?utf-8?B?UHorZGQ2Z0dBbldLYWFSS1pUeGhTeTdHQTBtUm5JZEJFd2dFMVZKWWpXaUlj?=
 =?utf-8?B?RGFrVXhUME1mZWZYSU9HQ2pXeVZySkZhbEd1R3lhWlF5dzk2VG9VTkFDMnAw?=
 =?utf-8?B?bkJydnRyQzllYjdPRmpMTktlKzVENTVxZWFuY0dsRjZZQkxQcC9xWDZFK1dV?=
 =?utf-8?B?cmt6OUU5VG5TWjhDYkJvODdYeDdYenEraGhJbEM2Yy9mamJraGw5cWVNTHNn?=
 =?utf-8?B?aVJmbG9yaTNyc1pHL0FZWHU2aVF2cUVZdDhhdWI2ZnRJOUxRdDFaQ1ozUG41?=
 =?utf-8?B?U1pMdTZvM1M4RzU4Y2tXTFZBSDdLZW9FaFQvQmhvNnZidFZ0aUc2a091YVFG?=
 =?utf-8?B?dDNQdnk3UTZkRWdERXJidWhFMmd2SWVIeWxTSDlmdDN1KzJSdEFkNnFRa1BY?=
 =?utf-8?B?RzNubXJGeDR4a01weU5EMHIyM0RkdlNMVGhodEViZXhONmV1MnlVUjl5aEpH?=
 =?utf-8?B?WDdkbUFNNkMwc1dBendXYjVkdW0xYXhhb1NsTjNnYVBSQ2xqU2kvMndBTGtJ?=
 =?utf-8?B?aG1kVkIrc1VXQk1hcjRKdExobDE3dEF6RGZkbkVRa1d0V3hXeW82ajBjOUJq?=
 =?utf-8?B?WUhoMHlNTGVsY0h5ZllsRnZ0Nkl2a0pEbW5TdHd4Y2hoSmJONE9LTGhXa0cy?=
 =?utf-8?B?ckd5aGh0anFGYytJOSt5TElUYVRQOHAyM0tpNkNMakN0TnJ3dnZ3QldOT3lr?=
 =?utf-8?B?V1R6TVZYcml4WXhiVmNvWURvcmM5SE1FL3hRellyV2gvWnU4a3pacFRGZ05Q?=
 =?utf-8?B?K1Vud0s3TGd3QjJ3cjZjZUIxaStPdUt2N3NzQ1N5bEVlaGFJVnVERXVkR21k?=
 =?utf-8?B?UXRncStBRUtJNHRNUXBEbkNBK1NvcjB1bmxFSG9WbjV5UzkydzAxY3hTVHll?=
 =?utf-8?B?L0k0WmY2T1QyeUFuVFRDVUMrdkIrSnU2Nk91bkVwZTZndjNaU1hZTFJYUTdI?=
 =?utf-8?B?S1E5NEY0Q0QyZEhiZWRRTDE2UW9OTWZBUHFVR05zcHV4elA0dFIxejk1dFFs?=
 =?utf-8?B?M3luZ1N1MDBaeDNtU3JJQXlVZ05YajhGSTJ6Tjdnb3dUTk9QUmZORlVBQ0dx?=
 =?utf-8?B?NWh4WllabURDTmQzMmFxV2FNeG92ZlVBWWtSQkpoSkRLZGJvbTJPRFZ4M1RS?=
 =?utf-8?B?V1hiV0lwMVZnK2pIV2RJS3Y3Y1I4VWtjRWtLTEhCTTRNSEJmWXVpMEhtbkpX?=
 =?utf-8?B?aEJyK1AvK1ljak9HWXZDNnN6ckpNbjRkN3JDUWlZcG1hSFhtQ0dPbURiNHpr?=
 =?utf-8?B?UER1RUJ1YTZLdXIwSWtpYTZqeDZadWFnQTBCcXpsR2hoREsvQWJiREh5dTZh?=
 =?utf-8?B?Tlp1bDdxbW9vbWFHWVIxdUNxUko4STBkYm90OEl6YXdtajExbU5TZmNMOHRS?=
 =?utf-8?B?aWN6U3lRV2loN1dBZnZGbENVaUxpd3MzZmltSlczWXkwNkxLT1NnNG5qY0JG?=
 =?utf-8?Q?/9arKoo9cviI64mCW0vZBwUleqp02MLBbkIhA?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aae21ef-ddb7-4418-a711-08de3f3ea4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 20:39:01.9737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6vaRNhj1YYubSZ7eBVwOq4uVvxY1boE8qy6fq2DHZ8ZeWFnxtgqwYxrchjD/ouhFmgya6brPJ5bXak72PoVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6731
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE3MSBTYWx0ZWRfXzwPJOzyOCeo1
 aatqtiGEsOM9rWG4gvZua8GKqU6DcOUqA/1TaGe3Y1PrNmJmXSWW4vUzilHmWidCxaA1WxH/hGg
 5zgTShdGqFpaIxYrBh7XGiMz+gD41ZSNhG1pFDDaTrysAhPd88OTo9SxtlH6il5UNApC578VnBq
 Xhyqy/yjMgirayyhNOeTsyQqtl1Fk0uuY5gbEetZGAIL1Mo3xsXggg3k4+pQdeN2+zHt/TyvqF4
 DJuH89i4HdCeQ3w+bNqDdN7p61PXd/rKVnA5gE30hQ4AtKto2P+cbsufg3vg9O3mo04KpA7ovme
 mlW2ov8vpXxPjR1Pnuff/RSy27iyc60Pdlr32ZHc9XLBOcGwsmQEWw3GoccgkoixN0tLhHBlamH
 3YW8VXxTITNTdn5l0l0KbMNNuHpLUeUkTomFz+idfrTrfEpqEyg1PsVBMrAC8f1imM+YUQiRYE5
 KP35dbZcgQXfA1r14zQ==
X-Authority-Analysis: v=2.4 cv=N50k1m9B c=1 sm=1 tr=0 ts=6945b7e9 cx=c_pps
 a=BFxEMT9/7ApEM+sm6hv7VQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=A2VhLGvBAAAA:20
 a=VnNF1IyMAAAA:8 a=lP65VIVt_Mv_WuJX8QwA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: _SGiNnRp_dbg9llCPJKLGtfy1qbOYp0r
X-Proofpoint-GUID: ryT_VFEhfOzPplqXW-H7kCFjY04YLjgL
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCFF26B101722A46B6375D44DBFA7DE1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_07,2025-12-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2512190171

On Thu, 2025-12-18 at 20:11 -0500, Patrick Donnelly wrote:
> On Thu, Dec 18, 2025 at 2:02=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > On Wed, 2025-12-17 at 22:50 -0500, Patrick Donnelly wrote:
> > > On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
> > > <Slava.Dubeyko@ibm.com> wrote:
> > > >=20
> > > > On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > > > > Hi Slava,
> > > > >=20
> > > > > A few things:
> > > > >=20
> > > > > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
> > > >=20
> > > > Yeah, sure :) My bad.
> > > >=20
> > > > > * The comment "name for "old" CephFS file systems," appears twice.
> > > > > Probably only necessary in the header.
> > > >=20
> > > > Makes sense.
> > > >=20
> > > > > * You also need to update ceph_mds_auth_match to call
> > > > > namespace_equals.
> > > > >=20
> > > >=20
> > > > Do you mean this code [1]?
> > >=20
> > > Yes, that's it.
> > >=20
> > > > >  Suggest documenting (in the man page) that
> > > > > mds_namespace mntopt can be "*" now.
> > > > >=20
> > > >=20
> > > > Agreed. Which man page do you mean? Because 'man mount' contains no=
 info about
> > > > Ceph. And it is my worry that we have nothing there. We should do s=
omething
> > > > about it. Do I miss something here?
> > >=20
> > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b=
0c41e/doc/man/8/mount.ceph.rst =20
> > >=20
> > > ^ that file. (There may be others but I think that's the main one
> > > users look at.)
> >=20
> > So, should we consider to add CephFS mount options' details into
> > man page for generic mount command?
>=20
> For the generic mount command? No, only in mount.ceph(8).
>=20

I meant that, currently, we have no information about CephFS mount options =
in
man page for generic mount command. From my point of view, it makes sense to
have some explanation of CephFS mount options there. So, I see the point to=
 send
a patch for adding the explanation of CephFS mount options into man page of
generic mount command. As a result, we will have brief information in man p=
age
for generic mount command and detailed explanation in mount.ceph(8). How do=
 you
feel about it?

Thanks,
Slava.

