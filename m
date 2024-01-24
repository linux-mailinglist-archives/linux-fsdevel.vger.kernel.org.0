Return-Path: <linux-fsdevel+bounces-8705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530083A828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4601F285036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6974F60D;
	Wed, 24 Jan 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bn+yrOO5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fv5TJYGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3602481A8;
	Wed, 24 Jan 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096381; cv=fail; b=QqWOkD5KXS4eP7+GslE7/1gr/D8D8Gavs2oZlJbOkc4jZX+5tby8TvdELSyVtg7K3rJkLy+qQ1ENwDJsU4wg5PaWs8yPIdkp2OpIFb1PvYuGzoUT7Da6xhV3cgQvgUdJ8kP2ICmzivMihinW+wg7MXoGIL/s043qebuXNgyUl8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096381; c=relaxed/simple;
	bh=PMHDyZNfV2DC1qGD/isnS4zuBg5+k+pQEE0G8qmELok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOnNJz/MT6nHFOgp9v84ZMWNq1E+cYAMqAE57uHP9TNEHbuiNPytKSTAX3t8MtJrDWzaoQf+KfIiCLpo6vSln02D1jB/5VYQ67lzIE4DYB1r4zEeZMKNl61E1ifgRU+a9hpv+cIe20PR1sBnWDlnVFoRRokdV0xAjlzWYUn4rVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bn+yrOO5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fv5TJYGL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxSLc019677;
	Wed, 24 Jan 2024 11:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Y3ME8YWCmtMyUFFF+UFtbiXw6J8VGJXY+lK9KpwRI2g=;
 b=bn+yrOO5GtUoQo/iuyGJafKFXm8dqvtsEuLAUBI1pbslBZ7l33IZrHXgo4AMvC/eyXnH
 Hvs1ituE2wJtitbQNRdpl8m8eIfjhoIQjlCVeMCJVPxhkmsjmKA/59SJjfK9gL4lnKv7
 ygwY7M2H8CZko2YFKup0V4A4pn6aT+2F+rV1i+P1NUoySHqr0WPIN0Dy40/GcmlwPPXn
 B3iw90CaK/HqORyW0TdOaXV9WwDfROmOlEun99SrZlbo/p3hcj01KOxzpKUBZ2OpH+4v
 ZpUDwFW3ByNHFPog+WD5nAOQ1GR/vBN1PmtAuFy/5I/Auo/y/uE71AOrh31+JqsV1n0A Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ansx8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBSk75006248;
	Wed, 24 Jan 2024 11:39:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32set4q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRbsPSP+8gLOp365nof8cX0ZgLhkC9yDiE364I2pS7XtJK6FzyKL7MXib9n67CeHGMjGjvfH1SuI5Mq4baF+yLMW6uqLLYUwb40dGBtGowMTIccuy/+935QgjGHzoHynMZupypbl0jpqW+28zgOUPnSSIhxUGU0cxo6kV2s8vwwioaRqYrEgwnshAN9PlqIRC8I57OzeDyjMLwUT3bzHWs2ZeMtlJ9aDAs/XKtbhJl3ndTFIsCsCkLUxtYPiHR+ABE5tNpNYV4K9JHPBvgfCM2MyXLZu1NeoyueR4TXMV0J6tvbxTEK55wp8rlULtJmt6INdLH0eExafUVpF6hzgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3ME8YWCmtMyUFFF+UFtbiXw6J8VGJXY+lK9KpwRI2g=;
 b=VYHB5y5E236SjY03srFwu8OImKi8unpG4ZLkcnX+g8JSdpz0vEJb4000P244BYs1Wx3l+vKEH3r8KPI0atS2XOEjU3xsp1NMg6BAenIZ0Bu04UdNBwPMzoc+DikgSRL99l307ZNS5lNlxqzIaMxYX+QVG3Wpa62462jFRVRcMGIY9covr6ZRUmhL2PdO63Uop031Si0tHUI09fR0ovMIHVw5Lqwn3MQrCS4CU8MPLztNt8bqA2FH/PDHUBi6IwTxezQod0CLTwJ/diwSMtFfyujE/P4Z8cg6boAY1WKe98cob333TUABy3g8liJ0jBm+p2cBNvTlAAiTKESoYgTMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3ME8YWCmtMyUFFF+UFtbiXw6J8VGJXY+lK9KpwRI2g=;
 b=Fv5TJYGL+FN7k5u+j+Sy6e5UyGMgrT/mMO+oIWCvaN206uEmKclK2zp9zaHgroOrF6EYfeX+VejV4Cv5ru8OOyIOhwn3oN1k2IM5sknlaOnIQA2a8qvIMc9qXCQHD9x9jc92dbeX0YhdrAmfJeFRF6gbF0ry7ekgveodOOX5nc4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/15] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support
Date: Wed, 24 Jan 2024 11:38:30 +0000
Message-Id: <20240124113841.31824-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:208:32e::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ee82d-97a8-47fe-95d3-08dc1cd1163f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WVSlhu5Nog4/jD9oJqe296zNBOSYd5fvbEMlRdQLcYpvlRgCnq36Au1O0i1ns1C+meK9PcKG7sMwy1rZYgSorc3T0AhiuZqLtVNKL4U0JfIJV2AyVFKfq+DjFAZ4sHQTfz26Dk4ypGTlgue0Pxn7dsi2cumir51nXSqnoJ14IwZc28AdH3xepVlxbtwC+QqpEBoYKq/D4QO2eb06De4unCXY+z94DP0ElU0ta1O9JJr0QL3E9xsinETwDox4D5YS+V2k9PzYBTF+dEWV5KuCZ8CFhyVgML6XDeCjzVBLVyLoSFRm0Enjb94d4nutFvBJpsqkuP4ylUV6Bk/uJvVsTV6bQ24dk/YlhQKEKg6XeoITowAtIDSqENjJXzmlCKc12YTb0CuE6BTarBit9myGezJDtQp2f9PsWAARGV3k0AWh3hW0nOtHQkjak4lIbpJUsLCC0rBBSaKf3Nc4uhv0MDMcZZ0WSc0EG7Xbnt0FcdhibS9grv0mDuk2PM8tYiT8aAb2qfXIZLXcuP1vgwwNB64oZT4GnQ5TQv4uzkO+wQx5xEPTeqAul+2Wp0peDvvtz4+KOk1WHDbnZSD924bvrpslGWsVJpX3RHD20k8l/SY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(54906003)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hWWa66XePd8EqrJc8x8m5bDzrL5j1YL41Mjg7hxQws9+TK5F+/H3mSRwMszw?=
 =?us-ascii?Q?yjGK74lOM8dEwbztk54O0GXY+cK/RJqUSNaUNB7/wZazEpQRWja+bc/9nC7t?=
 =?us-ascii?Q?NDM2pNiUk3Dev1sHAQP4UwKlZrLkBTCHQCpoFAV5pGZGzgpg4sBXTqfglR+F?=
 =?us-ascii?Q?vfBKTHhd2dEtfMm+XldPi0ZazMxB7wTt5wS/Ez5Bvet1lDzjWauvLr3VgWTw?=
 =?us-ascii?Q?zKykkzRkCYsXAJ8UTDN2b1lhpSttuvrP4ANVCWm5rXWamWYqs1v6485UOY8h?=
 =?us-ascii?Q?kOk6jGcEWUYeK7+wTDKz1U8v/3DgSAe/u4rkqEajBS9wWhXZ0va8aL/8oeme?=
 =?us-ascii?Q?onzt7x9oW229Ir73KKW2TUzfCiXny9qrn8wyCk+x6nMwH9TRcZ4ihLPT9AHn?=
 =?us-ascii?Q?H49DWk8183hpi380hOpyuOrFwQ+7iW1NASLDcPUdFKex/vxOKdWywHAVtFq0?=
 =?us-ascii?Q?0KGi3ftAdd99srs6NRCAkgFx+dWQWP7fdahfM5feiKL9gDO81p2yzgEJOWwg?=
 =?us-ascii?Q?hrkvRasanAtehVL8zae50WOPCee+4OdmdztTFvwle38K0xflbcvIdjYgsGn0?=
 =?us-ascii?Q?tCxdXPpIeao9JsnNW/PPFZIGwPArPu5Uux0Rf2cO42HbPbx89Ksil1fcSKnz?=
 =?us-ascii?Q?9Ts4xORs1xsBQru4wNPE9ynGoIPbW0VeGjuuhwdCgLQ0LRT+1iV1PqPLt6Kt?=
 =?us-ascii?Q?gPp1MnpXJO3dmw0O1zjaLbJA1p9K7QU43kyLXI4Uv30GZWEMd7XwPRUoSuOT?=
 =?us-ascii?Q?lDLtpHcVmhBR93kJqXYskcRwpb1SNTWJ6OnjsbcQZkNeiaFHsUHCOrCwersA?=
 =?us-ascii?Q?5v2ftuoHM0sy+gO/kByvPRUlyKcE9EUUQpQyGXGiokvYU7MRnGWwjo5bjAvP?=
 =?us-ascii?Q?LQDNwgJe1PB9SedPbtrktLI/tST4nHUAMEX/d15x8t2UjPpkuezy97txFj7l?=
 =?us-ascii?Q?tRLAO7qFPZZj8lv+NOnLQSv/ngLfvA9qqdyjQyRJYXA/Ac0dJYNwAayMjdsM?=
 =?us-ascii?Q?weWlTHTlK1lfmI8j/qx8398806I4AIkgAsiVrmF63z4iOJlMLAFDRilRicQD?=
 =?us-ascii?Q?jFSfyO3vdQ0PWvLRmOKzXvgf75TE3XWNxLk9Dm7Q1H8K7GVtXJMoT5IIVdYt?=
 =?us-ascii?Q?eHfvxDYTJI6Gn/YRRxZzoblUTh+vAioKABo1ROBwfjmYAjdE3dFrfGIjd+nk?=
 =?us-ascii?Q?7SDR19hy+AALd0tixGhS2F7hQ2tldtLXCzd4S7vZatHVw+bYTkAKXVPNCT5S?=
 =?us-ascii?Q?o/UFo2p79EfKvYcTSbLapDiifx8wKQLmV1uqxIqjLgTU9IZXvMeONE5wpoEW?=
 =?us-ascii?Q?UOnlYSDYZn/Lo6SbgQd+56WR749no0ms+e54HT6UaNn3HVGYFph4K2ZVTQqh?=
 =?us-ascii?Q?VeSBUFmhkziJO0cPfMG8AKr6culTGgEhgjQV+H+3SrWaeM/i4DxMuolf0/RY?=
 =?us-ascii?Q?+YIPswSrKyCqECS5vXoTwcpDRTlvMwhRzBa1qw7cVF04XbB0OZXbK+z3TZqx?=
 =?us-ascii?Q?dtmBNE7NtBhXqAYM3nxLf5LgJ8hjmdzSEWVnvwJz2K5Nhii+IygCtG8qcW8W?=
 =?us-ascii?Q?/dut2AEHl6oUL9eJsChAweexGkk2aBznqF5OTUFOfmXFfYDboQYebF3ZwwQT?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WuPJrjtTXjptXE5JAMYGLO1wOg5UGf2INn1/VXpwKBRJdbZ9vcJqeOXLReoV3JnRRE0IiZ3oIDfjZRND3dIxG4eMbAqWWzvJGAP2II9qqGJg2r37w8jaIEymfrsujOCr1HgNXZmZ98880w3U/whNDjmbnOj3/MyJK69rYnx+1edgIIuLiJXjDP/yL3ftd8eVJa5kRPSKI98sRu9EEKu6YjN93KsIzSMN8Qq/Z0cXT5/G8VPGLXBinjnrlGjfLBZlcZxSIakvKcmmHaN3U/AYzCzCtOnMiZCck3eAdKEcBd1BfRyaxAhExZCayOpsMsB8DIyPkispojDBcnfgnZpAH3ItoqFPJ19wMuvCEPmqgrHzOExwOcex0aQcmW/ONljWimb4IZHLEz6OAX/MUGLlc6g1uYEjIaDN+ZZmdDzXmMbY6zRbYLKRvg45c1p56hUL+NIxX3QeUfE+5EnpjZ6Rn2vuMDaeAfDQMHa1iislQk2Bn4q2EE+/R3CA/0XuhS9mLSAkzFXZecWv2Le0jIEJaQVLfX0Am+T7n0bQg0C8UNbwI2jT4TnodtlRO1uO/2Lk8ZY7IgDU0gAiRbpsCxEwogFY7L8kl1jHAz8k6AAVdDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ee82d-97a8-47fe-95d3-08dc1cd1163f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:12.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFZD4psspw8iEZQcmhZ9eEp8wBEizSzeJQFTsNedjIHOnRPOyX/KtACYv94NyhyGZfnnhFnM88rHIvR9k6jU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: EaT4RV5_cPT46i15wjFhBWg7xJngzrci
X-Proofpoint-ORIG-GUID: EaT4RV5_cPT46i15wjFhBWg7xJngzrci

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
write is to be issued with torn write prevention, according to special
alignment and length rules.

Torn write prevention means that for a power or any other HW failure, all
or none of the data will be committed to storage, but never a mix of old
and new.

For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
iocb->ki_flags field to indicate the same.

A call to statx will give the relevant atomic write info:
- atomic_write_unit_min
- atomic_write_unit_max

Both values are a power-of-2.

Applications can avail of atomic write feature by ensuring that the total
length of a write is a power-of-2 in size and also sized between
atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
must ensure that the write is at a naturally-aligned offset in the file
wrt the total write length.

Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
flag set will have RWF_ATOMIC rejected and not just ignored.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/fs.h      | 9 +++++++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c316c0a92fff..95a7e2889d2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -119,6 +119,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_PWRITE		((__force fmode_t)0x10)
 /* File is opened for execution with sys_execve / sys_uselib */
 #define FMODE_EXEC		((__force fmode_t)0x20)
+
+/* File supports atomic writes */
+#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x40)
+
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)0x200)
 /* 64bit hashes as llseek() offset (for directories) */
@@ -328,6 +332,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -3344,6 +3349,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 			return -EOPNOTSUPP;
 		kiocb_flags |= IOCB_NOIO;
 	}
+	if (flags & RWF_ATOMIC) {
+		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 48ad69f7722e..a0975ae81e64 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -301,9 +301,12 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ATOMIC)
 
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
-- 
2.31.1


