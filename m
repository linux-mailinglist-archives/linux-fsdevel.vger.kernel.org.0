Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C592C3B77FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhF2SmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 14:42:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57118 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbhF2SmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:42:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TIbSOD026166;
        Tue, 29 Jun 2021 18:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=strpBo4nYW0ai5jNzMxTRp9In0b48BKrcOvfgCvjYtM=;
 b=px7ts1UNnFXv+2/kFoWbwv2FfEKtRCVAcNEYnXXHr9dhElC4KRz+zLA5VmjY7Q0CumkQ
 q7HpIIiq4J+5wRGL9TahNvW0cSKGhYbua49WqfA1EUFykAW3Uf50lLC5Sb7t9670Bxz3
 lvE0MfmDEYr27IjnFaxlTAuafZsniKnlDcwAChC7UpmzR8BsbAXhPvNaFOknj+1nqBSe
 Ks1c5OsDlsgqqhe5LnTzRkmhmIMWhhe0DabHM8p/XRa16HetN9yng+Hxku6dUjxBcn0k
 wWqNhZg/CofT9g14TPj4vfsyeRyLGYqgQOvP/Txfc+hccHClhh8IKb/MjUUrn+mMHsRN Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f1hcmp7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:39:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TIZt0A008278;
        Tue, 29 Jun 2021 18:39:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 39ee0vfe6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv6mPGBjm5lUfouLPLreYajV3aD4g9HIF8q9j3fQCZHaGH46jyNJRyRSpD6LK2OkL94qqx45/zkR0yOHtM+Kd9lBveceKniqZgGLre+J0Y8m2JuyMkqFaQXUnGFItNZeC27aJo7A6yH8IiHF5ZytuBvqJOJn0gA3+E0K3W6dp+M9JGH091TnDsiq0gQlVkTcbv/oDAc7yCzCJYjcNerJQVkh9q+Ia69EEx0MVx3KLkHOLW/74Dcm1mETKQbUJue9HvA0GVnWr34m8ff/Ffzh7HHMgPYb5vOGcUoSgCoGcFE4Sw4lORs4xiOtEZr/ecyRQoLFATQeQeMwic9Rx/x+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=strpBo4nYW0ai5jNzMxTRp9In0b48BKrcOvfgCvjYtM=;
 b=LzQEyljkvzAwYGuUV0BHBzxoRqxmYYEIAqpzg7S3/4WbOdxJGvgCmBmoSLtCYPtLHaFCIn8ZtTXPtd0TpCS8+FxP43MltWLJGCKrz3MOzAzJ4MvUW0lJHeO4owYnslbc9N2PimWPtzLA4dIhks+7Ih40bTLSMSICPUwiqS86WEHUU8hZ/mGmXy1c/SS4FPY8u+OFsjtuOuK90ioszrdKKfJjUvBlah7fLgrAuKLFfLgWYbCEpN04rD9+Mf6XC5voodbyxRVMfaEZ76Y/yM0NrHTjsL6xA7n/mc17PAD67scgzTppPxzbh3SY+XHZL1IfyqM1xGlXeMaoHKrbt8Rkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=strpBo4nYW0ai5jNzMxTRp9In0b48BKrcOvfgCvjYtM=;
 b=n/G5kWGYdiQoQgY/dxQVYvqdIEEnN7VnF0oPV0U0o8Im8Bdj+m3w1QHDoJ0ulMRiAjhYUrbdwck2wwbkfFrCh48f68XMIrSND7HoP2gTy8mU30V/ixhovkAIA2DT9K5SRdXH5pz6+gsvXq1jTDDzbc3l1DyVprfWyXLUbT603to=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2757.namprd10.prod.outlook.com (2603:10b6:a02:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 18:39:46 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:39:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Neil Brown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: automatic freeing of space on ENOSPC
Thread-Topic: automatic freeing of space on ENOSPC
Thread-Index: AQHXbFawsxWIRQcUak231tyZr1/kZKsqJs8AgAAICQCAAAjfgIABGfiAgAAB5wA=
Date:   Tue, 29 Jun 2021 18:39:46 +0000
Message-ID: <20DE3A01-9B1D-4909-B347-65055CE4F86B@oracle.com>
References: <20210628194908.GB6776@fieldses.org>
 <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>
 <20210629011200.GA14733@fieldses.org>
 <162493102550.7211.15170485925982544813@noble.neil.brown.name>
 <20210629183257.GA1926@fieldses.org>
In-Reply-To: <20210629183257.GA1926@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b945deac-ce62-4a02-cded-08d93b2d44f4
x-ms-traffictypediagnostic: BYAPR10MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB275763A8947CA8965990EF6C93029@BYAPR10MB2757.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5A+wFPSWM4YUQopHnm9Z4K8CSYQFJStG5F810NUWHkPsNuAOudMMA9JQZY0wbhaQHgWc2o0QSsaZ7HB4yV9EjWTg2PoKbd/n9o745bnu/8lSp8ShRLYUd5uzZuN8Br8w2lCJMrWWvojgoDIh9AMVWV0vc4LnKBQqYyG232fye1qKf5+x/2/wQMdRYcr+HWonKOZMXmT2adY4dYneyPvY1CTaLwiOCVbKBwHpaIXQC2H38cNkxw1sTboR6VphKK/vpBC7oyW47kK2CSrwj8ErE4RPsfZdtS+dzq5DrfwsPY6OptAcba6LbfONRKQJ1gJKxY2eilCq4FOY6uIC8sxdVa9JcOy4YjVppp6TDleVxkQLCndm5rXYK336Z7q6FZIJ0UYQb4y9yP4zG0eqtQ2+BD4HNzcMZEQSrRCUcUD4vlZUe9DOGsmx3UZEcrmXiR6qjtipeOI5dHk+JJr3RnNTG21ZrFkKqX8w0vzR/KSENoz2boCkTT7LFGeRHeQHmCO0lBbeUzOoLvAqgJ4029PoqJM2ndDPud5J8vpryQ8iaBU5ddn06ZL05/YUPlI2FKIV1uUtbNQCyZYU7A/WJeWxPL1se5Uq6vT9NvbjHrNYAerox06//RS61QgJ1tEe7vrcrAhHken4APHSd3G4Fk2zj+zdqflMNCM4mHM7Om6UplxnKM9Lena3BimTVMQBXGgR8jv8HbIFjQAZxHYBMmeJWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(8676002)(8936002)(71200400001)(478600001)(186003)(4326008)(2616005)(6512007)(38100700002)(6486002)(66446008)(36756003)(33656002)(316002)(64756008)(53546011)(66556008)(86362001)(66946007)(6506007)(5660300002)(2906002)(54906003)(91956017)(6916009)(66476007)(26005)(122000001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m1+e7zyUfVPK6ejUoI6HZ4ulp3Run1laxfRgP31RDB7YSbm8tkqkRoJBgsTV?=
 =?us-ascii?Q?YKL1lSYgAGd0nZROhSE2Zn7MHPILvIZW5L0cPc0u4jf1DTXkrV6c8C/7Eemf?=
 =?us-ascii?Q?eX97ZUeBnKm8EmV+kRhh5100KG0M76RAMcgUKLhXl/mz8PEpDKa6V3cmEbYN?=
 =?us-ascii?Q?5F5TgAizagBH3Ece5ROhvFSM1BlPE2sERwDEmUz0S7Cql49WKNJ21HaypTIE?=
 =?us-ascii?Q?wqdoWLAPjpfzYFMOBFnsztylSOVhC6zV1Hs2k+Q7W23pXyhH4NliQOBaBKXV?=
 =?us-ascii?Q?BXa7bLQ6FQwNExcWoBcyQAdMyEcvucIJvNwuTtmBxmXo0qWLZ2elPKWYkdR7?=
 =?us-ascii?Q?KHGn6usyA1aTUlbOFGes/kiFy1G8wLTPlARpFqFrPlU1yx95Pvt9Dtz/odka?=
 =?us-ascii?Q?g+L1Ihg/iyu5C+Ui01cgghJ9oQRj77wf4et9Hf0696A0IcXQnvKsVvh9WxJL?=
 =?us-ascii?Q?yZH12bHbrO44eSZlnCYhuMCO2hcAVOTv1yVXTF8jBLiivliWMgS+y1jS2TTI?=
 =?us-ascii?Q?0fP6UMQPN8qchp0x1RcwWxJnKWf3uGYRI6ivxIh37XSPjVU0yPYWDBhcPTjl?=
 =?us-ascii?Q?WoQGCdRJL1HkgwUa8CmV1F7gmtOvxl329UHqBZrr7T3am3DkOeZi0bmzig4M?=
 =?us-ascii?Q?XBLl4wU+rrOEZV2KxdFI240Q/vDBJ5rVUoJ10OVkB013a50rTb8O6TXtXrdm?=
 =?us-ascii?Q?wMmREL7c67bP2bvyuRZGhIpC/thMA09zJDC68UTcQdineAhyTEWmDnCor87y?=
 =?us-ascii?Q?cd+JpwccEu3YLBi4uISBrYXBvXnnp9V5Hkn4seHJPTIGTo8SDNLEf4r9RW+B?=
 =?us-ascii?Q?bt6LvMx4y2V1sisaNnzhKfgeCi/dxGp1+0MshAVBFYB9wnW958lflmoTQJEt?=
 =?us-ascii?Q?dIcHGfXEsDccooauKTJcEpbLdMB5BQJxjVWqq9Meuy2Mewtbk3YgKFEc5ftK?=
 =?us-ascii?Q?eLN5c0Fsr2cHOaM1woC29qMSvPQoGVthHyShcQeRehqc26am1kKsEPHqdUCv?=
 =?us-ascii?Q?CXcNkSuePp3i9oosyh91wNCIPxGM/o6kwhXvWv7IpqgbePScdH26+9R7iW5o?=
 =?us-ascii?Q?1TZxs2ZnIxn6jLXrSIGgJuahEHOYWsEqL0JonfSNqMjSGxoaSBJQ2V62pVda?=
 =?us-ascii?Q?NgRH6oA0ku3EoC4NX659oqC3cd0Ezb1SHU71OCLfK3iGDuw1IXb3lyeUDxcb?=
 =?us-ascii?Q?OCQXfUDRJOYqz2hXKwLPaVAEo4FrfoWtx+1HoQXkdvcM+dy5Xc8/BLgRHIPS?=
 =?us-ascii?Q?5YTDHu3pptiKVjihtNZ0rOvHaHZgrEQXiEF0k8S3fzwp9fe+vufl3OvlCz2r?=
 =?us-ascii?Q?AWA7W0+tnVuX8yCNAniOcnMr?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0627FA812C1D748BA77330DDBB5E978@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b945deac-ce62-4a02-cded-08d93b2d44f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 18:39:46.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sriPrr/9G9gxXz7XXwawv/w/toXwDNRdB7Xmx4wU5AsSvoeRe2h4PhwFHbtBYUmJHvhrUpRrZemMprHDdABQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2757
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290118
X-Proofpoint-ORIG-GUID: cEOv-O1TGpzfqGCTzS-MQ38Fz0kWyFz8
X-Proofpoint-GUID: cEOv-O1TGpzfqGCTzS-MQ38Fz0kWyFz8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 29, 2021, at 2:32 PM, bfields@fieldses.org wrote:
>=20
> On Tue, Jun 29, 2021 at 11:43:45AM +1000, NeilBrown wrote:
>> I wonder how important this is.  If an NFS client unlinks a file that it
>> has open, it will be silly_renamed, and if the client then goes silent,
>> it might never be removed.  So we already theoretically have a
>> possibilty of ENOSPC due to silent clients.  Have we heard of this
>> becoming a problem?
>=20
> Oh, that's a good point.  I've seen complaints about sillyrename files,
> but I can't recall ever seen a single complaint about their causing
> ENOSPC.
>=20
>> Is there reason to think that the Courteous server changes will make
>> this problem more likely?=20
>=20
> So I guess the only new cases the courteous server will introduce are
> even less likely (probably just the case where a file is unlinked by a
> client other than the one that has it open).
>=20
> So I think doing nothing for now is an acceptable alternative....

I'm comfortable with that too. We can keep a careful eye on this
as the courteous server moves further along.

--
Chuck Lever



