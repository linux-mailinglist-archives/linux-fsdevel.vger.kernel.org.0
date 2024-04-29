Return-Path: <linux-fsdevel+bounces-18152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50498B60AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951822823E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17512D768;
	Mon, 29 Apr 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WjCDxek6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LNnfqUdP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE312A15A;
	Mon, 29 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413028; cv=fail; b=mmRDjdQx9G5/3enq8D+7C69+IxK994ukYzgEz1Ul05Ade/MCU9Jia6IRJCkKODul4Yp4VhZJRyOovVShvMTL84zENPkpZMchSa41tM4SEZB+WNvc1P0fuNC11Naq/e9Zf5qkL3hvhJ7Ngs8Z9aE1K1J+0z9DJm0/yvYCqa000AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413028; c=relaxed/simple;
	bh=Ih8tEafXb+2JqesJECMMFEeN+UBfXfympEoWDMU1txA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VesCaQYrZvTSO/w74G5ylMzYwWuqARolpDsB/6gyURc1E+ojEH54b8rBc0hOUKYF4k4FksH3N2mvuetRQtDpOLRfciitSXyEJSrQBM8KKSLrMz1sJF+Wgcn9GDYRcPLEMlLDiVffOFJNa6fE0Sq4II/GcQVH90klCPgxXpxa60w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WjCDxek6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LNnfqUdP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwkoC004990;
	Mon, 29 Apr 2024 17:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ZyOPNx/GZG5DQWwJEomXpGL4+JD24uptc3CmBdlQf30=;
 b=WjCDxek6gKk6eNvdgubbePAn38mAUF/ei+TNsVOMYgAnD+j7T32PAkyJtR3WPXXHPkpx
 ZkICQwFxiY1/fmOZqTevA0/siNZuREPNOPNN3T15BUe0A8z7OUfNBCxbwP9Gi71i/ZFH
 Ivt+FLsRmYVgS+706b2Wed68vNb/hlqU7TZJLYfKntNlJdwvHoJ2tHFKV88jV3RHt5T5
 Q++YQ1lW2Nqcxu9yuKjS/UtVffwQ0FnML0YQWgThxx1Hut1ZsTrl+IE/vM+Ks8BEgtfL
 /LDW3E5378l8jvRgyd9t+K712bavk9BBGYbwY74VrBm37BII6Xqvr9fTDkq4vZ1JwOXr 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdek6cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8k016783;
	Mon, 29 Apr 2024 17:49:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5/TDJWVWhIVKcmSXLmEXtVlnfK/QncjyRwdJbBj9GsF6ijb3s+iI8KwqpLcKmbMs+MH5A+aF5ElGcwvIvvBIMjW3GtUv54WLeyw4I+jwjxdz9NRX78GiSRXKY9oMH1iP/gUdQDpl/XVbTmnSlcFGzOQMeUyAeYKyW7ysRyarIuglWGrdZcZIwe5NdK/RH6mjS0kJb6b3OB0G+JoPPSMLAmlxdV+GgVVZY/qZGnfyd+BWQEOq32x6x4K4InNjp6mbnXAoOR1egsmzGpl61i/2b4vQVEpSnaaw8EW8G3EDOdsu5z85JHRpYoRevIhz8VtmBWx1eBwqGTk7Db9w/7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyOPNx/GZG5DQWwJEomXpGL4+JD24uptc3CmBdlQf30=;
 b=JTHxRYPx6vKiAR5Hly7dHMZeZdo+K4p8ojeSTgKPVY+FW73EWty/n/5J2CAb31u6cQ9Z2sUJwZE8PE3IVk/HCOMBxloqC37GetVwXOJajMPGon6YyxDuL1v/6qOYSWPc6nlALWieC4f8h72FlXRC3l8/xBiJ0LhTDx0wQbgYz9YtJoUhZGfFHzlJtQOHYFqkrDJuTgNF0e+WRIZPUheu4VDXSNP4jCnWoSRHU/3+X2Su60jpxZkguBcIdo6pY/42cNHtk8diW1sS2bKSck77p86BnL8JJZ+TTBHnjqW72w3oqDyhZvRaj15BftC2HEbTi79ZocBmMUFe+mbjiE6B8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyOPNx/GZG5DQWwJEomXpGL4+JD24uptc3CmBdlQf30=;
 b=LNnfqUdPxYW2MrQu1AxIdarx/kY/VMYBTMvO8f4eWtAktwctx+NG+VF2f04kkp0fmWv8xLP5uVmrW8EmBOBxQ0SUbJ7vz6B2+aXRIkj9qZfI9Te/viNLzOfgYdgIwICCZfPYh3CPSmG1+0ba6lDLNjQMTx6QgYXXbrPOse8SyDw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 21/21] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Mon, 29 Apr 2024 17:47:46 +0000
Message-Id: <20240429174746.2132161-22-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d95c22-3e3a-4629-bf1e-08dc6874a3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C2uPRdk1dgMU0OhO8jSZS/Je5nWs8jZb8ugzIedGsAmZqoyECI225tnOaek2?=
 =?us-ascii?Q?/cvo80EiuxXIThETi2OHyqBbi8kOnJq7Bfs7Oexm35I9KIh9LPdvh2wl6GEN?=
 =?us-ascii?Q?+vbnGgXY60muo3xGbNQ6jcc1i/5Udv3H81wid5QkrkGpAtswNr9jKdfqDmB/?=
 =?us-ascii?Q?lER3oDRXdIUdzFVu57zExWfyBfcO3eoGTT5kXHbCORr1aO8F6XMw8qdqtxB0?=
 =?us-ascii?Q?aKHPhDtKcM8bLw8NCjUvQB6tD/JxrnksflTuimp8KR3Sxz/J8FPGULQlD1rr?=
 =?us-ascii?Q?CdIvNTFnyD60Is6cInFefHKxQDyWRAK45gAo50uCobq04OGm+KNNn6INNOT5?=
 =?us-ascii?Q?ZMwxvaWsVgd8T3bN6cjFmdBiw9udpg3w7lcnQ5seS+SGsmfvMqMvRKo2tz+a?=
 =?us-ascii?Q?vTtVVTsR6K6qIJkykQmrx514NGKhpJdGkTE7+ekmVkKc/mw31ZEONMMUGvXz?=
 =?us-ascii?Q?3qYA9XCReH8e9vYbeQyXAbZbsuE0cpSB4NP+nG0aiq141cI1aVo9d2vogQnn?=
 =?us-ascii?Q?CEbJ5g8zn6l+7FLbHLoBJzYED7Jm2meFxjoMrcaOrkDcs5TI/Pwgr5jaWqSe?=
 =?us-ascii?Q?9rM46n16LZU8PcNBcTj67Ip1xMP0TpndOJn+XnPMiMXZ/AmJbuHD10RndvSr?=
 =?us-ascii?Q?W5T3GnkqXv9YJUDxrpzgkeES1dFwMfDrD2TQMZ/97zG4V0VsiCBs3jnL0NvL?=
 =?us-ascii?Q?sL8iD0bFZ6GJ98unh+c9FUwNaEQdAE5G5TESecknf5F5gN3AQ73uTzMpvl/x?=
 =?us-ascii?Q?HmOViJhCHtFT8WWocf8Iw2zlOekF9FsGpUI8E7Swo39ULYhqMhG+g/X31MMY?=
 =?us-ascii?Q?qUllnU97PNzso02o5w68OC1QvptLa2BG3vHVD2PeuglGJdIHbpLISlLTDKrM?=
 =?us-ascii?Q?pVDJaUgyU4VfHH30jSJ+fqT0CEXYDsF04Q996HG3yY2g0o5fOhNLv6upStBE?=
 =?us-ascii?Q?2c21bCazaat8pnHJGlDbv3211/UE10/FWFldzG8GeLA56Sonwm+a9koA0qVp?=
 =?us-ascii?Q?i8kWtQcAMEiuWUmoYjeFXktryGoqxUgzurxsdrdYlQlGKfoiDUB6ztUFwZZb?=
 =?us-ascii?Q?EOtbU0DPwbeyhOrVjuugO/eSnDNByLnTsI+cVH/gANnso9ZRB+K977mtyRsR?=
 =?us-ascii?Q?QV4gPBI5poAWmOrTcDgZvDr/xVi4KTeVZpvefNIsSLTW//yHM9CeAkGy0l2z?=
 =?us-ascii?Q?QRmeHj7lC1aucDamXGW51StEq4wp0LtkZRy+JsNbDqMHa8EdmtOP/P6V2dw+?=
 =?us-ascii?Q?ejh6yno7crx/jFVEDf6HjblPtbcWQ/8KaWtlLoLk/g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EzndzFO9mmdOxb0tNu3jSoXQWd9s0JzMC43SbgNQFbpZi159FvdFCf3r40FN?=
 =?us-ascii?Q?7Yhm4zNjsPbVz9N3v0MAcKslAhXagPdWu33SefR1C+HzTw5NzNz1tNjDyzeV?=
 =?us-ascii?Q?atMUbql/LuaqNQXVu5uvm/cshu48TKr52pusXIiiLhA4XQOnvyl0JeFRxzNu?=
 =?us-ascii?Q?4FtuY2MXUEmUW84TcNbyE6biylWUp04p380wwIYsoSNew39IQvyBCT96AJiO?=
 =?us-ascii?Q?1b9xbjE23xIMGSd/mE0zEIiou7K8L9wJCtJRIkbzjuoAZiv81IHCsc4PQ88i?=
 =?us-ascii?Q?AZStcoJO+b0VafA4uWSiiLvQ+OeLVPJmsFNVSlHo4CYUsyTte8FnEHRKrlXL?=
 =?us-ascii?Q?PzSvKpa+597rGMt6oklid7lUVwsNHarxJ4SUkXD8A1kP0JvL92iO2BB8w3lk?=
 =?us-ascii?Q?y8Hg7GoEOoHR/5V7IxEaG1o5YMCkLyLpYjGVBG6A6xHkDfH/gG6mdlxfbNK1?=
 =?us-ascii?Q?aNUNny2dfCjyYHjC5Tbs64zU20IPJQ0Xc/4phUwFnU4cAFUdNuDPqvVV2Abl?=
 =?us-ascii?Q?FNJpucLlaoROOfvA000gYMCHj6oI+HJAomjHn8d5CcneLZXu8oKbHxDTfvpF?=
 =?us-ascii?Q?AAD7PhyZh+bqHtcwf+st0t2mOgu4Ms632MFn36DWmCMBegDt7TZ3hv1j5JM9?=
 =?us-ascii?Q?3nwLrCiIJHH+ozeQZYa8ksUKuXT61rg8dIwqc9hCfa1U6LZNWC8A18M0vNYf?=
 =?us-ascii?Q?6eqTp63Xv9qVGbrJKbWwjDv+NHUZSwc1rozVq41zwcZYR1IXRJlV2dLVTP2B?=
 =?us-ascii?Q?qmqtdhC1me0FgfPD0V2+QctoMEEo7BZzrHF1w1bKjRVzia4PhghhY1F4FLZX?=
 =?us-ascii?Q?DQFXY4anoP3Ac9TVprTgopANe90HjaMtw3v1r7yEFj3At9JVWuLTH8NfpGiD?=
 =?us-ascii?Q?ck7PDo5OCIPUn3Cx1vTMfn5I+oNrpMfqwK2XQCJxYkrZe5Dcu4+aD2Fpo5YM?=
 =?us-ascii?Q?8ILFXKIACVKBCYUTE3+yZjCtxEiLpIdstRq5Cjw2rtcyVoEzDPM5W3mI+W7G?=
 =?us-ascii?Q?+6xVHkSCyfzyQ26eN52RpqeGmffCzYj/4D9sfhZTg84Kme7RsCSumyjMCi7o?=
 =?us-ascii?Q?dnw77XIKtYuaDMsa50GrW2yuAaCxN4fpvtZfTUxTdmRa0eW/89SVVduEbMLP?=
 =?us-ascii?Q?LA6SrHzanT3cgbQja5fmELHFQH0bUSkro4vDiTrOG59xR3U/PMmXaTwU9zOc?=
 =?us-ascii?Q?eG9wpNn/SZRrqc6J/pkI58A80d0uHkU6Pt1vC4wqUjR2AAmOKexxx2V1ovTe?=
 =?us-ascii?Q?JhmDoIY0NZjjZEimCArapqtsFKCZniKVTRDdIxyK9croYbC+0zGk6pmyklQF?=
 =?us-ascii?Q?21O7bIGrqD/jWaPEza1zMaARoX98asi35Rx5HAkZCcdz0WbW2714xzKPEgJa?=
 =?us-ascii?Q?jke3zI1ULiRgLCJGvzadfS9rdmiokeeYnGMjuTTewC5tv/JdK+Lau1d3+Gwe?=
 =?us-ascii?Q?e9OZsoNYc0h1BoGd44snU63Vg5Bsy11ntWBy5BsciJOIWvMbXvhn4x8G+anx?=
 =?us-ascii?Q?3TYwKGeF5cL/kBDZpBd9rQ1HT5jxrbH1HjsuKVxeGkiZVJvoEWc/aHaeN6Cs?=
 =?us-ascii?Q?vU+eDvv5uws/hjzpzAlXFVhmbMVYpuU6kF5gD4sAZDU69TQWa4/O1/Lo/fzo?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DCL+H1S7IGw/NpvVz24OvjhZPYHXEQN6Te+vOujKE3hqMZx8+b8VQLC8yBL2Te+BGu8fdVtmivQ5GN8XODQW5lz1atDTWd+Z/FzGpEijbOZZjVkyZS/B64FLJybFB+GMVrEUaId1Nx75w8K1N0DWwpmGVNskVElUlQHcgrk0u2PNi1QQorJQa1HHbXY8mgtUdmujjBqC+b3zXoTKkh+f27Yg64K20vOpCDW8xxyk7ZqVPapKpjNSVsS31kgX2L7LgkOMhUXpgF2Nm9Dy1cxwb7W2JhBDvcSZ6QE3wctDklbIk8opa7hVoSVPeNUSHioXWkNoGXvklhdmcPHcQK9G2IUgR8l6jngvP5IDfCfw0S3mBhqPsWhsVJ13cjT8TPtlWr75GwO1ndNe3dK5yXC97uwMrE62hn/dVq6zAisiUeeQ59S0fpAaU/J/vVIwebZ8OqKLhIELS89SJq7biBz+RUMfg44EX96ZQCeDcgzX0w0vSjSa3DS//5ZZg21UakBnI6V6FNOVeXAhaVWlqcgjcK6/bXp7PtWr/zvSaZQZmNhjiIgZ+5ULNxu28xD9qWH2YfxDZgzNcoMJie8brMRESOgVBELOJd2NPfERi3wvczk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d95c22-3e3a-4629-bf1e-08dc6874a3ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:55.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs7qsxWzzj4L6buyIbrWfBPdt/uRID1FcPHgOzUjT+38Fdke7YuUQNFhcfkNKz7+w3b1lkZoyTVhyXFSfqZUhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: u710AV0qDp4fnXW7X_rA97Mn2cxLE4v-
X-Proofpoint-ORIG-GUID: u710AV0qDp4fnXW7X_rA97Mn2cxLE4v-

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag. Only direct IO is currently supported, so check for that also.

We rely on the block layer to reject atomic writes which exceed the bdev
request_queue limits, so don't bother checking any such thing here.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 256d05c1be6a..5a17748eb6bd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1243,6 +1243,18 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+static bool xfs_file_open_can_atomicwrite(
+	struct inode		*inode,
+	struct file		*file)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (!(file->f_flags & O_DIRECT))
+		return false;
+
+	return xfs_inode_has_atomicwrites(ip);
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1252,6 +1264,8 @@ xfs_file_open(
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+	if (xfs_file_open_can_atomicwrite(inode, file))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


