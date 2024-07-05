Return-Path: <linux-fsdevel+bounces-23178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1C927FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 03:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C193A1C219FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A111CB8;
	Fri,  5 Jul 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEwPFGeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B0EEDD;
	Fri,  5 Jul 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143739; cv=none; b=kOALvTpgqBP9FPDnrJyl1HvWz/4MsK78E9UZToOCSDSlToDsm9zHwdO69bcDGWXL+FShKYCUgt627rlN2OQWxbFvVOvTL9VH/GfArEiuyYV52XTL74aCXcp8II8YIUbnKeiiR0W508v4ydu7K878REpfrMGcx00A02+Vkwno7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143739; c=relaxed/simple;
	bh=N9zCE5gbX4i5ttVLz8oCFLcEIsG1PazvLAoiqe9Aem0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVAXNWXXOzG3o4ynnGe/8S0zcBn5Zvp/MGUpV7JfBD+zCIvaauwOfc9RQOp9vA2wTzVMLVGKokl5xgt9owdNd347oAitR2KlzjsLVGVSjq6IVl+0jKey15eb2AoKX+UZ1N/i7KDDY3KKvNdfCWBomPNlNkkiLK4dtLtgQmhvQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEwPFGeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B0C3277B;
	Fri,  5 Jul 2024 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720143739;
	bh=N9zCE5gbX4i5ttVLz8oCFLcEIsG1PazvLAoiqe9Aem0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEwPFGeGYEqg+o5k1d89Y/mGxm/NLx4OHc5kltn+H67/o2Go6LDw4nbNfL1KkZMck
	 CRpVoCktz+zLeESUX0wI3udZIa14xqWEdpu9z4j+uRsH8gAgkOORnHaMwgynFif+2v
	 c5NXjo5Pf3rUb/trvX7Ee/2x0BpoJrT/gyEam6OciCVGCLhUvjSKwQLdRFD6XX6doj
	 IWUGZA81Dz0rapKjV3lsdUpkvhq8ybEuxFvDS3z0ZAYsKtgVbZFOOJsEXFrUwm2pcX
	 f0S9pdHddhyB6PsSi6TuXw/f5z9QvEwZZUiDkCxhn8ks9sBZ3RGSIQTwBL9eUtG24b
	 SJEVkUkpa2spA==
Date: Thu, 4 Jul 2024 21:42:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
Message-ID: <ZodPeeJzhZOtiUo1@kernel.org>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
 <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
 <ZocvhIoQfzzhp+mh@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZocvhIoQfzzhp+mh@dread.disaster.area>

On Fri, Jul 05, 2024 at 09:25:56AM +1000, Dave Chinner wrote:
> On Thu, Jul 04, 2024 at 07:00:23PM +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Jul 3, 2024, at 6:24 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > 
> > > I've been pondering security questions with localio - particularly
> > > wondering what questions I need to ask.  I've found three focal points
> > > which overlap but help me organise my thoughts:
> > > 1- the LOCALIO RPC protocol
> > > 2- the 'auth_domain' that nfsd uses to authorise access
> > > 3- the credential that is used to access the file
> > > 
> > > 1/ It occurs to me that I could find out the UUID reported by a given
> > > local server (just ask it over the RPC connection), find out the
> > > filehandle for some file that I don't have write access to (not too
> > > hard), and create a private NFS server (hacking nfs-ganasha?) which
> > > reports the same uuid and reports that I have access to a file with
> > > that filehandle.  If I then mount from that server inside a private
> > > container on the same host that is running the local server, I would get
> > > localio access to the target file.
> 
> This seems amazingly complex for something that is actually really
> simple.

Could be completely wrong, but I'm inferring you've read more
linux-nfs email (particularly about alternative directions for
implementation) than looked at the localio code.  But more below.

> Keep in mind that I am speaking from having direct
> experience with developing and maintaining NFS client IO bypass
> infrastructure from when I worked at SGI as an NFS engineer.

Thanks for sharing all this about IRIX, really helpful.

> So, let's look at the Irix NFS client/server and the "Bulk Data
> Service" protocol extensions that SGI wrote for NFSv3 back in the
> mid 1990s.  Here's an overview from the 1996 product documentation
> "Getting Started with BDSpro":
> 
> https://irix7.com/techpubs/007-3274-001.pdf
> 
> At least read chapter 1 so you grok the fundamentals of how the IO
> bypass worked. It should look familiar, because it isn't very
> different to how NFS over RDMA or client side IO for pNFS works.
> 
> Essentially, The NFS client transparently sent all the data IO (read
> and write) over a separate communications channel for any IO that
> met the size and alignment constraints. This was effectively a
> "remote-IO" bypass that streamed data rather than packetised it
> (NFS_READ/NFS_WRITE is packetised data with RTT latency issues).
> By getting rid of the round trip latency penalty, data could be
> sent/recieved at full network throughput rates.
> 
> [ As an aside, the BDS side channel was also the mechanism that used
> by SGI for NFS over RDMA with custom full stack network offload
> hardware back in the mid 1990s. NFS w/ BDS ran at about 800MB/s on
> those networks on machines with 200MHz CPUs (think MIPS r10k). ]
> 
> The client side userspace has no idea this low level protocol
> hijacking occurs, and it doesn't need to because all it changes
> is the read/write IO speed. The NFS protocol is still used for all
> authorisation, access checks, metadata operations, etc, and all that
> changes is how NFS_READ and NFS_WRITE operations are performed.
> 
> The local-io stuff is no different - we're just using a different
> client side IO path in kernel. We don't need a new protocol, nor do
> we need userspace to be involved *at all*.  The kernel NFS client
> can easily discover that it is on the same host as the server. The
> server already does this "client is on the same host", so both will
> then know they can *transparently* enable the localio bypass without
> involving userspace at all.
> 
> The NFS protocol still provides all the auth, creds, etc to allow
> the NFS client read and write access to the file. The NFS server
> provides the client with a filehandle build by the underlying
> filesystem for the file the NFS client has been permission to
> access.
> 
> The local filesystem will accept that filehandle from any kernel
> side context via the export ops for that filesystem. This provides
> a mechanism for the NFS client to convert that to a dentry
> and so open the file directly from the file handle. This is what the
> server already does, so it should be able to share the filehandle
> decode and open code from the server, maybe even just reach into the
> server export table directly....
> 
> IOWs, we don't need to care about whether the mount is visible to
> the NFS client - the filesystem *export* is visible to the *kernel*
> and the export ops allow unfettered filehandle decoding. Containers
> are irrelevant - the server has granted access to the file, and so
> the NFS client has effective permissions to resolve the filehandle
> directly..

IRIX sounds well engineered.  The Linux NFS code's interfaces aren't
so clean/precise.  The data structures are pretty tightly coupled (one
big struct nfs_client, nfs_server, nfsd_net, etc.  sunrpc's svc_rqst
in particular carries auth info that is used as part of the the wire
protocol business end -- so NFS auth is in the layer localio wants to
bypass).  And as such interfaces tend to do a lot of different tasks
on behalf of structures that carry the kitchen sink.

So retrofitting the Linux NFS and RPC code to allow a subset of the
NFS client and server code to be used isn't so clean.

But what you described IRIX did is pretty much what my localio series
provides, see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

(Always room for improvement, like I said to Christoph, especially on
the IO submission and handling side.. as you've seen it is doing
buffered IO and is synchronous.. really leaving performance lackluster
but lots of upside to be had making it async and support DIO).

> Fundamentally, this is the same permission and access model that
> pNFS is built on. Hence I don't understand why this local-io bypass
> needs something completely new and seemingly very complex...

pNFS doesn't need to have a direct role in any of this localio code,
but pNFS can use localio if it is enabled, e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=5e7bf77fbbecdbea0e6ae7174c97a69b11e3098a

Localio not being tightly coupled to pNFS enables localio to easily
support NFSv3.  NFSv3 support is a requirement and there is no reason
not to support it.

Anyway, I really think Neil's ideas for localio improvement are solid.
Especially factoring out the auth_domain to ensure bog standard NFS
authentication and security mechanisms used.  Though IMO the proposed
localio protocol changes aren't _really_ needed, but I also won't
fight to stop localio nfsd UUID sharing being more ephemeral and
risk-averse...

The only reason there is a sideband/auxilliary "localio protocol" is
the NFS protocol is very focused on enabling NFS spec implementation.
I actually framed it in terms of NFS encode and decode on the server
side and Chuck wanted me to make sure to decouple localio so that it
stood on its own (I agree with him, I just didn't think to do it that
way).  I just needed a a means to generate and get a UUID from the
server to anchor the mechanism for nfs_common to allow the client and
server to rendezvous, see:

nfs_common:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=cb542e791eda114adcc9291feb6c66a5ea338f7c
nfs server:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=877a8212c3af37b5ba32959275f4c49bfe805f24
nfs client:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=572b36de2bb1dde06d6da4488686c9fbbc79d7e1

Really quite simple.

And the pgio hooks used to branch to localio handling of READ, WRITE and
COMMIT are the interface point for then generating a kiocb and issuing
the IO accordingly (last 2 commits below):
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=46569e6d92a074188bb1f0090d36c327729ab418

But even the buffered and direct IO in nfsd are really tightly coupled
to the wire protocol interface.  So localio hooks pgio and calls down
to the underlying filesystem with its own side channel (that uses
.read_iter and .write_iter), see fs/nfs/localio.c
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=877a8212c3af37b5ba32959275f4c49bfe805f24
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next&id=4222309dac70e485f089738d0ffe9113b9a5a1e1

