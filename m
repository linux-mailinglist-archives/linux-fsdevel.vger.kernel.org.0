Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FF711335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbjEYSIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbjEYSIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 14:08:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F73E7F;
        Thu, 25 May 2023 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=YL8OMDLHODA41rvR8ub9++8ad6Sy/4p0ql0b8s32pR4=; b=hG3IAvmXcplLQeAkZUYiIB2Lu1
        wosgmRGyX2O7q/NhVvhVdn4UWMpVTx3FVQiRQS/1KtwYsOs5n0hJCGyE2oYr/A6fQ9tjw0DqMYe6u
        wo51sRdOEd1/CzSnlBjTBRUtcPu7puN+EljKWHqncqQyRl+08ZIiujx2jiMbc+w6uLyfkzBQE5nNj
        bOTepye23vwfIh9CrUmOnJFHqmZHvIzZTFq1AyEoTsj1JM3ByOxaqCGS4xGxkxCL/p7V3klhUYf3c
        3uZrAYijmR68QIr2l2efVer9Egw/SZ/NHj23zusMNth8PgW7BYpicGg0+jWl189lWrIJospApzMMq
        OdOTjUPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2FNm-00HL6H-01;
        Thu, 25 May 2023 18:08:14 +0000
Date:   Thu, 25 May 2023 11:08:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com
Cc:     tglx@linutronix.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate
 detection
Message-ID: <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ fsdevel please review,

On Wed, May 24, 2023 at 09:00:02PM -0700, Linus Torvalds wrote:
> On Wed, May 24, 2023 at 2:52 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This is all disgusting.
> 
> Bringing back the original thread, because I just sent an alternate
> patch to Luis to test.
> 
> That one is also disgusting, but for different reasons: it needs some
> polish if it works. It's a very simple patch, in that it just extends
> our existing i_writecount and ETXTBSY logic to also have a "exclusive"
> mode, and says that we do the module file reading in that exclusive
> mode (so if/when udev in its incompetence tries to load the same
> module X number of times at the same time, only one will read at a
> time).

Indeed, this is the sort of gem I was hoping we could acomplish.

> The disgusting part is mainly the hacky test for "id ==
> READING_MODULE", and it would probably be better with some kind of
> "exclusive flag" field for general use, but right now READING_MODULE
> is basically that one user.
> 
> Luis having explained _why_ we'd want this (and honestly, it took a
> couple of tries), I can only say that udev is horribly broken, and
> this most definitely should be fixed in user mode. udev randomly
> loading the same module multiple times just because it gets confused
> is not ok.

At this point it would be good for for someone on the udev camp to at
least to *try*. If the problem is the fork on udev, maybe the shmem
could be used to share the module context to prevent duplicates.

> Any udev developer that goes "we can't fix it in user space" should be
> ashamed of themselves. Really? Just randomly doing the same thing in
> parallel and expecting the kernel to sort out your mess? What a crock.
> 
> But this *might* mitigate that udev horror. And not introduce any new
> kernel-side horror, just a slight extension of our existing writer
> exclusion logic to allow "full exclusive access".

Yes, that expresses what is needed well and is simple enough.

> (Note: it's not actually excluding other purely regular readers - but
> it *is* excluding not just writers, but also other "special readers"
> that want to exclude writers)
> 
> I'd like to point out that this patch really is completely untested.
> It built for me, but that's all the testing it has gotten. It's
> _small_. Tiny, even. But that "id == READING_MODULE" thing really is
> pretty disgusting and I feel this needs more thought.

>  fs/kernel_read_file.c | 6 +++++-
>  include/linux/fs.h    | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 5d826274570c..ff3e894f8cd4 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -48,7 +48,11 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return -EINVAL;
>  
> -	ret = deny_write_access(file);
> +	/* Module reading wants *exclusive* access to the file */
> +	if (id == READING_MODULE)
> +		ret = exclusive_deny_write_access(file);
> +	else
> +		ret = deny_write_access(file);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21a981680856..722b42a77d51 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2566,6 +2566,12 @@ static inline int deny_write_access(struct file *file)
>  	struct inode *inode = file_inode(file);
>  	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
>  }
> +static inline int exclusive_deny_write_access(struct file *file)
> +{
> +	int old = 0;
> +	struct inode *inode = file_inode(file);
> +	return atomic_try_cmpxchg(&inode->i_writecount, &old, -1) ? 0 : -ETXTBSY;
> +}
>  static inline void put_write_access(struct inode * inode)
>  {
>  	atomic_dec(&inode->i_writecount);

Certainly on the track where I wish we could go. Now this goes tested.
On 255 cores:

Before:                                                                          
                                                                                 
vagrant@kmod ~ $ sudo systemd-analyze                                            
Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s        
graphical.target reached after 44.178s in userspace.  

root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/stats    
 Virtual mem wasted bytes       1949006968 

                                                                                 
; 1949006968/1024/1024/1024                                                      
        ~1.81515418738126754761                                                  
                                                                                 
So ~1.8 GiB... of vmalloc space wasted during boot.

After:

systemd-analyze 
Startup finished in 24.438s (kernel) + 41.278s (userspace) = 1min 5.717s 
graphical.target reached after 41.154s in userspace.

root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/stats
 Virtual mem wasted bytes       354413398

So still 337.99 MiB of vmalloc space wasted during boot due to
duplicates. The reason is the exclusive_deny_write_access() must be
kept during the life of the module otherwise as soon as it is done
others can still race to load after and fail later after it sees the
module is already loaded. It sounds crazy to think that such races
exist because that means userspace didn't see the module loaded yet
and still tried finit_module() but the stats reveal that's the
case.

So with two other hunks added (2nd and 4th), this now matches parity with
my patch, not suggesting this is right, just demonstrating how this
could be resolved with this. We could also just have a helper which lets
the module code allow_write_access() at the end of its use of the fd
(failure to load or module is removed).

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..ff5b338a288b 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -48,7 +48,11 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
-	ret = deny_write_access(file);
+	/* Module reading wants *exclusive* access to the file */
+	if (id == READING_MODULE)
+		ret = exclusive_deny_write_access(file);
+	else
+		ret = deny_write_access(file);
 	if (ret)
 		return ret;
 
@@ -119,7 +123,8 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 	}
 
 out:
-	allow_write_access(file);
+	if (id != READING_MODULE)
+		allow_write_access(file);
 	return ret == 0 ? copied : ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..722b42a77d51 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2566,6 +2566,12 @@ static inline int deny_write_access(struct file *file)
 	struct inode *inode = file_inode(file);
 	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
 }
+static inline int exclusive_deny_write_access(struct file *file)
+{
+	int old = 0;
+	struct inode *inode = file_inode(file);
+	return atomic_try_cmpxchg(&inode->i_writecount, &old, -1) ? 0 : -ETXTBSY;
+}
 static inline void put_write_access(struct inode * inode)
 {
 	atomic_dec(&inode->i_writecount);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 044aa2c9e3cb..88aaada929b1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3078,8 +3079,10 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
 	if (len < 0) {
-		mod_stat_inc(&failed_kreads);
-		mod_stat_add_long(len, &invalid_kread_bytes);
+		if (len != -ETXTBSY) {
+			mod_stat_inc(&failed_kreads);
+			mod_stat_add_long(len, &invalid_kread_bytes);
+		}
 		return len;
 	}
 
