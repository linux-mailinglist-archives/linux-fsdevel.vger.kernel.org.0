Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853832AD43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 05:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfE0DKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 23:10:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:7279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfE0DKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 23:10:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 20:10:39 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2019 20:10:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hV621-0001sI-SE; Mon, 27 May 2019 11:10:37 +0800
Date:   Mon, 27 May 2019 11:09:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Renzo Davoli <renzo@cs.unibo.it>
Cc:     kbuild-all@01.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <201905271138.mTyXQ9sH%lkp@intel.com>
References: <20190526142521.GA21842@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526142521.GA21842@cs.unibo.it>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Renzo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc2 next-20190524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Renzo-Davoli/eventfd-new-tag-EFD_VPOLL-generate-epoll-events/20190527-023620
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/eventfd.c:321:27: sparse: sparse: restricted __poll_t degrades to integer
>> fs/eventfd.c:321:16: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __poll_t [usertype] events @@    got poll_t [usertype] events @@
>> fs/eventfd.c:321:16: sparse:    expected restricted __poll_t [usertype] events
>> fs/eventfd.c:321:16: sparse:    got unsigned long long
   fs/eventfd.c:357:25: sparse: sparse: restricted __poll_t degrades to integer
>> fs/eventfd.c:359:27: sparse: sparse: cast from restricted __poll_t
   fs/eventfd.c:367:44: sparse: sparse: restricted __poll_t degrades to integer
>> fs/eventfd.c:375:17: sparse: sparse: cast to restricted __poll_t
>> fs/eventfd.c:512:28: sparse: sparse: invalid assignment: &=
>> fs/eventfd.c:512:28: sparse:    left side has type unsigned long long
>> fs/eventfd.c:512:28: sparse:    right side has type restricted __poll_t

vim +321 fs/eventfd.c

   310	
   311	static __poll_t eventfd_vpoll_poll(struct file *file, poll_table *wait)
   312	{
   313		struct eventfd_ctx *ctx = file->private_data;
   314		__poll_t events = 0;
   315		u64 count;
   316	
   317		poll_wait(file, &ctx->wqh, wait);
   318	
   319		count = READ_ONCE(ctx->count);
   320	
 > 321		events = (count & EPOLLALLMASK);
   322	
   323		return events;
   324	}
   325	
   326	static ssize_t eventfd_vpoll_read(struct file *file, char __user *buf,
   327			size_t count, loff_t *ppos)
   328	{
   329		struct eventfd_ctx *ctx = file->private_data;
   330		ssize_t res;
   331		__u64 ucnt = 0;
   332	
   333		if (count < sizeof(ucnt))
   334			return -EINVAL;
   335		res = sizeof(ucnt);
   336		ucnt = READ_ONCE(ctx->count);
   337		if (put_user(ucnt, (__u64 __user *)buf))
   338			return -EFAULT;
   339	
   340		return res;
   341	}
   342	
   343	static ssize_t eventfd_vpoll_write(struct file *file, const char __user *buf,
   344			size_t count, loff_t *ppos)
   345	{
   346		struct eventfd_ctx *ctx = file->private_data;
   347		ssize_t res;
   348		__u64 ucnt;
   349		__u32 events;
   350	
   351		if (count < sizeof(ucnt))
   352			return -EINVAL;
   353		if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
   354			return -EFAULT;
   355		spin_lock_irq(&ctx->wqh.lock);
   356	
   357		events = ucnt & EPOLLALLMASK;
   358		res = sizeof(ucnt);
 > 359		switch (ucnt & ~((__u64)EPOLLALLMASK)) {
   360		case EFD_VPOLL_ADDEVENTS:
   361			ctx->count |= events;
   362			break;
   363		case EFD_VPOLL_DELEVENTS:
   364			ctx->count &= ~(events);
   365			break;
   366		case EFD_VPOLL_MODEVENTS:
   367			ctx->count = (ctx->count & ~EPOLLALLMASK) | events;
   368			break;
   369		default:
   370			res = -EINVAL;
   371		}
   372	
   373		/* wake up waiting threads */
   374		if (res >= 0 && waitqueue_active(&ctx->wqh))
 > 375			wake_up_locked_poll(&ctx->wqh, res);
   376	
   377		spin_unlock_irq(&ctx->wqh.lock);
   378	
   379		return res;
   380	
   381	}
   382	
   383	#ifdef CONFIG_PROC_FS
   384	static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
   385	{
   386		struct eventfd_ctx *ctx = f->private_data;
   387	
   388		spin_lock_irq(&ctx->wqh.lock);
   389		seq_printf(m, "eventfd-count: %16llx\n",
   390			   (unsigned long long)ctx->count);
   391		spin_unlock_irq(&ctx->wqh.lock);
   392		seq_printf(m, "eventfd-id: %d\n", ctx->id);
   393	}
   394	#endif
   395	
   396	static const struct file_operations eventfd_fops = {
   397	#ifdef CONFIG_PROC_FS
   398		.show_fdinfo	= eventfd_show_fdinfo,
   399	#endif
   400		.release	= eventfd_release,
   401		.poll		= eventfd_poll,
   402		.read		= eventfd_read,
   403		.write		= eventfd_write,
   404		.llseek		= noop_llseek,
   405	};
   406	
   407	static const struct file_operations eventfd_vpoll_fops = {
   408	#ifdef CONFIG_PROC_FS
   409		.show_fdinfo	= eventfd_show_fdinfo,
   410	#endif
   411		.release	= eventfd_release,
   412		.poll		= eventfd_vpoll_poll,
   413		.read		= eventfd_vpoll_read,
   414		.write		= eventfd_vpoll_write,
   415		.llseek		= noop_llseek,
   416	};
   417	
   418	/**
   419	 * eventfd_fget - Acquire a reference of an eventfd file descriptor.
   420	 * @fd: [in] Eventfd file descriptor.
   421	 *
   422	 * Returns a pointer to the eventfd file structure in case of success, or the
   423	 * following error pointer:
   424	 *
   425	 * -EBADF    : Invalid @fd file descriptor.
   426	 * -EINVAL   : The @fd file descriptor is not an eventfd file.
   427	 */
   428	struct file *eventfd_fget(int fd)
   429	{
   430		struct file *file;
   431	
   432		file = fget(fd);
   433		if (!file)
   434			return ERR_PTR(-EBADF);
   435		if (file->f_op != &eventfd_fops) {
   436			fput(file);
   437			return ERR_PTR(-EINVAL);
   438		}
   439	
   440		return file;
   441	}
   442	EXPORT_SYMBOL_GPL(eventfd_fget);
   443	
   444	/**
   445	 * eventfd_ctx_fdget - Acquires a reference to the internal eventfd context.
   446	 * @fd: [in] Eventfd file descriptor.
   447	 *
   448	 * Returns a pointer to the internal eventfd context, otherwise the error
   449	 * pointers returned by the following functions:
   450	 *
   451	 * eventfd_fget
   452	 */
   453	struct eventfd_ctx *eventfd_ctx_fdget(int fd)
   454	{
   455		struct eventfd_ctx *ctx;
   456		struct fd f = fdget(fd);
   457		if (!f.file)
   458			return ERR_PTR(-EBADF);
   459		ctx = eventfd_ctx_fileget(f.file);
   460		fdput(f);
   461		return ctx;
   462	}
   463	EXPORT_SYMBOL_GPL(eventfd_ctx_fdget);
   464	
   465	/**
   466	 * eventfd_ctx_fileget - Acquires a reference to the internal eventfd context.
   467	 * @file: [in] Eventfd file pointer.
   468	 *
   469	 * Returns a pointer to the internal eventfd context, otherwise the error
   470	 * pointer:
   471	 *
   472	 * -EINVAL   : The @fd file descriptor is not an eventfd file.
   473	 */
   474	struct eventfd_ctx *eventfd_ctx_fileget(struct file *file)
   475	{
   476		struct eventfd_ctx *ctx;
   477	
   478		if (file->f_op != &eventfd_fops)
   479			return ERR_PTR(-EINVAL);
   480	
   481		ctx = file->private_data;
   482		kref_get(&ctx->kref);
   483		return ctx;
   484	}
   485	EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
   486	
   487	static int do_eventfd(unsigned int count, int flags)
   488	{
   489		struct eventfd_ctx *ctx;
   490		const struct file_operations *fops = &eventfd_fops;
   491		int fd;
   492	
   493		/* Check the EFD_* constants for consistency.  */
   494		BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
   495		BUILD_BUG_ON(EFD_NONBLOCK != O_NONBLOCK);
   496	
   497		if (flags & ~EFD_FLAGS_SET)
   498			return -EINVAL;
   499	
   500		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
   501		if (!ctx)
   502			return -ENOMEM;
   503	
   504		kref_init(&ctx->kref);
   505		init_waitqueue_head(&ctx->wqh);
   506		ctx->count = count;
   507		ctx->flags = flags;
   508		ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
   509	
   510		if (flags & EFD_VPOLL) {
   511			fops = &eventfd_vpoll_fops;
 > 512			ctx->count &= EPOLLALLMASK;
   513		}
   514		fd = anon_inode_getfd("[eventfd]", fops, ctx,
   515				      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
   516		if (fd < 0)
   517			eventfd_free_ctx(ctx);
   518	
   519		return fd;
   520	}
   521	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
