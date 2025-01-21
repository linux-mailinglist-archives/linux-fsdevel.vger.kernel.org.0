Return-Path: <linux-fsdevel+bounces-39804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FCA187F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3353A56E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E951F8EE9;
	Tue, 21 Jan 2025 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z1243yu1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0O+Gu05j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z1243yu1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0O+Gu05j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F091F8901;
	Tue, 21 Jan 2025 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500364; cv=none; b=ucHUC3iXMxhKBIzUSfaz/8tL94eDC6EIQDH2mn6QrxnGYM/Et6XKVmJ0Ng9JF4xrdUDpAfWnyfG3Yfn77/7+SsuWrv6vZy402RpTiYiwu7kIXxk5EkeoElYeQBIzzvWyTRfehSq14Hpt8fpxq08DMWgoBGQeUcH4uDYSibDWN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500364; c=relaxed/simple;
	bh=NE1K7/EfR0OLAbsoFsB66+lGGFQK2Cqa6U3NJXbQgwA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ckrs/zpF3HRhDrXFWmiI+1IbP0M052DHlJJiX9J0zbN6L0oztgdx/L6BI9RgZD6MY+G16bZ0+048Q+tFKc08yIdIPsKolmk2p0WojxUzuv2PruUTp31nq83wfchX9iOPLKdKQSxYiYiUNEE0gW7zPhfM/LGKeFw00pLJfkeNzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z1243yu1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0O+Gu05j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z1243yu1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0O+Gu05j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4716F1F391;
	Tue, 21 Jan 2025 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737500358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPFZqVyR8tMuCZQo63k6WvpkcMgpQEahSeqcjs/1/zs=;
	b=z1243yu13wsjkyPJMMIiuWEukNof9b8vM3wwAf0eIH7y1KmLzAc7+tkeQ6ezlFikltuPN5
	qDK2W4Pz48HDnDHO5wKxo7DvcmF6L/2C46v6MEJiseqiT/RT/hKE5RgVHske/FXTLNZF8O
	XQhkBuAR9hYZNRUMyaFsH1BiYjXlVMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737500358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPFZqVyR8tMuCZQo63k6WvpkcMgpQEahSeqcjs/1/zs=;
	b=0O+Gu05jZfdMPHlt+wiNs+V/p878vufoGmLu/NZXWY/5nCOAGj5JDgjgYDC2tyMjEbMPxe
	EIit9fKrOBd+54Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z1243yu1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0O+Gu05j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737500358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPFZqVyR8tMuCZQo63k6WvpkcMgpQEahSeqcjs/1/zs=;
	b=z1243yu13wsjkyPJMMIiuWEukNof9b8vM3wwAf0eIH7y1KmLzAc7+tkeQ6ezlFikltuPN5
	qDK2W4Pz48HDnDHO5wKxo7DvcmF6L/2C46v6MEJiseqiT/RT/hKE5RgVHske/FXTLNZF8O
	XQhkBuAR9hYZNRUMyaFsH1BiYjXlVMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737500358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPFZqVyR8tMuCZQo63k6WvpkcMgpQEahSeqcjs/1/zs=;
	b=0O+Gu05jZfdMPHlt+wiNs+V/p878vufoGmLu/NZXWY/5nCOAGj5JDgjgYDC2tyMjEbMPxe
	EIit9fKrOBd+54Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C9C41387C;
	Tue, 21 Jan 2025 22:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFatL8MmkGe4HAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 21 Jan 2025 22:59:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
In-reply-to:
 <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
References:
 <>, <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
Date: Wed, 22 Jan 2025 09:59:08 +1100
Message-id: <173750034870.22054.1620003974639602049@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4716F1F391
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 22 Jan 2025, Amir Goldstein wrote:
> On Tue, Jan 21, 2025 at 8:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> >
> > Please send patches To: the NFSD reviewers listed in MAINTAINERS and
> > Cc: linux-nfs and others. Thanks!
> >
> >
> > On 1/21/25 5:39 AM, Amir Goldstein wrote:
> > > Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> > > mapped EBUSY host error from rmdir/unlink operation to avoid unknown
> > > error server warning.
> >
> > > The same reason that casued the reported EBUSY on rmdir() (dir is a
> > > local mount point in some other bind mount) could also cause EBUSY on
> > > rename and some filesystems (e.g. FUSE) can return EBUSY on other
> > > operations like open().
> > >
> > > Therefore, to avoid unknown error warning in server, we need to map
> > > EBUSY for all operations.
> > >
> > > The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
> > > to NFS4ERR_ACCESS in v2/v3 server.
> > >
> > > During the discussion on this issue, Trond claimed that the mapping
> > > made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
> > > protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
> > > for directories.
> >
> > NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
> > file system objects. Here's what I find in RFC 8881 Section 18.25.4:
> >
> >  > If a file has an outstanding OPEN and this prevents the removal of the
> >  > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
> >
> > It's not normative, but it does suggest that any object that cannot be
> > associated with an OPEN state ID should never cause REMOVE to return
> > NFS4ERR_FILE_OPEN.
> >
> >
> > > To keep things simple and consistent and avoid the server warning,
> > > map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions.
> >
> > Generally a "one size fits all" mapping for these status codes is
> > not going to cut it. That's why we have nfsd3_map_status() and
> > nfsd_map_status() -- the set of permitted status codes for each
> > operation is different for each NFS version.
> >
> > NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOVE.
> >
> > NFSv4 has only REMOVE, and it removes the directory entry for the
> > object no matter its type. The set of failure modes is different for
> > this operation compared to NFSv3 REMOVE.
> >
> > Adding a specific mapping for -EBUSY in nfserrno() is going to have
> > unintended consequences for any VFS call NFSD might make that returns
> > -EBUSY.
> >
> > I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(),
> > nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
> > trigger a warning.
> >
> >
>=20
> Sorry, I didn't understand what you are suggesting.
>=20
> FUSE can return EBUSY for open().
> What do you suggest to do when nfsd encounters EBUSY on open()?
>=20
> vfs_rename() can return EBUSY.
> What do you suggest to do when nfsd v3 encounters EBUSY on rename()?
>=20
> This sort of assertion:
>         WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
>=20
> Is a code assertion for a situation that should not be possible in the
> code and certainly not possible to trigger by userspace.
>=20
> Both cases above could trigger the warning from userspace.
> If you want to leave the warning it should not be a WARN_ONCE()
> assertion, but I must say that I did not understand the explanation
> for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().

My answer to this last question is that it isn't obvious that EBUSY
should map to NFS4ERR_ACCESS.
I would rather that nfsd explicitly checked the error from unlink/rmdir and
mapped EBUSY to NFS4ERR_ACCESS (if we all agree that is best) with a
comment (like we have now) explaining why it is best.
And nfsd should explicitly check the error from open() and map EBUSY to
whatever seems appropriate.  Maybe that is also NS4ERR_ACCESS but if it
is, the reason is likely different to the reason that it is best for
rmdir.
So again, I would like a comment in the code explaining the choice with
a reference to FUSE.

Then if some other function that we haven't thought about starts
returning EBUSY, we'll get warning and have a change to think about it.

Thanks,
NeilBrown


