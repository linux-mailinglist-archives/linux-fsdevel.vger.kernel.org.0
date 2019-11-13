Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7CFB9E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKMUbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 15:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfKMUbu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:31:50 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2A2206EC;
        Wed, 13 Nov 2019 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573677109;
        bh=05ooIT3YbJ/fHw6k555x4s32E0dixclBOdSSgJz8rso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0mHiSipc5QBPv7QRZhJSWtDlMjLjk4z2sj+8cfsJMlOx/sVhBWJ8dS/+N7+yNVDb
         KF55x6fWjF9icemuoHDIDMBKOw2FsurKp16lRC1XNpJ6c7gHewEtwBegNRXI6heVW6
         48kWapw6ynxD6/+2aK+SQYPQ3WRFiOxsU29zFvvY=
Date:   Wed, 13 Nov 2019 12:31:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     walter harms <wharms@bfs.de>
Cc:     linux-man@vger.kernel.org, darrick.wong@oracle.com,
        dhowells@redhat.com, jaegeuk@kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
Subject: Re: [man-pages RFC PATCH] statx.2: document STATX_ATTR_VERITY
Message-ID: <20191113203145.GH221701@gmail.com>
Mail-Followup-To: walter harms <wharms@bfs.de>, linux-man@vger.kernel.org,
        darrick.wong@oracle.com, dhowells@redhat.com, jaegeuk@kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
References: <20191107014420.GD15212@magnolia>
 <20191107220248.32025-1-ebiggers@kernel.org>
 <5DC525E8.4060705@bfs.de>
 <20191108193557.GA12997@gmail.com>
 <5DC714DB.9060007@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC714DB.9060007@bfs.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 09, 2019 at 08:34:51PM +0100, walter harms wrote:
> Am 08.11.2019 20:35, schrieb Eric Biggers:
> > On Fri, Nov 08, 2019 at 09:23:04AM +0100, walter harms wrote:
> >>
> >>
> >> Am 07.11.2019 23:02, schrieb Eric Biggers:
> >>> From: Eric Biggers <ebiggers@google.com>
> >>>
> >>> Document the verity attribute for statx().
> >>>
> >>> Signed-off-by: Eric Biggers <ebiggers@google.com>
> >>> ---
> >>>  man2/statx.2 | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> RFC since the kernel patches are currently under review.
> >>> The kernel patches can be found here:
> >>> https://lkml.kernel.org/linux-fscrypt/20191029204141.145309-1-ebiggers@kernel.org/T/#u
> >>>
> >>> diff --git a/man2/statx.2 b/man2/statx.2
> >>> index d2f1b07b8..713bd1260 100644
> >>> --- a/man2/statx.2
> >>> +++ b/man2/statx.2
> >>> @@ -461,6 +461,10 @@ See
> >>>  .TP
> >>>  .B STATX_ATTR_ENCRYPTED
> >>>  A key is required for the file to be encrypted by the filesystem.
> >>> +.TP
> >>> +.B STATX_ATTR_VERITY
> >>> +The file has fs-verity enabled.  It cannot be written to, and all reads from it
> >>> +will be verified against a Merkle tree.
> >>
> >> Using "Merkle tree" opens a can of worm and what will happen when the methode will change ?
> >> Does it matter at all ? i would suggest "filesystem" here.
> >>
> > 
> > Fundamentally, fs-verity guarantees that all data read is verified against a
> > cryptographic hash that covers the entire file.  I think it will be helpful to
> > convey that here, e.g. to avoid confusion with non-cryptographic, individual
> > block checksums supported by filesystems like btrfs and zfs.
> > 
> > Now, the only sane way to implement this model is with a Merkle tree, and this
> > is part of the fs-verity UAPI (via the file hash), so that's where I'm coming
> > from here.  Perhaps the phrase "Merkle tree" could be interpreted too strictly,
> > though, so it would be better to emphasize the more abstract model.  How about
> > the following?:
> > 
> > 	The file has fs-verity enabled.  It cannot be written to, and all reads
> > 	from it will be verified against a cryptographic hash that covers the
> > 	entire file, e.g. via a Merkle tree.
> > 
> 
> "feels" better,. but from a programmers perspective it is important at what level
> this is actually done. To see my point look at the line before.
> "encrypted by the filesystem" mean i have to read the documentation of the fs first
> so if encryption is supported at all. Or do i think to complicated ?
> 

It's filesystem-specific whether encryption and verity are supported.  I'm not
sure what your concern is, as statx() won't return the bits if the filesystem
doesn't support them.

Also note, if someone really wants the details about fscrypt and fsverity, they
really should read the documentation we maintain in the kernel tree [1][2].

[1] https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html
[2] https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

- Eric
