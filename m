Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1928AE97A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 09:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJ3IJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 04:09:13 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59834 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfJ3IJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:09:12 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 48EFA2E12AB;
        Wed, 30 Oct 2019 11:09:08 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CsKiUT6mtb-97BSov2p;
        Wed, 30 Oct 2019 11:09:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572422948; bh=0gMuzoYjykM/uZvK9DzD+n0Yj7FO8SORgjzdBRpEa5g=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=a9qsBa9vGwSSqdU7tEk0nmPCSfU3gZIYFPDU9+VhGyZzudddVNipCxx+JZAVld2/D
         TKSyJjN9G8uzAsuuZSB64iUFClBvKSU4N1SN/6iP/8CYiK85yS/pl2WOCITsLgsCJa
         48Vas8YBoXavlhQbwi7nSaTtjmQ46M9EDZ39M3r8=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZiQ5gd4EXP-97WevHVm;
        Wed, 30 Oct 2019 11:09:07 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] fs: warn if stale pagecache is left after direct write
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <157225698620.5453.17655271871684298255.stgit@buzz>
 <201910300824.UIo56oC7%lkp@intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1e90f71e-228f-c7da-7257-fbb83477e338@yandex-team.ru>
Date:   Wed, 30 Oct 2019 11:09:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201910300824.UIo56oC7%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 30/10/2019 03.20, kbuild test robot wrote:
> Hi Konstantin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.4-rc5 next-20191029]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Konstantin-Khlebnikov/fs-warn-if-stale-pagecache-is-left-after-direct-write/20191030-073543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23fdb198ae81f47a574296dab5167c5e136a02ba
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     mm/filemap.c: In function 'generic_file_direct_write':
>>> mm/filemap.c:3229:3: error: implicit declaration of function 'dio_warn_stale_pagecache'; did you mean 'truncate_pagecache'? [-Werror=implicit-function-declaration]
>        dio_warn_stale_pagecache(file);
>        ^~~~~~~~~~~~~~~~~~~~~~~~
>        truncate_pagecache
>     cc1: some warnings being treated as errors

This config has CONFIG_BLOCK=n while O_DIRECT is still here.
For example, NFS has it too.

I'll move dio_warn_stale_pagecache() into different file.

> 
> vim +3229 mm/filemap.c
> 
>    3163	
>    3164	ssize_t
>    3165	generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>    3166	{
>    3167		struct file	*file = iocb->ki_filp;
>    3168		struct address_space *mapping = file->f_mapping;
>    3169		struct inode	*inode = mapping->host;
>    3170		loff_t		pos = iocb->ki_pos;
>    3171		ssize_t		written;
>    3172		size_t		write_len;
>    3173		pgoff_t		end;
>    3174	
>    3175		write_len = iov_iter_count(from);
>    3176		end = (pos + write_len - 1) >> PAGE_SHIFT;
>    3177	
>    3178		if (iocb->ki_flags & IOCB_NOWAIT) {
>    3179			/* If there are pages to writeback, return */
>    3180			if (filemap_range_has_page(inode->i_mapping, pos,
>    3181						   pos + write_len - 1))
>    3182				return -EAGAIN;
>    3183		} else {
>    3184			written = filemap_write_and_wait_range(mapping, pos,
>    3185								pos + write_len - 1);
>    3186			if (written)
>    3187				goto out;
>    3188		}
>    3189	
>    3190		/*
>    3191		 * After a write we want buffered reads to be sure to go to disk to get
>    3192		 * the new data.  We invalidate clean cached page from the region we're
>    3193		 * about to write.  We do this *before* the write so that we can return
>    3194		 * without clobbering -EIOCBQUEUED from ->direct_IO().
>    3195		 */
>    3196		written = invalidate_inode_pages2_range(mapping,
>    3197						pos >> PAGE_SHIFT, end);
>    3198		/*
>    3199		 * If a page can not be invalidated, return 0 to fall back
>    3200		 * to buffered write.
>    3201		 */
>    3202		if (written) {
>    3203			if (written == -EBUSY)
>    3204				return 0;
>    3205			goto out;
>    3206		}
>    3207	
>    3208		written = mapping->a_ops->direct_IO(iocb, from);
>    3209	
>    3210		/*
>    3211		 * Finally, try again to invalidate clean pages which might have been
>    3212		 * cached by non-direct readahead, or faulted in by get_user_pages()
>    3213		 * if the source of the write was an mmap'ed region of the file
>    3214		 * we're writing.  Either one is a pretty crazy thing to do,
>    3215		 * so we don't support it 100%.  If this invalidation
>    3216		 * fails, tough, the write still worked...
>    3217		 *
>    3218		 * Most of the time we do not need this since dio_complete() will do
>    3219		 * the invalidation for us. However there are some file systems that
>    3220		 * do not end up with dio_complete() being called, so let's not break
>    3221		 * them by removing it completely.
>    3222		 *
>    3223		 * Noticeable case is a blkdev_direct_IO().
>    3224		 *
>    3225		 * Skip invalidation for async writes or if mapping has no pages.
>    3226		 */
>    3227		if (written > 0 && mapping->nrpages &&
>    3228		    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
>> 3229			dio_warn_stale_pagecache(file);
>    3230	
>    3231		if (written > 0) {
>    3232			pos += written;
>    3233			write_len -= written;
>    3234			if (pos > i_size_read(inode) && !S_ISBLK(inode->i_mode)) {
>    3235				i_size_write(inode, pos);
>    3236				mark_inode_dirty(inode);
>    3237			}
>    3238			iocb->ki_pos = pos;
>    3239		}
>    3240		iov_iter_revert(from, write_len - iov_iter_count(from));
>    3241	out:
>    3242		return written;
>    3243	}
>    3244	EXPORT_SYMBOL(generic_file_direct_write);
>    3245	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
