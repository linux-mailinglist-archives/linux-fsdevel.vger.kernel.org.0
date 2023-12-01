Return-Path: <linux-fsdevel+bounces-4525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B80004A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F828164E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95421CAA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE2133;
	Thu, 30 Nov 2023 16:01:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4ShCXm45tlz9y9TW;
	Fri,  1 Dec 2023 07:47:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 80487140133;
	Fri,  1 Dec 2023 08:01:08 +0800 (CST)
Received: from [10.81.202.161] (unknown [10.81.202.161])
	by APP1 (Coremail) with SMTP id LxC2BwBXlHQ0ImllMJCuAQ--.12372S2;
	Fri, 01 Dec 2023 01:01:07 +0100 (CET)
Message-ID: <f37c47d0-5b20-4293-8bd0-5d465f328ffc@huaweicloud.com>
Date: Fri, 1 Dec 2023 01:00:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20231130231948.2545638-1-roberto.sassu@huaweicloud.com>
 <20231130231948.2545638-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231130231948.2545638-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBXlHQ0ImllMJCuAQ--.12372S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfJFyrCry8Cr1UZF4kXrb_yoWfCryUpF
	42gay8Jw1DZFWj9F4vyFs8uF4Sga4vgFWkWw1Ykw1kAFyqvr1jqFs5AryUuF15GrZ8Kw1I
	qrn0kr45u3WDtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj5ceegAAsV

On 12/1/2023 12:19 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Before the security field of kernel objects could be shared among LSMs with
> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> of inode metadata. The association between inode metadata and inode is
> maintained through an rbtree.
> 
> With the reservation mechanism offered by the LSM infrastructure, the
> rbtree is no longer necessary, as each LSM could reserve a space in the
> security blob for each inode.
> 
> With the 'integrity' LSM removed, and with the 'ima' LSM taking its role,
> reserve space from the 'ima' LSM for a pointer to the integrity_iint_cache
> structure directly, rather than embedding the whole structure in the inode
> security blob, to minimize the changes and to avoid waste of memory.
> 
> If IMA is disabled, EVM faces the same problems as before making it an
> LSM, metadata verification fails for new files due to not setting the
> IMA_NEW_FILE flag in ima_post_path_mknod(), and evm_verifyxattr()
> returns INTEGRITY_UNKNOWN since IMA didn't call integrity_inode_get().
> 
> The only difference caused to moving the integrity metadata management
> to the 'ima' LSM is the fact that EVM cannot take advantage of cached
> verification results, and has to do the verification again. However,
> this case should never happen, since the only public API available to
> all kernel components, evm_verifyxattr(), does not work if IMA is
> disabled.

This needs some explanation on how EVM can be used currently. EVM 
verifies inode metadata in the set* LSM hooks, eventually updates the 
HMAC in the post_set* hooks.

If integrity metadata are not available (IMA is disabled), EVM has to do 
the inode metadata verification every time, which means that this patch 
set would introduce a performance regression compared to when integrity 
metadata were always available and managed by the 'integrity' LSM.

However, the get* LSM hooks are not mediated, user space can freely get 
a corrupted inode metadata and EVM would not tell anything.

So, at this point it is clear that the main use case of EVM was a kernel 
component querying EVM about the integrity of inode metadata, by calling 
evm_verifyxattr(). One suitable place where this function can be called 
is the d_instantiate LSM hook, when an LSM is getting xattrs from the 
filesystem to populate the inode security blob.

But as I mentioned, evm_verifyxattr() does not work if IMA is disabled, 
so there should not be systems using this configuration for which we are 
introducing a performance regression.

Roberto

> Introduce two primitives for getting and setting the pointer of
> integrity_iint_cache in the security blob, respectively
> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> the code more understandable, as they directly replace rbtree operations.
> 
> Locking is not needed, as access to inode metadata is not shared, it is per
> inode.
> 
> Keep the blob size and the new primitives definition at the common level in
> security/integrity rather than moving them in IMA itself, so that EVM can
> still call integrity_inode_get() and integrity_iint_find() while IMA is
> disabled. Just add an extra check in integrity_inode_get() to return NULL
> if that is the case.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/iint.c         | 70 ++++---------------------------
>   security/integrity/ima/ima_main.c |  1 +
>   security/integrity/integrity.h    | 20 ++++++++-
>   3 files changed, 29 insertions(+), 62 deletions(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index c36054041b84..8fc9455dda11 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -14,56 +14,25 @@
>   #include <linux/slab.h>
>   #include <linux/init.h>
>   #include <linux/spinlock.h>
> -#include <linux/rbtree.h>
>   #include <linux/file.h>
>   #include <linux/uaccess.h>
>   #include <linux/security.h>
>   #include <linux/lsm_hooks.h>
>   #include "integrity.h"
>   
> -static struct rb_root integrity_iint_tree = RB_ROOT;
> -static DEFINE_RWLOCK(integrity_iint_lock);
>   static struct kmem_cache *iint_cache __ro_after_init;
>   
>   struct dentry *integrity_dir;
>   
> -/*
> - * __integrity_iint_find - return the iint associated with an inode
> - */
> -static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
> -{
> -	struct integrity_iint_cache *iint;
> -	struct rb_node *n = integrity_iint_tree.rb_node;
> -
> -	while (n) {
> -		iint = rb_entry(n, struct integrity_iint_cache, rb_node);
> -
> -		if (inode < iint->inode)
> -			n = n->rb_left;
> -		else if (inode > iint->inode)
> -			n = n->rb_right;
> -		else
> -			return iint;
> -	}
> -
> -	return NULL;
> -}
> -
>   /*
>    * integrity_iint_find - return the iint associated with an inode
>    */
>   struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
>   {
> -	struct integrity_iint_cache *iint;
> -
>   	if (!IS_IMA(inode))
>   		return NULL;
>   
> -	read_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	read_unlock(&integrity_iint_lock);
> -
> -	return iint;
> +	return integrity_inode_get_iint(inode);
>   }
>   
>   #define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
> @@ -123,9 +92,7 @@ static void iint_free(struct integrity_iint_cache *iint)
>    */
>   struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   {
> -	struct rb_node **p;
> -	struct rb_node *node, *parent = NULL;
> -	struct integrity_iint_cache *iint, *test_iint;
> +	struct integrity_iint_cache *iint;
>   
>   	/*
>   	 * After removing the 'integrity' LSM, the 'ima' LSM calls
> @@ -144,31 +111,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   
>   	iint_init_always(iint, inode);
>   
> -	write_lock(&integrity_iint_lock);
> -
> -	p = &integrity_iint_tree.rb_node;
> -	while (*p) {
> -		parent = *p;
> -		test_iint = rb_entry(parent, struct integrity_iint_cache,
> -				     rb_node);
> -		if (inode < test_iint->inode) {
> -			p = &(*p)->rb_left;
> -		} else if (inode > test_iint->inode) {
> -			p = &(*p)->rb_right;
> -		} else {
> -			write_unlock(&integrity_iint_lock);
> -			kmem_cache_free(iint_cache, iint);
> -			return test_iint;
> -		}
> -	}
> -
>   	iint->inode = inode;
> -	node = &iint->rb_node;
>   	inode->i_flags |= S_IMA;
> -	rb_link_node(node, parent, p);
> -	rb_insert_color(node, &integrity_iint_tree);
> +	integrity_inode_set_iint(inode, iint);
>   
> -	write_unlock(&integrity_iint_lock);
>   	return iint;
>   }
>   
> @@ -185,10 +131,8 @@ void integrity_inode_free(struct inode *inode)
>   	if (!IS_IMA(inode))
>   		return;
>   
> -	write_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> -	write_unlock(&integrity_iint_lock);
> +	iint = integrity_iint_find(inode);
> +	integrity_inode_set_iint(inode, NULL);
>   
>   	iint_free(iint);
>   }
> @@ -212,6 +156,10 @@ int __init integrity_iintcache_init(void)
>   	return 0;
>   }
>   
> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> +	.lbs_inode = sizeof(struct integrity_iint_cache *),
> +};
> +
>   /*
>    * integrity_kernel_read - read data from the file
>    *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 3f59cce3fa02..52b4a3bba45a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1162,6 +1162,7 @@ DEFINE_LSM(ima) = {
>   	.name = "ima",
>   	.init = init_ima_lsm,
>   	.order = LSM_ORDER_LAST,
> +	.blobs = &integrity_blob_sizes,
>   };
>   
>   late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 26d3b08dca1c..2fb35c67d64d 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -158,7 +158,6 @@ struct ima_file_id {
>   
>   /* integrity data associated with an inode */
>   struct integrity_iint_cache {
> -	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
>   	struct mutex mutex;	/* protects: version, flags, digest */
>   	struct inode *inode;	/* back pointer to inode in question */
>   	u64 version;		/* track inode changes */
> @@ -194,6 +193,25 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>   #define INTEGRITY_KEYRING_MAX		4
>   
>   extern struct dentry *integrity_dir;
> +extern struct lsm_blob_sizes integrity_blob_sizes;
> +
> +static inline struct integrity_iint_cache *
> +integrity_inode_get_iint(const struct inode *inode)
> +{
> +	struct integrity_iint_cache **iint_sec;
> +
> +	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
> +	return *iint_sec;
> +}
> +
> +static inline void integrity_inode_set_iint(const struct inode *inode,
> +					    struct integrity_iint_cache *iint)
> +{
> +	struct integrity_iint_cache **iint_sec;
> +
> +	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
> +	*iint_sec = iint;
> +}
>   
>   struct modsig;
>   


