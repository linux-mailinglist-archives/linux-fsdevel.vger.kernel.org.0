Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4D4A747E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbiBBPV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 10:21:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17234 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231379AbiBBPVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:21:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DHbZ9011400;
        Wed, 2 Feb 2022 15:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2l1SqwsC6+9v8F2xTJ6Irctfh4iLvXnGKL82Una5XVs=;
 b=EKK8qH/WWXT217WaTyQHEN2Z5Ovq9+LruEZevLfgRAkcyntHf+KfS/hx/jk7SeuChAJg
 h1ziJ5oKx3t/mvI8ms0cSlB6MMEc4KJqWuoR9Z4j3/EDJKZJbRto+i3zLwjtd3lTYldk
 EnkjbGfzFa2OjIoXGaBRGKTE+hR4MZD8K/fDE9yuCueMiwH91JC1A8NBvNntqxfSWk/f
 gkxlo+t5qU6QrqhWedYz8SsZ2AoWp6MgTRYfflJsuvJJDREsan8jScaIKOx9flX/l+s+
 sCvs6rK9aeGy+QLVbEc4EtYiLYoXaULbX4mydVZj9SFEqNhKQkozfYi8dXyZtH/fD34A mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fxcn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:21:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212FBTqW054387;
        Wed, 2 Feb 2022 15:21:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3dvtq2ufwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 15:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mawFIw8qa4Cfo1sXyueWeG8bowZ7ZdYI4fVczL1UECvHKNlkyNJddYG+CbLDIuneCikalcRh2qvNe/qHFlDarEAyiPHuq3LKzqeYPwiKshOkx7G83V8YC4NCigPtTfB5Jk6a1ALGfNvcQ9zIeNV6K1/kh9/McAFiJGNXhwuJSQpA5xP56gBiXSUoH8ILd3vlORh3S6GiuvW/WewPaiIXPYtYc4Aw/7w7DoIIKIQiCmpqkH6L1KWn8nJJ8Ihk7F/XT0GYticCyjNI2B0QI0B6P91s5FKqsbTFACSxsnCWpaAeP8pfrvzUDLIq6zSiLC7nu/28byL/u610UB2lYyHzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l1SqwsC6+9v8F2xTJ6Irctfh4iLvXnGKL82Una5XVs=;
 b=FQ6m0zAVokAYIuxrn8fY55qrpZ+7J3ixYoXGXE7h3fo+jHtxDJshPvN9GSqiJjvQmBqrIakHBK9wJW4ixZt9QyWRK+xkEST8KVtqI/kY/BmTnzDsj5VogGi9tlvErTdNbZNxMJFZVg1I0oNOh+22HyqzfZxCwciV4T0ItlfroeqNX07nZb6PbH6W0M668KyG0Yq12EJe4Z72tzW835mrK5TRhLsZ0+zLojOs5NOtW4E3e1sIF7MvAkosIuPEjkoTzUkM0WiP74YIbkXB7b5sBrVFetA/cjz8FtX8xo0FEaiDRmg+xKoFCw3H21QgXRBNO8JSaJUK7K/vFwZ2XVMtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l1SqwsC6+9v8F2xTJ6Irctfh4iLvXnGKL82Una5XVs=;
 b=BeEtF8Qg4UV2lHlWPhb3md5w10a87CsLN7nQPx1PR12zplIaKVO5jTnbJtbyrxiwQQiR0WLHpMGFL3dHrK1W98/ynqhvNeEmWS+0x7ndo0IQwA/9IZUxj93yIrcfVtwZxgASRabBzyUhZUNbBEYaqA1rbZciaEpunifExvJPp3Q=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM5PR1001MB2123.namprd10.prod.outlook.com (2603:10b6:4:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Wed, 2 Feb
 2022 15:21:17 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 15:21:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Thread-Topic: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Thread-Index: AQHYGD7d7d+2S4V6f0CEtplIA5luzayAYIwA
Date:   Wed, 2 Feb 2022 15:21:16 +0000
Message-ID: <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
In-Reply-To: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc75198-533e-4f3b-acca-08d9e65fa84c
x-ms-traffictypediagnostic: DM5PR1001MB2123:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2123429244AA60CCC185E8B993279@DM5PR1001MB2123.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtU3Mxmv+3puBdvtfSDk8PA6WUG3m04wUB3//jEYkpHGTYfP2CeY8cIW93SuhjXORAnTpSICrsHxYzEPFbZRNHsFXbWHqIZDUqV89nlDospsa9cKX6AVxgv7pHTkQDnR6oDbJL/bIMSLb71o13Ivbi/yrxTXv5M+1FUNAFdjqfPtXwGR7NCQqxljddcBZqhex6yCB4BUSYv3Z4q5m02oEDdhr4Ul8koLHb78NIfbuK0BTK09bX6Dk/Y0M9yX8ihqGRPiVcELjHUNivU8ur5/qAwJsInZaZFhofGNkwaIV+KVDLoXJnbdQNuoJkgV5sHeNf4QQ6/AL9ZFih3xzm7xHznTqbkj6+H0lCMQWO9OZDwo9nhDTuqDJF1Xwxc8CjtIPQgHzBj4iRWBc4QlvGFTX44DYMoQE6uxaFhiC5C8n0w9enWGC97/aqdXzHIrT1wfkCYdiB13IMpI8LROKl5SeffupF8CLHnTsM+qd8iwZ+ufrgDkgWOONB0fBXkQYnXedxHMZsxmCUcOgKN7/s8QInLJS3Gv40blZTTCCS4mtgfg8bI7KdrPVc4J2gG/XuV75Dc96wVy3sGG0qA7QpJvTmlatQnfMfNLAJckNdmKmYcZ1OixZTJhwvJKSp9L/McyKQoTF2Rgmthy89H0HG+SvWXlPEo6M2XO92azKVAqUCn6jwXcVGzxegQ7YLYfj2wtjUvIzH5T46BmGT3gxEbPRvGcLlj+jOMKpdaUNS509xvbOaTbEHp99y18Td2OlLySAbMMM/jQbCsSqt1KfLmr6wTvWoehlxmCYKdmnErZ5wgm0OCr27U7BYz7YyEJ16gPnQZTpFB/G36u+w+KmKJ74w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(6506007)(6486002)(66446008)(71200400001)(66556008)(66476007)(36756003)(64756008)(53546011)(66946007)(6512007)(54906003)(38070700005)(2616005)(2906002)(316002)(33656002)(8936002)(26005)(186003)(76116006)(122000001)(38100700002)(4326008)(6916009)(5660300002)(966005)(83380400001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3qPVvEvouheW/kxwBAlSXJtURRjMYLHNRSSeqHQJh2BbrUKcbyM6sJhT5PSh?=
 =?us-ascii?Q?sC7YyU3qLnhVrz6AkGFar2oCQE7WiXDXlf6ceenNJveM5Y8ohyrYAVUJz+a1?=
 =?us-ascii?Q?WShfRhko7x9Fbeql7F0qzJlvxrIlF4Kd8o3ujRbi98H+kDA4XOwB5+vFuUBr?=
 =?us-ascii?Q?ycdL54FUrT7N+hSDPaVs8Z7c85WqRwojew6OIJjM5EadqL5zgvNDTyGlSb+V?=
 =?us-ascii?Q?zL074uvYKgaDbvLDx7pXMIwJ3l0sN2txOjyaTbjj/XSj4nYoilaJmGVgZ1dk?=
 =?us-ascii?Q?PnMF4c0yOyR0MDJ8OFDB9PTXIVT9OKAJ8sTmJBypL8yBjH/RHObyOWIotYWs?=
 =?us-ascii?Q?3nU4fucBkk9cfyw+G/d5RKhgBSbZNg7pP0KkZco2DDjIEfz8oqSveKCO3tTs?=
 =?us-ascii?Q?xuK/qRprU8oo6YKxD8yvxUVmbXFxAHPDnNFbRMQGgHzCZaZHuyJA3Gz30L+L?=
 =?us-ascii?Q?FKIYGLm94wWvh5YdesIT+079Umy4QyNPlYtA49gl5YQOFM6Oslpz1yJqsbL2?=
 =?us-ascii?Q?fONynE1qLzJEuCewiTmygevhxxtektlxVNviZfkN8bLn2tjkuuqLJd827sUg?=
 =?us-ascii?Q?G87z3htj6jTH+4yG2xUj8Sto39pLPRBSvsZPXGArdtjvuTT4NH5axmAUxABu?=
 =?us-ascii?Q?i/be1VpithDqG1Dm6kETIzuqmeaKLiskcJL37ld3N+DS/7R8jc4gZdsJ3OAl?=
 =?us-ascii?Q?rp9m36LfgZzuVDoVnrzk/uWq/uFkk+k6ifXMF4q90sK/CD4bAY3MUX3XEa/j?=
 =?us-ascii?Q?t/edU1meFV7AFOzjbwF0DGk+jXnQJM/pNOltumWXIbo/1iCmsunTHfIasXs+?=
 =?us-ascii?Q?qjrChs3JzqNBh2H/PH43lD38DyTIi2nQHE0w1TmhN2NDvUkHGrqNUeqWnXJL?=
 =?us-ascii?Q?X9DnZrbociPRkCjcrEtkRVhHIl9G2kVXEUdZx3Ni5Atfp8HEO23eH0pWkley?=
 =?us-ascii?Q?iXX8RZ7UwBkKGxkIisy8igwgRzcu2yFqWHo327KgeHLIkshiVxTPu3vqbj21?=
 =?us-ascii?Q?IPyfRChYMUwlTXwSQI+17mQhiM/Mwz2g4iwCrTOPXE8jEplC5zh8nMPYu2gp?=
 =?us-ascii?Q?8AFPT6Fc72J3sEh9Kcp/0AfLiXRhOuYUxZKsjZ0BkJ7buXNFRIsv/kk7ACSs?=
 =?us-ascii?Q?kJoTXyzXLqoqGuOqyKEx0Kv9XHy4qGOmo6iYi9Md+roo7xy260NKvDSK45AY?=
 =?us-ascii?Q?WFqsfwf/j+tGlJWCBBKkjfr42RTmcON9BcuPkdmjsi9sdhMobxxvBtDPRfT/?=
 =?us-ascii?Q?L/fNFG/y1SufSNA/Pq+LEad34HbreEhuKCPmF8oHkPLh4BLWKQtDyq7EFGkg?=
 =?us-ascii?Q?f/pOy42bR4lgMwz4OBwkP84wqfoDd5nCbkVn15uykiEGjE1hFvUuliaDJ9xj?=
 =?us-ascii?Q?PkFHUElqU6F9FbmXFgp8VFQfxIsdJO8W60AAfEa5J/mhg5nMNM3ePrzzPtIy?=
 =?us-ascii?Q?ymvWN1HMVTxkttMuE4Q14GNOd1zcaXdE1AjLWqAtUVXYSqBpXK3//BpWMtSr?=
 =?us-ascii?Q?/a2O55QNDzbx+D2pJHiwktxU76DpWLfgBiexIvJxpQb3yz3P9mdFmF7hGMyh?=
 =?us-ascii?Q?dLHxfv7B2+6zPyNLX0kNq0KYIGUi01ps/l+k83tXDugrv89r4HDrqDEkTCEj?=
 =?us-ascii?Q?38e9bUZ4ip2BTbrrTtUcncQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAE409FF6A5DCE42963E6F82F324EF2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc75198-533e-4f3b-acca-08d9e65fa84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 15:21:16.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gs57ax6gbUF+npgYNEXa1MzqjSaWOpgfRihl358F0fxSUqm7LPHh3TQb1FkczjWar/czxrWSe5Pydj3wNaJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2123
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020085
X-Proofpoint-GUID: YgsLR-5CqKGtVNd2cHw82K8Qrr6N7Y7l
X-Proofpoint-ORIG-GUID: YgsLR-5CqKGtVNd2cHw82K8Qrr6N7Y7l
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ ... adding NFS and CIFS ... ]

> On Feb 2, 2022, at 9:12 AM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> Hi all,
>=20
> nvme-over-tcp has the option to utilize TLS for encrypted traffic, but du=
e to the internal design of the nvme-over-fabrics stack we cannot initiate =
the TLS connection from userspace (as the current in-kernel TLS implementat=
ion is designed).
>=20
> This leaves us with two options:
> 1) Put TLS handshake into the kernel (which will be quite some
>  discussion as it's arguably a userspace configuration)
> 2) Pass an in-kernel socket to userspace and have a userspace
>  application to run the TLS handshake.
>=20
> None of these options are quiet clear cut, as we will be have to put
> quite some complexity into the kernel to do full TLS handshake (if we
> were to go with option 1) or will have to design a mechanism to pass
> an in-kernel socket to userspace as we don't do that currently (if we wer=
e going with option 2).
>=20
> We have been discussing some ideas on how to implement option 2 (together=
 with Chuck Lever and the NFS crowd), but so far haven't been able to come =
up with a decent design.
>=20
> So I would like to discuss with interested parties on how TLS handshake c=
ould be facilitated, and what would be the best design options here.

IMO we are a bit farther along than Hannes suggests, and I had
the impression that we have already agreed on a "decent design"
(see Ben Coddington's earlier post).

We currently have several prototypes we can discuss, and there
are some important issues on the table.

First, from the start we have recognized that we have a range
of potential in-kernel TLS consumers. To name a few: NVMe/TLS,
RPC-with-TLS (for in-transit NFS encryption), CIFS/SMB, and,
when it arrives, the QUICv1 transport. We don't intend to
build something that works for only one of these, thus it
will not be based on existing security infrastructure like
rpc.gssd.

Second, we believe in-kernel consumers will hitch onto the
existing kTLS infrastructure to handle payload encryption and
decryption. This transparently enables both software-based
and offload, and in the latter case, we hope for quite
reasonable performance.

As Hannes said, the missing piece is support for the TLS
handshake protocol to boot strap each TLS session.

The security community has demanded that we stick with user
space handshake implementations because they view the TLS
handshake as complex and a broad attack surface. I question
those assumptions, but even so...

We will need to have in-kernel handshake to support NFSROOT
and NVMe/TLS with a root filesystem, which are requirements
for the storage community.

We have an in-kernel prototype based on Tempesta's TLSv1.2
offload in the works. See the "topic-rpc-with-tls" branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

We also have three promising user space upcall implementations
that are helping us with architectural choices. The main issue
here is how to set the correct peer authentication parameters
for each handshake. As Ben said, key rings can play a critical
part (as might netlink, but perhaps that can be avoided). We
are sensitive to containerization requirements as well.

One (not-yet-working) user space prototype is published in
the "topic-rpc-with-tls-upcall" branch in the repo above.


> The proposed configd would be an option, but then we don't have that, eit=
her :-)
>=20
> Required attendees:
>=20
> Chuck Lever
> James Bottomley
> Sagi Grimberg
> Keith Busch
> Christoph Hellwig
> David Howells

Anyone from the CIFS team? Enzo? How about Dave Miller?

Actually I think we need to have security and network folks
at the table. LSF/MM might not be the right venue for a
full-scale discussion of alternatives. We have been waiting
for an opportunity to bring this to a broad community event
such as Plumbers but the pandemic has interfered.

However, I am happy to discuss alternative upcall mechanisms,
new requirements, and anything related to securing an
in-kernel handshake against remote attack.

--
Chuck Lever



