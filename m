Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309B315E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhBJEEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 23:04:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34724 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229969AbhBJEEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:04:48 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11A43jtE014659
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Feb 2021 23:03:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5627215C3601; Tue,  9 Feb 2021 23:03:45 -0500 (EST)
Date:   Tue, 9 Feb 2021 23:03:45 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Message-ID: <YCNbIdCsAsNcPuAL@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
 <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu>
 <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:03:10PM -0700, Andreas Dilger wrote:
> Depending on the size of the "escape", it probably makes sense to move
> toward having e2fsck migrate from the current mechanism to using dirdata
> for all deployments.  In the current implementation, tools don't really
> know for sure if there is data beyond the filename in the dirent or not.

It's actually quite well defined.  If dirdata is enabled, then we
follow the dirdata rules.  If dirdata is *not* enabled, then if a
directory inode has the case folding and encryption flags set, then
there will be cryptographic data immediately following the filename.
Otherwise, there is no valid data after the filename.

> For example, what if casefold is enabled on an existing filesystem that
> already has an encrypted directory?  Does the code _assume_ that there is
> a hash beyond the name if the rec_len is long enough for this?

No, we will only expect there to be a hash beyond the name if
EXT4_CASEFOLD_FL and EXT4_ENCRYPT_FL flags are set on the inode.  (And
if the rec_len is not large enough, then that's a corrupted directory
entry.)

> I guess it is implicit with the casefold+encryption case for dirents in
> directories that have the encryption flag set in a filesystem that also
> has casefold enabled, but it's definitely not friendly to these features
> being enabled on an existing filesystem.

No, it's fine.  That's because the EXT4_CASEFOLD_FL inode flag can
only be set if the EXT4_FEATURE_INCOMPAT_CASEFOLD is set in the
superblock, and EXT4_ENCRYPT_FL inode flag can only be set if
EXT4_FEATURE_INCOMPAT_ENCRYPT is set in the superblock, this is why it
will be safe to enable of these features, since merely enabling the
file system features only allows new directories to be created with
both CASEFOLD_FL and ENCRYPT_FL set.

The only restriction we would have is a file system has both the case
folding and encryption features, it will *not* be safe to set the
dirdata feature flag without first scanning all of the directories to
see if there are any directories that have both the casefold and
encrypt flags set on that inode, and if so, to convert all of the
directory entries to use dirdata.  I don't think this is going to be a
significant restriction in practice, though.

						- Ted


