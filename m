Return-Path: <linux-fsdevel+bounces-54598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C266DB01646
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FD63A9100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BF226D14;
	Fri, 11 Jul 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g6mT1K2R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fP280jzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761642222BF;
	Fri, 11 Jul 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222741; cv=fail; b=Brdhr3Cx/J/gU2QpgqXtt0LxBuSche7m424/ZsC4HJxhM5jFHleFzbgVHIWDD/g2VKsuJiXx6rJP0CphJzSPT1xMPycF8CNy3ZEtlChlhwddsKnO8eQSZPFsn/uAFJwc5oZXZzQFKhuY3NuQ1ilE3LmtCJDocgFxz8tldd6rPEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222741; c=relaxed/simple;
	bh=VHWG7S5bXA3IltnjW1JB+EPWCAm/uUVctzItMXSSY6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4gPiwyII1gB7YjhT7w9HdsJBNywuRWtacAumfoT/kV2wRIZYBgxaGUbJTw7S9Xb9/+JbXdD1+koNIIyBMITmgbIQaa5ru4tzA9nNyIBHTyUr1WRcgHUS6d9eYog9rIuY5xt1nw+BPogBF3Kd3O7fQHL8Hlaea6GG827c6Bbvdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g6mT1K2R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fP280jzF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B6fjel005227;
	Fri, 11 Jul 2025 08:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/WesFGrFfEbw8zBDlB
	MjSfFs+v09ukLTL5dLJ6zo57c=; b=g6mT1K2RNi28ozRa+jlVUQAG1eTR8mFRMQ
	I/uli0t/lB9gVDg8Ueh/ddengJ36Dz1r/kwcHV4QKc1BaI6O6VptmDz5TPMXsCSI
	yZVUbq3Es8kGW9tpbZ9FpeftRhNSVB86bAlYHLIw3IySw6kND2t2/2J+5d2adnR1
	1xn5o5d9Y+w6HZ0cQxO4aK3HOYuGzTmHNElJx/icidZmt7+LRadGsjS7xLkL+4uf
	b7U2k2P80R1kgETJff0NxJ1bclbTwIBjzKGmcFEkpWNqxmZpW39TZ5GhIItUWqIa
	OAP8EwuD0ZywLe2uy9FaC6JpuxV2D7xiD9/2oV+bkabn10f2wPCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47twjmr4x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7ro3F040410;
	Fri, 11 Jul 2025 08:31:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdhq3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrssEiBVmaDPFfzMjqASargJhaa2ZhjzdKdf655B0ZMjPNq8pqR2fut22dlqLQenZzCvTxLF+vGOGT93ieuRSXv6aRxP21MO2H+Tnf86Fq/PE0mGZccNQFx5wtIwQxGL6yjEernxYUNRCioMtZrcmbirJlh7l83i6inXHzcXrtpPFd8mx1/we3KO8d4fisTfzHwegwkTul/9rjC3v3toAYzSXwO4RixppwcJvf++Abz0WyHiWbm7Gh4PZe+pOFbeZWb7g+NqtGmOUeVAaOj5rkodt/PtaO/nz2ye3kukSQP4jDqXOnPsrk2Kwd5c6D1068u0sptaRZiPXPFRlUMWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WesFGrFfEbw8zBDlBMjSfFs+v09ukLTL5dLJ6zo57c=;
 b=Dh8PQa3M7Q7FiUKrzLR4ri+0t81rNd5VkYAjbheO+iBHA9ohx/arGR/wYeLwVD9XBhzspgbk/HttMrZDk4nnZKfMCzPT8y/yvY63ItGhniDAk8LXy4WNxta0epNreTwLjSXBSWcUGEXgH9koj37Q6eX3VqnLPXbjGxaqBWtMs9LBaApiXMRLoESRpg3J2TzXCGiDMP1PRb00iCfMyzO3jcvq+zNEw31WpmvyjsNCgyZqU7K9xaG5BR8Cw5lPEMVMzG4EjJtKKnpt2uCFRqC8e0BIdIPAj09LtxQ6HHxGflsxVP28qcz2NWFeHEO2M98d7N2uoMFwVojJlXiwVa/4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WesFGrFfEbw8zBDlBMjSfFs+v09ukLTL5dLJ6zo57c=;
 b=fP280jzFOwnj/tLhw98hyNKlHIqMWe1m8Tx/huZE/yM4Nm7ov/PoyQ4al1zNCdMPXNarldJx1mi6BIy8lZBFLRVhamoGbLjIWDmHcgVzr6Rd0jMkg4riO9VVUq6RUYDh0nOL0RPTg9UgvV696Aq2UWDD8qUAeKqGapZ3T0t/mus=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7130.namprd10.prod.outlook.com (2603:10b6:8:e2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Fri, 11 Jul 2025 08:31:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 08:31:36 +0000
Date: Fri, 11 Jul 2025 09:31:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <50906a91-5417-4d44-85ea-d114c4cec3a5@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
 <aHDIk6bKzI5kf_be@finisterre.sirena.org.uk>
 <aHDJtSKEGWJlMnzz@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDJtSKEGWJlMnzz@finisterre.sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b47989-0e22-47b4-efac-08ddc055597f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t9Oi4VBo9A1ct76orR+M6bJH5Olf44goWMv2ARSichyIGUcmU6EeBOWMTgcq?=
 =?us-ascii?Q?Cr2zUYT7fMKQM51FFDYQds6bF/dD8sFKLTnrf3kkCyUYEzROoQFCWkGCPxi5?=
 =?us-ascii?Q?u3s3Nlg2BrlSxxHk03HrEnES39n9aNa+w2M+0P5e84zqTmOVrmOUpfuConwu?=
 =?us-ascii?Q?xtJmytFu8cFYVT6ypaaJYg2wWe8TVNDIYeJ9+PTvUzSGSSrEoVYZChhffkZ+?=
 =?us-ascii?Q?8r/QAD5gc1h+2d8Y/yZSqbhePMs5mn1am7zinrPkW6PeBsnjLpsIyt5g3H+l?=
 =?us-ascii?Q?UKXUkvmNChclJqAuB7FLAQnAxQb7d8QR9GPDveMmc3U+88U4T/cOZ6iPZpKj?=
 =?us-ascii?Q?Vb7PNfsV1S8lF8vl+1mJ+d816FkXzEoaGReMQW8U7kfwhLCDN9MaPfT+KFL3?=
 =?us-ascii?Q?utLqrW8HJ8IgHJTLg00x+0gdkeamP51/nHS0OviAJczMI7qhwqc21UpecZbP?=
 =?us-ascii?Q?yEAyaVb466f4vBsYXvuIoYghcMJwHsNq3ONLFfB1s4hVtP5virU7uKo1a2gk?=
 =?us-ascii?Q?c+wySa8dWxayxlHdkL45UocvLtXULvxlz1FgGYM8yJBZll8l5BXQ7T/tgIzK?=
 =?us-ascii?Q?emGGkVGN78NCOs35O/MX4hG7Yx33FYlYll5tyvHppeNjTTs3oQTqsALBIeOq?=
 =?us-ascii?Q?vNLh7KiU8zsGffxy8gBx2hl4CQwytk7FOTwQ/ClH6GZzLDNu7Y29TK9+8/Fg?=
 =?us-ascii?Q?EW2j6Xy8drUbuyHFrzzpPP4xNpWR0+2jruM1U18G38lOiXz1ip5OU8YtCtxK?=
 =?us-ascii?Q?NQ2+dcGV2bAD6ukOKn3hbMNFnZyTj3qh/jxI07YpwyQIxzjI14ubUYiVwi9b?=
 =?us-ascii?Q?4lS9DuHG7erGz5kTV5pyYZiCP6SVChx3aweZ790evuo40Lr75J/065lz1aV0?=
 =?us-ascii?Q?lCr8b4Vpt3PPxGyG+skILE2ru0nbBPX7rP8YS8/eN3rI4t9gPOeiSwFW4B1G?=
 =?us-ascii?Q?bPR88LU9WtL2JNQ6eWWler7MPeY+MMlj9lpF/7orLnBPqCqkjTePjKfeBO3Z?=
 =?us-ascii?Q?NzVUfz7VlTqtCX1K9JE/cmY9EVCrS402aiF/NH2oXcUEKj5iz94bNYAXq765?=
 =?us-ascii?Q?8J8K3OG1bI6yntwGm2vOLa2A0KCptusKyHZOd6C0ryonM6LWzA0q2jzJNJiC?=
 =?us-ascii?Q?ev7sJLrZZeVguAcR6iGBJBPZ13QkhxOkrWGLzN+7eJh1CM3LRiPexwhR99Si?=
 =?us-ascii?Q?7UGivGHklFZhTyxbnDEiluzg6IF6KEsTgODJzJ/xQnPW65ExYuHynP43LbP3?=
 =?us-ascii?Q?zuK8QY2KyA5DLAWcG7NTNKAywJ4rRZ7DFI02zjmpgx1qd0oXAisFVar/pynD?=
 =?us-ascii?Q?ASBJ1ulfOJ63ALrQEPEEjYAPG2hYhqtnqulF4/tQ9OIsYBubTOHvfNQ9mpSN?=
 =?us-ascii?Q?AG4fEIFzCXVHh1Ek+pe+qj+R+/Cy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwHt0MPFqILcaOSBbAxjXkqGNZ13zUpU+fAQb/l4VzF6psKcGiD6NkmvgM/R?=
 =?us-ascii?Q?lMAnnmepc2ww4BEemXX63dsQGcs/vL5hIWXCmiaJNemfikStFPY6O4I5umDs?=
 =?us-ascii?Q?GH43QPSOOrWTDQnX9GyETwD8pBdCLRUB2lyC18L9+I7Kr++LWYStzNVW848S?=
 =?us-ascii?Q?ZRFcPp/beh9KYZIck/LUlbCvCBgTCBXSpnOxi5ilHM/PMrV5NfDNrH5F4ngJ?=
 =?us-ascii?Q?qgRIyLywvnhAyEz6dgOnkg112fd1A+kAXNEG0a7nAYdO79g6wGMiUPh87vRL?=
 =?us-ascii?Q?4Uq6rH0PwMVZVJBrzQlTO4Ylxk8Jb3SM3ZFcTIGlQxkCebpl4SRFF509Pg2z?=
 =?us-ascii?Q?pvkmYNcBEcuxRksQWe3k/PADbACCXe2brvGxl1pI3N+ICeKTHTU1k6PR2U0o?=
 =?us-ascii?Q?Fz/snBy5OcplVRgC35XPLj0ph4w9nYCvvuButlg3s3ZXczYTGSSVRAMXId7z?=
 =?us-ascii?Q?DmUSVDsxIVjhXtLsc6cptFm9t5kR7Hp4uaQeeWPmq5g4JSt79mSnpcagZyD0?=
 =?us-ascii?Q?liG6zQKnm1QRIQbAE/zsNqLHCb2iW/7JNhNfls6TWTlZfOheqhJd/cxeS4Fm?=
 =?us-ascii?Q?ZgGFj23Pl2TLFuK+EESL5BlnwzTsOOEDPZgteC166Mez68zzoz7AD/QNZyEG?=
 =?us-ascii?Q?cOLAy+KdycVG01iabpHTTQi1BajyfA+muXEaaCy2NB1p6y0CaSMz03iD8gdL?=
 =?us-ascii?Q?eGEZk7qWWgfIbNNduNFoWyQJI28nufMZZ88F7fwMjqkL3ErQpWJLX+GRDYdi?=
 =?us-ascii?Q?FtTqj9AW3PAsQEAuVzKVHSLlH3cHN+23GwKAm0HPIec0HeCqMGcFvQ/DtN70?=
 =?us-ascii?Q?4rNqKIH5vZkX/VXDt6nMRQnNkLNr0/7biSJXMytWLsEj/4lKBWj+NI7GdNPz?=
 =?us-ascii?Q?GMISQI7t8VewWtWjSVz8hvQSkCNGyTuSeoelv/06buT5h850dd8WYSHQlmBB?=
 =?us-ascii?Q?Bb10Ak4FfZIVdWw867Voq3lsznKicdVFspnLK2EPqO2wfviU1Jlgd24PyGM3?=
 =?us-ascii?Q?/19UuusxlYxLvEYICxuDXI1mFxY6n+Tsbz8zHID0acTKzM7bC7cPH5IFaOFd?=
 =?us-ascii?Q?5uTzJXsVsEzf8oyM4wbYe46KXGdfJQXeP/jOmupAaa0DCMNMHgLozC/XeUmC?=
 =?us-ascii?Q?O2vdE9g6C+kdHSQlpu6TDS/u06MmTSjOApygP6DrcrthHHD08a13ryaPhe84?=
 =?us-ascii?Q?envGHKb6Y/9xcoHxxGKFBj3jiQHiXA9bHyU+LTvZeFy8aWThbe8LRR+oQhxW?=
 =?us-ascii?Q?tNm6XzeF3C4ogRENctymsraIv+udSnw3bACf/jvBJN4Jdg/E2nQ00yj6548k?=
 =?us-ascii?Q?THCTR9FmboKHQc4qTgn11bdbhs2MYw3A0r3iex7CExRJuWbeP1VslHap6LK/?=
 =?us-ascii?Q?CAIlaRmVTEym0G6ord0y8ocACTR4QuiNwUHPPCLKasD9jSPiNwG4eLyYvxI1?=
 =?us-ascii?Q?qjyB2c0V3CQ2aO+NMpy56cPCZxe5TfUdX4So9ZgOhfRY0fliTs+3Aztb5utG?=
 =?us-ascii?Q?jePY/RYv3uYwxpFbjFs+Q6FtxapXaEkyYjNfYkdHTmd3LlE8XmttABrbtNFL?=
 =?us-ascii?Q?GeTMJGnQSrjat+vBskuHkidW+9D9rQ77tOStG8bBeS6bGC4vxLQjB0NAPot2?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RsQHmXE89H4Wv3le56L5zaBQZFxUJSAc3pHEuPT+ELA4qP5GIV3mmTSX6Ujb+xcm1Nx9+YC/jQZFUrATbA8YAx2hRP40pdGkKKUXNmpn3MgKays33qtogIe8pR0s7kM9/jMydfhu2oJjAitBAMqvZI1ViuXHivXNFDzfWBr4+cM8ajnAFL7ZNSylX44pyY3uQ2EGeqdkim8eC/5kMVnlBUAeUG9ZP9Vet/V8qwyWn37fRCMcBGFC7Y14MRMMO2jR2hgpu9plOfEwruelOpEAC480YlPwS874cob4MBBHlFNDcsEmz+JdSKz/xd2st/qVNuppOu0x/+xcDTjtWkgXGMeoAG/4yv9ciH42a0sXWU2aNDC6Ib2C3kWvUgO/j2lNK5JNBCSpEVAhq/mJR3+JItWSrmL2ISHbic84nnE0wM5qnZtENMdsi8SrrkFiCUBOHq96B4el3w5+Le8iZ/DCtivuExQiA+dtmihPQ20c7UG9fYf3vzsQUQKwDpgTA2+fX6xCSPc34zx2JrZrhRllJ/xbBGbAY4zCMaWYzUFta/JHUi205cDNDlcBGONjk/9DYp9naFbRSPMPLm9y9uxo0NTFn9+ESK9cYmpnDttxaoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b47989-0e22-47b4-efac-08ddc055597f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:31:36.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc3me++ku6viZfBWGvXqhx/ZS9e6gvUG/Hd1KjSrkh/CnN9/Y0UvTKYg5phTdDYoBUrCbDuE+jAX6fZcUTTPcnezlMSsPa96SDxDfw9gOXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110059
X-Proofpoint-ORIG-GUID: q8eATqHcvNQsUEwxofNh9suoryC0AOos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA1OSBTYWx0ZWRfX0zvjXVR/ZItP jKmd3lkJqWbLiKgH8QHgmrs8SZy2tkifD+UMjcn97qNETAqHqswLlehvHHoWw1fnD3zLGCBNNld 8mTR7P6Ps9T2DvAYVmswAbNh9cFQBV14E1B/1t3yarJ2CrD5zw6NCXzhmn7r3FsyhH4XsFZZLrm
 KCCARB3ruvUVExYKb2lmrNiBOqn8l6dHLKZnbhwot+0mrMvI4RJ1xuhAyYls5UiOVcrQLJSoH48 4Tw6byuEghZCYTm3LIEeiR9hhD9+hD81BusXbfqv/ofhExodkvHCNo+F5maoqS1nV06bMRCO/JX Ar++7yo5T2Tq8I7aVLvkk7BuI2sV4yNvV8A8nLmbljEZ6NdGtwEycDzM1f60btQBPFprjXf9EIS
 3Tb/Mjf2cX4sPw9P8G8pfZ+RQtW8WwqtvsBflLvoyxdNDgvWUp81F92n95bs8GISSJBsQ9xD
X-Proofpoint-GUID: q8eATqHcvNQsUEwxofNh9suoryC0AOos
X-Authority-Analysis: v=2.4 cv=ENYG00ZC c=1 sm=1 tr=0 ts=6870cbee cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=qNABUOcEAAAA:8 a=ry_KaldK0bVjcsLKkh8A:9 a=CjuIK1q_8ugA:10 a=Ytm653ucTKQjCvbzLygB:22

Thanks, yeah, I'm going to send a respin today. I accidentally enabled for the
MREMAP_DONTUNMAP case, so this should resolve it among other things.

Note there's a v2 at
https://lore.kernel.org/linux-mm/cover.1752162066.git.lorenzo.stoakes@oracle.com/

On Fri, Jul 11, 2025 at 09:22:13AM +0100, Mark Brown wrote:
> On Fri, Jul 11, 2025 at 09:17:27AM +0100, Mark Brown wrote:
> > On Mon, Jul 07, 2025 at 06:27:52AM +0100, Lorenzo Stoakes wrote:
> > > Historically we've made it a uAPI requirement that mremap() may only
> > > operate on a single VMA at a time.
> > >
> > > For instances where VMAs need to be resized, this makes sense, as it
> > > becomes very difficult to determine what a user actually wants should they
> > > indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> > > Adjust sizes individually? Some other strategy?).
> >
> > I'm seeing failures in the mremap_dontunmap test in -next on Rasperry Pi
> > 4 which bisect down to this patch.  The test logging isn't super helpful
> > here sadly:
>
> Same thing on Orion O6 (a more modern ARM v9 system with more RAM than
> my Pi):
>
>     https://lava.sirena.org.uk/scheduler/job/1556807
>
> and Avenger 96 (which is 32 bit arm):
>
>     https://lava.sirena.org.uk/scheduler/job/1556479

