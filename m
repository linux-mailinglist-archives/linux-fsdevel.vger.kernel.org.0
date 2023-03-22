Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13166C42F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 07:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCVGTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCVGTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:19:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043FF4C3D;
        Tue, 21 Mar 2023 23:19:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso1176442wmo.4;
        Tue, 21 Mar 2023 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679465976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3iaW2agAbMwqgiEp5WfNoQ6YhOUN3dC7dOrA2kDLxI=;
        b=J536LDg3b+r0xbOHBtWGz8F4PNLnCkmSpWzIsL1VgPnRn7BJH1iSL0EOxazEyjPQDX
         fugbc2Ju4igR5eWHIkEB4UUaXq1m6CVI9N75OtVIy78rqk+I4v0tye6ad3blm71xDfaj
         aGb/tMtJTBNDWM8iUCDYazou0LqQ9EX3F5j+XuS7M24XrJlRFefUMHHENdQ055n7yLkG
         bjgggzE7CcVcyXEcN8N4SXUjvk7MA21S39YFaFNcJoDlZL8Qfdu3shmxGQearZXmxsCP
         ZzC50pxa69r1dDSa6qPFwJJ7F6upavkrvkDCLOvXoKhiAP7oZr1O+6MlrCbK9MTRILlC
         Dwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679465976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3iaW2agAbMwqgiEp5WfNoQ6YhOUN3dC7dOrA2kDLxI=;
        b=bI+H/ui/KUkcKTAcCWcevURORBlDKytg0PyYHs0SdlL+0KNFzYmlWUliMi61pjWv5e
         Pe2ljhlRoq/ZfkzhW9d5qiMWmuRcxxH9+FLKVrvAk/jqAEHLmjymouPof6QXxDRNYMl3
         RvLFuu+thDaI+kVMbDTWvIEViJTFAsVoIOlh1Txh/NvMZuzbmRqylmKeGs87BHCCizMH
         SvR7vw4nONFoPZ0ABjizDg2201hYFHIVqRW0jJ3PIO8k2PcYYqvRFHoehgNZpfZak9d1
         g34HZg2pcVZm2R+dmfRf00bb/CxNkgNDPsG7Mn4eb2SFyfHCBKs4P5n780ajrBBGHUcH
         J4Ag==
X-Gm-Message-State: AO0yUKU6q0ch3Guyv96Dc0mDyqLDQOYM0n4QFJtHL2Sv2L64+PwWX+ge
        I0vueTd1n4sBJ89Eqmo2mfA=
X-Google-Smtp-Source: AK7set+8i9OLhKRz91jbznPxQpXJ1YTazeewWapwy9kjoP2FM+6ggA8XMC6wMajezeQB4sERZ1Lqqw==
X-Received: by 2002:a05:600c:21cc:b0:3ed:e2e6:8ddb with SMTP id x12-20020a05600c21cc00b003ede2e68ddbmr4273593wmj.35.1679465975948;
        Tue, 21 Mar 2023 23:19:35 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b003daffc2ecdesm21600525wms.13.2023.03.21.23.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:19:35 -0700 (PDT)
Date:   Wed, 22 Mar 2023 06:17:24 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <070237be-48a2-4a04-bc19-7217b68c8bcf@lucifer.local>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
 <ZBpWxI+LYiwasnvj@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpWxI+LYiwasnvj@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:15:48AM +0800, Baoquan He wrote:
> Hi Lorenzo,
>
> On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
> > Now we have eliminated spinlocks from the vread() case, convert
> > read_kcore() to read_kcore_iter().
>
> Sorry for late comment.
>
> Here I could miss something important, I don't get where we have
> eliminated spinlocks from the vread() case. Do I misunderstand this
> sentence?
>

Apologies, I didn't update the commit message after the latest revision! We
can just drop this sentence altogether.

Andrew - could you change the commit message to simply read:-

  For the time being we still use a bounce buffer for vread(), however in the
  next patch we will convert this to interact directly with the iterator and
  eliminate the bounce buffer altogether.

Thanks!

> >
> > For the time being we still use a bounce buffer for vread(), however in the
> > next patch we will convert this to interact directly with the iterator and
> > eliminate the bounce buffer altogether.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  fs/proc/kcore.c | 58 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 556f310d6aa4..25e0eeb8d498 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > -#include <linux/uaccess.h>
> > +#include <linux/uio.h>
> >  #include <asm/io.h>
> >  #include <linux/list.h>
> >  #include <linux/ioport.h>
> > @@ -308,9 +308,12 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
> >  }
> >
> >  static ssize_t
> > -read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> > +read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  {
> > +	struct file *file = iocb->ki_filp;
> >  	char *buf = file->private_data;
> > +	loff_t *ppos = &iocb->ki_pos;
> > +
> >  	size_t phdrs_offset, notes_offset, data_offset;
> >  	size_t page_offline_frozen = 1;
> >  	size_t phdrs_len, notes_len;
> > @@ -318,6 +321,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  	size_t tsz;
> >  	int nphdr;
> >  	unsigned long start;
> > +	size_t buflen = iov_iter_count(iter);
> >  	size_t orig_buflen = buflen;
> >  	int ret = 0;
> >
> > @@ -333,7 +337,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  	notes_offset = phdrs_offset + phdrs_len;
> >
> >  	/* ELF file header. */
> > -	if (buflen && *fpos < sizeof(struct elfhdr)) {
> > +	if (buflen && *ppos < sizeof(struct elfhdr)) {
> >  		struct elfhdr ehdr = {
> >  			.e_ident = {
> >  				[EI_MAG0] = ELFMAG0,
> > @@ -355,19 +359,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  			.e_phnum = nphdr,
> >  		};
> >
> > -		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
> > -		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
> > +		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *ppos);
> > +		if (copy_to_iter((char *)&ehdr + *ppos, tsz, iter) != tsz) {
> >  			ret = -EFAULT;
> >  			goto out;
> >  		}
> >
> > -		buffer += tsz;
> >  		buflen -= tsz;
> > -		*fpos += tsz;
> > +		*ppos += tsz;
> >  	}
> >
> >  	/* ELF program headers. */
> > -	if (buflen && *fpos < phdrs_offset + phdrs_len) {
> > +	if (buflen && *ppos < phdrs_offset + phdrs_len) {
> >  		struct elf_phdr *phdrs, *phdr;
> >
> >  		phdrs = kzalloc(phdrs_len, GFP_KERNEL);
> > @@ -397,22 +400,21 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  			phdr++;
> >  		}
> >
> > -		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
> > -		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
> > -				 tsz)) {
> > +		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *ppos);
> > +		if (copy_to_iter((char *)phdrs + *ppos - phdrs_offset, tsz,
> > +				 iter) != tsz) {
> >  			kfree(phdrs);
> >  			ret = -EFAULT;
> >  			goto out;
> >  		}
> >  		kfree(phdrs);
> >
> > -		buffer += tsz;
> >  		buflen -= tsz;
> > -		*fpos += tsz;
> > +		*ppos += tsz;
> >  	}
> >
> >  	/* ELF note segment. */
> > -	if (buflen && *fpos < notes_offset + notes_len) {
> > +	if (buflen && *ppos < notes_offset + notes_len) {
> >  		struct elf_prstatus prstatus = {};
> >  		struct elf_prpsinfo prpsinfo = {
> >  			.pr_sname = 'R',
> > @@ -447,24 +449,23 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  				  vmcoreinfo_data,
> >  				  min(vmcoreinfo_size, notes_len - i));
> >
> > -		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
> > -		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
> > +		tsz = min_t(size_t, buflen, notes_offset + notes_len - *ppos);
> > +		if (copy_to_iter(notes + *ppos - notes_offset, tsz, iter) != tsz) {
> >  			kfree(notes);
> >  			ret = -EFAULT;
> >  			goto out;
> >  		}
> >  		kfree(notes);
> >
> > -		buffer += tsz;
> >  		buflen -= tsz;
> > -		*fpos += tsz;
> > +		*ppos += tsz;
> >  	}
> >
> >  	/*
> >  	 * Check to see if our file offset matches with any of
> >  	 * the addresses in the elf_phdr on our list.
> >  	 */
> > -	start = kc_offset_to_vaddr(*fpos - data_offset);
> > +	start = kc_offset_to_vaddr(*ppos - data_offset);
> >  	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
> >  		tsz = buflen;
> >
> > @@ -497,7 +498,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  		}
> >
> >  		if (!m) {
> > -			if (clear_user(buffer, tsz)) {
> > +			if (iov_iter_zero(tsz, iter) != tsz) {
> >  				ret = -EFAULT;
> >  				goto out;
> >  			}
> > @@ -508,14 +509,14 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  		case KCORE_VMALLOC:
> >  			vread(buf, (char *)start, tsz);
> >  			/* we have to zero-fill user buffer even if no read */
> > -			if (copy_to_user(buffer, buf, tsz)) {
> > +			if (copy_to_iter(buf, tsz, iter) != tsz) {
> >  				ret = -EFAULT;
> >  				goto out;
> >  			}
> >  			break;
> >  		case KCORE_USER:
> >  			/* User page is handled prior to normal kernel page: */
> > -			if (copy_to_user(buffer, (char *)start, tsz)) {
> > +			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
> >  				ret = -EFAULT;
> >  				goto out;
> >  			}
> > @@ -531,7 +532,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  			 */
> >  			if (!page || PageOffline(page) ||
> >  			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
> > -				if (clear_user(buffer, tsz)) {
> > +				if (iov_iter_zero(tsz, iter) != tsz) {
> >  					ret = -EFAULT;
> >  					goto out;
> >  				}
> > @@ -541,25 +542,24 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  		case KCORE_VMEMMAP:
> >  		case KCORE_TEXT:
> >  			/*
> > -			 * We use _copy_to_user() to bypass usermode hardening
> > +			 * We use _copy_to_iter() to bypass usermode hardening
> >  			 * which would otherwise prevent this operation.
> >  			 */
> > -			if (_copy_to_user(buffer, (char *)start, tsz)) {
> > +			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
> >  				ret = -EFAULT;
> >  				goto out;
> >  			}
> >  			break;
> >  		default:
> >  			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
> > -			if (clear_user(buffer, tsz)) {
> > +			if (iov_iter_zero(tsz, iter) != tsz) {
> >  				ret = -EFAULT;
> >  				goto out;
> >  			}
> >  		}
> >  skip:
> >  		buflen -= tsz;
> > -		*fpos += tsz;
> > -		buffer += tsz;
> > +		*ppos += tsz;
> >  		start += tsz;
> >  		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
> >  	}
> > @@ -603,7 +603,7 @@ static int release_kcore(struct inode *inode, struct file *file)
> >  }
> >
> >  static const struct proc_ops kcore_proc_ops = {
> > -	.proc_read	= read_kcore,
> > +	.proc_read_iter	= read_kcore_iter,
> >  	.proc_open	= open_kcore,
> >  	.proc_release	= release_kcore,
> >  	.proc_lseek	= default_llseek,
> > --
> > 2.39.2
> >
>
