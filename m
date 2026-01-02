Return-Path: <linux-fsdevel+bounces-72329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D4CEF1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 18:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49449303198E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D082F9DBB;
	Fri,  2 Jan 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn0gvEYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8462FA0C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376643; cv=none; b=Pc2wgx1eSJ2C0EqWCyeA9fmD1ns2eNNNPyjhOcOCA7+Sxhbt30UAUH8MD6R36ETDa/iZ6pGsiqVh6jdFEqZ5EdBudAxoHhav2oobiS8QfwpiUEFXCpicOGYdqRsc1/NEGOG65O8LYPqYhMOqojaQAF8YPBlPn1447wnc12oWWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376643; c=relaxed/simple;
	bh=gyDb2jd+vefeb5derpsvq7OglruyF0nZkG8dY+zRgDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJZ40SOy3PgGS0p8cAXHw7T9rDH8wnwtW8vIao/yQH9BHlI01QXblLlJbt1DJpQoavaxv81rqwh+qpsS5NOXbLpY0L0NKUFImuVIkWkXCUTu5+Dm2M1TEnvey+LsQxNFexZwIOqFLKKRlrpS2BQFkLgVMT2E50qJ/1JQ1p7Juj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn0gvEYJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so178152551cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jan 2026 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767376640; x=1767981440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O18+3anvsQ996bavqCgxvMHI82KXbcuUs/EX7wR6K1s=;
        b=Gn0gvEYJFLfskRJjbCCkxCVCpwz0AZIxMs7Vgx7s60tIMHZPTlHulYxDVfQPeKUet2
         DdSrRR3ska24CIgGq0+hJc9H99xCc67HtXg609JXGsovNym4+/S74ANh6YrCicToSJGL
         +0kjCF7JwN+exGmt42r5QBZ4ya45ZFZRxRBXViY84G2rF+QxRQVXEbShSj9M152X2xJD
         dNy/6AVi+TkMz29mz8S4fdudT8E29cGGPLRemqC+6YM/EKijqZOraFbK4rE451U0qe9T
         oCgZzkiuCiF+NiGFuW2D+QfuhvJu0w7ThUMKdUqlgZqIUuvti9U3zbfvVfg6pfteUrKk
         l+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767376640; x=1767981440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O18+3anvsQ996bavqCgxvMHI82KXbcuUs/EX7wR6K1s=;
        b=Hn97QPr7Y8ov5O5jkjGPqV08rS1yeqTJ4M2LRMCjDnccGGfPmzCPP6Y/yxLCFFORZe
         5YvIbp5jn8R4Y0reEA1R/kWbP+BvdTsdZYOoWYQp4wGEh8DHFIiKnAjcqv+OKUCLQyiI
         K5+TP4GkAnLtO6CDNrbU6VRpuwLINmOBfdSb4NjhxoV8SD/tug8283ilH4SWjNimoP30
         JWIIVWadvodJ+xVHUiFG+TJ9iiRnwGcC9k5l48qLRyOJTGTYbtkaZ6a48UsNu639dQwS
         uooBPr6qKEhGFGGp9UJn1BgFwX0+lPwJd0Qt32m67s7ZEszzcxpIM5AsvGEUBkv0foOh
         UFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqTyxpOJSe4oj18MvaLg7aLAWTbZ/VbMGu9nTf2GOnZmJv49Y4CKobJuR+iwTsNV7AGWgxhvA+fBVlBpSL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PkTpRP6nHgqYYixmTlzHQJVAcVpLlGA35PPRukBRmBpNXsjX
	APh6rVuES3k3AJeKglwsdwp6j9LCJTneleKe+he3TVOCtbK0NHYcFSsgnZqRs654Jjuhn3EzQnn
	su2PNCgDLPRkIW8hS4+hp9OoQn/C646o=
X-Gm-Gg: AY/fxX7Ddh45hbVyHxYfEXSFgzJaZbADFzzj75jvm6sMYLPDCaT9lR+wJqj6GyfUUsH
	qz3msqIEiFaQDoofm3h3qRVVu/v5RbVri1dPvAjYwo1EXOcVgw51D+EYg1rnNlMzqj9XmdXk15X
	N842rOXCL0DVBJ6Yl25osnQXpWyIYNt1Rx8K/SY73/VOO1bIl1WfRATAGURqe6ZUEfvtL3QaYrR
	6bmXM/MbxUAb2MkyOYs000Zp8f/jkIDp6n1GP7LkkYrl6RPy7YpRfsoKoKKPuVqu+/pyg==
X-Google-Smtp-Source: AGHT+IGorKA3maAZSXofCUy+HCC+njczBAg7rvZDg6EpFyE7TD4+DSfCoFgZ2bxYOgmujaLYA/z+r/Sp602TQv0GSmw=
X-Received: by 2002:a05:622a:6081:b0:4ed:b8d6:e0e8 with SMTP id
 d75a77b69052e-4f4abcd2ac5mr601470401cf.22.1767376640426; Fri, 02 Jan 2026
 09:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-7-joannelkoong@gmail.com> <87y0mlyp31.fsf@mailhost.krisman.be>
 <CAJnrk1a_qDe22E5WYN+yxJ3SrPCLp=uFKYQ6NU2WPf-wCiZOtg@mail.gmail.com> <87ikdnzwgo.fsf@mailhost.krisman.be>
In-Reply-To: <87ikdnzwgo.fsf@mailhost.krisman.be>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 2 Jan 2026 09:57:09 -0800
X-Gm-Features: AQt7F2rzrlK2P2sAM_OF9aPxCtuxCi-SzhqRwIpfqwqCRawDl8BmvdZb9N5jWa0
Message-ID: <CAJnrk1aAJmsK6Z0=F3n65pr0idGzDXFLEXXZDHOocy9ktnDZWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, csander@purestorage.com, 
	xiaobing.li@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 9:54=E2=80=AFAM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Joanne Koong <joannelkoong@gmail.com> writes:
>
> > On Mon, Dec 29, 2025 at 1:07=E2=80=AFPM Gabriel Krisman Bertazi <krisma=
n@suse.de> wrote:
> >
> >>
> >> Joanne Koong <joannelkoong@gmail.com> writes:
> >>
> >> > +int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
> >> > +                  unsigned issue_flags, struct io_buffer_list **bl)
> >> > +{
> >> > +     struct io_buffer_list *buffer_list;
> >> > +     struct io_ring_ctx *ctx =3D req->ctx;
> >> > +     int ret =3D -EINVAL;
> >> > +
> >> > +     io_ring_submit_lock(ctx, issue_flags);
> >> > +
> >> > +     buffer_list =3D io_buffer_get_list(ctx, buf_group);
> >> > +     if (likely(buffer_list) && likely(buffer_list->flags & IOBL_BU=
F_RING)) {
> >>
> >> FWIW, the likely construct is unnecessary here. At least, it should
> >> encompass the entire expression:
> >>
> >>     if (likely(buffer_list && buffer_list->flags & IOBL_BUF_RING))
> >>
> >> But you can just drop it.
> >
> > I see, thanks. Could you explain when likelys/unlikelys should be used
> > vs not? It's unclear to me when they need to be included vs can be
> > dropped. I see some other io-uring code use likely() for similar-ish
> > logic, but is the idea that it's unnecessary because the compiler
> > already infers it?
>
> likely/unlikely help the compiler decide whether it should reverse the
> jump to optimize branch prediction and code spacial locality for icache.
> The compiler is usually great in figuring it out by itself and, in
> general, these should only be used after profilings shows the specific
> jump is problematic, or when you know the jump will or will not be taken
> almost every time.  The compiler decision depends on heuristics (which I
> guess considers the leg size and favors the if leg), but it usually gets
> it right.
>
> One obvious case where *unlikely* is useful is to handle error paths.
> The logic behind it is that the error path is obviously not the
> hot-path, so a branch misprediction or a cache miss in that path is
> just fine.
>
> The usage of likely is more rare, and some usages are just cargo-cult.
> Here you could use it, as the hot path is definitely the if leg.  But
> if you look at the generated code, it most likely doesn't make any
> difference, because gcc is smart enough to handle it.
>
> A problem arises when likely/unlikely are used improperly, or the code
> changes and the frequency when each leg is taken changes.  Now the
> likely/unlikely is introducing mispredictions the compiler could have
> avoided and harming performance.
>
> I wasn't gonna comment in the review, since the likely() seems harmless
> in your patch.  But what got my attention was that each separate
> expression was under a single likely() expression.  I don't think that
> makes much sense, since the hint is useful for the placement of the
> if/else legs, it should encompass the whole condition.  That's how it is
> used almost anywhere else in the kernel (there are a few occurrences
> drivers/scsi/ that also look a bit fishy, IMO).

That makes sense. Thanks for the elaboration.
>
> --
> Gabriel Krisman Bertazi

