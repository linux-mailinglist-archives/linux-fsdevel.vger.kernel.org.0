Return-Path: <linux-fsdevel+bounces-49970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211AAC66DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14E93B0E49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F23278145;
	Wed, 28 May 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJoSS04+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0F20F07D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427616; cv=none; b=teMCUziZTvK8Te3qCh0+gXIE3l5u9xfqzrdfofbauLuJktAGpqCa4bV47ElhOSZwfBrwFEBAOmzxicsR9nUzvG5kjwy82Q33BM2Qw0n4+lxDTrLlsOTfvMwq5dJtEC6sBpMYxjZWKmQZWu2erh0lQtPFb0jbSbD6+EBJjNjWPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427616; c=relaxed/simple;
	bh=QVXvLr3GtA7cc1rTDq8wqrsCt69VXLlXgxESkQwMPGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZBUWyFivncKWE2hkJDETwav7n85w1D0Mi2TkLWuDUe/IVbpzWN7kt3m4uC6LGrl6TbMVphODT3PCKfN/LPGNeRKZwzV6nkzdgkIDhqxRuaM97gvLvLwdScXpqj93192Wdq6Avlsh4IfGKfNL8SJTfO1rNCuk5nM4+MUq6LNigTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJoSS04+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso32879435e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748427613; x=1749032413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTpKLT888ECG39NBheVQQY2QZ8sDTvoN58x2xm6E7Y=;
        b=KJoSS04+5nFceubjLn07ZmwFPgjJAPvZD2Ya8WqinsLMA23elwz8zz2ZwI3Ywwewdv
         quIbB1+ANRrSMqPeEZcaoF+YxuZ01Xs1fJO/eXHbsPPAtPtJYhpqYFAZ9m8WIklNr7u+
         gy0KI2JQY+E8QtvkxK6P2HHDRTpNebxqt1CdJvG+6/BtJx21I4wNA3ZmIbGSaQq6871a
         +L2xArlSw9D6NLNxHknGZ1XsoJrzjQDJnr9fRitB0PPBBJDheR7slHCCAmpEoJlMX9Bp
         hzTfGqTlnU6L5/FcqEoP7C16k3ZITgudSHwO44RthEX45/iQaAWJ9zUA10n/vTtf+OSb
         9dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427613; x=1749032413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTpKLT888ECG39NBheVQQY2QZ8sDTvoN58x2xm6E7Y=;
        b=Xk6saC/b0FgQIo/e4y6vGm1zmxIbWpXVoua82n+fF+0FaIl5rUOwRZ3yc63RvBc73F
         mDUnV9h11Z++rEri+lbI2yqJS0N67zKgWKolxrCEyJMEy/zY92TWdWpnabWEjN7antjQ
         2Us7PvIsSRZzN1wfjOXGy02H7qjSnODEr4UVGc4W2xFjiPnb+jRee+Q4nUIV56/3HuXO
         IBS/HvtPoFfQ9JivtU1D6IAUgK9kcuIotEjqv6r8zkslKZ+Ti9A400CuB4D4bW0fA1Kg
         +ki6mEY07wU/2rJPMN+7tqdQO7SSEgDKjiMwjWrGfpqJu5lixDUZHPf0wrJ+3i6gK4yr
         6piw==
X-Forwarded-Encrypted: i=1; AJvYcCWuDA/aD9syYfXwFR35gKh85al9DZZPPe/pVPYwSUZujzFG28wF+o9O+bU74d6diW4aXCShj4yVI9DP065k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ldoCUJEOgQkroyGC7hYs7JdnnPiFEitNft1A5kJ40bD+EIYf
	802qp40nPiPLSCAXII5114FwzNBtiiP0pPd73y6dWPTiOa7NnIEhIMOSMF4s/Audb85PudpMyLP
	oJwQgivf9+noNPXi3CQ==
X-Google-Smtp-Source: AGHT+IFbZP87yhpd+A5UORuRl+efDd9mhI47Db4pLu1nsC4kPmFxtELld4jQWoKyvlreBoGWn167CcDJWgZNgZI=
X-Received: from wmbdv21.prod.google.com ([2002:a05:600c:6215:b0:450:5dbe:5f11])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-44c91fbb448mr159238185e9.17.1748427612802;
 Wed, 28 May 2025 03:20:12 -0700 (PDT)
Date: Wed, 28 May 2025 10:20:10 +0000
In-Reply-To: <20250527204636.12573-2-pekkarr@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527204636.12573-1-pekkarr@protonmail.com> <20250527204636.12573-2-pekkarr@protonmail.com>
Message-ID: <aDbjWk-18QxVPIn8@google.com>
Subject: Re: [PATCH 2/2] rust: file: improve safety comments
From: Alice Ryhl <aliceryhl@google.com>
To: Pekka Ristola <pekkarr@protonmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, May 27, 2025 at 08:48:59PM +0000, Pekka Ristola wrote:
> Some of the safety comments in `LocalFile`'s methods incorrectly refer to
> the `File` type instead of `LocalFile`, so fix them to use the correct
> type.
> 
> Also add missing Markdown code spans around lifetimes in the safety
> comments, i.e. change 'a to `'a`.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1165
> Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

