Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071CF48B145
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiAKPt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 10:49:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59020 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245591AbiAKPt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:49:26 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFEcRl004656;
        Tue, 11 Jan 2022 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5NGAo9JJTUvm06YCoCKk0EmYmXoLAXSUUkS5lbKYqNE=;
 b=N+YnUO9d6AVZoI7KHCqA2tKBKMGyoKxy75KIXjMNklFL2UlkHM/L9+sKf3Sc+F1ZnSCi
 1F3VFHUeS94S1UQBuP3DWgpwygBtGfbfmDkAyhv+LHjrrwBmV/eOLL0eVWQZNufziHVV
 xXxpnLzMLFp9T0//1r2Tv/nsJBkaqVWkdF7bs+HeaDIkqlxGAng7X6PAfF5PwT6y2hMe
 ksPFghpEJ1eymShTk7dg9OJ68uoEZ9EEsdbLsti7imJcVt5sY/YDUXeY1quK4+IAjLaP
 GGtWFyOfOWqcfXoh++8+5Z9xdsN72j7F7ubB9GpXSBtUMKE8/4UbP5juGrn09T5hjHgc Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbus5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:49:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BFkgN2026431;
        Tue, 11 Jan 2022 15:49:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3df0ne73gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRmZtJe/omw9O5iXg3xL/sjAO5lLUy3LW5bxRHhZ2E1W1vuWvjSOf32bKg4lXqCU69vEQ4VlCUj9Tm8qb6qTk/ls0++msJL7to3PvyV39qj+CCjaHDXE/H76++oDLnnBFcQV8B4QK5NR9hqfQsI90aZyslQ8VKT8Q8fKRQ+FMaV877T0KlxJcs7AcRmm8A5syi105mCEWWZuDGiwLb83xyJhYKmRKqvcST96A74Vi2+s3gUmCQi5xYJNjnBBkxptsMKR2OwyBUKOgr/TMOThrXeRlMHpJPUKGb/aFhlQC0UD756poSj600sSwVjtSoExVmEpNUgpgeRCGIZwLmni3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NGAo9JJTUvm06YCoCKk0EmYmXoLAXSUUkS5lbKYqNE=;
 b=G0iDiD1q1Hsl8xn/X+04/7UR754K9kcWFBTGujBkRciEewbMDPburMtX1X5j4EkFidTgGQ8URKmku5M+DZq81fLziupqgiQZ1TpWO6cwZXXIHSMWKSyM8arX9XO5pGw8ifPP2YdqHtXeJW5in5syZRo9yKRkPcLETiHEp3sTfBVn5N2TglXiRyTMzaCkfCKccI6ZHYwO9Icpfw1jbiH45c/t2TxVrJjWgPKPcm0oBmcNN7FudcBgCKCHY5yU7MpDNUvneafjQeX3yVFAaakjG3PWY0esxRi3AGEDbBacMAjCn+QA6YPLi1tfVhoa3SSvuNuDSzqlFMSlT1KXPi2rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NGAo9JJTUvm06YCoCKk0EmYmXoLAXSUUkS5lbKYqNE=;
 b=QUJz9ypnPjP5kvbKMzzuhWM0lWz/Thk/x+2lBK1qg+K2jc8RxI5x5siDfyHXr7yrBvaRJepeUjFOYlflU1iU8bG5gWGyL6uN3r8jHFraAgIBPW9++hAOtn+zCPM68P8ZJoM6b8zhgknapKX/VlTcp4fXFxMf8dSk8dC16QM02AU=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 15:49:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:49:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYBlMLWE0hIl6tZ0+2dAxrVOaXK6xc48YAgAAdugCAAPdvAA==
Date:   Tue, 11 Jan 2022 15:49:19 +0000
Message-ID: <D2CF771C-FF71-4356-8567-33427EAC0DA9@oracle.com>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
 <f5ba01ea-33e8-03e9-2cee-8ff7814abceb@oracle.com>
In-Reply-To: <f5ba01ea-33e8-03e9-2cee-8ff7814abceb@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa1a1e12-cc21-4d3c-0c84-08d9d519ee01
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-microsoft-antispam-prvs: <CH2PR10MB37976D99A13934B0258E572F93519@CH2PR10MB3797.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIvPPwK/IJHhDHzrYLsXJhHwNUbF0IMXWn+nO/oA+ji/bTHKYcbIxrQthu9EAn2FJar2wJGR4scBBn420g0XQP1oGNyAnM1IcJK2VX1RCw1vitpQrjxVAwjZerqPe902En98JZssYGQ3GV0XE7oK6arRUjudrvkb//NkRAiltkGZkCwpBcvpu1dc66ZULnJCwGxLbwHWz6TH3A7QwXms+lrGGGGogNteotqVvCuhaWjZBAVnT4SbY4BoVczNCzPyTvkiUB7gqMIeX3AyRFqcvtIpjUenypJ4nqsJwghQpgoBAjIqAo7SIYr+HlHlU313C61N9K2H/wnYTvGieW4Jo5AWQ9E6KKQ1Iwx4eamWuFZz1Wr+krhljMzfQZOQkZ5PcfsrBON/eqaW7lr98iGf4lEG3SOXY2PsGf9RDtSMvaE4ACSDmJYhweo6+DETBOjvtbZKDTIHMAzTFWv/hY27nQyOyaL7eWzTWfPTkGJI33i4FNfA3UgwZnj2sPWkLa9f0MqpobSXtAmuCeRWDZAkT3BWQ4ZiyVXouaS7H6qUq74ABco/3I6E/uTdpgSDOtAP+RxKVqpIZISKiU3wHr1b62xzeLQgBxWXhmM3YgiPtXZNauTFfIXu9JPHQOV6jPjpJhv301oQnF3utoEh7CV53RkMzWWYg3MLTvcgqa/VNdSij1NAp9OszNvjICVj88WxQJ5CAPwfRav4SztPNsR5ruvUj7m+6a3k4m/PeZ3bvDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(4326008)(64756008)(83380400001)(6862004)(66946007)(26005)(66476007)(8676002)(2906002)(6486002)(66446008)(8936002)(54906003)(186003)(6636002)(508600001)(5660300002)(6506007)(38070700005)(53546011)(86362001)(33656002)(316002)(122000001)(76116006)(2616005)(6512007)(71200400001)(37006003)(36756003)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xT9I2H6yXTZdqXuZNYPS45Hj8rZFdnwKNmjqGRpkifujNhjKuVPAMxEKV367?=
 =?us-ascii?Q?op40AeVzOa65Dj+o3IamXSdwLh+WeRKPxP724AN+CQxUNhhcv997+EscbUo5?=
 =?us-ascii?Q?ho8JDZF4lAws49iPRJr6MUyqnHkm5Dj0WYLwq0E49eIGOCxNIIoHH0wdH+l9?=
 =?us-ascii?Q?83Udn++evPiHkj5/FIuPEHxh1h9u53P2l3sQqCCRa+VfpaWO+T34PShdl0Tf?=
 =?us-ascii?Q?/eFDNoxgS4s3fnzLxOYQhtCi2hQc1UOHm0z46GNKScqbiWlTv6zBD+BEV+Fz?=
 =?us-ascii?Q?Ibjm4/xAe4ATDdZEE+5huWI+y/2obFaOWWKulVpVA4IoStN1+Aq+CaFXPcBZ?=
 =?us-ascii?Q?9bEp0P107h5ywwWXhQBflfcReAy7FSeYBYuDiY4uWH20dNUipG3WgC79qKDq?=
 =?us-ascii?Q?ssTQY1Oui6xl0+V1sEG0HYReaso0tnX9zyI27CjEWTwLL+Rwj7wc0mISUKjO?=
 =?us-ascii?Q?2St+ec2Pyqw5v8e+fFr+lomsQRdQebreuLOHH1P9n9XS/CNWulcg0M1dGMCE?=
 =?us-ascii?Q?JABzfI1XBFlcwu644jX9pcG1m577FKyZ74gLqBjOWFpJNykKjxEj0z9CTNay?=
 =?us-ascii?Q?xFdaPonXIB2AqsvLQCwl20358zOC2PtlBwW71l8gpTUBAH6IWKx2QI6jm25F?=
 =?us-ascii?Q?sRQ6hESf3b/tCT54IvnA/kXutpHq/pDlIh7SMQAFZ0hp98JPGqFhdV7FIm9u?=
 =?us-ascii?Q?Zog/TzLmCwIUtyrEo0LmPnBXPNXdhp/I7Yi9EiK9O7Dd337QR+0bEfFrxYtI?=
 =?us-ascii?Q?ljCDMTcnoBtnAimNDb8ZGIDsOLpwoMMmDY6OeWSEYL1DXu8HJ2fBXt/JG5eM?=
 =?us-ascii?Q?ZXlMNBXsL1fRgGquQFri5GQhOKSs0ce5RioaQs/0fUAsjsgVYagOC3AbXgOG?=
 =?us-ascii?Q?CWYj3w7EN1TpnvO63T48f6D9Wr2uvnk2229cf5UgufyTtLBfAjbOZaCFc0b4?=
 =?us-ascii?Q?iXxVQJ4mYycqDgFJoAMxd8RaYHFIJl8FQF56VS+LXeAdTWF+WubI9V1IIT8t?=
 =?us-ascii?Q?w5RcUKkSo8cXC+xueNlMHaj8QuC5FOknyZs9vVM9kceVPwSmE9ckdWcAN/uX?=
 =?us-ascii?Q?0nZPPxy3TVi2AZbH0B2Qhc+i8dmN+MM9/ZhBPo5MyG/O3Y+fJ63KXk5zhK+4?=
 =?us-ascii?Q?UCnOJPpQiOFUfbRv8oPa8GYGHlc+MP3Jx6u6Fv3Qo5ilSxG8xvcHgYy67jDf?=
 =?us-ascii?Q?l6Gfs5Nxwe0JB3Dk5H4uioW9DQ4C/PQm2sjF8YuXfdOYWZ3YxHFl9CJx9i+I?=
 =?us-ascii?Q?hSO4waDeoXPK+0oSdazfxlfd0G8q4DjwnU6KcTwsr6v8n4UBr3pwDmiydyN1?=
 =?us-ascii?Q?tMjju93zemJ3OGzbfMYfc9W4p5HCrhDBrbpr5nS8BXIBLd5Bw4fy3N8E38kG?=
 =?us-ascii?Q?gNWdSGW5QBLb/slsH6tQ9qORldJ3rIZw8Db/K7i1Q25EOlIzHFxIeJr9CT+3?=
 =?us-ascii?Q?R4+qKXzQYX0zXzVnNhQnWBuz83g3GkiLsRv2fmY/9szUimJQ4c6hOiqgLOrS?=
 =?us-ascii?Q?hh+ZyP4LJuh8t6QWmW0sW/n/gy4TTNbCQ/vaGKwH7Qq20mSinNMEoa7VNQxU?=
 =?us-ascii?Q?8Hj8L1gk7duIF9ovinLg2V0KvBva+iNDGRxxKA00dmz0wNjjYco4pV7UjL/O?=
 =?us-ascii?Q?CzzEXv8w/8iVadCVyApcKE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E959F9C73370B489E50089083999187@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1a1e12-cc21-4d3c-0c84-08d9d519ee01
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 15:49:19.2799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8po3F/qXlhXkwpkRXWGIMDLVQ3y1gDQ8wysKrL2EqKWaxCJ4D8tmA8XsSpO7ba7Zp5eKmsx7b4JgWhehf1JUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110091
X-Proofpoint-GUID: Coxh8Y4UmHOSWvdlL07stFY_QUYrY5LB
X-Proofpoint-ORIG-GUID: Coxh8Y4UmHOSWvdlL07stFY_QUYrY5LB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 10, 2022, at 8:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Thank you Chuck for your review, please see reply below:
>=20
> On 1/10/22 3:17 PM, Chuck Lever III wrote:
>> Hi Dai-
>>=20
>> Still getting the feel of the new approach, but I have
>> made some comments inline...
>>=20
>>=20
>>> On Jan 10, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>>> @@ -2809,8 +2835,17 @@ find_clp_in_name_tree(struct xdr_netobj *name, s=
truct rb_root *root)
>>> 			node =3D node->rb_left;
>>> 		else if (cmp < 0)
>>> 			node =3D node->rb_right;
>>> -		else
>>> -			return clp;
>>> +		else {
>>> +			spin_lock(&clp->cl_cs_lock);
>>> +			if (!test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>>> +					&clp->cl_flags)) {
>>> +				clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>>> +				spin_unlock(&clp->cl_cs_lock);
>>> +				return clp;
>>> +			}
>>> +			spin_unlock(&clp->cl_cs_lock);
>>> +			return NULL;
>>> +		}
>>> 	}
>>> 	return NULL;
>>> }
>>> @@ -2856,6 +2891,14 @@ find_client_in_id_table(struct list_head *tbl, c=
lientid_t *clid, bool sessions)
>>> 		if (same_clid(&clp->cl_clientid, clid)) {
>>> 			if ((bool)clp->cl_minorversion !=3D sessions)
>>> 				return NULL;
>>> +			spin_lock(&clp->cl_cs_lock);
>>> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>>> +					&clp->cl_flags)) {
>>> +				spin_unlock(&clp->cl_cs_lock);
>>> +				continue;
>>> +			}
>>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>>> +			spin_unlock(&clp->cl_cs_lock);
>> I'm wondering about the transition from COURTESY to active.
>> Does that need to be synchronous with the client tracking
>> database?
>=20
> Currently when the client transits from active to COURTESY,
> we do not remove the client record from the tracking database
> so on the reverse we do not need to add it back.
>=20
> I think this is something you and Bruce have been discussing
> on whether when we should remove and add the client record from
> the database when the client transits from active to COURTESY
> and vice versa. With this patch we now expire the courtesy clients
> asynchronously in the background so the overhead/delay from
> removing the record from the database does not have any impact
> on resolving conflicts.

As I recall, our idea was to record the client as expired when
it transitions from active to COURTEOUS so that if the server
happens to reboot, it doesn't allow a courteous client to
reclaim locks the server may have already given to another
active client.

So I think the server needs to do an nfsdtrack upcall when
transitioning from active -> COURTEOUS to prevent that edge
case. That would happen only in the laundromat, right?

So when a COURTEOUS client comes back to the server, the server
will need to persistently record the transition from COURTEOUS
to active.

--
Chuck Lever



