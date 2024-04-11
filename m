Return-Path: <linux-fsdevel+bounces-16742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2338A1F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EA11F28204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DC17559;
	Thu, 11 Apr 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WTzaXJlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F455205E01
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864114; cv=none; b=XKqHCpoxW/1MK5qZcZydr+9/jWdZ2o7eZAb6CVLvb9pJ4v8h63UxW80xFAZ4YKsINHPImLYuM2DBhh77C+VNvcl2niX1ROTTfWvIqCvp8D3BFXF2vZpnvmLyfxRJjz+7ZXtgGxu9LnDSCUptm93ZRs62g8HkGrwiwIUY2wA+lwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864114; c=relaxed/simple;
	bh=5KVFeFerRH8GLwfSRDO//pTmkAv+uv/gwR3NCKN8Cdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyutQgUxwfsXhpSzP8RUZdr2iw1qDYQMB+OCDvT765lkOtRTvREkM3HUg5Hdf+QQsoajJY1UBnyDQgZSjNOIP9V4ukH3aE0vc0gdnpevy2EAH2qR0JQ43dACvCW0Q+plDNxw8IFH12vK+5KC9sXCSLTeEJi35Mis7STcxTMHIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WTzaXJlO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so1525191fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712864110; x=1713468910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhujaawioP0edqzESewC5qrutyIfvYKamEof/gouabc=;
        b=WTzaXJlOO/kVxxr1UkWojPQ/xwlyFTzOJSP5b0jR/awylRo5f1TXq5e9VoMDDY3kO2
         FFLH/bUak6hUenp9hECToGe5ICfRIfzKfk90FANs+DTVMzj3e0K5xRZ7x080OufLuOAP
         z6rlyTv541da48Ok+wcK3uaiY64r9X/GDlcuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864110; x=1713468910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhujaawioP0edqzESewC5qrutyIfvYKamEof/gouabc=;
        b=CwC2jnH14zGZsNzMBeXeqHujlE89xLdMcUqqcoafyALF0UTeQAdxLPN/tAQ05abVXw
         5qjf2VJUiJB+iPn6W30fimdqQH4fmS2cNn8580YKHgNomQZPqn4TbwlWa01l0bGiN9qU
         0BRDAMocL16kKb37ZVd94UA++XtkOLxmkYHcko0AjBm+O6rQvyIqx6C8KWJyeiaUnl3g
         4eANn/7oB8TVfU2jbmThL5nxhrZL48aA1B8tPWI4i4FNmpiYT1cyj3TLiz1+rVqZHPuN
         8VDsz73JLJblz/VVy+nDG0Ev9QqyVpTMZ7Rj4sGQTEJU1HIYfefrPCBf58LzblNmNbd9
         /nLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9UE6/H4D7xTXEOYYGk3TLn0Tsr37aHNjhm6zvYasYY60/72Floh3AEAg4bemZKjL3Tuqs3sWdx72KeGEAkZKc1cXXiwq7043WYZGudw==
X-Gm-Message-State: AOJu0Yy6MQvf4e6VGWS+cAhH+lsfK5Np9BHtReaDKvjWhEtpdGA5RSxk
	2I3yx0ZmtC8EcB8lQC4asOOh8p024gmlLzXmJc+Udh6w1WTgnGZ+vCqGvWQFH54mhhSR1dlbdhW
	kkTsQuw==
X-Google-Smtp-Source: AGHT+IEv7X8OV1l3Lfo/DvjPo1tcmFowK/N6NxsXfV3WRZZtMUGncTzMFos7nGxxRJfbX2Jb33TKow==
X-Received: by 2002:a2e:9805:0:b0:2d8:9955:cd27 with SMTP id a5-20020a2e9805000000b002d89955cd27mr353999ljj.48.1712864110486;
        Thu, 11 Apr 2024 12:35:10 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k18-20020a2ea272000000b002d4972b1658sm308475ljm.52.2024.04.11.12.35.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:35:09 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3776334so225304e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:35:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+axzhUd6zLAHeUIfnDntVjJb3VHqJFzqJXaB2EPUTywrJM5vldrDf9GALWDBYc6dpcQhCylGo7UU/3eOPhe6IEJJI0bRnpL/CCw8sSA==
X-Received: by 2002:a19:3855:0:b0:516:d11b:5532 with SMTP id
 d21-20020a193855000000b00516d11b5532mr402271lfj.23.1712864109199; Thu, 11 Apr
 2024 12:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com> <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
In-Reply-To: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 12:34:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>
Message-ID: <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 11:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So while I understand your motivation, I actually think it's actively
> wrong to special-case __O_TMPFILE, because it encourages a pattern
> that is bad.

Just to clarify: I think the ns_capable() change is a good idea and
makes sense. The whole "limited to global root" makes no sense if the
file was opened within a namespace, and I think it always just came
from the better check not being obvious at the point where
AT_EMPTY_PATH was checked for.

Similarly, while the FMODE_PATH test _looks_ very similar to an
O_TMPFILE check, I think it's fundamentally different in a conceptual
sense: not only is FMODE_PATH filesystem-agnostic, a FMODE_PATH file
is *only* useful as a pathname (ie no read/write semantics).

And so if a FMODE_PATH file descriptor is passed in from the outside,
I feel like the "you cannot use this to create a path" is kind of a
fundamentally nonsensical rule.

IOW, whoever is passing that FMODE_PATH file descriptor around must
have actually thought about it, and must have opened it with O_PATH,
and it isn't useful for anything else than as a starting point for a
path lookup.

So while I don't think the __O_TMPFILE exception would necessarily be
wrong per se, I am afraid that it would result in people writing
convenient code that "appears to work" in testing, but then fails when
run in an environment where the directory is mounted over NFS (or any
other filesystem that doesn't do ->tmpfile()).

I am certainly open to be convinced otherwise, but I really think that
the real pattern to aim for should just be "look, I opened the file
myself, then filled in the detail, and now I'm doing a linkat() to
expose it" and that the real protection issue should be that "my
credentials are the same for open and linkat".

The other rules (ie the capability check or the FMODE_PATH case) would
be literally about situations where you *want* to pass things around
between protection domains.

In that context, the ns_capable() and the FMODE_PATH check make sense to me.

In contrast, the __O_TMPFILE check just feels like a random detail.

Hmm?

Anyway, end result of that is that this is what that part of the patch
looks like for me right now:

+               if (flags & LOOKUP_DFD_MATCH_CREDS) {
+                       const struct cred *cred = f.file->f_cred;
+                       if (!(f.file->f_mode & FMODE_PATH) &&
+                           cred != current_cred() &&
+                           !ns_capable(cred->user_ns, CAP_DAC_READ_SEARCH)) {
+                               fdput(f);
+                               return ERR_PTR(-ENOENT);
+                       }
+               }

and that _seems_ sensible to me.

But yes, this all has been something that we have failed to do right
for at least a quarter of a century so far, so this needs a *lot* of
thought, even if the patch itself is rather small and looks relatively
obvious.

                 Linus

