Return-Path: <linux-fsdevel+bounces-60751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44858B51369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D751647B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53C24A063;
	Wed, 10 Sep 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Kq3x7uyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7E249EB;
	Wed, 10 Sep 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498579; cv=none; b=VitwdE6nPcgMjZ2tESHOfFp2Ry090N23jgjcrMIwEVSPvDrEgTmJSC3JMmZKhtO1P8LtjSllu/aXYP0IU6sp5tZIy7v/XxWcLsKYNinjMR4QHjmffJ10pW2BZ2x2XpjrUgbdfCBq9R6j+BdlrwfcYsR0yIQ2fjDisM9rPaGv9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498579; c=relaxed/simple;
	bh=NS1RBOToMJVpQqF/WmkSSABFW6L/EslGweafLCX2T9E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aHyOkzLWE6UBwz2WDoPp7Q3kwQa52J5hpdBxwQ+SY2B8K/k3qcJ6teevt9jEdb6nsdWd4JklYql2flNC7wzvUl9iaZNxMxbylHq+RKcMkOHqVAx4H791jsxUxLwI2FR2HQJRY49IXekVe3UVHldAaZfAqXMFoOWm0PAMFqKJauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Kq3x7uyL; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757498268; bh=mt3Kh9n3e4acIRUA6Q9kpMAPaVhtNMPtVs5KLOpj7RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kq3x7uyLxWAe/zVmo4XmOtY4cjHjgySxS4AtAR0gN6KwBaYRvp0hqsfNwoB+rPIA4
	 IslLR0lb4mTlZN3LmjOTxnVUWuPR7kh79LIqvasHMDojQmUJHFsnM/WcDJKGRQ5mqu
	 arjsjpYSiyfeubq3LR3ifzu7Mdf4/+gTxvK5krxk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id E6DA6CDB; Wed, 10 Sep 2025 17:57:45 +0800
X-QQ-mid: xmsmtpt1757498265tivd50rii
Message-ID: <tencent_1E3DB937EA968236C64B76757376BD675E09@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQRTzbvI03jwAOfWI1rUoT/nS6vZTYAlxJd8hAfHacQ1p9efAxG6
	 u6PZhnhpPlEJufd1iSVwLRvseAE95Dclryq4ba/KDyFf/H4/4KVLsYKiFl60ccQ8sJ30QxRzfR6l
	 S7VGqptj4+jz/0cMXBVIs0pF9RTgBvFILtNH3IsAW3aVEq5VoMSPpZj+vX6hVCcfH0dJYIXPXAfR
	 cvVubJ506bFMKn82jf4911DUyAJwIMv6QCmVPRh3k6LF2fkk1SwKxOWHclFpn51kVnSUWtnpHXkE
	 z5nMa62HYFSpNNvYdeIWbnzcsUWJJOYO5DHXlP3WUGF9+f5gGw8huWCVVBvjfBmnwTzRAXc1dBkv
	 30c5rdNYSHzaeKtW0ogeUip41aqMvgHuVo8GfHE1YUOa8qNagbhvfnhrWQ1xKMCFemMUWOH3eNG3
	 6YOjVkPEPwQGn/iNr5bjpkQQCLjXlkSjL3fs/jYweVWHJXB+VULiJfPegnmfpS4ojMJCGMTurDcX
	 pAt+QNhkzZdWzIvVm7URkgLbUQ8NquRPA6GVTeSB0pr3NZBIV6nZtiEi1FOBh/OdmNGzwvDGL9pk
	 8frB4vfrbm7fuHUIYBcdWCqmNWnJ/kqk/qF3fWSPkrh0/noXtJI7M3PEIwC+XhdrosNsL7MMul7Y
	 MehEV94RM+N8Qg5UW0/jiFE9Fr0U/HvgJJDqh8po9hLQtEiZfZ04QJ4uSv1pNyC/mtXrRSR67Nk4
	 P1EopDgCdKVxbg2sRsuYSmM33Q4Yd4clQQF/HD94jVkYOf4To/pzbrW2f5r5v4R14pqDCVZXUTvj
	 YBBwlVgHMyY1rzuiLbI/e3GROpDkz+MLF2MWrJEIImKRREqe23kCXEImEXMQRZuWuY9CZlXC/Qfk
	 8c1VG2pky5qVS1C+lvCxuuUHhaMRrNfa6QgGrK/zwBkSLepl3jVLGT6XtyfdwdwwTBd6U1RujIPk
	 bYQwGyyfBJnSElDqsTk87SGRA9TSVQrsvQNSbBHByNnWtnXk8nVtHyGgw/DwACz/9t+YIpI8LwF2
	 KRlZD5sPShvvNd5ap7
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org,
	eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzbot+b6445765657b5855e869@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	hannelotta@gmail.com
Subject: Re: [PATCH] USB: core: remove the move buf action
Date: Wed, 10 Sep 2025 17:57:43 +0800
X-OQ-MSGID: <20250910095742.1639746-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025091007-stricken-relock-ef72@gregkh>
References: <2025091007-stricken-relock-ef72@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 11:00:43 +0200, Greg KH wrote:
> > The buffer size of sysfs is fixed at PAGE_SIZE, and the page offset
> > of the buf parameter of sysfs_emit_at() must be 0, there is no need
> > to manually manage the buf pointer offset.
> >
> > Fixes: 711d41ab4a0e ("usb: core: Use sysfs_emit_at() when showing dynamic IDs")
> > Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
> > Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  drivers/usb/core/driver.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> While this fix looks correct, your cc: list is very odd as this is a
> linux-usb bug, not a driver core issue, right?
> 
> At the least, cc: the person who wrote the offending change?


