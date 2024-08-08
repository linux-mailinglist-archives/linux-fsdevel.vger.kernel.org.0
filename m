Return-Path: <linux-fsdevel+bounces-25430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916094C246
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E641F27615
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A7190062;
	Thu,  8 Aug 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdMEc/9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD62A1D8;
	Thu,  8 Aug 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133140; cv=none; b=VF6Uj3nbx3gkyncGYRb/GYa2XsDDP6tpxb3NStlU1M8C1POT9HjbGW0Om+DYRL8rVD9T4sI5FBCOzJQTUrQSGznOhIoKqS30EW7lH7d3fC66l+XpIZQGyA0Yr/skdVixB56KgVy7X4+o38Il4rEVevKueedUWDjmX7B0y2c3SXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133140; c=relaxed/simple;
	bh=hGPLkLuBujDWzSCZRROeSp5q8jzVfe/dq/k46RgEwFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxAgGXIroE+wk2gohjcvKxUeTdfxM6GbVpXc8B28bi7Bra5lYHgdEs7CnEAGR83NsegfpSxKBrZ4Ne2DTzAVnZUQGHpeuBAWaUHLQgyFlHzE3zYExYpJZ7HSHButdv8i/A0qAoufAHH5ZG2bEJwhecjJdXe2FXKbxzrzPQ8Blu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdMEc/9D; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d3959ad5so99456985a.0;
        Thu, 08 Aug 2024 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723133138; x=1723737938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGPS3K735vF0gCg8FwAak2G3PS56HZ9k7EbicOXtxk=;
        b=QdMEc/9DLgxLmVlU3FjdOLqo+aWHkdCeRLES+8fJda30Co5205GABnXo8MCiprSAJ4
         PGFeiEm3lWbz3PAyX7nhuW7qpo3FdM4cXl65penv97OTuW4GkhuehJ8EiT5Fwp6hXceb
         b1zf8RpgngtTC12nwmVFLXSd/GQvAqewEfEt51GtBYGWhgyrJEJBG2+gvd4IvP12picC
         Bt3j3CI4nx2p4IhGnguT5jGwrAw9Aq6bEojNi3wcEtFrhEs+HBRwXp0VkIrR00fzXm62
         whr5afash/BvVc0mauV97Vqq2tInPRNNILMbwLpep9u3TmBAnc346udNMYLRJLGO1QAh
         sz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133138; x=1723737938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QGPS3K735vF0gCg8FwAak2G3PS56HZ9k7EbicOXtxk=;
        b=oL6W3a1ahHRMYx95x8Nsy60bfWU9WbHuvzXCJva+mLMro0ccPlZgPl2ldmQZA7doHe
         Y8LL8NGr/dH3Ob45KHJvmFotoUiGNWjmAesFiQnOY4I943V23RlbwyBXcat/h/Vbl90M
         fe3hQgXIE6vUG5YoE2Kjlpa4l4sXEuDphK37vMBKOOQMRrlrNJ5a7jDq8Yf2QSYdT2xv
         UdudS1zkfEmMT2l4yhI1xTRpX+156nwu5uMq0Ipr6wpvltElsGtKQsa0fTimDrojT/Hr
         OquKX54HwRL2KbO5YBuTJ21i/rr9ZF1HLWHx8ekJn99AaxS4fBnlMCeq+IrNNzBgjoJG
         DPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWiNgfHbXa7PEoQAWn+z1mz6unYkATOxmB7JYHWSz7XOYqcqGVkUS0qgDWdApDLzScIBg4CRSaYwdrVQ6pZ6xXEvpf7mUHVRHG+tIhNHyzLd4XwElZKx/I9M7aapg7UgpGJ8SNL5gESisPra5udQeGuDS7TAkXeb4uvbnT9199EFIAukit6nO2IpizF
X-Gm-Message-State: AOJu0Yxvakj6r77jX7GShKPN3qMQXvTjDyFCOtojDP1HyC3rJ9CIlhWO
	iogQtU1OornYuk2tD+0i99DcFQSb9DDFVJj1xtFCQtMM0Kq+Gko9
X-Google-Smtp-Source: AGHT+IEWmL2YczOsYZhq8z7160r63ZHHN5CVVCuzTfuy7bXzdNjBuNS4e3VSmC6l++qpo3e41kNFnw==
X-Received: by 2002:a05:620a:1a8a:b0:79f:1352:8318 with SMTP id af79cd13be357-7a3826f3360mr388942885a.4.1723133137765;
        Thu, 08 Aug 2024 09:05:37 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785cfc23sm173005885a.13.2024.08.08.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:05:36 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 14A6D1200069;
	Thu,  8 Aug 2024 12:05:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Aug 2024 12:05:36 -0400
X-ME-Sender: <xms:z-y0ZuGvg5Xtnp58dq_EkiXmn9iauz350RugK5McJx2a5KLYlCqwmA>
    <xme:z-y0ZvUkeIIiurIKlwJYdj0R2CVkQB5C1E_hnM2ibw8JoLf7dkiH6UBnrl7zFbSK3
    NeSKHig0-ttTqjVHA>
X-ME-Received: <xmr:z-y0ZoIymP3mAQfntoxw16wADBCw0fbQOt7Klo7nXn0fpmGFO0bOhTdq7oB8eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffleekfedutefhkefhheekhfelvdejgfegvdej
    jeffudelkedtffeiveejteetudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvsehrhihhlhdrihhopdhrtghpth
    htoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhhn
    ohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrghesshgrmh
    hsuhhnghdrtghomh
X-ME-Proxy: <xmx:0Oy0ZoG56UcGdqdFp0HEz84kMKpXFfnHQGE83xOQDRkTklQh4xuCRQ>
    <xmx:0Oy0ZkWmXbjsZ4RltyJSnm9N-wX2pQsNkV7ONjuDo5J3jfnSkuTKWg>
    <xmx:0Oy0ZrNlxEFxGSKyatK7E_mVs-XXbKOsZHEWmLEsvRGMGcgOJB3vLQ>
    <xmx:0Oy0Zr2wn-G7Y645szN55bT2W5NI3dvK4mCGBJPz5zqXjYgI8mZitQ>
    <xmx:0Oy0ZlXbtGbP8KB1eqji8wy6FeQqXeTMDXLXC-MsugnoZX7eKw_bUO7G>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 12:05:35 -0400 (EDT)
Date: Thu, 8 Aug 2024 09:04:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <alice@ryhl.io>
Cc: Alice Ryhl <aliceryhl@google.com>,	Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <ZrTsiiRIRSNyttRz@boqun-archlinux>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
 <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>
 <ZrJ5kORJHsITlxr6@boqun-archlinux>
 <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>
 <ZrOIsLH2JsoFzCZB@boqun-archlinux>
 <51199e48-fd36-4669-a93a-97e5c10aea26@ryhl.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51199e48-fd36-4669-a93a-97e5c10aea26@ryhl.io>

On Wed, Aug 07, 2024 at 11:59:47PM +0200, Alice Ryhl wrote:
> On 8/7/24 4:46 PM, Boqun Feng wrote:
> > On Wed, Aug 07, 2024 at 10:50:32AM +0200, Alice Ryhl wrote:
> > > On Tue, Aug 6, 2024 at 9:30 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > 
> > > > On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
> > > > [...]
> > > > > > > +    /// Returns the flags associated with the file.
> > > > > > > +    ///
> > > > > > > +    /// The flags are a combination of the constants in [`flags`].
> > > > > > > +    #[inline]
> > > > > > > +    pub fn flags(&self) -> u32 {
> > > > > > > +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> > > > > > > +        //
> > > > > > > +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> > > > > > > +        //
> > > > > > > +        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> > > > > > 
> > > > > > Do you know the status of this?
> > > > > 
> > > > > It's still unavailable.
> > > > > 
> > > > 
> > > > I think with our own Atomic API, we can just use atomic_read() here:
> > > > yes, I know that to make this is not a UB, we need the C side to also do
> > > > atomic write on this `f_flags`, however, my reading of C code seems to
> > > > suggest that FS relies on writes to this field is atomic, therefore
> > > > unless someone is willing to convert all writes to `f_flags` in C into
> > > > a WRITE_ONCE(), nothing more we can do on Rust side. So using
> > > > atomic_read() is the correct thing to begin with.
> > > 
> > > Huh? The C side uses atomic reads for this?
> > > 
> > 
> > Well, READ_ONCE(->f_flags) is atomic, so I thought you want to use
> > atomic here. However, after a quick look of `->f_flags` accesses, I find
> > out they should be protected by `->f_lock` (a few cases rely on
> > data race accesses, see p4_fd_open()), so I think what you should really
> > do here is the similar: make sure Rust code only accesses `->f_flags`
> > if `->f_lock` is held. Unless that's not the case for binder?
> 
> 
> Binder just has an `if (filp->f_flags & O_NONBLOCK)` block somewhere in the
> ioctl, where filp is the `struct file *` passed to the ioctl. Binder doesn't
> take the lock.
> 

Yep, that's my point, I think binder C driver relies on the behaviors of
data race today (or probably all `->f_flags`s accessed by binder don't
have any concurrent write to them). Either way, what you do here is
better than C code if there was a data race. I was simply suggesting
instead of `read_once`, we could just do a `atomic_read` on `->f_flags`
once we support *unsafe` usage of doing atomic accesses on normal data
fields (of course, such a usage will be limited).

In other words, nothing needs to be changed here right now.

Regards,
Boqun

> Alice

