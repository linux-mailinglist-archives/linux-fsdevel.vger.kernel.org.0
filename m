Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F644DCCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiCQRsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCQRsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:48:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98351F37BA;
        Thu, 17 Mar 2022 10:46:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HGo0NR003868;
        Thu, 17 Mar 2022 17:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6S+PWUAGbwFLZtsmygufuZs6R+jvR6CzMDoSYKaMgb0=;
 b=zlcLHPcBJt91Ofa3PrDnqmNHbliTpWQM40/ScN7S9wseRAtuaO1NLOrZZ4elxNUGfQpL
 Utqu38vbarMOBiJrkg15L7pqAy8/1M6Q5uusibuFoRZwbhbE7zsi85QiACg5McieO337
 wsUR55h7wB07ijqGc0fFbI96v2wJpIrRosjEQvPYWt3sYlBjSYgNvf0052KlP6wdRPdJ
 bDaGJfn0sFrTz974ZLCzg3zFUjTH0VmOkNREx0crdm39XFWH0v+cPAfKlObfrKGl+/Rm
 cMHUO0o2GnmCJOGKVZj77fJ1YfAIeNgOW/3eRKbEg80F0oDLCzQqp3SzlJSeMXDEYJRW 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6t4gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 17:46:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HHf6UK061630;
        Thu, 17 Mar 2022 17:46:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3et65q3gf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 17:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFQAoaN2XNDr6HmckGMEvokRkBTGztcIGz5gkrzdCZV1MLyuPJuvuu2pHjHT4upaiD1yi/wNdVJchgCjmdIeGg7HIsPgbFmqEfK9IzuxZPOSDZCZ48S7dwaKNB4JXw6VfmieNXlTf+nuFlOW8ISbg7IxDBO1aYLsc5kLjOAkTTuqXv2jn5aj8buJmMohEQH9Num5I/3NDUHauqt9geNcqS8NsLGZM+uBc/7V81tf+Do/VoiukIODjGKOcPZ4sBxVMFzqcf9XQ991yu3vBs7J0sF24jXx4FaXLtz9mSYdf/6WcU1B23ajkUtDxhC0r0l2uch93Ibb27k9WR9eJGocGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S+PWUAGbwFLZtsmygufuZs6R+jvR6CzMDoSYKaMgb0=;
 b=WFU3KDRHkdcA5177X8nFkzmIPN31fa+R+kTi9g++s/bCMyML4aKQX9+nF5qlXHRYCzgzS+2riCE1CrXojFV4dR32YVJAaU9LarxEWXsa8Y9D19ufLj9L0NhjIfsIl7y7AVu4BLD//tTRukRtmkHVrHnMYl8wgy+7k8th7EvzgZWMW0P5nQDRTgw2HP1EijUiWnve1o2/hYP2txlALRThsidCJlGZtKj5T/diwAt8mvquZBn7fHtmGr5ERsD9yPIVAG7wNiZwYEiHZFBur6k0AYxq15OEYFBrvMomoqSRgA1O+mKg1mAdiHSsel+n5696JP7KXtBD6qoWMqh+X/vPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S+PWUAGbwFLZtsmygufuZs6R+jvR6CzMDoSYKaMgb0=;
 b=Iyrg2JrNfg1gmOK4UrDtXvudesZ50Na8E9xvEMa+ow7BslT32R07pIEk+ajy7E80Kc0qY6pBFVKfQaIH6TebSVFCh9ZG3A2kzbGk+7rHhp1oXAGXD6cwYgbpqFGolAUGccFB1C+MQKPJgfgu4xxG5WogScv2iH1Al6cizAr+/WY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2131.namprd10.prod.outlook.com (2603:10b6:405:30::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 17:46:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:46:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v17 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Topic: [PATCH RFC v17 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Index: AQHYOdLAmpfjykEdNkWH0VGWaQHNA6zD2EMAgAAB/YA=
Date:   Thu, 17 Mar 2022 17:46:38 +0000
Message-ID: <DE4259C0-950E-477E-A9CD-1389DA5C4B86@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-2-git-send-email-dai.ngo@oracle.com>
 <bf53431f2a6a1f50d4f21f67722a207f582ecf29.camel@kernel.org>
In-Reply-To: <bf53431f2a6a1f50d4f21f67722a207f582ecf29.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55112905-1c65-4eb2-6e6c-08da083e169e
x-ms-traffictypediagnostic: BN6PR1001MB2131:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2131E2490560874986FCB7D193129@BN6PR1001MB2131.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXldCxHU4Wk3jWnh8GWYiiJyffo4UJJBQ273MnzhZfIob/AvCPx+166L6O9XX8cMvBrw6wzTjh6HtYZZbFH3iWcxWLvz3MeHRyjQWJUEth2iYsv0PrrSU+Nnn0Zm/PeG3oyXb1jJVGhCD0nsmbUWaATrfiPBtHRHtSFCmucmtGc95cu4BBDAu3H8dRa9xNSDqbRjG/bK4UsFCC86U+9swyTY+QF3ZjQlk9vaMhwn0q6TBrAqXPHbcXUvyqoA8CDopYhZGODOTAwAM4m4Iva7ScxLSk2yEn0o3keHqGrNF7qRjnAki2Ega6tNedks3A09jSFoc1nIEY1zWi9t6IyrJb4IGNNIxiSTVdncDOR89X4veocprBJyH5KUWAYmJpHaejNkXZHqCLs5S3amnjn9ogcitnjcyAR4zV964jt3mFkqXgcvjAbbeEoG+ZHui3sFpSl2mUXejNmOSS1GCG6jjiQ1smlDm2YQ8r6+gfBBLwzZAhCy/Np5261zBD3kBuhpU/Ph7QsoYs3YP5dT4E7/fb5heeLl7nd2KhV4IREB/hg3t0NRMVClCqQ4ZI/xVs4/7YNDgDmLsolv3cmHdtG5ooPIUeW8tn1dF1CyFk08VpJsMJxA/Y/Sx8sUSJXuLksV/Mxd+zlt5IEn/LKogXFM+jpWaw/5iGMhdLP9DZjFec+SdGdyu9Q3Q3LGdEDE6wqlUKB+h4SxpEgNwCsYQEix1+KChoBSIs/Z+B4+fMun7OkRPKL60OR/SGa8M88ZZzWK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(316002)(54906003)(33656002)(122000001)(83380400001)(6916009)(2906002)(86362001)(38100700002)(6486002)(36756003)(6512007)(64756008)(8676002)(66446008)(4326008)(66476007)(66556008)(91956017)(66946007)(76116006)(53546011)(38070700005)(26005)(186003)(6506007)(2616005)(71200400001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gp3Cz5/gnfTBk+i1QZPT/ZmXPYTM3f+Nheuz/nKcZcUlSBWsOzzGk7O6xrkY?=
 =?us-ascii?Q?ylXkKlKZWIsw0lgnF0Eu5tzVHiGueS3G8sXbV8kXfTJAQLqAhiTSSN6M3eT3?=
 =?us-ascii?Q?C0N8EDHdkWQWqqeodkFi1zZNxRCS/Z+NzTdbClJFEfvBc4YofJgkomvZGOqO?=
 =?us-ascii?Q?krU3RekzwT4899KMOQpJPM8QEHw/qprdcTmbBKuBPjKOkpO27/Js0hWGf5QW?=
 =?us-ascii?Q?hEX0GccKel3i62F235aPsSyJUuEgqEcAerVq/Ucn+f7rPCOPpJoPNqRzgREc?=
 =?us-ascii?Q?OEnY5piMJeWUWroI+z0XnwIbqosqCi97KvuMgFV76N0v8ePHJdO1YwaHimn2?=
 =?us-ascii?Q?dnBgbjxeKQIJOnetRRsrej0tiiApIfUK/cV+Qyft+NNjVvmOZGHcbPJkIwoY?=
 =?us-ascii?Q?Ra0c4g5jfwIfEq1IVeLA5OtDNxqQBcEXGX8t+sZmL8s3BdrSZ7IjvXI2G2RM?=
 =?us-ascii?Q?hXSRy96vUwZmTLmLJRJ+ROgRO3oo63ln9Tpele6yZTRG64NWPb4aGoYozuDr?=
 =?us-ascii?Q?SX9nYFox1AgGUwDCjE6cmSRju6kXjPxa6SMhhm5aHWcKXWrIX5ZnIpSPX9V5?=
 =?us-ascii?Q?0IvG+wsUfVkppJsbUCCPk5dfUxoSUDt/0EhCMmYh+m620KSYi0FiltXWJT7O?=
 =?us-ascii?Q?EAw/gnWhdH46gH4a3CETIl+SkjJiD3VscOgnDGLl7aaXMAWbdmYIc7m/hoY8?=
 =?us-ascii?Q?vOPkzM2iEATrvZhfDBYtOkCDbrq3tSChHb/4vlHzBcORHGrSgAMeNDvkYLtA?=
 =?us-ascii?Q?kGv4QSxeD6AlZ43pT0k3bIUHaTKG2l+fJA11NPEnCBecLAzMOMN4X1f+ZqNs?=
 =?us-ascii?Q?E0dFUp7BPcK5B4ZReC3/0lymPHfvFfwNkppK6ZWCnpaeKw8OK1YknTOzYBhW?=
 =?us-ascii?Q?fiEUXK2JokqDVKnduBT3lxqzZYHUshOcAUqX3qNFoDgxFDrofwzPFtfxJ2z1?=
 =?us-ascii?Q?9DR6MY4vqZHjmctOfwwZeD8kJnWZ07EMjEgxhk/xcJ0uBmtUdCUzmM5LlSUe?=
 =?us-ascii?Q?XIhqPeAuZ33rHeWOFPKFzS/Dfbz+5b/+n47sgyJYB0NSmE9FiW8XEHVoRwzB?=
 =?us-ascii?Q?qsii61sfe2L8gdv3hlIAf+3eemUy1dy0h3JJWQFm9Go/pZktmHx6vGka+w4D?=
 =?us-ascii?Q?SNxLnaY7DqFmj6wHwzGtvgHxCFA6kiq+PeuCsrlzC4gWKm4WRCsgTFBmEGSc?=
 =?us-ascii?Q?kJYSX+ECBrS0+sYgMiTS22URweTKXbXq1Wrb55o66p2bWxd4pBB5EEURZ3w7?=
 =?us-ascii?Q?w6eVKC8JjPutu3xUwD2CeIJ8HtmUEJzUXdGMbrGGsReGF79LUT36OT5HJvHX?=
 =?us-ascii?Q?NWdQshraAUyw2fUNDakSps/ylNd6bJdHmfB7xocnGOdmli3RY4f6aGk0MwcA?=
 =?us-ascii?Q?eNx+S6HY0IHuWnH46RT8ee05eOdkk30BdY15NdoFXm7SH7zcBALmlU4qXoJf?=
 =?us-ascii?Q?65JUS4MtRTQgNroJQYAEELtTofErGCvN823kqs7ni3oLPnnRU3/rUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71224D1171082D4CA5B83FDBB47FECF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55112905-1c65-4eb2-6e6c-08da083e169e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 17:46:38.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nqKZDnAu2dZS/E8k/L9Tl10zy9StVeRj7i4hQJNCec/3euoWyDfgcui3/dj2CSWvhLOFKgAD5mhaJ84bfxZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2131
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170099
X-Proofpoint-GUID: z1svmltMscPFxLLiRSpa-gvPiIDMdgMR
X-Proofpoint-ORIG-GUID: z1svmltMscPFxLLiRSpa-gvPiIDMdgMR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 17, 2022, at 1:39 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-03-17 at 00:43 -0700, Dai Ngo wrote:
>> Add helper locks_owner_has_blockers to check if there is any blockers
>> for a given lockowner.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/locks.c         | 28 ++++++++++++++++++++++++++++
>> include/linux/fs.h |  7 +++++++
>> 2 files changed, 35 insertions(+)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 050acf8b5110..53864eb99dc5 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
>> }
>> EXPORT_SYMBOL_GPL(locks_release_private);
>>=20
>> +/**
>> + * locks_owner_has_blockers - Check for blocking lock requests
>> + * @flctx: file lock context
>> + * @owner: lock owner
>> + *
>> + * Return values:
>> + *   %true: @owner has at least one blocker
>> + *   %false: @owner has no blockers
>> + */
>> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +		fl_owner_t owner)
>> +{
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&flctx->flc_lock);
>> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
>> +		if (fl->fl_owner !=3D owner)
>> +			continue;
>> +		if (!list_empty(&fl->fl_blocked_requests)) {
>> +			spin_unlock(&flctx->flc_lock);
>> +			return true;
>> +		}
>> +	}
>> +	spin_unlock(&flctx->flc_lock);
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
>> +
>> /* Free a lock which is not in use. */
>> void locks_free_lock(struct file_lock *fl)
>> {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 831b20430d6e..2057a9df790f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notif=
ier_block *);
>> struct files_struct;
>> extern void show_fd_locks(struct seq_file *f,
>> 			 struct file *filp, struct files_struct *files);
>> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +			fl_owner_t owner);
>> #else /* !CONFIG_FILE_LOCKING */
>> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>> 			      struct flock __user *user)
>> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *=
fl, int arg,
>> struct files_struct;
>> static inline void show_fd_locks(struct seq_file *f,
>> 			struct file *filp, struct files_struct *files) {}
>> +static inline bool locks_owner_has_blockers(struct file_lock_context *f=
lctx,
>> +			fl_owner_t owner)
>> +{
>> +	return false;
>> +}
>> #endif /* !CONFIG_FILE_LOCKING */
>>=20
>> static inline struct inode *file_inode(const struct file *f)
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!

--
Chuck Lever



