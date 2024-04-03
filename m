Return-Path: <linux-fsdevel+bounces-15946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F33896085
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAB61F24223
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674910FD;
	Wed,  3 Apr 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="kiVK8Kn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+F0FSIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C617C8;
	Wed,  3 Apr 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103056; cv=none; b=cRdIAjl+5gweftcGBcLALaPLPHP7it4CybCsPpbJgP91k/QYqa1WQChs5UNdjl6uJbLjgG/CgYp3jxYMRqRoslMROS0vePhyyPw0NGHsFuj6EnuLWL903z+9JqieO6CYnmgwosabZmActpF/QattUKL6LLLK7QOjuvVM8PzCE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103056; c=relaxed/simple;
	bh=CrIldSifltW9z9RXdpcaCa3TxVQODRc8925iXulPPiY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=U/BjSajP/iyRaDSX6MP4dP6L7/0NPYVyU79jAJmRfUvzjkv2d3cfXdp26a8mkh2WepcplUqR1GhDr/QCtUdeKBTzg2Lj7HbYacGJWC+o+fNEKUZfTk0JnGorNCzAw0Xz8KwfmgL1UkdxFPrFSAkmAU/lODkjKeP3dvY5nSNYE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=kiVK8Kn3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+F0FSIi; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id B219718000A9;
	Tue,  2 Apr 2024 20:10:51 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 20:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712103051; x=1712189451; bh=IiRoYnk/VW
	3JxF37V/AuhIlxlMm5OpsLoRHRujHfwfE=; b=kiVK8Kn3esTAtBFDdfaY1193ql
	+rQjYcbaSuzHDIxnQbc9mC3OgxeLCy0cMK7O31mBCkjEvtWkigW5GtpCH5uRGTrc
	8LNzGj/k1t8lmVl4z0i1xtDqx4P2yVgEkiWzQ7vPghgpHQLr4marqqDFXHXW8DZf
	Xbn5sjl1jfkijhd3kfIPi9mgI1G1pi5pGlW9nGz6RAIGPYhkjgZ0IYBHBV2uvsYJ
	LboUftsIRo21FUtQ9GE/fC+nxwk3/MfLvGP0awNw4a7R0HP/9fSX06RsPS/ezKNB
	r5OL+cQkOIwNHSFOcHPi547lvyetHpZx0Oky95e3v3rWS3iQxiVYRO0ASbtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712103051; x=1712189451; bh=IiRoYnk/VW3JxF37V/AuhIlxlMm5
	OpsLoRHRujHfwfE=; b=Q+F0FSIi+Dfqeh3nOzrzOd9XZYXx7ialdoAL+TcKG8Z9
	K15XtT93Kwtw222dBaQC9cNh7Joo6MSysh7XGy77V0kY153H4NYiHTwOz76nBF8g
	neq+YVyXirbuhJ8De8bMmHSwu1zbUx3rjyVbCLoJN6IxJ3IPTak5lR73j5CXT6ih
	eqvUp4mEkrMAuKMuC9Kw0bHn5mnlgIX8bZGUBBwcx46fqpSfg7oBbAAphJqg050n
	bqs6WZ4YXXG+Y8RzLCaM77QJoOsTv5nZe9UU8B1WgKjhsNhIjSSHG6omtkeBtAd2
	g0cyFi3+tKwuh048cy4slf4rSJQX0j5ZtLAeh+NdhA==
X-ME-Sender: <xms:ip4MZt-ATHaBimGrd464a3CIP233pPJ47fHlGk6QdTtOPvS-1XOiUA>
    <xme:ip4MZhtV5ZG4mkY7aoAIumvOks0e--MM871GH1rt-koNeHfdRWDosvEkSCVId34BW
    MFDclLjKeZDVQxB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhjedutdehtdfgueeuledtkeefkedvgfevieefudetkeehffej
    gfeiheehkeegteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpeifrghlthgvrhhssehvvghrsghumhdrohhrgh
X-ME-Proxy: <xmx:ip4MZrDWX_-QOB_78KsRPQ2xjLVrZM3RMjBuo-EAoREl7n_cNIliFQ>
    <xmx:ip4MZhf106XwQCEJFV9e9NA8OOqAVGWEUA7mDBziTopBLvDNZL1NCg>
    <xmx:ip4MZiPJ6SjU159IvBXdKFiA-Pi_uov5Y90iybGK30v1rBauUcjOiw>
    <xmx:ip4MZjmyar2IQTYdJv8amsLJyE1xf3khL2bcE6kc6qzwvUN7spXCtg>
    <xmx:i54MZhdcinieZvn35D0R0VbSPOLph13oQ2dimrKgx7jNtOTCSrG0GSN4>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BAAE42A20090; Tue,  2 Apr 2024 20:10:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
In-Reply-To: <20240402225216.GW6414@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
 <20240402225216.GW6414@frogsfrogsfrogs>
Date: Tue, 02 Apr 2024 20:10:15 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Andrey Albershteyn" <aalbersh@redhat.com>, xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 "Alexander Larsson" <alexl@redhat.com>
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the fsverity
 metadata is damaged
Content-Type: text/plain

[cc alexl@, retained quotes for context]

On Tue, Apr 2, 2024, at 6:52 PM, Darrick J. Wong wrote:
> On Tue, Apr 02, 2024 at 04:00:06PM -0400, Colin Walters wrote:
>> 
>> 
>> On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
>> > From: Darrick J. Wong <djwong@kernel.org>
>> >
>> > There are more things that one can do with an open file descriptor on
>> > XFS -- query extended attributes, scan for metadata damage, repair
>> > metadata, etc.  None of this is possible if the fsverity metadata are
>> > damaged, because that prevents the file from being opened.
>> >
>> > Ignore a selective set of error codes that we know fsverity_file_open to
>> > return if the verity descriptor is nonsense.
>> >
>> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> > ---
>> >  fs/iomap/buffered-io.c |    8 ++++++++
>> >  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
>> >  2 files changed, 26 insertions(+), 1 deletion(-)
>> >
>> >
>> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> > index 9f9d929dfeebc..e68a15b72dbdd 100644
>> > --- a/fs/iomap/buffered-io.c
>> > +++ b/fs/iomap/buffered-io.c
>> > @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct 
>> > iomap_iter *iter,
>> >  	size_t poff, plen;
>> >  	sector_t sector;
>> > 
>> > +	/*
>> > +	 * If this verity file hasn't been activated, fail read attempts.  This
>> > +	 * can happen if the calling filesystem allows files to be opened even
>> > +	 * with damaged verity metadata.
>> > +	 */
>> > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
>> > +		return -EIO;
>> > +
>> >  	if (iomap->type == IOMAP_INLINE)
>> >  		return iomap_read_inline_data(iter, folio);
>> > 
>> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> > index c0b3e8146b753..36034eaefbf55 100644
>> > --- a/fs/xfs/xfs_file.c
>> > +++ b/fs/xfs/xfs_file.c
>> > @@ -1431,8 +1431,25 @@ xfs_file_open(
>> >  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
>> > 
>> >  	error = fsverity_file_open(inode, file);
>> > -	if (error)
>> > +	switch (error) {
>> > +	case -EFBIG:
>> > +	case -EINVAL:
>> > +	case -EMSGSIZE:
>> > +	case -EFSCORRUPTED:
>> > +		/*
>> > +		 * Be selective about which fsverity errors we propagate to
>> > +		 * userspace; we still want to be able to open this file even
>> > +		 * if reads don't work.  Someone might want to perform an
>> > +		 * online repair.
>> > +		 */
>> > +		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
>> > +			break;
>> 
>> As I understand it, fsverity (and dm-verity) are desirable in
>> high-safety and integrity requirement cases where the goal is for the
>> system to "fail closed" if errors in general are detected; anything
>> that would have the system be in an ill-defined state.
>
> Is "open() fails if verity metadata are trashed" a hard requirement?

I can't say authoritatively, but I do want to ensure we've dug into the semantics here, and I agree with Eric that it would make the most sense to have this be consistent across filesystems.

> Reads will still fail due to (iomap) readahead returning EIO for a file
> that is IS_VERITY() && !fsverity_active().  This is (afaict) the state
> you end up with when the fsverity open fails.  ext4/f2fs don't do that,
> but they also don't have online fsck so once a file's dead it's dead.

OK, right.  Allowing an open() but having read() fail seems like it doesn't weaken things too much in reality.  I think what makes me uncomfortable is the error-swallowing; but yes, in theory we should get the same or similar error on a subsequent read().

> <shrug> I don't know if regular (i.e. non-verity) xattrs are one of the
> things that get frozen by verity?  Storing fsverity metadata in private
> namespace xattrs is unique to xfs.

No, verity only covers file contents, no other metadata.  This is one of the rationales for composefs (e.g. ensuring things like the suid bit, security.selinux xattr etc. are covered as well as in general complete filesystem trees).

>> I hesitate to say it but maybe there should be some ioctl for online
>> repair use cases only, or perhaps a new O_NOVERITY special flag to
>> openat2()?
>
> "openat2 but without meddling from the VFS"?  Tempting... ;)

Or really any lower level even filesystem-specific API for the online fsck case.  
Adding a blanket new special case for all CAP_SYS_ADMIN processes covers a lot of things that don't need that.

