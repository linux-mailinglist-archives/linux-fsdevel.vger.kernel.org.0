Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0D6C3FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 02:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCVBWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVBWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016BF30E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679448121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ji/+gLUq4mhKl4W9bQYaYit7GTsJsCf//IKN0Tq+sKM=;
        b=YbD5iDlrO0TdBv/WC7aC4lhwHxPjNKCcgjOC1yMFMNpRMCqDb6RUG1P2BPQD1ODd9NnkIK
        c49/ZG7tb/VLGBda2sxndxp7mSnNqAEyug6E7kF2Xc3nH/I0yJb7bL5atD5JEtgjEC953P
        vPy5cdSdpv+3vXbZEVDUv+16zsQTEng=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-M3QeEbI_OTOy-_W1UUrLAw-1; Tue, 21 Mar 2023 21:15:53 -0400
X-MC-Unique: M3QeEbI_OTOy-_W1UUrLAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14D2D3806106;
        Wed, 22 Mar 2023 01:15:53 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41496B590;
        Wed, 22 Mar 2023 01:15:51 +0000 (UTC)
Date:   Wed, 22 Mar 2023 09:15:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 2/4] fs/proc/kcore: convert read_kcore() to
 read_kcore_iter()
Message-ID: <ZBpWxI+LYiwasnvj@MiWiFi-R3L-srv>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lorenzo,

On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
> Now we have eliminated spinlocks from the vread() case, convert
> read_kcore() to read_kcore_iter().

Sorry for late comment.

Here I could miss something important, I don't get where we have
eliminated spinlocks from the vread() case. Do I misunderstand this
sentence?

> 
> For the time being we still use a bounce buffer for vread(), however in the
> next patch we will convert this to interact directly with the iterator and
> eliminate the bounce buffer altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/proc/kcore.c | 58 ++++++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 556f310d6aa4..25e0eeb8d498 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -24,7 +24,7 @@
>  #include <linux/memblock.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/uaccess.h>
> +#include <linux/uio.h>
>  #include <asm/io.h>
>  #include <linux/list.h>
>  #include <linux/ioport.h>
> @@ -308,9 +308,12 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>  }
>  
>  static ssize_t
> -read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> +read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
> +	struct file *file = iocb->ki_filp;
>  	char *buf = file->private_data;
> +	loff_t *ppos = &iocb->ki_pos;
> +
>  	size_t phdrs_offset, notes_offset, data_offset;
>  	size_t page_offline_frozen = 1;
>  	size_t phdrs_len, notes_len;
> @@ -318,6 +321,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  	size_t tsz;
>  	int nphdr;
>  	unsigned long start;
> +	size_t buflen = iov_iter_count(iter);
>  	size_t orig_buflen = buflen;
>  	int ret = 0;
>  
> @@ -333,7 +337,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  	notes_offset = phdrs_offset + phdrs_len;
>  
>  	/* ELF file header. */
> -	if (buflen && *fpos < sizeof(struct elfhdr)) {
> +	if (buflen && *ppos < sizeof(struct elfhdr)) {
>  		struct elfhdr ehdr = {
>  			.e_ident = {
>  				[EI_MAG0] = ELFMAG0,
> @@ -355,19 +359,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			.e_phnum = nphdr,
>  		};
>  
> -		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
> -		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
> +		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *ppos);
> +		if (copy_to_iter((char *)&ehdr + *ppos, tsz, iter) != tsz) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
>  
> -		buffer += tsz;
>  		buflen -= tsz;
> -		*fpos += tsz;
> +		*ppos += tsz;
>  	}
>  
>  	/* ELF program headers. */
> -	if (buflen && *fpos < phdrs_offset + phdrs_len) {
> +	if (buflen && *ppos < phdrs_offset + phdrs_len) {
>  		struct elf_phdr *phdrs, *phdr;
>  
>  		phdrs = kzalloc(phdrs_len, GFP_KERNEL);
> @@ -397,22 +400,21 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			phdr++;
>  		}
>  
> -		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
> -		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
> -				 tsz)) {
> +		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *ppos);
> +		if (copy_to_iter((char *)phdrs + *ppos - phdrs_offset, tsz,
> +				 iter) != tsz) {
>  			kfree(phdrs);
>  			ret = -EFAULT;
>  			goto out;
>  		}
>  		kfree(phdrs);
>  
> -		buffer += tsz;
>  		buflen -= tsz;
> -		*fpos += tsz;
> +		*ppos += tsz;
>  	}
>  
>  	/* ELF note segment. */
> -	if (buflen && *fpos < notes_offset + notes_len) {
> +	if (buflen && *ppos < notes_offset + notes_len) {
>  		struct elf_prstatus prstatus = {};
>  		struct elf_prpsinfo prpsinfo = {
>  			.pr_sname = 'R',
> @@ -447,24 +449,23 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				  vmcoreinfo_data,
>  				  min(vmcoreinfo_size, notes_len - i));
>  
> -		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
> -		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
> +		tsz = min_t(size_t, buflen, notes_offset + notes_len - *ppos);
> +		if (copy_to_iter(notes + *ppos - notes_offset, tsz, iter) != tsz) {
>  			kfree(notes);
>  			ret = -EFAULT;
>  			goto out;
>  		}
>  		kfree(notes);
>  
> -		buffer += tsz;
>  		buflen -= tsz;
> -		*fpos += tsz;
> +		*ppos += tsz;
>  	}
>  
>  	/*
>  	 * Check to see if our file offset matches with any of
>  	 * the addresses in the elf_phdr on our list.
>  	 */
> -	start = kc_offset_to_vaddr(*fpos - data_offset);
> +	start = kc_offset_to_vaddr(*ppos - data_offset);
>  	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
>  		tsz = buflen;
>  
> @@ -497,7 +498,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  		}
>  
>  		if (!m) {
> -			if (clear_user(buffer, tsz)) {
> +			if (iov_iter_zero(tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> @@ -508,14 +509,14 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  		case KCORE_VMALLOC:
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */
> -			if (copy_to_user(buffer, buf, tsz)) {
> +			if (copy_to_iter(buf, tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
>  			break;
>  		case KCORE_USER:
>  			/* User page is handled prior to normal kernel page: */
> -			if (copy_to_user(buffer, (char *)start, tsz)) {
> +			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> @@ -531,7 +532,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			 */
>  			if (!page || PageOffline(page) ||
>  			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
> -				if (clear_user(buffer, tsz)) {
> +				if (iov_iter_zero(tsz, iter) != tsz) {
>  					ret = -EFAULT;
>  					goto out;
>  				}
> @@ -541,25 +542,24 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  		case KCORE_VMEMMAP:
>  		case KCORE_TEXT:
>  			/*
> -			 * We use _copy_to_user() to bypass usermode hardening
> +			 * We use _copy_to_iter() to bypass usermode hardening
>  			 * which would otherwise prevent this operation.
>  			 */
> -			if (_copy_to_user(buffer, (char *)start, tsz)) {
> +			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
>  			break;
>  		default:
>  			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
> -			if (clear_user(buffer, tsz)) {
> +			if (iov_iter_zero(tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
>  		}
>  skip:
>  		buflen -= tsz;
> -		*fpos += tsz;
> -		buffer += tsz;
> +		*ppos += tsz;
>  		start += tsz;
>  		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
>  	}
> @@ -603,7 +603,7 @@ static int release_kcore(struct inode *inode, struct file *file)
>  }
>  
>  static const struct proc_ops kcore_proc_ops = {
> -	.proc_read	= read_kcore,
> +	.proc_read_iter	= read_kcore_iter,
>  	.proc_open	= open_kcore,
>  	.proc_release	= release_kcore,
>  	.proc_lseek	= default_llseek,
> -- 
> 2.39.2
> 

