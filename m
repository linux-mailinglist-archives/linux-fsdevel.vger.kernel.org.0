Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE45ED00C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiI0WHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 18:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI0WHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:07:31 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADEA1B2D2F;
        Tue, 27 Sep 2022 15:07:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5CBCC110285E;
        Wed, 28 Sep 2022 08:07:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1odIja-00CvbN-B6; Wed, 28 Sep 2022 08:07:22 +1000
Date:   Wed, 28 Sep 2022 08:07:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 12/26] fuse-bpf: Add support for fallocate
Message-ID: <20220927220722.GA2703033@dread.disaster.area>
References: <20220926231822.994383-1-drosen@google.com>
 <20220926231822.994383-13-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926231822.994383-13-drosen@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=6333741e
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8
        a=q6eTjzhBop4zoYTBT1cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:18:08PM -0700, Daniel Rosenberg wrote:
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  fs/fuse/backing.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/file.c    | 10 ++++++++++
>  fs/fuse/fuse_i.h  | 11 +++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 97e92c633cfd..95c60d6d7597 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -188,6 +188,54 @@ ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
>  	return ret;
>  }
>  
> +int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
> +				      struct fuse_fallocate_in *ffi,
> +				      struct file *file, int mode, loff_t offset, loff_t length)
> +{
> +	struct fuse_file *ff = file->private_data;
> +
> +	*ffi = (struct fuse_fallocate_in) {
> +		.fh = ff->fh,
> +		.offset = offset,
> +		.length = length,
> +		.mode = mode,
> +	};
> +
> +	*fa = (struct bpf_fuse_args) {
> +		.opcode = FUSE_FALLOCATE,
> +		.nodeid = ff->nodeid,
> +		.in_numargs = 1,
> +		.in_args[0].size = sizeof(*ffi),
> +		.in_args[0].value = ffi,
> +	};
> +
> +	return 0;
> +}
> +
> +int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
> +				       struct fuse_fallocate_in *ffi,
> +				       struct file *file, int mode, loff_t offset, loff_t length)
> +{
> +	return 0;
> +}
> +
> +int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
> +				struct file *file, int mode, loff_t offset, loff_t length)
> +{
> +	const struct fuse_fallocate_in *ffi = fa->in_args[0].value;
> +	struct fuse_file *ff = file->private_data;
> +
> +	*out = vfs_fallocate(ff->backing_file, ffi->mode, ffi->offset,
> +			     ffi->length);
> +	return 0;
> +}
> +
> +int fuse_file_fallocate_finalize(struct bpf_fuse_args *fa, int *out,
> +				 struct file *file, int mode, loff_t offset, loff_t length)
> +{
> +	return 0;
> +}
> +
>  /*******************************************************************************
>   * Directory operations after here                                             *
>   ******************************************************************************/
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index dd4485261cc7..ef6f6b0b3b59 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3002,6 +3002,16 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  
>  	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
>  
> +#ifdef CONFIG_FUSE_BPF
> +	if (fuse_bpf_backing(inode, struct fuse_fallocate_in, err,
> +			       fuse_file_fallocate_initialize_in,
> +			       fuse_file_fallocate_initialize_out,
> +			       fuse_file_fallocate_backing,
> +			       fuse_file_fallocate_finalize,
> +			       file, mode, offset, length))
> +		return err;
> +#endif

As I browse through this series, I find this pattern unnecessarily
verbose and it exposes way too much of the filtering mechanism to
code that should not have to know anything about it.

Wouldn't it be better to code this as:

	error = fuse_filter_fallocate(file, mode, offset, length);
	if (error < 0)
		return error;


And then make this fuse_bpf_backing() call and all the indirect
functions it uses internal (i.e. static) in fs/fuse/backing.c?

That way the interface in fs/fuse/fuse_i.h can be much cleaner and
handle the #ifdef CONFIG_FUSE_BPF directly by:

#ifdef CONFIG_FUSE_BPF
....
int fuse_filter_fallocate(file, mode, offset, length);
....
#else /* !CONFIG_FUSE_BPF */
....
static inline fuse_filter_fallocate(file, mode, offset, length)
{
	return 0;
}
....
#endif /* CONFIG_FUSE_BPF */

This seems much cleaner to me than exposing fuse_bpf_backing()
boiler plate all over the code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
