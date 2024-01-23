Return-Path: <linux-fsdevel+bounces-8583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E6283911C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FE11F2AB00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA05FEEB;
	Tue, 23 Jan 2024 14:14:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896495FDBE;
	Tue, 23 Jan 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019284; cv=none; b=CSNTui5m4GWyNjFUr+aCXJMmkrRpXpTHz7WvW3tLMvoDEj1V5RBtUv5kPh+5UXxwemeN3T4VWPj+XdCoOmh5EQtkWBs0uw45bAkIrd0dbn70XheTdD6ss8rNtSJx4l29EIRn39S4V+RSW98qliZfNOx0kO3w0WXqhqo3Yg10xWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019284; c=relaxed/simple;
	bh=aLNrXaxt98R5cd0HEJoYciC+5vGvHwIt2upVpsfT5Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzvUGaJcv+Su1TtXZ1G6rNtBo1VYlKUOvWZnQoXv+JFzV7EekstjdTyz0IlmRLWn2epPJbouSNyx4/aGL5jS1f5tsPmMIH6NRNHT8r7ukqV5AKKh4NdGGSf9CMUUOjog5G3EHz1GdSQ95kO3XynWOrCqlh01y7F8gezRZIIJc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rSHXh-0006LC-Mw; Tue, 23 Jan 2024 15:14:21 +0100
Received: from p5dc556fd.dip0.t-ipconnect.de ([93.197.86.253] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rSHXh-0046MI-Cp; Tue, 23 Jan 2024 15:14:21 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1rSHXg-00Fl8w-2i;
	Tue, 23 Jan 2024 15:14:20 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: linux@roeck-us.net
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	christian@brauner.io,
	dhowells@redhat.com,
	fweimer@redhat.com,
	kzak@redhat.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mattlloydhouse@gmail.com,
	mszeredi@redhat.com,
	raven@themaw.net,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Date: Tue, 23 Jan 2024 15:14:20 +0100
Message-Id: <20240123141420.3756134-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
References: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Guenter,

> with this patch in the tree, all sh4 builds fail with ICE.
> 
> during RTL pass: final
> In file included from fs/namespace.c:11:
> fs/namespace.c: In function '__se_sys_listmount':
> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
> 
> I tested with gcc 8.2, 11.3, 11.4, and 12.3. The compiler version
> does not make a difference. Has anyone else seen the same problem ?
> If so, any idea what to do about it ?

I'm not seeing any problems building the SH kernel except some -Werror=missing-prototypes warnings.

I'm using gcc 11.1 from here [1].

Adrian

PS: Please always CC linux-sh and the SH maintainers when reporting issues.

> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

