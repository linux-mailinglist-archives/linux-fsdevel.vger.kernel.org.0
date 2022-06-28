Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6655EAF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiF1RXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiF1RWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614538DB8;
        Tue, 28 Jun 2022 10:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F1561937;
        Tue, 28 Jun 2022 17:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214CC3411D;
        Tue, 28 Jun 2022 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436949;
        bh=AW4NvSDSH3WYN2zjWgwf6ndsawKs4nf7g7OMTdNj0TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmAThDZKaCeBk3WeY/01QFAuLlyrBMop0iKe6RoJwALfnRuIpUvMPHgkPvU3KEC33
         8hP3Wizxq9/12Q88PGFFBBCHzr8xiMtAkJkG/flI8U0EPQw3+7VUPJzvoHgDt4Tt16
         D/5N5EBcqOIdPFWj1eqkAuufEPoCBcVXz9qR87/dYw18dbnSMJleFFX4okkyVSUOvF
         LmZ8z4G5o1UIFEa3qwazaIOfShP/enU3TxtmvKzV0cXx8hNSzVXbbloeSIJvZbhLl5
         T1dHNBMd1OMg+GRguf2jv5IgWDnQLIj+oy/DOsablaaAWBGZ4h8hzRe8wVt4+ySfq9
         ht6sV3ZmltL7w==
Date:   Tue, 28 Jun 2022 19:22:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Message-ID: <20220628172218.yzsrafhoof4wuf45@wittgenstein>
References: <20220628161948.475097-1-kpsingh@kernel.org>
 <20220628161948.475097-5-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628161948.475097-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:19:47PM +0000, KP Singh wrote:
> LSMs like SELinux store security state in xattrs. bpf_getxattr enables
> BPF LSM to implement similar functionality. In combination with
> bpf_local_storage, xattrs can be used to develop more complex security
> policies.
> 
> This kfunc wraps around __vfs_getxattr which can sleep and is,
> therefore, limited to sleepable programs using the newly added
> sleepable_set for kfuncs.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4be976cf7d63..87496d57b099 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -20,6 +20,7 @@
>  #include <linux/fprobe.h>
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
> +#include <linux/xattr.h>
>  
>  #include <net/bpf_sk_storage.h>
>  
> @@ -1181,6 +1182,47 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>  
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs that are used in tracing/LSM BPF programs");
> +
> +ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
> +		     const char *name, void *value, int value__sz)
> +{
> +	return __vfs_getxattr(dentry, inode, name, value, value__sz);

So this might all be due to my ignorance where and how this is supposed
to be used but using __vfs_getxattr() is performing _zero_ permission
checks. That means every eBPF program will be able to retrieve whatever
extended attribute it likes.

In addition to generic permission checking your code also assumes that
every caller is located in the initial user namespace. Is that a valid
assumption?

POSIX ACLs can store additional [u,g]ids on disk that need to be
translated according to the caller's user namespace.

Looking at your selftest example you have a current task and you also
have access to a struct file which makes me doubt that this assumption
is correct. But I'm happy to be convinced otherwise.

Also, if the current task is retrieving extended attributes from an
idmapped mount you also need to take the mount's idmapping into account.
Otherwise again, you'll retrieve misleading [g,u]id values...

Could you explain to me why that is safe and how this is going to be
used, please? As it stands I can't make heads nor tails of this.
