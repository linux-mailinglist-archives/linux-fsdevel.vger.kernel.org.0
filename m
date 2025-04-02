Return-Path: <linux-fsdevel+bounces-45572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE65A797B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6A3ACE6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F73C1F417E;
	Wed,  2 Apr 2025 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEYNXtDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC71EEA57
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629704; cv=none; b=QmPfoh6cRcWTq1EAfFEIpj6Ov0/CcL5ZMhNgaeb5JXJfdQLzeEho7k/jWCmxwkRMbxYBh9E2tWjRvwV4w3eNi31Y/5vv+KQXGXbXE/GYNBX2Y4oxyHE7azgqQeTu1+gKYIR/6zukwm3tAQDl2E1ZZXSMfcikcX3/eygsav7CCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629704; c=relaxed/simple;
	bh=96bZsdwcCTNpY/AwePC+plVbqSMLpQV/crqKoou/0U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlOOUOY9XCgttKoGikWNIn2sPopqnVwlu3r4go6EXpbsdHpsn+b56I/HQzgHbhNPcIadGmpQA/ZVV+baV5SJJS5q3g9x76JxWmcxx4Xh0irWibf/6CUQKK+kvXwPLjx1jRwgmkeivHMMEVzMrwKBXngmUMwhd4pISl/CAxQdc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEYNXtDW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4775ce8a4b0so3228931cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743629701; x=1744234501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXV/4KLKryL+mkVEiJtNLsehrS83f48ro1ic7SlOiFE=;
        b=jEYNXtDWOu0O3VKY591NB/dQiUM5/66xl/PzV5T35bRM4CLde6t69WwP7IC4B09WBa
         O7Fe3Eae2nLwCCV5w1txKrTXmjQr7nLh22ASUb7ZVwHl8Sf1noMcZsIpWxrktWskbvnF
         QHcsQj7PU+IZhRqbZ05Fux8XkEu31+BUT4/iBFDJEcktdWnaB7cS+PEWASal6HKS/0e+
         swP2csULc/TSh5JYdIh5mk0BlPUpY3oJXBzqZTk6bKNfX3uLLKakdbahC7Yd6gLC6jPp
         rS9HDL8esc9M9i/dRW1bbk2Vd8FlOF2tfPCWF1If4iCKuovxe5IsRi0AjbKcpK9gUsTj
         BVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743629701; x=1744234501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXV/4KLKryL+mkVEiJtNLsehrS83f48ro1ic7SlOiFE=;
        b=O9//9J63GhwLKZiRIDA/Rtswx8jcHZVezryDGed3Qk5DaV5tVMaPs5fSW2eG30L3O+
         By7t0xMbuKxzLjF58/CYgL9/1/fM61GR3oqqgyQ/09iS069cOW/JV4+NiYjrS0XTf6Gj
         OMUPweNSPK1if80klH5a4aIE8R+MbhIRUdTplKwz3dsvaVeYT51ihsr9QghBGlsPTo6k
         sx1vngAaCKXV2wkZfbIzdjUxMXKSOjUgKzUIG+n/sEkty6WcboUM1qI36/u/oGP8W/MR
         vord/KN3pO4EoPpPzyymz8maVxkIN5Za15wyV0f7CwiTNSSRLQk6e/K8E+yR/WNw0HUV
         ylLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz900D0scStBIxRj9QectnRpg/0ACpfZ0h0ZggT6yQDs8o2bSvR43ctdY8AdbPn1bGnMoorSU7rNBv2oV3@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTcJD6ZvBRt8sX/5O+eJGzEvXWCV+ILqBo1WZzaZoC56eGwKE
	7xtCQsECG392dVJLMaWi2uz/9HwBc7tjVeYxpw0v8C2GsPNOj4yZnh7HMCzsjcdJ7XQFCkQ6+CF
	imvftYT3qY2yPUFHnBxvksfArRsg=
X-Gm-Gg: ASbGnctN11uVM2MSDSHCKq3pQOEqgCyzjLMY5wsFQ4XEjJaqENlyxqq05nEwPoD8NVz
	CctV07tgCrIi+NhO8yVvSMD4K6eRk/6bKAXhb4UQ/ZEQ7z7z2FmW3fLJcSBPq1/BhSl6f3obrKe
	QFDUQJVmBkF2L/u3eaUV/shS85DMF6qwCI3c2EHRCMmA==
X-Google-Smtp-Source: AGHT+IH9RyuryqLYFr0sIwVsygMGNs86XJCPy1oK+2U+8CmMAUnEX5hK4KYSSBIuRZHQCki5QzjSDdLx2KVBYQ2iQyI=
X-Received: by 2002:a05:622a:281:b0:476:9377:17aa with SMTP id
 d75a77b69052e-4791961be70mr3772321cf.52.1743629701194; Wed, 02 Apr 2025
 14:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com> <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
In-Reply-To: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Apr 2025 14:34:49 -0700
X-Gm-Features: AQ5f1JrYVHMlDWZJxH4-18lt1qU_d4NlCtPkRQrCGOovJWEhE1ANrmdC3YBUzu8
Message-ID: <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 5:05=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.11.24 00:23, Joanne Koong wrote:
> > For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> > it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set o=
n its
> > mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, =
the
> > writeback may take an indeterminate amount of time to complete, and
> > waits may get stuck.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >   mm/migrate.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index df91248755e4..fe73284e5246 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_n=
ew_folio,
> >                */
> >               switch (mode) {
> >               case MIGRATE_SYNC:
> > -                     break;
> > +                     if (!src->mapping ||
> > +                         !mapping_writeback_indeterminate(src->mapping=
))
> > +                             break;
> > +                     fallthrough;
> >               default:
> >                       rc =3D -EBUSY;
> >                       goto out;
>
> Ehm, doesn't this mean that any fuse user can essentially completely
> block CMA allocations, memory compaction, memory hotunplug, memory
> poisoning... ?!
>
> That sounds very bad.

I took a closer look at the migration code and the FUSE code. In the
migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
mode folio lock holds will block migration until that folio is
unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:

        if (!folio_trylock(src)) {
                if (mode =3D=3D MIGRATE_ASYNC)
                        goto out;

                if (current->flags & PF_MEMALLOC)
                        goto out;

                if (mode =3D=3D MIGRATE_SYNC_LIGHT && !folio_test_uptodate(=
src))
                        goto out;

                folio_lock(src);
        }

If this is all that is needed for a malicious FUSE server to block
migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
mappings are skipped in migration. A malicious server has easier and
more powerful ways of blocking migration in FUSE than trying to do it
through writeback. For a malicious fuse server, we in fact wouldn't
even get far enough to hit writeback - a write triggers
aops->write_begin() and a malicious server would deliberately hang
forever while the folio is locked in write_begin().

I looked into whether we could eradicate all the places in FUSE where
we may hold the folio lock for an indeterminate amount of time,
because if that is possible, then we should not add this writeback way
for a malicious fuse server to affect migration. But I don't think we
can, for example taking one case, the folio lock needs to be held as
we read in the folio from the server when servicing page faults, else
the page cache would contain stale data if there was a concurrent
write that happened just before, which would lead to data corruption
in the filesystem. Imo, we need a more encompassing solution for all
these cases if we're serious about preventing FUSE from blocking
migration, which probably looks like a globally enforced default
timeout of some sort or an mm solution for mitigating the blast radius
of how much memory can be blocked from migration, but that is outside
the scope of this patchset and is its own standalone topic.

I don't see how this patch has any additional negative impact on
memory migration for the case of malicious servers that the server
can't already (and more easily) do. In fact, this patchset if anything
helps memory given that malicious servers now can't also trigger page
allocations for temp pages that would never get freed.


Thanks,
Joanne

>
> --
> Cheers,
>
> David / dhildenb
>

