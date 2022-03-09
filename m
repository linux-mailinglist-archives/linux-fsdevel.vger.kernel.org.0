Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89D4D3C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiCIWJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 17:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiCIWJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:09:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7E1201AD;
        Wed,  9 Mar 2022 14:08:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KcxDl023163;
        Wed, 9 Mar 2022 22:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P6T24SPDrz4sZdgP6ihBXP8ps9ztk2gzhxTuIhcJH3U=;
 b=Obv9ok8rKLPzzz+ofdzhX34Ko+SWrXLkr5rctGBwbqdcEOGVr85vnGBtccPaRXPdY1EU
 rD3YYEHnmzuT2m6W4fkKbv3InU3E7LyVh0TYdrIYw7WV090zaQB9Gi3eEcBf0JC96n4K
 3vtjzXGuFC1u73nC6al342pzyKfZmwsQW57+eGnWh2Dgw+web4T9xCsheF+AUe57goMi
 Ub43sE9VHy0T7qaN5IY6pkbYWfGwBH5kt8//3UHZdJHiorHffzPvYGweO6tD53LkU+o0
 mRjan0RABgukSbVi3wHhP63acLxqV916aplhYcdKQz+Qc1oU8pWQJZwA9Bd0i4+22NTg gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0du3mne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:08:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229M5KoI068047;
        Wed, 9 Mar 2022 22:08:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3ekyp36s6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RccOmKebkbPS7XQw91VuzLj+oySs50sa0L50SCK2JHaCgcX2C8i8akBc96mU0NFOyLNDrEcYkL5ZM2iQvRH6jDExGjDQ6OsT3qtcthMnGYhoeaxOSX+/amsvELbbdpQRq52np5Q89jq5RkQmc6o3Q4iHfGZnixF3YXX8iDJcJ9aekZqmnxxcylzlYRywlZ0SrmCoCiRpeH7HXJBd4YF1o1WcRl6+KpH8M4f5szYS8HH+yV75l2++scj0DkbDQw/2vnyLHvev6DguuPnPhojIkOBxUmAc5OafhhLK+FLjHGVjmEAqs/MmMwjyuOiSDkDLw6nf499qQHh4c6++Fwi0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6T24SPDrz4sZdgP6ihBXP8ps9ztk2gzhxTuIhcJH3U=;
 b=XtTrbAyfXvYhOw2cwc1TsgniSfr4cyRx2y2qEecaVWYZ4TEuO8p3ECfzVKiQE3biGxSyjuqiMYnbWBZZp+ZAJk7/8LQj1xYHvnO4nDmNbDLe4fTxICrM0/Omd/Md/UhxcwYQW9ywiFC7ZPcIRSpQ+xTEQzEuwN0WcV45zXtx9fXAn/75l87ewBKz5jrzrZkB0CtBIImO0dqRHw01GP4Wj9zVxmYMsJpiLHtbB1HP+Yx88iBPS7YxOr4MX2DeF6BFgHDupEhUIPJbPguzM6KUNAEAuQlmmTOxS7sqscMpKX4ptNton2EMaeQi9e2H6agtuTdFSB09uBPZTjPsCq2msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6T24SPDrz4sZdgP6ihBXP8ps9ztk2gzhxTuIhcJH3U=;
 b=D0f80iyuGBICb1FIZ+4J4PRMCwXzm1AuhTO+JJfgFX7nMWY14X/AH636RVhnIF8NdUzYDr6tsZKjztXprAXM+WRkgwjLoFcH9tHqNi8lZCxVcB4iPaNneXHHjW6c47aBWfOq39ZVam6yNamznjrMFrWRaeng5N5iq5L1KVxFxdo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3218.namprd10.prod.outlook.com (2603:10b6:408:c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:08:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:08:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v15 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Thread-Index: AQHYMCkvk8FtFgWVO0qI48tBE1yYGKy3pBYA
Date:   Wed, 9 Mar 2022 22:08:28 +0000
Message-ID: <EEB29573-9801-41A7-9CAF-9E3AE1B23D6A@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-7-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1646440633-3542-7-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5d8ab7-9173-4fa5-4699-08da02195730
x-ms-traffictypediagnostic: BN8PR10MB3218:EE_
x-microsoft-antispam-prvs: <BN8PR10MB32182AD91827D48F93EC30A8930A9@BN8PR10MB3218.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNr1KJerpZnorF5A9j/ZXIk3qexR46B5SHQI2K/3IKHCrvIsv9FDTUOo+ANYeieG3lIBB+KNoaV1MBzY0rpp5UDkq/OHbEP8sJXYHs69hIR0431PZUGTF5TB1itsHPfuW6JAWVZsBh+Ju1Cjdaywe14OP8a8QYKpv7Idk838rJ4Y7S/pdCNgmYqUclf5mPS1RLvZJ03CY2aZy0I3fvh6FIFMcXRqPp/EUvw/KkbdVDUbSO0AdWuoNxw2u0fdnI++85gwEsVzeAMBrL+68T1QfiPVyEracMHby+N5LsEmqrw4YO7LNcAAkn9q1r7PXdus/ui+LtFkiFSBVLmXtxjraB6ext/+izZ1/wXlqN+etv7FXLhsQGf+1OtbFijhVJuU36htY+6b27jq94rppHKl0+5195A/2vcPkjPlsIgyI5vkAGHIy70Kict/GBbl8gH2/EmcTep0Q7f7X0lHWOqJqEKFbAkOqVMJKFEIdaaVQoxfweOX23anUaigIY3rRmDAK5bVi6bCIYJ1s/YKRU7igqVj6TZcX7uKS+qeu7MHhpvWhrOau1J/Xx0T7HSjwkF62CcuMDjFnwIurWXnR9OghcimDt2meZqlKPMykGBm936m0dQz/80kVJH1GH4gQqjyiMyEjMBVZwmf/iU+YQSHwEUae+x/VxaVHkIxoT9Y3Tcm1ybIN4B1ZNHk4XMZ257dZLr1p1pJoUhb0LiwyVOGrXlJaBzo1HuJpJeyRTuRT6g/TohIKufsc6qtL/p3z08X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(508600001)(6486002)(15650500001)(71200400001)(26005)(186003)(2616005)(6512007)(53546011)(33656002)(6506007)(38070700005)(38100700002)(8936002)(86362001)(36756003)(2906002)(91956017)(76116006)(110136005)(54906003)(316002)(83380400001)(66556008)(64756008)(66446008)(66476007)(4326008)(5660300002)(8676002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Po6dmnOIRV101Fai8Cz7peHkloGwTOaUNiNZCwfEKHfQ5uyEwxSEpoVeVFil?=
 =?us-ascii?Q?QLvKV4NzWa+SNGY4iUZz6ILKWH/rJ8k9krIWiKnY6HN6Cll+LjVRKmZeYpAZ?=
 =?us-ascii?Q?Cs6BVB4n1ELzCue2KtsmH9uIJpl1EytZy1GM+IlEYZ3IgQMXQMVWZ+M+ZlKT?=
 =?us-ascii?Q?CAlm7Gia9s529wJehK3javurvZfCs0Yi8e6j0fkwtqxIESQKeg1+MDz/1Rem?=
 =?us-ascii?Q?7HIwJk7wT1v3aTQrM6UgG5y8QGe/ITSglEtPxd22E/wbkkIX5jWTiFKSIKI3?=
 =?us-ascii?Q?7kyWBArTKskilBcUdUHWuvHy6tcFG3oDReglyBvzAUOLrUSAL7Jlu53PPb0j?=
 =?us-ascii?Q?bOaI4AVT2ZiUUmNY57OoSa9itHC/pl4o+W+ouo8OTa+sD/NX+FzqQCzbKqSu?=
 =?us-ascii?Q?5pXfxI1u72I8pjL1fkSsZ6VuMi/YIUUhOQtAmHjcvSYTbQb1evQSkZ0f37Em?=
 =?us-ascii?Q?hZMVxvzUuno1rfJZvpHRhYiUBeVOxWlQAS43DfOEFwtRdUQN+ayZ/dzH3zB6?=
 =?us-ascii?Q?1mm1U3RAPEBlsaTjEt6QZ0QF6llP2ZMFol3HisO6u0LnG+he/maeeAhRIsy7?=
 =?us-ascii?Q?/uVquo9RfVnqqP/kDtohKHiWlo2v2xAIFPlmVbA3d34tt/vTY1UKQiGnCYy/?=
 =?us-ascii?Q?I+D9Cx7tDVgwMNGMOnw7OW9buu9WiFG39tndQuVbv/QpSbHcUV8xsFft/6q0?=
 =?us-ascii?Q?tVaFpa6xFzVMM768xsc+9VrvX2vg/UmGuBtk945YpKtx/wXuj/z2fnXC/f+0?=
 =?us-ascii?Q?AufNn79IgWz39hcpcV5JrHMixs7hFCYH3d0XARoSUAF/+KzCtj1uer2rQ4kJ?=
 =?us-ascii?Q?tbhQan035oBfB0VgOOANHT73sNKurE951hDMAg+TqYZKPwnVerq2om0juY5w?=
 =?us-ascii?Q?g4PQQpTpTVfF5VKZuTXfHMgGOpkrtHwb708PDqJqolwt/0LUjLmvALM4UETw?=
 =?us-ascii?Q?/MiXyHOoXg5oE8x13Aprd6mYbouXmTQzGKOGk/Eb0HGIjxcyjRacpWCA9RHC?=
 =?us-ascii?Q?ZcnvKUKIlfsZ/D3EoEQF8KkelPZceicndTp/zJPYSAhKVN8jS3cmCC7xM7Py?=
 =?us-ascii?Q?14zAJW4lNfT2FpVhrNdulhC3YhWX0cs1O+Zs0FFvpHZeB34RAaR2jgaUXP7E?=
 =?us-ascii?Q?O30riaEpkK8xd15c7U8U6wvVu2spWQcrVm4EFuRMsEWHBMjpFxPtKFyFFLlb?=
 =?us-ascii?Q?+NCDgn550ekoW+nK7092G5lzZkrXxYJL1rd+xVVGuLNYbtFeamom1591zcWB?=
 =?us-ascii?Q?eFz1b9b/JhhDpYL9UvIus5ZQEdZNyGRnmwJWMmvRQIaHtaJYcgDqbWTd4THP?=
 =?us-ascii?Q?hHIr+iRDtgtZPkyXfL1Et9v5XO9XzsLrvqQqVpS1h6QyFeWiZrwsHTBGP8/U?=
 =?us-ascii?Q?eDMMrfS3kmTymDu0orry0CRmxB17B5w+hJT67HzlIjb3EamGqZ7Hh5pe+Aai?=
 =?us-ascii?Q?UWotSk/JOyYk6O0i5Trs/r9LGaMHLu1MQ4I1JbtsjVS/97GVaEms3kkp0CvZ?=
 =?us-ascii?Q?xOLjXiogbc/4yq47Al+pA7WDVzL05/O7GnlePZmdlTo850NZZ8pWoxT7yCo6?=
 =?us-ascii?Q?5EhppS8dqOb7TvqvXUMZxXQUQzWUN88oWIeRjLbLKYd3jAfVXp0RTqyUm0j0?=
 =?us-ascii?Q?LEj2GROvVuAddgbgaIMXU4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2045FBEC6185EE41A698CAC9665CA551@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d8ab7-9173-4fa5-4699-08da02195730
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 22:08:28.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbK3Pin1rLou8MqP3VLLxAoGzqRp/KU2n+Lek/h5m5DYoTsAK2yGNnDGSUsI06exRz5lFHWxdP/U63SNDkuRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090111
X-Proofpoint-ORIG-GUID: BkZjYYugbZpgZ1K_FiK-0XeilbS3Mlb9
X-Proofpoint-GUID: BkZjYYugbZpgZ1K_FiK-0XeilbS3Mlb9
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
> Update find_clp_in_name_tree:
> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
> . if courtesy client was found then clear CLIENT_COURTESY and
>   set CLIENT_RECONNECTED so callers can take appropriate action.
>=20
> Update find_confirmed_client_by_name to discard the courtesy
> client; set CLIENT_EXPIRED.
>=20
> Update nfsd4_setclientid to expire the confirmed courtesy client
> to prevent multiple confirmed clients with the same name on the
> the conf_id_hashtbl list.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++=
++---
> 1 file changed, 52 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b16f689f34c3..f42d72a8f5ca 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1929,6 +1929,34 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid =
*sessionid, struct net *net)
> 	return NULL;
> }
>=20
> +static void
> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
> +{
> +	spin_lock(&clp->cl_cs_lock);
> +	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +	spin_unlock(&clp->cl_cs_lock);
> +}
> +
> +static bool
> +nfs4_is_courtesy_client_expired(struct nfs4_client *clp)
> +{
> +	clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
> +	/* need to sync with thread resolving lock/deleg conflict */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	/*
> +	 * clear CLIENT_COURTESY flag to prevent it from being
> +	 * destroyed by thread trying to resolve conflicts.
> +	 */
> +	if (test_and_clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> +		set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
> +	spin_unlock(&clp->cl_cs_lock);
> +	return false;
> +}
> +
> static struct nfsd4_session *
> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *n=
et,
> 		__be32 *ret)
> @@ -2834,8 +2862,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> +		else {
> +			if (nfs4_is_courtesy_client_expired(clp))
> +				return NULL;
> 			return clp;
> +		}
> 	}
> 	return NULL;
> }
> @@ -2914,8 +2945,15 @@ static bool clp_used_exchangeid(struct nfs4_client=
 *clp)
> static struct nfs4_client *
> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *n=
n)
> {
> +	struct nfs4_client *clp;
> +
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	clp =3D find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(clp);
> +		clp =3D NULL;
> +	}
> +	return clp;
> }

2983 static struct nfs4_client *
2984 find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_n=
et *nn)
2985 {
2986         lockdep_assert_held(&nn->client_lock);
2987         return find_clp_in_name_tree(name, &nn->unconf_name_tree);
2988 }

Notice the difference:

find_confirmed() does find_clp_in_name_tree(&nn->conf_name_tree);
                                                 ^^^^

find_unconfirmed() does find_clp_in_name_tree(&nn->unconf_name_tree);
                                                   ^^^^^^

I don't think we will ever find a client in unconf_name_tree that
has CLIENT_RECONNECTED set, will we? So it seems to me that you
can safely move the CLIENT_RECONNECTED test into
find_clp_in_name_tree() in all cases, maybe?

Or think about it this way: is it possible for an unconfirmed
client to become a courtesy client? I don't think it is.


> @@ -4032,12 +4070,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	struct nfs4_client	*unconf =3D NULL;
> 	__be32 			status;
> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_client	*cclient =3D NULL;
>=20
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&clname, nn);
> +	/* find confirmed client by name */
> +	conf =3D find_clp_in_name_tree(&clname, &nn->conf_name_tree);
> +	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
> +		cclient =3D conf;
> +		conf =3D NULL;
> +	}
> +
> 	if (conf && client_has_state(conf)) {
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> @@ -4068,7 +4113,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
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
> --=20
> 2.9.5
>=20

--
Chuck Lever



