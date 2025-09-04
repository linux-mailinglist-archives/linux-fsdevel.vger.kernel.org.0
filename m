Return-Path: <linux-fsdevel+bounces-60322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440FB44AA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3717BA483FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC672ED168;
	Thu,  4 Sep 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukqvi8mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BD23507B
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030370; cv=none; b=kwHKq/huxRQSN6UAyOv4oJ2yQpGbqkidqG2pYdKkWq+f+qPNBmn0Yoxoa8tsVS7rrDAoDGY/rO9iAkVd1Fd7CYRyrL17Iid43kKFW7X9rgbl278/MpTFi5Ml9Jka4HvwkHdqbscvu/5oKJEOCCb5pzg/NX35RDbtpE4fL8diL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030370; c=relaxed/simple;
	bh=lQNJODGpBoKfekJMtF9lQARyIrNDlcr6tlmsP/pDza0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5/DA0f8OllesqZDaRRSg8tlmaUvJ4le6+0WtulDT2b4zT7A/cuBrCExPT1kEIE97e14Ym9MEOCOCcnaRe1SZ7Hwzzoacv13ZehLxDJcl+CTjRiPlQnROrCK2wrm6oshEFkquqoPnrYu3+7TjMyxFSblC3WWMwHlFzBcKn5Rg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukqvi8mm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b38d47fa9dso16608351cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757030368; x=1757635168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJBouPfqG8rk327P5Sr7FS9kMnQsPpnILmql925f154=;
        b=Ukqvi8mmkEdGxqx40ZzJzSCSXhsVqDyLNYa6AXTXdI9bO5/N6+0sUmhS3E0ZSSaFR1
         zlaWyv4+P9V9d4f/SJ5rXsi3Hkv2bKeHv9u1IanEr74cIqLLiOaBcWQa6aYbx3Gje3LD
         7dwb+VEnCFN5DwR/YT0l6GhUCpsjgXJw9mjtU7QqX6rZIXJ76RIsMOVJOtokNAdVAeSj
         9Idj/yXzs6hAYWIcHc+2xZ2256A8XvADpeEh5FVqcUnJIAzV7Lojb6BrHtZlJ+/bcHi6
         GA89yKPmCrcMO5RLUDEbFwMXicxWtXpdTsHX+2FbuTtV2Ev5sQuEJqCQyirEBj7PcPPZ
         uhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757030368; x=1757635168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJBouPfqG8rk327P5Sr7FS9kMnQsPpnILmql925f154=;
        b=OjOwJhgEFEw/nwA0w/Z9lREJ5f7n5suDCEDoR8YkN2T2Fb9aBXZzFVMapLuGtTP+Ew
         WUE1+95Q5pIHMHkdHytCuqglylPSdbLBc34s4Ru7w/y7ydr5dzEuxTg12Wf9UZv2sNcB
         yEvqexG0xfcLKO+dz7UyLer1W90Lg3Qrzl440Ck71pS8tWDUd7XpUreowSGuTaA+62ao
         R/JwsEEf3i+D6I9d/TCzblDR53og/KNk3Ic6e3N8kf+FEUJtwoPf9VQgIocsyW+oeMOT
         LgbakzrQUa9QGs8lpk/h4CLb2ogPiHC/JmOr9HPPZK6KlhkydpxoCCqhAzsH10613gE0
         FORw==
X-Forwarded-Encrypted: i=1; AJvYcCWHo26u4lvJsi2AtIhG7gdPCVx8xCw8GL5bUF7K8n2rtVVXTeMQJaqeIZ5UrNJ6poShXGWKEZJIU4Dm40+a@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6IqIo1V/B+Yu6ORSwJLXXDGidtY7Sf/NtM4XSFn2ar05B1bg
	dMIATWRjBH39Ous4xLEbReAZe2qKRk//Vwp+KPXa2jRTIV7Lk+Y4Hd1mca+Hx1R51yWjii5fTI6
	AtBbIDByGD7PXWqa7WnFhmn/NxxtZKCRzG0pU
X-Gm-Gg: ASbGncvtb/e8maR/MgcPFIMcVn0RvO0mKC6OHJlSeO5NEl0uQIYoyj885JtHy0LddMh
	IbVUl9xDU9DP/thp+CFcL/Rf0+jYszGazYM4oIC8MXeY748kEVgtt4ZD7jock98RuBdgxa8o6FC
	C7a9nBALlINxJAVJh1vJdvWy90p+bIcOwLmQ3+wrpOBeZJEGl3cEeo0VgbPv/fQfngW3IK2L/n7
	wq0Y1ZSrIF3Vn/GXEA=
X-Google-Smtp-Source: AGHT+IG7SWs3uBaCgr6Bk63bbgSay78hiDZMZwtKTG8KVcQoJE3BLbhdg8CGYoBFjcBVILlKQkPYKny5F2e9/SRKbkg=
X-Received: by 2002:ac8:5e0c:0:b0:4b5:eab3:66cf with SMTP id
 d75a77b69052e-4b5eab369c6mr5814821cf.30.1757030367682; Thu, 04 Sep 2025
 16:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com> <5qgjrq6l627byybxjs6vzouspeqj6hdrx2ohqbxqkkjy65mtz5@zp6pimrpeu4e>
In-Reply-To: <5qgjrq6l627byybxjs6vzouspeqj6hdrx2ohqbxqkkjy65mtz5@zp6pimrpeu4e>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 16:59:16 -0700
X-Gm-Features: Ac12FXxrKg1CfKQQYXnuIWvXPvLbwk3vb6DFX9OL5MM-vJTNf-WDPPYhOVBjoy4
Message-ID: <CAJnrk1acU+bs2uJTSjTgeGYCMavSpokGbrngoTE-3Hay4KZsWw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/iomap: add granular dirty and writeback accounting
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, 
	hch@infradead.org, djwong@kernel.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Fri 29-08-25 16:39:30, Joanne Koong wrote:
> > This patchset adds granular dirty and writeback stats accounting for la=
rge
> > folios.
> >
> > The dirty page balancing logic uses these stats to determine things lik=
e
> > whether the ratelimit has been exceeded, the frequency with which pages=
 need
> > to be written back, if dirtying should be throttled, etc. Currently for=
 large
> > folios, if any byte in the folio is dirtied or written back, all the by=
tes in
> > the folio are accounted as such.
> >
> > In particular, there are four places where dirty and writeback stats ge=
t
> > incremented and decremented as pages get dirtied and written back:
> > a) folio dirtying (filemap_dirty_folio() -> ... -> folio_account_dirtie=
d())
> >    - increments NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE,
> >      current->nr_dirtied
> >
> > b) writing back a mapping (writeback_iter() -> ... ->
> > folio_clear_dirty_for_io())
> >    - decrements NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE
> >
> > c) starting writeback on a folio (folio_start_writeback())
> >    - increments WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING
> >
> > d) ending writeback on a folio (folio_end_writeback())
> >    - decrements WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING
>
> I was looking through the patch set. One general concern I have is that i=
t
> all looks somewhat fragile. If you say start writeback on a folio with a
> granular function and happen to end writeback with a non-granular one,
> everything will run fine, just a permanent error in the counters will be
> introduced.  Similarly with a dirtying / starting writeback mismatch. The
> practicality of this issue is demostrated by the fact that you didn't
> convert e.g. folio_redirty_for_writepage() so anybody using it together
> with fine-grained accounting will just silently mess up the counters.
> Another issue of a similar kind is that __folio_migrate_mapping() does no=
t
> support fine-grained accounting (and doesn't even have a way to figure ou=
t
> proper amount to account) so again any page migration may introduce
> permanent errors into counters. One way to deal with this fragility would
> be to have a flag in the mapping that will determine whether the dirty
> accounting is done by MM or the filesystem (iomap code in your case)
> instead of determining it at the call site.
>
> Another concern I have is the limitation to blocksize >=3D PAGE_SIZE you
> mention below. That is kind of annoying for filesystems because generally
> they also have to deal with cases of blocksize < PAGE_SIZE and having two
> ways of accounting in one codebase is a big maintenance burden. But this
> was discussed elsewhere in this series and I think you have settled on
> supporting blocksize < PAGE_SIZE as well?
>
> Finally, there is one general issue for which I'd like to hear opinions o=
f
> MM guys: Dirty throttling is a mechanism to avoid a situation where the
> dirty page cache consumes too big amount of memory which makes page recla=
im
> hard and the machine thrashes as a result or goes OOM. Now if you dirty a
> 2MB folio, it really makes all those 2MB hard to reclaim (neither direct
> reclaim nor kswapd will be able to reclaim such folio) even though only 1=
KB
> in that folio needs actual writeback. In this sense it is actually correc=
t
> to account whole big folio as dirty in the counters - if you accounted on=
ly
> 1KB or even 4KB (page), a user could with some effort make all page cache
> memory dirty and hard to reclaim without crossing the dirty limits. On th=
e
> other hand if only 1KB in a folio trully needs writeback, the writeback
> will be generally significantly faster than with 2MB needing writeback. S=
o
> in this sense it is correct to account amount to data that trully needs
> writeback.
>
> I don't know what the right answer to this "conflict of interests" is. We
> could keep accounting full folios in the global / memcg counters (to
> protect memory reclaim) and do per page (or even finer) accounting in the
> bdi_writeback which is there to avoid excessive accumulation of dirty dat=
a
> (and thus long writeback times) against one device. This should still hel=
p
> your case with FUSE and strictlimit (which is generally constrained by
> bdi_writeback counters). One just needs to have a closer look how hard
> would it be to adapt writeback throttling logic to the different
> granularity of global counters and writeback counters...
>
>                                                                 Honza

Hi Honza,

Thanks for sharing your thoughts on this. Those are good points,
especially the last one about reclaim. I'm curious to hear too what
the mm people think.

If it turns out this patchset is not actually that useful, I'm happy
to drop it.


Thanks,
Joanne

