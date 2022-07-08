Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762AC56B6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiGHKMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiGHKMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:12:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38884EE2;
        Fri,  8 Jul 2022 03:12:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686Haqc027362;
        Fri, 8 Jul 2022 03:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=FJyUWQvWyANcWv9sOowKnPZ86U7f++4lXTeaKds4TRE=;
 b=lzFM07bpDGrhDShrC7VnYG1NbI+bfEcO0T0h9WiUBNktxUYJJy6CzHe3D2MS1mBgAPu7
 ieAPDr6ikdx4Wczc8OL3RyzBFFkEBCeGXSMMt6xILDPfBXWA0SDYlid0Q9jB2KF490Ns
 filsr1e5g9xa1h2qTWcpTsjIWkA9iDB8Wqk= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69gxnr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxSPrEUXXaalL1X7Eg4phHETJCauu5t+QMN1aJ8k3J7zkioMTxRmF/ScogisZ4iRR5TDFzh2H1XY3xujmNVUhVUESrRobiRkMDmr5dX0dTuUuAFlobONfO3CcLtmtjJOBwYa1HOcGcMPmcMmbD0GRTU0Bii6feW324YZMVvBIIqo5/l2WqJuTiTiq9JRqWFZpxME4UCFdbMq+uTQEJ7Ap5b6n+qpsOnQ+HJQjD95AhfMnysmZ2dFrnGVgnbJt+iNS32kb5/zs0JsCXGhsXR3Jh2Or3W4ZLg+58KcIrL8ZME9raCkB8zfYfBLpCgyB+B8ciIuFaRdkVRgLry2zKehIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJyUWQvWyANcWv9sOowKnPZ86U7f++4lXTeaKds4TRE=;
 b=DnTVXKXTtYdvec+kwMV+y6PXfvqji85quDngCzkCuDeO5093l6P2ZnnqmK3X0xXULYSg1nB3cgBSt35nFySivG8hUbPGjfAKMWBak2cCSOtxh+3WsE8i5yzfRoSrEUWE+sw12szpjThrqkXJDj1zfcIuMxspADt2x/Gf8Gz83JognTvaYq/2QiInUha02WbZUQqB22CsrYIWW6wQiQ6M2AuHoZsQFCuxsQOv1CojmGxN12x6sM9h57fCASJv+CwzgsMHP2GqBU9zXXc4Z2gjp+rMS8P86le9g5OrmF1D/o9MERETBpxa4De70vygh9unB5Mb4wo4VfSWy/UP7irYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:01 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:01 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH 3/7] lib/cpio: use non __init filesystem related functions
Thread-Topic: [RFC PATCH 3/7] lib/cpio: use non __init filesystem related
 functions
Thread-Index: AQHYkrMqQCQoguTYLkWyk+Fnuut0VQ==
Date:   Fri, 8 Jul 2022 10:12:01 +0000
Message-ID: <4b9ed0a326cec3752792792a3de1ae6e5270ca78.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f9a9a23-6152-4824-1ee6-08da60ca4d04
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X3kzqKXIIWoz1hMDPl3ZGeJO2vC2Vm+8WgqtU9inD0UCqT/6f62TGhteSZOtLEy29XESkvY2tU6LzTVDcd28A3uPYml7wqFuiZWOh++NmK0SerL1khMh4UGRJQHzmd0VnbQiSO3eNSWxNcpgCYiw1LboKtZrdLQl793Cp6yNmMKUV8TeTZDboGV6rjf3dzy8jmcisjRS9B9hThxzv1LQu2adJBmnrQWmjw2wPS6sMULcyaWf256Cp4YK18T8zLNnGfER9MIJrziIfx4EblOfmXHCa2bjqYZrsWl1U2b3Clo3G6z3T17FkvHm5WyBmsb/2JwrFnMKBhhM7ItT68cpoAXv6DNvS6RAsyqKOrEJGXRlaFS3CUjgm7TPYwfFFJ5hjyyGbknJXv4/TiTnNFra5BEMDUBtHqhv7Efx3brxLnljKRqNvVHgaRdloRfWLZTDWN8QM5Uok5l8s4VyWgolStoaIz+fhqTpBgC4df1ORs1uX0noXsUWdF/Q2/4wn7lDbeyRO4u1t5g62HORDW1BEVqYSvnLHQbrkxexsUPT7kYAO8LIdlRAuW3d3NEE6aOmIGGv8UCQutSjtPDyocFl44LhuG8WXjW59xIc12LK67CWRs71UTiHunEwKVps5UKTcv33W4iLgx93SZQo8KkOWBOlBiuU44k9Q6SgbCYgwSuDtO34WjXIswqWCbSl7zdJ0JNWXbDAs41+rZqs+ZsyLHbAqiw+TfpQdkbo3+J+NgOTX9fQPu+pLkFSxhv/RudFl1pq2QhuDTwtCWIbzicPGFi5I8NbRohETbGuFw9pnqo0CWEyU9cSwP8JzI9v2LNa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(76116006)(91956017)(8676002)(4326008)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(38070700005)(6512007)(26005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(54906003)(122000001)(316002)(38100700002)(110136005)(2906002)(36756003)(30864003)(83380400001)(7416002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3r2xDnKLheRNUbs1h1HUmBCfB9XQbSrzVVrbSTnGCiZB7bR4l1t1IkonyfQ?=
 =?us-ascii?Q?yXQibyMDvZw5sQQANdXLEFdhKuIOisfdVOCU6AVI4fzaeCSorKtavniEjaoX?=
 =?us-ascii?Q?KQGJTjakTFHXimVjaptZJwjenPOLpGJ+iQOgTxDUzlo2EY2T4jOhKZ5cUK/L?=
 =?us-ascii?Q?IzaiWHtJmlRniEx/JPYK9MOfLoPEf9WrtyJQiIOLdNs8M9INzmMHDP5UErAm?=
 =?us-ascii?Q?hJrrBomzf2mLEM/vx/pXwKJbITOzTUZ/L/Pe3ja5d+Xc+cecUwQDCSgcOxOX?=
 =?us-ascii?Q?uVE+V0nv65eL2uCBT1xFYLitiPGyGYHiUMRfdWKIp/w7uu+It7mF8mG7n/Fk?=
 =?us-ascii?Q?ZoTtJbX8jNZFLbTA5cI9Tp2TOpuWFWVhG0MiyZCjU9TFxaLc7PzqJ8+jj6I1?=
 =?us-ascii?Q?256Yh38sOikq5deAdD5KomxEhYpGqO7nv9n3z8SxT3Qm8TbLvgANCtH5rejs?=
 =?us-ascii?Q?5ikM/toccBLSGcqI+pW+a83sKCDDM5/bZhjk3wbpCMmbeigBCsuGkQwuPHA8?=
 =?us-ascii?Q?cTZRkHG6d6C7yfnE5BlbPmOjAVMnvzmBx+/4yu8jGxA08sJZK6kfxQ/ZhAmW?=
 =?us-ascii?Q?1zNFI0QULsNWRY/8jpZQQRpsQNqjzViwSdFkPD2WrCqaEuCjFJj5+5l2Ks8o?=
 =?us-ascii?Q?TgFB7417NdWu/wLYf/pXY7PjMsBU/UIkTRVlkpyvtusPeanon4uAiuGT5oe8?=
 =?us-ascii?Q?e1yeEAn10u3I08DSa2OL2wPFmTm2lLemwSdYdVf/QGz/T0UuIlzT5PsvL8kI?=
 =?us-ascii?Q?UZ0G365Ywt8PpUeygeNp3eY1lfBXv+IPR588fdDLVeeZvMSPAqWibilFf+VR?=
 =?us-ascii?Q?xNu80TyQYmEgL24z3o/1/78SAgL+OyUFDywymaa8b7l4npVaCl8seWs2UMYD?=
 =?us-ascii?Q?AuYRNE1xbFZ0AOWGfaKrY99laaGMexzi1ZntgfNdaBkWn1sj0H1vm2KjUL4I?=
 =?us-ascii?Q?eGrgv3jWPMbNOiEJoXuEV2vng/mSUgzEz6LobWor2a/dE94SzOISQy8UGKB5?=
 =?us-ascii?Q?fvytt4CaD5yWA3cEl+ciKl6+rXfAFCuugmsMiARQWkM3n1m0SitNqeAIFp/k?=
 =?us-ascii?Q?nl0Dd4W75/9SQT46gpAAutgaSjJButQKlnICC3xpWFCRFBZ9VtQQFV5zar2D?=
 =?us-ascii?Q?3itEqKR5Crg03N2HprECt9C6LW+yLiNRMXB0R5ClYj6ILuohLtRnr8J5NAry?=
 =?us-ascii?Q?xqa2foq/CNkLD5AO5TL8fQhNh53N6qSVMz8EzkkfSGUqbb83as812pCRxvwt?=
 =?us-ascii?Q?kiSzhu8Si16h/nCMCp3YPM73qezuPHl58eFAlk7RwB/MA0jv7pHmxqu6oNHk?=
 =?us-ascii?Q?3OqFukWcpdk4l9DMrfc7a+LR+PBR9U1jpALHYL5b3IeKkgEPkAr68um669KC?=
 =?us-ascii?Q?Vtrae6b7GV5hHVxnIhBgJOgFGxpcFwiEZTH0rTqXJko3a3RMaEYtde76IJmx?=
 =?us-ascii?Q?5sOnI1T8YZPG8PktSZO6DEZmLuJ/rqBcarfaSINl9QGbldll79ttmFh+kiYN?=
 =?us-ascii?Q?TJQ96EjeLt0SjIT3bvJ7XuVpct8rA8lTQSTlg8esS7DjwT3l/ijIL+dxY1cd?=
 =?us-ascii?Q?Mp3sWQRg+zEKEgGGFEskxbu/Q4ejh0TOM3VO3EY3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C49A889B23A85A4DB8BA9BDB061594C0@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9a9a23-6152-4824-1ee6-08da60ca4d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:01.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHxj8B77a+DimGY2kdQjd9KiHb3LkHjTkEVcuK3g3KNUs/FWAM9E9L11nhwHGBOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: u7KijVxezWURKmdYnL36j37xjxOeBwfT
X-Proofpoint-ORIG-GUID: u7KijVxezWURKmdYnL36j37xjxOeBwfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for making the cpio functions generally available rather
than just at init make sure we're using versions of the filesystem
related functions that aren't in the __init section. Remove functions
only used by us from fs/init.c while folding into the cpio code
directly.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 fs/init.c                     | 101 ----------------------
 fs/internal.h                 |   4 -
 include/linux/fs.h            |   4 +
 include/linux/init_syscalls.h |   6 --
 lib/cpio.c                    | 156 +++++++++++++++++++++++++++++-----
 5 files changed, 139 insertions(+), 132 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..a946ad672dee 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -79,37 +79,6 @@ int __init init_chroot(const char *filename)
 	return error;
 }
 
-int __init init_chown(const char *filename, uid_t user, gid_t group, int flags)
-{
-	int lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
-	struct path path;
-	int error;
-
-	error = kern_path(filename, lookup_flags, &path);
-	if (error)
-		return error;
-	error = mnt_want_write(path.mnt);
-	if (!error) {
-		error = chown_common(&path, user, group);
-		mnt_drop_write(path.mnt);
-	}
-	path_put(&path);
-	return error;
-}
-
-int __init init_chmod(const char *filename, umode_t mode)
-{
-	struct path path;
-	int error;
-
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
-	if (error)
-		return error;
-	error = chmod_common(&path, mode);
-	path_put(&path);
-	return error;
-}
-
 int __init init_eaccess(const char *filename)
 {
 	struct path path;
@@ -163,58 +132,6 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	return error;
 }
 
-int __init init_link(const char *oldname, const char *newname)
-{
-	struct dentry *new_dentry;
-	struct path old_path, new_path;
-	struct user_namespace *mnt_userns;
-	int error;
-
-	error = kern_path(oldname, 0, &old_path);
-	if (error)
-		return error;
-
-	new_dentry = kern_path_create(AT_FDCWD, newname, &new_path, 0);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto out;
-
-	error = -EXDEV;
-	if (old_path.mnt != new_path.mnt)
-		goto out_dput;
-	mnt_userns = mnt_user_ns(new_path.mnt);
-	error = may_linkat(mnt_userns, &old_path);
-	if (unlikely(error))
-		goto out_dput;
-	error = security_path_link(old_path.dentry, &new_path, new_dentry);
-	if (error)
-		goto out_dput;
-	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
-			 new_dentry, NULL);
-out_dput:
-	done_path_create(&new_path, new_dentry);
-out:
-	path_put(&old_path);
-	return error;
-}
-
-int __init init_symlink(const char *oldname, const char *newname)
-{
-	struct dentry *dentry;
-	struct path path;
-	int error;
-
-	dentry = kern_path_create(AT_FDCWD, newname, &path, 0);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	error = security_path_symlink(&path, dentry, oldname);
-	if (!error)
-		error = vfs_symlink(mnt_user_ns(path.mnt), path.dentry->d_inode,
-				    dentry, oldname);
-	done_path_create(&path, dentry);
-	return error;
-}
-
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
@@ -239,24 +156,6 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	return error;
 }
 
-int __init init_rmdir(const char *pathname)
-{
-	return do_rmdir(AT_FDCWD, getname_kernel(pathname));
-}
-
-int __init init_utimes(char *filename, struct timespec64 *ts)
-{
-	struct path path;
-	int error;
-
-	error = kern_path(filename, 0, &path);
-	if (error)
-		return error;
-	error = vfs_utimes(&path, ts);
-	path_put(&path);
-	return error;
-}
-
 int __init init_dup(struct file *file)
 {
 	int fd;
diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..c57d5f0aa731 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -60,9 +60,6 @@ extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
-int do_rmdir(int dfd, struct filename *name);
-int do_unlinkat(int dfd, struct filename *name);
-int may_linkat(struct user_namespace *mnt_userns, struct path *link);
 int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 int do_mkdirat(int dfd, struct filename *name, umode_t mode);
@@ -132,7 +129,6 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
-int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..1cb51a54799b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2636,11 +2636,15 @@ static inline struct file *file_clone_open(struct file *file)
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
 }
 extern int filp_close(struct file *, fl_owner_t id);
+extern int chown_common(const struct path *path, uid_t user, gid_t group);
 
+extern int do_rmdir(int dfd, struct filename *name);
+extern int do_unlinkat(int dfd, struct filename *name);
 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname_uflags(const char __user *, int);
 extern struct filename *getname(const char __user *);
 extern struct filename *getname_kernel(const char *);
+extern int may_linkat(struct user_namespace *mnt_userns, struct path *link);
 extern void putname(struct filename *name);
 
 extern int finish_open(struct file *file, struct dentry *dentry,
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 92045d18cbfc..196030cd958d 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -5,15 +5,9 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
-int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
-int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
 int __init init_stat(const char *filename, struct kstat *stat, int flags);
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
-int __init init_link(const char *oldname, const char *newname);
-int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
 int __init init_mkdir(const char *pathname, umode_t mode);
-int __init init_rmdir(const char *pathname);
-int __init init_utimes(char *filename, struct timespec64 *ts);
 int __init init_dup(struct file *file);
diff --git a/lib/cpio.c b/lib/cpio.c
index 5d150939704f..6ae443a1c103 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -3,8 +3,9 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/init_syscalls.h>
 #include <linux/list.h>
+#include <linux/namei.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 
 static ssize_t __init xwrite(struct cpio_context *ctx, struct file *file,
@@ -92,18 +93,25 @@ static void __init free_hash(struct cpio_context *ctx)
 }
 
 #ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
-static void __init do_utime(char *filename, time64_t mtime)
+static void __init do_utime_path(const struct path *path, time64_t mtime)
 {
 	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
 
-	init_utimes(filename, t);
+	vfs_utimes(path, t);
 }
 
-static void __init do_utime_path(const struct path *path, time64_t mtime)
+static int __init do_utime(char *filename, time64_t mtime)
 {
-	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+	struct path path;
+	int error;
 
-	vfs_utimes(path, t);
+	error = kern_path(filename, 0, &path);
+	if (error)
+		return error;
+	do_utime_path(&path, mtime);
+	path_put(&path);
+
+	return error;
 }
 
 static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime)
@@ -133,12 +141,31 @@ static void __init dir_utime(struct cpio_context *ctx)
 	}
 }
 #else
-static void __init do_utime(char *filename, time64_t mtime) {}
+static int __init do_utime(char *filename, time64_t mtime) { return 0; }
 static void __init do_utime_path(const struct path *path, time64_t mtime) {}
 static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime) { return 0; }
 static void __init dir_utime(struct cpio_context *ctx) {}
 #endif
 
+static int __init cpio_chown(const char *filename, uid_t user, gid_t group,
+			     int flags)
+{
+	int lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	struct path path;
+	int error;
+
+	error = kern_path(filename, lookup_flags, &path);
+	if (error)
+		return error;
+	error = mnt_want_write(path.mnt);
+	if (!error) {
+		error = chown_common(&path, user, group);
+		mnt_drop_write(path.mnt);
+	}
+	path_put(&path);
+	return error;
+}
+
 /* cpio header parsing */
 
 static void __init parse_header(struct cpio_context *ctx, char *s)
@@ -269,27 +296,67 @@ static int __init do_reset(struct cpio_context *ctx)
 	return 1;
 }
 
-static void __init clean_path(char *path, umode_t fmode)
+static void __init clean_path(char *pathname, umode_t fmode)
 {
+	struct path path;
 	struct kstat st;
+	int error;
 
-	if (!init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
-	    (st.mode ^ fmode) & S_IFMT) {
+	error = kern_path(pathname, 0, &path);
+	if (error)
+		return;
+	error = vfs_getattr(&path, &st, STATX_BASIC_STATS, AT_NO_AUTOMOUNT);
+	path_put(&path);
+	if (error)
+		return;
+
+	if ((st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
-			init_rmdir(path);
+			do_rmdir(AT_FDCWD, getname_kernel(pathname));
 		else
-			init_unlink(path);
+			do_unlinkat(AT_FDCWD, getname_kernel(pathname));
 	}
 }
 
 static int __init maybe_link(struct cpio_context *ctx)
 {
+	struct dentry *new_dentry;
+	struct path old_path, new_path;
+	struct user_namespace *mnt_userns;
+	int error;
+
 	if (ctx->nlink >= 2) {
 		char *old = find_link(ctx, ctx->major, ctx->minor, ctx->ino,
 				ctx->mode, ctx->collected);
 		if (old) {
 			clean_path(ctx->collected, 0);
-			return (init_link(old, ctx->collected) < 0) ? -1 : 1;
+
+			error = kern_path(old, 0, &old_path);
+			if (error)
+				return error;
+
+			new_dentry = kern_path_create(AT_FDCWD, ctx->collected, &new_path, 0);
+			error = PTR_ERR(new_dentry);
+			if (IS_ERR(new_dentry))
+				goto out;
+
+			error = -EXDEV;
+			if (old_path.mnt != new_path.mnt)
+				goto out_dput;
+			mnt_userns = mnt_user_ns(new_path.mnt);
+			error = may_linkat(mnt_userns, &old_path);
+			if (unlikely(error))
+				goto out_dput;
+			error = security_path_link(old_path.dentry, &new_path, new_dentry);
+			if (error)
+				goto out_dput;
+			error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+					 new_dentry, NULL);
+out_dput:
+			done_path_create(&new_path, new_dentry);
+out:
+			path_put(&old_path);
+			return (error < 0) ? error : 1;
 		}
 	}
 	return 0;
@@ -297,6 +364,10 @@ static int __init maybe_link(struct cpio_context *ctx)
 
 static int __init do_name(struct cpio_context *ctx)
 {
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
 	ctx->state = CPIO_SKIPIT;
 	ctx->next_state = CPIO_RESET;
 	if (strcmp(ctx->collected, "TRAILER!!!") == 0) {
@@ -325,16 +396,42 @@ static int __init do_name(struct cpio_context *ctx)
 			ctx->state = CPIO_COPYFILE;
 		}
 	} else if (S_ISDIR(ctx->mode)) {
-		init_mkdir(ctx->collected, ctx->mode);
-		init_chown(ctx->collected, ctx->uid, ctx->gid, 0);
-		init_chmod(ctx->collected, ctx->mode);
+		dentry = kern_path_create(AT_FDCWD, ctx->collected, &path, LOOKUP_DIRECTORY);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+		error = security_path_mkdir(&path, dentry, ctx->mode);
+		if (!error)
+			error = vfs_mkdir(mnt_user_ns(path.mnt), path.dentry->d_inode,
+					  dentry, ctx->mode);
+		done_path_create(&path, dentry);
+		if (error)
+			return error;
+
+		cpio_chown(ctx->collected, ctx->uid, ctx->gid, 0);
 		dir_add(ctx, ctx->collected, ctx->mtime);
 	} else if (S_ISBLK(ctx->mode) || S_ISCHR(ctx->mode) ||
 		   S_ISFIFO(ctx->mode) || S_ISSOCK(ctx->mode)) {
 		if (maybe_link(ctx) == 0) {
-			init_mknod(ctx->collected, ctx->mode, ctx->rdev);
-			init_chown(ctx->collected, ctx->uid, ctx->gid, 0);
-			init_chmod(ctx->collected, ctx->mode);
+			if (S_ISFIFO(ctx->mode) || S_ISSOCK(ctx->mode))
+				ctx->rdev = 0;
+
+			dentry = kern_path_create(AT_FDCWD, ctx->collected, &path, 0);
+			if (IS_ERR(dentry))
+				return PTR_ERR(dentry);
+
+			error = security_path_mknod(&path, dentry, ctx->mode,
+						    ctx->rdev);
+			if (!error)
+				error = vfs_mknod(mnt_user_ns(path.mnt),
+						  path.dentry->d_inode,
+						  dentry, ctx->mode,
+						  new_decode_dev(ctx->rdev));
+			done_path_create(&path, dentry);
+
+			if (error)
+				return error;
+
+			cpio_chown(ctx->collected, ctx->uid, ctx->gid, 0);
 			do_utime(ctx->collected, ctx->mtime);
 		}
 	}
@@ -373,10 +470,27 @@ static int __init do_copy(struct cpio_context *ctx)
 
 static int __init do_symlink(struct cpio_context *ctx)
 {
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
 	ctx->collected[N_ALIGN(ctx->name_len) + ctx->body_len] = '\0';
 	clean_path(ctx->collected, 0);
-	init_symlink(ctx->collected + N_ALIGN(ctx->name_len), ctx->collected);
-	init_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
+
+	dentry = kern_path_create(AT_FDCWD, ctx->collected, &path, 0);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	error = security_path_symlink(&path, dentry,
+				      ctx->collected + N_ALIGN(ctx->name_len));
+	if (!error)
+		error = vfs_symlink(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				    dentry,
+				    ctx->collected + N_ALIGN(ctx->name_len));
+	done_path_create(&path, dentry);
+	if (error)
+		return error;
+
+	cpio_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(ctx->collected, ctx->mtime);
 	ctx->state = CPIO_SKIPIT;
 	ctx->next_state = CPIO_RESET;
-- 
2.36.1
