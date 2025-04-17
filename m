Return-Path: <linux-fsdevel+bounces-46618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C5AA917D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DA71908051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A70225A59;
	Thu, 17 Apr 2025 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VoAMAcYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4A224AED;
	Thu, 17 Apr 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882154; cv=none; b=ZZ+WU4kfAO+zZPc9L03munp5QYjr8ZOOSzKrA7HaoxNnI6v6HfyQEAFg/vK+B0CqCpM+THv4Higd/oHV0INex+Hy2KMunLqZNHKya8WkjW9BocX8ydOgonBp9IZQulWzkDnsQ0L+AYIZMtX7Ycxu2K7wRzrdslChHFi01Zj6E9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882154; c=relaxed/simple;
	bh=2DFcsFNzl2S6Me64gYjtZHI/GwLINDHoZ8edIdvtmyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RM9BQi7IoZHOUeTxZ1zH2IwanDelRQ4MAqyyaUfToA/4hVF6ylxQUnnUqR/XeP6yaLlqtTlHMVnWQ6WtFBAiFdO5i9gMFyQ9KGcoC3gneS81pC6l1V/naCHUSxJKGgUR1wVlSxXzUwg8oXxZVSQJRaAaxElPdSH+xPwW2OcQ5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VoAMAcYm; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SvUVX909fJIOTLyMUYrznFRGmURRPlli4sRzVXUeF4s=; t=1744882152; x=1745486952; 
	b=VoAMAcYmV0TOOW3hCUafU/ztiyWmghU9eb8NrVcuql/ywW2nX+K2RhILvCAXNb7mLZbxMhwyRyi
	a5In3XzEY+YWudFwzU5p2i6CEfNEYeNRpgoTnDaEJ8GjB1MC1tnuBdYytYVKLQF/5cLTU5xLKjyvQ
	OHySk5f1JcnXaLd9e8vl7TcAXPyP0O0r7EEhCJ/TsR+3ANsXlt4qviJGEGkTk1Fj0cbvWpgAf4aF7
	kQ2PC5Y9xvt2numLOpvnA2PwjgqsMnULOwtR0AYUjACTRWFYvXnrkRvwgVG+pCv7wFfkjd6q2GnQE
	Nn7BBByduqgo4x+jdPQBrBtR3spbSTeZVfgA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u5LYR-00000002p89-2PZK; Thu, 17 Apr 2025 11:29:07 +0200
Received: from ip1f11bac0.dynamic.kabel-deutschland.de ([31.17.186.192] helo=[192.168.178.82])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u5LYR-00000001BXm-1Uhh; Thu, 17 Apr 2025 11:29:07 +0200
Message-ID: <0e27414d94d981d4eee45b09caf329fa66084cd3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "djwong@kernel.org"
	 <djwong@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>
Cc: "jack@suse.com" <jack@suse.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "dsterba@suse.cz" <dsterba@suse.cz>, 
 "sandeen@redhat.com"
	 <sandeen@redhat.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org"
	 <torvalds@linux-foundation.org>, "viro@zeniv.linux.org.uk"
	 <viro@zeniv.linux.org.uk>, "willy@infradead.org" <willy@infradead.org>, 
 "josef@toxicpanda.com"
	 <josef@toxicpanda.com>
Date: Thu, 17 Apr 2025 11:29:06 +0200
In-Reply-To: <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
		 <20250415144907.GB25659@frogsfrogsfrogs>
		 <20250416-willen-wachhalten-55a798e41fd2@brauner>
		 <20250416150604.GB25700@frogsfrogsfrogs>
	 <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Viacheslav,

On Wed, 2025-04-16 at 17:56 +0000, Viacheslav Dubeyko wrote:
> I contributed to HFS+ file system driver more than 10 years ago. And I wa=
s
> completely discouraged because nobody maintained the HFS+ code base. But =
I would
> prefer to see the HFS+ in kernel tree instead of complete removal. As far=
 as I
> can see, we are still receiving some patches for HFS/HFS+ code base. Nowa=
days, I
> am mostly busy with CephFS and SSDFS file systems. But if we need more
> systematic activity on HFS/HFS+, then I can find some time for HFS/HFS+ t=
esting,
> bug fix, and pathes review. I am not sure that I would have enough time f=
or HFS+
> active development. But is it really that nobody would like to be the mai=
ntainer
> of HFS/HFS+? Have we asked the contributors and reviewers of HFS/HFS+?

If you're willing to step up as a maintainer, I would be happy to assist yo=
u by
testing and reviewing patches. I have PowerMacs available for testing and i=
t's
also possible to just install Debian's 32-bit and 64-bit PowerPC on an emul=
ated
PowerMac on QEMU using the "mac99" machine types to test booting from an HF=
S/HFS+
partition [1].

I am Debian's primary maintainer of these PowerPC ports in Debian (not to b=
e confused
with the little-endian PowerPC port) and I can also easily build various te=
st images
if needed.

Please let me know if you're interested in working together on the HFS/HFS+=
 driver.

Adrian

> [1] https://cdimage.debian.org/cdimage/ports/snapshots/2025-04-01/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

