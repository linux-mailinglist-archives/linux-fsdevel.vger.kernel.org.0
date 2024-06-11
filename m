Return-Path: <linux-fsdevel+bounces-21399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E9903867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D441F26490
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA3178CCA;
	Tue, 11 Jun 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EqewTNnn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mJsyujlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBFE57E;
	Tue, 11 Jun 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100545; cv=fail; b=S17UOnZjbpOeynHM/B8PZpCdVSXX3a3ozBop7kGkJdgyM5b4DYfSD+QhrXwc0ulDnrGTvlSw2/LHRFmU/mu7Odw5w91gFjuTbI39K+4DFt6Qb1b1J87HzwjLAs5XF8VzjSONGoqbnBAm6sxHr2W/NoV9xG2cRsT0uyRhoqGa+88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100545; c=relaxed/simple;
	bh=tluvzW4dyt3MbXTLZdeGhRxJI40VhOGfi6kdW6+7EA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVTpg25q7t/6TqhnnTqJXeAinHfdbSxaP95FuisMN3GInA/FmVoFce1pSuJzeZ7FD10W1LSsruJS+Qc7DzzrF0QmKYk/XBw9se9KiuDEF6hbWmEO0gjUxQr0kVUIBr+8brJ0GJlipqQ2tycCRc3LnOmXUKd4TlPG4GvhaUk2xTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EqewTNnn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mJsyujlb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fO9X026892;
	Tue, 11 Jun 2024 10:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kiyMn9uueDZZj5IrlDKCyU7iKHQXHPSlaR5VX15MNtM=; b=
	EqewTNnntd6yczcR6W4/oFWmd+iMF1Jn4WY4qk8vJwCsdyB9evyc0lM4bxniB/gp
	tugj9JIeN8d4LdfcfLUEmhKpgMFIFWne5kZJJ1oFYtaMP5SXtjFQaELtWENMoV4f
	wbqhixgUsFY9hBjZmssdABFG0gC6HCFY1VxGPDLqMFpfs0JtVORTgRlxhsntXRY1
	q42OQdmBGG29VdZsyjElQQ88bMW2AXa+L7PgEQ8vfnBDnlcs275bZaMkici/MIqo
	JBOUNYMl5OkwOH27hZ0FONIVlXyE2rGp+qRvWxDkmoHMqtzb3xjoY9aXeBlaukih
	2amGLvfbgdt7UKUkt+3qeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1gcj2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:08:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B8AEDH014236;
	Tue, 11 Jun 2024 10:08:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncetqnp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzCuA+gmaFOAkGW7GGnoXODbVExfie8Rvr66qhrwPUxGidQgB2SmBhd0M+/Yi3egpmgPDXFibeDo8CZY8LizuUEMYKs9aS0+VtJDdz44ZnBqL0ySp2BXJdS5Kd9MqoCuqVqs0bZZSadpinATBU6K7c7ELpT8ie/aH4nR4Upk1qnob8tWwrN1i0yy+Euf/7+Zo+/UiRmePaEzQE0h7AhHnOd9BMRfz9DVLIBq70KQkrXUDrbblIzuex/Ln1BvjGb4ekDjCdbKeDs+fNDmAMNaYctuHmBbdklgrmps1ogBAQ9W3iidOAsHmqPPL24+dLi3O7GD1QwLBLi5R1SP7cDoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiyMn9uueDZZj5IrlDKCyU7iKHQXHPSlaR5VX15MNtM=;
 b=AhNT6/ETfn5kTjuO6x17FPH8wUVdfgp9sLcFgvgqIvDBNZbrSW4NqZqhZObTsbpdUzr4TPnYV0QcBdFE+6NmEAvfK+AfylVTSjtIiq3QVDzScd1jgcSNcGaTMd9QmraJBLEzAIZuLA4vWuZQYmA8l4elIA5mV8iRAHGCpbtD2Yn4qar+3YJjxbuZeOj8mYlcpZl2/9EOZ7+qICrJ+wjxWeU1e1Umd3bv16CBMl0MC2y7PIG9cPILWecgz+08HEfLHPtYPthYoJglzST9wQQReMvYk47cPt51eTDtiddJAMLxT13B+bcZ9c3D7ajYlBbz/ltD2Jo2jCKVXMdyYC8ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiyMn9uueDZZj5IrlDKCyU7iKHQXHPSlaR5VX15MNtM=;
 b=mJsyujlbytQ3VdbE7IvKaoJs01jixX6r14ll+BfUPgyByoi/zegsxMHvr9pHUILi2c/UCIIiQQpxzfLIj0SdRPqmA1v/nGfSxN9zcGh74Bh0K6LsO+++wSL+ZF9/eAlqY8MNlV5/yHZUQRvk/hJcEdfGRNTSHJNQx6SyVKsm3iQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 10:08:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 10:08:20 +0000
Message-ID: <4c6da37f-c5ea-4008-8250-a75f3b65427e@oracle.com>
Date: Tue, 11 Jun 2024 11:08:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/22] xfs: Unmap blocks according to forcealign
To: dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com, axboe@kernel.dk,
        tytso@mit.edu, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de, djwong@kernel.org
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-14-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240607143919.2622319-14-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: af32a3c1-9c48-40ef-826f-08dc89fe6b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z1ByL2pkU0JkV2FOa2ZaeTBmcTIvZjQvNFpPWUovd1hucFRiY3preGQvQnRv?=
 =?utf-8?B?RVJTVDB1Tkt2OXhER1BneVhybUk5NHo1MHdWUmE3cFU3NVpmSjdXN0JkKzd4?=
 =?utf-8?B?bkFNc2YwYkVRRDJtalVhRjk2NENZRk5SZWorNUpZSGFKb3VLWVlweVRiODVK?=
 =?utf-8?B?eEJlR1lBNktwR1M2cWNMenpsSDZQRUZYcldkWElBc290c2lUNDNrVGdKa0di?=
 =?utf-8?B?azJBekd0OGlQVjN2b29FanhMYjVPSzdCcHVVdVorQWFxd1ZoODhUazloUk5u?=
 =?utf-8?B?RHlZbysvbWVWVG92bnZoeHBoSnJ2a3E2bHVzc3JPRVpxcGhRZmZnOEViSFJv?=
 =?utf-8?B?SWNwbHhRZG9kZjNkZE5ESVJta05NLzNOYU9pbU1uTW92L0ZDdzF1UWZrWmxv?=
 =?utf-8?B?U1Z5OXFUektTRTZCcU50NFBYMUtXaWt1UG9lbHA4Mm1RcGo3N3BPcEU2M3Ru?=
 =?utf-8?B?cFhqTDVSMVhPWkRNcGM1QXNMTVRIYmF3R053QWtiNkVEaFVOa0d5Nkxid3Jh?=
 =?utf-8?B?c2JHUStBQ254blh2dlV4VTVVbnN4RWJFZ2VRdFkzbmlSUVpIR2NIK0xraHYx?=
 =?utf-8?B?ZW9XNmptTklrZFYySi9GbEQyalkxVWxsc3o4MklWVnRaZ21GNWZSZUp3S2sy?=
 =?utf-8?B?RXZjaG0zNWs0UHd3Wk9QTWxpNmszUjdZSkp6QW40cG5yUFV5QUd2MUU5Ujhi?=
 =?utf-8?B?K09yOGtsOFZ1d0xHc1cwVGJNcUJJV2VtMTZaMUI4SzRSWkFMekxYc2N6UEd0?=
 =?utf-8?B?YklDUHVtN2RKYWhvOGg1aDc3RTI4dURkYysydTJHbUdKbWs3eXhUTjFsdktt?=
 =?utf-8?B?MTk4T1FVMHBPYkhzV1JHTFkwVnI5dCsxT05rWVlpaVpEWXBKMnIwcTNMUXFa?=
 =?utf-8?B?ekxWRklxN1JvemVQVzl1dFkxQmlQNHNQNjBrdkMxbDRxT2xjTEE5S0NsdUVo?=
 =?utf-8?B?c1JsdTMrMDQvcHdhaEhuNkhDMnd2bHBRbWpjdjEvY01IeE1MUEFpVlkvTllv?=
 =?utf-8?B?SWRsR0E2NmxXRktyM080NmI4bWhOY0pydFB4SnprZnJHd0xxa1lGMm1Kc3Ew?=
 =?utf-8?B?NGUwdUp3b3JmTmxvN0xRRFlzOGJTUDFnUUJ2WFgrUFBKRUFadENsWENPTnFI?=
 =?utf-8?B?aTJlczBNZUY0NjdkODY4R1Y0SE1oUUZ1REQ1Y2xoK29oajFoR2xxdHVrRm9V?=
 =?utf-8?B?K3ZSRFlJTXdkSEo1RXFhVmh3UnBMTnc2dVc5R25xb2l2THFtdEJXMmhZMENx?=
 =?utf-8?B?Q0lwaFVEMTU5SXErT0IzRnRxV3NqTERwK3JyM1lYaVdkeVpJdVQrV1JoSGdG?=
 =?utf-8?B?bnJsTHBpdEMyWTZxcmJibjBRWEFxVU1kdTN5QzZmV3poNlNadjRXb3VSVXNa?=
 =?utf-8?B?Y1BiT1dlbWFUN3BNeUwrV2NxdFR6UFpGbTEzWkNTajVCdFg0bFJ3bWZEanZv?=
 =?utf-8?B?THBaVTVYN1NzZmsrOW9zcUNrWkl6WG1MQ25mZVlSNE5EcnFWamdLYmtvR3Nt?=
 =?utf-8?B?VFJXS0dqTDQ4ZDZVaWZKTDMyc3BSUGM1QVRmOTBsNVpORnR3U08zTXpSNGxJ?=
 =?utf-8?B?b2syTzk1VjVncExCaEdSVVJpT3pCS2RURmp6SXBidkx0dFhiQVE0UmxCWWEr?=
 =?utf-8?B?bHBKN2s1bDJoSEFFblZMbUhWQmVnM0JTdGw1Tk1CTnh3Z3dQUVBxaEIxRmdt?=
 =?utf-8?B?by83a1pxYm9iNjZJdTN4d09PeE8wMWhjSUliOWlqa0lvdGZnRkNLRVNMUjdo?=
 =?utf-8?Q?b7N9GpkmgKDWNevej8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1pjMzkxR2dnUHlzS2R4bFlVdFFUSEdkNy93NlBWeVBaREcrWEhxdWxsSThN?=
 =?utf-8?B?T3dmSXpvVWdGSGNQbzZFVlBLazJUMVpMOWNwMk15NEJGQ0FVc2JIVHQrMWhB?=
 =?utf-8?B?QUJSd3FTMXQ5aHdHb211MTU0MVJlMUhkY1VudlgrWkRJZ2dOZWE1VkxaTnoy?=
 =?utf-8?B?ZFViYWhReEo5NEJ5OEtrMmMxRlJad3pUTGFLZUU4WXhic0RGWFM5SHNzMHFN?=
 =?utf-8?B?VG1QcE5VV0xHV3IySzJKZnMrV2c2azJzbWxRams0SjlWVklLUDhXMDFqazFV?=
 =?utf-8?B?Y2xHTGJTTUI3dVZ1czdneDBJWmorSk0xVXAwKzNZK2crQVJ2aFhVYzhCK3ZT?=
 =?utf-8?B?QVNLVVB3QmZXcEJpNnNmbUNraEg0cGZJREkyZ3JVY0FZQmFYNEZ4VFJ0R3Mv?=
 =?utf-8?B?d1BSZjlvOEUva2hPVVRGYlUrQ2NPOUNTTzFsM1N6TVRNdThLam92aFhHMEsr?=
 =?utf-8?B?dlhEUEZQQm9FOU9hSHBjajhvT2JDL2RLeGczQ3U1enQrY1puaVFQeVZ3eEpJ?=
 =?utf-8?B?YjlJVDNraVorNEhPQjFLNUdERHhRbFd2RHFjR0NJeWwzbUdrY3V4bW8wK0Vz?=
 =?utf-8?B?ZWx1dGxRNitmNlJ3ekZMaUNTRlR4dkUyM09WcENFU2lRY3p6TURBUmFhMkpt?=
 =?utf-8?B?SEhnKy9kRmNPdGc5TzdPSEFlTFlpUEpSU25VRVB3dmgxRmIxQTNZVDNMUmRj?=
 =?utf-8?B?YzZaT2VtTEdkUlVhZDljUzM4cFdDOFhtUWxPMk5RcHZvVjFuWWdZeHdXUS9C?=
 =?utf-8?B?cTl5d2lja3N6c1dhbG9hRjRZMnE4ckI3M013VGpVa2x5SGhjeXA4NEdHNS84?=
 =?utf-8?B?NW1wd1lOVFBqRGFidHBSek9obkw1T05hN2F2Q2hsRCt1TDMxWHhvWmp0S2dG?=
 =?utf-8?B?UDZiOVBWWXZCR3RUTVhuYUYwb01iTllHNm9pYnBhYkc2bUwrSlVYVW1lckRM?=
 =?utf-8?B?WVo4ek5pc0FDK0QrV2drTXB4alE5VzF1WUY2bzhMVkt0ajZyMitrNSs0UVRR?=
 =?utf-8?B?SCtWNUZQdEg0UDBWaDNCNU5TMCsxNzY2SE5PMEp4aEV4bis5UWt6Q3NTeGhp?=
 =?utf-8?B?Tlo1UURlOVd2V0h2TFhGd2svb1NSUVhUMmF4Wm4wdjJNZ2U3K29nMnlpYWRX?=
 =?utf-8?B?ditVbEFYNTlMNHREVTMxNlVRZENwMHQwTW9lOGFwZno2WVlOMk1SU2tTaXNh?=
 =?utf-8?B?NkFZUUpob2YwMGlPaDJrd2VIZnRDUWdNNVI0by9IbGdYWHpYKzVOWWFSVEV5?=
 =?utf-8?B?dUMrRTVFUE0wM1d5a0xRUVBwTC9aRWZXVXlCWHdGbzlzUHJacXNVb1R3NUph?=
 =?utf-8?B?S0hEZ0doTXg0aEtJd1pHZk90Rm9vOSt3U29OQVl2S3UwcnE3TlZUSzNKSFZV?=
 =?utf-8?B?YWhpd3ppSEhMa0w0RkJvUEdTa0lGR0NOMlJaQStnR21abzBONXl3akozWTBZ?=
 =?utf-8?B?Yzhyai9pcFVUYWRlMS9kSGtLckUrbHd0R2VrSWhzVHVNVW80YnFpc0o1RmQy?=
 =?utf-8?B?cEtVYVNtd1pJaFNGd0NoSy9hbGptZmtaVTFZOGJuTGNzdVlhMmpPWkZOdGRu?=
 =?utf-8?B?UFdDN3J2MjZIOUZ1OFV4czI0WWd4UTFWOVNhM1drY1J4ZEgrZmFnc1lldms5?=
 =?utf-8?B?OHhxaDkzSlhXc2QrSVRLMjNnUkp3a2RHZzVkZXY3MmxlZGI3OHEya24yRnFs?=
 =?utf-8?B?eFN6R1FTZFJLQ2FkNHZTcnlGem5QZ0U0R2ovbXdTWmZManZwYytSTlpLbHJv?=
 =?utf-8?B?TDdQMXhYTktXK3dSNW1UQm41dEE1YmNwRSs0WVIvV1ZmT09qUnR6djQ4T3FY?=
 =?utf-8?B?eHEzNjN0T3R0OHNjekZuT1VoM0ZsbW44NXQ0Tm5MM1V3Z2YvSTBZcitKVjVL?=
 =?utf-8?B?bndmWXVKejhTVHpwUTZTYXk4b0xmMHZVQ1liak1NK2xsYUNZNFNuM040MVdi?=
 =?utf-8?B?TjFIektHc3FNNEhNQXZtZ0pIYXcveEpvNzdYMGhBMU9XUkp2aEMxcFVkV3dN?=
 =?utf-8?B?Y3phUTBQczVEb0RZU1N5Rmtya3FaUllWeTNONVZVWDNVekJsQ2lva1pIZDhD?=
 =?utf-8?B?Q1p5dWp2ZU8xNDFxaWxvK29xa2NuZy95VW16a014SUUvUXh5TXlXS2k0WWQ4?=
 =?utf-8?B?NC9CSXI0SjU2Z0paQkkxQVVFTGFhRWRNVzJFSTRkWGIzbFFLdkpQVjJqVzB6?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PHIR7+kDiBA/C3E0yiqDs+3lmLGFVtYuBWX8m1ApbHT12IDWOmtt7xzFh1ZSVOF9gzFyJ17Rq2qN8w+URYiigj55f5eELp+7AjN6VBHoLq0Al4z9WchCz5dio2z6nllOKsPvgh8BZMhlrZ3RwdLXd+Tq50QguPLZc1RiljkRnFNbdtB42r4BfmVr1OFw1mGvc0L9QpMu5Zc/r8WUpg62fFJ8xSUw7rlaFF/eGwql3eKyt7WBJgoB9ZzKgMfGhWyehPoQXyeI1wob8ce/lYh5GxAoc0iF3Q4LHUI+k8ZlYvqV4IJux0mJkQOjY6vogomyjz+3zHEqtcCJ0245rE01y+/dzPJQn79TrpJCvl2veE3SexVn9Y7rBwgCT813hnSrApwoFePLTCpdaS6JqyyOk5Ee92V+iIZXMFVk83YEtVT4fGkaEiVOZPlgQPQO5DH+k3YZTnezZBr8qEnhoGKLgOxxU1GNwV67YT+PSAs1fzupswMDRllHfexwlKhqQkvHGic818+q4E7Md4uONIH3Bs7dv75pGSYnqQd9EuzcdZPF54O09DRS3GzGRpy7NXOhlVkjEUhCcfCDn4Grq963gqtmKrfz+qSdh6Elw0iqW20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af32a3c1-9c48-40ef-826f-08dc89fe6b9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 10:08:20.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9qaB3a67xwsxLy4yGn0n6oXZExP4sH+tpqTWM7bcPSq8i/YTWFwbpcnG2vUvNaGijF1KdvIrvbHANgNRU1Llw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110076
X-Proofpoint-ORIG-GUID: xQLl-Z5qdh4yrA8fvoEXImeQHFLOy4gr
X-Proofpoint-GUID: xQLl-Z5qdh4yrA8fvoEXImeQHFLOy4gr

On 07/06/2024 15:39, John Garry wrote:
> For when forcealign is enabled, blocks in an inode need to be unmapped
> according to extent alignment, like what is already done for rtvol.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_bmap.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index c9cf138e13c4..2b6d5ebd8b4f 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5380,6 +5380,20 @@ xfs_bmap_del_extent_real(
>   	return 0;
>   }
>   
> +static xfs_extlen_t
> +xfs_bunmapi_align(
> +	struct xfs_inode	*ip,
> +	xfs_fsblock_t		bno)
> +{
> +	if (xfs_inode_has_forcealign(ip)) {
> +		if (is_power_of_2(ip->i_extsize))
> +			return bno & (ip->i_extsize - 1);
> +		return do_div(bno, ip->i_extsize);
> +	}
> +	ASSERT(XFS_IS_REALTIME_INODE(ip));
> +	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> +}

This following updated version of xfs_bunmapi_align() seems to fix the 
issue reported in 
https://lore.kernel.org/linux-xfs/d96c6e91-44f0-41c5-bebc-a092dc8a8406@oracle.com/

static xfs_extlen_t
xfs_bunmapi_align(
         struct xfs_inode        *ip,
         xfs_fsblock_t           fsbno)
{
         if (xfs_inode_has_forcealign(ip)) {
                 struct xfs_mount        *mp = ip->i_mount;
                 xfs_agblock_t           agbno = XFS_FSB_TO_AGBNO(mp, 
fsbno);

                 if (is_power_of_2(ip->i_extsize))
                         return agbno & (ip->i_extsize - 1);
                 return do_div(agbno, ip->i_extsize);
         }
         ASSERT(XFS_IS_REALTIME_INODE(ip));
         return xfs_rtb_to_rtxoff(ip->i_mount, fsbno);
}


> +
>   /*
>    * Unmap (remove) blocks from a file.
>    * If nexts is nonzero then the number of extents to remove is limited to
> @@ -5402,6 +5416,7 @@ __xfs_bunmapi(
>   	struct xfs_bmbt_irec	got;		/* current extent record */
>   	struct xfs_ifork	*ifp;		/* inode fork pointer */
>   	int			isrt;		/* freeing in rt area */
> +	int			isforcealign;	/* freeing for inode with forcealign */
>   	int			logflags;	/* transaction logging flags */
>   	xfs_extlen_t		mod;		/* rt extent offset */
>   	struct xfs_mount	*mp = ip->i_mount;
> @@ -5439,6 +5454,8 @@ __xfs_bunmapi(
>   	}
>   	XFS_STATS_INC(mp, xs_blk_unmap);
>   	isrt = xfs_ifork_is_realtime(ip, whichfork);
> +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
> +			xfs_inode_has_forcealign(ip);
>   	end = start + len;
>   
>   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
> @@ -5490,11 +5507,10 @@ __xfs_bunmapi(
>   		if (del.br_startoff + del.br_blockcount > end + 1)
>   			del.br_blockcount = end + 1 - del.br_startoff;
>   
> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>   			goto delete;
>   
> -		mod = xfs_rtb_to_rtxoff(mp,
> -				del.br_startblock + del.br_blockcount);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
>   		if (mod) {
>   			/*
>   			 * Realtime extent not lined up at the end.
> @@ -5542,9 +5558,16 @@ __xfs_bunmapi(
>   			goto nodelete;
>   		}
>   
> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock);
>   		if (mod) {
> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
> +			xfs_extlen_t off;
> +
> +			if (isforcealign) {
> +				off = ip->i_extsize - mod;
> +			} else {
> +				ASSERT(isrt);
> +				off = mp->m_sb.sb_rextsize - mod;
> +			}
>   
>   			/*
>   			 * Realtime extent is lined up at the end but not


