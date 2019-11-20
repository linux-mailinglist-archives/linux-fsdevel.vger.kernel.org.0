Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC8104568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 21:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKTU7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 15:59:18 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:50234 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKTU7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:59:18 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iXX4D-0001vK-00; Wed, 20 Nov 2019 20:59:13 +0000
Date:   Wed, 20 Nov 2019 15:59:13 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-fsdevel@vger.kernel.org, musl@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [musl] getdents64 lost direntries with SMB/NFS and buffer size <
 unknown threshold
Message-ID: <20191120205913.GD16318@brightrain.aerifal.cx>
References: <20191120001522.GA25139@brightrain.aerifal.cx>
 <8736eiqq1f.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736eiqq1f.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:57:32PM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> > An issue was reported today on the Alpine Linux tracker at
> > https://gitlab.alpinelinux.org/alpine/aports/issues/10960 regarding
> > readdir results from SMB/NFS shares with musl libc.
> >
> > After a good deal of analysis, we determined the root cause to be that
> > the second and subsequent calls to getdents64 are dropping/skipping
> > direntries (that have not yet been deleted) when some entries were
> > deleted following the previous call. The issue appears to happen only
> > when the buffer size passed to getdents64 is below some threshold
> > greater than 2k (the size musl uses) but less than 32k (the size glibc
> > uses, with which we were unable to reproduce the issue).
> 
> >From the Gitlab issue:
> 
>   while ((dp = readdir(dir)) != NULL) {
>       unlink(dp->d_name);
>       ++file_cnt;
>   }
> 
> I'm not sure that this is valid code to delete the contents of a
> directory.  It's true that POSIX says this:

I think it is.

> | If a file is removed from or added to the directory after the most
> | recent call to opendir() or rewinddir(), whether a subsequent call
> | to readdir() returns an entry for that file is unspecified.
                                  ^^^^^^^^^^^^^

POSIX only allows both behaviors (showing or not showing) the entry
that was deleted. It does not allow deletion of one entry to cause
other entries not to be seen.

> But many file systems simply provide not the necessary on-disk data
> structures which are need to ensure stable iteration in the face of
> modification of the directory.  There are hacks, of course, such as
> compacting the on-disk directory only on file creation, which solves
> the file removal case.
> 
> For deleting an entire directory, that is not really a problem because
> you can stick another loop around this while loop which re-reads the
> directory after rewinddir.  Eventually, it will become empty.

This is still a serious problem and affects usage other than deletion
of an entire directory.

Rich
