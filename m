Return-Path: <linux-fsdevel+bounces-20223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FC8CFECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85931F229DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A313C830;
	Mon, 27 May 2024 11:21:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED013C699;
	Mon, 27 May 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808875; cv=none; b=dOZ647q54GHxpwtpfxCbN1YIwt5UiQ/ElOPuhXOeu/IU+JGPDyJ0XRqz7/MZZZL5GBPCySYZj55I16jaLwMTCfjxIvJnwyI3k97ldZkHhjOIVeoB+IddqAAOJmEe1pAMi8vFcBSVLK7IdWmTgrUiDV4pwqRKDYq5pH1DoueQobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808875; c=relaxed/simple;
	bh=VbfpEmXuaAG7nWKQNcVSqAIJl4e4QDZ7FZgYw5QlnDI=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=jHO8EKY/oOJDYUfMGyctwtJdW9/JUJ2VWeVKAM/0JdT8YCdbC7T28rtmDAfes0ZhcEVp1pPNcDkeMohzm1PioQQoW+c30BrZKSNhkQ128/qtoNfMLf13Lu/ioOfCvlz4JU+Cyudwu0aq2xdKxfKbkoWUK1em6jh/bO44QdDJxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id C9C2E378143B;
	Mon, 27 May 2024 11:21:10 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <9ce0c222-c80c-4049-8746-d74e612c3030@infradead.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240524192858.3206-1-adrian.ratiu@collabora.com>
 <20240524192858.3206-2-adrian.ratiu@collabora.com> <9ce0c222-c80c-4049-8746-d74e612c3030@infradead.org>
Date: Mon, 27 May 2024 12:21:10 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Kees Cook" <keescook@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Randy Dunlap" <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1cc802-66546c80-1-65440180@177937837>
Subject: =?utf-8?q?Re=3A?= [PATCH v4 2/2] =?utf-8?q?proc=3A?= restrict /proc/pid/mem
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Saturday, May 25, 2024 08:49 EEST, Randy Dunlap <rdunlap@infradead.o=
rg> wrote:

> Hi--
>=20
> On 5/24/24 12:28 PM, Adrian Ratiu wrote:
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 412e76f1575d..0cd73f848b5a 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -183,6 +183,74 @@ config STATIC=5FUSERMODEHELPER=5FPATH
> >  	  If you wish for all usermode helper programs to be disabled,
> >  	  specify an empty string here (i.e. "").
> > =20
> > +menu "Procfs mem restriction options"
> > +
> > +config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FDEFAULT
> > +	bool "Restrict all FOLL=5FFORCE flag usage"
> > +	default n
> > +	help
> > +	  Restrict all FOLL=5FFORCE usage during /proc/*/mem RW.
> > +	  Debuggerg like GDB require using FOLL=5FFORCE for basic
>=20
> 	  Debuggers

Hello and thank you for the feedback!

I'll fix these typos in a v5 together with the kernel test robot failur=
es.

I'll give v4 a bit more time in case other people have more feedback,
so I can address them all in one go.


