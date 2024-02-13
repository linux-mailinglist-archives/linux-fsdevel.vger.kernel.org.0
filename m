Return-Path: <linux-fsdevel+bounces-11324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31715852ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBED284912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E71B273;
	Tue, 13 Feb 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRFemJDw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iT935t+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4D18AE8;
	Tue, 13 Feb 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812221; cv=fail; b=Rkh/272/dCjR5E4Sau12zjjVfJVK44To8QLeRmkfF74TGa551GXF2opMNVPDmBFNA5j2N//3L4AExLpBGmNXCryVUI9WXKV0BKppu1nKw69K1QKUd/GuUUBzGoN1YWuS+ZFfnRs6M0hpxbDeVtmNuHCnxaUz++cTO9lf8ew17Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812221; c=relaxed/simple;
	bh=/fBIoRTliIQOZq2rQkAMB2420CM008MqbeZD8UoIDS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMnrvoH/QR7mynIVBXvzLzB7wRF4tpUFR47MeOzzMx6jDtksmk7/ptWlcDwcZ4mVz1x291vPBeWhjvq3YxM/J4b8oBxCtZp8SikGYiyyAR088FFQ7q4a5iJmBPoxu9BQbdmRt9cM6oneVOLaJ+d8f4NyhSycXyEp2APHLPtF9YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mRFemJDw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iT935t+w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8FBPV005055;
	Tue, 13 Feb 2024 08:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lBsf0XLdvfcxpX/auq/MCMLgE/4dxhGz0H7PKIb4jbc=;
 b=mRFemJDwRscSkI0uMZ94AfZJeBJPNsUdwFBVv7jjkWUNxKqjQUcbYYtTjBFDuvlPW2f0
 1QEioQNMua4sqJWIDSaFEiM3ZxFHW0fR2VytuJcVRAGoTpxHghQ5sks69RBCvO+sl4vd
 LcldBCiiZbcC1OSKGwcniEJ29LF4MAH4c9JysNUrcnGxks07c3BV/cpH2gKO8Te2KBgX
 x+st1rHTXt+7o/N3nur09a4xKtoPlkak2Odu3DlsAlpfF3kxsIRagYt0xAQ0S3C5/Cmq
 HK9vzxUfQRwvSv29ZyElov8+MzyEOz1PPkbXgIj6j2EuJSCqaHYxcrGuN1Rq5d5KEey7 SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w84r7r049-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:16:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8COss031321;
	Tue, 13 Feb 2024 08:16:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6yjst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgCUq9aCPILuHkQn/scu22BI/mc46AndOc3vOQ6SgV+cipwMLfybGDAANUX/btDKWr5+njv6TU4y/j6xEcca+0SAeoKHkwnnI6XCRY2gZKQtCsu8KOqD8JoMe6bZHRldi7q3vuGiD5TQfsxa0DJAm7/hqrTPdOUcvueENj2MZ2NR3j8Bw1de3i+GOVFXWMFWbgP2oftvCP5S85bNlSJGx6f3DBl0O5gL3bIqNI7tbMeSplf4sw5OWt3IXow9X5J/qUuT0TMrEeS8NRrNoQ+Jww6OP0uCmcEY7ny5ZMWaeLcPTQUvhpAlUuBzkQKiqQeQCa2mObeEs/W3fyByxAfStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBsf0XLdvfcxpX/auq/MCMLgE/4dxhGz0H7PKIb4jbc=;
 b=cerJZ2zTex1hFBbJVnbdXlCYqvrC9bl+2psCRtk+L+AfSO/zEBQ3UtLNhIJ7x2Qp7iCmg6TOGjUAEqAqUPH8ifasYeP8+Yg09d/KfyVIGkolwlpJdDeO50XkHWtfB8dyZhDs1H7Y+VPBMowt012/LVFwyD3uhmfKRDSs5Geoeq6c0AS034EVKLLE4pYWYkcCyP9yhTHuiA9VxkIglHvDbv9VHBX3JnILgugY2IEnXD2/XRLPT0WYmQcIDqG3ECjQ6v2TtS8XIEXkCTHv24BaxqMk6I1nXuM+ABAorvA6GHuZNHv0fmWWSaMBmnFwQIf9zE36/bu0iTLAmg9RDwp5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBsf0XLdvfcxpX/auq/MCMLgE/4dxhGz0H7PKIb4jbc=;
 b=iT935t+wAwNMYWQOyqCmwyEQ3AAw/fjXtbz3dI8rDk32f/sc06958N0bOFHPQK4bny7njU+1uokp8zzDgKdLD+RjplxsuCGj1lEwS3P+w4BTvWnt+2KlLVe/Ju5RfRHvSPU8MsP22sZsWy61yfoeiPBHzQPDOoh9xrPAxbXBBZ4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 08:16:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:16:36 +0000
Message-ID: <03770f22-02ea-43bf-952b-4a4097c62b3d@oracle.com>
Date: Tue, 13 Feb 2024 08:16:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] scsi: sd: Support reading atomic write
 properties from block limits VPD
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-12-john.g.garry@oracle.com>
 <20240213063139.GA23305@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213063139.GA23305@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0154.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfaf224-5e26-4013-dcad-08dc2c6c186f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vr1adsWwcXmhQxj7nEjEG3cMnsALdjtVny/phApWFBJT45/JMXS3rwN0Cotr8JYAJQMfPr5MUxMHDBfxVU62COLslhb6s44XtYsmzog0NY4oXKn4aPsnep8rus3MEmpR+INexIhs1asyfMXGKdmzqDjPDS2LTrl98sGN4AfSU7HgDtfxNgHoWnro7xQzNebcdhOeqyK4YobfQrj8oV/RDH3Ut3eHhjOlcAJ6s88e5yQQaoKxWGtgrXBDKIjb6o21VksIp3lj0LV9sIjEs1ZAavljZ/UTrucWI+zsAGkmkTjNxqd+xcME1SxgpFbv5Y/cCHMFWe4ois7k4XzF1w4K0k4s7WGUfwUup8OSPcw14SjRdlXTVhN2K05jMGUAhVVKWBAu6KphU2RMjLq7tZHUHkuhtknlOmhfqCoq6ZVkZIFYBYODLopS+ZhYwBethFeRRlAd3wsyp6WygBd+4Mjq8ZnXggca9H6VOt4MaFmmf6t1yT5K3e0o/76D/zjRiNo4wYYkzHFpCinkiuXRAvhXMbSdz3gqhX8CKXzbFm8oGjnaCrTGsBN+Gbj00Xyh0h3B
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(4744005)(66556008)(66476007)(6916009)(316002)(66946007)(7416002)(6486002)(478600001)(2906002)(6506007)(5660300002)(4326008)(8676002)(8936002)(31696002)(2616005)(83380400001)(36916002)(26005)(53546011)(6512007)(38100700002)(6666004)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TC93a2NSZytpemFzZ0F0QmNDQmEwbjAxYkI2Vk01clFQSHVQN2xPUVg3dGxx?=
 =?utf-8?B?c0NuVVRuSlNZY0pTRloxYmFrRjFJcUc1bjlmajlnRkc2Zlp6a21FTVhXejU3?=
 =?utf-8?B?ZXdYUXhQdmYxTElQNTZvMXRjSkFnSjJ5VmhVQWlDUVNjSW9aNVRSSG1acVcw?=
 =?utf-8?B?c01nbXdxaE9KUTduVGtVSWphK2xHRTcwaFpZTXNHYU5wRVoyU2tNc0JhdS9u?=
 =?utf-8?B?MW1wM3FXUmdveTYwSTZwZjZzSzhTN2pVYlJweXFGaE9YMzNtaXNLQ3VBOHpL?=
 =?utf-8?B?T1UzTkFkWTEzYklGMHJad0ZER3dvdGVnbW9vcFN3Rm5DeWZXRTQzaURIYUJU?=
 =?utf-8?B?TW5xMVAzT1FhYWZVamV1Q252VDRvbnMxZmQ2RXdYckNYNjl2UmQxM1lKRm1R?=
 =?utf-8?B?VjBndzlINFoxci9OUlI3dFNBRnBieFJuejc2Z3VYOEVGanV3ZHg2eG5ZNUFj?=
 =?utf-8?B?N202ZUZSM3N0L3lydUU0bUxZVDdvK21oZ09Tdk5sTm92UzRZQWkySTkxNTJL?=
 =?utf-8?B?cmV1dHJNYmREMWZ1RW5OWHBpQ3Y1ejMyUjc1MjZpQkU2V1N5dHZ4SHVlVEVk?=
 =?utf-8?B?cExhSXhiNHNvcExOR2RrWmhwTEowSjJUSW1XdzMra2ZEcmlkSG1zS1hONVRC?=
 =?utf-8?B?aVJLRlA0MzNCN2hrNWlSdVpyV1J2Y294eDk5dnluNyt5aUdqbEpLSjh6NEs3?=
 =?utf-8?B?VmhpU2lJei9NWm13WnBrMmNmTlVlaWh5cmtacS9mR3hvdk10eFoxYlRGdjVM?=
 =?utf-8?B?dG01cUx3anc2b2Flc0FGQlpkQjhqVkJZQnRmNmVVK1VhTk95eDhNd0JMSjBL?=
 =?utf-8?B?UWJLTWZFMFIzbVFwSHpzem5obWF6WnJMN0xJemVOSG1iNkwySms1QnlMcXhn?=
 =?utf-8?B?OHVGTVJKNzBFV2RjOVlTNUlOanB2YnBXUkNmbmFxT2JTK2pjNFFyb0w1eFZP?=
 =?utf-8?B?QU9UanMxOFk0RHZrQ0M1OTg0OTNCRFQzOU9ZSzVSTWl6bi9LeGJrbHFUbGNW?=
 =?utf-8?B?Wm44SzJBTmVpMFZNT05PTjJzYVgxbG0wYnBpS3pWbGlIOGpRWTB2SWJ5NG41?=
 =?utf-8?B?b0pRQWdHVjZ4NVVIbUhlcEtNa3Q4cHRBNm1XVU4rZnk4N2JkQ1MyR2NmOWh4?=
 =?utf-8?B?eDkyT09sMEt0RlhVWFB6N21RcG04aEFNZitMUmRlQnpFR1piYnFlaEprcUl1?=
 =?utf-8?B?Zkl0Z2ZRZjhJNVFkWnU4Vm5VY3prdFQ1ZFR5VGF4UnZHQ2FNNzdOZGNrak1B?=
 =?utf-8?B?TGswaWxrWHBPeGMrTnM3OVVKQnVqVDJHbHJ3MFFaOXF0ZEpTYWZFM2lRL0h6?=
 =?utf-8?B?N1M3U2s2UnZPdkgxN2tHOVZ1YU5PT3dXVjloRnRqN0JIeGVJMVFwcitxc0JI?=
 =?utf-8?B?SEM4MHJxMWtUd0hvbzljR0psMEEzcHl2ejd6WmR6UVFuNDVINE5uS2JZL3RQ?=
 =?utf-8?B?bHVjbVRsRGxLYWVKSVBUSSs3UFJwWldYZzFqTVhwbmczcFF5b1JQRjFodnNU?=
 =?utf-8?B?bWE4U3ZkUEFIdnlqMGxFNmpXbitNTWR2V3c4cExkWnJtbHNFU1BwbUgycmE5?=
 =?utf-8?B?V05ZRDBBMDU5U1JIWTRUYk5lbE9oSmw5Q0kxeGpuSXlEdi8rZXhJbENaaXNl?=
 =?utf-8?B?YnpKYjQvZVl5cHRObEwwSXNZUkNyQkN1dnpjSHY3UnIxNHNuZ2JpenpuQmVE?=
 =?utf-8?B?V0NEZGNkeDQ3S0R3SWZ1bDNnTXRYUTN0elhlNldXMUZkaXM5UHFsR042c0Zw?=
 =?utf-8?B?d2N1bytudzhBYWtVT1I3STRGalJxOTNkU24yemFtZ3YxSHg1OVdjcHc1QUgv?=
 =?utf-8?B?TmhEcUR4ZXVxblFTRUQ1eUVOQmg1Z3BzWS8wV1FtR21EVVZuVmJRREU2WG1X?=
 =?utf-8?B?SjQxdW90VCtlaXNaZ3dHTmlCVXFEOG5aRTEyT2xOcDlFR2NXMUplSE40bUp0?=
 =?utf-8?B?aGRYYTB4eHZyc0NaVVlaOTZqNHkxR2NWMzkrcU5JZmh0Z0N5eVFKQ2UxTnBD?=
 =?utf-8?B?ZS9tUER0dStZcVRTYUdYOEtRYThDTWRYaWRxT0laZnBaNmJNZlVtWEpDQkNp?=
 =?utf-8?B?aXJLenFRRG9OUm1uTzF4cmlrVUE0aW5uL0FadlV6a1hKdmVQOGJGNVIyVXk2?=
 =?utf-8?Q?gc8aG4/PNWsUv4mV7gbQhauus?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q+SVHmoZV2XaXDt7qntc6bDtSymquGJW6zTcSSb/kfHEu8yJ7MvgTTbrhaMJugOnTzjaa4weYtEVbLUhejjxjksGEeSK2iVOymiDEIrb0+gCCmanZSu42+gAmnADUcX4MmJJGJz0dg6WSCSqa4luRPqI6UVADD5BEA5Jb4EpuvnRqOFbBEs/AA67zm1C3r5DOvyXPz9JEVT94NESNE9Bx+pNJN3W5ocUzJgliFQIYXON7x0qb1CU3gDbEqTfurpABu79lSF5xclJmnb7t/fNMN3KePBZ6LtWj4NSAysEKmyD2NzdMwWK07wNKmnhJPHBstoIzwE7kUOZGQ/PmVFT8+C3Mc5GQ82cF9YD2AdYobp/MZteSfLpQzje0UUZ7Yf6pgQ6p2LUqene1mT1CnL5uXmIphLSyxoa9LcVflW20IybNbuz9GOP2vIGMVeu3MkSqiVT2oz5QcYYpNVzVytSsSha7RLLTndVeGaAPGT8MZz63Zl9baMwamFej7g3JdA6VhPMq8CIevXAPn7fjyIrFY8KCq5D480pjiTl37eQAXp5hoZg3SZvW18XAIHVf7eQJBDCWfbGMAQYzEZ43s/BfSQ4KSzPG3FCaKpubILrxYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfaf224-5e26-4013-dcad-08dc2c6c186f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:16:35.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d07L+mKmEsYjRi2rNTBH1ZUkCnHQm6WX++a55xSisJDlYAaLWceftwu7SPJQlpPs9FKydjDMuFhokWK0LhDIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=797 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130063
X-Proofpoint-ORIG-GUID: 1qZO3Bb06jbUBYkieYT9Ad9yCSmySX8F
X-Proofpoint-GUID: 1qZO3Bb06jbUBYkieYT9Ad9yCSmySX8F

On 13/02/2024 06:31, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 11:38:37AM +0000, John Garry wrote:
>> Also update block layer request queue sysfs properties.
>>
>> See sbc4r22 section 6.6.4 - Block limits VPD page.
> Not the most useful commit log..
> 
> Can you merge this with the next patch and write a detailed commit
> log how atomic writes map to SBC features and what limitations
> Linux atomic writes on Linux have?


Will do

Thanks,
John

