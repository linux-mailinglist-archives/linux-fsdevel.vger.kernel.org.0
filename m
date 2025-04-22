Return-Path: <linux-fsdevel+bounces-46888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C21A95EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 08:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4391A1782E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F19238C1C;
	Tue, 22 Apr 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="a9Nm/9Oz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338A2367C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305054; cv=none; b=pM2gd5nLXhabraPSsEObUeYJVaajDbl8Z2a2t76D6mef3B1BT0f/UASqXnIugjNglqRWHX0K6eAIQCvQLQlUS2h1V2kHO/UCg0cJzVAJyvHrzR1FDaTrSKGwsRjKdXlxdhEDzBf33ReLNs4MqwBQH/syj+jkeY39OEkLSDGsdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305054; c=relaxed/simple;
	bh=Xxj/TE7TzhuddVhXgcII7L22uQyZSMXxQ5G+AfGYFBw=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=pL1QxI8riOPPOxf6OmQ2cEe9rJaYoOKzlhtAP5+IdsJ7D/1aK+Hg4mo7O0cbYdYxgJtjXR+CLAxxtKReDtwL9BW6A4yDspLD4HmMPqpdnbHDf9y/nEee/Y22iWJBJ4KB5yNlNeuT4FSkWm9BDlT1Kk//WY4yM9rIMPMmjl0ExZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=a9Nm/9Oz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22928d629faso45546155ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1745305051; x=1745909851; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3sj+3EthYb+zN05p1L8+r649tWKw2xpkcFKm69cU1s=;
        b=a9Nm/9OzAEE7/AJHSg4DNAoxnb7ccKhefUXP8XNovu6+tm/SB6AXaDoZQQXcUvFeIm
         3KEkTSFsiK9k7e63qYDUAdrVV2+2mImCXvVRtTQDLtOPYasq41kTog9nS4LcGKJ+/662
         LFWN7/Qi5Rqw6TPEefQrMHaG2GxNzwd4MDd+HlgU23CACF4u9ZM2IyqOMaBLg8IzOQOK
         0eN+URK8hOQHwKYZgBphlfPDiRrWErqM04CtpTRuDM7vjvmzbPAnIuF7/GHL15Q5Qo/N
         z4DaT+dLyGNwLe06vLgrHEFvX1UcgdC5GcTeT93HYEca8cnSwFxDEVOayB45WNREbu0/
         agfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745305051; x=1745909851;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3sj+3EthYb+zN05p1L8+r649tWKw2xpkcFKm69cU1s=;
        b=Ew+QJcARIpzJjicXNfqBU71xtsEP6MtT9QRh0tv/e1HnewAGLkSoEn3JN1pY9AUvW+
         ddaZm25AB5NkMB7BfuzmqJmt+qPmcfkNUuN+vwYLR+9t0GulGNPLzta36vkNk9WBiUn8
         cVTBXOKaYULlX9qhWVC4zE+bev5icvuRY41Vxe26am0JfLUum5Am6V06dGZlwqkflaWL
         0b1oOlldnjR3j/00JfIz34rEFqXVPYMUs32BbJtKHVmbuFZxjkbdPdve5L0fo3cMeO4E
         X5ZKR5aDNjnVrpTuzyDCllcnb1IiKTWRJsXtOf6ioiKNsELeuFMswDAkYanTtlPtUPkH
         I3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUxBFzzef7mCE/JtM7XlwhuYY53Q/rVhX46jUvhqek4Vo+NvYIcmtYMrbuHFJLj8UNgAdq9eIhc8xasSv4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+NpBt1vb9klWN4zxCXuaFUgZXEoTghM7xUMQsleQvoB6wdyAN
	EsGy2zqxX6e5gP714hh4NXb+J+n0TnSukAvm/O+r58NIp7y8AyWwiSBHz3tI+dw=
X-Gm-Gg: ASbGncv2bCLdY0Vp5Q4TRz5NCF1Owb2FB5X35xEbfB0qO0RebovKS9nG5adlKCNlesq
	cuwwH+RPbfj4r0T0a6tY9fqp+M1/ygEee+KQCkM8g+dgNsSe1eYUXSfr9bdsboHsxAqJVFuo13q
	Wqc3PmdY2eWOq8ssiR+Lev18+nHNGfhGoGLn6SudKy9o+qvmL/FjXk4xWroo/iol+Ap4lhmG0IA
	pOoqdE/am1fhxK/kK5dHc5Htcq6LkzmZBb38IEVwN/2n+gt6QOnyIx50Y9I0tDs2tfTFAR+owDV
	5AQ9hHDSuXd0tKkDImCyfPKcoTKIcpKxftsoYYW+C0uDxz3sMEs+Maa9IgXHt9+zm0hlgn56Kpt
	esyKh/9nyrHEz+1sBMx7hgxS6
X-Google-Smtp-Source: AGHT+IG7n2o0dSvp9dABgg8pEXj77y/eZL2Q6N6BBo9o0U13S7Vzo/moKzdGDn6g9tVjdwaunLfI7w==
X-Received: by 2002:a17:903:1381:b0:223:37b8:c213 with SMTP id d9443c01a7336-22c5361b8eamr200476735ad.52.1745305050908;
        Mon, 21 Apr 2025 23:57:30 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed12cdsm77345135ad.204.2025.04.21.23.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2025 23:57:29 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <40B4C6BE-FB32-401C-A610-1F2E26E38D18@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8F88F6DA-A33A-4595-A863-1D90E9304A63";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: bad things when too many negative dentries in a directory
Date: Tue, 22 Apr 2025 00:57:26 -0600
In-Reply-To: <93dc5b257e11e3bb5a8989779dfa937a63b5e41b.camel@HansenPartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>,
 Ian Kent <raven@themaw.net>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org>
 <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
 <Z_00ahyvcMpbKXoj@casper.infradead.org>
 <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
 <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
 <93dc5b257e11e3bb5a8989779dfa937a63b5e41b.camel@HansenPartnership.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_8F88F6DA-A33A-4595-A863-1D90E9304A63
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 16, 2025, at 9:26 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Tue, 2025-04-15 at 11:22 -0600, Andreas Dilger wrote:
> [...]
>> Negative dentries are only useful if there are fewer than the number
>> of entries in that directory.
>=20
> I agree with this, yes.
>=20
>> If the negative dentry count exceeds the actual entry count,
>=20
> Yes, but finding this number is going to be hard.  We can't iterate a
> directory to count them in the fast path and a directory i_size is
> extremely filesystem and format dependent.

This depends.  Some filesystems will store the actual number of entries
in the directory, or it can be estimated based on the number of blocks
in the directory.

> However, since we only need a rough count, perhaps having the =
filesystem
> export its average directory entry size and simply dividing by that
> would give a good enough approximation to the number?

I would suggest to add an inode method that can be called on the =
directory
to request the (estimated) number of entries in a directory.  If the fs
has a good idea of this it can return that number, or it can estimate
based on allocated blocks.  It does not need to be exact, but provides
an upper bound on the useful number of negative dcache entries to keep.

>> it would be more efficient to just cache all of the positive dentries
>> and mark the directory with a "full dentry list" flag that indicates
>> all of the names are already present in dcache and any miss is
>> authoritative. In essence that gives an "infinite" negative lookup
>> cache instead of explicitly storing all of the possible negative
>> entries.
>=20
> Practically, I think directories with that flag would probably
> automatically retain positive child dentries as an addition to our
> retain_dentry() logic and automatically kill negative ones.
>=20
> This behaviour, though, would remove them from the shrinkers, so
> probably there would have to be a global count of the number of
> unshrinkable children this gives us and have that factor into the
> superblock shrinkers somehow.  Probably add the parent to the lru list
> but make dentry_lru_isolate() always skip until the tipping point for
> shrinking filled directories is reached?

It's true that this flag would (generally) remove the directory and its
immediate children from the dcache shrinkers.  However, the point of a
shrinker is to reduce memory usage, and if the directory can no longer
guarantee that all positive dentries are cached (so no negative dentries
are needed) would generally *increase* memory usage in the end.

I could imagine that such directories would eventually be reaped, but
it should be much harder to do so.  For example, every negative lookup
in such a directory should refresh it in the LRU since the parent dentry
avoided a negative entry from being added to the dcache.

>> For directories like ~/bin, /usr/bin, /usr/lib64, etc. (or any
>> directory) where negative lookups are frequent, it should be possible
>> to determine this threshold automatically.  Once the negative dentry
>> count exceeds the size of the directory by some factor (e.g.
>> directory size / 16, or the actual entry count if the filesystem
>> knows this, it doesn't have to be exactly correct) then a readdir
>> could load all of the names to fully populate the dcache and set the
>> "full dentry list" flag on the directory would allow dropping all
>> negative dentries in that directory.
>=20
> All this supposes we have some per directory count of the negative
> dentries.  I think there'd be push back on adding this to struct =
dentry
> and making it an exact count in the fast path.  The next logical place
> to evaluate it would be the shrinkers but then that wouldn't solve
> Matthew's use case where the shrinkers don't get activated.  I suppose
> some flag that userspace could add to directories it identifies as hot
> might be the next best thing?

No. Kernel memory management shouldn't be dependent on userspace doing
the right thing, and no userspace would ever be taught to consistently
set such a flag.

Again, the numbers don't have to be exact, but if negative dcache is
2x the number of dir entries (or e.g. 1000 more as a directory gets
larger) then it is time to change to caching only positive entries.

Having the negative dcache be directly linked to the parent would be
fine too.  It doesn't make sense to cache negative dentries longer than
the parent, and if there is an upper bound on how many negative entries
can exist on a directory avoids the need to shrink them independently.
If there is lots of memory pressure on the dcache then directories with
inactive negative dentries would eventually be reaped, and even "full
dentry list" directories would eventually come around for shrinking if
they were inactive for a long time.

>> The VFS/VM should avoid dropping directories/dentries from cache in
>> this case, since it is saving more memory (and avoiding filesystem
>> IO) to keep them pinned rather than dropping them from cache.  There
>> might need to be a matching "part of full dentry list" flag on the
>> positive dentries to avoid dcache shrinking of those entries (which
>> would invalidate the premise that the parent holds all of the
>> possible entries in that directory), if checking the parent's flag is
>> too expensive.
>=20
> As I said above, I think simply checking the parent flags in
> retain_dentry should do.  Since you don't need it to be exact and the
> parent should have a positive refcount, it should be possible to do a
> READ_ONCE rather than locking.


Cheers, Andreas






--Apple-Mail=_8F88F6DA-A33A-4595-A863-1D90E9304A63
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmgHPdYACgkQcqXauRfM
H+Dkww//av1CdD2gLZLLjtdw9qfqjEKQFEep3la1+b7EJ4SrcKQ1TEaoDHm3dm7S
PbQizzLLqfaxQFjUuHj9+b5ZPbw57iIk2/41tq6B5F9gLzpsYtRziAGIDG3grH5J
EALxBEXFW6vj+B3p+0wde+E38/9aSr+TFPExzGlyLZnRo0R5fs/qtVf6p5EBc/C9
20FImxE0ZaWUiaeMTCm3Ezm2NUKs6N1ILZbUL6mRlKR7WIh2y9OTTj6ZKYT8X0/N
tyLKP6ms/oOBiQEzdnpEWCS7Ls5b/gMBUa6iMJwgWncxa6d0Jts40DtB+9Y9cBNh
6Y//KCb5iv960ja0K0jWXVDAwS3PGuYzWkkr/kGN5bSnmz8RFXsyA540DMUnAyEn
JACizYnyI0DKBai+V2g9YE+DDz0IWlYFWXclclQo1+CDTETgovgSmGNvXJPUKvs+
RXeCRNMX1bJx/fpoOUmVQo0pTiCVtbheQP2CHhoTAE4TzlowjI+qkKeYVer8ZxB/
g9fMkg5QLpjki1JDE2ragvus3Q0yUONWxYEiWD4OiF4pxxVTwgSFMBWzgtTPrzs6
ae+F9juv/ottTeqn/2B3+aS+W+ykH7nyx+9fc7sEedkmf6aIml9rrLxXHXmdE7v9
O4ZwjGU5OTBIBvnRNy/XS2fVkbrS4edg2XIt65dNN+bp2n0pxFg=
=nKvU
-----END PGP SIGNATURE-----

--Apple-Mail=_8F88F6DA-A33A-4595-A863-1D90E9304A63--

