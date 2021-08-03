Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8891B3DF033
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhHCOYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 10:24:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21892 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236282AbhHCOY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:24:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173EGecY017817;
        Tue, 3 Aug 2021 14:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Stgz54hxG31raShujhkMMtOJqBA/L9UsVwzlrKd6uo0=;
 b=ScOqhcG+9T5bhh5Owizoh2b5fm26gval2ZnLzRRwZhSldF8QFfNRBrxtgYGeEbJ6ZBdk
 8pblpikAeq1GBvAh8ZbE7VgMAvHRQAv05zv1VVkEuUMYNWAVzRs1bjt8/UrvPfksmwJ9
 G7/OI1x0Zqb03i5+kzV3VtzcM2DR3WuxUywWJKEaHcEWSSuA1rVKzB4heQ76cAYWhxkk
 1rzlx499QPjUuN9RCxZ3SoL0Zil/TQJbSJwEgxeo3dUSiigGuT8fKrlSsYjkiZdP7Wi5
 cXo4yFYjsFWj46SN82cddShLptwHSyKp6NIkjBMvZkZmPKBibxJlF0bPjmYDMZ0DZugF 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Stgz54hxG31raShujhkMMtOJqBA/L9UsVwzlrKd6uo0=;
 b=hnYfAb2sSxTlCh7T54TKfblp4P5DUNDcIF4uFZDmyzwzjS4qsTPdoJv4H1yLK1V1fbyd
 BxvDX0SqgJSFiL//9fU71kl7OdRw8E0CUrG6qY94rP69UYjAAcTDXxjaYHBuoTUgwnOP
 Mae74QjjxjwyuXvihnUP5ieHOU5d+y9BZE1HIawThnr4FGljNVuNpn1WuHeAt4gltH2G
 9EQ9yi/T0rnv4Cqmahh9ZWHtb5HzDWhRn91ir8JSWn4vMb3+v1AZYMF3cWeO+OLkX2ij
 uqutqObc87+tpQe5Ump052tukoTNKznBSl5mj7+uBbczoFxbD3fC6ZlRcmdGMPdZZDYK nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhb96s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:24:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173EFKwr161524;
        Tue, 3 Aug 2021 14:24:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3a5g9v5u5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0nDmKcp+i71HWigUlpsrcyA+KDPWdCKBM2QjkqtNOEy4cYZ6jcY/s2WYJQUnFdCwfOYQmnYU/78lw4oCw4dhzX1bWuAmNcWBphI5spjqRltkAXEoSgf8gfcLQg96t/thc7w2QjBaxFZFi3sIymW8awUTucbW91dHnT4gtyp5kyYJ1UGrRf0V4xkB8o10PPCRC4mLYlRqCyXkKBdtuVBZgiYeIjSG/s2ZXRba8m1oVcq1bXLBzs+0Sm/p8N2rJXGzVh6qP5HmVr5z33irLJF17v1CDaIQEBg7vlGYN6taq8kXbgjt+pJAhV4PxbeYOZcX1fXqUhDRFcVbwz93FbuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stgz54hxG31raShujhkMMtOJqBA/L9UsVwzlrKd6uo0=;
 b=nNbA25vFXuPWGOxlag03hC8UPC+5PYzwDAaiYfMF/fb6BG4Yv1fKs97MYEQEarWjmBzv2CBmtaj33qJIVBLqsx16bBFwJi2A0W36KjG78VBQARABr4n8tcGTUeWgNBKkVfJl5ayuhy/F38Ax0aiKKxMKAarVSLmWo8ZQN8RtBavO8UuJacSE+AIkfE62Jc74ba3xd8VdQYV8V9OP5m4whwLEwxIWX4sFEHePSu5AjxWziguZaQS8XSyWGOugPdgAAQ2iDv9v46Xiit4BzF0zHw/PMHNeKLAX5DRPLOYXePduOAbnP1J6zy4HY3XmMAOIG3LMnp6DyAGfVBvn/Jbr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stgz54hxG31raShujhkMMtOJqBA/L9UsVwzlrKd6uo0=;
 b=o68+ZpzgwpozFmUZknof+dSj1S8pf75vYS6PhnudFOc4iuk9yCoIoXp0WmNiDXcp2TG7vgPY1gPrNto3VRJyL6GBreumwfEK2VoknSrgym317Fw4CPAeMpfSsyhCngIQyA1oxlWGZ3uEJaET8dDA04PXjqae1jHnjPFN3fmfw+o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 14:24:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:24:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Thomas Huth <thuth@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
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
Thread-Index: AQHXiFazbCL8ap5xPUS5u/husB93Vqth0XgAgAAERgA=
Date:   Tue, 3 Aug 2021 14:24:05 +0000
Message-ID: <73F77F37-DF04-46C3-97C8-2DD7EC043BDF@oracle.com>
References: <20210803105937.52052-1-thuth@redhat.com>
 <20210803140846.GB30327@fieldses.org>
In-Reply-To: <20210803140846.GB30327@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60041475-4c9d-4272-e25f-08d9568a5965
x-ms-traffictypediagnostic: BY5PR10MB4306:
x-microsoft-antispam-prvs: <BY5PR10MB43067AD5995ADDC1E681F56393F09@BY5PR10MB4306.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLS7cPZ3qK/zzS1z4nevMiWMIxhE0JPJSxnPpTENl78Lw0wZ0ujQJe4Z69YVAErJQ50pSm1JfITovnnlN7uLsbnnc7BKj/bzXVH4dNZdvErmTfi+rcChsAYhf+l27HLX0DHi4X83bTIYefbE/jV1RMOwjcpZMaKB2XVB/8jnYcPbgZNT50gtcaKzMqn+Df23fpM4/Tyl0wZLv/B3S6gIZG5b33+YY4Ww7PQAe0xIYCQL0X00PNqYrVaaqlcHIkkiYIzq/MAJURvvkgW0ejusMG4Ll6nzHoHMDPBSQ3tk111CMCztBvjSpIqJMCA1xL14a508sES24W2p5uttdzpgQIhMEEI13kvC0Vlaqk6O/53b+nFi+gC9tqVsepUZlgjXhcwXwNXR6LOGECbP7RaE8TnWSwETNiwAtqKdjGavbMA+LrzY7hhbpFUvVCYjfNd9hiDNeUjxXVezgvhq0ebwy0bxAAql1RV5kq2FTS+c3llsr4oyKAr7j+7rKSPESCtO8VriKBD7WX23yc0AvA4O5EfOblfGfvTo2SZYDimsRGdRlBaLkCFbR13hPZBR115BdWHFTUo8o+RKz4jc69U0HtVVHlP0xq8o1l2Y7KoVZFjV0GHAMQxH6lKyK2fJKd2UyJcGVdUJ3Q57KCvk0PybM/WJ5fy4uG4s1+YBewIw2K4PYdeIdEQbX220EUPoWeuclWgJY9jWDA86B6b73fN0PV4zIspgcASF+tnJ0Elx1VJRE8sLTtuMXPx0zaojJkWGImX24y9ho1BfuSoHeASlH/8qf7ZOp35fyCvVlaLfDm3S6HyenPZRZ3Nuo1vfd2FUCz2HbdDdzjPbiG38NLmErw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(6506007)(8676002)(54906003)(2906002)(36756003)(53546011)(2616005)(86362001)(122000001)(6512007)(186003)(26005)(38100700002)(83380400001)(316002)(38070700005)(8936002)(66446008)(6486002)(66556008)(5660300002)(33656002)(6916009)(91956017)(76116006)(71200400001)(4326008)(966005)(66476007)(66946007)(64756008)(7416002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nNYUqudniXGViQAvctpOT4uRK6v5YvLPb1uu51CwpL9ucxqu6IwHGIDLrctS?=
 =?us-ascii?Q?NR7B1/tROgK7rJdDKthO6DwYiIEhd71daxoFC3bvQ5TfFO0o9jXd+8RysOOv?=
 =?us-ascii?Q?8ZO3wyY0g7zTeCULASYCybUP1pmRHHqyXszrD7sOzhV4Uh1z1ZzzTbM3/jWy?=
 =?us-ascii?Q?ZU65bO9PDiAxbJPLQJNvm1WMheK80rh1Qjzftos7Px64xh9JNbdwe8qM+s0R?=
 =?us-ascii?Q?NTqQZjDzAPS6mMzuQTnzc2SjxKrgmSWK8tQxjjGucYHcxIFE9mfEl3Sbhkd1?=
 =?us-ascii?Q?Nw+HRwwnVsC14Nl2r+mCuqPIPx0GvwV8u0sm+rKDleA7gYPgmvY8kkOK2eFm?=
 =?us-ascii?Q?kVu+cj/hFxf+7ZFM4q7hDwPLxACLnbhvFqyrQ6UEtcLQ+RX9joYDrS0q5Fmu?=
 =?us-ascii?Q?g9AHTBj0Z96DjSdPnBnFR4Oksabw8UxHF3fEMKqHcMom18Fe+RVkIzZU+V1C?=
 =?us-ascii?Q?1SyHM/8E7q5bCCd5bhMIMS3CSfw2TF3h5eWWMuoKCvwVMEAr5QKbCo+3HdQL?=
 =?us-ascii?Q?p+7QVL3OQJERaBACz8ph4eHXORxRs14bvj9dfuPXGFuJVjogVQHwlyXaok6x?=
 =?us-ascii?Q?d6FJYiY+aUDSDts+Xm3ihCDURKUiufHbWvPL8ZrEr3r0WFw1laQMRDwnSlMi?=
 =?us-ascii?Q?SDzMFpG2oLRE/jVlKihFKjIAqpuDs+tPcgc/BNUHrCFI4l1QTZAQYJdbhryC?=
 =?us-ascii?Q?vE0ODyUV46k/HFjwYTlajuFu+1eHE2xsXJMDKdhMnDFzo1WYgxKgD6PXYzEm?=
 =?us-ascii?Q?MAeXJm0oAmICwQ0hwcAVRmwiFQThPWXuvpzNOOubCiYB/ZuizzBc8YoXB2bi?=
 =?us-ascii?Q?Je74t9QSfsYRkS+bHUfARJ6T8+r/l47VFK3io3x4wj/Iki+vTs1K+Qq6i4F5?=
 =?us-ascii?Q?iQaL5JVDwRlhkdKMXo9X255LVcq5G8RAzKjMdxFB/pISJauW7fshdD4ZjCfQ?=
 =?us-ascii?Q?SzBhJNOY6h3CVlc/q1geNv6dEPzNQ0sLFSF48PtFCPQ9C467wMISyNMRtmao?=
 =?us-ascii?Q?6lJ4ClEXtMffr2JV8XjqVp7NpfTL7mlZl+5+teJA6bZ4RSNw3JnfhFzxBzGZ?=
 =?us-ascii?Q?Ed88/Af0VELSr/2h6tGLeqLVpxmzewEQY/VbnfS1VP2PL0cB+h9A3x0VPZvO?=
 =?us-ascii?Q?n59y66djbiaQbNdPiq5B3BR6Qm0rrA2sIsk9zUXxXXPLuCmgILQENo/o6x6w?=
 =?us-ascii?Q?+27B9aFzRdBxXy8CqxLXkwA3zXtmgkHf6E8csju2DxaQJhG6jduVDBhZNy7Z?=
 =?us-ascii?Q?+rGiIAs+YUEgJQi2DENGBADIbJbe/538kqt3LhbvF2aiNLkgdOB/F/IA5DEp?=
 =?us-ascii?Q?n3Wak8j7Sl9YObLKi10izuMM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE0B98FA7588494896FEAC76EEC295DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60041475-4c9d-4272-e25f-08d9568a5965
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 14:24:05.4243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjKBsoROYJBLmMqbWRf3qHrPEB+RZOpZvzFnhtviPV18vg/4b/9v1L+v19UdK6F9mmxDqBI6pdIfMA4zumRRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030095
X-Proofpoint-GUID: V3CHRMlhZFcVoSh9WIYzFp1Rvm4EYh1_
X-Proofpoint-ORIG-GUID: V3CHRMlhZFcVoSh9WIYzFp1Rvm4EYh1_
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your review, Bruce. I'll watch for the additional Ack.

> On Aug 3, 2021, at 10:08 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> Looks good to me.  Could Chuck take it with nfsd stuff if somebody could
> ACK the sysctl part?
>=20
> --b.
>=20
> On Tue, Aug 03, 2021 at 12:59:35PM +0200, Thomas Huth wrote:
>> There is an endianess problem with /proc/sys/fs/nfs/nsm_use_hostnames
>> (which can e.g. be seen on an s390x host) :
>>=20
>> # modprobe lockd nsm_use_hostnames=3D1
>> # cat /proc/sys/fs/nfs/nsm_use_hostnames
>> 16777216
>>=20
>> The nsm_use_hostnames variable is declared as "bool" which is required
>> for the correct type for the module parameter. However, this does not
>> work correctly with the entry in the /proc filesystem since this
>> currently requires "int".
>>=20
>> Jia He already provided patches for this problem a couple of years ago,
>> but apparently they felt through the cracks and never got merged. So
>> here's a rebased version to finally fix this issue.
>>=20
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1764075
>>=20
>> Jia He (2):
>>  sysctl: introduce new proc handler proc_dobool
>>  lockd: change the proc_handler for nsm_use_hostnames
>>=20
>> fs/lockd/svc.c         |  2 +-
>> include/linux/sysctl.h |  2 ++
>> kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 45 insertions(+), 1 deletion(-)
>>=20
>> --=20
>> 2.27.0

--
Chuck Lever



