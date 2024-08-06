Return-Path: <linux-fsdevel+bounces-25173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD5949844
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C891F21886
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095C145B1C;
	Tue,  6 Aug 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBAQpTo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E18D62B;
	Tue,  6 Aug 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972628; cv=none; b=or5nqhsWH/xiF0KbnlfDtDe4AoJodnwBRkgVT9OjNF5NSa8fF9utCAN0UxdmB2uZeClgYHxgIMjXPcX5KztfopIF7wGWwL32VMKjNotH7Kxk+aLBsvNLqRzLI9w9TLjkLZxx4FcKBErTpKu87Qt2iktc39Mh874WWgckxF8XSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972628; c=relaxed/simple;
	bh=X6QfkjRatWcsZj3ajfwEGC7HIKUCcjueKZ/olJ4D0/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI3vYm6K48gaObikJZrhfmCw4HHwyyRH5X0dRtc7jhqigP6BCMER8IFvGM31y3jGUMfatnhyf5Ece2URXqKMThzzmOqri1IszleI4YRPS3jdlQ77dQrdUJdWme//HNjnN+Ckl7yvOyoIgSQm/stcXUdDVSxOzhnX8kWQpvV4/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBAQpTo5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5e97b8adbso582919eaf.1;
        Tue, 06 Aug 2024 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722972626; x=1723577426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEcKAOS2DS622B2qs4RzqDIjBl0dYknsbxf4LRAMqOg=;
        b=eBAQpTo5OhC8uyhJK/ZLVSGcM2UppkHbWuYipV7ycMB8+aWaRoAzz52lxmI+9h3Kxl
         mv9HOaKYrPOzqCsnvgnwpMZq5/vmvOKC+PNlnhwy3BWFrzm+hvrZU3TW+7Ia7D8kE60j
         V4sYyAvfxcKjUvBKGG+ADIWh4rMuDEgBY3vS1XnqY4GuJIYknJetfJcX+LXj0RK1mtz5
         7Y9BUTzM/lAz43zEii5ANp8QkpDkVmzwgE2FGdqfj0tH7APVAr/uKlRYT52vRNe+FLsq
         n7O+F8D8Isw83lovxp73e+Q4m4hfIOVC1sZeYns8Ry2/wEMVrOaQA40EqVYZSE3ip4jK
         5agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972626; x=1723577426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEcKAOS2DS622B2qs4RzqDIjBl0dYknsbxf4LRAMqOg=;
        b=FPrK7wl8Fy2kI8l3dpVSl9CaK58TW+4dBsQZU9Jy6k+3TW9ekRH5+OUUJnAEd5JZrp
         2P2aMeoI6kapJGWjpMeBcmOn6Aq5+qaHa1g9IQiuyYaL7zGmfqy33yXViacIyni6b083
         usP9e9JXou/twCtIuevRBvnCXE/mcgPc2XV3V47bmBr2exyigJvOSfLV5pQtFUfQ/VYW
         etbu4SfJsEj9iaILzAQS/bApOi0eRWAXTTsmn6hs8lO7A9J58OgNff3dkXSR01OVWWak
         hcH79P2xpNgFZUZc716lNWpg6rhBCky76d0aWajB4uSmenPfOsS4vBSbyoHorqsXNC4Z
         9Q0A==
X-Forwarded-Encrypted: i=1; AJvYcCXeRO+LjITHaMkdk0zB4qsCae40ZHk23safFylJrsoI90URLh25XB/x1k/q5gjqCwFp+3hfdEg+fS6J/Gzcv0KOxEs72kNpwnfgZ1TQJa7eaECTss8OjNpkLCd7EBKZMwN7gs8uuFKipX8ckJmekVjfgxt/81az5O+zTUdco56HT2wg92HLt12pJJRk
X-Gm-Message-State: AOJu0YyYjX7IPFMjKNd58rCi036T3Q5NAu511WQ3BAYRB9IskZDlS+Qi
	0nsrJ7JXz2nLkXuxX0vVTlHsera9toP/HXBtf38JdLw3/CnXcYlU
X-Google-Smtp-Source: AGHT+IHq3ySHZ8u8koQzYUuqImrLLZB7j/aFPojAHRqRVSoE6d6qYX7l74nT6HOmuxqyC4Q4Uo/joQ==
X-Received: by 2002:a05:6358:3226:b0:1a4:7f4e:d843 with SMTP id e5c5f4694b2df-1af3bac1626mr1934111555d.25.1722972625850;
        Tue, 06 Aug 2024 12:30:25 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c864e6dsm49200976d6.108.2024.08.06.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:30:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 791061200066;
	Tue,  6 Aug 2024 15:30:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Aug 2024 15:30:24 -0400
X-ME-Sender: <xms:0HmyZjyDFTxPTorPY-_UsXECCdM8l1tO0VIeg8ps5R2h1RtAw98Peg>
    <xme:0HmyZrTkVjTWXdgwxQBRZ6SSfXFLpmjkBxRGY6HyK9uwET9CL4RblU166omncY2fu
    twWZ2wK8Pjkz1oFGw>
X-ME-Received: <xmr:0HmyZtVwyT8rYSlhEIKRXY6PIYtGLcHyn2ClquqEmltIPhczb6PwNL2Hd-CvbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:0HmyZtjUYyNcfd4r8gyECgWAw7WKEYKJJfJOP8_L-IKUgsZ7nBxyQg>
    <xmx:0HmyZlB0H4biC831zIslOYhW_MZNPS9mrqYy1yZ1rxG0BTktixVt4w>
    <xmx:0HmyZmICi3h387IYOsOqhyA7_io3bEKbl8JrtHMOB5agKAqnDgg6zw>
    <xmx:0HmyZkChSdiDrgYT07keUq8Knpg474CO8PXpzWlx9Sx5YjT5mKT77Q>
    <xmx:0HmyZhz16W17-zo_4UKKZmjtpoKW3Xl5NF95msrwHYlzoDHD2-xN9Bli>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 15:30:23 -0400 (EDT)
Date: Tue, 6 Aug 2024 12:29:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <ZrJ5kORJHsITlxr6@boqun-archlinux>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
 <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>

On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
[...]
> > > +    /// Returns the flags associated with the file.
> > > +    ///
> > > +    /// The flags are a combination of the constants in [`flags`].
> > > +    #[inline]
> > > +    pub fn flags(&self) -> u32 {
> > > +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> > > +        //
> > > +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> > > +        //
> > > +        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> >
> > Do you know the status of this?
> 
> It's still unavailable.
> 

I think with our own Atomic API, we can just use atomic_read() here:
yes, I know that to make this is not a UB, we need the C side to also do
atomic write on this `f_flags`, however, my reading of C code seems to
suggest that FS relies on writes to this field is atomic, therefore
unless someone is willing to convert all writes to `f_flags` in C into
a WRITE_ONCE(), nothing more we can do on Rust side. So using
atomic_read() is the correct thing to begin with.

Regards,
Boqun

> > > +        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
> > > +    }
> > > +}
[...]

