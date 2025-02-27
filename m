Return-Path: <linux-fsdevel+bounces-42778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E6A4877A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98C3B903F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193A1F5830;
	Thu, 27 Feb 2025 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xij1VGzi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QiQ8gtib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04F26F447;
	Thu, 27 Feb 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679744; cv=fail; b=uGmtsdkt6En9Q9t0zSArsT1aS4qDK0VW4DYqvTIdGSYeCiFxUVTrBimx6fnus1gkyzG+5fvnC7s88B6kJdKfKF2VRmE6Ws0mGI27WtBHBHGfdMAjTDaSqj+H5/AsXQSZ4rotj9QMCiDx0Evp9w+uKqBqke+SHYK7oxDPubzJXbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679744; c=relaxed/simple;
	bh=HXZAfDdtHJOSIQMzZzhfmlgrqnh4AceN9fI4VR9x21k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvgyyB8kV13qHC6M3sEKvKb+2gMqxkbdB90F63Oxs++FqyvmP+AJ8ovqDNljaGuqBXLCaikMyJViDsAvJ3Tiz3C3j8+Ih1RqvlFOp/lAwIy8jyd9PPdR0n2J//QyP9TVhdYvhtRWFHS8el2Ff/csUK9EfRtwHnb8Z5yv8q4HqVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xij1VGzi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QiQ8gtib; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfkgF018396;
	Thu, 27 Feb 2025 18:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ExND6N0l3au/RHo/27D07/dBkt3h9j8UuoJMQoYZ0v8=; b=
	Xij1VGzih3O8zpIHPJArgtks+Cb8zVvHDaK2JRA4jsRZ83PIfpUT/AVU05VTCDnK
	4rcxcZhHUqxcGroNdu9/4/3LCTnM4Wic/tMz8gTA+CIScrMptYgLiaYHLE5u77Kq
	XSBHfP+I5lfU+bhHnSX8i8XCopIzC2hpn4TsPH8h+aoZ5NjA8iPMR1yQ/Y51sE2G
	XMQEOP1vKHY94WZI+4NPDv5VwzhrxFLemnuLbcI1iS8vzwbQkGmWj3hoHCI5nUwM
	5h6z993Euej/dahIlDJh0tvrGnZr/8I2/nJ9oiO7MKMi4SVOFxUxsysmMXIbW2Hv
	Nemvz0jgLBWCWpPxTyG02w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse40m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHVKR3012522;
	Thu, 27 Feb 2025 18:08:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dqknq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K095Ofq3hJ4pgLOIAk8OHJ3YcTKPb6Jk+S5QcnQsRRpyj05paXFi1ym0vlpvuSS7E/PKZeVwshqlDE0W9qOn0chsnpiiyLTvasCp5ACzSVAZwt0G89rlBIBaBh0JgjxtpR7xVfiBOECRF1UbBD3lEgiHWCA9F3bAMc6Gp+RsMv+YHqI2bIoYLIkAcOsJ65W9nbgHSRU1so4VQTdaHGd0iU1q0TFPbXR2F3zcE+f+WmIYu5BC4GRM2zdT50/0AEihC4CH7fN7wy/6xy6Vex7ncAO0qmGJVnnut3OC/paRVWPeX3HOk8Cuo4gzqGOOYaWpL0YtXze0lEtY2wiY31jIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExND6N0l3au/RHo/27D07/dBkt3h9j8UuoJMQoYZ0v8=;
 b=ULD/9tDFdYW/bA1Udnci8/SWth5pY3MCsrWo1NJ968quKGD7u0kP0h8i1MJ7Fukw1OSd097Q1D44UbOIKZS8170P/HOiVGhTzE/zAyySbtrVESZhgGffli+uyuITmQoZeviPYk/rI5IPJ9RjpGCgjY5+Zf+RRzEDdoQIbrf0C2bkYrLXyB39QrKAIr+ju897pb4cfMMCnNsYvbFHx3kokrEmEXGMeeW/xIEZGQJogdJlmG5myxk2vJG0r/SztnS1sDes3ukur+VCkbqzZj+N8ZgqrdNhivkrzJBum93ydW2fU+QAm6NAzJBrp8hx7WBxIpsb6wjRfJaUzYCQJwNJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExND6N0l3au/RHo/27D07/dBkt3h9j8UuoJMQoYZ0v8=;
 b=QiQ8gtibuNZyViyK0Agx+4cpt7LD3Tx4V8jUmr4PYQMG1iiopWBkZCPU/bu9N2mNwDD6s1qXURMPSusxdjlWOkWsDUZ7Lb1aDZzCRe7pGY3HPH+g0yf1nG2A/YRP/R6RpQWb5agQozm5MG6ofyAvcNoeAatc2MIelOUoPPZFpqU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 11/12] xfs: Update atomic write max size
Date: Thu, 27 Feb 2025 18:08:12 +0000
Message-Id: <20250227180813.1553404-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:408:f6::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d96dd0-7faa-4006-67a8-08dd5759c7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFXr8qCMcnKfSiMR/Uv97gnN+m4MKhv6K5l1aE4FNP0C2vTKVutHa+2sv7/I?=
 =?us-ascii?Q?zUJM2Alu030RoZyjyIqUA3tpZdEI9+77NPu9/JA72TLuJhOcmSMqRQOwokJl?=
 =?us-ascii?Q?Vs5XtfTSZOJBKEEfVy8WvZaJcNt+kNmWx4VM9kxkVxJacxCs/gDSwvui1kaf?=
 =?us-ascii?Q?Na1mJVgTponufg7QLv3ufvLlVpGHG4F9dxF/snVglQLzGkh001zIW4OIt6vG?=
 =?us-ascii?Q?Q+8k0ObjWneyaNLQBlOyE0F8w8sqP/9jZqgpcNGqME3H5oOs2WIoNnlDXIMN?=
 =?us-ascii?Q?Qf+8zbjH8uaueDqUI6mY/oT6DmNa0/+/islJPvWGG/PkeUpYc4bUiom6rysZ?=
 =?us-ascii?Q?Dz808dqu/Be5Dp+ulKrodFiSvtRFGicy/pW/8l/F2NE3L1Q5UzBzKRSGOgS+?=
 =?us-ascii?Q?YeonK/lVnfH2q1Dh0uhO4cgBDo8KtccWRuPQUTrCYBgq462LiGOa9lKOg/Bo?=
 =?us-ascii?Q?9Mflx3q7NQ1tFzF1Zysfg0aVF2w1JWeabzwavbw6Ze8kMQqr0RQDICjTX0m7?=
 =?us-ascii?Q?zFTL5FHvo++yRU+J44UQQ0eXQxtdmV/R9jPCHXY36hLqMZ0NRXl+FFDNVtdZ?=
 =?us-ascii?Q?aGEHDzXVD4/91QYX7fy3UysXlvnOBxjv4czI6IGdkCAvP5a04ljmpLhpKusW?=
 =?us-ascii?Q?27PIDOYF0E9gWHub9D+yxZe9BHk25h5+khBmULCTLG5Xu2wQLJVetxkznLSY?=
 =?us-ascii?Q?RAOMxYSKiIm3gdluFarysE4Bm7xl/n2j9cHZUhf4dcPWCeG22wiJv8f54UU7?=
 =?us-ascii?Q?5HyLeK7snABvQUNJqHLcqEIp9B6cBLYTKCoxPcXvdVRaRlUkiWTgRfycjvKS?=
 =?us-ascii?Q?ZAjmET8kE/jYWrjUOuUBHcz6Y82XyRgqKVuosaekWFvodVYdZJPofsgZL0n7?=
 =?us-ascii?Q?hRHsHRB24LGwmfT5UvHowGaOSLTrn/5Q0BUDaPIpSl4BpdB2T/Tvg7XOvJyr?=
 =?us-ascii?Q?GxOBRY/+HzCEJr7+TIrnNnT2IP0W9fzuu8hAfKaS80qVN82kMI7Lsxm8m9QP?=
 =?us-ascii?Q?QKK1bk9IsdithAX3bCbG3CAFJt2JYnSSEyCQ8Obr1d9ppzwQWZKci/OZBTn0?=
 =?us-ascii?Q?ejL0jMK0PU3SKe+udA2LCKtvL9t/KF7UxV6/sw6YLNsSd5SC5oI3mpCtPu8m?=
 =?us-ascii?Q?8wc+rZoa1JN2RVqI8+yWYNzz7MnGvwgZvktUdwnDXLIjclSIh+rpuMCLkR1l?=
 =?us-ascii?Q?PiPNjSIPw//KIO0zEdv1s0pNL/bxEUCTkLhRX44k26bCgM/mLPhDtF6uMeth?=
 =?us-ascii?Q?2fji6aaq9AVP5Je54upooY214B6H1KGk8IiIySx+eNESKJjiGUfMp78/Xq1F?=
 =?us-ascii?Q?kM9xVnLzOyH8wB6iuFP9Ykq63BurMameQitq/d13oeWvHscD3547MCr5eE2+?=
 =?us-ascii?Q?4mN54M3ixW6Zlrv6uuT1gvyl5Frc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdloIaNrZE0+ekpyPC49m3MgLGjO7JriniylLJ4hJrfFnPdpfQSmDW8FFLWZ?=
 =?us-ascii?Q?C8qJxtndM+bpQ1ynaGXfJE+wqjN8SmtBP0NbJ86MHi2rmbPvhZPhGVXzCOrB?=
 =?us-ascii?Q?RdasVdnbxxsAIrokZpmsriUy8wM66PhEzl2M9XnMFqA9HkjS5mPQcZgniVs5?=
 =?us-ascii?Q?nIIcCDc5o6bB2SDekh/bo/tyZ8ZbzgjKc3kl5Bqhb1maACKYaelw3fHjDs7q?=
 =?us-ascii?Q?G5TaU/vYatqJ6GtFwTEcJn597lyzU7LdCo4pW3WtwhEuZr4gELKK+XUIFJZa?=
 =?us-ascii?Q?/InEckAZ9S43PIzIcgth1CtMbul1byYylpJKTHzmKAsfm4jvp3IuEzImHZV4?=
 =?us-ascii?Q?cfMFdRkLrZ6g4ZbNbOog0wL0MeJaN4gwkGtw7/bn9WtPdSFdLX6cGdhvqnzC?=
 =?us-ascii?Q?rPqZT1Fhgqe6CEZZFy3iJ+MISySKvY/s1mKKtSDZOibYZDFsamtr2U/oEoQp?=
 =?us-ascii?Q?viB22yqo6IHp/Q1iWxxCRUakrNwnp6c1gaywmMYapfwZoXyPnbRpmq99RIfB?=
 =?us-ascii?Q?UpTMqxt68+6zE4qFk/o/g+hBVwpLqVJBmPjfOzwLAuwUrOCcMKOjeQBYv71z?=
 =?us-ascii?Q?pNM1rmilSGb0LMTkP7u6wXMYkKdEslWLNR65exDJHtbZ+oATT5baaqLi7SGL?=
 =?us-ascii?Q?HkEnLV/1mssN9g2IrCgwQZ6p1feASTju4jBPn9CboE5c3GEOh9BqdKRVwa5X?=
 =?us-ascii?Q?1xIwS5pybCXo7IQRPeB1PRNE8QxMTFM2tyROo+tT7xyc6ptImlzqgW7IT3sQ?=
 =?us-ascii?Q?6Sl8Qo3N/yDuhBM0Cz5Cs0p+4cQl96UGOWrydNaYW55rC26eDsQWFo1L8r9O?=
 =?us-ascii?Q?umPYgjDMNeIFPa1AdbrlSQCxDxEPEZ18zdTfk84b0QULBSPO574Bw1ub1K8U?=
 =?us-ascii?Q?x+T3tFHUb9CFzBq1xY1pXrCxnneBhPbNnWwwmlWhRdTviDmbLY6lVKOhlSJo?=
 =?us-ascii?Q?mQSr3pF5U60gCg/JvoHbwpRMNhIbti8AcB1l/AmhqjXpNVL+jn7C20Mfsxfr?=
 =?us-ascii?Q?quq5tGi8A3P0KoDN7c9bdw4Sn+CLBglBgdNVVAP+59G5RGtccDWM6vOxnH75?=
 =?us-ascii?Q?asCX/hExgoUGo8AjyBmdZxCkStZqzRHeqbVawukjOYrOjH7tBKN00LDfbZXd?=
 =?us-ascii?Q?TE+16sDq+gxbeiitccYpL7rFUIKFuFJM6Im/PdSxJoi8i5otEEJk9gxlVb2T?=
 =?us-ascii?Q?8ieE/gO0uXLmnYJSyKrqvsaQ94BBMHoGvk7i5uFfKQ7xqIOQ8ikus049aWkr?=
 =?us-ascii?Q?K2CkHCMv8FjtQnWhPthjh8IF8BqmYpmRbO0mLon2sGtEz7ybo/4GX9GDsiZN?=
 =?us-ascii?Q?VzwoksHtBghccTEv7PZzPT3CtXUb6kk1RjmWdfIjIYNwbYa/w2hPNa5SJz0h?=
 =?us-ascii?Q?o0UiAasyfRdKS/O4e6VAv8xIK5qNNeo181w8pJrdeM1qjdufbQ8+wgl1fyTh?=
 =?us-ascii?Q?F5W+bkZFQNNFfL3tQ+XxcNCuSvl3g1L9BoKQDUGnHtfYFtgVnm7/Mwfm0LTl?=
 =?us-ascii?Q?Tpy/0qyEGfIg12xOvEOWczYeO5kzVaYhPzPPowi+rMCcR8JojGThfY/3yqX+?=
 =?us-ascii?Q?W7rFSTSiUYVTyl/hGWyHux5leRQaz6t3ClFL674xEDQOXyGA9XhHVsy+2Qp2?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5R2ObpNXdV7dgCwlCdloj4x6Pcg2yVJ7xTpYGiP/fz035DU6vqZcXXIpas3v5aAZ0T0rYsV07WVr2wYD47UHV8tYgYavf2n+GEW6cxsBvmufKd58veCBUplwJ1P2siYuy/P/X+D0ztlWVqx1M6x9LPZK393MkBT4eMnIUNpgtx2OhT7sbkP/BcY3XnP0jInYHxbOB3ZjHk3i9zPsRKDH/wO3tWOZ/RnyIZENGU9O5v4q3tmlMm8zU+AWitDRV7EKPaXURRgUxf0EkrNKSUCtQuYK7AE9Fw9mduBAOJYjTa7ocizcBVWr7u9a/9I4d6/9enD4MX0/c/OK9eMzKDH0pz2QpLFOEzB+BxGCzrlhtl0t5O7MRaLSYzb/y6VBv/tiAK+N4POIN/kzDll3usG3XbBg26sbiVQ9W2Ca2XrPJ/AIqRkP5N1JdZrtuI/831wL70C/f1jyGYQaR2aHT1iAIg29HvinjraMJaiHHA1Uo2XqxeApjcEoENOY3PJjRqm122CyzUmzZQT/nOq9cOge3gtIO9hn8MSeCKLkWz8q7jJHTSh2NN7m3ugNIlmrjv+hdQV76vOMAQeVyY7OQark9vQGomZebQvZ48b6ZPfGd0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d96dd0-7faa-4006-67a8-08dd5759c7ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:47.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq4yBX60xuolXe8v20xxhuF8xMc+DFEoJ47/dJOGLEysfyRLX1QHKLn9Y1Uo7dgGXasEqxHSmZE/zkslhAqQgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: aFD8hGaSHO4MLaBACxkTTg3laik4s69u
X-Proofpoint-GUID: aFD8hGaSHO4MLaBACxkTTg3laik4s69u

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

For RT inode, just limit to 1x block, even though larger can be supported
in future.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  | 13 ++++++++++++-
 fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ea79fb246e33..d0a537696514 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -606,12 +606,23 @@ xfs_get_atomic_write_attr(
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		/* For now, set limit at 1x block */
+		*unit_max = ip->i_mount->m_sb.sb_blocksize;
+	} else {
+		*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
+					target->bt_bdev_awu_max);
+	}
 }
 
 static void
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 477c5262cf91..af3ed135be4d 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
 	levels = max(levels, mp->m_rmap_maxlevels);
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
+static inline void
+xfs_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->awu_max = awu_max;
+}
 
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
@@ -736,6 +762,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fbed172d6770..bc96b8214173 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -198,6 +198,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	xfs_extlen_t		awu_max;	/* data device max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


