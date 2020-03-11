Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501D5181EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgCKRHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:07:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40843 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgCKRHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id h17so2785986otn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+t9fU13Iuz/zoBPnGG3vft0C0z8m2mKCU7Saw6lmvk=;
        b=nDapp6XlmdQ95ZlIGVJCqMXN9WyMEgI8CkY0oLNB089wKVmR+TdQeZpYDltt7rgUbo
         3dLmnYrnPzoOy+BA0kNlt4kZy0eo8oxD/iQNDby4ZOZLvKsJ7toAqY+og/il5nfjvoqQ
         4nbRNzmRf1NValJ935o6Kb1TnOQckuNubNDuu5/tyTnmiaYMnvKQ02fsRkHbUXS28sG9
         ZQjcT/UAmUuOghp9CgbxknQK/JZWV3oSAA/okTSskDW+E+LNju1VyxIjyiso5WQ940vk
         bC1VPLSskaTKc8FU6ZuPNRE30Qt9QR7h7dAtWQdc0Tb8O1zmr8Tzn/NHVZwzBIxVOj5V
         CtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+t9fU13Iuz/zoBPnGG3vft0C0z8m2mKCU7Saw6lmvk=;
        b=ZTdXqswbKEvXDmxLfHZ/EQcRqZbdbXeMBX++5sNUEQ30uL44YE31Xw8/msKH4kYzjC
         4ldBkuEZjLw9XNuBr0XUG7NzIjT3oWe+d2LHSvrjm56XAkj4FT5JaWb01qffrogwRmxt
         5qSYv4pBUA+LZp0zI3sCyu2+JDb9vDs+bVEUzg5T692UeI1fOiEsaRXB7XUIEYaI4Jag
         naMGvpqzqMD/xF9wqV6kFLZwXM+gPOdcevb03eZ9BJiJ3iET0l2Akzx4c6nLncYmlDR7
         rBUwN+t/JpPKUQ7I682A+MLpqkO+IrfzDUiJgzRMF+g5gDsXUeoG5/N3vzQZP4x71rr5
         EQ4Q==
X-Gm-Message-State: ANhLgQ0pW7QRTeuqugbiNE4hvu4KSpsma08X2Ny2wnLHe6op+92wPB6q
        SDfv1UNAwhHenOe4bvJXf3mEAYvRSCBlmCwqQc7P8w==
X-Google-Smtp-Source: ADFU+vv33qQ1Vs3CkoYzAvtrw3SpDVVFOXBI9ccyey4I0e0R2cgw4zlbjqPoifA6+u164sdMBKOHuMFJW3vErink/7Y=
X-Received: by 2002:a05:6830:57b:: with SMTP id f27mr3211846otc.363.1583946449937;
 Wed, 11 Mar 2020 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
In-Reply-To: <20200311062952.GA11519@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Mar 2020 10:07:18 -0700
Message-ID: <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:30 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 10, 2020 at 08:36:14PM -0700, Darrick J. Wong wrote:
> > 1) Leave the inode flag (FS_XFLAG_DAX) as it is, and export the S_DAX
> > status via statx.  Document that changes to FS_XFLAG_DAX do not take
> > effect immediately and that one must check statx to find out the real
> > mode.  If we choose this, I would also deprecate the dax mount option;
> > send in my mkfs.xfs patch to make it so that you can set FS_XFLAG_DAX on
> > all files at mkfs time; and we can finally lay this whole thing to rest.
> > This is the closest to what we have today.
> >
> > 2) Withdraw FS_XFLAG_DAX entirely, and let the kernel choose based on
> > usage patterns, hardware heuristics, or spiteful arbitrariness.
>
> 3) Only allow changing FS_XFLAG_DAX on directories or files that do
> not have blocks allocated to them yet, and side step all the hard
> problems.

This sounds reasonable to me.

As for deprecating the mount option, I think at a minimum it needs to
continue be accepted as an option even if it is ignored to not break
existing setups. We're currently going through the prolonged flag day
of people discovering that if they update xfsprogs they need to
specify "-m reflink=0" to mkfs.xfs. That pain seems to have only been
a road bump not a showstopper based on the bug reports I've seen. If
anything it has added helpful pressure towards getting reflink support
bumped up in the priority. Hopefully the xfs position that the dax
mount option can be ignored makes it possible to implement the same
policy on ext4, and we can just move on...

> Which of course still side steps the hard question of what it actually
> is supposed to mean..

If we have statx to indicate the effective dax-state that addresses
the pain for applications that want to account for dax in their page
cache pressure estimates, and lets FS_XFLAG_DAX not need to specify
precise semantics.
