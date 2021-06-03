Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475EF39A9D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFCSO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSO0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:14:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8BCE61358;
        Thu,  3 Jun 2021 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622743960;
        bh=F/y2/Xdi0ro0EVjX6ng9wtgqyP3SEfu7omS9AaaCxz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+zwjwbZ5433owWIuNAL0slq9gnMTykhFnj259Z7uuxekTrLWZ8d0/2oSKIaXjOtm
         wgnKEzggP+U3Ure3VSX81M+MGaA5bKQbUF72rvUVg1RSTQsUQ6VkhIwT0zKG2Eq2j4
         zJv+K6EbCV/Cc50bFTABSoerC5xw3DRTaAG7bkj0=
Date:   Thu, 3 Jun 2021 20:12:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] f2fs: Advertise encrypted casefolding in sysfs
Message-ID: <YLkblVt+v68KFXf7@kroah.com>
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
 <YLipSQxNaUDy9Ff1@kroah.com>
 <YLj36Fmz3dSHmkSG@google.com>
 <YLkQtDZFG1xKoqE5@kroah.com>
 <YLkXFu4ep8tP3jsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLkXFu4ep8tP3jsh@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 03, 2021 at 10:53:26AM -0700, Jaegeuk Kim wrote:
> On 06/03, Greg KH wrote:
> > On Thu, Jun 03, 2021 at 08:40:24AM -0700, Jaegeuk Kim wrote:
> > > On 06/03, Greg KH wrote:
> > > > On Thu, Jun 03, 2021 at 09:50:38AM +0000, Daniel Rosenberg wrote:
> > > > > Older kernels don't support encryption with casefolding. This adds
> > > > > the sysfs entry encrypted_casefold to show support for those combined
> > > > > features. Support for this feature was originally added by
> > > > > commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > > 
> > > > > Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > > Cc: stable@vger.kernel.org # v5.11+
> > > > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > > > ---
> > > > >  fs/f2fs/sysfs.c | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > > index 09e3f258eb52..6604291a3cdf 100644
> > > > > --- a/fs/f2fs/sysfs.c
> > > > > +++ b/fs/f2fs/sysfs.c
> > > > > @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
> > > > >  	if (f2fs_sb_has_compression(sbi))
> > > > >  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >  				len ? ", " : "", "compression");
> > > > > +	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> > > > > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > > +				len ? ", " : "", "encrypted_casefold");
> > > > >  	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >  				len ? ", " : "", "pin_file");
> > > > >  	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > > > 
> > > > This is a HUGE abuse of sysfs and should not be encouraged and added to.
> > > 
> > > This feature entry was originally added in 2017. Let me try to clean this up
> > > after merging this.
> > 
> > Thank you.
> > 
> > > > Please make these "one value per file" and do not keep growing a single
> > > > file that has to be parsed otherwise you will break userspace tools.
> > > > 
> > > > And I don't see a Documentation/ABI/ entry for this either :(
> > > 
> > > There is in Documentation/ABI/testing/sysfs-fs-f2fs.
> > 
> > So this new item was documented in the file before the kernel change was
> > made?
> 
> Do we need to describe all the strings in this entry?
> 
> 203 What:           /sys/fs/f2fs/<disk>/features
> 204 Date:           July 2017
> 205 Contact:        "Jaegeuk Kim" <jaegeuk@kernel.org>
> 206 Description:    Shows all enabled features in current device.

Of course!  Especially as this is a total violation of normal sysfs
files, how else are you going to parse the thing?

Why wouldn't you describe the contents?

But again, please obsolete this file and make the features all
individual
files like they should be so that you do not have any parsing problems.

thanks,

greg k-h
