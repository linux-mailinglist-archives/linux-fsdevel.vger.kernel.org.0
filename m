Return-Path: <linux-fsdevel+bounces-67091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E57C3513F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4581B4F6AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405093009F4;
	Wed,  5 Nov 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03bhVvY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324102FFDDC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338110; cv=none; b=Lj0odYI/Eo10xtg5yroqhMmdVjV6aRqWboOWKoy5IxEoW/jEAQ5NUY/MVF6vxvEGyyFhwj44xhW5O/CYGgMJ9wYmjzD9zp73fJO57CVc6TB2Kes+dMkEGt8joOQw5lW42EWb0FS7RlC7TKZzjI7Md3wirpm8osJPkFimKmQcdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338110; c=relaxed/simple;
	bh=nOv5SbwEt/u7lrrZsNiTVArKA6WvbIJcj/VcuXvsciE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AG1V9mBNsXiUS8NvVY1VG6AyskqxZtk3Io6fbL2gEMWqIrnTbKcmW7mgjhOGYy7sjvgrJtZ0t9Cb7Gj/fzLLKc3iQxYnW4GrKXstRLzusZXYzR6i0GJysLVuBwVVaxFekW8hJH1/ClmqRQEp8MkOZQ1RdlJAhjLDVJDZmtLkZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03bhVvY6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4773e108333so25983155e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762338107; x=1762942907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvaJZPWX/lBr0I8xsGU61fm8PKa7AAE0hAZtVjjW1rM=;
        b=03bhVvY6AbWk3zQldCqvY4TjKdIeyY0W8PTk5mTJPcZlMOTGlAoMKL44WS+t+hi045
         wW7QO73XSAkoKVSp4ttRHhRJUuaYBa/3iu/qJgxR3xaqZl9JwpNVSXSZH1u5aLd+L4E7
         46j3ELrUUfrCEsTn/B1JVsJA4601H+OUwtvxv5JKWxmIess1YDny6UTgNG9Ntp6fyDJA
         eBDBoSIacJ1h+xzIjmbrmp5ff3DQexeHypFwl/NRUuCgDSaa87P+DCeSYiTyZQLoZpRk
         I95ZmCt6aHYD/Im3YGZVu6Dxx4U1913/0GyA59kVXO5i3eKVqY8l1jhp1WQjfa2LpE3M
         xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338107; x=1762942907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvaJZPWX/lBr0I8xsGU61fm8PKa7AAE0hAZtVjjW1rM=;
        b=qdid3Sm1rcj+dSZYtyL1td2n3AxNkHIIFB4+2Lr5KCTIstNl8JrjJnAqRrRf6byCjM
         kstv9eMJ8517XvVaeynDhO90VMUnduHUHW2F7+2Kp/Oga4QY0LU19CfwVA+Q/YZ4iHAc
         SL/W8o/uj/NgyvhH0ECCDO2Lm2I0G7USZB93+goA41UMXsIzbilBg3nom08R3kSB94Jx
         GlxPJLS0JNSn02SEvjmmt5YQiRBuHkFibM7+TCNPbpRjb2d3D9faLAohLpvSgWO1PVrp
         RbJYyJa9CtfRlLtYcThIRF/el9bqSqHLNg3WtsCpc6dmV134hNz4X1cHAXfWcDK+t1iF
         Id0A==
X-Forwarded-Encrypted: i=1; AJvYcCXjDzAHUBq3ZTZ8F7RzEmnaUHB5Jv88RtA6wUvm2OOQcCPxIAezQe8kIe9FGMgxc9JgT83HmbnfNv2/oY+f@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI8Gyopl0Bw89ygmpDOoIQ/+eaCwEl36Kbk4ik+qEMmODfDDe
	xCIctgA9VOJ2PVbdyzEhoSO760PDAkWqgiINLvaVsGMFzOF0D9FzUzszwHi18ddO8HrUpP5vbeh
	lyYt420XoTySi7nn0Rg==
X-Google-Smtp-Source: AGHT+IHdi59H0AvdEqXo2GpBK/HP8BVRFrNAgC6yALK1p5tu9Pd1lI5ZwDcYaG3owUMBQGLJqr+lB+V+J/vRa0I=
X-Received: from wmbb18.prod.google.com ([2002:a05:600c:5892:b0:477:5506:8a6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468d:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4775ce15bbamr32064945e9.32.1762338107601;
 Wed, 05 Nov 2025 02:21:47 -0800 (PST)
Date: Wed, 5 Nov 2025 10:21:46 +0000
In-Reply-To: <20251105002346.53119-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105002346.53119-1-dakr@kernel.org> <20251105002346.53119-3-dakr@kernel.org>
Message-ID: <aQslOtzy2PcJ4D9M@google.com>
Subject: Re: [PATCH 3/3] rust: iov: take advantage from file::Offset
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	arnd@arndb.de, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 05, 2025 at 01:22:50AM +0100, Danilo Krummrich wrote:
> Make use of file::Offset, now that we have a dedicated type for it.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

