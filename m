Return-Path: <linux-fsdevel+bounces-53722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B9AF63C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D241A4E2F85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070B239E92;
	Wed,  2 Jul 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FDk7DbvR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB7239E90
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490791; cv=none; b=iqzCm1ENl0rhmWOMwaqRNGtskUVu79KcusZhtQoLAG7xYZrWv5TDICnEAuGqT/h9kX8pOzmd87O1YUEhBB+Gx3l0khTj4+jdwDPVoBMGahBP45e7OPE45Q+uGQfluoCb3tanwNkupgpQ1Z44y+Uei7I6Imsn1AqXeRelvqfQAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490791; c=relaxed/simple;
	bh=QPIQwxQdEix6EbFW0wFu4XnoaqMuc21xvb58WaH9gOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sGN5YC22m99IAhO6p/5ezCdx6M8JcSEVAAY+kuWpBWPpMKsS++L8Ar06+un9ESiKRwwGqrkS1fsCgZ9TcG7acoNvL0Bbj2PCJJ91DoyckKhESVmFIS7pP7rJ/iBgKSNszwWwBfT1N5Zq6kx6vqcrGlRHPKVlS5DsLIsPKX51MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FDk7DbvR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9qe8FpvbftIwdpSPiLTONb6a5ev72Y3g7ZKd8FiUuEs=; b=FDk7DbvRfIVbgvbsH1jUSQ3tbQ
	f3qANIJx3mKqyRa2YUu9OSpW/hJ5+Fgmot40cRKUZVTa08K9twm3p7+lS1gAMOmEgYGDvBPM8rVt/
	VfPC0dQRCBWs/4/jmKlgAYXXM8QsIjKYrVrnh7YuEQz7NYGx5lghlukOI4OADb+lNK89umHH4dsfw
	iVTuaU/7qDmcx6AomoS/cEPhfchtXt3SbAHFh56/RYQWRFR+firH47/cfbp4kjweqkOPr2z5BZaHK
	nUqx81IsTx1qNLpUjGIpxVpzUPiJjSs98hx17l8Fy65sa0w13wQPl+KzDFUi4Jnj+VQCBIjPdaxGY
	PKE7N89Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4lN-0000000EI9v-3x3Q;
	Wed, 02 Jul 2025 21:13:06 +0000
Date: Wed, 2 Jul 2025 22:13:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCHES] assorted debugfs stuff
Message-ID: <20250702211305.GE1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	A bit more of debugfs work; that stuff sits in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs
Individual patches in followups.  Please, review.

Several removals of pointless debugfs_file_{get,put}():
      zynqmp: don't bother with debugfs_file_{get,put}() in proxied fops
      hfi1: get rid of redundant debugfs_file_{get,put}()
      regmap: get rid of redundant debugfs_file_{get,put}()
      resctrl: get rid of pointless debugfs_file_{get,put}()
Getting rid of the last remnants of debugfs_real_fops():
      vmscan: don't bother with debugfs_real_fops()
      netronome: don't bother with debugfs_real_fops()
      debugfs: split short and full proxy wrappers, kill debugfs_real_fops()

Bogosities in drivers/thermal/testing:
      fix tt_command_write():
1) unbalanced debugfs_file_get().  Not needed in the first place -
file_operations are accessed only via debugfs_create_file(), so
debugfs wrappers will take care of that itself.
2) kmalloc() for a buffer used only for duration of a function is not
a problem, but for a buffer no longer than 16 bytes?
3) strstr() is for finding substrings; for finding a character there's
strchr().

debugfs_get_aux() stuff:
      debugfs_get_aux(): allow storing non-const void *
      blk-mq-debugfs: use debugfs_aux_data()
      lpfc: don't use file->f_path.dentry for comparisons
If you want a home-grown switch, at least use enum for selector...

