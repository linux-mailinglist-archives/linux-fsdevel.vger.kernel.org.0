Return-Path: <linux-fsdevel+bounces-26193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB76955713
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2491C21147
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7441494AC;
	Sat, 17 Aug 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lv1S8Zby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B38837
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888862; cv=none; b=LrgYFdO3Ux/88vtfkUUnd5rQlzkUEwSHvHHcXwhGEEYH0i5A6PPt/AIw8aYdAiXNqkQzSDJmP63hFOaIHk57rPm51npwD+0Ql5CSSRzZyp1F+2lVv+jti02C9eugpWi973JD/cw2Dca+iExWo9SXRmVKANt2y4FmjaHsl9qtSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888862; c=relaxed/simple;
	bh=nDX73kmG43zD1h9uI+pb/oshet7B35SLo/HwmSmtjWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAC/RVa/oPcGqBj6S2Z23l9RdFzW5FQLZmL2w0yFrx+lVn/0CoI3uZh1TfcW0CVbscL051X89Yz2/N1uATHp+P02xrIOpz/dHi63tayIEpp+TYVzSrrXvnFZUaW87fBPn8O7rnuL+2ZP9k9/I+suw5zkBUEXE0GGUsGmRLgzpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lv1S8Zby; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928cso20103395e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723888859; x=1724493659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wOaVFGUPugW85pZ5rWgM4fAp/o3v69bNqYxxQVcnxU=;
        b=lv1S8ZbyEjUwKXDdgjupMufQvasQooyDQ4NhmPA7EBF1U6r0DN4f3kqRBmsVS9k/NP
         0/GsH0qehXsAPvT4LUTO4baNpr56q429aM7MIvzB7G1IIStovFsQUZ/0XQ4OLf2c5L+D
         C29YQvjWdAv+Win6JgfibyzSMIVk5OZ+jCfO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723888859; x=1724493659;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wOaVFGUPugW85pZ5rWgM4fAp/o3v69bNqYxxQVcnxU=;
        b=g3SrJbgAHlZWlUnVzzxez9hluvUFbT9l4fUiTtDYZ6jVJenCuMV64FNVA2Qp1IiSJH
         2ntsYRl39e1TBlvx5OT8WMyv45Alj7OoPMu1lRCxOtRqsX4SY1RDqtec68hvYoYFWfkX
         usoz/uhb+83i3ww+MfHAf5ii/BI2cMJVhphmlAZdQnT2Bfe6gpIOxoUHoAvtP2L43yee
         USxK1P/yc9/xeY7qEyWSZthTPC0g52qmIBO59slDD9nY+fqAJ1ZmPcKMG4uURgptgQdI
         kK5fqnrpSJWpmz76VN4xRgk8eix8OgX6Xv4AvP89SI761ujLknT1mkykQO40FrFoK/yv
         meuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKUC7U4ZIDPThnnJmNjZv/cB1hGCIf5mrEoctMSKK+FZ9GySRe9ivp34byc2Jdjel+wNJrWwwmIvR4bFR7M7amXNH+jSGd6J+saIOXQ==
X-Gm-Message-State: AOJu0YwADoSYK2Hblg9fV/fAh2Rat33HDFwMcncCeZGvGwew/xJOTUoG
	QGyKGobpzXUzvKn0FDRH3/YKR0ARitg/M6maNMJ2lWoV4/7phn3nfFQmU1rJZGU=
X-Google-Smtp-Source: AGHT+IHfQWV98fZLeG84YWRpqKY4ur3K6QpUoQyzhtj2RkcLl3fzp/oRkmKTRxcOvBE8DiQ+VXR6gA==
X-Received: by 2002:a05:600c:4445:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-429ed7891demr35901395e9.11.1723888858539;
        Sat, 17 Aug 2024 03:00:58 -0700 (PDT)
Received: from LQ3V64L9R2 (default-46-102-197-122.interdsl.co.uk. [46.102.197.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabf5sm5490505f8f.97.2024.08.17.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 03:00:58 -0700 (PDT)
Date: Sat, 17 Aug 2024 11:00:56 +0100
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <ZsB02OnFM1IhLkAt@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
 <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
 <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
 <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>

On Fri, Aug 16, 2024 at 01:01:42PM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:
> > On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
[...]
> > > Willem de Bruijn wrote:
> > > If the only goal is to safely reenable interrupts when the application
> > > stops calling epoll_wait, does this have to be user tunable?
> > > 
> > > Can it be either a single good enough constant, or derived from
> > > another tunable, like busypoll_read.
> > 
> > I believe you meant busy_read here, is that right?
> > 
> > At any rate:
> > 
> >   - I don't think a single constant is appropriate, just as it
> >     wasn't appropriate for the existing mechanism
> >     (napi_defer_hard_irqs/gro_flush_timeout), and
> > 
> >   - Deriving the value from a pre-existing parameter to preserve the
> >     ABI, like busy_read, makes using this more confusing for users
> >     and complicates the API significantly.
> > 
> > I agree we should get the API right from the start; that's why we've
> > submit this as an RFC ;)
> > 
> > We are happy to take suggestions from the community, but, IMHO,
> > re-using an existing parameter for a different purpose only in
> > certain circumstances (if I understand your suggestions) is a much
> > worse choice than adding a new tunable that clearly states its
> > intended singular purpose.
> 
> Ack. I was thinking whether an epoll flag through your new epoll
> ioctl interface to toggle the IRQ suspension (and timer start)
> would be preferable. Because more fine grained.

I understand why you are asking about this and I think it would be
great if this were possible, but unfortunately it isn't.

epoll contexts can be associated with any NAPI ID, but the IRQ
suspension is NAPI specific.

As an example: imagine a user program creates an epoll context and
adds fds with NAPI ID 1111 to the context. It then issues the ioctl
to set the suspend timeout for that context. Then, for whatever
reason, the user app decides to remove all the fds and add new ones,
this time from NAPI ID 2222, which happens to be a different
net_device.

What does that mean for the suspend timeout? It's not clear to me
what the right behavior would be in this situation (does it persist?
does it get cleared when a new NAPI ID is added? etc) and it makes
the user API much more complicated, with many more edge cases and
possible bugs.

> Also, the value is likely dependent more on the expected duration
> of userspace processing? If so, it would be the same for all
> devices, so does a per-netdev value make sense?

There is presently no way to set values like gro_timeout,
defer_hard_irqs, or this new proposed value on a per-NAPI basis.
IMHO, that is really where all of these values should live.

I mentioned on the list previously (and also in the cover letter),
that time permitting, I think the correct evolution of this would be
to support per-NAPI settings (via netdev-genl, I assume) so that
user programs can set all 3 values on only the NAPIs they care
about.

Until that functionality is available, it would seem per-netdev is
the only way for this feature to be added at the present time. I
simply haven't had the time to add the above interface. This
feature we're proposing has demonstrable performance value, but it
doesn't seem sensible to block it until time permits me to add a
per-NAPI interface for all of these values given that we already
globally expose 2 of them.

That said, I appreciate the thoughtfulness of your replies and I am
open to other suggestions.

- Joe

