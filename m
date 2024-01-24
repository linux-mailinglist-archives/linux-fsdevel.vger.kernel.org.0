Return-Path: <linux-fsdevel+bounces-8717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D983A869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F776B23EA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FA5B5A8;
	Wed, 24 Jan 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLFi+9cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IgVSLfd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDC5A0FD;
	Wed, 24 Jan 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096518; cv=fail; b=HkQgfyKeMQzJSFEd/JZRpZBgtI8DoxpMoc+wuZi9BpdxelyzGfkXMcnS+pV+qAcSDo9/CCtTovY+Ty/gfSThn6aL4nh4XF/vYJaeVEUD9OwEV3+qAhoogrZFa7Sl7vmjlwWKwuqKr8Ck3dK9f+l8hTfmueVlWshjm0rmfZJNMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096518; c=relaxed/simple;
	bh=XzntPZElmNiA0orUKM5b/hUv+unn9WgT/QsNM0aqJU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XISbxTMznZlA+Hruod0Y1aRNrgzF02NuEoEz2JNMH2IJu6ClM9eXJnT5alQw1hKzBGZ23+jhQbDpvTJTPQle23VuYWsYAffR3mAq9Yy/KUm5SAqPKY0FZlgGAgWFCdPeMWfatQxXoXYfQrJpfieD5RiuJQF9AU5571Q1PqZXP+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HLFi+9cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IgVSLfd9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxPEt030725;
	Wed, 24 Jan 2024 11:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=cTFWjnvbEsuX81EMnFt9l1cWFwz7OYTI5W7kirGCqBk=;
 b=HLFi+9cylamqxG7WvRKvLVOfX7tl1dcFhW+e41LqIhOw0eeWtdlS0wml5acmZCPHbwlk
 qqUwM0OsgoXnKorxVg3RF0cm/2Z25RfSREg9UWfLh2qSzCx9/UT5/Hj10Zuh9qM6NmLv
 nG89USF5W+BCw5yIEDNKOa1QbCEiKtxhg5QO4WLQ0NjeXDGMBiavl6urciu8HS3TJG2l
 Pv+4GRyhvXWox28kmLCuz+Sg7HFLWMOLGY4MDUEvMOuzwde8FmcJ5BKzpfU0lmuUTdbI
 pTEuyClrwvBOLlLUU7gZDRI+3SA3fVRxn91k8ykqP/BslOedC2sKl3CYrBmO4vmU/Zue pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cut1jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBVKx9001442;
	Wed, 24 Jan 2024 11:39:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs323xf1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJnaxdqvyzgcqJMdCEDFT563jRAVQR/kwN5IGqruesKhxxad1nKBu8dB4pXfYHQ15OaC8V8UwuDeFJRKoAL8BTkilOnLJiN6fafqyapFWiskGTc7BokULkZNtxd7wlKBvXtAfSxV9toqNQwnnC+jjzZzyuoMfPfohh9cYpQw3gHJtHvcw5tjsWPQ6lJ83kKNALn//39v8TQwfNOJXnVltZnyuK9Tnnh5aHu80gPEYoDWAVEtDJz/r7EW9In0+JVCSqCFs8V0ufon9C4B60rgVIw8NrJhsducMZpP7pb4JINmYeyaYHJ9Ge3n4nCHW9nC2hgU9JT/fPb5wYZart+Kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTFWjnvbEsuX81EMnFt9l1cWFwz7OYTI5W7kirGCqBk=;
 b=dYR7SDp9vn/kz6HuQXm2nUwhLzxSelNoY48BUf82jC3siZpsBhwr3UD1uc+3eeWkN8BGB930+wrvII/+J7mgS2v8RqZScMuHElCVtOxqtfjRskTKvrpAdaLtK2Y3HDVIggDDpSHFU/nVdHMAD4BtQI/mAGxAJv92hbFr7XiwNyTN2Tpw7mfYZEe3gmjfWKo5zXmXVLeuhHnwXzxN9XsTpKL5KxX/WuJlVySTjgougr/OddFQXxArXWJ7ic3SNpfr4q2rxzmKuSktocAW869VLCzFiv1Vluuv8gl+04X1dtTT5C/VX/1fZB+LcjRwFgomsXEnXIOTiT3rva1K/+UmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTFWjnvbEsuX81EMnFt9l1cWFwz7OYTI5W7kirGCqBk=;
 b=IgVSLfd9+BLsE6mc3JLdgntxBbEup9+Z9QKBbF9WAgMUQqw/tnaXk0NHJD8Q+l6E8sJ+K3HqZph0TQMmexjrnpZkqdqh8IZqtNxucp4RI0VBo9AEKmg5OycYCzUBbXbO+ngktZrW5qMPZgPFsHaBbWWoFXj0VJ7DBql49Q8oXIc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed atomically
Date: Wed, 24 Jan 2024 11:38:41 +0000
Message-Id: <20240124113841.31824-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 89741e9d-331c-4fcf-7a86-08dc1cd11dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lfYMIy4QsZNF+4xRFfcp6CxKBZdFu7psaOR5YzqFUocFDXNm5LYpwqZB7CcQFpcL6CccVJmxSC13oma3Ic6g/gbAi2U6oSPQ3le404uZeZ6ZrzE6exCI90SU6v+ykolAoIyssXy9jTbntvEd5C3DFdEmT4PGzDwrUpyWN18AraLbdqKMMtshI2bVz2n7JdOdNmRiJU1PdstnNb8TYaNls9kT3RWR/E+t++nucEB6fVmcvWtGvHwIaVGDI7S+GlvM197TDdbxVx8q3mvt9OY03rnVdRlev9m0Jr5mSJOpVo82jaztqvztNCGj5U5kyU76YERlBZcozofWsdJMZvqyTuCW9DETyxPjIXbLfzEF4jIGxSsmdjbwuLKcf06PPbgaWLKaJwowwV5cMxO9X4JgpUmvILuf6wVwFKb7phM1cYKlq5HI5b/QlXJ8e6O/IpADmZPEDH/rXRRGbnl5vJVxke9cy7UBLyWcDWXfYkO82l98Cxb5zaXOO8l+JbGw6q+0zf8dWlK7aJsdCPSqO/UZ2d5vGNLpWJMro+twR3eQSS2pjT9bqTm1x36x1DCadtp+iZEIvcp1CVs0gxqK8LbXGE34JITQzAlCwCff69pxq10=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(54906003)(316002)(66476007)(66556008)(66946007)(83380400001)(921011)(7416002)(38100700002)(5660300002)(86362001)(36756003)(8676002)(8936002)(4326008)(2906002)(103116003)(41300700001)(1076003)(478600001)(26005)(107886003)(6486002)(6666004)(2616005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xlVzclSmEd/I9JJVQpehK/TPLXPRe6AhqBPfrkGp7ELdP7AI+LssrU3p+sAY?=
 =?us-ascii?Q?6xz5/OfD2UXsETPcWg3XHEysXKcrOzI3BUh+opC/fxssvbQAsgVZbBSxTPKt?=
 =?us-ascii?Q?cYIc+dKRt1N7Ob6n4MDvVmDvW602k7K6QK48XGg/jA90h+u+bAUjqljK3K1M?=
 =?us-ascii?Q?hk3BJ1SlFX0Kj9WVYxPMpoaykOmGsodvQM780b+59kWVx656GYXQ05LEAaGV?=
 =?us-ascii?Q?F74RWrRVIHHM8TXBq4XI3canKpJBEXpnXMG/VV1BJ5BPvnRfKcCRF/Bj16gW?=
 =?us-ascii?Q?VhXoViJpzGeWINmtn/EEpDRd6niF2NkbNrsLaqSMnmc0SzZVLUmOBFiaUvNw?=
 =?us-ascii?Q?u+RK131+UK7oCyc0CI91+ZdAuV9oyXQbVbGRFfeAR1ft/ELLXPNRk8TqVpjU?=
 =?us-ascii?Q?gwN83vepzP9G2o7GZtVBJQfZ7MBavSMOOyatNcFjXNuPZnjQ/oa3HTcrM94b?=
 =?us-ascii?Q?PIKpYiNBFK3hA/irltfmYsOgWCZsrIK7I0CNPClvtAbgaDs7sqpywy/rmsZb?=
 =?us-ascii?Q?rdKMEjGA0GakE9qirvx+FujZpBk7+Lcas3uT+eECqcDm14KS0TL+7aEziJIB?=
 =?us-ascii?Q?58N+spuQFGh/MgCGsHAj2PvP3vPMrZh7DpKVxYOT+stmxYSf/km+VvHphq5M?=
 =?us-ascii?Q?eH7fDfkZDQT2Yem8gmUY7HCJSqgV1dsLasMx7pOMqmYcBULNQVIFBoGRiAnB?=
 =?us-ascii?Q?UwIHLZw9vqPHDLnRjRN4QoeOMEJ2GaMGGm6oZ6zarMup7zrVZtDSSXGcfso8?=
 =?us-ascii?Q?RGE68awEgHlKV6JeZytXkeS71F7eTQIuHHx+6maLetub9M83SIbkjYiQfL16?=
 =?us-ascii?Q?kfehpxObtlDRwUISklJtAjJzZaHpqnBT56TgrVLdhUteNShbAmz/KQijyPiC?=
 =?us-ascii?Q?zeJqMPFzUzKipruo5EG0w8i51hzQY/KP7bGcrnTRoXHLCk36EXRnEnDNihWc?=
 =?us-ascii?Q?EsAJhNHpld8BKl94wuO9ACX4fcyZGtBPOzXvp493ezzJEwgEuJY6eCnhmzL7?=
 =?us-ascii?Q?AdVcfXEqgu1G3Gz/No08W7ypyChjf4zUWReM3BSdnkoomO5+NsvBMx29jdAQ?=
 =?us-ascii?Q?BTMjHLjhx3bWoTlXp0adZyPop6ouCQ2jXJUx5w5RZmALzyHTImiQbdpls7Rv?=
 =?us-ascii?Q?gmjkr8kk2Trj24EA7+YhJm62c+6OVFKLrL8EvH1J0R81xrj/d32AymrjIwif?=
 =?us-ascii?Q?AeoAjz6AVt2wPSmQ3VsoLzDeCjPsJRt3jTqC04o0h6V64k0fKnJYp0cwpiPe?=
 =?us-ascii?Q?4nH5hA3K6sbgJ83s6t4h2uE3YE6v5rSjJVFxnB0Lq8IDEzmQzPRojuFhkz9K?=
 =?us-ascii?Q?6nZ3BxaERASzZ2din7fX+p2VVLaJBoarQaQh0MCmCe+WujMXvvA2mgwPmRrD?=
 =?us-ascii?Q?I9PDPqcak2zbX82H1RxK8exMCJ8UJh+yce9OkNnLtX94/HruQXy+HfiJKyGQ?=
 =?us-ascii?Q?mJJ8vd3oVdwreDJOOSg93vIU5nHktSpfml44zW7C6rJRp61D2qn7SAp6TpZa?=
 =?us-ascii?Q?LZtIV/OF6j58FSEIqfL1wr1Qky6VghDc8ZseZfSlYpcKcAG7QkZKP0j2iZAw?=
 =?us-ascii?Q?IIJNoXGp+xwUq/0v53372BsAhTmAqp3EB1uk6OSkvDC+bVJwSiwf+Z9oRaDK?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	r7yZag3rEHUmOtbqfkxkHLm9kNJXIZEgdgzGTjBeFoPxqyUQddQ6pm1+GUTdEL5HA+yXBp7qibameQCQo2mWj6vqAFy/B85/cIkCQe2tNLCzRE0FRElxb88YP7x9GVTwu3gOQcv42KtN3AEWbqaxIbUszUGCS4ZMnegcHkAYGWpgz0GdPraOzvXjSh82REgZiPyUVdXjGcWvld0f4eJ0DrRuo7XpK30YqLMWRBWf7zQUqvaORdWWMasFk7Ba/3hJcRIvQgnzDIWYChQp5w+lpssVpD7fWn0ElrrooKk7gRM0/eToPd4Vvhal44l44VimbE1RQpjlKpBYUH5MbqGvqQNjgQH9A2cmc5vm9bWhCOsoBPU1ZmsuFgfIrSEWGVgFe55c9Si7pj48NZU5xLJH2WWGkltKhNJ7ag7QL6P3Dz8NEP/2TtvPSavZyNmvQMDka4taK/6jtTn6U2SzRkBVsweCD0VMUaxyJ1HLUcYdLiy7tvXBtsU1Y9CtAsX5AqFCTBpCN2nfsQbb6hTMolCo1AaMAKbdfnl6/cUKCk/jWhBpm5sB+JB/x9YycVIci0Fyqk8DqCRvq0Xz3iN5xki6Pvzmz1qCpSzkaHhiZaE5aoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89741e9d-331c-4fcf-7a86-08dc1cd11dc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:25.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw9e2LBsM2sv3NOisXuB6vyxVlQ3NIZtRqBDZKVIshQQxtl2h9brjqZezMdh28OkWc7jm/Rkk0228ADq+HrivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: vU08l0Vlv9LhDEsWmP3MUho7CIcTXHLM
X-Proofpoint-GUID: vU08l0Vlv9LhDEsWmP3MUho7CIcTXHLM

From: Alan Adamson <alan.adamson@oracle.com>

There is no dedicated NVMe atomic write command (which may error for a
command which exceeds the controller atomic write limits).

As an insurance policy against the block layer sending requests which
cannot be executed atomically, add a check in the queue path.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 35 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5045c84f2516..6a34a5d92088 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -911,6 +911,32 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	/*
+	 * Ensure that nothing has been sent which cannot be executed
+	 * atomically.
+	 */
+	if (req->cmd_flags & REQ_ATOMIC) {
+		struct nvme_ns_head *head = ns->head;
+		u32 boundary_bytes = head->atomic_boundary;
+
+		if (blk_rq_bytes(req) > ns->head->atomic_max)
+			return BLK_STS_IOERR;
+
+		if (boundary_bytes) {
+			u32 mask = boundary_bytes - 1, imask = ~mask;
+			u32 start = blk_rq_pos(req) << SECTOR_SHIFT;
+			u32 end = start + blk_rq_bytes(req);
+
+			if (blk_rq_bytes(req) > boundary_bytes)
+				return BLK_STS_IOERR;
+
+			if (((start & imask) != (end & imask)) &&
+			    (end & mask)) {
+				return BLK_STS_IOERR;
+			}
+		}
+	}
+
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
@@ -1912,7 +1938,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 }
 
 static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
-		struct nvme_ctrl *ctrl, struct nvme_id_ns *id, u32 bs, u32 atomic_bs)
+		struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		struct nvme_id_ns *id, u32 bs, u32 atomic_bs)
 {
 	unsigned int unit_min = 0, unit_max = 0, boundary = 0, max_bytes = 0;
 	struct request_queue *q = disk->queue;
@@ -1943,6 +1970,9 @@ static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
 		unit_max = rounddown_pow_of_two(atomic_bs);
 	}
 
+	head->atomic_max = max_bytes;
+	head->atomic_boundary = boundary;
+
 	blk_queue_atomic_write_max_bytes(q, max_bytes);
 	blk_queue_atomic_write_unit_min_sectors(q, unit_min >> SECTOR_SHIFT);
 	blk_queue_atomic_write_unit_max_sectors(q, unit_max >> SECTOR_SHIFT);
@@ -1980,7 +2010,8 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		else
 			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
 
-		nvme_update_atomic_write_disk_info(disk, ctrl, id, bs, atomic_bs);
+		nvme_update_atomic_write_disk_info(disk, ctrl, head, id,
+						   bs, atomic_bs);
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..938060c85e6f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -476,6 +476,8 @@ struct nvme_ns_head {
 	struct device		cdev_device;
 
 	struct gendisk		*disk;
+	u32 atomic_max;
+	u32 atomic_boundary;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.31.1


