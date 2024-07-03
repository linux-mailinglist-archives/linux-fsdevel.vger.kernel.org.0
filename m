Return-Path: <linux-fsdevel+bounces-23017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55202925877
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE831F231A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43E15CD7A;
	Wed,  3 Jul 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g99TFQAE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wJTcGk+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162815B54E;
	Wed,  3 Jul 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002352; cv=fail; b=GmHD7ZdtupBbMaQZd0Hgdj96RJR7FHhNNh4ePNKCe2SrGoEfn8Th0NfVl9TPYW1ZME/0guxaJm0uGZjHwaXQJ1XXPSovpD4Jd8t8giKRsn8n0hEQBt3AOSRV/5Ttu6r+WS30z7/rKffhMyYpRMgDo0CmQwgIBOYKJTyxG67h8/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002352; c=relaxed/simple;
	bh=zUg5vOrh691TWHWC8XO+bmA25nD/wQxQa+QZCDBzqN8=;
	h=Date:From:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naad39Pzxoa1Sk2S55FUxKXMpucmvqFILye5rNsBfjM95UEFUOtbBNC/7IHyezXzjAPHeKWRrA+tjXzwphRJ4WPuD8UBC6/jfPTv0jCsCgL8NX9FrB3Kh0MXAsUsQ1tdrKgH40NpuXwYoZHUbkXrf+IHDCBsEczv9v1SwzxZjSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g99TFQAE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wJTcGk+2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638Ox11030877;
	Wed, 3 Jul 2024 10:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=c42DKP0uQvIVwmu
	fcbAy9dbi8a+h6pYlcgrED0SvK0I=; b=g99TFQAEHcNhxzZS1uixy2boHTDsSVt
	ypzjIDa5hud5lgMxS71iPqvRy9THjitItmg4vHWBILmPKCBc1/Vob67CDYqYb3Wh
	PwHdABW60uMRDcHlzeicubt5+uH9tlDUJciT6Qfoq//e0+IkBxroVxP1s8Q+saEf
	NhZ9os3Pop6bRatWPnREnDXrwaFVCjh7sSx40evK+niu1OG37ny7YJaiDcKaub4V
	tsvrN0MJ3/tL0HOTmSZxSaFTFw6c3QVvP6LLGg2PnNV4A7OH3CtL7NHfl5rjAD+0
	cuQTEBdh11QGHFQCrIYEL98PQPq3sEXQhre4dO6DxaRYINs7mBq5m0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296ayvt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:25:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463AEUse010188;
	Wed, 3 Jul 2024 10:25:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qfc0gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5uY9hrmrkWK4fAhJWM8xKmDvnBpg5vtVpGp7mg+d5G63RwyUj55QeKURJxJSWbt541qA1nczeJB+XtVdt9kqQqdFXmtAjS5VGRyqrLuky0PspW6rDyz/Hvx94JFXu7lwkO3Fvep8RhXrzrJJWQsf+tax3oFxMCzuOUN2grlPcdmztWexiXtD0siLPzIVf/Gy1ejuG3VPkdy5fX0nQjfTSFwuKTEYKzcw5s+gzW6yQ8/n1jSea/w7A2q6O3yvyIVvTnpBxzffztOiDg/0R3bC9S6fcFB2CX3gxTM9opeHVfsxb1gciN0PWimcRO5CtsYQmiKaEh4p3FZJo2qyx98xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c42DKP0uQvIVwmufcbAy9dbi8a+h6pYlcgrED0SvK0I=;
 b=Qv2Y2IW8UX57chPEz9aYURfkyiof2Xi7a0KMB4fsYgxrNaOl8qCKHO00y3JlfrMqfRK98bIhtSj0kHq5VffSnXnFHuRuGNL9PbpQEzmjP6rQ0VAkC4XSq59zwJN3f6UXf7RI3eLJH33C31TDwSzObwsor70bA1syn41WtagFM4J6Kj6uUgijcyP6TzPew4CU4OaqcvR0cL3q3YxK2kb7LOjb8VIEpIZ7ySNcE8YgQkKavnm+rc4Y8Uw10UudskdHlBkkbXRhtw5BuWyS+z+Z0usKmZxkSFUCjvqCVzBls+NpP/8/cT2qeE1cWp99izXMH+BzRl6iN1yUXHglShcpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c42DKP0uQvIVwmufcbAy9dbi8a+h6pYlcgrED0SvK0I=;
 b=wJTcGk+2smeDxg2bzTEp84Ya9uYL9QnZwEcDmX+mxlZB5NyuhYxIqJ6ruDNUQ8lKqMyCUZqUwEZQ/0RH0MKPBAydgze1jJtRVrh5CWtPFv0SQX7g3cw4uQ+6UUTE2Gim+gBBgrXoMmynjZiY/m9MC3e5ygEnEx9doMSTi6emBdA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 10:25:33 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 10:25:33 +0000
Date: Wed, 3 Jul 2024 11:25:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 0/7] Make core VMA operations internal and testable
Message-ID: <7e69c7a6-54ad-4605-ba32-561b985e2aa4@lucifer.local>
References: <cover.1719584707.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719584707.git.lstoakes@gmail.com>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 716489a1-8021-4b3d-d43b-08dc9b4a78bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TH4MTlbPS434438Vps6yav2WBGurulxEUw7/YmOvV/oIogiQ4nPxjjlWu13g?=
 =?us-ascii?Q?CiG5F9wqpXDYlCqtQ29QtUoJWsEjyOEdjU68MzVl7eZrGhpa/WwgQ9fo+6xQ?=
 =?us-ascii?Q?u80CCiN9qh3isGoP/FItwdx1FV832RvMBcKLEXyNdvHj5YZ/WtaQ0M2oN2A4?=
 =?us-ascii?Q?R+6oEv3VyyUz8KsAKsoCo6A0FFelDpDENbTg666fSvNJHSlIU/etLc2lwGVw?=
 =?us-ascii?Q?ysDTOMR5BvhkF/mMuY9+uFwruNtpuHvH87hqZq8uQnZ9Y8Nk7DROv4QbnbkH?=
 =?us-ascii?Q?eXmSBzhgrXFubJXIulaOr5NWjgr6HU++9oh1aMQisW85/wCQnYUNQQ+1z6Hv?=
 =?us-ascii?Q?YB0QtQp/HUJgIJiotW5mxHj0gAOywz4gv8nJwyq8xf7lumOmqXAUD6ev8EOM?=
 =?us-ascii?Q?xzrZ0WolKrSmhwioU1LVwGOX+J7cSzu+imu/e1dyhlqJ8msDkNJe41D7MXfk?=
 =?us-ascii?Q?jq63p/3a/D3G9Atpwvvi80YV/FOp3CiBEiJ1ypLhrYuJvnwaB0ZG02oMWR2N?=
 =?us-ascii?Q?zrU3Wvw3vz+k9UujivjHNuUXlKcrDa6iAEI19+j0lO1PGfpnwRuuVSzUHjCx?=
 =?us-ascii?Q?ZSA7w1RI4lksHES7gmFQrBr8AlP53BynsZFST4x96PMsyRlPJ3x8i9Ktz64L?=
 =?us-ascii?Q?cHla6ij3PxWXgYPOUg9jCJyFkogoO4OcF4FcGUciLrbPfD/jjvWQbv60lV5Y?=
 =?us-ascii?Q?l1vm9MkvYYedOcKUdNivIdgPajfOQBoxhWUH5pvDjOIaZYrGllne+j1/e/Ws?=
 =?us-ascii?Q?l7fNNaGyxtyfcZ3JjkOMfyAxoqAXkHW54I3j7UDi6F/fHZ5Ag5sxAr08Yiee?=
 =?us-ascii?Q?va4rNujKKzsBccGTMpqG/GO5ymix1+tpswLz5q7Y30+dH0PY9LXY+UNmDC40?=
 =?us-ascii?Q?JLvX5wMw/lH9wcGMjKXOFS+KMeuvR8kzxPAE6/VThkrQg3hnAcOmgvnSH+Gp?=
 =?us-ascii?Q?ajMkA9rZ/ZnZ6xtbTEFfrwiWSM8jlA/JDhprkeQwpfh62+Ku/G+kgYrgFtRJ?=
 =?us-ascii?Q?AiHpWd+dHYOSnLoPWV78AGC7ClVrU3jix4/nCZPviMl1tq1YBaZVlBlwWskx?=
 =?us-ascii?Q?KHFf0ftzLjx5FBgkzvIdGy7yzN8degB+qZjD5StWSal+dBL5v0Wssfb0maQI?=
 =?us-ascii?Q?jkEhSVOjgnKJfV2xrjVMMJ9d4gzoIruCU7/trX3V77CWK66S3t9RMbmoifq6?=
 =?us-ascii?Q?d/vMRfr7rQPIQknAQtl+AWRlBIKO8bVETYgxTgE7ArMUGU3aQ4U7QuFsJYAh?=
 =?us-ascii?Q?ocTuCYeT6JhLHXNQj+8Z3Tvtq7n7ezEpCSGanZbHUxYuF52CWWmX2F3TnR1/?=
 =?us-ascii?Q?JjM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BBmQKF3QdX9OXVbj5IBh4HMgg0jDUyzYeWXCRFOzecZRBAFqbp4fsgN5Saor?=
 =?us-ascii?Q?L11zBPh+91UxqHxDCEu/XzdyFHce3bPlOtYHWaNID9JlDA1y6rqVOVsh599P?=
 =?us-ascii?Q?TGKWsMxp2sfhSnOIUrArYfQ0+tkWKP/0eDrSirZ/CJa8PeEtwBGiZDptTwqM?=
 =?us-ascii?Q?SC2gEXvDvJBHXe0636TpB5m97cayvo0Zl7m8Qr1TXcwEieAyE4Y/Jijdw+OT?=
 =?us-ascii?Q?cX9Oy1FvA8Q/+IrEH8mRdB/wTPuHsxmhp+HDNpEAmrlqOddtAJgI/EV02MaO?=
 =?us-ascii?Q?yGpXZMCdiTUH4wW5z+xxZi6K3GjJ+LJB2PkBqM0Bw8FWLYiSs9F2/xqS484f?=
 =?us-ascii?Q?ipx1llYoEy0ylEIAnyR/IP9njf7LyxEdczXUISDPxNseCXAEG7brsRrFKqAZ?=
 =?us-ascii?Q?iVbyn8UZ9BowYCYlHBnFYylMIlBtseBuJPgo4vddIkfqokGC617ISap8PxcW?=
 =?us-ascii?Q?4ygpZvkYDju8/Ii1gyEeczfiu1y+vtAXVl4tuAcpa62phn3DJMTncEOwsflX?=
 =?us-ascii?Q?W1TiuujmvZUwNqUoJmxoDtkt7AZJwJE2Z4UOWfmwAKPuTsJ76CX7c+ubgNah?=
 =?us-ascii?Q?wo2UJQlkuCAHtYLr/qPsbmLNmhl+zDnnaw4eCYIGUBkVmOF4G+i9f5Xrdp9l?=
 =?us-ascii?Q?LqWkI8gmxdmaNrUn3zM6+r6zYSiQ0TnbkCVwer26GMS6N0RCO8+gZzlAR2er?=
 =?us-ascii?Q?W0yDmWIQZCjBtXUp4H1Syd731aZQAngKY59iOu8SWVxgtabYxh6xowkbR29p?=
 =?us-ascii?Q?zGzTPx9/jUDOhJMEI4dGvG/9cpSrzBqfDIHgS6TZTIcsnvK3XavE1VznGNNE?=
 =?us-ascii?Q?EcgpP7eMcW5EKn1o5+V+uUDu5dpIgdxkd/oV/BNGnj2zUNuvr6lD0m6RAsXI?=
 =?us-ascii?Q?WkCeCmOtRq4SD1tJFmtd3AGFr9INtU2EnkR40a+52yQWN1unhisff2RQJOIw?=
 =?us-ascii?Q?++bwmL9KW4fZmed4xdYPixlrdW6gTwtD4rXCTWfXtFv3mW+0utu7vLeqlPXi?=
 =?us-ascii?Q?G+1HI5d4j7sny79/ZfF3RIWl4UoTXe9m3/rQXks05ExjDgS3raA8iYnqmqLi?=
 =?us-ascii?Q?iIZ/tite1Yxbtl4r9i9Rq1+A0w2cSOw4vu6/tYYwh08/6D0i9E3ksw+sQhoo?=
 =?us-ascii?Q?wJjUDQPnHhy1lGdpXUpuwBB8nkwFUUPiIleK7vr8AYpzHf5gSbYFMgmgUa36?=
 =?us-ascii?Q?LiLz1UJn9WtSxbnmvmXeKWoLchKWsVUHeDWISjmv5SiHkIS/X99FSoZIGi7w?=
 =?us-ascii?Q?jJ+/E6ob/Gs44Sso/vvinswXj8tZSFDQuPEJ2nOpD1c3XxOFJUYXe8DwAksv?=
 =?us-ascii?Q?j2sjAE0s1jpL2kObWTRtw7I0dmRafoKO0MkyTBknPJwPf1zHSSwJn/X2PyYh?=
 =?us-ascii?Q?ij1w+sOHarH3zqbX616p9Vp94qsy2EU9WiJcMT2a8S2O0gJaPbikO4FQTX5I?=
 =?us-ascii?Q?ClkD+uOGDTzQQREoyRf3IQNHgmQUc74wtQvMpiqCJVW93wfq+/qtofyp1Ugy?=
 =?us-ascii?Q?RmKJLIw/SRTqnMwvWP6YjL8SxIneOnr+rZhcIkIP09ymRH9g5lDXdZB4LvV8?=
 =?us-ascii?Q?GTSWgb5VyoCveRaRMRpUg1S9xIxgu2vMmCbKRZyszL8pYKaQjru2rQKrfbtO?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mdy2PmpD9exiaTaDiNXM1rdAaKDxGPV0eSpez5efjrEWAqr9MFaXkCJfA2Q/x3vb70D/y5EzHUCYjAhhopj6lItplgum5tiIviL+IyMjGC9nPLEaC3wXsOKkzr0UYF6yARQWfP2ZRTK07Dn8rXX6/NaZ0ZttbIrvOIHYhAb2O2hBZpXw+84jvJoZkY0UIBg6RwQ1r5bVhxdllVnZvLzKiVRPHuQfCAchzTL4qNWbHqIdUmlLbv5/HZFfqbJ10c7OybEIppqqckcXIP+v2VEAvu3LQWH7vtdgw02L2tYLohaKs0DxTFq6rHqOdtHOrefwJDCGHCTeJV/1i2jFAHCkWVWcJgsSguaKb0+TBB8yo1j4dnOq99bPhNu2y1Y+gtoSBWSCt/0yUU9ZQGA37xAC9tc5p1MFkJhwg4Yi314f/ru3A//19SXvQzaReYYC/vnA3UgouvipljX3sinNFDhrPxetPmp3rRX7/7lU7ZvrIwbHhnpSAueZxkfl81hM3NUq0FP2nDRXbKsOO0+Nq/XhFtgcVIs51jAhwrXrpOHJ3Y+IuHXLe/ud5/4Hhu/wXaSJldzV7lTAoU5684YUcf+mF23p55pdCFL341iIwoybtxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716489a1-8021-4b3d-d43b-08dc9b4a78bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:25:33.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqi5SVLseN4iWqaOhYMRqkFZk3XfWu1H9n3D30Ur0/r9+38dvq1J6Le8hZYqJsoLPTIeOY2Z8tDS1u0yvhtFJ4QnUUmib69F0aAnkfGPZPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030077
X-Proofpoint-GUID: srXI5_yI9xpvDS-9X2HlJ5exBQeup57I
X-Proofpoint-ORIG-GUID: srXI5_yI9xpvDS-9X2HlJ5exBQeup57I

On Fri, Jun 28, 2024 at 03:35:21PM GMT, Lorenzo Stoakes wrote:
> There are a number of "core" VMA manipulation functions implemented in
> mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
> expanding and shrinking, which logically don't belong there.
>
> More importantly this functionality represents an internal implementation
> detail of memory management and should not be exposed outside of mm/
> itself.
>
> This patch series isolates core VMA manipulation functionality into its own
> file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.
>
> Importantly, it also carefully implements mm/vma_internal.h, which
> specifies which headers need to be imported by vma.c, leading to the very
> useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.
>
> This is useful, because we can then re-implement vma_internal.h in
> userland, stubbing out and adding shims for kernel mechanisms as required,
> and then can directly and very easily unit test internal VMA functionality.
>
> This patch series takes advantage of existing shim logic and full userland
> maple tree support contained in tools/testing/radix-tree/ and
> tools/include/linux/, separating out shared components of the radix tree
> implementation to provide this testing.
>
> Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> which contains a fully functional userland vma_internal.h file and which
> imports mm/vma.c and mm/vma.h to be directly tested from userland.
>
> A simple, skeleton testing implementation is provided in
> tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
> merge, modify (testing split), expand and shrink functionality work
> correctly.
>
> v2:
> * Reword commit messages.
> * Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
> * Make move_page_tables() internal too.
> * Have internal.h import vma.h.
> * Use header guards to more cleanly implement userland testing code.
> * Rename main.c to vma.c.
> * Update mm/vma_internal.h to have fewer superfluous comments.
> * Rework testing logic so we count test failures, and output test results.
> * Correct some SPDX license prefixes.
> * Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
> * Update VMA tests to correctly free memory, and re-enable ASAN leak
>   detection.
>
> v1:
> https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/
>
> Lorenzo Stoakes (7):
>   userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
>   mm: move vma_modify() and helpers to internal header
>   mm: move vma_shrink(), vma_expand() to internal header
>   mm: move internal core VMA manipulation functions to own file
>   MAINTAINERS: Add entry for new VMA files
>   tools: separate out shared radix-tree components
>   tools: add skeleton code for userland testing of VMA logic
>

As this is stabilising and there seems to be no major objections, the next
re-spin will be sent un-RFC'd.

I have a few small fixes on the userland testing code I will include, in
addition to the stuff commented on here.


>  MAINTAINERS                                   |   14 +
>  fs/exec.c                                     |   68 +-
>  fs/userfaultfd.c                              |  160 +-
>  include/linux/atomic.h                        |    2 +-
>  include/linux/mm.h                            |  112 +-
>  include/linux/mmzone.h                        |    3 +-
>  include/linux/userfaultfd_k.h                 |   19 +
>  mm/Makefile                                   |    2 +-
>  mm/internal.h                                 |  167 +-
>  mm/mmap.c                                     | 2070 ++---------------
>  mm/mmu_notifier.c                             |    2 +
>  mm/userfaultfd.c                              |  168 ++
>  mm/vma.c                                      | 1766 ++++++++++++++
>  mm/vma.h                                      |  362 +++
>  mm/vma_internal.h                             |   52 +
>  tools/testing/radix-tree/Makefile             |   68 +-
>  tools/testing/radix-tree/maple.c              |   14 +-
>  tools/testing/radix-tree/xarray.c             |    9 +-
>  tools/testing/shared/autoconf.h               |    2 +
>  tools/testing/{radix-tree => shared}/bitmap.c |    0
>  tools/testing/{radix-tree => shared}/linux.c  |    0
>  .../{radix-tree => shared}/linux/bug.h        |    0
>  .../{radix-tree => shared}/linux/cpu.h        |    0
>  .../{radix-tree => shared}/linux/idr.h        |    0
>  .../{radix-tree => shared}/linux/init.h       |    0
>  .../{radix-tree => shared}/linux/kconfig.h    |    0
>  .../{radix-tree => shared}/linux/kernel.h     |    0
>  .../{radix-tree => shared}/linux/kmemleak.h   |    0
>  .../{radix-tree => shared}/linux/local_lock.h |    0
>  .../{radix-tree => shared}/linux/lockdep.h    |    0
>  .../{radix-tree => shared}/linux/maple_tree.h |    0
>  .../{radix-tree => shared}/linux/percpu.h     |    0
>  .../{radix-tree => shared}/linux/preempt.h    |    0
>  .../{radix-tree => shared}/linux/radix-tree.h |    0
>  .../{radix-tree => shared}/linux/rcupdate.h   |    0
>  .../{radix-tree => shared}/linux/xarray.h     |    0
>  tools/testing/shared/maple-shared.h           |    9 +
>  tools/testing/shared/maple-shim.c             |    7 +
>  tools/testing/shared/shared.h                 |   34 +
>  tools/testing/shared/shared.mk                |   68 +
>  .../testing/shared/trace/events/maple_tree.h  |    5 +
>  tools/testing/shared/xarray-shared.c          |    5 +
>  tools/testing/shared/xarray-shared.h          |    4 +
>  tools/testing/vma/.gitignore                  |    6 +
>  tools/testing/vma/Makefile                    |   15 +
>  tools/testing/vma/errors.txt                  |    0
>  tools/testing/vma/generated/autoconf.h        |    2 +
>  tools/testing/vma/linux/atomic.h              |   12 +
>  tools/testing/vma/linux/mmzone.h              |   38 +
>  tools/testing/vma/vma.c                       |  207 ++
>  tools/testing/vma/vma_internal.h              |  882 +++++++
>  51 files changed, 3910 insertions(+), 2444 deletions(-)
>  create mode 100644 mm/vma.c
>  create mode 100644 mm/vma.h
>  create mode 100644 mm/vma_internal.h
>  create mode 100644 tools/testing/shared/autoconf.h
>  rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
>  rename tools/testing/{radix-tree => shared}/linux.c (100%)
>  rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
>  rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
>  create mode 100644 tools/testing/shared/maple-shared.h
>  create mode 100644 tools/testing/shared/maple-shim.c
>  create mode 100644 tools/testing/shared/shared.h
>  create mode 100644 tools/testing/shared/shared.mk
>  create mode 100644 tools/testing/shared/trace/events/maple_tree.h
>  create mode 100644 tools/testing/shared/xarray-shared.c
>  create mode 100644 tools/testing/shared/xarray-shared.h
>  create mode 100644 tools/testing/vma/.gitignore
>  create mode 100644 tools/testing/vma/Makefile
>  create mode 100644 tools/testing/vma/errors.txt
>  create mode 100644 tools/testing/vma/generated/autoconf.h
>  create mode 100644 tools/testing/vma/linux/atomic.h
>  create mode 100644 tools/testing/vma/linux/mmzone.h
>  create mode 100644 tools/testing/vma/vma.c
>  create mode 100644 tools/testing/vma/vma_internal.h
>
> --
> 2.45.1

