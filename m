Return-Path: <linux-fsdevel+bounces-21229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D23900771
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BAB1F26508
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531E1A3BA0;
	Fri,  7 Jun 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AcNSrxWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0FGrt/U9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728731A38C8;
	Fri,  7 Jun 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771293; cv=fail; b=sxRXwqIeCg1CqelC/O8VrRzezhTRWUNB/lrgJ9k1bVUZ9DndDiayZn3NC2aa1SmnocqaT9c1TGDgp0NUZBT30l6OX991+V8kNn/S7tjkCpSEm9TPeWi3noahzyTiVIbmsXaOnKB0FXtGrzxpMU7XY8VsErayJOzlU6Mve9jvLlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771293; c=relaxed/simple;
	bh=3sHjr/Ftofo6T38UOr52L4eA7lcgUsLKml3vb3YzFKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDAJseapvdMEvgtnHKwZadxV7p8okMZdz5e48Jp3lvi9P0Ae4zAEzSFhVI1yi3Awl8Q+KTv+9b1qjriDZOLNbfdTiKRaQtCc+oS6sqOdu6Qdl5/fr96jMGGG+LzJwLT79J5L1iWGcw7F7FyyoLBgF0Yw5eh9roLpsC5xN0mJzNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AcNSrxWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0FGrt/U9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CudSf029350;
	Fri, 7 Jun 2024 14:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=zID2VaO4owY7owz5ciwCNbLgt6lFN1UrQvjnzwMAgy4=;
 b=AcNSrxWc9+q+PQqVyYBpupkPfdJ4j7/23FCzDFGAzascZv6uQgiypQ1U66Ilip/ZrTqw
 Pj8N6ksELLcjqdMGRGwKPXOSH/5JiesQfdcipOPyz/htdjwiDx0ZuxkDj0tkcK88hykt
 kjcCDjJjRVKREuwsSAvxQrcJFVguBBM3yebLK3AXLKKpAXdiCETHvXiaOW+oH5MSor2R
 FFgwA33lqWvK2SYb3tFrcgjEF5VWq0Xz6GHPr3te2XwxfRVHiy1k/tR6SqXRX9b5BEpE
 qTUTRlKhZNknS8x74QkKa75ll1U6+e329d+49O84Edrn8xkMcpO8gpXtyR/PyZE2NJ9M vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbuswskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457EPEMM020535;
	Fri, 7 Jun 2024 14:40:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj6nshd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShfqC9zXi+fHTOOAZ9GY4dbhGlijSesTqrrlu+jNj/MHPm/yJq+CjI8rrjLsXOXRdlDz49GaKPtNnmEAykGuvpidsUCUJU6P9KnbUsM2RZqO6zl4pKGgT3xP9pALzIQEVrmXZeJXOxVtCgKjZCWxkyUXPhXQ+slFJt4c/FUs1dwXQLHKqDVf3Wn+MQWwkqNZGOZvS5oHuXBjXB9179PktUwelwoZrUSwJEoyPUTsyODvgpJ11wyTnP2biJIG9qG9eEFmbxrlJywMYeTCxzsr4t0KJpLcyEyVVQlJNDK9DbHJ1XqRa0nqN8gzJ0ys1ZhBcrwx+56DgFYijkzTI5ZOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zID2VaO4owY7owz5ciwCNbLgt6lFN1UrQvjnzwMAgy4=;
 b=IEwxzV0AYyGwvz9jvHe94146aaFl4wCvAewEbf79XJixsL9gg3h6vHpzvNodBFmIr+IQW02YZATNTp7wfN8AIBGILVIPXF0FvbxNfPMQMEiJCDYig4nBEsI0Vv226+paO8W4T58frCUlAMeeuMTTJ+BQtjGQF9C1QRVdCKburD3oeAH+FjzQDcNgqgba7vGsmkTqJi8eKo2yUoD0/zGcO8T7/MdMyDkzGy189BzX8jUw/o7e6PutGsQ39Y5+YaCh5LyuPCx26lY6qYwIimWh539g6SOrMD0lXiWzDXERUgz5FwoSzSQ51tx0FttIzpGwjaMmcYtORg5ABUiR79EqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zID2VaO4owY7owz5ciwCNbLgt6lFN1UrQvjnzwMAgy4=;
 b=0FGrt/U9ypEJ3d+XkEhdLXBvULFMVY0v9qazwgxD/RWueS+708LecbgloYWhPQM44+8E80U9L+8frbLJXuFWrMGcD+8tjHvyEO9IcpCpeU58pMMBIvl62KJoq4B+v/ZJlM+uCEH3eJg4j1FofQ+MlHaqWgvx3FG/x3VJnBhGiw4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 19/22] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Date: Fri,  7 Jun 2024 14:39:16 +0000
Message-Id: <20240607143919.2622319-20-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0665.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: bea68487-c86c-42fa-fcec-08dc86ffd37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8Ia8QdZ2OiKDeYh/KVbdvBVqjBNY11WJS90pEbaWld/25sWI27yagH68LOUT?=
 =?us-ascii?Q?0WL1RMoy8onx3ZI4fBb2esjJh8L55a011UKSPognowyY9IQhQdFdNX9aRrER?=
 =?us-ascii?Q?uFLHf73cnu9E8+vkmNN01VR430itf/bPXwVSm3IapLUUsq+34geri+w7PATO?=
 =?us-ascii?Q?JEe9KlbOWSvhpsvwupJMvT1+ajxy+csHOxt/KzgXRHc/+atQeXbPG7cX8ZC0?=
 =?us-ascii?Q?Wsmy9XesQRRu6wLpjL5XxvgOJh36sXb/sLM7nxPTVk1g7GZnSzFtKKXl0mBD?=
 =?us-ascii?Q?GKIQ6asEaT2hnQcilUCGgaHYQQ7rq28GfTxy7x0P9gATEWUJcBqo6pbsojVW?=
 =?us-ascii?Q?anEc1+2KyPQe+zDvoIYTqvWj/jki4G0ZA0D3EMFHcol1T7DW9xEUBxpVq6VJ?=
 =?us-ascii?Q?+c3ppmif7sMBMAeaPIo7k8Jy1Egf+08qXgFagevsO1QeJ/Mg052TjKVpaRLr?=
 =?us-ascii?Q?PCxMj3PNiPBfigJlHG4W4cSlYORVphgVTjhBJJ42wfKCf36elBxOFIUxGd3x?=
 =?us-ascii?Q?OrAW9hjknIQ1aI0US36N/0Gaz/8DmCBFfOW9kAagnYgJCXsa4kJy/1ODqDKF?=
 =?us-ascii?Q?Qu5nKu7oNgKeW+BeZz/LdacpU7LCUnFt2/wY8xmm4P98U8SZ9lrjK1/38+tJ?=
 =?us-ascii?Q?DQv8ou3McsjFMqbX6KWoHPl82SW5vByCHqJL+ynrZivF9lTeIJevlqG8LhBG?=
 =?us-ascii?Q?sRmrjFNurIs0gqfkyNtyPqdKirj1ywVOH5iHxInGXGKywktMy71ROxOX4JdC?=
 =?us-ascii?Q?5Qaesx72dNBjp7dO2wuvGidMUB7FmDbgWRuLpTOCz4kFS3chCPnZPtv1h/LU?=
 =?us-ascii?Q?1DuId7mRwFXsznv2h1T48xd8AXpHskqJnv3Ofi5aHeipWgV66E1rA2xUgAZP?=
 =?us-ascii?Q?I3uwbjWT8iY44wFhYi1TVrExShnDYuZC3pHAwxwXVlsQikQvdkmMGaSeiDID?=
 =?us-ascii?Q?HM9Hc3toASALI8YTwV3RKC9d2WpxlOMWJDsb1yZ/eaRANmqO+pQu1DfyUOSn?=
 =?us-ascii?Q?Inaoaa8khp0+Aw6V6Z+BFtyg7Z52PnJ2UaUoLTMRgBPgrAZYbfTrn6v9WhyW?=
 =?us-ascii?Q?wIxd3pBJ7QHurUIvGjCGzf3mrc1Dd43UMpc9HwctNTGc8jQAa9FeBjg7cHcc?=
 =?us-ascii?Q?sYpZ3wapKLrz5Q6e7aWO3TrBw1sNqMTtzNELvXwGf1dlMl3N19P9/t8yzft9?=
 =?us-ascii?Q?sK8gxnZlqVz0cC9hKnGNfIXCpy2PeOopSvytoIczx5//rnBHMKRpM61ccdJc?=
 =?us-ascii?Q?oNU7T5JN3cMxpUqqQs1UIh9S6S6lw1yc5eo6pES8Gq3F5HYEmLczdemjCMc4?=
 =?us-ascii?Q?vnmkYyGhd3JXh601x0+baTnK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GW0L85r0xtxvS/3BhJ8IWRxBwTMhQJ1BkTNbD1ZZA0kPES6SzLv28hT0hnJP?=
 =?us-ascii?Q?QvdOCYAnY6xNalvaPeGNFjo0aaJQzURxZHS1tzoOROdL3hEEgBSdHaCP40zk?=
 =?us-ascii?Q?MWKow2MHGlWg6zotElNOv5FKJuJat+whouE57KLE3m64b3XcXx3DRMW8w+ru?=
 =?us-ascii?Q?dbssbxEiQ5zNR4QATXxdFw0RvHwT55cLhy5QsHT1AXSi321kx+8AujDOy3iL?=
 =?us-ascii?Q?hHYJgZH5XTBbXxDv/ix2Ah9T9Mw6PXdHSzDZhFE+Q+knJi6La/MWnBcDYaEv?=
 =?us-ascii?Q?xuUQRKBFs4ThSldkIA6a8IlOdIB+6DlcWU61WLyDSo1aj9TV72kBi2ZGNJS7?=
 =?us-ascii?Q?uJmJ6kLQaZNMx7er7vMsoEjKdVRZSfN9DJag0hb2G2bhzJhAp3vADeKqhYaW?=
 =?us-ascii?Q?Ve36SznXIpzmiG2yx6scGlra5pRsONU+xLUKHNG+lLbxV0tMx8OHI5LCqlY3?=
 =?us-ascii?Q?By0LK5SEPHhGcskAo9lNaXgs+9bAVGwgUs8Z3XoPzVJ4Op//JoICugujcx3q?=
 =?us-ascii?Q?1N9LlptvOFIsElSgPnxuaTDx/4I4d48EW/UopWX8OpQgiY4R+jHmiVceFppj?=
 =?us-ascii?Q?cSwviHDTLzQefLiTfA2+du8ykC2cpST8BnWhfVoFIfJ/H4vl0N5SH1HzDfRT?=
 =?us-ascii?Q?ZpsVp1JYs61oje86emzrKRrnhqMyjmazZYDm/xIkIrditEk1ayqTJ3TmI8yx?=
 =?us-ascii?Q?Wx1k0V/KcgyOLdW/9PEa/JWV/BFN35UvUdnOojzqgcR/gZyfd4C+UMd/FzNC?=
 =?us-ascii?Q?9fWDNG3nYOsyfI5uMpgrwXXqF5G0R7jmqK5Ojs+TejQXrPlMRWGnW+LesHSD?=
 =?us-ascii?Q?ysFVRRZm5elKNeKpbpi8MS8w4uIMxTbWpZOBMszPwto1eY65PPzla61d7kSV?=
 =?us-ascii?Q?0Y/a/hVb1vZ9g4E2n3cNLhgLQqzjzF07cafC1zBSxGkuJwVEog14rwBXn7nL?=
 =?us-ascii?Q?71q1MKiLGAGSrxndWxNY++LFNU7F29RNjEU+dXFVaREwxkWrDlIBuH6C4hvT?=
 =?us-ascii?Q?yKr//5EcqN92f1L7Vr+Qg5OG66o4yLkW9rUU/J5eG/pScXdvChGJV9RgManv?=
 =?us-ascii?Q?yYieJbP2cCCu5cVZlT2k1kCeXMvwrdjpvI+n1ZM4XsxvXBydhiU+JmF9M8hf?=
 =?us-ascii?Q?zRLmJojHp1yRaxuwu485ldOjX5z74AobkClHZ8kexwL9151USzU4rsx7zGZj?=
 =?us-ascii?Q?coVyditOydfXY/zqQ3Z/sLWX7l9R0kIqak+nk6/m/OIffRpatWCrQQl8jY4J?=
 =?us-ascii?Q?UdYMlA5Ckbf1ZgmRwmCl0Am0sSQrkcGzZkEI8brdW9qevlKFRgoghCsh6zUY?=
 =?us-ascii?Q?27QYT+xCeHOT7mpctfflqtMANwOGCRjxbP6iWg1TZ5516Zfzw4bQDLKPsPzF?=
 =?us-ascii?Q?PX4ePjn52YQfTmHbgI6Dz7w1RRw2V1TBV28+qRnFl0Z1ruWqcNazLXzPY+Ta?=
 =?us-ascii?Q?PRGsEqIjFY3Ki9gfJtmFsTrTEdiQVVVwq9PHbeZW2lN1kg7kUZdZWY+5wk3i?=
 =?us-ascii?Q?ujKjNEVNfI0no+rLDiQPGabTuwIA1JeMer1+OgpWQsGEN5ovd2I+/3rXxEWK?=
 =?us-ascii?Q?G004hJuEPJ2VTdS3PICE7uh+Yzen/fU2aJufwkI54ok1I9lH/SoI7OkPX2AD?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0wekw9eo3F5D1dVAh3H0HDdQmsRicb9wm0yVJAp7X0WtJa2TjFYbdYPpSrtk12A42DwP9LeKnyXsM49aY14oR2nSFNvUXfueLC1MQCUL6j7ybP20tGI7rahiJryDxDEtQFMQ7+OydKA3MWUSISsLVReBzog2sl7JbXWpE7HG5cL7lzKwK33w6x5c2WWDrI69DXBtVKNGoQA3AeK/ApWZzFeOF9uTx/Tahca2sllmXnl3uHaz55coveu8iHGF5sDzVDSB1n3msHCF1pjtTVwJHieqU3y519Qvti8O7a67PbM2uSYsPGexl7bFLs3W2q8D6SiJDFCAA/ZNURSO+vO8fzLnVvLg5skU7f4qia1S9aEBMhynMgTq8Q3xTq30WB8JjAUu5ECAYNfDyBB8L6gxyFvBmH2fYWyESMXurPQF5R5In158feWGHX0XcD+FSrAN6V6RV+3TaQphmtBd2NuEKRWII1tWXDtk7XhZIhMndOhNPz1UDXxosyWGHWl2mD1dt1YairKCh/stIafxv/4RLzCK1E+EVf+tZqEfQXmmKfDCv9rPfPIMZ9plADuJ1v9xqeKnYDsS840Ax5QVvSVtpz+7ynV6nFS9qepMs9H7yH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea68487-c86c-42fa-fcec-08dc86ffd37a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:50.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFwk/wqZqb5mDQuWE9PH2uaPH+5UWu3d4Weyqfi5xQTHi3Qf5zn8ZUxpKyHSQLHGTyWEmH8DzXpZ3R0iusQv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: RK9mA2lrRSBP6SNLYOG-K0WT1thburZP
X-Proofpoint-GUID: RK9mA2lrRSBP6SNLYOG-K0WT1thburZP

Add initial support for FS_XFLAG_ATOMICWRITES for forcealign enabled.

Current kernel support for atomic writes is based on HW support (for atomic
writes). As such, it is required to ensure extent alignment with
atomic_write_unit_max so that an atomic write can result in a single
HW-compliant IO operation.

rtvol also guarantees extent alignment, but we are basing support initially
on forcealign, which is not supported for rtvol yet.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    | 11 ++++++--
 fs/xfs/libxfs/xfs_inode_buf.c | 52 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  2 ++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_buf.c              | 15 +++++++++-
 fs/xfs/xfs_buf.h              |  4 ++-
 fs/xfs/xfs_buf_mem.c          |  2 +-
 fs/xfs/xfs_inode.c            |  9 ++++++
 fs/xfs/xfs_inode.h            |  5 ++++
 fs/xfs/xfs_ioctl.c            | 36 ++++++++++++++++++++++++
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_super.c            |  4 +++
 12 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 42e1f80206ab..e20880b6aff7 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -354,12 +354,16 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
 		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
-		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1098,6 +1102,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define XFS_DIFLAG2_FORCEALIGN_BIT 5
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
@@ -1105,10 +1110,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
 #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index b2c5f466c1a9..046e72481b60 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -178,7 +178,10 @@ xfs_inode_from_disk(
 	struct xfs_inode	*ip,
 	struct xfs_dinode	*from)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct inode		*inode = VFS_I(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
 	int			error;
 	xfs_failaddr_t		fa;
 
@@ -261,6 +264,13 @@ xfs_inode_from_disk(
 	}
 	if (xfs_is_reflink_inode(ip))
 		xfs_ifork_init_cow(ip);
+
+	if (xfs_inode_has_atomicwrites(ip)) {
+		if (sbp->sb_blocksize < target->bt_bdev_awu_min ||
+		    sbp->sb_blocksize * ip->i_extsize > target->bt_bdev_awu_max)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;
+	}
+
 	return 0;
 
 out_destroy_data_fork:
@@ -653,6 +663,13 @@ xfs_dinode_verify(
 			return fa;
 	}
 
+	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		fa = xfs_inode_validate_atomicwrites(mp,
+			be32_to_cpu(dip->di_extsize), flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -864,3 +881,38 @@ xfs_inode_validate_forcealign(
 
 	return NULL;
 }
+
+xfs_failaddr_t
+xfs_inode_validate_atomicwrites(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint64_t		flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_atomicwrites(mp))
+		return __this_address;
+
+	/*
+	 * forcealign is required, so rely on sanity checks in
+	 * xfs_inode_validate_forcealign()
+	 */
+	if (!(flags2 & XFS_DIFLAG2_FORCEALIGN))
+		return __this_address;
+
+	/* extsize must be a power-of-2 */
+	if (!is_power_of_2(extsize))
+		return __this_address;
+
+	/* Required to guarnatee data block alignment */
+	if (mp->m_sb.sb_agblocks % extsize)
+		return __this_address;
+
+	/* Requires stripe unit+width be a multiple of extsize */
+	if (mp->m_dalign && (mp->m_dalign % extsize))
+		return __this_address;
+
+	if (mp->m_swidth && (mp->m_swidth % extsize))
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index b8b65287b037..c7613b1a05f2 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -36,6 +36,8 @@ xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
 		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
 		uint16_t flags, uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_atomicwrites(struct xfs_mount *mp,
+		uint32_t extsize, uint64_t flags2);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 515f5dd23b6d..aee285899ffc 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -166,6 +166,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_INOBTCNT;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 		features |= XFS_FEAT_FORCEALIGN;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..44bee3e2b2bb 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2060,6 +2060,8 @@ int
 xfs_init_buftarg(
 	struct xfs_buftarg		*btp,
 	size_t				logical_sectorsize,
+	unsigned int			awu_min,
+	unsigned int			awu_max,
 	const char			*descr)
 {
 	/* Set up device logical sector size mask */
@@ -2086,6 +2088,9 @@ xfs_init_buftarg(
 	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker->private_data = btp;
 	shrinker_register(btp->bt_shrinker);
+
+	btp->bt_bdev_awu_min = awu_min;
+	btp->bt_bdev_awu_max = awu_max;
 	return 0;
 
 out_destroy_io_count:
@@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
 {
 	struct xfs_buftarg	*btp;
 	const struct dax_holder_operations *ops = NULL;
+	unsigned int awu_min = 0, awu_max = 0;
 
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
@@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		awu_min = queue_atomic_write_unit_min_bytes(q);
+		awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
@@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
 	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
 		goto error_free;
 	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+			awu_min, awu_max, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b1580644501f..3bcd8137d739 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,8 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
@@ -393,7 +395,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
-		const char *descr);
+		unsigned int awu_min, unsigned int awu_max, const char *descr);
 void xfs_destroy_buftarg(struct xfs_buftarg *btp);
 
 #endif	/* __XFS_BUF_H__ */
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index 9bb2d24de709..af48a8da2f0f 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -93,7 +93,7 @@ xmbuf_alloc(
 	btp->bt_meta_sectorsize = XMBUF_BLOCKSIZE;
 	btp->bt_meta_sectormask = XMBUF_BLOCKSIZE - 1;
 
-	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, descr);
+	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, 0, 0, descr);
 	if (error)
 		goto out_bcache;
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9c0ae5c3682e..e8d7ad4e6d38 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -610,6 +610,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_COWEXTSIZE;
 		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
 			flags |= FS_XFLAG_FORCEALIGN;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -758,6 +760,13 @@ xfs_inode_inherit_flags2(
 		if (failaddr)
 			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		failaddr = xfs_inode_validate_atomicwrites(ip->i_mount,
+				ip->i_extsize, ip->i_diflags2);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 7005ea29bf11..1e8a8778ce0b 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -334,6 +334,11 @@ static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
+static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 5eff8fd9fa3e..2877553b6151 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -527,6 +527,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
 	if (xflags & FS_XFLAG_FORCEALIGN)
 		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -567,15 +569,45 @@ xfs_ioctl_setattr_forcealign(
 	return 0;
 }
 
+static int
+xfs_ioctl_setattr_atomicwrites(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa,
+	struct xfs_buftarg	*target)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_has_atomicwrites(mp))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
+		return -EINVAL;
+
+	if (!is_power_of_2(fa->fsx_extsize))
+		return -EINVAL;
+
+	/* bdev can actually support atomic writes range required */
+	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_max < fa->fsx_extsize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	struct fileattr		*fa)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
 	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
+	bool			atomicwrites = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
 	uint64_t		i_flags2;
 
 	/* Can't change RT or forcealign flags if any extents are allocated. */
@@ -604,6 +636,10 @@ xfs_ioctl_setattr_xflags(
 	if (forcealign && (xfs_ioctl_setattr_forcealign(ip, fa) < 0))
 		return -EINVAL;
 
+	if (atomicwrites &&
+	    (xfs_ioctl_setattr_atomicwrites(ip, fa, target) < 0))
+		return -EINVAL;
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 30228fea908d..0c5a3ae3cdaf 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -300,6 +300,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 29)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -387,6 +388,7 @@ __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
 __XFS_HAS_FEAT(forcealign, FORCEALIGN)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 852bbfb21506..85799bd12e92 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1725,6 +1725,10 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 "EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
-- 
2.31.1


