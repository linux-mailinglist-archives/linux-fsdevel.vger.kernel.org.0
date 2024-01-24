Return-Path: <linux-fsdevel+bounces-8710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AA83A842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445DE1C21D32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667965915C;
	Wed, 24 Jan 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4nqXPke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FTIMSkts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EE51C23;
	Wed, 24 Jan 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096390; cv=fail; b=Wd64L2a+hVTGBBTbnO+4s4zrZrLtYf7+/kV8UsHeHaFS3n4f6Vbw7wV16f6WxzDE0blNWIXgIkH+OHZKYwth6rJ9BMg4o9+5zBSmUo+CuBPfTTyBezOKHPEqYVlQAGwuFhe3IAGOkooR54TUjvZkmTMV+nfCvq0FenDXwPB+9lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096390; c=relaxed/simple;
	bh=eFg6jr+Oibq2mzMwJhGbbhShznIs2nlGxBzxrw2YSSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ne3xdI5OE8xNMas6tHLVM71Tzj6PGJUZmSPcrNarVPttbn8ItsWYZGblO449zuh3MfWc7sJ+PBmuANKxp2qfwHa9Zd7yihDHCxHaOIKTK+MoK3Ad+gUFbFWri/FJGJXnEsU1RoEpyKNU+IA8VcXUpm7hiv/2/H7VddBp6w+QzYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N4nqXPke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FTIMSkts; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwsO1009429;
	Wed, 24 Jan 2024 11:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=RKRautNLmAPG6+F7edPvHr2ITNIVpM77Jln4UIZ5mnM=;
 b=N4nqXPkemLTsS4oM9RhcqsyGL0WQEFHW7FxgZN4Ow92iE1/JbVN9J7vRS7eWi0EtVVos
 cyznZpxZM2gB2fDWMeb5H/CEvKAscCzvKaVZdJhUFLiiQGgnmjl13caFRDC22T3LcoSX
 O1yr/pv0ZJw4qwyPfvLdXcqq8uJIme1GRQ39VBpdLUXETmjbVvGZAVidwAXu3/iUFnMR
 nQBcet3FEGg1ho1E2JdYabHdkSB1hy2DIQnn+emSDoJeZ+/Tnmj7CXxw2IjLVU2ABUwt
 LzKAS/0+oHsdzHu0owH7bU7tFJQcH0Yfn5m3rTpEiG2yQDRIxTroTTmLxEtlbkF7ZtTb Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy1txy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBKcRq040865;
	Wed, 24 Jan 2024 11:39:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi71ihX5oNhS1x8inD7BGEZjJBTEIxHSSxOggsRgQyGigYlqEWR0Q1tcy4+w6HVfcTx7QQQUkqN8/lvzJxHbSfp+huKDkdkWIVgSEZp5e+beLMoUmKEw/+J1w+NLqG45OWliUmTTqG0WYzDdOXIzBYFzByRfjCGgM5pbbHLANMnBYfenWicmG8v3uC4E3rE3hp2qicjgAS9zpZPKYkjAX+WWVJ8VhDXD1E952gvB3VdFq0+UkeNkaxiWnPgiR5S2L9YKxRpKKXKJ1A2f2VMlnqj4nsUEyZKp9U0C4JcoGuj/mNeN9JptVrqFhRDC2vahAee0rhPSpzF6XoOSlZmkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKRautNLmAPG6+F7edPvHr2ITNIVpM77Jln4UIZ5mnM=;
 b=Ub9mrmsSODpFWy4oCDyIIaCMADC5Pa/5TM24wRnUZ/Uj2Bl7G4cVoF8bS1NGmKBle+rgoyLVtpQw6c7fNt3N/apYtEpW1mjMrpOZmOetzctHwyG3eM9xPvVQjXxAJVcYkfZtJDox29GZmgmGIPReZQ9rMj4WMGwCrqh7hOFbjw2thL7IXRajyj0K+F/bO0WTcS+5mUsR3A4yGkDmQ0xOoiIbzhNDoO1VLxoStESZRWJBXRte8BImo7QCAMKJPHJqEafPG68Zkk/6rQpKDATBtpwWG1rrQ+/yecITQx3geelLFHEEIf90r0yCgvhVML02StBKn2RkPshDDtTlojYM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKRautNLmAPG6+F7edPvHr2ITNIVpM77Jln4UIZ5mnM=;
 b=FTIMSktslLdLgUcnG5GuqEW0OrMCf8nnGPU4u4lKd3RCZ2kXxTVteken4I7X/3vhHwk1P1PoyPzdpSBzZ+Qge9NC0dJhZhC2P6GtIXuihC81IZqqFa9jtyiprKTSc8BihYJ0pKUXTBmXDKR67NfS/Lo1H5gbOlraO2vUJi9TrPw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 11/15] scsi: sd: Support reading atomic write properties from block limits VPD
Date: Wed, 24 Jan 2024 11:38:37 +0000
Message-Id: <20240124113841.31824-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: b207b4fd-f9f1-418c-8ad3-08dc1cd11b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dy71tp7IKasDqHl3dCPhOUuCK5p3GERVJLcLliW+f8Tvg4Y9t8XD/16VAYc7p+K7MQEQZORmp9/C1SKSIL+zcgxxQ+wJGPeXfY1ydmFPqoAJ1z+czFcCxKDGLi/N0d/owSYjojHedSMN4im0KQa5PSk5jbt4KWyjqYMqawkHKqqQ9s1XAL+13EzzlqRx05ORP8+J6XNzL91yA1bj+Iq082k/ZR7pIJBm5rUUzrSn/RcBQr8LQalglLZSRTT6oYas9LQmtXn1xeliXLlScaBLcYlzTbt7Rh7dSYBFs2U6+RU/EXyHCa0WEhD1vchFKXus+un6dakKPkyDgmbzXRjAyHLVt1pX37EKe/ER8nwSgifnFyE5BP1X60CALQsS2LTjjjiACizAsJ/KCtxcDHHFAZShxNcOXtbXvJa3HvY4uZaq0CoTCOSO348epM1y2wh5rsU0s0brXqhsvpf4da7lvm1F1dHQ0Geen2aZmPQuLMYpI6beArZo7QikVfsWvGcVvGEhEmdkmpifI6WQ6UihuCiRWXQleSeEaNbO474HKcQ4XEmHd+IlSNikdaWTvBoEqV1Mr6We95HJe+MBHvbA/qvGFZjROyeYrBljrSsb/uw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(1076003)(6512007)(107886003)(26005)(2616005)(38100700002)(6506007)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(6486002)(478600001)(66476007)(66556008)(6666004)(66946007)(316002)(921011)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bRIlaH5CJnIexgw23W+LQuKa20xtL65uYEfsUJRWplnWQuoTa5WxgQDJngt7?=
 =?us-ascii?Q?GoX6cBB+6qHJESFTXdymsjoFzhCYIPBU7QxeEwG16RsJmz95SGivHQQHicEM?=
 =?us-ascii?Q?RuvMuuQ6utxx6UJkDS6oLdvbDrW3rtHxeofM9PZbtEnk9Uvapn5kgXwN5zjT?=
 =?us-ascii?Q?exlz8mLWlAY3PGhFpY3VdsVtFJnxRbe/sp4JFa5F+3H3iL1HaV5LpXoSNi4w?=
 =?us-ascii?Q?3g9hz08JHJERb881+P6O3NPvejtOEG1vhGjg0qWd7/RoqCnnkrxQGFZulxW5?=
 =?us-ascii?Q?YJtY5+XQe22ckqpxCR2MhwdnEyTw8ajlCEs4cyp0uQYi0Ju8O5a0xdp3Tnf5?=
 =?us-ascii?Q?k0izSNboP1l+Wkw9mUhVdTYfYWI8IfTgp/JPZfx0/t5zs45kTz9SfQuJ+KuO?=
 =?us-ascii?Q?IASPRTtPbvFnZPT+4HXmOy4K4+3B4lbCFOiaMXswmCB2L7+Ptg99mUtcnQ0W?=
 =?us-ascii?Q?FNbWuW6U0iJxc703Xy4ESfmwiwhuL/f+6C2g4j38uFHxKBtf2J/REKeyQA4g?=
 =?us-ascii?Q?s6kDsN5J03JeooC4XzwrSSeqQjt0tCtlZNmI9sZvFHKCBvBYlsU7UFBGmbt8?=
 =?us-ascii?Q?f8IoCDjBQIMhezhnDerFUd6Aq4xfmbz2WY6lACXv6abrR04rqMAe1sfYfKab?=
 =?us-ascii?Q?NMgc6ZmPtXPfUrRiquJmXYZsrOdz3gWS/EAJMALkUhfXFjGqpspKn0V1em8o?=
 =?us-ascii?Q?VgarZDpJS75FFnzjMgy5jkrqbLvkVlgNjm2ISsPTV2bKDftdYr1PI5Loc2B0?=
 =?us-ascii?Q?sKTr8goqspG5VriUEt7BbQWtenIt0fDt5hie2Y4j+gNKa9s8vElTVHej2/tp?=
 =?us-ascii?Q?7hlwcYvVVS81mnEnkQY2D7X+NpBed/8z2wEOM7JOyOOKe+KEWctE0ATpVg1O?=
 =?us-ascii?Q?M5lhk1t3NDNy73nFvJrqNbyW4lfD30OB8Nxq27lRw9OyMWa6fSZDlKBFcXWl?=
 =?us-ascii?Q?DRlZkEUN1gbh8mT9qQRdILfPE4LWzb/GIEIeS9gHTydUtu+Qdl69O6v5k+v+?=
 =?us-ascii?Q?qZXsRzOSG+Fk0jJtH+jQ2kfk3YqCGSQfWZ+D7jR4Q9H6n6UKAraM0wISvnsO?=
 =?us-ascii?Q?7/9sQhbCOsL/hOpba2s4KPn9gJ2rEQl5hio/mT4Pk3ZdhKC8LDyKOPkhKtXY?=
 =?us-ascii?Q?NheQY82FJUEP3fkujtMoyZUX+pe3swWoFiAuuOG7YBoEDAjrBH5HYuaEvpRM?=
 =?us-ascii?Q?tnr5Sh6g/qICgXbSSg5ATiIr3/kAlloYL++aHTyU5AVd0QZ1JOLSmXGj9i9d?=
 =?us-ascii?Q?JszIGFUTlxplOalSzgV/giXedjq0qHrCR83CDyNofHPuv6DZwQs9QWIjg2Av?=
 =?us-ascii?Q?rB8kQRAT2vDjZ+CwT5nvwFWwxi/ANRAsV189KxJB7TAlWr00tmxB6SPx0WNh?=
 =?us-ascii?Q?fQekpbCd96l4d1dx/n5vNsBRB1RF8a3ZHQs0rZmYEftQk6INSq2eM78Vpu71?=
 =?us-ascii?Q?CScX3rHr/Gj+KyyQ62rMbyI0PSn4IGYR2LVVP1Iqn1EcTJAsQBqmNycGHnX3?=
 =?us-ascii?Q?uAyg8cYeC0KWldtqRZNnFOJokTYNYKM8Lzsz2wadbmVk62ICRxNlR2a8/Kok?=
 =?us-ascii?Q?1US2JEYN1z+jyKQS8EH3mQLO1C5jsu2weXB/mDu4/pBFHgcmkR/gjpwurIWG?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eViwGrbwCKhM4/pblmhlwgGBOb0p2KVsNt9n/9p2/jAZTqWoVF7QXI7lZnhjJs+JNnGOXDSoE5J3TkSyB+I1276Hvm8eMnXyVN7DyhxeXi25Kxc+/bxpAg1BNwMs//iPdcn7Z0PUZSfBj/u7aFuTRF+LUat3hWtL9rBv9e2fgDeme0NHODPz/rop81xBaljSZqkAzsD1IAHAC5/Xv9hE9oryBWPerwNQNx+wrulUXbbbI+le87vT4+WQKoSppyLjiXFT/nEe5VS2Uf6g3IcN3nNtzGpLhLk+MPMOeHKwPP0VIWB4kE6s3XJjXlOW5B3KdaMyLfj2Pl+nU8JVw21t11/BoPU79ALWQQEgSD6CCR09xc0BaihxmjQsr2vi4LMlPAWw5gmXuoSHXRn6VJ98LiQJMcBCwl9IR2GIcG6GaL28f7A9rAlSudomJBf8X5SJSh3gCp8uYwmoKGVsZvkgywxOYwQXqyZaGilP32AfNQqkZvdW/X5xZi5AEpdTI0CtXA5U/mLFUPszgVP77YIJZMhRtJyUR+MaRAsEDa5izkR9T6wUg86Z6Rj6iOfaKLpfH4/s5kcgpNgZlnXusuhJGrXOkH+2sq6Yq6r8xdTdIwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b207b4fd-f9f1-418c-8ad3-08dc1cd11b28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:21.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX3rrK76EzJuuRxcMie7l44mYpGyrZpA01VJx1pNIrZ8cwEL2ol+8OVuWwZovn/YI2vWzLG0B4NPFL+j/Gyt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: 9ZaYkbmZyi66-YbHlQBWF9FaokVvG4IP
X-Proofpoint-GUID: 9ZaYkbmZyi66-YbHlQBWF9FaokVvG4IP

Also update block layer request queue sysfs properties.

See sbc4r22 section 6.6.4 - Block limits VPD page.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/sd.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.h |  8 ++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..32dfb5327f92 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -916,6 +916,65 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_alloc_sgtables(cmd);
 }
 
+static void sd_config_atomic(struct scsi_disk *sdkp)
+{
+	unsigned int logical_block_size = sdkp->device->sector_size,
+		physical_block_size_sectors, max_atomic, unit_min, unit_max;
+	struct request_queue *q = sdkp->disk->queue;
+
+	if ((!sdkp->max_atomic && !sdkp->max_atomic_with_boundary) ||
+	    sdkp->protection_type == T10_PI_TYPE2_PROTECTION)
+		return;
+
+	physical_block_size_sectors = sdkp->physical_block_size /
+					sdkp->device->sector_size;
+
+	unit_min = rounddown_pow_of_two(sdkp->atomic_granularity ?
+					sdkp->atomic_granularity :
+					physical_block_size_sectors);
+
+	/*
+	 * Only use atomic boundary when we have the odd scenario of
+	 * sdkp->max_atomic == 0, which the spec does permit.
+	 */
+	if (sdkp->max_atomic) {
+		max_atomic = sdkp->max_atomic;
+		unit_max = rounddown_pow_of_two(sdkp->max_atomic);
+		sdkp->use_atomic_write_boundary = 0;
+	} else {
+		max_atomic = sdkp->max_atomic_with_boundary;
+		unit_max = rounddown_pow_of_two(sdkp->max_atomic_boundary);
+		sdkp->use_atomic_write_boundary = 1;
+	}
+
+	/*
+	 * Ensure compliance with granularity and alignment. For now, keep it
+	 * simple and just don't support atomic writes for values mismatched
+	 * with max_{boundary}atomic, physical block size, and
+	 * atomic_granularity itself.
+	 *
+	 * We're really being distrustful by checking unit_max also...
+	 */
+	if (sdkp->atomic_granularity > 1) {
+		if (unit_min > 1 && unit_min % sdkp->atomic_granularity)
+			return;
+		if (unit_max > 1 && unit_max % sdkp->atomic_granularity)
+			return;
+	}
+
+	if (sdkp->atomic_alignment > 1) {
+		if (unit_min > 1 && unit_min % sdkp->atomic_alignment)
+			return;
+		if (unit_max > 1 && unit_max % sdkp->atomic_alignment)
+			return;
+	}
+
+	blk_queue_atomic_write_max_bytes(q, max_atomic * logical_block_size);
+	blk_queue_atomic_write_unit_min_sectors(q, unit_min);
+	blk_queue_atomic_write_unit_max_sectors(q, unit_max);
+	blk_queue_atomic_write_boundary_bytes(q, 0);
+}
+
 static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
@@ -3071,7 +3130,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
 		if (!sdkp->lbpme)
-			goto out;
+			goto read_atomics;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
 		desc_count = get_unaligned_be32(&vpd->data[24]);
@@ -3102,6 +3161,14 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			else
 				sd_config_discard(sdkp, SD_LBP_DISABLE);
 		}
+read_atomics:
+		sdkp->max_atomic = get_unaligned_be32(&vpd->data[44]);
+		sdkp->atomic_alignment = get_unaligned_be32(&vpd->data[48]);
+		sdkp->atomic_granularity = get_unaligned_be32(&vpd->data[52]);
+		sdkp->max_atomic_with_boundary = get_unaligned_be32(&vpd->data[56]);
+		sdkp->max_atomic_boundary = get_unaligned_be32(&vpd->data[60]);
+
+		sd_config_atomic(sdkp);
 	}
 
  out:
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..990188a56b51 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -121,6 +121,13 @@ struct scsi_disk {
 	u32		max_unmap_blocks;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
+
+	u32		max_atomic;
+	u32		atomic_alignment;
+	u32		atomic_granularity;
+	u32		max_atomic_with_boundary;
+	u32		max_atomic_boundary;
+
 	u32		index;
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
@@ -151,6 +158,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	unsigned	use_atomic_write_boundary : 1;
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
-- 
2.31.1


