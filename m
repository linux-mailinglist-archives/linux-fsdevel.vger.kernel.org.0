Return-Path: <linux-fsdevel+bounces-43507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3EA5783A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465CD189A0F4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E115B115;
	Sat,  8 Mar 2025 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/rx4imJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B02CAB;
	Sat,  8 Mar 2025 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406826; cv=none; b=JW0mIm0Z1ftwPCMmc6Fk2ImQ3gENZO0rlg1DilmqBHC31C2oH6q0TRyVv/iW3AOvX3j6K/7qAtraPTz49IIbnAtlLmVKYQw6mkCxT59imtvdLERQQ49uHSnXuw49gkSlvcFYs9FodS7IIu1Q1eCJUxvmuGfM09bjxvkIgrx68Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406826; c=relaxed/simple;
	bh=s41Kiihoo5v0OXthZUir9md3noNFobzwW/cnNSvrFAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGwEoytuagl8fCvbhJK3DFUL3iPiPjko7g1sqSDnsH5gJfuAJcDLBc6yAMMboktYqXJnPd6NfUQZSvc0+kc4Ghu4cTeZm9wt1fRysGiRvWkQheC5WkDpDFQvWPQptMHu/XhdRsG5jc92AlrEZGhnGzmpynGNZEeGQZji2rsFBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/rx4imJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A14C4CEE0;
	Sat,  8 Mar 2025 04:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741406825;
	bh=s41Kiihoo5v0OXthZUir9md3noNFobzwW/cnNSvrFAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/rx4imJ1i7ZDNHYHBA7H4lp7cojqNDgPdPaS3/7MnfFNfOeQYHcBYGV/HSyRxWjw
	 ro+iHFi8ugniPknrC0uBQEZDnulTXvtX+ii9iun8nG8+Sy0MQin7yvaYPuN1myiZpz
	 Y3nNe3NfYaZFmtk8evlnvGI3C+FmuT0Vs8+XDGeCODll4eZ6WMPIWdcgvcSfCfrbLz
	 wTvnmPDFxc0DQO1o5Wrh/VS7EYyT8tmLAQs6k/e1tjXM6+1p/iHpEXV2hhzOMZlShI
	 GYnZB5UMWjcyK19Rr+ypxthdY9rXRWwWac5+f71nwFRNXfRZRyZMW617G7SDGOPPG1
	 FGcVlNkfb+gYA==
Date: Fri, 7 Mar 2025 20:07:01 -0800
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, sunliming@linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] fs: binfmt_elf_efpic: fix variable set but not used
 warning
Message-ID: <202503072006.B920348F@keescook>
References: <20250308022754.75013-1-sunliming@linux.dev>
 <174140535640.1476341.8645731807830133176.b4-ty@kernel.org>
 <CAKbZUD1ieaVVD9A9CG=5oCacud4JqnxzYgMv=fiQK=2zT_y10w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD1ieaVVD9A9CG=5oCacud4JqnxzYgMv=fiQK=2zT_y10w@mail.gmail.com>

On Sat, Mar 08, 2025 at 04:01:50AM +0000, Pedro Falcato wrote:
> On Sat, Mar 8, 2025 at 3:45 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Sat, 08 Mar 2025 10:27:54 +0800, sunliming@linux.dev wrote:
> > > Fix below kernel warning:
> > > fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
> > > used [-Wunused-but-set-variable]
> > >
> > >
> >
> > Adjusted Subject for typos.
> >
> > Applied to for-next/execve, thanks!
> >
> > [1/1] binfmt_elf_fdpic: fix variable set but not used warning
> >       https://git.kernel.org/kees/c/7845fe65b33d
> >
> 
> FYI, there's a typo so this patch won't compile
> 
> >+ unsiged long excess1
> >+ = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
> 
> s/unsiged/unsigned/

D'oh. Fixing in my tree..

-- 
Kees Cook

