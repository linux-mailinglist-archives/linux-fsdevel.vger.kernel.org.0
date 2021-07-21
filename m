Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4034F3D16E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGUSdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhGUSdk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E645461029;
        Wed, 21 Jul 2021 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626894857;
        bh=npzfqeWI+4wHmooiuXhmsobgpIf7M3e1QSXcBc2VOFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMgqpW82XepnaU3tx1qyH8jfdiE+LcTzt2JiQDOd9Wa+uQ3cXKajKygd1jg7cwFBY
         CbVfBnItw8ml9JHwBkhNFw3TGA5YEFMiFnqgk5EUcgUGgTm57F15GF8oevGbPYhZba
         dLRdpMXPXQSxnF3cy+siAa8kpr2cvERDzcLA3wC0grsmlkOpUIwsRVUEm3m2WSOZzq
         LVog9jP4i6iy3oFN66jnzPbzmQixeJ9J9LgPXhjOjQKW/FeXUC9O+QmA6ZBKKe5f+0
         +J1BziRWX6s/BtYX1kXry5omvAd+elLKXX+sAburafwxrWAM+VKOodXseQ1SIMEyrm
         DJOyG7H5HFRDA==
Date:   Wed, 21 Jul 2021 12:14:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <20210721191416.GC8572@magnolia>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPhbU/umyUZLdxIw@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 06:37:23PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> > ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> > minix_super_block pointer
> > sbi->s_ms = ms;
> > sbi->s_sbh = bh;
> > sbi->s_mount_state = ms->s_state;
> > sbi->s_ninodes = ms->s_ninodes;
> > sbi->s_nzones = ms->s_nzones;
> > sbi->s_imap_blocks = ms->s_imap_blocks;
> > sbi->s_zmap_blocks = ms->s_zmap_blocks;
> > sbi->s_firstdatazone = ms->s_firstdatazone;
> > sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> > set sbi->s_log_zone_size
> 
> So what you're saying is that if you construct a malicious minix image,
> you can produce undefined behaviour?  That's not something we're
> traditionally interested in, unless the filesystem is one customarily
> used for data interchange (like FAT or iso9660).

Sounds to me like butt3rflyh4ck is volunteering to rebuild fs/minix with
proper ondisk metadata buffer verifiers.

--D
