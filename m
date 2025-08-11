Return-Path: <linux-fsdevel+bounces-57372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F168B20CAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2429F1669F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE22DEA8C;
	Mon, 11 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fFsSvodw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A86E555;
	Mon, 11 Aug 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923772; cv=none; b=HayNjwo1KM750HSAKjyXmzcExFr/q1MiRGp7G7LeaVAF5YAqtKb6ZS4YsyiUz99jZfbatCMb3gOzuhJX8FVNqHFLFTxQuNugyzewnuHOdGBKTHuFnn+Mmwh+dx3s8A+7Kft5ASqvQc4FTbHgkCjGtqobiVWmOVEHaNWN87pNyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923772; c=relaxed/simple;
	bh=P3HAzNCi/lnV527V9D2Kvsw3Wjl1CbW7cJ5bgFhE7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhl2fUTUXsQOiBhjTzgaT8jaL/GTI8Q08LCro0yEIgKEXdyLUei9mqB3qLhDYVTffbwhq46YnCyRqMZulIQa36vLQytwP/+EnZxF4MLs1SM5Dfax6U0mGT/eEJPRenwdimvYoT7fLkIi59Jhumd41rQq452TeljKDZ7BxTLWiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fFsSvodw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qlFzUxPWHjx5grAM+2JEnhzKMq/lcSztmTKoL3AWCPo=; b=fFsSvodway9dLw4r27bUqyziiM
	ZFFt0NVoqQRzfTiHDy9Nv5/CwKTYc3aJHBm1s0dLRGK80/rCteCvbAsljVEr50AWbO92XvTLeHgUq
	I+lgvtPAFEQdyxe4y1n98IaxIJeK+OXEAWVfkS8Ek+4RVAyGD3es2IudckEa8WP12PhNoWl8YDtFh
	tvuyjWNdYOXZhMucOwRfdnFwbgBeq1D7Hv5y7InFFx9VAPz7KUUaOyxB17HKkzTjTsm2gq8a49tia
	B2yF+r+kJB/EShwuNwTdDMFcdEVuhq+7ZoaZmXpHNAaBm14PyLNV+5VcwfTNTyz/YtySAcdF6/1iF
	XQ6F59bg==;
Received: from [223.233.72.183] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ulTpt-00CpHZ-13; Mon, 11 Aug 2025 16:49:17 +0200
Message-ID: <6b5c92c4-2170-8ce9-3c9f-45c0e1893e03@igalia.com>
Date: Mon, 11 Aug 2025 20:19:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, laoar.shao@gmail.com,
 pmladek@suse.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de
References: <20250811064609.918593-4-bhupesh@igalia.com>
 <202508111835.JFL8DgKY-lkp@intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202508111835.JFL8DgKY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/11/25 4:55 PM, kernel test robot wrote:
> Hi Bhupesh,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on next-20250808]
> [cannot apply to trace/for-next tip/sched/core brauner-vfs/vfs.all linus/master v6.17-rc1 v6.16 v6.16-rc7 v6.17-rc1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250811-144920
> base:   next-20250808
> patch link:    https://lore.kernel.org/r/20250811064609.918593-4-bhupesh%40igalia.com
> patch subject: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
> config: sh-randconfig-002-20250811 (https://download.01.org/0day-ci/archive/20250811/202508111835.JFL8DgKY-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250811/202508111835.JFL8DgKY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508111835.JFL8DgKY-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/bitmap.h:13,
>                      from include/linux/cpumask.h:12,
>                      from include/linux/smp.h:13,
>                      from include/linux/lockdep.h:14,
>                      from include/linux/spinlock.h:63,
>                      from include/linux/mmzone.h:8,
>                      from include/linux/gfp.h:7,
>                      from include/linux/umh.h:4,
>                      from include/linux/kmod.h:9,
>                      from include/linux/module.h:18,
>                      from net/netfilter/nf_tables_api.c:8:
>     net/netfilter/nf_tables_api.c: In function 'nf_tables_fill_gen_info':
>>> include/linux/string.h:116:50: error: passing argument 3 of 'nla_put_string' makes pointer from integer without a cast [-Wint-conversion]
>       116 | #define sized_strscpy_pad(dest, src, count)     ({                      \
>           |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~
>           |                                                  |
>           |                                                  ssize_t {aka int}
>       117 |         char *__dst = (dest);                                           \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       118 |         const char *__src = (src);                                      \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       119 |         const size_t __count = (count);                                 \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       120 |         ssize_t __wrote;                                                \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       121 |                                                                         \
>           |                                                                         ~
>       122 |         __wrote = sized_strscpy(__dst, __src, __count);                 \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       123 |         if (__wrote >= 0 && __wrote < __count)                          \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       124 |                 memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
>           |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       125 |         __wrote;                                                        \
>           |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       126 | })
>           | ~~
>     include/linux/string.h:86:9: note: in expansion of macro 'sized_strscpy_pad'
>        86 |         sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +        \
>           |         ^~~~~~~~~~~~~~~~~
>     include/linux/args.h:25:24: note: in expansion of macro '__strscpy_pad0'
>        25 | #define __CONCAT(a, b) a ## b
>           |                        ^
>     include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
>        26 | #define CONCATENATE(a, b) __CONCAT(a, b)
>           |                           ^~~~~~~~
>     include/linux/string.h:149:9: note: in expansion of macro 'CONCATENATE'
>       149 |         CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>           |         ^~~~~~~~~~~
>     net/netfilter/nf_tables_api.c:9661:53: note: in expansion of macro 'strscpy_pad'
>      9661 |             nla_put_string(skb, NFTA_GEN_PROC_NAME, strscpy_pad(buf, current->comm)))
>           |                                                     ^~~~~~~~~~~
>     In file included from include/linux/netfilter/nfnetlink.h:7,
>                      from net/netfilter/nf_tables_api.c:17:
>     include/net/netlink.h:1655:46: note: expected 'const char *' but argument is of type 'ssize_t' {aka 'int'}
>      1655 |                                  const char *str)
>           |                                  ~~~~~~~~~~~~^~~
>
>
> vim +/nla_put_string +116 include/linux/string.h
>
> e6584c3964f2ff Kees Cook        2023-09-20   74
> e6584c3964f2ff Kees Cook        2023-09-20   75  /*
> e6584c3964f2ff Kees Cook        2023-09-20   76   * The 2 argument style can only be used when dst is an array with a
> e6584c3964f2ff Kees Cook        2023-09-20   77   * known size.
> e6584c3964f2ff Kees Cook        2023-09-20   78   */
> e6584c3964f2ff Kees Cook        2023-09-20   79  #define __strscpy0(dst, src, ...)	\
> 559048d156ff33 Kees Cook        2024-08-05   80  	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> 559048d156ff33 Kees Cook        2024-08-05   81  				__must_be_cstr(dst) + __must_be_cstr(src))
> 559048d156ff33 Kees Cook        2024-08-05   82  #define __strscpy1(dst, src, size)	\
> 559048d156ff33 Kees Cook        2024-08-05   83  	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
> e6584c3964f2ff Kees Cook        2023-09-20   84
> 8366d124ec937c Kees Cook        2024-02-02   85  #define __strscpy_pad0(dst, src, ...)	\
> 559048d156ff33 Kees Cook        2024-08-05   86  	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> 559048d156ff33 Kees Cook        2024-08-05   87  				    __must_be_cstr(dst) + __must_be_cstr(src))
> 559048d156ff33 Kees Cook        2024-08-05   88  #define __strscpy_pad1(dst, src, size)	\
> 559048d156ff33 Kees Cook        2024-08-05   89  	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
> 458a3bf82df4fe Tobin C. Harding 2019-04-05   90
> e6584c3964f2ff Kees Cook        2023-09-20   91  /**
> e6584c3964f2ff Kees Cook        2023-09-20   92   * strscpy - Copy a C-string into a sized buffer
> e6584c3964f2ff Kees Cook        2023-09-20   93   * @dst: Where to copy the string to
> e6584c3964f2ff Kees Cook        2023-09-20   94   * @src: Where to copy the string from
> e6584c3964f2ff Kees Cook        2023-09-20   95   * @...: Size of destination buffer (optional)
> e6584c3964f2ff Kees Cook        2023-09-20   96   *
> e6584c3964f2ff Kees Cook        2023-09-20   97   * Copy the source string @src, or as much of it as fits, into the
> e6584c3964f2ff Kees Cook        2023-09-20   98   * destination @dst buffer. The behavior is undefined if the string
> e6584c3964f2ff Kees Cook        2023-09-20   99   * buffers overlap. The destination @dst buffer is always NUL terminated,
> e6584c3964f2ff Kees Cook        2023-09-20  100   * unless it's zero-sized.
> e6584c3964f2ff Kees Cook        2023-09-20  101   *
> e6584c3964f2ff Kees Cook        2023-09-20  102   * The size argument @... is only required when @dst is not an array, or
> e6584c3964f2ff Kees Cook        2023-09-20  103   * when the copy needs to be smaller than sizeof(@dst).
> e6584c3964f2ff Kees Cook        2023-09-20  104   *
> e6584c3964f2ff Kees Cook        2023-09-20  105   * Preferred to strncpy() since it always returns a valid string, and
> e6584c3964f2ff Kees Cook        2023-09-20  106   * doesn't unnecessarily force the tail of the destination buffer to be
> e6584c3964f2ff Kees Cook        2023-09-20  107   * zero padded. If padding is desired please use strscpy_pad().
> e6584c3964f2ff Kees Cook        2023-09-20  108   *
> e6584c3964f2ff Kees Cook        2023-09-20  109   * Returns the number of characters copied in @dst (not including the
> e6584c3964f2ff Kees Cook        2023-09-20  110   * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
> e6584c3964f2ff Kees Cook        2023-09-20  111   * truncated.
> e6584c3964f2ff Kees Cook        2023-09-20  112   */
> e6584c3964f2ff Kees Cook        2023-09-20  113  #define strscpy(dst, src, ...)	\
> e6584c3964f2ff Kees Cook        2023-09-20  114  	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> 458a3bf82df4fe Tobin C. Harding 2019-04-05  115
> 8366d124ec937c Kees Cook        2024-02-02 @116  #define sized_strscpy_pad(dest, src, count)	({			\
> 8366d124ec937c Kees Cook        2024-02-02  117  	char *__dst = (dest);						\
> 8366d124ec937c Kees Cook        2024-02-02  118  	const char *__src = (src);					\
> 8366d124ec937c Kees Cook        2024-02-02  119  	const size_t __count = (count);					\
> 8366d124ec937c Kees Cook        2024-02-02  120  	ssize_t __wrote;						\
> 8366d124ec937c Kees Cook        2024-02-02  121  									\
> 8366d124ec937c Kees Cook        2024-02-02  122  	__wrote = sized_strscpy(__dst, __src, __count);			\
> 8366d124ec937c Kees Cook        2024-02-02  123  	if (__wrote >= 0 && __wrote < __count)				\
> 8366d124ec937c Kees Cook        2024-02-02  124  		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> 8366d124ec937c Kees Cook        2024-02-02  125  	__wrote;							\
> 8366d124ec937c Kees Cook        2024-02-02  126  })
> 8366d124ec937c Kees Cook        2024-02-02  127
>

As mentioned in the accompanying cover letter, this patchset is based on 
'linux-next/master' (the exact sha-id used for rebase is: 
b1549501188cc9eba732c25b033df7a53ccc341f ).

Thanks,
Bhupesh

