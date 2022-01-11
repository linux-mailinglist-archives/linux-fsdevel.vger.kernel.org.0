Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44948BB79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 00:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346848AbiAKXf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 18:35:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4732 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbiAKXf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:35:28 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BMv7Z4005893;
        Tue, 11 Jan 2022 23:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9EJNmewhmo+LChVhuRRG/ONcIS+NCNPoqskom+mKHcY=;
 b=OzrwMBo3m5Npx6iLBBMG5G2edyEGAYKL8WHUbTthUZ4LdTLIvuqe767XjZtIamZkoqLl
 ag5R0vtatTujUiR5Lfu35zIRNhS4VK+JMdtt1SlhG8nTyRIK+52PsTmj7U2qFpiCbOpV
 tpHfW3epv57NIsSSnfXtlLco7WqO76+qNXMQEH0jyqNWLJMXckvIigpYxf4jVEbVz4Tl
 dfhvr1z3RZbFEhJorJFvqe744pmxZyVMwXmFo/ZOZ4vRg+n3HrMqANL7H/r1Bff83Or0
 zVvU06fUPyhiG7tp6tmfpD0xB+jaNDdKE7RFia1nI6tUmZLPx61tL3pInbhHyadiCzz/ Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgcxg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 23:35:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BNFeHE173751;
        Tue, 11 Jan 2022 23:35:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3df42nka2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 23:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANLYxxSYKd/DJonMBekKOXM22KOCGXe+vgjmU3cjxmofj8yRNS/k2jDgtxk49ocg+b1cNo8Toy2JsoPb4MRWeiEeGplYAOwyg+5p/9Kn1nO3ROBjBhxFzzCqGjz65QTyuXMIVvQ0lYJ78Cl14VCFVMQ+x1jb36fIFFVI2icgYEZE3wzWeBYx+m0+EaTKpvUP22sJyNSuB/rNDFbIno9gKJfuXjwSq+hsMJKpP7nja6HTUVBnk6JsCLwRChZo+xT4vT5ic2RmfJ0yuHgffWHqzAeNJszsSlWs+drMcNiOyYw4hVxHswt7DJJ+dU06gq5dW2bSS2YLLXGiX/kVBnD3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EJNmewhmo+LChVhuRRG/ONcIS+NCNPoqskom+mKHcY=;
 b=FDstEKj18632h36wom19srkfVF5yOEJ9Q7gX8JCdMh8TKbyCQfm9ZK4QGOCtg/Jr92AyKVc/ufgZjKevkVc6VGF807V017RcuU2tClgW98/HMuoSOpTzObsnL2FmhK+yJmSStdn9yepElDxqmaluORfFqK9EqJXhSu1Rr0jC3GmwKu0eXhAKnJbBzekJtm9BMx4Dc8CDcvlPX392RbFiCKa4/tGar1uP2RqH8E7WBz9pHBbVZUUOTx7NIwntKhVJa9AQMlvQxu33kKqDLEIYnEp02Qejk6TYqcGAgl9xbY1KzpjFyRFORlO6ivxM4Yo01SKhbRZ+mG1Qt+O90d8+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EJNmewhmo+LChVhuRRG/ONcIS+NCNPoqskom+mKHcY=;
 b=WzvOcXF2R4C/8UhkJnkZ51w9NOG6xbvPE+QYwsXDvtspyrZSxY1I8V01IRJDn10b58q2DRTC6vKJeiLDT5xIeS68kDEF9f/c1NtJ/7mvCKLuu5FCB74uOfjyAKwkvKf15ZhdL9v63PcxzX2y1IbceEFX29sLyX4nWEAHWJEYFSM=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB3039.namprd10.prod.outlook.com (2603:10b6:805:d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 23:35:02 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 23:35:02 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Mina Almasry <almasrymina@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Thread-Topic: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Thread-Index: AQHX3/1h6BaKuexxgk2yZwE5+ZTke6wYW6WAgBjlr4CAIn2OgIALCNgA
Date:   Tue, 11 Jan 2022 23:35:02 +0000
Message-ID: <FD103257-48FC-4441-BB32-58C14C0CDE3F@oracle.com>
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YaMBGQGNLqPd6D6f@casper.infradead.org>
 <CAHS8izM5as_AmN4bSmZd1P7aSXZ86VAfXgyooZivyf7-E5gZcQ@mail.gmail.com>
 <CAHS8izNw87-L=rEwJF7_9WCaAcXLn2dUe68h_SbLErJoSUDzzg@mail.gmail.com>
In-Reply-To: <CAHS8izNw87-L=rEwJF7_9WCaAcXLn2dUe68h_SbLErJoSUDzzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 395d1274-be23-4be0-ea5f-08d9d55afd69
x-ms-traffictypediagnostic: SN6PR10MB3039:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30391C5C71EA570CCF10DFA781519@SN6PR10MB3039.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZ2QHyI9YA3N/LafWKvSNURZZt37H39uLTf81vWIa5JaalTGRh2/U9bBSqm9CJlEjJBLPMDfaQK3O8pg/35/M6NQrlzqyMlAfayUI53zOcGDTSLa6hC1Jin1sl39EOXtI36395YIwKfle/V/ptC1FKoc0oeaVYzMzm94ix5LXAGBYvF28qkESZL0NcoFkXYmbjREDeAZkiiBbB2UVkjY3QsPr6JhtqiiFzmUqWRdWWLwHYB9PFKqAVxTxGS5BEeOs4zolVmeDr43sU7+GSpuxCvmlGz79NeTL/izgQbFvIGUx4Fi1IOSPRMXAruXo5c/t1hr88REm50nfHyuzViziLiUznldf8FuHPlbDOwXfHaPifCfoeK/ywXPxZXAuRt1GcFqULJXiUGEr6FTEG0JYVWjLRvb02+VH5Al1QnK9Gbrmu7CUdOm5av0jp3epbeTveGqIp452iYUTvM2aMnuEcKEEjqy3MfTIi1/bxLuznrAhNl+ni1bORk55iArCpqfFCcrOFiR5/PfX+H3QVHD64ie7zfOBrYIJoUo7S4zbnb8nmI5Ec8gyrHoTvwcIVfy1YuFm0jLWcG78S79NHxyI+eZx6nUnxEmYNavgp5+lj9cS9eyc1qSbmmaPoIBwgZR9wXITYF7vjGWb+ltelDbe9v0gN4e9HjmQ7fapYvdvRFLBCBaZntNDzsr9zHDImw3O9Kf9SIBeZwnajEG4yAQFe4Pi2XuWZ7Dd/8nhR1mtHL4PmB+TRpyoaDtcJ08pM4G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(71200400001)(8676002)(5660300002)(83380400001)(33656002)(8936002)(316002)(186003)(2906002)(54906003)(38070700005)(36756003)(508600001)(53546011)(91956017)(6506007)(86362001)(4326008)(6486002)(66946007)(66446008)(64756008)(38100700002)(44832011)(66556008)(66476007)(7416002)(2616005)(6916009)(122000001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FW//jVQnj6+5z0AKgrYOMH77NbWLX8b/2k1uCvQejB/5Y48UjSaVXzvq88sy?=
 =?us-ascii?Q?YqurGfg00kF5+e1L0p21BRXEFTKYhu8ev3bKdd49ZunOG4TDyick5l1/CSEG?=
 =?us-ascii?Q?6Opo+p26z92uwYFRI12vkF3fsN3JEFFPzxA3Pq57O/6omzb7dD8VwlJltfYO?=
 =?us-ascii?Q?NUaZTGLfzebumLf810/AAtm/70tRqvuP+sJJSzeSbd2D0BQCQ+E/rSDHABMu?=
 =?us-ascii?Q?ut3DUrJhw154HgbwEByopLvGl5e7RMXf1Asu8kFhPDG3aO5bZuHwkMukslfP?=
 =?us-ascii?Q?+pqy8veIAo3kEzqxmaYIlXXzT4uQPkSuOnMIuYKofckw0SmHECo5iOrKvFqH?=
 =?us-ascii?Q?5U+hONLpKFEusguivnzhY5357y7rCiA07Ux/ATNvX1ms/at2pAAoI5AEfxxr?=
 =?us-ascii?Q?Qwy/FHGo9LfZlglaOa1BY3D2m/KX1AnnU90kLb3FfnpUoD8hbgZNokP4raxa?=
 =?us-ascii?Q?5MqD7dnFPC+GrM1Ol+QvPDvNzPWK+eUStNaBI4GTIJLOMrXKY3IHbdGw5ZK6?=
 =?us-ascii?Q?m7Qzc+PE8kCIp3oRQVcr72y2rjQlnACpihJZqQQgWtNDUrZVweOZKlii9rHi?=
 =?us-ascii?Q?Yt3v8u19eHJOCwk6mzM1FMhU436KoZCVgS3f1WWOWqOfw9XNcJxr3py0mMnc?=
 =?us-ascii?Q?/zB9HxojpMTHNv+zkeDmueI1/1uHIaeRYB+S5Jv3JdoqBVGHEroqfRvkiMT3?=
 =?us-ascii?Q?5XC59iqGWK8f34B5XDKSk348sScuHf8mzmspB+KFVY4YLQdTBxXDxTQdqnzA?=
 =?us-ascii?Q?6An7Kur7ZBn3IZC1ZusqRIn7lKFaZdhTi3NOVgmqFjQ5m01zPdNRKcMLobtZ?=
 =?us-ascii?Q?rKDiky8jCHpMqIWkCpS6ownprA22wQ3jrRmTsaSpqIGoF9STfR6mm1jhnojs?=
 =?us-ascii?Q?20a3UFFjtfGnYAIO1whqBxNIfMnEnug5xIGk+PSBgvl2LZYfcGvMNRTbpplj?=
 =?us-ascii?Q?wFKKIKUBfApLwcZrRcb8YxtAVobjFbvp3wyKlfaomF/Ha3jRq6O7Sn5PPPat?=
 =?us-ascii?Q?ZHjfFwhcx/4iQ0jrKvaSStHz3w2jMGJvrgjKQKz/si3t7hNIlTiVtHuj/Jx3?=
 =?us-ascii?Q?esJnbMwQrw4OTF4JjBacHNCI8e3tomIv0ocedKLy6oDVcPglPDE8z7+x7Vhj?=
 =?us-ascii?Q?JmHXgLQ9SAMcWxWbOKkF3dOGOsgw6nep70mnHVUXsAvOFNOUzwPzi8Y0PdDW?=
 =?us-ascii?Q?XzoQXRUWC85+RY0osDamrBzUx8+aX54m73CCm7/+2KZMBvFuaI6+oiG2vMNj?=
 =?us-ascii?Q?MafbctxMvx7B755KxM8ZGUULx5tp1XKpksfU3kf+2NkI2vjdrGhc6MvJ2ZBe?=
 =?us-ascii?Q?q1hrG6kV1rpsOaQzBvfNb80MnmZ/FGhM5wwL6JqyChsA2HHal9yr2rn7Zlb+?=
 =?us-ascii?Q?odd85DNvi1XdilKvezOdnfl4XZGEp+NZmuIN+o5o1wkl1Xv98ktOD5KmcIjN?=
 =?us-ascii?Q?mrj482QiNCikBJgmHLDO42Kenomi3DIWMwyZLd0KrmQZcLVaCsOXFE9A6rOL?=
 =?us-ascii?Q?TTOjZbdabeI3i2knIJRWSPXT5MoCjT077SCN9L2e4Ah8sYDu/6IQ3JCTK0+5?=
 =?us-ascii?Q?tVM8oQWhqMf515TM2ry3Zg9WPy46ieQeE6UBBpbd3i128Zd1HOasHwkUuk90?=
 =?us-ascii?Q?jBFw2QBnafr+gIUsCG8wx9qKU3t/SrIPIJd9TfVVwQdIzi+jUA3pTfOI+mGG?=
 =?us-ascii?Q?2VQi6F7zH8Gk5bxpZ3+lK9ZsVZ7IHJ9KQwA+yrrkuS3O2fz4eVd0/SXcKPgC?=
 =?us-ascii?Q?50YlfaqmhsOeoYuSTKkRdhNUS5cJIqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3E6EAE394F104489230B14073CA141B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395d1274-be23-4be0-ea5f-08d9d55afd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 23:35:02.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6X5P4hu1N26x/jNNF0FEc716SF+Y7xwbFYVs0/07R2akNxTZ3KCeqEkRQwQ9T8VmWSplS17rwIvHDVaKbM6gy5fgUI8+LRhgGOsUqp9+JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3039
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110122
X-Proofpoint-GUID: sFwmZ_QPAN4olOtvyKpMl0BFT9VMgK4r
X-Proofpoint-ORIG-GUID: sFwmZ_QPAN4olOtvyKpMl0BFT9VMgK4r
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 4, 2022, at 4:04 PM, Mina Almasry <almasrymina@google.com> wrote:
>=20
> On Mon, Dec 13, 2021 at 4:22 PM Mina Almasry <almasrymina@google.com> wro=
te:
>>=20
>> On Sat, Nov 27, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wro=
te:
>>>=20
>>> On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
>>>> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given=
 virt
>>>> address is currently mapped by a transparent huge page or not.  Exampl=
e
>>>> use case is a process requesting THPs from the kernel (via a huge tmpf=
s
>>>> mount for example), for a performance critical region of memory.  The
>>>> userspace may want to query whether the kernel is actually backing thi=
s
>>>> memory by hugepages or not.
>>>=20
>>> But what is userspace going to _do_ differently if the kernel hasn't
>>> backed the memory with huge pages?
>>=20
>> Sorry for the late reply here.
>>=20
>> My plan is to expose this information as metrics right now and:
>> 1. Understand the kind of hugepage backing we're actually getting if any=
.
>> 2. If there are drops in hugepage backing we can investigate the
>> cause, whether it's due to normal memory fragmentation or some
>> bug/issue.
>> 3. Schedule machines for reboots to defragment the memory if the
>> hugepage backing is too low.
>> 4. Possibly motivate future work to improve hugepage backing if our
>> numbers are too low.
>=20
> Friendly ping on this. It has been reviewed by a few folks and after
> Matthew had questions about the use case which I've answered in the
> email above. Matthew, are you opposed to this patch?

I realize I'm jumping in late on this, but while (1) and (2) are
understandable, this bothers me:

> 3. Schedule machines for reboots to defragment the memory if the
> hugepage backing is too low.

If it's important enough to reboot the machine, shouldn't one be using
hugetlbfs instead?

It seems like user space is trying to track something it shouldn't be conce=
rned
about, rather like if user space were concerned about precisely where in ph=
ysical
memory its pages were mapped.

