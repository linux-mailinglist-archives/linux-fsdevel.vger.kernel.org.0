Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAB39967A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 01:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBXvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 19:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhFBXvQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:51:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DA9A613D8;
        Wed,  2 Jun 2021 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622677772;
        bh=03OVd6l7oQj7vrcl0Aa1QgC37aMuKF9JB7s8GqaXSLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWwqLESx/uN0TCUq74s7on3lrH3UFn2rv2kdcIzf1o5Jgnn7d8PgdrYIpePQLuTL6
         UUBhYp6K0+WSWlYcoCOFDSWk03Zx3dl51cY7bEwFxqfwazFX0rP9sOORPXVWLBVuwb
         BdzV30lQzXtiCp3gCR6Ee/gAfzVSCX67IJz7EwgwNQeosZ/9kihFo1Ib1aunBzepRE
         243u5/pct8DogyydXFMXgkhK+sa2xEfGCLgmiXkRn6qGbSEEOZYBQtNvYI1opQQ3ee
         gsOP+DpRKZlfHP9mawzwBEvOc4tRZ8nbZQCPcAbs0A9uK8VaNqUjbE3ESiu6ycIsW8
         B1Lhbs6BOfARw==
Date:   Wed, 2 Jun 2021 16:49:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
Message-ID: <YLgZCwPLenETHx1+@sol.localdomain>
References: <20210602041539.123097-1-drosen@google.com>
 <20210602041539.123097-3-drosen@google.com>
 <YLfh9pv1fDT+Q3pe@sol.localdomain>
 <CA+PiJmR1vWN7ij7ak4q=C0Wxa++t=SCnEFh_iDt7QVOAZy-VFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmR1vWN7ij7ak4q=C0Wxa++t=SCnEFh_iDt7QVOAZy-VFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:22:38PM -0700, Daniel Rosenberg wrote:
> On Wed, Jun 2, 2021 at 12:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Jun 02, 2021 at 04:15:39AM +0000, Daniel Rosenberg wrote:
> > > +#ifdef CONFIG_UNICODE
> > > +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> > > +#endif
> >
> > Shouldn't it be defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)?
> >
> > >  #endif
> > >  #ifdef CONFIG_BLK_DEV_ZONED
> > >  F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> > > @@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
> > >  #ifdef CONFIG_FS_ENCRYPTION
> > >       ATTR_LIST(encryption),
> > >       ATTR_LIST(test_dummy_encryption_v2),
> > > +#ifdef CONFIG_UNICODE
> > > +     ATTR_LIST(encrypted_casefold),
> > > +#endif
> >
> > Likewise here.
> >
> > - Eric
> 
> Those are already within an #ifdef CONFIG_FS_ENCRYPTION, so it should
> be covered already.

Adding a comment to the #endif for CONFIG_FS_ENCRYPTION would make it easier to
read:

	#endif /* CONFIG_FS_ENCRYPTION */

> Should I send a v2 set with the
> 
> Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> Cc: stable@vger.kernel.org # v5.11+
> 
> appended?

Yes, please add those tags.

- Eric
