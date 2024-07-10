Return-Path: <linux-fsdevel+bounces-23521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D292DB20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FC228513B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633D1420A8;
	Wed, 10 Jul 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pmRu7gZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D69132113;
	Wed, 10 Jul 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647626; cv=none; b=aGKFI8mFAT+UGgaEKEW78EFW1qzY/Ru+P05ox8d7H8m0SRN2APvT9OBzz5oN+lDYbDs+/oOh1JahfM534l2yHls4xzThTVpA1hjcuS8LeiVQBnGMobFgM7VLekMlCw+rAfslooFdm4mrzElZYi/fYtGdhOGf0H8dVXXB6xuHzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647626; c=relaxed/simple;
	bh=dtNZaFXzPMRLfnec74raV485fSKqF/FDLb+FsiS4fTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mpp68QRutTJJXcB/qXtjPmsWJwwlpFlPIMOf+oiPE5TmbfB3LIAAdVj0Ph4wUX+dxhdSB9FgFePFm1gz/0Yj0wg1zJHNfM2RqZLkzxFr7YSksO6Bf34gap+9vgozKIiomC4n02Wqrr3jQT0FW5baJyp+aBje+M2U4zkT8A3KWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pmRu7gZQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=t4jvbJ7n8PAGp09Txkl3fReWKpqoTyQAeWAGk4qQm/o=; b=pmRu7gZQLcNyFlN272TC6n+Pfl
	0uX+C6vTTtndMxjKm5byN5vFdxVg0GwLIoEoJwWuns0WUGdROO2+1dhzZdKWoWp4/6I0qHZXSvO3V
	b0UHmFkud2zX/YFmg+nENEt+OXUQh5LT3Gs3nhF3EeiCDkKHe/K+S9GYaq7eqiSfXHn3+tBGM4ynd
	Cz0mbigeg0DtzD6U0hCaJxnixGOU0TmvkUubdRu7YLQRCTiu9O4jyMHOPEFlpG6QftsSvbxvtqzgA
	6gbAiIzwS/WK4J1HlwxETq0/JNEPhHZQ5GzpkGWBbWs+I7RVC0kZ8QkO9qyzUyXG5PUpgQPdCglft
	j8Hxw89g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRf2x-00000009uiC-3NoI;
	Wed, 10 Jul 2024 21:40:19 +0000
Date: Wed, 10 Jul 2024 22:40:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: [6.12] Conversion of aops->write_end to use a folio
Message-ID: <Zo7_w-BjbbbrxadX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For the 6.12 merge window, I intend to submit a patch series loosely
similar to the one you can find at

http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end

(aka git://git.infradead.org/users/willy/pagecache.git write-end)

This is split into a few pieces:

 - Directory handling conversion for ufs, sysv, minix & qnx6, all posted
   recently.
 - Various prep patches in reiserfs, jffs2, block fops, nilfs2, ntfs3,
   ecryptfs, f2fs, fuse, orangefs and vboxsf
 - The big bang conversion that is now appropriately trivial in each
   affected filesystem.

It would be nice to get sign-offs from the various fs maintainers on
the prep patches.  I'll send those out in the next 24 hours.  If you
want to take them through your tree, I ask that you do that for 6.11 so
we're not juggling git trees trying to resolve conflicts in 6.12.

I don't think we need signoffs from the various fs maintainers for the
big bang patch as the individual changes are so trivial.  But if you
want to give it a look-over, the more eyes the better.

