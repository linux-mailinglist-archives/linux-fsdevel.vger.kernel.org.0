Return-Path: <linux-fsdevel+bounces-76404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AzyAEaChGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:43:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368AF1FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9C393004D09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312970810;
	Thu,  5 Feb 2026 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weY/gQ12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001D3A9D95
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291771; cv=none; b=nAwrgTgagXbstca4n47mepzxC7pU25EVA2GpkoiyO4IryX5XQ94NAR6C3RbLVWRSIfLZ0eAdg436Djl9eVx0JbT6IQbdlyanFYWdZebD1cAn9KyrjAqSU1ya3uuzgos8tK0Ip0c0rAg6Xj7AIHuk02skypTsI8TwwHl73nhQC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291771; c=relaxed/simple;
	bh=Bt+fYzKw8AlmPnNaqzpY8FozNkNgG19Kj3CbOJxPGns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGRE+b8JycCiuEvjeHQffxDnOF2DVwmqRI8bIonwdRLIkPM++ju34Rt1DU8knxgWcrNoDKZbBR+P+X88QdE9vxubIW1Mx4UgIgfGom9M+cMkcd7IzIPibNwkhA7uWsoSrZG5OfMUILNp9I/QgWx6k/l36vTu43tJylfiNx5FsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weY/gQ12; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4831192e66aso8284665e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770291769; x=1770896569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9zFwpzMf0m7VjNRoMa+VYvPnrR6qveuvQACHy4StpI=;
        b=weY/gQ12fRnpI2UF09WK12cMwD65jwI3areoDjG8gF96hZ9AZXdjSXkNdbu3Kk3xJL
         OyOrGuLqA1u3SWSnSvq3tW/ry/tz/91ji87pFAHfjmMAqaBWe6KnxUrFS7fKfJ257elZ
         qYjEr6oM1g35GeqPpHAW29KW/DIEcZfCFjxgAyXQNfzlGrZjW2VU84ntDC7924AH7g8s
         zP/55XwpoDbZ5ddgXaPqnkFhHlvb0p61apNy0Ob52xhdKaqByrrP0omF0uiNOZwjlCgw
         Tt7B/tkIO/m7KiYx+RtAMdvA6OOsgpTWa6rRMNRV6M3k28b58zlYiZzSSQiweLhdwzvH
         Rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291769; x=1770896569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9zFwpzMf0m7VjNRoMa+VYvPnrR6qveuvQACHy4StpI=;
        b=pW12N6XB8yalYI5CkYxWwwlmO/lb702gec4KFBSJ65FfgLwUKykcZxLcca9/eJTzI0
         qAN4DtGsaSbbzUDVfs/j75C00RQ45/LUQC7zza9FuZTV9sz2L7y7iqnBvb8be/4hI46z
         uNpt+xH/Ay1ppIVs4RVx4zWV1bmSo0cAV7hUk5Tpp/R915OIVj4xkz9UeA6FPpoCyRws
         tduQ9lX9rCiRSZDBLN9rEclOFEMQdLWvEHEQC10lDJQ2/5b9loP06AYQdGT6bJTGG4GX
         t/JYPDPyehC5WAWnMb5ToccTqVN7374mzepdD2/LkZXMGVIpUXZ5efbUIkRiFKE+alEy
         0DBA==
X-Forwarded-Encrypted: i=1; AJvYcCXvrCvxodj8CjyR5drgbYarshgbyxJx2nq4MZA1qmten5sKVGsjGsK8VbvmCNUlo0cUYKzW9k908CNElh5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvSMOHnGuw2PIw2Idy8J9+9v9IdrRkg0zhdIwCez7e2JquDdn
	bnbQjebYRQ/fprll1GLdL3u9NAYY3smGfsK9qDeZHTdIDEwyDegAC/8QNLZzYd41yVclO5cryQM
	xMGjlWC1DZxjDArl3Hg==
X-Received: from wmbz6.prod.google.com ([2002:a05:600c:c086:b0:480:4a03:7b6c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:530f:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-4830e9552a2mr89288445e9.15.1770291769579;
 Thu, 05 Feb 2026 03:42:49 -0800 (PST)
Date: Thu, 5 Feb 2026 11:42:46 +0000
In-Reply-To: <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com> <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
Message-ID: <aYSCNur71BJJeB2Q@google.com>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76404-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5368AF1FCF
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:20:33AM +0000, Lorenzo Stoakes wrote:
> On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> > This exports the functionality needed by Binder to close file
> > descriptors.
> >
> > When you send a fd over Binder, what happens is this:
> >
> > 1. The sending process turns the fd into a struct file and stores it in
> >    the transaction object.
> > 2. When the receiving process gets the message, the fd is installed as a
> >    fd into the current process.
> > 3. When the receiving process is done handling the message, it tells
> >    Binder to clean up the transaction. As part of this, fds embedded in
> >    the transaction are closed.
> >
> > Note that it was not always implemented like this. Previously the
> > sending process would install the fd directly into the receiving proc in
> > step 1, but as discussed previously [1] this is not ideal and has since
> > been changed so that fd install happens during receive.
> >
> > The functions being exported here are for closing the fd in step 3. They
> > are required because closing a fd from an ioctl is in general not safe.
> > This is to meet the requirements for using fdget(), which is used by the
> > ioctl framework code before calling into the driver's implementation of
> > the ioctl. Binder works around this with this sequence of operations:
> >
> > 1. file_close_fd()
> > 2. get_file()
> > 3. filp_close()
> > 4. task_work_add(current, TWA_RESUME)
> > 5. <binder returns from ioctl>
> > 6. fput()
> >
> > This ensures that when fput() is called in the task work, the fdget()
> > that the ioctl framework code uses has already been fdput(), so if the
> > fd being closed happens to be the same fd, then the fd is not closed
> > in violation of the fdget() rules.
> 
> I'm not really familiar with this mechanism but you're already talking about
> this being a workaround so strikes me the correct thing to do is to find a way
> to do this in the kernel sensibly rather than exporting internal implementation
> details and doing it in binder.

I did previously submit a patch that implemented this logic outside of
Binder, but I was advised to move it into Binder.

But I'm happy to submit a patch to extract this logic into some sort of
close_fd_safe() method that can be called even if said fd is currently
held using fdget().

> > Link: https://lore.kernel.org/all/20180730203633.GC12962@bombadil.infradead.org/ [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  fs/file.c          | 1 +
> >  kernel/task_work.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 0a4f3bdb2dec6284a0c7b9687213137f2eecb250..0046d0034bf16270cdea7e30a86866ebea3a5a81 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -881,6 +881,7 @@ struct file *file_close_fd(unsigned int fd)
> >
> >  	return file;
> >  }
> > +EXPORT_SYMBOL(file_close_fd);
> 
> As a matter of policy we generally don't like to export without GPL like this
> unless there's a _really_ good reason.
> 
> Christian or Al may have a different viewpoint but generally this should be an
> EXPORT_SYMBOL_GPL() and also - there has to be a _really_ good reason to export
> it.

Sorry I should just have done _GPL from the beginning. My mistake.

Alice

