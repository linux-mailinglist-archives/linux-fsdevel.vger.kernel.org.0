Return-Path: <linux-fsdevel+bounces-46115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF3A82C08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE329189F3CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D822C35B;
	Wed,  9 Apr 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7E8R6Wd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D11D514B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214944; cv=none; b=UKzuWJSCYzAPEaqgCcH/veLk3RBy3f0LnFRrTxko6UaMuFT+Sj2Q5nWopPZcyCC0huft+HpnMtXr/Tyz8fBHPqBc4lGjcA6vgn/K7ldTxYDU2GGyLmkpI0T10clBAZPMD4V/Uthy9QR55ZtqcbtvaW1YXZBiWjksv7DAeCRbW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214944; c=relaxed/simple;
	bh=OmUCUuBlmfaYCRI+35suQ8O6IFTakFO4F0FI9+UZMTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGIzXspQqi08IztD4Y85GrWDsotQy/yxHihK/pOThCysAtt/Zzcs/fGRoixEkOsQoRWnS6Vt4xiiE/H8+KfStBEzht/oYzC4WctapdjArFkrMmoB/z0PK4oz6WsfW13EzTng6xx2QyBz5yps7Y3X007bM8e5U2eNHeqysMsVs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7E8R6Wd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744214940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/gwbs8iUTadHjheIXDz5biM7bJ/ozoAzELzVwioeRI=;
	b=N7E8R6WdFgjrXs02tf4+S5WqZUI21rVHWwPayba4eQhPEApx0CEzUAwLt8GJxhJJZuADww
	yaMcf6vi//+MEGFy00N0Uo/blfaALNf3xzZRSRDGxVpl8DlGyQSnKtQZKR4lKqY1QceSN0
	bFW7mapnO/x5AT9tD2EBxwc4e0hy+kU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-1Vw9N9XNPiaJN9ADX7Lf1A-1; Wed, 09 Apr 2025 12:08:59 -0400
X-MC-Unique: 1Vw9N9XNPiaJN9ADX7Lf1A-1
X-Mimecast-MFC-AGG-ID: 1Vw9N9XNPiaJN9ADX7Lf1A_1744214937
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e91b1ddb51so131389746d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 09:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214937; x=1744819737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/gwbs8iUTadHjheIXDz5biM7bJ/ozoAzELzVwioeRI=;
        b=jUPjAfLGv/QRHl4JYU2i/76dcta5gfi5X+g3H4DLmXVbHFZJ4U5+srz54TlVS19rAy
         P+B2xIwIoGym1Ki3qBsslE6vn0xzaI/Y6nMEUtztoUw/VrfADxNhVjbv5dLNthJW1UJo
         QqFP14X5g9PhkAa+Wz2HpuHC2409m8QCjp6XNHn8mbHbpDz/JISo1QD6b6ZO7Be9VyJP
         ZyAAViNi13rLxmOSgir7A1MGTIscE8bALbHaCC3oEGvNkUXTiV8rl+zALJ5bmUTJaIJ6
         KegSfwYEVTg3PbG/4+4DJa1VNuMCZpZSAvgrkaskEG6WdA71Y5XRQNPXXWvc2LDij5PP
         5erA==
X-Forwarded-Encrypted: i=1; AJvYcCVvO83q/sbQ0xcutWE80n/g0sT979SwOKeBKifYwObpzkzKwjqsmbDRJiBsf4xLz4LrDZLbHPS1vbS5QfHq@vger.kernel.org
X-Gm-Message-State: AOJu0YxzG6r+EA7NW2+VYJHxgGc8lAI/K6jELh7KxlypRDo1jh7keijy
	zZ1Gpjx4WCl2Vgvc++vms0eDaTt+wB7I9SjZUPko7LbSxCXGX7uwYlPxcLADyJZ8q96dgIsacPq
	vMM17m2Jtu4O6XcNpPAkMDxEIMD4JHCVJxCu9IkhNXehXjfC9GNUMy/2gHdKJj7E=
X-Gm-Gg: ASbGncvx3s1pQPtyfcFJKefdWYvCDAXKGasC7AKy8uBPhvuag1yVHA7hsRuybczD7xw
	B+02H62STrs+TAUh4NYjjAnAMGpKQpBKGNzbJbux2SbJIOeOIRyD6KRtqqk2F5Wp+ZL42RbSEt5
	X+1zWVG2PEmTSRnToEeZ6tMP7uf2SH9C4NHR2HKQ4qD+7pPpbGcXMxr9gvcKdi/GtXSP9yr9DIJ
	AsaCllKoAN/ngqEkBovEGy1ZVmbSq8nOFANHq7u/D7OsRR+ihbHFr0JGdSaF0UeUMTuoZpuIEC7
	qV+p8xWmc/9WFSztjopqmdoVa5D45KHq2vyUPH8Q5PXWB4Sz3iTEFUs=
X-Received: by 2002:a05:6214:1250:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6f0dbba3a2bmr68845586d6.10.1744214937625;
        Wed, 09 Apr 2025 09:08:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ+xnnM6qqj7Voq8qG/1yO7IWAsw62DaLYrNEIYUDQkqDqWtsb21w6aHDcGJ+1yll6H0wd0g==
X-Received: by 2002:a05:6214:1250:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6f0dbba3a2bmr68844966d6.10.1744214937222;
        Wed, 09 Apr 2025 09:08:57 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea107a3sm8853496d6.114.2025.04.09.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:08:56 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:08:55 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <43hey3rnt7ytbuu4rapcr2p7wlww7x2jtafnm45ihazkrylmij@n4p4tdy3x2de>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409142510.PIlMaZhX@linutronix.de>

> > > On Wed, Apr 09, 2025 at 12:37:06PM +0200, Christian Brauner wrote:
> > > > On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > > > > Attempt to re-spin this series based on the feedback received in v3 that
> > > > > pointed out the need to wait the grace-period in namespace_unlock()
> > > > > before calling the deferred mntput().
> > > > 
> > > > I still hate this with a passion because it adds another special-sauce
> > > > path into the unlock path. I've folded the following diff into it so it
> > > > at least doesn't start passing that pointless boolean and doesn't
> > > > introduce __namespace_unlock(). Just use a global variable and pick the
> > > > value off of it just as we do with the lists. Testing this now:

My apologies, I went with the feedback from v3[1] and failed to parse
the context surrounding it.

[1] https://lore.kernel.org/all/Znx-WGU5Wx6RaJyD@casper.infradead.org/

> > > > @@ -2094,7 +2088,7 @@ static int do_umount(struct mount *mnt, int flags)
> > > >         }
> > > >  out:
> > > >         unlock_mount_hash();
> > > > -       __namespace_unlock(flags & MNT_DETACH);
> > > > +       namespace_unlock();
> > > >         return retval;
> > > >  }
> > > > 
> > > > 

I believe you skipped setting unmounted_lazily in this hunk?

With this, I have applied your patch for the following discussion and
down thread. Happy to send a v5, should this patch be deemed worth
pursuing.

On Wed, Apr 09, 2025 at 04:25:10PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-09 16:02:29 [+0200], Mateusz Guzik wrote:
> > On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> > > them all via queue_rcu_work()?
> > > If so, couldn't we have make deferred_free_mounts global and have two
> > > release_list, say release_list and release_list_next_gp? The first one
> > > will be used if queue_rcu_work() returns true, otherwise the second.
> > > Then once defer_free_mounts() is done and release_list_next_gp not
> > > empty, it would move release_list_next_gp -> release_list and invoke
> > > queue_rcu_work().
> > > This would avoid the kmalloc, synchronize_rcu_expedited() and the
> > > special-sauce.
> > > 
> > 
> > To my understanding it was preferred for non-lazy unmount consumers to
> > wait until the mntput before returning.

Unless I misunderstand the statement, and from the previous thread[2],
this is a requirement of the user API.

[2] https://lore.kernel.org/all/Y8m+M%2FffIEEWbfmv@ZenIV/

> > On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2025-04-09 12:37:06 [+0200], Christian Brauner wrote:
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index e5b0b920dd97..25599428706c 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -1840,29 +1842,21 @@ static void __namespace_unlock(bool lazy)
> > > …
> > > > +               d = kmalloc(sizeof(struct deferred_free_mounts), GFP_KERNEL);
> > > > +               if (d) {
> > > > +                       hlist_move_list(&head, &d->release_list);
> > > > +                       INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> > > > +                       queue_rcu_work(system_wq, &d->rwork);
> > > 
> > > Couldn't we do system_unbound_wq?

I think we can, afaict we don't need locality? I'll run some tests with
system_unbound_wq.

Thanks,

-- 
Eric Chanudet


