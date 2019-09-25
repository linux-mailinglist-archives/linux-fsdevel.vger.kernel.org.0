Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D019BE583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408633AbfIYTUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 15:20:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfIYTUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:20:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so6169285wmj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xzswSRe2eIn8wG2R2FPqQj3Cz1yjMoHYy61Ft4UumsA=;
        b=hZTy8fml4waPu6HvzX9qzprBk1rFdXqPmj7RPWeDA8sZ+QYVspnCu71wKx7dTy4t3h
         GNXeAY0C2owYA6SRw+NE7yhgvIkYoQjYq6BXSXF9zcB4mUabU2QVtc66w6C1EO0ZzEde
         R2ysSCegV6oI+ar2yDiH3HWWq2c48fxjLeLGRKn4W4uJMRQAebRUE7R8hE+Mtr/FpooL
         lx2n8keayHoy0LXq/K7QjqDOUTJbc5tKk0UEIPmXCNOPZYD1yrvuSTnTmSaR+iJ8dDMN
         SeQ+5OgG50xle5Uw1YcoztKfG7FHW99ZPZWxLNVhQx5neTtkM7cJ7Ex6Nfy2p3Qmq0cd
         V4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xzswSRe2eIn8wG2R2FPqQj3Cz1yjMoHYy61Ft4UumsA=;
        b=PANAObRC4KBN/y+3J8n6FFzDtB1bhUGJjNjd+wYSpwLWh7ka2S+Udjd7UZSZILUz5d
         m7ErFKzKKEGcl8Wz/C5rWUjQ2VmuTaMgcx0LuCAc0bj618cZ/uQ41kirg0W+IQ7+ODAE
         J6Ak5a7BZhxUMwpEtLuguyXUMCiMGt+Ugv7wS14oOMXEgKbQlMedCuh2PWhsekWsRPCo
         6RzxBeQVRC3NgH3ymFvQs1K0RK4XTFzblfB6WD2glQq9sIti0O4uP7Rz+Jh7l5n+7IUL
         3HqPHxrQeuhZPbkX8cirzowxsbfjrmk+gbO08hwZP6+WaKXUpw9ehHu2ZyFDEhPgSBTc
         1VNg==
X-Gm-Message-State: APjAAAXCtlhKa7VEaymfyeDBJElgChXZ+5Rida9A4lWHL+dWOc5ptXOm
        EO+hNhM+TiZDrFzs9c8HDw==
X-Google-Smtp-Source: APXvYqw1Rj+nf010MtNey3wjAA5DXA8bSWz3SCOOZhiWSr+w5QmRl2WpZ0ZpmyN8TNI5VfALo7qPMw==
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr9199461wmf.126.1569439221708;
        Wed, 25 Sep 2019 12:20:21 -0700 (PDT)
Received: from avx2 ([46.53.249.15])
        by smtp.gmail.com with ESMTPSA id g185sm8371304wme.10.2019.09.25.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 12:20:19 -0700 (PDT)
Date:   Wed, 25 Sep 2019 22:20:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com
Subject: Re: [PATCH V2] proc: fix ubsan warning in mem_lseek
Message-ID: <20190925192017.GA30690@avx2>
References: <20190902065706.60754-1-yangerkun@huawei.com>
 <7452f3d2-1fcf-2627-cbee-b9a920c17fcb@huawei.com>
 <a984e257-7b4c-3cb0-d28a-e9db553865e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a984e257-7b4c-3cb0-d28a-e9db553865e8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:09:38PM +0800, yangerkun wrote:
> Ping again...
> 
> On 2019/9/6 13:48, yangerkun wrote:
> > Ping.
> >
> > On 2019/9/2 14:57, yangerkun wrote:
> >> UBSAN has reported a overflow with mem_lseek. And it's fine with
> >> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek).
> >> However, another file use mem_lseek do lseek can have not
> >> FMODE_UNSIGNED_OFFSET(proc_kpagecount_operations/proc_pagemap_operations), 

Why those files can't have FMODE_UNSIGNED_OFFSET?
All files have unsigned offsets by definition, it is just lseek(SEEK_SET)
reusing signed type is silly.

> >> fix it by checking overflow and FMODE_UNSIGNED_OFFSET.
> >>
> >> ==================================================================
> >> UBSAN: Undefined behaviour in ../fs/proc/base.c:941:15
> >> signed integer overflow:
> >> 4611686018427387904 + 4611686018427387904 cannot be represented in 
> >> type 'long long int'
> >> CPU: 4 PID: 4762 Comm: syz-executor.1 Not tainted 4.4.189 #3
> >> Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> >> Call trace:
> >> [<ffffff90080a5f28>] dump_backtrace+0x0/0x590 
> >> arch/arm64/kernel/traps.c:91
> >> [<ffffff90080a64f0>] show_stack+0x38/0x60 arch/arm64/kernel/traps.c:234
> >> [<ffffff9008986a34>] __dump_stack lib/dump_stack.c:15 [inline]
> >> [<ffffff9008986a34>] dump_stack+0x128/0x184 lib/dump_stack.c:51
> >> [<ffffff9008a2d120>] ubsan_epilogue+0x34/0x9c lib/ubsan.c:166
> >> [<ffffff9008a2d8b8>] handle_overflow+0x228/0x280 lib/ubsan.c:197
> >> [<ffffff9008a2da2c>] __ubsan_handle_add_overflow+0x4c/0x68 
> >> lib/ubsan.c:204
> >> [<ffffff900862b9f4>] mem_lseek+0x12c/0x130 fs/proc/base.c:941
> >> [<ffffff90084ef78c>] vfs_llseek fs/read_write.c:260 [inline]
> >> [<ffffff90084ef78c>] SYSC_lseek fs/read_write.c:285 [inline]
> >> [<ffffff90084ef78c>] SyS_lseek+0x164/0x1f0 fs/read_write.c:276
> >> [<ffffff9008093c80>] el0_svc_naked+0x30/0x34
> >> ==================================================================
> >>
> >> Signed-off-by: yangerkun <yangerkun@huawei.com>
> >> ---
> >>   fs/proc/base.c     | 32 ++++++++++++++++++++++++--------
> >>   fs/read_write.c    |  5 -----
> >>   include/linux/fs.h |  5 +++++
> >>   3 files changed, 29 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index ebea950..a6c701b 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -882,18 +882,34 @@ static ssize_t mem_write(struct file *file, 
> >> const char __user *buf,
> >>     loff_t mem_lseek(struct file *file, loff_t offset, int orig)
> >>   {
> >> +    loff_t ret = 0;
> >> +
> >> +    spin_lock(&file->f_lock);
> >>       switch (orig) {
> >> -    case 0:
> >> -        file->f_pos = offset;
> >> -        break;
> >> -    case 1:
> >> -        file->f_pos += offset;
> >> +    case SEEK_CUR:
> >> +        offset += file->f_pos;
> >> +        /* fall through */
> >> +    case SEEK_SET:
> >> +        /* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
> >> +        if ((unsigned long long)offset >= -MAX_ERRNO)
> >> +            ret = -EOVERFLOW;
> >>           break;
> >>       default:
> >> -        return -EINVAL;
> >> +        ret = -EINVAL;
> >> +    }
> >> +
> >> +    if (!ret) {
> >> +        if (offset < 0 && !(unsigned_offsets(file))) {
> >> +            ret = -EINVAL;
> >> +        } else {
> >> +            file->f_pos = offset;
> >> +            ret = file->f_pos;
> >> +            force_successful_syscall_return();
> >> +        }
> >>       }
> >> -    force_successful_syscall_return();
> >> -    return file->f_pos;
> >> +
> >> +    spin_unlock(&file->f_lock);
> >> +    return ret;
> >>   }
> >>     static int mem_release(struct inode *inode, struct file *file)
> >> diff --git a/fs/read_write.c b/fs/read_write.c
> >> index 5bbf587..961966e 100644
> >> --- a/fs/read_write.c
> >> +++ b/fs/read_write.c
> >> @@ -34,11 +34,6 @@ const struct file_operations generic_ro_fops = {
> >>     EXPORT_SYMBOL(generic_ro_fops);
> >>   -static inline bool unsigned_offsets(struct file *file)
> >> -{
> >> -    return file->f_mode & FMODE_UNSIGNED_OFFSET;
> >> -}
> >> -
> >>   /**
> >>    * vfs_setpos - update the file offset for lseek
> >>    * @file:    file structure in question
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index 997a530..e5edbc9 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -3074,6 +3074,11 @@ extern void
> >>   file_ra_state_init(struct file_ra_state *ra, struct address_space 
> >> *mapping);
> >>   extern loff_t noop_llseek(struct file *file, loff_t offset, int 
> >> whence);
> >>   extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
> >> +static inline bool unsigned_offsets(struct file *file)
> >> +{
> >> +    return file->f_mode & FMODE_UNSIGNED_OFFSET;
> >> +}
> >> +
> >>   extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t 
> >> maxsize);
> >>   extern loff_t generic_file_llseek(struct file *file, loff_t offset, 
> >> int whence);
> >>   extern loff_t generic_file_llseek_size(struct file *file, loff_t 
> >> offset,
> 
