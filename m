Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B384DB341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349102AbiCPO3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiCPO3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:29:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77AE1C102;
        Wed, 16 Mar 2022 07:28:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCnLnO024490;
        Wed, 16 Mar 2022 14:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YTFQPnngX4oVTylwyMWbW1gqSduLGfoNuntXkuuctb0=;
 b=X3V0jiCrB77aKgNtI+QL3xqDQBzLnbEZKmZCEBn4dc4kvsTq0AHJ2T9Kxu5EwfRf/VWq
 VX4HXN/vlMonRFXnVcTfI4v8VurY3k8qUmVb6PAU+2H/bcNchh9mT/+Fxq7dKhmORaMx
 T/O1CtrV0JSuXT+0IVIBcbwwmatx1u3FXkM3VACOdzoa7NcVMMy4dm/eDwCGZ/TGR6Y3
 Cy/CGsKd1GGD7ZpzuX4OW875Qt6pflfCuvc1b3rZnWwiAKWXuYAS737JvoxrdjD0R+Eb
 I2qIh1Vo4+vGFSo6ht6roVHZXjNh8vt0sqFCCPeTVTQH/Vj4SRrEggIXP20VYOVSc/iu 3A== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6pcq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:28:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GEGNsE060201;
        Wed, 16 Mar 2022 14:27:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3et64tyqqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fch+QQfbwxRplqshu7gUd34kLbI1wdi7X0CpaT7MFtlXRxu9ka6BcVACyGDy+X6htiMDwPA9xs/4Ajhk7pcEnuttxNlZy93KjrN+oOo7+AQBIKgLL8OjNFxWzvjmBK55p5yxF2JbBIZ77rKNnDjjEsJubo0xmSjK65LlCwixRB9xgGXbJLswRZ0ECjsVdd9OBt0e6bqLXj38yiaDd+UPAcKqXS0Tm78UmkbTx0mlAHl6yHHREumHdc4wn2oxGDjOtAwB/AYg9U/6hvj5cEVDJDnT3rsxRmLiojrnlh60Slbu2nlDOfWNOb4nGxKv0Byt1OZc9ZKz4XUGXg7tYi5FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTFQPnngX4oVTylwyMWbW1gqSduLGfoNuntXkuuctb0=;
 b=FLBwsyvINQDKq2gqkh7uGRAPmrs6n4pUSid0lkKtI+HFSZO5B+MslvRyxFNpRc74EOv73fAttm4nujzy0iVIwU3I9AwaUBdSxX/AcSw/ebs9GjQEqbz1iVOWJmWKJwuHvcQquB4EUJ3uwNd4yQeKxtDeiiwUUK5iyTM/IkeA+QvetnQdH44HGpMNkmz5b+kNgJtd383rlsfGsHMK7H1x6fsr+Sobr2d4+mXNvAWb+CT5PgV1CAzFIEo5+Ppb2PowtJLRk69v0Zdvdjp5WTrlmTUl2sCWiQ3cZbrYGdvZv7EW2YDqoC1RV1wDqM4TjzMODwDXSGOYxsLQso/MiEYmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTFQPnngX4oVTylwyMWbW1gqSduLGfoNuntXkuuctb0=;
 b=BJXjdqSQY14uzUHMqYbQC4OwbY09YpgX8QkPQPxXqy1UlFndlyawexjb0xFeicb/UhquG5TklHgutt0ryBOfSdYNUDKTrfJWCPRxZPLTjPnPVlyQ6UUNamlHS00z8Q99fkKRiiDOdvaqiqohAofaOUuPG/sH1IBTslczDyY3rdc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3781.namprd10.prod.outlook.com (2603:10b6:610:a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 14:27:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:27:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v16 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Topic: [PATCH RFC v16 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Index: AQHYNbbNyCdZ5ld6D0G7GIwxFtXS4azCGKAA
Date:   Wed, 16 Mar 2022 14:27:57 +0000
Message-ID: <31F7D9C2-7DFE-48B0-9464-7042208521D5@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1647051215-2873-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e587fa-1a38-40e5-4d7d-08da07592ad6
x-ms-traffictypediagnostic: CH2PR10MB3781:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3781255A70710FCAC0ECC8FE93119@CH2PR10MB3781.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOLOPA0iO0cZXy8M2vjuMZECkCiBF4bX0WhVtN62ljwRoJ5SAqIJoDml8OGgmegulR5UGrgyPQLLRKMuKd4j08giYwMU1fbNaQd01JCKGmAL71U3Nbt9SXPpAWfOKMTwekN2bATACqZuP4PhJXM4w6VmYdrAzIgdzA30Vh+nD/ddeX35D0+tydJ55ZjsNeDeBaLQoPFshtaRDI1HkDPQlUbPLlFw79eOlFDdDk6sr1NlYiDvAL0jNaMhbPZcQ0xbfAU5uZWiEiUKal1FBmkJoXV3YNG4CH3K8rD2DicA+W5PTdhD+zzZdL1aR2QWcuTTkK5H5ZHicEtzn43gSInfPQowE0R7dOaMONHwKTz5BeCjwdLRwnsxP0n2lUaLV4L8WvqIjycPuN+pMEASVyIW386L/zxmFQmQyt6QxYBVu0aERb9kVxP9h4sLkwfipE9doVV3nieYga3oFy3ojB30XSPzcm7hPFJFBZ6IgeatLxVs5RXN3qVqKNSOXOqMotymrSjWF6gunhk/r0Ly93OL2yRvzM11jlmXnEENSeHLh30Sa5xBMj10Rp7pNsglzlhOkVwkTN+h0LidT3xzR9KTKJAptFnyyZkFl8AvjokY85mVRFafnt+P0ys84PWI7ZEeMPrikwSPfSpx3QmRjbDdJbVoyclOxtxxcIBD/XxpoLqMU4JGacJ2P8nb6gigaNL1nGhHa12FK/tmJFe5IbFXGbW9/06DQppZX+w0mra60O5nccG0p15xBpjDt+KZgHST
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(36756003)(76116006)(4326008)(66946007)(64756008)(66476007)(66556008)(6636002)(6862004)(53546011)(71200400001)(508600001)(66446008)(33656002)(8676002)(91956017)(6506007)(2906002)(8936002)(5660300002)(38070700005)(37006003)(2616005)(54906003)(316002)(83380400001)(26005)(38100700002)(122000001)(86362001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/4ldSBnzIayDR9D3OuSUDjrRqBNzTQ327i+SOVwxB0RN9Knl4EdPpq1Q081?=
 =?us-ascii?Q?qJ1TQuDSiDEbGgqt4qD2MtRAHGHZZodmysAMZA+CG+OUHGSWYXwj6n+fYvRA?=
 =?us-ascii?Q?P7YRWBfZ5/Pv1RXBpmOFaT1QBLs1/4Lltol+aOr3z1rkUC3tzHoaoW6uBbpN?=
 =?us-ascii?Q?XjXsDF7Qmu0qBob2YrN/T6xNudNfC4nYaqO+nfv2CgUeK/s7WCX6BQlL9xPl?=
 =?us-ascii?Q?vTulRAAkMx6Liw5U+Pn0cUaAkcb46YLrGwoGMX+b06hV+0SrbHBqkovjJxAM?=
 =?us-ascii?Q?6svSfcsXb/kSdjXoBIVJm/NLLoGG9u62FF0BigK8e1uFdF2c+npPHFxIbTQE?=
 =?us-ascii?Q?X58+nOaocNbMLDMwvyJtlH/d6l5PeIr55iKcuVpHW0X5Gk2Yh/AD/WxJtR6f?=
 =?us-ascii?Q?C6KFFB2/0ca4xDBRYCCThKXk66nILIySglQ4/EvPuriZVba/qD/OGZaiNRkv?=
 =?us-ascii?Q?eDgiQzpg7WBR+ForABCpyygFb7av+F39DPt/eIt5tBuTzCl4otAWlDnyJroR?=
 =?us-ascii?Q?i2IBnE0BcRvUoozIl1uOaApHv2aKUWpe6DU3Gv+1XyqoMLoMLOYO7cg2YIX2?=
 =?us-ascii?Q?g3dUZnRopeutzASD08Z41w59SMn4pYDHrHhUCaCIc274whdRZFsEs17idd+t?=
 =?us-ascii?Q?EwcvcPCAtyehs9yIHacqUeEQ8KP1Y4iuHDwlMCOH+SawTnOAYnDQg06sW0uq?=
 =?us-ascii?Q?Si0zFNeaHw/Q2C+RH/ml8vYDLOZLlNot57z18XSbGXYIBL0+04veUmzpDo53?=
 =?us-ascii?Q?GF4r+Rr/eqz3Al2riPmEaW+q0/1GGCFizmSCgssgQ1Vi7PyT6I3Opv+Q1SjU?=
 =?us-ascii?Q?DbZz8gL7wmEdFweOhZzhazxApY1VgGfbweOE85NZu1WenZ6ALkxvm9XGCXi4?=
 =?us-ascii?Q?DVCRpjAQMfTqKzfe0ZU3R6H4WRpv6y0JtsUQ7VHo7edFQMNmpK1W160bNqxv?=
 =?us-ascii?Q?1l3FvNUL6akIMfD12zwVqNw/q7OI6YjRkMDigsdv61zucec3FnbrJuq7yOm6?=
 =?us-ascii?Q?hc8ug4ZU7jxYoubHI3vxeRNZc48wSqANzK5/PiTGQalhpxZturop8dOGgsp7?=
 =?us-ascii?Q?1hHyCSjfYwTOdp7GyHRqGwEDpu/hz7uUZO97e1EWCUVfIdqCfxdS51Q+yReg?=
 =?us-ascii?Q?FMzG+PCSXcaETDhjNjgLykMhHX7uiLtzE63IrYXCZSKCZmjYysa1VzuFryd2?=
 =?us-ascii?Q?UciMrngQS5uMWIC3gmpIU2mSqhLgpJaLhp0BvQr8fCn6iJUq5ZVQAqZVIIoj?=
 =?us-ascii?Q?D3iVA3laYdq6v6qeZCFyWNm2KiY41G2giaxqG3357P7tvuaAfVdUU0oezYRE?=
 =?us-ascii?Q?RBzulfiTRSTZx70uHT76waSc31tOgykVhBzapMgoLVhbcQahN/zOJcdGwL1C?=
 =?us-ascii?Q?Bi4z/6dxWBiKmgywYur665iMRltlDX5KA0KU1HMKTHcnRwYIijVdMV7L6+3k?=
 =?us-ascii?Q?am1HPUmLjT8N/jX+3V4Jqvbog0PmAvo8K7gNKQe/1FvAVR35jbzW1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <967E7180F2D763418190564CAE989609@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e587fa-1a38-40e5-4d7d-08da07592ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:27:57.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvlVs2++RRMVr65ntEEnqjvV9WLx0O5Min8FNHz5VnMWuspFjoTxtYv/fqux2Ctv7Fl7Ui5AWIkyPa1hrwY01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160090
X-Proofpoint-GUID: xF9Sm_geC6GLIX9Sd31MYAKYjfQ7swYt
X-Proofpoint-ORIG-GUID: xF9Sm_geC6GLIX9Sd31MYAKYjfQ7swYt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 11, 2022, at 9:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/locks.c         | 28 ++++++++++++++++++++++++++++
> include/linux/fs.h |  7 +++++++
> 2 files changed, 35 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 050acf8b5110..53864eb99dc5 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
> }
> EXPORT_SYMBOL_GPL(locks_release_private);
>=20
> +/**
> + * locks_owner_has_blockers - Check for blocking lock requests
> + * @flctx: file lock context
> + * @owner: lock owner
> + *
> + * Return values:
> + *   %true: @owner has at least one blocker
> + *   %false: @owner has no blockers
> + */
> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +		fl_owner_t owner)
> +{
> +	struct file_lock *fl;
> +
> +	spin_lock(&flctx->flc_lock);
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		if (fl->fl_owner !=3D owner)
> +			continue;
> +		if (!list_empty(&fl->fl_blocked_requests)) {
> +			spin_unlock(&flctx->flc_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&flctx->flc_lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
> +
> /* Free a lock which is not in use. */
> void locks_free_lock(struct file_lock *fl)
> {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 831b20430d6e..da8ae38f471c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifi=
er_block *);
> struct files_struct;
> extern void show_fd_locks(struct seq_file *f,
> 			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
> #else /* !CONFIG_FILE_LOCKING */
> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> 			      struct flock __user *user)
> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *f=
l, int arg,
> struct files_struct;
> static inline void show_fd_locks(struct seq_file *f,
> 			struct file *filp, struct files_struct *files) {}
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner)

Here's the problem, Dai.

This empty function needs to be declared "static inline" not "extern".


> +{
> +	return false;
> +}
> #endif /* !CONFIG_FILE_LOCKING */
>=20
> static inline struct inode *file_inode(const struct file *f)
> --=20
> 2.9.5
>=20

--
Chuck Lever



