Return-Path: <linux-fsdevel+bounces-32874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4A9AFF57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDBA1F21546
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303411DBB24;
	Fri, 25 Oct 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e59WWVIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FxDg2LdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351C1D4359;
	Fri, 25 Oct 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850420; cv=fail; b=YclmLSQ1fMDnA/DL82htrMy/xi26iDw65wDRNuQwTqlZWts0gZ59K85WNXcpykJ0PA/VNXxrONoz1RJPyeWqMQ9esFGdhWIRHGCP4Vr3DdYDCog+o75sHlDFXMq7FlFFqPhBBUqJXNIKrxhic7mt0dc17MmYo8iKC7Pquc8x5R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850420; c=relaxed/simple;
	bh=m2XnjUi0VdwLo9CexTzofkBI4dL2Pw9tg59UpzmoTaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KceBfly81x6h2DN06fZo5BFE5AXSjRQNB3SUJzhCD12Q4YKrEE+N6bTb6u7hVnEIaZ4O+6WXBG2SZ+3YXsPkAavzabM+kjb9Iagf7ZIiLocPivJPXXy4SPJ68ueOZdkszB/o6yYXKYJXC1p+1OcP8ZIHT8hLJ4k5Jhzrjl403GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e59WWVIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FxDg2LdZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZt7005839;
	Fri, 25 Oct 2024 10:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PX5rhV/6lwPyJuZ54zeIBwKPKXbkoNVcqk2MY0mAnpU=; b=
	e59WWVIPxBnOgIFyhIoY+fD2odHoK+NoNJrXx8x6EXHx8GNHMz4WSbUcXBlcwAE7
	7nAz2OVuYPCHZFXMH06i27fM434FBUQuu5HT4d3h/2+DNW0bBxuiQN/JR8wHQGWF
	zww9WqxoC3B8HC+gRZoI904XC83Dw4sWktkybsP/QKrSU4kiPLb8C6koMtP9tLCb
	oLjKkrRfl76SmR1hO/VeQBNsl5AodumlKBQlzZECGyANb8ILsjS+E3deRkCqndmr
	smC+RduSyb8kM99Ifqk2wiWq4DLK7Z+qIUUeqkAvurTCOfBWFXvqIngg4tiQrFO+
	TEyjsCL/OMQBPzwUGootLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvku5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:00:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8bFac002300;
	Fri, 25 Oct 2024 10:00:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36aadfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kURfDXTaONTpf+p1tDYhfa3GTv5mBR+XTbjxg8HMswLbzx8yAfVSLWg4BHpfvAD/Dmrza6ZoGWczxve1xfW8z9wdrAnm9nekb/Ms4YPW1XutfvwDaJiO0ag0bzcUZRRJuuiAYRXTMLx7H/QlyGOavRu8XLsZBaPZYVF+v/yVPxOE/RKar264HhnSRQSr9JqSgGj0+LvB0L6tMhMkhn4CK4ww97Divy+g0cQurVZZ/3K1GSQxkf0C1tIG6Qsb13iOQnnH1LQvCXZh6ydrxLWc6mpIyMtRCdgf+9qckUmEPpnIPPwFpu0Ql9WrEA0Z30mtd8QD6YqIaz6zS3jJnqiUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX5rhV/6lwPyJuZ54zeIBwKPKXbkoNVcqk2MY0mAnpU=;
 b=wHOD1z3eEyXd0ge+dVxl2UCdeHufhn+J9xeCAVObkciKDzoJjMomy1DlHQJucOvcBCiKwcGUwZfEYOICX/KAHK0A+g/o8Wt8QRj7IBhON8K4OpktYNW1mlQ6pbbEzpw+BKzD0kA4RWRlqEV4l9APXXiQtV/hklvK+SUJYsl0wF9h69MKJgq5VU7x9gVtDBNHzg8FJG6zXpZEykvKIouiQgzco15xIYBQirZh7BmruGm3cvcpwKJnCgghcF24X691LYJg7XXTRb744d1ZIAMmzRdHCXhq4O4Uah64t0Qw5oj39YByCj/dtBhgaCGrxlISY5y2ElzANYLWi4eEcZq+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX5rhV/6lwPyJuZ54zeIBwKPKXbkoNVcqk2MY0mAnpU=;
 b=FxDg2LdZ/edVCP7Kapn8vgiVyQhVQTINNoKYdMIv0vYuj9Bn4R2/O1i2YYrzSPcNiV1qZj6oqo1hUZNFm4l0nai5MlLPDMoG3EsW/ZxPAhdceZBxvjmk88o9AIAHo6374lwf08URRJlwzHpGqUm0UbIVZpITugQHAl6OVgyU6fI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW6PR10MB7551.namprd10.prod.outlook.com (2603:10b6:303:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 25 Oct
 2024 10:00:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 10:00:01 +0000
Message-ID: <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com>
Date: Fri, 25 Oct 2024 10:59:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
 <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87zfmsmsvc.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW6PR10MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 857979cd-8e63-4ad0-3d86-08dcf4dbca57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJJR1ZJQ0xXdkxVRzI3QmdaK3ZxenZXNlJaMnNiOUFpY3NnTXREWW9DbWM0?=
 =?utf-8?B?bytQSnZPN0pOOTIvazB1RysreHNSRDdWQ2tFdDBHaUZkUFdmUjlkdVc3QlRB?=
 =?utf-8?B?cjNBTStGYzIzV1NsZTltZHVLaTVVelNhZVNzRXVPZTNnOWxzOUUvRFhYTHY3?=
 =?utf-8?B?K1YwU0JGOHJ5ZXR2c3RHREpkL2VkMmlzYWE5a2FWQTUxTnFUMXNRUTNOR2ZZ?=
 =?utf-8?B?VE1USHZ6NE95MFlqamJqZjFoS2JUc1o3WVdKOHZsZzV3cHVGZ2lNVUNuTzVM?=
 =?utf-8?B?KzJIUlgya3NFeWxUQXRtUkRPSFkvZXZlSHNvUGdUWFVuMVhueEtwak5aZW5U?=
 =?utf-8?B?bzFPNlZlNzZJNk0zZnNqK1VmUzdYWjVvTk0rZGpSU0JDSUNrSzYrREhNcVJS?=
 =?utf-8?B?NEJrRGhxVGRPTUdVS1NjTW4wUVZ6RUlWV2ZXTmhrUHhlSzlkNk1ja3hXU25o?=
 =?utf-8?B?MjN5RlN6QXZLajdiVWNyWHVWWit6OXNiaklIcmhJcUVHQ0hXTEkyY2lQRjBC?=
 =?utf-8?B?RjhPL2p1SDh4QnFxcVFkS21OVUJpWmU2N0JBZmh4ZFd6ZGVrRUF3ZldnQUpK?=
 =?utf-8?B?OU1ZR1Z6Nm0zdjY4TWVEaGhxTElRd1NQaVMvWFhSOEh4LzFOVGtvK09pNWd1?=
 =?utf-8?B?b1l1dE42V2Z5d2d1bTVCUkNoZnZjN0s1TTNUL2E2cks2bGM5V2NLNUFDVkFW?=
 =?utf-8?B?WXFQemxldCtLd0kzUXpiRFVldUNEQ3doOXB1aG5mSm1mZ3lxY2o3YTBpaDds?=
 =?utf-8?B?UzRhRm9BaWpPYVcySitaMXFKV0kvaHZXcVVGT0dNZis5Y3Y4TG5VRCtnMFV2?=
 =?utf-8?B?eWFnb1BxT3lQU2p2TGhiSDB4WSt3aGlQSG9lelFQaXJmTHIycHFPN25aUlFC?=
 =?utf-8?B?SS9wWHl6ckRDV1Bockh2MXlSMTdhaGpFWmt4UWRaOGZpRWpoU3orSmo5SGhy?=
 =?utf-8?B?eTVQRVB6RVI1aXFKRXROTm5XQ21adzdmbEFnbTZDcDdFWC9TQU1ucFdKTjdm?=
 =?utf-8?B?cll2Qk9UVTB1TzBsWnJBa29zUW5aNHpGQWNkQkFaU3FkaE9FNndobDhYcEI2?=
 =?utf-8?B?YVdlTk5CZi9iRjc4QnpkbWV1VEsyM3QxVlBLYlNONno3STQvbTFCajJjWTRt?=
 =?utf-8?B?bDNqMHJOTXh4dS90VS9vbno1STVpT24xZFgzUVZzRHplNGhKVW40NTlrMDNI?=
 =?utf-8?B?c1VET0p3a2JCOW9Ec0ZmazdOeWRwTXd6b2xjd0syVzJha283NktvZEdDSUxD?=
 =?utf-8?B?TCtoYkIzV3VBS3R5MlUzaWp1TW90R2EvUjRYSkdYbjZERGVWTS93bkRYdlpx?=
 =?utf-8?B?NHl3aU8zWnozdUJFQ2tUMU53S0VOVnNSN2FNZ2NPVGFDV3hnQzRzMWd4Yloz?=
 =?utf-8?B?a05zV0w3QXBaWlVJSFVrRWdjVGtEdkt2N0hzOThKekt4REsrNjZyY0tSMkYr?=
 =?utf-8?B?WjdtNkNRWXdyRkZzdkNsTzVGL3lLaStKYm12WVFhOHBCTXNYNG1nZGVuOVJw?=
 =?utf-8?B?UGFES2lJb0RKS25URmtuVjFERlliNURhRnpqbndYMEtFdTNzY1VlZzNDakZZ?=
 =?utf-8?B?VGw3U01jNHNJUmQ3aUpqVlVxcHUxMmFOb2tCWE1jdU1yVkk1WlFhNkllTFV2?=
 =?utf-8?B?b25pcnhjdnF1M2JYanlLVkh4dGUzRHA4NmFORm1XQ0pwQ1U0U01ZOVFHQkVO?=
 =?utf-8?B?bURTMVdXYkZlOGsyTmdtb0RMdnNVSC9FVTFYcGRwb2NHSmJUYy9yQTg4VUNL?=
 =?utf-8?Q?BZboqhpIUZB4Ls1ke1KbdmGHeZ3z5CUzIps1bp4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGxMZWNlNk00cmFXcUYwRUlLSHd0VkRQb2NyNHQzek5neHczU3BuckNEbWJV?=
 =?utf-8?B?ZlZVWEtHQnpuL1ArcDRRQ1hCSzQ1OU5RdG03UXZTTjA2V3UzQXNXOFdGbGdn?=
 =?utf-8?B?TzJRWEM0ZGEzajBmd2EvU0Q2enRqTDJhSDhDZjdXVnp5a1ZHVU5TWWR1MVNR?=
 =?utf-8?B?NDArR0ZrSjlNNStJdHRTd1Nuamg2d0VMSUIxTS9FOFB0aXVtT1JsRGRaS1BH?=
 =?utf-8?B?WVV5L1Nlc0I0K1JSZXBmTGVwVWJrVE84K1dMZWZiNlk5TFBpRy8wZUlCOGVQ?=
 =?utf-8?B?TS83ZWc4MTM3NHZkQU9KcEk4WlN1WXJvU2ppZWtTaUU5QWloUllGWWZxc0RB?=
 =?utf-8?B?Nm9nTmpEL2dObHc0SG41T201UFViZ1dpWjEzYkNKQ092UXJ1UGJHT0pNcDE5?=
 =?utf-8?B?QldtMFNPN0w3SWtEUkt4dGhXMWp4MXpiSHM0eUlNakNndDZJeWh4bzJoU3N0?=
 =?utf-8?B?K3FnblhwdnhaOWhqeFRWZkFwR1ZkS1FxaVpSSUVQVlBJY3hVaTFIb1RHdHEy?=
 =?utf-8?B?eUdGamRwRmUvQ1lsVWNmMmtzc3V4eXFJMG5VWDk4d2tnWnkzQWlnSzBFNU1o?=
 =?utf-8?B?WCt2ZUxoSFpxVmc1TGJ5YUh4MWh1MGoxR2NCS1lsY1J1aER5VGdxMGVlazFW?=
 =?utf-8?B?SWM2cHRJeGhqRnRZR213cXZkeURXZGthNjVyTWJhaUp2aWRidFB1ckhjK2Ix?=
 =?utf-8?B?Yy96STBOVEd3RzBTdjhWbVJGZ2NYYXAvOTlzSFJ0VXdYSE15dTBxdHEyRm1z?=
 =?utf-8?B?L095Z2trb012YUY2RnJjN3dhZDYwRFZob0JDSkVscVhnWktZSmU3UkJGV2tn?=
 =?utf-8?B?N2haL0tzaDNHU1RnbkQ4ZnpOaE9sQWlaaUdmVzdGd1drcWlwMnpnY3Npbi9C?=
 =?utf-8?B?enJHOCtFcFZpR2pzUkM4ZzhQRTgwZVltbjJhcER1dkZLUmRLUzNMTzI1ZnE5?=
 =?utf-8?B?cHVEY0ZrZ1U5UUp2SUs0cm9UdUtoaDAyVUlCd3lVRm1MTjE2WFh5ZTltYlkv?=
 =?utf-8?B?SVk3WE9PV2dSRjl5bXMrcktRM0FwRXBjMWhJSDhtMmg3eUVYK2Q4OGxaYlBJ?=
 =?utf-8?B?QVVwWUdSdHg4MXFDSlRDdkg1R1BaNVVPV2dOcStSRDVsbG5zckFFTUNlNXJv?=
 =?utf-8?B?ZldCN05Gem5PQUk5eUtPWkdrbk5MRU8zY0JlUmw1RVRyNkt4RjhxbGhXR1I5?=
 =?utf-8?B?OGFqT0t6b1Urc2hPYjdpY2phNWxJbVVZRityK3hTalhXQjRpalhmNU51V1hz?=
 =?utf-8?B?WWQralR5T1RiYzdtbFhRU1phZTJPQmJUbE41dC9maVgxbWlOc2trbUtuamxC?=
 =?utf-8?B?Sm8wRlpoMzhtN3R3bllKN2VEeGlHQmhSVkhrdDBPTFJtdDNWTHMzR0FJSmJE?=
 =?utf-8?B?NlJVcUhwb3RMek1ONzFuMGJ6THFtVE03WSttK2xGKzFHWkFnVzk0TzlKdmpq?=
 =?utf-8?B?b2pYMC94cHFNRHZhekF4Z0gzNU9SVHUxR09LbDcwemxHclRQM09XSU5oQU5J?=
 =?utf-8?B?M01FZWVCNXJUMC9EdGowNFI5clhJeVJlVzFESjF6M013dE83UmVxME5CMENu?=
 =?utf-8?B?Nndta20xVDJ6bkMya1EwZTAyUlRST3lrcFE0cXFMR2U0N0lCQjdlWU9mdHl5?=
 =?utf-8?B?NTJGNnB6Q2I3b3hzOWJPUlY0QkNsYlgvdFBaZ1pBYThSVERWeUJyYUw2U3l3?=
 =?utf-8?B?VUlnMFF6K3U2bzg4dEYxeng1V0ZHZi9MWUcvdVl6Wm05c2JzSkVvMkJUbTF1?=
 =?utf-8?B?d25GbWlMbXA0UUExNmgwbWFoR3I0TjYxbEZrVW1lRXRPbnFpVXZDdk5Penht?=
 =?utf-8?B?VGtUOVVteEZBWmkzSG5yUUlVQWVYd2dKY3NTb3JwWmNwT1kvNUNUWmEzWUJt?=
 =?utf-8?B?Z1BaRXpLaGF1SS9ySlpEYW9hRmd2VWJZZTB4bG9rR1hVY0tIdWVIY1JValJn?=
 =?utf-8?B?cS9oQmRUbHNZejdORGcxT3lvVTF1R2NiSzZkejRXV3Z3TG5rREV6enNDWm9m?=
 =?utf-8?B?eWlmRi8yOEt2K3VpaVBHOHNzcVVQeVBUTTZ5a3BEeXgvOGl6T0xTdGNjNXJr?=
 =?utf-8?B?UkRsalBNR3gzVitHMkZZcG1aWGpWMnRoY2drdGI2dTFDbFl0dkVab2pMQTV2?=
 =?utf-8?B?QlZLYlVPaldxUGcrcVRCNkhCQXRsdkJxY25CTUd2YzlHdGExUUEycnlxaytK?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8l0i5jrvGp/EzLevqUFDULnmkefDYVX2kXw4fpQKxVeZT7Y1xFvJxmZahmqKSnoPPR2pMudpTON804SwEuoVXYbZS/gX/+0JTP/nbUwGK5Zt7Raj1tIWoMIPpoWoA/31btnsxQwHVCeRKgbCK/lFjFNbYp/8U3sR4gFquoqy4rVYjHKAqgIWHZyg4dtYVunhla1h8h8CZk7NhdEnmHLCkLHjQK9Yovm+pr5ehrJd3VQyGo6chPgVKtvrY0gJnywj2P2RKHQJ8Mk5A22jnxM0QZtlv7tjGf2NSHDLXHhTgl+pVghqdxUtkEBqqkl5CAlOPIStKT1qo2cOjWthJuifi1kOmKYDK1HAwI82dvlEBZDwf8id1x2oh/yuzSYd5ZLDYDZ+IFqqp0nZwcGYbmSfsIlwEyPgsAUNLC1Isd8pJGr+eohxhvwhq+0W+x9PCwB5j3LAymbNGltwYOdqd/WTL17DNi1dxXgPy1raHAyefBdfj5qrq6DHjZBskD3iSITWAg8UbmbR/5G10SUz0JMWmu41hiHgW2pa5eAO907IG95Z8NG8kmIMcDnPq30o69Inh74RstyCn2+t3CBuDgWkhWMFhJMWEDZGORBiOBSboAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857979cd-8e63-4ad0-3d86-08dcf4dbca57
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:01.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng5DT6x2aBEjOWlf9j38BW8S2uCV4idAokR+YjEjwommugm9V7OhYtCsR1D0FtxvsDqxRkYfSkWCtKKiP2dV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_07,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=892
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250076
X-Proofpoint-GUID: Pl-CFh96CtN2_u6_8h5DlKoWBSOCVF_V
X-Proofpoint-ORIG-GUID: Pl-CFh96CtN2_u6_8h5DlKoWBSOCVF_V

On 25/10/2024 10:31, Ritesh Harjani (IBM) wrote:
>>>    
>>> -	if (atomic && length != fs_block_size)
>>> +	if (atomic && length != iter->len)
>>>    		return -EINVAL;
>> Here you expect just one iter for an atomic write always.
> Here we are lifting the limitation of iomap to support entire iter->len
> rather than just 1 fsblock.

Sure

> 
>> In 6/6, you are saying that iomap does not allow an atomic write which
>> covers unwritten and written extents, right?
> No, it's not that. If FS does not provide a full mapping to iomap in
> ->iomap_begin then the writes will get split. 

but why would it provide multiple mapping?

> For atomic writes this
> should not happen, hence the check in iomap above to return -EINVAL if
> mapped length does not match iter->len.
> 
>> But for writing a single fs block atomically, we don't mandate it to be
>> in unwritten state. So there is a difference in behavior in writing a
>> single FS block vs multiple FS blocks atomically.
> Same as mentioned above. We can't have atomic writes to get split.
> This patch is just lifting the restriction of iomap to allow more than
> blocksize but the mapped length should still meet iter->len, as
> otherwise the writes can get split.

Sure, I get this. But I wonder why would we be getting multiple 
mappings? Why cannot the FS always provide a single mapping?

Thanks,
John


