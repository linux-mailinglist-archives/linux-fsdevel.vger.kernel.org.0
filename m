Return-Path: <linux-fsdevel+bounces-736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4E7CF6C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF957282085
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0311947A;
	Thu, 19 Oct 2023 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBA7HSvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED719442
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A89C433C7;
	Thu, 19 Oct 2023 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697714932;
	bh=frnWz1sFRBQuYonb5RmQwPk5jf/lF7GP4WLN8JSXa7M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HBA7HSvGoIRn7e8pKkbEW9dLvkhR6UbP9YryXoyb0yOjeGBF3+t2/uXVAqhO8+5XZ
	 g0zjGzFjnXF/LfXiIIdiO8O+s2WH1DbOU5PxZHMy5BGmXDF1pxMFXw5belLfcYtN7H
	 99/gEqDLZv0OG5nrh2/sMZTcmW/PdfrhuOSXelnXPQnJC1BordF3CwVUQNbDT7FTNG
	 nn177O3fNCLQE2ooDHVnWEyFQh2gHAsFOuYPrlz1K/YrfOpU/ht9vUd3N/Bwu8Bm8m
	 10CRzoGlUcfNESgswU4BLKxSdAsGBM5bqEhUzQbS/iUBrFcZX0/oc11HUt7teGBqNa
	 7K8NLvWb7IZrw==
Message-ID: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz
 <jstultz@google.com>,  Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>,  "Darrick J.
 Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>,  Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Thu, 19 Oct 2023 07:28:48 -0400
In-Reply-To: <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
	 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
	 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > Back to your earlier point though:
> >=20
> > Is a global offset really a non-starter? I can see about doing somethin=
g
> > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> > as ktime_get_coarse_ts64. I don't see the downside there for the non-
> > multigrain filesystems to call that.
>=20
> I have to say that this doesn't excite me. This whole thing feels a bit
> hackish. I think that a change version is the way more sane way to go.
>=20

What is it about this set that feels so much more hackish to you? Most
of this set is pretty similar to what we had to revert. Is it just the
timekeeper changes? Why do you feel those are a problem?

> >=20
> > On another note: maybe I need to put this behind a Kconfig option
> > initially too?
>=20
> So can we for a second consider not introducing fine-grained timestamps
> at all. We let NFSv3 live with the cache problem it's been living with
> forever.
>=20
> And for NFSv4 we actually do introduce a proper i_version for all
> filesystems that matter to it.
>=20
> What filesystems exactly don't expose a proper i_version and what does
> prevent them from adding one or fixing it?

Certainly we can drop this series altogether if that's the consensus.

The main exportable filesystem that doesn't have a suitable change
counter now is XFS. Fixing it will require an on-disk format change to
accommodate a new version counter that doesn't increment on atime
updates. This is something the XFS folks were specifically looking to
avoid, but maybe that's the simpler option.

There is also bcachefs which I don't think has a change attr yet. They'd
also likely need a on-disk format change, but hopefully that's a easier
thing to do there since it's a brand new filesystem.

There are a smattering of lesser-used local filesystems (f2fs, nilfs2,
etc.) that have no i_version support. Multigrain timestamps would make
it simple to add better change attribute support there, but they can (in
principle) all undergo an on-disk format change too if they decide to
add one.

Then there are filesystems like ntfs that are exportable, but where we
can't extend the on-disk format. Those could probably benefit from
multigrain timestamps, but those are much lower priority. Not many
people sharing their NTFS filesystem via NFS anyway.
--=20
Jeff Layton <jlayton@kernel.org>

