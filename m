Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FCB4B8DA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 17:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiBPQPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 11:15:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiBPQPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:15:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AE2AE064;
        Wed, 16 Feb 2022 08:15:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GEiNWA005395;
        Wed, 16 Feb 2022 16:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B94sPqQSiJqkBOd+fVnAEcGZMGHwkIQ+EnDY4kL+smM=;
 b=WLFEfc64ErvNDXKVmYaN4gFGqweH4qBib69fnBghZpcW1gr1YlUHylk8mWE0vuX0/EAT
 MkGGP9Co0pRlBF7JZ+yquMYc3sehXMCrJSdmPbsER8Ff7Snws7H9rj1hC8UVwmhQQ5eP
 ilQ7sXnikxBpPRYKASt771K82B7wbCj2qXmfF37+pwry5aOr8Koi/gfrp+Vxltz44ZtN
 2lTqYvXXMORBvMyFRAExfINTygw+YZ5gIqM/PRJ8GbpDBQKsVNEfT7QPDRogFD9sY/k8
 nYDGDRTeM02MALNvGrl7JvpvdhY9IChCdfE3LtZXLEbb5yRao9g3Tb+szum5Vi2XPQ6U yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncatjje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 16:15:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GG52he093735;
        Wed, 16 Feb 2022 16:15:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3e8n4usu40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 16:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzV6/q+8bx4pSFS1MMMNfMsNzjRWwIWBRC+ekgbSJVO4/gfFQ8+Y7xHOFlAJs/Qa5xernIQBSaOctJj1OGYTAxCnE/NaNA/AJxhePZdtfXTxW0LPr6xjf+cRlJZXpuTQ7/wTpjN1ydDRTR0Aet0XgVCRC8R3lZ8eCmsWiUrgYKth38pTzZcgM1JYiybE+yMwGJ4WSbCSbTcn7Pfu20d0P2tEFASh1ZaLCjFzwZv2UPi2cI7Pxb4SZT/wlfG7by8AVYjdlQuMMYIQi3skMVDuXltE3k3VkP8LQSrGC0iwzYnLua7QbTVe6M9H6DmhPwl/FgzjXd5un4DwQSH0TOMXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B94sPqQSiJqkBOd+fVnAEcGZMGHwkIQ+EnDY4kL+smM=;
 b=dunQqISBj2dj2B3r4JJ75vByhJn+Rrn2g6oy3kqWJQDmiIeOGcQFlkOAPux7C63nit9sdo1rIJOJ3tajNaP0E9yDaXOZmiPGsDLJ6sV5emsqIn7kjkD1bLSST9Z5Lw3ZZXFabyY92j2Ofp2u+Mpuql1ud4R6d4nA6VQEt7UbfVKA4dF9W70FlOu6T8a4mgx8W3caO1zsxt+2eVarHuRx2G7mJ1k3mEllniR2H7ISQt7NJaaLzWIyvvkx2cMfhfr2RjTxPFXbamxLnU+wf/k8Vg2chZmpgUFEQ5stQhZx7baSjw9r60le9Ja47PkWEC3Ntkt8o3p5P/8nG2og9v+PDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B94sPqQSiJqkBOd+fVnAEcGZMGHwkIQ+EnDY4kL+smM=;
 b=vcHxiwL7EXz0gOUHzZIZlQpNxpqrq1zfYt+NTq5pE/vHw4Axw/lIM69giOopVYXhws/BrfqWNRu3/mePWKIQNcM1s+2f57a2vn2WAayEnqbxPvIAIXxXTgW9nihi/SQeSfcty0Nt8sG2sGTGT9UYh+9TSuzQu8CQvTUUdycBWhQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3611.namprd10.prod.outlook.com (2603:10b6:5:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 16:15:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 16:15:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYIDwrUbH4vFbDYkeTHocB/S7pFqyU304AgAEXOACAAGm+AA==
Date:   Wed, 16 Feb 2022 16:15:10 +0000
Message-ID: <6553DE77-F4CA-4552-82C1-46D338FCAE44@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
 <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
 <b76a9b30-89d0-c4ab-a1c7-0ca1a1ed6281@oracle.com>
In-Reply-To: <b76a9b30-89d0-c4ab-a1c7-0ca1a1ed6281@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5ef12a3-5d92-4300-4f29-08d9f1678191
x-ms-traffictypediagnostic: DM6PR10MB3611:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3611731D21AE95D0091739D293359@DM6PR10MB3611.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYt3Z/0d3tgGY00wDyARA67tb1rh8XgOxIJJOdhExZf15kgO1On7I2W6MUVeCd+o/T6NnYLephQKMSPuHXiYm7WIPs4JxeMli5/zbxZUlCEDeHHDhXLTxg8UAKa5iUoa4DH6RuYCnm7YRC0peJsur28osPIq1zi+NcwDnAYJjcxp4sPTcwR0aWsEjj3Qc/6hdoXssKykh/X56qlol7nEmpN7iRN4QqFkbhavMn2+8lIzzNgEJb7Z9qXeoJESy4svi06jpS5ENwS1qi3EGRELzin4i8RcHEW/ee5lb20Jzgzu3p6o4QAhrJ1Sf/nT5ZRvikuQyeTPGvU83VRTkt/3ubCtUj+nfYzL1C4Evg8RHBgYT/q+VhVq/9V5tqyzZK7ipD0O6tsdtTIZV/+JsJDK4aGOejXkCOcDCrvNhCmGqt0wRXOz1L4bFI9ZSxTbjX7yVAFOj2A7XewnM6Gq6soHuxtS/7XHINv3smUHAsrNlfjW0vReZEFR/VAnkDwC1zkqIBnB9hPtBheiUB2oGcoWC4wXfyzDZjrIwqSVv1ygJP/cp0vkbtp6Pnh0LpSB2i2jJMr+dR6jlj9+mIIw7C5Fqfsm+SnsqJnNRwWlOoiUiR9s9XKEdrW3QWzPXufGCLeCRCjBNNu0c67/V0HKS4LsT5XGg4iKfRpv4lYe7GB2tcC3+bFbRjSHQlFL5894u9Yc1lLdx4azXAJ7+nCOKWlE7JQsKFOy8Fsq9Wdqo1D5cQoGXezugQMUdZgRIuGrX08wR/EBFt8PdoX5HOCIFq1P2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(36756003)(6512007)(26005)(83380400001)(6506007)(30864003)(122000001)(6486002)(2616005)(38100700002)(71200400001)(2906002)(4326008)(8676002)(8936002)(5660300002)(6862004)(508600001)(37006003)(54906003)(86362001)(66946007)(76116006)(66476007)(66556008)(91956017)(64756008)(66446008)(33656002)(6636002)(316002)(53546011)(38070700005)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jONuvpyh2ml93dKV6A8gDqLDl9J2HJzeXQThtUbGZzqNiedGHM6nJh/q+cGa?=
 =?us-ascii?Q?ir3UJgofxeh4OjyeE2BAwE6rysjGMUqKfKGzjFdnqqV20ygCRGKAZu7SQbRW?=
 =?us-ascii?Q?UnKEuYFj948XboNcuZJu91sltA2ynl+A11hqoxQFx3fTifcGzYwSbHevcE/h?=
 =?us-ascii?Q?WwT4PQqy2osY9mQyVsJ4I2cMpkUNk/aznfhcP25dQxR/BJEO/mn2W3tHtYsU?=
 =?us-ascii?Q?MJOwMb2ZGS2jAKU9AzgABTy/SQQDy+0UCIXDY1HvadUGEPNoWAFnTqcSz9MF?=
 =?us-ascii?Q?L6BIXSbBvbEg9X9xHuafZ4hr5T6WJUkjp6pPIaLd7GSbeLsj4HxeEzvJLNg4?=
 =?us-ascii?Q?f/xpbAOKBdwZ4uwX60NGypyMgNaWFIz4NBmytEZEwtPKJgmZwb5HIzJvDSn6?=
 =?us-ascii?Q?iyVbO7JH0w3ZGBhYZqZy0Y/aKyadBqmfntbQXW6UvLyVejYPBrnlkO5J2CPI?=
 =?us-ascii?Q?Pmet/SFaT0GGs8UFp2LussR6Rs/0/wIatLTT45gSuJMecp2dNFQakSwuB6EV?=
 =?us-ascii?Q?EOk93wbWO1ng9gIfLa27RUt/fp+Vkpl0/ZR5BrsyHTFE8PVzzVlPjfUiDRZr?=
 =?us-ascii?Q?PjhxUyTjkuRn8v0v6MijKNOARXMObBpBx3rBciMH9eNbD4hzJ4F5gOQYTj1h?=
 =?us-ascii?Q?oqn28AbGMisD8fao71nGFWqQIgD1kgpvVBaPYHAsrPXhFumQ8aFF9GeTvbs4?=
 =?us-ascii?Q?NKy/LUz0a2Xyvt4e1EnQPv29tHM0rZ3u+p8+hEaSXTxOI8oWqOBIC3+yGXi1?=
 =?us-ascii?Q?fKIgm2pohKoZp49OJ8uFjgxgGkpIl9IEITplrjsuYNay0MgnplGupzjrQu8/?=
 =?us-ascii?Q?v2xfvymAyHMeGnfJRiHjtyN2g2I0jb6rLoNbT4DXiwrB5U42yvPT8i1K/lu7?=
 =?us-ascii?Q?H0tKD9nvDF3t9+iI7E6ffgFWgIenHfOF3D3767FWKlzu62+swdpRQEgDipxq?=
 =?us-ascii?Q?nnPJP3FvjTWbPb6h4avOpiSVS3BtwyB1WutghG5tTg3twouwDTx5TXcElUlj?=
 =?us-ascii?Q?I/Mnx8Fhcc8/Qz+olP7Fz5chOngWqei8Zo9AbagjNIMngPDlpfJ0gfo7EeGk?=
 =?us-ascii?Q?IGAx4PBzEhtaRH2jMjM/jq20n/orHOoz3CpfpOEp3xpU4ZDfURBJriTT0NFy?=
 =?us-ascii?Q?XAhTRmHsgh0lLNngaZNJxpmGlYxA+00KajtB4Y3bdta92G+9iMtSa0rhZd79?=
 =?us-ascii?Q?BnEWzqbqMT8rhrfHAPnry9Sa+N+QmuL3NZ4sefzE1eMjFwwLcJvGKK4KkO0O?=
 =?us-ascii?Q?H6jj3WcL8CT64zyCQOplDVvJPBN+SJoRWEA4Twq6pUlnpptVi2SpojoCN3Rg?=
 =?us-ascii?Q?NL3aKMGB+bZMR2IZgFcF2MYcTMFF3u1e+5h7CW+5feORqegWJt6CAcXujAV8?=
 =?us-ascii?Q?RVlL7icjhWv7LdFG2ex9PeYSY2H7PgubDRCXliQC+b/OBHDggbJq+1t4M1eR?=
 =?us-ascii?Q?ZkmnYsKUR22MJH+MPhlHLkFoN8GlkO7V/EaGXVbUGJGLlRtnvs1EQa+SNqzT?=
 =?us-ascii?Q?3cR1e4pqWIXycip1QHMlSA2G3Md1KPQTLxd/1x8prNuGrNkZ2fqK2HEkKePC?=
 =?us-ascii?Q?DpSNFlCHPn9WYomHAe+Se4sL+1rJ+ZT9ErZhYJtG1bne28xiZwsq2DZSWZrm?=
 =?us-ascii?Q?ZyUm+NDENpqfhLjp0mMUYkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D48337AB2279C444A89239E3590403E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ef12a3-5d92-4300-4f29-08d9f1678191
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 16:15:10.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a56MtgQNGNHDVKk71ciVa6EcikhSIi8vwkYZyOxER+764px+Yt7mDZWKWj0oouQuBw2yBsbk20G9iocuTP/xOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3611
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160095
X-Proofpoint-ORIG-GUID: FwfnUphk11lPT6_ZUCrqHS_cl93UF9PI
X-Proofpoint-GUID: FwfnUphk11lPT6_ZUCrqHS_cl93UF9PI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Feb 16, 2022, at 4:56 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 2/15/22 9:17 AM, Chuck Lever III wrote:
>>=20
>>> On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> @@ -3118,6 +3175,14 @@ static __be32 copy_impl_id(struct nfs4_client *c=
lp,
>>> 	return 0;
>>> }
>>>=20
>>> +static void
>>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>>> +{
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>> +	spin_unlock(&clp->cl_cs_lock);
>>> +}
>>> +
>>> __be32
>>> nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *=
cstate,
>>> 		union nfsd4_op_u *u)
>>> @@ -3195,6 +3260,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>>> 	/* Cases below refer to rfc 5661 section 18.35.4: */
>>> 	spin_lock(&nn->client_lock);
>>> 	conf =3D find_confirmed_client_by_name(&exid->clname, nn);
>>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>>> +		nfsd4_discard_courtesy_clnt(conf);
>>> +		conf =3D NULL;
>>> +	}
>>> 	if (conf) {
>>> 		bool creds_match =3D same_creds(&conf->cl_cred, &rqstp->rq_cred);
>>> 		bool verfs_match =3D same_verf(&verf, &conf->cl_verifier);
>>> @@ -3462,6 +3531,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>> 	spin_lock(&nn->client_lock);
>>> 	unconf =3D find_unconfirmed_client(&cr_ses->clientid, true, nn);
>>> 	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn);
>>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>>> +		nfsd4_discard_courtesy_clnt(conf);
>>> +		conf =3D NULL;
>>> +	}
>> I'm seeing this bit of logic over and over again. I'm wondering
>> why "set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);" cannot
>> be done in the "find_confirmed_yada" functions? The "find" function
>> can even return NULL in that case, so changing all these call sites
>> should be totally unnecessary (except in a couple of cases where I
>> see there is additional logic at the call site).
>=20
> This is because not all consumers of find_client_confirm wants to
> discard the courtesy client. The lookup_clientid needs to return the
> courtesy client to its callers because one of the callers needs to
> transit the courtesy client to an active client.

Since find_confirmed_client() is a small function, I would
create a patch that refactors lookup_client() to pull the
existing find_confirmed_client() into that. Apply that patch
first. Then the big patch can change find_confirmed_client()
to set NFSD4_CLIENT_DESTROY_COURTESY.

What about the other find_confirmed_* functions?


>>> +		 */
>>> +		if (!cour) {
>>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
>>> +					NFSD_COURTESY_CLIENT_TIMEOUT;
>>> +			list_add(&clp->cl_cs_list, &cslist);
>> Can cl_lru (or some other existing list_head field)
>> be used instead of cl_cs_list?
>=20
> The cl_lru is used for clients to be expired, the cl_cs_list
> is used for courtesy clients and they are treated differently.

Understood, but cl_lru is not a list. It's a field that is
used to attach an nfs4_client _to_ a list.

You should be able to use cl_lru here if the nfs4_client is
going to be added to either reaplist or cslist but not both.


>> I don't see anywhere that removes clp from cslist when
>> this processing is complete. Seems like you will get
>> list corruption next time the laundromat looks at
>> its list of nfs4_clients.
>=20
> We re-initialize the list head before every time the laundromat
> runs so there is no need to remove the entries once we're done.

Re-initializing cslist does not change the membership
of the list that was just constructed, it simply orphans
the list. Next time the code does a list_add(&clp->cl_cs_list)
that list will still be there and the nfs4_client will still
be on it.

The nfs4_client has to be explicitly removed from cslist
before the function completes. Otherwise, cl_cs_list
will link those nfs4_client objects to garbage, and the
next time nfs4_get_client_reaplist() is called, that
list_for_each_entry() will walk off the end of the previous
(now phantom) list that the cl_cs_list is still linked to.

Please ensure that there is a "list_del();" somewhere
before the function exits and cslist vanishes. You could,
for example, replace the list_for_each_entry() with a

    while(!list_empty(&cslist)) {
	list_del(&clp->cl_cs_list /* or cl_lru */ );
	...
    }


>>> +/**
>>> + * nfsd4_fl_lock_expired - check if lock conflict can be resolved.
>>> + *
>>> + * @fl: pointer to file_lock with a potential conflict
>>> + * Return values:
>>> + *   %false: real conflict, lock conflict can not be resolved.
>>> + *   %true: no conflict, lock conflict was resolved.
>>> + *
>>> + * Note that this function is called while the flc_lock is held.
>>> + */
>>> +static bool
>>> +nfsd4_fl_lock_expired(struct file_lock *fl)
>> I'd prefer this guy to be named like the newer lm_ functions,
>> not the old fl_ functions. So: nfsd4_lm_lock_expired()
>=20
> This is a bit messy:
>=20
> static const struct lock_manager_operations nfsd_posix_mng_ops  =3D {
>        .lm_notify =3D nfsd4_lm_notify,
>        .lm_get_owner =3D nfsd4_fl_get_owner,
>        .lm_put_owner =3D nfsd4_fl_put_owner,
>        .lm_lock_expired =3D nfsd4_fl_lock_expired,
> };
>=20
> Most NFS callbacks are named nfsd4_fl_xx and one as
> nfsd4_fl_lock_expired.

The existing lm_notify callback name is correct as it
stands: nfsd4_lm_notify.


> I will change nfsd4_fl_lock_expired to
> nfsd4_lm_lock_expired as suggested but note this inconsistency
> is still there.

The usual practice is to name the function instances
the same as the method names. aef9583b234a ("NFSD: Get
reference of lockowner when coping file_lock") missed
this -- the middle two should both be nfsd4_lm_yada.

I will add a patch to rename these two before you
rebase for v14.


>>> +{
>>> +	struct nfs4_lockowner *lo;
>>> +	struct nfs4_client *clp;
>>> +	bool rc =3D false;
>>> +
>>> +	if (!fl)
>>> +		return false;
>>> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
>>> +	clp =3D lo->lo_owner.so_client;
>>> +
>>> +	/* need to sync with courtesy client trying to reconnect */
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>>> +		rc =3D true;
>>> +	else {
>>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>> +			rc =3D  true;
>>> +		} else
>>> +			rc =3D  false;
>> Couldn't you write it this way instead:
>>=20
>> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>> 		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> 	rc =3D !!test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>>=20
>> This is more a check to see whether I understand what's
>> going on rather than a request to change the patch.
>=20
> I think it works the same. Every time I see a '!!' it gives me
> a headache :-)

Indeed, it takes some getting used to.


>>> +	}
>>> +	spin_unlock(&clp->cl_cs_lock);
>>> +	return rc;
>>> +}
>>> +
>>> static fl_owner_t
>>> nfsd4_fl_get_owner(fl_owner_t owner)
>>> {
>>> @@ -6572,6 +6965,7 @@ static const struct lock_manager_operations nfsd_=
posix_mng_ops  =3D {
>>> 	.lm_notify =3D nfsd4_lm_notify,
>>> 	.lm_get_owner =3D nfsd4_fl_get_owner,
>>> 	.lm_put_owner =3D nfsd4_fl_put_owner,
>>> +	.lm_lock_expired =3D nfsd4_fl_lock_expired,
>>> };
>>>=20
>>> static inline void
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index 3e5008b475ff..920fad00e2e4 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>>=20
>>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>>=20
>>> /*
>>>  * The following attributes are currently not supported by the NFSv4 se=
rver:
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index 95457cfd37fc..80e565593d83 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -345,6 +345,9 @@ struct nfs4_client {
>>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>> 					 1 << NFSD4_CLIENT_CB_KILL)
>>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>> The comment is a little obtuse. If the client is
>> actually expired, then it will be ignored and
>> destroyed. Maybe "client is unreachable" ?
>=20
> I think "client is unreachable" is not precise and kind of
> confusing so unless you insists I'd like to keep it this way
> or just removing it.

I think we have to be careful with the terminology.

An expired client is one the server is going to destroy,
and courtesy clients are rather going to be spared. The
whole point of this work is that the server is _not_ going
to expire the client's lease. Calling it an expired client
here is contrary to that intention.

Unless you can think of a concise way to state that in the
comment, let's just remove it.


>>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
>> Maybe NFSD4_CLIENT_EXPIRE_COURTESY ? Dunno.
>=20
> Unless you, or other reviewers, insist I'd like to keep it this way.

I think NFSD4_CLIENT_EXPIRED, actually, is going to make
the test_bit()s in fs/nfsd/nfs4state.c more easy to
understand. The transition is courtesy -> expired, right?
And as you say below, the mainline logic has to decide what
to do with one of these clients -- it might not immediately
destroy it, but instead might just want to ignore the
nfs4_client (for example, during lock conflict resolution).

Try NFSD4_CLIENT_EXPIRED. If it's awful we can switch back.
"It's only ones and zeroes."


>>> +#define NFSD4_CLIENT_COURTESY_CLNT	(8)	/* used for lookup clientid/nam=
e */
>> The name CLIENT_COURTESY_CLNT doesn't make sense to me
>> when it appears in context. The comment doesn't clarify
>> it either. May I suggest:
>>=20
>> #define NFSD4_CLIENT_RENEW_COURTESY	(8)	/* courtesy -> active */
>=20
> The NFSD4_CLIENT_COURTESY_CLNT flag does not mean this courtesy
> client will always transit to active client. The flag is used to
> indicate this was a courtesy client and it's up to the caller to
> take appropriate action; destroy it or create client record before
> using it.

I get it: The flag names should reflect a state, not a
requested action.

But I still find CLIENT_COURTESY_CLNT to be unhelpfully
obscure. How about NFSD4_CLIENT_RECONNECTED ?


--
Chuck Lever



