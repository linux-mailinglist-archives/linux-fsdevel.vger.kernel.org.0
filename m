Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9304D769D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiCMQFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCMQFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:05:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ADB1275C;
        Sun, 13 Mar 2022 09:04:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22DAVFle031068;
        Sun, 13 Mar 2022 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SRZ0f12vQE3XifCie7pepIE5euCJOZsefzFqgoFy5Xg=;
 b=DaeE1yzISgAPwz5HDUGnXkSAtVMGN722pmyZJkkqtxbh6V1g+oyymVAXZ5EnY0JlWnyZ
 /4ZogICtPtHIe2AFq8BGIWexRTxdQYx7dGBQFohLlE/yT/lpq/aJRcrZRyiUZtS4VR7g
 3NoSU1aedLh5T+TYF1Dvdp8beSg3dXe38UT8xKoCOk0ECnbdYljZfrsr/BSPqaNWO7Zy
 QtTMhBEndbm+q6CO1IphS6qHL9jvR7HLfzf3GNvkKCIC+ou2YceEYLGKzViYQpP/Mpqs
 vD5cPsDonmA6ggDaxZl+yOYrWXx103n6/+3ietJGZwy3dgzUvPBLKCvNzOS4/HnMXCNs uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erkd9svxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Mar 2022 16:04:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22DG1fd7040472;
        Sun, 13 Mar 2022 16:04:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by aserp3020.oracle.com with ESMTP id 3erkb032gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Mar 2022 16:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StXaH+ViO5VJdJaA0rzQlzV8ZrDSpjLufTbc5OtLDtEnSbwTvVSDP9tGgYGBqUcbtwe/up53Yh1nsZz/XSFFKwl5/X1HVV35pVIcFUTi1hC2QVvPfjiWs6v4RhZ24ZyWCaKlgJbOEcNk7kK4lgx7XMJvT35qm4H2c1wt+QlSKefUMqqTWX4KpBHEwsO5TaPUJzhLZmyKib86OkRZkbPYvMNIWAKuj7WyiFEfkGi719t8pUhLm0IcxxoQL1WENvCyBlvZYfz66PL1nJ2788Xnum1FpVCN5/pDYGtoGgFtYVRJzmEtgZK4sAInac/vxjrW6BzbIX0oXEEgG4tIjdZu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRZ0f12vQE3XifCie7pepIE5euCJOZsefzFqgoFy5Xg=;
 b=AXMSEwha+6WBFG36XrZgfeqmEoQUF4fuOjOyfQwUWxxK2vDWmxL5WS3pN9Q0vf3gISeiolRMRWKUHKTambFT9kPxyVAeI95oAkBGTDzzAirFtL9A3MXvNhuxdlLggzEmjPd2g6BsffJKYi2gXIbROjm33G/JCwDpk2CGuIujc4Zm8GL2rn7DG+gDCm1ORUR61FDNcTYz4N3lwaJsR0o7IB/+7KGf0JCzvO3qSxn84sqIWM/49o+LHQ0qLH0Jh/sAs3AhVD/ERnWwuj5hRu8ClJt6at0qyWzewV33d1EqdpGBUUktsdTh8BiDFXKvAyihHerd1u59ANkTTUiAUasUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRZ0f12vQE3XifCie7pepIE5euCJOZsefzFqgoFy5Xg=;
 b=VVomW161IXO2WMVjJLDP7lT966auk+cku4eBcfYL8CHruMUnJ63aPp7oUBZ1T/LrmQmCYBMdNVptU+GNRfDkFYuJoEGK6ErLMNDCSqXmmfbLFlfUiJXHPcRnfya9n+erJIFFaIVU5U8Um13PsjRWbGQk0BlmHIOYaj6lYr/R5Pg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR1001MB2326.namprd10.prod.outlook.com (2603:10b6:910:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 16:04:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Sun, 13 Mar 2022
 16:04:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v16 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v16 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Index: AQHYNbbOt4lEkyAZMUuWU1WhGW7wyay9fJKA
Date:   Sun, 13 Mar 2022 16:04:21 +0000
Message-ID: <EEB335C0-818A-4510-AA51-547CB9F57DF4@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1647051215-2873-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28323f99-2a26-4fad-1edc-08da050b22fd
x-ms-traffictypediagnostic: CY4PR1001MB2326:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2326D6DD73D4BAB96A986F20930E9@CY4PR1001MB2326.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfRXBPAvkAfiiUjurCYGMRzOdJ2L/ajq1bvG074hvQFSXRyZo2iQefwKR4l5/+JiSaVgpiJqKmwXBPc//sjr/+ML6iXOGat5MsSlk+KrHQnvoOvU/4TJ57S9i5kVtRC28V0VZao7/pxAr8pS+pG6g/2Nik6IgCmtLoHPDvGe9/V5Q3C2R0nPSSDtUyLUYeHcwF8vFd+MGhg7Ib71CWI87e3wxkwI+OUA/50V+mcLKrqgi9iXcs90IG3WLc0pZOOEDatbq2X7oOH9tMovJILHNucB8dcfsWC0wRor7A3945SxoxMJ7IcojZjbesjV2eIAdkiaR0Vlki3upomgYXQcWNlhiZzb4CIp/Fbn57y0pDk2NVKKb3j7Q0TzvHePBr1ElhhKn6QWSTnGqZtgqR+i1qKhaLeu4nj/2G7L+oZ2yEJJ3LjrJuL4Zfeg6qVhLltV3iAqEJJCiWDXLAV5h62ikdcrM5LLEIJ8vQ402OW64yiHc4Lq9S/RxUSwyjZwQLfOjY50AqoUqLYxeBkjTNXYqIhHSxUcIaTdHnKZQt1ESRYcji5LFwRy3P7k0lME2p2HffiXlhiC0TGMmFoImaY/+RlNXfTWdDRjM9u+Q9PMrQw64P2Y6WRxTR6uBBeXvRLKLt0aw5u4z329KiP1iQddEJR3TtpjV2ksR54n+GB3jPMad952u8S9xZPcZKMLyx60FTaXJuKIboJIISECLGANgzOXOlHIOz+/dPCKRX1H+xWSPtA6MMsyKb9QH0Zb5o4o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(76116006)(86362001)(508600001)(91956017)(38100700002)(6862004)(4326008)(8676002)(36756003)(66446008)(64756008)(8936002)(2616005)(37006003)(6486002)(66476007)(66556008)(66946007)(54906003)(6512007)(6506007)(15650500001)(53546011)(2906002)(38070700005)(6636002)(26005)(316002)(186003)(5660300002)(83380400001)(33656002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDDjIAGz0PuuE3a8kMdqzZrRpJTHR48Wg9JK+easkvHphV26jcinZ/4PBsth?=
 =?us-ascii?Q?7gyfssuZVZh4sePM9pzkEhAQiB6CiQtazAQH/OyiCg2Dbm9jDTjYwc5B7OJ7?=
 =?us-ascii?Q?Y6dAMNe9s4xUfwqg5VJDtL3FHFixdMeiVn8dpKH/gXC/FQp1YaFQjy2rj/8W?=
 =?us-ascii?Q?AeRJjTtZKzi4iPszjawNKPtgOzC8/QVO0sH0roGCb9q3fafT81/2tJQ0RZKV?=
 =?us-ascii?Q?qTA2yNR6mfDBcfXo0Drt0WLuqP/+3Pa5T0r8QNVhwIUi24DA6LDPLCLNxfP/?=
 =?us-ascii?Q?neODbwqEEQQKZsmbkEQ5mvH7f2g7F3G7DDbPtE8iVGfAejB4tgiuwFB7/tBA?=
 =?us-ascii?Q?c4hBz/LVmmQdSpZpZhwFZk16Zd11zyro7U/SFaB1UY1b8FLrFAIx7FI2MdbQ?=
 =?us-ascii?Q?6hLjTT6xiaNePyUxV2UhSwlxNjhzg02gh1fpSdtspp7EF7stSGRlIw+NE70J?=
 =?us-ascii?Q?HzRMayGyoE2Ygm2iouTuEZ1RV0i6PqRGMkUaMa08HElRbrGXX4Hx1s+RTn5y?=
 =?us-ascii?Q?mQ4OQ9cujztw/mDkX0FqAurFsuC4pw/o7qIR14PDS2VZYx9FcoCowc2BTn+Z?=
 =?us-ascii?Q?DaLWl+5X0UHd9E561A+jYZrYXFl7H/+i7mbF1PEiJzyyZhsfG/4YCXMwdgUM?=
 =?us-ascii?Q?WkYzFVGW8pGE+arlx87osdJdehu3SbDyURIedJXYLuaODn23gNofzfKQocZI?=
 =?us-ascii?Q?epRv5aA9SlBlM7btT5+ISYDF5ejdxjrn6/YjDVz/PAw7pz/lce0A1EGns2LU?=
 =?us-ascii?Q?djpVgekwB0aAxf2XlUeC919WfDujkoygk9ASSfsnI9k8zZH0+jpOTSHI1ONU?=
 =?us-ascii?Q?TG4K82NJK4B6/m1/yl9xRx2T2jx70P4iiQG1ApWpdF5gNNrR364V7ujuSt0U?=
 =?us-ascii?Q?vWIfitkzbzkJYYNk1MqKbNDebbEU8Uq740thVQxvA+JNzSdrSamK5IL/6pIZ?=
 =?us-ascii?Q?3SUshLS0bUOxgV8j3sDILO+CFMCyaVeMAgrLyNNPHYUgUE20+BxVsvZMuAco?=
 =?us-ascii?Q?Pc0VhqcUfCg1L+RDJWLqIHV0wN9ccaEXO7424Icg8E8F+FatL3gciey9MGHQ?=
 =?us-ascii?Q?0fpupvcx/P60hNDjhN/FHdqwFOET+Zt7tLTBJexUdHdIWd/3Hbrpg7XNEdiZ?=
 =?us-ascii?Q?vPLWRX+NKNuFPbNJE4L5zZBlqMXXHkUh3a8b+ZOMgFgX3Ry6ws4oeb16sCB/?=
 =?us-ascii?Q?lg1SLn8dFBCEy4RNF6ySj/YvtIKLkCx0IC5ezGq4HEGU+Yc93ilxqq6ei10p?=
 =?us-ascii?Q?Y4F1KUnLHexbqZcYNM4nTJbfiI9I139oAEe8pQwswAHjSIPtXpZLuet4y1VK?=
 =?us-ascii?Q?KaiWKC1aSjjJRVbTHTzqeHo3AdFAHN9dwl2nvud0lVr47EUxZPbMhQNzTi+w?=
 =?us-ascii?Q?gkZ/QrjeVw+jzxZjj0XxF6McDjWYIZmQMPaw5L72oSvGeET8kBqT4enqTuMU?=
 =?us-ascii?Q?Kfqw9+9Qr5fnRUQS+rJf5X7xsXne5hR51e1DUxfgU6ucrye6ztWNuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E265CE8ED87D7A42AC659A2EC5AB707A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28323f99-2a26-4fad-1edc-08da050b22fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 16:04:21.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIN6z5op7XsT+YxHTKA1eiHOODnoXZ1GddGNgP9fI0OTWsF5nA9e0pQEj23DqwGny2vJgqOd+QSzTENMbjkxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2326
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203130098
X-Proofpoint-GUID: k0kcR5B5ZzNAhrTtweFSUTqWGKtS7Ado
X-Proofpoint-ORIG-GUID: k0kcR5B5ZzNAhrTtweFSUTqWGKtS7Ado
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 11, 2022, at 9:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update nfsd_breaker_owns_lease() to handle delegation conflict
> with courtesy clients. If conflict was caused by courtesy client
> then discard the courtesy client by setting CLIENT_EXPIRED and
> return conflict resolved. Client with CLIENT_EXPIRED is expired
> by the laundromat.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 583ac807e98d..2beb0972de88 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4713,6 +4713,28 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	return ret;
> }
>=20
> +static bool
> +nfs4_check_and_expire_courtesy_client(struct nfs4_client *clp)
> +{
> +	/*
> +	 * need to sync with courtesy client trying to reconnect using
> +	 * the cl_cs_lock, nn->client_lock can not be used since this
> +	 * function is called with the fl_lck held.
> +	 */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return false;
> +}
> +
> /**
>  * nfsd_breaker_owns_lease - Check if lease conflict was resolved
>  * @fl: Lock state to check
> @@ -4727,6 +4749,10 @@ static bool nfsd_breaker_owns_lease(struct file_lo=
ck *fl)
> 	struct svc_rqst *rqst;
> 	struct nfs4_client *clp;
>=20
> +	clp =3D dl->dl_stid.sc_client;
> +	if (nfs4_check_and_expire_courtesy_client(clp))

Since you'll need to fix the kernel robot issue in 1/11, when you
repost, can you also just pass dl->dl_stid.sc_client directly to
nfs4_check_and_expire_courtesy_client() here?


> +		return true;
> +
> 	if (!i_am_nfsd())
> 		return false;
> 	rqst =3D kthread_data(current);
> --=20
> 2.9.5
>=20

--
Chuck Lever



