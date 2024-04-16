Return-Path: <linux-fsdevel+bounces-17072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C98A72F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63342B21E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FA135A67;
	Tue, 16 Apr 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJFISS3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDE134CD0;
	Tue, 16 Apr 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291552; cv=none; b=IDof4kg6bRLphZVGTa90U5oL3yYJQYIXhtnDmfY8qmIhIOvHv2c4e8BIpm9vO/W4SsMudFZx7F02uNJpwcGfn76hfHv49ufSBhZtJeiVHrucb1yo+lMnqQCyNZfQkRSKQ3Da95iLy/FunRYLcjqZBQ7vwK/eIk1BJcutYCiOf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291552; c=relaxed/simple;
	bh=OSFyHt08QH9EQT0OH6l2mjM6TDXgg4K1qPiqN9EnzTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktixbaK0mtmPhVBhY7SP8XepjcNYspSFTkHw+r+/R6nmHSy6B7QFl/+ZqGDvRr6tjj51VOeuWxk0Rbc3zoi9o1LrzrnQWcK1sEVzi/cMiJX3Ib68krsfhwHycXTC85KC/SIksYCUz0RVKXxexpexeiHqEfDr91dMkakuHnfF/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJFISS3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1C2C113CE;
	Tue, 16 Apr 2024 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713291552;
	bh=OSFyHt08QH9EQT0OH6l2mjM6TDXgg4K1qPiqN9EnzTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJFISS3fPUcd6DEOOP0W+iLg/MehqWAKn84NatA9HD2x9ox4VLLzoRForSafJLD5Z
	 7bknIRzjCT4DAd3BU/lMIEJKmiIGlav6YBMZMbz/DN4vug1w5ufeLyipa8GyG6ee/E
	 2VBwwcud1ujgQzDiV0AkCdaD7egYm3HrIcJ+CWH2QlbK/4r+shqzCLAI8Y66FlC6Qm
	 Df/4O359q3sLIf8HsChGbNGebitD1yY8qQTqMgKU2HRSnIW4bSh5OtY1xFENmbcjcw
	 CvvFesh2ElTtCjgpJuW7rKi4ipanh0qwGxR5nqaPQG5AFADuX/VcD+oLP/Ps2rpJT6
	 4j5kRjU+IlUHw==
Date: Tue, 16 Apr 2024 21:18:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nam Cao <namcao@linutronix.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <Zh7A2o59dOIwaRjA@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <Zh6lD8d7cUZdkZJb@kernel.org>
 <Zh6n952Y7qKRMnMj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6n952Y7qKRMnMj@casper.infradead.org>

On Tue, Apr 16, 2024 at 05:31:51PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 16, 2024 at 07:19:27PM +0300, Mike Rapoport wrote:
> > > "last page of the first gigabyte" - why first gigabyte? Do you mean
> > > last page of *last* gigabyte?
> >  
> > With 3G-1G split linear map can map only 1G from 0xc0000000 to 0xffffffff
> > (or 0x00000000 with 32-bit overflow):
> > 
> > [    0.000000]       lowmem : 0xc0000000 - 0x00000000   (1024 MB)
> 
> ... but you can't map that much.  You need to reserve space for (may not
> be exhaustive):
> 
>  - PCI BARs (or other MMIO)
>  - vmap
>  - kmap
>  - percpu
>  - ioremap
>  - modules
>  - fixmap
>  - Maybe EFI runtime services?
> 
> You'll be lucky to get 800MB of ZONE_NORMAL.

But that does not mean that the last page won't get to the buddy

-- 
Sincerely yours,
Mike.

