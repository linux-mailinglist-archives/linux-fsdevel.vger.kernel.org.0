Return-Path: <linux-fsdevel+bounces-5353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222DC80AC35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E061F20620
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8F4B142
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DE11D;
	Fri,  8 Dec 2023 09:25:17 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SmyJN1wc0z9yskh;
	Sat,  9 Dec 2023 01:08:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E5EDD14090E;
	Sat,  9 Dec 2023 01:25:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnInNoUXNlUnQqAg--.64290S2;
	Fri, 08 Dec 2023 18:25:04 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	paul@paul-moore.com,
	stefanb@linux.ibm.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
Date: Fri,  8 Dec 2023 18:23:08 +0100
Message-Id: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnInNoUXNlUnQqAg--.64290S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryxZFWxAw4DAF4xurW8Xrb_yoW7Zw1DpF
	Wqya4DKr4rXFy7Wws5Aanruw109w4Fk3WUJ3y5Wwn5AF9xW3Za9FyftryYkFyUJr18ZFy5
	tayjqw13K3s8Ww7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUsrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5dj+AABs8

From: Roberto Sassu <roberto.sassu@huawei.com>

EVM updates the HMAC in security.evm whenever there is a setxattr or
removexattr operation on one of its protected xattrs (e.g. security.ima).

Unfortunately, since overlayfs redirects those xattrs operations on the
lower filesystem, the EVM HMAC cannot be calculated reliably, since lower
inode attributes on which the HMAC is calculated are different from upper
inode attributes (for example i_generation and s_uuid).

Although maybe it is possible to align such attributes between the lower
and the upper inode, another idea is to map security.evm to another name
(security.evm_overlayfs) during an xattr operation, so that it does not
collide with security.evm set by the lower filesystem.

Whenever overlayfs wants to set security.evm, it is actually setting
security.evm_overlayfs calculated with the upper inode attributes. The
lower filesystem continues to update security.evm.

This seems to make things working again, and even allowing IMA appraisal
to succeed on both the lower and the upper inode.

Example:

# mount -t overlay overlay \
    -o lowerdir=data,upperdir=root/data,workdir=root/data_work mnt

# echo "appraise fsname=overlay" > /sys/kernel/security/ima/policy
# echo "appraise fsuid=<lower fs UUID>" > /sys/kernel/security/ima/policy

# cd mnt
# echo test > test-file
evm: security.ima: (34) [0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...]
evm: hmac_misc: (24) [1300000000000000cd9e816c0000000000000000a4810000]
evm: uuid: [28b23254946744c0b6ba34b12e85a26f]
evm: digest: [b186cc901ead302572c6b271db85e4e5cd41c6ce]
evm: security.ima: (34) [0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...]
evm: hmac_misc: (24) [1300000000000000000000000000000000000000a4810000]
evm: uuid: [589286d4df13456ea82a9aca97660302]
evm: digest: [b90586afd1703a6cbf290d9150465f8bdd48fb8a]

The first 4 lines show the HMAC calculation on the lower inode (ext4), the
remaining 4 the HMAC calculation on the upper inode (overlay).

Now, after mapping security.evm to security.evm_overlayfs, this is the
result of the getfattr command on overlayfs:

# getfattr -m - -d -e hex test-file
# file: test-file
security.evm=0x02b90586afd1703a6cbf290d9150465f8bdd48fb8a
security.ima=0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...

Instead, this is the result of the getfattr command on the lower fs:

# getfattr -m - -d -e hex ../root/data/test-file
# file: ../root/data/test-file
security.evm=0x02b186cc901ead302572c6b271db85e4e5cd41c6ce
security.evm_overlayfs=0x02b90586afd1703a6cbf290d9150465f8bdd48fb8a
security.ima=0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...

Both HMACs are stored on the lower inode.

Trying IMA appraisal, the result is that both the access from overlayfs and
from the lower fs succeed. From overlayfs:

# cat test-file
evm: security.ima: (34) [0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...]
evm: hmac_misc: (24) [1300000000000000000000000000000000000000a4810000]
evm: uuid: [589286d4df13456ea82a9aca97660302]
evm: digest: [b90586afd1703a6cbf290d9150465f8bdd48fb8a]
test

From the lower fs:

# cat ../root/data/test-file
evm: security.ima: (34) [0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93...]
evm: hmac_misc: (24) [1300000000000000cd9e816c0000000000000000a4810000]
evm: uuid: [28b23254946744c0b6ba34b12e85a26f]
evm: digest: [b186cc901ead302572c6b271db85e4e5cd41c6ce]
test

security.evm_overlayfs is hidden from listxattr in overlayfs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/overlayfs/xattrs.c      | 9 +++++++++
 include/uapi/linux/xattr.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 383978e4663c..1141d2fa01db 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -65,6 +65,9 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 		goto out;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
+	if (!strcmp(name, XATTR_NAME_EVM))
+		name = XATTR_NAME_EVM_OVERLAYFS;
+
 	if (value) {
 		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
 				      flags);
@@ -88,6 +91,9 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	const struct cred *old_cred;
 	struct path realpath;
 
+	if (!strcmp(name, XATTR_NAME_EVM))
+		name = XATTR_NAME_EVM_OVERLAYFS;
+
 	ovl_i_path_real(inode, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
@@ -101,6 +107,9 @@ static bool ovl_can_list(struct super_block *sb, const char *s)
 	if (ovl_is_private_xattr(sb, s))
 		return false;
 
+	if (!strcmp(s, XATTR_NAME_EVM_OVERLAYFS))
+		return false;
+
 	/* List all non-trusted xattrs */
 	if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) != 0)
 		return true;
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..93930300f69e 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -51,6 +51,10 @@
 #define XATTR_EVM_SUFFIX "evm"
 #define XATTR_NAME_EVM XATTR_SECURITY_PREFIX XATTR_EVM_SUFFIX
 
+#define XATTR_EVM_OVERLAYFS_SUFFIX "evm_overlayfs"
+#define XATTR_NAME_EVM_OVERLAYFS \
+	XATTR_SECURITY_PREFIX XATTR_EVM_OVERLAYFS_SUFFIX
+
 #define XATTR_IMA_SUFFIX "ima"
 #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
 
-- 
2.34.1


