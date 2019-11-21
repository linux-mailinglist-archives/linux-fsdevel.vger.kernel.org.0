Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAE1058D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKURyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:54:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38798 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKURyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:54:41 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xALHsJ6a011724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 12:54:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CA5FF4202FD; Thu, 21 Nov 2019 12:54:18 -0500 (EST)
Date:   Thu, 21 Nov 2019 12:54:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rich Felker <dalias@libc.org>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel@vger.kernel.org,
        musl@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [musl] getdents64 lost direntries with SMB/NFS and buffer size <
 unknown threshold
Message-ID: <20191121175418.GI4262@mit.edu>
References: <20191120001522.GA25139@brightrain.aerifal.cx>
 <8736eiqq1f.fsf@mid.deneb.enyo.de>
 <20191120205913.GD16318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120205913.GD16318@brightrain.aerifal.cx>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 03:59:13PM -0500, Rich Felker wrote:
> 
> POSIX only allows both behaviors (showing or not showing) the entry
> that was deleted. It does not allow deletion of one entry to cause
> other entries not to be seen.

Agreed, but POSIX requires this of *readdir*.  POSIX says nothing
about getdents64(2), which is Linux's internal implementation which is
exposed to a libc.

So we would need to see what is exactly going on at the interfaces
between the VFS and libc, the nfs client code and the VFS, the nfs
client code and the nfs server, and possibly the behavior of the nfs
server.

First of all.... you can't reproduce this on anything other than with
NFS, correct?  That is, does it show up if you are using ext4, xfs,
btrfs, etc.?

Secondly, have you tried this on more than one NFS server
implementation?

Finally, can you capture strace logs and tcpdump logs of the
communication between the NFS client and server code?

> > But many file systems simply provide not the necessary on-disk data
> > structures which are need to ensure stable iteration in the face of
> > modification of the directory.  There are hacks, of course, such as
> > compacting the on-disk directory only on file creation, which solves
> > the file removal case.

Oh, that's not the worst of it.  You have to do a lot more if the file
system needs to support telldir/seekdir, and if you want to export the
file system over NFS.  If you are using anything other than a linear
linked list implementation for your directory, you have to really turn
sommersaults to make sure things work (and work efficiently) in the
face of, say, node splits of you are using some kind of tree structure
for your directory.

Most file systems do get this right, at least if they hope to be
safely able to be exportable via NFS, or via CIFS using Samba.

       	       	  	     	      	 - Ted
