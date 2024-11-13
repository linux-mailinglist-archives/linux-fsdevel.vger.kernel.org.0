Return-Path: <linux-fsdevel+bounces-34571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4EE9C65B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E01F24EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE433CA;
	Wed, 13 Nov 2024 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUcAZFe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072310F1;
	Wed, 13 Nov 2024 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456372; cv=none; b=Q0gssI+KdAVnkt9/fNnlaHzqC3p6IFXUuAtT+Re5oRO12dCYH1MkgI1pbjCLAzRxGteKX4UpMyj67/cjs0RUy+H2nRzaRDOk8on9PeUbZ0eVQJ9H3/+W/5muqdbBUH0ss39fZb2C1B58kKCjBHeANxOfQNYq9NfkQcDEp7aamnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456372; c=relaxed/simple;
	bh=9EL2scJFXnccPjhChzPUjKuhb1mAN3zWhyrLCbq7A30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y59jDVAGHJ5yP/UPJ/unjBeo7XlircUxe3EoJaTs6vjWvoLizEVNzQkan32gltY1Iz+Dz/K1WxtDIBynyHGtLiyaKAnWJkouopH3QZRSJ2JjaoQBSXWIF2ATmKOBmFP85p78SQyNlS8FyF8mCXM7SU5qtKyAyfHXXtA7wyCDdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUcAZFe7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so46156006d6.1;
        Tue, 12 Nov 2024 16:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731456369; x=1732061169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EL2scJFXnccPjhChzPUjKuhb1mAN3zWhyrLCbq7A30=;
        b=HUcAZFe7lVeKbgJ74E4LD12h76luMWNw+naS5hPJlSXld3yLTDNJtaJMUYPdSGhoRj
         iuQLo9DeKO6gAs5WaIRwa3wo5t5RD/zMHyF3LLSJMwYoJQA5uEHOI0pdlvGMkEgOQEvZ
         SV/afK9V5kAI4snfy6tWmytAcPExTYCADw7oCVrrcJBeRWaRD7uSzIwAT4RKmhC87ffc
         xeXlrkKqw7Ur2GPdba8sP4Gq2QnyhV1h5zl6f3QmAddSoEGFbsnBVR/ZppoXOmwXJv4r
         gLEgrlNVVEc8mvn4cmNIZ0WKdjVKcFx+Yelr0SWftIeq1F/fcKC+of3rzf6CkjX2Ip0K
         FMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731456369; x=1732061169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EL2scJFXnccPjhChzPUjKuhb1mAN3zWhyrLCbq7A30=;
        b=ZCIFusMfWa4MvNDa7rDSnmB6/uocZqpNVx4mk3VoY1DRM95yY4I7mo3buBn8U3lq0j
         N1qWNeeKQ8x4pLO9EB3joCZKmM6A2og26Jym/Yu8imjxbE0FfjFCKMO+1UdsN/JxdPpT
         zp6FfNu+MKOrbKVFfDmaDkSAD5SiDbsKpVbUVF2G50or5L1q9WBtCYRRXBL/bOriJ/Wa
         ce1X6hQCd7LBSbYVtdeMT1/ZH9BdGEAQGSo3HgbNb/Ltp8sGS7RTEgEX0Kqcnqq8dcHl
         1xkn/iEEYCqMLJibeKgjHw0Z1CBA6Y3HnwrEwK0s8QW8XJ1gqzuSW0fGmHaTE1xuNX31
         1Akg==
X-Forwarded-Encrypted: i=1; AJvYcCUzUWCis8gqz4NkHb1RZK3hjWJfCsVheoN+KOSXQ4MCFIrVJ9RlZ9Q2zkdQGGQ/4gCdLhuSBcS0gjtSUQ==@vger.kernel.org, AJvYcCVcrnpS1yPs2rbvGZMOFCZRBsJlAeh4ywCZCZFC5EaJL9o+qbZnyJnW87xW/kjUqq9rOI1p8eV+VD6a@vger.kernel.org, AJvYcCVl6h5floAJ3+b+Qim+EDLEhsZvmbSdNQpZ3jME9An8D4J6QqrxgUW6HopH9WOIQgRkvTmAHX75lwCcPYmx4A==@vger.kernel.org, AJvYcCXM0iwVOCiqaeHYSm/lE9YDwmtqu8PKM2duTbkpX53e4EGfmhVuxN6/znfxZisnV78fwxd2/mBj5yx6Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAULNq2jlEBHbcDPt7nH72QyRU24FshPhWTjE3pf2+MZTPVzN
	5AZwnt4WeBVfTdgNE56NIt4wrWqbMx4nUVZVFhP//DpR3/lsIPTro+yhLkSxa9c6dyNBDcxANwG
	ingOIZ0ifA1wNwHIjw5y03ZDXeSSGhmime6c=
X-Google-Smtp-Source: AGHT+IHkvSgq/EOVX4LpHBlkcl1hDns6d7bWEXuH8vWxtTEazMpiUPJkYBXQtgxz2fPI5ACmGcS0nB3VO6Ms5GyJOoA=
X-Received: by 2002:a05:6214:570b:b0:6d1:992e:4c5a with SMTP id
 6a1803df08f44-6d3d03a9ac0mr63223186d6.45.1731456369379; Tue, 12 Nov 2024
 16:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com> <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
In-Reply-To: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 01:05:58 +0100
Message-ID: <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:48=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I am fine not optimizing out the legacy FS_ACCESS_PERM event
> > and just making sure not to add new bad code, if that is what you prefe=
r
> > and I also am fine with using two FMODE_ flags if that is prefered.
>
> So iirc we do have a handful of FMODE flags left. Not many, but I do
> think a new one would be fine.
>

Maybe I could use just this one bit, but together with the existing
FMODE_NONOTIFY bit, I get 4 modes, which correspond to the
highest watching priority:

FMODE_NOTIFY_HSM (pre-content and all the rest)
FMODE_NOTIFY_PERM (permission and async)
FMODE_NOTIFY_NORMAL (only async events)
FMODE_NOTIFY_NONE (no events)

Thanks,
Amir.

