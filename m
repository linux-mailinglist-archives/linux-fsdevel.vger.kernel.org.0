Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F5B3E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfIPQLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 12:11:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59781 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbfIPQLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:11:07 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8GGAtcM010807
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 12:10:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 18DBD420811; Mon, 16 Sep 2019 12:10:55 -0400 (EDT)
Date:   Mon, 16 Sep 2019 12:10:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Michael Halcrow <mhalcrow@google.com>,
        "Theodore Y. Ts'o" <tytso@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: IMA on remote file systems
Message-ID: <20190916161054.GB4553@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <FA4C0F15-EE0A-4231-8415-A035C1CF3E32@oracle.com>
 <1568583730.5055.36.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568583730.5055.36.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 15, 2019 at 05:42:10PM -0400, Mimi Zohar wrote:
> > > My thought was to use an ephemeral Merkle tree for NFS (and
> > > possibly other remote filesystems, like FUSE, until these
> > > filesystems support durable per-file Merkle trees). A tree would
> > > be constructed when the client measures a file, but it would not
> > > saved to the filesystem. Instead of a hash of the file's contents,
> > > the tree's root signature is stored as the IMA metadata.
> > > 
> > > Once a Merkle tree is available, it can be used in exactly the
> > > same way that a durable Merkle tree would, to verify the integrity
> > > of individual pages as they are used, evicted, and then read back
> > > from the server.
> > > 
> > > If the client needs to evict part or all of an ephemeral tree, it
> > > can subsequently be reconstructed by measuring the file again and
> > > verifying its root signature against the stored IMA metadata.

Where would the client store the ephemeral tree?  If you're thinking
about storing in memory, calculating the emphemeral tree would require
dragging the entire file across the network, which is going to be just
as bad as using IMA --- plus the CPU cost of calculating the Merkle
tree, and the memory cost of storing the ephemeral Merkle tree.

I suspect that for most clients, it wouldn't be worth it unless the
client can store the ephemeral tree *somewhere* on the client's local
persistent storage, or maybe if it could store the Merkle tree on the
NFS server (maybe via an xattr which contains the pathname to the
Merkle tree relative to the NFS mount point?).

> > > So the only difference here is that the latency-to-first-byte
> > > benefit of a durable Merkle tree would be absent.

What problem are you most interested in solving?  And what cost do you
think the user will be willing to pay in order to solve that problem?

> I like the idea, but there are a couple of things that need to happen
> first.  Both fs-verity and IMA appended signatures need to be
> upstreamed.

Eric has sent the pull request fs-verity today.

>  The IMA appended signature support simplifies
> ima_appraise_measurement(), paving the way for adding IMA support for
> other types of signature verification.  How IMA will support fs-verity 
> signatures still needs to be defined.  That discussion will hopefully
> include NFS support.

As far as using the Merkle tree root hash for the IMA measurement,
what sort of policy should be used for determining when the Merkle
tree root hash should be used in preference to reading and checksuming
the whole file when it is first opened?  It could be as simple as, "if
this is a fs-verity, use the fs-verity Merkle root".  Is that OK?

     	  	     	     	       	      - Ted
