Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F134A913F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353652AbiBCXk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 18:40:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50084 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbiBCXk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:40:27 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213L3xN7001942;
        Thu, 3 Feb 2022 23:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fiRj/1GHbowC3fONbiZgRD6dMY9RWb/Y8WOzTcbr6Mg=;
 b=Zj+kPJnK2w9v7jCMmuysVT86BpAT4ePetmfgFuakQik463wj7fBsf3xhzk9aVMk5Xjui
 TwZySXfGOU7pPJbRyOegFAfT0pmI1cnDuz7vAa4miQ10vXsuAeaPyWROqeis6025ka58
 TdOMq7d8rVup5d6rVK1oF5iIQd0LgI8Px6bDNFvTGGIQahNewpw100OApDWIRWhCtYf9
 NrvE2Rd7+1cLsnh8EDGOh2FYm9EVaz65Q9/t59Db5O/DDSVbhONPyhd3k2UlcHswZuXx
 CPkX3gc/aVnUjVSzXNOUQNGfJl8F9H62aWpnKfyASl5WLt+3DT9P3i2VDCrFmlNn+WRy lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfs96q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 23:40:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213NUrYQ173674;
        Thu, 3 Feb 2022 23:40:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3dvy1w2t8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 23:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwuJqQr8SD6Z7/WDSiAj10cImzS7VSR9DH9YEoiSHKSjqSRndc7TBgkBCafAwb7m+SWXyJE9Cs5NVHYyf1cKHg3NtmTQZoQxk8qUYznMYoIw7tDdRy4Wza86OEYT/cPDqXE2goRjgclr1KojbU801GAQ827IYuw7+UylCYF7S5EiG+ypgB0Cy7baakTI1WyOwS/fl8UbqhKNEgEo/jVbRPZDy4HuHqVZ3zfl7IJLgI1JfMS2i00HeIQV/6vp1w9wrIh2vcBmwKGOEL1fDGY0eYsjjpFKToQfAEsjpk4g7Xqxj63lYlv9O9mHyD7WTzTlud7tXwGccMIj47gNuaKOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiRj/1GHbowC3fONbiZgRD6dMY9RWb/Y8WOzTcbr6Mg=;
 b=QHVvoUZTtSUzZG/cqbBrpTVNzzRhjpelMi6AzTsTp/6GfakOR3bHMWjhReeiLf5HLaOc//teWzm6An9ALkWwqcV7DXpHpEHKQHgmXhzwI0SynYCE19D5P6VdAwPjjRCWlZFoNeHaacIXfY6onMDoeIgZKztvdqhWqZEm7sJhzCtVYCHGSUjoknPukSoNJpc/oRJSyEDKUorRUqZzG1x94igwJWIOhjahFKQyEd5oZPjCPLILlPfSFTpkEBdfRqMM5oVnFxs5mgmxXdh7znezZtMBXAMlcprISe1zPU3t0C1t+iPJKjwxq17kMr3trx6KL/M/xkH/LofLdvROp/kXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiRj/1GHbowC3fONbiZgRD6dMY9RWb/Y8WOzTcbr6Mg=;
 b=XvN4ktn2nAkfspILBMJyBeRwp6wvggRdTRFTMrl/e4a/fc+oh9Gg6epZg0sN4tYtBKqtTIigbg8/i1nm4aaf8nPLByLoWUFW07gDgu73SnfqyMHWiKoiISfqSeLmhT9UOMian/Ng0DadyhgTteZb54IEZuJvDXkWSYzp7i0MmWc=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN8PR10MB3090.namprd10.prod.outlook.com (2603:10b6:408:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 23:40:21 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 23:40:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHYFH7X1sEKJuZpaUeYDd9pPdXaRKyCQCmAgAAjwYCAACHnAA==
Date:   Thu, 3 Feb 2022 23:40:21 +0000
Message-ID: <36731CD8-E35E-436F-AF1A-9F97C0ADCA57@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
 <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
 <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
In-Reply-To: <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b6537c1-8542-42e9-b7be-08d9e76e8b39
x-ms-traffictypediagnostic: BN8PR10MB3090:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3090453C481B7E48E56F4A2C93289@BN8PR10MB3090.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdwtEm1XGMS9GkQueAk4Ha/wKQYROGSOP8jKOB39SsXHcOi6scEIJzIN1qMWWygOxjpQJH/1CG/ovXaHYPZfafm+StQPOpaIHJrhpZY8q4E2cg3OmlMU2T7KasRqm9nTQVfSnQvL5BuoD3EMMO57VfVt3LpWba1Rsn/I35Ic0tZak3aCSK3I7cydH/9gpsanNkXeFNNX+ZyeAtYdWhjfydWBnq3tpNXSa2ep2vbYJUZ0G+o6bGbyFMzeTLfg3eK9pimVqhPbdsYKan0lDfyuQZpmS/Kq/ABxZxp7xnijI70l6K7uhMBZJh/bt/Tq9Wy2S6LqJy14zEiqGzuIleZsM7/rOdgPbAyUyvn9Xw5BS/1S1rP0Ig2gusL09tcfU4OIbe48F2BnePZLaH3XCnUwZt7b6fKU5u8DrmJeYZid5A4x3+gYUtwJuln8l0l5md0J0/7h5lsWZPHv6pOfHVhJikY63tQy9nX2yFk9IxooGYF62TTlEk/aO8erMRjcR15u/bbvUz7ODgdSz1nFi6yKGvNczaehAwAFYXkPp2eN4hF3rLf9p/dV6mpVJHGRjrXNaI0p/i2mEvMvelmck4sDo8U2FSqhrt6tNgj4/Qh78qPbc9jhxDaEqrp3pPGdWUbRA/+jbKWX/wnnet3w/XsBSGtxP+j7DtU3+w3pd2BiJ+CaoEhYVR/hVKhXXwL0xaye/tZXBUuZz6BKkFqrOrWQkN/rTYA5b80ekVWLgc403d0XmhVwEEHeYHO7DS1Z3ZcH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66946007)(38070700005)(71200400001)(508600001)(86362001)(33656002)(66446008)(38100700002)(66556008)(122000001)(66476007)(6862004)(8676002)(76116006)(8936002)(64756008)(4326008)(6512007)(53546011)(5660300002)(36756003)(316002)(6636002)(54906003)(186003)(37006003)(6486002)(2616005)(2906002)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5KLZunAscWUsHhTBeL0WKbpK41KnS1wEZCQluoCIKOPYRkltAVACWZScHfuB?=
 =?us-ascii?Q?6eOVNaH3aHp4yF4BeHEfIggBj+vqUYx1/TPxHrH6FC2DyQgoWW1C/DRa4G+D?=
 =?us-ascii?Q?aES/jvnHXOtKgI2Pmfqiww/t1tYaNvLifbvi/wUKYpFIFlD8rxec3k45aFK2?=
 =?us-ascii?Q?wZpTFzCY7/k6tqbR2U9EvU9KjZV5KYO79Ol3WcCRxUoJKOWrPrrerw8ZL4i2?=
 =?us-ascii?Q?x5Qq5B2MJPOd7SnjKGkIkHj0mYcjganZjDZm6DnBD4ICmyyAuLTPN+Y2Zugo?=
 =?us-ascii?Q?2hu2Nfrwl9fsv9P7qH7EnyHsXZzsgeuvskgTXtK7fOjlHgrYQkccZ+gq5pOn?=
 =?us-ascii?Q?+2jGRtM1D0dWgUMDfXVVVhZijkWYu10I/DyyIH/uVytJ0KJMKumlq4Fy9rA1?=
 =?us-ascii?Q?0G1WIt+qbtvsD4WBH8RDZm9/vE8zLHro1N9k2gC12NsRrdTd8E+RlYxi/fyW?=
 =?us-ascii?Q?cWx4sDW+ivcRk4ZyXPTcE3hgNzH/fhb7xXGXWXc9YZJ+VA/BVD6Iqf2Sy6TM?=
 =?us-ascii?Q?MAefkG7KmTAPI9EFPnqgeRb7ZYFPG5KkxibiNsFiXa7Lfj3txxiM3gR42wtb?=
 =?us-ascii?Q?JVRAEYuzRJSTl4luNFqXb2Mcbd/PLu4vywcF44dAdQbpKyKV/1jozG6OgxMr?=
 =?us-ascii?Q?4RVT1cDrmJMdLlxBZpXQ0CTvfXaTqKTn4eU9AI4lfosl/8l7IFC5f/OnSAgc?=
 =?us-ascii?Q?eDGHOBQkd9KGi3FS07b3+E8NobcrdlB4nzoNEL+jgRiLiZITyuk4E5CBf9rt?=
 =?us-ascii?Q?XGNoPfceHlcXECpn105o0ViW91IyeuyN4B+vuNVvTfQKXQqNe9S1RRh1L23t?=
 =?us-ascii?Q?hizhXPkCZ2m4KE7ParA4pQTmlkpfv7b7Y8tGx04w67Lic9W3ASMvVuv/ERkP?=
 =?us-ascii?Q?uib3xU7alz1D5rHR1ps7gCXAWiRJRf88fvm8O6dLk1xMCqp10YF78pqd+Ye3?=
 =?us-ascii?Q?GEKW7Jll3Gaw/wXwB/iEl6qEYissqTT3TiiY7vXofgmbLZqTxG04DUv7sECZ?=
 =?us-ascii?Q?Ze17jsJIrxn+Hg4NOMA3IEt1F9YiEnXri1yH6J1cLLu6iFsla8G4whapYA8d?=
 =?us-ascii?Q?CBPqW7yBLMWgGdQYIMmh0RdnOxFu9oG+IGUND3D9/YyPznkBfZ50bIq5/2Fm?=
 =?us-ascii?Q?CQe/HWhWL32w20o9qOGogxsD3j74ooudkTOoFY8Vu1vHG8q+QD7FZvwcINBb?=
 =?us-ascii?Q?zzbag2W9X+/4qqoAc5MEYIq0pW+r9QW3g+lE5WTwJr+xeXBWs316TZKr1+rf?=
 =?us-ascii?Q?VdtvMmOnKy0sg1jqlHkkkjdIrQamNE2oiqeNyaBuBQ0hhOc+95lfDzUH20hC?=
 =?us-ascii?Q?8BPEEDTNKTn7juLfPfybDNDdL7+oNdldx3QmxD4j+3k/LyBTE5cMJ1Zn6IQ7?=
 =?us-ascii?Q?AEToJ5Z7mAlbsjDC48zf0cHjwce9anbZMcCXgvAi+S6XnXV8FCZrrLLGe5JD?=
 =?us-ascii?Q?D22B42a3cooSGw5zdYCQ/1x+7jamdGeILqqTYkniO9hEg1VlprUl7ui9wYP5?=
 =?us-ascii?Q?f/8f2WjnFMWS04Ntsev5IDUKEZ1GWJlSd6PlVSlxcBvJbeOeWpbapInu3+qb?=
 =?us-ascii?Q?PUGZnkcsobST26rjAftGgDpOiJe8312CGdXyj1MCy/IK427AcpruspM1uGJE?=
 =?us-ascii?Q?wV7Eohujdq+le5zvsb5rXsA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDF0EE59A0E8C9478CE5C76430B8F2FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6537c1-8542-42e9-b7be-08d9e76e8b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 23:40:21.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxD263Lsk9Mt3CZTeb1AscvnfBqyqGBr0PjWNuRzyoR8zH+j5smJKB3+300gXcSnFqFY8G6eivMDUUvbWI9ugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3090
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030141
X-Proofpoint-ORIG-GUID: IVxKdCkf7GGvSP47XsjQH3dAIKYBCiDO
X-Proofpoint-GUID: IVxKdCkf7GGvSP47XsjQH3dAIKYBCiDO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 3, 2022, at 4:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 2/3/22 11:31 AM, Chuck Lever III wrote:
>>=20
>>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently an NFSv4 client must maintain its lease by using the at least
>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), o=
r
>>> a singleton SEQUENCE (4.1) at least once during each lease period. If t=
he
>>> client fails to renew the lease, for any reason, the Linux server expun=
ges
>>> the state tokens immediately upon detection of the "failure to renew th=
e
>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client sho=
uld
>>> reconnect and attempt to use the (now) expired state.
>>>=20
>>> The default lease period for the Linux server is 90 seconds.  The typic=
al
>>> client cuts that in half and will issue a lease renewing operation ever=
y
>>> 45 seconds. The 90 second lease period is very short considering the
>>> potential for moderately long term network partitions.  A network parti=
tion
>>> refers to any loss of network connectivity between the NFS client and t=
he
>>> NFS server, regardless of its root cause.  This includes NIC failures, =
NIC
>>> driver bugs, network misconfigurations & administrative errors, routers=
 &
>>> switches crashing and/or having software updates applied, even down to
>>> cables being physically pulled.  In most cases, these network failures =
are
>>> transient, although the duration is unknown.
>>>=20
>>> A server which does not immediately expunge the state on lease expirati=
on
>>> is known as a Courteous Server.  A Courteous Server continues to recogn=
ize
>>> previously generated state tokens as valid until conflict arises betwee=
n
>>> the expired state and the requests from another client, or the server
>>> reboots.
>>>=20
>>> The initial implementation of the Courteous Server will do the followin=
g:
>>>=20
>>> . When the laundromat thread detects an expired client and if that clie=
nt
>>> still has established state on the Linux server and there is no waiters
>>> for the client's locks then deletes the client persistent record and ma=
rks
>>> the client as COURTESY_CLIENT and skips destroying the client and all o=
f
>>> state, otherwise destroys the client as usual.
>>>=20
>>> . Client persistent record is added to the client database when the
>>> courtesy client reconnects and transits to normal client.
>>>=20
>>> . Lock/delegation/share reversation conflict with courtesy client is
>>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>> effectively disable it, then allow the current request to proceed
>>> immediately.
>>>=20
>>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
>>> reconnect to reuse itsstate. It is expired by the laundromat asynchrono=
usly
>>> in the background.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++++=
++-----
>>> fs/nfsd/state.h     |   5 +
>>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 1956d377d1a6..b302d857e196 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_session=
id *sessionid, struct net *net)
>>>=20
>>> static struct nfsd4_session *
>>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net =
*net,
>>> -		__be32 *ret)
>>> +		__be32 *ret, bool *courtesy_clnt)
>> IMO the new @courtesy_clnt parameter isn't necessary.
>> Just create a new cl_flag:
>>=20
>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>=20
>> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>>=20
>> or REHYDRATE_COURTESY some such.
>>=20
>> Set that flag and check it once it is safe to call
>> nfsd4_client_record_create().
>=20
> We need the 'courtesy_clnt' parameter so caller can specify
> whether the courtesy client should be promoted or not.

I understand what the flag is used for in the patch, but I
prefer to see this implemented without changing the synopsis
of all those functions. Especially adding an output parameter
like this is usually frowned upon.

The struct nfs_client can carry this flag, if not in cl_flags,
then perhaps in another field. That struct is visible in every
one of the callers.


--
Chuck Lever



