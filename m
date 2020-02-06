Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1609153EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBFGyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 01:54:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51180 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFGyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:54:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izb3P-0089QE-Ua; Thu, 06 Feb 2020 06:54:24 +0000
Date:   Thu, 6 Feb 2020 06:54:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Namjae Jeon' <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de,
        'Christoph Hellwig' <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] exfat: update file system parameter handling
Message-ID: <20200206065423.GZ23230@ZenIV.linux.org.uk>
References: <297144.1580786668@turing-police>
 <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com>
 <20200204060654.GB31675@lst.de>
 <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
 <252365.1580963202@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <252365.1580963202@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:26:42PM -0500, Valdis Klētnieks wrote:
> On Tue, 04 Feb 2020 15:53:38 +0900, "Namjae Jeon" said:
> > > > Al Viro recently reworked the way file system parameters are handled
> > > > Update super.c to work with it in linux-next 20200203.
> 
> > Acked-by: Namjae Jeon <namjae.jeon@samsung.com>
> >
> > If I need to make v14 patch series for this, Let me know it.
> 
> Hmm... That's a process/git question that somebody else (probably Al Viro) will
> have to answer.
> 
> fs/exfat/super.c won't compile on next-20200203 or later without the patch, and
> as a practical matter the version that finally goes into the main tree will need the patch.
> 
> On the one hand, the proper way to track the history of that patch would be to
> cherry-pick it into the proper spot in your patch series, right after the
> commit that adds super.c.  Then the git history reflects what code came from
> where.
> 
> On the other hand, it leaves a really small window where a git bisect can land
> exactly on the commit that adds the unpatched version of super.c and fail to
> buiild.  If all the Signed-off-by's were from one person, the obvious answer is
> to fold the fix into the commit that adds super.c - but that loses the git
> history.
> 
> So I'm going to dodge the question by saying "What would Al Viro do?" :)

	The situation with #work.fs_parse is simple: I'm waiting for NFS series
to get in (git://git.linux-nfs.org/projects/anna/linux-nfs.git, that is).
 As soon as it happens, I'm sending #work.fs_parse + merge with nfs stuff +
fixups for said nfs stuff (as in
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=c354ed1)
to Linus.  In case Anna decides to skip this cycle (and I've seen nothing that
might indicates that), I will just send #work.fs_parse as-is.

	I *can* rebase #work.fs_parse on top of NFS series (and vboxsf, and
exfat, etc.) and send it to Linus right before -rc1, with obviously identical
final state.  That would avoid all issues with bisect hazards, but Linus is
usually unhappy about rebases.  And bisect hazard window is narrow...

	Again, I've no problem with such rebase (hell, with additional
branch ending in the same tree as #merge.nfs-fs_parse, verifiable by
simple git diff - compare vfs.git merge.nfs-fs_parse.0 and
merge.nfs-fs_parse.1, the latter being a rebase on top of #nfs-next).
Linus, up to you...
