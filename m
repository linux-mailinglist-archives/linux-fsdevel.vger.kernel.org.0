Return-Path: <linux-fsdevel+bounces-14571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BA87DDFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F521C20DA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31481CA9E;
	Sun, 17 Mar 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AG7VOz5W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0ImFA35N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C91C68F;
	Sun, 17 Mar 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689736; cv=fail; b=VzFZfri7a6OGIo0BCmcGnjXyvelpKkxywIIE+5nIQDMsJBsVFbrG/Cx7F96Zba7IlMvCy9e3CzqKXn6tSyQDZ6ta0VbW4OIYWcf9HAof8m45+5hDHucY7f86ZgkTgD/wsZDxm0gXzY7cD5gfLqzkAez3BdVeyxrQ/IO3UglscZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689736; c=relaxed/simple;
	bh=xsngyQSmEQGn4eL2a6QDxobkSYlI15dZTyqwQg3q1rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jj4bnT3WYteSbQZua1l1znGCZFlb08Ccj3egO4eX1TE7824SFfn7CrrCpscFcoYV8hSm57pd+O5CCu90QmTJuC4LGsDts0WnDbMshswBru/hyj1a4vsPhXS3VviC6098QLgzjFNe7up7kdqQWurR2B4mhXP80qtJp3m7Dkl8VWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AG7VOz5W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0ImFA35N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42HDTqUg013915;
	Sun, 17 Mar 2024 15:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=WB2cJnMui0UaDLQXUb/fZ5DApCwehC9II8JAPe3b6C0=;
 b=AG7VOz5WDGkTrtChYn1aYgW9HNWRzZIGtwu4xAsSCHYU9ybeULyr6y3R8DhSgZPRofgC
 EK1nLbEf2x8+0vCTSB1bEaQYKO5cJqkCHax1KEx2WDRTXsjh4P91Dq6CYsvfWzqPFXg1
 Rs57y4zJCUV8QFCF9IshU0xw4VbXDWT4B7XyDCeJiQxDpo0KVBDlS/+FF3svt6QkBex+
 XV+27lYujvT0ZfquRG5Yaw/jHPNr4ZNipWj9WXnTa4h02gpRKOf/7XXvP3Vp3SrW8Ifz
 uqkanngC/0/S4Qav3fztFuHOmWYh2eWdvVmTuBb0O3TH0hBXcdNrxB+cIsm7D5qZKDsk 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu1ets-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:34:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42HCAFpj015761;
	Sun, 17 Mar 2024 15:34:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v4aar7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwwOfFZRuCc2+Q3yR16SUsyJJs8G6VOrNi4USQvBmQKair3t3qK3/SVgZZf2CO9xaGMmG6rgPEQJV4BTcao/w86iALzSj75wDmE4i53WVE13pNKBSblPSqi9hrmsHSpFmf6Ynnt9TXE7LoDcnMkFBTkdFkVS65p2ZGnAmba3VJ9XgE5Ft1bDjKEQSjBf0UziO5QihZv7ilGrJQVDSgABhoOr2wrACUmbiSr3gaTeYbTEX5sTUPECgNhJxg99I1J//z7CzcIStE3w3J/LQHebJ3/gDklAJCjS2WG1F5FNgsyJA/6I+salFaFZF2BWd2u5//eJekKToLlbKh7GJDgnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB2cJnMui0UaDLQXUb/fZ5DApCwehC9II8JAPe3b6C0=;
 b=LXGUrV5ZMrzeVVWTY4PUB1LtHj4Ln9088D/d/SNIJ/X228GI4any5KhktSfDKicby2nYl33EzNrPMmD/62d/ttOFXIBbaK23afQfmyrc92PLbMcrblzyS6UWE/gjv/X2YrSSBq9k6gtRym3KyZUXBgD0/GYpA2FVVqWtPHQix1xt0Jazy0WXwmAmolbap/yUjK4i0Nl2laUT9WEFqmd3AmN1XGw4w9VmKCBZD991x1/FGS7LK1mDp2Z2Ykdk40Igv2GNo6WLrjpvMj15FHfABJxp1A4yt/lRdGwUhNGcXjc94UHH9YAKWFAkPYF1zlur/yNPJuble1bfTFgRwKWqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB2cJnMui0UaDLQXUb/fZ5DApCwehC9II8JAPe3b6C0=;
 b=0ImFA35Nz6lYJwR+snb+S+dGmSpkWfyDYxHXprmE12kWCWsRl4lBaBbdK1uZBLXtWgmBLogoyO/SmEDLRosxK9NK9e+jg3rJCgrmRReN8Q8shuBqWdsVA1znmZM3l7i82U4TNiwr4lgA3WKqFRbzUmbo7mmdDlI0+5dov7SIXbA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 15:34:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Sun, 17 Mar 2024
 15:34:41 +0000
Date: Sun, 17 Mar 2024 11:34:31 -0400
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
Subject: Re: [PATCH RFC 12/24] nfsd: encoders and decoders for
 GET_DIR_DELEGATION
Message-ID: <ZfcNh4O3i19P25h1@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-12-a1d6209a3654@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-12-a1d6209a3654@kernel.org>
X-ClientProxiedBy: CH0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:610:b1::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4847dd3a-4170-46f1-7a91-08dc4697c3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JZHHZCIRJTI2k7CEklO143ngTHdBDbyBkF9+i2x6Zviet5AVw9QrNncD2VrlnAFP6AW/5fjxGINPVy99PgMg5f2qlB2Ev4qdiU8uspvyu114kprWdKmzE2Yj05MV5t+lo3V8Uf9QfMQUGXE8xR08iX+ZfncAejU4Cnbf+fP6JGM8c9LkLPPOJ9gtDqjL+d3rNdxqs1TnXpSBoov79MzBeKH8y2p0zO4bIRk7PWqM2OymCBDeohSZFUGlqpnGkIAgDgE/vh1BtOYaNUQTMVOWWJYaeSbgFwQqsUDShvCF3RjzqPBntIlHamj99iGEF34ulgXJPeonXoJvOe3a291a8w6xb1xzURBghQxs6iJhY1p0LEuh+QXQeUq32z4tOHOLAw10F9upNp0WgkKwdikemzpvfXpDZDCAhQ6EI/wTSMohycTJdAiCik6ag4pzf44BVytRxW4svuHLLkZ15o/sfG/WdV0967hcZIzPBMxnr1fYFC+ltPbJ0MMFW/iel5ptTVFL/XPb+4tvmfcbThifVdrcCXXi8I8hYKUN66MkRr3BrOaAh7kxaz7MLKZm71RXmqI08KWjN1/Hif/0xUS9hYpugtWFn/bZgnu0qYZWqP0aCDAFcjcHaEC2grEyKNtXvzfa/5h15JWiUWQzja/uxYNRfOwk7xcg81hp6KOmHd0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p5Yha6DDVl6ds3xNwhtoO+04Ia+YDeQeOnY4tF0Rrnl0DNXd8oJFDl3ryZJ0?=
 =?us-ascii?Q?UaTLHoRqup1aWzVkf37BSQbD17aY2ifkSU1NZlkqJ8BeNuxyAfcKuFdmOA7E?=
 =?us-ascii?Q?E+4LH2QpHRiiqsjE//Q1/SGbyLsAlUxPEn2VjMIsCloBmm9sZJNyZbDve97Y?=
 =?us-ascii?Q?X3OC7P7YyKOYci46DuR0RvgsIOqP/tRmc4i3T7oHKTLmAvuguZBxzTiJNHMy?=
 =?us-ascii?Q?wXLOR1VN3wTY2Z0Kv1eczoej1m/82yVQBJPJg/k7eyaer3j/njW3qgXuRdS6?=
 =?us-ascii?Q?buFeseVtFFSfUqHMsQQyzeSK+tSvSvrx7pqJsL53tuEoZbTpPq0oG0wGpOiz?=
 =?us-ascii?Q?gziyDanlosOot3hVFR2Q3EHKm74Ic0eOieSM29Xw1a85weDEscN4y/UtVE11?=
 =?us-ascii?Q?B1rF77N3c8wDyzR67Y/xgIIXLDlivNy9DWL1P3jJouvEICqjtAFSg/xfI2/Z?=
 =?us-ascii?Q?dPzaULO2qGVxRrTjvXXdN42rGe8ai+rK3EiCzf0JQTiIY+Amzgw0Bx9W00R3?=
 =?us-ascii?Q?k5/4wvKeR7fPXGf+pEFM7qyKD/gk6vTPkLYcKYpM5cvui5b7FssecyZATgcj?=
 =?us-ascii?Q?w99lknwwONF7fCSlWV4+WnndKoOrqt+E4v9Y6KrrI1nZpQmZSD/baPiB1YKP?=
 =?us-ascii?Q?gUHUDd/YSXqG3U2e/H6IkzPK5eHtJ3AaocotRv6mSuKngSBhE45y2sLama7m?=
 =?us-ascii?Q?hyZANZb0SkW+pR6qE8fgG6hlm1Uj15Lfz+3MxpQ69c3xSG5WLxkni/IV8ZR9?=
 =?us-ascii?Q?tvdrEanHWgVuFfj6jfIxMhqPCtYZV/J+awavNbhHbUuMrr/xFzARPd9Hh7u+?=
 =?us-ascii?Q?G6WsfUqiZOcNLOA4mgZMaeR46H1Q3TXXKHxgRvfXCsT5qwpyQZts/p/RIkcV?=
 =?us-ascii?Q?a1+xurwfE7Q3Wj3mgyw4JVyD62asoqqXwETnWhIh9XA9q8O947AonUCZv9fy?=
 =?us-ascii?Q?w37k5KHICarFCvJwWdtim4pyirMTgtCsCIakWsyFWkikXMUCwSzDyU6Arx+J?=
 =?us-ascii?Q?ovbMFCxo381N4V5Smn+WVIk8YTC0DYTbxLeR5o+pF+OaJrqH3hv9VpG/mw6C?=
 =?us-ascii?Q?NKEWQsSgZpPASRvyd+Lh8EM8BC6VZxlklY8VOHh+ZuD5iYYsXcZTW6lHLPXv?=
 =?us-ascii?Q?5YZMC9meVtFXZuZtZUkitq4ONRKEXCoNJhPvscnB1v1qWpYYrHr+nHL3+LBC?=
 =?us-ascii?Q?600aeJNpJYTFwUTYhwK9fr9MA0z7TY8qxEeUZmuTNeg3mkZlE/AF0bUequsE?=
 =?us-ascii?Q?VXdh7mxBCFlQ5O/2y1kqld9tyC0sxnxDa2Ci07P5TGyfACWMb6MXN0HVDSV/?=
 =?us-ascii?Q?shvMHZNJ4zZNH8o7s3KSP+cwe2a3xfCiadHVdvkj1w20HD4/2dxPitzVeXPZ?=
 =?us-ascii?Q?ampJJ+BDzUqpG8BQZAQcQDDrvlmgOdm53mVSQ/acaiQgJ1BXNFziuNtr0zoR?=
 =?us-ascii?Q?DF0RLz0CooSs/4U7LhjLC6vyk09OEFskst3H3OfFmscNDRInRFsvtgtAlkAN?=
 =?us-ascii?Q?sr/RypbiW6eXG1wXkXbbBeUEwVxvqeyMUbOzzkxiP2Opp8GYyMSapbz6dpQe?=
 =?us-ascii?Q?l+h0kfHwqGBvwoWOZbl8Wv7yaQ3baplk5gNrz8zA2odIas+9J2rR7eWwZkwT?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	reG2LbleKAHuHcYxz8PNl4H3Mo6zRNe0OlhMaDiygMMUQbYUXcOU4ViZPakiWT6HTqM61s4u1VdmfE+mETG6QcC61TDLkTXxtkLtYymeKMQtWvIGZF2KKX+9Zt7fl/14qcFwyi5+1hYzNGLR7QGsnp6fr/XY90s3OguhHDge1SBCMjdLBSkiyHEs3Asd2LRmtteWk+3f9C2z4PaGBNtuVc50/L5Z7bTe5FJWM+H4j983napmSKLe0fQX0wBlP790mbOwGRZo1v8uCMIkQTueXhG3D63Ghs22FKgylciSX3LuC5ShEoQpvbqkGEu92JP1bNx9q4sX4mo4V7ZvvUi5qFo25DcPxn0rXO8NJXBPnH36+6vW+MoyL5akS7WkC2qj1i8bYx109TCDabwadEOtyLBYv8FhevjpBoDjVC+8aLC2SqntOpHwS1KTi1t5u2joGlYJX4NowWKGEiDn6p389JYJPoPq4k4G+nNxngjdkQrlzZIvhNq+9jcskM0J4/Th/A2Wj0BnMhfaqNHhbIrhftWVu3NLOi0sSfHFbAZ1mxgmqtcEPHdwWfgb+sbtPXJsYzadXladoLur/caO4sNHsJi3p6YNkBXKufIB87jg6Qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847dd3a-4170-46f1-7a91-08dc4697c3c6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 15:34:41.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDlKxGI6gKKBXdqsbbTcDiB6mnGTyxbifdXOcEVecFenjoxhdDV8euSoKo3DyZQNp2c3QV1WwOT2xifswr0uZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_11,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=974 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403170121
X-Proofpoint-GUID: ue0Xg9ZYPiTOLENbWv_d0uPbhRC_LZvV
X-Proofpoint-ORIG-GUID: ue0Xg9ZYPiTOLENbWv_d0uPbhRC_LZvV

On Fri, Mar 15, 2024 at 12:53:03PM -0400, Jeff Layton wrote:
> This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
> clients, including the  decoders and encoders. For now, the server side
> always just returns that the  delegation is GDDR_UNAVAIL (and that we
> won't call back).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c   | 30 ++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/xdr4.h       |  8 ++++++
>  include/linux/nfs4.h |  5 ++++
>  4 files changed, 113 insertions(+), 2 deletions(-)

Just a handful of style preferences below.


> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2927b1263f08..7973fe17bf3c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2173,6 +2173,18 @@ nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
>  	return nfsd4_layout_ops[layout_type];
>  }
>  
> +static __be32
> +nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> +			 struct nfsd4_compound_state *cstate,
> +			 union nfsd4_op_u *u)
> +{
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +
> +	/* FIXME: actually return a delegation */
> +	gdd->nf_status = GDD4_UNAVAIL;
> +	return nfs_ok;
> +}
> +
>  static __be32
>  nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> @@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
>  		* sizeof(__be32);
>  }
>  
> +static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
> +					  const struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size +
> +		1 /* gddr_status */ +
> +		op_encode_verifier_maxsz +
> +		op_encode_stateid_maxsz +
> +		2 /* gddr_notification */ +
> +		2 /* gddr_child_attributes */ +
> +		2 /* gddr_dir_attributes */);
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
>  				     const struct nfsd4_op *op)
> @@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_get_currentstateid = nfsd4_get_freestateid,
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> +	[OP_GET_DIR_DELEGATION] = {
> +		.op_func = nfsd4_get_dir_delegation,
> +		.op_flags = OP_MODIFIES_SOMETHING,
> +		.op_name = "OP_GET_DIR_DELEGATION",
> +		.op_rsize_bop = nfsd4_get_dir_delegation_rsize,
> +	},
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO] = {
>  		.op_func = nfsd4_getdeviceinfo,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index fac938f563ad..3718bef74e9f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
>  	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
>  }
>  
> +static __be32
> +nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
> +		union nfsd4_op_u *u)
> +{
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	struct timespec64 ts;
> +	u32 signal_deleg_avail;
> +	u32 attrs[1];

I know this isn't how we've done XDR in the past, but I'd rather
see these dummy args as fields in struct nfsd4_get_dir_delegation,
and also move the comments about whether each argument is supported
to the putative nfsd4_proc_get_dir_delegation().

The actual implementation of GET_DIR_DELEGATION is in nfs4proc.c,
after all, not here. This is simply a translation function.


> +	__be32 status;
> +
> +	memset(gdd, 0, sizeof(*gdd));
> +
> +	/* No signal_avail support for now (and maybe never) */
> +	if (xdr_stream_decode_bool(argp->xdr, &signal_deleg_avail) < 0)
> +		return nfserr_bad_xdr;
> +	status = nfsd4_decode_bitmap4(argp, gdd->notification_types,
> +				      ARRAY_SIZE(gdd->notification_types));
> +	if (status)
> +		return status;
> +
> +	/* For now, we don't support child or dir attr change notification */
> +	status = nfsd4_decode_nfstime4(argp, &ts);
> +	if (status)
> +		return status;
> +	/* No dir attr notification support yet either */
> +	status = nfsd4_decode_nfstime4(argp, &ts);
> +	if (status)
> +		return status;
> +	status = nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> +	if (status)
> +		return status;
> +	return nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static __be32
>  nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
> @@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
>  	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
>  	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
>  	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
> -	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
> +	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_get_dir_delegation,
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
>  	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
> @@ -5002,6 +5036,40 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr,
>  	return nfserr_toosmall;
>  }
>  
> +static __be32
> +nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32 nfserr,
> +				union nfsd4_op_u *u)
> +{
> +	struct xdr_stream *xdr = resp->xdr;
> +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +
> +	/* Encode the GDDR_* status code */

In other encoders, I've used simply the name of the field as it is
in the RFC as a documenting comment. That's more clear, and is
easily grep-able. So:

	/* gddrnf_status */


> +	if (xdr_stream_encode_u32(xdr, gdd->nf_status) != XDR_UNIT)
> +		return nfserr_resource;
> +
> +	/* if it's GDD4_UNAVAIL then we're (almost) done */
> +	if (gdd->nf_status == GDD4_UNAVAIL) {

I prefer using a switch for XDR unions. That makes our
implementation look more like the XDR definition; easier for humans
to audit and modify.


> +		/* We never call back */
> +		return nfsd4_encode_bool(xdr, false);

Again, let's move this boolean to struct nfsd4_get_dir_delegation to
enable nfsd4_proc_get_dir_delegation to decide in the future.


> +	}
> +
> +	/* GDD4_OK case */

If a switch is used, then this comment becomes a real piece of
self-verifying code:

	case GDD4_OK:


> +	nfserr = nfsd4_encode_verifier4(xdr, &gdd->cookieverf);
> +	if (nfserr)
> +		return nfserr;
> +	nfserr = nfsd4_encode_stateid4(xdr, &gdd->stateid);
> +	if (nfserr)
> +		return nfserr;
> +	/* No notifications (yet) */
> +	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> +	if (nfserr)
> +		return nfserr;
> +	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> +	if (nfserr)
> +		return nfserr;
> +	return nfsd4_encode_bitmap4(xdr, 0, 0, 0);

All these as well can go in struct nfsd4_get_dir_delegation.


> +}
> +
>  static __be32
>  nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		union nfsd4_op_u *u)
> @@ -5580,7 +5648,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
>  	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
>  	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
>  	[OP_FREE_STATEID]	= nfsd4_encode_noop,
> -	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
> +	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_get_dir_delegation,
>  #ifdef CONFIG_NFSD_PNFS
>  	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
>  	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 415516c1b27e..27de75f32dea 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -518,6 +518,13 @@ struct nfsd4_free_stateid {
>  	stateid_t	fr_stateid;         /* request */
>  };
>  
> +struct nfsd4_get_dir_delegation {
> +	u32		notification_types[1];	/* request */
> +	u32		nf_status;		/* response */
> +	nfs4_verifier	cookieverf;		/* response */
> +	stateid_t	stateid;		/* response */
> +};
> +
>  /* also used for NVERIFY */
>  struct nfsd4_verify {
>  	u32		ve_bmval[3];        /* request */
> @@ -797,6 +804,7 @@ struct nfsd4_op {
>  		struct nfsd4_reclaim_complete	reclaim_complete;
>  		struct nfsd4_test_stateid	test_stateid;
>  		struct nfsd4_free_stateid	free_stateid;
> +		struct nfsd4_get_dir_delegation	get_dir_delegation;
>  		struct nfsd4_getdeviceinfo	getdeviceinfo;
>  		struct nfsd4_layoutget		layoutget;
>  		struct nfsd4_layoutcommit	layoutcommit;
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index ef8d2d618d5b..11ad088b411d 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -701,6 +701,11 @@ enum state_protect_how4 {
>  	SP4_SSV		= 2
>  };
>  
> +enum get_dir_delegation_non_fatal_res {
> +	GDD4_OK		= 0,
> +	GDD4_UNAVAIL	= 1
> +};
> +
>  enum pnfs_layouttype {
>  	LAYOUT_NFSV4_1_FILES  = 1,
>  	LAYOUT_OSD2_OBJECTS = 2,
> 
> -- 
> 2.44.0
> 

-- 
Chuck Lever

