Return-Path: <linux-fsdevel+bounces-5032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D915B8077C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24375280EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42F6EB74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/hKUsZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABDFA
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 08:49:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d06fffdb65so28423345ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701881391; x=1702486191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/emo8eo1n5l2se6f2Okqi3h9qOd104lH+P+GuFVvEM8=;
        b=l/hKUsZpNo/mDhWyl8XKZe+U9MKlLPRVkAVWMlj1L9f9IJPENmyJ23q0zr1/36pdIs
         sG3tvQ2dRqbSy5iTKOZiUvnYubcpJtPioBCKISLFVjuktAUAwX/zH11udpX51ERZDlwO
         heib6ZCUyPMlb+zipnIdWzZWPopdK6uVM0ZS3XU0Ccr8F0CgLeuKElnn9eljIPARIM+7
         mJqdlByiEXdhuFGeQgXiGqk7bGPHkhgc4Qer1bT+gSOI4sQy+ovAjI6lfYZodI5t9f4E
         P/5ExIMqBMPr1srAPCX21Ax+Ebv2mImEAsB9s31o4mpE4hwLMgBHoqIhTGVqtbIITmug
         jbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881391; x=1702486191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/emo8eo1n5l2se6f2Okqi3h9qOd104lH+P+GuFVvEM8=;
        b=iIsz//CET4TPfva8XhlgFvNCgOXgAMzYox5FtanIOCyTGp40LSpTbxie6WrWukZq4v
         AtfHWxcgaTn84w3f0jQwIvEj6ccx0VVqW8UZYm8WyMk3uo/zeyZDikP+Oq/HqyEBVMSL
         rL18kstrupmCHCRzOBfKgw6ZFDCzfdUH/GJKWpPSgS6v7DvZaWsa+RLcfbwqr9OXrJ83
         pHP3fizoNQQP7uS+D4RlHJUjEgLiPxouwqDDj8WEDIpGf2+TsIDtLUom6D83pVAFT4zM
         52qSRGx/Fn5GelR7hG2U1sz2b55C0h/wecTv4byjG9c7jFVuLOz1LuCw65/xr3rVLyaJ
         1/OA==
X-Gm-Message-State: AOJu0YxAMGBkJtdwUXfJYjpSXKCWPlPXzZOqnh/aTQdajw3jzUxXl/qm
	pB9094BIhi7GTwCJJTYA9+Y/YQ==
X-Google-Smtp-Source: AGHT+IEKhKCbpLdxbFsThg9x3s87/P+i+0HTO+cft20G9jiFl+h6++FYzwypLm2mg2KBegxj+3BAXg==
X-Received: by 2002:a17:902:d4c7:b0:1d0:a084:b009 with SMTP id o7-20020a170902d4c700b001d0a084b009mr926559plg.108.1701881391106;
        Wed, 06 Dec 2023 08:49:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:205:3c52:6dfa:1cbe:d20d])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cc50146b43sm42269plf.202.2023.12.06.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:49:50 -0800 (PST)
Date: Wed, 6 Dec 2023 08:49:44 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <ZXCmKFjpO_w98iv_@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206134041.GG30174@noisy.programming.kicks-ass.net>

On Wed, Dec 06, 2023 at 02:40:41PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 06, 2023 at 01:57:52PM +0100, Alice Ryhl wrote:
> > On Wed, Dec 6, 2023 at 1:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > I can reimplement these specific functions as inline Rust functions,
> 
> That would be good, but how are you going to do that without duplicating
> the horror that is struct task_struct ?
> 
> > but I don't think I can give you a general solution to the
> > rust_helper_* problem in this patch series.
> 
> Well, I really wish the Rust community would address the C
> interoperability in a hurry. Basically make it a requirement for
> in-kernel Rust.
> 
> I mean, how hard can it be to have clang parse the C headers and inject
> them into the Rust IR as if they're external FFI things.

That's pretty much how Swift and Carbon are doing C (and C++) interop.

Carbon: https://youtu.be/1ZTJ9omXOQ0?si=yiuLHn6o8RMezEZj
Swift: https://youtu.be/lgivCGdmFrw?si=-x9Uva-_Y2x-JNBe

The swift talk doesn't allude much to the codegen interop they're doing (still
an excellent talk), but the carbon folks have adopted a model from Swift of
doing interop at the IR layer.

Those compilers link against clang to provide IR interop.
Rust's bindgen crate links against clang to generate Rust stubs.

At some point, someone on the Rust side will notice what Swift and Carbon are
up to, realize they're probably already linking against libclang for C/C++
interop, and try just linking libclang into rustc itself.

