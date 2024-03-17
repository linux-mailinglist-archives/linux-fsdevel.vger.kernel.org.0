Return-Path: <linux-fsdevel+bounces-14570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23987DDCE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141921F213D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747C179B1;
	Sun, 17 Mar 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GborT5mF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Atf1epys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D88BEF;
	Sun, 17 Mar 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688266; cv=fail; b=uylXSssH45B+J26w5Omez0Of3oPcoi/gVcDOYv+1+MqW3EZHTmyMIwoAMAMdwNqyEru2yKE2MuUcjCWhoDBp3LRn+S/BpjANmEUxCOiLVVe2j5paqzSnqyBuDcNLL0qhrUMzjaGGaH3Lt2FLui4QdG+2Rf+ZpQBcQyxZJ6oCVxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688266; c=relaxed/simple;
	bh=jKiW1omulw8ocggumqFAkEHx6xkfN33rXscOyVwPC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZhtnBu/A+7xuGCXQAi5f9r07oR97ENcD36LuKaNhwFi6fo+FPYKBWkbTqkZRui8Tlzhfi/NrET+sEJJX7xZm+c9KwRCeLjHXrspWnWXPKnnQfBNDVXerANhVn4RqXtnTkQZ51w822disRqaXpwfAJ4CKBww5MSLjbEi8jorcm6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GborT5mF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Atf1epys; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42H1c3Dk017118;
	Sun, 17 Mar 2024 15:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=R2WOZaf3v7lI5bs0zk9uLShEt+0M1dlVIUqMh8hOiTg=;
 b=GborT5mF5URekHYBVFu4VgVqblkjubpFdKcKJOXdinEVlZ5/KsvZvqJ9XsBdr5WKVO7M
 c8WL+sHm0s69y18RN7f0MM8NCwkKDQXcYVZTac1h28Ltm8G6N2+wBd8kDqnbVIA3Rigk
 LEg/Qex+QE1gSrEBVU39Hmz81BXjneVJL1fPIGJAcQ4VOaMZyXfJrnxpfcKnE4eSVcZB
 B1qLijgnMGoeUIU2ReTG+fQuJGUgnuGP5cGx7Sx1KzaOOD9y4dEWSi8xTdUGf+IOlXx3
 aCi30mdbHhLQGvp9FORyT1Zjd0wXzGlmSNs+oa686yEm4J0Vbi0XCACG9ReJE5jPn+aM sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fchj82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:10:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42HBt6Wq007478;
	Sun, 17 Mar 2024 15:10:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v3yftn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 15:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ08YrUkHDQrqXI/nZK3kat/JuvdL9MjiNzJLJUBY0QSwz6EB0zNrNtRSV9uL83BCwPTl5jbrGVj7BeCKAzh/qYarrAdmX3zwMLkrIc74C7nbov9s3nBX6B55/2iB2QHzL62FqVyytC1+Y4fF0j6l1HAWwqab5P67C6Bk/D4YnBtAprY/zGG2jyMVPp3gs4nv1MivEJkl7u3NKgcSiasLd58r20IsHkLLhtiyn0M2xRuP4OXgEkZDdnjaQER4ji+5z9NxJd9VINsB5GYOtee2ox/LaCCBJd+JvS5rBQSEJeUlH1r/Pf4clMar/KBP+ZrjwhvaPmzyufFw+ElVV5xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2WOZaf3v7lI5bs0zk9uLShEt+0M1dlVIUqMh8hOiTg=;
 b=NyJmtDvokxvhwwQZv3ksh19OpIeSuACCr+djH4DJPDadga3cVRbRJ3GYCugaE0Ub90/SvVjIY6CGpv8boLTu5J5VTLWM+KQ6qhFHBb+vOg6AvWOSSfWcTZov758EetgZSCINq6JyGCl3T8khdz+OdlTnV2qNvex+OH+9AArJC1oESuR4pqHcis1yp/5BwegKCXsLP45KU3jd2LPYrO3UcMr7eTX6Nvj1oQ59Fhjp5DPXeoWcSOK+dlKAAplEfLUN8TzPW/eHavIzsIZ4SFL4u7VY1QQDDqzGU2m94w/17n1/RxbX/FI2Nc8ksV+2mApMsXcuc/726sqEBGJT1xVfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2WOZaf3v7lI5bs0zk9uLShEt+0M1dlVIUqMh8hOiTg=;
 b=Atf1epysO8XlNgnndW8GjPnmplRgfeaWdUrA2QIUrIiOxRKH3i1kVT5r9eshn7ZdLIkCJ/+08JO9KM7Gy0+6YfYYhLB9Ke18itOa1IvGzS59WsAppJNf4wLfvHggz8+EtWb4W4fEjYg3ZcsoI9o0zgiWwXxPopypamsvCn+LYuU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 15:09:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Sun, 17 Mar 2024
 15:09:58 +0000
Date: Sun, 17 Mar 2024 11:09:49 -0400
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
Subject: Re: [PATCH RFC 11/24] nfsd: allow DELEGRETURN on directories
Message-ID: <ZfcHvSEkwIS8-Ytj@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-11-a1d6209a3654@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-11-a1d6209a3654@kernel.org>
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 668b0b96-448c-4709-af6d-08dc46944fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yFCfVTCrH2VUQtkPLDHb25zRRfk4D8L8qyrTQN+mDH08QRy9HAz5NYlwYaLCUfHiU3D3uMPWWyzJfVWlOiGwJCKd6uY7SoTpRUpUWSghPO6SOaJa6V1bZ28C31QB2u00YpHZbDjtbOO0aDGdzqwt0CboQh4n1y+O020i9IXTr2l3RBRxBPtPaYfF4z/9WCYHUkMX+zK4AeGZRfzX3jdh9M2Y6rErVfY4H75FdevWIzX1zkqRZj2aJ79eL5By2NFbR/nk7KW148iPF3T+LAKTXRLLkR4VJefbgEz5TSDwGBgqAGy5JaGSbt/KBN2qFQRL/SK0mUxvBJ/anm/UD6FW+Ug6BIC+RsiCKebirnk824sD5HIdkNfGQRyBqiP0gntUqOQsWvRHKEYEsX9Qk5rA9+/129EtzQ4vThQGzD+naTVTm9fFNltSX9bnjZhFOgBYWMVmeZAqA2gxa/4wXH3uilEFJHuWszPmCewVbHucknMYwJfOS+Ly1mXGwLoNWuYv05ZJ99ik4o7a7bK9V7vHmZZLnQ7N01M0+uir/yI8ibjYEwx9vDXLVltvFAvcOKX/EnybD/+0X9+3anVeX5bdxaoDntz/KEGg4qkcNl+VHkqSYp5pPNl71IQ6TvN5z8rSAgP1zMzW2VYBKFcFV7k5dEWdeg1iI4CN2tgok3xIWg4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NmHMpqVcOqIjMGjXp8h8PEsv/PStyp2qg+/sFgwQVHVfvOrcBIH589TZjX5m?=
 =?us-ascii?Q?Fw8vJn6QfgQWodsu9+aZ4Gl9SLcRLcSgeJ/n/MCbZgWy0Xf0lkos/+9iOjxH?=
 =?us-ascii?Q?UQf5xXUqghHfxpz+gvWEurJZx+M3iv2/aBoh193KUkMYibXVDzH9he/7iD7f?=
 =?us-ascii?Q?KWBHkH43ypVAlz6+uOHq7/Ex3NGtPL0T553lEUMC8JbQleQVNVr8K+WTPcxg?=
 =?us-ascii?Q?SrJJx3m0IzBA/L22O4R/SsMnQ7Fu34xLSORBLGqA4QHMZ4ESBhpMv8NE7MMR?=
 =?us-ascii?Q?yRAqMo4688uOIYOCw9yjJdYPiBffCgvZFGr85uXHHLBTPkmnnA5PClhYvPhA?=
 =?us-ascii?Q?nE7IyMxqpupzX3zUUfAnZGAJ3ve/8kOsl2qxWDtet5sGSOz24ir1E4TVQkFD?=
 =?us-ascii?Q?Qvg+anNW0AQhmDqAcoRUj5A7ZlYTj5AmC+fg5pkoWVz3P6JFuLMY/M8RkRFB?=
 =?us-ascii?Q?LZE9Ymrat2F3c+4Np4KUEirDdkioW0fvyFkt0fGHjULX9gzPMXvScsiWGRER?=
 =?us-ascii?Q?MYMBLNY19lQrfd15ArU/1zHm8iOyysylv4RW6xCvUM0LGbxiVmQuh4XUxKOE?=
 =?us-ascii?Q?YO02/i4AlqyrnekvZdj7WehW+B3vFOVmMHG5v5HBeqV1f6dDVkPvQaRv+Rgt?=
 =?us-ascii?Q?1XqOEnLXpb1/nFKSCOCAOVhjR74eLIqi418MPR2+knO7S5CB8WHQik3osv6T?=
 =?us-ascii?Q?VTflQQTZaVkh4aUN6k0l6mtbQalFYppcmq/mtHxC8g9nBoUW7ekJxp4w2IcK?=
 =?us-ascii?Q?O2RxNM90RCeB/3aTVDblhfz5QkajRQnGLNsgLRvNfnI0924rZ0QD0rDZTNKV?=
 =?us-ascii?Q?SuBN5ANgr1/q8ThS6m+HeJ81ziAWslrdBc7jnEql/keTf87Nn0Q91kuhHClo?=
 =?us-ascii?Q?lMx9BuY45DP8mlhTYsbKp/LbKqlMmGcdup6x4lhhK1GSG8+2DxqlivrH4fYr?=
 =?us-ascii?Q?vMfEX6uTlbDL7gqeWeLTL8VHStmCKAB3T57+5UwkFS5l52jBQ5noFqCurUm7?=
 =?us-ascii?Q?Ndw0h0bEK2YE4jAa8cH5Fkd421yEOZ8wo0e3b6ehy/MSNrpJPWA+Fxq6r5Th?=
 =?us-ascii?Q?DrQxKdrQ1/Phzz7XTIA3p6Az4hOEqxfHBen0gr/0A6++VBHtciQ77UtZCdSC?=
 =?us-ascii?Q?12SJfKr25ShqWJusVcKe2XUze0o90IsZDbe1vLA7SKTCclSBlT3fa1xsHSfJ?=
 =?us-ascii?Q?vSln4pfjdvrvZam6kzeyYDQ9uCfn8iPwB547O9HixHFFwh3nGS+OAOmeDLTq?=
 =?us-ascii?Q?cKOLJX3TuNgYCpEl+O9QrIKhxc6KlCOMkMBCLFpW8iJyWHmKZpmRlxTv/VZ4?=
 =?us-ascii?Q?XUIuvfQ1rdZj13s8/hS1u40WXbJFHdMm+2f/OdIRO7b4jbKrTLoC58W+4WiT?=
 =?us-ascii?Q?hvld3YTAcoFP6o10WGFClvm8MBUzlzsuHy1+PVVtaZjdr2gPeHiWHQxHFyOJ?=
 =?us-ascii?Q?0o7gXy6kuK5lgrx50x4zwY0TwrsV29e/8fNl6JWdos+cVcNG+LwtZ6NNHtsi?=
 =?us-ascii?Q?BekcCVa2ybJ9DQe6EEt3qumjVQnSLPZ87N2LNtQ9gv3n9mbbUR9Ceyu8lW3q?=
 =?us-ascii?Q?ymo0KLDMdLrMuIqzQv+6g+daGHtjUbIJNX++mOCk5/AYB5peHr35k6e5EayH?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tevoBGrYrou3a4eKmxBZVfchHZa/iolMyzNzY1DPtFuQZmXTXM4o/4IZuHegRq+6xER2JszhwDyaUyPTbfUg/OYOp5qf/3DQH2IZAcdbYkR1Q3sPN12XNHsqdx98Wb3DewYvKwrHS3D6Gw6G1XNbWF4FsMEdFeCHMf9Z881+UVHQ9hbPbxXCzF6WRlvFqy9tEenl4uGe0qQI4vepDw3BNzxg9GN+BbwePfPVZtF0Sjy7ROBMNXG75siUiLczMBqp8M/fXLP36voRHD50qRhwnF1W8uPvC1TT3HbyOhTxhSaqpT64rOpVx/2US32mEK/+v1LFm3sKGlbjqrymvO13s9JWeIrn7BIQdAwVGRZzTc/3jDrJAwJl2gxyWc4j+RaZ9qZS6f76Cr4hD1flk1TdVh8cO6dBtft1y8DaQ79DjcxTMAT2gMJlKzuJaoUk+2THIF3CEUPNsP8pwjnTI7Tnaa1xreeOkbsWMg3VdXilOGTfW/VUA6NszDcnOBwqTTKc1m3SymOFXx8bSC9LYTA5hugBo6PXNW0zhntq8Df+fG6w/oPYf6k3XxNW0/Al72RUtNU1eQHhQwGpKL+PUjB9x7k0SWaDhW4CGhEXKJbQ+mo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668b0b96-448c-4709-af6d-08dc46944fc5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 15:09:58.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjZMNjmtVJQMcWAISn4khALxx/uNz44W7OA68VFkPzHI22T1NvJN3/+MUnj+gDHkbM4rVfqRc6EOwhcBze3sEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_10,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=806 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403170119
X-Proofpoint-GUID: 37GOpg1u5-XBiubg3a2vHlbPgPXgJDJZ
X-Proofpoint-ORIG-GUID: 37GOpg1u5-XBiubg3a2vHlbPgPXgJDJZ

On Fri, Mar 15, 2024 at 12:53:02PM -0400, Jeff Layton wrote:
> fh_verify only allows you to filter on a single type of inode, so have
> nfsd4_delegreturn not filter by type. Once fh_verify returns, do the
> appropriate check of the type and return an error if it's not a regular
> file or directory.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 17d09d72632b..c52e807f9672 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7425,12 +7425,24 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_delegation *dp;
>  	stateid_t *stateid = &dr->dr_stateid;
>  	struct nfs4_stid *s;
> +	umode_t mode;
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  
> -	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
> +	if ((status = fh_verify(rqstp, &cstate->current_fh, 0, 0)))
>  		return status;
>  
> +	mode = d_inode(cstate->current_fh.fh_dentry)->i_mode & S_IFMT;
> +	switch(mode) {
> +	case S_IFREG:
> +	case S_IFDIR:
> +		break;
> +	case S_IFLNK:
> +		return nfserr_symlink;
> +	default:
> +		return nfserr_inval;
> +	}
> +

RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK among the
valid status codes for the DELEGRETURN operation. Maybe the naked
fh_verify() call has gotten it wrong all these years...?


>  	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, nn);
>  	if (status)
>  		goto out;
> 
> -- 
> 2.44.0
> 

-- 
Chuck Lever

