Return-Path: <linux-fsdevel+bounces-18158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111A8B60C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CD81C21B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8712F58B;
	Mon, 29 Apr 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDwfR8jM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LcON0kwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003512C478;
	Mon, 29 Apr 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413115; cv=fail; b=a6WkocxjHNMaBGeP0hGheWSmVXRI+X18ihyUacFx5loupM1wNGTFl9WyJvHFD/UddAjSm5VRnFtA6NjZZMl8EG1VNnU8ZtV92IXYIBpeEQYgdbvB6tEROqAAZ7TQuDVQysPnsER3DZDgg+2241Vq0R6VFXWCSvrJ2Pp0eMPTvYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413115; c=relaxed/simple;
	bh=C1uPySa2UjoSalJxT0kJkpre/zMPk3DE/vNubo+9YpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnViW9yaz51CiCpgILv6fIPru3MMMifWwG3XuW65I8rp690mtImoquCQbE1W9b3dU538oVjf1/FxZMr8sy7M0rHIopYd8z0qN9ZrXoaAW7+g5z+DFLjmcdi9ghJlm/tZwf0ciGVR5r1mwy5qxkBzRs6vG4J5pal1YFqY4XF/HME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDwfR8jM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LcON0kwL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwuFE030165;
	Mon, 29 Apr 2024 17:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=z3RLnYUNaSWXsZvwZ1Zosbq05DKqEiYU3IiL38q9lZI=;
 b=NDwfR8jMSa5eXTxvP18eOUIHqz6t6bUQ7FyHxf1sMP5hLPw986L5n+G6Uhj98yvSO6zJ
 pixFhXqGCooT5Nr12sGqIPtQMcxDQnyo60HRX8IJJiHMDA6s0pobyDIl8wHGGPHF/lKe
 LASEnX88AaMbfjBkGdVhcGSh/msysknjEkh/hizHLMirTumoiC89kGyitZWfkZeqRWvu
 6uPoYmva9Qc7TQGpNj50f9C/YCo9rw7jMd5v2yu0gJEtOWE8Ai4XyMffAlrQ4oCRQjye
 Fa6DFm5fIrxMolqR8hq7C25IZ1M4Sll542wP2S81Y3HmxOY2RouZ+V76fk57pGK9gGPL nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv367g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8i016783;
	Mon, 29 Apr 2024 17:49:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLuDBpvSkkDTstdTX5HEcF+m9WHb04K4Y3h/BEWinbQ8pkLDS4sTV4NrHOhrGDA0JeHpA6sdqamlf57On+marQV39WsPgQDXj420qvlB98ciJztFfubI47kteK00HFfOMg5sgVjM91ehdn5qmLH++JtfrlnWohJGgtsjXCjYBfkFT/gbJvI1j3fSkU+iabqCFC0u79vDd7fHly60/l2o0hXjkUTMFELEVsqO+KGDK5rV1FCfQ3dAtO/wbGPb2sHwq42n3krVMX0KFmmg7r44GJgh/9y2Vn5Ayd1cx4alJA+x1Fwer8eTDImAB1uZAlGy+ZdqkWd20s66NW+jKx1x2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3RLnYUNaSWXsZvwZ1Zosbq05DKqEiYU3IiL38q9lZI=;
 b=UFRz5oQQGCp7qoXVV007mg3mNVs4u+Ihx3ei0XpgVMhqzv4D6grE+mA3MrVVfpO5xO/mgYjWp1jM/7Svgau5utEmLMFm7QMCRSkBSVhgoVEneX4rRZwMncTSB/MUe9eQDv9PJ39O7JIRarey+GTBkEXT0w+d4Sb4yU2FmHqMNogftWC5TkGSvAyhXeTJdqSCVzxA6z2JnSywzfVbmFbXG4Xwy5FEwFSdcuPI+8ArGmLFoJBoQs8JXFNoL02CAGwq8ypo1rlUexU3LRVRbr4YU1dTuG+dcwlKVgWyjA9tOAiEuBGuloUqL1DdCd6p7OrmROMURGBo+kS3X+dWfpON5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3RLnYUNaSWXsZvwZ1Zosbq05DKqEiYU3IiL38q9lZI=;
 b=LcON0kwLVYPR9pK2u4QMa9c12UFadLgojZnbsAUOvPPkX89jKbnoG4/MT46bjlSaTkS0UebChxLhOnVputWu0+BEWJkh23k5/Bu2AMtXpif8QXr6QDNDY3qrm8uvjKrVY2Wagga+oA2EruuvtRKeU4nyoQwNg8kacROlpSsL5/g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 19/21] xfs: Support atomic write for statx
Date: Mon, 29 Apr 2024 17:47:44 +0000
Message-Id: <20240429174746.2132161-20-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbd49e1-164c-4313-363b-08dc6874a154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EUhuJzqmBGx76iKfj4mpWTyIh11+/gpcYuXYaDi8s/lfYG7e6QkoNC2jrWhk?=
 =?us-ascii?Q?JSl3Fhc9VZb4q3Egwe4T/ElUakxm5Dtl2M62k4rZDO35a5rCSWsbRYPbOkSQ?=
 =?us-ascii?Q?Ou0womDYnLFhhSbU9x90VIIl6jVGEbGlyv8Nf+rPQ9zTVqFYqgOa/7iPwRXN?=
 =?us-ascii?Q?ZG42z78jsL2mnrxRIvKdskzkYU0KX3ZlCSCczmO0KZBOCI3c7tK1t4sX4yBS?=
 =?us-ascii?Q?JJK/qDpmvJax+HOAQFpHDrOiIvKzpNW00GuT2ApMkM7ixC1FoYbAIQfYMyZv?=
 =?us-ascii?Q?JbU9uR9ROeDftdEzvQLYjxakG+8zKHSH0uApqmk/FsI2C07MpNL/x9nL/drH?=
 =?us-ascii?Q?DXMIz+75/XtKC4P99445s1tzcJyCfoNPpewdG9y93WY1NWhS63jNLCPyRQJG?=
 =?us-ascii?Q?DXNDKDhYEhr6FKrh/zu9IZYdez+4jzUjwsBMP2iS0ThZpVavN3JTcFAV8FWa?=
 =?us-ascii?Q?KqqD4JD4sR062x2/6ejfzCral8u/bQvF5JFEsm0GH6A9FjB/KiibrDsPn4cm?=
 =?us-ascii?Q?2eoSnuWFSsC59ujWAFxE+aKSv8kaQGU0qDFv/MOP8AfZCqPFu9MAsksG8rCu?=
 =?us-ascii?Q?lpqqWN9+6lG8mNPdozUbDaRVM2FpM9ueD6WqcDGhD0NH1LS0/njRo/+VtcJf?=
 =?us-ascii?Q?S0P2fjJfIlJ6ZIcV5L1uWWzfju8szoWrEOTSu2ebCq2nl32puwqT7Q41wHBn?=
 =?us-ascii?Q?Er4F2XHDfoBbVwS84iJUIzqZrBlGiHmOWsB27ZMpCVgeZp/kzq6r2PxmssCi?=
 =?us-ascii?Q?4zEt6r8MKQJbCA7B5Eql7qWAlhxsz4iqO0wiSgoeW5VrY5wsZoRmhFcBIDS9?=
 =?us-ascii?Q?gwg+DoSW3KrWkgqsfmrMa5Fd+3ZwiXPHuucU9FE9YbNk29+f2nKYgwQts22/?=
 =?us-ascii?Q?mJBmi6MZJHo+tOzDx3LtmEUWEDPTRUL1PupbTghzh6WmsQNCwd1ibXAXpM06?=
 =?us-ascii?Q?8OQYGvQXhbQBQNk+Sog436Sv5yptc8hFY5ewIqBn/V/XaMDcg5+iEu3C0WbL?=
 =?us-ascii?Q?bCE+dZT8UOb/34pw3QTjEfLz37K7Bt+7Cm3TjaBE3Pi3ZYcJL3W10UABuyzR?=
 =?us-ascii?Q?g02eC0hG+v8escI3Hp6WdVwWHdk2lWhf1YBF4cTEkYoW5J12pZ72AOT6IxQN?=
 =?us-ascii?Q?odg0Z+Jt+pn1XoTN3YtwoB5cWTLHespYH3/WfLEgNzU5ApVdiQC0tj0g7Ke4?=
 =?us-ascii?Q?EfxJbetgGQ69kw2nhkQmtXHk4X6AoC+bplMJBASSWLbdp6wkvsDD058EXtVh?=
 =?us-ascii?Q?ZeptOyvZ98RrN01mlbJ5gREGl+OgzQgVabfViEZ6UA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RtrNDAWwShaMB/ZJ2rgOM2MqYCpXBkl5WoxebgcSbVluoJglQjcUdeoGZwTQ?=
 =?us-ascii?Q?VL/91c75vlb2X6aPd8zLx07j2ajKgTMBKXYNJslpva+JcpNAX4es+GQKBf2s?=
 =?us-ascii?Q?hGYKqQXDK4ieuAciHegrDwkbl9ADX/B/Tj4q2LnEC4xp0dpT4/mmJresbq9f?=
 =?us-ascii?Q?uSfuXtGRf1JNtU7SzbO5i/VDZUvBvL2eZqUzXzjOnU4BYXkoCV69rHXC2xkq?=
 =?us-ascii?Q?qmbL5+BUXPXGm4BlMkhNGW51DpJ6lsROmYxgKWuvvSsKiB7i6+sCe7ty8Jvm?=
 =?us-ascii?Q?cyzxAGBi5SbLwz8EagTImSX0PcxTYU9zauhurYJmIxafJOC1lStSWTsJhMYh?=
 =?us-ascii?Q?XwexJNoBZE7U+OjjgDQOvLVeEEgjmwh07gH5epyrEmxZEip3p1fDDunFAPnt?=
 =?us-ascii?Q?uyIxr4YFa636tO3DNRANlXIG+5DF4h4es3ej0Tkti65NpqZMuiImCPF0a6kO?=
 =?us-ascii?Q?UoLTV52XkZjtT51UN4mR8iEcRUZlHKlqY3ePyqCsvDKDDXNPbQdNFwwWFjhe?=
 =?us-ascii?Q?1e6/89bg9pvVmETkjeVFUzSRDk8kSx9ryHoRCLivKRI0CMO20+IUFstXb3gp?=
 =?us-ascii?Q?bqRm3N0xf1vyuGRemxWIEIm8yftxCIsXEqcmk3saASSeyqB6kx0CwaT2hiMi?=
 =?us-ascii?Q?B98veW/ZvmLeQ50t2arZHakoI23YIu8f6U/hTmJ6vA7CCQjMWrhHGNYkbwv8?=
 =?us-ascii?Q?NpaC4+Wtz1XWsniya5JaixwB1ViFEeiUG3HYh/B55I1akBMi2SA/WLSBSQpB?=
 =?us-ascii?Q?CwxK1FYVFq2Sk1sKFMhcizgXFneG443ZyHtN/CjUuotRk9eZhBKJ8I0Oqmf3?=
 =?us-ascii?Q?Vn8DXIzPCYBv0ujtCQ9wgpPmmlrg2ku9u/Cf+Se8NdKMGcgl6gQqePrAOys2?=
 =?us-ascii?Q?HQhCi6EVE1oCv/eMIHBvh1QClHXY4B+YSIkjh/5aaMzTh4boUbynOQFsOxsb?=
 =?us-ascii?Q?4D8xhRl6/PFYVWnLc6xVgxU+94l+3BI3gY/xPtOp2QWrL+QCxkX6ExwrHWgW?=
 =?us-ascii?Q?yyD9rh+8ZvkktVZMEn3jeNQVuzfdETcB+eFf6wBKeLS612ndbR6IO2bqaJ7q?=
 =?us-ascii?Q?STMQ7IBXliJq68N32DEOZ6BNy8p5F9HyXzTGy5Z23bOMuxLifulgKaOrNttu?=
 =?us-ascii?Q?nBscgQlcsvO/NsjR5ALwWtHpqd+I3AQwEE94bZDvH31ciWBvswLdQQA1W5Ef?=
 =?us-ascii?Q?JLUFrKRetVxTugbMAesYttD0dZ4GTzns7+/SXccisp0NwtxKoFBnoiAz1BGX?=
 =?us-ascii?Q?I0eDlATPtQZ0t+1nHj8RxNFamrJr6jdpB81NaO59pRwSe/wlUsZzo0clMrzX?=
 =?us-ascii?Q?z79kFjTLn00pFdH5N9ZxEwVF1agPo+kBHEpqORiifCyk2OAskYIcAVlInnXq?=
 =?us-ascii?Q?bBwJUxiAyVwiJu6VdQPAJ/bPP16uTnLO2pbrfsoWcZGnoFX4+DptWgsnY/Go?=
 =?us-ascii?Q?IVtMZl82LQw7boahIq3oGdVhMxoss/7XeCS6U7YlB/CzSVEDsUgQn6Zceuha?=
 =?us-ascii?Q?4qXXozvyMa6AvUhiMwzC6/ySPzHSc1oDFhxb2K0q2mM8SsLwPl+kfYtQsAmg?=
 =?us-ascii?Q?ZlWvbNKMMNNP7xF8U8TrXRC+zfsG7xK8MBH3Owq1t8Ptv1ZuMTstofdgUU8k?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X1RkRQcGpW7S+i55GRp6zTXTJpGEhJ0IYCmgn0HahVmrAV6U3TzzTznTSFfcxSjRKJzeLOTXXINf47Wra2xMKfYYbMYwgmSugT9qR4UCWOVw+BmoHnjti04/NZ6pa2doNY9DBt2kAWBIhrBwWnoPx0f6ISAZ++XIQsrSyVhvSWsPt3b147c140OVyEiWv5Z29wNAbgpFFjcu25K4Q+Tf62ZUF87K3s9UwbooXvxWQ3yBvNpAM9M6NW9WEy8ToGlVuTmT0tD8qk3w3Vqf4GHSmbFwgwt8/bK+Qm4MiPSBw8dR+BqkhTDAUw91ZYgp7yXqh/mR2S4VS/N0elV6wQODT8cGRmdghZu1pXMaDt8NLbIQqgcNU+I8/qJg1IHU92XA5Z5wCFHTnrb5qkKs2p4LA9unBEjLXcZTFXo9TegGpj8hdSEvCV6N2YwacPblkCpDRZSaSnn9caUVAK8fMlFp4EO+idTtoHe3+SErGGRyGyJFUcb6iYLrjuC2DKFdz0Zm3EpB3xhiuz0Yha7OeLxDwubsXX+Z4mjboiEcmM2vaEvfxJEFOuCWmJ19+Mj3+7RsGXRwlH9xTZs3efPWkfVpWgiaIPhVi2yES6ZmsUYvQWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd49e1-164c-4313-363b-08dc6874a154
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:51.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZG/QlkvMf56xG9dy8aaZVWM9abdkUK3xQATtdII2vMcCh9XZ8bvfKnUqqQcUJTE4RL8YrkyKPEarIKZgie2U3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: CiN6czIx49mofbrShMfhf-tLumTypuXe
X-Proofpoint-ORIG-GUID: CiN6czIx49mofbrShMfhf-tLumTypuXe

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future. This is required by iomap
DIO.

The atomic write unit min and max is limited by the guaranteed extent
alignment for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66f8c47642e8..7d2ef3059ca5 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -546,6 +546,27 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, ip->i_extsize);
+
+	if (!xfs_inode_has_atomicwrites(ip)) {
+		*unit_min = 0;
+		*unit_max = 0;
+		return;
+	}
+
+	*unit_min = sbp->sb_blocksize;
+	*unit_max = min(target->bt_bdev_awu_max, extsz_bytes);
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -619,6 +640,13 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


