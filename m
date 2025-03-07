Return-Path: <linux-fsdevel+bounces-43479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660CA572F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58944189456D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B227257424;
	Fri,  7 Mar 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ4I2loE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5D21ABD9;
	Fri,  7 Mar 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379440; cv=none; b=EA8wqq1pGHc4cu1RnajQcigRPcVzUzB0Y/ZhwAmSp5h95NPcE5GIqUmnpnENN/DOI07HRH3GDVyrPoxcIolHvVfKmKLDzNJGENGBoKkunecNGyfN/y/mfe/OBaqFZFBU84rT7vJt221KhVnN85q3Jhdedmps1GFIbqrwuAAL390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379440; c=relaxed/simple;
	bh=JeNtnuY3o7iF7TYmV0ibx2LZvjcolgMAlFCcFGdxczQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHfpmF+lteGTejSabd6xxc7aRMRZoPHEJtVrcbUnJkfHrr4tZ/ggQv1qqb8Gz5v/qQ7Og3gsS8ObDDNfjV6bH6nSfYeJGbyacV0Vk+bVFxwAmjJpy+cuzJtP4VF4aCfYrHcX4ewA7mYnNjteDQj/RTds9liUS+/8gIgF1w8CGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ4I2loE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B88C4CEE2;
	Fri,  7 Mar 2025 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741379440;
	bh=JeNtnuY3o7iF7TYmV0ibx2LZvjcolgMAlFCcFGdxczQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ4I2loEI3M5F/Xmoj3zVD2J6ZuSsweDsJ/xzqhTlJFjWCTfOHxFT+KBERCYTt9Le
	 o7fvlWgoUVOodSoP6O/UfQbsxRZHXc+VTlZuw/7Y6DF+od5FtlMmBPQMfaYHmFdFEC
	 YyXnG9//5nTDgptoODd8fK2kuaKxZxl2d+xntkxKPYubFiWrcuaNQWz5nfFW6Qqwl9
	 GSZV/sTgccFAljLxj44mRZEo1UxeB0ZkN4wvaKIdKbyL6ZFZ5wO2UUrFP9PPOQrAEw
	 OVQKbFVvbJZsgvGcc/zO+RsJClFFSneOl3gLBhN8ixk8VpVmXZrw1qbrhNUJarMxHl
	 eVcyexFqm1R6A==
Date: Fri, 7 Mar 2025 12:30:36 -0800
From: Kees Cook <kees@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: sunliming@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	sunliming@kylinos.cn, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used
 warning
Message-ID: <202503071227.578545FF9@keescook>
References: <20250307061128.2999222-1-sunliming@linux.dev>
 <a555rynwidxdyj7s3oswpmcnkqu57jv3wsk5qwfg5zz6m55na3@n53ssiekfch4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a555rynwidxdyj7s3oswpmcnkqu57jv3wsk5qwfg5zz6m55na3@n53ssiekfch4>

On Fri, Mar 07, 2025 at 03:47:28PM +0100, Jan Kara wrote:
> On Fri 07-03-25 14:11:28, sunliming@linux.dev wrote:
> > From: sunliming <sunliming@kylinos.cn>
> > 
> > Fix below kernel warning:
> > fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
> > used [-Wunused-but-set-variable]
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> 
> The extra ifdef is not pretty but I guess it's better. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Since we allow loop-scope variable definitions now, perhaps this is a
case for defining the variable later within the #ifdef, like this?


diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e3cf2801cd64..b0ef71238328 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1024,7 +1024,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 	/* deal with each load segment separately */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
-		unsigned long maddr, disp, excess, excess1;
+		unsigned long maddr, disp, excess;
 		int prot = 0, flags;
 
 		if (phdr->p_type != PT_LOAD)
@@ -1120,9 +1120,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		 *   extant in the file
 		 */
 		excess = phdr->p_memsz - phdr->p_filesz;
-		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 
 #ifdef CONFIG_MMU
+		const unsigned long excess1 =
+			PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 		if (excess > excess1) {
 			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
 			unsigned long xmaddr;

> 
> 								Honza
> 
> > ---
> >  fs/binfmt_elf_fdpic.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> > index e3cf2801cd64..bed13ee8bfec 100644
> > --- a/fs/binfmt_elf_fdpic.c
> > +++ b/fs/binfmt_elf_fdpic.c
> > @@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
> >  	/* deal with each load segment separately */
> >  	phdr = params->phdrs;
> >  	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> > -		unsigned long maddr, disp, excess, excess1;
> > +		unsigned long maddr, disp, excess;
> >  		int prot = 0, flags;
> > +#ifdef CONFIG_MMU
> > +		unsigned long excess1;
> > +#endif
> >  
> >  		if (phdr->p_type != PT_LOAD)
> >  			continue;
> > @@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
> >  		 *   extant in the file
> >  		 */
> >  		excess = phdr->p_memsz - phdr->p_filesz;
> > -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
> >  
> >  #ifdef CONFIG_MMU
> > +		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
> >  		if (excess > excess1) {
> >  			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
> >  			unsigned long xmaddr;
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Kees Cook

