Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915B4A8C73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbiBCTbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:31:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37086 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbiBCTbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:31:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTcE6023360;
        Thu, 3 Feb 2022 19:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wMYSNct5jBUNAORYOisqu2HriAvCeHpOaxKNC3uAXS4=;
 b=oIoXKJ1xe/DasLfiERvRUMZ9RHOZlRMB/+iL3rHHm7BZbmz4Xl6gBI/XiB7AjVqYwRzr
 o0vXcPjgA5tCey+aatm9nK0Rtntswr2iXZEQMhUy++YS29chwct3tm2pTn0QwBcro0Bc
 GtmlVyfObGDaV7AvWiaYk4Hf+h01YKUX5cQf/ogBjd7qzoyTi1xNGzastURIY3G3EMkq
 bhU2a/iUktde8CiFN2Kkak6EXD24h/p3c+1p7absq66mpNJsd13lRS9b/hhoQRKP4HG0
 P7qUPY5JtPt32qX13LjIjLIZozUxhlCT7+4VV6sGPNe0R8EN4R0vN4hNFuCfDMA0cljQ Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hjr0q6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:31:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213JLXq0127865;
        Thu, 3 Feb 2022 19:31:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 3dvwdb11ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 19:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJmeSM0nqE/GlpZBBVP1F39nH965XdjtVwS6CL9DaWIdVxjI76s9QMYeYduPXSjzIuaVDJcQJ3JGe5Ypr2SCvtaJWvL4IqpRDaXET0569gzZk5H5uwVmRnzwSq0N3LpbgJBy6oasnzQUxmuW3u6QSct13+fVNFoA4MsxoBWsX/JACbl5CTsRG2f7D5o7cfWwtVcNSd1XqvelJsiZCo0z3NMlcd2JLrTyT6gG18YNbb0KY10b3WcMl+xb4AHeEdTivJZueaLiJuoLp0mMIeB37NeDtmqt58KFlzYpMCIy/z1w0YVbVnB2IZBK0FdXQ0y3J8USzdu64KQ5rparLcJoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMYSNct5jBUNAORYOisqu2HriAvCeHpOaxKNC3uAXS4=;
 b=Hq0/+HrrGX3CTWNW51FP+xcj04Tc1fVV2FHuNEg8/VdiqzgWjoeNGi9ZLwIBK7QnTxVP/ZRWKNJKy0QrCPDECJbzL72auk4I85R6l2sPS7RnlC9IYKlZarS08vwwEJL7ea/E47wDKa2Edn2SXarMnHIZnF0TKsLWTmEXGsEsOUGuLIs+5BlBBsJ++HPLpug8bxwXwDqbLmHSLeZN+IdBo+VGbhWOzaMsk0WtndSw2aembepdrG2rxnB4xrBxhmqvo0SVg26YK3ldKrY+SmT9z/NZEqXFklI+okxk2+8n/CoMbjvIjrWGTYd8vuDjbyqVM8eFb1aSlK4+HKwsyt+SbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMYSNct5jBUNAORYOisqu2HriAvCeHpOaxKNC3uAXS4=;
 b=VU3HdIU1z5dpFYgmMjPyxVbm72/JRswUUx0kxFmKOah96l1eapZ/gnp9yRFhE4hzezQ0RX2ygUhfJsEniqtIMLHnIFoUu+tpII73JrlTGoJFPg2LOFXWlDNSK9xtLudvcnmnj19pEP8EwTV3vfiIcHhV5AWpiPPSLq+vkyiZ9Ws=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN8PR10MB3617.namprd10.prod.outlook.com (2603:10b6:408:ba::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 19:31:01 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 19:31:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHYFH7X1sEKJuZpaUeYDd9pPdXaRKyCQCmA
Date:   Thu, 3 Feb 2022 19:31:01 +0000
Message-ID: <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f5214b-0e40-4b08-42fb-08d9e74bb650
x-ms-traffictypediagnostic: BN8PR10MB3617:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3617E546C16618536DE6228493289@BN8PR10MB3617.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6+jZJtS6J3S8yqDhU9AXgtaIuCW5nc9uk9fsRpIQfIC0fdw0v/nflqjKn1KrA2nvuRftF/+bbUYNMRMq/QZv8AQy5wAdU4VoI+wrFszO62hcuSvKTTXH0cvOf5QpwdALgE3J9xeeVLXNLjR7yFMVn2L7s6IISG6PvvtyzD61oqJ3Jfa/RsBoJlK0QXOKKaS/S6qkdQx5kuT3FXfMki7BrVfk0HLg+9mVlm3A43fKJ3oFA3d8YLH5QcDPVvyBH0AKF97pYqJYB/w9Wl94D/t0xvtF6FUMlV7zM956s/X+6JHSgQQoRw90Byl9OmKVw9nzrodBSMnx/9dGZa45hlQIa4krlFEC/HKuJJZ0nuOOey+iBEmJv1j2Wbmj4K+SqTkQtmAJ0HkW98gVc9ckK+lLwSP6++9u5WKOLZPue0s4fn0W/2x3tNhboM22hgfgh6wl7gtTNxqF5vV05Y3GtmIkLxkaxkhPaRVW5nmM+fSwONFf+vS3qGgnuKOmgPdEwGSckl5IAFiAoplwAU8jJX/XMnw73/Z0i5FIMy6u+BqA2hkEWfUiM4H4II5wTfB/hyoCe1tkQTrxrDInDLJETyREGJ8NsQAqMMv04kT3PtNWECTbAjxhMg5uXvGJFBEnHRQ2T0qh3E2c9qwiHJnx2pU5FxsCZAYiIvtAsWD9mIZL1TNUSblLkJDMgdVCYv2LY2ZpqTCkii8lA8sW/MO8KxCk7Vp0yFXcRqYnAvdYCPLH0sA/rm1COAkCqMV9XbC9nS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(36756003)(37006003)(83380400001)(6636002)(2906002)(316002)(26005)(122000001)(54906003)(6512007)(2616005)(186003)(86362001)(6862004)(8676002)(66476007)(66946007)(38070700005)(30864003)(66446008)(5660300002)(33656002)(76116006)(8936002)(508600001)(6486002)(38100700002)(71200400001)(53546011)(66556008)(4326008)(64756008)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HF5whXRVjeCwgfS/T32+EsmmJYhZMtiZ1A71hP9oS/5759AhuaczWuWLa09/?=
 =?us-ascii?Q?m/IRhs+NxXkCbyv3IGdX+7eALq5pU33Myl47R3QumRxaiuv5YXFvjLtoxiaL?=
 =?us-ascii?Q?7DnH9Z2QAV2buFFVkM2sxMWGsZXc/qLHqgQKPVTaslsqypkl7xoFH+ygSpCg?=
 =?us-ascii?Q?xM2LWYaWl+vGyYEUy3TkQVa5GlrvsNvqV6Mgzn+JjObQQek2Wa7JnIMU6yiO?=
 =?us-ascii?Q?2n7/Wne4AWSqk8mezXz/oYlRMJADf0O993t034pBsqHkRnMRA1a9Rmr15kfK?=
 =?us-ascii?Q?vlTYp/XjPZgt57rQR23RTiiLZbTQH4HAZudFJckZAAXUW2jf+i+O6SNrFwyJ?=
 =?us-ascii?Q?KgqOfuDrWcnYLsgs93Bcfll+aVttE4tol4F1Lubnm/sMHAkoiN++T4gqRc1K?=
 =?us-ascii?Q?A/3pysnvIs5/ux5E4l3NT5Xn2QI7VwAyEuBVpUjVbIVF5GD81z5I3B7S5hpS?=
 =?us-ascii?Q?S5u1xuDNZii0PngkbR/XALSf9+W57L4whAXZ6a4qXIAWbPKbJBQKeZSsinyf?=
 =?us-ascii?Q?yaOnHpjD8RTM/8voxqp8rirqKoxbDvHBEDmQ6X5Xo8ER5YLg8fPW2YFlwrSv?=
 =?us-ascii?Q?V8Gb4sbxrcjFLlo9HLE3y9pAExoV1Ae9PjfzMRw34RzWDI21h6WMLS/l3rII?=
 =?us-ascii?Q?y+PaGhrwVvgRB/h9XKnzqoevzzdKc91ntjOaEph5yzDS/PBFi+nfhJik1lxF?=
 =?us-ascii?Q?/3nJ5lVum+inJq02IkXs7n+Kn2rO4fgyl4DuXKYAK90Y+7bMIjqOUrEOeg1W?=
 =?us-ascii?Q?mOEQ08qvyOpZiOqotyVR+JkjWgHbFJ9XXvu/nZCqKkpT0tSohFKND13oFLhK?=
 =?us-ascii?Q?TVkOOo8Qa0DLsWkz5Z86+/+lqC+giNQLsxm8+YngTeR8RgapEeQDlZvszt2b?=
 =?us-ascii?Q?tOE7ZiLv5gh66g5KpLxMRP7oDTgscsWqBzLgHHziRDeVHKXrIh9+itKz4jxm?=
 =?us-ascii?Q?aC0533M64xrpT2jExkHdw/NcCevlrZeWkIRTQ70AW96W2mQxaN/3W47WH00L?=
 =?us-ascii?Q?8wtuOIt1fwDPg/frPi40753QrERVbBaXESqNVw+CEFZ5aUQGsufI2u927atY?=
 =?us-ascii?Q?/bJ76AaTNSAkvOwai/+wojvNyK6LN27kWuTEuLhdlZv7Ytw/fZA6PdEmllel?=
 =?us-ascii?Q?qF+Edk0MCI6Lswe/c/JXJaScfdbFQO42+10uJAOO81x8EjmijPnbFidVeu7A?=
 =?us-ascii?Q?Mf987ZGktsFIxw9tYGgcqVT/D7oOY+6N+cCuqBNDxRApxvB0GsHPdHSBJxd+?=
 =?us-ascii?Q?wSd+gHCf0HEaptkoV1+t6SzbL5qsyPdnfHNRM1U3EpN9fyFU5K9ewIfI5yme?=
 =?us-ascii?Q?0iLy52UCylpUUsaq4fjLmqN/efItDia5/ZYgpcs6FlsRtkT/SlLJjcywy/3G?=
 =?us-ascii?Q?SW3L4gmCbQvHyDbjeiaRC4/2N2VvH1C9O+Tcq+GHdhzFeqHFZPyQgJDQmc5/?=
 =?us-ascii?Q?fFWa7QnKShWMDcbs3qdFqeySlb+IRunoKX7UtjVEQQoYHMt3/jHULdJgg4Bp?=
 =?us-ascii?Q?j9cKwd2EAWKitqVMoEY9drbZOp0nJz+zkMHbUOHGFcL2qtLdAKtPyJeGBeJF?=
 =?us-ascii?Q?QTGlHcvjZY467VkOZ7VrbYpnbepyCfkzlxDjBUL/T0u31dRn9zxAHIGOQkLm?=
 =?us-ascii?Q?+kt7MHZlxT0apeIhil90WEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F714A93645A565439345B4ED43943258@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f5214b-0e40-4b08-42fb-08d9e74bb650
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 19:31:01.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcAW9wrIwitS61/RhUd3iER7i7tykOVzQjpmQDR2Z2JtTOSEmgUnoVAzaKsVwy8DFMbs5yuzbdFlf3n0GYT65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3617
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-Proofpoint-ORIG-GUID: 231PNRLfol8XQCM__woSDsgRAM5MjoyV
X-Proofpoint-GUID: 231PNRLfol8XQCM__woSDsgRAM5MjoyV
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunge=
s
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client shoul=
d
> reconnect and attempt to use the (now) expired state.
>=20
> The default lease period for the Linux server is 90 seconds.  The typical
> client cuts that in half and will issue a lease renewing operation every
> 45 seconds. The 90 second lease period is very short considering the
> potential for moderately long term network partitions.  A network partiti=
on
> refers to any loss of network connectivity between the NFS client and the
> NFS server, regardless of its root cause.  This includes NIC failures, NI=
C
> driver bugs, network misconfigurations & administrative errors, routers &
> switches crashing and/or having software updates applied, even down to
> cables being physically pulled.  In most cases, these network failures ar=
e
> transient, although the duration is unknown.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> The initial implementation of the Courteous Server will do the following:
>=20
> . When the laundromat thread detects an expired client and if that client
> still has established state on the Linux server and there is no waiters
> for the client's locks then deletes the client persistent record and mark=
s
> the client as COURTESY_CLIENT and skips destroying the client and all of
> state, otherwise destroys the client as usual.
>=20
> . Client persistent record is added to the client database when the
> courtesy client reconnects and transits to normal client.
>=20
> . Lock/delegation/share reversation conflict with courtesy client is
> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
> effectively disable it, then allow the current request to proceed
> immediately.
>=20
> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
> reconnect to reuse itsstate. It is expired by the laundromat asynchronous=
ly
> in the background.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++++++=
-----
> fs/nfsd/state.h     |   5 +
> 2 files changed, 415 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1956d377d1a6..b302d857e196 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>=20
> +static const int courtesy_client_expiry =3D (24 * 60 * 60);	/* in secs *=
/

Please make this a macro, not a const variable.


> +
> static bool is_session_dead(struct nfsd4_session *ses)
> {
> 	return ses->se_flags & NFS4_SESSION_DEAD;
> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid=
 *sessionid, struct net *net)
>=20
> static struct nfsd4_session *
> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *n=
et,
> -		__be32 *ret)
> +		__be32 *ret, bool *courtesy_clnt)

IMO the new @courtesy_clnt parameter isn't necessary.
Just create a new cl_flag:

+#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
+#define NFSD4_DESTROY_COURTESY_CLIENT	(7)

#define NFSD4_CLIENT_PROMOTE_COURTESY   (8)

or REHYDRATE_COURTESY some such.

Set that flag and check it once it is safe to call
nfsd4_client_record_create(). That should make this a
much smaller patch. Anything else you can do to break
this patch into smaller ones will help the review
process.

By the way, the new cl_flags you define in fs/nfsd/state.h
need to be named "NFSD4_CLIENT_yyzzy". I think you can
drop the "_CLIENT" suffix for brevity.


> {
> 	struct nfsd4_session *session;
> 	__be32 status =3D nfserr_badsession;
> +	struct nfs4_client *clp;
>=20
> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
> 	if (!session)
> 		goto out;
> +	clp =3D session->se_client;
> +	if (courtesy_clnt)
> +		*courtesy_clnt =3D false;
> +	if (clp) {
> +		/* need to sync with thread resolving lock/deleg conflict */
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			session =3D NULL;
> +			goto out;
> +		}
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			if (!courtesy_clnt) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				session =3D NULL;
> +				goto out;
> +			}
> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			*courtesy_clnt =3D true;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +	}
> 	status =3D nfsd4_get_session_locked(session);
> 	if (status)
> 		session =3D NULL;
> @@ -1990,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->cl_openowners);
> 	INIT_LIST_HEAD(&clp->cl_delegations);
> 	INIT_LIST_HEAD(&clp->cl_lru);
> +	INIT_LIST_HEAD(&clp->cl_cs_list);
> 	INIT_LIST_HEAD(&clp->cl_revoked);
> #ifdef CONFIG_NFSD_PNFS
> 	INIT_LIST_HEAD(&clp->cl_lo_states);
> @@ -1997,6 +2023,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->async_copies);
> 	spin_lock_init(&clp->async_lock);
> 	spin_lock_init(&clp->cl_lock);
> +	spin_lock_init(&clp->cl_cs_lock);
> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> 	return clp;
> err_no_hashtbl:
> @@ -2394,6 +2421,10 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 		seq_puts(m, "status: confirmed\n");
> 	else
> 		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
> +	seq_printf(m, "seconds from last renew: %lld\n",
> +		ktime_get_boottime_seconds() - clp->cl_time);
> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -2801,12 +2832,15 @@ add_clp_to_name_tree(struct nfs4_client *new_clp,=
 struct rb_root *root)
> }
>=20
> static struct nfs4_client *
> -find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
> +find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root,
> +				bool *courtesy_client)
> {
> 	int cmp;
> 	struct rb_node *node =3D root->rb_node;
> 	struct nfs4_client *clp;
>=20
> +	if (courtesy_client)
> +		*courtesy_client =3D false;
> 	while (node) {
> 		clp =3D rb_entry(node, struct nfs4_client, cl_namenode);
> 		cmp =3D compare_blob(&clp->cl_name, name);
> @@ -2814,8 +2848,29 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> +		else {
> +			/* sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				return NULL;
> +			}
> +			if (test_bit(NFSD4_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +				if (!courtesy_client) {
> +					set_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +							&clp->cl_flags);
> +					spin_unlock(&clp->cl_cs_lock);
> +					return NULL;
> +				}
> +				clear_bit(NFSD4_COURTESY_CLIENT,
> +					&clp->cl_flags);
> +				*courtesy_client =3D true;
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			return clp;
> +		}
> 	}
> 	return NULL;
> }
> @@ -2852,15 +2907,38 @@ move_to_confirmed(struct nfs4_client *clp)
> }
>=20
> static struct nfs4_client *
> -find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool se=
ssions)
> +find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool se=
ssions,
> +			bool *courtesy_clnt)
> {
> 	struct nfs4_client *clp;
> 	unsigned int idhashval =3D clientid_hashval(clid->cl_id);
>=20
> +	if (courtesy_clnt)
> +		*courtesy_clnt =3D false;
> 	list_for_each_entry(clp, &tbl[idhashval], cl_idhash) {
> 		if (same_clid(&clp->cl_clientid, clid)) {
> 			if ((bool)clp->cl_minorversion !=3D sessions)
> 				return NULL;
> +
> +			/* need to sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}
> +			if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +				if (!courtesy_clnt) {
> +					set_bit(NFSD4_DESTROY_COURTESY_CLIENT,
> +							&clp->cl_flags);
> +					spin_unlock(&clp->cl_cs_lock);
> +					continue;
> +				}
> +				clear_bit(NFSD4_COURTESY_CLIENT,
> +							&clp->cl_flags);
> +				*courtesy_clnt =3D true;
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			renew_client_locked(clp);
> 			return clp;
> 		}
> @@ -2869,12 +2947,13 @@ find_client_in_id_table(struct list_head *tbl, cl=
ientid_t *clid, bool sessions)
> }
>=20
> static struct nfs4_client *
> -find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *=
nn)
> +find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *=
nn,
> +		bool *courtesy_clnt)
> {
> 	struct list_head *tbl =3D nn->conf_id_hashtbl;
>=20
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_client_in_id_table(tbl, clid, sessions);
> +	return find_client_in_id_table(tbl, clid, sessions, courtesy_clnt);
> }
>=20
> static struct nfs4_client *
> @@ -2883,7 +2962,7 @@ find_unconfirmed_client(clientid_t *clid, bool sess=
ions, struct nfsd_net *nn)
> 	struct list_head *tbl =3D nn->unconf_id_hashtbl;
>=20
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_client_in_id_table(tbl, clid, sessions);
> +	return find_client_in_id_table(tbl, clid, sessions, NULL);
> }
>=20
> static bool clp_used_exchangeid(struct nfs4_client *clp)
> @@ -2892,17 +2971,18 @@ static bool clp_used_exchangeid(struct nfs4_clien=
t *clp)
> }=20
>=20
> static struct nfs4_client *
> -find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *=
nn)
> +find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *=
nn,
> +			bool *courtesy_clnt)
> {
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	return find_clp_in_name_tree(name, &nn->conf_name_tree, courtesy_clnt);
> }
>=20
> static struct nfs4_client *
> find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net =
*nn)
> {
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->unconf_name_tree);
> +	return find_clp_in_name_tree(name, &nn->unconf_name_tree, NULL);
> }
>=20
> static void
> @@ -3176,7 +3256,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>=20
> 	/* Cases below refer to rfc 5661 section 18.35.4: */
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&exid->clname, nn);
> +	conf =3D find_confirmed_client_by_name(&exid->clname, nn, NULL);
> 	if (conf) {
> 		bool creds_match =3D same_creds(&conf->cl_cred, &rqstp->rq_cred);
> 		bool verfs_match =3D same_verf(&verf, &conf->cl_verifier);
> @@ -3443,7 +3523,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>=20
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&cr_ses->clientid, true, nn);
> -	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn);
> +	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn, NULL);
> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -3474,7 +3554,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> 			status =3D nfserr_seq_misordered;
> 			goto out_free_conn;
> 		}
> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
> 		if (old) {
> 			status =3D mark_client_expired_locked(old);
> 			if (status) {
> @@ -3613,11 +3693,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst=
 *rqstp,
> 	struct nfsd4_session *session;
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	bool courtesy_clnt;
>=20
> 	if (!nfsd4_last_compound_op(rqstp))
> 		return nfserr_not_only_op;
> 	spin_lock(&nn->client_lock);
> -	session =3D find_in_sessionid_hashtbl(&bcts->sessionid, net, &status);
> +	session =3D find_in_sessionid_hashtbl(&bcts->sessionid, net, &status,
> +				&courtesy_clnt);
> 	spin_unlock(&nn->client_lock);
> 	if (!session)
> 		goto out_no_session;
> @@ -3647,6 +3729,8 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *=
rqstp,
> out:
> 	nfsd4_put_session(session);
> out_no_session:
> +	if (status =3D=3D nfs_ok && courtesy_clnt)
> +		nfsd4_client_record_create(session->se_client);
> 	return status;
> }
>=20
> @@ -3676,7 +3760,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nf=
sd4_compound_state *cstate,
> 	}
> 	dump_sessionid(__func__, sessionid);
> 	spin_lock(&nn->client_lock);
> -	ses =3D find_in_sessionid_hashtbl(sessionid, net, &status);
> +	ses =3D find_in_sessionid_hashtbl(sessionid, net, &status, NULL);
> 	if (!ses)
> 		goto out_client_lock;
> 	status =3D nfserr_wrong_cred;
> @@ -3790,6 +3874,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	int buflen;
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	bool courtesy_clnt;
>=20
> 	if (resp->opcnt !=3D 1)
> 		return nfserr_sequence_pos;
> @@ -3803,7 +3888,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 		return nfserr_jukebox;
>=20
> 	spin_lock(&nn->client_lock);
> -	session =3D find_in_sessionid_hashtbl(&seq->sessionid, net, &status);
> +	session =3D find_in_sessionid_hashtbl(&seq->sessionid, net, &status,
> +				&courtesy_clnt);
> 	if (!session)
> 		goto out_no_session;
> 	clp =3D session->se_client;
> @@ -3893,6 +3979,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	if (conn)
> 		free_conn(conn);
> 	spin_unlock(&nn->client_lock);
> +	if (status =3D=3D nfs_ok && courtesy_clnt)
> +		nfsd4_client_record_create(clp);
> 	return status;
> out_put_session:
> 	nfsd4_put_session_locked(session);
> @@ -3928,7 +4016,7 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>=20
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&dc->clientid, true, nn);
> -	conf =3D find_confirmed_client(&dc->clientid, true, nn);
> +	conf =3D find_confirmed_client(&dc->clientid, true, nn, NULL);
> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -4012,12 +4100,18 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	struct nfs4_client	*unconf =3D NULL;
> 	__be32 			status;
> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	bool courtesy_clnt =3D false;
> +	struct nfs4_client *cclient =3D NULL;
>=20
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&clname, nn);
> +	conf =3D find_confirmed_client_by_name(&clname, nn, &courtesy_clnt);
> +	if (conf && courtesy_clnt) {
> +		cclient =3D conf;
> +		conf =3D NULL;
> +	}
> 	if (conf && client_has_state(conf)) {
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> @@ -4048,7 +4142,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	new =3D NULL;
> 	status =3D nfs_ok;
> out:
> +	if (cclient)
> +		unhash_client_locked(cclient);
> 	spin_unlock(&nn->client_lock);
> +	if (cclient)
> +		expire_client(cclient);
> 	if (new)
> 		free_client(new);
> 	if (unconf) {
> @@ -4076,8 +4174,9 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 		return nfserr_stale_clientid;
>=20
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client(clid, false, nn);
> +	conf =3D find_confirmed_client(clid, false, nn, NULL);
> 	unconf =3D find_unconfirmed_client(clid, false, nn);
> +
> 	/*
> 	 * We try hard to give out unique clientid's, so if we get an
> 	 * attempt to confirm the same clientid with a different cred,
> @@ -4107,7 +4206,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 		unhash_client_locked(old);
> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> 	} else {
> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
> 		if (old) {
> 			status =3D nfserr_clid_inuse;
> 			if (client_has_state(old)
> @@ -4691,18 +4790,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	return ret;
> }
>=20
> +/*
> + * Function returns true if lease conflict was resolved
> + * else returns false.
> + */
> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> {
> 	struct nfs4_delegation *dl =3D fl->fl_owner;
> 	struct svc_rqst *rqst;
> 	struct nfs4_client *clp;
>=20
> +	clp =3D dl->dl_stid.sc_client;
> +
> +	/*
> +	 * need to sync with courtesy client trying to reconnect using
> +	 * the cl_cs_lock, nn->client_lock can not be used since this
> +	 * function is called with the fl_lck held.
> +	 */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +
> 	if (!i_am_nfsd())
> -		return NULL;
> +		return false;
> 	rqst =3D kthread_data(current);
> 	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> 	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> -		return NULL;
> +		return false;
> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> }
> @@ -4735,12 +4857,12 @@ static __be32 nfsd4_check_seqid(struct nfsd4_comp=
ound_state *cstate, struct nfs4
> }
>=20
> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool session=
s,
> -						struct nfsd_net *nn)
> +			struct nfsd_net *nn, bool *courtesy_clnt)
> {
> 	struct nfs4_client *found;
>=20
> 	spin_lock(&nn->client_lock);
> -	found =3D find_confirmed_client(clid, sessions, nn);
> +	found =3D find_confirmed_client(clid, sessions, nn, courtesy_clnt);
> 	if (found)
> 		atomic_inc(&found->cl_rpc_users);
> 	spin_unlock(&nn->client_lock);
> @@ -4751,6 +4873,8 @@ static __be32 set_client(clientid_t *clid,
> 		struct nfsd4_compound_state *cstate,
> 		struct nfsd_net *nn)
> {
> +	bool courtesy_clnt;
> +
> 	if (cstate->clp) {
> 		if (!same_clid(&cstate->clp->cl_clientid, clid))
> 			return nfserr_stale_clientid;
> @@ -4762,9 +4886,12 @@ static __be32 set_client(clientid_t *clid,
> 	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
> 	 * set cstate->clp), so session =3D false:
> 	 */
> -	cstate->clp =3D lookup_clientid(clid, false, nn);
> +	cstate->clp =3D lookup_clientid(clid, false, nn, &courtesy_clnt);
> 	if (!cstate->clp)
> 		return nfserr_expired;
> +
> +	if (courtesy_clnt)
> +		nfsd4_client_record_create(cstate->clp);
> 	return nfs_ok;
> }
>=20
> @@ -4917,9 +5044,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_=
fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file=
 *fp,
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * This function is called to check whether nfserr_share_denied should
> + * be returning to client.
> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	true   - access/deny mode conflict with normal client.
> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	struct nfs4_client *cl;
> +	bool conflict =3D false;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		if (st->st_openstp || (st =3D=3D stp && new_stp) ||
> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +
> +		/* need to sync with courtesy client trying to reconnect */
> +		cl =3D st->st_stid.sc_client;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags)) {
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict not caused by courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);
> +		conflict =3D true;
> +		break;
> +	}
> +	return conflict;
> +}
> +
> +static __be32
> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
> {
> 	struct nfsd_file *nf =3D NULL;
> 	__be32 status;
> @@ -4935,15 +5142,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	 */
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_deny, false)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* set access to the file */
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_access, true)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* Set access bits in stateid */
> @@ -4994,7 +5215,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp, struct svc_fh *c
> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>=20
> 	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>=20
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> @@ -5343,7 +5564,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> 		if (status) {
> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> 			release_open_stateid(stp);
> @@ -5577,6 +5798,122 @@ static void nfsd4_ssc_expire_umount(struct nfsd_n=
et *nn)
> }
> #endif
>=20
> +static bool
> +nfs4_anylock_blocker(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo =3D lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf =3D stp->st_stid.sc_file;
> +				ino =3D nf->fi_inode;
> +				ctx =3D ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner !=3D lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests)) {
> +						spin_unlock(&clp->cl_lock);
> +						return true;
> +					}
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +static void
> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist=
,
> +				struct laundry_time *lt)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
> +
> +	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (!state_expired(lt, clp->cl_time))
> +			break;
> +
> +		/* client expired */
> +		if (!client_has_state(clp)) {
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +
> +		/* expired client has state */
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
> +			goto exp_client;
> +
> +		cour =3D test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +		if (cour &&
> +			ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
> +			goto exp_client;
> +
> +		if (nfs4_anylock_blocker(clp)) {
> +			/* expired client has state and has blocker. */
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +		/*
> +		 * Client expired and has state and has no blockers.
> +		 * If there is race condition with blockers, next time
> +		 * the laundromat runs it will catch it and expires
> +		 * the client. Client is expected to retry on lock or
> +		 * lease conflict.
> +		 */
> +		if (!cour) {
> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
> +					courtesy_client_expiry;
> +			list_add(&clp->cl_cs_list, &cslist);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +
> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags) ||
> +			!test_bit(NFSD4_COURTESY_CLIENT,
> +					&clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +		nfsd4_client_record_remove(clp);
> +	}
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5610,16 +5947,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
>=20
> -	spin_lock(&nn->client_lock);
> -	list_for_each_safe(pos, next, &nn->client_lru) {
> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> -			break;
> -		if (mark_client_expired_locked(clp))
> -			continue;
> -		list_add(&clp->cl_lru, &reaplist);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> 	list_for_each_safe(pos, next, &reaplist) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> 		trace_nfsd_clid_purged(&clp->cl_clientid);
> @@ -5998,7 +6326,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
> 	cps->cpntf_time =3D ktime_get_boottime_seconds();
>=20
> 	status =3D nfserr_expired;
> -	found =3D lookup_clientid(&cps->cp_p_clid, true, nn);
> +	found =3D lookup_clientid(&cps->cp_p_clid, true, nn, NULL);
> 	if (!found)
> 		goto out;
>=20
> @@ -6501,6 +6829,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> 		lock->fl_end =3D OFFSET_MAX;
> }
>=20
> +/**
> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
> + *
> + * @fl: pointer to file_lock with a potential conflict
> + * Return values:
> + *   %true: real conflict, lock conflict can not be resolved.
> + *   %false: no conflict, lock conflict was resolved.
> + *
> + * Note that this function is called while the flc_lock is held.
> + */
> +static bool
> +nfsd4_fl_lock_conflict(struct file_lock *fl)
> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	bool rc =3D true;
> +
> +	if (!fl)
> +		return true;
> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	clp =3D lo->lo_owner.so_client;
> +
> +	/* need to sync with courtesy client trying to reconnect */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
> +		rc =3D false;
> +	else {
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +			rc =3D  false;
> +		} else
> +			rc =3D  true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
> +
> static fl_owner_t
> nfsd4_fl_get_owner(fl_owner_t owner)
> {
> @@ -6548,6 +6913,7 @@ static const struct lock_manager_operations nfsd_po=
six_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,
> +	.lm_lock_conflict =3D nfsd4_fl_lock_conflict,
> };
>=20
> static inline void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..b75f4c70706d 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,8 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -385,6 +387,9 @@ struct nfs4_client {
> 	struct list_head	async_copies;	/* list of async copies */
> 	spinlock_t		async_lock;	/* lock for async copies */
> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;
> +	spinlock_t		cl_cs_lock;
> +	struct list_head	cl_cs_list;
> };
>=20
> /* struct nfs4_client_reset
> --=20
> 2.9.5
>=20

--
Chuck Lever



