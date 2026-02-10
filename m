Return-Path: <linux-fsdevel+bounces-76825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aClyBsLwimmwOwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:48:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77901185FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C0F3040460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130F33D6EF;
	Tue, 10 Feb 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvaFxUND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EC274FEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713276; cv=none; b=ZIEtzsmfr6qKWI9IGw7/p1iPDHthTx16NSKHCz0qf48CH2g4UsvABmFxc67wDw9DLaNDN8ykAXbO35NsUzRuBUAmfJhHAtPeXtfCpgQ994J6v9gcVYFTyr1J47xFlh02bVN87YvYlXj7LrXzwQYW3qa/Fup90FMzQEcguSUhelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713276; c=relaxed/simple;
	bh=3lnGLctRTV1ZhP7gsANbRBWYr/uaOemWulTLa6OebJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nlTLtzyUlYPSJfpgleJ+Ndol/yqduGYQfal4UNwTcw0hso8Zwtp5nPFbT+9w+Phjyrp02s3bqLmCuPXj1olmtdrZ3N+uC/eAeqfhp7esyJIBD06AJhM4xlddcTG1lUNC4+hIlEcrvX2v2EMOT+XYLunWEFuXvd3Nau3HWl00Rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvaFxUND; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8720608e53so64049166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770713273; x=1771318073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULYjWWC903FxjlaA/DfXcj/bqj7W1j7W1eSCTHW/xkw=;
        b=EvaFxUND285Y3oVyxjVN89cDVVKtUUnTes1vgOJYBW2C3AcXNDFEt8ikXkvM2jEKwP
         opUNVt7T4n+fgUjZ49Q8Twi7E+KB17Aqk+nlfQgA5QnBh1tVHt6/LBejIO28MqpUjHBY
         z3xp2w1lZk1GoXC8WJiGtg4mMA3LKo8aWbPocEQItu0kO+0z2i43lZyAKVk4+ZepRDNz
         GJDU8bnAwcl7Zec7S1XU0cKi7lBii9eiZ5oVlZDLAF8OnCDCprro26A1AAx6ja9775+/
         PalV8lZHRvPQdvmrnTEmIcIbqqrJswKzwvLmFg+LM8ISsbHvkx8Rhj2yin6DfvTkRWej
         cOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770713273; x=1771318073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULYjWWC903FxjlaA/DfXcj/bqj7W1j7W1eSCTHW/xkw=;
        b=grvqr40IwUpOOraejZ59oj2uIyvKhP0goPdtif1CbGyijC/gw5o6425x8IX2BRHGNA
         97vgFE/SljvAT/QAbnPvteLujMkgMaaYXzOaSw81UHqB8m9uhL+cHqK5aXDlFFoNaru5
         RRM7SzVp+M89K5e3tqfID9CtZqkRJJsUwhnASskGaRFAUWvH/8zjuv3gZApDlMLNI3YQ
         fL2YkoYrdq5SfVYGNBy4UhZZyB8rDzdKBJPdwVu0L6C+SXmPa8rXjt9YCZ1zm6e9SqSy
         p6H7oOiHvOiToJVDGi9aWkP8cw39VpLsRb0sryrY5WOKLEoNoqZ7qZu2RJ7ScpPI54TB
         BR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVcSI2ZqkDbTlGXWh6sINeYtr0hcJyTx6z98OhFiW1ARCk01PoCUSWofd5tULNfTTqJs62N/FYbxn/ENX7n@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOe9PGlGNu8Yt6bSCihx7/6MwZl96H2VNJMtB4jt+qf+59fir
	z/mAsuOVRnO+J86zDNMH94v2JyMEpOHnTUEgPnG4oXp5G93/BeArSANRNMQ0EG64CkFO0pgCrO4
	Qu1yVjfTmYP47uBTasA==
X-Received: from ejdai24.prod.google.com ([2002:a17:907:e158:b0:b8e:b3d3:3838])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d16:b0:b88:510a:59b3 with SMTP id a640c23a62f3a-b8edf40a6a6mr848568966b.48.1770713273356;
 Tue, 10 Feb 2026 00:47:53 -0800 (PST)
Date: Tue, 10 Feb 2026 08:47:52 +0000
In-Reply-To: <df876a6e-013c-4566-890d-7c1d662fced3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com> <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
 <aYSCNur71BJJeB2Q@google.com> <9a037fdf-1a98-437f-8b80-7fdc53d5b0fa@lucifer.local>
 <aYSfBJA4hR4shPfI@google.com> <df876a6e-013c-4566-890d-7c1d662fced3@lucifer.local>
Message-ID: <aYrwuPus_cOyumGo@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76825-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B77901185FB
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:21:58PM +0000, Lorenzo Stoakes wrote:
> On Thu, Feb 05, 2026 at 01:45:40PM +0000, Alice Ryhl wrote:
> > +/**
> > + * close_fd_safe - close the given fd
> > + * @fd: file descriptor to close
> > + * @flags: gfp flags for allocation of task work
> > + *
> > + * This closes an fd. Unlike close_fd(), this may be used even if the fd is
> > + * currently held with fdget().
> > + *
> > + * Returns: 0 or an error code
> > + */
> > +int close_fd_safe(unsigned int fd, gfp_t flags)
> > +{
> > +	struct close_fd_safe_task_work *twcb;
> > +
> > +	twcb = kzalloc(sizeof(*twcb), flags);
> > +	if (!twcb)
> > +		return -ENOMEM;
> > +	init_task_work(&twcb->twork, close_fd_safe_callback);
> > +	twcb->file = file_close_fd(fd);
> > +	if (!twcb->file) {
> > +		kfree(twcb);
> > +		return -EBADF;
> > +	}
> > +
> > +	get_file(twcb->file);
> > +	filp_close(twcb->file, current->files);
> > +	task_work_add(current, &twcb->twork, TWA_RESUME);
> > +	return 0;
> > +}
> 
> Would need an EXPORT_SYMBOL_FOR_MODULES(...) here right?

Ah yeah, for Binder to become a module it would need to be exported.
(Though maybe it's worth moving this logic even if Binder is not made
into a module?)

> > diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> > index c45306a9f007..1c99a56c0cdf 100644
> > --- a/include/linux/fdtable.h
> > +++ b/include/linux/fdtable.h
> > @@ -111,6 +111,7 @@ int iterate_fd(struct files_struct *, unsigned,
> >  		const void *);
> >
> >  extern int close_fd(unsigned int fd);
> > +extern int close_fd_safe(unsigned int fd, gfp_t flags);
> 
> One nit, generally well in mm anyway we avoid the 'extern' and remove them as we
> go. Not sure about vfs actually though?

Right. Not sure about this.

> >  extern struct file *file_close_fd(unsigned int fd);
> >
> >  extern struct kmem_cache *files_cachep;
> 
> I mean this is essentially taking what's in binder and making it a general
> thing, so needs Christian's input on whether this is sensible I think :)

Yeah.

Alice

