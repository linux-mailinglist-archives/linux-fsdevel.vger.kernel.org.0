Return-Path: <linux-fsdevel+bounces-64307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDFBE07E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943385057E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF530F818;
	Wed, 15 Oct 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyiqbtYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD130EF70
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556673; cv=none; b=e4WApHmo9wZJYlHxOKPoNn3j7ejArwr4l0ctQh9ZflEQrNwj9fAwfdy7UM9r6MYbODCiTJMT7DMu6Pk60X+LHzovL58md8QRq0eX21wKJsXMTT7yF3QKqBnBHptiJyTgz6CXyYoBxMjoqJ/PrMemHL3wCiJQEQt7oItaQBcliP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556673; c=relaxed/simple;
	bh=M3OmafxYrytddi2fWGeQJQ8nIAlismXr2eiCuylqQ9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yjm8Pz/tnBmNZUzyVqd6DfgHh77aVuQ6VJvzqiX5InXpklPDPAJE58VEdPi7Yx4PVmB3x0Ei5TrW/gPmyaBoj10v00HpxkRV/f+lU7r1WiH4pZwfFv6tjB4refl7jkcSCW3+7jHlHc1xV8/JrDx+WICSpLwduSjMo17qLhEq5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyiqbtYa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso20858005e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556669; x=1761161469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rhvc+XdtkSeql1ngz80HmWK4mJ3tw4/Kibofy2HKs=;
        b=qyiqbtYaPU4E7r/EgAYjBbvh06YOElGo1y6q0VE/i7jMRyDy7vi9059RVcaeQDnhoV
         +6pvGO2MxkFk0jpQmEPVTd76fo6CpN1bf48hk4yh/UTA2ob8k0h0eK52+KV6MhC9/ete
         2uN9QHdzuHgvGDXtocDQogXKHmCR1d2iIMInhi1xk4GTVd+tdp3iKA7ytgcuw1lNO8DR
         B0V/FNLRq3Tq4XOfzPbQVpNMP3/u1OUFzDPC4GRgTiaMca8ActyiC0X8IVOvBBG2AlTU
         1q4pwNAvXy9vdCPxbt0BnmnAyJWuI2lx5JoAq1tolBTO6pLkZHOlK02iam/4ErajhcG+
         91BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556669; x=1761161469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9rhvc+XdtkSeql1ngz80HmWK4mJ3tw4/Kibofy2HKs=;
        b=JeQE6BEnyrhyNcBSHth+eKvowmAcHItzUAdyVl3ziGDNERe6cVV9iZbXn03+RFATLp
         yF/YPyR24ssgdJPldxaZVhN8eEpso+ODBQyn6Guvq08LPqKuCtbFIKNuzWR0CFEHMaZs
         vpc+hntWgKmvB1zgvMG4SgsTex4VaEwYP4k1TNpeV3xSfyjTUpS3YbqKjfjcvPm7AYRf
         sW3/sQFk4y+3IwcdJ+KTblX1WsLC70RwSMmFzz+IWacK4zNqS17aRTveMWbKrvmPnpYw
         omtgvmSYBPGzGjo0e1fsmSDioAh/yedg2uGm/gRt3+IfmcIvjJqggfUPFl6WZgO/fvmx
         dfzA==
X-Forwarded-Encrypted: i=1; AJvYcCVxqk66ytrUdoceRBVWZWrpt6l4jE+/XtrIcwipBcqw7P9uelY6c3ZM5dRWIx9RQvxEnS5kIsWK4XHga3m0@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRBfxluso6+GDGXdxL67kJIc6yNC2AEW5+jY+9Z47gNwyaoen
	JBCFoIMmAuqKCOE+Tz4b8gow9OeilY7m3oxROoH9fQixt4iaYs+/5TvchKZCJv/2eUapjRRPbw0
	/FVKEs/io5P//5rrafQ==
X-Google-Smtp-Source: AGHT+IFUuQlqtHR44WvPHRF9KPjT92Y5yOj1YhvXBQy9Crnrgo5UDneJSF9KPTAa9EHr6BuFGJGsfuKxG3RvfpA=
X-Received: from wmfq20.prod.google.com ([2002:a05:600c:2e54:b0:46f:c6cb:516f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529a:b0:46e:3802:741a with SMTP id 5b1f17b1804b1-46fa9af2d67mr202606365e9.22.1760556668803;
 Wed, 15 Oct 2025 12:31:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:08 +0000
In-Reply-To: <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
Message-ID: <aO_2fAYlMxOHBt7Q@google.com>
Subject: Re: [PATCH v17 03/11] rust_binder: use `kernel::fmt`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:33PM -0400, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
> driver").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


