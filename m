Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659384D3B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiCIU5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbiCIU5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:57:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C128188E;
        Wed,  9 Mar 2022 12:56:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Kcl8L019669;
        Wed, 9 Mar 2022 20:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UFlIIqQbpDHikhSpKKeBOsrtYevds0d9bQ3ZeBdQXKA=;
 b=y5YVEYJz20wr7KhQLqqWpiRZYOpY5/PknC4qfj2VV9kOscVe86YlnGzt34cRWczZQmhz
 AsWclZRZrwcdX0A8dNnZyZPeZB265acLtSTJ57HzP0Dg/SvgzvV+fZ8TWNXNIjC/S4DF
 j/h2qYsYIw525K0/+OKo6OYo9uVe5t+NQmiKAsUVVrJZaUTsEwld7OlrGWbYl7LEuWeW
 N2Sp17V4/c7+eR07gkDKZ24bDaxo7hi/njhAbeA/bb0QAhsWpifEm0W+cwYPFwmKxQsR
 R4HsT6zHt9ByQoIVzrvS5ByZOxiwYEZQmcs7uS68Ju+bW419v6SRrkXE9wJ44BL2SCMV 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfskf1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:56:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229KfNiY122431;
        Wed, 9 Mar 2022 20:56:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3020.oracle.com with ESMTP id 3ekyp35u3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 20:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWzS5DNFjYLcCp0P+mvl0Sr5V35IkpZzcsmAeKt93eLQct9s3ZMlwEX7kmE5Pyd2AXjUPrqUtIF6Ihm2795pKMKj8p9Aw95NfexwYhb9qc4DKlk2h4NuaX2LwPjwoLWUjJOGp2MDXgX4JEoL+LSziAKiOF99EGrh0JsiJlJPdjlsXeQB1AvziE/VeB5a5TBNftxwOixIQONeiDdTJQZWTw3YURaU701pZuVWarM+KdJCB6W6liQcA05eoqPE2Iu5djWKb+7+PtnxgwD8Apk16xgMlYnDFONtZwzU9XzpEw8LFSGMuc46C6nBfgArsfrUWZIc6wU7hijjKe5lREMy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFlIIqQbpDHikhSpKKeBOsrtYevds0d9bQ3ZeBdQXKA=;
 b=FI3IiNTRJ/2Z+GyBEo8++zBMjvrcGBrq1u+nkMXVlmFZZU2/Ras85B1tlgiR1bmj+f7oZTrv+kSV5X68XDzhoLYtQDmHczEqT8Fy9GGAabmNiZNlEPerlDyZwy/NG7SBFwE/TmTGGxEo+qz9dcR6rBIjK8bBBCMugQfeUCiBZqsw9gaZKIFNVHrafbb7h53EJlRMnzFMJuMbVHW1ud4RH7pqZWQegojKg+xjrfaotYavsrpBxSjbSQA5VG3c/PydfGqT0ZaMA0+kFsM1tUgSLrYlOVwdp/zVKhWAohLOErja1WNOrYzWZUliIvuset7gIrmE5t4wlMMdztfniGdaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFlIIqQbpDHikhSpKKeBOsrtYevds0d9bQ3ZeBdQXKA=;
 b=rWUe7pShMEnef1x8N9UpF6psOk8vsnX5Xts2EtSRrSHtRZUPaBfeCRZrpgAWt/pwO+tSM1LOB39sXsM4ochBFnynDZ48eApmpZ8SEivVqFD8coDy5r/H9epv5YRrihyhgFvuw0J9meGan7CeNTg4cAASTBhtzmXnQebvPEKA7RY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2084.namprd10.prod.outlook.com (2603:10b6:405:2d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.25; Wed, 9 Mar
 2022 20:56:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 20:56:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Thread-Topic: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Thread-Index: AQHYMCku2gD55cSpGkGygsBMZ14sZqy3kACA
Date:   Wed, 9 Mar 2022 20:56:36 +0000
Message-ID: <AB3847D1-CAD5-4D6F-8D49-C380F2E7AB64@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1646440633-3542-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6a15fe9-a4d7-4885-6c9b-08da020f4ce8
x-ms-traffictypediagnostic: BN6PR1001MB2084:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2084654F7D86084D5C1279EB930A9@BN6PR1001MB2084.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tY5AQEgZ4ve+bzT/p8T3rx5hW+Ylab7ZEv+exHrZRlBVlmoY8m9bydPXmIKdOU9aU4C6vMgvejs0m1X4I8Xb/+M3YO4yKDtXRwk/ZJjr0WVsZj1I+EkXV+XMIcQao+EyvajIx01rgxdyM1lH3x/g3gEO8muT9uxf4FvVYJr1dEVqQNTnlQJ8n/EC2GAwf9cOUG+Cs9dAhNal2sPD8q2eaYEvZv/ERzlcgPAYh+k82D+tR3StLJofdEHKqce26uTPPKatCW0QdcIAMVX8UCCm9wFQy0e3ekzWPei1bBGrfSIGiurxdYbL5xHuRZp7VFbr4fUpNliOLKVmkGAkMeWECV5LcwgzeMMfjme+E1WZlM4nEgs20BrWPDwUvbUbCOoQOVolFhe5LlqODm6iL1zaxJLRXe+1LlbkoTnXVg2mp3GFji6soUJXOsZMloErkqwXoE8LDrnMzAbCNIBHNxem0i9cv/cxrYXxnZJ2iqATQItjLgiXK37uGKUEXTpdeigTnsATfvpU41c1Gsz5MLCZbzb3u10sm0E6Fj/WSk766C1tT8U2+9pol45B5P54Ww29Ystwjpl4dxkz2qui+jEUSwtrpseLFxS/QfMYHY4Ojx8ZzE3WFU1Wljht5MSkdSIWfwPLjNumqOSkFrEw6oB2F0IZPY+hu0eLhr/syfXXZajRUIRE/6xnS84Km0Fd9RlLUfW2ECcWTlyXl0UB8PtgoafHDcQBH3qC6ojUgOWKWMJGEoXr9lpIhsL9OdFVwixQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(66946007)(53546011)(91956017)(66476007)(64756008)(66446008)(8936002)(76116006)(33656002)(4326008)(6506007)(2906002)(83380400001)(316002)(26005)(36756003)(6512007)(186003)(54906003)(110136005)(6486002)(2616005)(5660300002)(86362001)(71200400001)(38100700002)(122000001)(508600001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddDfX4paEaqine8Bi1vyRyfgaeusIzLBd8Z/oa2oDDKWTuAyV2OA++WRVQwq?=
 =?us-ascii?Q?0nj155EY5z+oBTdLxoJBYqt4kf/GRHKs35FcCc6ohAJhAYvoSzz+N7po4pDm?=
 =?us-ascii?Q?1e8GIBO/jdObaK2WucjN1Z5JBLOUrs9S9RHyVNAWW3Yw3T095TjYhPWnBWJU?=
 =?us-ascii?Q?wbgrs5aGc4tZ7kC3rPrVB6uSxfUaQOsvMzB4mPFgct5ndjmfvaloYz7Rg8hB?=
 =?us-ascii?Q?WdhVlH2RTledQNd3I+yZuq0nhHRqdL01LZii6zkJemGrshFboJCxWVxO00Cj?=
 =?us-ascii?Q?m+pf26scXo2+yFZyp72Sao0J9irQUUq1IOwNrrpWQFTpbjE2t97mOXzAgooJ?=
 =?us-ascii?Q?iYDvzFMUHnya08RD/MhfMwR9kyOjyD04hsxgzV7jhB5mlMquJ2vvKnikflet?=
 =?us-ascii?Q?WN9J0Z6uZp/6aWI9D4UGFxoZDms9JGANC3SBi9fyDtgz/OJ2vBQiRsfUgIjT?=
 =?us-ascii?Q?MLbH6EJ3U8GOnjBUTl3maotkBrhQbPMfQRRjNkF7zE3ujMSPXyqnXjjH8RJp?=
 =?us-ascii?Q?rE9IuOeA5p0P7LnUnR8wFZkG+4zsxDZO/gmdxcJN6Ln0+hI+OS7kSXWP3T5n?=
 =?us-ascii?Q?K1Du3eRz8H+uJ/7HJ6zXKk7jIkga7xVeRLWffz3z1ITjbGq3bw6rs5//hnsT?=
 =?us-ascii?Q?SnD/6D36Zk7G+O1zfaulQqCkbAwuFODtgZLZ21q/0lHY8CUBYSmybuwWraSX?=
 =?us-ascii?Q?Wa/5hDt1K9SX8KLEkgvLt8LzAfyKg2ke77yJ6gIBgy2owp+BQyFZHVOoue2L?=
 =?us-ascii?Q?ubSJj2i0obQx2DXwJYmDZijV2mxVNA+wayi7JeUrqN9rqbnwVn2js7otU2jB?=
 =?us-ascii?Q?+ElamiD3GslcxapUWjxFS0PGF6vhave3+JJjZjjG3RPNEoDJkLFROdmwm2VN?=
 =?us-ascii?Q?l9oF13tNTaKT9Fl+fGAxYOPav99V+V1PdQ+DmvRELYcgahLcQxB2i/qfLytY?=
 =?us-ascii?Q?v+pE/HuAwZd+/+ZXfyG8jMudfz8q81mY1rJW4vgbzI7x41v+8R73EZor0dXD?=
 =?us-ascii?Q?lLfGYIcMD5N4JEuf1kSXvFt1LN2DmvBYmCHWs00MZh/tTAu9fhAoipXzlDSM?=
 =?us-ascii?Q?Hz+gMstaBw9o68S4lVdqaJh/hWIQg97PtZtHVzRVC/fSapWpLLqOlKULmuSx?=
 =?us-ascii?Q?mt4HCIemXFiS5OYXVhZ2DpWGuhdHvIkKG6Ai0JPcDDRmEB5TEboUueoWWkaW?=
 =?us-ascii?Q?WR6p5Naw4Su/zxoeh1oqdHWdU+XikY5lO/jn4ceVz4wUz3UD6cRrTMIkO/Kh?=
 =?us-ascii?Q?wmP3Cx6u7toO9wKkksnuPEeKwOkrw0/2e6mRgpX8bzDcXUKA4PC+DwgLlxZy?=
 =?us-ascii?Q?nVmEy3T+SEcSDwtN8j5kjp7t0hj6d0Rh4L6cw+psmaJy86WAEiZeDgUZdEOd?=
 =?us-ascii?Q?gbIr8f7O7cpmLni4tQp9okfUlwI7Yn4WlI2ZSFDKu9xfnQMzgCjk2wflU7YU?=
 =?us-ascii?Q?/ut0j1Z1s4JtESvm3kCHNcjlr6y1khI2Gk8EZaPS/2eIjIPzgNDqbjYJh7Oe?=
 =?us-ascii?Q?fA39yADH6SnfSrsh9YzxUur6GphGaMXv4E1JPlq5TtsdKZ3t4TZKK60seYyN?=
 =?us-ascii?Q?w7NA4SN/75Tm2uEfAK5BGEC9qPHqUCAMAWsR4xptc+L1tBIYwADANAOLS01p?=
 =?us-ascii?Q?lhyyjPbJ9pD2mMAlMeWDArs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA89F6049661C543859E9EDA1B55331E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a15fe9-a4d7-4885-6c9b-08da020f4ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 20:56:36.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkSCmiIcB5wPcyCeLM8IjnOopTohHXr/HXoFAysFwQ9OJBeiYeiDWpCKeewQnESs9PdEh+RDr5UCI3O0Cr3nNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2084
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090107
X-Proofpoint-GUID: vXNK7ihdLP2P2WtWYzLfbHUAS3iP_qlG
X-Proofpoint-ORIG-GUID: vXNK7ihdLP2P2WtWYzLfbHUAS3iP_qlG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add helper locks_any_blockers to check if there is any blockers
> for a file_lock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> include/linux/fs.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 831b20430d6e..7f5756bfcc13 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1200,6 +1200,11 @@ extern void lease_unregister_notifier(struct notif=
ier_block *);
> struct files_struct;
> extern void show_fd_locks(struct seq_file *f,
> 			 struct file *filp, struct files_struct *files);
> +
> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
> +{
> +	return !list_empty(&lck->fl_blocked_requests);
> +}
> #else /* !CONFIG_FILE_LOCKING */
> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> 			      struct flock __user *user)
> @@ -1335,6 +1340,11 @@ static inline int lease_modify(struct file_lock *f=
l, int arg,
> struct files_struct;
> static inline void show_fd_locks(struct seq_file *f,
> 			struct file *filp, struct files_struct *files) {}
> +
> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
> +{
> +	return false;
> +}
> #endif /* !CONFIG_FILE_LOCKING */
>=20
> static inline struct inode *file_inode(const struct file *f)

Hm. This is not exactly what I had in mind.

In order to be more kABI friendly, fl_blocked_requests should be=20
dereferenced only in fs/locks.c. IMO you want to take the inner
loop in nfs4_lockowner_has_blockers() and make that a function
that lives in fs/locks.c. Something akin to:

fs/locks.c:

/**
 * locks_owner_has_blockers - Check for blocking lock requests
 * @flctx: file lock context
 * @owner: lock owner
 *
 * Return values:
 *   %true: @ctx has at least one blocker
 *   %false: @ctx has no blockers
 */
bool locks_owner_has_blockers(struct file_lock_context *flctx,
			      fl_owner_t owner)
{
	struct file_lock *fl;

	spin_lock(&flctx->flc_lock);
	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
		if (fl->fl_owner !=3D owner)
			continue;
		if (!list_empty(&fl->fl_blocked_requests)) {
			spin_unlock(&flctx->flc_lock);
			return true;
		}
	}
	spin_unlock(&flctx->flc_lock);
	return false;
}
EXPORT_SYMBOL(locks_owner_has_blockers);

As a subsequent clean up (which anyone can do at a later point),
a similar change could be done to check_for_locks(). This bit of
code seems to appear in several other filesystems, for example:

7643         inode =3D locks_inode(nf->nf_file);
7644         flctx =3D inode->i_flctx;
7645=20
7646         if (flctx && !list_empty_careful(&flctx->flc_posix)) {
7647                 spin_lock(&flctx->flc_lock);
7648                 list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
7649                         if (fl->fl_owner =3D=3D (fl_owner_t)lowner) {
7650                                 status =3D true;
7651                                 break;
7652                         }
7653                 }
7654                 spin_unlock(&flctx->flc_lock);
7655         }


--
Chuck Lever



