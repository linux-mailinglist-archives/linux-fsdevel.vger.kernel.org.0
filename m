Return-Path: <linux-fsdevel+bounces-45652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99DA7A5A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3C57A4238
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E62505D6;
	Thu,  3 Apr 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYk1fH69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105B2500C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691719; cv=none; b=kPd3aNkaSF4WH+/GVVp6N3GO3VZ0RPAvIh1iWCZ6jgsSBDU9gfzztWkFAKylC+4W+jfhbcjPI9YtELNBDn0FAaDWgY9dUJfRwWgKPAUYDiMV5NOeMq+z00jaGkEe6cXn/GpXnT1w7qeZ9wz/Ggz5faYlDx5bBvjfADo8k/iY0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691719; c=relaxed/simple;
	bh=wmF3ASAu4l5e5QaPK3NSuhBM69OYwzUeQtDHQcn6MS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcvJ5/g7VEO8u1G69JZCg7cK7wEN9Xv3lnya8y+9ZMO6/NNMwIenxXn7IdFlGFA/VrIPbASvuJKLH1JsyU5KkS3+o/ogrRiBTa/KGm63zyACcmAUbwUboiqH1cSw0D392HTI2mf7bHVCU/dipdXxH55xwS5e/nflZtxqDZSxH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYk1fH69; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c89461d1so1573283b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743691717; x=1744296517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=igg3zobfFtydVGAelA7JZ01NRykTuhkzUPbgteiqM9Q=;
        b=EYk1fH69tc4yf17oohqE/smapvx70QbTJXOdw3Oj/CBkroQgFazxXoiPtcfYcy30Ni
         cbUahoZOzeiqR+osRxk3fws1H+8J2X4eOza+dSB3gyQI2o0boG6bwtB5FVHmY1GXrzxN
         KtoR1P6d9k2mY06HQFV3wSM+cNGxt8sobihMT/QAr+ea/AyncRf1FlzFZtzxJmxQJD9l
         S3uUO++mwmQMgTqpeSXYEt+EAIZFq80Qy7HAQXZeEPnNuThT4xtdMM2Vgyoj2GQ+5/OB
         ZwnPnhie3oJ6/oQwLttkQxhtrnk/uKrSx+NI6bvQGyFsA8TdT1TgGTTgPXePvPqEbK+E
         SX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691717; x=1744296517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igg3zobfFtydVGAelA7JZ01NRykTuhkzUPbgteiqM9Q=;
        b=Fa5ls8xjC79BGvxOCeW+uMLNt0K+yft72HPGNNdQbX47pKFrdpx+ZwSULKDNbeuAEy
         OAIhnfxItyMN9ie+hFRjp5U7lry0xjg0/MSEAHz2/LVL0V4lfq/WXABc5FG02lhStveP
         b2Yd00F1zC7R8bfzM872ANMnM8iC/eRQ2z4Xe/aupzumFzZhEJGdYJBIOgV0nCwfuvzA
         u8vzP+b06X6VYp8AcSrKq9c2jZ4kvOMoElmlhl/4yPTCLHptIFSs/MaMvRpIDnB6HxXr
         K2auj86tTEiVbxKsYMFw26Q3wCCbm1oHyskzrq+08zba1qtsYF88NN0aOwAvWg/7aTLu
         Fz6A==
X-Forwarded-Encrypted: i=1; AJvYcCV+6xgDx6T0O0/i4bjmp8r+kLR2FOwc9VtoQOi4FzOR3e5K+TaO9EKJA5S9u6CtQGlzNGinksx25Fg7gE44@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjlekUBF0uyPpIWMdI/Rv6eS0D2ex+obmGTf00a0DiC5FicNH
	i+eCeBLw8uZKgIjwZPNh0Wqclvr0kf98yuZkI5l4QInFk57B8XDz8UlZ+J+4H4gSH0195vPHPN1
	RfQ==
X-Google-Smtp-Source: AGHT+IG9IJrC2WV7WLtmMSWgTecisx21a4/DmbtG4CGcCIp6FaiyOk56NSQtsUf8hBMYnyjC9Po0xvGrGdU=
X-Received: from pfam26.prod.google.com ([2002:aa7:8a1a:0:b0:734:6f4e:794])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:848:b0:736:5b85:a911
 with SMTP id d2e1a72fcca58-73980399504mr32373172b3a.8.1743691716806; Thu, 03
 Apr 2025 07:48:36 -0700 (PDT)
Date: Thu, 3 Apr 2025 07:48:35 -0700
In-Reply-To: <Z0DOdTRAaK3whZKW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
 <20241122-guestmem-library-v5-2-450e92951a15@quicinc.com> <Z0DOdTRAaK3whZKW@casper.infradead.org>
Message-ID: <Z-6fw8VuDTk4soN8@google.com>
Subject: Re: [PATCH v5 2/2] mm: guestmem: Convert address_space operations to
 guestmem library
From: Sean Christopherson <seanjc@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Gowans <jgowans@amazon.com>, Mike Day <michael.day@amd.com>, linux-fsdevel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 22, 2024, Matthew Wilcox wrote:
> On Fri, Nov 22, 2024 at 09:29:39AM -0800, Elliot Berman wrote:
> > A few near-term features are coming to guest_memfd which make sense to
> > create a built-in library.
> 
> You haven't created a library, you've created a middle-layer.  This
> file primarily consists of functions which redispatch to a function
> pointer.  I think you'd be better off creating a library!  That is,
> have the consumers register their own address_space_operations and
> have functions in this library which provide useful implementations.

Or, go even further and move the overwhelming majority of guest_memfd code into
mm/.  But I suspect that will be practically infeasible, in which case I think I
agree with Matthew.

Either way, the Gunyah usage of the library/middle-layer needs to be included in
the series.  It's impossible to review the code split and APIs without seeing
both KVM's usage and Gunyah's usage.  E.g. this series allows
__guestmem_invalidate_begin() to fail, without any explanation as to while that's
legal or desirable.

