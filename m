Return-Path: <linux-fsdevel+bounces-74228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98165D38592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5753A30ADD6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514F34EF0E;
	Fri, 16 Jan 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="pYRdvorW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cbJN+/Lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-79.smtp-out.amazonses.com (a11-79.smtp-out.amazonses.com [54.240.11.79])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2734D4D6;
	Fri, 16 Jan 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590713; cv=none; b=ecmo7PtaMyDqwPtXfGnReIBDzVBtJoy4D+oRHq7yB6Ox0p48ViVvvy1+Ife3vO4jy348qr2Pg+z63Huj84/o3aj3TxyZRFBOayXUvN81yIy+/iypIOuvF06W7wLWStYkx43dFeMfe4Qe2cuXO8QXQ0s+oEsjMXPWApkV5MqBRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590713; c=relaxed/simple;
	bh=glz+00ijWYQQ2Oo0TY1hR6I+VY2OuM/0QdldFtPNveU=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=XWeGgOd8QzXYjKZdiOqIcBOm1aXDETJ34YKGxCdOW0AeBpPTosr0cFCV4OI836Bgpp55N4DbTctaupSZOiKTDlbaeASSxJGfHBkQMZvZ6JO9JT4nJtzhEiAfcpyaVUWOMxIepf2+o4dxOg/5OeNxcBhT8RWONc4A68qNwQJEzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=pYRdvorW; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=cbJN+/Lb; arc=none smtp.client-ip=54.240.11.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590711;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=glz+00ijWYQQ2Oo0TY1hR6I+VY2OuM/0QdldFtPNveU=;
	b=pYRdvorWVJ26bvSAafZRqGCB5LRFrwcUlF6Q60jq8NYGh0xq0RdgVrIPOIz5zS7Q
	lOB97EWqEjlWx6ijmk8i8orpktu9yUXwDZS2hMy+IA8wZK/BZv+3V3JyfvUCnDq6CHG
	v3Tqsp8uti7g3xC8GVQzYmWWraYPLxS3jVJw1bZg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590711;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=glz+00ijWYQQ2Oo0TY1hR6I+VY2OuM/0QdldFtPNveU=;
	b=cbJN+/LbGQzrueOi19mgvuMFtWcGC9EYpi0Lkb1jnmM/HciKcXsXzIzLbNQPPVff
	yM3vSYdiJeWG3tUdXh+dFyX46lgvw6F73xNpKJaJSdJrqsRjo+Cy+whvLtrLBxry3p+
	yALaRQqyoAmBSuSMPwl971xYOfTj28V7n16KSZ1s=
Subject: [PATCH V5 2/3] fuse_kernel.h: add famfs DAX fmap protocol definitions
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:11:50 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116191036.1470-1-john@jagalactic.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116191036.1470-1-john@jagalactic.com> 
 <20260116191036.1470-3-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAAa/D4AAB2LiA=
Thread-Topic: [PATCH V5 2/3] fuse_kernel.h: add famfs DAX fmap protocol
 definitions
X-Wm-Sent-Timestamp: 1768590709
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc838980e-2cb9b0f8-583e-41b2-861c-39858ad5650a-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.79

From: John Groves <john@groves.net>=0D=0A=0D=0AAdd FUSE protocol version =
7.46 definitions for famfs DAX file mapping:=0D=0A=0D=0ACapability flag:=0D=
=0A  - FUSE_DAX_FMAP (bit 43): kernel supports DAX fmap operations=0D=0A=0D=
=0ANew opcodes:=0D=0A  - FUSE_GET_FMAP (54): retrieve file extent map for=
 DAX mapping=0D=0A  - FUSE_GET_DAXDEV (55): retrieve DAX device info by i=
ndex=0D=0A=0D=0ANew structures for GET_FMAP reply:=0D=0A  - struct fuse_f=
amfs_fmap_header: file map header with type and extent info=0D=0A  - stru=
ct fuse_famfs_simple_ext: simple extent (device, offset, length)=0D=0A  -=
 struct fuse_famfs_iext: interleaved extent for striped allocations=0D=0A=
=0D=0ANew structures for GET_DAXDEV:=0D=0A  - struct fuse_get_daxdev_in: =
request DAX device by index=0D=0A  - struct fuse_daxdev_out: DAX device n=
ame response=0D=0A=0D=0ASupporting definitions:=0D=0A  - enum fuse_famfs_=
file_type: regular, superblock, or log file=0D=0A  - enum famfs_ext_type:=
 simple or interleaved extent type=0D=0A=0D=0ASigned-off-by: John Groves =
<john@groves.net>=0D=0A---=0D=0A include/fuse_kernel.h | 88 +++++++++++++=
++++++++++++++++++++++++++++++=0D=0A 1 file changed, 88 insertions(+)=0D=0A=
=0D=0Adiff --git a/include/fuse_kernel.h b/include/fuse_kernel.h=0D=0Aind=
ex c13e1f9..7fdfc30 100644=0D=0A--- a/include/fuse_kernel.h=0D=0A+++ b/in=
clude/fuse_kernel.h=0D=0A@@ -240,6 +240,19 @@=0D=0A  *  - add FUSE_COPY_F=
ILE_RANGE_64=0D=0A  *  - add struct fuse_copy_file_range_out=0D=0A  *  - =
add FUSE_NOTIFY_PRUNE=0D=0A+ *=0D=0A+ *  7.46=0D=0A+ *    - Add FUSE_DAX_=
FMAP capability - ability to handle in-kernel fsdax maps=0D=0A+ *    - Ad=
d the following structures for the GET_FMAP message reply components:=0D=0A=
+ *      - struct fuse_famfs_simple_ext=0D=0A+ *      - struct fuse_famfs=
_iext=0D=0A+ *      - struct fuse_famfs_fmap_header=0D=0A+ *    - Add the=
 following structs for the GET_DAXDEV message and reply=0D=0A+ *      - s=
truct fuse_get_daxdev_in=0D=0A+ *      - struct fuse_get_daxdev_out=0D=0A=
+ *    - Add the following enumerated types=0D=0A+ *      - enum fuse_fam=
fs_file_type=0D=0A+ *      - enum famfs_ext_type=0D=0A  */=0D=0A=20=0D=0A=
 #ifndef _LINUX_FUSE_H=0D=0A@@ -448,6 +461,7 @@ struct fuse_file_lock {=0D=
=0A  * FUSE_OVER_IO_URING: Indicate that client supports io-uring=0D=0A  =
* FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.=0D=0A  *=09=09=
=09 init_out.request_timeout contains the timeout (in secs)=0D=0A+ * FUSE=
_DAX_FMAP:        kernel supports dev_dax_iomap (aka famfs) fmaps=0D=0A  =
*/=0D=0A #define FUSE_ASYNC_READ=09=09(1 << 0)=0D=0A #define FUSE_POSIX_L=
OCKS=09(1 << 1)=0D=0A@@ -495,6 +509,7 @@ struct fuse_file_lock {=0D=0A #d=
efine FUSE_ALLOW_IDMAP=09(1ULL << 40)=0D=0A #define FUSE_OVER_IO_URING=09=
(1ULL << 41)=0D=0A #define FUSE_REQUEST_TIMEOUT=09(1ULL << 42)=0D=0A+#def=
ine FUSE_DAX_FMAP=09=09(1ULL << 43)=0D=0A=20=0D=0A /**=0D=0A  * CUSE INIT=
 request/reply flags=0D=0A@@ -664,6 +679,10 @@ enum fuse_opcode {=0D=0A =09=
FUSE_STATX=09=09=3D 52,=0D=0A =09FUSE_COPY_FILE_RANGE_64=09=3D 53,=0D=0A=20=
=0D=0A+=09/* Famfs / devdax opcodes */=0D=0A+=09FUSE_GET_FMAP           =3D=
 54,=0D=0A+=09FUSE_GET_DAXDEV         =3D 55,=0D=0A+=0D=0A =09/* CUSE spe=
cific operations */=0D=0A =09CUSE_INIT=09=09=3D 4096,=0D=0A=20=0D=0A@@ -1=
308,4 +1327,73 @@ struct fuse_uring_cmd_req {=0D=0A =09uint8_t padding[6]=
;=0D=0A };=0D=0A=20=0D=0A+/* Famfs fmap message components */=0D=0A+=0D=0A=
+#define FAMFS_FMAP_VERSION 1=0D=0A+=0D=0A+#define FAMFS_FMAP_MAX 32768 /=
* Largest supported fmap message */=0D=0A+#define FUSE_FAMFS_MAX_EXTENTS =
32=0D=0A+#define FUSE_FAMFS_MAX_STRIPS 32=0D=0A+=0D=0A+enum fuse_famfs_fi=
le_type {=0D=0A+=09FUSE_FAMFS_FILE_REG,=0D=0A+=09FUSE_FAMFS_FILE_SUPERBLO=
CK,=0D=0A+=09FUSE_FAMFS_FILE_LOG,=0D=0A+};=0D=0A+=0D=0A+enum famfs_ext_ty=
pe {=0D=0A+=09FUSE_FAMFS_EXT_SIMPLE =3D 0,=0D=0A+=09FUSE_FAMFS_EXT_INTERL=
EAVE =3D 1,=0D=0A+};=0D=0A+=0D=0A+struct fuse_famfs_simple_ext {=0D=0A+=09=
uint32_t se_devindex;=0D=0A+=09uint32_t reserved;=0D=0A+=09uint64_t se_of=
fset;=0D=0A+=09uint64_t se_len;=0D=0A+};=0D=0A+=0D=0A+struct fuse_famfs_i=
ext { /* Interleaved extent */=0D=0A+=09uint32_t ie_nstrips;=0D=0A+=09uin=
t32_t ie_chunk_size;=0D=0A+=09uint64_t ie_nbytes; /* Total bytes for this=
 interleaved_ext;=0D=0A+=09=09=09     * sum of strips may be more=0D=0A+=09=
=09=09     */=0D=0A+=09uint64_t reserved;=0D=0A+};=0D=0A+=0D=0A+struct fu=
se_famfs_fmap_header {=0D=0A+=09uint8_t file_type; /* enum famfs_file_typ=
e */=0D=0A+=09uint8_t reserved;=0D=0A+=09uint16_t fmap_version;=0D=0A+=09=
uint32_t ext_type; /* enum famfs_log_ext_type */=0D=0A+=09uint32_t nexten=
ts;=0D=0A+=09uint32_t reserved0;=0D=0A+=09uint64_t file_size;=0D=0A+=09ui=
nt64_t reserved1;=0D=0A+};=0D=0A+=0D=0A+struct fuse_get_daxdev_in {=0D=0A=
+=09uint32_t        daxdev_num;=0D=0A+};=0D=0A+=0D=0A+#define DAXDEV_NAME=
_MAX 256=0D=0A+=0D=0A+/* fuse_daxdev_out has enough space for a uuid if w=
e need it */=0D=0A+struct fuse_daxdev_out {=0D=0A+=09uint16_t index;=0D=0A=
+=09uint16_t reserved;=0D=0A+=09uint32_t reserved2;=0D=0A+=09uint64_t res=
erved3;=0D=0A+=09uint64_t reserved4;=0D=0A+=09char name[DAXDEV_NAME_MAX];=
=0D=0A+};=0D=0A+=0D=0A+static __inline__ int32_t fmap_msg_min_size(void)=0D=
=0A+{=0D=0A+=09/* Smallest fmap message is a header plus one simple exten=
t */=0D=0A+=09return (sizeof(struct fuse_famfs_fmap_header)=0D=0A+=09=09+=
 sizeof(struct fuse_famfs_simple_ext));=0D=0A+}=0D=0A+=0D=0A #endif /* _L=
INUX_FUSE_H */=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

