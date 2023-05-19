Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B770940D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjESJty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjESJtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3C10D
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 02:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB5260AE3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBD6C4339B;
        Fri, 19 May 2023 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684489790;
        bh=uLp1Xa/PTrZuf7Qm5PZyBRk42+cw5Hq+Y9ckTvf3Mf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdLiw5zgrgLh1u0IJQpgiqcEgeMMuwuY3RQ7O2jUtpzs9SflantracsJcw3EVyIIc
         JnuZeOFY49CnnaRgZjJAUT0a8whi2Tt8ATGxXFxanBNWy75pf6j3Vf63GUm6REKfO7
         aWNJFi3jCNpw89lWooypWbpsIKAfRy1RID/3r97/9xwBFPvgXiMi1/41gStviyNgnA
         JYuhzAFpyqLU6CC0mmhslCXxIM0mceOwYSG2zgVCfZgIxrgb+5TyI4tLLG69SVjUXp
         didJJdPQuUSGWRyaeVE3Wgf/Y90Ura5lfqRhZzloHJuuit7IwMZ7iM51dYfAm2bJ0N
         aiUCrkQ4wBrdg==
Date:   Fri, 19 May 2023 11:49:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
Message-ID: <20230519-eiswasser-leibarzt-ed7e52934486@brauner>
References: <20230518215444.1418789-1-andrii@kernel.org>
 <20230518215444.1418789-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518215444.1418789-2-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 02:54:42PM -0700, Andrii Nakryiko wrote:
> Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> forces users to specify pinning location as a string-based absolute or
> relative (to current working directory) path. This has various
> implications related to security (e.g., symlink-based attacks), forces
> BPF FS to be exposed in the file system, which can cause races with
> other applications.
> 
> One of the feedbacks we got from folks working with containers heavily
> was that inability to use purely FD-based location specification was an
> unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> commands. This patch closes this oversight, adding path_fd field to
> BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> *at() syscalls for dirfd + pathname combinations.
> 
> This now allows interesting possibilities like working with detached BPF
> FS mount (e.g., to perform multiple pinnings without running a risk of
> someone interfering with them), and generally making pinning/getting
> more secure and not prone to any races and/or security attacks.
> 
> This is demonstrated by a selftest added in subsequent patch that takes
> advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> creating detached BPF FS mount, pinning, and then getting BPF map out of
> it, all while never exposing this private instance of BPF FS to outside
> worlds.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  4 ++--
>  include/uapi/linux/bpf.h       | 10 ++++++++++
>  kernel/bpf/inode.c             | 16 ++++++++--------
>  kernel/bpf/syscall.c           | 25 ++++++++++++++++++++-----
>  tools/include/uapi/linux/bpf.h | 10 ++++++++++
>  5 files changed, 50 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 36e4b2d8cca2..f58895830ada 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>  
> -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> -int bpf_obj_get_user(const char __user *pathname, int flags);
> +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
> +int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
>  
>  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
>  #define DEFINE_BPF_ITER_FUNC(target, args...)			\
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1bb11a6ee667..3731284671e4 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1272,6 +1272,9 @@ enum {
>  
>  /* Create a map that will be registered/unregesitered by the backed bpf_link */
>  	BPF_F_LINK		= (1U << 13),
> +
> +/* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
> +	BPF_F_PATH_FD		= (1U << 14),
>  };
>  
>  /* Flags for BPF_PROG_QUERY. */
> @@ -1420,6 +1423,13 @@ union bpf_attr {
>  		__aligned_u64	pathname;
>  		__u32		bpf_fd;
>  		__u32		file_flags;
> +		/* Same as dirfd in openat() syscall; see openat(2)
> +		 * manpage for details of path FD and pathname semantics;
> +		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
> +		 * file_flags field, otherwise it should be set to zero;
> +		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
> +		 */
> +		__u32		path_fd;
>  	};

Thanks for changing that.

This is still odd though because you prevent users from specifying
AT_FDCWD explicitly. They should be allowed to do that plus file
descriptors are signed integers so please s/__u32/__s32/. AT_FDCWD
should be passable anywhere where we have at* semantics. Plus, if in the
vfs we ever add
#define AT_ROOT -200
or something you can't use without coming up with your own custom flags.
If you just follow what everyone else does and use __s32 then you're
good.

File descriptors really need to be signed. There's no way around that.
See io_uring as a good example

io_uring_sqe {
          __u8    opcode;         /* type of operation for this sqe */
          __u8    flags;          /* IOSQE_ flags */
          __u16   ioprio;         /* ioprio for the request */
          __s32   fd;             /* file descriptor to do IO on */
}

where the __s32 fd is used in all fd based requests including
io_openat*() (See io_uring/openclose.c) which are effectively the
semantics you want to emulate here.
