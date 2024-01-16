Return-Path: <linux-fsdevel+bounces-8093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2482F5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30C61C23CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BB1D533;
	Tue, 16 Jan 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RkTKvsn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E331D534
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434082; cv=none; b=XvmxdLkVoYgvhhp5fkEmOB0NIkYt4vwWRX+Avyt0xHwWErpbT/FSGXgaOT8JF3uYmHK2Z2Kx/ZD1eGAt6xgmDnXUAmdosnMQpMqvN9Dj+gZohmGcTDoFNpyMxxTcww55ZBfzeL4nabLD+ZHPBYWwYbdrG39KHu4UO9MYHVegjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434082; c=relaxed/simple;
	bh=1V09i445Vft8fre+PNOEpNMe6lQZDDd4eZkjeZxOl8E=;
	h=DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Mailer; b=MzWQDF+Jl20/31i7AnSCJwZtlZeldfQEVwBGg7P4k4I3D5oauDT1PfDwB7CQ7kDxPqiFJNsOvTS7mWOk6bgAtEGayETArZsogXae+iJ9RdYxQLqjL6Z8IeFMWcrSWXRswpOZUaiRads3B7qjXj5OwMkWVA8mz/T6hk2DR2/2/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RkTKvsn0; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705434080; bh=Pums67AQtIibuvWDgI/gKeaSxifYBmsbSPY3e2wEph8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RkTKvsn01hE9Vm4cWJ7c29sJDmLUNeipmuAxyJGttMDeAay+vD+zgmeNsmLMGv3GO+5GFsEKoV4JEYpOfUD8dY8enqzBotpzMgK9Hv0BbKxrZg7GPE5fRj6cycFIloF2T60A7tRZZ0l5N45yn3e6HC4EhyIjFhuP4kyo/rOJj1Y0FtmmsKqQWA5fbnqug/6s/thG9rpTYcyilLp89zeC4oBDE0oiJG0+8H1sFkE3HGn9iNuhsWmWOShYHee6g3LWfkd560VnbFYcMV/bXnyXuE5zrVIJ3OeGz5abjm7nBnaMKBa391PSttcrpLaPy3zHokLqe8ZMzXgMp/k3X19rGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705434080; bh=vtA9+wfAowU44kTIgSvJJkN6PAk9XwFib66hLHM40Uc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SefrzH5hJ/hqET9t7Mcq+kfNqjXokAK57K94thDSHK2Ai2eNuVg8/U02D24ks3026BFU/9dDXPdTymuWL0xiLG/VlRlZb+cxWM6Mnce8UqfnjGESCGoS7sBN3zn/1wic/S3lWUSLZstFhsQSwatw9K2hJydH+PSYDO+bYVRohLMZl6yNWmnEifpiCF7gUgiSv7t9P9lBMGj6Bfe3NDW35MFmkZY0VVnCIPkZc8q5lmA8UflZJ7lLiFwVB+posQeBVEeUDPBjvNtBrpfNexdIep55vdxxdnyyil4rTQ+rRrXltqt0ujIZU1Rf45MI9BBSDy/3cRwd2ESj2uAPNwNymw==
X-YMail-OSG: REIZpNoVM1mUCR2YGnBrQMAi5V1umO3SzKm1_Fi30VKpNgGGj0k4m.8W0rtKJcB
 BpF9pIJOV7DTwsjuJ.UnUTF2i1NwmjwT78vnFQYYXpQa69wfr4cyMyDnU6DqKSlGyQNycukN7L46
 d_0kehWkOtCvRAdtOPpFFVBVfXbWu.fV1ZP6Wz4S1GQUsrXqWsFKVoY4yeqAI1eWGIA1LbWGnYJu
 m6r9w1W_K3yKdfKhIpLfZT5sJ_7x6n5_FtuSWSJJBa_TCTAFwFKZCUinGI8Xzn6_2TTkhFbnfgCb
 52kiXjM5CsaZ5eE79otPC4uv_d0grQ.AGNj.XhW0I71jT8Deo8vTZkpdX3mS1L0RaRyk5YJpjPWJ
 Wz1tli8MVMYzM9yrxR3HdyUCEYHoq2C1yrtqda_9FqoWqAZ1ua2KyKrBAfLOvoTV6vLqysjpGABX
 lotne9gTU15yYiPL1m0ZKLCqLoxE1y0huk6IEvYHx84MdX7f7sffHYpBbg3tt.ZzABWR_XdpFI7y
 trFof51BWG9DNkj1unDeuZwFNH7sTWYge0WlWVRnDh00sZO4H8nzd9INOxDVN0FzlEjlwpmc.I3P
 yBtQMSK0jUifebyPs4rMNkpyDVcGSWQ.Z9cF.2b38uCyliaryDs5Gg3_E.zU7FXLlaDBWmFnr1Nx
 6RwcxMd3vpKK0xDS8wbw5SnhidporqDuYvHkAoXRqaxaotj0yrnqhJvKX5idKIfjAsOZsXZHR7hb
 WWPRg3ofZsuuQ4tFq_eqq2uaVcZzH67wwOs528rOUapIdemlO3O_pRPh3SCShlFHBhPnw.AuZZkF
 XPVwVUd0oIlKUi_p5lQMceUx83Agti4ukk953fXFD7Lh_Y8PAKQkFYpxo_7HUAGLYbZb8TgKBcg5
 UGsnI.Cb5Oxj8lWevnoZopfBKi6rJwUdGM37TxkOInMx7s_xggjPkFa5i6mNpDtIzIdwqto4SLh.
 jrk1tukaafN1D0xrr.FXiNWxtD_P2OnuS0oqnOXf8h1w6PyutrOUgzNhAp_VWSOvYMCS2OpB_P51
 _zVbI9q404JeYik9gyIxuVGk_pFq21FkljmOoEeOBRwOIrVr0jc9y_ICJxQu3F2vSWs5K59ZusqA
 ztQ8NOFwPaqA2R._6UD_HlbXL4KHVV39TS1SUFAcdc60V1.NRMJ6co25iVJwqgLX7j4XU.5ZrTBu
 mvfwXQZVABjJ0saGG2lB2y4lHePUZbiQRYep2nFWIBQ_IHS_nGqOQjRuuBfGo8P354tC3Q7TM298
 m48nCUp02OuCBc9d3ltcsu84XbwPPK6khCgeSX_4D1QjcEdx6N.r7c9UWpKsXfuvkS4HFwYhm7.0
 7WC6gPSLrxS39lNBo13LUXg62dsSjjilCOBfoD4k9sUi_8Upqx0ftxAwTlkwCPlB8XWz5BTlworQ
 qY7DPWeMfsHf_5s97bvNWKp4TPgApHMLkfjJc5N.BKDiLTQTR2vNzIlv0B9hVNoN5y.n1zYNOx4O
 M82fUltje.lURnjnHN9w8RamxM8Q.MMBJJSec1lJb0PzwNzHEsX8caWCFJkKZHvYRlB15KSYokhF
 woPMXxOuWEyifHtWOw1XaVB7jIBZAnJJQT6edfNMiy9lp6zjgq6BrMKJP.JtaXiKcH0mhN4hd3wU
 qXEgxhrbuiS0vD5wYBvoZg_YIOmw5uOcQbvZsyP9D77u.vL1q5oJuo7H43V.N5cx..WauYlLOOgA
 1SeA9rEV3_CJ89zyeLC9vAAqHKKxWGnQhUjTcB3JYbwm1Pb5a.Wv_xbKiFzzRv6VXdwVuqwqVanP
 iUmClUlRKRrLT_L9KxX9BvAhoLMNhtgFz5.B_gc59gi7VyeCrtCQjC0.1thJ_siHQV2nQg895EhA
 yk5N52lSSJGfhdPff_oduVMatKKG989pSjUkPA1OMuDng.nvSxPqvUzLF7sgygBFj8DtVZgchmNq
 _GCeO4PdeZhtIvV22_d4oEX9K8Oq2Tz3m05aoq3bSXHGx_4VuHN84zmfLqSGVuukrNOWickeMs7F
 .pN2fN.ufwV5t1S08yZnfFAnhtuQ9bheXwnql2zyon7S57dI539XUebZu4dYrAUfpk1Lnm60_luW
 DzU3ZQ6KIWm6sWgqW5utBY1qABTxQrIOhfmaRZ9DEpXbypJNi0PQGpFoma1zpEBAv9BwRM6h9MEB
 HwMLMoiCDndhXBxXsFnnv2UhUAL5vZ0tSAwSFOHxSHXP5Oo9jDmdyqbKPXb0ZySRW0zBYFJTIhYA
 UvrP2czaqIVhxPXK8.r4bWWTLDKkBKHnhUjTNCCbVWNPJqNTLxv2_gw1qX2tFzAVr378QH8NK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c99b1a5b-187c-4209-a07c-8495901ac7fa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 19:41:20 +0000
Received: by hermes--production-gq1-78d49cd6df-mnx8f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1214647a3ffbd90e25e7bcd21096381a;
          Tue, 16 Jan 2024 19:41:15 +0000 (UTC)
Message-ID: <3e2d5c73-0c77-4b46-a879-c92116eb5ad9@schaufler-ca.com>
Date: Tue, 16 Jan 2024 11:41:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 25/25] integrity: Remove LSM
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
 eparis@parisplace.org, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-26-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240115181809.885385-26-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/15/2024 10:18 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Since now IMA and EVM use their own integrity metadata, it is safe to
> remove the 'integrity' LSM, with its management of integrity metadata.
>
> Keep the iint.c file only for loading IMA and EVM keys at boot, and for
> creating the integrity directory in securityfs (we need to keep it for
> retrocompatibility reasons).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/integrity.h      |  14 ---
>  security/integrity/iint.c      | 197 +--------------------------------
>  security/integrity/integrity.h |  25 -----
>  security/security.c            |   2 -
>  4 files changed, 2 insertions(+), 236 deletions(-)
>
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index ef0f63ef5ebc..459b79683783 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -19,24 +19,10 @@ enum integrity_status {
>  	INTEGRITY_UNKNOWN,
>  };
>  
> -/* List of EVM protected security xattrs */
>  #ifdef CONFIG_INTEGRITY
> -extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
> -extern void integrity_inode_free(struct inode *inode);
>  extern void __init integrity_load_keys(void);
>  
>  #else
> -static inline struct integrity_iint_cache *
> -				integrity_inode_get(struct inode *inode)
> -{
> -	return NULL;
> -}
> -
> -static inline void integrity_inode_free(struct inode *inode)
> -{
> -	return;
> -}
> -
>  static inline void integrity_load_keys(void)
>  {
>  }
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index d4419a2a1e24..068ac6c2ae1e 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -6,207 +6,14 @@
>   * Mimi Zohar <zohar@us.ibm.com>
>   *
>   * File: integrity_iint.c
> - *	- implements the integrity hooks: integrity_inode_alloc,
> - *	  integrity_inode_free
> - *	- cache integrity information associated with an inode
> - *	  using a rbtree tree.
> + *	- initialize the integrity directory in securityfs
> + *	- load IMA and EVM keys
>   */
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/spinlock.h>
> -#include <linux/rbtree.h>
> -#include <linux/file.h>
> -#include <linux/uaccess.h>
>  #include <linux/security.h>
> -#include <linux/lsm_hooks.h>
>  #include "integrity.h"
>  
> -static struct rb_root integrity_iint_tree = RB_ROOT;
> -static DEFINE_RWLOCK(integrity_iint_lock);
> -static struct kmem_cache *iint_cache __ro_after_init;
> -
>  struct dentry *integrity_dir;
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
> -/*
> - * integrity_iint_find - return the iint associated with an inode
> - */
> -struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
> -{
> -	struct integrity_iint_cache *iint;
> -
> -	if (!IS_IMA(inode))
> -		return NULL;
> -
> -	read_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	read_unlock(&integrity_iint_lock);
> -
> -	return iint;
> -}
> -
> -#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
> -
> -/*
> - * It is not clear that IMA should be nested at all, but as long is it measures
> - * files both on overlayfs and on underlying fs, we need to annotate the iint
> - * mutex to avoid lockdep false positives related to IMA + overlayfs.
> - * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> - */
> -static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
> -					 struct inode *inode)
> -{
> -#ifdef CONFIG_LOCKDEP
> -	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
> -
> -	int depth = inode->i_sb->s_stack_depth;
> -
> -	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
> -		depth = 0;
> -
> -	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
> -#endif
> -}
> -
> -static void iint_init_always(struct integrity_iint_cache *iint,
> -			     struct inode *inode)
> -{
> -	iint->ima_hash = NULL;
> -	iint->version = 0;
> -	iint->flags = 0UL;
> -	iint->atomic_flags = 0UL;
> -	iint->ima_file_status = INTEGRITY_UNKNOWN;
> -	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
> -	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
> -	iint->ima_read_status = INTEGRITY_UNKNOWN;
> -	iint->ima_creds_status = INTEGRITY_UNKNOWN;
> -	iint->evm_status = INTEGRITY_UNKNOWN;
> -	iint->measured_pcrs = 0;
> -	mutex_init(&iint->mutex);
> -	iint_lockdep_annotate(iint, inode);
> -}
> -
> -static void iint_free(struct integrity_iint_cache *iint)
> -{
> -	kfree(iint->ima_hash);
> -	mutex_destroy(&iint->mutex);
> -	kmem_cache_free(iint_cache, iint);
> -}
> -
> -/**
> - * integrity_inode_get - find or allocate an iint associated with an inode
> - * @inode: pointer to the inode
> - * @return: allocated iint
> - *
> - * Caller must lock i_mutex
> - */
> -struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
> -{
> -	struct rb_node **p;
> -	struct rb_node *node, *parent = NULL;
> -	struct integrity_iint_cache *iint, *test_iint;
> -
> -	iint = integrity_iint_find(inode);
> -	if (iint)
> -		return iint;
> -
> -	iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
> -	if (!iint)
> -		return NULL;
> -
> -	iint_init_always(iint, inode);
> -
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
> -	iint->inode = inode;
> -	node = &iint->rb_node;
> -	inode->i_flags |= S_IMA;
> -	rb_link_node(node, parent, p);
> -	rb_insert_color(node, &integrity_iint_tree);
> -
> -	write_unlock(&integrity_iint_lock);
> -	return iint;
> -}
> -
> -/**
> - * integrity_inode_free - called on security_inode_free
> - * @inode: pointer to the inode
> - *
> - * Free the integrity information(iint) associated with an inode.
> - */
> -void integrity_inode_free(struct inode *inode)
> -{
> -	struct integrity_iint_cache *iint;
> -
> -	if (!IS_IMA(inode))
> -		return;
> -
> -	write_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> -	write_unlock(&integrity_iint_lock);
> -
> -	iint_free(iint);
> -}
> -
> -static void iint_init_once(void *foo)
> -{
> -	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
> -
> -	memset(iint, 0, sizeof(*iint));
> -}
> -
> -static int __init integrity_iintcache_init(void)
> -{
> -	iint_cache =
> -	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> -			      0, SLAB_PANIC, iint_init_once);
> -	return 0;
> -}
> -DEFINE_LSM(integrity) = {
> -	.name = "integrity",
> -	.init = integrity_iintcache_init,
> -	.order = LSM_ORDER_LAST,
> -};
> -
> -
>  /*
>   * integrity_kernel_read - read data from the file
>   *
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 671fc50255f9..50d6f798e613 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -102,31 +102,6 @@ struct ima_file_id {
>  	__u8 hash[HASH_MAX_DIGESTSIZE];
>  } __packed;
>  
> -/* integrity data associated with an inode */
> -struct integrity_iint_cache {
> -	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
> -	struct mutex mutex;	/* protects: version, flags, digest */
> -	struct inode *inode;	/* back pointer to inode in question */
> -	u64 version;		/* track inode changes */
> -	unsigned long flags;
> -	unsigned long measured_pcrs;
> -	unsigned long atomic_flags;
> -	unsigned long real_ino;
> -	dev_t real_dev;
> -	enum integrity_status ima_file_status:4;
> -	enum integrity_status ima_mmap_status:4;
> -	enum integrity_status ima_bprm_status:4;
> -	enum integrity_status ima_read_status:4;
> -	enum integrity_status ima_creds_status:4;
> -	enum integrity_status evm_status:4;
> -	struct ima_digest_data *ima_hash;
> -};
> -
> -/* rbtree tree calls to lookup, insert, delete
> - * integrity data associated with an inode.
> - */
> -struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
> -
>  int integrity_kernel_read(struct file *file, loff_t offset,
>  			  void *addr, unsigned long count);
>  
> diff --git a/security/security.c b/security/security.c
> index f811cc376a7a..df87c0a7eaac 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
> -#include <linux/integrity.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mman.h>
>  #include <linux/mount.h>
> @@ -1597,7 +1596,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -	integrity_inode_free(inode);
>  	call_void_hook(inode_free_security, inode);
>  	/*
>  	 * The inode may still be referenced in a path walk and

