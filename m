Return-Path: <linux-fsdevel+bounces-34567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC479C6554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA822844D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613121C186;
	Tue, 12 Nov 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhVWFPqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5620DD41;
	Tue, 12 Nov 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454866; cv=none; b=b0Zfzm6aQKVMzRtAdoeCBcMMLNOZngNCUl5VY1h0s9jI4I1ZEaF3LrCMDe9qpbFhFoMzaIA2XuFUfqE30RSYyc3jFZVocTmyWP7EPzN0HYGJd725yhzbAvOuSZO4dn+4NX4RGw6w3CHxLiPEWCCN1M8wK6PF1ZC0Av1f+MePWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454866; c=relaxed/simple;
	bh=zIHDsuhqhSIJJgwOMRK8hly4BoPR0xEX3Q4y6b5o9VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckYaMzw/SOQ8Wz/Uy5fAks5E0MunC2TZfn33LmbdWRqmJpSoCpvFIN8zkRZls6Y1fK3cNLE6oGb80HbfWxZHpVAs2CYqb8M/5vF3xjQbDdFONT4o4F3OucNPfbQGcytKv74Wad4WyNYRmwUCaC1oh+wmTMdzI76tuEIoz+UYTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhVWFPqE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbf340fccaso1496906d6.1;
        Tue, 12 Nov 2024 15:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731454863; x=1732059663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S41n8m1asHjOj2zkIWsKa2/GMlPGIciesJUEgI/ie94=;
        b=QhVWFPqEhj4is2KytOvyotCWz0DqjfuOJQ9XyVgSDuxpj3EB4xuCaiNHuNAuMGHyQg
         ZkxBe/corb++bPou0B/nGF/59XrcEO79sOhKAGpBaaGOnwCx3bSYTxR/fjiXO/2zYRYK
         W+ZPCZYLq5LBGKH+6gniQfP2F4DV4a5WDNcPU1aGhXAooaDLLP/k7MfBlD+3jzEXnIK7
         pjhYCYmRGcc1MwHmOuzB5C6cL92y4UrAFO5wLy4NCUBixvA8hmAQoHDatwsCbhSsdVQe
         xKueXj4pejepLVm1x7u9kAacTs1aOlgmCa5nh9e9ympDYRDhNawRM30hW52jqHG7NDY+
         xo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454863; x=1732059663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S41n8m1asHjOj2zkIWsKa2/GMlPGIciesJUEgI/ie94=;
        b=UcKPzKgb933fMHta2R4WOCf2IAF7LqMTqLmGoc+XZ4YLioBWdO9Q6eFfux9xDf7XKS
         andCZhSJE+yKQWo5aJQU3SvYrII8scFFEQ/fllRZBGoVawMhgOEQKtVmyS5okrbZhHhP
         LLBITRnUfDyJ7dG4SPqgYulqwrEVBZQtadKBXdPhgZBpV7z3HE5jYVcCBfZm2qW9/oGW
         3P7EdjeefVwACqu7CLfpvsAfe5Z92FDrj7KTbwXES7huir/sXD6Rz4xaA+pkjJs7r7Pb
         LtR0R7ixelN+ams4+oXXbdjX1eoy96OjDDT4BP4nXpygL9HzWJkePpUU/IkJFe6uZMM3
         6J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+PX8e+uo9GhkZYCIDIYWU1UIR3N8IlAQC5JfIZXFqp6WAWPdLn70DPHQ/CWC6L28Uv3qbK9EFo3iL1M+vRg==@vger.kernel.org, AJvYcCUDgNocH94RAgBD/oYkkZa0b75jvgyb5JGTB/cppRDAdlRAUj/qanmsD0Dc+OmHGfngRo1+m6nUJp38Mw==@vger.kernel.org, AJvYcCWNDT0QH5mU29yW+xNLULB6e/VxMitqJ6QGQkwW7+lHFRmHcXKnJPZu9OHHltRPCQJ/WBfBFm2Yds1Z@vger.kernel.org, AJvYcCWQ3Xa7GgKztPb4ExTca8zg92PqESNOj/IRNWLF6FSG96KWqL1AMSU55xO+WuvRgGbHgrCqF1eAjN8uYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxrd51CkqPADac0Hc6WfUX97n5LIK1dVqv06joRbnw11AG0gg
	E5MJ6apH9cIFE5zYnX9ux32foX2dM1mtPKhuD5ThZrfBz6bG7QW4I8IZeVRBMt0FKlKACFxPiMM
	6uCb2DHpwW8JPeY7IIUDbhcZJsXg=
X-Google-Smtp-Source: AGHT+IF5mj0cZzbas4T/DS3EAEzFgd019hNrEPMuAGUvwR2aAP50Ksm9TLyWCyC7OjmCeuhyupOXVNxsG44rGwB6G1o=
X-Received: by 2002:a05:6214:5296:b0:6cb:5bde:d78 with SMTP id
 6a1803df08f44-6d39d567a33mr292873866d6.3.1731454863339; Tue, 12 Nov 2024
 15:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
In-Reply-To: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 00:40:52 +0100
Message-ID: <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:54=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > +       /*
> > +        * This permission hook is different than fsnotify_open_perm() =
hook.
> > +        * This is a pre-content hook that is called without sb_writers=
 held
> > +        * and after the file was truncated.
> > +        */
> > +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0)=
;
> >  }
>
> I still object to this all.
>
> You can't say "permission denied" after you've already truncated the
> file. It's not a sane model. I complained about that earlier, it seems
> that complaint was missed in the other complaints.
>

Not missed.
I answered here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxg0k4bGz6zOKS+Qt5BjEqDdUhvgG+5p=
LBPqSCcnQdffig@mail.gmail.com/
Starting with "...I understand why it seems stupid..."

Nevertheless, we can also drop this patch for now,
I don't think the post-open is a must-have hook for HSM.

> Also, this whole "This permission hook is different than
> fsnotify_open_perm() hook" statement is purely because
> fsnotify_open_perm() itself was broken and called from the wrong place
> as mentioned in the other email.
>

You wrote it should be called "in the open path" - that is ambiguous.
pre-content hook must be called without sb_writers held, so current
(in linux-next) location of fsnotify_open_perm() is not good in case of
O_CREATE flag, so I am not sure where a good location is.
Easier is to drop this patch.

> Fix *THAT* first, then unify the two places that should *not* be
> different into one single "this is the fsnotify_open" code. And that
> place explicitly sets that FMODE_NOTIFY_PERM bit, and makes sure that
> it does *not* set it for FMODE_NONOTIFY or FMODE_PATH cases.
>
> And then please work on making sure that that isn't called unless
> actually required.
>
> The actual real "pre-content permission events" should then ONLY test
> the FMODE_NOTIFY_PERM bit. Nothing else. None of this "re-use the
> existing fsnotify_file() logic" stuff. Noe extra tests, no extra
> logic.
>
> Don't make me jump through filve layers of inline functions that all
> test different 'mask' bits, just to verify that the open / read /
> write paths don't do something stupid.
>
> IOW, make it straightforward and obvious what you are doing, and make
> it very clear that you're not pointlessly testing things like
> FMODE_NONOTIFY when the *ONLY* thing that should be tested is whether
> FMODE_NOTIFY_PERM is set.
>
> Please.

Yes. Clear.

Thanks for taking the time to look closer.
and thanks for the feedback,
Amir.

