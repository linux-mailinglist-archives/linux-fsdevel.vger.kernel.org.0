Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA6489FC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiAJTDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 14:03:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46456 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242977AbiAJTDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:03:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AIx30h022359;
        Mon, 10 Jan 2022 19:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uEV+1g973hNxCWuUnd3zuKaTjZRwGoqarqr95ismvOc=;
 b=fMnIfpY2CUcdXxAFKJ0VC2KwVDKKV2sCz0FhEULCTt5/DXMf/tjwSpqZV0pkoJL07ovg
 USvcvGzIw9TwIVYMcJq/ug1aM0d6lqM1l/XS2TVGi/vntLXGOC2s0mq6xkIjtCpL5REw
 OJUaB3qjQIWcdpvA6jqIIjeemz5R+Fkjnl7Jn43Ig8mi6bUDsVcAG/IdUJla9BAmWnBi
 SWy/u1IgdB8XR0B1UYFf+Nlxsxh18f8LHf56hVQ8vBmnRaJHoeCNCQXXAGgPoGtv9R9X
 CVz1+CUQt8Dk3xclgfNn6z5br5NBUmHFf+IHutFDgD65xcvsKCqwB3RneM9Fc3NjOMhF OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7ngvgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:03:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJ1vXr107114;
        Mon, 10 Jan 2022 19:03:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3020.oracle.com with ESMTP id 3df2e3penk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1oDb0cGhsrAYq21zRB4KQmHEffMjGC0Uc6S8PC0IMDL9EHI6fU8z9wqBRkykuWrZk6BmgE6Qr0Jk7xckblss4TKS2+b/AwZ72V5FH8Kqt7mCkoiM/QyCliRlSWmTuNNht97yz6pj0lEtb2qlIahG2bipdpeT4chpmSe0fjlp4rafoaCKhoxsEU8wVZ+Q7d1ar5bNwrthKPUf4Cdz2Ok7RPEmhm1KjuBY50g8VMp/QGqBAWIZqg+rlVdLySGpLhMJFIi3wJDoqozAzrIEQRkhMjKO2U3UlhqSRdjfmfJEsmSJ3vJGCo9U0POripfmN9ck9I0Ty5GPV+RTiuGoTBF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEV+1g973hNxCWuUnd3zuKaTjZRwGoqarqr95ismvOc=;
 b=JFxfMMNsHHijzheIrOS8Wm2bULNOupGZmMkiObtHCGGxWxwU5bAQQ5Iz6EVyCiUsQEHN9Eio7mEqqyTvP4AN/qMhTmnOByt2fmTyfy92KqBPbS80L4NAUoqdjTTycxAc67ottqb4xXqXtQ+o5Jgyf6eeRR7PYhsSA/h94H5J1bRVsYYrnBnGH1+58hXWwD4+FAAeh7NzPyvTJulZ2/eYQbqSKXyQa3ECvh05F3MVqWV7qK/YlmrPDPvICXZmeSe636LsTb45rqKvutqMXDRzruqMtBd9dLNOuphT7N98J0/A73w3cTnEiPwDPVmnzrkNT97D3xgRMq41z+UPsJAsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEV+1g973hNxCWuUnd3zuKaTjZRwGoqarqr95ismvOc=;
 b=dsrqqdfsddfdjB0oqy0cCLdFyXtePOdWyld9gK1ocOXUwTZBMX/RlaAIuzYIN5kAAI36rePiPBm0t44KViNGv3+mGQXtwaRn9oczYCTDX4QW/0mS5ndqjBEvXxadEQo+5wIyxHphzm381hkk5jkbrht8Sbj2UxvYe5jgAjd9aM4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 19:03:31 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:03:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYBlMKp8f3bH7OUEOopwJba5Y126xcnNwA
Date:   Mon, 10 Jan 2022 19:03:31 +0000
Message-ID: <ABFBE8DE-36FD-431C-8C5D-4D31EA0A16B2@oracle.com>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eae0a68-9340-4b68-dcdb-08d9d46be4c2
x-ms-traffictypediagnostic: CH2PR10MB3957:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3957359FBCA5F16F5B7A181593509@CH2PR10MB3957.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDQz7s6ooalXzGk1cn58QhgRiD94Up4jFPyGMUErmpTEYXZub9gB+ZrikhcFNDpVwxGdvIOGax/BmtBwKw9LvIZpavI5CLM0v9vReL2viZsbKcyh6kYpspvkTwcHRlTBDcQ6dPbLknnaUkuOaGohVLoDDUBW0Sl0sDw80CG07KUdgK6AfEdT2fsZHxsnBFJG2t66rHqH2B3OKQHI3mT/Zax0e2/Q2yq1Zsnr5EzKEmH/cQKlAfHTdG6XX9XReEwjjKsf8Iw1XLhErLYv6y9AxRJ38pG67Z7vCuqDFPJUmsm/IyOniQjpy4EsTneE0kxrjxdBD3ALst9S/HaIv7swNgX3aZcdMQ7Ykj/XJQr/EwLCNXbfwl+3FNLf9a94ojbMOBpu0SyEC5K3qkJD8+sqri0eZ2CEexFmF3IBoVaUfmsaWu8Wo/3xrG75eZgQQjczyl5O1sL8ig2394ul+VZtDXdnxePwXxf15GM4aZ8jaLMZL7xQtTKcfUxBRht8vpQawgBEtr9iyhXMQw+RPykPkVuw3B4KRiI76lt4hJnwHAz4xhG+wW6sOnYKF+W2gLa0pLBqSCpFxCRY1HFNxghW0I7M20UHow1ARp3Gcdy2eJZd3r7U1y4QAmERzJviP/2LW+iMQeKlazwi6PkOCPEYTEV+ochryFUTHpdbX/ulkaDo0+xOwU1QfhQu86iv7gd1PsiLRrHWaGImrcM3RT9hxjbHFkSoQnb+3XHSQMv2qBnwHC5iRMIviCx0a4b31ZCc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66446008)(66556008)(64756008)(2616005)(33656002)(36756003)(6486002)(76116006)(66476007)(37006003)(83380400001)(66946007)(4326008)(6506007)(508600001)(6862004)(53546011)(26005)(6636002)(122000001)(2906002)(8936002)(54906003)(8676002)(38100700002)(186003)(6512007)(71200400001)(86362001)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7GlHpIF0n6/psBPakNeMyRV/YqMTpYsAYuUDyE21r2LCyiCY5dKJYahzvHmE?=
 =?us-ascii?Q?fHOb0nYq2Eloqj5Poz/xJmteWEhaungYZYBpeRbncLGakgOtULeZwmHWPPsm?=
 =?us-ascii?Q?/Cp8df9FMwzUtfTfwxsJs2aWr3XZEmjwLlizWDqI2FOonFi2p5/JmCqupzgf?=
 =?us-ascii?Q?bff6m5IFHrL3hVyGCfUCgMHRTpcC9EDXPTHhl+Zc9C060V6i0Ie70RPZP0WY?=
 =?us-ascii?Q?uYNGdtG2ausR2OvDwK68Rwh625agj6HhJFkXp3paZr38UpcbCD0ZNs0xeR7p?=
 =?us-ascii?Q?z97oAYSStFZ31i9Lbh80fcY6ml/cYTHezJvtvkFKEvvlUz9YqADwST3TNzgd?=
 =?us-ascii?Q?HOJXbEowAqJsWrM61clKPVNbLdcyo0IsiyXUZ53sWQGVM6IozgxZWemMleZJ?=
 =?us-ascii?Q?T4oAQVOVnQvTcmV01/yeNC5XVWdNTsz0XdmrgWYKZJ+/9xSBOqf4zRYJlQJl?=
 =?us-ascii?Q?9zLKVbfsF6pVryyfw3AhLvwQcZghO39TI6izdxY57Sp7lz0OqHuIrysEZXll?=
 =?us-ascii?Q?9zB86eDZqF60KNzz05ttkqHxgK9rYZhLl9uSVVugED8H5MitW0kQtdClsC+t?=
 =?us-ascii?Q?lYFyNU+SHBuk/418AC3vp2Qc7zZess3VGRBQkKuzH+l1C+JjxLnf84S6BtXk?=
 =?us-ascii?Q?3PIaX/RNw/K8FemgY3M6kY6PlxBYx9gVsEipoyFAnrVHBtpb5IPA/8ApwLAE?=
 =?us-ascii?Q?gQG4NGXYAG5hp5htmx7+QlWQo4lwcYudM9Hj6gcT1xY6OLl7Gmg+CDR5KSuN?=
 =?us-ascii?Q?qoK8LS8Jx/ydOVqnH2QcfdxljJitzy9f5sS8FLGfYy2TlMCv3t6VLLYH2rFM?=
 =?us-ascii?Q?CKPxjH256c28wImCOcB9/qBnmqEI1dz5hXNhHQcxmkkdtsd2Z3Y4TY3zdetZ?=
 =?us-ascii?Q?I4LNtaAr8lm73zlDiIYwP0/lfGjW+DnLy/ZiVzdmFNebrLE3uyA3FmD4KU0X?=
 =?us-ascii?Q?v1EEiXmiCzBDtjXL+GWV2Y5tk+oi3QR7r+tnlfH28DQBvFhupsHVANMhQTpo?=
 =?us-ascii?Q?vgx/aNLm0W3BnehCPODkYoF9jDbeZYXz9palAa3PPUcrHHkdAfV4VTunpEYE?=
 =?us-ascii?Q?robdaqYw//xxnO+bAC7AAAr1A3AUQWG0tuWzm4TPlE1fd7PwNiy5Z7wr9+bq?=
 =?us-ascii?Q?osoUTFNvOdrtXolWADl2ka895JHj8caaA/zzKc6dtiVnEx/ulebeNwW6vg1v?=
 =?us-ascii?Q?rA3mLutejTbdZAhkW2Za451bhi0MmMKjZQ+WfLWT9Z1S1AtAC0Rf5WhZ0Tah?=
 =?us-ascii?Q?6Redqvp62u8zjWvLnreG4ukXL1bp/7U7Fn1gDHYY2NB4SDK1QcvNB0VIVx0x?=
 =?us-ascii?Q?ku9U4OZNsyWvcEUL6BSAOKWwDJDUKp0x4xn7V2Gx7Co04qt+DXUPlMdStJik?=
 =?us-ascii?Q?M0fabcA+Gwg7WlOo3ChXkmQ39hM0qmHF7JPQXGw1ST9cu/3iZCKlbf2+L8J1?=
 =?us-ascii?Q?vpVSrOKNiN6OjqXHmFd+8XR5v9mBlp4OL7Z47BfofZTmr0WQ90A3ueBXAXU/?=
 =?us-ascii?Q?OT6cwBcfVXuJdguvZhPKEWNmJNRrLU+80rVhNTqib+Jv0H0I1r6kkZ8o4ltC?=
 =?us-ascii?Q?990+SFRPnYD473MJ8Mwb1pbDjlxR18IXm0tBSoMlaw0a9BsoNG/oVTvOJyl4?=
 =?us-ascii?Q?GUCS2PVTz3aVmLH2DNphgaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <239FDB7A8FDDCE4E9DBBCE775DBC71FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eae0a68-9340-4b68-dcdb-08d9d46be4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 19:03:31.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKOT2eHuztsephdYY47i9X4utKNTfWYzbu+iAUfNkWZths52X2jg5lDX+7CYy5fMNlDGf6UKp8kr6uUQWYc3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100130
X-Proofpoint-GUID: B5u89WZ3To_PodIVSuRFCYrbzaWU40hK
X-Proofpoint-ORIG-GUID: B5u89WZ3To_PodIVSuRFCYrbzaWU40hK
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 10, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Bruce, Chuck
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
>=20
> The V9 patch include:
>=20
> . Simplify lm_expire_lock API by (1) remove the 'testonly' flag
>  and (2) specifying return value as true/false to indicate
>  whether conflict was succesfully resolved.
>=20
> . Rework nfsd4_fl_expire_lock to mark client with
>  NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
>  the client in the background.
>=20
> . Add a spinlock in nfs4_client to synchronize access to the
>  NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
>  handle race conditions when resolving lock and share reservation
>  conflict.
>=20
> . Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
>  are now consisdered 'dead', waiting for the laundromat to expire
>  it. This client is no longer allowed to use its states if it
>  re-connects before the laundromat finishes expiring the client.
>=20
>  For v4.1 client, the detection is done in the processing of the
>  SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
>  to re-establish new clientid and session.
>  For v4.0 client, the detection is done in the processing of the
>  RENEW and state-related ops and return NFS4ERR_EXPIRE to force
>  the client to re-establish new clientid.

I've made v9 available for testing and review in the nfsd-courteous-server
topic branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


--
Chuck Lever



