Return-Path: <linux-fsdevel+bounces-13853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5977874C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A62D2824FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33A85280;
	Thu,  7 Mar 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQUPGyvT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKl5i84q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA782D83;
	Thu,  7 Mar 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806791; cv=fail; b=bPtjhiaXODDA//cCTR3RK/2h42699qttRT2dTg5w2njevBQMuo3Dm0AcIRsmYJEoZ5L3eCXa0fRrmPNprCf0FMGUN0GKkbjktRJZBSsaBllSFNgSv5JT12o2UUW801TU7VLvtY3VflvWk9t5uQPR1eiQdCY7F/WW8FUQUuuKgfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806791; c=relaxed/simple;
	bh=GrjxLo6rsxQ3sEDUyIQcRQ8igYb+a6mzNvF5w5+NxTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzFmOEcq4dJEDN0uOfrjr94N1dFcpLj88NaxmhFFdm88kByWD06ZySLzdGvFpN28R5FHbqLdJqSkAYYkVYfl3iIKTGTkdJI5lsUfDh1VvXXmQWbUhKuNI2yJNB6+kU7z7/1In5U5zFitP9jnYeRZNwe47YlkVgsFMPtu8CBj6oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dQUPGyvT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKl5i84q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nb6O020782;
	Thu, 7 Mar 2024 10:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z6IZDskQtXp+n9zmkkt7eD9WxxxjBMfGwt08Ig675qY=;
 b=dQUPGyvTq/DY2TbUOZAoRV0zvjrc7v+9iTKRGcTsNgyr5Nlm7OaVlm2H+S8eKmMEjWg0
 pne+5BV7D3k1/g28DX0Ip0/q8Nnf3us9VE7uzt9pq4xXrw0H8muAG+lcOR++8Yp57hML
 wLk2QrheKY3vN/tygt8K8/GqkHyndRQLjs8xayMo8JqHmA+NTgx4my4+ui1GkjaVaoSI
 MDsLyVfWWQ3OL9r8IQCa9NQ3Ur51/HL9NkcMsMPrBvl2npI6K9TnhPZ6X+/uuHBCITcg
 IAq+7R6zpCVfZ2NzT4N6pk9OwWFo6x4TvzQ75pDtOFTM7FabBrgQOI7RypGdMlS8ri84 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2bmp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:19:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4278bC9G015978;
	Thu, 7 Mar 2024 10:19:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb1ef4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbRGdsUfX11yJ9SufW+G6YBTT3xLf/WJKQL68xPnvsugRR+YWelNrR/5rSNXPo/QqXDKKLsvj1gNgke14CS3UiV2Spvj8qUpXsvlLggn8p2p23MUy7ZQp45pgMdjJ2hJcfOFYfVuENchLPOyr47pQV57DhLkPSAUpznWm9mZYt8I7WOxSf3yuwALMMwz3CJAgQG49gIRG9/wuQH3SCSfc8l0gpsF5obT9IR6pTrrtgDlNu63o6vDx8T+NqeZaa3lfUU3BuGrnH6wzT36IcGUeLN5JGYqhjPXAiOHSIQS+or5LuF4R6ZnGlerp36XeQEqllBq6xCr1bJkEjlw9W+Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6IZDskQtXp+n9zmkkt7eD9WxxxjBMfGwt08Ig675qY=;
 b=DJZZt9xl3jAOiiy3SPOLPnKHYGUIwvXXtxMhRTxA5Bhbb6yTfboiHO6CPmILZe5NkBFWGS+kVHbtbSSPEJQcBTdW7OtvrRqTP61T9mrdLfpyhVByvguRDK55MJTjs594Rj0FDiUDJ1dsszZgWRlC7gRVgp6lbaTCGZaMoLJhEgKjCXjHAJ57L9PUUPoB2lqlU+k71m27VAnI8EwUzQcOcxRUs8vA8rSCTHDBIOYcu33H1+Fu+AmAX0arMDTwQxtHh1RiVzSlOcAN89p6D1yTdLLie4dGGllfV24Xhzym3QsK0y/5T3zEVyWei4LGqp/hDmj6DNw/I7JljCF2+MRxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6IZDskQtXp+n9zmkkt7eD9WxxxjBMfGwt08Ig675qY=;
 b=TKl5i84qpjGwd6E/SJ81SlePKo3BCEaNCfWbGTGoY86z49Qc2nKjeXrFMOEZHsoDONZfTfAXANWFz+h03tyQIW8wkyIC9liT1jszXo7nHlXVuFXi6Fu/kjAf7vVBK9HW8HKUTDiM3p03FwEDFKU+WuVbfuV7MYVk89b0g22pqks=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 10:19:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:19:29 +0000
Message-ID: <07d53a91-5451-43e2-ae8c-0c863cf0ec9f@oracle.com>
Date: Thu, 7 Mar 2024 10:19:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] fs: xfs: Validate atomic writes
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-14-john.g.garry@oracle.com>
 <ZejersjddMNdkDqz@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejersjddMNdkDqz@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b37d82-1ea8-49b4-3157-08dc3e9012ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PLNAzS76TUmOECN8sOwf4b+nWIYll96uMOQ/qRQQeMYCNy4sRmCubkvXdFWHI+7uxxPVLhkPqv5Rc6hn1aShq5cldB57N/+UNo2wJUf0sGBvfTGInPI+uzploC3T0gqAsT1Dl9K3h6VlHVsRvn9InZn7fuiOk7iInlSASGZDQ/kT6D+OAqCmNj31+2LqiRAymdQbc8djTwPihpHTjIl80ABDeprmUv5ysy7xjaz2iVXmsGYtjkymcPpvHP/+BDjdVUl8fZZFhE7++0G5Tty1ueEq+nMyZrLBsQSv7sTXtB680/0+ECXskO98Vsbw2dhAIwY8nf4hjW1rF+befc4sV8mjp7/1nBc4NVucoHi7fwuRqWFjg1129+oiza08XGBlGafolcT27mTfasS2a85OvjY2MJYQhRlI6VjZ6lAmxHlK9CDudky0YPdCh7kcDB3je+uvx157vafNRXWh3Ume36VbxGur3RmJjNJYe7Hj2EJH8g8ydfORaVxdgXEniq060YONhyOFKBd1Nibuj3Y92pxfdPbIQqk1Rlvoj96zb39AyiKfRXfQUBFd9NHKL8YCxq/gZl8qqwLAEZjmi8L9YzY5kmeG+y0I7/W31ytYB4Y4K7hHIqLY8EIlq9vJdaNxWnTJQA91mM9RJlbRgcrtuQjFPBoRid3CX5tUCt/oGXQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUh4a3UzY1h3TkRReGdVdlFiTWdOOHg3Y2lEUUpFdGd3RU03WnQ3RGNwS3Y5?=
 =?utf-8?B?QUlENkVOYVJPQ2l2c0Nmd2Z0UmRCZC9NTWhzdHlQOGR0WVBPOXl3RDFJbHZE?=
 =?utf-8?B?KzU1NnZaMzRwWU9GRlFIb0MxK3ZldHloNzZXVEphbU9aRnFmbWljMnNHQSt6?=
 =?utf-8?B?cTJHeUxreW84RVdyTkJzZExkVG9lUlNEQ2svN29CYzhWWHNPVkthRjV1NVcz?=
 =?utf-8?B?ZnB6cGJ3TlAvR24ydTJMTFczZW5zaVdLS2hUYTBlc2R0VlRmUWpVTFQ4d1k0?=
 =?utf-8?B?VitVRUxxcVVYRkRLQ2l2R01OdlpxaFhUT1NDZjFvZGEwenRpK20vSlNSRnpv?=
 =?utf-8?B?aVdBTmd4WXNmaStEbTh4cGxsN2lMSnZMcWorZU01TGZSZTNFNFpGYkkvYXBS?=
 =?utf-8?B?ckpnL1NDbE82SHEvSkNLVEVMeGllMnIvK2hsb3lmWkE3NjdYM2Z5cWdvTVdj?=
 =?utf-8?B?cTdoR1Nsak5zN0h3TmpRZjdzNmgzNEplSjBxc2ZTc0pvTWVWVkN1cFNTT1Fa?=
 =?utf-8?B?NHMvczVCUDFRelg5R0dmTXJvYzZUZDZ1Qm1FajMvZDhvTCs0M21jUzZncFJp?=
 =?utf-8?B?RmZPS2VLdUpZMUsyYnlER2xkczFueVpzc2psUDd4Z082Y1JZMzRWbTBjN21V?=
 =?utf-8?B?dys5cW1RVFlGWEJHREFaRExSYlRvb2lpNzQ2aVg3L0NEY3RkcFRkT0J6U2dF?=
 =?utf-8?B?S2lyVGhxdHNzSXJZUURlSWRvRGhSSCtaNVRmZ1l2TWVjejlnOVowekpoVDRa?=
 =?utf-8?B?YTdyUVNCeWxpck1QRlBWNTdGSTM4NlQrdlNBV0dhNElSSE9mNEVoaXcyMVQz?=
 =?utf-8?B?dkFNamFmUjluVUNwYVd3ZmhtdmdNd3BTQ2ZleXltREc5ZGpyZGhGU1VDaTRa?=
 =?utf-8?B?bmZKSVJ1U0N5STZsbExCTHhCNTZwYVBWZjgrcWc0MGdYQjNyTFZmQjBYUlZ6?=
 =?utf-8?B?czFkRE41a3VPM2JyMUlCblFrZXNWN0hBTnlBNndKNWRIQ1dHNlRrVDZZOGd2?=
 =?utf-8?B?UXFhVHQ4b3lJMUpxeUJzMEpJNEkzSkoxaURjYjArUENicnBBUHBFaEN5aEdB?=
 =?utf-8?B?YzJ4eWtLb2RLWFVEOGE3RUVoVHp3WWxKVjBWL3F5b2d5b2Nmd2E1SU9SYnhJ?=
 =?utf-8?B?TWl0cGUxTXhNcGNyOEFYUjlMZzAzeXlTZWxpQkhRWWpjWm9vd2IyZ3ozdzNl?=
 =?utf-8?B?RUxYTW9UUWVxdTVrKzduM2NrK055NjlhZDErWmMrYzl4L05TMTEva2FDNURC?=
 =?utf-8?B?ZnZQdGVVMFZHOENRYXlvak9Yd0RQLzRBdDh1OXlzRTc1RVdGODVraTM1VGpz?=
 =?utf-8?B?dnFlUkNrTmRUM0p6UWF5VTdWWGYzWnQrdENvY3RmVGUwWGtEOTlicDBKMTcv?=
 =?utf-8?B?ZFBieUZxYWhubVZOMU03blM2ZVpscXZHaEtKZGJrcGZoRlZBYUorcU5JWUdH?=
 =?utf-8?B?RWZXVGRRN3JRb3BWT2xvbE5wcnU2Rzg5ejU3ajBEc0g1TWM0TUpiaEl3TGJI?=
 =?utf-8?B?L0xvQlhTSDkvbmovaU9Rb0JiaE5XaDJjbHFTR1BOOWU2L3c2VHMzNFBJaFNW?=
 =?utf-8?B?bXFkTUlkZWpUbXRRcDRLSDl0dy8vTmFpaHh0YzZKYlhYd0o0VVhWSUkyN21X?=
 =?utf-8?B?WTZheEx3WE13cm9lUXlZQ2RtVVRYSWlrY09kZXBacTZ6c3MwWkgxRyt0ZVps?=
 =?utf-8?B?UjlLdnZBbW5obkEyNG5CbFZkTFRTT1E0M3NjUGFSUGdVZ1d4NWI4WVBLNzJU?=
 =?utf-8?B?YVdkZVA4SzRMNmVZNEk1OE40T0t0QUlvV29GeEZTTDJKdUlubG5NdXpoY3NW?=
 =?utf-8?B?Y24yTFU1UEo2SDlDM2ZVUGN1eEYvVVdmbStmUlYyMjFxV2hoV2pBdjdmVUht?=
 =?utf-8?B?MmRjRUF2dDU3bDhGbXhKZ3lpMlhBeXBnNmttU2kybTBLOXk0WmsyWlFiZnQ1?=
 =?utf-8?B?SzIyMmtOVkxUSmhpaGRzZWVZbTFFNld0Z08xMUU2RWtGM3dZZ3Fua3ZDM1NY?=
 =?utf-8?B?cHBtR2ZJNUZsTlEza1RnOTZ6Z3NmSjJ3Y0E1UG92Qkk4YTdzeGRjV0UxaFJs?=
 =?utf-8?B?K2dUdkptY1cyZG45VEVyUjRNcC8wL09STTVVSDUrQ3NLNmxkeUN5UndVL2Vo?=
 =?utf-8?B?ZlRnNTd3MWsvLzk4VVEvdkQ2MHZQZ1QwcVRDQ25wRkQ0QjdzMG01SHRvcGQv?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PCJvkbiBKNOO1c9Wp/I0vVyrU9PkBeIU3QibwCgZN7MZ0rqtp5XzbHEV3EA4EyrQ1yVB7RoeiDiVohOzymo4EDn+6GjSofD6RvacuALS5UwKBkl1Z9tgXKhi4S7Geyq0GhtQut1ilC5MqF1Hk6dbX/rdSrDqzryBdOaWant4nUq/FA4YlXrlOtnPbhmTtPt4yUNdO9jdoy42lRDJQNZv2++V6sSTKKLzVO/d+Y06D4j9RmiSQOmj+H2Csmg4VzstRFMKhTPg7ycyHF/q+Ts93dbkKZWrpm3uFI8/MLjTDJ6fnuoqu1WMoRON5pMJegC3HDfXXYhunwjTfGndaaHdP0EBUgeZNpBe1FrI/151BZtnxY4F7+3FIcsTtW1O3i+zXS/eSpj4yAzzMv8pM/qYhuUCOMoYt/hfsDbW1xO33qUz69rOPfnne21BBa/E++/utbaAifA2voZl7F0Wx6DsHZuY6ghpSF4CHLDUehn3aGknddjLmDwDdXn7iVnWDAZg7aOs3OJtzi2OYfiDDY0YJMmd/moxWihHwScflHJSHBVRAjbdeBpG8w5RYL20vt7nJZ8Qz6UDWEdhJg27jeGI7NnyLKb9bfKnGKBpCbKMd+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b37d82-1ea8-49b4-3157-08dc3e9012ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:19:29.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPe5RDBPAjeYNXoBmSBfQMo5fGrMh50FLdjBEyY/hKtMN3zukbklKCMtnyoxycWXWcZ02hTAk73X1Z+shyc50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070075
X-Proofpoint-GUID: 6nQ78oHlel_xXKa7-dN0f2Qho4ueciz9
X-Proofpoint-ORIG-GUID: 6nQ78oHlel_xXKa7-dN0f2Qho4ueciz9

On 06/03/2024 21:22, Dave Chinner wrote:
> On Mon, Mar 04, 2024 at 01:04:27PM +0000, John Garry wrote:
>> Validate that an atomic write adheres to length/offset rules. Since we
>> require extent alignment for atomic writes, this effectively also enforces
>> that the BIO which iomap produces is aligned.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index d0bd9d5f596c..cecc5428fd7c 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -709,11 +709,20 @@ xfs_file_dio_write(
>>   	struct kiocb		*iocb,
>>   	struct iov_iter		*from)
>>   {
>> -	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>> +	struct inode		*inode = file_inode(iocb->ki_filp);
>> +	struct xfs_inode	*ip = XFS_I(inode);
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>>   	size_t			count = iov_iter_count(from);
>>   
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		if (!generic_atomic_write_valid(iocb->ki_pos, from,
>> +			i_blocksize(inode),
> a.k.a. mp->m_bsize. If you use that here, then the need for the VFS
> inode goes away, too.

ok

> 
>> +			XFS_FSB_TO_B(mp, xfs_get_extsz(ip)))) {
>> +			return -EINVAL;
>> +		}
>> +	}
> Also, I think the checks are the wrong way around here. We can only
> do IOCB_ATOMIC IO on force aligned/atomic write inodes, so shouldn't
> we be checking that first,

We are checking that, but not here.

In 14/14, we only set FMODE_CAN_ATOMIC_WRITE for when 
xfs_inode_has_atomicwrites() is true, and only when 
FMODE_CAN_ATOMIC_WRITE is set can we get this far.

I don't see a point in duplicating this xfs_inode_has_atomicwrites() 
check, so I will make the commit message clearer on this - ok? Or add a 
comment.

> then basing the rest of the checks on the
> assumption that atomic writes are allowed and have been set up
> correctly on the inode? i.e.
> 
> 	if (iocb->ki_flags & IOCB_ATOMIC) {
> 		if (!xfs_inode_has_atomicwrites(ip))
> 			return -EINVAL;
> 		if (!generic_atomic_write_valid(iocb->ki_pos, from,
> 				mp->m_bsize, ip->i_extsize))
> 			return -EINVAL;
> 	}
> 
> because xfs_inode_has_atomicwrites() implies ip->i_extsize has been
> set to the required atomic IO size?

I was not too comfortable using ip->i_extsize, as this can be set 
without forcealign being set. I know that we would not get this far 
without forcealign (being set).

Having said that, I don't like all the xfs_get_extsz() calls, so 
something better is required. Let me know you you think.

Thanks,
John


