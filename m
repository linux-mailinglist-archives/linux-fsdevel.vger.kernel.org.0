Return-Path: <linux-fsdevel+bounces-41123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7BA2B3A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E258168788
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4D1DDA3E;
	Thu,  6 Feb 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcjLPXXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE11DD0D4;
	Thu,  6 Feb 2025 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875517; cv=none; b=uPWBa0lI/pze6VfPHLp3bFVEPoXBvdS8UEjTat9NEIN8QrtWFoyhWPd9lN8udUc34ah/CIL+fI4nLbIAAfccNO5ZaDtCtvI2p8FAZpndpFOaaCWMaKzFwT9+BJBqb7X47ZafVYPTmMBEknZalAZPUsZWgY202nm/ojDiiK1EySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875517; c=relaxed/simple;
	bh=Vl1E5n4Tqgm2PGQzPBmSB+0qboSZss7zKm0zOFIQOIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOjvEqSK6w1CBdI4XPp2cEY9nMTax32VZD9XNyPQx/mP/J4uZsYlmWH6tB5dCzz/IDdaTTdOTAzvJ4cUJWOXlUtEFhTELfuqfkOos8Nf6LEUtThqmR6WUUq6L51UusHegqdkrCsy7t6sUrNOpAhbfl1Oh4GntJSucBe5X77uGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcjLPXXO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46783d44db0so14372221cf.1;
        Thu, 06 Feb 2025 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738875515; x=1739480315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t9cHsIps+BUS5q+gyi26JPt+JcfCXlNK6A88Ldomk2Q=;
        b=KcjLPXXOX5c/J0vRBGeJl4bfPcBlKjF+pTuRpkdx6cF1pEJLFQCTDHW1dixVdB9vFq
         74wCmvOfg/bay+nNAzj2I15hfujCz/xo4nXhBEKThTKF/8Mrb4bWFr/cmVP1zDVypSCN
         +v9Et6cAB4Bzqc1W4Rt4oTvm7Q+aw8xdEg19fM6p1O2inKMHmBdE3k7yjwQ1BQm62TkG
         TgT/7OcL8b/gqnpUo79lEjXOgutRAEt2FD2IqwJbxknXZsr/s/PCbdNQAEP+kvih/q/k
         Vo2EKj/KwsqTMtbheDYbYqU5ROOnyP0u+3Vx+PDyMpfQW7dKsFBLupkOKlLhyQsl+mKx
         S54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738875515; x=1739480315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9cHsIps+BUS5q+gyi26JPt+JcfCXlNK6A88Ldomk2Q=;
        b=Ycz+pX8ymcExi3zCSFOSbBzNawS1xRtIZWLlDivx2FNEHm1jtzBTM2Jvt9iPWiJx3Q
         Jfxsu3JXAgECPCSEx1OPTJsW54qfj4fOkMfwsj90pb/EroCKWTuLCZ9IGvl8bnvKhR0k
         ICAZOOz8dRnBw/Q+mX5QeaiLCXZLd7Hogrxxh3WxhTHs30eONCPIBOJaWbeRyavzIGMu
         N/OpFLbDDlyEFBIIi+aVCVNEbdlHPlV8vR297jN2Dm+S2E24QGpHmqS3zwhDbKEq5jpN
         n9Ydsn0oEHha+UeBAq4q7S8p7A/R+UvbxoKCJ4bxtjXEE7lq4iunt7La+XYZPmGeuHfu
         4vpw==
X-Forwarded-Encrypted: i=1; AJvYcCUKiFww705Gpry9IBSdfLmhKFjdYDrrRlrviZE4c2CZwnj7m9uIiObWx+B8yFBgpwhlEUv9ehj9/qjguAtN@vger.kernel.org, AJvYcCUgw9EdQ1uaylA9QLx+7wCSlNnCkFcHJYPer4/YBCj2Jk4K6iRInZRvyrcDNKoCou6zWNVtufSCQUqV@vger.kernel.org, AJvYcCXYZUT43SECbT1h0yRqTLkZ2aT4LAMUp7vWFYN847gjd6cncRPDy22+8o5Qo1480n6W+q0yewrspiHuPTDU@vger.kernel.org, AJvYcCXpGbDZlXNkwT0+DDFcXPffni1CCEBwEcNONThpuwRUxdeVAdsd6wKAkmhmYOLx7sUfmdnUMho5SVQD4b9FPXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSX2c/RispQsYA8foonbLMNObutV+3db/p4Ilx7+BN7yIJDFgm
	4ihLCMeuT094NRNgL9og13wZGE2za0wvOs/621eSwTYvrmc21WeT/PU3RQ==
X-Gm-Gg: ASbGncvFlwOeEVE1Flu2tRdCX+TNlT8mghCEo8UyG9VWk7A4jGq/Itn/7Cxlq71EqUf
	WI3Lw9lBnbSkuLMbIrzr35Wn3rduZ6qhU2MHAEsdMOYak6HS/8oko1Ksf/7B7+hBh7BjlkLny4W
	8pjRNOcL6lwCwkYHnwxNX3YTGs18pKWALVa3+AdR0tlXcjaQH6tgVsrbRJsXQqvC/QVcrQhR5Wf
	Nnkpb7Hy+JrdQ9/eRtTp6rw3CZMPAkFkZwRadGRKIpDmK3AOBJjHd971Prbe5KuoRrX1AI0cAVY
	Frq/7wOtFYD1hcvHB+gaPYcy7btEOtuS2a7FDe9JAx4o0oAp9rC5JirG/29XjDGC6cSvGfcoEtZ
	L/8hVnA==
X-Google-Smtp-Source: AGHT+IHuTiT1O9gWcNSlS8NNPtvRf1yXdSvvR+Laa0d93a1XUZSuNd8/pQ+BCFaC45iXFJm2+9asTg==
X-Received: by 2002:a05:622a:6182:b0:461:22f0:4f83 with SMTP id d75a77b69052e-47167b07bddmr12791641cf.43.1738875515083;
        Thu, 06 Feb 2025 12:58:35 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a91b6sm9036151cf.34.2025.02.06.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 12:58:34 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 032F91200043;
	Thu,  6 Feb 2025 15:58:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 15:58:34 -0500
X-ME-Sender: <xms:eSKlZ-P1XZZZwwOALGZsJMKMKTZ2t1mRy3hCWjVkS3UHSei6d_7tFA>
    <xme:eSKlZ8-_JUCzgRLfxcmxTU-Sm-ozIqRpdmGSynfNwatc75aPWdaRuRIEdCH1J1h_X
    1CE8JXdekWjdehfGA>
X-ME-Received: <xmr:eSKlZ1T9moYcz8JW0s2M0BH9XYU7g4uZaygZXt35X2VTUEFwE6edd8C1M-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomh
    dprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:eSKlZ-vA6jXnYmz9tmLDBjDkBTik0K8rin_JOnOJ1N5fJD8kR5gw2g>
    <xmx:eSKlZ2cKL70bfoHR9pQuTzAe62KtbtB-1gefbEKPqGA7GEqJGT7i2w>
    <xmx:eSKlZy2UOjrX1g5N-lc-swWMPbTa_4dCp_M_BXa8oMT9W_CdmNnUIw>
    <xmx:eSKlZ68WK37X8rB6-Gooz4quTAaqGD72W5lkjltOONiU8idJFqkbBw>
    <xmx:eSKlZ1-vviK6heep0UHzWhKNK6u6vLVGhU_pR2xpMAvjje6BxjMwkSLz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 15:58:33 -0500 (EST)
Date: Thu, 6 Feb 2025 12:57:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 2/3] rust: xarray: Add an abstraction for XArray
Message-ID: <Z6UiNYOTUshEKNcL@boqun-archlinux>
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-2-a22b5dcacab3@gmail.com>
 <Z6Tu8E4r5ZEolFX1@Mac.home>
 <CAJ-ks9nGZCMjgTTzeRz3DUCQyLVu-xWKau4AFkMGutLtomK-fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nGZCMjgTTzeRz3DUCQyLVu-xWKau4AFkMGutLtomK-fA@mail.gmail.com>

On Thu, Feb 06, 2025 at 01:21:35PM -0500, Tamir Duberstein wrote:
> Hi Boqun,
> 
> On Thu, Feb 6, 2025 at 12:18 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi Tamir,
> >
> > This looks good to me overall, a few comments below:
> >
> > On Thu, Feb 06, 2025 at 11:24:44AM -0500, Tamir Duberstein wrote:
> > [...]
> > > +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> > [...]
> > > +    /// Loads an entry from the array.
> > > +    ///
> > > +    /// Returns the entry at the given index.
> > > +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> > > +        self.load(index, |ptr| {
> > > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > > +            unsafe { T::borrow(ptr.as_ptr()) }
> > > +        })
> > > +    }
> > > +
> > > +    /// Loads an entry from the array.
> >
> > Nit: firstly, this function has the same description of `get()`, also
> > I would prefer something like "Returns a [`T::Borrowed`] of the object
> > at `index`" rather then "Loads an entry from the array", thoughts?
> 
> I was trying to avoid repeating the signature in the comment. In other
> words I was trying to write a comment that wouldn't have to change if
> the signature (but not the semantics) of the function changed. Since

Understood. However, I think doc comments and function signatures (and
name) can have the overlapped information, because they are for
different users. Surely a developer who already knows what XArray is
will make a good guess on what `get()` and `get_mut()` do, but it won't
hurt to have the doc comments double-confirming the guess. Besides there
could also be someone who is not that familiar with XArray and would
like to seek the information from the doc comments at first, then having
a more precise description would be helpful.

> the difference between `get` and `get_mut` is completely described in
> the type system, the two functions got the same comment. Shall I
> change it?
> 

Your call ;-) It's a nitpicking after all, and you're the maintainer.
However, I do want to make the point that being a bit more comprehensive
won't hurt when providing an API.

Regards,
Boqun

> > > +    ///
> > > +    /// Returns the entry at the given index.
> > > +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
> > > +        self.load(index, |ptr| {
> > > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > > +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> > > +        })
> > > +    }
> > > +
> > > +    /// Erases an entry from the array.
> >
> > Nit: s/Erases/Removes?
> 
> Will change. I used "erase" because that's the verb used in the C
> function name but named it "remove" because that's the verb used in
> the Rust standard library. The result is neither here nor there :)
> 
> >
> > > +    ///
> > > +    /// Returns the entry which was previously at the given index.
> > > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > > +        //
> > > +        // SAFETY: The caller holds the lock.
> > > +        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
> > > +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
> >
> > SAFETY comment here needs to mention why there is no alive `T::Borrowed`
> > or `T::BorrowedMut` out there per the safety requirement.
> 
> Will do.
> 
> > Regards,
> > Boqun
> >
> > > +        unsafe { T::try_from_foreign(ptr) }
> > > +    }
> > > +
> > [...]
> 
> Thanks for the review!

