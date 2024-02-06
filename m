Return-Path: <linux-fsdevel+bounces-10467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBF84B725
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F741C25668
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0515131E3F;
	Tue,  6 Feb 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ws/SY585";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tH4jAFvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E413173B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227911; cv=fail; b=d/k+cyO1Fx6z6ipQxWh/5NXCFYosyU0DZa3oZPdYurPlOlBa/EjZABG/KOKsdFLQEQpVzj8r6bGru7ap63/qM96g4p4WtSdMEY2JaaqAe4M7G5UZF2lLncIqdhcDILxYaqQON0VSCGQk3CVEBxI3T9YcQnzAvx+JP4Fn0LmoD+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227911; c=relaxed/simple;
	bh=zbnZxREZBSSwIU1WzZphfYqU82IodThaseYlHojlkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fe22ImlC08XKZdX/kNdQuMJaTJgJSOYF8sezzXzgpXBdXXNO4/65T8oJpVqboVNLpCI5pcUAZpQ2EMIWqwgyKAz/GQubfXniV8fWHZ5uvjZYD7ly52VZeJjnFYU9XQs2folOYD1wmGbfI8OMlR3+PaQYwCk/2ytnmKd1bmE9pd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ws/SY585; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tH4jAFvP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416AImDu003500;
	Tue, 6 Feb 2024 13:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Sb/f0pxYJAfJoNxMime0vksu+fkmUoTNxvx+1K04Byk=;
 b=Ws/SY5850/KHIqPrkvBbtj3iPzCoOXNE1auw9+6sCB7ysse9uA7O8dFLCuVo4pykPSTQ
 iCCUhChKaRoUsY9yA3xANsVq8ThQjjOKGU6uLIrh3r29x0T1T6xO9H0qJaPmb/sKezN0
 ZBz4AFsyXENtRALsAmbZQ6asgNxqk7BEFJ8u+5DwZArrRSromMKJ3af1lXfzAjK3lvJm
 3Dix9LswHwrQA2rGQhQ6y8uwv89+56XTGqYDeshyJI3bqTHsPreUnO/dZOV4NapspnYy
 JbQOkK7kFia5k3l3xrjtYuioV1JM1xky7xdNkLPgcCxlj+ien1b9ZrTUBeUG0olH3E1p Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93y07c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 13:58:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416DobrP007082;
	Tue, 6 Feb 2024 13:58:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7jem4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 13:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiwMgQ0egerwfT9XoV+GjcbWUdoEKH5y96fdKqMNJ+pVeIOsqIyKWWjGCAg5C0JRZ4t9pmmBfohIlE2Ek8OXzwB6RXd8cZBHaYhkfz2797RfYUL60yxHiWy81OjpMgu4yBBy8wC+gkNJ25Omyhp8hqw2tS9/vWaUGx9lyKciHIxFSUnv2T1WGpW9zaWZCDetIZN4/wuPwkX4AA4aBhvPvX248i/PK5cLg/Xor2HeGRlQOpoXTxKR4PzNIuxEKlDwIHEB1Kz3ZpDIww+w0ausmXPP9m1TQYTJ4/8aeqXvdB5yx+ylkg3UAaN4HTAwv4chjwIe5A/GdZBiwmly3ElY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb/f0pxYJAfJoNxMime0vksu+fkmUoTNxvx+1K04Byk=;
 b=KnAoKnR5CLMqS8vbZZBLx87IhEPxr/6zhwgJfJWPH3lEzuZkMYWozcXy1zxSfkRubs6C78UazdzrC89UoTCUA3cfEnTYBbvSpjpHHJ/gxb8CoZPKHPWw2Fo/AqOegJ+dgIDDClCzq4VANwyilgF/yr2to+YdeB+9xr7WQKBm5kXldZ8NFs7m2D63GF6fa21hB9TXgypxozl8jrAg/z6LOWKyAVmT6jPscrX1rpE/qysvhI/g8agLgz/joInDm6b4iJkHwCHK1NNDxyEMGKPN2Yq9Y5s0K7lj3/9M2yrmn09/3kgV7gEHZnhIVIGj46VhvTviG4wWHEkuvGlOkXVKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb/f0pxYJAfJoNxMime0vksu+fkmUoTNxvx+1K04Byk=;
 b=tH4jAFvPZfhOuirN46unBGmqV5tEFJVM66cppSOgxOm5CWhOlAlaGMo0SRKS0To/yJK6cxdhfHW9oQQz9ARbK3AJFJsjUgBPzOV8JLpWcP5b0/Z/VPRnGOcBp59W/B3Y5AC/aJUAaXHrIV+5ONChQhPRwkvrD5TozYLsjuL5ssY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:58:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:58:21 +0000
Date: Tue, 6 Feb 2024 08:58:18 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, aahringo@redhat.com
Subject: Re: [PATCH RFC] MAINTAINERS: add Alex Aring as Reviewer for file
 locking code
Message-ID: <ZcI6+vdtvpghMy+O@tissot.1015granger.net>
References: <20240206123642.28774-1-jlayton@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206123642.28774-1-jlayton@kernel.org>
X-ClientProxiedBy: CH2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:610:54::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb5b1d3-9961-484d-1b16-08dc271bad9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	82Me9pGobDhhNsuTdFdDWSgHxsmqY8J3AvF/7OAE9wKZ3+7LHgrouzGM1vLL93p6G21KrFI0p551rwiS/S1EAWwJ3uuQvIC168fIF7W8UKyAGetro2/d/BFtfCVn/1pLwGWLpfMWG9GQ+mWKvxfkQg/tJZ/iqF7jKhfQHxPxN+Qa0Q2L6aclBXWZM9QWazCjw1j8EsEsbTUEPxcbQekuCyztoitu9qD6KvhHQTD4l4r1qjNpSHbdsh7ZJ2YzwFzpMPRmeNZ7lOcFoLI3VSG2jdlbIv25EVNFQeXtBRorBHM0zZEYzppolFP8vSUL0yNFM8gnE4m7IL7/nPyUkUSWtdStxVCr45sQeCYa+JL386ZhneWAniuldxjyBZVzshWq1QSgECAgdlJUMI3jihm3J7MbysoaAJazvu9N73YnQkMnN96lvh6i3sob+L2VMCbrOdAIj+tbRbUGSKKTqjyEwGsoqVOIO/EcJClskgbN3HrDNn0ZHcGd8y5eD7vWJnX1V/ZqTYAjT8lGHBv5VkpRJo9IMVztBlwsDOb/XBztYCqxsEzFQ6GG6jWWiTlzfP0s
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(41300700001)(26005)(86362001)(5660300002)(6486002)(4744005)(2906002)(478600001)(44832011)(6916009)(66476007)(66946007)(66556008)(4326008)(8676002)(9686003)(6512007)(8936002)(6666004)(38100700002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E8iyAXan2WvHm+8E7leMaxeAmM9PllnPuvMS2STX85SaFlwgNGmSlriaH9Lo?=
 =?us-ascii?Q?eu78zn4A4Yy+gHDc1YeGek4mBofRDyA/HFBtdV2XvcIwkecNKWXy5VqFZXpK?=
 =?us-ascii?Q?hljQqLQsiWI9Xun2t3uuc7qo4zaROw8LYQVbsgO8yfj6GCg/i3D1LEbRwSuQ?=
 =?us-ascii?Q?95epCzeSdxUjPariv6XzmD2peiFkElmofO5IJ9oRxH1gNTJv/+MkEM93zYvU?=
 =?us-ascii?Q?tFcm/9CwHqoqkLffPlClTF/K6J5glk26bKlYM90m2BdK5SKsQ9Fit21rd8kS?=
 =?us-ascii?Q?wlpanFt4Sq8+ahpVCqhU739izGBzGZuuxF07/8IIwdv6C9HWi0zv8RNEv6no?=
 =?us-ascii?Q?WcLcRCJwlUiHG6Apuku5tgauIjOxFX/B3pyY/jf0m0y4NUJoLfjNUD6dUA+T?=
 =?us-ascii?Q?MyJD2jnhDVmlkjKR0ZOjpF/YPDZ8ikDLAzW/EOQBRZMjEynnwf9SeslHbNyz?=
 =?us-ascii?Q?zhAhaoBi4KLfP3Y0OE3MGPrqiJf2tpJhz3y9JIFfRmJDPw9KQcVlxb8EPYsj?=
 =?us-ascii?Q?Pyzz7iajn/UciW9YwQCwagrIArNXbV4YIqgWoar2cwBQFUg2+igXYPSAKc/l?=
 =?us-ascii?Q?eQqXtfk34Vym7ZE2ljxz7aCVJCSGxdwqNJe1m7JvM0eY/IHhwvavQHnoMBGi?=
 =?us-ascii?Q?nTpSzzQ5s4pfoWYsmt2BdGnqhsfv8toVE6TeBYWjTlH0sZe1oHfZU2pAoc1y?=
 =?us-ascii?Q?QFAXTjK7mScVRrLkA0TZk7+o9RAzYk1n9eCOV0S7kLgfI6QqdqxT1y4uZG6c?=
 =?us-ascii?Q?qAEAmKZ7g0cPg0wVTUQ09CBgvOL6j74OpdpThto0//Fpc4ZhQHV8Sc4uXzTA?=
 =?us-ascii?Q?ruk8sk5aBBVuMZBwSeu3fHG7KYrKZVEuktISSbDqoTdUTpBZcsZf4e9T9I7i?=
 =?us-ascii?Q?lnAx8eK6Tfo1sRdej7fZmEuzzNihCjrYJ+HgQmp7WIMDCk68cEGfJ16b8YmS?=
 =?us-ascii?Q?ALOWEqfHsbiX3OMbHUAezVZviWoZ2uHiRV/OXVAIh/FNGCKI4Y7dGrB6lO1R?=
 =?us-ascii?Q?Cbxg4pEoek3oSIujRPe24nWfxYfvWwG5I1jIe1SvXgAh12WlKXdY1QWW+fAY?=
 =?us-ascii?Q?x3+gGB3iHov7SzRmEQsEoy+KTuEcodDC5amGivww2eJ0rCSEdQf/240MFsGo?=
 =?us-ascii?Q?Dj/wM/GsixEIkxXImNmUA4sx8968tCAJgInzBa0JmgkQvIi1PesoYUTUQDMP?=
 =?us-ascii?Q?iy4PMlPmAvgk9nPARMPyoaPxppbQxay+kb1ASORbJKikBUs14JYSMHFLsdMD?=
 =?us-ascii?Q?ktosCMnj2p6gK7o8SN3dFp8ZmQle85Su5hhF4L+Msu5OmputzbMBCK9z0e3x?=
 =?us-ascii?Q?QK4DA+SV81vIY86QIpjqOc+IwsQ6KJ1TL0CgOIIiEkhuy5hL6HslmuXH7M6R?=
 =?us-ascii?Q?9q1+0gGk6n9gIw+IU1TcT37hlBLEvQUiLVc0cEnQIac5tFcx7uSXnK/6Ba8/?=
 =?us-ascii?Q?EBrG4WRszcTxoft90uilcILrCpnv7HSI6u49W8My6LGiHy9GaNc7n2WETobc?=
 =?us-ascii?Q?udDNZ/vR9RWYI6JfrFuNZci/fkHhs9smirAXDDO4upA9/Z1xK98aJgXk2ibm?=
 =?us-ascii?Q?L0WrQaLYB9/kobTAf2HwwW4JCNG5P+CAAls+cZA1aQaM89Sr9NlL+aaDwc5E?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uDKL3KZ5mXc+wcvN2VbIw6nUwG9qm0aWjFYcpPt0jPztwbMAMsXhZLPZ9SaIq9vXmSVUDUdOyMV6M708YcfrvKANaQJbVG9e5zqfasEe8UtEGVTO2/v0cSr+5kxaGBjPEhXqD9FOih9NHvpfGBtGaJiCoNSxh4v/59Bnqqlt9WSDNQaR8btvvApZzaSM9FOvYfK57Xct5Rcm5W0kffrunwAKRrWhHeop87OV5mt0zrlZAfxO1ym8Jbdc1je7biI+kbs/7Ib4ylV/dlNwCccQHa3Ss4Q5z8aCUbtTRh8S205j2aPkJWlWbeNXPvJm0Qk009WdbKDokrYieqidtNalElGGJd8Vx5JRa/gfTKrmMQsA9KPSDSVfD+gP/QqlvdLSTSP34Wy7iF9fFBHpvh5CXEAqKWtJQRtdpsoWACIHeM7cJ6H/t56xc2PAAxXS6iyBPTzWR7luaDtQbMzZzJCn5HMI+25SSXFTGlCeJlOXRUAqZNbku93dkOyT+d14OESsYcKvNnPHWYmYKpc0cJNlE4OFnkrN6AerC87sL+O2rxttlx5+p4u7oXTFtdkvFVrDgjazbYQxlkvXP7uHZkGJG9kTLAtqG842UVTRK7dEOZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb5b1d3-9961-484d-1b16-08dc271bad9e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:58:21.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu2OXdT7ujl8Xi9O3FSdPYqWX9uhoiwNWMQiwa9pJO4cI7/jQc6+0t8l6Gc82f0DJnOzeEaPyObUDZpZZ3ZQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060098
X-Proofpoint-ORIG-GUID: isMsiJSXDUnOx1yotfvoY-508t5itLM7
X-Proofpoint-GUID: isMsiJSXDUnOx1yotfvoY-508t5itLM7

On Tue, Feb 06, 2024 at 07:36:42AM -0500, Jeff Layton wrote:
> Alex helps co-maintain the DLM code and did some recent work to fix up
> how lockd and GFS2 work together. Add him as a Reviewer for file locking
> changes.
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> Chuck, would you mind shepherding this into mainline?

Done.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..1f999e4719e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8160,6 +8160,7 @@ F:	include/uapi/scsi/fc/
>  FILE LOCKING (flock() and fcntl()/lockf())
>  M:	Jeff Layton <jlayton@kernel.org>
>  M:	Chuck Lever <chuck.lever@oracle.com>
> +R:	Alexander Aring <alex.aring@gmail.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	fs/fcntl.c
> -- 
> 2.43.0
> 

-- 
Chuck Lever

