Return-Path: <linux-fsdevel+bounces-8582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75139839113
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3EC28B4DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8C5FBA6;
	Tue, 23 Jan 2024 14:14:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680D605C9;
	Tue, 23 Jan 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019275; cv=none; b=UKerg12Ywsb3ZQAW/TyL/tJlfGFmR1G2K+Rw60keDc6lbyIEhORNxwiI9yMtYxkikP7yDAbrgGVby5vKI4GVpz2LfJRxO0x+YH7g9ycIOlXTN5i+Dms12o5mzNWTwZJMdrCfqYClZbOZyox0ieNWKOKQQDYIY0kDEJrJJgHUpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019275; c=relaxed/simple;
	bh=aLNrXaxt98R5cd0HEJoYciC+5vGvHwIt2upVpsfT5Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmXU6sfb4LbGJW6NEVH+Y4khsCQtovcuVrjnoKsWvqFweD/00R8NYD2hhDLeixoT9pOqP0Rj4ChT4JO9+YUKYV5K5IfZrAsqKVFmmlna896jpO042/rZl/DWhm2buj3PYOywZzUY8rJ1KvlJhWwhrgZrQSC8p003+Sj387Moqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rSHXV-0006I0-Hz; Tue, 23 Jan 2024 15:14:09 +0100
Received: from p5dc556fd.dip0.t-ipconnect.de ([93.197.86.253] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rSHXV-0046LF-9X; Tue, 23 Jan 2024 15:14:09 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1rSHXU-00Fl8i-2t;
	Tue, 23 Jan 2024 15:14:08 +0100
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
	inux-sh@vger.kernel.org
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Date: Tue, 23 Jan 2024 15:14:08 +0100
Message-Id: <20240123141408.3756120-1-glaubitz@physik.fu-berlin.de>
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

