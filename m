Return-Path: <linux-fsdevel+bounces-23938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF5935053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278E81C21056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499431459FE;
	Thu, 18 Jul 2024 15:58:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364C14532B;
	Thu, 18 Jul 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318294; cv=none; b=B90cZLtNPL2qZVtE8jPEdKuK6QvDorETqJSOqKrMRy6rhsSD3HNX7rpwor4Mi6kidnkleUcPITxnT6C8/bnf2qD+d4rFULsp+uRXq1b8KDbUwxXwVNevuFj8fzESp9NGUhKscN05XDjRkjazSaW55jJDG+yZP5Ws0JPwT3qwa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318294; c=relaxed/simple;
	bh=e+Mfphj55ScHIRjhyc2GqmrZc3aIc1iAzpaFZ2zbjC0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ZY/uUlOp49ctG6Lf3GfUY89JkgscTlcHEapOxYViGsIE2oDvDAgIGHUeMNmvjbYp5DEu76OgWdpxr1RWsd/N6zxuLxYWYniyibesf+HgdJ9+SP98MLc1SSBbDWn8QK5ElcHiUePDRcnrVPIxV529GOqnU8Ed2J+AstP90upyWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 6483137811CD;
	Thu, 18 Jul 2024 15:58:10 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
 <202407171017.A0930117@keescook> <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
 <202407171520.FD49AE35@keescook> <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Date: Thu, 18 Jul 2024 16:58:10 +0100
Cc: "Kees Cook" <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, "Doug Anderson" <dianders@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Jann Horn" <jannh@google.com>, "Christian Brauner" <brauner@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <11987f-66993b80-1-116be8e0@64320549>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?proc=3A?= add config to block 
 =?utf-8?q?FOLL=5FFORCE?= in mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, July 18, 2024 03:04 EEST, Linus Torvalds <torvalds@linux-f=
oundation.org> wrote:

> On Wed, 17 Jul 2024 at 15:24, Kees Cook <kees@kernel.org> wrote:
> >
> > > In particular, this patch would make it easy to make that
> > > SECURITY=5FPROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE config option be =
a "choice"
> > > where you pick "never, ptrace, always" by just changing the rules=
 in
> > > proc=5Fis=5Fptracing().
> >
> > So the original patch could be reduced to just the single tristate =
option
> > instead of 3 tristates? I think that would be a decent middle groun=
d,
> > and IIUC, will still provide the coverage Chrome OS is looking for[=
1].
>=20
> So here's what I kind of think might be ok.
>=20
> ENTIRELY UNTESTED! This is more of a "look, something like this,
> perhaps" patch than a real one.
>=20
> If somebody tests this, and it is ok for Chrome OS, you can consider
> this signed-off-on, but only with actual testing. I might have gotten
> something hroribly wrong.

Thanks for the patch!

I tested it on ChromeOS and it does what it intends, just with two
minor fixes applied:

--- a/security/Kconfig
+++ b/security/Kconfig
-config CONFIG=5FPROC=5FMEM=5FFORCE=5FPTRACE
+config PROC=5FMEM=5FFORCE=5FPTRACE
.....
 -config CONFIG=5FPROC=5FMEM=5FNO=5FFORCE
+config PROC=5FMEM=5FNO=5FFORCE

As Kees suggested, I'll add a bootparam with a simple =5F=5Fro=5Fafter=5F=
init
variable to select this and then send a v2 for review.


