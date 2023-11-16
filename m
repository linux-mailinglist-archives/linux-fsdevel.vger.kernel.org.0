Return-Path: <linux-fsdevel+bounces-2935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF327EDAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FA01C209E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1715D29C;
	Thu, 16 Nov 2023 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OueZXl8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F84D49
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77ba6d5123fso136382285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109230; x=1700714030; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkyYJfnzm1A7HGn47wCcQYDeiYTgoVSzUDXfMA9+Fmw=;
        b=OueZXl8NzyZo8bZgJea+dZmFlLJjO74Ra2CopP/Qgur/mLt0dhmZVdCDsqNeS4ip94
         UIBt6XDH7viAJ4m2+9I7XFVAWX7TJV/IWqS6Kd5F9txUgeL4Dekfo7BRAmjwdmgEE/s1
         +TmoXy5u4Kbk/gF02UeYMmMlYOkMluVfkbnmWz5e8TLWygyFBFKyJXaFRk+xPt1EcHdV
         MBdP6pJ3r5Vx4PWcLf3BWAzuYy4hQntcXLEpGxcW+78Rdho7TZ85xn06h6NAgk/8rWlq
         FueizRW4rNkDdsMjbmKAnMlt2K7cgjMZ+Bet58IGWy17Imr5Gm67PEfZB0eW9hN8snud
         utqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109230; x=1700714030;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkyYJfnzm1A7HGn47wCcQYDeiYTgoVSzUDXfMA9+Fmw=;
        b=Bn13IfJyturwvFlnUV353luqf1O+ITyttUVJsiutjJosncRSnU2eHnm/Q4GelR9AC6
         jWiF2YAmNNFB+RsMBaPNj8w5RqW1aIeTp3ovKDGP3GxzJMUy0gBW7shHUHXE8mxd85gg
         lthepRP3BlJcqaeXq1PCDcUtsaTH/o3I63sRL0TmUwxbyORk4pRpeahyTU1sT33pelyw
         Vr62kDB3GrKWvV4+HtbC1ogpz+5rJz1l699YTTNKYnFjJI+ERjaFpl/9+lwYe3TXahGP
         LoTyme8ix0ayW1huhluiYT+1NYUvDkalLM5efa9Yd5MaYUy822PK/k2ei8cz2K1T+YRO
         0IsQ==
X-Gm-Message-State: AOJu0YxfYRhVAUGHNAksBVZlHaRsmjSkPFe3hiuOHF9FujTZ8RG9n8qg
	lRGHl3CAfkkcIg8ERxrwz3K6
X-Google-Smtp-Source: AGHT+IGRS7nQEJCXY6T/nN7yC1vAx+U0DJtezCw7jd5lMHyaQY5xg8Dk8QLP0DAu6DJyxDh395lJwA==
X-Received: by 2002:a05:620a:19a8:b0:76f:1614:577a with SMTP id bm40-20020a05620a19a800b0076f1614577amr844860qkb.5.1700109230369;
        Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bi33-20020a05620a31a100b0077703f31496sm4001433qkb.92.2023.11.15.20.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:49 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:49 -0500
Message-ID: <add2fed4552b4cbc2919caf54e97646d.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 16/23] security: Introduce inode_post_set_acl hook
References: <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
> 
> At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
> POSIX ACL and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index ca650c285fd9..d2dbea54a63a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2350,6 +2350,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>  }
>  
> +/**
> + * security_inode_post_set_acl() - Update inode security from posix acls set
> + * @dentry: file
> + * @acl_name: acl name
> + * @kacl: acl struct
> + *
> + * Update inode security data after successfully setting posix acls on @dentry.
> + * The posix acls in @kacl are identified by @acl_name.
> + */
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

Another case where the existing evm_inode_post_set_acl() hook doesn't
check S_PRIVATE but this hook does.

> +	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
> +}
> +
>  /**
>   * security_inode_get_acl() - Check if reading posix acls is allowed
>   * @idmap: idmap of the mount
> -- 
> 2.34.1

--
paul-moore.com

