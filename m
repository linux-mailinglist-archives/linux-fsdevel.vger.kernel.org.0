Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2455EB17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiF1Rdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiF1Rdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD82240A1;
        Tue, 28 Jun 2022 10:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4C86198A;
        Tue, 28 Jun 2022 17:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB2C3411D;
        Tue, 28 Jun 2022 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656437630;
        bh=atnO7rgworbFv1hYRHTU5kh7wQv554WyjCmdAGy8NpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T35UGPOEzWfebXO1JjbbtZ5fwx/W9R8DbtJDg5Zwnfr20QqibKkutJfHyPa95Tb08
         MyigS/s43gTu1Mee7sQUIZ5n/IXtA31I5R80/mcpFz6GwW8IyBkGtUOgok7bhXozKi
         Mr0coe9iV+Y1ljjihfNW/G2WU/aoNIFCa6pgLTAXEFzed9WQ1yim1aDMZ2bvrSLvT4
         gBpDKWQa87lcHXDAoxT2kxj4ejCamBCtc/wu54a0uEqRGB/CDZAbVXXwtFBB3y6p+7
         TwukM8oslwpozhYgi37LeY74rnN2EhT69fqiI1SFihilXqEZwJ2aaad5upt2k2uPd6
         qi+MSTC7LCiNg==
Date:   Tue, 28 Jun 2022 19:33:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for
 bpf_getxattr
Message-ID: <20220628173344.h7ihvyl6vuky5xus@wittgenstein>
References: <20220628161948.475097-1-kpsingh@kernel.org>
 <20220628161948.475097-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628161948.475097-6-kpsingh@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:19:48PM +0000, KP Singh wrote:
> A simple test that adds an xattr on a copied /bin/ls and reads it back
> when the copied ls is executed.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/xattr.c     | 37 +++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xattr.c b/tools/testing/selftests/bpf/prog_tests/xattr.c
> new file mode 100644
> index 000000000000..ef07fa8a1763
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xattr.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include <sys/xattr.h>
> +#include "xattr.skel.h"
> +
> +#define XATTR_NAME "security.bpf"
> +#define XATTR_VALUE "test_progs"
> +
> +void test_xattr(void)
> +{
> +	struct xattr *skel = NULL;
> +	char tmp_dir_path[] = "/tmp/xattrXXXXXX";
> +	char tmp_exec_path[64];
> +	char cmd[256];
> +	int err;
> +
> +	if (CHECK_FAIL(!mkdtemp(tmp_dir_path)))
> +		goto close_prog;
> +
> +	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_ls",
> +		 tmp_dir_path);
> +	snprintf(cmd, sizeof(cmd), "cp /bin/ls %s", tmp_exec_path);
> +	if (CHECK_FAIL(system(cmd)))
> +		goto close_prog_rmdir;
> +
> +	if (CHECK_FAIL(setxattr(tmp_exec_path, XATTR_NAME, XATTR_VALUE,
> +			   sizeof(XATTR_VALUE), 0)))
> +		goto close_prog_rmdir;
> +
> +	skel = xattr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_load"))
> +		goto close_prog_rmdir;
> +
> +	err = xattr__attach(skel);
> +	if (!ASSERT_OK(err, "xattr__attach failed"))
> +		goto close_prog_rmdir;
> +
> +	snprintf(cmd, sizeof(cmd), "%s -l", tmp_exec_path);
> +	if (CHECK_FAIL(system(cmd)))
> +		goto close_prog_rmdir;
> +
> +	ASSERT_EQ(skel->bss->result, 1, "xattr result");
> +
> +close_prog_rmdir:
> +	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir_path);
> +	system(cmd);
> +close_prog:
> +	xattr__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xattr.c b/tools/testing/selftests/bpf/progs/xattr.c
> new file mode 100644
> index 000000000000..ccc078fb8ebd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xattr.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define XATTR_NAME "security.bpf"
> +#define XATTR_VALUE "test_progs"
> +
> +__u64 result = 0;
> +
> +extern ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
> +			    const char *name, void *value, int size) __ksym;
> +
> +SEC("lsm.s/bprm_committed_creds")
> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> +{
> +	struct task_struct *current = bpf_get_current_task_btf();
> +	char dir_xattr_value[64] = {0};
> +	int xattr_sz = 0;
> +
> +	xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> +				bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> +				dir_xattr_value, 64);

Yeah, this isn't right. You're not accounting for the caller's userns
nor for the idmapped mount. If this is supposed to work you will need a
variant of vfs_getxattr() that takes the mount's idmapping into account
afaict. See what needs to happen after do_getxattr().
