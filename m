Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B763B46A62C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 20:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbhLFT7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 14:59:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7042 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348995AbhLFT7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:59:05 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6JbPuE020426;
        Mon, 6 Dec 2021 19:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ILoG22T/Tt90DXxhyZaFL6plOHoTt/PN779NhLPuItE=;
 b=ECGskiKKWpnV42KL7POiUsevlcHXLw5C79y4fwzly7Nuo1CjmJXRSs2Soaq5o5kBO2Ae
 YnP3mH1dlUPHZ6CeDBaI4GRyp5A/nUe/gCPcmgBSDfe+dSZeEYuR7jnRO8T3ADPUPG21
 8V1CQEu6ai0wQFnKPJsrE0BF/ggumAoT/uvccfk3DGJ6odegpSWHc5O4BWYzZum8TQW7
 nhU1fXR2prONDjji2N/93BGQvWrz1/KGw3tGooqAJHGN8l4mohWhad4qkZHkCQ9lgEWs
 0JvK/dmXtxAbWv/N6b4ldU1U91aYDyZzeuffR1Z4vuFlEy7YFzC8NsnrYiuQUz5H+sTH UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfjb5d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 19:55:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6JpDaP115515;
        Mon, 6 Dec 2021 19:55:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4s8u59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 19:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGglo5gISaE44ADJKWQT+XJ0vTXTUeDIVrGdtKvfA6dc75b0SJig1UDmnXoOgRSpgbnW6pq7+b0Mvz4F3JFqeu7MLraGSbxV0+7iDIp2zJdpcBYABVL8qn7FJoIRZNEq/Rx6AbqLEl6epsUvEuAC3uMmTKh1tCHQ2V36C9+Wk5uRp6/4u/uBwGCTjBGz6UbHT/uJira5kG2i8GJm9ZKJ0i9wx4VKmUh1dAX2bKDimHIUD5iaitjnQBh2xCTRlx/cieyqn/kZtP/YsyhLr+Meay0BXBdGg3Kkf6XqiAVxkK8K0q99h2sHfc1FyZ+mBSWQ16XIi0ofCOhdGn5ki1MRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILoG22T/Tt90DXxhyZaFL6plOHoTt/PN779NhLPuItE=;
 b=HJogHnkahhVdYPLWnhBvuCkguVLeXo1qKdozuRWUZgEbQYy0OQx5w8AU2sMEqACrdNv2+FTk90n25MW9SXhA5zBUPTsOiClSELC/DAvvMSkyZ4SFuhBIz4q0TbxiA2iHmddMsRaze1nTfz7o/uMUhxU1+JCLrkSqUE+qUaFeP98edS7v3sPxT11Eiir5tU9pmkasq1KMsoRfl34UEdZ1N97ixQrjQJ+ezo0fa/qnZMeY8VfZyOX0aDDEKAOsH9EBM4PNP8LWytZuIjHeL3dgk15yxwoO1gZeU/6SYM5vDljzl5JCenYQ6NOrbEpLVP7zixQWwoudlz6pwiBtTypIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILoG22T/Tt90DXxhyZaFL6plOHoTt/PN779NhLPuItE=;
 b=p5P5B87dvTXeB9IfJxtrTMZ576DRSGWk8+3cs3upRhktAti23qfJFgRUMIBE9ZqsaiBBbvVLmDv1C91VRUNESZXYS/7mzuYSWdYWEozJLICmNSQ+iM3UQp6T6SWR53k4Slb7ICRYjaWKvGMaOa9FEOsevgjkvN/Ou0DHjgvfc5M=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5225.namprd10.prod.outlook.com (2603:10b6:610:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 19:55:31 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 19:55:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssTAZRABZ1HqkCYuoltcOnBFawl4NyA
Date:   Mon, 6 Dec 2021 19:55:31 +0000
Message-ID: <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
In-Reply-To: <20211206175942.47326-3-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb579b7-fca3-45e4-fd52-08d9b8f25c33
x-ms-traffictypediagnostic: CH0PR10MB5225:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5225EA20BC960874D68ACFFC936D9@CH0PR10MB5225.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8TUeH6kVPFaPwqS9pksiMY2UpEmDkJFF0HeCVv5kw6a3uiSjy8sGWzaBK33lq6dFoO9yAHyhEFR0Y7Dg8MwAsb3dFVP4B2kgRWUwlLpdeYYyP2fgYSgsoTNgtY3XRqOQdTgZ4tWp+pWBt7nU/Zz4oi8RryWo1HU4eH9nZKsl4HExRVQ/e7QsCpJNTSi6aS/tOnyaQa08qrJhiCGnT/Zit8jdmPcIvGcth0ncOmml/xujifrz8wYdXPWqR7F4MGJPNDVwKN57omNMYwWCzxyBKkA48txv9Iyk66EYESsQ8Dvtu8uztmJVAI+uJPDFpHHTaGJNoxjtdFSMftrf56h9JBSDjg+duZpWCukvIw3Yekiaw0r0DR2gOgDsMVbNRt9zXl0dKn1dHjZ4e6MIPmGgIJJaWSKZePQOS7eZ/4vFP73+GESVGuP4PU6UbJEmP9eM+UG3DVH/b/HvA/1qB4n7Y4r6SSx6FQe9kH3dABQ1c1V5wC36Fu6FhodK6uV093k6CT4aClC4jMXhyD1nOopWxTcfF4NBUbLEU21gxEcHwQZIxlhHmzehjprpvzJ1Hlm8M8OeDLsPhq7naEt14barfW+j5FjeCDGEQ7oSpaAe9mU1M5Q0FqAMe/5rlwRrj1IoIRfi3pZP9p0HykoF3TVeWnz8WZcEKtJHyAxUVBV+cYJ4PBWMcVova71x+B0CRf2rG59Rmv/me+DlGwvVy2KVB7yGUmdpVY9QvrWFUEs2XbeceK1ipDOaOuvs413rryzP+ewZeOK+Trb7PK5aOx+Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(66476007)(83380400001)(66446008)(5660300002)(53546011)(64756008)(316002)(36756003)(122000001)(76116006)(38070700005)(38100700002)(54906003)(37006003)(6506007)(66556008)(86362001)(26005)(6636002)(2906002)(6862004)(4326008)(30864003)(8936002)(71200400001)(6486002)(508600001)(2616005)(6512007)(8676002)(33656002)(45980500001)(579004)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H7EMKuliIWJxAvrnvz8EryPMYQVjl0KaiRuav9FWQW+RqLuOL6/DqgcQCp+B?=
 =?us-ascii?Q?lMmjf/fpE7xqmVfMXskjstpnB6410CCBAiikZgR5b4jegk+Dbd+HSrSEDK5i?=
 =?us-ascii?Q?/tg+mMIYPAGZYp77NxOjvnv7TVC/UB5+SzapQzJ+AQpKn4gdd8n6UCtAkK8i?=
 =?us-ascii?Q?/ZmbyJtDg3TG3GQeSmVczUadifYHgxcPiOFAZhfmbdiAkpGNBWMsMNqBhXj5?=
 =?us-ascii?Q?4rS0CLFv42dCyuxMLQDyHnWBbHJAqZsypCh0EDCdsX9qXVZm9EbBDY4qdvf6?=
 =?us-ascii?Q?9DBn3+rPuoXHi9Nnbf44WDPW9grnZNN3Sf2+P8+THeNAiBCNVMSoobTJCtCM?=
 =?us-ascii?Q?RlH9SrKzIFqo0FXY0APaFlh1fxkmuKCMsRiqzgOwytcvmNozBLO97M1SJ8CU?=
 =?us-ascii?Q?HrcieeEb3SIbAfCFnA0W38QJyhXV5fJ+KzTXrjRciZFSuKVTOqmxliWMc/73?=
 =?us-ascii?Q?4TKb3vH4kpSD2CzWI9z7wn0jjitmxfy1+DbFgAOxp6adfMG6VuNVvIv/ZPDB?=
 =?us-ascii?Q?0SfQ3RP1K54BXvcEnaKKNJMvZmGROmWjV/DyKW4jlvo85xs15rJ51rVyWiPK?=
 =?us-ascii?Q?BpFdu614iUCeHpEoxPms9JPH7Pwb3ruQa6YTtVj28qzQUJjh8wbAD+ZdPgLr?=
 =?us-ascii?Q?1yt4S456CPz+rsLPmJnnC5UhL+tAS2l413YxC+WmMPgmceWsYgNwqm17xC/g?=
 =?us-ascii?Q?VjEiLnK+JAPqrLC8hxI1eUqIRvlHRC8xEU6wAI7VoFuta2+LSj2W7RFlIyPH?=
 =?us-ascii?Q?s8uVMMpji22pJrwbfSQKA7Mqhbzq+AfTeljmru7NtewZWDFoYjwB60vcYWv6?=
 =?us-ascii?Q?7mmOyxyf48Ki4Wcvdfdvu+pV6KlhyQaN3CO7mMDQTlaN2I+sQjNEJP+1iriY?=
 =?us-ascii?Q?JgxzpuNr3LkNYko7mtqJCmFUbUVg3M6Fzg6raa5vL+lim/VHiS5L5L2rjtLE?=
 =?us-ascii?Q?L0H62QGDsyi3fIZSyWeanmiEY24P6ho0QLGQiljlIv9gNWBk29WrcUXt/oN4?=
 =?us-ascii?Q?N4QL7rlmtCwsNBYoKxMu1kSaX6oHlkM7EjOBBHbTiTRHK4nXlO03kNQq5IdE?=
 =?us-ascii?Q?hYjzqSu5NaFAYI9wXX39ZOSS4+E0HI4WJfZHBA4vYPlD049c88/8kz9COv1X?=
 =?us-ascii?Q?OyqlZr/GJvrsdesPzsqDkLjA18ACmL6aA47f/ZeQQrgaG065Spkw4C3P7pN5?=
 =?us-ascii?Q?kN5SdYrlysI9JuyMy06foSAiKYpqZCFI2OAIRqpPlv50wqkVQ6aESIWsCG/9?=
 =?us-ascii?Q?dBeQFupOaqiDs4+vtUe5pT6vMykKcYzZeKA2qAsOC7zLu5Dgw8R+7YQoesmg?=
 =?us-ascii?Q?Ae/Nn5bMR4eMvjo5wIR/JDdOL+mzeV/EjoCGwNr+Jkp5LGT9lKmoo30MFHvy?=
 =?us-ascii?Q?Px13oXJnaHUL4DGe+eij3kY2OybNHXG08K3zJQPEXu6+bYMy0nPMqLi2e9CV?=
 =?us-ascii?Q?dy5O3QPTmDBlWN/CTlffleCxvExD3TRLzb95G0/0vDR6Gub20Fjg7fogUm0p?=
 =?us-ascii?Q?zaojuH41sSIVJpmyXlqUF0DjcUf6UTY8Rz4GaFbRKvF62H9nSLmdSTcuhwcd?=
 =?us-ascii?Q?A/W5aTO3bWeAAEbUBNaqBGpTnIH0DDQx94qqRBO5In1B1JB24PHHCbZ/MSO+?=
 =?us-ascii?Q?56imc6pM8aoNT+dmm+paZjU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7423CDD1B8F40146B834B9D7CC41B988@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb579b7-fca3-45e4-fd52-08d9b8f25c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 19:55:31.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvBYydDSRmbMYMhGf9eOisPUYMqEUf/AyN02cS8nV9fsWYN2Cm0TmwvDADKMJvbp3dFd/WdnStFrQxYLKqfmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5225
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060121
X-Proofpoint-GUID: eUnBE_m7rQYJ5Y6MnLkUiWUqUzqvpKeB
X-Proofpoint-ORIG-GUID: eUnBE_m7rQYJ5Y6MnLkUiWUqUzqvpKeB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dai-

Some comments and questions below:


> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
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
> . when the laundromat thread detects an expired client and if that client
> still has established states on the Linux server and there is no waiters
> for the client's locks then mark the client as a COURTESY_CLIENT and skip
> destroying the client and all its states, otherwise destroy the client as
> usual.
>=20
> . detects conflict of OPEN request with COURTESY_CLIENT, destroys the
> expired client and all its states, skips the delegation recall then allow=
s
> the conflicting request to succeed.
>=20
> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
> requests with COURTESY_CLIENT, destroys the expired client and all its
> states then allows the conflicting request to succeed.
>=20
> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
> requests with COURTESY_CLIENT, destroys the expired client and all its
> states then allows the conflicting request to succeed.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++=
++++-
> fs/nfsd/state.h     |   3 +
> 2 files changed, 293 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3f4027a5de88..759f61dc6685 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>=20
> +static struct workqueue_struct *laundry_wq;
> +static void laundromat_main(struct work_struct *);
> +
> +static int courtesy_client_expiry =3D (24 * 60 * 60);	/* in secs */
> +
> static bool is_session_dead(struct nfsd4_session *ses)
> {
> 	return ses->se_flags & NFS4_SESSION_DEAD;
> @@ -172,6 +177,7 @@ renew_client_locked(struct nfs4_client *clp)
>=20
> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
> 	clp->cl_time =3D ktime_get_boottime_seconds();
> +	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> }
>=20
> static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, vo=
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
> @@ -4662,6 +4672,33 @@ static void nfsd_break_one_deleg(struct nfs4_deleg=
ation *dp)
> 	nfsd4_run_cb(&dp->dl_recall);
> }
>=20
> +/*
> + * This function is called when a file is opened and there is a
> + * delegation conflict with another client. If the other client
> + * is a courtesy client then kick start the laundromat to destroy
> + * it.
> + */
> +static bool
> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp =3D dp->dl_recall.cb_clp;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	if (!i_am_nfsd())
> +		goto out;
> +	rqst =3D kthread_data(current);
> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;
> +out:
> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +		return true;
> +	}
> +	return false;
> +}
> +
> /* Called from break_lease() with i_lock held. */
> static bool
> nfsd_break_deleg_cb(struct file_lock *fl)
> @@ -4670,6 +4707,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
> 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
>=20
> +	if (nfsd_check_courtesy_client(dp))
> +		return false;
> 	trace_nfsd_cb_recall(&dp->dl_stid);
>=20
> 	/*
> @@ -4912,6 +4951,136 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc=
_fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> +static bool
> +__nfs4_check_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||

Aren't the NFS4_SHARE_DENY macros already bit masks?

NFS4_SHARE_DENY_BOTH is (NFS4_SHARE_DENY_READ | NFS4_SHARE_DENY_WRITE).


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
> + * access: if share_access is true then check access mode else check den=
y mode
> + */
> +static bool
> +nfs4_check_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
> +		struct nfs4_ol_stateid *st, u32 access, bool share_access)
> +{
> +	int i;
> +	struct nfs4_openowner *oo;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_ol_stateid *stp, *stmp;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +					so_strhash) {
> +			if (!so->so_is_open_owner)
> +				continue;
> +			oo =3D openowner(so);
> +			list_for_each_entry_safe(stp, stmp,
> +				&oo->oo_owner.so_stateids, st_perstateowner) {
> +				if (stp =3D=3D st || stp->st_stid.sc_file !=3D fp)
> +					continue;
> +				if (__nfs4_check_deny_bmap(stp, access,
> +							share_access)) {
> +					spin_unlock(&clp->cl_lock);
> +					return true;
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +/*
> + * Function to check if the nfserr_share_denied error for 'fp' resulted
> + * from conflict with courtesy clients then release their state to resol=
ve
> + * the conflict.
> + *
> + * Function returns:
> + *	 0 -  no conflict with courtesy clients
> + *	>0 -  conflict with courtesy clients resolved, try access/deny check =
again
> + *	-1 -  conflict with courtesy clients being resolved in background
> + *            return nfserr_jukebox to NFS client
> + */
> +static int
> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
> +			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
> +			u32 access, bool share_access)
> +{
> +	int cnt =3D 0;
> +	int async_cnt =3D 0;
> +	bool no_retry =3D false;
> +	struct nfs4_client *cl;
> +	struct list_head *pos, *next, reaplist;
> +	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +
> +	INIT_LIST_HEAD(&reaplist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		cl =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		/*
> +		 * check all nfs4_ol_stateid of this client
> +		 * for conflicts with 'access'mode.
> +		 */
> +		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
> +			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
> +				/* conflict with non-courtesy client */
> +				no_retry =3D true;
> +				cnt =3D 0;
> +				goto out;
> +			}
> +			/*
> +			 * if too many to resolve synchronously
> +			 * then do the rest in background
> +			 */
> +			if (cnt > 100) {
> +				set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
> +				async_cnt++;
> +				continue;
> +			}
> +			if (mark_client_expired_locked(cl))
> +				continue;
> +			cnt++;
> +			list_add(&cl->cl_lru, &reaplist);
> +		}
> +	}

Bruce suggested simply returning NFS4ERR_DELAY for all cases.
That would simplify this quite a bit for what is a rare edge
case.


> +out:
> +	spin_unlock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &reaplist) {
> +		cl =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		list_del_init(&cl->cl_lru);
> +		expire_client(cl);
> +	}

A slightly nicer construct here would be something like this:

	while ((pos =3D list_del_first(&reaplist)))
		expire_client(list_entry(pos, struct nfs4_client, cl_lru));


> +	if (async_cnt) {
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +		if (!no_retry)
> +			cnt =3D -1;
> +	}
> +	return cnt;
> +}
> +
> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file =
*fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> 		struct nfsd4_open *open)
> @@ -4921,6 +5090,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rq=
stp, struct nfs4_file *fp,
> 	int oflag =3D nfs4_access_to_omode(open->op_share_access);
> 	int access =3D nfs4_access_to_access(open->op_share_access);
> 	unsigned char old_access_bmap, old_deny_bmap;
> +	int cnt =3D 0;
>=20
> 	spin_lock(&fp->fi_lock);
>=20
> @@ -4928,16 +5098,38 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	 * Are we trying to set a deny mode that would conflict with
> 	 * current access?
> 	 */
> +chk_deny:
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> 		spin_unlock(&fp->fi_lock);
> +		if (status !=3D nfserr_share_denied)
> +			goto out;
> +		cnt =3D nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
> +				stp, open->op_share_deny, false);
> +		if (cnt > 0) {
> +			spin_lock(&fp->fi_lock);
> +			goto chk_deny;

I'm pondering whether a distributed set of clients can
cause this loop to never terminate.


> +		}
> +		if (cnt =3D=3D -1)
> +			status =3D nfserr_jukebox;
> 		goto out;
> 	}
>=20
> 	/* set access to the file */
> +get_access:
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> 		spin_unlock(&fp->fi_lock);
> +		if (status !=3D nfserr_share_denied)
> +			goto out;
> +		cnt =3D nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
> +				stp, open->op_share_access, true);
> +		if (cnt > 0) {
> +			spin_lock(&fp->fi_lock);
> +			goto get_access;

Ditto.


> +		}
> +		if (cnt =3D=3D -1)
> +			status =3D nfserr_jukebox;
> 		goto out;
> 	}
>=20
> @@ -5289,6 +5481,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfs=
d4_open *open,
> 	 */
> }
>=20
> +static bool
> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
> +{
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
> +			mark_client_expired_locked(clp)) {
> +		spin_unlock(&nn->client_lock);
> +		return false;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	expire_client(clp);
> +	return true;
> +}
> +

Perhaps nfs4_destroy_courtesy_client() could be merged into
nfsd4_fl_expire_lock(), it's only caller.


> __be32
> nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, st=
ruct nfsd4_open *open)
> {
> @@ -5572,6 +5780,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_ne=
t *nn)
> }
> #endif
>=20
> +static
> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
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
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;

Isn't cl_lock needed to protect the cl_ownerstr_hashtbl lists?


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
> +					if (!list_empty(&fl->fl_blocked_requests))
> +						return true;
> +				}
> +			}
> +		}
> +	}
> +	return false;
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5587,7 +5836,9 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	};
> 	struct nfs4_cpntf_state *cps;
> 	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
> 	int i;
> +	int id =3D 0;
>=20
> 	if (clients_still_reclaiming(nn)) {
> 		lt.new_timeo =3D 0;
> @@ -5608,8 +5859,33 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			goto exp_client;
> +		}
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			if (ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
> +				goto exp_client;
> +			/*
> +			 * after umount, v4.0 client is still
> +			 * around waiting to be expired
> +			 */
> +			if (clp->cl_minorversion)
> +				continue;
> +		}
> 		if (!state_expired(&lt, clp->cl_time))
> 			break;
> +		spin_lock(&clp->cl_lock);
> +		stid =3D idr_get_next(&clp->cl_stateids, &id);
> +		spin_unlock(&clp->cl_lock);
> +		if (stid && !nfs4_anylock_conflict(clp)) {
> +			/* client still has states */
> +			clp->courtesy_client_expiry =3D
> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			continue;
> +		}
> +exp_client:
> 		if (mark_client_expired_locked(clp))
> 			continue;
> 		list_add(&clp->cl_lru, &reaplist);
> @@ -5689,9 +5965,6 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> }
>=20
> -static struct workqueue_struct *laundry_wq;
> -static void laundromat_main(struct work_struct *);
> -
> static void
> laundromat_main(struct work_struct *laundry)
> {
> @@ -6496,6 +6769,19 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> 		lock->fl_end =3D OFFSET_MAX;
> }
>=20
> +/* return true if lock was expired else return false */
> +static bool
> +nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
> +{
> +	struct nfs4_lockowner *lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	struct nfs4_client *clp =3D lo->lo_owner.so_client;
> +
> +	if (testonly)
> +		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
> +			true : false;

Hm. I know test_bit() returns an integer rather than a boolean, but
the ternary here is a bit unwieldy. How about just:

		return !!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);


> +	return nfs4_destroy_courtesy_client(clp);
> +}
> +
> static fl_owner_t
> nfsd4_fl_get_owner(fl_owner_t owner)
> {
> @@ -6543,6 +6829,7 @@ static const struct lock_manager_operations nfsd_po=
six_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,
> +	.lm_expire_lock =3D nfsd4_fl_expire_lock,
> };
>=20
> static inline void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..93e30b101578 100644
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
> @@ -385,6 +387,7 @@ struct nfs4_client {
> 	struct list_head	async_copies;	/* list of async copies */
> 	spinlock_t		async_lock;	/* lock for async copies */
> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;
> };
>=20
> /* struct nfs4_client_reset
> --=20
> 2.9.5
>=20

--
Chuck Lever



