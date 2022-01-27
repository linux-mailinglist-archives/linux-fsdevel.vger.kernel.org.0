Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420E649E97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 18:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiA0R4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:39 -0500
Received: from namei.org ([65.99.196.166]:52994 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244907AbiA0Rz7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:59 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 12:55:58 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 600C71BC;
        Thu, 27 Jan 2022 17:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 600C71BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1643304809; bh=AGzt62snnTX+RhaQRcauWWHyp7x7hKo4JgECX14Qns0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OG0fZTdVPXr4s6bgq6Xx/7z/4tXB6PztAloBvarfSfkiTtlldoPyQcpvAuukv6ljv
         FO16pBmarlXoFiA6tCsZCl0rJ/Py/sbxZxH7mcl08HhxtyGTH9xiUzEqtPc2+/mjps
         rErYzBTGmXdVGf67tiaUOLeSoNUzY5/aCy0aS2So=
Date:   Fri, 28 Jan 2022 04:33:29 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] LSM: general protection fault in legacy_parse_param
In-Reply-To: <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
Message-ID: <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com> <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein> <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
 <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com> <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jan 2022, Casey Schaufler wrote:

> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> a security module may return an error code indicating that it does not
> recognize an input.  In this particular case Smack sees a mount option
> that it recognizes, and returns 0. A call to a BPF hook follows, which
> returns -ENOPARAM, which confuses the caller because Smack has processed
> its data.
> 
> The SELinux hook incorrectly returns 1 on success. There was a time
> when this was correct, however the current expectation is that it
> return 0 on success. This is repaired.
> 
> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  security/security.c      | 17 +++++++++++++++--
>  security/selinux/hooks.c |  5 ++---
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 3d4eb474f35b..e649c8691be2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -884,9 +884,22 @@ int security_fs_context_dup(struct fs_context *fc, struct
> fs_context *src_fc)
>  	return call_int_hook(fs_context_dup, 0, fc, src_fc);
>  }
>  
> -int security_fs_context_parse_param(struct fs_context *fc, struct
> fs_parameter *param)
> +int security_fs_context_parse_param(struct fs_context *fc,
> +				    struct fs_parameter *param)
>  {
> -	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
> +	struct security_hook_list *hp;
> +	int trc;
> +	int rc = -ENOPARAM;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> +			     list) {
> +		trc = hp->hook.fs_context_parse_param(fc, param);
> +		if (trc == 0)
> +			rc = 0;
> +		else if (trc != -ENOPARAM)
> +			return trc;
> +	}
> +	return rc;
>  }
>  
>  int security_sb_alloc(struct super_block *sb)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..371f67a37f9a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2860,10 +2860,9 @@ static int selinux_fs_context_parse_param(struct
> fs_context *fc,
>  		return opt;
>  
>  	rc = selinux_add_opt(opt, param->string, &fc->security);
> -	if (!rc) {
> +	if (!rc)
>  		param->string = NULL;
> -		rc = 1;
> -	}
> +
>  	return rc;
>  }
>  
> 
> 

-- 
James Morris
<jmorris@namei.org>

