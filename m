Return-Path: <linux-fsdevel+bounces-13465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995B870231
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC0E28140C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C53D992;
	Mon,  4 Mar 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jW4sHXn9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SHfm74Xk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9648781;
	Mon,  4 Mar 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557546; cv=fail; b=sHjsOa0lDc4PudjKbNWIYFIyZOdgbFQOUW1UyK4tix0/6RXy09fYVV0tGfQLs7l5tIbMBV0sb599UyDeGhC20x/pm+bw35232WKZ8AHlt/cCp+oWFMg+WYQqEziDA/tl0EZpJoUhH6ioxwjfuHPa3TBbRSh97oq8zP/LWeZ8wEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557546; c=relaxed/simple;
	bh=TRyelkttK40ngjNNiq8R8M31tZsjJ1sEyxsL8ZDWMn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWA8zVc1uinyXuTonc8mX2XUpu32h53sGYzC9ap6/x26Lqk5JEITf6f2ey2OGlAsKKJtdvS8v53OeMHBOSdG/VeDjTtZ6My63Bp8jk2cQIdRXQqno/dNw23hkMfnPbQuuc7zhNmZc78KmWmQQuGtJ2XsoM6iUSmFGjUqFEeos3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jW4sHXn9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SHfm74Xk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTl67028481;
	Mon, 4 Mar 2024 13:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Ha8Tv/RMoC8p28JMKFanI9LLeN5wQEQnvUJUy47fDp4=;
 b=jW4sHXn9FtiL5xX2xEv1DYhLoBKJb1HILaxKrmuio9DKn19CnknHjpWvYIM2PaIAeg4d
 6vqxjGX/K4yA4dSaQuIy1K0x2IpgXMBc0pD90Ou4maygPobgGEMUgq2hLFNOeT9XJ1bD
 czoX+wEIc6WMJepedgU8gWJkA7yJMiz33yWrXKVlRr7nZX4PJL62Iz6XPY9Eh6qdlqD/
 O4Q1/OAKRD9rDzp4q1mOlwSzOs+tcWazutLH2j2vacLUbr9FXe0r2ARCool8H40XuxCt
 speT2z6a4hQnmh1toemP125AQ92g8GiI8iTQOxGGdonrhruemEBcRGw6Qddkt2K0gf3q Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuufaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424CfUFM018951;
	Mon, 4 Mar 2024 13:05:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qh5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJxUbVF/OInawU6SDOMo10fIy2pnD385NZqiKqrnwNAs+t+C5AhdZzMiapXTn0F8NFn1hcSeCD7V7tfCaiqV4zgC7TdaSFvy1Vyf7GV3pwjHn/0Y0Jk0uPh+GUUauZ0g1A7Rm8IuA0pez/JW2DmPsb/PYfkf8a+0bIdoS35WjcBH7F+9Rii+H7SLm3FJ6LHucaPX4DSABUp/KpcZsXDq1fp6PFTtOfbnB7ujaV0xyFPgBDAGNzJv6UTAFXyLlrd2Rd9/FMuKPcVgXRym9WhdzBcki9f3H9gfhCYj/T8mA5mN/c4lp7JZ+iwc9sTdhuTIL+I8qgM/BQ6FjLXms2yziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha8Tv/RMoC8p28JMKFanI9LLeN5wQEQnvUJUy47fDp4=;
 b=Z1yd9oI2tv+CVIK9fQX1NR7syr1Kkjh91RQyevE1Y6zLWxXSNEPdwPg4BxbNWBxB49bccQIe60zO2sBugpf0wHMusytGiDs4kC+yntGeRfuhxZK5VPg0U7jVOeNCBjt6qc1MMf+aLLo0oYHglXN8FlhhIjvtF3lopgiBwnYkmj0ciXOFeMX6DdNTRz5bHg1mKUVuVtUpVZVG1pbNi6Ti38oELS6Wgd2N+c2qBxuhhb/F9JRY+TRngBna3ewtavDsAhbVmOOdxPh9ZCa+2we1gDAmytTpkcg07OxKDxxrS4yOdBbzQHgS4wX5mnHBJirNBytmwLTPNXuiic5EoAXz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha8Tv/RMoC8p28JMKFanI9LLeN5wQEQnvUJUy47fDp4=;
 b=SHfm74Xk5wkupr53FdtmRh6YjSZ+q5az4HrA2k/BOGsUvY2CjRVoU6rCksP6nAV5+o8wzgipuAZrW5YEHi+W12NWoVa/Gfw+7RZ1NtXv0k2RJGs14VQeAkXFRb1Ia2D4OjaOQffnORbGp+2z0b0b7Ok53RC80zJykTHGq4gA/EY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:05:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 14/14] fs: xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Mon,  4 Mar 2024 13:04:28 +0000
Message-Id: <20240304130428.13026-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: a610abf4-5fa2-41bf-ec84-08dc3c4bc320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gqo5gyh2IprpuLG3bGdIHB9valibyIq8GvMqjhmgjxeGLa40WfAMIT+WfWAKeV/+IKxO9HVfBmhF02s2Uy9/IPT6GllA5riM3FlcfMJMtH7AhOmanRBHzv37gQHUALH4Uopr/bbqv2+VCVF3q9gue5vdi5ztgF8xQcx8tCqlom3E9KmnhK6GsaghTJfzbU5vTHEBpoMcDrNf46rmYpNs2PDOyi/T14fmZXQ2dwMQIYXk6aeG/+s1Gt/hT8duCN+km5UkPksApPFMbfSl+LCkSrnVQ6+8lPTs1b/Iyc1PzVMr8y+w0Q1jpZ0HaaBKtpEI7uENhnzWOHJebIf46ZbgOomPwaLLd2Ualg4vfkQg9xjfefk9yR3kPZO01AFzTZpTa5wHxtKg1ngn9hCLAUphUH0AlfdMd5a5kf39ohHQOMO8y42HcEee8H+kXRS2WZLPTGZkEle7UsmWpfS9kGNQOmr3mXqopIWr6gNwmYdSnfaq6el9MRlVYduGZ83MZCsiC6s9zFePv+fahPVuFCe0zU/edNs3Z2Ftb0nVdqVrAH5WjSteLNhX+LBI+iZxlfIXt227qWggv13Th8yMTeJxojka+hqIpBAr/m/ZFBLQa57a5Y5EukZ6F9WcU6ah0AZyeP6pLDnlsqychjHidv/uNq+linJ9/svizJZNvYKs0f0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gwg59AP0HP2z5S7qPXlgRcd7fo+7mZDP9l31ldrsDc36aPrB/HxY8px+Y80T?=
 =?us-ascii?Q?DpU2XGVxu2y3+wuaRtnPvU5R8jbRipX7r4bRawhQUGL4Hwo1OwZuojNQMx1P?=
 =?us-ascii?Q?S+o0LBGipFuejhuazjcmSYXP79LG+fEKu9ekpAbtCo+leOwZKp4frEyg7rHl?=
 =?us-ascii?Q?+AE0tSkp2Yaw+YEFUzonyfdYeqxooAEWdJ/C3ebBjbuPPMXT75XA0ByPmqgz?=
 =?us-ascii?Q?5YXzBNeeYKj9Gr1EGR3YUC1vMYUYEbzv1zsLqVkRGn/0/65Dqmn9DiVV4HrM?=
 =?us-ascii?Q?3SUzmq1H+s/waTP98XeNn4IYuQrn6++1LLZM+J3Q5lYQRabzFb3fowSarjWQ?=
 =?us-ascii?Q?blmSYf/77TAZWxwGKBhlLAUcZJbjuc790oZTxRxqHHNq/cyDxAKoq7UWl4jb?=
 =?us-ascii?Q?fIgsWfLSlsofAv3WLklmlY9RPu5SRND4h031XBdmkXIP5iSz7j/yEYShgwsY?=
 =?us-ascii?Q?Vus+rwsG17cTw439Jr3PfylgVrKT9Mwyvs7SauMQOKe2M5EZe8c2wl4WPMTr?=
 =?us-ascii?Q?vlBL3Q+exd/FDmsk7WtJiwV3SNHZmxVlnyCD9VbsK7IG0/J7ixDTNvYTX6AV?=
 =?us-ascii?Q?U8SI+v5N3x8kSkAUtU0d7OThmZ79aFcF3ww+m5XcQyeUv8QP8KSL5AS1wOC4?=
 =?us-ascii?Q?egsPGm/RHd8HSQrYEy13ZjHpFcquyG13L0zct7IW8oXlue4dAEA2ffVDmNlt?=
 =?us-ascii?Q?a9pH+ALE5SIW1y6nEMfV7XLqEgpsPUf0Yt9y5uxMw+6G+m2V+eOgGNLYy2yt?=
 =?us-ascii?Q?GEPtMtRZ5sTkVi6TpvZd9N3ueJO3j2l1BU8FjAXhTYyTK2szhs9EsGibwIQ1?=
 =?us-ascii?Q?cT5Q76geQKY2KMUkb0K2kCp3DdbsOKbCBQj/JN73jy1rtTy87O5smt8812k6?=
 =?us-ascii?Q?8MQzcATgXUUjPyDkzlwg/7zMfrIgT66eh7XY/n2eFa+4FMfLVxhxU9FTjiFb?=
 =?us-ascii?Q?htVmsDilvDokq9OLqwfcLIUTuoAYU9LMoIpmcwTnnhcfusitTUh6vm6ksPpJ?=
 =?us-ascii?Q?mRIEd45EaAO4lgIcOveEtefSL3OCQYp4rvyCBioQlKtVVNgpP+zM4l3ZUSAJ?=
 =?us-ascii?Q?gDW5bHequUzIb9dS+WMeCFfoO8SZa/EDlpDJK8Q5nzlf6aQb1T6wxuziA5+p?=
 =?us-ascii?Q?Gb/yDung7KS5O7/5zPRki6+I7PaO1RTdLSHnypQ+nIZdFMgyQtir9aI037ht?=
 =?us-ascii?Q?XSCOAqt9gorT5COeNMhXL55McYOOaS+Sm5YYUwXv6vmcYCbLUTYx/an9Uu0U?=
 =?us-ascii?Q?HBWCO7jr41d9+ioViKjRoy3utBCUFarowHXQmUwz46hG3gTkkgqkj8c5yTY+?=
 =?us-ascii?Q?31KidgCXFVTq/LsRAs0kP4Wxv3Mqj93u1k3v1Q6S248EpSW2xjbt/H1/8hP3?=
 =?us-ascii?Q?ve2vplXGVWy9MLlW1iv7Eae5vqmaIuNfsiazru1Nsdw8zpJufjFP9paO9zRh?=
 =?us-ascii?Q?IvMws+hbBlImaC//sD7k648dMRcoQ14+7x6yZ7/ZDhiwM5JHpJIq4ldY7Wd/?=
 =?us-ascii?Q?QG11NkHKlC32ssmXJpHf6/dLlqJeZv7xFjnwjXzLlU+ov1XmJ6lwasWcvhoY?=
 =?us-ascii?Q?rl9+qg1snw+3Q+xzL5gsjtC8Dki3j0WTGwIwsopUWNXJx4gAaeH0BsgmbCJk?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NS7S2K6D9rTLiuOKkjJG3HnFUelKdiwkNwnkOqgluA3IS4QxZROKkvKen0+tQbj5z1NeNlUOmn4vbt33TDnWZjp26MWFcw9tOwWNYkNDlPDcDPalrGplEu+JwxIQ4Ve2dh1GS1qZ50YS1zD9giTZMHuHS2CICTDQ0xiI+r0asUC2fIlpCrd8auKjaa3pbewb9QuTHafvV+BwS+d399u+F5ZiUQwCjGn9JBOa6MKv53Woo+4PUlRNf3Wl1gVbojQgCfYuW/UbW3Y9OiRyn1vGekm7UBgkvJlz2u+wFRaSiGhQx9aZkvVmqi1TO+GDcYScGraIEkW8MBbvBYYwhOl74+pxBrINy2eirS9FA2gX0BVNyUbLH9lRGY7h0C0QFwJBYALIfxwE8Rm4KpBSJnBzoJWMc2N25Jw44tipZ0FPFWaK0VxGG1mEWZC+8W/MiYbzM0ELa/jhgnAgp7inJBSVamOekK6S8oLen1znr44GnWEC+L3vBCYgSyNCuxiqYpHPKUmqrHYiwOAd81QsDrG9YwXB/uMs+QE/52bvMZixXX71nJROf9RzI5x9SPgx6VnxA7oru/4R9iFmHCQw6CfCj5mLJQaOktMVhcUUca1D7wo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a610abf4-5fa2-41bf-ec84-08dc3c4bc320
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:27.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXnc4QBlczFqCAxtfRrenSOSc24a4GQoxm0oziDsLi3eRdnz4ad8ooFckxitTpDvcSAr/iNz4/5O8iHPAHw1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: PJYtT9aPmANXv9VyL6IKpufYRqwz0rdx
X-Proofpoint-GUID: PJYtT9aPmANXv9VyL6IKpufYRqwz0rdx

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag. We check for direct I/O and also check that the bdev can actually
support atomic writes.

We rely on the block layer to reject atomic writes which exceed the bdev
request_queue limits, so don't bother checking any such thing here.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cecc5428fd7c..e63851be6c15 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1234,6 +1234,25 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+static bool xfs_file_open_can_atomicwrite(
+	struct inode		*inode,
+	struct file		*file)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (!(file->f_flags & O_DIRECT))
+		return false;
+
+	if (!xfs_inode_atomicwrites(ip))
+		return false;
+
+	if (!bdev_can_atomic_write(target->bt_bdev))
+		return false;
+
+	return true;
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1243,6 +1262,8 @@ xfs_file_open(
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+	if (xfs_file_open_can_atomicwrite(inode, file))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


