Return-Path: <linux-fsdevel+bounces-79868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILSOJIghr2myOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:37:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55262240292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E64E130804C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB5413222;
	Mon,  9 Mar 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcp0vPvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0093CD8CF;
	Mon,  9 Mar 2026 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084790; cv=none; b=YrmcK+K48cMLg+lSiTXuEyZA2pFi/6CEfznC7jQ3TmzBB070Jaw1la8T4rtClcWya2jIu3j0QkFvWLGfkKjlLry4/fc/Tm6STwsZtjlyiKpVDxbbkUhecnl1kIGs+B8jFtvOPPVI7fU+Z1/Qx4vLvCw7IHBV4itS//Rapra7Fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084790; c=relaxed/simple;
	bh=pvOA7z7LAJ55Pql7T2iOG6EB9ez/gWB7V9MCZ/Zjlxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R10h2takzT4WfXB/HRJfaS2ovo4iEFbENGxwpJqY5Sqp+GpwnjoojMnnAkWl/pcbTtBdJnLVZUBYKjPhJln4/P/uQz218QoNPa7+z4WSYRBiYivk4zNeQ+fwi3rClHWMoiA3gYlOC5xjNdQls7unYiUyYfijHmuHJhCiL99SSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcp0vPvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAE9C4CEF7;
	Mon,  9 Mar 2026 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084789;
	bh=pvOA7z7LAJ55Pql7T2iOG6EB9ez/gWB7V9MCZ/Zjlxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zcp0vPvGFcZ64z2raW4wDIh6j/XTTVgNcxeU6VWNbEqd3gJuDkjSzkOpsspUcVCKQ
	 lcc1XL1FP2pWRLr+NlaKDAMpjvtN9zBII7AcLdNk1bPWn1WQKp7bbcxfLC/m9pPB/N
	 IEY6Fnduwj/32EH8XBInBsK25APHGZx6v+VZKXH5b9MOO4KRs2f/HfKETxZ6bQRWF5
	 dtM/8cl3v/DJKwm6MrSDpPIxnE4JZ94CyZpQ5RFLZk1zEcO5rifdFzuz9yWMRlnl0P
	 Cw7l0xykXbtHms2rm+pFvFKz7om9OVETWDWxVlg6TPC/S9c57HXwELizpEeZDVP7VL
	 zdDmzqN6JLEqg==
Message-ID: <dd3f9873c7939fba0ca2366effd24e4b6326f17b.camel@kernel.org>
Subject: Re: [PATCH v3 00/12] vfs: change inode->i_ino from unsigned long to
 u64
From: Jeff Layton <jlayton@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 autofs@vger.kernel.org, 	ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, 	linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, 	linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	selinux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 	linaro-mm-sig@lists.linaro.org,
 netdev@vger.kernel.org, 	linux-perf-users@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, 	linux-xfs@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-x25@vger.kernel.org, 
	audit@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 09 Mar 2026 15:33:03 -0400
In-Reply-To: <c9500adc562665d44feaca9206f23a5ba07432c1.camel@linux.ibm.com>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
			 <05b5d55c49b5a1bbc43a5315e3c84872e7e634b3.camel@linux.ibm.com>
		 <f22758116dabd3c135a833bcb5cfcd2ea4f6ecf4.camel@kernel.org>
	 <c9500adc562665d44feaca9206f23a5ba07432c1.camel@linux.ibm.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 55262240292
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79868-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 15:00 -0400, Mimi Zohar wrote:
> On Mon, 2026-03-09 at 13:59 -0400, Jeff Layton wrote:
> > On Mon, 2026-03-09 at 13:47 -0400, Mimi Zohar wrote:
> > > [ I/O socket time out.  Trimming the To list.]
> > >=20
> > > On Wed, 2026-03-04 at 10:32 -0500, Jeff Layton wrote:
> > > > This version squashes all of the format-string changes and the i_in=
o
> > > > type change into the same patch. This results in a giant 600+ line =
patch
> > > > at the end of the series, but it does remain bisectable.  Because t=
he
> > > > patchset was reorganized (again) some of the R-b's and A-b's have b=
een
> > > > dropped.
> > > >=20
> > > > The entire pile is in the "iino-u64" branch of my tree, if anyone i=
s
> > > > interested in testing this.
> > > >=20
> > > >     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.g=
it/
> > > >=20
> > > > Original cover letter follows:
> > > >=20
> > > > ----------------------8<-----------------------
> > > >=20
> > > > Christian said [1] to "just do it" when I proposed this, so here we=
 are!
> > > >=20
> > > > For historical reasons, the inode->i_ino field is an unsigned long,
> > > > which means that it's 32 bits on 32 bit architectures. This has cau=
sed a
> > > > number of filesystems to implement hacks to hash a 64-bit identifie=
r
> > > > into a 32-bit field, and deprives us of a universal identifier fiel=
d for
> > > > an inode.
> > > >=20
> > > > This patchset changes the inode->i_ino field from an unsigned long =
to a
> > > > u64. This shouldn't make any material difference on 64-bit hosts, b=
ut
> > > > 32-bit hosts will see struct inode grow by at least 4 bytes. This c=
ould
> > > > have effects on slabcache sizes and field alignment.
> > > >=20
> > > > The bulk of the changes are to format strings and tracepoints, sinc=
e the
> > > > kernel itself doesn't care that much about the i_ino field. The fir=
st
> > > > patch changes some vfs function arguments, so check that one out
> > > > carefully.
> > > >=20
> > > > With this change, we may be able to shrink some inode structures. F=
or
> > > > instance, struct nfs_inode has a fileid field that holds the 64-bit
> > > > inode number. With this set of changes, that field could be elimina=
ted.
> > > > I'd rather leave that sort of cleanups for later just to keep this
> > > > simple.
> > > >=20
> > > > Much of this set was generated by LLM, but I attributed it to mysel=
f
> > > > since I consider this to be in the "menial tasks" category of LLM u=
sage.
> > > >=20
> > > > [1]: https://lore.kernel.org/linux-fsdevel/20260219-portrait-winkt-=
959070cee42f@brauner/
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > Jeff, missing from this patch set is EVM.  In hmac_add_misc() EVM cop=
ies the
> > > i_ino and calculates either an HMAC or file meta-data hash, which is =
then
> > > signed.=20
> > >=20
> > >=20
> >=20
> > Thanks Mimi, good catch.
> >=20
> > It looks like we should just be able to change the ino field to a u64
> > alongside everything else. Something like this:
> >=20
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/e=
vm/evm_crypto.c
> > index c0ca4eedb0fe..77b6c2fa345e 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -144,7 +144,7 @@ static void hmac_add_misc(struct shash_desc *desc, =
struct inode *inode,
> >                           char type, char *digest)
> >  {
> >         struct h_misc {
> > -               unsigned long ino;
> > +               u64 ino;
> >                 __u32 generation;
> >                 uid_t uid;
> >                 gid_t gid;
> >=20
>=20
> Agreed.
>
> >=20
> > That should make no material difference on 64-bit hosts. What's the
> > effect on 32-bit? Will they just need to remeasure everything or would
> > the consequences be more dire? Do we have any clue whether anyone is
> > using EVM in 32-bit environments?
>=20
> All good questions. Unfortunately I don't know the answer to most of them=
. What
> we do know: changing the size of the i_ino field would affect EVM file me=
tadata
> verification and would require relabeling the filesystem.  Even packages
> containing EVM portable signatures, which don't include or verify the i_i=
no
> number, would be affected.
>=20

Ouch. Technically, I guess this is ABI...

While converting to u64 seems like the ideal thing to do, the other
option might be to just keep this as an unsigned long for now.

No effect on 64-bit, but that could keep things working 32-bit when the
i_ino casts properly to a u32. ext4 would be fine since they don't
issue inode numbers larger than UINT_MAX. xfs and btrfs are a bit more
iffy, but worst case they'd just need to be relabeled (which is what
they'll need to do anyway).

If we do that, then we should probably add a comment to this function
explaining why it's an unsigned long.

Thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

