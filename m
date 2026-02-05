Return-Path: <linux-fsdevel+bounces-76403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF9WOkmBhGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:38:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11BF1F56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC90301AA7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65A3B52E7;
	Thu,  5 Feb 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ToISBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738835C1AF;
	Thu,  5 Feb 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291513; cv=none; b=GTOQlVmugR+D6Acguu0WsGB7DBvozHCeHjtirmyDwIxMOt7bKlCsI9ts6pNJ5vcZgUqSGWjwYsACeXX8aBLg0rutojF0joJg3ju6ULedbueyLchRXGjBt109FvxzTShomK5Ew/04ZlW3/yeQTeBxEwQGJXQPKXjwFNlCqK3VWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291513; c=relaxed/simple;
	bh=PM0XV/uT/jCnIxBlVSrxNfFfXmA4nUroh+I9xLVtYfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYJdLVGH3COzpujFsMT2x5oppm2JG4/pkGz80Rg0+/xt4LSvX5CjNYBAeBc8Cpy49SZTqAQz5JfeBZPhDBgoRtIZ8NrY+5QCWWhQgvLna82DnZYI4M3sI4omglUrpuaeHeBb9eyN3qjA9X+Mk+uVB+z/dzSXixvbHQ6uoQBl00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ToISBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA6BC4CEF7;
	Thu,  5 Feb 2026 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291512;
	bh=PM0XV/uT/jCnIxBlVSrxNfFfXmA4nUroh+I9xLVtYfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3ToISBU7ApYFyJrR45t52S2cND4hxuUwGAkEz9buEwGEVIxCZ+PwIyX8rw3833IZ
	 1WERE75sN6q3JPGmCueFi683z+0eoY4ewv8urdc+GSU2pMV8VNzRdFkG3UkUUCD9N3
	 Fh4VH8xSR17PHY6j8BLCg3725dqglYRxSI8v5LGmb8RqaZLOOo3Ksnq6FY+29xKNf0
	 /PRYNTM6NOmfUqx6V5pPsdkfOiVTfCK/rwHL9tbRS0b6LKoACHEQqpMRx/CB5cYnIm
	 LYSFlsJw+9nhcK+tK2LFtMwwXjNuc53HZ7vy7kkzft3YkFeoJ1gvhON/v//ieCBr/W
	 PQOP2f8vTuRlA==
Date: Thu, 5 Feb 2026 12:38:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
Message-ID: <20260205-mitschnitt-pfirsich-148a5026fc36@brauner>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76403-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,kernel.org,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B11BF1F56
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> This exports the functionality needed by Binder to close file
> descriptors.
> 
> When you send a fd over Binder, what happens is this:
> 
> 1. The sending process turns the fd into a struct file and stores it in
>    the transaction object.
> 2. When the receiving process gets the message, the fd is installed as a
>    fd into the current process.
> 3. When the receiving process is done handling the message, it tells
>    Binder to clean up the transaction. As part of this, fds embedded in
>    the transaction are closed.
> 
> Note that it was not always implemented like this. Previously the
> sending process would install the fd directly into the receiving proc in
> step 1, but as discussed previously [1] this is not ideal and has since
> been changed so that fd install happens during receive.
> 
> The functions being exported here are for closing the fd in step 3. They
> are required because closing a fd from an ioctl is in general not safe.
> This is to meet the requirements for using fdget(), which is used by the
> ioctl framework code before calling into the driver's implementation of
> the ioctl. Binder works around this with this sequence of operations:
> 
> 1. file_close_fd()
> 2. get_file()
> 3. filp_close()
> 4. task_work_add(current, TWA_RESUME)
> 5. <binder returns from ioctl>
> 6. fput()
> 
> This ensures that when fput() is called in the task work, the fdget()
> that the ioctl framework code uses has already been fdput(), so if the
> fd being closed happens to be the same fd, then the fd is not closed
> in violation of the fdget() rules.
> 
> Link: https://lore.kernel.org/all/20180730203633.GC12962@bombadil.infradead.org/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  fs/file.c          | 1 +
>  kernel/task_work.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 0a4f3bdb2dec6284a0c7b9687213137f2eecb250..0046d0034bf16270cdea7e30a86866ebea3a5a81 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -881,6 +881,7 @@ struct file *file_close_fd(unsigned int fd)
>  
>  	return file;
>  }
> +EXPORT_SYMBOL(file_close_fd);
>  
>  void do_close_on_exec(struct files_struct *files)
>  {
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 0f7519f8e7c93f9a4536c26a341255799c320432..08eb29abaea6b98cc443d1087ddb1d0f1a38c9ae 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -102,6 +102,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(task_work_add);

Uhm, no. We're not going to export task_work_add() to let random drivers
queue up work for a task when it returns to userspace. That just screams
bugs and deadlocks at full capacity. Sorry, no.

