Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A042A22E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhJLKeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 06:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhJLKeu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:34:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 553E660E53;
        Tue, 12 Oct 2021 10:32:46 +0000 (UTC)
Date:   Tue, 12 Oct 2021 12:32:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
Message-ID: <20211012103243.xumzerhvhklqrovj@wittgenstein>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> a security module may return an error code indicating that it does not
> recognize an input.  In this particular case Smack sees a mount option
> that it recognizes, and returns 0. A call to a BPF hook follows, which
> returns -ENOPARAM, which confuses the caller because Smack has processed
> its data.
> 
> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

Thanks!
Note, I think that we still have the SELinux issue we discussed in the
other thread:

	rc = selinux_add_opt(opt, param->string, &fc->security);
	if (!rc) {
		param->string = NULL;
		rc = 1;
	}

SELinux returns 1 not the expected 0. Not sure if that got fixed or is
queued-up for -next. In any case, this here seems correct independent of
that:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 09533cbb7221..3cf0faaf1c5b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
>  
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
> 
> 
