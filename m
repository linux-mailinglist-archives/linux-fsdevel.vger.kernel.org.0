Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4A3DB03D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 02:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhG3AZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 20:25:47 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42656 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhG3AZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:25:47 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9GLC-0052tv-VI; Fri, 30 Jul 2021 00:25:31 +0000
Date:   Fri, 30 Jul 2021 00:25:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
Message-ID: <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742546548.32498.10889023150565429936.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> /proc/$PID/mountinfo contains a field for the device number of the
> filesystem at each mount.
> 
> This is taken from the superblock ->s_dev field, which is correct for
> every filesystem except btrfs.  A btrfs filesystem can contain multiple
> subvols which each have a different device number.  If (a directory
> within) one of these subvols is mounted, the device number reported in
> mountinfo will be different from the device number reported by stat().
> 
> This confuses some libraries and tools such as, historically, findmnt.
> Current findmnt seems to cope with the strangeness.
> 
> So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
> provided.  As there is no STATX flag to ask for the device number, we
> pass a request mask for zero, and also ask the filesystem to avoid
> syncing with any remote service.

Hard NAK.  You are putting IO (potentially - network IO, with no upper
limit on the completion time) under namespace_sem.

This is an instant DoS - have a hung NFS mount anywhere in the system,
try to cat /proc/self/mountinfo and watch a system-wide rwsem held shared.
From that point on any attempt to take it exclusive will hang *AND* after
that all attempts to take it shared will do the same.

Please, fix BTRFS shite in BTRFS.  Without turning a moderately unpleasant
problem (say, unplugged hub on the way to NFS server) into something that
escalates into buggered clients.  Note that you have taken out any possibility
to e.g. umount -l /path/to/stuck/mount, along with any chance of clear shutdown
of the client.  Not going to happen.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
