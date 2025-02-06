Return-Path: <linux-fsdevel+bounces-41109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972EA2B104
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331471883A99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B719D892;
	Thu,  6 Feb 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhK3vg5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A81239563;
	Thu,  6 Feb 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866135; cv=none; b=EeHC1473mu3aQr0mo3+9Ii/1HJhcbikWTxe0w9S9pNs66GZJApnriBijXlTP8LFsrDoCJ60XUSMwfdcoBmMrP46bP8lYTtOZ2Pe/T9vcf00t/NCwvu1ESd6yd6lvnatmolrP4dqURX0StoQbhsJGvKeVca6xy4+7eq3r+Q49yeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866135; c=relaxed/simple;
	bh=I0JoylfEjf5NYy/dEPAYeoaY68CrQJsOX33kLDUGtDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDDEj4o88iaDqGTr1dLYZ5EzmwWHdXAB/NtF4dStQ4iwgai8jJYSNYyfC5bdOhv41yHNMd86Qg7hh022KAGo71bIE/U1nlt9jLc9RSBoLcdNKTERS/X7KzcgzRVWhw//FOwhdEJfC80uzu5j8UKHksJdnvZiTV7J21eE166obe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhK3vg5Z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30616d71bb0so12684921fa.3;
        Thu, 06 Feb 2025 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738866132; x=1739470932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FjSp+nhTVRHLJUEeTrWTXh4h3mEMg91XlDhqYRzaKA=;
        b=QhK3vg5Z+rYBcSoaVonZJqG9t4bhW3mzGouUsruuobdwLqxjN+Ktu6PIIZ6btXtpym
         1S7uhswcGQKJ5CJNT+B42EB8hCGDmgC9KlWS4sZb/imVZdN/KO09BcekILuvrfNDqXha
         jtbRm5Vv/Ggt8zHAlk2jOUgRwL+UtXcb/jMDlY5RnYX3cpyrGiIq0ncnx3lwNibKPxn+
         C2nKecrRc3F2V35eYKNmfZ/gaC07ohkIKTkI7QEg8+qZAHoARxHhMvi3j4RrWqhXKDQ5
         EHFc2nYLK/ZmfNTFeewe/NaC8DnjbPk7GRDKKt+xcjNCpaUQCH/H4822YNuwRbZKcFg0
         GuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738866132; x=1739470932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FjSp+nhTVRHLJUEeTrWTXh4h3mEMg91XlDhqYRzaKA=;
        b=cUIe+yx8wsfidCrpDHpzGNUVAme/jclbYwWmS7lLLy1sUVmJtbH65i/dw/nNfccml/
         JbZQoeULPNO6YKHVW+Zev38dXY9qI9j/1s+G5O9IY+q8ll2GYB25s/PpV+HuDQttxYBd
         59CxSllyxIvPHcbPsfHUiSV7teImMqyzeZ3g1ZoifpuQ8+CZzRn9q0NaHXGLcg58VLPB
         4NdMCV0PSlmkZSWxo6S6LchzvsofS6z/ZUr3TP3wpf1y+Tr3CJiKsfjv0nW9HFfydrLw
         mma8v6+juY+KIeHoxi+Hy6HYgBvyAnm5J/toJBBH3k8wnT5rCXJ1GI5X7JVB2UVMfQKR
         Hk2A==
X-Forwarded-Encrypted: i=1; AJvYcCU9pEZ+4S+H9c+Ts+0R7bOnxDlB7RoUzQIdmm50VkD6v2IthnWwlYneWrhOk8R4ay/khaw+0HaHpjwkNVefb1E=@vger.kernel.org, AJvYcCUQX6j12XrVt/uzOgOeWYoxzyX/pBaDvyT3oAubhziqDcDTFtidP1HQa/Km5sCP4CjuGwZAdinZBi6iJWfa@vger.kernel.org, AJvYcCWeQ3/MXwoz9z0X3Wpq40xRBiv04vF6IaSt9E5B76A3CTl34x/PAuWVIOUzgcGGImFRdXmZDbVXtrB7Oa2E@vger.kernel.org, AJvYcCWtXmJNu/ljEJr4XqD6qrsAVUpM6MDaiOTu4WiAFCjv6esRIae84l56eGcIFSKHGKdF+C4wvdbrLbGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkdv49jr/MoJJ0guDX9zaA9mepKFf+/Ep/OgfvJM4eir14K9K
	QUNukcAN7rDL6kqLAvbuoBAZLRn3wKhMRbHNHlQjNUDjBOjulw0Rt01Bb5oa1L2bYbp2Pq7wCBe
	pqFG8439daUwbM5sQxTcF06DYkwU=
X-Gm-Gg: ASbGncseT4NRJHz9em8drOOtIbW/9VrNGR6QV4+RJqI5UMkGNPLbqawo1sw9DGgjvmX
	Suseh8ikwbun2Oln6GKeVZbg2vKhR8xOxLfHaYfWH02QMy5IOkeZT/UwVTgagY1mPmUCPTaOqB/
	U5GC6xYT0Ru/g+hOgNfN1Hue/3SIJs
X-Google-Smtp-Source: AGHT+IEubimIA/g2sUr+3XzIBjy9/U2wu4nTdN7tTx5dIs+4tZe9yiBHBtVxk1U/1rj6RdxXlb9+mDwbhGiHZDgWVvc=
X-Received: by 2002:a05:651c:4cb:b0:302:3356:3a98 with SMTP id
 38308e7fff4ca-307cf38ede2mr31148911fa.37.1738866131482; Thu, 06 Feb 2025
 10:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-2-a22b5dcacab3@gmail.com> <Z6Tu8E4r5ZEolFX1@Mac.home>
In-Reply-To: <Z6Tu8E4r5ZEolFX1@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Feb 2025 13:21:35 -0500
X-Gm-Features: AWEUYZkTDBIg-NNTe4OrrwEA8Z6ZCqWhhpkzyhj8VTuO0g9oQTLIoNgu_4Un96M
Message-ID: <CAJ-ks9nGZCMjgTTzeRz3DUCQyLVu-xWKau4AFkMGutLtomK-fA@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] rust: xarray: Add an abstraction for XArray
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Boqun,

On Thu, Feb 6, 2025 at 12:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi Tamir,
>
> This looks good to me overall, a few comments below:
>
> On Thu, Feb 06, 2025 at 11:24:44AM -0500, Tamir Duberstein wrote:
> [...]
> > +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> [...]
> > +    /// Loads an entry from the array.
> > +    ///
> > +    /// Returns the entry at the given index.
> > +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Loads an entry from the array.
>
> Nit: firstly, this function has the same description of `get()`, also
> I would prefer something like "Returns a [`T::Borrowed`] of the object
> at `index`" rather then "Loads an entry from the array", thoughts?

I was trying to avoid repeating the signature in the comment. In other
words I was trying to write a comment that wouldn't have to change if
the signature (but not the semantics) of the function changed. Since
the difference between `get` and `get_mut` is completely described in
the type system, the two functions got the same comment. Shall I
change it?

> > +    ///
> > +    /// Returns the entry at the given index.
> > +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'=
_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Erases an entry from the array.
>
> Nit: s/Erases/Removes?

Will change. I used "erase" because that's the verb used in the C
function name but named it "remove" because that's the verb used in
the Rust standard library. The result is neither here nor there :)

>
> > +    ///
> > +    /// Returns the entry which was previously at the given index.
> > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        //
> > +        // SAFETY: The caller holds the lock.
> > +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), in=
dex) }.cast();
> > +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`=
.
>
> SAFETY comment here needs to mention why there is no alive `T::Borrowed`
> or `T::BorrowedMut` out there per the safety requirement.

Will do.

> Regards,
> Boqun
>
> > +        unsafe { T::try_from_foreign(ptr) }
> > +    }
> > +
> [...]

Thanks for the review!

