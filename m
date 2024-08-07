Return-Path: <linux-fsdevel+bounces-25248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C694A479
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88905282230
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F061D1F51;
	Wed,  7 Aug 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btbhCRAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B81D0DE3;
	Wed,  7 Aug 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023365; cv=none; b=OnauMIN6cxWEriQXdrgaPjuJ4CA13ikOKMufNwvrolnr9AkwtuxYvx37a0de6neVl6UMXtNK5qM/Ag8thftAeWXWJf48znP33BQb77rF0YsYw6OwInS1bPSUBCRLQGPtFSa3S95NxBhoEztkJeVCJ4V2joVrzEXWI0jDfo4nqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023365; c=relaxed/simple;
	bh=SIN474AVw4y1MoDQyBN2l9zLDxAG8yJpM+IZg/xSlBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byqVjajC/B0duFc7woJ0JC+/TPyJSLxIUSKlJdzaCQg4IUbYz1Xov2KdZjrO9ro5zpMm2fgg8q/R1e2o4h7HgEZI7vT+hqlSlEnzvRMphS32VJamtg2ymfuxLI0cqxRcll/cOTy8SerPIfT3aX3/cetNO0PSOqdKXGKxDpWziqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btbhCRAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EDC4AF0B;
	Wed,  7 Aug 2024 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723023364;
	bh=SIN474AVw4y1MoDQyBN2l9zLDxAG8yJpM+IZg/xSlBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btbhCRAZArjLvUl8j5Ej+vHzQoO1vTjwqrNsQBIT0/x406nNG6tlbPi9O+sN17d4Y
	 QICBpuxQ5Bjmn0gXNfW6CQYVZcH8G9ejnTHAA9QFo2zZkYlDWAI6Ot2tDmga9anM+b
	 WGgtBA/ZIv47FtykXIpoPT2AFtuvlcGoPU21CF4LWL98hI/ZRbIPlQfOtpM6SjubXy
	 OlCR91eQljQjrJdxLmEtfQYDLsvKApDB3/uWNI88bc+X4QiyQeaPCNomUP+ive0rEL
	 gGm3BEKgE3wm60LcEtCDTOpcEofl8MTOn6i7t19oigLeiBJBu3URtJDBmLKsiEuJyf
	 nO0JARebaxVPA==
Date: Wed, 7 Aug 2024 11:35:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, reiserfs-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <20240807-fazit-bergbahn-25781f6167b7@brauner>
References: <202408062249.2194d51b-lkp@intel.com>
 <ZrLuBz1eBdgFzIyC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrLuBz1eBdgFzIyC@casper.infradead.org>

On Wed, Aug 07, 2024 at 04:46:15AM GMT, Matthew Wilcox wrote:
> On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
> > kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
> > 
> > commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
> > 
> > in testcase: boot
> 
> This patch should fix it.
> 
> Christian, can you squash the fix in?

Yep, done!

