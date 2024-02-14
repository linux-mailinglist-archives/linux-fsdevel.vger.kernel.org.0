Return-Path: <linux-fsdevel+bounces-11548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D29D85493B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D4B21FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6B33998;
	Wed, 14 Feb 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dz2z3Mkx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K3ZpGvf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168122626;
	Wed, 14 Feb 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913816; cv=fail; b=JDQ43W5LdDqT1lxdRUNeJUhBPerm2W8Sw3Aa9T0Y+hUddOupPo+CHsHYiMvz+tcqbY4Pf6r5n7H56xXWkpBjp1YkFy/4eEZ2OZmBrmj/zcnwinXGt5b6TzC26o23XrWhyz6DK3HveZ4ZDEgCQoeoSDih8JkO9YFqUr4BfZzDSsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913816; c=relaxed/simple;
	bh=mexE7O8L4PBpS6bxCAb5jyNZb1JbGbK4nO60Pwy8MSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cExEFg6zVQ6ohL7QD1iXhTPJF7I/EwWXaXMr14oss1nn45AmXFTNN+X/g72qCe8WsHEvpL8spBP643HY+H4bhVWaT9WOkVLnoZsByy7bEmyQ40H+RUWrHWwUhYPEeSUYLP21/5j4jOPkQZuQcgG6GnR3ww/bLLGcET9BPvgI6yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dz2z3Mkx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K3ZpGvf3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBm9Du019955;
	Wed, 14 Feb 2024 12:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lHv9AHLzorOOp7F7s33gUUZmDmVuld08RRjE+RGWtA0=;
 b=Dz2z3MkxJHR+bPK8rTxS2VX/0ETwutxEZ3nTPGWKeMtU4cOWhQXgF3LzAXHLITYc3Lyc
 xKuhO/p2dKzqnTm50sP8y9dYwNkpRrTt0uGSgtQT2HQq7DDtv60EjLBHtgWt7mFmbpAz
 6yg7+9RYGsHT/APVe+KdALtC9YfIc0hTGugKvIMcgk2V5clA5Mn+hhzl7pqLKsYNsFMZ
 Dxv6W1SNEuIkOrpaPijadQ4Tk2UFmfwx2md3x7VQEyA6l+rjRAMWe/3DqfDL9P8GWxZ5
 7xMsRyfhdpwEdpOy/dlT6U+l+63irp1VPfcKMf+Yr6vIGUdqhApSNneukcZdAp7z6h0v Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8varg4v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:26:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBUSVF031505;
	Wed, 14 Feb 2024 12:26:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8uwtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwXIsXs49H3WrK1AiHDXuOcQmwxpdCS7os1vQBTDKA6B9IfZXakILzt0euNBcfddMhl398M5XuN5nW0nMXS+gfNUVq3ld8D+b2lIThrHa90KHx+f8rBwvIoKnfmamMZsCyYrHQd8kOYfcfEUHdl9xFUx3ICBQuwyn1xhS4IpZmy+THUIFe69TTkXNxnxSRaMSKef4SWHwL2m1FLGTQMp/K53LTm/Q10m+0DNrzPeHPDItt1a7XB+H+xppVnvbyPj/zRnk/CmsOjr82mhtF5GSY7YhodlGRlf8zQwfDlQHank/qRUylcrupAJal/JaEeks8C/727pFlMwui4QAOPkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHv9AHLzorOOp7F7s33gUUZmDmVuld08RRjE+RGWtA0=;
 b=JK/dgf8oPDDzY9Dluh0UVP1fI00eQ1JxIr+SVRTylPD7SX2JwX2yXq6xcqRtLj/xQ7PRPUvQJRa7CmXOpVUCrxvp+aXJ6feHdvAQROYDPcCsJ12Het6ATP642Do4TiWeOZJ5npfHGWQiF3qQFTc5X+TMyt/SPqY0v6vHzq/M50rmm2KgWV0kDvuTovuPhjUwvxwJL3nSdvQ5iQ/Islu5qHPbx/3RCJd6++CW6zeGqoaPy6ZFCXKIx41AU916RCmWNUYlt5dSVfuhq4jQSxQjfsoheEHXo/azoQpdQqKjtZmEsawH2GCCMcKShsM4TKGLGP1V5fSUhmqedIQywFJOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHv9AHLzorOOp7F7s33gUUZmDmVuld08RRjE+RGWtA0=;
 b=K3ZpGvf32RkKMtQRHkGW4Jdhj+yRyZYT+oqTHvOwE70PgLHHUBVhJeRjxE4Q/vn+U0k+MJGun0AEh4ynz+bNCaX3FcOh24qcJmXkR3icxIULJ+jbDcFrxhivR9QM8pAgFFsVyTmpMGW8HY8yl1KQwEIr+AwtmRnEFWaVIx7E+iY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Wed, 14 Feb
 2024 12:26:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 12:26:31 +0000
Message-ID: <e39979a1-b8ec-4b1f-ac88-0ccb1e086581@oracle.com>
Date: Wed, 14 Feb 2024 12:26:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <20240202180517.GJ6184@frogsfrogsfrogs>
 <9b966c59-3b9f-4093-9913-c9b8a3469a8b@oracle.com>
 <20240213173704.GB6184@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213173704.GB6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e432c5b-4220-48eb-a371-08dc2d582d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Bd8V0UPF4TymDBu3ph1ml0JZZ05KFdimN4tM34vjKnFtR86j/kcRsIM3tsxtzTsSHqDwsBpmEylUfqNhPXf6lasxIbZJdYBidiUhY0081kylgqeLkceqqO1ZTsdOoQ0RGzI+WXBGh+m6G5nlAYgG6FYrQhanmqoirNyDpOd9NeskyylkZlfbJSsv2KHgh5Vus4Ds4E3ukh7JLTEcd08KO6zn+Jg4PFA7d4RZtsSwt8FcAQNyFMlXmaQDwwp7QLBbyEPMS8lt+90FHSp67nM/m9lVd//QV0aAzd3HNSJHNi8TtoaeEz+6s5mRphtt+MUV4bxn5hll0fpPJMNl65v8X1KbmHYSIYZllzUy++zU7FQeeOdNoEu+EHlYV+PhbUx5YId/2gYTmNRy7sKOxFnoLhRK4dwro9uj7nEe+1wYU84G9Dj0nOQB8+3/yIDTQrPYplgVQgHmA3sEPdQchKwy0+pZP/L2dH5DQoemyZPBsGxcE1qOOfr8WpEsIu5LCaj7K90bqQXpkSV6lTAHXb29RWJwJWDed/iOKXIZS4AN+s8+yXXv5dpOg5scUupfypH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(36916002)(6506007)(6512007)(6486002)(478600001)(2616005)(53546011)(5660300002)(7416002)(66476007)(6916009)(66946007)(66556008)(2906002)(4326008)(8676002)(8936002)(6666004)(316002)(41300700001)(26005)(83380400001)(36756003)(31696002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2tFT20rUm1kU3ZSWnYrd3JZRGsvb1BTQW93ZEJQRkJoTldqb2cxMm9hdnpq?=
 =?utf-8?B?TW5VSllGazJrR2ZZVElMcEdZWnpweEVzVVVBdzVBWExrRnAxOUM4cldMTG1q?=
 =?utf-8?B?K0R0SXdtQVFvL0lzOWN5NVZFMzBXdnNHSWNyWnNYdWNhVVc2OXZQNUhIb0dP?=
 =?utf-8?B?K0M0Y3JPQ2h5Ri9vbnVqQkIxQXpaV1RMb3cwK0ptMTA5MThOYmdYL3c4QUxF?=
 =?utf-8?B?MHpoY0VGU0dReWV2Z3RqaXB4cktNNWxkQTFuamNLSWZMTi9JaDhYSFZaeENI?=
 =?utf-8?B?aXlhRjExbmdyZE01dDZWeFJxelBkL1lGMHR3YzhiYlJyakp0SUdycDUzYmNk?=
 =?utf-8?B?cXlKL1BXdm9vL3YrZklMOEExSmlVdml0S1BkQXJSU2RNMENQckdlL2RIeWMr?=
 =?utf-8?B?eHFaZmpnMlY4RWdNQWpyWkF1MVp2ZW9XSDhHQSsrZUVrdUFIbDZVcHRpNm43?=
 =?utf-8?B?dnpLYTJNRE9CV0lWTFlMQkFVZHg2WWU2aVgzcjEwYmFkWXdyMVZEM05HR2VQ?=
 =?utf-8?B?UUM2VFJEL29YMThOakpIRDVVWmJKMndmL0dGNWk5SjBlMXVyekc3d2N5QjVa?=
 =?utf-8?B?RUlkajF2ZmRHeHpxVGZZbEMvN2ZYTitCOGFoY1VyeExjRWp3YzhrU1Rhby95?=
 =?utf-8?B?b1dITUN1S0JsbmlzYmw1dEtOeVJUdWk4bHlCcWlPaUwya1NGbjdrVWE0TjZ3?=
 =?utf-8?B?ZXZyS0lYdlJ1N2tsanBVNkpsQnVPMXBlRzAydGRsU3locmtOSnJXZ0UwOWI1?=
 =?utf-8?B?ZEl3WEFGaUNteGxKVnBPZS9zVVlsaWtjZDFjMldadTVqa0dWZW1DSlU0bU5p?=
 =?utf-8?B?VHJhejhNdnBYaUZ2Z2IzdnJBbjRnL0NRT0FKRWxjT2s3bjBxVFpxOE8rTWZW?=
 =?utf-8?B?L1J3U3YwY1RFNWZXSmNYYmRTdXZ3VjdyZDFlRHBQalRmRi9rdThWSm9Id0xQ?=
 =?utf-8?B?dnpoS052TWsxRnpuaXM2NDZudmJXam1nWi9XNGl4b3ZSTnRjb3RNTWNxY25r?=
 =?utf-8?B?SlQ5NittY09NNTFFK3RaQnFpRFVzVXowWFRNUmlDejdOOXVmRXFTeUlXS2Rr?=
 =?utf-8?B?RG5KVDg4M21kQitsRnhsNmtDMHVQWVVoVk15QStFcGdFL3V1YnE2cXNYOUNY?=
 =?utf-8?B?cklZZXZlM3pmay9vMjhkNjUrVnFISkoyd2lCUTlzTHkxM01zNHFPZU9aSEZt?=
 =?utf-8?B?KzZaUjh5a3kvWGpzOE92NjRad2VuNkRJVVJoWDM2K2RtWE5CWG5ZNHl5Ykh2?=
 =?utf-8?B?QlVDSDJCZDFBb21pZ2l4L01GR1BhV21NcGIwbXJvQzZTZW8yTW84bWh2d2gy?=
 =?utf-8?B?QjQ0RmVKVFNLVWs0Q2RRbUkxVmw4RnltTXlHSitBY1lSbkxuOVJsb090K1J3?=
 =?utf-8?B?ZjMvQko0Rk1oQ2Z3c3dUMElZYnJ2TVBNd253ZzZ3dkVtMitRU2pBTGZLeWdw?=
 =?utf-8?B?RzNUKzFoRXlJcHQ1NEVBU1owc1lEUFVGejQwdHRaMWNVNEN3RHhSK2dPY1cv?=
 =?utf-8?B?YXlvQWVaTEd4WGxtR2ZGZXFpZ2grNEFtRUdmUktPVmdRY0dncStDdkM3VUQz?=
 =?utf-8?B?MGVncHVSMm5LRG5EY0Y3MEI3VUo3eUVZWm9FMnlqRm9SWXYwRWtvWXZQT3Nt?=
 =?utf-8?B?UTBHVFBxaG4wb0JNSWk4R0JUWHRYTFJOTTBqc0pOSjgxT0o2Wkd5TUg2TmtE?=
 =?utf-8?B?T3J4OERzeVMxaDEvMk04R3JNLy91L0ZJSjVGbU5NMy9GM25YUWpjQ3JQRFY5?=
 =?utf-8?B?RDc3S0QrZndtR2g3RkNMbXRHT0JlWFVvWXU5bWJvTENscy9nVUMyN085VmZ2?=
 =?utf-8?B?QzRvcGRuNlpGUzZSRzVjNWtGT1ovckVpbm9IQ21VaWZsZlVTVW9sdnpMSk9J?=
 =?utf-8?B?a0w5NzRseEl1azV5cE5jZVRqU043Q25DckliTVdybFVuNk9FU0Fab0F3V2NH?=
 =?utf-8?B?cUhqUHM2QURmMjdzWWU2QjZYaGM3VExEOHQ2UThBME1zMXFjY1pkS3FleG0z?=
 =?utf-8?B?ZlVkRWRtellYNjd3dDlCcDQwSDVzT21ENzJyWndqSnpTWDBlVTloR2dFbXI3?=
 =?utf-8?B?cTdEOXZScC9WVURoSzVmT0dXRTYza3FYdlpLZlBaTTA5WjQ1c2dRVk5BNzEv?=
 =?utf-8?Q?YV0Z+8TSCQsDqW9Gp04nltj/l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UiDKSNxFUT9uvdDCVDb4cbPWDFPGau5rGqP8pDM67Vm3iWSgJuOiuoLKnDZHdxKDqcZFcBx2qrJ8z2cvyUjco9iL5m2/2LvyUZXj69RuxBwj4Pac101vfxGmQ41z/YE9Tr9rXgn1CRd1tsmOLmJ4W/0mUI7+VHLrxrgTmEXN4X/WBd9jvMo9hed/my4iQAbUw6jDrSZQGykG6bMmoSX+w0zHqPNoNXughwoHx/zMrcGJ1FWBBNnvBuDg1185Md4NiMRM+um9MQtVvCOfrSOmDGi/DNFpr771Ly0zNw7Z/10716kgKMCmRWD9lQG87VAwWkEMh3mgYhbmB0KIzm/jfD6STQmNj16Y4vM/a8ZC2l1OcbjCs0jk1+7+5PvViPNLbupkVelhi0qeamGu599g3SamLK4VUVPRq7gQWUXZ+IwmzOBV3hG+80+/XxBy06S9v5NmcuF2Ypk/dpUZhu5xbtQmaQp/38CSaZ4MwwyRkjaMLHcaS4MJZFirlhRk3ITqiXMlfZ6Re4zM2vaDzfiAhjTrNP5NPvPOqMRXW4AkPbNqAa48MrotR/XY9XqLoqCYPe6CMXqYs1Fl8D6c5ESRt4QnfAmZlToWtL9XCOntJ7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e432c5b-4220-48eb-a371-08dc2d582d0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:26:31.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHccEWtyCxC4XNWSR2i1BxRt7UEKgpHCT2iYt4dPcvaBZs3ys/89rKG+oZPw4SLk48lWnqmVakUpciLlGTl36g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140097
X-Proofpoint-GUID: vL9hLFGCFO9bJWo1EVr0kM908AoxN6jo
X-Proofpoint-ORIG-GUID: vL9hLFGCFO9bJWo1EVr0kM908AoxN6jo

On 13/02/2024 17:37, Darrick J. Wong wrote:
>> We use this in the iomap and statx code
>>
>>>> +	struct xfs_inode *ip,
>>>> +	unsigned int *unit_min,
>>>> +	unsigned int *unit_max)
>>> Weird indenting here.
>> hmmm... I thought that this was the XFS style
>>
>> Can you show how it should look?
> The parameter declarations should line up with the local variables:
> 
> void
> xfs_get_atomic_write_attr(
> 	struct xfs_inode	*ip,
> 	unsigned int		*unit_min,
> 	unsigned int		*unit_max)
> {
> 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> 	struct block_device	*bdev = target->bt_bdev;
> 	struct request_queue	*q = bdev->bd_queue;
> 	struct xfs_mount	*mp = ip->i_mount;
> 	unsigned int		awu_min, awu_max, align;
> 	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> 
>>>> +{
>>>> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
>>>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>>>> +	struct block_device	*bdev = target->bt_bdev;
>>>> +	unsigned int		awu_min, awu_max, align;
>>>> +	struct request_queue	*q = bdev->bd_queue;
>>>> +	struct xfs_mount	*mp = ip->i_mount;
>>>> +
>>>> +	/*
>>>> +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
>>>> +	 * atomic write unit of BLOCKSIZE).
>>>> +	 */
>>>> +	awu_min = queue_atomic_write_unit_min_bytes(q);
>>>> +	awu_max = queue_atomic_write_unit_max_bytes(q);
>>>> +
>>>> +	awu_min &= ~mp->m_blockmask;
>>> Why do you round/down/  the awu_min value here?
>> This is just to ensure that we returning *unit_min >= BLOCKSIZE
>>
>> For example, if awu_min, max 1K, 64K from the bdev, we now have 0 and 64K.
>> And below this gives us awu_min, max of 4k, 64k.
>>
>> Maybe there is a more logical way of doing this.
> 	awu_min = roundup(queue_atomic_write_unit_min_bytes(q),
> 			  mp->m_sb.sb_blocksize);
> 
> ?

Yeah, I think that all this can be simplified to be made more obvious.

> 
>>>> +	awu_max &= ~mp->m_blockmask;
>>> Actually -- since the atomic write units have to be powers of 2, why is
>>> rounding needed here at all?
>> Sure, but the bdev can report a awu_min < BLOCKSIZE
>>
>>>> +
>>>> +	align = XFS_FSB_TO_B(mp, extsz);
>>>> +
>>>> +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
>>>> +	    !is_power_of_2(align)) {
>>> ...and if you take my suggestion to make a common helper to validate the
>>> atomic write unit parameters, this can collapse into:
>>>
>>> 	alloc_unit_bytes = xfs_inode_alloc_unitsize(ip);
>>> 	if (!xfs_inode_has_atomicwrites(ip) ||
>>> 	    !bdev_validate_atomic_write(bdev, alloc_unit_bytes))  > 		/* not supported, return zeroes */
>>> 		*unit_min = 0;
>>> 		*unit_max = 0;
>>> 		return;
>>> 	}
>>>
>>> 	*unit_min = max(alloc_unit_bytes, awu_min);
>>> 	*unit_max = min(alloc_unit_bytes, awu_max);
>> Again, we need to ensure that *unit_min >= BLOCKSIZE
> The file allocation unit and hence the return value of
> xfs_inode_alloc_unitsize is always a multiple of sb_blocksize.

Right, but this value is coming from HW and we are just ensuring that 
the awu_min which we report is >= BLOCKSIZE. xfs_inode_alloc_unitsize() 
return value will really guide unit_max.

Anyway, again I can make this all more obvious.

Thanks,
John



