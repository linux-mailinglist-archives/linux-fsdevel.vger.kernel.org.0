Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F114866AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbiAFP1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 10:27:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60844 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240450AbiAFP1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:27:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206DfoSC022924;
        Thu, 6 Jan 2022 15:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eYtXWDs9D18NiqG+RjKwcGTZpHKU4gvIXwRy5EpG5qo=;
 b=OFicK6oEjrMvVDTDwwRhrMiaqm6zf64jltVdFRHfxq3665EZE/InUFwgxjj/kTMq1Obb
 iFlaQyrfgvLM5SM5ORvYAR1Pv7hjIUsiiGzFc5EcqZy4965DiVtXMmUMNvfkTPkWHav5
 zJKIW9HSD+TZQ5tirnWi5z2Cs5GAICBR1Pv7veExnOU13RGrGjKbjSTkVZ7B5IPMio7v
 IfpwqVnLH+cgB32ulSK8Wrg603l6TeBC9REUQmXncN216psZ0VCGpA6dCbtdx/lOC+TJ
 jojhGleEumq3ll0zk2sz8TfQtC3+gxQ/3oGcioMqPraCS9sxnh1Clgvm2RbD8/6hETk7 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpehwpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 15:27:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206FFr2u085212;
        Thu, 6 Jan 2022 15:27:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 3ddmqd185q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 15:27:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbkZSXmm4ROE0KFGy9/YX99OZbCBdFiYkxcTqd1LSvW+t4xlasKr3O8gZFLG+Cx9MZWtR+/HyVWZiEoXqLEkm5kLFMH523Wa7ZhmGCc49wQMdCwe9oYnzcRQlsOxng3uyh2RMh9CCq73uSAKb/4p9+aU5OY2iFQRljsa2wo66bReF/pNpn5vkOKFyh0V98Vqyc7sxki/5l54XVJN9gvOmI5weE3SbLLjQFSUYZLuw4hWK3tnV0qZXl641WfbOG3drgPs1R0ocTsOcirl9EMfjxCbduyFxUSdiSv+ySefsRCadofO9ymoBvCi5T6zKtR7yi3m4mBTQgAitQbLMF8iOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYtXWDs9D18NiqG+RjKwcGTZpHKU4gvIXwRy5EpG5qo=;
 b=VAS76+w6b2tSoU4vdgEh5zDi2mWnY98cW1m/7ZDXtYwMmkTKTeECObFTeHF5lZ6/a8I45q6mDYkS7dTjJ4ZMiXMW0ueYxICPJPXUDof+xNlZxEvG03bA2mhkvgJiavQe4zGmeE03NcHnDFuRSzt86X19b/rjI6ySkOoS9Gbkhx8/fpfYQBRtyth2W25A700tXs3jYTG+V1gkSM9k7n9t/TD/HK5VpqpbxTS5pu3UKE1I7VrmJfsle7NtSFfM3d00HcnI6I7qF35jAvvE9weOfXT3s9Xdvs3zUPl2qqUCYPjLtoB/59fVglf/mnqda++Uey9zUUJ2CrWVOQz1uCv61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYtXWDs9D18NiqG+RjKwcGTZpHKU4gvIXwRy5EpG5qo=;
 b=svo+R7LT5XwwP3xyTMYA6mV+MoqTO7ckqxVee9uaH927jvm1x1wy8j8C+QYI0HL4RMH/QUXwW4rbrAHjhXuNCPL/GVlHm8MTm+ZH3j9wfzv385m2FzbPHEcj+weyxEMxPxvW20t9eeMHLNjUfrPdYCyQLfIXvmqqpM1jjSCtGH8=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3831.namprd10.prod.outlook.com (2603:10b6:610:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 15:27:33 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 15:27:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: remove bfields
Thread-Topic: [PATCH] MAINTAINERS: remove bfields
Thread-Index: AQHYApp3nWiApkQ/b0avZObPv/hGl6xWHqMA
Date:   Thu, 6 Jan 2022 15:27:33 +0000
Message-ID: <1738A497-3FF1-4FC8-9AF7-F8CBDDF9E52F@oracle.com>
References: <20220106011213.GB30947@fieldses.org>
In-Reply-To: <20220106011213.GB30947@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba3956a0-46bb-409b-12a9-08d9d1290f96
x-ms-traffictypediagnostic: CH2PR10MB3831:EE_
x-microsoft-antispam-prvs: <CH2PR10MB383160CC6E4B0DCF8914D147934C9@CH2PR10MB3831.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CxrV5GHtt060ckDiWik5ujJGgn2jBqjVec4HD3Z2CatxFWDtvO7O0284mUdBv4UhvLpOmM8F/4i3NFg0BZh1EFZyzZFSbpYJDXb9QoDgIm5N1rJLNLCyJTjnA+h2B9lIs0pqw66szaR37Y/D/SvkDxKrbBs1W6XuVpc37OHeEmNxtEHdjfLZ5iNdBXXgOY16e9ir2yxaxYj/hITTImxcANgMBD3jiv4OkceairquxBzeLXobZ6kMFJI8X1sYH02dbJCH6qhUL+0aYE1S4WyRRGepurQL7b6RBKoknQW7dSKqBIpGH8I85Uvqv2mM9xQlSvbTWWEI+ngqaosLo/wLm7Z+N0zaDLi/bJ/iu8X7P16qD0HkcFZKu/QIoWJfoEKqt64tytyF5A3KBcr86z7rMephwDozKisumJFpye+UixBDwiX/+hZQpZTLLiKkkg8AKs+9DQiyi+vb2N1Yre/fMkrVGPurJ2Pl638yB1Gjw4eVzXOM3u73oCAAzzzzBq2iNM0rhF74e/JgAhiF6dFtqiF5cJ0Wvl84aIwQVSPaixGfu/dBMaYMU0PWIlIpJo9MXGa/rgiBDt+ai5LpoLiFLZa7TxHPd7cnOuyGQezDHiXKxW9xBzj3koo/SftX+ieAgFRr1idTLKgcMmf/m/Az0VcVHFwI+aZCx/j3u4EMSbrG7zWI8s8Le9yTmyZ571WrZbCSVet1AAwucmYrgJwGerGkSa6DfifpXvxiBU1fgVSwz8tx/KAlnUSlI4tqzakpIAP+GWf4TzrzLkm300ZSlywtUcsHqF82acH3RtK7khwU6BCdKthHvx55F8gW6Qg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(8936002)(71200400001)(83380400001)(6916009)(54906003)(8676002)(36756003)(122000001)(38070700005)(2906002)(966005)(186003)(5660300002)(316002)(508600001)(86362001)(66476007)(64756008)(6512007)(66556008)(66446008)(76116006)(53546011)(6506007)(4326008)(38100700002)(66946007)(2616005)(26005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wtdC1sIpRaO9pUrt1atjV2TdoWwlZwKOZbiHEnowQoLppPBPt/kJi4Bhaid?=
 =?us-ascii?Q?M3ZeniJeYRPyvQlXcuvKKYpF4RtLKq7MLyoaMEQxPdlV47kfJbL6zovtqwzr?=
 =?us-ascii?Q?czXlG1ZcqqnOo3MaQ6iooEsYmSKmz2R7IooGmH8kSJmn69atjl3dCD+Wo0MS?=
 =?us-ascii?Q?yoHMpgUgxkVG9Ri6wLMubynlRmhudDdpbQ56VIl10KVgC+vHaDCGUhoMCDm0?=
 =?us-ascii?Q?iTxekFmjUb5+iyK/wpb5SX//rFF4YZ1bLc83a7m2aKwepIMIPuWnA+zYQrzy?=
 =?us-ascii?Q?SBRb3zNai6ZFCLQLhNRl4jzIYn2QJKgkmm4kk0ZfYHGQ58F55bYM4ZYzgxHS?=
 =?us-ascii?Q?Ymjo1eHu1mHYkJNxkrRt4TgPzuzSN8ezgce3XPaN2FdrqGk6oNZEEbBULsgV?=
 =?us-ascii?Q?F8uP1sgiIbEvvKkBH0VHsmyxpUYcyJWxJOeTObLc9cgY5iicQtfKd3CI/gxC?=
 =?us-ascii?Q?Seb16dkb7SAccD2eLjJdlKBm8QkuSLKVxGvc5NHzGpnOlo7yf62SJNcQiF2L?=
 =?us-ascii?Q?52bVOw6VSmx4PKm5IbyKGHo4liLvjJKHC1/m7eJK/pRLrJSE1hN3dpUo0WOL?=
 =?us-ascii?Q?uZJF/el14ane2flGUIukhYLixfdiu2VRk5lnGaV06hlZBrTMUhGfayaRnCS0?=
 =?us-ascii?Q?xRgdOvcOl7SlNvP/oTnF0yip1q0MENzo3xAE33YoX5BYsUG1OQ09w8Sqxkmf?=
 =?us-ascii?Q?TOccJrZUuZmFYdvbmcP7w9JdQZBzDYvIpDwTPw86NzQBCOKNPv3HIMaOMXVo?=
 =?us-ascii?Q?V9f0Lv6iC8ge3QefSyJviyfvJ9rUw0W5HO53SeDe/hDVAMAulDa2xRSikRUm?=
 =?us-ascii?Q?u7xsf2QZtVt3KCVtQ5t7n+dCQevtXLN7r7ys1xUfDwhEcuza/iYmW0GRuePZ?=
 =?us-ascii?Q?Ffu2aHP9e2HqN3lVus4/eo7E1bekeknhXK+viNE9hW5ku7Xpf5fJI6K4swjV?=
 =?us-ascii?Q?mZGfL1SJHQv9OwL5HGyU69jvErZ5WQGNPu8xafoDiTm5oZ4dkP7qEQ4B/IZm?=
 =?us-ascii?Q?kuxQB2prf+3VHMeyqWlurixPokMQzzRoDcTK3MlBTL4udrnoEb7fsD+3Kg0P?=
 =?us-ascii?Q?w0hPR28p0TqcpFUd/gL197V07703+zS4Udzri61S4YverWLNOde84ipi/kZu?=
 =?us-ascii?Q?17h3Wjr+FjmoHrR+V3rUi1UDNKJoySACQ/ofBygqsYMrq85ssJudNf3fSziq?=
 =?us-ascii?Q?MoKhXStPB61683b6YxHFK0yAwWrjIF5g+uZcEe/vWIjwrr8lUAUfw94vX7wY?=
 =?us-ascii?Q?S7enosnYT5L/GY/VAnxr0Tm+CdZ3toHKmOH2KV1a9vTHv+Gp3+VEIbJEUaS9?=
 =?us-ascii?Q?9W+0DMGw0135hLHfE1Tqic891ANvOExakAEg8oAd5CFlL8jB5k8HK147jdQi?=
 =?us-ascii?Q?EZt/AmXEsXEz1XZHHGGCWKc+NJgzqUbQUfyIEW2tby71do2zLFLsfCyn5px/?=
 =?us-ascii?Q?FHYpsMDqyxmK0l1dB9ncTCEj4bbHhlT/UB9rmc0hpFciT4Xn2FnB+1+FmT53?=
 =?us-ascii?Q?RgNQ2CcdFi4Sm9oJl9TOZG6zUK/d3QKRrgkwIdrPTYM6qwka9PI0NoqhS32Q?=
 =?us-ascii?Q?917O6ALLPT4UTQFHb3vPzwO0s9KK3rzE8oslW1zvxlPs9xLeLrg7bCNo188U?=
 =?us-ascii?Q?/wVc79IEDEjqK2D4jvC8mMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1604B50C86A4F344B71C5229D4D662F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3956a0-46bb-409b-12a9-08d9d1290f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 15:27:33.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nO7G0hH8vCHenwSQMOe6kDVkwkCKcqWP3wX4He9DBLmE6v70jz6WceIReytvDygNqhp/Pl48tvHH6NyRpqRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3831
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060107
X-Proofpoint-ORIG-GUID: iwIfsTn4dkVc6V5oj-XkwBnQI1Fovbeu
X-Proofpoint-GUID: iwIfsTn4dkVc6V5oj-XkwBnQI1Fovbeu
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jan 5, 2022, at 8:12 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> I'm cutting back on my responsibilities.  The NFS server and file
> locking code are in good hands.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> MAINTAINERS | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> I'm leaving Red Hat at the end of the month, and expecting to cut back
> on upstream efforts as well.
>=20
> I don't expect to disappear completely, though, and will still be
> reachable at bfields@fieldses.org.
>=20
> Thanks to everyone for an interesting twenty years!

Applied for v5.17.

Thank you for your time, energy, and good humor! I hope to
continue working with you as much as you will tolerate as we
transition to what comes next.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..8ee4e623b6f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7334,7 +7334,6 @@ F:	include/uapi/scsi/fc/
>=20
> FILE LOCKING (flock() and fcntl()/lockf())
> M:	Jeff Layton <jlayton@kernel.org>
> -M:	"J. Bruce Fields" <bfields@fieldses.org>
> L:	linux-fsdevel@vger.kernel.org
> S:	Maintained
> F:	fs/fcntl.c
> @@ -10330,12 +10329,11 @@ S:	Odd Fixes
> W:	http://kernelnewbies.org/KernelJanitors
>=20
> KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
> -M:	"J. Bruce Fields" <bfields@fieldses.org>
> M:	Chuck Lever <chuck.lever@oracle.com>
> L:	linux-nfs@vger.kernel.org
> S:	Supported
> W:	http://nfs.sourceforge.net/
> -T:	git git://linux-nfs.org/~bfields/linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> F:	fs/lockd/
> F:	fs/nfs_common/
> F:	fs/nfsd/
> --=20
> 2.33.1
>=20

--
Chuck Lever



