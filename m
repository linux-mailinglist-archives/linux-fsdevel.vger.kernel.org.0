Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645322B764E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 07:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKRG1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 01:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgKRG1Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 01:27:24 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 967CC24655;
        Wed, 18 Nov 2020 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605680843;
        bh=RpCSS3y/duXfmLEcUn3G8/pHSXmT8ukKU/5AG+m0bT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V58yRoepyagZTKlr+aW6gb29AshdnBnmgDiYwKqMm3jlLRYkgNPd33jvY3404zhqF
         f0Vq1eeZw/pwKC17YrReXC+eB7OqJ3I2z/UF/rbyQKIjkyufDOUzj36PJr33VOANJ1
         46Slhm5EzAs0u5/ypJRRtVFkLqUibL9cremOd1dY=
Date:   Tue, 17 Nov 2020 22:27:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 3/3] f2fs: Handle casefolding with Encryption
Message-ID: <X7S+yK05aX+zB+k9@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-4-drosen@google.com>
 <X7QbX9Q4xzhg+5UU@sol.localdomain>
 <CA+PiJmRQGJP5uHf-yXs=efo++JE+SUmjRizwzH-RGG92RdAxyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmRQGJP5uHf-yXs=efo++JE+SUmjRizwzH-RGG92RdAxyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:22:28PM -0800, Daniel Rosenberg wrote:
> > > @@ -273,10 +308,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
> > >                       continue;
> > >               }
> > >
> > > -             if (de->hash_code == fname->hash &&
> > > -                 f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> > > -                                 le16_to_cpu(de->name_len)))
> > > -                     goto found;
> > > +             if (de->hash_code == fname->hash) {
> > > +                     res = f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> > > +                                 le16_to_cpu(de->name_len));
> > > +                     if (res < 0)
> > > +                             return ERR_PTR(res);
> > > +                     else if (res)
> > > +                             goto found;
> > > +             }
> >
> > Overly long line here.  Also 'else if' is unnecessary, just use 'if'.
> >
> > - Eric
> The 0 case is important, since that reflects that the name was not found.

I meant doing the following:

	if (res < 0)
		return ERR_PTR(res);
	if (res)
		goto found;

It doesn't really matter, but usually kernel code doesn't use 'else' after an
early return.

- Eric
