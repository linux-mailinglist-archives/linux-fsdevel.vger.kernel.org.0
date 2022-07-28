Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128E55840A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiG1OKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiG1OJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F95F13C;
        Thu, 28 Jul 2022 07:09:27 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD9eEh012416;
        Thu, 28 Jul 2022 07:09:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=LEJpDPX/NKMZyfnFH7rB9Ov/WvBAflqmzyE4kZeGnbA=;
 b=h7w3bpUIdhpC1MrI8L4amecfwzwwL7bzkgvMz86M1ChmRBjvef5+o10z1SNGxwAgO2ZZ
 KdrV/P0xy7p1y4/YnR7BRGjKp40Tfaf5IYJmiYrMH2ZI9vD4ydfAkthEZKXVKnQHI7Gs
 4Xzjni0iPWqEU2U9fwmFDQtxVPSrdNYi4Uc= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0ps39h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMh15I2ARfcVSvtIzWFK+6Bo1FyG9NACDA377KpCrqIX4pcj+SYhCOP86p9ZqaBAU0cU9Lw3jF1VhpdxJuaHQMBLdOXUs+SHF2Ljf/jDBHokE10XVdPVewnX5+7QZm6aQzAvgwcKWcWgRNnzUWSlziIUCpNILsC8WlKd4IFshc8tVv9mZymcyhY9il9kykp4E70hkreBQypq+XhE74QUHeklELjyBVCdG6A2mbGFwq8oqVJEEUQzGzYbW02kjp0vB5uAZ+2Rdr5kuBE4UtvGeXMgjvZyrKykuxgnYfrWZhb+zUilNJ9F9MwkrI04DFUhPvJaadx3vlA7Bz7boD2V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEJpDPX/NKMZyfnFH7rB9Ov/WvBAflqmzyE4kZeGnbA=;
 b=PXJHcFKEwg/kl4i55bPMb8rJxbRIb72CV/Op0rpJpVjWXaZk/Gg+0PXcdX/v/mFCtKzuZmm6oNTF8GnonVsGYwDzYw0hFwMQZLAoDAYxr2oIISKKxxYYA5SpMDTcbsN73ZZ4z8YUN1Uqhe1aUZJ4715qlVMHAoUqtCkKGfch8Md/nozSvhtzWchLtiAR7ndRiUU72+UstJxLqr6+YvnksRaYetmkxhaehYD4NA3Zz9mWv0ehCSptZaHrRbA8uuHPcITEZiwc0LmEqSk1yXZ1+V1vB7IlXjhBs2gorHCQK3xxfFoaLHZWdSN/f3ech/cEuIyEHX9eCgWh8c2ne8n76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:22 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:22 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH v2 3/7] lib/cpio: use non __init filesystem related
 functions
Thread-Topic: [RFC PATCH v2 3/7] lib/cpio: use non __init filesystem related
 functions
Thread-Index: AQHYoouisaJ4GxUn7UeGeqD/Ofxiug==
Date:   Thu, 28 Jul 2022 14:09:22 +0000
Message-ID: <7ad4218faaf60b632329c86b819b4615b6c6f121.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c73fb1d-f512-4ccb-6375-08da70a2c52e
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3jc76xrcFrCxrpsEG0XtdIaHJH8c6e9RZfxhIHeWNLUMDftZcKWzIa8SSiaM1XZw3mdXNR991bEr7o0bbsNBkq8we862dxwRF3i6HXqz/2sTcsdWN8IkgSM0JjYtTN70DilCDcDOQR6jehskkaW+EQHrJTcYQhesGR18zhlM04Q5vTbU+DSFk4v+GOluJsjUh0b3L8ZSswUOvbYEYQLwHeBHcd+enpNeOBHSzwWo0/ZXKuZSH3d33tzZFcjHGpjwc6G9GhJQMbTZLKU9ksd/bpyEW3YTTzUIvZTOIakpl2rDhROcEdWTyV4nYEQE7SDh32lOnlD5a17vg3MxhrG41NSiAklentOSok56yWdEQ0YPVf6SnpSQT8Uus1KZCTHyo5itemQr53rNEIxJ1zYkJ57Nj+PAflaQWGaGdbsUNSzlaXN/WAZmsWt3eLMScQ0BqxKa7TDd/OqxXlahzjMyH1MXf4e5H/JSKtIjDQOHoJ9gb2NrH8pELL9r8Y225w8wSGD2ZamUbM2YniNdD8t7Fua6oisdSv1fJhPH1lKAr+cY1NqWkVsJYHx0AvLLGVpw2AWBJBz2T1uzDi+w3ykd74cLHMf/vYhba5t3P2GOPqehuCoimrmapjRcUs+yNMw/LLUDZTZnfbXa+7TP9gM8M8eSzumRBvp02lYyl7yPwmGOzskp3hkedk+fp+c8aESmKFCdPj20udzl5cPa3Rx0warnrSdcvGvDnTjhh/3iof6bkIr8BB6034MGaXTXhC1/Xdn+s4xccChUZLaABrvfI2yOuSSw/QyZj6UJh+p1G6BJ3GYxgGtqd6URbJ4gMVY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(30864003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sphL66o7Ulu245zqpYbei+GG7Bx7D3VHiwl0FBvKs4qDM5P0epiPMTNVjnag?=
 =?us-ascii?Q?+1ObL9iYF+Vc4u5ql3ehH0sTHXYk29cA+YGOxv3kDsUz/qJ2wjN5w9w9j904?=
 =?us-ascii?Q?1S98b7qOWqctolbdiSrrRKmUATQwLUUKpnh1hQ5B6kRdNypXADYJIXP0b9fH?=
 =?us-ascii?Q?rjcBbY+QvidxF8ODaPqj4U5ve//4hoLzg1hEpu9FTOuvBegIexpbCuvD6hrj?=
 =?us-ascii?Q?9aUZsrJcxDc9MZFwRUhWZqrCq8DTevrvqyqppGc1z0tkvdqPajZ2Efl4pExv?=
 =?us-ascii?Q?icQnzX4zP9hxE9XsdmzlVG1MSoX3KFv09qzlCIu9sz4h8eBUwjB6L/DZQK5w?=
 =?us-ascii?Q?+f2m3rm4Cd8FdRxEdzDzzo4MLRHQcn7PWWYKuSljc1AmuVTk+xxQByErAjf8?=
 =?us-ascii?Q?7QeuaHEoiXafoRNcY5KrdIymFjPyBtOdxru7VOaC5haZpExfcC1DdyALE0pp?=
 =?us-ascii?Q?/Do8YMDcr8XidIJotKpa6ISP1ZekCnkUFn7SvkeaZd/1WqaGmmMr1y9deN00?=
 =?us-ascii?Q?OHoKLCY4auK+hleEDvfxnlD/V1P/fN5wOjiugS9Qb2pjfMtjb/p5CAZF2voM?=
 =?us-ascii?Q?GK0vvP1PqHaO9y5/e4WnfTgC7uA+eY+1JwDv1FIYp2GPEg4Zb5SxkRdcTine?=
 =?us-ascii?Q?7r+/0VMXXrrYTnWqsX9smYK25S/v6F6zx3BxkUtlBv9uEaY44saPLJCrgk/M?=
 =?us-ascii?Q?U1QwuEXpBE6W6ps5nwtZnoFhBWDt9Dwvhvz41pkHCeHMgrEj7jWFN5jCnThk?=
 =?us-ascii?Q?S9IWgsOtW8tmmyKwjpwsVFYLFhAF2HLqub/THnyI+MgEo1QL/o19XVKUhpdR?=
 =?us-ascii?Q?rndegp68DzM5IR8WqnXvOFtJngx7bVJ75llhCImP3E7DhVGwF5u2sLsrOzYO?=
 =?us-ascii?Q?P7zer5uNJcTTEQdk3lgwsMcWJqW1BbtIEd//pJKFx9xTqHWfIVRunOHauGsr?=
 =?us-ascii?Q?21CbEIiNs4wiRXCykdE/F+cDevZHJGsR99WhlIKv06MYk/my5ntOt60WesZA?=
 =?us-ascii?Q?kK4HG8Io875az41S83/vXB0WCgJlecCMSGaKpNjjkrpdnKmw1MQbtqQGfdl0?=
 =?us-ascii?Q?/bc30iUd+B5z3R4Zr/bvsGv4EdN8P7CHle/UO7EFOlvHYn7mJrsXFxHAvY3J?=
 =?us-ascii?Q?cOHPLQjNeKz/JiFmKJEiXEkNaP0c0fHDO8vDqlGiT2YcJMQ0znS5+z3fLHcm?=
 =?us-ascii?Q?ngOCryPmSW2FTh/Fdo02bbrC/7Y6KsfVbgon3A96162PWcRD4y80nq9eZVYn?=
 =?us-ascii?Q?UAAGMPTucBtIik6/kvQKimZM+mKbbsFN9piPup4aB+XP7qCUxG885Il2Edyo?=
 =?us-ascii?Q?v9RJj9XPngfGJcDQMGYlxvz34C9v0jTwXUoLXpNIlX0yGc23rVKca0B1Qn4y?=
 =?us-ascii?Q?8bDe1+zOdd4L/s41kbjhZ3PwAw6ShUCMzGrIKdA8fmN8rV25uk663dOrv6z5?=
 =?us-ascii?Q?UpGVh0cie6FppRwqK9Ha2ALmU070TAtan9D8ikklacfEVvhg+e/2JZQNyhbB?=
 =?us-ascii?Q?GDdx0jtJ4yWU+OrZQQTOsV6qR5S2Fv/4vbYIfnf8FIV6u0zMVn5GAR8zU4oL?=
 =?us-ascii?Q?zWVDoMtd8PmnnuC3Ys2hzfjO88slAkxAj9cI4KVZ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <031C80F7C7EC8447BD5DE89D4840F3A7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c73fb1d-f512-4ccb-6375-08da70a2c52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:22.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwrmjewM7Fe9Q8QvPMOPnzuzKzc8yfs4Fb6+NCd9mPWgkvZd8ocamporaEHNm2Py
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: r4DCnt7PYt8RzXR1ejLAma---IDrzdq9
X-Proofpoint-ORIG-GUID: r4DCnt7PYt8RzXR1ejLAma---IDrzdq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2:
- Fold in directory EEXIST checking from patch 4
- Add EEXIST checking for device nodes (kernel test reboot boot test)
---
 fs/init.c                     | 101 ---------------------
 fs/internal.h                 |   4 -
 include/linux/fs.h            |   4 +
 include/linux/init_syscalls.h |   6 --
 lib/cpio.c                    | 162 +++++++++++++++++++++++++++++-----
 5 files changed, 145 insertions(+), 132 deletions(-)

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
index 5d150939704f..9a0120c638db 100644
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
@@ -325,16 +396,48 @@ static int __init do_name(struct cpio_context *ctx)
 			ctx->state = CPIO_COPYFILE;
 		}
 	} else if (S_ISDIR(ctx->mode)) {
-		init_mkdir(ctx->collected, ctx->mode);
-		init_chown(ctx->collected, ctx->uid, ctx->gid, 0);
-		init_chmod(ctx->collected, ctx->mode);
+		dentry = kern_path_create(AT_FDCWD, ctx->collected, &path, LOOKUP_DIRECTORY);
+
+		if (!IS_ERR(dentry)) {
+			error = security_path_mkdir(&path, dentry, ctx->mode);
+			if (!error)
+				error = vfs_mkdir(mnt_user_ns(path.mnt),
+						  path.dentry->d_inode,
+						  dentry, ctx->mode);
+			done_path_create(&path, dentry);
+		} else {
+			error = PTR_ERR(dentry);
+		}
+
+		if (error && error != -EEXIST)
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
+			if (!IS_ERR(dentry)) {
+				error = security_path_mknod(&path, dentry, ctx->mode,
+							    ctx->rdev);
+				if (!error)
+					error = vfs_mknod(mnt_user_ns(path.mnt),
+							  path.dentry->d_inode,
+							  dentry, ctx->mode,
+							  new_decode_dev(ctx->rdev));
+				done_path_create(&path, dentry);
+			} else {
+				error = PTR_ERR(dentry);
+			}
+
+			if (error && error != -EEXIST)
+				return error;
+
+			cpio_chown(ctx->collected, ctx->uid, ctx->gid, 0);
 			do_utime(ctx->collected, ctx->mtime);
 		}
 	}
@@ -373,10 +476,27 @@ static int __init do_copy(struct cpio_context *ctx)
 
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
2.30.2
