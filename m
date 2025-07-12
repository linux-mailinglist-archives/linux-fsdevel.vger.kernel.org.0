Return-Path: <linux-fsdevel+bounces-54752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8CB02995
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 08:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61CD189A1DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652721ABBB;
	Sat, 12 Jul 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSHrh7zA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64913635E
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752302351; cv=none; b=lCjrQUMvujAD4a4iSVdd2h1VUTyXuemBsLpAYI9aSgyNn5alvXI6QYRVNhtiRNusfJFu3PpP8HSisbOIh5BMI+3h1hKnkCLbZL3prSMr8mTaXodkTFoEwcliQ5x5CxeVYRUTD4wBvXIf8NiPUXuKwDshx+5KIWN9byUO1EjdSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752302351; c=relaxed/simple;
	bh=vjbNHUUTaz7zE4va/oal7ojPS1+2shN15+YHj8WnCqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leO5BPzi+Zb3xNno7akaDfvo2qVZJs9nmlriONdszAlAvwl1rzn78d3vNUIeUJuKaiSIl/JZdnnEwgu/2jyaOT+lcb1EaYzxkiWyo3xCChoOSHdqFqUQw4k8/5RJ0ccauGTdSAhE5l6h/f9rQommBpYNnJBPoDd0jEGpg66cv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSHrh7zA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e3f93687so41164875ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752302349; x=1752907149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VPXvH2mvRAGH9FqPEOFIQeu4GENebxxokQWy9jp6IE=;
        b=xSHrh7zAc/y9qj48h0NUu+6EtLJ7fDEKUxenjXuFVMDtpPCLr1IpkOlM+EgeNu41pD
         l0QCMOSuu/CcTf79H7h9Z4GH3lfz/f+TsZR0/7wLo8P0dQGs7Bb1b4Q1wno7c0ffi6Mv
         yxl7Zd6VXB79p2Eq8MEGvque5EkwUXcoEv6ODjFf3ZM7GNDpMs0wi7/6ZGf/IfRtMYeA
         Q0S92FUrPPdfenRtmeTsQtYeoVyy4+uxYWBx4LyEQD5b/8u9/CWi8y4/JSZIR36sOEaI
         WNcy9DpzT4s1y/XkWwneXD6PNmY+mBAr/eTudCm3GG509LkJosGD+Q23q5v4n8mEW+nK
         7OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752302349; x=1752907149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VPXvH2mvRAGH9FqPEOFIQeu4GENebxxokQWy9jp6IE=;
        b=nLQcZO+WXTTay7orrzA4n5mgTSfPDkYsmzn0r5v7wFeJV7W+kPW5kKpppc8rtldGyj
         myOJzYj9SgtQCbA63fUWXPiJbBgb/zdc4RMVe4xtzKfzu1logfL8xNxgsy9M9T9gIZaW
         LqXO4cE7b9EqVhO1HX+h4LZsjrzClY2Vyno8eWitPXP2HytXnO8gve+hJ42WNgsM9D17
         4rH+2V6ItPNK/E3vdxGkm8C0ygzbzRkPjhSD80xtk2DgGXQFinz00ETtVZN0wWDg3idr
         NTLT/Vl0Jl5p9hc+XKZODdhrkFI8WXRrHin0brLdEZYAA8QAahxB6TeBtdnETOuTIPYA
         Et/A==
X-Gm-Message-State: AOJu0YyDDwiI+cgNIwo2MshN0z/wV+p12vFcBJstsOOh5dIay2j7TWUF
	gbFFGUieMG6aWhy+X24RS0z1GhLCcN+1SEXclMMOzFiVdG+LkM586rmX9//wR72SSVgUgFpFfMU
	OecXd3w==
X-Google-Smtp-Source: AGHT+IEIOANH5eJDmrQy1OghKPpT3RQTtaVUtbEUu6u5Eur5hwe0pTX3yRZ9taAb7uMlnuy4k6GOtuVzdDA=
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:2ff:84e6:b2bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d587:b0:235:27b6:a891
 with SMTP id d9443c01a7336-23dede7d510mr84362825ad.28.1752302349138; Fri, 11
 Jul 2025 23:39:09 -0700 (PDT)
Date: Sat, 12 Jul 2025 06:38:33 +0000
In-Reply-To: <20250712054157.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712054157.GZ1880847@ZenIV>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712063901.3761823-1-kuniyu@google.com>
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in unix_open_file()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 12 Jul 2025 06:41:57 +0100
> Once unix_sock ->path is set, we are guaranteed that its ->path will remain
> unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
> does not modify the path passed to it.
> 
> IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
> can just pass it to dentry_open() and be done with that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Sounds good.  I confirmed vfs_open() copies the passed const path ptr.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 52b155123985..019ba2609b66 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3191,7 +3191,6 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
>  
>  static int unix_open_file(struct sock *sk)
>  {
> -	struct path path;
>  	struct file *f;
>  	int fd;
>  
> @@ -3201,27 +3200,20 @@ static int unix_open_file(struct sock *sk)
>  	if (!smp_load_acquire(&unix_sk(sk)->addr))
>  		return -ENOENT;
>  
> -	path = unix_sk(sk)->path;
> -	if (!path.dentry)
> +	if (!unix_sk(sk)->path.dentry)
>  		return -ENOENT;
>  
> -	path_get(&path);
> -
>  	fd = get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0)
> -		goto out;
> +		return fd;
>  
> -	f = dentry_open(&path, O_PATH, current_cred());
> +	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
>  	if (IS_ERR(f)) {
>  		put_unused_fd(fd);
> -		fd = PTR_ERR(f);
> -		goto out;
> +		return PTR_ERR(f);
>  	}
>  
>  	fd_install(fd, f);
> -out:
> -	path_put(&path);
> -
>  	return fd;
>  }

