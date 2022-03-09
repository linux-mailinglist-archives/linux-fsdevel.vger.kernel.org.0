Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141D4D3D3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 23:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiCIWnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 17:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiCIWnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:43:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42E193C9;
        Wed,  9 Mar 2022 14:42:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KclsS022206;
        Wed, 9 Mar 2022 22:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=v4g3PsarsI0DJujIhkosSRf3yWV1UjVZhhDFy26yzms=;
 b=kSO/PclMS691UZfRVieCKrbMCmQG3trZ6JUULvgq7ahqOohDQT2f3AtZ7PvAvpxkRyOA
 rc7cytpd0e6B09W+i0CEjzSfSwkVwefmY963ZyA/HVd65Gx+0mYZvryH8rhe+eYSELil
 bRGZYVUk2x/nEeMCloAZoaDEmn/Y3E83VplXzHh9frB55LMctu7JGO3A1eynT5JuKlto
 FbhhsYvHmkvBco88uCOVjd+J1kDkeqk0D4QIbQTjiHC7Xhwd/0HTZm85Oh0tNgsp44O8
 VfWrj1j0dReIpxXwoZpEUtPeeukSplGYsaWjU3lHiNXol5LUlaiZVgSo+u8sFmvVjc3X Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0ujht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:42:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229MQPen107590;
        Wed, 9 Mar 2022 22:42:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3ekvyw7whm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjchooCklo3ORTotGrPtPmcVhY3JA26kNVA2E+UdOiRmjtiV93L/fr5nOfV8v5RTCxXUi5UYpi5REKIPYC8s+TNkk7TzHc+RZkeI2/6Hvw+Ua0RLs1WRgC/hoDxTXs8FMyLa1GAMjdtt6vR6Akljdug4X3WF0HuYF2iJ/RUtl6estD88JOUHYm6VzFSdU7pdgcuAVSCAJYWoMx6NJUTlrFQQ908jbT9NwdR1yB40PAE91ImCjm5LKl/6wQfeGPmoOObRUYEG2dEeGYCKv+SOE+qixFUaGpMLYhcb0iBS5odPFXe91fcTZ+P6Kc6mAOo7QT6jgypMVAR5SKi1CcBuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4g3PsarsI0DJujIhkosSRf3yWV1UjVZhhDFy26yzms=;
 b=KG7uVcCCu0NCzgEAEcgnUO3H2kxxvTq4piSZVIWtersPTMj6RCWOWD76b2bJCJKcQUm+wI8KgRpXLOqepnx728dE6mvR2h9lzUeAcJ7riFF2E63wj5IkzqkvXzlMyS5uxFHwV36J2rVDLEJl08/l+TyDsDTqTA70S6SImf4RfFgSRlxRXaaJF+qo0RN/P+SH2aWgs6YySK83OheTpSkIZxmjoCeDVBdMdBfNQdsEixD2LYvVtuqF6Ytf8RJE+COJCMYX3HQu9eTxqAXECFzv83cyNx6XS7MfVUjHNZTLQkJGJ5w+6ZONcrVY72Zr3oPZ5Zm/CfYDpIl6sso7jo77+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4g3PsarsI0DJujIhkosSRf3yWV1UjVZhhDFy26yzms=;
 b=edAD8Xk6Y1WYTankLyc+DSz4+IhfC7MLn1QFXqKGpJOFYF9KBqMYMcoo7SkGQ9WbUmCZ5fNOJSgMhltZGEQmLQJJK9YrwWtmTmieBCZMrGl5fp8cj+HNG1MxlbDbgYkXd76kACTXUpYl7wNZnztzqbUSs6di3PbOA63Uvf1KVTs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2591.namprd10.prod.outlook.com (2603:10b6:805:49::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:42:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:42:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl()
 to handle courtesy clients
Thread-Index: AQHYMCkwQ/sQvlxXy0G/nHUfqC8/oqy3raCA
Date:   Wed, 9 Mar 2022 22:42:38 +0000
Message-ID: <E3F16183-1407-430F-B408-A298D4C29401@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd039e67-13c9-4e23-e852-08da021e1cf6
x-ms-traffictypediagnostic: SN6PR10MB2591:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2591ACE7600D2153F92A75A4930A9@SN6PR10MB2591.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nAOkyb0lOXftbhOeHsBQEJYZ0ZAjOXZ7uLDD7N4kdce5bs+UKNIeDvXoN86vEgXGqL45qGE4cYzlbC8hZXE6Dm5c5JmHREAeUK7dofCh0lllqiwEoesJuTw5Hl6uURAPyFu/iGY1Ltgt+ybhkdMEG2/FAwEwKLxuzPnN6ysp+cWL0+gxr5jBgUMq/FEzMfXN5wYOIl106mYOzFKy9ZGN6h9yYjOrZhBR6wDJm6cGjplQcUDSJd0KTwn98UwkKBHTotPCE6oUUlwZAEVzHcXJUQ8s3nznTx3YqKnK0xyBi55PW8sINaYiSW1/kipddopb5clNd9hf3CWKGCAGUucU5A9oKpYTXIFXKobnuJ0OBGNpTCsttwP3kii7+9J/C1C016YlAzl2XJ5q8ih5VxjAB5QmiIQKvt23qAhhNuyTJCZ6TZ4+AR3tPznlVellxMXTD56nR6br/gL/apCC8yA4n2ku2q+lPbXwZF8Ogv9Iz47p0bsRMqlOeI9X5shC/OFhzyCxeKB5wULkV/qDSOCjAb8IHJlFNe91ERQvxDkDD2t98cXrf9tHr09CffKfjtWx+dcjrzieck7xH+qv4uZhUBxZcnbO3rkDL2Va8CBZuKy59+yTrKm8nhsODOt2Z0gV+cKs4zNjXgtCOgeUZ5/COeR+KFnLFSKyNQRRSsgCgnjggjsAoyScmbA47UzNI7Hgg7Mo+Km/9a+LOmj7Jm1zUvmowWFF2PYXzTD7WVTwYQofrY9GrsVGyNJUOcOqT+d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6512007)(86362001)(71200400001)(26005)(186003)(316002)(2906002)(33656002)(2616005)(54906003)(37006003)(6636002)(6486002)(122000001)(83380400001)(66476007)(66446008)(64756008)(6862004)(8676002)(4326008)(38070700005)(66556008)(66946007)(76116006)(508600001)(91956017)(53546011)(15650500001)(36756003)(5660300002)(8936002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wwBq1ZYwWQNunpe+ba62XxL6Ez5KcZa/tATNsBjk+7uocKCM5P3XU/FUCn67?=
 =?us-ascii?Q?jCydDrFhqoNS81bLnwKMb94c0Nq44vCMJlEtxCmmNWoQO0MnJZuBDcrflF2f?=
 =?us-ascii?Q?ZYvBme2/vdFbaUSiCXJluDkF/qfGKxkuyaz+LEiAeLgEAQKUPoUcCtYRyqFK?=
 =?us-ascii?Q?ar6HSRp7jBBeq55OZn5scAlcDB3yb1Ryu7y/m6pLwyyi0ghXn17RQp3/KycX?=
 =?us-ascii?Q?RCqZy4IBYM6KZmEbznVTZ8wNAzV44rNLXxc02alks1VU+fCHuyYHT/6iC3BE?=
 =?us-ascii?Q?8rqPganwjZlyHy1shbSzzwsTF6aZxPhyHcKbVEmAv4WWdmLNZUvy9wrz+2Hy?=
 =?us-ascii?Q?/2zG4CCUU3Nadx3s9QfsCJ149bOXu034JanXcctOxyqPRgcj1jafQYBAr1x1?=
 =?us-ascii?Q?ZFYZsrhfvxxWgAgSrZlDjNX+9yh8y/KwX7VRd3FtLwelhEGSu0gaFBzI9NPY?=
 =?us-ascii?Q?SwLkrowLibbk02mIBW4+5tRW6w3EQhatWXfw/Wn8dfa8r58nOP6WOEk9kckK?=
 =?us-ascii?Q?ps6h0ji7LSBqUEmqPXfbLRLck4AeLOPN8xC7xl98dKEUO7eYUkCQxxWJQjAz?=
 =?us-ascii?Q?oWEFWCNsiA4IfrqGh0jx4u37dukEpxWy35XHY9oQuhvhp+65yECzBHFv9Iwg?=
 =?us-ascii?Q?HYIyMYEcYJIUhr1dPiptZl+UNIqvUyBJIJbJHhuWYhkO6CtzLD1/hpcVWo7E?=
 =?us-ascii?Q?lTv5vRGJKsvWahk9Aop6CYaoVDZEv2CPMYbavlQKQlxP8rAvOE+iQJ5CeHEa?=
 =?us-ascii?Q?+nUY2Gy5xbvEdnPF8UhyCAjmuyUpD3ytY8WXUH7pJxZxqpaiRi5RJA1FByy1?=
 =?us-ascii?Q?qacsFon0h8iJFDXQzlNsr8hEUTYYkP+MlcVBpMgw/ceKtzdQJr6JnYGomF3D?=
 =?us-ascii?Q?l7tbmpUSFUlz0cZcG/Aw0lx1cA4JeltfNhBDGMLTY/4nVbfu80QDfl7bsbhT?=
 =?us-ascii?Q?5rNkblEO/GX9YSvyjWWxu00TrQ86YYDOvdcK/3+fBCxEnuBinIFTkGWTo3Dn?=
 =?us-ascii?Q?yl84nUBzVddVqvaDGi6Ejavixr6CyGD+3+hgtK9aB16WIYUmvvMOGRMkzfsc?=
 =?us-ascii?Q?KrfWKH+8802oug4Og7dMqb4gOK8XZa7oYuqrnImGHv0r3x8x0wTTbxQykmlT?=
 =?us-ascii?Q?ummbPmPje6uKKiOqCT5TSJOXLWaos+P8uwWFCBOlCgdE0s5Xk87CU9oIRTEr?=
 =?us-ascii?Q?SpqlXKRIj1ZxGE3TBsoW+ji7L4B7LFVTYgjGfQvf2YVlpOFQznBh1rHcZZeY?=
 =?us-ascii?Q?J7og77hjQZIr9A6pueQqGzXdxo0UR20iFH5Jr1wsJKrfQ6yzVXGkMmzexVaF?=
 =?us-ascii?Q?T/oNkoCTaAL7hrLibXcpHA5Mp9Ou5dGqBUk6WalLzVg3vTyHy3ZXSVcDcr15?=
 =?us-ascii?Q?nJ70063UywzW4oLn627CheT8mnSY+3XtJOz3e+XshEe+YzRazTBw51/NSkal?=
 =?us-ascii?Q?RN9w5I4sbGf4LdGMnQSDs98gftEvwlRx3yJYDBvq4TdLHGFP+H+KfTbU1SYY?=
 =?us-ascii?Q?pChPMl08cVVBPR15nds3AfyT+wuvTudLFD0pbpXNPM7lg8u/IyHKHPccBkZ9?=
 =?us-ascii?Q?6yvpEKLvWzxERO1nYpmp3oTMPYrwtdBauN4VAmVclQwhjZrn+SftOrELttXa?=
 =?us-ascii?Q?4zosFQrgvLh04ckGQHlUyS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FFE1BDB6D04CC459E46FBFBEFC25CCE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd039e67-13c9-4e23-e852-08da021e1cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 22:42:38.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veYChF809BJz4YDE4mvv9ATM8/f0rYPWjVykE29eZ0/GxdH/9P7y0Sywtl4KPXjODthyA3EyQ06mBEaBc1CsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090112
X-Proofpoint-ORIG-GUID: WTqOTlnHbRO1SobH5mOH46AcphQMWUP5
X-Proofpoint-GUID: WTqOTlnHbRO1SobH5mOH46AcphQMWUP5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update find_in_sessionid_hashtbl to:
> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
> . if courtesy client was found then clear CLIENT_COURTESY and
>   set CLIENT_RECONNECTED so callers can take appropriate action.
>=20
> Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
> record for client with CLIENT_RECONNECTED set.
>=20
> Update nfsd4_destroy_session to discard client with CLIENT_RECONNECTED
> set.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
> 1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f42d72a8f5ca..34a59c6f446c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1963,13 +1963,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *=
sessionid, struct net *net,
> {
> 	struct nfsd4_session *session;
> 	__be32 status =3D nfserr_badsession;
> +	struct nfs4_client *clp;
>=20
> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
> 	if (!session)
> 		goto out;
> +	clp =3D session->se_client;
> +	if (clp && nfs4_is_courtesy_client_expired(clp)) {
> +		session =3D NULL;
> +		goto out;
> +	}
> 	status =3D nfsd4_get_session_locked(session);
> -	if (status)
> +	if (status) {
> 		session =3D NULL;
> +		if (clp && test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> +			nfsd4_discard_courtesy_clnt(clp);
> +	}

Here and above: I'm not seeing how @clp can be NULL, but I'm kind
of new to fs/nfsd/nfs4state.c.


--
Chuck Lever



