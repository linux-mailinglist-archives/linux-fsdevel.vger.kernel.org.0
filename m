Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2349A39B1C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 07:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFDFCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 01:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhFDFCz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47F976138C;
        Fri,  4 Jun 2021 05:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622782869;
        bh=FX6o7aB6iS8uy89W3MSrtVuCO1EpSj36V4h5Npoe450=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgBIwOAY1BynVNx0Ow7+EJcnJ8OeXkGp9rKCjhykWbfHAKuCTHi+Bl2yD/YjbU5Me
         LKuaAUS6fFA0s2gD0UcnaXo9xcyh2FiNaOVmSYWkvNVIoTc50ArtJcDX1xTeOWryAu
         6kabYQIquTtaM3Q7LDdPL6348hPP0bnFMnqcVxqNunmwNvsWVjXbyLzE+XVTI6+U82
         H02fB0o7GKn2A5tKM3O5sBBEigLANr1z7vtO8+qyaXH5gyvYMQjMOpKS3VPjDx61kF
         c5dNoonMRp8zCbCagSPantf2ijeJddzQcUNfGMRQ9ypW6Ny0d/nwLld5DBNZ69NhC4
         2VRDwHX/nsPxw==
Date:   Thu, 3 Jun 2021 22:01:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] f2fs: Advertise encrypted casefolding in sysfs
Message-ID: <YLmzkzPZwBVYf5LO@sol.localdomain>
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
 <YLlj+h4RiT6FvyK6@sol.localdomain>
 <YLmv5Ykb3QUzDOlL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLmv5Ykb3QUzDOlL@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:45:25PM -0700, Jaegeuk Kim wrote:
> On 06/03, Eric Biggers wrote:
> > On Thu, Jun 03, 2021 at 09:50:38AM +0000, Daniel Rosenberg wrote:
> > > Older kernels don't support encryption with casefolding. This adds
> > > the sysfs entry encrypted_casefold to show support for those combined
> > > features. Support for this feature was originally added by
> > > commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > 
> > > Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > Cc: stable@vger.kernel.org # v5.11+
> > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > ---
> > >  fs/f2fs/sysfs.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index 09e3f258eb52..6604291a3cdf 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
> > >  	if (f2fs_sb_has_compression(sbi))
> > >  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > >  				len ? ", " : "", "compression");
> > > +	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> > > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > +				len ? ", " : "", "encrypted_casefold");
> > >  	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > >  				len ? ", " : "", "pin_file");
> > >  	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > > @@ -579,6 +582,7 @@ enum feat_id {
> > >  	FEAT_CASEFOLD,
> > >  	FEAT_COMPRESSION,
> > >  	FEAT_TEST_DUMMY_ENCRYPTION_V2,
> > > +	FEAT_ENCRYPTED_CASEFOLD,
> > >  };
> > 
> > Actually looking at it more closely, this patch is wrong.
> > 
> > It only makes sense to declare "encrypted_casefold" as a feature of the
> > filesystem implementation, i.e. /sys/fs/f2fs/features/encrypted_casefold.
> > 
> > It does *not* make sense to declare it as a feature of a particular filesystem
> > instance, i.e. /sys/fs/f2fs/$disk/features, as it is already implied by the
> > filesystem instance having both the encryption and casefold features enabled.
> > 
> > Can we add /sys/fs/f2fs/features/encrypted_casefold only?
> 
> wait.. /sys/fs/f2fs/features/encrypted_casefold is on by
> CONFIG_FS_ENCRYPTION && CONFIG_UNICODE.
> OTOH, /sys/fs/f2fs/$dis/feature_list/encrypted_casefold is on by
> on-disk features: F2FS_FEATURE_ENCRYPT and F2FS_FEATURE_CASEFOLD.
> 

Yes, but in the on-disk case, encrypted_casefold is redundant because it simply
means encrypt && casefold.  There is no encrypted_casefold flag on-disk.

- Eric
