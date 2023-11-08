Return-Path: <linux-fsdevel+bounces-2388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77E7E5827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D86281263
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A79199BA;
	Wed,  8 Nov 2023 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+gxhwql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA519468;
	Wed,  8 Nov 2023 13:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B39C433C8;
	Wed,  8 Nov 2023 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699451507;
	bh=ZMSscZxw4l4aURw1F5+SZTr6ghqL/5J9z/+heAnmCLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+gxhwql72aOlgDfZs+oY4rjQBHw4cFcOWZMLxX5KrRnMKpY9NHNxCFrxAEynV74c
	 xZtLyeTlh3Oz0VvEPH7K8m4UUgXrvXWjlVCqPfvOICippPr4j+pBWduPCNPzpP5uSq
	 m1z9nOU6eyc1IZd5/CoA+8X/068Br7DREy0ThNpOAp2YkOiNUD0XZlcBQdDJ2OmYJD
	 aLQZ18NHUJqYIiRcg7LVF3mkp2qb9kJeviutPeBPas/Dhh5ojn/4YAhW45EM0FV5Zx
	 tXib9xEnrgg4Ha5MzE9fEJJpolNo5Xnc+o8gEpg2SZZIiCuOonXX1V3mvusZ+lb/HZ
	 Ff2I+PZ9y+NrQ==
Date: Wed, 8 Nov 2023 14:51:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
Message-ID: <20231108-ungeeignet-uhren-698f16b4b36b@brauner>
References: <20231103190523.6353-1-andrii@kernel.org>
 <20231103190523.6353-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103190523.6353-3-andrii@kernel.org>

On Fri, Nov 03, 2023 at 12:05:08PM -0700, Andrii Nakryiko wrote:
> Add few new mount options to BPF FS that allow to specify that a given
> BPF FS instance allows creation of BPF token (added in the next patch),
> and what sort of operations are allowed under BPF token. As such, we get
> 4 new mount options, each is a bit mask
>   - `delegate_cmds` allow to specify which bpf() syscall commands are
>     allowed with BPF token derived from this BPF FS instance;
>   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
>     a set of allowable BPF map types that could be created with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
>     a set of allowable BPF program types that could be loaded with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
>     a set of allowable BPF program attach types that could be loaded with
>     BPF token; delegate_progs and delegate_attachs are meant to be used
>     together, as full BPF program type is, in general, determined
>     through both program type and program attach type.
> 
> Currently, these mount options accept the following forms of values:
>   - a special value "any", that enables all possible values of a given
>   bit set;
>   - numeric value (decimal or hexadecimal, determined by kernel
>   automatically) that specifies a bit mask value directly;
>   - all the values for a given mount option are combined, if specified
>   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
>   delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
>   mask.
> 
> Ideally, more convenient (for humans) symbolic form derived from
> corresponding UAPI enums would be accepted (e.g., `-o
> delegate_progs=kprobe|tracepoint`) and I intend to implement this, but
> it requires a bunch of UAPI header churn, so I postponed it until this
> feature lands upstream or at least there is a definite consensus that
> this feature is acceptable and is going to make it, just to minimize
> amount of wasted effort and not increase amount of non-essential code to
> be reviewed.
> 
> Attentive reader will notice that BPF FS is now marked as
> FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
> user namespace as long as the process has sufficient *namespaced*
> capabilities within that user namespace. But in reality we still
> restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *in
> init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is added
> to allow creating BPF FS context object (i.e., fsopen("bpf")) from
> inside unprivileged process inside non-init userns, to capture that
> userns as the owning userns. It will still be required to pass this
> context object back to privileged process to instantiate and mount it.
> 
> This manipulation is important, because capturing non-init userns as the
> owning userns of BPF FS instance (super block) allows to use that userns
> to constraint BPF token to that userns later on (see next patch). So
> creating BPF FS with delegation inside unprivileged userns will restrict
> derived BPF token objects to only "work" inside that intended userns,
> making it scoped to a intended "container".
> 
> There is a set of selftests at the end of the patch set that simulates
> this sequence of steps and validates that everything works as intended.
> But careful review is requested to make sure there are no missed gaps in
> the implementation and testing.
> 
> All this is based on suggestions and discussions with Christian Brauner
> ([0]), to the best of my ability to follow all the implications.

"who will not be held responsible for any CVE future or present as he's
 not sure whether bpf token is a good idea in general"

I'm not opposing it because it's really not my subsystem. But it'd be
nice if you also added a disclaimer that I'm not endorsing this. :)

A comment below.

> 
>   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h | 10 ++++++
>  kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..df50a7bf1a77 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1562,6 +1562,16 @@ struct bpf_link_primer {
>  	u32 id;
>  };
>  
> +struct bpf_mount_opts {
> +	umode_t mode;
> +
> +	/* BPF token-related delegation options */
> +	u64 delegate_cmds;
> +	u64 delegate_maps;
> +	u64 delegate_progs;
> +	u64 delegate_attachs;
> +};
> +
>  struct bpf_struct_ops_value;
>  struct btf_member;
>  
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 1aafb2ff2e95..e49e93bc65e3 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -20,6 +20,7 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
> +#include <linux/kstrtox.h>
>  #include "preload/bpf_preload.h"
>  
>  enum bpf_type {
> @@ -599,10 +600,31 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
>   */
>  static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  {
> +	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
>  	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
>  
>  	if (mode != S_IRWXUGO)
>  		seq_printf(m, ",mode=%o", mode);
> +
> +	if (opts->delegate_cmds == ~0ULL)
> +		seq_printf(m, ",delegate_cmds=any");
> +	else if (opts->delegate_cmds)
> +		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
> +
> +	if (opts->delegate_maps == ~0ULL)
> +		seq_printf(m, ",delegate_maps=any");
> +	else if (opts->delegate_maps)
> +		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
> +
> +	if (opts->delegate_progs == ~0ULL)
> +		seq_printf(m, ",delegate_progs=any");
> +	else if (opts->delegate_progs)
> +		seq_printf(m, ",delegate_progs=0x%llx", opts->delegate_progs);
> +
> +	if (opts->delegate_attachs == ~0ULL)
> +		seq_printf(m, ",delegate_attachs=any");
> +	else if (opts->delegate_attachs)
> +		seq_printf(m, ",delegate_attachs=0x%llx", opts->delegate_attachs);
>  	return 0;
>  }
>  
> @@ -626,22 +648,27 @@ static const struct super_operations bpf_super_ops = {
>  
>  enum {
>  	OPT_MODE,
> +	OPT_DELEGATE_CMDS,
> +	OPT_DELEGATE_MAPS,
> +	OPT_DELEGATE_PROGS,
> +	OPT_DELEGATE_ATTACHS,
>  };
>  
>  static const struct fs_parameter_spec bpf_fs_parameters[] = {
>  	fsparam_u32oct	("mode",			OPT_MODE),
> +	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
> +	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
> +	fsparam_string	("delegate_progs",		OPT_DELEGATE_PROGS),
> +	fsparam_string	("delegate_attachs",		OPT_DELEGATE_ATTACHS),
>  	{}
>  };
>  
> -struct bpf_mount_opts {
> -	umode_t mode;
> -};
> -
>  static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	struct bpf_mount_opts *opts = fc->fs_private;
> +	struct bpf_mount_opts *opts = fc->s_fs_info;
>  	struct fs_parse_result result;
> -	int opt;
> +	int opt, err;
> +	u64 msk;
>  
>  	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
>  	if (opt < 0) {
> @@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case OPT_MODE:
>  		opts->mode = result.uint_32 & S_IALLUGO;
>  		break;
> +	case OPT_DELEGATE_CMDS:
> +	case OPT_DELEGATE_MAPS:
> +	case OPT_DELEGATE_PROGS:
> +	case OPT_DELEGATE_ATTACHS:
> +		if (strcmp(param->string, "any") == 0) {
> +			msk = ~0ULL;
> +		} else {
> +			err = kstrtou64(param->string, 0, &msk);
> +			if (err)
> +				return err;
> +		}
> +		switch (opt) {
> +		case OPT_DELEGATE_CMDS: opts->delegate_cmds |= msk; break;
> +		case OPT_DELEGATE_MAPS: opts->delegate_maps |= msk; break;
> +		case OPT_DELEGATE_PROGS: opts->delegate_progs |= msk; break;
> +		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |= msk; break;
> +		default: return -EINVAL;
> +		}
> +		break;
>  	}

So just to repeat that this will allow a container to set it's own
delegation options:

        # unprivileged container

        fd_fs = fsopen();
        fsconfig(fd_fs, FSCONFIG_BLA_BLA, "give-me-all-the-delegation");

        # Now hand of that fd_fs to a privileged process

        fsconfig(fd_fs, FSCONFIG_CREATE_CMD, ...)

This means the container manager can't be part of your threat model
because you need to trust it to set delegation options.

But if the container manager is part of your threat model then you can
never trust an fd_fs handed to you because the container manager might
have enabled arbitrary delegation privileges.

There's ways around this:

(1) kernel: Account for this in the kernel and require privileges when
    setting delegation options.
(2) userspace: A trusted helper that allocates an fs_context fd in
    the target user namespace, then sets delegation options and creates
    superblock.

(1) Is more restrictive but also more secure. (2) is less restrictive
but requires more care from userspace.

Either way I would probably consider writing a document detailing
various delegation scenarios and possible pitfalls and implications
before advertising it.

If you choose (2) then you also need to be aware that the security of
this also hinges on bpffs not allowing to reconfigure parameters once it
has been mounted. Otherwise an unprivileged container can change
delegation options.

I would recommend that you either add a dummy bpf_reconfigure() method
with a comment in it or you add a comment on top of bpf_context_ops.
Something like:

/*
 * Unprivileged mounts of bpffs are owned by the user namespace they are
 * mounted in. That means unprivileged users can change vfs mount
 * options (ro<->rw, nosuid, etc.).
 *
 * They currently cannot change bpffs specific mount options such as
 * delegation settings. If that is ever implemented it is necessary to
 * require rivileges in the initial namespace. Otherwise unprivileged
 * users can change delegation options to whatever they want.
 */

