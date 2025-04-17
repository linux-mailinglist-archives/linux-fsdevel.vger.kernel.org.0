Return-Path: <linux-fsdevel+bounces-46616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B4A91737
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC87AA5D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276102222C1;
	Thu, 17 Apr 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZyZ432YF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992E320F;
	Thu, 17 Apr 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880641; cv=none; b=pe2HG/S7e1ARmb/zC6nfPAMeVSDR8HJOlIK7kHPTF/qAZ70vrqkYwBNokkHpEyYq296XxhAMxS1k2POBhCv94YVF2ux1jgdzyqXyggARo8FzC4E8gQBuWxmtPmAtva/vyxZukORxy7eKgXMvCcu+AejDuyxNEZD/KDufYW+AiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880641; c=relaxed/simple;
	bh=7MMNhztDV8UGTuOPRC7v8gW6Lz4xX15N+7tLV2xsNdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nh5Q5JkNHDWmQaT3PcRhpqnkim+Hc5B7KAYKOepJvuXP/puPn4Vi8wGwKuEUGpMfFsenQdWtADspzaZFxLPUwoUk+ZmwAtgODbjV62EKgy880Po3s8da10ELs6GEd8Yak+n9iZ5SW2TrpD3Q8PCvQkt7d3G6Ot/WdAuP386DNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZyZ432YF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ncoo+8tS1G2HLx7lql71IkSO6kq6VOzIS3CcwjeAEHM=; t=1744880638; x=1745485438; 
	b=ZyZ432YFMGAGk5M7qSEAWFavIASRSprCswLaiYZV4A2d29n/DDoW58hyzJVI7TeTKR9yPJr4eX1
	yolZ/g9EJN0tDsk0IgolyIgO4H15Nrc2UVUtyymCdBb19iLDq0clGqODqNImRjMEWg1wFKLKJjzNT
	Znn1dn5/vlORBw9/7lzY3jS412/g4M70w6+U08PMV3BWS0BIsqMlirDu72mTN5VrJ4gJw3QNgOrJq
	FlpctjUsnlRJ7Xut30e3awmBj8xUw18MEA10kpFsmnfJIME9S1FiVAEY/XCIIg+KSayseclqIkhCa
	9C2FJmHejtDSYBEIiX1ENWG9WTAEiwafZSug==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u5L67-00000002a4q-3Xu3; Thu, 17 Apr 2025 10:59:51 +0200
Received: from ip1f11bac0.dynamic.kabel-deutschland.de ([31.17.186.192] helo=[192.168.178.82])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u5L67-000000015Qt-2f1L; Thu, 17 Apr 2025 10:59:51 +0200
Message-ID: <dffbad05874662697a74a4799b61ac068ec17a55.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel
	 <linux-fsdevel@vger.kernel.org>
Cc: David Sterba <dsterba@suse.cz>, Linus Torvalds	
 <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara	 <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Josef Bacik	
 <josef@toxicpanda.com>, Sandeen <sandeen@redhat.com>, linux-kernel	
 <linux-kernel@vger.kernel.org>
Date: Thu, 17 Apr 2025 10:59:50 +0200
In-Reply-To: <20250415-orchester-robben-2be52e119ee4@brauner>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
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

Hello Christian,

On Tue, 2025-04-15 at 09:51 +0200, Christian Brauner wrote:
> Both the hfs and hfsplus filesystem have been orphaned since at least
> 2014, i.e., over 10 years. It's time to remove them from the kernel as
> they're exhibiting more and more issues and no one is stepping up to
> fixing them.

I might be willing to take over maintainership as we definitely need this
driver to stay for Debian Ports as otherwise we won't be able to boot
PowerMacs using GRUB.

Developers on the grub-devel mailing list might be interested in this
discussion as well as GRUB won't be usable anymore on PowerMacs with
HFS/HFS+ being removed from the kernel.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

