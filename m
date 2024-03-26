Return-Path: <linux-fsdevel+bounces-15317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D388388C203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAE3031E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C20F71B5D;
	Tue, 26 Mar 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNQQoOsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA112B6C;
	Tue, 26 Mar 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455834; cv=none; b=LxIRq2w7N1pWPW1PNOfIpuQexLyBSN923VT+Uusm6cqNGGPB/wdStbDTM1A68juNBag4zy34AcD7lrxDnHZXw+iWMBR49drFvneVE9RCqJFyKZGaGZats1quejmqKiQCFipjkiDjFlsBfMebrSXfdtBIsBAYyfVz5Icoq2cHU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455834; c=relaxed/simple;
	bh=4VlVLK2sdJR7lKxQDcN7Nw94rnswCWGOJygtw3l0Z2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHTQdwFlxjNtEROzPwz9I7Q/lQl8gNMNJJ/+zl8xEEwi5QFQkRWsc6WkxKqas+4kiT8LHI0M4bIPBeel2fssCStLuJSkrF9j2VkUeiOOm0pVbI8Adkbs5aqRgc2dFTtay2NfLvCXJjRf6ZNWbNKIm4YJ7hKZASB0p/vcohe4h00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNQQoOsx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29fa10274e5so3605333a91.3;
        Tue, 26 Mar 2024 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711455833; x=1712060633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VlVLK2sdJR7lKxQDcN7Nw94rnswCWGOJygtw3l0Z2Q=;
        b=dNQQoOsx9zbo+dE6oIa5JHFWtTb8lcDqijnPg9Lin9sopk/ZOPVErtNjBkb5IsL+nm
         SB9lMw/xZgARByCKHt8mseLlUdlNOP/cW2aRoXdsOUc27CPkNTWxSli78pqG3MVzawLC
         PmTuDFBzHsaMEBPMsizGlGI3OQ0DQ4hjm+MXc125SbbOFJ+uOllPNRR+oks36opQwBTK
         yFqcL/z6WmzNp6pifM/p3/hiaI52+ukicekAOYJLub5WX4LryWUE5YE9ASVY1ypW7DZF
         gpZXa73f3ouIwoKEaM0wvH8WfA8SGzpCrHLwl6vat27PRM19U/JACBJcgdyD4MzGehwn
         33kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455833; x=1712060633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VlVLK2sdJR7lKxQDcN7Nw94rnswCWGOJygtw3l0Z2Q=;
        b=oONt7tuHvS352IV8Rj7XNsMWCWYZNhbZlmtN/M/l3yLzjjJH27PF+T6Hb1t6jRN+LE
         THSIxthBFScrc4BfaNFLEaFklLCRO/1aEyffr3T/VyRDxBlN6C83UzWVJU+V1zbv5jMo
         bP1VqBt2hWy8Fz0Wz+e3KBDWCxmCzqpcZBFW6esgQ5rGUGoRKGlQWapH8J2MqIpgxJPt
         fKKh3ba9Xt3J0Og1LAhzoTwMHx62OIIyqSyNYLLGmXFUIHc81G5igoGhXLqALupe+JSZ
         WaXK9fJjEt6cLgo7fTIJ1EeOr0QOkY1IQXBkIZWkf3QPYTjowfswvaPfsLDbgV40BRwE
         8VPg==
X-Forwarded-Encrypted: i=1; AJvYcCXu152mRDQg1psZSiH3EbLkiMJuX7vrJfd8q2Ex94Z4njU4dF265YtONnO8umfMFAl0W5SlgH0YeefSZIJdTzTuH2K9lYDu5fIt5Xt+ONo71yatSoD5Cyy4dr6LD/uYpvnoTJ7TfFX32qaxUbHT
X-Gm-Message-State: AOJu0YyAL9WEe0mDHazEJeC8FZUk5C05XMo9FqfGsXuzW+hVTIvYaK/R
	kJ34RnqKAik485cNy3Lg30A+AgS+Lcv0dZ79FqCOBzjTmXL1BVSPsx3oU992OUThx2JNypEKd9z
	zXHNtAWuokS2kuW0XuJul+vb9udI=
X-Google-Smtp-Source: AGHT+IHGxv7/5zhs2iRpuZ817ZZrm39w00aoZ6a9Y5udibuKXf94oH1WCbdxNgUhyJd0u5zI9NSI/YjP1hFYA65UElA=
X-Received: by 2002:a17:90b:3d0b:b0:29f:9275:b660 with SMTP id
 pt11-20020a17090b3d0b00b0029f9275b660mr1048310pjb.38.1711455832733; Tue, 26
 Mar 2024 05:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309235927.168915-2-mcanal@igalia.com> <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
 <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com> <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
 <31263f2235b7f399b2cc350b7ccb283a84534a4b.camel@redhat.com>
In-Reply-To: <31263f2235b7f399b2cc350b7ccb283a84534a4b.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 13:23:25 +0100
Message-ID: <CANiq72=1hY2NcyWmkR9Z4jop01kRqTMby6Kd6hW_AOzaMQRm-w@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
To: Philipp Stanner <pstanner@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
	Alice Ryhl <aliceryhl@google.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Wilcox <willy@infradead.org>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:41=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> I actually think it would be nice to have variable declarations at the
> top of the functions, but that would obviously very frequently collide
> with Rust's concept of data being immutable by default.

It is true that deferring bindings sometimes allows for more
immutability (this also applies to kernel C to some degree with
variables at the top, by the way). However, it is more about other
things like when new objects can be constructed (when can invariants
be set), when destructors run and in what order, even the type itself
(rebinding).

But it is not just this (where to place variables/bindings) -- there
are other kernel C guidelines that do not make sense for Rust, and
trying to apply them is a bad idea.

Where possible and where it makes sense, we should try to keep it
consistent, of course. For instance, naming concerns have been
discussed many times (avoiding different names for existing things) --
that can be indeed be confusing and introduce mental overhead, and
thus we try to avoid it, even if sometimes it may have been locally
the best solution.

> Regarding our example, my hope would be that `if ret < 0 ` should
> always be fine, because, what else could it be? A float?

I think one of the things Boqun was referring to were the semantics of
the value, which is why one advantage of `to_result` is that, when
dealing with a C function that does not follow the usual pattern, it
stands out more.

> I'm very happy to hear that we're on sync here :)
>
> Though there will be a lot to be discussed and done. As I see it, so
> far the clippy rules for example are global, aren't they?

Yeah, and that is intentional.

Of course, as with anything else, there can be exceptions where they
make sense. But the point is to avoid diverging in how we write the
code in different parts of the kernel unless there is a good reason.

This is essentially the same as the formatting discussion. The flags
for `rustfmt`, Clippy or the compiler diagnostics can and will change
to try to come up with the optimal set as we learn more (and as new
flags appear or if they change behavior in a way that we didn't expect
-- hopefully not -- etc.), but they should be consistent for the
entire kernel, except where there is a good reason not to.

> I think the ideal end result would be one where we have rules and
> enforcement similar to how it's done in C:
> C has checkpatch, which fires errors for some things, and warnings for
> others. And, if it makes sense, you or the maintainer can ignore the
> warning.

I may not be understanding this part, but that is already the case, no?

In any case, I am not sure we should look at `checkpatch.pl` as a
reference here, because it is a tool that we apply against patches,
i.e. something done at a given point in time once against "ephemeral"
entities.

In other words, it is always possible to ignore any and all of its
warnings/errors, at the discretion of the maintainer, and thus it is
not as big of a deal to have false positives for the checks (in fact,
it is good that it does, because it allows `checkpatch.pl` more leeway
to catch more issues).

We could have different sets like with `W=3D`, though, including perhaps
one for "development" where it is even more relaxed (e.g. no missing
documentation warning).

> When the build chain checks global rules we can't really ignore any
> rule without some kind of annotation in the code, because otherwise
> we'd permanently spam the build log

That is the intention, i.e. that they are enforced as much as
reasonably possible, but one can still ignore the rule if really
needed (and even better, one can do it as locally as possible, e.g.
right at the item that requires it instead of file-wide).

> Yeah, I get where that comes from. Many new languages attempt to end
> endless style discussions etc. by axiomatically defining a canonical
> style.
>
> But we're living in this special world called kernel with its own laws
> of physics so to speak. To some degree we already have to use a
> "dialect / flavor" of Rust (CStr, try_push()?)
> Will be interesting to see how it all plays out for us once the users
> and use cases increase in number more and more

The "dialect" you are speaking about is global for the kernel. That is
completely fine, and as you say, needed in some aspects.

But what we do not want is to end up with different "dialects" within
the kernel, unless there is a very good reason for exceptional cases.

Cheers,
Miguel

