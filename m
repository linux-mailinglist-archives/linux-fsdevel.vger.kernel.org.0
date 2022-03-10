Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4124D4885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiCJOD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiCJODz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:03:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B466C9E;
        Thu, 10 Mar 2022 06:02:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ADdwtr028050;
        Thu, 10 Mar 2022 14:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ogSJvgaO0mmsKoGd7XRHFEKw6x8jkSXb9GxEgmjpPR0=;
 b=jMyOkN1BD6X97NDCUA4s+lkJK2U2lZigEOCi8IGybKODlt1aeiE9chgjlq9vAdXDBmmb
 VoYGios5vrHWUS2S38EELnRQxD8gWGJzF1Fg+WwAu0ReMSmhh7chJcQ3I2cHKjv6Obnh
 ibspJjKn66k2qUcsveKAOFAh69D2vkfdkwUCZU5dBc49xuKfYXDTWYmjYxqd64Q15IKS
 Lt/QkmFRIJKZtzXr1xW+7bTA7Qgg4vd27u1L25jJibILpP4d8/2poGKjS4pUVcdws7ub
 H0P2zQPhm83z1nJSbE4zAB1H6xyotUIgBmjxU6Z+JBaalOqFewbgZ2qloFc5+m6u9v0m 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cn55f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 14:02:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AE1Ks4163011;
        Thu, 10 Mar 2022 14:02:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3ekyp3kkvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 14:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDd9EdVzOW3pA2FfxSMCwDXPOR9PUn7zetSuL0iSwtHq3zesMCnn+/5n3iQxZbfPFgUXU1z9vkv9O33O/rOTlE4s/VvWsAt92eipyOB6gjO7lT/vEM+exV5CZ2njyNPUmvY1JjBt6gn01yYgnNTEZ1IfCdCJeTaLtm2aBmZSYnNz+sKEff6HdBhBiBaqAXKDyitPIApWwXpG5id4ghaBTN0BjpBPcYHYiVJ5FY3CFMPHJ+iaEIDmwzAQBR1j4c3PKxtI2Gb6pi9+DGxOdJyWu/ZCtfudCJXmS8pTmZTnjsXgxkksHQo3qWm5xD1IHfJLmqowzjxsDVPtlSZ/bk3kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogSJvgaO0mmsKoGd7XRHFEKw6x8jkSXb9GxEgmjpPR0=;
 b=fLswrCMpG6qwX+JGQushrySigSn45s64bW22v9MXfYEg/azDceLqEJdO19VmR66jRQOIirpwoAFpIG2Ljjk05S5TBLUgnNmyS9rtjpJh4MhYlg6ZP8VhRk0ULYSZYq8UuASqf4xH8ASjOf/j0MeXy/+FxBPxs9z6i0PVWJzs6FaD3gikZ25nl3TE05cnEYMDQqCI77r/Zd0XH/Vim2686QEQKkn81ouhmJnqbPHzzS299XhkDbeYz0s3EX0cMWmfg3h0Pyxa1ct+m0ukV1uhmA4ib84GiIjCA89xpHDJ1sEYHe8h3GOTkB4/AQaCFqq8d9D8kfv9L69F+t/WGxOSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogSJvgaO0mmsKoGd7XRHFEKw6x8jkSXb9GxEgmjpPR0=;
 b=vx4L+Av754DdGpUrHHA9Nwd7FkIb0+OiVUJqZgnKBr8BUk3XO1cIS9yrvIQUd7jhjxKu4R2J99LQ8o4b4caAiDhe+CNAte0KH+yarEA5X/4vw7UeUmZ9zuy4Zx6FqYD0/fHgnAvPAq5Ek6ysUmwoUm+vQP3bzOsXW3zDsnpJECY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 14:02:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:02:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Index: AQHYMCkuO3+8v2ZQTE6s2XcaoPiYRKy3nf8AgAB7qoCAAJUOAA==
Date:   Thu, 10 Mar 2022 14:02:47 +0000
Message-ID: <D0361183-9BAC-4A92-886F-DDD6B22626E2@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-5-git-send-email-dai.ngo@oracle.com>
 <541790B3-6B92-4A85-8756-04615222EFF4@oracle.com>
 <efc9edcf-d6ce-e0a1-d00d-e31f6287d6d3@oracle.com>
In-Reply-To: <efc9edcf-d6ce-e0a1-d00d-e31f6287d6d3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a96e00c-46ac-42f5-5a65-08da029ea841
x-ms-traffictypediagnostic: BN0PR10MB4901:EE_
x-microsoft-antispam-prvs: <BN0PR10MB4901630B93272EDDABD4AAE6930B9@BN0PR10MB4901.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNGJLHDObFd5SpOxilKivHLbAo29p/CBWj7rPsnv3IuQqi8pIz2qoo0CpVqORSrKeeLbkwc5oyHqVJSaZUvEHHtqpnZcXI+AwWoZ0dihq2zfqqaJ9s/a7hjj6J1ppJwrDCk0PkTjq6+DgqbZ0YjD+P4m8N0tMcEBq1ChAR6cifuVkwzhMpTKFWBeoLxdZIoIwtBGV+/ihdXswUs19fEI5nbCx6+ilx/ebdtO+EENf2ogKdfkHukF01Vp4pm3LhU5VqSqKyFxeZ2qMqJZgMFaKHGaEPVahJprt/3sfFlgK1BW6u7YzQyMCkQaWLWo/wjiORrAHV2+Ay4UT3bIdUyFo0OtgU7yKluEAx04M8AG8R8KaACL5epcirwpJRXq7I6ULK1xdU9uvTa5FD2MBKSEI73KcL3g2FfIvjQizlFuEBA6dHFbSqfHNlmj4Ohb7dn5lDqO68jxHYWqFVq2nCcaUP5sgi6Ab6QE9axVuy1YS+f68SpNbizIq2TOW/cCe878FvMfz4GRYa8rWkgDQ7InLwQREQThbO5Qgi/jTAjVhOLg/6eTwkOQUFRHTtarIFiRwphh4EEQTC3w8SEkOEbl3UridyIhjS7LG2NB2lR5Q98Mb47V49bOqyug210qjK12NrNMtL/Y27enFZeehl4dflmX9RQpMqiTEyo6/0qSVDP2QE7C+0+Sj8XKQNTXnYUDxZtysA08Ze71BmXy98r+Tj6nno1FrLCfrF5l3ooG3d4LJFWt36tO6RPPcXI5264t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(122000001)(508600001)(66446008)(66476007)(64756008)(26005)(66556008)(8676002)(66946007)(91956017)(76116006)(71200400001)(15650500001)(86362001)(6862004)(6512007)(6506007)(4326008)(5660300002)(38070700005)(83380400001)(36756003)(8936002)(316002)(37006003)(54906003)(6636002)(53546011)(33656002)(38100700002)(6486002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xgm02W6UPwyGNIxlnz0liSyt67jXUIxzfgY6Fypiyb1cLwR7L20PT5bhFwDZ?=
 =?us-ascii?Q?daei5Zp+Z81bX5rmFqpnxSgjhu5jB9wpzA9iHt7U9IRnxMRDY4ArT8qfcTeS?=
 =?us-ascii?Q?q2Na3pV8AaT6/dQiCd7rEeFzuHXreaAWjlga/qoOsQNUhrt4KYaqIP/l9lu6?=
 =?us-ascii?Q?NOeFgdMX2LG8iP7k2xyNvsj44GG3LGxaUN19sbC3nbKadUXHXu+9LoCfUTKu?=
 =?us-ascii?Q?LR21tPZmmaOuiM8wFO0uNaxGyi+oQPAQkHBFhDBGu8S2YzQjpwgSW8bnPGXS?=
 =?us-ascii?Q?jg7fFG9FvXZyrfzUYWezfZx7I7tb4wbZot3YutswgQ4J0cuLFBwjLRJWtJmQ?=
 =?us-ascii?Q?6Rs6Jn/eiDxWs5afX+0scw+y7UJJuexcU/0etcl/VC5Ca5kJjmrTdNOZ4EPu?=
 =?us-ascii?Q?dl/aoxZyG6H8w3egeEIAwCXpgVpP5w7H8J9gVZTzF4pCapXUta4qDtmUI2sP?=
 =?us-ascii?Q?4kKbJJo6bE3MjTevaYZ9EWwaaJ0BBHoa2+j7J7/Jt0fsNO84q4wKZ6EQC43T?=
 =?us-ascii?Q?N2LtEgT/aVAeLrcaaRm30te6U0aeUTsIgFD3j9EyVueQU+SXIk3oFZwd0dIC?=
 =?us-ascii?Q?EaMDIygWaVniOI8WJYJWTF9+0KQRcT1ojHaDbg2qreNnYXJw5EaHgRSgMKwt?=
 =?us-ascii?Q?7vvSHnhZGN0RULDbOOFGzhjUxIBDPjWSkyCHb9fkonzGFLkvwPFpcNZetFMF?=
 =?us-ascii?Q?q8P/FPIWjmKUs5v1bL9ZX2RV0Ow2hHUjLUF1ahQLNTr6xMk2Xo6bJsemkiY7?=
 =?us-ascii?Q?ILxxED7Hs0zmdPUeFNZE8lLvuisE6oi98iQV4SVE038a3p6NYZRB2/gCLpiP?=
 =?us-ascii?Q?HutqIE4/EXnePC3dhaDPARiAKrtK1j+IKFU+mgJfOqplnkgSah/gxedy9R7R?=
 =?us-ascii?Q?YkZsKFj/f8x4euMHcWF2VTQgMqH7fJkwAt8b3suJEYWbysOd6rCyjd6micAw?=
 =?us-ascii?Q?raRWISQrNNa2mBdRHyuYzFcMb+gYRTwJYLUREZtQbA3YSTal6gcEyWNSv9x7?=
 =?us-ascii?Q?qr3ewvf+gUWwGcfzoisdGGvv8bzBjd4oQdQnf30+ZWgsLXg2oAq80gdiZcL/?=
 =?us-ascii?Q?5WAiBgZH/bPYQHhUwTEG6gDaZxs/ByNuJZf5M6acKCeI+WtEunUuppDmVrPi?=
 =?us-ascii?Q?/BzxaRKmCxVzXvVzhFkZE+fS14s4SDpa1rt+S2d48ra8jXuo4ExjCxFIJryh?=
 =?us-ascii?Q?j21/tW2LyJIGQ0o8cmtblQxE3fUO0A85t8aLUatYOfQ+vtMQc2r6w6B5p6OE?=
 =?us-ascii?Q?PuHeAmtP7RPumQYVxuqiFCvLIO01q+W2b7UmHPXylmeErv7vkHxziDZ4RCoH?=
 =?us-ascii?Q?CkLeU2POb9AIuAAGVQbvlZHL+mrz48FwjKqQ3JvD5iwQ9O3axPStFVD4W/rR?=
 =?us-ascii?Q?32xClMHEmnHpklT7pbGbonV6rTGuKBEY6jlNgt25E0yRcEhTAAW8w9x87GkU?=
 =?us-ascii?Q?D5+CBoMFe9zwARbXJJyZ2ZrJzlKkGJ/7ZnUYpEZo5qY0kk/5HmhR000a9CX7?=
 =?us-ascii?Q?1K3Kv4D0afk/fXqB/LEDzpUNKZdA0HJSK3XxrwEfg/HaFeZl9/INXChmJEZn?=
 =?us-ascii?Q?4bWVCuRh/JRmhVYiawPkha58thHwVRbvgc6+PGqL18MZAWCIbp74xIDlNr+L?=
 =?us-ascii?Q?0U+meLmJrTJkVaRNMw0ZpEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E753CD8F28614C49B8D866F729821441@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a96e00c-46ac-42f5-5a65-08da029ea841
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:02:47.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g962MIjnTMoGSgy7wVozEmhY0SW0iodcIUWRFno5RDvDowSr7hm8VRI19FJ8g58nmyUTO8F5GnQhBuxR1/Bxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100076
X-Proofpoint-ORIG-GUID: 1L5vbDuCsdEvtM-DhyIG2jDHKxSXpGVU
X-Proofpoint-GUID: 1L5vbDuCsdEvtM-DhyIG2jDHKxSXpGVU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 10, 2022, at 12:09 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 3/9/22 1:46 PM, Chuck Lever III wrote:
>>=20
>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Update nfsd_breaker_owns_lease() to handle delegation conflict
>>> with courtesy clients. If conflict was caused courtesy client
>>> then discard the courtesy client by setting CLIENT_EXPIRED and
>>> return conflict resolved. Client with CLIENT_EXPIRED is expired
>>> by the laundromat.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
>>> 1 file changed, 18 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 583ac807e98d..40a357fd1a14 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -4727,6 +4727,24 @@ static bool nfsd_breaker_owns_lease(struct file_=
lock *fl)
>>> 	struct svc_rqst *rqst;
>>> 	struct nfs4_client *clp;
>>>=20
>>> +	clp =3D dl->dl_stid.sc_client;
>>> +	/*
>>> +	 * need to sync with courtesy client trying to reconnect using
>>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>>> +	 * function is called with the fl_lck held.
>>> +	 */
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
>>> +		spin_unlock(&clp->cl_cs_lock);
>>> +		return true;
>>> +	}
>>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>> +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>>> +		spin_unlock(&clp->cl_cs_lock);
>>> +		return true;
>>> +	}
>>> +	spin_unlock(&clp->cl_cs_lock);
>>> +
>> Nit: Please add nfs4_check_and_expire_courtesy_client() in this patch
>> instead of in 05/11.
>=20
> That means nfs4_check_and_expire_courtesy_client is being called
> in 05/11 but is not defined in 05/11. Is that ok?

I thought I saw a hunk in 5/11 that converts nfsd_breaker_owns_lease()
to use nfs4_check_and_expire_courtesy_client().

If so, I prefer if you add nfs4_check_and_expire_courtesy_client() in
this patch, and call it from nfsd_breaker_owns_lease(). Then the
additional clean-up in 5/11 isn't needed.

Again, this is a nit. But since you are driving a v16 soon anyway,
I'd like the patches changed before they are merged.


> -Dai
>=20
>>=20
>>=20
>>> 	if (!i_am_nfsd())
>>> 		return false;
>>> 	rqst =3D kthread_data(current);
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



