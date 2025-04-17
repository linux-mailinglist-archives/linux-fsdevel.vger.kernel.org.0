Return-Path: <linux-fsdevel+bounces-46640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D5A92695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A78A61FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC82566D2;
	Thu, 17 Apr 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KioKXj26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F1253B7B;
	Thu, 17 Apr 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913665; cv=none; b=APquKwyeOmq89tuQsa+R4P4ZNotMO0ryKMs80KoR23h6eL2LpN6gCENbX1AcfDmbdD90dR5SWY41xEiljJuZylMIBfbA+BCXXTg8Mxj2x2UgIZ8gDxIZfbDcj0BD9KTo81laYpq4/EdQrMyuUFyePv+T0wz/eGFF5xcHT+jQoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913665; c=relaxed/simple;
	bh=fD7mh6RqQn7HJVHgVvcpbPHD3vL50VC62XGEwVGvDEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHxpMerV5kVhtia0i/rFUYQorUGLCSQ2fen1ZpHoUCSCJX1ehH+ChNIO7TTKlGPZs267LSffNjNFMFwRdfduq48rQTxizrQ5vn8m8t5yO08IJ2qOmkkuXliippzGoIZiXnG4zAv4zGTaSDVSc+fd5hPBiiEK/ySGIcDjC2x5iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KioKXj26; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pUTQkCl777ybNdacW+wPw7g7Guqx37fpCwdsyJVE9Gk=; t=1744913662; x=1745518462; 
	b=KioKXj26UktkryhbIbbaTIQU7ZjkNnCB+7Q4HCOdID5fDcTbhFW6GE7MeaxAes2s0I1y50Mffs8
	4UU/CjVznXtpHFpMJXD9Jr1HsD6HTZ3D2CI7sySdN1XLZDK5ijUWkTC60Jm4X1SY7Zq9YSiTUv3RY
	tDZOSAB4UJp48qmbBcHQ6Qs4+RNXVl8A99vChJLHsSSJCjXnMyYnIl5jA1w7as6CKHsN4VOrHbKXr
	tHYx0JVR1XR5jXUaf7+SFd1N/ymSlhAyZ/SDRAdmkKXYxwaVjiofAn9laJWJMJOFDFqehxkl3caUh
	29f/HnACdK3NQcoOIxk5yMG/3zAZ8ibTIYjA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u5Tkf-00000002B28-0SPW; Thu, 17 Apr 2025 20:14:17 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop-2.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u5Tke-00000002suZ-3a6W; Thu, 17 Apr 2025 20:14:17 +0200
Message-ID: <1d16c046a5c9e1ee83f1013951d77d9376d8fb64.camel@physik.fu-berlin.de>
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
Date: Thu, 17 Apr 2025 20:14:16 +0200
In-Reply-To: <6fcb2ee90de570908eebaf007a4584fc19f1c630.camel@ibm.com>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
				 <20250415144907.GB25659@frogsfrogsfrogs>
				 <20250416-willen-wachhalten-55a798e41fd2@brauner>
				 <20250416150604.GB25700@frogsfrogsfrogs>
			 <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
		 <0e27414d94d981d4eee45b09caf329fa66084cd3.camel@physik.fu-berlin.de>
	 <6fcb2ee90de570908eebaf007a4584fc19f1c630.camel@ibm.com>
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

Hi Slava,

On Thu, 2025-04-17 at 18:10 +0000, Viacheslav Dubeyko wrote:
> Sounds good! Yes, I am interested in working together on the HFS/HFS+ dri=
ver. :)
> And, yes, I can consider to be the maintainer of HFS/HFS+ driver. We can
> maintain the HFS/HFS+ driver together because two maintainers are better =
than
> one. Especially, if there is the practical need of having HFS/HFS+ driver=
 in
> Linux kernel.

OK, then let's do this together! While I'm already a kernel maintainer (for=
 arch/sh),
I wouldn't call myself an expert on filesystems and I feel way more comfort=
able working
on this when there is a second person around with experience with hacking o=
n filesystems.

Can you send a patch to update MAINTAINERS?

My mail entry would be:

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

