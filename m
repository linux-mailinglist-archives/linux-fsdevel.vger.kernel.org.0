Return-Path: <linux-fsdevel+bounces-1806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3DD7DEFF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8251C20EE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A913FFD;
	Thu,  2 Nov 2023 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfC4xEgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5513FEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE270C433C7;
	Thu,  2 Nov 2023 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698920974;
	bh=Re2dqNuKfkORzyb2wUhHbpPQHZvYeU32o2iRAeDKELk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VfC4xEgo6WkMO4eihMPrTH0TndVEUcC3iif+UuOMldW3locME58/MSs+rdhZ0esTY
	 ca1e3CquDqo8Oz1s+y3r/25OQjr0nH9agzlmoMG282uM5H7flQjxDCIcwA74lfE64q
	 x1GvEaUSHPuj6bPWY5KmYwWou5uCeMT7RxRPxXtFc83cT54IgyfV/Pqmn4hBZoF/TO
	 s6rAnmBEI2UBN+8vy3LVi32z1bYhhBYtWmeVPM+2VHwHJRWdUrGiS8LcyyewUdpwv7
	 nJugXB7iaxMHR7d0nuM8tBJdDEQUYFtSIxh3TXRyj8E45EJZmOM0EcI7G9LvqMgc2B
	 WNKJAiEY60Jog==
Message-ID: <eeb7e312410a5d6e362d1ac377005c7eaaf72925.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, Trond Myklebust
	 <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, 
 "jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "jstultz@google.com"
 <jstultz@google.com>,  "djwong@kernel.org" <djwong@kernel.org>,
 "brauner@kernel.org" <brauner@kernel.org>,  "chandan.babu@oracle.com"
 <chandan.babu@oracle.com>, "hughd@google.com" <hughd@google.com>, 
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dsterba@suse.com"
 <dsterba@suse.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>,  "tytso@mit.edu" <tytso@mit.edu>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "amir73il@gmail.com" <amir73il@gmail.com>,  "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "adilger.kernel@dilger.ca"
 <adilger.kernel@dilger.ca>, "kent.overstreet@linux.dev"
 <kent.overstreet@linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>, 
 "dhowells@redhat.com" <dhowells@redhat.com>, "jack@suse.de" <jack@suse.de>
Date: Thu, 02 Nov 2023 06:29:30 -0400
In-Reply-To: <ZULfQIdN146eZodE@dread.disaster.area>
References: <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
	 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
	 <ZUF4NTxQXpkJADxf@dread.disaster.area>
	 <20231101101648.zjloqo5su6bbxzff@quack3>
	 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
	 <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
	 <ZULfQIdN146eZodE@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 10:29 +1100, Dave Chinner wrote:
> On Wed, Nov 01, 2023 at 09:34:57PM +0000, Trond Myklebust wrote:
> > On Wed, 2023-11-01 at 10:10 -1000, Linus Torvalds wrote:
> > > The above does not expose *any* changes to timestamps to users, and
> > > should work across a wide variety of filesystems, without requiring
> > > any special code from the filesystem itself.
> > >=20
> > > And now please all jump on me and say "No, Linus, that won't work,
> > > because XYZ".
> > >=20
> > > Because it is *entirely* possible that I missed something truly
> > > fundamental, and the above is completely broken for some obvious
> > > reason that I just didn't think of.
> > >=20
> >=20
> > My client writes to the file and immediately reads the ctime. A 3rd
> > party client then writes immediately after my ctime read.
> > A reboot occurs (maybe minutes later), then I re-read the ctime, and
> > get the same value as before the 3rd party write.
> >=20
> > Yes, most of the time that is better than the naked ctime, but not
> > across a reboot.
>=20
> This sort of "crash immediately after 3rd party data write" scenario
> has never worked properly, even with i_version.
>=20
> The issue is that 3rd party (local) buffered writes or metadata
> changes do not require any integrity or metadata stability
> operations to be performed by the filesystem unless O_[D]SYNC is set
> on the fd, RWF_[D]SYNC is set on the IO, or f{data}sync() is
> performed on the file.
>=20
> Hence no local filesystem currently persists i_version or ctime
> outside of operations with specific data integrity semantics.
>=20
> nfsd based modifications have application specific persistence
> requirements and that is triggered by the nfsd calling
> ->commit_metadata prior to returning the operation result to the
> client. This is what persists i_version/timestamp changes that were
> made during the nfsd operation - this persistence behaviour is not
> driven by the local filesystem.
>=20
> IOWs, this "change attribute failure" scenario is an existing
> problem with the current i_version implementation.  It has always
> been flawed in this way but this didn't matter a decade ago because
> it's only purpose (and user) was nfsd and that had the required
> persistence semantics to hide these flaws within the application's
> context.
>
> Now that we are trying to expose i_version as a "generic change
> attribute", these persistence flaws get exposed because local
> filesystem operations do not have the same enforced persistence
> semantics as the NFS server.
>=20
> This is another reason I want i_version to die.
>=20
> What we need is a clear set of well defined semantics around statx
> change attribute sampling. Correct crash-recovery/integrity behaviour
> requires this rule:
>=20
>   If the change attribute has been sampled, then the next
>   modification to the filesystem that bumps change attribute *must*
>   persist the change attribute modification atomically with the
>   modification that requires it to change, or submit and complete
>   persistence of the change attribute modification before the
>   modification that requires it starts.
>=20
> e.g. a truncate can bump the change attribute atomically with the
> metadata changes in a transaction-based filesystem (ext4, XFS,
> btrfs, bcachefs, etc).
>=20
> Data writes are much harder, though. Some filesysetm structures can
> write data and metadata in a single update e.g. log structured or
> COW filesystems that can mix data and metadata like btrfs.
> Journalling filesystems require ordering between journal writes and
> the data writes to guarantee the change attribute is persistent
> before we write the data. Non-journalling filesystems require inode
> vs data write ordering.
>=20
> Hence I strongly doubt that a persistent change attribute is best
> implemented at the VFS - optimal, efficient implementations are
> highly filesystem specific regardless of how the change attribute is
> encoded in filesysetm metadata.
>=20
> This is another reason I want to change how the inode timestamp code
> is structured to call into the filesystem first rather than last.
> Different filesystems will need to do different things to persist
> a "ctime change counter" attribute correctly and efficiently -
> it's not a one-size fits all situation....

FWIW, the big danger for nfsd is is i_version rollback after a crash:

We can end up handing out an i_version value to the client before it
ever makes it to disk. If that happens, and the server crashes before it
ever makes it to disk, then the client can see the old i_version when it
queries it again (assuming the earlier write was lost).

That, in an of itself, is not a _huge_ problem for NFS clients. They'll
typically just invalidate their cache if that occurs and reread any data
they need.

The real danger is that you can have a write that occurs after the
reboot that is different from the earlier one and hand out a change
attribute that is a duplicate of the one viewed earlier. Now you have
the same change attribute that refers to two different states of the
file (and potential data corruption).

We mitigate that today by factoring in the ctime on regular files when
generating the change attribute (see nfsd4_change_attribute()). In
theory, i_version rolling back + a clock jump backward could generate
change attr collisions, even with that, but that's a bit harder to
contrive so we mostly don't worry about it.

I'm all for coming up with a way to make this more resilient though. If
we can offer the guarantee that you're proposing above, then that would
be a very nice thing.
--=20
Jeff Layton <jlayton@kernel.org>

