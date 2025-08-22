Return-Path: <linux-fsdevel+bounces-58792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A796B317E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA15A7EBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DBA2FB633;
	Fri, 22 Aug 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bLB3y1oG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mv7pSZfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977F2FB624
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866003; cv=none; b=N5nDiy9QifmMvNmpjA8TXzcqdxcR1ZXeVeG4awFduSUQ9wAyBr0xQ9WPQTiuaN7z6Ccw9FqdXjXcsoMXkO18BOZcD3psWI9bwvgng07hiDaMc9fCLZTzKLIGlyxU5h7bfuZqVqNAad18F0tPL27B2Bk4xcPHi99WFam9BugVmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866003; c=relaxed/simple;
	bh=7nJvkcpQ+lsP1sjG6dEmpvqmMPn2p8ajF3940NAo3TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI5heYVrpmtJskxH2I+cLtLd02W6jNZVHq+wx60Z9ENYErytv117UYhXB3Y/pbPsaz84JghCu9eTP+ypiq1kauZyjY25iN1xJ/z17APwM26liC43UK3uuqWtNaFGP0+sjbTZWnf4kLVPGLPqpOxSjjWyJFiM8MtqXbG7IFq0wWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bLB3y1oG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mv7pSZfn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A82137A015A;
	Fri, 22 Aug 2025 08:33:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 22 Aug 2025 08:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755865999;
	 x=1755952399; bh=N1h28bmnLzTUfsPTCv4I4krq8s3e4hZhOuwUXpzFJY8=; b=
	bLB3y1oGrqH7KdlDuVpJKtWeN4y7hANoBWeeTElCrhacYvy8/1pzst0g1NQWlgRH
	uR28Slxt67yNIrUx5/xn5abytK/EOi9/JUZXeH9QLKHS6Z5kwLJY8p2tg7icWMHE
	VwQDPy7R56LVlrb6s/hxiNsvYrtk2C2o9hKBykT9oeufCOOksXS8GO7BYxZeYo7E
	MhChHfVdaTo23SDnQFV6ZMXY7zTBe77DdlnRdqSC8UkBk4Dn86iT7skkp39jCMJI
	H3qWbt7xhK0uoi3f53G+UJwNHS0TfmKTd/BH4sQW2RmW72Qy5Fif6oX0qVhF496E
	ZxY1dWpUzYPfdZ4hf5mW4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865999; x=
	1755952399; bh=N1h28bmnLzTUfsPTCv4I4krq8s3e4hZhOuwUXpzFJY8=; b=M
	v7pSZfn1pT2qvIQh75+bi/1ixmATx6WfD+ws2tjDTrZfmbIVUSLOCtPTdI4zTJiy
	CaFoJfD/Qm4oRwK9pwbuhTwaYL6gkkAhnm4STVcg28yOW5c56uiRDFH9lTJ8xIq5
	W/jpsTTMLm99Fym8C6pbLrnT6rY173SrbmS1d75Xf9OU5KmR2n3nR8d39WDDvcg2
	FWlvLd2zmpFeICfawHAlTMM7mhGoqRXhmNRssh/6kWqxz7gT+wPSI3/mxsZMgGKC
	TqPE9jkOA5tYBZVW+uCWQ/QYhABxy5vzKh73baoWpflHwxevEhrz8dR6wnM+0CZc
	nNm4Ezmu2WPWujqXLWiPQ==
X-ME-Sender: <xms:j2OoaAwiXj2HUKxnJZDTsVLHKAk8AodziTG3Xf7STJzR2xWXPnvXcg>
    <xme:j2OoaPzZzSHzIMjJTN94KiUmxxgl88aROWR8wysZu3WbtJa9fOyGzgJfKeL8JRFkF
    dRUOADC7e_ylxLG>
X-ME-Received: <xmr:j2OoaIxib1jTQzP2EEO4sfz1EhgwKZSJ-jABeZKk95DNt2RniigBOGWEtkcYCndc6qRa83y3j2J6ehCPLIKcDovdG_M7dC3cWonbzCpUxdQI9S4tEIUr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    horghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnsehg
    rhhovhgvshdrnhgvth
X-ME-Proxy: <xmx:j2OoaJZ6HDC_bfh2tE1-A17Ed8oKbW_0W7U94eb3EpaaWkWhw7BdUg>
    <xmx:j2OoaJVPhyySTAniBpU3ocCpnfGuIkN4aAoMwLh6_4JQkVdjoyR_zw>
    <xmx:j2OoaHgIsnCWZUUtUSnO845kGm8ia4gWKjpkxQEaGZAnJGnkf56jvw>
    <xmx:j2OoaHusesVDLVOAfWMz_3HxNUTeMT__zRx9B1wttgEJqiBkgTTNsw>
    <xmx:j2OoaHoszyhsEZXtOes0pFpvUjhF6h1kpzeurMTVv3H9_lbyNX6C0u5j>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:33:18 -0400 (EDT)
Message-ID: <4dda12a5-e676-4733-bbf7-ee1eb9e4a6d0@bsbernd.com>
Date: Fri, 22 Aug 2025 14:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>
References: <20250822114436.438844-1-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250822114436.438844-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 13:44, Miklos Szeredi wrote:
> FUSE_INIT has always been asynchronous with mount.  That means that the
> server processed this request after the mount syscall returned.
> 
> This means that FUSE_INIT can't supply the root inode's ID, hence it
> currently has a hardcoded value.  There are other limitations such as not
> being able to perform getxattr during mount, which is needed by selinux.
> 
> To remove these limitations allow server to process FUSE_INIT while
> initializing the in-core super block for the fuse filesystem.  This can
> only be done if the server is prepared to handle this, so add
> FUSE_DEV_IOC_SYNC_INIT ioctl, which
> 
>  a) lets the server know whether this feature is supported, returning
>  ENOTTY othewrwise.
> 
>  b) lets the kernel know to perform a synchronous initialization
> 
> The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
> only during super block creation.  This is solved by setting the private
> data of the fuse device file to a special value ((struct fuse_dev *) 1) and
> waiting for this to be turned into a proper fuse_dev before commecing with
> operations on the device file.

I really like the ida. Another reason is that fuse-server might want to
abort during FUSE_INIT and it then leaves a stale mount that in worst
case might have gotten requests already.

> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> I tested this with my raw-interface tester, so no libfuse update yet.  Will
> work on that next.
> 
>  fs/fuse/cuse.c            |  3 +-
>  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
>  fs/fuse/dev_uring.c       |  4 +--
>  fs/fuse/fuse_dev_i.h      | 13 +++++--
>  fs/fuse/fuse_i.h          |  3 ++
>  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
>  include/uapi/linux/fuse.h |  1 +
>  7 files changed, 112 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index b39844d75a80..28c96961e85d 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -52,6 +52,7 @@
>  #include <linux/user_namespace.h>
>  
>  #include "fuse_i.h"
> +#include "fuse_dev_i.h"
>  
>  #define CUSE_CONNTBL_LEN	64
>  
> @@ -547,7 +548,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
>   */
>  static int cuse_channel_release(struct inode *inode, struct file *file)
>  {
> -	struct fuse_dev *fud = file->private_data;
> +	struct fuse_dev *fud = __fuse_get_dev(file);
>  	struct cuse_conn *cc = fc_to_cc(fud->fc);
>  
>  	/* remove from the conntbl, no more access from this point on */
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 8ac074414897..948f45c6e0ef 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +struct fuse_dev *fuse_get_dev(struct file *file)
> +{
> +	struct fuse_dev *fud = __fuse_get_dev(file);
> +	int err;
> +
> +	if (likely(fud))
> +		return fud;
> +
> +	err = wait_event_interruptible(fuse_dev_waitq,
> +				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	fud = __fuse_get_dev(file);
> +	if (!fud)
> +		return ERR_PTR(-EPERM);
> +
> +	return fud;
> +}
> +
>  static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct fuse_copy_state cs;
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_dev *fud = fuse_get_dev(file);
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	if (!user_backed_iter(to))
>  		return -EINVAL;
> @@ -1557,8 +1577,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
>  	struct fuse_copy_state cs;
>  	struct fuse_dev *fud = fuse_get_dev(in);
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
>  			      GFP_KERNEL);
> @@ -2233,8 +2253,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
>  	struct fuse_copy_state cs;
>  	struct fuse_dev *fud = fuse_get_dev(iocb->ki_filp);
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	if (!user_backed_iter(from))
>  		return -EINVAL;
> @@ -2258,8 +2278,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>  	ssize_t ret;
>  
>  	fud = fuse_get_dev(out);
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	pipe_lock(pipe);
>  
> @@ -2343,7 +2363,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
>  	struct fuse_iqueue *fiq;
>  	struct fuse_dev *fud = fuse_get_dev(file);
>  
> -	if (!fud)
> +	if (IS_ERR(fud))
>  		return EPOLLERR;
>  
>  	fiq = &fud->fc->iq;
> @@ -2490,7 +2510,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
>  
>  int fuse_dev_release(struct inode *inode, struct file *file)
>  {
> -	struct fuse_dev *fud = fuse_get_dev(file);
> +	struct fuse_dev *fud = __fuse_get_dev(file);
>  
>  	if (fud) {
>  		struct fuse_conn *fc = fud->fc;
> @@ -2521,8 +2541,8 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
>  {
>  	struct fuse_dev *fud = fuse_get_dev(file);
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	/* No locking - fasync_helper does its own locking */
>  	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
> @@ -2532,7 +2552,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
>  {
>  	struct fuse_dev *fud;
>  
> -	if (new->private_data)
> +	if (__fuse_get_dev(new))
>  		return -EINVAL;
>  
>  	fud = fuse_dev_alloc_install(fc);
> @@ -2563,7 +2583,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
>  	 * uses the same ioctl handler.
>  	 */
>  	if (fd_file(f)->f_op == file->f_op)
> -		fud = fuse_get_dev(fd_file(f));
> +		fud = __fuse_get_dev(fd_file(f));
>  
>  	res = -EINVAL;
>  	if (fud) {
> @@ -2581,8 +2601,8 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
>  	struct fuse_dev *fud = fuse_get_dev(file);
>  	struct fuse_backing_map map;
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		return -EOPNOTSUPP;
> @@ -2598,8 +2618,8 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>  	struct fuse_dev *fud = fuse_get_dev(file);
>  	int backing_id;
>  
> -	if (!fud)
> -		return -EPERM;
> +	if (IS_ERR(fud))
> +		return PTR_ERR(fud);
>  
>  	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		return -EOPNOTSUPP;
> @@ -2610,6 +2630,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>  	return fuse_backing_close(fud->fc, backing_id);
>  }
>  
> +static long fuse_dev_ioctl_sync_init(struct file *file)
> +{
> +	int err = -EINVAL;
> +
> +	mutex_lock(&fuse_mutex);
> +	if (!__fuse_get_dev(file)) {
> +		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> +		err = 0;
> +	}
> +	mutex_unlock(&fuse_mutex);
> +	return err;
> +}
> +
>  static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  			   unsigned long arg)
>  {
> @@ -2625,6 +2658,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case FUSE_DEV_IOC_BACKING_CLOSE:
>  		return fuse_dev_ioctl_backing_close(file, argp);
>  
> +	case FUSE_DEV_IOC_SYNC_INIT:
> +		return fuse_dev_ioctl_sync_init(file);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -2633,7 +2669,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  #ifdef CONFIG_PROC_FS
>  static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
>  {
> -	struct fuse_dev *fud = fuse_get_dev(file);
> +	struct fuse_dev *fud = __fuse_get_dev(file);
>  	if (!fud)
>  		return;
>  
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1..bef38ed78249 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1139,9 +1139,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		return -EINVAL;
>  
>  	fud = fuse_get_dev(cmd->file);
> -	if (!fud) {
> +	if (IS_ERR(fud)) {
>  		pr_info_ratelimited("No fuse device found\n");
> -		return -ENOTCONN;
> +		return PTR_ERR(fud);
>  	}
>  	fc = fud->fc;
>  
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 5a9bd771a319..6e8373f97040 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -12,6 +12,8 @@
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
>  #define FUSE_REQ_ID_STEP (1ULL << 1)
>  
> +extern struct wait_queue_head fuse_dev_waitq;
> +
>  struct fuse_arg;
>  struct fuse_args;
>  struct fuse_pqueue;
> @@ -37,15 +39,22 @@ struct fuse_copy_state {
>  	} ring;
>  };
>  
> -static inline struct fuse_dev *fuse_get_dev(struct file *file)
> +#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
> +#define FUSE_DEV_PTR_MASK (~1UL)
> +
> +static inline struct fuse_dev *__fuse_get_dev(struct file *file)
>  {
>  	/*
>  	 * Lockless access is OK, because file->private data is set
>  	 * once during mount and is valid until the file is released.
>  	 */
> -	return READ_ONCE(file->private_data);
> +	struct fuse_dev *fud = READ_ONCE(file->private_data);
> +
> +	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
>  }
>  
> +struct fuse_dev *fuse_get_dev(struct file *file);
> +
>  unsigned int fuse_req_hash(u64 unique);
>  struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 486fa550c951..54121207cfb2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -904,6 +904,9 @@ struct fuse_conn {
>  	/* Is link not implemented by fs? */
>  	unsigned int no_link:1;
>  
> +	/* Is synchronous FUSE_INIT allowed? */
> +	unsigned int sync_init:1;
> +
>  	/* Use io_uring for communication */
>  	unsigned int io_uring;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9d26a5bc394d..d5f9f2abc569 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -7,6 +7,7 @@
>  */
>  
>  #include "fuse_i.h"
> +#include "fuse_dev_i.h"
>  #include "dev_uring_i.h"
>  
>  #include <linux/dax.h>
> @@ -34,6 +35,7 @@ MODULE_LICENSE("GPL");
>  static struct kmem_cache *fuse_inode_cachep;
>  struct list_head fuse_conn_list;
>  DEFINE_MUTEX(fuse_mutex);
> +DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
>  
>  static int set_global_limit(const char *val, const struct kernel_param *kp);
>  
> @@ -1466,7 +1468,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  	wake_up_all(&fc->blocked_waitq);
>  }
>  
> -void fuse_send_init(struct fuse_mount *fm)
> +static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
>  {
>  	struct fuse_init_args *ia;
>  	u64 flags;
> @@ -1525,8 +1527,15 @@ void fuse_send_init(struct fuse_mount *fm)
>  	ia->args.out_args[0].value = &ia->out;
>  	ia->args.force = true;
>  	ia->args.nocreds = true;
> -	ia->args.end = process_init_reply;
>  
> +	return ia;
> +}
> +
> +void fuse_send_init(struct fuse_mount *fm)
> +{

I'm going to review more carefully later on, but how about renaming
this to fuse_send_bg_init()?

> +	struct fuse_init_args *ia = fuse_new_init(fm);
> +
> +	ia->args.end = process_init_reply;
>  	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
>  		process_init_reply(fm, &ia->args, -ENOTCONN);



Thanks,
Bernd

