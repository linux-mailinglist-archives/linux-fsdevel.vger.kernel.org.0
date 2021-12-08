Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26746D79E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhLHQC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:02:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64170 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236469AbhLHQC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:02:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9ZRE007074;
        Wed, 8 Dec 2021 15:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9qlpPsQVShv7BZMOHdqC7QknAuYvFYGu9iChCHeQdqQ=;
 b=SL9NDZL1pevSlB5J3WEXkWTwAbyV7ubYX/hN1wIYpqXuhh+GVtyXhBjT5cKxpuX3DPHB
 5Ye7e+q/npnsJvsxNscorF3u7MhnaAH9R2CAKTRSRcnZpkrwCmMJNr+m8+a2PVAai6vi
 Zf5no2JKtwveNwIgd96F5Q9rRwV2so+9QVQuOPnu8q+UH9pQPklLG8V9bmBadw7edX28
 Alv6Wj5WDY0VdwIuPJ8Y3DdsWTct4wDFqWjYeOUg+ZVdnbwp4WNm10EK27raZM2h5YpH
 H8w3OidDBBnGpiBw+LlbUFfwW8YLumThi9SwTMHAhBZY3+ArTC+us4ra+OE0UNxxKWai ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1h07n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:58:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Fu98w053397;
        Wed, 8 Dec 2021 15:58:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3cr056h64p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwPyk71j9aZqte7QeMX/zMe5Qn4i/EzsnOQ+Bia+IPvuJ/f2FLSovS8GTc4e3fjqvxGngfZBELb8UidYMrV82dgnsYQRl2yz+NmTPM3e12yFpPVHRsXozlibAcBs53rqbPLxQ7tC6vaOzy+KV/kgSifJz3G6QIzny/M6HCcbhO7v8ZPhhu9khGTEOTv5dAMiX7pjtr19odE5zGRlBTiCMA6NXXE+pfS6qAbFfvqlBycOflBTbX/aFX54tubf0a5X4I/zPRhIhDR0povaAD3DrjDRUhN7JDDJO0Bsw2PxVDzlEbKQsUofBhPvYvPu7GkXRIjPLRmo0XvVCDm5DwLs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qlpPsQVShv7BZMOHdqC7QknAuYvFYGu9iChCHeQdqQ=;
 b=gZ0Le0GR8svCbL8EXeM09cqidNNr46pfiNX+nU41+viIqsrxeZR9HdI7jDwKzQd4Y7o67/10qwi+qoinRKppn1wW8DS00dnW0Z9xwnElmaf6+xZDBHoYBkHs7OvGK286jBWj2yuwrLBbJ3kss0+k3VXZuHDPl1eS0PE76NLDLZy+sIH1EG91P8QtwsleoVWvKb04J45t2HvwLJvAe4v9I0dt1ca8KBfp5rlIyJim0Hl5x27Z/ZA86P6BltVdrmo1hsrx/dCM3sSaJYgOp+931FJIdPWwT9rcWtzjrNrIciG65EXy1RUvvuz+/i+f6bRZK97ZuzI69Cm+Cj3yAOOXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qlpPsQVShv7BZMOHdqC7QknAuYvFYGu9iChCHeQdqQ=;
 b=Qq6fOBcqR8jS0QAyhOm0WcMHULTC73lTBKOhzqAjr2+gfqhlMofjlByGRjD5/CWcGlizjfKSjcL/lL3gThCZg15p81OcAHhOMvWrL2X5KUsK4gBUJsC6sJ4MDznlwyXvZW97MV6++Tx2/IhrBf4hlk0Mx6QwUXguA6pTZJ2ULo4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 15:58:51 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 15:58:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>,
        Calum Mackay <calum.mackay@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssTAZRABZ1HqkCYuoltcOnBFawl4NyAgALhbICAAAEdAA==
Date:   Wed, 8 Dec 2021 15:58:50 +0000
Message-ID: <6E81B5EC-9449-4337-9FEB-66DEE08809D1@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
In-Reply-To: <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8624ea4-8181-444c-8ae0-08d9ba63a0dc
x-ms-traffictypediagnostic: CH2PR10MB4166:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4166A2FF4EE6A72CFE986FB3936F9@CH2PR10MB4166.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIYPyumvzeRA6PkYCJ3Whnbwme90MWxMxWr9O2sSH6k5q7FQqGVbnEXWhCu1W1OoB0pTOsgxrJH+ekcEaAuvtadGFh0Cku2vhm/evc9mQ/son2bq747lSIDkiCQD9bHRyJguZJqkqVeM0kSQb8Zk0YE0vHfgLt2vjrlBiH2WlbYDUSoCpbAwj04aRYWZarLjPCmipW0IZUTDA1xuA6O6iJKKBgtJtJybniJULRGrl0U4QUWmMtL8mbsVQ7HxDY/NuajAalUYsDZEXwoz2xOOvJz8rg1JO6cbKYcTnw43A4KH4oMjDDdT3B3twmDn/3mIPZn0wkmqoL8XvFPrYEY9hT2AjhaUJdoR03DyYrP7gOrEKaHLOKCjMSgxG0R2Jkx+ka77ElNyef3qZCyamI7bZ+OlRyOc0zsviVFcb727ufM4oM7U+HvJRC+gs/FTe92HbzGhs4GkKxZR3LqV513mR/vbdZTn4OKodELXzpG+nIlEk+Td8KTD06R57pJgSN6eX5VMwx/Z34HzGyam0eaCjLE5y0DOk0WcQC4hVaqUHXvDO/qqRJIMkvFaMnKt0pCo8JIJLGEr3YcZkVGlm90iq+d+lH+6EdgcGNnOcj71AUAmrPtEJ0pfPFte+ujakKrH5RTVzDh/LXGSvFCDBRDOcnl/nJWh03FIM2h1pp77yfhwNORLykRdSFxdLeLifdyQftghY8zGTMHE9RLVicFlE4zNpbG9FtBegHLt/D+hFbhOngYfFNjgr5wTJitAKm+d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(2906002)(86362001)(8936002)(4326008)(33656002)(8676002)(508600001)(110136005)(36756003)(54906003)(316002)(2616005)(19627235002)(38100700002)(122000001)(83380400001)(53546011)(38070700005)(186003)(64756008)(66446008)(26005)(66556008)(66476007)(5660300002)(6512007)(76116006)(6486002)(66946007)(6636002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oHL0qENpqw8Sb9nV6epd9QaNU52SlPVDV6q5tkx67F6QRS5t4Umr4HhUAKNv?=
 =?us-ascii?Q?jYufIFkawSsIjZ5vCQxx38wOgQuk0Am0h0pjFGNyev4CXQwNgvmc5P/bDEft?=
 =?us-ascii?Q?uY+A1GURJXh1ke7nWF9yDFZV2fby2EISfNSNfztbahQfKBq8ND35kB2VXfQi?=
 =?us-ascii?Q?XCq5+d0DgfoWZedBFBAjrDGYNj+DiO21ksHV/3ec+dftGfbPOHyVwv69TPhp?=
 =?us-ascii?Q?H0drs99xRTQWsiclObKfnA68DZ+34pB/mQxdjv8jSE3e7QT5MSsBtdtzvdLB?=
 =?us-ascii?Q?jgNFDgn0HdKOSqRdTjTTILFqtFORWypz1mTq5hvQa8SoSjfEolhwSj8S9GQ+?=
 =?us-ascii?Q?3+Ekl/gQD85hR+Buj1ukyopktBLZSbuZ6ocRGLL5bBvBkHAvmVY8U2QkI9dM?=
 =?us-ascii?Q?hvt6EUOzSRjc049aS7qRX/IEy1xZ1Sy1pEmvxmqKwKMxO/412spBbBNrmZii?=
 =?us-ascii?Q?67Kw00hNSBJDGwwocnsKai5J/WEvxSxbTji9v91uXJj/ZovPHQNGrZJMat1Q?=
 =?us-ascii?Q?hp/+PydnhAZ9obTm/JeljDtV8G0Kc16uQMb1gPqcbVwK7Vc/YBY4dXqozh1r?=
 =?us-ascii?Q?3VslgUbidrkrVxcMK5RpSXsllVguoLSRWoKLO68BZK0ti5+AC+kYqtRP9rbU?=
 =?us-ascii?Q?0w4PlxM2I2M8TYkCCb8OhAICcXuvV5q24krXF1+GgiZiFL7kKhVYAylPAO3z?=
 =?us-ascii?Q?3GBKBomf6FtInVk7lsdaNTsNykKDcmwkWj0Sjr7iWkd3VTA52vcvcf5acE7L?=
 =?us-ascii?Q?NTiLC3M2ELovOTyvJMMMqFdesfGmqb4BS/WFpbztr9rc9qTlvPpF4HlGeK4l?=
 =?us-ascii?Q?VOBEM20ewHoKhzi/hbj+0myy4cHQ0p9Uiptf+lAa+qAAIILmp1GNJYm/RcWw?=
 =?us-ascii?Q?4jdPEBD5QwsyBYm57HHk165ev5hFQSwLwW+o+/38vLs4DJUNk1dsZkFAEA04?=
 =?us-ascii?Q?Rq4lZ03zbwxDHhPwd1MWPfYKw38kVaF/XKIIZkmyV0xkL9R8Mh5wRszpT+R+?=
 =?us-ascii?Q?OyP3ypOfbbTdoMhthIWbzdhUcydbI8sH8tjvJwNvEn94Yyu5Y1/03NNr0AJu?=
 =?us-ascii?Q?gcR0tQvi2+g6eUTTxMJH0sgtn8KLInMCAHuZ870RFRKRmJx9Z1KyaQ14iNjn?=
 =?us-ascii?Q?j6KP8x0EIxbtPuUfqSjUv4K4wdO06ShB6uYbLLpIEvzcnjge0xBlVCCFI8zd?=
 =?us-ascii?Q?vMPMWvcSoQsfjXCUyZXNKcL45MJf+EBgjPVnF/CWQDEpUzfMTSxclj1NiJkj?=
 =?us-ascii?Q?+W/g6N60Bk3aFfw4os+jCAyeEFoiqDFBxoJ5Rv/0vmJfKuAeivtOU3WK+WD7?=
 =?us-ascii?Q?2/8GKGH/+1/Byvjrcby6qJcldnMT65MJYfdkWPI70LioV8xsR05iBQcxTXFP?=
 =?us-ascii?Q?O1hAax8haYXyfkNcm4HuBe28zJThLNh1kW3oXCD77nP1AbHQvVZ8rij1EZcm?=
 =?us-ascii?Q?3rPwO+J1enWG0PSHkX4JOnL9opUudWrVox2haQEu6Q4zYW0ZXrh8R+PT0aNY?=
 =?us-ascii?Q?621oPSzRi3LJwLodtBo61ZeVcO0+ujS3tEW5sK065pjpMZx5kKWI1P4J1tAf?=
 =?us-ascii?Q?qT5N31iLQrlgcje8vtChwyh8VZQXGa8orhPxrnYZqFN4HIsSJ7cA/7OIAq6g?=
 =?us-ascii?Q?7C+X+1G++MXeQIuMi/i6Z5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1DD52A656E47D4F907E1671A247B496@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8624ea4-8181-444c-8ae0-08d9ba63a0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 15:58:51.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdDrVQeTfH+pem+pjT4HtUtWQym1fkB7wfq7NMh3rar02u1g/+SdqA/kx6GJvlzO4XY3DrRvpq0s+kIDf4y2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080096
X-Proofpoint-GUID: BMsJzY2OW4wkiPolk75l7zwV2q3FcvEH
X-Proofpoint-ORIG-GUID: BMsJzY2OW4wkiPolk75l7zwV2q3FcvEH
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 8, 2021, at 10:54 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 12/6/21 11:55 AM, Chuck Lever III wrote:
>=20
>>=20
>>> +
>>> +/*
>>> + * Function to check if the nfserr_share_denied error for 'fp' resulte=
d
>>> + * from conflict with courtesy clients then release their state to res=
olve
>>> + * the conflict.
>>> + *
>>> + * Function returns:
>>> + *	 0 -  no conflict with courtesy clients
>>> + *	>0 -  conflict with courtesy clients resolved, try access/deny chec=
k again
>>> + *	-1 -  conflict with courtesy clients being resolved in background
>>> + *            return nfserr_jukebox to NFS client
>>> + */
>>> +static int
>>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>>> +			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
>>> +			u32 access, bool share_access)
>>> +{
>>> +	int cnt =3D 0;
>>> +	int async_cnt =3D 0;
>>> +	bool no_retry =3D false;
>>> +	struct nfs4_client *cl;
>>> +	struct list_head *pos, *next, reaplist;
>>> +	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>>> +
>>> +	INIT_LIST_HEAD(&reaplist);
>>> +	spin_lock(&nn->client_lock);
>>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>>> +		cl =3D list_entry(pos, struct nfs4_client, cl_lru);
>>> +		/*
>>> +		 * check all nfs4_ol_stateid of this client
>>> +		 * for conflicts with 'access'mode.
>>> +		 */
>>> +		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
>>> +			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>>> +				/* conflict with non-courtesy client */
>>> +				no_retry =3D true;
>>> +				cnt =3D 0;
>>> +				goto out;
>>> +			}
>>> +			/*
>>> +			 * if too many to resolve synchronously
>>> +			 * then do the rest in background
>>> +			 */
>>> +			if (cnt > 100) {
>>> +				set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>>> +				async_cnt++;
>>> +				continue;
>>> +			}
>>> +			if (mark_client_expired_locked(cl))
>>> +				continue;
>>> +			cnt++;
>>> +			list_add(&cl->cl_lru, &reaplist);
>>> +		}
>>> +	}
>> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
>> That would simplify this quite a bit for what is a rare edge
>> case.
>=20
> If we always do this asynchronously by returning NFS4ERR_DELAY
> for all cases then the following pynfs tests need to be modified
> to handle the error:
>=20
> RENEW3   st_renew.testExpired                                     : FAILU=
RE
> LKU10    st_locku.testTimedoutUnlock                              : FAILU=
RE
> CLOSE9   st_close.testTimedoutClose2                              : FAILU=
RE
>=20
> and any new tests that opens file have to be prepared to handle
> NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.
>=20
> Do we still want to take this approach?

I'm still interested, but Bruce should chime in.

Maybe Calum could have a look under the covers of pynfs and see how difficu=
lt the change might be.


--
Chuck Lever



