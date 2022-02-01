Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23C74A5533
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 03:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiBACRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 21:17:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3846 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbiBACRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:17:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VLhNDQ028108;
        Tue, 1 Feb 2022 02:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZanxshsE+5fseq0QsrQRwTCT/sl8/eJfIoiCLV8EooI=;
 b=suwWDAp3Gt+T2FobW9YbclONpl7DVYF6U3/mwlxDJNR6Kc7Ku90fExGQySGaBqRoTCS8
 ztIPel7drVCNNZRrR7UCpUe1BktVPV5j1djIrPVh6XNLRUiFHFKC4YxjFvJ8cyreIhlV
 JKo7YR8pY4UtYCzISN9/1+pQIfgBwu9+IxqfOyBxR+SqNiWZkZIYarDAIwiTVPqA3QTn
 v+itWxyjpBfNo5Geyl0a2z0EJghey/YsiGWOgwHihhcWoDB6DdFSVtrdo1/rQnKGyF8h
 T9rzOZ2DFiP5PikXREB+eB7nmVtv8H0Sp7MNAoZ7AH6yMoMyCRPUhw4jSh/5L5URsjnf ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fsg9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:16:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2112FfIN065051;
        Tue, 1 Feb 2022 02:16:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3dvumehsuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn/LZxTFv6E8XkX9jkY43B1aq74QBMYCe59jmN2YfCtAsVd6Yfn28l3M9S26Dwzdo+Yn/ldBiWxU5tccolsISvfloB1eMHmrjCYdS2acBxO0FS2fyFAyHOiIvTMAbKz9hJ7KIfyng2Gdps8RA9+BkYp2PqgplPwLoC8qVdpl7QqZhK+ycdsCk512lnAFbavm6SeFq3LbD//zWnDh82BR9ubY4OpK5xM2P4IrN5oJmfQLXGo0AfABGsgA++wy5B7gdHtC/AFiW4WOZ2+U+rEgGzGe8A9YYuIvpal/249Cu/DA2lT6jctl9rSF8EFBnbxYUZSiOHM1Y2vV61Z8EV3L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZanxshsE+5fseq0QsrQRwTCT/sl8/eJfIoiCLV8EooI=;
 b=hsNDirHpMd8KCjcc7X5Jdn5Ob3TcziVNWZ9eH4f9R/XQO38jsT/eHszsWIY5UTaiBmNKISwHcUNUvTNo1548oHAPQYPOYuVg+oGChUdvuoMfA2tNF+4Tsg4fmIxRjYlUWyap8vFB0HK5GH+PtJFyBk91kMvJO5uOIuaqlF7m8fd6hemmDpcDvXooMK9lAPz/J1zCcH7dXzK32xEbtWYwBQamSyVptyJwCkxsfGUT/Ps9PCd9hl4e6JfULz4uRbuw+nuXx5CQIou8qJA3KbZIwomWUz3TnF1E/sS3vR0hW4378Kf9fW+6I5rf7RbTeeBLPe28ANWIbyBPWHUmSdYtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZanxshsE+5fseq0QsrQRwTCT/sl8/eJfIoiCLV8EooI=;
 b=KFnhO1H8yIKUz/7blUTj5ITZhiMkanxurV23mA+vxAHgr3Gl+zIysft22R3dOeawMX1p6ZDmniUM04eSIqdHXNucY7SWuTyhIVzqY9Zs9+OKHW8gEoV+arZuhJEV7NoC7o4B9Er7SPAMnx+M7GK1OyYVbPe59eREk4sglPXUEGw=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 02:16:54 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 02:16:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Topic: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Index: AQHYFuZsVN49lu1TCki88X55Ds7H8ax99cIA
Date:   Tue, 1 Feb 2022 02:16:54 +0000
Message-ID: <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
References: <2571706.1643663173@warthog.procyon.org.uk>
In-Reply-To: <2571706.1643663173@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087bd321-ce4b-4f67-7cc6-08d9e528ea77
x-ms-traffictypediagnostic: BLAPR10MB5074:EE_
x-microsoft-antispam-prvs: <BLAPR10MB507436B8682BCF596E8D3F3093269@BLAPR10MB5074.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YOpgGDl7rfOMoE18R50ZG13KBxWjW4OtbJHG/SNI/MMHkPoAvdnr/DuknAoOv7lLvo/UGLGEtKBh3UoesBa+l9Hu7d3dpnUY7Bul0h9elN8LyrUrgWxZ+qYAGC2gdJZ6a4Qk3dHHlw4r0rACji40efp5md1ClhM/wLa48XmiRgAV8Ic8Z90+RVQVismPW2587VJBHXLi2QCH2QCDsLA2nW419MzKKiaHoV56k7+N4OJ81VmImOUwiZ3zhY2/p/gtZqx/SeQroI3Sr2Raglol8ZWWiHByq/vusK1rVFJ3f6H1Lijo4B02Wj8OH9bTSXEpYiigjxdTENQQ4oaYfyALq94kXokLjHUjeiznLLMY5Mzuilh05oTd+ZlOG3yf+XeZ5n1thjBZoLBFBEd+ufCzKcroA6qKindfIWFjnHb8x4dnPDFSozgUjgGh17i/2uAJN9C9vdQ3rnb+uBL+HGkt0/tWCs8zp/tqlGsD7QtRragvynI14ZRFRydPcINruZRVa0wYG7EE97KWaTnmwlNcnyjBuklpYXa8NtOIthaXw/MlMJaTgOWh5sOrx2fIwX8xfMlPxReYYl/Of4gNLryr4Yd7L5ZtA/QtgkYVsvOaueDykrOYNCA1ESLEI3gbz59maR4xJgvsoZdk5dIMR42ChrR5FQBxq9e3VimH9dNIbyuHWBdaZQ8to3YpLl4Xw0ed9IyniqfBXha73QhXsejWM8xbudwLUjvgNaICjAroaPMObpSj6yX1vj96big7bmw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(8936002)(71200400001)(6512007)(186003)(26005)(66946007)(8676002)(6506007)(53546011)(2616005)(86362001)(83380400001)(33656002)(38070700005)(66476007)(66556008)(64756008)(66446008)(38100700002)(6916009)(6486002)(122000001)(5660300002)(54906003)(316002)(36756003)(4326008)(508600001)(2906002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lG2AhODwG6dakV2xM0QasqWUeVGHp2WavhHvHWUGHFTu6UQlopPVgejj9YyL?=
 =?us-ascii?Q?j8z6oGntiH4vVC3eZigFd+MGklJlgujWVLj5Sj7I+Mc8kvqddK88dY9RgE9K?=
 =?us-ascii?Q?cqAxornf/8jo3Fm0GQOJKw2Eqry7wJ80MFnXpMfigRbi7Gh+1+jIlgMoK+6q?=
 =?us-ascii?Q?0Gk0VyQXW1MoTZWBOU/PQT05jk5sxof0SrH2F3bkMvdCOLtoWEdQsRLVUuqb?=
 =?us-ascii?Q?8eWTC+Urb7k3qwyhQA6LwOmgTeEJfetPEzOqCvowguDLJFfZvhJHRWFzSkA5?=
 =?us-ascii?Q?Dw8e7wFJFN8jlhDdzOESgwKXAYbG06EUSu4BwGIddH+QQUrpIT88pLeLnfMO?=
 =?us-ascii?Q?tSU9jzNOHorEtqQv0l+tO4OmNSbfbcvkFL+PXKlLs2k6EUyRnNTzHa4vDngh?=
 =?us-ascii?Q?V0DBAq7T4rIWGYaWa7T/Uoc0gStaibvEAP5dewrhiiP4UDm7GelYOVKPbgGu?=
 =?us-ascii?Q?xZ+Q1W+SdESomy0EHDSLC2l3xOqeou8RIUX+H5nMl75XN1ttzBUtILOPvchK?=
 =?us-ascii?Q?+poIUPJ+V4P1KH3hRX2Bi9uRYbN8yO5k5wygRioOgi8ysrdax4Q7IIXxybAq?=
 =?us-ascii?Q?qjyziaiw8k1vfuwNfcuJy1mC3UCCnl5/+1w5nyF2lU3HPCdDfy33rrYKNaTW?=
 =?us-ascii?Q?MpV3fS9AzjP/85kLMgZFHY0di/7e6GvvP1dGLRUxGGzeqWJDlegJQfNPjDIL?=
 =?us-ascii?Q?aEUc6xMMSlkTa3Idnu2wpOnYBhvwLx7vSLW2J/CHX5DHoDMZqSSkp59wJacm?=
 =?us-ascii?Q?IMhRw4edMK4AyOKxOBg17ksELB62o2yMKkRJ84N9z7CJ0hDQWgm//vZud7Hk?=
 =?us-ascii?Q?/yPMKtHUIM//6r5bhXThJ5oj2OZl/e8jMnRR9cUYTKKVPlrtagu+YM07veo+?=
 =?us-ascii?Q?t/AxCasbAfhyNw7qPIh+JVZuc5gclIQu71Lnulc3WW88R73KdI2van+y/p3/?=
 =?us-ascii?Q?2zIUyjuQUZZpq6iPZr3XIrSrpo/DcS83SWg8Tl6fFv8NbVLQ6tZFr7j5QVNR?=
 =?us-ascii?Q?tf2Et4AmHGkXTsIlYVccfXEKXuZiquoDYvJ3jSm4s5M3brFvbO49n43RKhFi?=
 =?us-ascii?Q?NmTEg9RBsAgfj+mEtMroBmPKREi4zqxeYOfrJraExKxem9TD2S8ztr/ojaM8?=
 =?us-ascii?Q?rsnyl0Fb2H6va3tpEiCk6NHE+61kVc3eCDmjfqfGrnocDFJiIQycoFM3aDrM?=
 =?us-ascii?Q?xnJZQm5sPfzzRflQzENJALvi0mzOTJHYl2m88hoHGFuy+hXTo4LDi36s2xFI?=
 =?us-ascii?Q?iDs/DHMGPYY82Ygpd1QCN3kAEPzPV705Iwx5VUgprBJMuO0MMIWET1zmYX7p?=
 =?us-ascii?Q?zswSfErlDIqn/9FGTNWZG2AUT1l2Y64C/u9q57IcMAdU6vh5+BdXQ+jVY5qr?=
 =?us-ascii?Q?T45anH2J+iWkkjLGxvjm9lpmkyDBAgvsJoNreS7Seap4U8+8ac9+VeQGYNCI?=
 =?us-ascii?Q?ypt0JCBe45AR0hYucodlZsDfAF6ZhN5F4SCvNAl0/Ywh8QBkVCfQINcWmsRm?=
 =?us-ascii?Q?BbU81dOAgdcIISkEAufeZGTYDJoXU1KVMUmDPGyGYI7nmrTR2JUe3+9gPuel?=
 =?us-ascii?Q?oYKUwa1MgLlflcH7jCFNa/TIvBItjm9sHC7a/GLsFwNk69dcoWQyj6lvj/JK?=
 =?us-ascii?Q?wZtcCHNmfPVC9kgBSO2Qb0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E783DF11B6C8E349B5153293F62711F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087bd321-ce4b-4f67-7cc6-08d9e528ea77
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 02:16:54.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MixOYd3C+xb2yZ0jqPmQrGj1aFGpy0XSCUEfgF1jlMSLmYHcwtIlqM58cztg9NmXHPkmgv9t/sfnXZQ+p4CuxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010013
X-Proofpoint-GUID: 9sFGzuiMJgwNHTafJqrBaHSTYzqO57Nd
X-Proofpoint-ORIG-GUID: 9sFGzuiMJgwNHTafJqrBaHSTYzqO57Nd
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> I've been working on a library (in fs/netfs/) to provide network filesyst=
em
> support services, with help particularly from Jeff Layton.  The idea is t=
o
> move the common features of the VM interface, including request splitting=
,
> operation retrying, local caching, content encryption, bounce buffering a=
nd
> compression into one place so that various filesystems can share it.

IIUC this suite of functions is beneficial mainly to clients,
is that correct? I'd like to be clear about that, this is not
an objection to the topic.

I'm interested in discussing how folios might work for the
NFS _server_, perhaps as a separate or adjunct conversation.


> This also intersects with the folios topic as one of the reasons for this=
 now
> is to hide as much of the existence of folios/pages from the filesystem,
> instead giving it persistent iov iterators to describe the buffers availa=
ble
> to it.
>=20
> It could be useful to get various network filesystem maintainers together=
 to
> discuss it and how to do parts of it and how to roll it out into more
> filesystems if it suits them.  This might qualify more for a BoF session =
than
> a full FS track session.
>=20
> Further, discussion of designing a more effective cache backend could be
> useful.  I'm thinking along the lines of something that can store its dat=
a on
> a single file (or a raw blockdev) with indexing along the lines of what
> filesystem drivers such as openafs do.
>=20
> David
>=20

--
Chuck Lever



