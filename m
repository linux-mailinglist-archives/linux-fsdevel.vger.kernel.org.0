Return-Path: <linux-fsdevel+bounces-25321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C2994AACA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6811C20E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838DC81AB1;
	Wed,  7 Aug 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j81kSiyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DF80638;
	Wed,  7 Aug 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042587; cv=none; b=Czh6P1Hn+qTGNnaQ8HlHGREpZsjdPrsLOM90JUfhe21oY/DyZW6OAv61g2813N2BH4y+cg3zw05v38eKTuH9PZcAMvnYVX7P5YHAnkjt8CxYIbfRUv6EKKs/6vQ27Z+scWi0nLgCxY+jTc9KcFgsfOE1sd75i1vbDE6+MaJhSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042587; c=relaxed/simple;
	bh=aOTBc2nGmk4b98ZyAWHowaEZwFZYQyDe34oExucfhjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI1HEDhxHRlndEfuykBv4kbMlmIPC8iO2LRc0fKzuxz2Otht+lLF9NVpOLse37HXtA6tZvbjCke1l/ERrcqXmRPbMYwMEdrDrMUsu+m8KDD21Mf6y47yNajZ9dG9crKPe/VPd6kv0uZpi4XFkUMAKJ3Zr67Fyp0C4eLKVUX6u0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j81kSiyS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7af49e815so35406d6.0;
        Wed, 07 Aug 2024 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723042584; x=1723647384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RBBcExoXcZmsDvSDziTffsIbas/OP3jB8GubuwqBybc=;
        b=j81kSiySOg86phhMsXaWfAPh1xyihkf2Yp4qea32LgRGgcHksWGxs2+sssFDE91wql
         s97lGYWO/HPtPRbBoxHOITR0eoHYztQu5jqD1suHnJFJby/Mvu/xQx14Yew53HoCLXHc
         vqAefgzP79xVddQQO9MbN5xOQBUxlvmpg7spTzTv5G0hREEP3bs8uUhN3YAMCKqreLkc
         TspyFTNPzVTkax9HMEFbS8NbI+7TmekNSLEIsxWd3JU5DzWRIGwejp/7zwXcefvpFVYc
         bAcCQqbrCiMZlv+tU5oh/LR/+Ktu+EBzFyvsvlwPtZoRNFkQ5JAcxC1ZeK9esYFrYjnk
         7LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042584; x=1723647384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBBcExoXcZmsDvSDziTffsIbas/OP3jB8GubuwqBybc=;
        b=aCy6t/4xHEftENzjrS70H+hnPim9+sDozVFwRnX85istIOcSYsFhmx60s5CpcCAf5J
         /u7yau/QRTgdP2G1L52pQhmn2Sa/r7wqgOLExyI78cXf01DEkSrQe4MlTojSkQWYEGBA
         ooyyhu4AaBth8xSF7CXGp7SlQ3CSHSoE7t8l3uktDQhxzChIqQJ3Z1O4eWeg4i/DbVa1
         Vm8L8s7gY8VqEzfJ7BhQKe+2JeCsvR3WApf9NPHc0u5PFYCKNRJIuWGX3B7/UOZ8biu3
         H7TBW5sHTAXGSha66A6IqMJpz3tHgmIySXZGdcXtaIOk+3mzWUqb8iDwmH8eehK5An6P
         APww==
X-Forwarded-Encrypted: i=1; AJvYcCVJQG7eMd5KBUWGxuorZzTq3ith3971skryGuddBQ8+VETVYH+L+J+UumQz+kS79KK2YDS/4Ub7W8IDZFC8NOTmBFYfD0YD/GzwxNYtY8msa+AeCs5jzdKAsiSYk4PpLEpTS8bJh68FSObOpMiCruLsSgK9wGYZtPmBzF9UHk3qapXs8w67RyHvZcrX
X-Gm-Message-State: AOJu0Yz7Z+SgXRXYBeBKpOpvKp0iJ2Mt5nRhblEY+OrQxR+iNQtDtlbd
	X8+6g4opZLvMa2wWLLV7MNn+PpbRXnaXz3a8oZdqfv6X0zbpxjYT
X-Google-Smtp-Source: AGHT+IE7UPn3bBVlDIiEYS0Fz8qvBoEVDE2qwDjfa6YRbFuhvqqkzA71DmuTmpjKSqEqpQ7FSF5QGg==
X-Received: by 2002:a05:6214:598e:b0:6b0:7482:313 with SMTP id 6a1803df08f44-6bb9833d848mr267607186d6.11.1723042584365;
        Wed, 07 Aug 2024 07:56:24 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ecbbsm57418846d6.39.2024.08.07.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:56:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0C2EF1200072;
	Wed,  7 Aug 2024 10:47:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 10:47:15 -0400
X-ME-Sender: <xms:8oizZjHbGo8icAQ2GFsfqCqT4xKNxIaHfkmCE0IWKX2-iWzyeqCTWw>
    <xme:8oizZgV2f-ax-z76yo7rAFPa0ZRSrqdXHI3FuH_HfTGeLeyp7Bn_m_l9FkFxfQKqv
    b4DHXMun6FWl1OE6g>
X-ME-Received: <xmr:8oizZlIWSsLaY5Iq3MOmAQSioDS_uYpFy_nDruSnU2a0tMyBRaErs792BAu4MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8oizZhGZFD6zHC_8SXKASg0SNkJFm_VGecwF7EXT2fgmT5LDSRxm0w>
    <xmx:8oizZpU2Oga6eU1MPbNYqm1Ozi09K0-R9pkgpRXlAXaCHZjFXkn1CA>
    <xmx:8oizZsO3FfyMm1JtrKWop9lhaAZQJ_uu0_ayH-HlJhBYmOd5VSM5IQ>
    <xmx:8oizZo0BuswQSR_3qs-msjb0eEyBnuteYJH3bBCje1WXIvvWjc5o3w>
    <xmx:84izZuUjRAXCIBx7paZyFPqtQLNEx-cFzG2W0qCjB1bcbmj-buRe8zhq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 10:47:14 -0400 (EDT)
Date: Wed, 7 Aug 2024 07:46:08 -0700
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
Message-ID: <ZrOIsLH2JsoFzCZB@boqun-archlinux>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
 <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>
 <ZrJ5kORJHsITlxr6@boqun-archlinux>
 <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>

On Wed, Aug 07, 2024 at 10:50:32AM +0200, Alice Ryhl wrote:
> On Tue, Aug 6, 2024 at 9:30 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
> > [...]
> > > > > +    /// Returns the flags associated with the file.
> > > > > +    ///
> > > > > +    /// The flags are a combination of the constants in [`flags`].
> > > > > +    #[inline]
> > > > > +    pub fn flags(&self) -> u32 {
> > > > > +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> > > > > +        //
> > > > > +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> > > > > +        //
> > > > > +        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> > > >
> > > > Do you know the status of this?
> > >
> > > It's still unavailable.
> > >
> >
> > I think with our own Atomic API, we can just use atomic_read() here:
> > yes, I know that to make this is not a UB, we need the C side to also do
> > atomic write on this `f_flags`, however, my reading of C code seems to
> > suggest that FS relies on writes to this field is atomic, therefore
> > unless someone is willing to convert all writes to `f_flags` in C into
> > a WRITE_ONCE(), nothing more we can do on Rust side. So using
> > atomic_read() is the correct thing to begin with.
> 
> Huh? The C side uses atomic reads for this?
> 

Well, READ_ONCE(->f_flags) is atomic, so I thought you want to use
atomic here. However, after a quick look of `->f_flags` accesses, I find
out they should be protected by `->f_lock` (a few cases rely on
data race accesses, see p4_fd_open()), so I think what you should really
do here is the similar: make sure Rust code only accesses `->f_flags`
if `->f_lock` is held. Unless that's not the case for binder?

Regards,
Boqun

> Alice

