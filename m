Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED349F0B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 02:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiA1BtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 20:49:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30734 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235404AbiA1BtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:49:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RLtgoS016333;
        Fri, 28 Jan 2022 01:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l69FsGVrSry+uNlt6CY88yGIuYMUQCqtgYX7A/TPFGQ=;
 b=fiEORbf4+n8AG5F4wQ1O4DCTlLl2X+FbZIN2xAgZLxhBfcO8oBKSNPkJXupvsJ9SZuXI
 Y8YOGxQv7pi+7p6Cvv7Nlg47qCZqw1qj8CL0nnQDBR/V2freNpkrIAdtYDdMnm4Dz5hY
 w6nRDPCPFsj3EBK/iN2wvdESfm9JVcgdPBvhKrPZ1b1eiEHgPixTdI8b2CkE64cD8Vz2
 bvJIO5nhsW1yAb7WvSWoCJcPRluGCQtNqB7eqoEHzw5FM4IRQHDmraW6Khvd6C01DsGb
 5o3vlv/inbnl5PkwhLE9cWpE4CjiaxSSlQw77fNBAmwms+vkELwtC8pCVbjw8+tNqLYF lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp1e6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 01:49:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S1jlgt002395;
        Fri, 28 Jan 2022 01:48:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3dv6e3tb1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 01:48:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAKJIgC85Ui8+Fs2XIxba7kGJm8IsU2C2oLe5cROPSIg7IIcFPPdc8qWvuHVZMeR5umW8EYfKgZmBRsKMe19hVPR4K/AdN8bq4k0EAe3LHvi3SG0srCV6HLinIy95s/dTQgzbbgez2liUbz6IWZmUyDdQ4XoJ/KvVMzTb7M0zTlSo2/LUa1yUAlDbIFI87VQ9OSBOSUboiO+CElkRSkIQtk5e9e630voA6AwQvpbtaVUY4MbJCOrGtWc9V7AMXDLwUe8Ys61eDBxunDntxM1mR0s3LShIyfYzZoTJX8WA96HvtsTNdiGR+jGFGKstc2R5zSWK3LNoxdBLNYQtFUwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l69FsGVrSry+uNlt6CY88yGIuYMUQCqtgYX7A/TPFGQ=;
 b=DcCL/V8M4288E8KJcO7NA3Kpr+ZFBBQbbZKPMRraRdQkNMkzWPlJ1pHKWLnAGZio9jaUmMZ/MXhucUdnTwkVkhbSYoCHxc4su2d3GWajCl9aqrFWCrOXEI/iQx15dNAZnPZIwQcEErSKbW4rCROvNbxi/AQ6bO949naI8zzaOg7Lv1PBUfyjqwe2X7nauF/xnFRrgs7EmctjjEB93pd0oHMgn0pezBAkiqVzuM0iIEJ54lNdTY7DqUyQeRDowg3qooITb0HsPqOHUs9iWsAfaPlIbm9atJ4KKy/GG6Bqyie9t5zuaPvil2CCFexyuK9MwoKyZ/kLN90xcNNB9RuCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l69FsGVrSry+uNlt6CY88yGIuYMUQCqtgYX7A/TPFGQ=;
 b=S4IAC6Gy6LNHt522SsGlRtvd4zfv79yOhKrQDceDuWXAn/10+5cFySpAMrWDJ/8CjY05U4JnhmwaZHwOp6IIxHrLxIxlg1VOLZPuoFM/KaP3GRbaynAdgMdpwDz4VEZy0tNENT9VoFefqbC2biMIiYzohiXKAhG/zyRFQbkxh+8=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 01:48:48 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 01:48:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/6] NFSD: Fix NFSv4 SETATTR's handling of large file
 sizes
Thread-Topic: [PATCH RFC 1/6] NFSD: Fix NFSv4 SETATTR's handling of large file
 sizes
Thread-Index: AQHYE5gnMaDMLUEEDkiNXrKLKlhIy6x3lwuAgAAUJYA=
Date:   Fri, 28 Jan 2022 01:48:48 +0000
Message-ID: <77B0ABAA-3427-4E4E-AE5A-B6D34FB6E837@oracle.com>
References: <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
 <164329971128.5879.15718457509790221509.stgit@bazille.1015granger.net>
 <20220128003641.GK59715@dread.disaster.area>
In-Reply-To: <20220128003641.GK59715@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e9220aa-acf4-4726-81a9-08d9e20053ca
x-ms-traffictypediagnostic: PH0PR10MB5658:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5658714286929217C454199E93229@PH0PR10MB5658.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwD9ZIYJo8ynR94EKPgRZIBrD2iaibCCK7govqpqWwNSFFyTmkGYyaWpI9aeaSBWbfZ7BrSUfl4kHR4JcZn3V3t5ZE/NCOf90xWdPLPtnrqsDm1fVMcMlAuV+IKo0QKiYtjOZyS1OrZkVgNXKg5UbeVn/1xukVGEptDqSfNHsBhQOrBoqqK9v0mQaIThvbWggF1RysiDO+60rpnQ0VHIHi/s5lss1oQuT2J2MLx298XIbgfaZ5SrAeYVpnn0kxwvDM+GQN9gK4hzswsC0zQh6HyDZNCg0pIXoR01klLrEGs9WjS0KysdkeF7hGUE2WLkJY9yut2tCplt/jQGw63uvIMGvGpc1SiFZZbgCZsCmmiIp1Nw/NXqoDj9cQR2DzrAQfBS93TPl0lErx7zQitzWIP5KmbP3QIiKFpEROfvMLNUb+SIAqx6EGT5fJvqnW+y4H5irylEwZKV7VBd5FwABiweX0QWnW5ci1R+uBk4n9fo/SLpoC80npgXz4SSTlz9EmUnk94ef6ODNEpzyebpA3+KE8F+9eMsOvGerh/Ee1+vn6b0zgkudR6rSGwboYgL3JURllYRpPRQ758lg135EQZiPVwCmXbXm4FhcqLm3PEKcwfBPsID3uzqZThnaweryVi+NyWzEYugBnvhI5Wm3lLPOF+oN8GAUBBPWgLKc5ojeW/W+q1ZusgfyI2BeDraqOBEAlcIqKoLc728UjQvTf/zNmewDUTcPNiI/sXvHT2IgiKvNvCVzfF5Tz1z4wDy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(45080400002)(66946007)(6512007)(6486002)(53546011)(5660300002)(66446008)(71200400001)(186003)(8936002)(26005)(2906002)(54906003)(122000001)(38100700002)(316002)(2616005)(38070700005)(6506007)(76116006)(4326008)(64756008)(508600001)(66556008)(83380400001)(33656002)(8676002)(6916009)(86362001)(36756003)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WzpucOiI/+Np5XQ39RMHIYZB9E1EdiCpsEojBnWS5kdaXXMYuAOqOx6O7LNf?=
 =?us-ascii?Q?UeGeAEJudJRMcG8jCsOJsGwWEBML1wk+MfRZXwlV3EPU2JxtD+fVBWGV2OM0?=
 =?us-ascii?Q?yCXjVBZcGJ2i3lwa97scfEt+F02lr+/pYKLfqI10cUd4hNfW0aNR4LtWHaIp?=
 =?us-ascii?Q?cHP6ZkJBF2xxwtJ5An+lL8k6WbWfda1WTfd6lRAbKyV2Lf+aKaDIncQO6jqD?=
 =?us-ascii?Q?ATBmWwmqS/TNIp3ePpUTwz2PECwWd5anCx6E2cyzGFeX+CMitU/lNj+gRr+5?=
 =?us-ascii?Q?J5WnF14bS9e/N0mHqdxSVKLpU977L5O/XYoSjG2qfyypItTFN1YzHRNxibHP?=
 =?us-ascii?Q?osiPUZFCFcQeJK9bcsuIn6ZY7FiD51fSu6RuyMc7pqt9VW+v6CYoWNcX0kPk?=
 =?us-ascii?Q?T64eEaJQnuq4opSfXejGsPnWnQUb4aMVlLL7WMnfL9/1NVx46CdY0SUpqQY0?=
 =?us-ascii?Q?lxvRRJXNTadwUme4fp5rInyZ6Ap0JTYojhl9d7VkSa+yKaWNYTXFo4oOZGKw?=
 =?us-ascii?Q?VYIDMiSGykEs8NoaLYupsUf2wSow3HW7dr2bqBxBdzvs+UX8XntuJXL1awyY?=
 =?us-ascii?Q?XekUKsuOeXyvCi4U8zDrdnsYxCT4b3cvVFIiYERId1J0cjRVlTh//tfNHuTW?=
 =?us-ascii?Q?b1PzzBpFwFfEd1gGq2V1gstyQJqBTQZmTAcct8ObHxVrsEa7yhnHk0Zz6c8y?=
 =?us-ascii?Q?WPnCHVnyqssWxN/GdgpXdUPRBh4iWUZM4+NXtvz7xUEsc8Uv0jxs2DO1uTRG?=
 =?us-ascii?Q?6hMc6sLgHxaIvEbXVMXz629/VMTOHT8EU3/7mYZl42Cb4AFJfFvXJtdFxYFr?=
 =?us-ascii?Q?hZdyRyDIIMujmB9ZaGFq+Yxb0gghU6fDgA7HUY8UkyKGZFDwgkxwYbRkWKIY?=
 =?us-ascii?Q?nEshL2SOBmgPuJBT3BFWJLdNVwS4cM7lDiZb0KkFPjrex2qJhXGPkR0w//QX?=
 =?us-ascii?Q?d100SyyslBkeVx2jR1LnFA6VfVlLi+a6OBn1yYmwcw1gk3NFpBv2iRLJKGzm?=
 =?us-ascii?Q?972Gca0Z5QbDtcAmgOX1B0lKdjbUm+mkOZpc8Lm+fk8TRefhzX4NzTZF42IM?=
 =?us-ascii?Q?mIP8qdvJnOfWuXpeUaZd2Wu0eKzxLZNGRamlr7WAd0iHtd69mzdP9q7XY+Uv?=
 =?us-ascii?Q?Kwnd0L8o4gO969YUC13ZpRugfpBqw+hpB7XwTG7pjFdjEhsD37dZAjS+t3QR?=
 =?us-ascii?Q?QiDczBQPxRGzPX3NLGzJk2d0E0+3C7OFr9eGyXnvbG6IsY29Z4DTJCTLdpw6?=
 =?us-ascii?Q?OUCcdfAAVCHSu7e1LL07GanwQwZuJFJlnwnNqg4DbMAwikRR3ujY5NLqqLd4?=
 =?us-ascii?Q?9l5fzEZaIqTDzj7NobcezD9g5F1bhvVLVOovw+JPXQlMwz9TEZaoLi/x8ODE?=
 =?us-ascii?Q?Vulu4IEMBin2XVaF12BX/i/sFFU4fJ4gu69JfsEp3FbRGN4nNv0lw5iEdrxe?=
 =?us-ascii?Q?VdG2daa8ehOAitWNXkDW/FvLbFfMmek8kk4/MjiMtAUFrL6XR9kRg57KXdna?=
 =?us-ascii?Q?r2vp/EuAVAXNBcF64rVh0rogns01MjgH7OFN0JiCJ7cRoE03TH4WeiE4+l/r?=
 =?us-ascii?Q?li2W8vVONyL/TEF+JUr+UtPIrOWfwvjGn9Rdci7TB3O3n8a9yCFwk91Px9hT?=
 =?us-ascii?Q?BvtD765KRQocKg6LYNc8Vv0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E40D3DFF461F940AEDE81F3E66CABF9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9220aa-acf4-4726-81a9-08d9e20053ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 01:48:48.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgdYJNcKxAURnQA6efMjk5PC2WaDMlNGRZkRat8+0MNVwZead5h7J+O4ccsvamptqWTEA1xmE24V4ZIfGthLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280005
X-Proofpoint-GUID: ksF0gkhW0da-hCrL2-4m96qfbq8SLlo9
X-Proofpoint-ORIG-GUID: ksF0gkhW0da-hCrL2-4m96qfbq8SLlo9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 27, 2022, at 7:36 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Thu, Jan 27, 2022 at 11:08:31AM -0500, Chuck Lever wrote:
>> iattr::ia_size is a loff_t. decode_fattr4() dumps a full u64 value
>> in there. If that value is larger than S64_MAX, then ia_size has
>> underflowed.
>>=20
>> In this case the negative size is passed through to the VFS and
>> underlying filesystems. I've observed XFS behavior: it returns
>> EIO but still attempts to access past the end of the device.
>=20
> What attempts to access beyond the end of the device? A file offset
> is not a disk offset, and the filesystem cannot allocate blocks for
> IO that are outside the device boundaries. So I don't understand how
> setting an inode size of >LLONGMAX can cause the filesystem to
> access blocks outside the range it can allocate and map IO to. If
> this falls through to trying to access data outside the range the
> filesystem is allowed to access then we've got a bug that needs to
> be fixed.
>=20
> Can you please clarify the behaviour that is occurring here (stack
> traces demonstrating the IO path that leads to access past the end
> of device would be useful) so we can look into this further?

Reproducer:

I constructed a pynfs test that sends an NFSv4.0 SETATTR request
to set the file length to U64_MAX. That test was applied to pynfs
today.

git://git.linux-nfs.org/projects/bfields/pynfs.git

I will note that I tried this test against a tmpfs export as
well. No crash, but a subsequent GETATTR returned U64_MAX,
which is surprising. There's really no checking in that path
either.


Note below: md0 is the device where this filesystem resides.
It's a pair of 3TB PCIe NVMe cards striped together. Kernel at
the time on this system was 5.17-rc1 + a few NFSD patches.

Jan 26 16:01:26 klimt.1015granger.net rpc.mountd[972]: v4.0 client attached=
: 0x61bb6d4261eef9f6 from "192.168.1.67:53636"
Jan 26 16:01:26 klimt.1015granger.net kernel: ------------[ cut here ]-----=
-------
Jan 26 16:01:26 klimt.1015granger.net kernel: WARNING: CPU: 2 PID: 1009 at =
fs/iomap/iter.c:33 iomap_iter+0x1b5/0x272
Jan 26 16:01:26 klimt.1015granger.net kernel: Modules linked in: rfkill rpc=
rdma rdma_ucm ib_srpt ib_umad ib_isert ib_ipoib iscsi_target_mod ib_>
Jan 26 16:01:26 klimt.1015granger.net kernel: CPU: 2 PID: 1009 Comm: nfsd N=
ot tainted 5.17.0-rc1-00165-g2785fad9b745 #3338
Jan 26 16:01:26 klimt.1015granger.net kernel: Hardware name: Supermicro Sup=
er Server/X10SRL-F, BIOS 3.3 10/28/2020
Jan 26 16:01:26 klimt.1015granger.net kernel: RIP: 0010:iomap_iter+0x1b5/0x=
272
Jan 26 16:01:26 klimt.1015granger.net kernel: Code: 8b 73 08 49 8b 04 24 4d=
 89 e9 4d 89 f0 48 8b 3b e8 c0 79 8e 00 85 c0 0f 88 c1 00 00 00 48 8>
Jan 26 16:01:26 klimt.1015granger.net kernel: RSP: 0018:ffffa65701ea3a80 EF=
LAGS: 00010213
Jan 26 16:01:26 klimt.1015granger.net kernel: RAX: 0000000000000000 RBX: ff=
ffa65701ea3ad0 RCX: ffff8ada8cf0f840
Jan 26 16:01:26 klimt.1015granger.net kernel: RDX: ffffffffffffffff RSI: ff=
ff8ada49411000 RDI: ffff8ada8cf0f840
Jan 26 16:01:26 klimt.1015granger.net kernel: RBP: ffffa65701ea3aa0 R08: ff=
ff8ada4a56b000 R09: ffffa65701ea3b40
Jan 26 16:01:26 klimt.1015granger.net kernel: R10: ffffa65701ea39a0 R11: 00=
0000000efc25f5 R12: ffffffffc06d6100
Jan 26 16:01:26 klimt.1015granger.net kernel: R13: ffffa65701ea3b40 R14: ff=
ffa65701ea3af8 R15: ffff8ada4a56b000
Jan 26 16:01:26 klimt.1015granger.net kernel: FS:  0000000000000000(0000) G=
S:ffff8ae97fd00000(0000) knlGS:0000000000000000
Jan 26 16:01:26 klimt.1015granger.net kernel: CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Jan 26 16:01:26 klimt.1015granger.net kernel: CR2: 00007ffff8126260 CR3: 00=
000001a16dc001 CR4: 00000000001706e0
Jan 26 16:01:26 klimt.1015granger.net kernel: Call Trace:
Jan 26 16:01:26 klimt.1015granger.net kernel:  <TASK>
Jan 26 16:01:26 klimt.1015granger.net kernel:  iomap_zero_range+0x6c/0x1a9
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? __radix_tree_lookup+0x2f/0=
xac
Jan 26 16:01:26 klimt.1015granger.net kernel:  iomap_truncate_page+0x31/0x3=
6
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_truncate_page+0x39/0x3b =
[xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_setattr_size+0x11a/0x306=
 [xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_vn_setattr_size+0x4e/0x5=
7 [xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_vn_setattr+0x67/0xb1 [xf=
s]
Jan 26 16:01:26 klimt.1015granger.net kernel:  notify_change+0x2ac/0x3a2
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd_setattr+0x200/0x268 [nf=
sd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_setattr+0x200/0x268 [=
nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd4_setattr+0xf1/0x130 [nf=
sd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd4_proc_compound+0x337/0x=
474 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd_dispatch+0x1a9/0x260 [n=
fsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  svc_process_common+0x331/0x4=
bc [sunrpc]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_svc+0x2f5/0x2f5 [nfsd=
]
Jan 26 16:01:26 klimt.1015granger.net kernel:  svc_process+0xc8/0xe7 [sunrp=
c]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd+0xdd/0x160 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  kthread+0xf7/0xff
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_shutdown_threads+0x65=
/0x65 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? kthread_complete_and_exit+=
0x20/0x20
Jan 26 16:01:26 klimt.1015granger.net kernel:  ret_from_fork+0x22/0x30
Jan 26 16:01:26 klimt.1015granger.net kernel:  </TASK>
Jan 26 16:01:26 klimt.1015granger.net kernel: ---[ end trace 00000000000000=
00 ]---
Jan 26 16:01:26 klimt.1015granger.net kernel: ------------[ cut here ]-----=
-------
Jan 26 16:01:26 klimt.1015granger.net kernel: WARNING: CPU: 2 PID: 1009 at =
fs/iomap/iter.c:35 iomap_iter+0x1ca/0x272
Jan 26 16:01:26 klimt.1015granger.net kernel: Modules linked in: rfkill rpc=
rdma rdma_ucm ib_srpt ib_umad ib_isert ib_ipoib iscsi_target_mod ib_>
Jan 26 16:01:26 klimt.1015granger.net kernel: CPU: 2 PID: 1009 Comm: nfsd T=
ainted: G        W         5.17.0-rc1-00165-g2785fad9b745 #3338
Jan 26 16:01:26 klimt.1015granger.net kernel: Hardware name: Supermicro Sup=
er Server/X10SRL-F, BIOS 3.3 10/28/2020
Jan 26 16:01:26 klimt.1015granger.net kernel: RIP: 0010:iomap_iter+0x1ca/0x=
272
Jan 26 16:01:26 klimt.1015granger.net kernel: Code: 85 c0 0f 88 c1 00 00 00=
 48 8b 43 30 48 8b 53 08 48 39 d0 7e 02 0f 0b 48 8b 4b 38 48 85 c9 7>
Jan 26 16:01:26 klimt.1015granger.net kernel: RSP: 0018:ffffa65701ea3a80 EF=
LAGS: 00010293
Jan 26 16:01:26 klimt.1015granger.net kernel: RAX: f8ada41a253c0000 RBX: ff=
ffa65701ea3ad0 RCX: f8ada41a253c0000
Jan 26 16:01:26 klimt.1015granger.net kernel: RDX: ffffffffffffffff RSI: ff=
ff8ada49411000 RDI: ffff8ada8cf0f840
Jan 26 16:01:26 klimt.1015granger.net kernel: RBP: ffffa65701ea3aa0 R08: ff=
ff8ada4a56b000 R09: ffffa65701ea3b40
Jan 26 16:01:26 klimt.1015granger.net kernel: R10: ffffa65701ea39a0 R11: 00=
0000000efc25f5 R12: ffffffffc06d6100
Jan 26 16:01:26 klimt.1015granger.net kernel: R13: ffffa65701ea3b40 R14: ff=
ffa65701ea3af8 R15: ffff8ada4a56b000
Jan 26 16:01:26 klimt.1015granger.net kernel: FS:  0000000000000000(0000) G=
S:ffff8ae97fd00000(0000) knlGS:0000000000000000
Jan 26 16:01:26 klimt.1015granger.net kernel: CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033
Jan 26 16:01:26 klimt.1015granger.net kernel: CR2: 00007ffff8126260 CR3: 00=
000001a16dc001 CR4: 00000000001706e0
Jan 26 16:01:26 klimt.1015granger.net kernel: Call Trace:
Jan 26 16:01:26 klimt.1015granger.net kernel:  <TASK>
Jan 26 16:01:26 klimt.1015granger.net kernel:  iomap_zero_range+0x6c/0x1a9
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? __radix_tree_lookup+0x2f/0=
xac
Jan 26 16:01:26 klimt.1015granger.net kernel:  iomap_truncate_page+0x31/0x3=
6
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_truncate_page+0x39/0x3b =
[xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_setattr_size+0x11a/0x306=
 [xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_vn_setattr_size+0x4e/0x5=
7 [xfs]
Jan 26 16:01:26 klimt.1015granger.net kernel:  xfs_vn_setattr+0x67/0xb1 [xf=
s]
Jan 26 16:01:26 klimt.1015granger.net kernel:  notify_change+0x2ac/0x3a2
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd_setattr+0x200/0x268 [nf=
sd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_setattr+0x200/0x268 [=
nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd4_setattr+0xf1/0x130 [nf=
sd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd4_proc_compound+0x337/0x=
474 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd_dispatch+0x1a9/0x260 [n=
fsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  svc_process_common+0x331/0x4=
bc [sunrpc]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_svc+0x2f5/0x2f5 [nfsd=
]
Jan 26 16:01:26 klimt.1015granger.net kernel:  svc_process+0xc8/0xe7 [sunrp=
c]
Jan 26 16:01:26 klimt.1015granger.net kernel:  nfsd+0xdd/0x160 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  kthread+0xf7/0xff
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? nfsd_shutdown_threads+0x65=
/0x65 [nfsd]
Jan 26 16:01:26 klimt.1015granger.net kernel:  ? kthread_complete_and_exit+=
0x20/0x20
Jan 26 16:01:26 klimt.1015granger.net kernel:  ret_from_fork+0x22/0x30
Jan 26 16:01:26 klimt.1015granger.net kernel:  </TASK>
Jan 26 16:01:26 klimt.1015granger.net kernel: ---[ end trace 00000000000000=
00 ]---
Jan 26 16:01:26 klimt.1015granger.net kernel: nfsd: attempt to access beyon=
d end of device
                                              md0: rw=3D2048, want=3D199077=
65165852672, limit=3D12501942272


>> IOW it assumes the caller has already sanity-checked the value.
>=20
> Every filesystem assumes that the iattr that is passed to ->setattr
> by notify_change() has been sanity checked and the parameters are
> within the valid VFS supported ranges, not just XFS. Perhaps this
> check should be in notify_change, not in the callers?

My (limited) understanding of the VFS code is that functions at
the notify_change() level expect that its callers will have
already sanitized the input -- those callers are largely the
system call routines. That's why I chose to address this in NFSD.

Maybe inode_newsize_ok() needs to check for negative size values?


--
Chuck Lever



