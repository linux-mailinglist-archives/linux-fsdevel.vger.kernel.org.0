Return-Path: <linux-fsdevel+bounces-64308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD8BE0720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717B3585382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305E310654;
	Wed, 15 Oct 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmI27w5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA330F936
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556691; cv=none; b=AN4aEiLyz0yZsdSh+cM+axakg++v54otjF5lEVA/pVEKHyr35FawOFz+eGu9s3bSqtponDiMmF4A9ayDYShm4fJTnrdFyT++/+6oEz3kqSYvxTKShFcayyYe0VwNzFOlKlurnLrcwSD9Ymn2/R4kRDaemd1ssf7xwI5RElZSOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556691; c=relaxed/simple;
	bh=kNflbdkxnSak8W84DQ9chfjwf1iwPVGgDeWnudi49IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GvxxliKb3U3Zw3dXaUuVrKk0obYsX+98i7EnRll6fqL2rKU99PGyN+V5FDsnV+Fv6Ko9j9ryp7mGwzwTOaCDG6czmhndCDXFfjDCB+J2huh9xbe1zPdCbKSO2Lz+7eDMSZIwJqZPAYu+wZUjwmuxi6BzlSD17mSCtbexVF06lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmI27w5x; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so71479735e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556688; x=1761161488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=XmI27w5xlSKnfxgSInyYaWeOIFLoYxyVbK1nfeR85kygPzMmThaIuBowCqgYOJ0Rad
         g5HBqy+tccEtFAfG+OoopcoNG0RvjCJUreF9jam6sNl2+gp3dpMdZZCMtfw9PEG9u+Tu
         PDO9errvqX4ws2qc1YlT2rPDVFYmevwWeN3JyMa5DL0GQhXFGay1cpppj5E+gOUUFFl4
         E8RhiEnCcRduX9qlUPvrWGVpUQUCyNeBRaUp62YcKnlZWWh4t2Wgp8npYisR3YkBue6r
         jGDZdhm7qb/SSPRac/oZrEsHqyr8TuwY5FDUPWPBprUXJWYowMCU4cY+8HepX5th914A
         YA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556688; x=1761161488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YYTBGsDd4ZJL1eAQVxl6XdilN8lmC3un8gI57oa+wc=;
        b=AnRRvcOez1h9KB/gHZ1h75unYlqVG1VFMgBEV44y/rtczmfmXIunik1w2u5aWZwFRR
         T/ULRTMzfndbq712Fg9q1JJteLskCT32/YZ9Hch+bNPl2PTYj9qrg8m7/o0/xqZWShpR
         yYNZDALK1W+rrZHAIoYIL8XA5ilLEk/ESccJIlVDLypotKedcUQnEFFz6b0W8kx4JT7n
         LKlUXt+VOvhk+CB4gdAeawm3ZjaT4Iu978YHKtdMO276XLGNDjkHxHwZLvYDtiMmbjUN
         czVsF5HS2jCK5A4KA21r70+mlx/Jufgl7RK/6kd0NqVX2Axs7g9nvVtZuMgn5gBnD0Tl
         mj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVSJfkKVW8gOX/aGMrT5Yy320vdMybbAHPPfKvC17t5mw7qCem7+it2ICeyEI7RwL03WtyAhWOkDjiqJOvC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gLllbQjSqLmrHn9LZBJIJEF2XH+8Wh1XdbGPwJuQP8aeUZfL
	m8A4N0ryB8mfYjoIBmHKHxT04Kp4BrULZGyeYwjGXYOv02XDT/VEGzyyKJXZoQm9TYJXsiuUMmo
	t3xXuHNrJaera/YwPYA==
X-Google-Smtp-Source: AGHT+IHkXgCUD/Xg8mwfvq5rsw1NsD7V33g7iy9bartydYztNdh4V9vcMXz0z1HOSr9X/M95RapHcDYXFrnCOyo=
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529a:b0:46e:59bb:63cf with SMTP id 5b1f17b1804b1-46fa9af31d9mr184569055e9.24.1760556688057;
 Wed, 15 Oct 2025 12:31:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:27 +0000
In-Reply-To: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
Message-ID: <aO_2j7uQGLbXmZVS@google.com>
Subject: Re: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
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

On Wed, Oct 15, 2025 at 03:24:34PM -0400, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoiding methods that only exist on the latter.
> 
> This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
> driver").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

