Return-Path: <linux-fsdevel+bounces-24290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492993CDC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C953FB22261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 05:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4539AFD;
	Fri, 26 Jul 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j8It8LbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7C1A716
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972502; cv=none; b=FJ8//OK8rrIjccJM34KxNOg0vVSPIQhDpeQr3ijAQMOIn9141sts7AtVTyZaJ7jPn+Q80SUOXsRmyyq5v1Gj7HUh7oFutblTX4BPSnEhQlIkrE3NnfSCj1Sx9qF7K+IfJSxx7tztUI/o6Q9brEKBOAsNMy6+hbsxtafqA+XLgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972502; c=relaxed/simple;
	bh=gZvxlVGFnHm2ArDQBE9emnEK3lVKU1vZJpWBPWnh3mE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UMuiFiTQBt0gqgmxzq5/6SmBwakTnH57Dh0yFwybBrXEvZ8m+LKXMTkVTQ/sUTDjvA9yRPT/vIwQVAo2CgHhyTlfVoJmEYv0G9SvsvD7TwW2ckxf1cNwI5kRRR0syERtqr2P6p2EeDbOeKF5a16PL/UCSzcbBe5QPN8uBTo5l/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j8It8LbL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YY0znSO/DBT1dyYaRktZW1XEP4seS3F1nRRgCuK+rKI=; b=j8It8LbLW4fvrlDpLS6qi79Syo
	Ge5zZbQzeWu7YVJyheZQPgbOsabS70yv0f4Owpg8hHa+Ad3il4az+gpn1kUIePEQZPra6CltWzXFm
	pg87iplCmyKfZXaegw4KWLVQNrznbS5ds1M1vN4HQKPILwyug/MKd6K1SLFVKaq61sR83/Gq23vOH
	Xudm2unkS2fG/nPOR0Y7BDkGmBojs0P2jCIK15y5hrxCuZuv9Iktn0cCaEyOaiPnDKzEGJdVad4OV
	Umqz0ZXi7Hz45NF8O8OGZdaJw+GX3HRmim1zZESlgQh/LeCdA0DXMwIIE98Zuy7anfjYV4/sYzInm
	92tI70jw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXDhy-0000000296j-2bjW;
	Fri, 26 Jul 2024 05:41:38 +0000
Date: Fri, 26 Jul 2024 06:41:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] (very belated) struct file leak fixes
Message-ID: <20240726054138.GC99483@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[sorry, that should've been sent out weeks ago - had been sick lately ;-/]

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to bba1f6758a9ec90c1adac5dcf78f8a15f1bad65b:

  lirc: rc_dev_get_from_fd(): fix file leak (2024-05-30 23:58:26 -0400)

----------------------------------------------------------------
a couple of leaks on failure exits missing fdput()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
      lirc: rc_dev_get_from_fd(): fix file leak

 arch/powerpc/kvm/powerpc.c  | 4 +++-
 drivers/media/rc/lirc_dev.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

