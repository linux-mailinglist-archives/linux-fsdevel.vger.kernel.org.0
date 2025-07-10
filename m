Return-Path: <linux-fsdevel+bounces-54528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48264B007BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB5E544582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6255275B15;
	Thu, 10 Jul 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAGvH+pW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xe8C3sQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73829B220;
	Thu, 10 Jul 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162733; cv=fail; b=kGRup0ScK3MXvWxgRDII/L1ixWZmEhbBs2y+OPoVsGqewvCICgOa7SJ/VVnyYCxoyiP45djyY1DgrGDjk9lXoK/6txawH7qESN+cjfpIAmI+d2f3JvGnRYhRAC3JEesT7WgBrSZHb5y3xDukzOKJYeNPUk/Zc0whItgx9Lc8McY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162733; c=relaxed/simple;
	bh=KkOGjKdq2IJKxxmFZySovX7PfYXzZ29GwuKJbFX2uVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+DKJCJz9Q5qcFC/usZXlTvnuf9u2FPHcqtBr6R9+HjTRZ2+Gpe0G0I7X3pDCWJSOKaRdHtkG62DeG/f8vYtGq46qYZNkHDWNATlkm1bcnGFNi3K1lRyZfMRGnzxNfvpRBCpFIg8+R6jFeC1Z9EnC0nzeU3PQeIh/JfU9eOY74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAGvH+pW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xe8C3sQh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF73Nq007434;
	Thu, 10 Jul 2025 15:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=; b=
	sAGvH+pWw/QlJ4LQNFkKHGahenjh7GClTTYY/J6CyMLAdRpbm7RSVb8NOfM2FGyD
	JuTkv4VnDAXvrqV2nXMSScxq3B0W0rhHcreSA+3Fdawk2VnpLwc5J/sVzbgWs0Q8
	nA5R8lxkMA0Fo6oq/AxKmoUOJcgiafvtJpGijoToWN456CEyoksnTULaWr+jgqXG
	p1JOpHD/ZrNyzDHB1cqp/VBOLyCO/4SqJCr12Z6GWh9Hz/RkigHwDH7kNRKYbHFb
	5KQ0e06pk9nfSx8zWg7z0PPrXjUCy/1C3rusVaj1cxoa1qG+iyjLZTfZcRgXcz9P
	je2IPgWycTQoJ45VoGrCVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd0393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEmC7c013987;
	Thu, 10 Jul 2025 15:50:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcfqwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwW7xseEr1PHW4KnJUZD1l73ihGMx+fGS+YnUvplH6teNp0mbkkQ9kyLUqKiKOpyL+pu/CrfZVZdOgePYECfa3LSnb3/Sy/0HYW9RVkOHYfZ1g0dWrcXOqfIEHVavzEpSh9jZnzC4aPWxDygqHcbJczfcdZlJ46CwPU7w9nnee1A1w+/kZ1wr/5RmkzC0nO2w1NPuedBpKlwZhZcGkOgL1r72JHoj97exUmMEs5mUQSMivdvFcI4hj9mVWAcRg+CaeZAnSLZLFBh/c/l3XLwdSpy7+2jvly5eJcIE9RGlf27DcE2vzGTT9yKcUm2A0AStpafkkR+CXYsRuDYonEW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=;
 b=p306cCJq+cnR8ycAiX+qZdyTGkI3fhJsQmPsnJj1L5/hBioDeCLXdCSjrVWRfSvJOl0Jx9S/z3UIP5Me26FDlB0aWN5BK7G4yfR8zQOas4iHTYNpa8y4sFr5/MNBFk2KJoRM3CuGf4CSP5W5V4ZlVpIMg/mVd6PvT28ozbB/6Pam98fcblK19ibIjA860/TY3DK5vN7KthYeTcWURUn+aq97LGfgU4NdwIPrMOTvQ7Ee8ThLha8VYVhNhZrripCiS8In7Bz18a7LG6J3q9uBxlSZFM4+RLicQJ1dAGuWfpGO6Y0AMbAqNy6MDTCAaWg1SwAKydel6vAWgMm/OdticQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9G4Gwx4oz0qS31ul15VOYdWon9UAmf5ja6emhAXTZ0=;
 b=xe8C3sQhnITAf8fitwwXuhF+8/eMy2uo//4bF9uyLgsOya462g67fcCxWHL1nZH+KZ41TmWPjFz+vnlT6ObBbvAbOh5sls5S+tmsvgZ4vF4DhnZKM1S48lF/ASxp00gWHo6Yin9kq5QCh3EWtyqVojeEHrbpg/GJADOrpKiSkTs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 10 Jul
 2025 15:50:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 06/10] mm/mremap: check remap conditions earlier
Date: Thu, 10 Jul 2025 16:50:30 +0100
Message-ID: <e1adffe889289eea167fdf42673ff5ba6f78106c.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: fb354d55-d4e8-40f4-fa41-08ddbfc98e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaxfVYTcosx9HwRexAdT2k1eR0Xs/Zznimx8MW3908U9dmYxSoBNGljeQnMm?=
 =?us-ascii?Q?s72DOKh+6qtaRMsDJczqYU60UaAxzVkNLeICoGefi45JHSrrEvSEEHjtGjIe?=
 =?us-ascii?Q?hcIFIIdyC+AAjD6lj+ofKE5v478fL3pGMKBdxPxvHyVTt7wE6G9ghfpEPtlr?=
 =?us-ascii?Q?mGKZ4bd2ERQkoLu9YMWqtN2d/e6QImqr4+fa1hEevGzqVl69F6Gi928mr9Ya?=
 =?us-ascii?Q?3Drnsc5lHk+4mI6CsuTPeaUkCgC70iOlAruzVun1R67hHpUVxrKwwQsq14Zv?=
 =?us-ascii?Q?yRz3OecRCZtPG1yZtbL3yl5cUGcbr4hHJYFnTmaxvreWHP32nSl6+hwNmcoC?=
 =?us-ascii?Q?vd1aY149cFtHM4qj9h8A4zSIOgWTraTfI/0oiXpfmImmQ6pyVdV2cKnrDeyq?=
 =?us-ascii?Q?mQUAPdfz4+k8d5Fv7hgQq3dHELR939MN9OAdFcsOEIudYAmaavWM8+I6sKP5?=
 =?us-ascii?Q?RmGYldN2hROJI4Ee/nWqY4NnPqfN1t2WaaTxJv7AQ7sYIhoFxl1+if6ED9Oj?=
 =?us-ascii?Q?eH8s0ciNyEYPqIaVPRIRhEg1ixyrjniqKZ+cNxpA8MMR7/5znX6u8karPbp0?=
 =?us-ascii?Q?dXEd2lKiq6PiV1RKcy0ean0IeKKzC9NWZKsmEB5IPiE12wbeXt4sN0/ihiQ4?=
 =?us-ascii?Q?TsDfKWrxBkUfRLXucYPbMZWpzeJHHHrlKWz2EvtTNMs9r69tPyMD/6gokfyg?=
 =?us-ascii?Q?g9BxprbogEbhKVUK/vgbxVnZu9ERLGUjv24JuCFBDWkMsRl/O4jLB8gPonV+?=
 =?us-ascii?Q?jbbhJO10r/RLv77SsXEOPvZiUN/6cNPHbUxt7zzwZWVmv5Dbra+uzDwvw2TS?=
 =?us-ascii?Q?bgyaN696aMo4eMZAxBjvEYSIwS3j7VlBnKXQefIbGbjUHioZ7Hu4K/W983cD?=
 =?us-ascii?Q?4PSaAiomsUKcKD9CJweWTEcoxTyEw1gBauyb8xsqezWo1D/vk5h55M2FaQYZ?=
 =?us-ascii?Q?Bq31uUGmVMmXvRKVDW9zUJhV9gsETZbJcLO4LN67XTdZmWR3YLuxzy84chh9?=
 =?us-ascii?Q?SCF+8JCFB8zGSovisJIGQsJ/mTTl8IUhamVRxB/nnPPY1uboJ2DLyLSYbIu8?=
 =?us-ascii?Q?P2rKmYRlMgPRSt9REsuUxrm6vdZ4uP6hF18IrTA8bdaCzgHoKfGSwUfxuEeG?=
 =?us-ascii?Q?eT4BGWeVxY5z/wvogH7JDTHP8ribNuKNli3KcZC1JIzGg0WsQpbMzA8nMMqB?=
 =?us-ascii?Q?lf0E+B+5V5jwYiBqcxpmix2Gur+UHk1a5NdPKqI7xmKJBav1T3lIUwaOgpQh?=
 =?us-ascii?Q?+IpcBu8MyNLZwXZI7Zw3YrayIuFvKBaZK52M88JSpUUM43Myg624zVK1s9xB?=
 =?us-ascii?Q?GLuvKqBNgkIAqHSGPLDplqvhisUJ1Fg4Z+Nanno84tNGEPx1n/AsfV+2FHPF?=
 =?us-ascii?Q?1JnsK/1yttbOTs1VvRMB7gr+RJO1qTfFyKE+DvOgNYLUNI6sRS3M0WO6LLZD?=
 =?us-ascii?Q?N8hdUPYrPG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKwI5/GmPUtW7ghDrhDbMGhmuniWHBZHwos83OTni93+4kVh+bL7+hTlD+z6?=
 =?us-ascii?Q?woE93aiW7crHM3bFSal/09grvQBQbZVQKn1CaHdn/6kYRjnrwhy2MhreYeRh?=
 =?us-ascii?Q?DhRgFhx8g7QpFOnKZc3fiPZIoKFLKXa3N53tCphVgyeI5uSZogvV50yHXigi?=
 =?us-ascii?Q?yWGKdseTfVHUo/R7csgvcMy61sNhCCtV71qOMavBmraY0kcKPMbVfs+QA2WC?=
 =?us-ascii?Q?b5f1hnoNTvfFoyZJrprwebhGtdVt/hWoAN3mFtqj/ZwxFrUJcyx5GaIuTh4b?=
 =?us-ascii?Q?IKnb1+WTtydZDjMDHqEjtdglGJ9ZSF240o9vxbtkiE+X3ijHu1doKxuIxQBP?=
 =?us-ascii?Q?yDveQB2S7xfaT02SO4UV+6kjsEWo7bESP/OCoT03F3s7Uh2pVc0gPzTffSLT?=
 =?us-ascii?Q?PJCpiHf9yhN4KBavcp7cyc7LqpiNu2UWmG4XLp1WEoQj1K52F6k8i+d/m4yN?=
 =?us-ascii?Q?eUAsmKa/Aq0r4XelrQUBtAhH4Ae8MyXfuGNReuTpirT+oWgX3Zgst6UUCLe6?=
 =?us-ascii?Q?fsP8i+XrWlTqCIDws9/KeNBDGYCMgKn1jKJ6VOAQRrcXfI+s7H1avNUkpk0+?=
 =?us-ascii?Q?RrwzEo2Nmgv1ykrncMbEOWtfyDE22dVOQtghW9SZ5fLJ7EEO1g1Hh4z7YAdd?=
 =?us-ascii?Q?IHPll13CDXgKHdK6Gvsr1JwDnN84eQpHCxThS4au/cHSw+12NW3Q2knjbnEV?=
 =?us-ascii?Q?uwDI1SNzWqvNtovacnnIGLAAcMZZLmtlH4KY4NFzag9xn3ikwEEAJ24CYISl?=
 =?us-ascii?Q?Sj9GrboYp40/H/AcNT1Le8xXcsPXmyTyrsbmut4NXHf1+MzxZSfVBxdcVBcT?=
 =?us-ascii?Q?O7HHyHY7VXpyHwZGGMER8lU241wEu4xtFByEsfEl8acFcUWRvlTz2ZEXJrfy?=
 =?us-ascii?Q?psuWAWUe/HupziMz4CytELy8uHGo1a0LSu/uiTACp7ivALKIRCi6xvKWJZwZ?=
 =?us-ascii?Q?HbQ77SfNtXV6B1AxNth8FlU8j6b3xGB6FvgRfiZvrRv3P/+qxV6axD5AZfaI?=
 =?us-ascii?Q?1ksxXXTslNQYdK3SFpLdYhT5N5EGkIQ/8NSQ6AXHbbhtlIjf0UL3a1pm0C7+?=
 =?us-ascii?Q?k2r+8p5doRfjbtf//mymXBt+4HhgLN0c6awuLNvssTzgJDF5HsvgIaKoPS0m?=
 =?us-ascii?Q?yChrfQaMK7QdivTI/jMZEneZ6BNMbFT19YIwPpT0Y060RqvAMcMjpYbDQ/Ep?=
 =?us-ascii?Q?zK1OpXaN5cHx9yEztjSc46FciLHukGGD+2tmy25y4EtsXP5USk0Ck2bXTz3A?=
 =?us-ascii?Q?r4XWiIWJL3BXS2swRxdbnItDzxSy7rIrdSezWd7S5YgIMmemvLbISsFSvCsU?=
 =?us-ascii?Q?ZNj7je+emDJR0Z6q0kaR+Cu1NeFmL3bCK6s2/05mHwzmU6epJeZkKQ3MwhNB?=
 =?us-ascii?Q?mZGIg9dVsBvUBJ9B/zQzfS4N3dNQ4BfwrOALRyPXVSCqFY8h3WDSnqIC0uQZ?=
 =?us-ascii?Q?jPQlWZ5rXgdH1pShb6sa+bI4FgDfurFeVdmCVYFK2r2U6BrwJef+5XIQjbjZ?=
 =?us-ascii?Q?wZPkTAHBCn/z4OJfmeatqyj/bc8ROR8YQfEHFEnth/uwh8Vl3l5G2qdxsrd2?=
 =?us-ascii?Q?f/oYo+2p9RBKexBzWRUdszHchFnSzxWLj2gSWiRkTgI58R6K2/VgsRUsaEKB?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i85+FIJ/zW5i4CX554XIFq0xzIrZC2U3enFtRmTsDy8M9JNnDCPFcfp8RraT3BFICrVfTxsTo7z67hGJ4DiFkcHsrnRB2NcdkTvpYPMQm1BhqO5GwX0gGPU49tVfavPQ8smOWDQbbyizt+cDHxrwHjlba51ffR1swv3ofe5H7tL2VpgmN0WSmFrJzLNO69q4dK9Svs0zUjxXxwmuy1G1HBB4EkTe9U7b2ftiR25cMlCHXo8Sxj/vWqOGbA6jVjBtem+V7wmc0y21LQWJJdRzosESHKzWQegclFPipcG3xG0/Rk+xG0GQc8R+5k2hMumqsXg3Wqx6MadMQDSWWvrUrzzt7sI8LWVwmb4ZosGnxhu4i+et7D3RUknhVOZh7ruTJjKXGL3IdH34s4TYHprBEvDtn1u8AVHH9G8T50y8zt9tLjMFYZ8yFi9JGmP9yCtMf7vTh9nDgoApxRLPLbkvswiP6L0kSpRd3GjehBnyhvhTFel5v38EbAYxzFGlNcSmYLTIZieAUL7RUJYrSe11JGTpK5TcOf9o0EeRnCo1KKjZWFHBn4tbi3IxvYghEP5eLie7vyVxAbc3ZoNzpJOf07ycBSnBLLSBlD3erX2XdBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb354d55-d4e8-40f4-fa41-08ddbfc98e31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:55.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbG6l+ACTcFNYZHnkd7t9YOLByvXo2xxXkv9+wygPkAnnIpHjvpf7Dnp+Ltk4qVxajrNekotNMxPxkUKQpL8n3Od252rksOaKPbfMjJ9iKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100136
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe161 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QQFbvnUwB9Dxs2rSiigA:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX2xVV6h4g/LAn 36d7taTWXYoafVCO+aC7Z2UOGCao4kEZibKPPzaCvCqbj/1Ggk6qyX7AVL1Zwa9HN2yQeIaa5nS mL5hcckE31qa4cKugPERutIvAwLIjoU5pg/sRNaOrEx7TEe/YPzDcljCj5TvNqxcmJqxy1t7f30
 6wkv3zcwx5Shxzu83pDUxp4ckd7slzfvEHDotwi4Iw/phzM1dCMU/q5RWdULm5IcuROuQTnYRUZ gL2mpBWz5tCdqBXFj9qoJgTG0Terf2qI760zgm9M9kwqCciIc8EeS/xpmbJYuYBu7s2xv3yOLX2 NQ4//F+OTXPSouZ+rmyh68bXqjFGFKI3OhTssVubBRYScqMtJ6aMbYQ5DLboIDA23vEp0Awt/ll
 g8j/UkZ2nNJrstdEz7RxzQGcvrYuXD7mAr8LAHusUfPcnOgIpv2TxdXBJMCPS6hWYee5QCQ9
X-Proofpoint-ORIG-GUID: -0Vo5SSMIvdBSrcrepKw0r-Q5Dh02_DX
X-Proofpoint-GUID: -0Vo5SSMIvdBSrcrepKw0r-Q5Dh02_DX

When we expand or move a VMA, this requires a number of additional checks
to be performed.

Make it really obvious under what circumstances these checks must be
performed and aggregate all the checks in one place by invoking this in
check_prep_vma().

We have to adjust the checks to account for shrink + move operations by
checking new_len <= old_len rather than new_len == old_len.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index b2ee95182b36..116203766ce0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1345,7 +1345,7 @@ static int remap_is_valid(struct vma_remap_struct *vrm)
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
-	if (new_len == old_len)
+	if (new_len <= old_len)
 		return 0;
 
 	/* Need to be careful about a growing mapping */
@@ -1445,10 +1445,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (vrm->flags & MREMAP_DONTUNMAP) {
 		vm_flags_t vm_flags = vrm->vma->vm_flags;
@@ -1637,10 +1633,6 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/*
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
@@ -1707,6 +1699,21 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+/*
+ * Will this operation result in the VMA being expanded or moved and thus need
+ * to map a new portion of virtual address space?
+ */
+static bool vrm_will_map_new(struct vma_remap_struct *vrm)
+{
+	if (vrm->remap_type == MREMAP_EXPAND)
+		return true;
+
+	if (vrm_implies_new_addr(vrm))
+		return true;
+
+	return false;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1728,6 +1735,9 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (!vrm_implies_new_addr(vrm))
 		vrm->new_addr = vrm->addr;
 
+	if (vrm_will_map_new(vrm))
+		return remap_is_valid(vrm);
+
 	return 0;
 }
 
-- 
2.50.0


