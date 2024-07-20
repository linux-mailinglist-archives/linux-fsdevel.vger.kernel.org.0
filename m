Return-Path: <linux-fsdevel+bounces-24037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D19380C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9349E1C2124A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF284047;
	Sat, 20 Jul 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxaPVatu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D022F17;
	Sat, 20 Jul 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472151; cv=none; b=UylJqe2WknU/HmI7+eTdUkaD+AfZ+qL5meeiLTso28T1Tofkm75LlKbceq4Uvy0wRyaAORRzgY87wLkicHG8TAA5gIXCZR2w8H9F99cdpSMYK/P618nG0tDQ8DcXD0iA6I89K4Aof2fm9ANpTO/wcRuvcMJla8WXr2vGBA4zK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472151; c=relaxed/simple;
	bh=SjXz8Q7cYNANPWdAIE+1LcHU+Sy/cBqo18xnb4k5Ups=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGBLnjnxcCzYT9Z/kImAlPmme/5S/s5VVq7QJQlybDy/xTVZD1xtc8Eg+tjl3CUW9WsteON0NCHRKngOgVch/Wod0sXO4vv0x+msed7fWwMLzaVmrRJMY9SC50kAhEpmgn5nApLu6A0gGPnWBv55ph0rZEKpVxm2gvfC/RRg3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxaPVatu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so19507965e9.1;
        Sat, 20 Jul 2024 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721472148; x=1722076948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvVRqveKCbnKGjsii996Z+A1wxik6ho1ZN1Ar+GN1jU=;
        b=JxaPVatu/aUIga+cJ11HurZUoA2ZL4R1jB8Vs7z65uRRzhSoXXZQf49B8eNjHgXUMx
         dHJSaZcETi/qgRktynQdOf7iBJj7nC6nbA6Ku8U9KL/+3n7WoXzxMFndfx13tnEnEhgs
         fWJx8h1FwOGj8jTGi6l1vQfT1bpJz9w8iNBmpO2n1L/4st1qf2LodpFvmP2NEfDEvRf+
         ZNj50wqwrLoeN/qDIt+MSfvEc/4DsBcESsbw5gc7P0JuyuQwtrfuKfxT5J//V5g4Pa/T
         7CChXqCCwV6r8YmT74pe6Ys7ScVF/bLbmoFkzybBndxrPPNqrURdvf1ZV+PtTkMoVdxx
         tfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721472148; x=1722076948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvVRqveKCbnKGjsii996Z+A1wxik6ho1ZN1Ar+GN1jU=;
        b=aAEm3wtbFOBMLF9W+O5+7lGT8jBy6maXsYIrZ0ZJeidf6RVHVJWfthOKGvgcTElG0K
         DA6vg3Cr90s8lcGsvsvMJx7p/lDWIp11oyXNgGjEbRR5Y0JRt9ZltWX3O9Wr8ZJ9sr6Q
         uuSntErdSw8219RAH5JRk00SMN7ZsknDG+RP54ktd8GqBe6hXEV/em8DD3PMBCKj/ZwI
         FTQq/OhhbmvwUC6tGlWjlS/bFV0sUveeYKuRpqDGCEwnUcNZwcIKbzGShS7f340TLMzO
         83T6N+QF8zxjtMwvcM4yWC/RLcazI1detQRO+v3mPryuFEB6ik3R5JHLlDnU7lKi1Vez
         SOLA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0sR/fJD3xfKwJFs7FrprIHlJ6BS1s5LHchdMbcoO7eiDaVv0JFocmGONy68ZS5GUxCNoCM+7IO99QMdWS+ecgyhm/9l54elYXZ+qIoYu1QQmEqBBJi23uDJoEbvr1ROWIMQBgq1KIFBHlIWfwxmuAo/D1grvF3yqMcb5iSRO+a2z48Or9FE=
X-Gm-Message-State: AOJu0Yws9UEfXuTxc01a/jXKZ2+GidKcBOk8+6Jp4TCp5Lmd3ss8Lm6q
	4xKbLqaGn5PW4S6iz32xBokkxq9ln4ZJzun2U2knNyh+HYLej2Uf
X-Google-Smtp-Source: AGHT+IFtjw6W19sDZIGkdGb3I2QzTdMrxKBtLKtuA6pZllYy+sAObBJu8M1Kqk6cGFm7GvJaZE7/IQ==
X-Received: by 2002:a05:600c:4ec7:b0:426:6f15:2e4d with SMTP id 5b1f17b1804b1-427dc51cecbmr7415135e9.9.1721472148099;
        Sat, 20 Jul 2024 03:42:28 -0700 (PDT)
Received: from f (cst-prg-77-238.cust.vodafone.cz. [46.135.77.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6906c77sm52947855e9.23.2024.07.20.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 03:42:27 -0700 (PDT)
Date: Sat, 20 Jul 2024 12:42:15 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, 
	Richard Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>, 
	yangerkun <yangerkun@huawei.com>, "wangzhaolong (A)" <wangzhaolong1@huawei.com>
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the
 inode lru traversing context on ext4 and ubifs
Message-ID: <yakewaqynmapatlh3s45huq6dutkkkcdj26tqpfx6yllsjmyie@rh6xthl5pwkb>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
 <20240712143708.GA151742@mit.edu>
 <20240718134031.sxnwwzzj54jxl3e5@quack3>
 <0b0a7b95-f6d0-a56e-5492-b48882d9a35d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b0a7b95-f6d0-a56e-5492-b48882d9a35d@huaweicloud.com>

On Fri, Jul 19, 2024 at 11:21:51AM +0800, Zhihao Cheng wrote:
> 在 2024/7/18 21:40, Jan Kara 写道:
> > I'm pondering about the best way to fix this. Maybe we could handle the
> > need for inode pinning in inode_lru_isolate() in a similar way as in
> > writeback code so that last iput() cannot happen from inode_lru_isolate().
> > In writeback we use I_SYNC flag to pin the inode and evict() waits for this
> > flag to clear. I'll probably sleep to it and if I won't find it too
> > disgusting to live tomorrow, I can code it.
> > 
> 
> I guess that you may modify like this:
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..5b1a9b23f53f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -457,7 +457,7 @@ EXPORT_SYMBOL(ihold);
> 
>  static void __inode_add_lru(struct inode *inode, bool rotate)
>  {
> -       if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING |
> I_WILL_FREE))
> +       if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE
> | I_PINING))
>                 return;
>         if (atomic_read(&inode->i_count))
>                 return;
> @@ -845,7 +845,7 @@ static enum lru_status inode_lru_isolate(struct
> list_head *item,
>          * be under pressure before the cache inside the highmem zone.
>          */
>         if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
> -               __iget(inode);
> +               inode->i_state |= I_PINING;
>                 spin_unlock(&inode->i_lock);
>                 spin_unlock(lru_lock);
>                 if (remove_inode_buffers(inode)) {
> @@ -857,7 +857,10 @@ static enum lru_status inode_lru_isolate(struct
> list_head *item,
>                                 __count_vm_events(PGINODESTEAL, reap);
>                         mm_account_reclaimed_pages(reap);
>                 }
> -               iput(inode);
> +               spin_lock(&inode->i_lock);
> +               inode->i_state &= ~I_PINING;
> +               wake_up_bit(&inode->i_state, __I_PINING);
> +               spin_unlock(&inode->i_lock);
>                 spin_lock(lru_lock);
>                 return LRU_RETRY;
>         }
> @@ -1772,6 +1775,7 @@ static void iput_final(struct inode *inode)
>                 return;
>         }
> 
> +       inode_wait_for_pining(inode);
>         state = inode->i_state;
>         if (!drop) {
>                 WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..daf094fff5fe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2415,6 +2415,8 @@ static inline void kiocb_clone(struct kiocb *kiocb,
> struct kiocb *kiocb_src,
>  #define I_DONTCACHE            (1 << 16)
>  #define I_SYNC_QUEUED          (1 << 17)
>  #define I_PINNING_NETFS_WB     (1 << 18)
> +#define __I_PINING             19
> +#define I_PINING               (1 << __I_PINING)
> 
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> 
> , which means that we will import a new inode state to solve the problem.
> 

My non-maintainer $0,03 is as follows:

1. I_PINING is too generic of a name. I_LRU_PINNED or something else
indicating what this is for would be prudent
2. while not specific to this patch, the handling of i_state is too
accidental-breakage friendly. a full blown solution is way out of the
scope here, but something can be done to future-proof this work anyway.

To that end I would suggest:
1. inode_lru_pin() which appart from setting the flag includes:
	BUG_ON(inode->i_state & (I_LRU_PINNED | I_FREEING | I_WILL_FREE)
2. inode_lru_unpin() which apart from unsetting the flag + wakeup includes:
	BUG_ON(!(inode->i_state & I_LRU_PINNED))
3. inode_lru_wait_for_pinned() 

However, a non-cosmetic remark is that at the spot inode_wait_for_pining
gets invoked none of the of the pinning-blocking flags may be set (to my
reading anyway). This is not the end of the world, but it does mean the
waiting routine will have to check stuff in a loop.

Names are not that important, the key is to keep the logic and
dependencies close by code-wise.

