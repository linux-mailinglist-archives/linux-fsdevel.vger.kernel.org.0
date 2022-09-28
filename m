Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F25EE3AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiI1R6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiI1R6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:58:20 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE9FADA8;
        Wed, 28 Sep 2022 10:58:17 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:45168)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1odbK2-0004Db-Nm; Wed, 28 Sep 2022 11:58:14 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:55952 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1odbK1-00AF6g-J6; Wed, 28 Sep 2022 11:58:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YzN+ZYLjK6HI1P1C@ZenIV>
Date:   Wed, 28 Sep 2022 12:57:44 -0500
In-Reply-To: <YzN+ZYLjK6HI1P1C@ZenIV> (Al Viro's message of "Tue, 27 Sep 2022
        23:51:17 +0100")
Message-ID: <87fsgb4c13.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1odbK1-00AF6g-J6;;;mid=<87fsgb4c13.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/4sCrkHe6NtBryOpeTbgSXlizmgvZTkYg=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 582 ms - load_scoreonly_sql: 0.21 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 9 (1.5%), parse: 1.09 (0.2%),
         extract_message_metadata: 19 (3.3%), get_uri_detail_list: 3.7 (0.6%),
        tests_pri_-1000: 19 (3.3%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 94 (16.2%), check_bayes:
        93 (15.9%), b_tokenize: 12 (2.0%), b_tok_get_all: 10 (1.6%),
        b_comp_prob: 2.6 (0.4%), b_tok_touch_all: 65 (11.2%), b_finish: 0.95
        (0.2%), tests_pri_0: 414 (71.1%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 15 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> [I'm going to send a pull request tomorrow if nobody yells;
> please review and test - it seems to work fine here, but extra
> eyes and extra testing would be very welcome]
>
> passing kmap_local_page() result to __kernel_write() is unsafe -
> random ->write_iter() might (and 9p one does) get unhappy when
> passed ITER_KVEC with pointer that came from kmap_local_page().
>     
> Fix by providing a variant of __kernel_write() that takes an iov_iter
> from caller (__kernel_write() becomes a trivial wrapper) and adding
> dump_emit_page() that parallels dump_emit(), except that instead of
> __kernel_write() it uses __kernel_write_iter() with ITER_BVEC source.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

From a 10,000 foot view this makes sense.


> Fixes: 3159ed57792b "fs/coredump: use kmap_local_page()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9f4aae202109..09dbc981ad5c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -832,6 +832,38 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  	}
>  }
>  
> +static int dump_emit_page(struct coredump_params *cprm, struct page *page)
> +{
> +	struct bio_vec bvec = {
> +		.bv_page	= page,
> +		.bv_offset	= 0,
> +		.bv_len		= PAGE_SIZE,
> +	};
> +	struct iov_iter iter;
> +	struct file *file = cprm->file;
> +	loff_t pos = file->f_pos;
> +	ssize_t n;
> +
> +	if (cprm->to_skip) {
> +		if (!__dump_skip(cprm, cprm->to_skip))
> +			return 0;
> +		cprm->to_skip = 0;
> +	}
> +	if (cprm->written + PAGE_SIZE > cprm->limit)
> +		return 0;
> +	if (dump_interrupted())
> +		return 0;
> +	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
> +	n = __kernel_write_iter(cprm->file, &iter, &pos);
> +	if (n != PAGE_SIZE)
> +		return 0;
> +	file->f_pos = pos;
> +	cprm->written += PAGE_SIZE;
> +	cprm->pos += PAGE_SIZE;
> +
> +	return 1;
> +}
> +
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>  {
>  	if (cprm->to_skip) {
> @@ -863,7 +895,6 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  
>  	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
>  		struct page *page;
> -		int stop;
>  
>  		/*
>  		 * To avoid having to allocate page tables for virtual address
> @@ -874,12 +905,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  		 */
>  		page = get_dump_page(addr);
>  		if (page) {
> -			void *kaddr = kmap_local_page(page);
> -
> -			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
> -			kunmap_local(kaddr);
> -			put_page(page);
> -			if (stop)
> +			if (!dump_emit_page(cprm, page))
>  				return 0;
>  		} else {
>  			dump_skip(cprm, PAGE_SIZE);
> diff --git a/fs/internal.h b/fs/internal.h
> index 87e96b9024ce..3e206d3e317c 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -16,6 +16,7 @@ struct shrink_control;
>  struct fs_context;
>  struct user_namespace;
>  struct pipe_inode_info;
> +struct iov_iter;
>  
>  /*
>   * block/bdev.c
> @@ -221,3 +222,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
>  int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
>  int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		struct xattr_ctx *ctx);
> +
> +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 1a261dcf1778..328ce8cf9a85 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -496,14 +496,9 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
>  }
>  
>  /* caller is responsible for file_start_write/file_end_write */
> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos)
>  {
> -	struct kvec iov = {
> -		.iov_base	= (void *)buf,
> -		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
> -	};
>  	struct kiocb kiocb;
> -	struct iov_iter iter;
>  	ssize_t ret;
>  
>  	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
> @@ -519,8 +514,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
>  
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = pos ? *pos : 0;
> -	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> -	ret = file->f_op->write_iter(&kiocb, &iter);
> +	ret = file->f_op->write_iter(&kiocb, from);
>  	if (ret > 0) {
>  		if (pos)
>  			*pos = kiocb.ki_pos;
> @@ -530,6 +524,18 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
>  	inc_syscw(current);
>  	return ret;
>  }
> +
> +/* caller is responsible for file_start_write/file_end_write */
> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +{
> +	struct kvec iov = {
> +		.iov_base	= (void *)buf,
> +		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
> +	};
> +	struct iov_iter iter;
> +	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> +	return __kernel_write_iter(file, &iter, pos);
> +}
>  /*
>   * This "EXPORT_SYMBOL_GPL()" is more of a "EXPORT_SYMBOL_DONTUSE()",
>   * but autofs is one of the few internal kernel users that actually
