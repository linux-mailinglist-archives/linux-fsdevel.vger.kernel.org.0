Return-Path: <linux-fsdevel+bounces-41103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63242A2AEB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC51889A01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD81684AE;
	Thu,  6 Feb 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA/RB2v1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152C23958E;
	Thu,  6 Feb 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862327; cv=none; b=jB74kk9XEM+xFvUo5p82FJpRNKDscZ0gn8e1EZkUDTRW2F82DJyJfiYPb3eQBo9DPZ/+bcejgdtx/zG209awpoDb1bOQViYHWielaFceN7P8ctTgd3SjDrBFQBFmogeRdekhvo1RHAwjD0yhvZKOtOSNgTNrpSQ8FNQX1d1x8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862327; c=relaxed/simple;
	bh=hign94Go9lk4AYPopq+TYKCuIxjzdqNnqTCBcL9Y1Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMP/XZQA3YgHJIojBamNS1oJy5LzdatCGlMDVtNoh5kRavvJ65AVaiMvTYlef3eBnaYLpl3RDj1Gyj9R+KV5NZqsmXh6fPuQV7ZVZHQEFFw+mR72uZ+5PsgGLf3O7WpoGHpb+96x7VJXNAhhxmOMNH0/vdKP/RMFPuTy6lobvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA/RB2v1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46785fbb949so12981021cf.3;
        Thu, 06 Feb 2025 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738862324; x=1739467124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWZE34TSmahB5AibwSst6U5NVP6NbGfoRI+yy3U6I1c=;
        b=ZA/RB2v1bqUkieU5vUKFp22+J4mX4hKOqDCON8VcT6LPRTLt1yy0TTgLO46NO1CuHq
         vtwSKxKsUX/IAsIpDyaM+1MKfpFNQ32tEGE2BffrGyxx77x29USTJLHcEPrw2cWXcj80
         OJiTo7sdKCoszYDJcuEK1GonIm6GPnc0F5sW9LIjkEFKYL6E+OU+cvBXf0X6IGUiENkf
         vI80ghXtEiImge1NBxi1xHJipd6FLuzj5cXlYHJUk3e6kcYMM1n8fyZs9WsVvortgmz+
         jp3Pn75Bys/6IxbuW9IOBx53nyo/NWoLGbcYoHjh1uugDucKwBHaqBRtf8v+kpKXhMPO
         KQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738862324; x=1739467124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWZE34TSmahB5AibwSst6U5NVP6NbGfoRI+yy3U6I1c=;
        b=LKUJEd7fA2Qzsp8tKWRxsVOG9HLWMzgB71EZ47H2j3DznuwLmfRAGYnFbWxtib6Bp5
         ewsAESj+29Y4G2tT0cgOgCs+0SpGmHjANTd/0Tje7yZGEPetPZ0hDPCosfg+mp1pctQh
         WlMUSMos1O2dE48ib4Gk/Lk87+7tzOGX49w+78Yg2zpSrQAXSmMutRNYlMOdQq3VOwFd
         Ze3qzkvVeudRHN+ARP2C5BRWbb2Hqz9yHaQsrGeOd1oYis46c7oWOVGm57c5MevSTKGS
         8vxQeLPZ+v5+BThqcT35QCovRdJh6jj8c3Ms3H3sizVTxfJba6Dw2TChd8NIzDas7gPE
         O2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVGLrFA1BSw2JXwEjfqKfX49CYUkiFbjnXaNsfN8SMGniof1FTNNsdBY0XJXHnWCu99bz4v5QkaAdvfAWYT@vger.kernel.org, AJvYcCVRQFGPrsTTA7QuQOjMZ92XaIULfRQv89bHeaM7+vAqLCg4CYU/YYIbDRfQV84DMuzTkNHa+4phcuvlrL5l@vger.kernel.org, AJvYcCVqRTi/vJj4Kl9Lgl8jYtfpZyH3ag1+jCWpV9SK4zf0rztznxZSFs0ITn9vrPdv2xBguVVDe8YlUBIQ@vger.kernel.org, AJvYcCVtX5p8Nz9ILUVTNN3IA9gxX8e4rskc4wpqOfzw4G/dzZ7X4GlU4LqBNkCRCDi+4Mi9sah7Q1P3B4s4QIrwGeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcsaykhzv0v2DtCCzdP4dyoyeQcJCGSYcycNyVISoEBd9iu2e
	IZOKqv3VE+NhJ8Yerq8u9KTfF2UEPd/JZT5IX9F4TgUQ6rEBMpgO
X-Gm-Gg: ASbGncuz1h+pDKb6cr2GDV9i5nSfPkr+tAcM43XMobJt/vzOIy/5LLgD58dQzNNogWw
	soMfFc3j10g8kPprUsHtRrlPUm+cvGZoGlJooaR9cEEDc0cnGpiTmJIUtuqhM+M3shky68UNAI3
	UByk7veQQRI/INS+FOy55LDdxR/DU7Ahoafs7PfX+obPkewRbuOqWeaj1TQAsISF2IYPP0G/ZyR
	VjnSAaWRDJQcRMkyW4EFMo7/HQTTzSYnjiQ2kuRZq6JkxHHzBNv+m8Cxf8bJNbqZWuBPsydSDni
	WpGHjoAqyz5g56yBClQvWf5cupYS3uwJ61akkEgluDU1QWzskw2PbCN/mCNhRD0CbWWJcrKy7LZ
	8u9MKwg==
X-Google-Smtp-Source: AGHT+IFcuW/XgSmCC4i0dttCgM1I/hD7fjOkOntHg5kN5NTOknxD30oPuuJ8aQkhu6PUzCNg/tjPvQ==
X-Received: by 2002:ac8:58cc:0:b0:467:61da:1ce2 with SMTP id d75a77b69052e-471679ec4f7mr702191cf.16.1738862324283;
        Thu, 06 Feb 2025 09:18:44 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492c333csm7340371cf.48.2025.02.06.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:18:43 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2930C1200043;
	Thu,  6 Feb 2025 12:18:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 12:18:43 -0500
X-ME-Sender: <xms:8-6kZ2l8XiVBWBm5rTzHC80qndFjsKbCkh2q1pLLO8MvZWSvxSPSZQ>
    <xme:8-6kZ91qw9OuUgy5-3KXkSFwaW_JOgo3cnPHSL6zbgL_RjHlypxsNltxGhWjmKsjf
    CiWcwl9xw7sW5Dh1Q>
X-ME-Received: <xmr:8-6kZ0pmU93HoOzaieAtgeDEOdXXkLTRopFNeJl8RWO--t1uVd0hqUrFRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    ohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgu
    sghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:8-6kZ6l1hOeJT8v7TUBz8oSP12kpo96EKFsX0rJpOZRgEy7E6DznGQ>
    <xmx:8-6kZ02zK9dLV6YF3Lt3D0t3Ln4ns7DVPytwZAVFFxAZSEMeLR3UEw>
    <xmx:8-6kZxsilXIdZ2zjxFSP7Yc7CyKoQ4mfsjDpvJI9FVM16SuE21kCTw>
    <xmx:8-6kZwVZpRPTpkNefKq8Quc9eyEh_VxSlbLZg2_gcyIQCupuC-JywQ>
    <xmx:8-6kZ_0xrlqHvJgaeeV81Pe9a47bNufGsWDy7qO4vVMv5VssB0STMCOk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 12:18:42 -0500 (EST)
Date: Thu, 6 Feb 2025 09:18:40 -0800
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
Message-ID: <Z6Tu8E4r5ZEolFX1@Mac.home>
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-2-a22b5dcacab3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-rust-xarray-bindings-v15-2-a22b5dcacab3@gmail.com>

Hi Tamir,

This looks good to me overall, a few comments below:

On Thu, Feb 06, 2025 at 11:24:44AM -0500, Tamir Duberstein wrote:
[...]
> +impl<'a, T: ForeignOwnable> Guard<'a, T> {
[...]
> +    /// Loads an entry from the array.
> +    ///
> +    /// Returns the entry at the given index.
> +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Loads an entry from the array.

Nit: firstly, this function has the same description of `get()`, also
I would prefer something like "Returns a [`T::Borrowed`] of the object
at `index`" rather then "Loads an entry from the array", thoughts?

> +    ///
> +    /// Returns the entry at the given index.
> +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Erases an entry from the array.

Nit: s/Erases/Removes?

> +    ///
> +    /// Returns the entry which was previously at the given index.
> +    pub fn remove(&mut self, index: usize) -> Option<T> {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        //
> +        // SAFETY: The caller holds the lock.
> +        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
> +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.

SAFETY comment here needs to mention why there is no alive `T::Borrowed`
or `T::BorrowedMut` out there per the safety requirement.

Regards,
Boqun

> +        unsafe { T::try_from_foreign(ptr) }
> +    }
> +
[...]

