Return-Path: <linux-fsdevel+bounces-13555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BC870C3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 22:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C442A1F216AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3251CAA9;
	Mon,  4 Mar 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dz/v6tqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23331118C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586997; cv=none; b=Xuxq4Bkqdkq2SSHDeiVT86DOixjKiHZtJEkfgjYADJqoQ8nHTywojZ0V8qKBi2ngpiyP1v8zzGgEbQtdjMYh3ymt2r39UxepnyLK6R1z+Oq6H+/QwLHYk7HDQdHE1C1sBKCp6i/Qj2Ty5Pe8vSpoOfkpJLQ2jOFLX+6e1ur3AEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586997; c=relaxed/simple;
	bh=DwGDQUhSCU7Y4nG/PPFIcs2jOQysKOkH+7ODTg8yZRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPyZHHF1Bb4UuRVhcjwM7TzOcVRV27TEZ24UOCBxfmhv0l/2SRf3kL1mcJNaiBbNKIIkEMOGYmm0hUxzK1n0Nt4pCEjkQjD/MHJb5+p7sXtnG+8K759gWsVfBCyknHH6oNCq4Ma7Bm/WbyXYBRbV6nw7Izjqbb7MRYPBEEhuPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dz/v6tqK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcad814986so44731445ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709586995; x=1710191795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht77Rh9chZwrT9wMUxlqK6jHiux3/iT7+lTeKLVMP6A=;
        b=dz/v6tqKCY/UBYsAxcRU13l3FFHsgxgNNzFAc97en43I2g8vM34ha173ymmwCH+fMR
         nwLi31MUF6Z97c29W7lT5pPo6HrYFYOpNofnsxeZY/rMwG/9pTRnie1fnPscPLHYIY52
         4WNLglGM7/YmcRLLriu4ZV1r/wvgyqC9lZo32wnp4KE05BEg9H7LngJz2p2uzQBizIpD
         Ki3nqsnmWqVmfklmdR6YnugKCNs9Fs/r1OsNuhcYksiUr5S949HKNYZNR/fssGq1lqTt
         vMuvNSDl9cJdo7eXefXgWVTgQkGE68FOHEenRuv4XeEFpsQcJx0TXh3Wr/gfBYfZslbS
         KvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586995; x=1710191795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht77Rh9chZwrT9wMUxlqK6jHiux3/iT7+lTeKLVMP6A=;
        b=P7NmKJ4iiJ/PzEwFE9IvLlyVC2dHoGKGxeU2thOuPKt4J4D2RlP8a6qKOy4l1vCNMi
         HoKVrlspwvqN3FUxxPNO+u7bKWG9zUKB54HrNKHZWw+aBqqBkJd9WM9Prw/uK2zQravT
         d0IB80x3nQ14I6F+48nfmjpXwa706QI14hV1O/+KX3Jg0f1h7IFMTHFBvcdcXB03s/GP
         r/Jeqb6mqraiwz0tjrWYL0Q3iMWy+Sm5hU/JK6bOoxbZgxzjeyTRFfd6yD6AGwbSD0Wy
         y4DXXnBdno9CJcoK3tct/zk3070culpu5BV4a7x+VqZXabzQoTiWIWbAVMhfm7fr0VJi
         wwQA==
X-Forwarded-Encrypted: i=1; AJvYcCXsIxYu3x9sZMXLgd88FCmk3MRoc0JO7NaJgITZjhmFOSCKx4lb+40no4R3CwwPk69oR+xDuVlYTveQD8sRxPXgFll6u2fTllJ2d68ikA==
X-Gm-Message-State: AOJu0YydUgdzW9wQIA72kfftmUF+RECZNHAtSBnF1WT5QkTLlztQRUuH
	nZTa1GtSy5Ls6ND617gqSZUlBIOOZsRI41hj7ktv4UdtrvENpHF+Pom33o/GHdI=
X-Google-Smtp-Source: AGHT+IFtDdeII6LXDpO349Taby8wKoqZ7HHSL+QvN62Uu9JmHDBN1LAtjB0yvQGqN54fIdfCkUYpGA==
X-Received: by 2002:a17:903:246:b0:1db:fa72:25eb with SMTP id j6-20020a170903024600b001dbfa7225ebmr11770883plh.52.1709586994977;
        Mon, 04 Mar 2024 13:16:34 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001dc11f90512sm8953929plh.126.2024.03.04.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:16:34 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhFfi-00F4GR-3C;
	Tue, 05 Mar 2024 08:16:31 +1100
Date: Tue, 5 Mar 2024 08:16:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] xattr: Use dedicated slab buckets for setxattr()
Message-ID: <ZeY6Lv4rfUyFHgOr@dread.disaster.area>
References: <20240304184252.work.496-kees@kernel.org>
 <20240304184933.3672759-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304184933.3672759-3-keescook@chromium.org>

On Mon, Mar 04, 2024 at 10:49:31AM -0800, Kees Cook wrote:
> The setxattr() API can be used for exploiting[1][2][3] use-after-free
> type confusion flaws in the kernel. Avoid having a user-controlled size
> cache share the global kmalloc allocator by using a separate set of
> kmalloc buckets.
> 
> Link: https://duasynt.com/blog/linux-kernel-heap-spray [1]
> Link: https://etenal.me/archives/1336 [2]
> Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [3]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/xattr.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..2b06316f1d1f 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -821,6 +821,16 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
>  	return error;
>  }
>  
> +static struct kmem_buckets *xattr_buckets;
> +static int __init init_xattr_buckets(void)
> +{
> +	xattr_buckets = kmem_buckets_create("xattr", 0, 0, 0,
> +					    XATTR_LIST_MAX, NULL);
> +
> +	return 0;
> +}
> +subsys_initcall(init_xattr_buckets);
> +
>  /*
>   * Extended attribute LIST operations
>   */
> @@ -833,7 +843,7 @@ listxattr(struct dentry *d, char __user *list, size_t size)
>  	if (size) {
>  		if (size > XATTR_LIST_MAX)
>  			size = XATTR_LIST_MAX;
> -		klist = kvmalloc(size, GFP_KERNEL);
> +		klist = kmem_buckets_alloc(xattr_buckets, size, GFP_KERNEL);

There's a reason this uses kvmalloc() - allocations can be up to
64kB in size and it's not uncommon for large slab allocation to
fail on long running machines. hence this needs to fall back to
vmalloc() to ensure that large xattrs can always be read.

Essentially, you're trading a heap spraying vector that almost
no-one will ever see for a far more frequent -ENOMEM denial of
service that will be seen on production systems where large xattrs
are used.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

