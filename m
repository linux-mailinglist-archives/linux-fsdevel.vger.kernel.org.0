Return-Path: <linux-fsdevel+bounces-46568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D5A90750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5215444C29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A71FC7D2;
	Wed, 16 Apr 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPoEO2aE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319851FCF78
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815890; cv=none; b=BhB+cL/Hkrxh33Y6eiaZHBsOFF2fFu8PwulOu5rulMTr2MSsRDlZjJJ1C8/WtzJwZlwNUyxoCft8IgLQQ2tD0CLN5AeNIv7vBkbvi0i12ofGHnk4SKxNEAYMT1dWZI8TOY7AM0x+oYneIK+4Rdl8pz0xz21iXfu8LdKjz7UDP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815890; c=relaxed/simple;
	bh=l/wU5LlCNeXKb1bR4CJxudZaj0MK9M+rTjIXHj/uHHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJBXwaC7ZuguwFGaw8kFjQ0/ZtUfELNJWE7dAi269hM8eTp5DRyl7IsUCf8F6rGV+/gaovpiO1rjXnjbMR4MaY/O8W7Zuk6khvQsBfnE6QbKjJdaFuxsjzdMCsfc5ZoQRmW0zDX767130iRFN6vaN3NdLEzFx2qBBQbfXfeUFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPoEO2aE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so10177981a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744815886; x=1745420686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mALff3rdEiTI8CPpBrO1EEpr4Q3mHrpmiRhWlQ+Az+4=;
        b=PPoEO2aE7jqMnrE+MufL8FUwB5F2cXsR7jifU2EN13MuZrKC14ru5gyQ43bIDQjmFQ
         qqh5mr98Lq5YVsWQQ66XJSfXAii1zhw9s2fiY72PrN/npI6KQ7Vtwu1C35vTGwgPuRfp
         LTDFXcVN2IO23+7JWcXkNgf92XoAFeNdTm7Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815886; x=1745420686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mALff3rdEiTI8CPpBrO1EEpr4Q3mHrpmiRhWlQ+Az+4=;
        b=WQzu+nTfoyvCFc9Lm2r500pe3JUBEV1K0gRpWZg1jJTMD/98XK4rw6ZQahw6/0+3cy
         OwnAyVWMz463AR2klCpkV/Fk+eTYvPx/4JT8DHIeTjmOhzHFG0KYCP4TmXiiH1nhzn0E
         LLdjw8JlCJWckODMxOYaKAPqX5Tz5aJ9aHmU/3IKvvGP0o9QvTgzQwLVZJ/tp/pvURGq
         8DfATLW8X+P/+/5NDdwrEWO6jhw5PNtvT/G3QvoeB1HZ8Mb9cWZsdWyhWrKrNrg4OXAg
         U6VUGiodpb4aizMeIOaXKQV0wFgk++U3HHPNoK+tnhgFVn8cPaAMhcMSHVxsh3HWtvYP
         jI/A==
X-Gm-Message-State: AOJu0Yz/s21yQZ26/ji82P2FacZTG7RPc6NIR5yJ+qsmsk296sV0o8As
	SNNUnKi6Ie0oJo6HXt5P+UKeFWqhXmDpnFZ3zEkgslwhNeHQy0wZr8tIHdw1IgFTZCednF/vpk4
	XZ9A=
X-Gm-Gg: ASbGncuz1RpiSuqksndalf9GHPSiKj6oJFfdfofSM/trfmrGa35xy/65bSpB3Ccsin/
	GkZ+EQRzRi2SPGFsrAY8fm6f5CXVmSrvH3jPma/MrVC2v3dj4AeerzS/hFGRfs+Lb9HHw37qzPR
	4FPcyWpUE4Cw70SvuRBFB8m+bLvv++phpbHRxix02gj4Jb40xqct23UgJYd6xDsLBvqjz423j+z
	iD4bvYwKnEOI4VWYDtzf7OLsg0nxMoojR+YufprVp/nC0L79geH5lSZRgeTwV/ytPsqYJFQjPR9
	hNaD8FhzuSxrA91rONfxTwvOAIR7ZcMz3ojshZYJlvU37I4bu9LWH2HL0Bo34r1+bQeYlVIL/hS
	PQ7xOn9wCcZgNEUM=
X-Google-Smtp-Source: AGHT+IHSKhryNtreiAhXB6H2/j8pmGs20P9FUOc6YhCSLXmOi5KwgnpnJ2sIkT5lOSOpOI3v6mEiRw==
X-Received: by 2002:a05:6402:350f:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5f4b731cda6mr2271720a12.11.1744815885569;
        Wed, 16 Apr 2025 08:04:45 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f068a5asm8565955a12.34.2025.04.16.08.04.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:04:44 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc0b5so5181634f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 08:04:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4310:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-39ee5bada8dmr1866584f8f.55.1744815883835; Wed, 16 Apr 2025
 08:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org> <20250416-work-mnt_idmap-s_user_ns-v1-3-273bef3a61ec@kernel.org>
In-Reply-To: <20250416-work-mnt_idmap-s_user_ns-v1-3-273bef3a61ec@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Apr 2025 08:04:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt5Lw7q_VAHgEC+HT4d5iJos6_shnyOnNBQeT0qrJSXw@mail.gmail.com>
X-Gm-Features: ATxdqUE5Ea_O70qWm1hojvGX4BwnFV_hF6IiKNOOQmXbk3HBLCQRu-d7_qVWAXg
Message-ID: <CAHk-=wgt5Lw7q_VAHgEC+HT4d5iJos6_shnyOnNBQeT0qrJSXw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mnt_idmapping: inline all low-level helpers
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
>
> Let's inline all low-level helpers and use likely()/unlikely() to help
> the compiler along.

Hmm. This looks like it might be a mistake - code generation will
probably not be great, because you still end up calling a real
function for some of the cases (ie from_kuid() in the actual real
translation case), so all the register allocation etc issues with
having a function call largely do remain.

Yes, it inlines things into generic_permission(), and that will avoid
the function call overhead for the common case (good), but it also
does make for bigger code generation. And it doesn't actually *change*
the code - it ends up doing all the same accesses, just the
instruction flow is slightly different.

So I think you'd actually be better off with *just* the IOP_USERNS
patch, and only inlining *that* fast-path case, and keep the other
cases out-of-line.

IOW - instead of only checking IOP_USERNS only in i_user_ns() and
making it return 'init_user_ns' without doing the pointer following, I
think you should make just our *existing* inlined i_uid_into_vfsuid()
helper be the minimal inlined wrapper around just the IOP_USERNS
logic.

Because right now the problem with i_uid_into_vfsuid() is two-fold

 - it does that pointer chasing by calling i_user_ns(inode)

 - it then calls make_vfsuid() which does lots of pointless extra work
in the common case

and I think both should be fixed.

Btw, make_vfsuid() itself is kind of odd. It does:

        if (idmap == &nop_mnt_idmap)
                return VFSUIDT_INIT(kuid);
        if (idmap == &invalid_mnt_idmap)
                return INVALID_VFSUID;
        if (initial_idmapping(fs_userns))
                uid = __kuid_val(kuid);
        else
                uid = from_kuid(fs_userns, kuid);
        if (uid == (uid_t)-1)
                return INVALID_VFSUID;
        return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));

and honestly, that looks just horrendous for the actual simple cases.
I think it's a historical accident, but the

                return VFSUIDT_INIT(kuid);

and the

                uid = __kuid_val(kuid);
        ....
        return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));

things are actually the same exact "no mapping" code for the case we
care about most. We shouldn't even do that

        if (uid == (uid_t)-1)
                return INVALID_VFSUID;

case at all for that case, because the no-mapping situation is that
INVALID_VFSUID *is* (uid_t)-1, so all of this is entirely pointless.

So I think the inlined fast-case should be that

        if (idmap == &nop_mnt_idmap || initial_idmapping(fs_userns))
                return VFSUIDT_INIT(kuid);

code, and then the 'initial_idmapping()' thing should check the
IOP_USERNS bit explicitly, and never use the i_user_ns() helper at all
etc.

That case should then be "likely()", and the rest can remain out-of-line.

IOW: instead of inlining all the helpers, just make the *one* helper
that we already have (and is already a trivial inline function) be
much more targeted, and make that fast-case much more explicit.

Hmm?

                   Linus

