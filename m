Return-Path: <linux-fsdevel+bounces-8773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776483AC4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADCA28C499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E29B81ADD;
	Wed, 24 Jan 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IMy6Jxm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="awhA7DGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE8134738;
	Wed, 24 Jan 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106686; cv=fail; b=Ae0yOxcWz0Tj+tFQfaR8d4h3rFsqqnC8vSeBiVxW4j8j1nKq5si+C7ozbyobJScDxCDNsBizfV12IkHucjqbKlUE7w+xmyszjNKxzC+ZsV1iVsb38D7lmNk170vp0UZYKiNOalgKGD3n0nvFNcZ697a8owt85rN4zw8XbQhXaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106686; c=relaxed/simple;
	bh=AWQ+1Sj0aG5iJnfRsuFkjWtV9Wmvyn7jlgiY2EZpOKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4DVfP+70N2EBpr+qSeVFJgom7Gs6PpfcEAsaUTUf13zeGCU2jISKmnEHIJ25hrHuuJcyDEv3FuIkK0j42Qr5z0GspXZheUP/iG28vMPfCQxrIvNlCeQjFpUYdIONP6rByGwCfqjq4H1wEMuZlWZdV+Wj7oH7S9JxCn4Y0lTuz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IMy6Jxm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=awhA7DGM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEJTc013261;
	Wed, 24 Jan 2024 14:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=brgOp2OxL371o6OTal8xLgcw124BPhdkdF61p4+jAnM=;
 b=IMy6Jxm89oLJ+TefIBozYtvZiig7ZPi5I3MwRHpbTMP7rZeJrsqbTY4AiD3jZaHV3S10
 kola+oXY9iIdsD/A8XQuvEBXRab0NFvr1k0MHX/jOZtvScG55NdZJrdBfc5bu1w6sQmT
 wd4XGKyZAdWbWNmwxuwYRoHktYJDFaV/VqfzcUHBR2zcPaKN7IHWYNtlG1Ot7iYeM/dN
 caFFzcq6kgL9P/qOwFXEcfiPejBkORnFBZBgtsOQJhePVg8b485+SF6ebqtptCjoLsNN
 eWl/nWPY5VrYQgOAlQhlk4Hy8OqBi6BfZ4v0IM7rxIovofzMsmQ/qTwH/3MfXm6M6sp5 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anuqcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE1L29029572;
	Wed, 24 Jan 2024 14:27:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rr2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGzP9I1S3wTfBc9Ar1shLhukZvOQIObtjY1gBaT63XZ1QtGrU153Tpb5e3TatdJWAt6OsWmIef+krX8thTnD6zg75e5MA1kMO56xmasYtjQw0fwMbkLwflzbomA0ZFbgzMekDFHt5GdjhCvpKaKGBHt5fk0MasINpJuzbN7/uo6pj8urmNTk1rDKRFOevwfOwxGcGcEkKsv9Y7VhLXBu/zQ/6jGNGWy3VLwKvo4RPQJ0H3bps3bIgEFeDnn2EVEWFQ48b8NZpUf/HpigRCDWxBOyqifcT7ZoAKCguxyccz9+cJR2xjbLo2CpHpIaCr7duCVUB3EgUXpM+QYDPAFUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brgOp2OxL371o6OTal8xLgcw124BPhdkdF61p4+jAnM=;
 b=DpAniQqlGZbciQTG6xnHQGO9Eq/k92NnBcZCKFarrS5FGDYPgg+4zofrmVJyNyJGE0LYXALk1HXGzDxyRFw3c0oFnU0s7qhbkdNCaULA17mKpcSh408x6mR4oCkJp+TIg4YWfCN3lEEACYhFWYTo5JGfDhmGTGnc9M1PZcqXQFR00+bJXeEBMiGQvs9zi0skRijeO2jF8V/uy4hLQS5t06MPH5GJ8W6ADPxmj+cx+G8UuKQt9KOtZeyLJypG5LNhZusUUZZkBBb3/miJYxuMDc7xr8O/HCvcboVi+DG8XQchrvQiwjTjcCLK2iaKjyYKs9wG/Wdv30HZuwZ0jIip4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brgOp2OxL371o6OTal8xLgcw124BPhdkdF61p4+jAnM=;
 b=awhA7DGMHbiJd6JtGpDBwuVfA8+6SoOk3NVEtR3teiVK6JAMv3ndCt/7fv5ZnFZChX6BLLGqnm3snqDFmc/cProoiiHKIXR6uHn91X6O5qAhi89PrXEWv+GWkaEJ26ImR9bFq/jherle+BfmMUVY1fyE5qko8RLEhKqWXBDFdVA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:27:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:27:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/6] fs: Add FS_XFLAG_ATOMICWRITES flag
Date: Wed, 24 Jan 2024 14:26:41 +0000
Message-Id: <20240124142645.9334-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0141.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ce835-b02e-467b-727a-08dc1ce887bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4GCDjVH3vEeENEUcHvdJKdTgQ55KZOR2S34rrwQ59hjq0nCbhYitw0kT1oZoSxHxWxudz/mGYD1UNNWaTaySjjHilbAB6Tk7yg0oNGwEEXf/Cw6mtMTGGcbmgpQZgVFF4ouYLAf0NuTBqYM5xwd46OhBMHZvU8W/q5nXSG1B1ibKT32mdJ1IL6IbJ8x/98oH64pSd2njKxIIKO/2dVsH5KljLPcbqnknqpM46O1UGgxDBsDxgM5rYh5aXIpChVWDB1oacFPpbwjq8c6MmIki/AKah5oPNr4I0wMz8c08FkmlrVpCfDb14Gkk2GuaLfCY6B+fUA3W+yG3DeGlWsFo5MjOEXNl2dP5L93IqH6FSD+aqIlHS8eRt/yOaaRqyxCSF01myqYKPu7Q/4vVAf7saKr+T+SVp/NirSbhjjfCV7RNLQghLWiYt+yDEcgXrIbwLAfi8GAosBxK5SoRo1/SmqS0vmWc8LmdCz+S8s4U3DVf/kLMEd8H9/PkZETYeZjLY7ndzIhPpBU/6G+is+19Ry2pDB6Xgnzlq1P0eLEnHKfX2kql4icurGSCVXivluLY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(4744005)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t77jWTjJB1w13QqySus8Ig06VwntaPC4FLQvVllfbcpClZ9esxhBTH/R1x0s?=
 =?us-ascii?Q?Uqj4oQZa3HxMT2CoV7lh4RkC/Tmw0Iz/eiUfdJD+8qUsSvgLKgQ5gHENLBQs?=
 =?us-ascii?Q?Fg7wDuD9H/YNOx12VzQxRPMDkQo0YbqNJrK0hONRXMryZD2mmeNwUck8gHO6?=
 =?us-ascii?Q?MOPWXpNPEj37Z+kIWEfpw7GzGkTG9FeHW8UToDZopak9+nBYRPgPaXPKB7qs?=
 =?us-ascii?Q?Qg+w1xT2iN5R9ZcYj4hFZwV384pAdk6qUC46kK8a6dm4NeT9ToV2R2tP2dM5?=
 =?us-ascii?Q?IbsuFxG3eqLJoPPbrIYr93S9N9mMqz3DaPL1XHKAvNavCNbCeLwJF19Xr/FS?=
 =?us-ascii?Q?8c2VLXEbJ/tzLMJ5qhnEdA0MEA4vntSAXQIEZY9PLWa1/VqCxVpEzBcosS8L?=
 =?us-ascii?Q?JujRYtXMEL48woIdwJb1/CoRrXBZQfiuzGCdJIzB/vYRKMM5nnAe1UZ6xpKC?=
 =?us-ascii?Q?FAah9Ld42pPdgJ8u9fnB26BdMnuJJuCHq+s/UoEgJIAuaJBDNMAy8mR/V/8v?=
 =?us-ascii?Q?SNwmooydi4GDgOaqCO2kihchuaG4BNCNpfouMOFH9jW2kWgDrIfhXNs7rbts?=
 =?us-ascii?Q?1zSED+ALa1zE5DJTGWLD019fEUktDCm8w7dItOOfLOOBnjaYIn4AG7l0q8iE?=
 =?us-ascii?Q?O+f3qeB9OnGrSakBmwl/pvwxsY4oHFmEqyEaXqUYBkpHKqIzf9SBBaVuJvZW?=
 =?us-ascii?Q?zKDrywMcdJ6TBp6oaauO0ZFMeAdBSEM3ZgZGVMaUg3sOUpP8PAYcVkVoeV8I?=
 =?us-ascii?Q?mFJsbgP1gFUC39F8UWS7jXcLyOEcWraDMCXhcHR+v3HzrnbKl+DkYYHSD7j8?=
 =?us-ascii?Q?8zDr6bfEnr5hnauhFA8sDiEGnQxPoVY5aj+HCq4wbcrKrsUW37XXFbtvOrfq?=
 =?us-ascii?Q?JDbStODNA+5MHOrpQDjm0wFjH1ppZMmzzFN35oSJ329VFFt2homrzZrWz2n2?=
 =?us-ascii?Q?6aNHqUePVUiXnXORKW1AMIYdwWxMgtRjkw9IrCDTzzRkWkJKptZGPiVPows+?=
 =?us-ascii?Q?r4vmgt2be/cBDmLsy7LPEpZrgLZ6xykZtSYUCpGhOwdrfJ+UzqjDgytfJi5C?=
 =?us-ascii?Q?bUdVh/tCEKTGKuiKdUGexsfung/Jrtpwwm32ZiW7zejCZ0I9775yzKWDuC7c?=
 =?us-ascii?Q?fQrxq9ocke8zFiS3jFCXfBbutTURiE5y85xkqFUritAvU5F9Rt75pISjY89b?=
 =?us-ascii?Q?j5JbPQOgTx7YciADs6JFCgz6v1x1WvPac+OG8UO/SrYje9etlaWsV+LB7eq3?=
 =?us-ascii?Q?W4iXZuVtQXP9hczQu2YhiQ0QUUkiqNbzU/vJlfG6KDUPAA9WzAisgxug7Nxu?=
 =?us-ascii?Q?TOAPT7dFhux23CVVHuGOvqHF2HL49ufGRmTBFo1mpOHeq07v8y3ftyNlIO/V?=
 =?us-ascii?Q?ewbL9/Qtd3FVNR3ndfACj0kkiqe5cXAXd6bFsFk/R7dShV7VHdVCNBhwzd7X?=
 =?us-ascii?Q?vEHoQsWZChJGKUsVYZ+rjsCXCpM2a9WcL3udbCEoobEBWZ/CuFv/px7g4XyV?=
 =?us-ascii?Q?/ykxlQpM6y1Sv9lzsP/a/D5sy8+rxFUIki5NRsWAEeRdBH0CDEYiJS1aHWEE?=
 =?us-ascii?Q?Kol8aKNb/rVyzn3D/TOwUR/dAzv2sUL1c+dbOeZpmkABbtvNoU3zGrlTO7U8?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PvTL2Y0wzMvYS9jeX+JOMvcXbcNmh+vsaLtFeiLjKB9lsiOWqMfnUT2Ueck8xagEMmeCtYbECl4ku0jikWSRkr7xnBl/q9fCSkasxaFCXmVG9UEb7OWNSsRQC0699MwxDGyOY7SeFx7f6UHRjfWmwL4j68nIapkm7Kd3ryO08EWHHyXlwqLRNEYfljecZhs0wcdglBihGLOacsUlKh2vdruwgsDlaHmz4kStfmzOAKWUM0Qf3vPNiYjiSpHdW2CG+axM0SZVaGQIrYbXyYiooojrw/xhhfNwinp4HjqBnkUdoM+BqEHhg9+d6hQE6ohfXHjlpDLniuXHCgxSTYnlB1FFgTez0HI+VKdkTsgWyoDBxUdN5p9t2MwpjdDdQkIF4srgivkijSgUh5jQhxydtJBoGiRmXf+65T7bSeD1fbWF4/FyV4h5kX3Ufx4K68dzskmljQ01PKfoVzYYjZpMdTVwe5/Pr/fLEYg1MXPlVInu5XANESkbdSCOKn+W/LrpTGAu0aN+N0gGQ1faiOi4B2zV/7ht7S3C8bIGp6y/i+15157ZMvAbZG92oP592IC336G388j5H5urjQgZoTQcSduAjxPR/UzttuggV/D4/kQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ce835-b02e-467b-727a-08dc1ce887bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:27:01.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSfqX6LmuB3kfMBMvmq2V/RFNBfxRGttNbFiuM9GjM/U1qfwoP1FTPXZFXvs4rl9CfrhJJqBe0y2FH6/UgnaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-GUID: 5tqKjQQKyj4h_M4ozfeoLSD-yJPHl15D
X-Proofpoint-ORIG-GUID: 5tqKjQQKyj4h_M4ozfeoLSD-yJPHl15D

Add a flag indicating that a regular file is enabled for atomic writes.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a0975ae81e64..b5b4e1db9576 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


