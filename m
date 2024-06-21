Return-Path: <linux-fsdevel+bounces-22079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0323911D43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C87C1F22EA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E716D325;
	Fri, 21 Jun 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfFN+Huq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D216C86E;
	Fri, 21 Jun 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956050; cv=none; b=n+AaWGSjWvK5G7bWBmJh+DsXfR+9t/8ifhRI4HYcOG4S42vzSxxbIfycsSL1gj12TacewVvE2cp/poFbK939RGb+NX9yc/YDuYcUGih3r27t5V16pTPe4xCQJKqFVIfh5XkaOINvNENE+hQBlSJ+b5xwyavxrCTfsA+vgJGsDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956050; c=relaxed/simple;
	bh=+n1uE1MrLQMFhNN+7jwAvQajIquhPpIK6hC9WogIb1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3iOUVHate0rd2oJjkAAYJ9xtqcdoYz7I68Bk6VG/WHEYVUOjSCcqJCoC//wN0rRTiysmui2KlWfNpjMfcaOaFUvWLMAvuKul2QuQc2p/8s3/R7YZh/fUm67sZFkk1xfNRlMmwdlitJFOjBotlfmbRnBFpMYx/EGN+EKwR1KgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfFN+Huq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED54C2BBFC;
	Fri, 21 Jun 2024 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718956049;
	bh=+n1uE1MrLQMFhNN+7jwAvQajIquhPpIK6hC9WogIb1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfFN+HuqInMOioum3nOUUAxrTdtVdjbZPYztVw5rmIyxcrJKkfr//GPMMvssZ97mF
	 bc16USxoEeLnXgt2+ZWBhKfJaZxF6h94UXw/6wVZmRCosK7MzmOV/zy0hFkL9oAOTY
	 pLA96PVGw92edy7QBoumKi8/eHn/jpPrkZVF8iciR02xYit0fMKT5AKfFI28z2S/Xo
	 7cTGqzDyXh0801wUzYZXCV5iG5ibGw7x8NUtpfJaovfGEj4d4xgd71H8ZAoG1ltp5R
	 DaYwRoRG9BedSojyfpOn0Rc1oP+3UrPp/XDKQIT4MVW7tJ4oBBcq8vXMRLFcoNlAPv
	 I1hJb8yogM0Jw==
Date: Fri, 21 Jun 2024 09:47:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-mips@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>, 
	linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org, 
	musl@lists.openwall.com, ltp@lists.linux.it, stable@vger.kernel.org
Subject: Re: [PATCH 01/15] ftruncate: pass a signed offset
Message-ID: <20240621-jeden-hinab-e265b0d0807a@brauner>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620162316.3674955-2-arnd@kernel.org>

On Thu, Jun 20, 2024 at 06:23:02PM GMT, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old ftruncate() syscall, using the 32-bit off_t misses a sign
> extension when called in compat mode on 64-bit architectures.  As a
> result, passing a negative length accidentally succeeds in truncating
> to file size between 2GiB and 4GiB.
> 
> Changing the type of the compat syscall to the signed compat_off_t
> changes the behavior so it instead returns -EINVAL.
> 
> The native entry point, the truncate() syscall and the corresponding
> loff_t based variants are all correct already and do not suffer
> from this mistake.
> 
> Fixes: 3f6d078d4acc ("fix compat truncate/ftruncate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

