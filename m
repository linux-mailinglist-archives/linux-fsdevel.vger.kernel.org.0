Return-Path: <linux-fsdevel+bounces-79440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOCyE0KmqGkYwQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:38:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E66820807C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1937B304DF15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C163932E2;
	Wed,  4 Mar 2026 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeOv4i62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC5273D8D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660269; cv=none; b=IFcZ88IrE5VySuK+tUTUIh8xHTfAawDYeBYCSJJ6mDyT/jn6+biLyQp8rkWXSn0gfOGsGQzLY1FgyUXlapuoUqDg7wyAzHamDT6XeOUlZg8zgHHq17mDZaqg/V7ztm40FY6UgD4+o0DF+Xc/MIUvyy4C6uWw3Em6QSQmM2OrMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660269; c=relaxed/simple;
	bh=DHFzucvKQo9mJnpiOC/mpjemhEuJZ6EV4obLrcNxNYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F8N0Lcv9OlCzOH/fAn42pF2TfuGmZQMkem1PApNhOLlRKNTSK9JDQAc0y/KSMvvdJMBA2fNcdCc7y9ybvmpSK52qUtnjeO/KZOkto5QgUHSJfgoMcSDXY1t8twWRKBPwzio3noZkiUpt3qP2Pql2zGVZobDyTZMgHDE6Gkm2GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeOv4i62; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836b7c302fso75279565e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 13:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772660267; x=1773265067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3B6twlxs7RG5L5HQ0RR3EQNIcTaBDOh7BWXSLk64tU=;
        b=PeOv4i62mPdMN5GCFB4SI/nked8GOPruvrh9hLhH7seF6Tu+9ZCDjzdlYqv62xeyEW
         w4bltHeaJRElv1u9HArZLc8VCUn7rYhZEHNBN0vtn61qpT32va6U703RD/F9lQd97qPv
         cp/DAmuziaoS1QaGnaxh0eRi8xYxxqPEWV0XP0WrojV2DFLpdt03C1DRawQoDmqTevaQ
         GNHzje+jMWE/zSGPzDR6ZeCz1+bQAzSzQ/hAH+dZTOG/otHkGxknlSPeVxfv7JHpuP7c
         E7ykQzdlFb6hBoMqkCh0L9LNFSePPC6QctcitDd8VtTOy1eRPZPMO1afwSCM3q6LyjaF
         Dc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660267; x=1773265067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3B6twlxs7RG5L5HQ0RR3EQNIcTaBDOh7BWXSLk64tU=;
        b=jp2XME7KwCj85WfeGxZrSFQpZiubgM5prvbS4VDttMAd9FI1wgkTKgLvw4rclytjUl
         pSKNgg1vjV0uN+r5UNc1NHCsQlkyN3wOHHlX4yquilE7Bt3MsFVJ08T/MYvhS1rxPudg
         UId+NzbY6o0b2MBnw6awsIdWOclEUG9SuFcvbTXdteebDI7rIk1p2WwMiHCjJHBa6FvC
         QUZNCfFWdAYrddt5bey/9nw/ddFgMGzFq2g6RndmUOx15uUPDuvv/qjq70NR0yUnuhnD
         SnuO7Xq+bq2Plk1snnhHbNqkb0CiWFmEfqdtg+imOtkL+x7ieNzjQGLlwT099/NfIah5
         D4FA==
X-Forwarded-Encrypted: i=1; AJvYcCW5D5hDsvAO8d+6AlnzKP5yR/918m+bO7tS7SANbgzx69mZh+MK7ks2zWpBoCYucP+mL2yv52omoOzqn5nx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxojalre6mln5X8b4ouZSVtQom6EU7L3bo02ruFqRUNTbeH/NxI
	ksBmi6YRJcXYwVbtCygxQSPASavMnwcxBeSKxdSpbCfreNeBq5YUHmilAHxEDKWVVSCFFFdMnt2
	Sp2EC//lbQlCug6Wd7Q==
X-Received: from wmjx23.prod.google.com ([2002:a05:600c:21d7:b0:482:ef67:407f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a087:b0:485:110f:5b7f with SMTP id 5b1f17b1804b1-48519888e6amr59392995e9.19.1772660266742;
 Wed, 04 Mar 2026 13:37:46 -0800 (PST)
Date: Wed, 4 Mar 2026 21:37:45 +0000
In-Reply-To: <aahd2DIXFJiUKy0S@tardis.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
 <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com> <aadbyBmaV8zCYiog@tardis.local>
 <aafmf5icyPIFcwf_@google.com> <aahd2DIXFJiUKy0S@tardis.local>
Message-ID: <aaimKbwAbPfBUPG6@google.com>
Subject: Re: [PATCH v2 1/2] rust: poll: make PollCondVar upgradable
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 9E66820807C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79440-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,linuxfoundation.org,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:29:12AM -0800, Boqun Feng wrote:
> On Wed, Mar 04, 2026 at 07:59:59AM +0000, Alice Ryhl wrote:
> [...]
> > > > +        // If a normal waiter registers in parallel with us, then either:
> > > > +        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
> > > > +        // * They took the lock first. In that case, we wake them up below.
> > > > +        drop(lock.lock());
> > > > +        self.simple.notify_all();
> > > 
> > > Hmm.. what if the waiter gets its `&CondVar` before `upgrade()` and use
> > > that directly?
> > > 
> > > 	<waiter>				<in upgrade()>
> > > 	let poll_cv: &UpgradePollCondVar = ...;
> > > 	let cv = poll_cv.deref();
> > > 						cmpxchg();
> > > 						drop(lock.lock());
> > > 						self.simple.notify_all();
> > > 	let mut guard = lock.lock();
> > > 	cv.wait(&mut guard);
> > > 
> > > we still miss the wake-up, right?
> > > 
> > > It's creative, but I particularly hate we use an empty lock critical
> > > section to synchronize ;-)
> > 
> > I guess instead of exposing Deref, I can just implement `wait` directly
> > on `UpgradePollCondVar`. Then this API misuse is not possible.
> > 
> 
> If we do that,then we can avoid the `drop(lock.lock())` as well, if we
> do:
> 
>     impl UpgradePollCondVar {
>         pub fn wait(...) {
> 	    prepare_to_wait_exclusive(); // <- this will take lock in
>                                          // simple.wait_queue_head. So
>                                          // either upgrade() comes
>                                          // first, or they observe the
>                                          // wait being queued.
>             let cv_ptr = self.active.load(Relaxed);
> 	    if !ptr_eq(cv_ptr, &self.simple) { // We have moved from
> 	                                       // simple, so need to
>                                                // need to wake up and
>                                                // redo the wait.
> 	        finish_wait();
> 	    } else {
> 	        guard.do_unlock(|| { schedule_timeout(); });
> 		finish_wait();
> 	    }
> 	}
>     }
> 
> (CondVar::notify*() will take the wait_queue_head lock as well)

Yeah but then I have to actually re-implement those methods and not just
call them. Seems not worth it.

> > > Do you think the complexity of a dynamic upgrading is worthwhile, or we
> > > should just use the box-allocated PollCondVar unconditionally?
> > > 
> > > I think if the current users won't benefit from the dynamic upgrading
> > > then we can avoid the complexity. We can always add it back later.
> > > Thoughts?
> > 
> > I do actually think it's worthwhile to consider:
> > 
> > I started an Android device running this. It created 3961 instances of
> > `UpgradePollCondVar` during the hour it ran, but only 5 were upgraded.
> > 
> 
> That makes sense, thank you for providing the data! But still I think we
> should be more informative about the performance difference between
> dynamic upgrading vs. unconditionally box-allocated PollCondVar, because
> I would assume when a `UpgradePollCondVar` is created, other allocations
> also happen as well (e.g. when creating a Arc<binder::Thread>), so the
> extra cost of the allocation may be unnoticeable.

Perf-wise it doesn't matter, but I'm concerned about memory usage.

Alice

