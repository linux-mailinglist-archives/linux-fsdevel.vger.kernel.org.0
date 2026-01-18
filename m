Return-Path: <linux-fsdevel+bounces-74299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2BD392D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763B43015176
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F6286D53;
	Sun, 18 Jan 2026 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhkh1bf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903011A3179
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712423; cv=none; b=AeXgJ81yTnmj75tVzkUuMG533FsYkp7quavezTcfCNALFJzJr60qk/vIXRXTHms53E92vTanmtb+fU9eLqzpyT1GTMrRUdjG1mXVXpbh0PaLrvSvBVaoz+l3WZhfP1h/E4JLLlfNPqlUtqzxfQYNMGNyOxNs3H7o1G7LxvpRCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712423; c=relaxed/simple;
	bh=Lg2ddzv8qzBQatAKWd1WaTBA3NxfIUUntjnsVJ8LZh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMhx+M5X8kaXQA/zGZfPu7lWEb9o7gc8E7BYkBsa7qxyaD7MzuezXGtZWDRtkF7EvqiT/C8CLIbvuneL77H3W5UnT/5K3zXCAWTG8ewyc85dyJ2hs+mePnwEB6/CYQYAs5mDngeYsw38ZwREW9xDpuDeG2YYo7lFzbFBJH/TxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhkh1bf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA9C2BCB4
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712423;
	bh=Lg2ddzv8qzBQatAKWd1WaTBA3NxfIUUntjnsVJ8LZh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vhkh1bf+0lBl78mmglHiOPThIbOmHUTGSFIExJTezRj82leBuHzlLNA58k6i6ASba
	 7vHcj061eF4Klvz9qY9vdvrcO3rdR9BpyAMKqx/BmNP16PJg7hfEvocwdj7C7f5FFq
	 86zDoxT+PKxbPXRH5XV/0bgLoY0FrMnytZuiW6tcLD8+EseRf2e1U7c/JxACLlj5FY
	 W0LPBl2DJGrHAFhI4Vs2e0cN5nqkJ+3o87h5GL/lFRpQ2rNwwd8mV5bmdQtPTDezYF
	 n+0xKERlsUPMqyYQl0adp0kyyTa2zu2XGkC4Lt7ZiXXOeBNVKjZuWjG2Vw+PbHk/pl
	 b8l7rr+G9NdCQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8765b7f4c0so537075666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:00:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW1c88zoN1FVqmQnpZCkhLG51QJJ8KCPHstJyjMlXkaXSfVDqeBIN9+gNqN68JazFZNFuHVsRz4sTEP++g@vger.kernel.org
X-Gm-Message-State: AOJu0YxX95jUuw6f3xIScLWQwrlrRqdJDtW23zjdFMSkpeWVN/56cBsd
	p7PdXBZ2/wMcXesAYWccTTGLoAtSnjD2NPIOgdM95Yl8aAFC6/izgw7wOQNZsO3dWZHCr8KqL3I
	Xf4SDKjDrPe+U4mDukoevqFQfL1FNpfI=
X-Received: by 2002:a17:907:3cc9:b0:b84:40e1:c1c8 with SMTP id
 a640c23a62f3a-b8793013404mr650205766b.33.1768712421730; Sat, 17 Jan 2026
 21:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-8-linkinjeon@kernel.org>
 <20260116091451.GA20873@lst.de>
In-Reply-To: <20260116091451.GA20873@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:00:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9+P6ekYnbXuoG95Nt5-H6bie6cSm4N-9RFDN3E+smJ+g@mail.gmail.com>
X-Gm-Features: AZwV_Qhzo7FgcdWtH5i8eQHTT8Xxv9CwrHyK-FWcpgR3kSrjl-kmzsd8q_I60Es
Message-ID: <CAKYAXd9+P6ekYnbXuoG95Nt5-H6bie6cSm4N-9RFDN3E+smJ+g@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] ntfs: update iomap and address space operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> First, a highlevel comment on the code structure:
>
> I'd expect the mft handling (ntfs_write_mft_block, ntfs_mft_writepage
> and ntfs_bmap which is only used by that and could use a comment
> update) to be in mft.c and not aops.c.  I'm not sure if feasible,
> but separate aops for the MFT (that's the master file table IIRC) would
> probably be a good idea as well.
Okay.
>
> Similarly, ntfs_dev_read/write feel a bit out of place here.
Okay.
>
> > +void ntfs_bio_end_io(struct bio *bio)
> >  {
> > +     if (bio->bi_private)
> > +             folio_put((struct folio *)bio->bi_private);
> > +     bio_put(bio);
> > +}
>
> This function confuses me.  In general end_io handlers should not
> need to drop a folio reference.  For the normal buffered I/O path,
> the folio is locked for reads, and has the writeback bit set for
> writes, so this is no needed.  When doing I/O in a private folio,
> the caller usually has a reference as it needs to do something with
> it.  What is the reason for the special pattern here? A somewhat
> more descriptive name and a comment would help to describe why
> it's done this way.
The reason for this pattern is to prevent a race condition between
metadata I/O and inode eviction (e.g., during umount). ni->folio holds
mft record blocks (e.g., one 4KB folio containing four 1KB mft
records). When an MFT record is written to disk via submit_bio(), if a
concurrent umount occurs, the inode could be evicted, and
ntfs_evict_big_inode() would call folio_put(ni->folio). If this
happens before the I/O completes, the folio could be released
prematurely, potentially leading to data corruption or use-after-free.
To prevent this, I increment the folio reference count with
folio_get() before submit_bio() and decrement it in ntfs_bio_end_io().
I will add the comment for this.
> Also no need to cast a void pointer.
Okay, I will remove this also.
>
>
> > +                             if (bio &&
> > +                                (bio_end_sector(bio) >> (vol->cluster_=
size_bits - 9)) !=3D
> > +                                 lcn) {
> > +                                     flush_dcache_folio(folio);
> > +                                     bio->bi_end_io =3D ntfs_bio_end_i=
o;
> > +                                     submit_bio(bio);
>
> If the MFT is what I think it is, the flush_dcache_folio here is not
> needed, as the folio can't ever be mapped into userspace.
Okay. I will remove it.
>
>
> > +static void ntfs_readahead(struct readahead_control *rac)
> > +{
> > +     struct address_space *mapping =3D rac->mapping;
> > +     struct inode *inode =3D mapping->host;
> > +     struct ntfs_inode *ni =3D NTFS_I(inode);
> >
> > +     if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> > +             /* No readahead for resident and compressed. */
> > +             return;
> > +     }
>
> Not supporting readahead for compressed inodes is a bit weird, as
> they should benefit most from operating on larger ranges.  Not really
> a blocker, but probably something worth addressing over time.
I agree that compressed inodes would benefit significantly from
readahead due to the nature of compression units. However,
implementing readahead for the compressed path is currently complex
and requires more careful design. I will keep this as a high-priority
task for future work after upstream.

Thanks!


>
> > +static int ntfs_mft_writepage(struct folio *folio, struct writeback_co=
ntrol *wbc)
> > +{
>
> Instead of having a ntfs_mft_writepage, maybe implement a
> ntfs_mft_writepages that includes the writeback_iter() loop?  And then
> move the folio_zero_segment into ntfs_write_mft_block so that one
> intermediate layer can go away?
>
> > +int ntfs_dev_read(struct super_block *sb, void *buf, loff_t start, lof=
f_t size)
>
> Do you want the data for ntfs_dev_read/write cached in the bdev
> mapping?  If not simply using bdev_rw_virt might be easier.  If you
> want them cached, maybe add a comment why.
>
>

