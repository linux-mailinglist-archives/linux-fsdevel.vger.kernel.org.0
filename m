Return-Path: <linux-fsdevel+bounces-55610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C4B0C883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656DF3B3BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC02E0408;
	Mon, 21 Jul 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="tGaWKZUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE902DFF04
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114963; cv=none; b=NwUlKOggmcZWeAA9/MEmqBBZDH6aEjJIU41ubpbNTQYoNoiqNsICtIk8ziam6ofgHH31G1jIfzsqtO5OKZIKorxNuDbckOfo0drFH6GqzuliymwuBI0aSv5S3Jj9lPn2UgJRBm/JtocgQ8tJJF4mGtlCdQOP5ugS2lIfmDM32W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114963; c=relaxed/simple;
	bh=ZpEXWfdqowslmoI4WT9IFXIxZDdpf7UpcNVqaEA/5SM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SGYZ+n2TxvY84NyALmaro6hGbNwtejPzDdO0pZrteCTpCEfqkBx/rNX48xJ7v/zAvV8yeQYWWNTY44+eCqa7cVcWrs/F9hfLPjXklxQr+veNsy15CL1Fi01wRFX/np2hKUB8xJE+WjzihtwkzEAqgxHqP9U4cw9v5KSfu73PlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=tGaWKZUq; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=20865; t=1753114532;
	x=1753719332; i=jaltman@auristor.com; q=dns/txt; h=Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; z=Received:=
	20from=20smtpclient.apple=20([146.70.166.254])=20by=20auristor.c
	om=20(208.125.0.237)=20(MDaemon=20PRO=20v25.5.0b)=20=0D=0A=09wit
	h=20ESMTPSA=20id=20md5001004854015.msg=3B=20Mon,=2021=20Jul=2020
	25=2012=3A15=3A30=20-0400|Content-Type:=20multipart/signed=3B=0D
	=0A=09boundary=3D"Apple-Mail=3D_E92E1DC6-D9C2-4C3F-BA21-8F84E080
	A0C3"=3B=0D=0A=09protocol=3D"application/pkcs7-signature"=3B=0D=
	0A=09micalg=3Dsha-256|Mime-Version:=201.0=20(Mac=20OS=20X=20Mail
	=2016.0=20\(3826.700.71\))|Subject:=20Re=3A=20[PATCH=202/2]=20vf
	s=3A=20Fix=20inode=20ownership=20checks=20with=20regard=20to=0D=
	0A=20foreign=20ownership|From:=20Jeffrey=20Altman=20<jaltman@aur
	istor.com>|In-Reply-To:=20<e7b6c8c4-0d73-4845-a1d9-8baccdb2c891@
	auristor.com>|Date:=20Mon,=2021=20Jul=202025=2012=3A15=3A34=20-0
	400|Cc:=20Marc=20Dionne=20<marc.dionne@auristor.com>,=0D=0A=20li
	nux-afs@lists.infradead.org,=0D=0A=20linux-fsdevel@vger.kernel.o
	rg,=0D=0A=20linux-kernel@vger.kernel.org,=0D=0A=20Etienne=20Cham
	petier=20<champetier.etienne@gmail.com>,=0D=0A=20Chet=20Ramey=20
	<chet.ramey@case.edu>,=0D=0A=20Cheyenne=20Wills=20<cwills@sineno
	mine.net>,=0D=0A=20Alexander=20Viro=20<viro@zeniv.linux.org.uk>,
	=0D=0A=20Christian=20Brauner=20<brauner@kernel.org>,=0D=0A=20Ste
	ve=20French=20<sfrench@samba.org>,=0D=0A=20Mimi=20Zohar=20<zohar
	@linux.ibm.com>,=0D=0A=20openafs-devel=20<openafs-devel@openafs.
	org>,=0D=0A=20linux-cifs@vger.kernel.org,=0D=0A=20linux-integrit
	y@vger.kernel.org|Content-Transfer-Encoding:=20quoted-printable|
	Message-Id:=20<6C16280D-1627-423B-9421-A5BF3FB653BD@auristor.com
	>|References:=20<20250519161125.2981681-1-dhowells@redhat.com>=0
	D=0A=20<20250519161125.2981681-3-dhowells@redhat.com>=0D=0A=20<e
	7b6c8c4-0d73-4845-a1d9-8baccdb2c891@auristor.com>|To:=20David=20
	Howells=20<dhowells@redhat.com>,=0D=0A=20Christian=20Brauner=20<
	christian@brauner.io>; bh=F5AZsQfcr6mmtvAKkEmaYQeWXrl/O7Lum3Iq+y
	a+PBI=; b=tGaWKZUqniLYp8mo8LcqX2qzAUfsHe53CJgNtSef3qBu2DoktXgc8C
	J46i5XsowOPUsOnhqAk5OUpwChTKOZZDGOuUN0wKCvb3rVNbs7KRT6Nh1uIz6de0
	BIH+RVHoqXSxUPRhn85JiuT1q47ATyMgpbUwgocZ/o3pSjCt1jAbM=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Mon, 21 Jul 2025 12:15:32 -0400
Received: from smtpclient.apple ([146.70.166.254]) by auristor.com (208.125.0.237) (MDaemon PRO v25.5.0b) 
	with ESMTPSA id md5001004854015.msg; Mon, 21 Jul 2025 12:15:30 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Mon, 21 Jul 2025 12:15:30 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 146.70.166.254
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Mon, 21 Jul 2025 12:15:30 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1297b80b54=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E92E1DC6-D9C2-4C3F-BA21-8F84E080A0C3";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.71\))
Subject: Re: [PATCH 2/2] vfs: Fix inode ownership checks with regard to
 foreign ownership
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <e7b6c8c4-0d73-4845-a1d9-8baccdb2c891@auristor.com>
Date: Mon, 21 Jul 2025 12:15:34 -0400
Cc: Marc Dionne <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Chet Ramey <chet.ramey@case.edu>,
 Cheyenne Wills <cwills@sinenomine.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Steve French <sfrench@samba.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 openafs-devel <openafs-devel@openafs.org>,
 linux-cifs@vger.kernel.org,
 linux-integrity@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C16280D-1627-423B-9421-A5BF3FB653BD@auristor.com>
References: <20250519161125.2981681-1-dhowells@redhat.com>
 <20250519161125.2981681-3-dhowells@redhat.com>
 <e7b6c8c4-0d73-4845-a1d9-8baccdb2c891@auristor.com>
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
X-Mailer: Apple Mail (2.3826.700.71)
X-MDCFSigsAdded: auristor.com


--Apple-Mail=_E92E1DC6-D9C2-4C3F-BA21-8F84E080A0C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 29, 2025, at 9:03=E2=80=AFPM, Jeffrey E Altman =
<jaltman@auristor.com> wrote:
>=20
> On 5/19/2025 12:11 PM, David Howells wrote:
>=20
>> Fix a number of ownership checks made by the VFS that assume that
>> inode->i_uid is meaningful with respect to the UID space of the =
system
>> performing the check.  Network filesystems, however, may violate this
>> assumption - and, indeed, a network filesystem may not even have an =
actual
>> concept of a UNIX integer UID (cifs, for example).
>>=20
>> There are a number of places within the VFS where UID checks are made =
and
>> some of these should be deferring the interpretation to the =
filesystem by
>> way of the previously added vfs_inode_is_owned_by_me() and
>> vfs_inodes_have_same_owner():
>>=20
>>  (*) chown_ok()
>>  (*) chgrp_ok()
>>=20
>>      These should call vfs_inode_is_owned_by_me().  Possibly these =
need to
>>      defer all their checks to the network filesystem as the =
interpretation
>>      of the new UID/GID depends on the netfs too, but the ->setattr()
>>      method gets a chance to deal with that.
>>=20
>>  (*) do_coredump()
>>=20
>>      Should probably call vfs_is_owned_by_me() to check that the file
>>      created is owned by the caller - but the check that's there =
might be
>>      sufficient.
>>=20
>>  (*) inode_owner_or_capable()
>>=20
>>      Should call vfs_is_owned_by_me().  I'm not sure whether the =
namespace
>>      mapping makes sense in such a case, but it probably could be =
used.
>>=20
>>  (*) vfs_setlease()
>>=20
>>      Should call vfs_is_owned_by_me().  Actually, it should query if
>>      leasing is permitted.
>>=20
>>      Also, setting locks could perhaps do with a permission call to =
the
>>      filesystem driver as AFS, for example, has a lock permission bit =
in
>>      the ACL, but since the AFS server checks that when the RPC call =
is
>>      made, it's probably unnecessary.
>>=20
>>  (*) acl_permission_check()
>>  (*) posix_acl_permission()
>>=20
>>      These functions are only used by generic_permission() which is
>>      overridden if ->permission() is supplied, and when evaluating a =
POSIX
>>      ACL, it should arguably be checking the UID anyway.
>>=20
>>      AFS, for example, implements its own ACLs and evaluates them in
>>      ->permission() and on the server.
>>=20
>>  (*) may_follow_link()
>>=20
>>      Should call vfs_is_owned_by_me() and also vfs_have_same_owner() =
on the
>>      the link and its parent dir.  The latter only applies on
>>      world-writable sticky dirs.
>>=20
>>  (*) may_create_in_sticky()
>>=20
>>      The initial subject of this patch.  Should call =
vfs_is_owned_by_me()
>>      and also vfs_have_same_owner() both.
>>=20
>>  (*) __check_sticky()
>>=20
>>      Should call vfs_is_owned_by_me() on both the dir and the inode.
>>=20
>>  (*) may_dedupe_file()
>>=20
>>      Should call vfs_is_owned_by_me().
>>=20
>>  (*) IMA policy ops.
>>=20
>>      I'm not sure what the best way to deal with this is - if, =
indeed, it
>>      needs any changes.
>>=20
>> Note that wrapping stuff up into vfs_inode_is_owned_by_me() isn't
>> necessarily the most efficient as it means we may end up doing the =
uid
>> idmapping an extra time - though mostly this is in places where I'm =
not
>> sure it matters so much.
>>=20
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Etienne Champetier <champetier.etienne@gmail.com>
>> cc: Marc Dionne <marc.dionne@auristor.com>
>> cc: Jeffrey Altman <jaltman@auristor.com>
>> cc: Chet Ramey <chet.ramey@case.edu>
>> cc: Cheyenne Wills <cwills@sinenomine.net>
>> cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> cc: Christian Brauner <brauner@kernel.org>
>> cc: Steve French <sfrench@samba.org>
>> cc: Mimi Zohar <zohar@linux.ibm.com>
>> cc: linux-afs@lists.infradead.org
>> cc: openafs-devel@openafs.org
>> cc: linux-cifs@vger.kernel.org
>> cc: linux-fsdevel@vger.kernel.org
>> cc: linux-integrity@vger.kernel.org
>> Link: =
https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ
>> Link: =
https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=3Dbash-5.3-rc1#n=
733
>> ---
>>  fs/attr.c        | 58 =
+++++++++++++++++++++++++++++-------------------
>>  fs/coredump.c    |  3 +--
>>  fs/inode.c       |  8 +++++--
>>  fs/locks.c       |  7 ++++--
>>  fs/namei.c       | 30 +++++++++++++------------
>>  fs/remap_range.c | 20 +++++++++--------
>>  6 files changed, 74 insertions(+), 52 deletions(-)
>>=20
>> diff --git a/fs/attr.c b/fs/attr.c
>> index 9caf63d20d03..fefd92af56a2 100644
>> --- a/fs/attr.c
>> +++ b/fs/attr.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/fcntl.h>
>>  #include <linux/filelock.h>
>>  #include <linux/security.h>
>> +#include "internal.h"
>>    /**
>>   * setattr_should_drop_sgid - determine whether the setgid bit needs =
to be
>> @@ -91,19 +92,21 @@ EXPORT_SYMBOL(setattr_should_drop_suidgid);
>>   * permissions. On non-idmapped mounts or if permission checking is =
to be
>>   * performed on the raw inode simply pass @nop_mnt_idmap.
>>   */
>> -static bool chown_ok(struct mnt_idmap *idmap,
>> -     const struct inode *inode, vfsuid_t ia_vfsuid)
>> +static int chown_ok(struct mnt_idmap *idmap,
>> +    const struct inode *inode, vfsuid_t ia_vfsuid)
>>  {
>>   vfsuid_t vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>> - if (vfsuid_eq_kuid(vfsuid, current_fsuid()) &&
>> -    vfsuid_eq(ia_vfsuid, vfsuid))
>> - return true;
>> + int ret;
>> +
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret <=3D 0)
>> + return ret;
>>   if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
>> - return true;
>> + return 0;
>>   if (!vfsuid_valid(vfsuid) &&
>>      ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
>> - return true;
>> - return false;
>> + return 0;
>> + return -EPERM;
>>  }
>>    /**
>> @@ -118,23 +121,27 @@ static bool chown_ok(struct mnt_idmap *idmap,
>>   * permissions. On non-idmapped mounts or if permission checking is =
to be
>>   * performed on the raw inode simply pass @nop_mnt_idmap.
>>   */
>> -static bool chgrp_ok(struct mnt_idmap *idmap,
>> -     const struct inode *inode, vfsgid_t ia_vfsgid)
>> +static int chgrp_ok(struct mnt_idmap *idmap,
>> +    const struct inode *inode, vfsgid_t ia_vfsgid)
>>  {
>>   vfsgid_t vfsgid =3D i_gid_into_vfsgid(idmap, inode);
>> - vfsuid_t vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>> - if (vfsuid_eq_kuid(vfsuid, current_fsuid())) {
>> + int ret;
>> +
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret < 0)
>> + return ret;
>> + if (ret =3D=3D 0) {
>>   if (vfsgid_eq(ia_vfsgid, vfsgid))
>> - return true;
>> + return 0;
>>   if (vfsgid_in_group_p(ia_vfsgid))
>> - return true;
>> + return 0;
>>   }
>>   if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
>> - return true;
>> + return 0;
>>   if (!vfsgid_valid(vfsgid) &&
>>      ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
>> - return true;
>> - return false;
>> + return 0;
>> + return -EPERM;
>>  }
>>    /**
>> @@ -163,6 +170,7 @@ int setattr_prepare(struct mnt_idmap *idmap, =
struct dentry *dentry,
>>  {
>>   struct inode *inode =3D d_inode(dentry);
>>   unsigned int ia_valid =3D attr->ia_valid;
>> + int ret;
>>     /*
>>   * First check size constraints.  These can't be overriden using
>> @@ -179,14 +187,18 @@ int setattr_prepare(struct mnt_idmap *idmap, =
struct dentry *dentry,
>>   goto kill_priv;
>>     /* Make sure a caller can chown. */
>> - if ((ia_valid & ATTR_UID) &&
>> -    !chown_ok(idmap, inode, attr->ia_vfsuid))
>> - return -EPERM;
>> + if (ia_valid & ATTR_UID) {
>> + ret =3D chown_ok(idmap, inode, attr->ia_vfsuid);
>> + if (ret < 0)
>> + return ret;
>> + }
>>     /* Make sure caller can chgrp. */
>> - if ((ia_valid & ATTR_GID) &&
>> -    !chgrp_ok(idmap, inode, attr->ia_vfsgid))
>> - return -EPERM;
>> + if (ia_valid & ATTR_GID) {
>> + ret =3D chgrp_ok(idmap, inode, attr->ia_vfsgid);
>> + if (ret < 0)
>> + return ret;
>> + }
>>     /* Make sure a caller can chmod. */
>>   if (ia_valid & ATTR_MODE) {
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index c33c177a701b..ded3936b2067 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -720,8 +720,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>   * filesystem.
>>   */
>>   idmap =3D file_mnt_idmap(cprm.file);
>> - if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
>> -    current_fsuid())) {
>> + if (vfs_inode_is_owned_by_me(idmap, inode) !=3D 0) {
>>   coredump_report_failure("Core dump to %s aborted: "
>>   "cannot preserve file owner", cn.corename);
>>   goto close_fail;
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 99318b157a9a..7e91b6f87757 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -2586,11 +2586,15 @@ bool inode_owner_or_capable(struct mnt_idmap =
*idmap,
>>  {
>>   vfsuid_t vfsuid;
>>   struct user_namespace *ns;
>> + int ret;
>>  - vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>> - if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret =3D=3D 0)
>>   return true;
>> + if (ret < 0)
>> + return false;
>>  + vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>>   ns =3D current_user_ns();
>>   if (vfsuid_has_mapping(ns, vfsuid) && ns_capable(ns, CAP_FOWNER))
>>   return true;
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 1619cddfa7a4..b7a2a3ab7529 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -68,6 +68,7 @@
>>  #include <trace/events/filelock.h>
>>    #include <linux/uaccess.h>
>> +#include "internal.h"
>>    static struct file_lock *file_lock(struct file_lock_core *flc)
>>  {
>> @@ -2013,10 +2014,12 @@ int
>>  vfs_setlease(struct file *filp, int arg, struct file_lease **lease, =
void **priv)
>>  {
>>   struct inode *inode =3D file_inode(filp);
>> - vfsuid_t vfsuid =3D i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
>>   int error;
>>  - if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && =
!capable(CAP_LEASE))
>> + error =3D vfs_inode_is_owned_by_me(file_mnt_idmap(filp), inode);
>> + if (error < 0)
>> + return error;
>> + if (error !=3D 0 && !capable(CAP_LEASE))
>>   return -EACCES;
>>   if (!S_ISREG(inode->i_mode))
>>   return -EINVAL;
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 9f42dc46322f..6ede952d424a 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -1195,26 +1195,26 @@ static int vfs_inodes_have_same_owner(struct =
mnt_idmap *idmap, struct inode *ino
>>   *
>>   * Returns 0 if following the symlink is allowed, -ve on error.
>>   */
>> -static inline int may_follow_link(struct nameidata *nd, const struct =
inode *inode)
>> +static inline int may_follow_link(struct nameidata *nd, struct inode =
*inode)
>>  {
>>   struct mnt_idmap *idmap;
>> - vfsuid_t vfsuid;
>> + int ret;
>>     if (!sysctl_protected_symlinks)
>>   return 0;
>>  - idmap =3D mnt_idmap(nd->path.mnt);
>> - vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>> - /* Allowed if owner and follower match. */
>> - if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
>> - return 0;
>> -
>>   /* Allowed if parent directory not sticky and world-writable. */
>>   if ((nd->dir_mode & (S_ISVTX|S_IWOTH)) !=3D (S_ISVTX|S_IWOTH))
>>   return 0;
>>  + idmap =3D mnt_idmap(nd->path.mnt);
>> + /* Allowed if owner and follower match. */
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret <=3D 0)
>> + return ret;
>> +
>>   /* Allowed if parent directory and link owner match. */
>> - if (vfsuid_valid(nd->dir_vfsuid) && vfsuid_eq(nd->dir_vfsuid, =
vfsuid))
>> + if (vfs_inodes_have_same_owner(idmap, inode, nd))
>>   return 0;
>>     if (nd->flags & LOOKUP_RCU)
>> @@ -3157,12 +3157,14 @@ EXPORT_SYMBOL(user_path_at);
>>  int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
>>     struct inode *inode)
>>  {
>> - kuid_t fsuid =3D current_fsuid();
>> + int ret;
>>  - if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), fsuid))
>> - return 0;
>> - if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, dir), fsuid))
>> - return 0;
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret <=3D 0)
>> + return ret;
>> + ret =3D vfs_inode_is_owned_by_me(idmap, dir);
>> + if (ret <=3D 0)
>> + return ret;
>>   return !capable_wrt_inode_uidgid(idmap, inode, CAP_FOWNER);
>>  }
>>  EXPORT_SYMBOL(__check_sticky);
>> diff --git a/fs/remap_range.c b/fs/remap_range.c
>> index 26afbbbfb10c..9eee93c27001 100644
>> --- a/fs/remap_range.c
>> +++ b/fs/remap_range.c
>> @@ -413,20 +413,22 @@ loff_t vfs_clone_file_range(struct file =
*file_in, loff_t pos_in,
>>  EXPORT_SYMBOL(vfs_clone_file_range);
>>    /* Check whether we are allowed to dedupe the destination file */
>> -static bool may_dedupe_file(struct file *file)
>> +static int may_dedupe_file(struct file *file)
>>  {
>>   struct mnt_idmap *idmap =3D file_mnt_idmap(file);
>>   struct inode *inode =3D file_inode(file);
>> + int ret;
>>     if (capable(CAP_SYS_ADMIN))
>> - return true;
>> + return 0;
>>   if (file->f_mode & FMODE_WRITE)
>> - return true;
>> - if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), =
current_fsuid()))
>> - return true;
>> + return 0;
>> + ret =3D vfs_inode_is_owned_by_me(idmap, inode);
>> + if (ret <=3D 0)
>> + return ret;
>>   if (!inode_permission(idmap, inode, MAY_WRITE))
>> - return true;
>> - return false;
>> + return 0;
>> + return -EPERM;
>>  }
>>    loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t =
src_pos,
>> @@ -459,8 +461,8 @@ loff_t vfs_dedupe_file_range_one(struct file =
*src_file, loff_t src_pos,
>>   if (ret)
>>   return ret;
>>  - ret =3D -EPERM;
>> - if (!may_dedupe_file(dst_file))
>> + ret =3D may_dedupe_file(dst_file);
>> + if (ret < 0)
>>   goto out_drop_write;
>>     ret =3D -EXDEV;
>=20
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
>=20
> This change looks good to me.  It should be noted that it assumes that =
filesystem specific is_owned_by_me inode_operation can properly handle =
all inode types.  The preceding change will need a fix for the afs =
implementation.

Some further thoughts on this series:

1. Can vfs_inode_is_owned_by_me() be restricted to regular files and =
symlinks? AFS cannot provide an answer via the PRSFS_ADMINISTER flag for =
directories and with the exception of __check_sticky() it is never =
called on a directory inode.

2. __check_sticky() can be changed from calling is_owned_by_me() on both =
the file and the directory to using is_owned_by_me() for the file and =
then use a have_same_owner() check to compare the file and directory =
inodes.  Doing so avoids the only vfs_inode_is_owned_by_me() call on a =
directory inode.

3. Can we add a new vfs_is chown_ok() inode operation? AFS does not use =
vnode ownership as the determining factor when permitting alteration of =
the unix owner/group. Only members of the AFS cell=E2=80=99s =
system:administrators group are permitted to change ownership and the =
client has no visibility into group memberships so must either always =
assume its ok to attempt the ownership change and let the fileserver =
reject it, or the AFS fileserver needs to implement a new rpc or caller =
access bit to determine if the caller is a system:administrator or =
otherwise has permission to change object ownership.

Thanks.

Jeffrey Altman


--Apple-Mail=_E92E1DC6-D9C2-4C3F-BA21-8F84E080A0C3
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDHEw
ggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMB4XDTIyMDgw
NDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0EwMTQxMEQwMDAwMDE4
MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRtYW4xFTATBgNVBAoTDEF1
cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk
C7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3xHZRtv179LHKAOcsY2jIctzieMxf
82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyNfO/wJ0rX7G+ges22Dd7goZul8rPaTJBI
xbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kIEEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq
4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6
W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjGIcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAw
gYQGCCsGAQUFBwEBBHgwdjAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEIGCCsGAQUFBzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2Nl
cnRzL3RydXN0aWRjYWExMy5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYD
VR0TBAIwADCCASsGA1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIB
Fj5odHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5k
ZXguaHRtbDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJl
ZW4gaXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmlj
YXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vdmFsaWRh
dGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQYMBaBFGphbHRt
YW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2sgjAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwVeycprp8Ox1npiTyfwc5Q
aVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4cWLeQfaMrnyNeEuvHx/2CT44c
dLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYqutYF4Chkxu4KzIpq90eDMw5ajkex
w+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJoQle4wDxrdXdnIhCP7g87InXKefWgZBF4
VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXta8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRk
gIGb319a7FjslV8wggaXMIIEf6ADAgECAhBAAXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBD
b21tZXJjaWFsIFJvb3QgQ0EgMTAeFw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6i
xaNP0JKSjTd+SG5LwqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6i
qgB63OdHxBN/15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxl
g+m1Vjgno1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi
2un03bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsG
AQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3Qu
Y29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2Nv
bW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djCCASQG
A1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0dHBzOi8vc2VjdXJlLmlk
ZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMIG6BggrBgEFBQcC
AjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMgYmVlbiBpc3N1ZWQgaW4gYWNjb3Jk
YW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2VydGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0
IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20v
Y3JsL2NvbW1lcmNpYWxyb290Y2ExLmNybDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX
6Nl4a03cDHt7TLdPxCzFvDF2bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN
95jUXLdLPRToNxyaoB5s0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24
GBqqVudvPRLyMJ7u6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azN
BkfnbRq+0e88QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8Hvgn
LCBFK2s4Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXF
C9budb9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4dUsZy
Tk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJnp/BscizY
dNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eAMDGCAqYwggKi
AgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJ
RCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCgggEpMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcyMTE2MTUzNFowLwYJKoZIhvcNAQkE
MSIEIGmh3ewuaJUXoA2nojfFkJ8krl19veC583XhdAZtg68rMF0GCSsGAQQBgjcQBDFQME4wOjEL
MAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMC
EEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQAgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYD
VQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzM
MA0GCSqGSIb3DQEBCwUABIIBAIQ6rwUQD84MFvEdiq/vvMCbd/WZpwvCOmqY6ndutTGVkrF8HfMV
BVJJJVXbIDIFZcpp315AsQwqX3Tp5m7iqA0E0es9lFT6fs1UGBimcOIt5Aj08pWk3mLcspK0LbSi
HJmvwfJWXesgj4Ra4MeoYeprjAXobwzV4G6dTHQY8CigA2NTHDZXbZI+n0KpsGXD5y5+yzKhme+2
IMxlP2DuwQYgjqh3o1flRQmJh0z4DCHUzByK1TUDQNp5yuGXDvVJA2uWAdZRz8piGv+mUFoMViO2
W8FElecUnepNM9CjQlkcEX9jcmjK52SUrs6mqZdTHG4++a6x/snnvBfS14wqbDIAAAAAAAA=
--Apple-Mail=_E92E1DC6-D9C2-4C3F-BA21-8F84E080A0C3--


