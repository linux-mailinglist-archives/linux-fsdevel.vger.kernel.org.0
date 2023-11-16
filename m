Return-Path: <linux-fsdevel+bounces-2937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26D7EDAEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE761F237DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C11D51C;
	Thu, 16 Nov 2023 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QNxLd/OQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A41AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:53 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41ccd38eaa5so3533111cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109232; x=1700714032; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTk7a67S1QtD8sba7dPNc/tDHo+LguzreZvYAY1S4fY=;
        b=QNxLd/OQnTNMmenq2+mNq4v5DLEMf5UVSLWa4Rr0TGvf7arRBJRWB8tkqk1zXmO6jS
         G6NBVvrLQNtS5Wg/KyqNcLQBGZvNNzwaIOLKjZTIrnlVwo4btxdIv8Xm7ZXO0EqKAJX3
         qZ8Kq5FAoV+Y3Ccnp3Cl9l4dIV2jfSHghxFeJo9XBlmBFQ+/AtTJ4kT6a1MOMsVKJbw3
         xBhJnJZL4D9VQl+w9Dn/Up7hfA7UGEm4Z2LtMQleLvCb0ncc2rfz47vOIBGtcQhdB1zW
         8ae9RaG3KxtmP2T/k4mJsi8uIKnNHpPh4s3dFQ7EvPs7SR1gOvldrQ/2Q2BMrJ7Nwr1G
         Kp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109232; x=1700714032;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTk7a67S1QtD8sba7dPNc/tDHo+LguzreZvYAY1S4fY=;
        b=iMQQuQ5sbr89gc8z2OY3fS3SaJjeBEsIkoNiQcDrlJWMLYPuQGZW9FvZ5oMuBcbSrC
         munRUzCMOFF2NsTqExqJLCPsg/BWvmf4f2p7Y4mLCw3qRp/Tbez64oAfw4wTnqmzauN7
         q7MGYgg1AQ9Rxv9/XXMCQSRcQrQvOyIIPxPGwzPYAFAlzfV7uHh39wzfxtnuQCefedmq
         MU+tWlm2G69FdRdvD11IyiQK7yzluC1hewelP2+9/NtJwigLGxQ7TreWLao5a7GAe/DT
         QxfRNfpKJWG5lHx2xPXvbAM52Vx53CTW2UEzH0liXBXjuQoPmy6NmJHsytvEOGFew3XZ
         syAQ==
X-Gm-Message-State: AOJu0Yy/29HmZOWm8R+S4ZWpuhtLzOSYd7CLXzasi5+nLv9iH2Sa7Idl
	xE7fNjB8uCP0LF+DykHWUhfP
X-Google-Smtp-Source: AGHT+IE6tK6IBkeFsEiWjCzdnINS6WA30ZUhupFJIZkUjsjh41YBZxyWDozBggH4FWZCSzCDyuP/4g==
X-Received: by 2002:ac8:5706:0:b0:41c:c27e:f8f6 with SMTP id 6-20020ac85706000000b0041cc27ef8f6mr676761qtw.23.1700109232335;
        Wed, 15 Nov 2023 20:33:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id y2-20020ac85242000000b004198f67acbesm4045202qtn.63.2023.11.15.20.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:51 -0500
Message-ID: <f529266a02533411e72d706b908924e8.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM  infrastructure
References: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Remove hardcoded calls to integrity functions from the LSM infrastructure
> and, instead, register them in integrity_lsm_init() with the IMA or EVM
> LSM ID (the first non-NULL returned by ima_get_lsm_id() and
> evm_get_lsm_id()).
> 
> Also move the global declaration of integrity_inode_get() to
> security/integrity/integrity.h, so that the function can be still called by
> IMA.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/integrity.h      | 26 --------------------------
>  security/integrity/iint.c      | 30 +++++++++++++++++++++++++++++-
>  security/integrity/integrity.h |  7 +++++++
>  security/security.c            |  9 +--------
>  4 files changed, 37 insertions(+), 35 deletions(-)

...

> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0b0ac71142e8..882fde2a2607 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -171,7 +171,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   *
>   * Free the integrity information(iint) associated with an inode.
>   */
> -void integrity_inode_free(struct inode *inode)
> +static void integrity_inode_free(struct inode *inode)
>  {
>  	struct integrity_iint_cache *iint;
>  
> @@ -193,11 +193,39 @@ static void iint_init_once(void *foo)
>  	memset(iint, 0, sizeof(*iint));
>  }
>  
> +static struct security_hook_list integrity_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
> +#endif
> +};
> +
> +/*
> + * Perform the initialization of the 'integrity', 'ima' and 'evm' LSMs to
> + * ensure that the management of integrity metadata is working at the time
> + * IMA and EVM hooks are registered to the LSM infrastructure, and to keep
> + * the original ordering of IMA and EVM functions as when they were hardcoded.
> + */
>  static int __init integrity_lsm_init(void)
>  {
> +	const struct lsm_id *lsmid;
> +
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, iint_init_once);
> +	/*
> +	 * Obtain either the IMA or EVM LSM ID to register integrity-specific
> +	 * hooks under that LSM, since there is no LSM ID assigned to the
> +	 * 'integrity' LSM.
> +	 */
> +	lsmid = ima_get_lsm_id();
> +	if (!lsmid)
> +		lsmid = evm_get_lsm_id();
> +	/* No point in continuing, since both IMA and EVM are disabled. */
> +	if (!lsmid)
> +		return 0;
> +
> +	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks), lsmid);

Ooof.  I understand, or at least I think I understand, why the above
hack is needed, but I really don't like the idea of @integrity_hooks
jumping between IMA and EVM depending on how the kernel is configured.

Just to make sure I'm understanding things correctly, the "integrity"
LSM exists to ensure the proper hook ordering between IMA/EVM, shared
metadata management for IMA/EVM, and a little bit of a hack to solve
some kernel module loading issues with signatures.  Is that correct?

I see that patch 23/23 makes some nice improvements to the metadata
management, moving them into LSM security blobs, but it appears that
they are still shared, and thus the requirement is still there for
an "integrity" LSM to manage the shared blobs.

I'd like to hear everyone's honest opinion on this next question: do
we have any hope of separating IMA and EVM so they are independent
(ignore the ordering issues for a moment), or are we always going to
need to have the "integrity" LSM to manage shared resources, hooks,
etc.?

>  	init_ima_lsm();
>  	init_evm_lsm();
>  	return 0;

--
paul-moore.com

