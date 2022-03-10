Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403924D4C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiCJOwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbiCJOtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:49:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D418023C;
        Thu, 10 Mar 2022 06:44:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ADe0RT028062;
        Thu, 10 Mar 2022 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TOnRbm61T6Aj4e+AcKOeqhiAvs/1qcB7MKbvDioTIqE=;
 b=ntwASsMgVkwCJLejPfzM0QUiekBiX1ze8ns5KgE4nxP8KtbM4MyhD2CSL/UFprtYkqeX
 m7Nyi6/wKY/UIYqNhePZv5Yd2lGOaJyvAMU1ACqTkRTMS+yggP+k8dBKCmsDCKxP7P+k
 jKmlbweKFgnCs+9XOFI/rKouy3Whnbf7b8+uZ+bhyPjZ38lwQ356DT2mvnmqeXoQPIKi
 1bCviqUJt3xTo5YwT4rQQdmuimmrRyrQLizk4tMy4mkUBzVyLEK7ELV4iqyjnhmmTUOc
 hJSKjV/30/mpG/erJg9FGgBSwJQHKbDTZMPl3br9VW/EeGfJsshM/opG3krYVTftO6tj Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cn9fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 14:43:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AEbNaq066558;
        Thu, 10 Mar 2022 14:43:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ekyp3m900-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 14:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P70Mwm8SGst0pFIDr6qCC+rmegB5kDUZ3ildw6Mpi2ymA4NOv5GCQcdrWPs7vlr9YdwMU4ydcrNNI4FZotdqAxqBlOzqDHzuIMOxa+F8QNZ3nAE8a5qfenOt1kHQF/Tancq/MvQUe0nmVZINYhr8UXhtgyVPkzeJniz7ZNp/a84xC5SSgVLqd9wAf3b9yaNG3UGEYo1sIVp8RGcbPbymKbZAHHQF3cVy0piT2XrfmgUqrQVPFrYcd6ygXIGTC4qIgSd0qVFJBhyr2uRJqYu6ZbHsxY1Eostr4wPWS2Ux6OqkjcBhX14y6OAG+RRxOgFfGJaRHp3vZ+w9Y7X1QbI22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOnRbm61T6Aj4e+AcKOeqhiAvs/1qcB7MKbvDioTIqE=;
 b=G0uIGszjN1oQXGO4wa0eX+ZkJuTJOB/BGhVHDPmYY6+29sWzwBMaJw2+JhK/rzeCZ2bLp38gTvz1KCntd8yvCm0lqsLURS3qQgjlJwzXBL4q/881mem+LdFSEQyVYd4ftbou5mkokM9N91UfMlxqCPD/PRb6Lpy7sJ7maTCM3zLDgA7G03hiwGKOPBbxoYzh7S7KgQGz09YOTpAOEVZaliLOgx/xtMJHDGWsoX/N+GCB9rbeIQblGsNvF9Sz+U59DDDllvQV4OOCOyYVVcSZxQHOyu99cscqO8jsxCyPp+IjkOBeroTTPRIAs/znxgnjVBIzZcYWI2FxEckTIlvIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOnRbm61T6Aj4e+AcKOeqhiAvs/1qcB7MKbvDioTIqE=;
 b=UaeBqdtzgE+qjEfUOsn1ZkPLJMDhvwqZofIvwECnhq6m3UAiiCEkyyZOdZi5MAgS14U58IEUq1qmsBppZOuSX5ui9l/d9EKhR3jnoR4mFgngBWHNGn26aPFWcz9p9Wb5XtnUiitD9zpBOsu96ygXEG7W/RblOxDd7vWKHXSG6F0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5588.namprd10.prod.outlook.com (2603:10b6:303:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 14:43:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:43:54 +0000
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
Thread-Index: AQHYMCkx0/hr3YEM/0Sucgyj906cvKy3hEEAgAAKNICAAGnRgIAAwe6A
Date:   Thu, 10 Mar 2022 14:43:54 +0000
Message-ID: <FFD71A62-084E-49D2-ADB2-8D7D4463E875@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
 <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
 <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
In-Reply-To: <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc58bc4-7346-4bfc-3bcd-08da02a46692
x-ms-traffictypediagnostic: CO6PR10MB5588:EE_
x-microsoft-antispam-prvs: <CO6PR10MB55886B3E43BA3BD5A062E112930B9@CO6PR10MB5588.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szq1r6igFwRDtKgbNEzwgqGdcpcWr4+/rqAu4UC9gQcMvvtzikT7XRv0UHsv6WwClvEp0SpCgD7X9qf74Ll3mRUqbemINUArMV5G1KpIEuEdkZwoST97Yfq/ZdAx44uzDxDk/q9h+2LcL1VI3cMGGq/rivtB4b4wjwZSX8XU01Dd1yIkhRNU8EpuH+yOMuDEd89/lfxKZ3ZwooxmaKYDq6hwVtgJzldzfXYKz5xlsO5WreaLzv1YfrP+mhxQa7cMYVO8DsuBbFqNST5VwyH3DXzh10HUGX1/VgKTkfjHY9H40Dwm5eE+0UcfWzhyA8j96o7U1A/cfToZ5bVTpo0HPZYxnb39jUvQvSfyQqQG+aFMU7tsilHQulXYK1+FtxaB98jDdVYilUUHtZkRFOwTSv49uuc7zFQ2l1EZTEI+4CFy8zRmzCMn3ZOZyaj2WVZkefxxBq+jq4613k264Z/ZGDB8NazB20qFvuEuWGkwSRZtYdCQOTgj7/JNf4xMsBbOaNlMBMadYLQPLA/UGHpV7qgG7xDeQ4ixvgcO0zrju7SuEtooLjWkZn/nBQJARyTkwt2+nGldy6ofarflKIGm84dQWwFapkbVMoaMToBa5V44qRbT0ZZO9VnsecN0pAOnjbH4mY2xV/AHaJvkAPquCkExjFImzJ9P+Agn3p7vpfypgWrRxYJDLWe3tmtrLz7lsh7hYHCcanPbeGs/G/1IKDw5AVb44/tl82dCoIt6WtgKPjdKDEiOjdrYhyf2RZiM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(508600001)(38070700005)(26005)(83380400001)(2616005)(71200400001)(6506007)(53546011)(6512007)(186003)(66446008)(2906002)(5660300002)(6636002)(4326008)(91956017)(6862004)(76116006)(33656002)(66476007)(8676002)(66556008)(66946007)(64756008)(316002)(38100700002)(37006003)(54906003)(122000001)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4l/a+222Kl0BWy6WJZmq82n6N6191vjilVqAE0QfnczfY4H5Q++EMs6LO4Lg?=
 =?us-ascii?Q?gSSY1mmBKCE1RMcMjMHiHvj3jzGIrl4XfzFjR5j+45KAr3r1/78K1IU2LdaK?=
 =?us-ascii?Q?GnqNUBgWdK8uGXyi/fm05yrQUWQ6gPd1QtEHxr2jl6PLZOZvNHq67S7PEdUN?=
 =?us-ascii?Q?TOqcPLNnQvv1ET09p3dO6e8a3fuD283X61QNirFTbemXnMg7rbdSwO4SDuex?=
 =?us-ascii?Q?MBcFnDit3UJxL1QmU23ft79A1ROp5txrz9GaJnMBioU/ymEmr6LGBAcaPOb9?=
 =?us-ascii?Q?zeVWoPwjJjKZubIicon1/ygZq3fFIY6psMGrdX0kS8+7Sg2GzBJbTbFeBql6?=
 =?us-ascii?Q?FtPJltZQrr4HMf0dt181P6dLGP1A30xuycTR/2avwcGTStE5JHKirHYb/Fnl?=
 =?us-ascii?Q?84VVhxY9jEJ5yoSeYZsD8T0eaoFuNMpyo1l12yJZy0uyw5+BE6hGUm8Hv3zE?=
 =?us-ascii?Q?p/a3yBZ5TVyYt78rShQI0deMA6mELyNeqPS4XIyAdBd3pf2GG8kYnadMisel?=
 =?us-ascii?Q?hhqT55jxPhtG9cVjVJQO7FAqytT2W3A+NPfik6ILBj7ZiOVO1oP0wqr2DkMe?=
 =?us-ascii?Q?pyj2rGghAyrzCJwWCauiT0H4g1hk0KKlkDQn7SXxtUS41Hw9o3nYC56wsv6Z?=
 =?us-ascii?Q?HiCfHlky/oTAHmj1jxx2yiaYOZ3Sh5ZhFhCo9DaOWfufACaAzMZvl1PKgMdO?=
 =?us-ascii?Q?LG8LIr+jpVMHAQQMSCxYg+eoGkMfXMQHab5fEWDAur8/oGHSW8aTY3PGBfE7?=
 =?us-ascii?Q?TE91mqVN0inV/83BymnC8x5QsYhbrFZ+p2/VZiATF20/XU3jNIAQeM4YbJaC?=
 =?us-ascii?Q?NidLOmEwi6ecFDJD8sUCkKZ7lCPzXgFvPTp2cIatNFfRg/xU91BFQGz04zbi?=
 =?us-ascii?Q?d9C98SChls3/INUteqEi/JRUsOO2boTpkn8nCVIA3fBdcNIQpv+CzFJcvIQ6?=
 =?us-ascii?Q?yk+Bl72vJdVl1UQAch3LUSJuUlCqovtixet+Vrwpr6kgiauAMSi5wGGLXUos?=
 =?us-ascii?Q?Mzx/zBKtIDRp1HLaKIelOm/X+WzM3yJvnxy8s/DCn++1FnaHDbDBX3IwGbJe?=
 =?us-ascii?Q?kRFoxtyo7paXP/LmtbTHlJU+WQ5mxuHeSSrEzcQ16CSfUOVcGLN9yefwFSr4?=
 =?us-ascii?Q?VSdymP3mu1hrIBEntrVKUNcn634T3cRUfL0K7WNIGVV2M5BFdoIUsGMYe3M8?=
 =?us-ascii?Q?JF1cOjXzk/JwrZtALikonZSvEXVgvJbLWftnV4ivl6PBb31jH7wTDxpN0NtM?=
 =?us-ascii?Q?RuLaCR1e6YEktj0m9U/rpax/sRp0SdzpOw11woO3LAY72m5kVG5YE+DQfatF?=
 =?us-ascii?Q?r4b1cb3EBXkntKmUwZqXE1pXcEcr6iSc2Dm5mJ/2du+vD7eEkYLCAjaKms1N?=
 =?us-ascii?Q?VoWaO9rAla4rk1TbGWit2U6FUtAnQgw9iLJrqr2BiefHL1m9V4qG0VXAi4f4?=
 =?us-ascii?Q?UE7iz+SSUjBDKjLk/wDaf+BBryKzIqexTA+OoqNj+3KQZuPlrk1M/pO1+V5n?=
 =?us-ascii?Q?u4UbFFJx3A8x2AavWHRbszNAnP0KidEhBTXuUkegpwKbPTTrhTtjpckg1OTQ?=
 =?us-ascii?Q?sgfNNj96nzqrWLrDYxVTtebRzQfDi1hrXWLP33G578n4ym1ZC7ohPl/kiMAO?=
 =?us-ascii?Q?KMt40U5YWC+twUcRJjbYRoM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DB194AF049CC046B33046DD9FA6C887@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc58bc4-7346-4bfc-3bcd-08da02a46692
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:43:54.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnI26AFWYbQZpqwQfL7ndA3xRK8qZoKt0XIHxyIZBdRdOIyBYM85dMZ4NSmM5fKCHGCVWqyRQQC7Rmx7Q2yySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5588
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100079
X-Proofpoint-ORIG-GUID: bLYdCYEF6gseWwqIFGsJhRLILO7cXBhK
X-Proofpoint-GUID: bLYdCYEF6gseWwqIFGsJhRLILO7cXBhK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 9, 2022, at 10:09 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 3/9/22 12:51 PM, dai.ngo@oracle.com wrote:
>>=20
>> On 3/9/22 12:14 PM, Chuck Lever III wrote:
>>>=20
>>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>=20
>>>> Update client_info_show to show state of courtesy client
>>>> and time since last renew.
>>>>=20
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 9 ++++++++-
>>>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index bced09014e6b..ed14e0b54537 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2439,7 +2439,8 @@ static int client_info_show(struct seq_file *m, =
void *v)
>>>> {
>>>>     struct inode *inode =3D m->private;
>>>>     struct nfs4_client *clp;
>>>> -    u64 clid;
>>>> +    u64 clid, hrs;
>>>> +    u32 mins, secs;
>>>>=20
>>>>     clp =3D get_nfsdfs_clp(inode);
>>>>     if (!clp)
>>>> @@ -2451,6 +2452,12 @@ static int client_info_show(struct seq_file *m,=
 void *v)
>>>>         seq_puts(m, "status: confirmed\n");
>>>>     else
>>>>         seq_puts(m, "status: unconfirmed\n");
>>>> +    seq_printf(m, "courtesy client: %s\n",
>>>> +        test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no=
");
>>> I'm wondering if it would be more economical to combine this
>>> output with the status output just before it so we have only
>>> one of:
>>>=20
>>>     seq_puts(m, "status: unconfirmed\n");
>>>=20
>>>     seq_puts(m, "status: confirmed\n");
>>>=20
>>> or
>>>=20
>>>     seq_puts(m, "status: courtesy\n");
>>=20
>> make sense, will fix.
>=20
> On second thought, I think it's safer to keep this the same
> since there might be scripts out there that depend on it.

The "status:" information was added just a year ago by
472d155a0631 ("nfsd: report client confirmation status
in "info" file"). I don't see any concern in recent commit
history about making the information in this file
machine-readable or backwards-compatible.

Therefore IMO it should be safe and acceptable to use:

  status: confirmed|unconfirmed|courtesy


> -Dai
>=20
>>=20
>>>=20
>>>=20
>>>> +    hrs =3D div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
>>>> +                3600, &secs);
>>>> +    mins =3D div_u64_rem((u64)secs, 60, &secs);
>>>> +    seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mi=
ns, secs);
>>> Thanks, this seems more friendly than what was here before.
>>>=20
>>> However if we replace the fixed courtesy timeout with a
>>> shrinker, I bet some courtesy clients might lie about for
>>> many more that 99 hours. Perhaps the left-most format
>>> specifier could be just "%lu" and the rest could be "%02u".
>>>=20
>>> (ie, also turn the "d" into "u" to prevent ever displaying
>>> a negative number of time units).
>>=20
>> will fix.
>>=20
>> I will wait for your review of the rest of the patches before
>> I submit v16.
>>=20
>> Thanks,
>> -Dai
>>=20
>>>=20
>>>=20
>>>>     seq_printf(m, "name: ");
>>>>     seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>>>     seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>>>> --=20
>>>> 2.9.5
>>>>=20
>>> --=20
>>> Chuck Lever
>>>=20
>>>=20
>>>=20

--
Chuck Lever



