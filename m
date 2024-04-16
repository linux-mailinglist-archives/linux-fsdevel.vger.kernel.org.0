Return-Path: <linux-fsdevel+bounces-17039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B158A6B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BD5B22713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AE412BF1F;
	Tue, 16 Apr 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHT+3klZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20A5FEE3;
	Tue, 16 Apr 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272143; cv=none; b=noHRNfGLAbQuYaojFjqTeQgfRg2SZK62yGb1OmdSfFcFpaMmfKOAZO6pbDgYU9xYe1NqqbG0IJQMrv3Ozh9bz5nVswpIhYQlDT/EAD13qfryo4cGoVkqLL7+KDEUlzCVd8TR3BxrQ7nzSv2MakcE9c6d45c/1rSFuxh0Xca6e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272143; c=relaxed/simple;
	bh=vS50xrw5prwzj+VNQBlQu3Y5Io9p8bmnxxpzPj+x/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO52COkF+s/cNv4tmHKEUIDfp0Ik/+4eUGpLfNfj6SpAog0bA2mrXH55Ity5Sskn5HmMfnLf7oNn631hjtMH6N1coqCiOzg0LjSuv1nYOW/ns0J6VbXKpHWtPvD4vuj/llcVpOzBCTgYmCIZbomHGUUjILF7P2cjP0Fbc0DWoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHT+3klZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06064C2BD10;
	Tue, 16 Apr 2024 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272143;
	bh=vS50xrw5prwzj+VNQBlQu3Y5Io9p8bmnxxpzPj+x/Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHT+3klZ7SSMK9w5c++xbc6dBTQiAJ15T8aUAzrEzEyS8TGK+mBkp+Mjjrb7s6H46
	 yc0BaGFcO6BO5c/HNtHeZQPsJSmMtcmIplh5mzzHhbqFiDoBXjqf7OplY20brwHPYM
	 vjWmkofxRZLgD7IsaN1NBftoz4tMKK3sIcNNjhURja2Z3T4hBhGJT6ixRz+slWDTyb
	 T7POWEtN7URTTkwJMMydiv502MCDXvrcTC3aN+/ObM4AQZJ2zsfuL/saoSXx+FoZCW
	 EUR6IpZZb2pCkFvzkRp2xpZTW1i3GMwd4OieQoHt3yXiwJgTvLu9UB/er9PTLur/e4
	 EAKeOJEXrQ7/w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwiLe-0000000037N-12tc;
	Tue, 16 Apr 2024 14:55:42 +0200
Date: Tue, 16 Apr 2024 14:55:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zh51TvFSlXhTGPJy@hovoldconsulting.com>
References: <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
 <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner>
 <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
 <Zh1MCw7Q0VIKrrMi@hovoldconsulting.com>
 <CAHk-=whN3V4Jzy+Mv8UZGTJ5VEk_ihCS8tu3VskW-HCfBg6r=g@mail.gmail.com>
 <Zh1Qa2aB2Dg_-mW4@hovoldconsulting.com>
 <20240416-genutzt-bestleistung-f76707a9ddba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-genutzt-bestleistung-f76707a9ddba@brauner>

On Tue, Apr 16, 2024 at 12:38:56PM +0200, Christian Brauner wrote:
> On Mon, Apr 15, 2024 at 06:06:03PM +0200, Johan Hovold wrote:

> > Ah, right, I forgot about CONFIG_NTFS_RW as I've never enabled it.
> > 
> > Judging from the now removed Kconfig entry perhaps not that many people
> > did:
> > 
> > 	The only supported operation is overwriting existing files,
> > 	without changing the file length.  No file or directory
> > 	creation, deletion or renaming is possible. 
> > 
> > but I guess it still makes my argument above mostly moot.
> > 
> > At least if we disable write support in ntfs3 by default for now...
> 
> I think we can disable write support in ntfs3 for now. I've picked up
> the patch to make ntfs3 serve I sent some time ago that Johan tested
> now.

Note that I actually meant that write support should be disabled
completely in ntfs3 for now.

After this first encounter I have zero confidence in that driver and
pushing people towards using it (by removing the old, read-only one) is
just gonna result in further corrupted filesystems. At least make sure
it can't modify anything by default and mark write-support as
experimental and broken or something as that's apparently what it is.

> The only thing left is to disable write support for ntfs3 as legacy ntfs
> driver for now. I took a stab at this. The following two patches
> I'm appending _should_ be enough iiuc. Johan, please take a look and
> please test.

I skimmed them and gave them a quick spin. It seems that not specifying
either "ro" or "rw" in fstab now results in a ro mount, but I can still
specify "rw" explicitly (in fstab or command line) and end up with:

	/dev/nvme0n1p3 on /mnt/windows type ntfs (rw,relatime,uid=0,gid=0,iocharset=iso8859-1)

For obvious reasons, I did not dare listing the root directory or write
anything, but it looks like it's not read-only.

Using just my naive temporary hack from yesterday:

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8d2e51bae2cb..26be6c6d1032 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1177,6 +1177,9 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
        sb->s_xattr = ntfs_xattr_handlers;
        sb->s_d_op = options->nocase ? &ntfs_dentry_ops : NULL;

+       ntfs_warn(sb, "ntfs3 driver is broken, mounting read only");
+       sb->s_flags |= SB_RDONLY;
+
        options->nls = ntfs_load_nls(options->nls_name);
        if (IS_ERR(options->nls)) {
                options->nls = NULL;

seems to prevent also explicit rw mounts (but judging from your patches
it is not necessarily sufficient to prevent all modifications).

Johan

