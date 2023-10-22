Return-Path: <linux-fsdevel+bounces-892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE24E7D26F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 01:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55144B20D5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AD10790;
	Sun, 22 Oct 2023 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vzkQYxvY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmVnhdLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00F63CE
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 23:29:16 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4AEB
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 16:29:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MMuTUS005746;
	Sun, 22 Oct 2023 23:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8ONxAKLLiHejKjg+qF7txUywXdD8/XzztOjp262fTRY=;
 b=vzkQYxvYM1L2YdmpikwP2UnfD20PDDxLj7dWndOv5fz6p6GgTd8SHK0/v9jtn3CHxPeZ
 SBVwaWndMt5eEizmnZ3D2e6MjGasNjx8TvohslJlZSnBd5YVtmV2la77wsHjs/6tJKay
 IvOIRfTb7Srr0GvLufFSGOkZ3vaKLzzrjLVy3bFdphpgN/ca2NkjoWzMJv3sLcDLLTpm
 ekVrH5AUnVCuTxzHftFwwZC53IFSOV7/DYMQbka2PJ9lRkP4YiIlXrG8yrFZ3ebSjP4/
 3faYK/oTotdRXDuBUaZ1vYRi6ir9x8oQyJ21EyWc4ir4uKXkYeD17nlzGH15ziArjfGA Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e31xvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 23:28:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MIGWuY018983;
	Sun, 22 Oct 2023 23:28:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv533jm42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Oct 2023 23:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNv26Ghvd55eG3AGHGTROWyxVHlKC8BSPXEJ6IJz/tjqM177JKJdKkDetgLEronyq4BlysCzkjqRzKpDp7LHLoh3qVGfPgEBwxqYwZmBfVD39egLeeSVMdrh7zX+P5EDxcKwni3FPwr2ho8pVETKk3EZV8xbOtRemD5ULZQxgkF+zmb7tZqw8LQnM5xvaPW8W+RcN4/FiQWoyVnLvI4bII0G4V6ikxWfxOTA0cMRD3jWAIf52ws0+xNLbXoSLLPQ+f0MH4DdtAVRdluiSbfAfML+nJZKDXJBNOue22AAiPfaChcn7OW7bnzDBfSrPCogR5XWI5Xi7ByvTnBmystV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ONxAKLLiHejKjg+qF7txUywXdD8/XzztOjp262fTRY=;
 b=YUMreo3kYz9ySJUZgMMhkJwdJZ83n/olaJrt8D22qg/eJ2HEbj57+6RwWTm9k2xAsqgs/RkQUFRtNIpF1Hhx3h1uDefxP266lI/QwG09MU+18eFFJQJTZ38yxlRk4bIxn3t5MSjJxpJUgPKuR0gG9cTB3QWrPpbiRidTh1kqpgCj4hpsyw0hjgXkfvghS+CxtVqkfm+oFwFawUDOBUkT+w/F+imQaHjDO4vJh8u6zsswOMRs4Q//Cffn9ihyZlHsdZKVSUe2OXPvyX02CC7AGYBRhJ0GTZ2vFNguRmHLxuvtqofc6T3NYZQXQz6NaOnDhKZGiZ0+CiwV+GAOckNd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ONxAKLLiHejKjg+qF7txUywXdD8/XzztOjp262fTRY=;
 b=qmVnhdLXHssLDUqf84yzd0Tl080Ps8R97K9z6L8UGJhjUb8dmHqp6/mUz4FlpQ9EC+fKKJnqC4qWHdDzALOcR8Fer+w3P1mYTOz5yXKbvXlrKs5ocop+fo3mkk73KAzJ6cbytNsI+KFwY6bdnqm8YMmAlLQPBh9kyDgz/X/ZPNM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5255.namprd10.prod.outlook.com (2603:10b6:408:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sun, 22 Oct
 2023 23:28:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Sun, 22 Oct 2023
 23:28:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Vlad Buslov <vladbu@nvidia.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner
	<brauner@kernel.org>, Gal Pressman <gal@nvidia.com>,
        Hugh Dickins
	<hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm
	<linux-mm@kvack.org>
Subject: Re: memleak in libfs report
Thread-Topic: memleak in libfs report
Thread-Index: AQHZ/FdqLpZobpowIkSuoIGRXjdgXLBEuAAAgAAFIQCAAAP6AIARxSOA
Date: Sun, 22 Oct 2023 23:28:39 +0000
Message-ID: <04726AA0-474D-450A-93BC-8BB03AB6C8B3@oracle.com>
References: <87y1g9xjre.fsf@nvidia.com>
 <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com> <87ttqxxi0j.fsf@nvidia.com>
 <366CAE3F-455C-47E2-A98F-F4546779523E@oracle.com>
In-Reply-To: <366CAE3F-455C-47E2-A98F-F4546779523E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5255:EE_
x-ms-office365-filtering-correlation-id: e23d60fd-39ad-40b7-cb9e-08dbd3569f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8xx2XpiaX7zW0OM1CVxkfIKXUuPVVNX0b00ZZyix8orkDtLQFS02ml0hlJbrTdhxPPblBqXDZMi9MdNE3PNIpd/16th73SENJdWPqLFom+gjCludoQDL5muy+Rx0NIwgXceKjt6ybJddxg0gWErhh/p/BG7WEbHQpuvq9luPNKlGV6ndO8PLk77dHkpQieR1rxFV5p+1Ix7fYpcKlYtiCNtncq9Wk8Eo1fl/u0EDjKCvktKPAIfb9Zfph72BZahYdJGdn+mUXaq+ZULMh7w6zk0A5t/Dj8vUIigmFXFpvIyOJb8wKh7UAa9rdmhS0V0Rqv6tKmwIHzieuP7wjw/bbDRxH43wnPtGK87g4g6aJWc/09woj+tnM1CeuLp7LtgimVTmglfhB2GUvPsFvGTFI06hwCWh/IE0NXSZiwwH3+jTKNr4z1UH4lpLdUxm5kupVUm+GZM+UciA22jtN48doqoCdta2IMt5CcfxWVnobNBnEFiOmhazU1vhwZYaPt2YI0ieT8nHcSDYZ518hlgFcxb2PLPvoOX/zpppWEK5R7MuZK8N8CxdbBsOnbGT/gPU6lMwbFUa+iCF8eFiUQj+wLoVlYzaDpnVzfg4/VyzrdCY8lqaFW0O7cRsbTa5LXpGrOMypOecwBcx+5R3Wb2hvK29SzYs6JVAovhko7Q9GZFQ2rFiZVNGv+RA4/7JQ4cb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(38100700002)(3480700007)(316002)(76116006)(6916009)(66946007)(66556008)(66446008)(64756008)(54906003)(2616005)(122000001)(66476007)(26005)(91956017)(6506007)(478600001)(71200400001)(53546011)(6486002)(6512007)(83380400001)(41300700001)(36756003)(86362001)(5660300002)(33656002)(8936002)(8676002)(4326008)(38070700009)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PVjNXO8i78HPDvy/HemP8HSrUdvT2HNSYHGoR7agRw3HsHLS8LK52+TcwJ1G?=
 =?us-ascii?Q?XRv3+Iyc1/Gdtx6D03w+J8hGkr3AvdcITPdyXH9sQDwtJzeF7DA5O2XPnZxa?=
 =?us-ascii?Q?BnYoW2ctKfMfC6aZL+W07Pe9jOl3Ot6UWzBLlsv/3nT4vw3Rl4LvhBxwmueW?=
 =?us-ascii?Q?jwpIzBiOzCQULtHBIjygx9tQHd9uDI3ixiR3OV/vbYl90gp5NN+yvC5AdyZ5?=
 =?us-ascii?Q?7CBlBq/cD1wNMlgFQzdIdDsx5vS6DOMKIKRwV+tcdysZlQXTa4/vZrCnitmR?=
 =?us-ascii?Q?AUqu9VnkDgE7mnjsqFAZQ6GusEvo0C2tu2xv416p5Z41fD/5fj7dyu9vGnap?=
 =?us-ascii?Q?eTq6kjbwADmGqeGx+/NiRU6B6Je7EFZX9mZClvszszWGOA8eukyZD7xeLKaP?=
 =?us-ascii?Q?5bA4nztHRr32k8xQnmSIYdUrCM/VxnETRlRW+f7pttIU/HL3WIr3L5/NOqQT?=
 =?us-ascii?Q?YmA8L4FPuTpQvzpgDOdvqzM9zMo+RK4Tw7VGzzSGXsdgD3dDPuWq1t40PWSt?=
 =?us-ascii?Q?P9Ucdb6sXVqhAWH4fosHNA+fSdyQbzMaIsuuvvrI7RqsR8vHWeWyjMaD6bP3?=
 =?us-ascii?Q?UsCNImJkVsAH5R5P3c1jqQsWW/qSGxrWaUgkbHWgsxduyOKWQ3dyvyVwU9b5?=
 =?us-ascii?Q?D8gWwm3YCgyOE7sWa1m6lAKNsdXhtBem/Srb+hNXBj3mVpJAZXon6VnCMPXX?=
 =?us-ascii?Q?fS+J2G32CnY6fxkGbVSlSJ97NeNGkD+3MVa/Nkx7jhIHAvlCHfJDq1xpLfvy?=
 =?us-ascii?Q?IYctKpo7Ulgy+6tMEmfth6wLEpg3uizhGwWNypDWyLbMR3CGlWgedO1pPE5l?=
 =?us-ascii?Q?OUnKufs3AnKgeKYF+jPT7bEVfbY/zSt+Fww6V8PObaobiPzOIAJr46QBaJU4?=
 =?us-ascii?Q?bnstFxyoeaGKFJa8g9KBIj0s+3EAnSV2VkMYqFRbPPJK7VP/2+euDNBnQTLK?=
 =?us-ascii?Q?7rvz1BsU+C8KB4XDbKB8yA6khpJqZ1dhJiwXaEtgLKN/9ipFAFp/+DoK0yaY?=
 =?us-ascii?Q?ewcs8vD4XFBYXioRmNsXXimGINzEiiWbB46f4RX9i74OKpE2I6Vz689vf8Cr?=
 =?us-ascii?Q?nGzUyTJ/WZ0iZYwF9oH+xh4fQoHxqHknwgeeLtxw+XrLvNFBMmb8nU8FFAEO?=
 =?us-ascii?Q?qMrev8vA/BFG7QLw34lzj1P9AhdstwmgoY18SoF/R707XK4NcHr1LhLD/vTQ?=
 =?us-ascii?Q?PndKbNYBUSh7ooXOu3t7ye2WneZw5HJOVjOptUrQOeTla+HOGz96Q7xmcS9m?=
 =?us-ascii?Q?0SZ1s4W/jiXzq8s+lnmiQLG6XZzbFpOlo1yA1ULYZBFwfYVpGiMB1UMIzZbm?=
 =?us-ascii?Q?vJYEy85iTNFdb2yLBybdLCgfdk2tRAjyYJwjZiXsgZ5hSW0kPYkXb6ZTL7IW?=
 =?us-ascii?Q?wTO6OGUOqCUwrcsJcnCzxm/k5x/W/HSVHCn3xVkoLqc4+9Y9Ez4mtN+xk9xi?=
 =?us-ascii?Q?tjtFffvNymDoVt9OGAyTR5mz7XKW1oSNaGQvh3YoYGZf5tCUxtslPzlHalCS?=
 =?us-ascii?Q?MM4XTu8wEDPxYZovxwVo1M8dq3D4XsqU2Op1RrffbV5pT6YvFFtQZeYH3j7c?=
 =?us-ascii?Q?Tt/4PPp7uL9ZwDE5AtQvqsgaC4RofxKwA76wEARA1nJ+wqO8B4qMgbQX/WLe?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23089DCC5328BB409924471E55226741@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?rjTDww45hzTzArLao+3yzUC6RtuXv8LW01Lj48Id9eHMOmQdHjYVHYfLdRKn?=
 =?us-ascii?Q?gSoya0B6ijnUSdY9nOTdDAhDqXQgohMi0g64QA+ezsFKobLoH6J3Jhgss/LA?=
 =?us-ascii?Q?XJeiLYYjKwylt4NEl5Oj41+ZIhXrjg1xPlq2eDwb39PwokNeo5iE3uo6jo+n?=
 =?us-ascii?Q?fDOXk7+nVFyetqbbSRbItKWsjlbiIdhwn1sEdsjDQTgvSQw8sSWluffGLnpP?=
 =?us-ascii?Q?S9w30zHv3b1/Lyxm+1HAcUY71ZGhggXw7lUqkoTsdeVmQdKJfUn1nIfAe2V1?=
 =?us-ascii?Q?JmVVJsoQVn54PSakMKuqXwcD2cd54SG3iyNAAIAK/3S8jU6OIjSwPurVNRvb?=
 =?us-ascii?Q?YK+LRtm4f7/KSf4QSc+Zma3AY7xTNTLNmeiEfjyd0GYBPgmYMaSkoTU7Vd8J?=
 =?us-ascii?Q?YcU1cM7Ln6qboO44DnfyB7Y7yGZ7ShK02Nflc4/UtkTnytOpvw2wdAlgjiAb?=
 =?us-ascii?Q?iyqH+y86D6dH4dwOJEXSBSLGXSbVIvzVUPZnTP3yP6hMlkyBFaABSq+8NE4p?=
 =?us-ascii?Q?jLXFQH8fHfg9xpAoLqxEPZjkuxy49Mdnl8f4u93vayTYEH5JyuYQyw5Jv860?=
 =?us-ascii?Q?kT+ud4LTuIcFLmf1mP4HbiB6yZFL/kOauo2AUtKgoQI93z6Ks06HUSgr3yB4?=
 =?us-ascii?Q?qqzcuvOgRiD46NZ73sjN2GQt8HDe51v0SuE1wV5F1Q+Ob6zVrItRTKOLSdY3?=
 =?us-ascii?Q?wQ0/TxBUsjDHXMINSfc2yITrO155gcTGKFTwsp9RvB5feM8jVSD6vK/CTQ3l?=
 =?us-ascii?Q?4G4yR7fv7gBj5+cySB4eTxn87ok7K5bLC/JpTAr1RUKRHWDW2SmXDmZUpvWD?=
 =?us-ascii?Q?EZgiR2pUkP86OcBagJtHhwIfc8x8KdNmBNZnkn1zg+KI7Szv0UjUVSF6BjAZ?=
 =?us-ascii?Q?0PG4OKr6Z5OSayNJ5ukjbdIHtrjZnW5Z5a2hrpfgvDjeWcnUMcUxp1YCn1aT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23d60fd-39ad-40b7-cb9e-08dbd3569f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2023 23:28:39.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ub5emor5ep7D+F/QSMsiKjnwKbLrGgxlELy0eGIM+HAvFT3GtPued3uKzg3uf4O+O1jE1OiI6QDbAXJ7k4gKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_22,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310220217
X-Proofpoint-GUID: gOtk0dKLRcUIV8UFJtMBHU0Ke3e2pLWv
X-Proofpoint-ORIG-GUID: gOtk0dKLRcUIV8UFJtMBHU0Ke3e2pLWv

[ ... adding shmem maintainers ... ]

> On Oct 11, 2023, at 12:06 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>> On Oct 11, 2023, at 11:52 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>>=20
>> On Wed 11 Oct 2023 at 15:34, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>>> On Oct 11, 2023, at 11:15 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>>>>=20
>>>> Hello Chuck,
>>>>=20
>>>> We have been getting memleaks in offset_ctx->xa in our networking test=
s:
>>>>=20
>>>> unreferenced object 0xffff8881004cd080 (size 576):
>>>> comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>>>> hex dump (first 32 bytes):
>>>>  00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>  38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>>>> backtrace:
>>>>  [<000000000f554608>] xas_alloc+0x306/0x430
>>>>  [<0000000075537d52>] xas_create+0x4b4/0xc80
>>>>  [<00000000a927aab2>] xas_store+0x73/0x1680
>>>>  [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>>>>  [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>>>>  [<000000001032332c>] simple_offset_add+0xd8/0x170
>>>>  [<0000000073229fad>] shmem_mknod+0xbf/0x180
>>>>  [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>>>>  [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>>>>  [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>>>>  [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>>>>  [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>>>>  [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>=20
>>>> It looks like those may be caused by recent commit 6faddda69f62 ("libf=
s:
>>>> Add directory operations for stable offsets")
>>>=20
>>> That sounds plausible.
>>>=20
>>>=20
>>>> but we don't have a proper
>>>> reproduction, just sometimes arbitrary getting the memleak complains
>>>> during/after the regression run.
>>>=20
>>> If the leak is a trickle rather than a flood, than can you take
>>> some time to see if you can narrow down a reproducer? If it's a
>>> flood, I can look at this immediately.
>>=20
>> No, it is not a flood, we are not getting setups ran out of memory
>> during testing or anything. However, I don't have any good idea how to
>> narrow down the repro since as you can see from memleak trace it is a
>> result of some syscall performed by systemd and none of our tests do
>> anything more advanced with it than 'systemctl restart ovs-vswitchd'.
>> Basically it is a setup with Fedora and an upstream kernel that executes
>> bunch of network offload tests with Open vSwitch, iproute2 tc, Linux
>> bridge, etc.
>=20
> OK, I'll see what I can do for a reproducer. Thank you for the
> report.

I've had kmemleak enabled on several systems for a week, and there
have been no tmpfs-related leaks detected. That suggests we don't
have a problem with normal workloads.

My next step is to go look at the ovs-vswitchd.service unit to
see if there are any leads there. We might ask Lennart or the
VSwitch folks if they have any suggestions too.

Meantime, can I ask that you open a bug on bugzilla.kernel.org
where we can collect troubleshooting information? Looks like
"Memory Management / Other" is appropriate for shmem, and Hugh
or Andrew can re-assign ownership to me.


--
Chuck Lever



