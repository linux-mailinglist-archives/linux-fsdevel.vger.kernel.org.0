Return-Path: <linux-fsdevel+bounces-14572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3647587DE0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BCB1C20FEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11C1CAA8;
	Sun, 17 Mar 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C4eLx+UP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WIhFoXsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35701C695;
	Sun, 17 Mar 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690197; cv=fail; b=rw69YlkIB9qAGxhETcPujvzu5HVCxYh0vEMRzs+sltGk5wM6n74CNqM2Mc2hrqWRIx8PneO0tyocI1fhoMyTRspH8JDCuWy4fL93A0jdtGYik7V65gubX5OSd/t5OuE9ySJPYTePSAJ9zVBMhLXP3Dpn4A4Zj0P1sPb+dnX/zoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690197; c=relaxed/simple;
	bh=33kF0P3B1w1K2ur/u8Ro+RhgPr59KPSIiBNlbHs9H+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AIon1umP8+zSFQn0onR+YWgI/zkCmtpVRm7vhKvbvLij7IKzLi9gTJxpHsZ4YVvHn/ATUBPCvxKIl6bElq8Mxt5dBBAr6/1etvGOMmUN+ZGTXWsngz8ON0wneXIj+RXwkxKThLkG8tnpsxkmBtFgEIJKh/8KTUZUiI8JIy/OSuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C4eLx+UP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WIhFoXsg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42H1xpNZ032118;
	Sun, 17 Mar 2024 15:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=3uR9BYV88heLcP1u9ehp9MzJDphVQgme7kQkUW07KwI=;
 b=C4eLx+UPpkUFjt+2sCfNA47O5AkKDm8QBtzJNf9x8RneHzMET3BLcOL78I/fMxZPBooX
 oBisTdEmm5zjcsyqPpbg6vf9Syk6Ea+KycAA0G1Ob4k1UCdN9k4isIpKwm23ZhLXTJat
 DyAdFIqrD+eTs6CJNgyzrkZQ3Z6sI5wWt2O55Ca650IReJnecgvAXaoKF8Ugf78HMziP
 ncBmCe42oJo6Bi41MgNPenHUl2n1G8YVkik1BXhJiRR4yCcuT8yNxK2SJidtFEG6Rnmn
 ZJSgMRdi2hJceGQF4dLKSO3uzmh0p05czOPqJp+ju31pl5rPH7HlFIz+gwsCR207Im9d /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu1ewv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:42:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42HCAjqr024261;
	Sun, 17 Mar 2024 15:42:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v481p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7cYFxyQjHWpJYovRJvjA43RlMB+z9x+uvqSflFm6q4AWQDJTZlOYD19SMNJ9jYjcfj7WNve3JBwLmhCgN6Y+oPKqSyJ+W3fHKfSkTm4xDQVcYYVuocKb+C8C+hXnL+DXGjHp3nDeSmrvPud8sl7Nz0TNP7/FQ9DJmO5if/uVf2DHXPqlv1Lx6Orqr8+4Z/Bu2kkzzi2pfwVysJLFKiA/29TXR1fR/5/Fwr20BWmqH2FjiMLNxCOzIvD+alGpuCp6oYoEJLqlnRgL3054Z6nbPjz1mHyEQyVJPYwgns6kktYg61PG1guyGa5pO70uK4A4Jg2JBHOMwWVhT2T5CyNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uR9BYV88heLcP1u9ehp9MzJDphVQgme7kQkUW07KwI=;
 b=RKuPJK4DHOPsPsKZtCe+aK8mboWbXn63g9Nxs5ekWoUi1TsQ3ZiJzq81y25BdWI38nry9ko+No+QyEAnaV23ZExvHIF5QRf20Y086lLWV2eZrVZtRYF/e0HDTQ0hnHQ6XOmeLjray+Ag+VXEupZTzq3OL6iIj0F2sMvfYVxAjKebIPwtIwRccPRAEl67a/gb4vVnB3NDR5Jl3UbeSR0RHAavejtMlDhbXtgZHXGD3v3XsWFYpWbkqazIPgswiffQxtjc8yJuIHSPVna9b6UptBh1LYUon9oLbGL7njDzb+9w3Vs8518LqG5uo7PVFws0PfaKUXXnA7bdeS6xg1FMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uR9BYV88heLcP1u9ehp9MzJDphVQgme7kQkUW07KwI=;
 b=WIhFoXsg0tFLjKoURCIV0LCN2ViLMOyOrArz2iO2b5TJNgRlXM0plVj7HHJUaChj+3Oe4m8QaJ+/ocTxYK/H2cSk7l42RkhTic81vnfQjDPPxVxlyGfa5xC98UcCItGre/09KWP2XDhSVu4C2B3yTvrzee/EeFtZ121lJxTs8L4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7146.namprd10.prod.outlook.com (2603:10b6:930:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Sun, 17 Mar
 2024 15:42:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Sun, 17 Mar 2024
 15:42:29 +0000
Date: Sun, 17 Mar 2024 11:42:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 14/24] nfsd: wire up GET_DIR_DELEGATION handling
Message-ID: <ZfcPYJxOaS5U7qh-@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-14-a1d6209a3654@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-14-a1d6209a3654@kernel.org>
X-ClientProxiedBy: CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bc874b-2747-4ae0-98f9-08dc4698da2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wgryAOxC+sUYelt9FT+sih1sV7iTwoTTPka494QP9ZWHzwoaImg9+NlWqU/6gT9J3+GSSFEoZzBo6VkjpZnDGF7SWq48MsSp3LfT0BUWpWjdwH7NXitYQ81LNFAS0p+ht78mdmYuR5Uv8YMoinNwmJ1+wFYSxbKooCN/bJgHsEb4yU+uIJ6ksPQ++zHoHR0x1BiA25L+uzwVWsTFII8gN8h6KvXQrmpl+x69Oki8bDCi3+jNJZNnt59tUCCTMKjEN7y36M4E+dQ1kQ9RYhReTlPtQwIsJzRHeBYw+5SVTf3BhEcD6CXVl+ca9mW18mLCchcwbudqHTuc93cVYk+FHNZGMVl06ZMRdAoAzyRD2CF1ORn8SPRBji44SEjoRMBaV1chJRpO/PV1Itl5EPriY4TRQIhw5f0popnMVONQcBZreOcEKgHagkwXIU6/N7n2NlYag0obN/lnxulOh4pw2gPe184C7lA/Bn5rxGpBoAZHb60r2vMXmOiJVdg/l6mS4Nb4aH6cs+nf7C9BFxULweq693zpg5LRxGlarAc9C9wMkgBpJmJCpfm43sCU1JoPtxxg5euvUxzhSOiFk5rvu3fzyPRfPk9XAWWday3PgdGQN+UQHMmT6PtEWt7H9gla/03cDn4PmvtS5wp8WyEGFJJAJ8I5JvZoXmlQvbqsc0o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NQcDbrk6hbEqFWTwstn8JsseeWXpME/iOUbrDJPjHTDqHKYTw/5WmnJhNkI+?=
 =?us-ascii?Q?enJjDrx9nzAqZ9AsvOHJbRIV6+1IEguyrqT62Ki1tWxTqu4dEdJlvZydSO60?=
 =?us-ascii?Q?SWvKXOGTteirr7iCyCilf93GB/7Nm/a3oVWZ5t6A/FPfAl5q/apeO54KtWih?=
 =?us-ascii?Q?WjBs1zL3y8UiWm+EzaiiWnURvYm5AbNznDQro0NT5yMuQ7spxE2s3a/7yRaw?=
 =?us-ascii?Q?eTtmDHXW405pmWGVupYXz69ppIhYINXQMmBRQ35A9KquuD9CD7NxOX/CiueL?=
 =?us-ascii?Q?yJYYrbwzNuiABAeP5YTAMRNMC2uxAsnM0Q9BEE+csqQyrPEWlo2Jcan8f5K2?=
 =?us-ascii?Q?PCzyv4n/NUsppqTGSj7CV6Cb3UFRtQ5Vr1Xx6zphGMKHqGte9+c7nE7/hJy1?=
 =?us-ascii?Q?t6B1o43ZlFC9dcEQn7wM5sgq7H/p3SHaVk1rtDf9owU9aG6U44tK9AGuftXG?=
 =?us-ascii?Q?+YL4hxldUtY0XnGCP/W9ThbVWWjBZOWewI3GBc4rfnwgZhd95EU7hKN8KAwE?=
 =?us-ascii?Q?/WFfCUW50pS5BNBIYCMfvpe4OIwdvPNl4nFRvi/OUcpKvoNqcKmurFPuFaB2?=
 =?us-ascii?Q?cfbnjNY3rO2cr4DDRMcIuh/sxKyguwlzGRGB1+NTZKr/sdDUNxlypx1QBarS?=
 =?us-ascii?Q?M5gfWrs4KG4u0Wd0z4xsMgykE/CxiUJR1UBHzq7XBhj9kIoGn+mUpG0qGgkR?=
 =?us-ascii?Q?gjN+YevxZBObrwq66HX/eyWBqKIkWkBNcskiWyw3iB6cxRotADVS7Tq+n2F2?=
 =?us-ascii?Q?unV8G77mxW5EI2K7M29jNTbPpqXLV8H87me1awoTD9it1SdyoXGu+K43ymK1?=
 =?us-ascii?Q?S8rrkm6NS/9xs0LynYUrtAWVEudg2eQGoax1y8YCfb0pMCekv3tin8ys8xQP?=
 =?us-ascii?Q?55wLiXus83AMm8D6O/OUK5blHbehJkKkO0Itwkl865b2jkrKoSTCwZVdf91s?=
 =?us-ascii?Q?6ssYwwcE4hQsgMK9o4d7AJ/w7TkDwKlwhJQygy9a6uyJTGAQJKt22AssOV5b?=
 =?us-ascii?Q?ZThZiSkYOYw4p5NxWtZyvJTqVcpVRAC2yD1Tseyp4wgmCF/rYic6KYlbkQCn?=
 =?us-ascii?Q?pFJZ3QidgflRcL0hbkxnduBWw6vi4EVQl1Xf+v1jcAhYrFJWSpvZI+pklP2i?=
 =?us-ascii?Q?Pgw5SPF9enQja+7SDDx/97UAgsdcyEoZM1mJX7iHI9mw/ALZKFBF16futuNE?=
 =?us-ascii?Q?FA9H3DDbupeZp5ToeQvzG8jn7KoznviMaXHXXsSzOpKty3yz//lvB/sidTP5?=
 =?us-ascii?Q?9rF8QeFRtgROIb12k0e71qKyFI/KXW8SFVHzqXUDxSqmwhQdBUUcCtaz092T?=
 =?us-ascii?Q?5kJd3IRpR+ZqHPuoe3XonL52fIYwKE3EM+2V2Ij9hyq8cSiRwZXTPtN3fIus?=
 =?us-ascii?Q?ADW1+htRalY4z+5KrCqNvGNWThY8wqzVgxzztnIC1EIf3P4gQi67rsEK0k2e?=
 =?us-ascii?Q?vBzqaza/wzYNgE+K1Ghdls0S5bsx1DcXJ/S+em1/LeuKTuhAarLqp04VtSqA?=
 =?us-ascii?Q?LVpJBV/sEi7sxNA7F8AOwoWdoZV2y/SCvq2DHzSOvvG+fqz8wfMe8HCJG8LC?=
 =?us-ascii?Q?2+LR29GlEU927bNgj5bBdyFoRwAweDiOkdaSfy9BW41o+1RohCjZQH0aJCpm?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4kKSp+PAe72I2J/qppeqJROQCYOKz58e02v94qakxXEVwxNBAmduhxN/s/Rtbj23i4sr2ifIV3suwQJ9DENemoD0hjvh9S7H0xKKoEna3Hs+iqopVLYaSOjpG2e9r0Ench3BxWRBaGaAU/ygPK08YECjNJWrtU0YOU8C2eZIjkTMGLvBTS+y1C6lS7zoaQPkB9fbNr5Pmj490eNw53VD+zG2Z1vXKRBuT7UorqZVaHbKMsB6PMIHDTsvB5h89fVDyI33b1h00Co4laU850tZkpSHYuouhLn2LhnYQopG717KVGi3/BBSSK8/E4eFgHsDs3nAVvDheMh0NbhGmIFL+RdrZeMAzy3AI6hbzRdfd701QTI8Sx50sK+Lt5nBL/BsRjSD/PJobhEEbuxWwmWXo9AuQ/o/9GpDHTPeyoCS5rZS7f42yv1sFoiNVoUAdugVb0QafgucXbACuKtbcYKBRBY2SB7SfotBggBBR6sZmPU5yxMChm1bgvHb3GHUpCFlG2JAFXi8G/VjBjwGBsneRzlEkEPtrNZspafopC1bWkdq/BSY/56nN1SerEkw+jtBWSTMWaUdJYLheOjusINGFloauR//nemR2LCJinXvYBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bc874b-2747-4ae0-98f9-08dc4698da2f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 15:42:29.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11FHYjHnzKNCHYib9YrXKMM+a6pBS1A7hzwpMIP7BzaU85yYUu766Se3+um7wk9yRSfNUxEUyRzwet9kzXuLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_11,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403170123
X-Proofpoint-GUID: tKQiL6xGR9liVdxUpVwydM-Zx-0r3772
X-Proofpoint-ORIG-GUID: tKQiL6xGR9liVdxUpVwydM-Zx-0r3772

On Fri, Mar 15, 2024 at 12:53:05PM -0400, Jeff Layton wrote:
> Add a new routine for acquiring a read delegation on a directory. Since
> the same CB_RECALL/DELEGRETURN infrastrure is used for regular and
> directory delegations, we can just use a normal nfs4_delegation to
> represent it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  | 23 ++++++++++++++++--
>  fs/nfsd/nfs4state.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/state.h     |  5 ++++
>  3 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7973fe17bf3c..1a2c90f4ea53 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2179,9 +2179,28 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  			 union nfsd4_op_u *u)
>  {
>  	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	struct nfs4_delegation *dd;
> +	struct nfsd_file *nf;
> +	__be32 status;
> +
> +	status = nfsd_file_acquire_dir(rqstp, &cstate->current_fh, &nf);
> +	if (status != nfs_ok)
> +		return status;
> +
> +	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
> +	if (IS_ERR(dd)) {
> +		int err = PTR_ERR(dd);
> +
> +		if (err != -EAGAIN)
> +			return nfserrno(err);
> +		gdd->nf_status = GDD4_UNAVAIL;
> +		return nfs_ok;
> +	}
>  
> -	/* FIXME: actually return a delegation */
> -	gdd->nf_status = GDD4_UNAVAIL;
> +	gdd->nf_status = GDD4_OK;
> +	memcpy(&gdd->stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->stateid));
> +	memset(&gdd->cookieverf, '\0', sizeof(gdd->cookieverf));
> +	nfs4_put_stid(&dd->dl_stid);
>  	return nfs_ok;
>  }
>  
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 778c1c6e3b54..36574aedc211 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8874,7 +8874,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  			}
>  break_lease:
>  			nfsd_stats_wdeleg_getattr_inc(nn);
> -			dp = fl->fl_owner;
> +			dp = fl->c.flc_owner;
>  			ncf = &dp->dl_cb_fattr;
>  			nfs4_cb_getattr(&dp->dl_cb_fattr);
>  			spin_unlock(&ctx->flc_lock);
> @@ -8912,3 +8912,70 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>  	spin_unlock(&ctx->flc_lock);
>  	return 0;
>  }
> +

I'll admit to not having examined the below function closely, but
since it is not a static function, can you add a kdoc comment and
a few salient points like, if there is something NFSD doesn't
implement (yet), or short cuts that would be good for readers to
know about?


> +struct nfs4_delegation *
> +nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +		   struct nfsd4_get_dir_delegation *gdd,
> +		   struct nfsd_file *nf)
> +{
> +	struct nfs4_client *clp = cstate->clp;
> +	struct nfs4_delegation *dp;
> +	struct file_lease *fl;
> +	struct nfs4_file *fp;
> +	int status = 0;
> +
> +	fp = nfsd4_alloc_file();
> +	if (!fp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nfsd4_file_init(&cstate->current_fh, fp);
> +	fp->fi_deleg_file = nf;
> +	fp->fi_delegees = 1;
> +
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	if (nfs4_delegation_exists(clp, fp))
> +		status = -EAGAIN;
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (status)
> +		goto out_delegees;
> +
> +	status = -ENOMEM;
> +	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
> +	if (!dp)
> +		goto out_delegees;
> +
> +	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> +	if (!fl)
> +		goto out_put_stid;
> +
> +	status = kernel_setlease(nf->nf_file,
> +				 fl->c.flc_type, &fl, NULL);
> +	if (fl)
> +		locks_free_lease(fl);
> +	if (status)
> +		goto out_put_stid;
> +
> +	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
> +	spin_lock(&fp->fi_lock);
> +	status = hash_delegation_locked(dp, fp);
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (status)
> +		goto out_unlock;
> +
> +	return dp;
> +out_unlock:
> +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
> +out_put_stid:
> +	nfs4_put_stid(&dp->dl_stid);
> +out_delegees:
> +	put_deleg_file(fp);
> +	return ERR_PTR(status);
> +}
> +
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 01c6f3445646..20551483cc7b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -782,4 +782,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>  		struct inode *inode, bool *file_modified, u64 *size);
> +
> +struct nfsd4_get_dir_delegation;
> +struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +						struct nfsd4_get_dir_delegation *gdd,
> +						struct nfsd_file *nf);
>  #endif   /* NFSD4_STATE_H */
> 
> -- 
> 2.44.0
> 

-- 
Chuck Lever

