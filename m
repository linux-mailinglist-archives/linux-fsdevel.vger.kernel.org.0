Return-Path: <linux-fsdevel+bounces-77397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD61F7LPlGlGIAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:29:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B514FF7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CFC2305F67D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2E37755A;
	Tue, 17 Feb 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WWELYzXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B736D4FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360070; cv=none; b=ZJd7cBZCEm99K9REKpPZDRw/MbXrODho2wjEkt2xVAp52m6NzzYT/9niEpN4J5hXXH+3/YhxDrFE5hG+9JSN9YGRhk/djNOfae56GoX5bV1/8DDC9tAarxkGY9taUomwUjsXpkKFArk2lG4VljdWxdLnOHjEAJeY4ppW3ah1OsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360070; c=relaxed/simple;
	bh=/9zPP2G4JeboX0+cDTSzN7re16L5WGfUqhrSKmHc3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etvTK3R+LcieM74SU//K9LnMGEG6seBk8f0CU17gWWg9r5byUtedsUny9M+qF/6r9Bo+2572iiGfYOFwFSFAuKeEQYguPxfzdklBLMlJZO2q1RYgj5GXawJ2+UATd8EoGFluxlQFayQo5wtRRoH8J0EL4F7WHgezaB6LPI2Wr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WWELYzXO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so7800692a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771360067; x=1771964867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9FeJRBMRyCrCa/QY6et9khCB1LQpN5iJP8D4ikcUfM=;
        b=WWELYzXOS7GIVkYj2eN15fj2fASk5ekaymGVPwV+5+4cg+GYVwcqboiF+PtFFJFnX4
         kYUiIYxz+CC/hfXDFG66oXsd0kDYKP0ILYriQsc7F6Iac9fyou3/WyAZuotzUJL8t2GK
         u+psmL7y11iZkq6lCowQOQbZbqH4oPhKf/xPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771360067; x=1771964867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9FeJRBMRyCrCa/QY6et9khCB1LQpN5iJP8D4ikcUfM=;
        b=qQIh754DGytKQUh5Y4KugL9rXRHw0HUvovPSeHz/8ytYmkKX8LBYXRT1yomeEXRXFF
         /CzmZ51b2bW3B4k5PJFIG0mQlsosOVIGOnhg/1PH2pDMjaUM/+cY3i/TYEf9Ps/EmCDU
         kgvnv93Y9MQTKtIZ9BoGODVzie4NkIG+Z4rWnYdUkcIGGurJeDkPwKTe+KFNDjRfzPY3
         HXRkVNzYtxgEBGveWT5MMf8TvQoxmOjcL1pOeOqjrKOBygupG+AF1atRtdDYJ2FeqeMX
         lR70BZu0CZffPIJYEBEI83dQPxlkQNVm3DlTrnAefpE6utAproGLEmNkZ58iCGBFswEp
         DL6g==
X-Forwarded-Encrypted: i=1; AJvYcCWCp9fhLXSlTxrVigThH/3Zsmc0hz18AtEwr7B6oey1elVko/MLXiCbYO0dofO94eY30LY9TC/aL5YRwEdh@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ86vclveBMm9oqaNrWenoCy7w5tWCbNObuXEQFNczPhSLgOlZ
	fEnbjWKzAHe/EVZaKPED2KpAqa8kRTxr+Jy84pHYJHhGol5/MYFi4Zy5RNPL4oM4lLX/hZtw7wh
	/7sR5z7W2aA==
X-Gm-Gg: AZuq6aJVL8wCvc9CXsg70BhICnYKGh3yNcQpFyYJPvVSacfxAX/Vz/YahKns/DNkLFd
	nCA918qWozYj6ZmJmoRyfpg+0ErPX9QfppqpHooHMySZkU7D04vkNIHlCz32W4GFVapUGNvu0pW
	ybd0Li67+tm3nvsug/CJnRxC+XHZzyy+8uqMfEum8IUM+8An4h22mLB1XjqLCfAOXiA2F6D4dsY
	ZTt186s2QUVjLsOR7Bgu2URwP/tB3EyFZsm6QN+R+2YDZ8KNSHrLM4v8BKt5PVxNzj6wfAh+g8E
	lo8Sl3KbOlqKDyzIAh0GDi7M99hNyoR51e+1a5hmTTK37Zd3lBjCMzYsiw+opDZRx81CPfm+5Zf
	wygBXO8H8bqhQOTE7mSg1LoH2A3Angjm/xqYaFWkSdRU9Wtedn0hmjtrVc/lavloCi1bwi6k6dH
	aTM14TpfsM8mgQh21HOgAZs1GJdHILFtsBj0kQSE6U11K8huiTjl40xfQvYuVCsWsASGDVi4CD
X-Received: by 2002:a05:6402:254a:b0:658:115e:34a9 with SMTP id 4fb4d7f45d1cf-65bc785f787mr5789209a12.8.1771360066838;
        Tue, 17 Feb 2026 12:27:46 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3f1294sm2640520a12.26.2026.02.17.12.27.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 12:27:45 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so7633495a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 12:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjgKDButgCvE1EdVit7g6jBOMEQA3GOaOLvywqZCNwCeeWEEGs6h3YUE5NSeRCf8t2Vgq/Ho46Qa7LPYkW@vger.kernel.org
X-Received: by 2002:a17:907:3d9f:b0:b87:6c1e:9ffb with SMTP id
 a640c23a62f3a-b8fc3ca8e29mr763220966b.48.1771360065464; Tue, 17 Feb 2026
 12:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217190835.1151964-1-willy@infradead.org> <20260217190835.1151964-2-willy@infradead.org>
In-Reply-To: <20260217190835.1151964-2-willy@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Feb 2026 12:27:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
X-Gm-Features: AaiRm53Jwdj8IhdDu6SvPDHJOVyPK7HyrIdGj3FV4JAh81jBIiCi4hjzrD6typ8
Message-ID: <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77397-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: C97B514FF7C
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 11:08, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Instead of embedding a list_head in struct rw_semaphore, store a pointer
> to the first waiter.  The list of waiters remains a doubly linked list
> so we can efficiently add to the tail of the list, remove from the front
> (or middle) of the list.
>
> Some of the list manipulation becomes more complicated, but it's a
> reasonable tradeoff on the slow paths to shrink some core data structures
> like struct inode.

I like this, but I have to say that I dislike how rwsem_add_waiter()
in particular ends up looking.

Not because it's horrible on its own, but when you look at the
call-sites, that function ends up being entirely pointless.

It does two things:

 - it asserts that the wait_lock is held

 - it now checks whether the new waiter is the first one and does two
different things depending on that

And lookie here: there are exactly two call sites, and both of them
are immediately preceded by a

        raw_spin_lock_irq(&sem->wait_lock);

and one of them then goes on to check whether there are no waiters
before it calls rwsem_add_waiter().

And the other? Immediately *after* the call, it does

        /* we're now waiting on the lock */
        if (rwsem_first_waiter(sem) != &waiter) {

so that other call-site *ALSO* basically ends up having special code
for "am I the first writer"?

Put another way: this helper function seems all kinds of pointless and
it got worse in this iteration, because the pointlessness is now in
some of that added complexity.

So considering that there iareonly two callers. and both of them
*already* fundamentally know about this whole "first waiter is
special" situation, that helper is actually the opposite of a helper.
It's actually hiding what is going on, and just making code generation
worse.

If we want helper functions, can we please just make them be
"add_first_waiter()" and "add_to_waiter_list()", and make them
actually be what the callers need and want?

Somewhat similarly, I also reacted to this part:

    -#define rwsem_first_waiter(sem) \
    -       list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
    +#define rwsem_first_waiter(sem)        sem->first_waiter

that rwsem_first_waiter() macro used to make sense as a syntactic
helper function. But now it really doesn't. It is literally more
typing and *less* legible than just accessing that new
"sem->first_waiter" field.

In other words, I like the direction you're taking, and I think the
code already is set up to have that whole "first waiter" thing that
your patch just makes much more explicit and obvious. That all argues
that yes, having a "first waiter" pointer instead of a "struct
list_head" is a good change.

But I think some of those existing helpers were because we did *not*
use to do it that better way, and they were designed for the old world
order, and they no longer make any sense with your changes.

Hmm?

               Linus

