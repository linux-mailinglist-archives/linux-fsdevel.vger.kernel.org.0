Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8AF26DEA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgIQOqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:46:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgIQOY7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:24:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0339868BEB; Thu, 17 Sep 2020 16:12:58 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:12:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
Message-ID: <20200917141257.GB27653@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917112830.26606-3-avarab@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  core.fsyncObjectFiles::
> +	This boolean will enable 'fsync()' when writing loose object
> +	files. Both the file itself and its containng directory will
> +	be fsynced.
> ++
> +When git writes data any required object writes will precede the
> +corresponding reference update(s). For example, a
> +linkgit:git-receive-pack[1] accepting a push might write a pack or
> +loose objects (depending on settings such as `transfer.unpackLimit`).
> ++
> +Therefore on a journaled file system which ensures that data is
> +flushed to disk in chronological order an fsync shouldn't be
> +needed. The loose objects might be lost with a crash, but so will the
> +ref update that would have referenced them. Git's own state in such a
> +crash will remain consistent.

While this is much better than what we had before I'm not sure it is
all that useful.  The only file system I know of that actually had the
above behavior was ext3, and the fact that it always wrote back that
way made it a complete performance desaster.  So even mentioning this
here will probably create a lot more confusion than actually clearing
things up.

> ++
> +This option exists because that assumption doesn't hold on filesystems
> +where the data ordering is not preserved, such as on ext3 and ext4
> +with "data=writeback". On such a filesystem the `rename()` that drops
> +the new reference in place might be preserved, but the contents or
> +directory entry for the loose object(s) might not have been synced to
> +disk.

As well as just about any other file system.  Which is another argument
on why it needs to be on by default.  Every time I install a new
development system (aka one that often crashes) and forget to enable
the option I keep corrupting my git repos.  And that is with at least
btrfs, ext4 and xfs as it is pretty much by design.

> +However, that's highly filesystem-dependent, on some filesystems
> +simply calling fsync() might force an unrelated bulk background write
> +to be serialized to disk. Such edge cases are the reason this option
> +is off by default. That default setting might change in future
> +versions.

Again the only "some file system" that was widely used that did this
was ext3.  And ext3 has long been removed from the Linux kernel..
