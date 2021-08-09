Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070FE3E4B33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhHIRvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:51:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57452 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234749AbhHIRvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:51:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179HkOGq001586;
        Mon, 9 Aug 2021 17:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3xhsy4uuZJLG4lyzGTY4jQyrr0SbaWwXY0j71VHFisk=;
 b=IAu8UDn0O9a/FdKoEpKNHw246NOs9/t6bhWFSfAxPaJ5zv4JDbkxwUGriocdh3zKP0o+
 s8/bFL9KvMqh/9NQn6wBdnT/+bAZdMwFRFbRWGgKvA+HrguLGVNMtMnjctoE5/8zaxac
 yMYt7LXqFfO6w66ccSWr+0msm3adM2n/DRcGRgN1KhVywLS7rwosDLwDF0Kqh4rs0iGk
 FYmDvKC7DUwAEQFZK+wofeTIZSktYZyK0Yg5e1rGieNMnqrjg+xc0WVkGsveT21fpW0w
 C3umkBVbnKRSPk/neGAaGGRj8p6kaCV/vVe2pP/uNVwS/9mITsqc2Ahyad4AENGTR014 eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3xhsy4uuZJLG4lyzGTY4jQyrr0SbaWwXY0j71VHFisk=;
 b=P38HoIu6gFUDO4T/IV5FsSOoNOW+EvQTUFpgkM+2V6X5S3FmuV4uwgWzBInvqS94AO3v
 Jy2ulekEa3ZFhmHyo1qC5KiMwYl/0OTS4MjcF6qxgCfNWE3qMMOFnWZ7iMN8BjhEBc4O
 1aC59LKFAxh/4RGcXBCnoGtXjZqwYZHcZUjEbjmWuSd4mFbMQFU6wfeN7d2G/zIr3jTc
 jMmVwk7kCAy7NcVvAA1OK8hxAa++ngOmc2pHI+lDupf2sQI56+PGAxToKzD7EZvQrfoT
 nAPEP5kLfKW6vVuSGytZTGGD047b7XRiZrozcz/hr3SQcPSOSrygmKKDWFzHsd2MRvhu og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 17:50:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179HoS3M028155;
        Mon, 9 Aug 2021 17:50:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3aa8qrqcq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 17:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdmkTgLxTqswxv2R4LLb+xTELURE1B7vP0Nn0vhX8cGsSk32koLFefqJXtSob9mpEVmjpIL8lYCulBFpfIRI2r29Fdxt+gWvF/mIPEStyWOOIUKL9F/vfUPQSGKXfb9UmCdPHrhrdRTFXYEtPQVMpUgsMZrQHwrGplBdefxuyKLZDD/B7/NioeQ4ySKF7FuI63NLfn2aGUsvcHQ0PBbco9RDceIZFy0rVjEsqYt2UDILIZ+tauC8MSAu5YcNM+j9Yj1YPSIb0dWsVyH49lji9NwdNdU82mazsrZLwAOJGZVZDNzCareGFH4eI34JZpFS2dWY+j5Hp0c8NfrGmm2rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xhsy4uuZJLG4lyzGTY4jQyrr0SbaWwXY0j71VHFisk=;
 b=iw6OV4vZ1fd9eJ+AkwxiW4Mub6HIFS400GhMieNk+6IzKA6jQlKX3re/q/0cXRUWVPASXvsfegqYlaqaBV2GMRMsO96uoeuRpOXRnP764kiRywxhJiX0z8ECTb0nDviUG8qE2ehHj/mZ+LH2IuqZ/vQRIX3LSqk33i6N6FYbmBFTqjB2Wvw+oyrp7/FLc/rPHzv+OdloZKlINAzBLxwoua2PAcTQ1TPexrsGJzAcKZAz8+qavgAto663G91ydA81YVUrsRwWji8mKFbbqW3042zoc/vaFQ1tJxl3cMQCbBwFM7n0KnDEFQbhrtNz0r7ONcsKktFDMr8121mH7/mNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xhsy4uuZJLG4lyzGTY4jQyrr0SbaWwXY0j71VHFisk=;
 b=n3DntOE8B9d9Vqv4gKy6F+v9YX7zkVuoEu/BNxuNYmjDIPYf8PyOQq6efD9ySVbHjuc/wALws2vBGUB/8PyXHaG0c/dqgGlG9diu0t9Klm81pf92ooyOX4pBWpmDbKnIhVCmqMP9P4B8GJf/L/0BIXgOX0PCaJUrrVHd48e4+MM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5454.namprd10.prod.outlook.com (2603:10b6:a03:304::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 17:50:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 17:50:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thomas Huth <thuth@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Fix /proc/sys/fs/nfs/nsm_use_hostnames on big endian
 machines
Thread-Topic: [PATCH 0/2] Fix /proc/sys/fs/nfs/nsm_use_hostnames on big endian
 machines
Thread-Index: AQHXiFazbCL8ap5xPUS5u/husB93VqtrfVgA
Date:   Mon, 9 Aug 2021 17:50:17 +0000
Message-ID: <00D67F02-1AA6-43FD-B2F4-EC5015D59A7E@oracle.com>
References: <20210803105937.52052-1-thuth@redhat.com>
In-Reply-To: <20210803105937.52052-1-thuth@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d23f6091-77c9-4278-9449-08d95b5e2643
x-ms-traffictypediagnostic: SJ0PR10MB5454:
x-microsoft-antispam-prvs: <SJ0PR10MB5454DFB73500721202CAAAA293F69@SJ0PR10MB5454.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7PBivYbZn3dCFMGu/Rj0Stck7dk0xHlVB3xXvKz6PBKH8pTm/MLT4SXWfP+pzBPsRVWiS2SLc7PLF0I8soNFlJz6Df/jsXf5OtJfVjUkb1PD0stFb5fKV5CUJMqlKR57mnpkVy2V6pS0VuRGThA+dlg5yKQKrLQ1ifCSMu6B/LnwLbXFaBNRSizLDjGrYDX/E0W8r0z1IFPqA4HDvUNJJ5jRWIcJs2PL6y/GWoWozNbYjvzJqO+b6MUAxeuIuzcGqiE7iU/44Xi4hGHcsY97X6SnBzTQn9Qp4UgXN5R0wnStI21KHd4pFKNCOyG+568oCCUv+RcvAKKeOxCIOHKLm09rnmTQHx0Oq83H8i7Oei8Tj6AihjxvpKshISrTBvDnVKwdYmihxcvItWGuuA6nGPTt8IfPx6F63xEBUkiz9KX7PeyV8po95zExyJwVkNw0NFN4Mpukx7dOuIVeZmfXgbjJtJjck5qkbTSXxq/gIVIac275sSLTkFlJqxcikYMmPl6IPKHJGwo9+czo/4wn2uknBNaTf0FFpT/hqtt4zO62w9CBDOvIZmfd3BOSamkt7CprjXPN8fKTg/GXxAsnI9ZZpVdzGAxqW8WNY3wvfBI5ZwiPRlHqmiY3FFgZTzvJva6ofLgx8BdPrE5jl9kHFSOTCzqxunyAHF/IymIvkfuM3sKnkbfrwsKdwPN2m/piClCUZcZD1r/4qvs8RO8Ln/BcY1SQAXI0DOoxDoB51k0tBZ0VYhigzEwOrnNvAReacJNOBG38eNehD35/BwCGY4/KUije3ZfoYXsxLhW+0K+wKs/KwAZs+YOPi8JMbK9lfQ0oBqVC5TmoVrhnEFdfBuJ8HScgWP+SoLE0FfKTXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(8936002)(36756003)(186003)(508600001)(7416002)(91956017)(66556008)(54906003)(316002)(71200400001)(8676002)(66476007)(66446008)(966005)(66946007)(64756008)(5660300002)(6512007)(6506007)(6916009)(33656002)(53546011)(2906002)(86362001)(38100700002)(122000001)(38070700005)(4326008)(6486002)(2616005)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/nqNI/cH/6BtFlfozVfRFyG0BoyiXEm6uRb82d3+pSRq1aQKwaAWX6Eoirw9?=
 =?us-ascii?Q?A8qeMhXY7Bum/78DtpZjfiweZmgqPhDgFwdbkVRKtXHKnw00m8QTr/3Ev6Vm?=
 =?us-ascii?Q?dxJcz1wtqwEor7yXkrgkZtKq8A8zadZWZRfz/40JecRlNOXOFnK/abVIj5yg?=
 =?us-ascii?Q?M99lpQ0+tJIqSZij0VBC1mOFtgcuQmcF/sPjR0MiM97300Z0L0/7QG8u6R5K?=
 =?us-ascii?Q?/GQ38KmVS1Di2uMDOVca2ItTJGOWUuxy4vcL2Re2f/LEhmzRqC5JwUSH55N/?=
 =?us-ascii?Q?7hzDM2GapnGW7OkOAI8PfXMU2PnAm0rYrYWFsljVpr1j+MQcs2xG4ze6ZszG?=
 =?us-ascii?Q?mgf3bIMK437eehl9mi319fj7E6hqT1FC61bsTUuR4Yj4p7xoavUn+QHNgZvt?=
 =?us-ascii?Q?HQxXHi/QrfuHvlhVcGWFW4ovoNHc0yQsFFjHrvGFm+bGfsqoS900x3nXYkMK?=
 =?us-ascii?Q?r3Wm9tjpF/a1lw6zaQ0oMW7lwt/EhkDX82KLSJDYD7ieZoJRjL8gePQEV42d?=
 =?us-ascii?Q?DuJCqyYRFyXzuvIDWR0bI3JhigLUW3QhY4LKt7S6cF0sHGRJYqah46XFedJO?=
 =?us-ascii?Q?mxQh541wK4Vw7N0ZraeaG8dbYTlJNrMbGCub2ax+1UdgTyEa7AsK1mgiIXsb?=
 =?us-ascii?Q?i+qCZ0DPlTL6brezJIIeipqwDouEL0AwdYfN3JLWCw3eKzwArfogLnv82fri?=
 =?us-ascii?Q?vK39JE5vQmDHd1GiuEixa34MkN0VJoSnS1LvuG5m9p9all4XBd5jaPT5SAFp?=
 =?us-ascii?Q?XfaPNs7rl47p1QuRbaoWQWLBhDAgJiEkRj5eTliM+Tdob0KqnUcPqoXt797r?=
 =?us-ascii?Q?cSzO8MdRxz9WD4ktbYzE+vP5L5Uh2f1ic0us20wdk3yTpQ6BF6ALdM2jFogL?=
 =?us-ascii?Q?zq/6BzN3KAvy7PxtaZ27CSe+7eGeqa3ryN2cJnLXSSYqkPfMX/iOyi1TVhPI?=
 =?us-ascii?Q?ErAL1Ai6s4eYyznfmmZZyMFZpKfCzdz4XyhxOqCAENxBHF2a0VqyAqcOK0Ss?=
 =?us-ascii?Q?y7genk/SAXdodcgnVxY8lzs9J+GMQ0roTQzAUMr/FZ1eZ4eHIIK9y5sHcLMa?=
 =?us-ascii?Q?vbqmv3gLTO2XjpW/k/scQ57CIGLo3/n5309Fs+24Kk3HtlSWYVeF3j6qQgWn?=
 =?us-ascii?Q?0BOBPBdLCWHV/C2eVEODXnUi+v/hwKvk4QoTsxd6v1FAQumv30OnsvkoclfY?=
 =?us-ascii?Q?3DPz5qXjMnrkNL5N6+b0SBtfzsyejjfFFN2ni3SiD8dDta/dSrhE4EBR15aC?=
 =?us-ascii?Q?hyP5n6RF1tQHgsYLRAGcvd8RyXYOoBn8FoclqQVqwdrmaiFHNQQGPyp0+5Oq?=
 =?us-ascii?Q?UpPSV90Fx6+k9P9WQ9W4wv+7e4AKzdaaBrc9akpnNwlEWg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D08953FEDCCDF24EA43539FDE271F485@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23f6091-77c9-4278-9449-08d95b5e2643
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 17:50:17.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA4i5kUp6T+ohJPeDxOiXdyE+hEzp4n9GJh1zxOqhgrcm7RGWdAzEXHb407ZlfmDdG+1t1N3F4OmFTURWzVSgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5454
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090126
X-Proofpoint-GUID: NYHpcgp8-rSSOLjDL9VjfJLN2cT_9ca3
X-Proofpoint-ORIG-GUID: NYHpcgp8-rSSOLjDL9VjfJLN2cT_9ca3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 3, 2021, at 6:59 AM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> There is an endianess problem with /proc/sys/fs/nfs/nsm_use_hostnames
> (which can e.g. be seen on an s390x host) :
>=20
> # modprobe lockd nsm_use_hostnames=3D1
> # cat /proc/sys/fs/nfs/nsm_use_hostnames
> 16777216
>=20
> The nsm_use_hostnames variable is declared as "bool" which is required
> for the correct type for the module parameter. However, this does not
> work correctly with the entry in the /proc filesystem since this
> currently requires "int".
>=20
> Jia He already provided patches for this problem a couple of years ago,
> but apparently they felt through the cracks and never got merged. So
> here's a rebased version to finally fix this issue.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1764075
>=20
> Jia He (2):
>  sysctl: introduce new proc handler proc_dobool
>  lockd: change the proc_handler for nsm_use_hostnames
>=20
> fs/lockd/svc.c         |  2 +-
> include/linux/sysctl.h |  2 ++
> kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 45 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.27.0

To get these patches in front of our zero-day apparatus,
I've applied them to the for-next topic branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dfor-=
next

However I haven't seen an Ack for the kernel/sysctl.c change yet.


--
Chuck Lever



