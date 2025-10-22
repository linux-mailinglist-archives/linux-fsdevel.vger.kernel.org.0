Return-Path: <linux-fsdevel+bounces-65016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D4BF9B87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E55604FB686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692AE221F26;
	Wed, 22 Oct 2025 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKlNqAj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912C219E8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100053; cv=none; b=D/k2qw89ODN0X+DW9lywP0iJ0AgeJvf3Gm1dESp5jdEL44ekBz7Tt9aFdQez+aGPCJXTEZExKBp3g4uTTgTtlKzgm7ARJuwOOHNfi7B5fJrTpLgtae1QxgKkk/7pmr/QgR4OAkvkx0sShuWiF5F7+mfQjoA092x4Lh6vWeQCjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100053; c=relaxed/simple;
	bh=A+P0s8xM+ovp2iCRdR2wm/nwAd8dNmdnn9/2R/2q9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1tlMLYouApvWy6jUi3PHusNML4lqritlO+EnbSjlDtNc4W2HMQYlB4QbVixvhH2eNzSvgyfRhtq6jpmmvkZsXQpuXlHN/X9FHMt/uC4iCKRtZhEvZZTM15OKulY0mG5ouNyxhC0sM5HmJ+kvlQ4O9zvPlrTaYDZGH/A6w39Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKlNqAj8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33d896debe5so4316210a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100051; x=1761704851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=aKlNqAj8jXvvWoICbfNwKUqLGP/aPJt/n2SESZe6VHiyTTE8J40WagoO4bVRrT+qiX
         OgTdYRYckYQlquqlWtROXxhAwy+utRm1jmHF5SAROzafg4jUZ3LaXBg12KXTsMoK2QTy
         MhoEL5kohuLJmswz8GF+RPKgG6gVOPrXt2mWXRituP26sm0KzzdVtDXj1zcQB0fCMvoV
         EWFQ4s/bvRvRkPtHqWB0VAwv5CQ5QwEyQAtaIx/wbAK6O0V+wsI23tum/tKi+cZZ8nm/
         MU3CXKwTo1bA2ndzRTVmIVKL7gBE9yBOelXsJxfxoEncwWtTZfW4pUjNlmChldVCbrmQ
         vEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100051; x=1761704851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=M2jByM+Ts6tQtf+J5KjD5T4FdVLkSE8XDfiG9CfumDcCTPnW5aiImgwighzPx9uaPA
         jTFgs/ln/4zlqjgwPyLisW1xPfthHUh1WOntE9L1S4bqeMGMghwMDTV3aldjJ7Bv7iS/
         w837yxblvexp13ddLJpq5WADTfahRTF+82r2PIdIWWl4UbwR1cGnw7Vip1ICD2FS6o8O
         +XPtJprABv/HTgMjKOL0/FexA1rS1Jdh+RQaqeRQZd8sNV/ooY1NcRSVB2UB9aofGhcr
         gEN3Armbheh+g7O+93R2QMQp31Mc4JzyH4hXJEH3Lencz13jLFDskPQUSbPYezuAU+xu
         gr4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDsUvOFmwUysN8sbvg+EXyhvQ27CAGLrcMzdRyKSoW+BAZ5kKQhZtNqOdN2Ph/wWGH39rPw+imcl3Vr3vS@vger.kernel.org
X-Gm-Message-State: AOJu0YybLJKqIJrZ8ZqKsNhOYreacWN3AU1Yf1T3EhTqTwA6UbIuv+Cf
	2XnVdIueIv7GUP1C7OMDdSh5mvz8aDPpGW4cxUIKLHJuTco1Ep/cWtHTvW+rDL0pJEc=
X-Gm-Gg: ASbGncuyQnRi4tkRRVTQ7ldSgw7UMGTMYxdrVjmaWa0/U1tsDsg4uJ1YKH3/HhDABdg
	wi8rgBTkZhJYAM/zYB7Aw0t03CXjnqk66AlhE7AYficWuXmu5iqVt9jRpOkT4uMc4CTV7OGA+Vh
	R1X+5mU83FJ5chfySK9DFAnzjVSTYlt4CqUCbOAPgxoIRRjpGYpkYCcFhQX35KSTN+4zkjrckh/
	aswXblFgix+pZtRerOMQwJ3z7Yr0MbefQc2XkLTraVzA3YocMQPirKd5uzbSUV+62qRXVwZWM0+
	rR8k+P6UH9ElrvLne2v1mMjxgn5Agw0pDVKNpvlspke82oN549XOOFa58qbW8CF/vigCI+vGXcQ
	7JP9IMVnEgnNX3rcCAZAgmpcRsT5bNqIdltREklOOAyt2RABzL5WBxco+d8ezCdxIjF9rUZfPsU
	ptoinneu6g1MR4DZBMlcZX6eA=
X-Google-Smtp-Source: AGHT+IFJLVFpIR1aWCyZCFOIKnAA6a58lXYXHZeAFELxfkfneTEN5uN4Dh2U6O2etE9y+Y+gRJvc9A==
X-Received: by 2002:a17:90b:1dc6:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33bcf888575mr30106334a91.12.1761100051119;
        Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11e1sm981092a91.12.2025.10.21.19.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Correct the spelling of "CString" to make the link work.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

