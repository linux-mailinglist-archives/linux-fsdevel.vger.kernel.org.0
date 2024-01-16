Return-Path: <linux-fsdevel+bounces-8075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61682F27E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D1AB23634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211881C6AB;
	Tue, 16 Jan 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo/1JOmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C451CA83;
	Tue, 16 Jan 2024 16:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C53C433F1;
	Tue, 16 Jan 2024 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423065;
	bh=jre5ipGlkss5zAu1aIdBqL+hSwB+mdQlTFI/dlhzA6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qo/1JOmobPmFtak/7HKTx0XejNptaXUIipjwln1OdfT3drLtS0ju3ZCDZ8sbscoY3
	 4w4l/W4KVXVwszFTlZlVW6GiSdpXfV8m2kdN2LXG/LWTRktlE1nXOiKWKVMehdMgq/
	 YSCXgjMlSkfUewRXwJhrywSfxDJPTmgTlXrgty2B2R4paYEzJt9t8abuG6BVMWRbcQ
	 VahL2b5MDPJ3rrb6XOVsaS6+Lz6ihmZIC0J83Hxq6cSQwnTmonnERgAypkCcgBWhY+
	 YG408WTKIX6WfbU2m4LVeQyQnNixVSn84OGSHw8OczrSxWtNm28O0rPGIy/gdCxoq1
	 hwfo9TCSBIXqg==
Date: Tue, 16 Jan 2024 17:37:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240116-gradmesser-labeln-9a1d9918c92e@brauner>
References: <20240109-tausend-tropenhelm-2a9914326249@brauner>
 <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner>
 <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner>
 <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
 <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner>
 <CAEf4Bza7UKjv1Hh_kcyBVJw22LDv4ZNA5uV7+WBdnhsM9O7uGQ@mail.gmail.com>
 <20240112-hetzt-gepard-5110cf759a34@brauner>
 <CAEf4BzYNRNbaNNGRSUCaY3OQrzXPAdR6gGB0PmXhwsn8rUAs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYNRNbaNNGRSUCaY3OQrzXPAdR6gGB0PmXhwsn8rUAs0Q@mail.gmail.com>

On Sat, Jan 13, 2024 at 06:29:33PM -0800, Andrii Nakryiko wrote:
> On Fri, Jan 12, 2024 at 11:17 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > > My point is that the capable logic will walk upwards the user namespace
> > > > hierarchy from the token->userns until the user namespace of the caller
> > > > and terminate when it reached the init_user_ns.
> > > >
> > > > A caller is located in some namespace at the point where they call this
> > > > function. They provided a token. The caller isn't capable in the
> > > > namespace of the token so the function falls back to init_user_ns. Two
> > > > interesting cases:
> > > >
> > > > (1) The caller wasn't in an ancestor userns of the token. If that's the
> > > >     case then it follows that the caller also wasn't in the init_user_ns
> > > >     because the init_user_ns is a descendant of all other user
> > > >     namespaces. So falling back will fail.
> > >
> > > agreed
> > >
> > > >
> > > > (2) The caller was in the same or an ancestor user namespace of the
> > > >     token but didn't have the capability in that user namespace:
> > > >
> > > >      (i) They were in a non-init_user_ns. Therefore they can't be
> > > >          privileged in init_user_ns.
> > > >     (ii) They were in init_user_ns. Therefore, they lacked privileges in
> > > >          the init_user_ns.
> > > >
> > > > In both cases your fallback will do nothing iiuc.
> > >
> > > agreed as well
> > >
> > > And I agree in general that there isn't a *practically useful* case
> > > where this would matter much. But there is still (at least one) case
> > > where there could be a regression: if token is created in
> > > init_user_ns, caller has CAP_BPF in init_user_ns, caller passes that
> > > token to BPF_PROG_LOAD, and LSM policy rejects that token in
> > > security_bpf_token_capable(). Without the above implementation such
> > > operation will be rejected, even though if there was no token passed
> > > it would succeed. With my implementation above it will succeed as
> > > expected.
> >
> > If that's the case then prevent the creation of tokens in the
> > init_user_ns and be done with it. If you fallback anyway then this is
> > the correct solution.
> >
> > Make this change, please. I'm not willing to support this weird fallback
> > stuff which is even hard to reason about.
> 
> Alright, added an extra check. Ok, so in summary I have the changes
> below compared to v1 (plus a few extra LSM-related test cases added):
> 
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index a86fccd57e2d..7d04378560fd 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -9,18 +9,22 @@
>  #include <linux/user_namespace.h>
>  #include <linux/security.h>
> 
> +static bool bpf_ns_capable(struct user_namespace *ns, int cap)
> +{
> +       return ns_capable(ns, cap) || (cap != CAP_SYS_ADMIN &&
> ns_capable(ns, CAP_SYS_ADMIN));
> +}
> +
>  bool bpf_token_capable(const struct bpf_token *token, int cap)
>  {
> -       /* BPF token allows ns_capable() level of capabilities, but only if
> -        * token's userns is *exactly* the same as current user's userns
> -        */
> -       if (token && current_user_ns() == token->userns) {
> -               if (ns_capable(token->userns, cap) ||
> -                   (cap != CAP_SYS_ADMIN && ns_capable(token->userns,
> CAP_SYS_ADMIN)))
> -                       return security_bpf_token_capable(token, cap) == 0;
> -       }
> -       /* otherwise fallback to capable() checks */
> -       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +       struct user_namespace *userns;
> +
> +       /* BPF token allows ns_capable() level of capabilities */
> +       userns = token ? token->userns : &init_user_ns;
> +       if (!bpf_ns_capable(userns, cap))
> +               return false;
> +       if (token && security_bpf_token_capable(token, cap) < 0)
> +               return false;
> +       return true;
>  }
> 
>  void bpf_token_inc(struct bpf_token *token)
> @@ -32,7 +36,7 @@ static void bpf_token_free(struct bpf_token *token)
>  {
>         security_bpf_token_free(token);
>         put_user_ns(token->userns);
> -       kvfree(token);
> +       kfree(token);
>  }
> 
>  static void bpf_token_put_deferred(struct work_struct *work)
> @@ -152,6 +156,12 @@ int bpf_token_create(union bpf_attr *attr)
>                 goto out_path;
>         }
> 
> +       /* Creating BPF token in init_user_ns doesn't make much sense. */
> +       if (current_user_ns() == &init_user_ns) {
> +               err = -EOPNOTSUPP;
> +               goto out_path;
> +       }
> +
>         mnt_opts = path.dentry->d_sb->s_fs_info;
>         if (mnt_opts->delegate_cmds == 0 &&
>             mnt_opts->delegate_maps == 0 &&
> @@ -179,7 +189,7 @@ int bpf_token_create(union bpf_attr *attr)
>                 goto out_path;
>         }
> 
> -       token = kvzalloc(sizeof(*token), GFP_USER);
> +       token = kzalloc(sizeof(*token), GFP_USER);
>         if (!token) {
>                 err = -ENOMEM;
>                 goto out_file;

Thank you! Looks good,

Acked-by: Christian Brauner <brauner@kernel.org>

