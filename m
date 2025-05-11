Return-Path: <linux-fsdevel+bounces-48689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D64AB2C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AF71896304
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD626158F;
	Sun, 11 May 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QS1GBbxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623F1A0BD0
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747006057; cv=none; b=LwFYBxZ7E2N9MdGSeud9crXLmik+0D8Sy1M/n8PJ4IGhIcuLQSZzy2NZxroU9RdX/6cp1bq/LIXF9AgqBCB+v+ozc4qxWj11mFpU8JCe6pyEtF8cTZzPJ1jq9Q1ZBqEmR7GneVXn9oWNy7QbTpVHrCJjtL0LeVgBB+u61Bp9VtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747006057; c=relaxed/simple;
	bh=ix+2xsDkJVHQ1lvSOu4E8j5KGIUAJcPmPm+E7RtJS/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZAryK85Inw4cNsq/2d3lLvd0ah/3kKwgeLZpTkUcOqDsSW/TvyQIu2eSr/z1RDxbxgYaIWWY9tSqk9XZN/18GNea/1TzcPcKZAbRqF52k5xhUVleMBPLM/VsAobDofmU2iaXsytvWh3KnNDvt8dWbF2XIn7PsP+suSyzESDxf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QS1GBbxF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cxVFMVmfciEHEZnGDa+QeVbID9I0w+eCH+evKX0d3lk=; b=QS1GBbxFWbxAlN1tPf2I2XM2p+
	z4ZWEjSJg7z6MWTyoTe/zhZilka6bjSqGnuoPqt9+JZgjh7RTonNxjShuLY5JPy/1A5iurXdfqDXT
	nfclkN1uHW3LuhEC6UgluSsyQ8CdbNPkCNoA5U+ZRk/Sd+fDYACg+mbPBEb8rX2cVe6FEwSiQKnA+
	pubre+NQiL1tkQRT5PK0GU5WW7zFlxSIVzRaSq9h5FO7oz5IWKzA0iN8Mf18jCWp71bAkbF2H/Zhq
	1SX7kevlyPcfg9DsfG0X3vsPoNTNeX+kz8fcWJmZlWIjIbbMcJYhJztqViAFb5Vqau1VndsqhLE2v
	AOyutjmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEG4y-0000000BiC2-1p4C;
	Sun, 11 May 2025 23:27:32 +0000
Date: Mon, 12 May 2025 00:27:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [BUG] propagate_umount() breakage
Message-ID: <20250511232732.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

reproducer:
------------------------------------------------------------
# create a playground
mkdir /tmp/foo
mount -t tmpfs none /tmp/foo
mount --make-private /tmp/foo
cd /tmp/foo

# set one-way propagation from A to B
mkdir A
mkdir B
mount -t tmpfs none A
mount --make-shared A
mount --bind A B
mount --make-slave B

# A/1 -> B/1, A/1/2 -> B/1/2
mkdir A/1
mount -t tmpfs none A/1
mkdir A/1/2
mount -t tmpfs none A/1/2

# overmount the entire B/1/2
mount -t tmpfs none B/1/2

# make sure it's busy - set a mount at B/1/2/x
mkdir B/1/2/x
mount -t tmpfs none B/1/2/x

stat B/1/x # shouldn't exist

umount -l A/1

stat B/1/x # ... and now it does
------------------------------------------------------------

What happens is that mounts on B/1 and B/1/2 had been considered
as victims - and taken out, since the overmount on top of B/1/2
overmounted the root of the first mount on B/1/2 and it got
reparented - all the way to B/1.

Correct behaviour would be to have B/1 left in place and upper
B/1/2 to be reparented once.

As an aside, that's a catch from several days of attempts to prove
correctness of propagate_umount(); I'm still not sure there's
nothing else wrong with it.  _Maybe_ it's the only problem in
there, but reconstructing the proof of correctness has turned
out to be a real bitch ;-/

I seriously suspect that a lot of headache comes from trying
to combine collecting the full set of potential victims with
deciding what can and what can not be taken out - gathering
all of them first would simplify things.  First pass would've
logics similar to your variant, but without __propagate_umount()
part[*]

After the set is collected, we could go through it, doing the
something along the lines of
	how = 0
	for each child in children(m)
		if child in set
			continue
		how = 1
		if child is not mounted on root
			how = 2
			break
	if how == 2
		kick_out_ancestors(m)
		remove m itself from set // needs to cooperate with outer loop
	else if how == 1
		for (p = m; p in set && p is mounted on root; p = p->mnt_parent)
			;
		if p in set
			kick_out_ancestors(p)
	else if children(m) is empty && m is not locked	// to optimize things a bit
		commit to unmounting m (again, needs to cooperate with the outer loop)

"Cooperate with the outer loop" might mean something like
having this per-element work leave removal of its argument to
caller and report whether its argument needs to be removed.

After that we'd be left with everything still in the set
having no out-of-set children that would be obstacles.
The only thing that remains after that is MNT_LOCKED and
that's as simple as
	while set is not empty
		m = first element of set
		for (p = m; p is locked && p in set; p = p->mnt_parent)
			;
		if p not in set {
			if p is not committed to unmount
				remove everything from m to p from set
				continue
		} else {
			p = p->mnt_parent
		}
		commit everything from m to p to unmount, removing from set

I'll try to put something of that sort together, along with
detailed explanation of what it's doing - in D/f/*, rather than
buring it in commit messages, and along with "read and update
D/f/... if you are ever touch this function" in fs/pnode.c itself;
this fun is not something I would like to repeat several years
down the road ;-/

We *REALLY* need a good set of regression tests for that stuff.
If you have anything along those lines sitting somewhere, please
post a reference.  The same goes for everybody else who might
have something in that general area.


[*] well, that and with fixed skip_propagation_subtree() logics; it's
easier to combine it with propagation_next() rather than trying to set
the things up so that the next call of propagation_next() would DTRT -
it's less work and yours actually has a corner case if the last element
of ->mnt_slave_list has non-empty ->mnt_slave_list itself.

