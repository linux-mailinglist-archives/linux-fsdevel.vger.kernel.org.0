Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3676B93D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHAP7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjHAP7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162DFDC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690905495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v1Xszfz9uEDrPkkvCMGSkEQEMthpp9oBlq/CbCyVYks=;
        b=bJIrJ3BipJRG7ar02litnOEgXGOeZYlgrA2YOWT+raaA7s8PRlw9PphnL06R0XZIi+73YH
        H72MGnIvD5e80AVFa9NqzS9IUHYElao7JqRNBG8P4eurFFbQ1JVtdQA+kHDnogrF7esEHc
        k6CV1NT/oqXZpoADff0BCpxBH+R/BoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-x24qKZ6FPHuvf70ETQoxQA-1; Tue, 01 Aug 2023 11:58:12 -0400
X-MC-Unique: x24qKZ6FPHuvf70ETQoxQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 319E4185A791;
        Tue,  1 Aug 2023 15:58:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 993E42166B25;
        Tue,  1 Aug 2023 15:57:51 +0000 (UTC)
Date:   Tue, 1 Aug 2023 23:57:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org, David Hildenbrand <david@redhat.com>,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
Message-ID: <ZMkrfBDARIAYFYwz@MiWiFi-R3L-srv>
References: <20230731215021.70911-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731215021.70911-1-lstoakes@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/31/23 at 10:50pm, Lorenzo Stoakes wrote:
> Some architectures do not populate the entire range categorised by
> KCORE_TEXT, so we must ensure that the kernel address we read from is
> valid.
> 
> Unfortunately there is no solution currently available to do so with a
> purely iterator solution so reinstate the bounce buffer in this instance so
> we can use copy_from_kernel_nofault() in order to avoid page faults when
> regions are unmapped.
> 
> This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
> bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
> the code to continue to use an iterator.
> 
> Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 9cb32e1a78a0..3bc689038232 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>  
>  static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
> +	struct file *file = iocb->ki_filp;
> +	char *buf = file->private_data;
>  	loff_t *fpos = &iocb->ki_pos;
>  	size_t phdrs_offset, notes_offset, data_offset;
>  	size_t page_offline_frozen = 1;
> @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			fallthrough;
>  		case KCORE_VMEMMAP:
>  		case KCORE_TEXT:
> +			/*
> +			 * Sadly we must use a bounce buffer here to be able to
> +			 * make use of copy_from_kernel_nofault(), as these
> +			 * memory regions might not always be mapped on all
> +			 * architectures.
> +			 */
> +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> +				if (iov_iter_zero(tsz, iter) != tsz) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
>  			/*
>  			 * We use _copy_to_iter() to bypass usermode hardening
>  			 * which would otherwise prevent this operation.
>  			 */
> -			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
> +			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
>  				ret = -EFAULT;
>  				goto out;
>  			}
> @@ -595,6 +608,10 @@ static int open_kcore(struct inode *inode, struct file *filp)
>  	if (ret)
>  		return ret;
>  
> +	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!filp->private_data)
> +		return -ENOMEM;
> +
>  	if (kcore_need_update)
>  		kcore_update_ram();
>  	if (i_size_read(inode) != proc_root_kcore->size) {
> @@ -605,9 +622,16 @@ static int open_kcore(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static int release_kcore(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
>  static const struct proc_ops kcore_proc_ops = {
>  	.proc_read_iter	= read_kcore_iter,
>  	.proc_open	= open_kcore,
> +	.proc_release	= release_kcore,
>  	.proc_lseek	= default_llseek,
>  };

On 6.5-rc4, the failures can be reproduced stably on a arm64 machine.
With patch applied, both makedumpfile and objdump test cases passed.

And the code change looks good to me, thanks.

Tested-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Baoquan He <bhe@redhat.com>


===============================================
[root@ ~]# makedumpfile --mem-usage /proc/kcore 
The kernel version is not supported.
The makedumpfile operation may be incomplete.

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		76234           	yes		Pages filled with zero
NON_PRI_CACHE	147613          	yes		Cache pages without private flag
PRI_CACHE	3847            	yes		Cache pages with private flag
USER		15276           	yes		User process pages
FREE		15809884        	yes		Free pages
KERN_DATA	459950          	no		Dumpable kernel data 

page size:		4096            
Total pages on system:	16512804        
Total size on system:	67636445184      Byte

[root@ ~]# objdump -d  --start-address=0x^C
[root@ ~]# cat /proc/kallsyms | grep ksys_read
ffffab3be77229d8 T ksys_readahead
ffffab3be782a700 T ksys_read
[root@ ~]# objdump -d  --start-address=0xffffab3be782a700 --stop-address=0xffffab3be782a710 /proc/kcore 

/proc/kcore:     file format elf64-littleaarch64


Disassembly of section load1:

ffffab3be782a700 <load1+0x41a700>:
ffffab3be782a700:	aa1e03e9 	mov	x9, x30
ffffab3be782a704:	d503201f 	nop
ffffab3be782a708:	d503233f 	paciasp
ffffab3be782a70c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
objdump: error: /proc/kcore(load2) is too large (0x7bff70000000 bytes)
objdump: Reading section load2 failed because: memory exhausted


