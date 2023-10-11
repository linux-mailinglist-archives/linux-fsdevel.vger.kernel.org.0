Return-Path: <linux-fsdevel+bounces-80-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D095D7C5821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1CF1C20B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B8208BE;
	Wed, 11 Oct 2023 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3XNtPSeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k0zjPHQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE90208A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:34:28 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CCBB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:34:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BFTVeY019541;
	Wed, 11 Oct 2023 15:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rV13/Ja0oNA0W5Eb3YkfAjiDGq9ABgIBGWrQJU2QgXc=;
 b=3XNtPSePHHlORGikgaMLb9nJxtZ+GfuHHDY/UH9h9FWTZzfgmFmzymCHaowLB4kZjyMj
 WlNHxN0JpwvcEYkFaY0/njsTGcWME2WeKkslgagL0MYJetqy5og0Wo8h8G+zc21yvgFN
 cP3XXk6RyXbgzNlxS/JNHpVGKrMEBIFjFVOxBNI1wwb/PsJvuknZNSutYP/oVnRgZLLL
 2Ane181wxMRAJHdvXRN+xjAWpngSL9F2R0wqfaNJel1qH4Q6f+679pC+16X/tBABavOF
 6dEHuLhpbCJcUJw5mZ1kth1CnmrJF3OM2hexPcDfygGFMpEScompCUuhFby7CUU8erDT 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx28bss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 15:34:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BF8Y1B024236;
	Wed, 11 Oct 2023 15:34:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8w28v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 15:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSTzzIewjXjM/NmoLy6sp8AgQS1lzKZo81fyTxpXAleALRNRl6b+ITKC6BrgOJIhtXi8na4L6WgPIV7f7nkmpUEs/5v3qPvtIXc0eOBw47eY4ZmMHu9dyMd9XkyJCUEzCEdJ4wMajtqKRqgn1DcZQgGXZBo4Cx8Tpazbvrjfb8MlyrU8b+oNtEnW3X9EeR//exDfyrXjSx2smCICwMFRhNkQurtSiKf9dYiIEvSwGWlfgXy5yyh0sOwQQ0dmuC57oOaba1A+Gb2s2pydZqog7VhwhDSxCvUdIgXT8Ok6BP3ThR5LeHFl7gmnJyy2Z7GA0EC9EKopggyZxk0hzc2AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV13/Ja0oNA0W5Eb3YkfAjiDGq9ABgIBGWrQJU2QgXc=;
 b=S3Fwwy6nxcsw8YXWei3kjWT6ze7UWbnW2CxaebABdPdNfQanDTaD8YqPWBlFd8YVKqdR90Dw5V0ib9cB+7n5lR9spGoTGRdToHBwFLrj/zDB80x0j/SZHI3qnGT1FaIiLbMpawVLNgr2CP/+HtrguIKJAZMjCV+ZOPM7Wnyjks8dnIjRbhknvmD/k3ej1xky1sKqz4jYiJId3YOW3PPM6YPBir7V99kGqX8Vb5+8pwRlWSzagg79Psmf2hT/qrXLl8ZBLYLY6QIQJj/jQLwrEmTK7Mt3IJxgMxL+nuLTF8P/C+OGIoNFMhsw1ABptKaESpWj+vtaop9TEPOX/Z6QZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV13/Ja0oNA0W5Eb3YkfAjiDGq9ABgIBGWrQJU2QgXc=;
 b=k0zjPHQeLahk/1j/aBw9obECxavNS89mug3lMm4s7PRNOPeZ/oUDhZk9ZEtY0spdKs6ehCCpYP8KCL/6Uxndu1eKIxGYo3FOKbCYjpXTzFikBes6LrXtRzStzDC6CQ1V7GyUhiJ9LlwZ7LyawLle0Ft+HlgNz8Uy+UF8aNcFjJs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 15:34:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 15:34:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Vlad Buslov <vladbu@nvidia.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner
	<brauner@kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: memleak in libfs report
Thread-Topic: memleak in libfs report
Thread-Index: AQHZ/FdqLpZobpowIkSuoIGRXjdgXLBEuAAA
Date: Wed, 11 Oct 2023 15:34:05 +0000
Message-ID: <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com>
References: <87y1g9xjre.fsf@nvidia.com>
In-Reply-To: <87y1g9xjre.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6663:EE_
x-ms-office365-filtering-correlation-id: 08ec4be2-088f-4d35-59a7-08dbca6f809a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 smc2AXtnzgHqijPZRny1TBgll0gxGortqFH1Xw4ZPYVieTRa58iRLqIYP94v7UzTTRBGSTrgP+5iqJlaXv+2v0kgT5T8SJWRAaCA96wkneqOhnpqNtJSjvyAffE/VwRqPjKHpd4z6r43NoCsaG5JS8Cix3BYFz82XinmkaaBVnwJgPH6XZ6B54HXKh26OQXObVg3zxYdfxu8fLENVNfdDq+QHnIjV+bHdQLv2UQwlDIkx2afVLvp2TL3FYKHHhKOhW5+iZKBBxgE6ii5Ywx53jtUTettVpAbdaw4SKIuxSOjvcD4BY7uK2oAK/uII6P9L1Wl9POACuioMJyaoCu3b7sGj1AU9Ak0hEV7l/iWX4k0SWmwLyJbTGkwvSEBdUoV22qznBZjj4zwqq04Kx3uzQ757/mnABUy8PHTev5YqYFCc8wBhRExLx73xu2w+hWlBLuPQbcS6PD7KrMXSWSWt3/klI5TrJpmVXGtMOoY3kS+SpTHrnnydR8JmjzU22bqHKNQvL0+CPqCzYGVAdvP7KmVjZOADUAPSpvKy7PA7oqni9N8wca07F+fU09ySixzam525kuC4gkdoyZ8IBXVqWaTJREd/YxHuGIr9Yy3k8omzEqczjNkDZwKJjkWJmn/wcPENg/3J0wk1dxA3aE9ggtUHIrluOPU3k92cGvdPJpao5sa+Pg4ugX9hdo/qXFU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(36756003)(38070700005)(122000001)(86362001)(33656002)(38100700002)(6916009)(6486002)(2906002)(41300700001)(6506007)(53546011)(71200400001)(316002)(6512007)(4326008)(478600001)(8676002)(8936002)(5660300002)(83380400001)(66476007)(64756008)(54906003)(66556008)(3480700007)(66946007)(76116006)(91956017)(66446008)(2616005)(26005)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A6f8AmRUoAbwmBvd4GiaDEox4/UtpzUhKLU5TcUirVYs0iZC1V4m/PvGfwMU?=
 =?us-ascii?Q?N37Fe1ENRYsLWSk/79j9jGhhi1bgZK8RY29fekBSataZKVbTCr8oo7FVBs+M?=
 =?us-ascii?Q?96WS6lBwN9EFnmx4sf20unoWe+dfeNDA84berHzbv6owWrbUQ2gupeSp1U71?=
 =?us-ascii?Q?Be/7/6jW539lhRiCnNcn6UeyRA8C++o3OmULBxs7d3bm3wYq95d76Oi20KXK?=
 =?us-ascii?Q?clrwmT79LlJlATI4uK3e2+9Gvpu2fI04SYoT43bt1VYB3Dy5LU+l0hS/ZYTi?=
 =?us-ascii?Q?dyt/F41UVgmC2YgI45gnqbgDVm0BFSV9yxO8r+5V+gofl5mhBmFN5L2pHIFk?=
 =?us-ascii?Q?g3ZNOJZvI8bBXVJBWMTvDiGMqyvhNliUCBUbHTEjE5tjyLuIVbjaUgju3SLc?=
 =?us-ascii?Q?pmktc5HSpoAUTlrsdirwuJ1YxZMY/N2d6rjP6HI8WUkGx7hZGOe63v+5AIGv?=
 =?us-ascii?Q?Q5G4rrW6lQ13Mz2mlMvho03dCdrFudHI4sNeDOzw5vof4lCNII2dtFHXONWu?=
 =?us-ascii?Q?vqbZUZ9peH2z4u1fP5mP89e+lOrssvir+2c76CqqbCVfYnmc4ZxrIUSR9VtS?=
 =?us-ascii?Q?+CaesK54L0O07PglihhLfSst2a33ukiK/7YpWzw4uMzJ6Z9ztA0/5Dc499z3?=
 =?us-ascii?Q?G8YtYUN1pvNf8ESr4KE0LZw7d3fvqTfSKnxErf2tQQGdfKVwrkynP8J/0Yi7?=
 =?us-ascii?Q?5HX5BmPcGCDa/B4GMD22znTpML0YvMyi/iVWjBUFXxuq4171FCblm0EiImLh?=
 =?us-ascii?Q?Y42pJaP3DVB1XaZVLbJKEDwNhYmrCcDNPoNcTyChQwVYt5ZnIuGzGapjM6Xn?=
 =?us-ascii?Q?056tQh4UcEbOTh7S7t3s9cAki1iLcBoqrBVPLHPTGx5W4xpK9zIwrslKKHe4?=
 =?us-ascii?Q?wR68vZusv4+xTszKj3CMl+0ta/5X6ATQugGRp+LJUfi4WBCZHCoOdF433UVr?=
 =?us-ascii?Q?ka7+p2mZTTAuP4ZEI01M/dheAO+IgbRDwFOKjrfKAw7Gym7RDtTRJVbuk6n5?=
 =?us-ascii?Q?aED8IX1MxRTTKm+OQ3k0AfGzuxzfhIpxMK36HA/KqJtSB/0vY5RTg7rNGvfr?=
 =?us-ascii?Q?ZbrK0M0nN/kz1hYe3ho9PmxQMqSB/ZjAyGEkuqNkUT/KB8+tu0vtaQFVo5QF?=
 =?us-ascii?Q?0+0ZDd1TBtQjFpXpXlaECh4fvg0CONDmx2z/zgr3zdFSBKK5Oq3tIRwSiuME?=
 =?us-ascii?Q?BM4RjqiBV66sYiIcb1X9XfwVsll8+dHfBHylahPC+k+orUY73G7KS0ydFiNI?=
 =?us-ascii?Q?wO3omLMvAhJdOcQpTmlHHAmqR+bMA4sMEA3ZmuyOBcSvVMginGWzMBKtq15g?=
 =?us-ascii?Q?YrrbUwmEzsp23hJn/7DKqWMyvsnhiKuidEkjy2W1CAOvywoM7o9SACwgxCME?=
 =?us-ascii?Q?QUfirUnTDE3Z2TxeQlcuzczLDnsWZeKUZ8NHoQG1UFJmhcUZALWyDRYsaqnE?=
 =?us-ascii?Q?RxZnnF/ygSW5Lbvag50F6KAaS3sXhXmjDF8XcRpBfVa5be/J731L/++EvAFb?=
 =?us-ascii?Q?6OaLDI51S6NAMqn95tFkOU9wCsVa7QW0jY8Lh8bhdr9CxwCM2BysxTFEPdlp?=
 =?us-ascii?Q?X35kVzP8brOxGAJ6HDdV+wrVkjOD9BaE2imlO3h6W/VVXTBRmQ4zmmh0vRW1?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C770D5BD497194192F173A7EDC98C60@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qU6g7WqxcUUHyh0qqD/STEic/IMl5S7tByeFROmHJ9V5buhqgjcUqlbcl5eVTMQ34rf77HkG/LvXy55/pl+UFInU2GoaLK3slM+fMcFL/WsQ/w2Wt67VbdqCfvVq2VZt/kb60egmCyyhETVh0iOxpFRFbQnxaRpTsOez9OeGeMOnU8H3wZCdTRuqnEzHAOW1I0656V2B7zYJh2vKUNO7S9nPHdsJjHDoQxbwWQNo3E86uaPLOOO1eoV/htqc9sUTo+kgVNXg40iW6t+AmXl56ZKjzsIL828QwBl3vyM4t7D+Kk/4IAwBRBhpN9SfD1GrLcv5dc3+yBAP9FdNvaZMw+iG5j8bYgD+ejxzPFRNNpaM2A7gGY6fWVkmBnMKRIWRTYWUmecG4aj5j74EloTl3DFpX8Pe0mCeaUk+ADOmJJGMzcdK7vyWXqueBoMuvuEtL6kPsZLjc094kjS/H8EdRdRNz5WWUPBUCyNrqYuDKU7Iu++kpB4JyBDi/65YHPL8EwHPHCWooQOPhRznBeQQR9w6WLyDpg5iR1bxjjUsZTZ/+Fc5DIUHH5n9SUa+6/Qa3wUQn2VhVK0QjUVwUuF5r9fFM4WyLCP585TPYjS5CQaKr/e4N+rXoRKQPrGOvvAg/h1BgvqLwZbcf9ebvFWR48O/jojqOw6TQGpFcWnXDi4Ho7XyBqizDHiyDIb5iLJvD5xX3e5NO9If91ghwBnjHi4nOOMxglSyHLCnUzfMusJ2iKbu9ePSYiANru0K6f8fD/nTdH1XCEhme6OMd6CT8oggZC4/aDe5QEOW7/BydW0C0Iq+L556inKRkA6NwemI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ec4be2-088f-4d35-59a7-08dbca6f809a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 15:34:05.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTI7eTlY8QW1ROdOej1oqxAJodaWBuBu5oWJPVpAPbDS+xLPQPcB7mzSIWgBgqbaf50iI89YbzIZJd/zRE9aDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_10,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110137
X-Proofpoint-GUID: g14HWB6lyN3bWnZzAbWsVKheYm3jNEZe
X-Proofpoint-ORIG-GUID: g14HWB6lyN3bWnZzAbWsVKheYm3jNEZe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 11, 2023, at 11:15 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>=20
> Hello Chuck,
>=20
> We have been getting memleaks in offset_ctx->xa in our networking tests:
>=20
> unreferenced object 0xffff8881004cd080 (size 576):
>  comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>  hex dump (first 32 bytes):
>    00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>  backtrace:
>    [<000000000f554608>] xas_alloc+0x306/0x430
>    [<0000000075537d52>] xas_create+0x4b4/0xc80
>    [<00000000a927aab2>] xas_store+0x73/0x1680
>    [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>    [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>    [<000000001032332c>] simple_offset_add+0xd8/0x170
>    [<0000000073229fad>] shmem_mknod+0xbf/0x180
>    [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>    [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>    [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>    [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>    [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>    [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> It looks like those may be caused by recent commit 6faddda69f62 ("libfs:
> Add directory operations for stable offsets")

That sounds plausible.


> but we don't have a proper
> reproduction, just sometimes arbitrary getting the memleak complains
> during/after the regression run.

If the leak is a trickle rather than a flood, than can you take
some time to see if you can narrow down a reproducer? If it's a
flood, I can look at this immediately.

--
Chuck Lever



