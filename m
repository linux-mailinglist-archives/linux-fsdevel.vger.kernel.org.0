Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA084D3ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiCIUPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCIUPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:15:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0D35DDE;
        Wed,  9 Mar 2022 12:14:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229JOjci029000;
        Wed, 9 Mar 2022 20:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jiZTihySKHIrHr9woNniZeFRjO/3DNeCuelFHFySCnc=;
 b=RPdJzFbcjDJpnZdP9amYVET1MUh/Sfatah5zSxY4NvE5/+9dmZCe7WsJBIG/YR98G2/6
 qCWhBDWMtO1S4daQ6v/TQxqbGbMLe0dWyiD/+bIezgEbzY+sxWvC8aKo7XVixYvMcWu9
 2I5wKDI2kf27n8HujAmMabKOaChWWF5v17Fyg7Gap5EToKjBjqYOrfbXl9LUTmrpcVUb
 bttAvPMBtIxrHwpLAW55ajOdk8736LCTpwsj2yivkFu+YGg2JBmmaZYJaLKH/FfyOixx
 N1j9wLRkt6mX2otKWFqD98SeMAtVusPny0PYE8iW6yWMawNPHfKgdu/oRswO7PRVYYGX Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrattkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:14:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229JodOd024186;
        Wed, 9 Mar 2022 20:14:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3ekvyw4rpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9IB0E7UUpelHZr/BBEVzYYRF3EzxicXHwA0ybB7qgDhaawu6yQ+ukAKdJITsq7Grg9i/BZ1khWfQ4ktrSQdlRdfApTJh9oT7IREfwdj+cOHihoFFW9AlMGPz+rY8znFiuy3/Y7tIxDxG4Lqsn72ajeZy1goZxlTvz8IrWmuRagznnx96sxoz9e/N6QyryMdmrqKiTm/1ct0Q7XkPYdpdv3pr1DIdx4YphCYmFCoRhWFRAM/O9mGLW4J4Cgn+VFrwF+mNB07Rs0WyXqz9GZFcVOg6Rimrxd+3kS0fS7M87dL1yg0p8nJzsXMlnnSZwCXAXOZbHLGaNITK4+66et8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiZTihySKHIrHr9woNniZeFRjO/3DNeCuelFHFySCnc=;
 b=VeaNdrPfldz9PgMod6VcN64Iwz4RvWu9x7ExvXTbUKUjd+miY5r8Y4PYrGZlVvWytmb+ZnXW3OKgmho/VOgMXykkBfKNpWEt6uSiaVOKc/17yXw2Bo1RRKgWyV94LngilMHq7nMwv9Xz01Ma4411RLUwOuwffBL47OAyVXkvMczGAxIFbHjHFkskF/RlZ+fzpFc1H++8xBifjmjqBN+3VDcdiEtGsvXdxHyOA5qSqqlB83k8yv2+hq5/e2WonAuf20lptJfKBAulRfI22DnpzSfX/76/0E4jUSiHEcgvGMFmuDbCH3qkfLtYck6Mxv25BTPHTltzuxVailV5RCkB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiZTihySKHIrHr9woNniZeFRjO/3DNeCuelFHFySCnc=;
 b=gyGFS4QZi9s0kj81Eq1YLLDBf4c86XvztM+MuKO1iAmNgp412qgroOF8PQlTgxwL9MPKL9w2bP5Z1aNxGcWKJW/0CCCsdUFj48cTCY7GJdbTcuoMv6Lv5riTUjvgyAu0/ZL1sgNDME5QDUkXrZv/aGQd0nKnsNJwccgIH1oWbRc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3584.namprd10.prod.outlook.com (2603:10b6:208:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 20:14:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 20:14:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Thread-Topic: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Thread-Index: AQHYMCkx0/hr3YEM/0Sucgyj906cvKy3hEEA
Date:   Wed, 9 Mar 2022 20:14:32 +0000
Message-ID: <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54754bf0-14a2-4861-3576-08da02096cce
x-ms-traffictypediagnostic: MN2PR10MB3584:EE_
x-microsoft-antispam-prvs: <MN2PR10MB35843DC1C8E657F0F7972DB3930A9@MN2PR10MB3584.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGcsILPbEJJQia/nNF1uoHvcS39tnjfSiMUKuB5QDwcL55X+C6USVGuk9NcPSujEjY+FnNx0uqMm6wUqS+URyLyRIHk0/gX4KvzGtorSkZMTKHi9qCRI1wkLPVxAQJ7uTtFXAwnbSUoSk4S1xewFREAkDaDNoGRyIg95h4FmFkd1HasHdzfvNPpABK/LNTPXB6zXbxmY/NO8RTXTqTR577ahudC1IAZcmz9KEzjKMJS9IlgD3gOIvFsGKvEd1UZ0l0AIKHlwDUd+SQI0fxlJ/8NMjCNq0/vKf4/9+cuEMcgDtRpLbsZ6ZEFOGimNpyub5RBZaw3qLKm3/BJmfDRtMK7jNZvQ2g2QnmuEScK79zGPKEKBQloO9bKx1kGwt7VylbeozheGHbvitaMH3PUJ2UUVkAwXKO+uBcU3lrhpz0PvQwcXhasdYIGPA5jmOY617+UvSJBx3U5/q4HLe7Y4SLHAk+tHrbB74ltTKIOXQrOf3s89ESUwMiM0FYApbKNfV/Irr0S8tjChw+irXH0qxFNVAfh649C/G5OoqStuL1t8F6eXzM/bW9RLOacKtAe6PruBUV0nQ1s2EoQz5KZJi/PSbCYrFTkxDuKJ3wPJD8XW1PbQlDTnNfuO3bkUtzF/PSPdNrkdRBbQTNID6hh2q5HFQ8uxxJFpAj7nXBXvAfTc+pgWD3psfAaFxMDYhqeACE/JVKXe2P2X6xhiRJLAUcTxCDN71TSnxBP3m250bv5KxQP6V95eWhyOm6alo5kH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(2616005)(26005)(186003)(86362001)(38100700002)(2906002)(8936002)(38070700005)(6506007)(6512007)(53546011)(54906003)(36756003)(37006003)(33656002)(122000001)(6486002)(508600001)(64756008)(91956017)(76116006)(66946007)(71200400001)(66556008)(66446008)(6862004)(66476007)(4326008)(8676002)(6636002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4jCqmqGeVuorQ3IXt2Xrb/WDkdnv4u6+Y0683WRkeabKB5YWsKpQPiAultD7?=
 =?us-ascii?Q?DoJf17QGhNoJQSwmETmhIaA8REPNIDcvDj3/R5GlrFhS3VFMLtK9zrA4jJeH?=
 =?us-ascii?Q?oCpp9BOlML1o1D1WiUoo7dYV+72Rifuv2k7dYYWKHOImMgx2aV1iUgCRy1sA?=
 =?us-ascii?Q?4r/buIzNIYJhD8+0KgvEkLqFSCfjxE/h6I4KPhshePR3hrL9ZSfcXla4a7zW?=
 =?us-ascii?Q?3Hzdyh3dl+lGH5LVHuXWmz95NmFmoami8HPVTupIw2aOpMRl4TI2iWMvPSBL?=
 =?us-ascii?Q?ELmdWt1dYikhlV/Emlf64rqHreRF60vVfdgy+gEgT4/lCbhsSrtEjZ9Nu2E4?=
 =?us-ascii?Q?2ahA6APd/jqcmxGJLuOyvQ7ENcR5QvvjunNFjKVx1l/i3Y9Wdft+Acj9vrPa?=
 =?us-ascii?Q?Gd1+0SL627+FAbHIZC0sx5bOEdoEigUtXrz0hgKsLcI2/PFPiAtS0RGVsjmm?=
 =?us-ascii?Q?INGonYghcg1CMYO8/GilA9L6ka1+XiJ5ZJqrETMXF4aTcZxDuguUAls9vQk8?=
 =?us-ascii?Q?aLF6mCeKJLUIsQ5u9IMpjeIX5UaZpfSZ7FYmt6cw9I7UbJD2oZH2Abar61HF?=
 =?us-ascii?Q?zAucpjv12IPjJoTgC9ZkTOVmREEyVWDW4XIbZklsJKXdOuiH+q6TACGoR2Uz?=
 =?us-ascii?Q?xLzsGbJeG72Y3dNw11TmxM/pe4dC266/cGjg+TEB7Qbyshe4HEgBVJKppk8Z?=
 =?us-ascii?Q?He2/qHnDa3afuqGmQrpcYhNZ/xjrIEgBr4J92N9qoju3Kd87c6XUhUF6FF56?=
 =?us-ascii?Q?TGQF5Bo7UG+XDZzyIVS2fifd8XyudAWt2HBIpzXJK8phGkllkTD7esGnYlmh?=
 =?us-ascii?Q?hvu9R+bmNxynoTOJ4A3qqn3D2SiXWTbZI9UGGqLhDwcRnxTFDRNPxpviksxT?=
 =?us-ascii?Q?wNSTs5MGHCiEsrBRyM362wXLHZSyICMJrgekKNvHCCui/lyJiq4oe8NhPPKx?=
 =?us-ascii?Q?HjVNth3ZTtvOuW+S2CFfzc5IUUU0mT5AxWi7tp2j5tuGgf54YscZBOwsPRli?=
 =?us-ascii?Q?Ryq2TMiPP9mCtCKiwYqdBV/j4n8wZvLa1NsVbULssrqtW4VTH//ZP6Zblh2r?=
 =?us-ascii?Q?v6IIMf7tzS2uRqyUAp3I4I+HPsaXd32OLaz5zIdWxMR2vbZNceL4qizc0EbD?=
 =?us-ascii?Q?L7XTCKQAuGGKuGds2ziitrIjM9KOYMO09jPEOw0wM8SEsn6bOxHuqEQwWHDQ?=
 =?us-ascii?Q?Vq4JcPdf6bG4A7ztmrTbL6NNAgAIjwpMNRWAUXBvttsnmQBkDAfYZrBCWXPl?=
 =?us-ascii?Q?/RauKA4X3EddXhLjj8aktAIwH1L52BH8oAboKYPUm6+4qZ2m+TSoIU3C37qz?=
 =?us-ascii?Q?sUEOBxZ+eOvVKYHvpeiXQOZIuM6Qo94MRXoeptd5NadgdPjjs8x4N8Qi7LVh?=
 =?us-ascii?Q?ZfQZgBFR2pODwrEqAiUBujAcOsnulhNCxBguQsF+9N4yem14nZ4IjFyEVFSC?=
 =?us-ascii?Q?rY7gMLPKNMgJTlBHQJPs+HKlvxPyc4/dU2VWLmaDOdu07DfY9i35boxU6sVT?=
 =?us-ascii?Q?qhIIJ8+l1tKuxqPWvdup7d2MxlhML4nAA9yLEb4F5ZVVpqoJLh3u9Jv6XVII?=
 =?us-ascii?Q?cZ18P/hLWTUtx5bT9SNuxJsxBPsoEA4Jj8e+uejI6Ejja+2XVrF2jsnByVBT?=
 =?us-ascii?Q?fkgPMbJH+x6ar7LVPun/8GE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <205681B8B66AE34A8C0B1C3941BDA96D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54754bf0-14a2-4861-3576-08da02096cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 20:14:32.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSvB0dLQrbb/AEX3mX5EtxpJBI4pq0K0rlGSZ3iSjF+TxVJBrXgW2B2zY4rv7fSAFePhpKPsaWYEUaul+tQt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090105
X-Proofpoint-GUID: yhuqFhZuw0l5S2koAD-Kb8GguGGDRS7y
X-Proofpoint-ORIG-GUID: yhuqFhZuw0l5S2koAD-Kb8GguGGDRS7y
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
> Update client_info_show to show state of courtesy client
> and time since last renew.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index bced09014e6b..ed14e0b54537 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2439,7 +2439,8 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
> {
> 	struct inode *inode =3D m->private;
> 	struct nfs4_client *clp;
> -	u64 clid;
> +	u64 clid, hrs;
> +	u32 mins, secs;
>=20
> 	clp =3D get_nfsdfs_clp(inode);
> 	if (!clp)
> @@ -2451,6 +2452,12 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 		seq_puts(m, "status: confirmed\n");
> 	else
> 		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");

I'm wondering if it would be more economical to combine this
output with the status output just before it so we have only
one of:

	seq_puts(m, "status: unconfirmed\n");

	seq_puts(m, "status: confirmed\n");

or

	seq_puts(m, "status: courtesy\n");


> +	hrs =3D div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
> +				3600, &secs);
> +	mins =3D div_u64_rem((u64)secs, 60, &secs);
> +	seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mins, se=
cs);

Thanks, this seems more friendly than what was here before.

However if we replace the fixed courtesy timeout with a
shrinker, I bet some courtesy clients might lie about for
many more that 99 hours. Perhaps the left-most format
specifier could be just "%lu" and the rest could be "%02u".

(ie, also turn the "d" into "u" to prevent ever displaying
a negative number of time units).


> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> --=20
> 2.9.5
>=20

--
Chuck Lever



