Return-Path: <linux-fsdevel+bounces-43503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E0A57804
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24287A66A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 03:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912515B115;
	Sat,  8 Mar 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dusQBWYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AC3A1DB;
	Sat,  8 Mar 2025 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405405; cv=none; b=WJWOYld6l7J8GE9omM3xCwjH511MNtzVCmy3WyAvNRvP7lC0KpKE256CtODSrUvQ0D1w8+Ixpjl6WCsxgUobOYo0TFeZyVStpvCnt3IqSoUT9N7lZtKHlNCSVDVOAQo5Dnxn3o6nqL8a4W3P26zlnndQuD7a9jYFz6d0nB/GITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405405; c=relaxed/simple;
	bh=ica+9mODfxewARoWmuQgFubvre1BHwD4871DgNF8e28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUk2odIMh7/iI+Vky/Q2MNjUgkzld0C4vhSIx4Ir4Ra6n5IuRXv9xJOfHIXhDj/2vV+hQrpsf/RKzBADdxegU3VmODUXjhQ14BsGcWJd76HPSzyrwyvH3oqepW6NdmoT/d/G0Jiou5a1J9KdL8B9qDEPflmqOa6YsaRrVoim5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dusQBWYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E58C4CED1;
	Sat,  8 Mar 2025 03:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405404;
	bh=ica+9mODfxewARoWmuQgFubvre1BHwD4871DgNF8e28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dusQBWYnXmnySfLKKmC0Fzu8k+eOHF24AhihdhjF2FaTE168Fi+QGww55E4RBVdN4
	 O5OVWFPoqzwOuae/UBtUDyXrIIa7ws3kYl8jz75fBqYZazww+8diRcmuxPj5Zvfc/k
	 bZ9awcQhuUUBuqhdWZEQE+aLaZ+LFrVqCpZOinlidnUZtq1f8SJlcNIURm32tyNni8
	 dWgqT6XdzAYUQ5ZeA+2LaDhNXCTEDk2jYEKh1H+oW/MiBP5U22MA6cvVq7pU/74hI5
	 3eixJL4qOMrQS8pl08URDU2nkNSnW86oDyniZCvpJfH2w0hbnZb5rR71RrjHfmZFMj
	 LKR/58hS+7Wyg==
From: Kees Cook <kees@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiederm@xmission.com,
	sunliming@linux.dev
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] fs: binfmt_elf_efpic: fix variable set but not used warning
Date: Fri,  7 Mar 2025 19:42:38 -0800
Message-Id: <174140535640.1476341.8645731807830133176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308022754.75013-1-sunliming@linux.dev>
References: <20250308022754.75013-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 08 Mar 2025 10:27:54 +0800, sunliming@linux.dev wrote:
> Fix below kernel warning:
> fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
> used [-Wunused-but-set-variable]
> 
> 

Adjusted Subject for typos.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf_fdpic: fix variable set but not used warning
      https://git.kernel.org/kees/c/7845fe65b33d

Take care,

-- 
Kees Cook


