Return-Path: <linux-fsdevel+bounces-24686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38944942FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E26B2725A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D01B3721;
	Wed, 31 Jul 2024 13:15:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC019F49A;
	Wed, 31 Jul 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431759; cv=none; b=OuTRag9VkCTpdVGMw6Jxf319NrhXrFHdDW3eTprWoBsPOt1ObIyDR+9tlwEOjua6+d5k74MPvJm7lF/SPa2ZOvCRqNdkfDR8EPcDV/asIb+oY432mmgKrF53X2IW8FRgFEiHYnihoqinW6dT2oZA+qrlkIjSBXz3MZLW7SyF9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431759; c=relaxed/simple;
	bh=70RynTUJwC73RJmo/iFM7wHnQJcJm+PmYG2ZRhXGh/M=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=NqzyFZEoetFIV6DMa0t42QOOkG3zvtI4m8SAmAFCe5VKOV9kRRHYG3b9MJ87YQRDb2utTN1B6jNpRl7Hm7tU+to8gGC4Q4DXORyISuEJrBbZz58X4vEHFqPWcl6uM8/UbuRSU9+3bSP8JqQQcTzboDRlc5uCkFPceLdkK8MoW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id BF53537821CA;
	Wed, 31 Jul 2024 13:15:54 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com> <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Date: Wed, 31 Jul 2024 14:15:54 +0100
Cc: "Jeff Xu" <jeffxu@google.com>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Kees Cook" <kees@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Christian Brauner" <brauner@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3ea8c0-66aa3900-3-2bfd8e00@3451942>
Subject: =?utf-8?q?Re=3A?= [PATCH v4] =?utf-8?q?proc=3A?= add config & param to 
 block forcing mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 31, 2024 02:18 EEST, Linus Torvalds <torvalds@linux-=
foundation.org> wrote:

> On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
> >
> > > +               task =3D get=5Fproc=5Ftask(file=5Finode(file));
> > > +               if (task) {
> > > +                       ptrace=5Factive =3D task->ptrace && task-=
>mm =3D=3D mm && task->parent =3D=3D current;
> >
> > Do we need to call "read=5Flock(&tasklist=5Flock);" ?
> > see comments in ptrace=5Fcheck=5Fattach() of  kernel/ptrace.c
>=20
> Well, technically I guess the tasklist=5Flock should be taken.
>=20
> Practically speaking, maybe just using READ=5FONCE() for these fields
> would really be sufficient.
>=20
> Yes, it could "race" with the task exiting or just detaching, but the
> logic would basically be "at one point we were tracing it", and since
> this fundamentally a "one-point" situation (with the actual =5Faccess=
es=5F
> happening later anyway), logically that should be sufficient.
>=20
> I mean - none of this is about "permissions" per se. We actually did
> the proper *permission* check at open() time regardless of all this
> code. This is more of a further tightening of the rules (ie it has
> gone from "are we allowed to ptrace" to "are we actually actively
> ptracing".
>=20
> I suspect that the main difference between the two situations is
> probably (a) one extra step required and (b) whatever extra system
> call security things people might have which may disable an actual
> ptrace() or whatever..

Either approach is fine with me.

Will leave v4 a few days longer in case others have a stronger
opinion or to gather & address more feedback.

If no one objects by then, I'll send v5 with READ=5FONCE().


