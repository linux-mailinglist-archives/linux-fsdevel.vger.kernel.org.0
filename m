Return-Path: <linux-fsdevel+bounces-72557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B1CFB58D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 00:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F84304A7C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC858248B;
	Tue,  6 Jan 2026 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRy9pvD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1E175A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742219; cv=none; b=AE3VZ//wwmFRS9q6PSygEJOhM69gfB5IAqqFHLwxMvHSfq+NGjvEtRb6BKG7mwMFbWjgyZ1WaTqIk2qHBLWeUqjVS8aIwaFhCzk4srTRuwJryP0LTmBRnN7fCBXoa9GYcLxejDzl5aTriEy8kwYMx5FlPDPQSdU/sVkOfZ7JiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742219; c=relaxed/simple;
	bh=sF9ATBDiQa2WJGuZ7B1rayFwvR917J2e+JTZh6nnnvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugrt4JPIzSTYjS7sy8jIkkRbHd+DARCkl+sMV29x8Stts9JnubnIxmJtMD31lMDLkQEdeu5UEORgesgy14XrCqK0TvCb84CYG7l7spi4Q4vVdTvCQd8oxhBtlZ8oHaDRJn5CtwLP8/pLMTXpxyUgbxeVNB68TpKb5OoYJwidnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRy9pvD9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee257e56aaso4160291cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767742216; x=1768347016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMPrgVPAJkxzoSL+MjXhmJYJPrnZM80RIBzr/vd32Eo=;
        b=dRy9pvD9kfnH01O33fEcWaBhpUK13X0eq2f0WK24W0P4CpDfCT8p4oB8wCvFMO+z4q
         UKdSvpqtkDmAUUTRtut4Y0N4kNHT22qIRQJEqD0rEArTxpN8S0FIn8x3s5DRghaWHDSL
         LlxX5jER9ZH+ptd8fUgSQn1lG3WKSOUbX+lAm3mzCY84aX2zUP3QRhkcatCVMlQb0ONQ
         pCjKKsUZReZcvM+fKARSvooPhYMb154Fe7m26u9FDhTxonBXlHIeTw2GCFgttM4GcggS
         rHJw2xRCzfK9DkwwaDRJ8UcpOQ6E/M45xi2K6v7oziY7H7nhzwE/kLfat5UY7Me0R6G+
         50uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742216; x=1768347016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMPrgVPAJkxzoSL+MjXhmJYJPrnZM80RIBzr/vd32Eo=;
        b=Gy1eJVdOI/i9/9uB6rv4YlwGRFYt5y5TaEc744LTor/vvj4K1KdFyFPiBsxvsEDN1H
         gN7kgcA1gW4RrhyFQTm6sni2DEZHpwmAPWbAM2kLJdLmnDkQr3XMwidoBpiSBZevmoIm
         Wg82rXA3e3cA6ObzUHlGy9NiB/htOAgZAJ4PFi6s3Al0yaV8xpXwf9pmNIxccG0+9u3Z
         HQ37QvgooPD9+sRC/CiOt/E/5AcG33FoZlml41FFwqXqWMdu5UjJHD3s2ayIp3RwmyfB
         nmZNIqyhKgBYyySDmSsAuUupk3Mh2mwR2agVyo9Pite0A/PbfSVRh1eBmnxsTmfcT5Hk
         vJrg==
X-Forwarded-Encrypted: i=1; AJvYcCU372WJA2rAI/PaztmKryORsjXNyZppJC1uxEvADPGiiZqtm20YQx7s9TBt/cu21KPNgcPrEux98tT5AexD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lYkEmHJfHxFARLP8dPZv/V1P2ET86rJoeaonRD6F+VDPzThQ
	DQ8ts0ORLjaQSB2JgMMYADffpmrW1fRJbxoAw/hcTu2rlcBJ2okpwUeXcDsI8HN9m7+NOlpOxsL
	9EZePobH9u84XXItfQrCW3H1sKNIiqjA=
X-Gm-Gg: AY/fxX7mo33qJ6ROu43yjDRlGI2YoWi/St7zWW9qPSy0j1LcYcxM7Y+ZUF06VG3AYux
	4DJ8NVmXclJAyDVK+u613Dt7SJxEFf0ssumPzFlQASb4pVOujlHcb3+OuV3sUOkpMHF3fUWvdqQ
	DugvfrWsWgloynrw6yg6citmci9UVQGjbBW684OsN7CufBmRFVahl9G0op78/Wzfmpb5Rs2NYk4
	+f1A/Ej88iNIbTa+x8nh0bKUHttjZJ4H9acm72uk/dPOOtDzbtf8QQu52x50h0039RehgQDFgFX
	JKFPQ9Nf1xKD2TuM+1hhGA==
X-Google-Smtp-Source: AGHT+IH4DdeN8NA/9bx7gypeth53pF4xCrOLbCSBRDkT68+39OMrQflzwe0faxz8RIiURIMpee/M6awa20lDfJJEDPM=
X-Received: by 2002:a05:622a:2c2:b0:4ee:2721:9ed3 with SMTP id
 d75a77b69052e-4ffb3f7c162mr10231181cf.26.1767742216040; Tue, 06 Jan 2026
 15:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
In-Reply-To: <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Jan 2026 15:30:05 -0800
X-Gm-Features: AQt7F2pJlPO-7drumYMDtTF9-DOPHU0IjtOLLiFeDA2rNi5E_BAE0vn6n9y_GsM
Message-ID: <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
Hi Jan,

> [Thanks to Andrew for CCing me on patch commit]

Sorry, I didn't mean to exclude you. I hadn't realized the
fs-writeback.c file had maintainers/reviewers listed for it. I'll make
sure to cc you next time.

>
> On Sun 14-12-25 19:00:43, Joanne Koong wrote:
> > Skip waiting on writeback for inodes that belong to mappings that do no=
t
> > have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> > mapping flag).
> >
> > This restores fuse back to prior behavior where syncs are no-ops. This
> > is needed because otherwise, if a system is running a faulty fuse
> > server that does not reply to issued write requests, this will cause
> > wait_sb_inodes() to wait forever.
> >
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> > Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> OK, but the difference 0c58a97f919c introduced goes much further than jus=
t
> wait_sb_inodes(). Before 0c58a97f919c also filemap_fdatawait() (and all t=
he
> other variants waiting for folio_writeback() to clear) returned immediate=
ly
> because folio writeback was done as soon as we've copied the content into
> the temporary page. Now they will block waiting for the server to finish
> the IO. So e.g. fsync() will block waiting for the server in
> file_write_and_wait_range() now, instead of blocking in fuse_fsync_common=
()
> -> fuse_simple_request(). Similarly e.g. truncate(2) will now block waiti=
ng
> for the server so that folio_writeback can be cleared.
>
> So I understand your patch fixes the regression with suspend blocking but=
 I
> don't have a high confidence we are not just starting a whack-a-mole game
> catching all the places that previously hiddenly depended on
> folio_writeback getting cleared without any involvement of untrusted fuse
> server and now this changed. So do we have some higher-level idea what is=
 /
> is not guaranteed with stuck fuse server?

The implications of 0c58a97f919c (eg clearing folio writeback only
when the server has completed writeback instead of clearing writeback
and returning immediately) had some analysis and discussion in this
prior thread [1]. Copying/pasting a snippet from the cover letter:

"With removing the temp page, writeback state is now only cleared on the di=
rty
page after the server has written it back to disk. This may take an
indeterminate amount of time. As well, there is also the possibility of
malicious or well-intentioned but buggy servers where writeback may in the
worst case scenario, never complete. This means that any
folio_wait_writeback() on a dirty page belonging to a FUSE filesystem needs=
 to
be carefully audited.

In particular, these are the cases that need to be accounted for:
* potentially deadlocking in reclaim, as mentioned above
* potentially stalling sync(2)
* potentially stalling page migration / compaction

This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
filesystems may set on its inode mappings to indicate that writeback
operations may take an indeterminate amount of time to complete. FUSE will =
set
this flag on its mappings. This patchset adds checks to the critical parts =
of
reclaim, sync, and page migration logic where writeback may be waited on.

Please note the following:
* For sync(2), waiting on writeback will be skipped for FUSE, but this has =
no
  effect on existing behavior. Dirty FUSE pages are already not guaranteed =
to
  be written to disk by the time sync(2) returns (eg writeback is cleared o=
n
  the dirty page but the server may not have written out the temp page to d=
isk
  yet). If the caller wishes to ensure the data has actually been synced to
  disk, they should use fsync(2)/fdatasync(2) instead.
* AS_WRITEBACK_INDETERMINATE does not indicate that the folios should never=
 be
  waited on when in writeback. There are some cases where the wait is
  desirable. For example, for the sync_file_range() syscall, it is fine to
  wait on the writeback since the caller passes in a fd for the operation."

That was from v6 of the patchset and some things were changed between
that and the final version landed in v8 [2] (most notably, changing
AS_WRITEBACK_INDETERMINATE to AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM and
dropping the sync + page migration skips), but I think that analysis
of what cases need to be accounted for / audited remains the same. I
don't think there are any places beyond those 3 listed above that have
a core intrinsic dependency on folio writeback being cleared cleanly
(eg without any involvement of an untrusted fuse server).

For the fsync() and truncate() examples you mentioned, I don't think
it's an issue that these now wait for the server to finish the I/O and
hang if the server doesn't. I think it's actually more correct
behavior than what we had with temp pages, eg imo these actually ought
to wait for the writeback to have been completed by the server. If the
server is malicious / buggy and fsync/truncate hangs, I think that's
fine given that fsync/truncate is initiated by the user on a specific
file descriptor (as opposed to the generic sync()) (and imo it should
hang if it can't actually be executed correctly because the server is
malfunctioning).

As for why this sync user regression has surfaced and now needs to be
addressed, I don't think it's because there's a whack-a-mole game
where we're ad-hoc having to patch up places we didn't realize could
be broken by folio writeback potentially hanging. The original
patchset [1] contained patches that addressed the sync and compaction
case (eg maintaining the original behavior that the temp pages had),
so I don't think this is something that was missed. These patches were
dropped because in the discussion in [1], they seemed pointless to
mitigate / guard against when there already exists other ways
migration/sync could be stalled by a malicious/buggy fuse server. What
I missed was that it's more common than I had thought for
well-intentioned servers to not correctly implement writeback
handling, and that even if it's userspace's "fault", it's still
considered a kernel regression if buggy code previously sufficed but
now doesn't.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelko=
ong@gmail.com/T/#u
[2] https://lore.kernel.org/linux-fsdevel/CAJfpegveOFoL-XzDKQZZ4U6UF_AetNwT=
UDbfmf7rdJasRFm3xA@mail.gmail.com/T/#m56255519bf9af421ae07014208ccd68a96e72=
d52

>
>                                                                 Honza
>
> > ---
> >  fs/fs-writeback.c       |  3 ++-
> >  fs/fuse/file.c          |  4 +++-
> >  include/linux/pagemap.h | 11 +++++++++++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 6800886c4d10..ab2e279ed3c2 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb=
)
> >                * do not have the mapping lock. Skip it here, wb complet=
ion
> >                * will remove it.
> >                */
> > -             if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> > +             if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> > +                 mapping_no_data_integrity(mapping))
> >                       continue;
> >
> >               spin_unlock_irq(&sb->s_inode_wblist_lock);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 01bc894e9c2b..3b2a171e652f 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, u=
nsigned int flags)
> >
> >       inode->i_fop =3D &fuse_file_operations;
> >       inode->i_data.a_ops =3D &fuse_file_aops;
> > -     if (fc->writeback_cache)
> > +     if (fc->writeback_cache) {
> >               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_d=
ata);
> > +             mapping_set_no_data_integrity(&inode->i_data);
> > +     }
> >
> >       INIT_LIST_HEAD(&fi->write_files);
> >       INIT_LIST_HEAD(&fi->queued_writes);
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 31a848485ad9..ec442af3f886 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >       AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
> >       AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
> >                                  account usage to user cgroups */
> > +     AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_=
on_reclaim(const struct addres
> >       return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
> >  }
> >
> > +static inline void mapping_set_no_data_integrity(struct address_space =
*mapping)
> > +{
> > +     set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > +}
> > +
> > +static inline bool mapping_no_data_integrity(const struct address_spac=
e *mapping)
> > +{
> > +     return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > +}
> > +
> >  static inline gfp_t mapping_gfp_mask(const struct address_space *mappi=
ng)
> >  {
> >       return mapping->gfp_mask;
> > --
> > 2.47.3
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

