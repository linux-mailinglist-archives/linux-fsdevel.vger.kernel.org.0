Return-Path: <linux-fsdevel+bounces-15961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633B896276
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE14B233A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930A18E02;
	Wed,  3 Apr 2024 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NE1z1d65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448C17BA9
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110876; cv=none; b=KKUf/GtSMgfKLfMOD6jBpvN7sWPuhJRZoyK1l4Bqlwztqd3Xwe8+rSaJpQeUcDEtikq6v2co4yqwybLe63Pj4OJl7QaGuEcIOz+Hh6d20Tjz2zf/+ntdZj0xH56KKsGeDgMsIIOPJdUcAptn5omix1WcZWifRNvoLtTosj2tSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110876; c=relaxed/simple;
	bh=L1V2y2GXYltLjaiMkhGOV5y2Z7ue7LSWprWVpxmLNUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o71M13vJn5NvqQkWOfTWVE39oMNPkenL6h46bhNctM3ASku6ecp3k/DbSNFNN2045eKzTCkQICK7jRj4beXENHMKLXy4WAvwszrN9yWj3KiPWq2H6DIRMNaQpXUrhfwgKdd6wTNCMRloXdUqN1Jx0aBOqSYrPOSrNUb4Qz6k9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NE1z1d65; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6154a1812ffso7045317b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712110873; x=1712715673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g330QbZKpmXoovT0mI5FxZrknOF9KuBu/XS6jFcDi0E=;
        b=NE1z1d65GZjWLzAWpw9GLR57HhKUbNQaIqE9BmN9PpDH41sXw4iLKTjwQ3+6U2TH0X
         twhVVFEa8GeXhSykc6Ht8Qeq9KKbADBHIvgmnwlKTTONLloCu54C25MFlNQPM4SRm4k8
         6zfhREgTelHcZi2j0yEbOxsRAZcBYfeKAhYvXYIaexh+kHepIxp9Nzr32N07BgfvVD0F
         0gMUV7l9606UUw0Rmyq/xb1/tpNaiA0A8SfwlIpPPIZaYiKoyvq6oeh7Rim3cByBEZEv
         Y3r0mqo+mou2DACaO83ZKg/ATPsbzVHFxkY/uNKoKFXcdqoAo3sJYvk7h0XsAtXIItvW
         GkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712110873; x=1712715673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g330QbZKpmXoovT0mI5FxZrknOF9KuBu/XS6jFcDi0E=;
        b=rCAYvw93BsOFbAGULaNu+wX/j90O4Yq2bwKA/C1gISgMxtMIrI5NBwrRXA3SL0dgaZ
         XDluiZCult6ftuwA1P5VZUqN+nmnHsdhXr2bhf+MPwkiHrN7X43tl0buMv6tdlzXeCEr
         /ZM57W2O++jALv3w6bBe+CaLyAhanqprg51pj/HA1FLiVTOpPGCUewOLUSztku+vBuCD
         kaMjLdWyKaB+tWH159hLMUeWFUnlJFHEwvkV+sBBeP/AHdNppjZ4NTN7t54poA1njVvs
         eUGWnr0MWydGhv9rbHnxiPP4rdM3VSU7VD0wJ6WRuZRg6UNbtCQzsP+8FFCxMh2BBOUw
         0SLw==
X-Forwarded-Encrypted: i=1; AJvYcCWBxy4RJoocHrE3lt1fYcvHS5feWgzEhU9PbW7KKOn5HzZHi2nu/7WB9UtmXpVaObA9nXoRhsvN00IL6djqYyxsLk7zQ5EjvmDg4fdSaw==
X-Gm-Message-State: AOJu0YwB816D98VZS/Yz46lqfa66eqQfkPHETtHeU+fzYAn+fyIrSfCw
	IPcKCmFw8swW+xhFuszOoZi5TJ20ypazWONlb6NpLTUwOk1uEmIz2dQKBIGCMBws9mbg4iFrpgx
	LjdsORm4WPNQ1QiJE+lvc5YC3hf0dMeszbfaZ
X-Google-Smtp-Source: AGHT+IFMAaM/T+rULGSdsw6XpiNNlLErpHDat07KwGjIkb/LEfK/zW/nRiktUc706dGm/V+2QhXWLe/mDCZv5OD0GAQ=
X-Received: by 2002:a81:6d09:0:b0:615:2603:7efd with SMTP id
 i9-20020a816d09000000b0061526037efdmr3631139ywc.8.1712110873474; Tue, 02 Apr
 2024 19:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
 <20240402210035.GI538574@ZenIV> <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
 <20240402224230.GJ538574@ZenIV>
In-Reply-To: <20240402224230.GJ538574@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 22:21:02 -0400
Message-ID: <CAHC9VhQH6Mxm06NrYacrMC5pUogv6f8jXeqZFYr4r4izot1pHA@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 6:42=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Tue, Apr 02, 2024 at 05:36:30PM -0400, Paul Moore wrote:
>
> > >         1) location of that hook is wrong.  It's really "how do we ca=
tch
> > > file creation that does not come through open() - yes, you can use
> > > mknod(2) for that".  It should've been after the call of vfs_create()=
,
> > > not the entire switch.  LSM folks have a disturbing fondness of inser=
ting
> > > hooks in various places, but IMO this one has no business being where
> > > they'd placed it.
> >
> > I know it's everyone's favorite hobby to bash the LSM and LSM devs,
> > but it's important to note that we don't add hooks without working
> > with the associated subsystem devs to get approval.  In the cases
> > where we don't get an explicit ACK, there is an on-list approval, or
> > several ignored on-list attempts over weeks/months/years.  We want to
> > be good neighbors.
> >
> > Roberto's original patch which converted from the IMA/EVM hook to the
> > LSM hook was ACK'd by the VFS folks.
> >
> > Regardless, Roberto if it isn't obvious by now, just move the hook
> > back to where it was prior to v6.9-rc1.
>
> The root cause is in the too vague documentation - it's very easy to
> misread as "->mknod() must call d_instantiate()", so the authors of
> that patchset and reviewers of the same had missed the subtlety
> involved.  No arguments about that.
>
> Unkind comments about the LSM folks' tendency to shove hooks in
> places where they make no sense had been brought by many things,
> the most recent instance being this:
>         However, I thought, since we were promoting it as an LSM hook,
>         we should be as generic possible, and support more usages than
>         what was needed for IMA.
> (https://lore.kernel.org/all/3441a4a1140944f5b418b70f557bca72@huawei.com/=
)
>
> I'm not blaming Roberto - that really seems to be the general attitude
> around LSM;  I've seen a _lot_ of "it doesn't matter if it makes any sens=
e,
> somebody might figure out some use for the data we have at that point in
> control flow, eventually if not now" kind of responses over the years.
> IME asking what this or that hook is for and what it expects from the obj=
ects
> passed to it gets treated as invalid question.

It's rather common for subsystems to push back on the number LSM
hooks, which ends up resulting in patterns where LSM hooks are placed
in as wide a scope as possible both to satisfy the requirements of the
individual subsystems as well as the LSM's requirements on coverage.
Clearly documenting hooks, their inputs, return values, constraints,
etc. is important and we need to have those discussions as part of the
hook.  This is a big part of why we CC the subsystems when adding new
hooks and why I make sure we get an ACK or some other approval for a
subsystem maintainer before we merge a new hook.  Is the system
perfect, no, clearly not, but I don't believe it is for a lack of
trying or any ill intent on the part of the LSM devs.  We recently
restored the LSM hook comment blocks in security/security.c (long
story), I would gladly welcome any comments/edits/suggestions you, or
anyone else may have, about the docs there - I will be the first to
admit those docs have rotted quite a bit (once again, long story).  If
you have corrections, notes, or constraints that should be added
please let me know and/or send patches.  Similarly, if you're aware of
any hooks which are ill advised and/or poorly placed, let us know so
we can work together to fix things.

I'm serious Al.  These aren't just words in an email.  I realize you
don't have a lot of free cycles, but if you do have feedback on any of
those things above, I'm listening.

I *really* want to see better collaboration between various subsystems
and the LSMs; that's part of why I get annoyed with LSM bashing,
leaving the LSM devs out of security/LSM related threads, etc. it only
helps keep the divide up between the groups which is bad for all of
us.

--=20
paul-moore.com

