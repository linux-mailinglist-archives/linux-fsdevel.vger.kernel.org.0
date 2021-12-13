Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304BF47341E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbhLMSgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:36:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237355AbhLMSf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:35:59 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDICu2l030314;
        Mon, 13 Dec 2021 18:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yJ0nGaR6WhpbRA6+ra4jNRlHqlz23EgWOFiMO8ZZZ1o=;
 b=Yf4zLy37yRspfmEKLFnnTzRRTQvZlyluCalb44QJXm9ULRHBZoUtPL12Pb91+4RDlAL6
 WtEct4w0FZS5mls6chTigGo27mdLklzvxUwVj6dSfnA9rRcZPCWxLqQiqTGlfUvKUiYJ
 sLvm86G2nKEVH/YVTC8dejgWvweZbDuqhZcwZcsBS9A/YXp+rJ7K7GUClGouhdxiZlYZ
 XFgDkkkzV0dAruJoc9dr77G3e6g9NLZMHGtPvo8DC0teSKqJ+iZWQsvhUAYzvSnYx7+l
 jFhmHkMGd0TaeDlZQripvudvmS2st2TWRb7SVPV0gPEMjsaepc66eDXnhaNVCGeg3XRB 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py1f5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 18:35:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIKQIo125719;
        Mon, 13 Dec 2021 18:35:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3cvkt3bj1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 18:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVKB8WnIfLmPLwsnhOsYx6YWg0GavLivm1CNdj4spdAyePzY576hRVIiuoLqFJP3JY+zH9YxWlOxnNdKTe+myqXC+1P5/YStNibRL4uMyWSDPrVmGV2dCK4gG6cb+8ehIKrj4FulrKnUrWpG9zt91MkkTpgn3vbDiu9yE+JD8GlfAJpOb+zl7b4P134D+UFcUGxgHC988TRKB/zAHKzXhBelTddijh7OLd0qz3Yxgri9Hjofd/mOh4vd5chnLG4JhyENjuRAbwq2+tTTj2jBMyDPinc7K1pSjpJHMKqz96CgRlnCogDPpXu8hnDcukp6/FqdBBjkRG8cwPKN0yqxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ0nGaR6WhpbRA6+ra4jNRlHqlz23EgWOFiMO8ZZZ1o=;
 b=mnG5ie1ZuQG/rgZge/z+CJiYY2Bzc3EP0+RWs2IBtj1gSwYSx2L0kIn69UHUJy+rIIB9Uqdr8uH5jyqwCj7XuZmGOSfHpnU8NdsWr9CgmOy/DVIyuu3NWIIvWrPaMPZ1r0YEMotMCvymfHjJOvBrHk6/4jrigo9eI+KzsRcBZe9rv/RfJWq39IGx3lpkFwvPlG3AIhY6up8AOuqk0LHtJuOvZzH/Z5WWZ4gt8X34p6uuig4AEPdWhtdwdUyoMtt7U4uddw7xixQmMjhcwudVjpGyY+4XElwTouRIjXo7Xp6aYAEphfbQx3IhOwfRhsLFe5zaPXsfypSy6rWB8kyJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ0nGaR6WhpbRA6+ra4jNRlHqlz23EgWOFiMO8ZZZ1o=;
 b=aVKX17esNGF5kI9hQeZqcIr46D5mKGPvtwRJSGmqoRK/V28rYaFrLNxaVR/rLE3MPZFUMbCQXqyePHggb6G6xlINmlZ3OBx550+BMEeCk9ucfaoj38fxfgxF67ilD5JjhVe4Wl2hDY0sKV1r/VpQPeg9/49Oj5WoBrZR8zxD2tg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 18:35:52 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 18:35:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v8 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v8 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX8EZJHj0hKhxnn0Wn9O1TkXYf1Kwwv/WA
Date:   Mon, 13 Dec 2021 18:35:52 +0000
Message-ID: <B0F380E2-3F48-40E8-B845-823E0A148FFD@oracle.com>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
In-Reply-To: <20211213172423.49021-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d4b840f-fa74-4b0d-3872-08d9be67646b
x-ms-traffictypediagnostic: CH0PR10MB4921:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4921C7858090991D47AF2EFD93749@CH0PR10MB4921.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0NFIeJ4LXhfel0BIeZZ5GosGWQDuDQMAmPIvoMVg2FazYMj8/xYm3brgexxLkB86TK/rd+xpjlxGfAadRkjgfJi0V6n+t073gUozUAA7I9NnoplVLJ2MQieYSd6g1x97YN/Ol0L7ChkAAqhTp9x8MBrjYpi+rkr0WCufqSr1SV0djAbbejryGwCuYNs7XH+ScJxSOMU22yTsdTB2//iH9G/2eu91dLj2AIr596eEz1lSCvV0oITk3x42gYkvnDKFwYTvb78eU/QZq65HYSKsj5NRPUtODUoE/PqpedMv3ls4GgMy6us66reAgyOQKZw4KmXzf680o5BwEZMr0XUAi7cRBu1Tnb307ewARKPzl0XP5E7oTCRD9wAQpi/mwI0tthvUpFg1eqt3oSiZXaqVgB0QOyywVk/kQPiEEH6yynwTJYVJrp4wJ3WSzCePjaNOQnJnDTp7cajTAcJQyJ5aYbmZgPKgv0aArP5qt/uD/tejWV3bgwBpLYWvn6ssD8VvqE0pNz5/1f1PcDKKzCs8LAEAe5CibJClhsQkS+h/WI9TWVCxc/GW21lIuZewS9LDZUUADwwB93W/PadLuBaBiXjpMIa+UfXonhG2aNx6EvoyqFKnJpIVD5G8tAz2Xb8nY1EDzcQgHs3mlJAS3B3bEK0X2CRijj9nC0D7CF8p6CYTCNOHqD1v4Z8kOy/LxPlAwVz8mkVOgpY8wYN0PVdt04KB4fxHkX6Cfj5E0OZiYxRIYHLHbQiquwjA27sbbjNp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6512007)(5660300002)(122000001)(83380400001)(64756008)(66476007)(66556008)(66946007)(38100700002)(76116006)(38070700005)(186003)(2906002)(66446008)(8936002)(33656002)(26005)(2616005)(6486002)(6636002)(54906003)(6506007)(8676002)(36756003)(53546011)(4326008)(71200400001)(6862004)(37006003)(86362001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nH/VYc3fg8q+Ir9mynxhNVAtOyk1hHoY5z1kldUow2lutV3sHJNMeM5hBu4a?=
 =?us-ascii?Q?8o4eUS1Fz6Gu6z4/xxidREhrWOfiXgl88WxteIgE8XrF51cf5gbDsJwzU/7n?=
 =?us-ascii?Q?Rv1f9kZPPdSWi8q8bnPqDsCFqaKYrw1etuyNsEKvvh5etXgMcjC6xjx4bCI2?=
 =?us-ascii?Q?wYAojtMyfq8JfFhQ1Yzt3ezlgqAGGlNMy/t/J+CUsZ3W2GnlcfGwHWb3vqTd?=
 =?us-ascii?Q?fKDleI+knbCCLiAuRbAjvI8o/rQxAR1l2IqeZ+bN28gPvluUvGX0rpuxpxui?=
 =?us-ascii?Q?JuCPYCZCMDdr/mcWr67m3zvK7ifFNDrSlUl1PKiDlCruI/BRz3BXPVmLczKB?=
 =?us-ascii?Q?3ssFlWHorrh3dJVhOF4QAwvpNhOExzRKPvoXpWkVf1ab7TeTmfVhNy0v1hIR?=
 =?us-ascii?Q?MifRlEuvQwiUbvr7I8b6LVdcHT8OSakB6uWRR9dRUSdBNnF0RtPAgZAjB+Ij?=
 =?us-ascii?Q?nDD94PtTIokFekMlX95mU7kyiN76eEpQVjvBzP7Gey9X0Zr4XUMpXbeIGSB2?=
 =?us-ascii?Q?arVVndHMOfkE2HOFy987O/aFbk3UONitc4QQzgYNJy0YllIWroT9Khy+/T03?=
 =?us-ascii?Q?C/iIfr9xnEPDCNWI2T7/Oklj/2xTBuFYjUUwwS92r0uFn+iRndcurMTIo6Mb?=
 =?us-ascii?Q?pZbrqiV6C+whw6zJShNsmxOlI4LU85f/5f6spKT6KhkoOt1U9FTKm5qwH/Rn?=
 =?us-ascii?Q?cJvFLjouINHILoOy0MyFO7khfk3qCc+T/Lyp2JEPxhgElLHdFUgx/7I5B2gx?=
 =?us-ascii?Q?r1bfKB8SockjBbP00C612KBgccLxteqFTTz5kEnzGDiyKbbMfke7mHY+8dlW?=
 =?us-ascii?Q?pbaAi0Bk1gnEouBLYiDZbTEWKcve8OA+hTP7tyBMUTvFqcZ/G6rOJD9OOnw4?=
 =?us-ascii?Q?6OrnLDIvBjTeRRi78m/5c6vMtcSnOrTvMhzj2bUi/6jzm3le744m8BESSXxf?=
 =?us-ascii?Q?lwWRmpqT7XhZaygbLhUDb0R+G4m5EmIMXWglDBrk9Fu2LGTF9omGyDoiZKJn?=
 =?us-ascii?Q?7RisgZXoW0W1aU89qQkh4RfvB6vB4Xt0kW/rDbjh/fdkYRWu/dpdhGuQ32dT?=
 =?us-ascii?Q?yjBycf8kSePbXIlUoMlASks4f7VLnjUu0l7U6bQTkydaMdlYsikeDW0xelg6?=
 =?us-ascii?Q?PPEucx5d+veecmY3hN4aTiY+24Zy+xC0ikpcvKEamLQ9/5KrxWadFLRhj0g2?=
 =?us-ascii?Q?yeUkteW6VXgfcYJPm371GDEvIM5XKAXg9w2iqHt5QIlP27elNmEB5P0/FhGG?=
 =?us-ascii?Q?tWeG/DaJXrKeTNyx/iEVgr19aB5w27IL3K1lD2PFVoJqc3KbCIebFnHqENma?=
 =?us-ascii?Q?/CRo8RTYyj3iuCn1DSX7s+lIeruJy/mF1LhaXTUqBkv2n3xmnQHnWQY3UFXH?=
 =?us-ascii?Q?KVIS8CAKJLzZOKLxRsWeDJgt2ZMU/NnZW7egjB44AdxXL+PTF11BKC/M1VYJ?=
 =?us-ascii?Q?w2Nckt4aostTGC6FXSJSU3DnoGLNO38Y2+m9HQZic0ohp2gPMIZBib51r6zR?=
 =?us-ascii?Q?868sZfg45ZAk/VdWe2jCI93Amfa7pIoesIUN2uAyJS+IbWViE7drZJMykz99?=
 =?us-ascii?Q?kahlXmVkiV4lpMxh0KMY+c8Mr95cqBPcRT+LYgzDF6bweJcYOLVvwSf7AMG6?=
 =?us-ascii?Q?+uO0tcupJhKMcUGGTRfM1Bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F23C417B6E1FC40BA64C85D78C10415@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b840f-fa74-4b0d-3872-08d9be67646b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 18:35:52.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1R5/n2e3tCA3V+7KTP4TSMTyUPoPGJ7juPJBjoJNdu5FmLX9tj+JVpKPvpbMrH+NATd/bU9CBY8LEx4gek1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=928 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130114
X-Proofpoint-ORIG-GUID: KgiFaYOwivoicxhrbHC8A5aZW8dz8f0D
X-Proofpoint-GUID: KgiFaYOwivoicxhrbHC8A5aZW8dz8f0D
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> Hi Bruce,
>=20
> This series of patches implement the NFSv4 Courteous Server.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> The v2 patch includes the following:
>=20
> . add new callback, lm_expire_lock, to lock_manager_operations to
>  allow the lock manager to take appropriate action with conflict lock.
>=20
> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>=20
> . expire courtesy client after 24hr if client has not reconnected.
>=20
> . do not allow expired client to become courtesy client if there are
>  waiters for client's locks.
>=20
> . modify client_info_show to show courtesy client and seconds from
>  last renew.
>=20
> . fix a problem with NFSv4.1 server where the it keeps returning
>  SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>  the courtesy client re-connects, causing the client to keep sending
>  BCTS requests to server.
>=20
> The v3 patch includes the following:
>=20
> . modified posix_test_lock to check and resolve conflict locks
>  to handle NLM TEST and NFSv4 LOCKT requests.
>=20
> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>=20
> The v4 patch includes:
>=20
> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_loc=
k
>  by asking the laudromat thread to destroy the courtesy client.
>=20
> . handle NFSv4 share reservation conflicts with courtesy client. This
>  includes conflicts between access mode and deny mode and vice versa.
>=20
> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>=20
> The v5 patch includes:
>=20
> . fix recursive locking of file_rwsem from posix_lock_file.=20
>=20
> . retest with LOCKDEP enabled.
>=20
> The v6 patch includes:
>=20
> . merge witn 5.15-rc7
>=20
> . fix a bug in nfs4_check_deny_bmap that did not check for matched
>  nfs4_file before checking for access/deny conflict. This bug causes
>  pynfs OPEN18 to fail since the server taking too long to release
>  lots of un-conflict clients' state.
>=20
> . enhance share reservation conflict handler to handle case where
>  a large number of conflict courtesy clients need to be expired.
>  The 1st 100 clients are expired synchronously and the rest are
>  expired in the background by the laundromat and NFS4ERR_DELAY
>  is returned to the NFS client. This is needed to prevent the
>  NFS client from timing out waiting got the reply.
>=20
> The v7 patch includes:
>=20
> . Fix race condition in posix_test_lock and posix_lock_inode after
>  dropping spinlock.
>=20
> . Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
>  callback
>=20
> . Always resolve share reservation conflicts asynchrously.
>=20
> . Fix bug in nfs4_laundromat where spinlock is not used when
>  scanning cl_ownerstr_hashtbl.
>=20
> . Fix bug in nfs4_laundromat where idr_get_next was called
>  with incorrect 'id'.=20
>=20
> . Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
>=20
> The v8 patch includes:
>=20
> . Fix warning in nfsd4_fl_expire_lock reported by test robot.

These patches are also available in the nfsd-courteous-server topic
branch of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git.


--
Chuck Lever



