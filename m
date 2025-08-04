Return-Path: <linux-fsdevel+bounces-56634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A2B1A09A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 13:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DAF178C8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2923BF9B;
	Mon,  4 Aug 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJsKnsNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00752046A9
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307289; cv=none; b=svNCqrSh/nRkY/DKgfjcZcZDU2kBslR29QpP0M6vnPYp51X2+cXm3Dbtroxh3y4Sw+5wWIQAPJ6SfQbSoClOFjTuttthXVCl/mHpDP1QrBnzj10H4ZBc3k53hTtMQWpdZC9VUk8pGcwAIHQmeJc4Rdo8FybTcuMYpLLgGfKY8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307289; c=relaxed/simple;
	bh=ulhD4ZkuDAK3k2qDQl0X7/UyqpKU+NyG3I0TjP00sss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8PKbQ2oxcacJBB4E15ZTvfTFP3yC3zMX99t2ac+QP2+OQ+No6AfBWf0jcONb26ZeEAy/DGd1SnRAddgwGUeBYEt4GyFkO7ku1pCXFlHEhGFAfyONG3JVjqqRhNvlDOzvhe11nWAxwr4ERC887cvMSZfvo3UwbYn/Ov5PdC9MHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJsKnsNU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754307286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3V1T20G7TfHh7dK0HImr9yuZ74iE23wyw4ljPa6v4iQ=;
	b=WJsKnsNUcPz6UO4TkAB21UigK36qjuEAwtEXhEJxgQxrvIvqXvlnUPp0KyLZj2uKlMTtOu
	4Dj4Jg5GbE106gQTgNa88ZfaE0pMXnMPdOlSWipAJSktT4CZHhlSiujqHoTEMlKkYjHLhA
	kMqy4Lg7dPEj7SeQBfR5yFn7Do+tXfI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652--DNC-n-3MNOFeE5PCEFuQQ-1; Mon, 04 Aug 2025 07:34:45 -0400
X-MC-Unique: -DNC-n-3MNOFeE5PCEFuQQ-1
X-Mimecast-MFC-AGG-ID: -DNC-n-3MNOFeE5PCEFuQQ_1754307284
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7889c8d2bso1691610f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 04:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754307284; x=1754912084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V1T20G7TfHh7dK0HImr9yuZ74iE23wyw4ljPa6v4iQ=;
        b=N62SD2ohW2ZMZZRl15hWeO+BzGlSz2FzeCiIc2CMIGRDPmJhuvfQXECqsL4oQZLUCd
         sznoVQFREUGe6mSSWywdmvZmhIeeVdd9Ac2pCaLFcfl5ba08oJMg1a/SJZcJpp4fxoFA
         0FnLBftZ+akO95QNKbd9b6XxZGUk/kNtH9ES4AiVo8ephCpHLqRWAFWiKdAR4MPeEmC3
         W83WcmafsSrDWffRvj5fK1X6Qr/MIBhy3+cUsbtK6e5sPzm9UxlvRcCSIL6d8S475SnP
         qEvJcoyHf/GK8WdUBnwQSNorAKvpIUGgI08B296+jvl4X8iyPG8IruD6Kx+AFq9NJ+C/
         EdMA==
X-Forwarded-Encrypted: i=1; AJvYcCU0/goju0xQrSKCKrBLY5CozOzmV9dOnMWj8RV2Qe5474WPxY5ugeVDO89HaVNUfgo7r29JyPhH4CZAjLsZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZvDbZY3ldljZYMiuKNSONVUMw8gs4nF23Z/EGx4XTYsZra40
	bsXvju9cLFks8Pkc7ueZrJixz8s4djw5BwfSUVD/wCGcXLl4J+ixBsPW3BRO8yyZg+KRFFnNK0Y
	SHsn9E/GQi0AvYXnfKPk4eEcR+JuusIezpfd9/847z3WznmLINMuHf3TdJN0XBSHhG2VhZAEYwg
	==
X-Gm-Gg: ASbGnctUV/lFtjfUa3fhMt6PZ2y/3vHy1VDqRTRI//96qfsM+7sCg4PDg98IyMCKCEl
	4adeLI5cXXOmBTBjot0vebMHsaErRMcOWzK/FwapT0CgIEwd8SaiOlzY0Mmny1Jp1CM8x3J4u5I
	baQ+f4TQJnaEq4g/QahU0yIsJVditLhCUs972hSlyOS5fZKsh9ZgSgYsOW3cZYB2p+XwWQN53zz
	tkJbrz0J40zCEbQk4hZLx8SCPyYiomW/BvUa9C+GQ3MxumOt6NTEv449BwvhnaI3yyqch78zQTY
	zAu1KrUft5DnSvPeUAtjnUnb8XrfbfEolClm1NuKVMIczGZpuLxT9GHnbhk=
X-Received: by 2002:a05:6000:4308:b0:3b7:9af4:9c75 with SMTP id ffacd0b85a97d-3b8d94b5f5cmr5721836f8f.30.1754307283916;
        Mon, 04 Aug 2025 04:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECSNlAqX2SbDaV4025aA/QtAgxGcECmwvMzo9vl9cLxYwe+gfIm+JQX3+RGKTbSCjXQi1ysQ==
X-Received: by 2002:a05:6000:4308:b0:3b7:9af4:9c75 with SMTP id ffacd0b85a97d-3b8d94b5f5cmr5721809f8f.30.1754307283439;
        Mon, 04 Aug 2025 04:34:43 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ad803sm15173444f8f.6.2025.08.04.04.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:34:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:34:41 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org, 
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 01/29] iomap: add iomap_writepages_unbound() to write
 beyond EOF
Message-ID: <nusz22lytklhy2qlc6ihpp3onpwckbvpo5lohmcsfyjbgnprqm@mi6u5fleplah>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
 <CAJnrk1ambrfq-bMdTSgj=pPrGW6GA1Jgwjvx8=sy8SVR67=bJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ambrfq-bMdTSgj=pPrGW6GA1Jgwjvx8=sy8SVR67=bJA@mail.gmail.com>

On 2025-07-31 11:43:52, Joanne Koong wrote:
> On Mon, Jul 28, 2025 at 1:31 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> >
> > Add iomap_writepages_unbound() without limit in form of EOF. XFS
> > will use this to write metadata (fs-verity Merkle tree) in range far
> > beyond EOF.
> >
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++-----------
> >  include/linux/iomap.h  |  3 +++
> >  2 files changed, 43 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3729391a18f3..7bef232254a3 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1881,18 +1881,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >         int error = 0;
> >         u32 rlen;
> >
> > -       WARN_ON_ONCE(!folio_test_locked(folio));
> > -       WARN_ON_ONCE(folio_test_dirty(folio));
> > -       WARN_ON_ONCE(folio_test_writeback(folio));
> > -
> > -       trace_iomap_writepage(inode, pos, folio_size(folio));
> > -
> > -       if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> > -               folio_unlock(folio);
> > -               return 0;
> > -       }
> >         WARN_ON_ONCE(end_pos <= pos);
> >
> > +       trace_iomap_writepage(inode, pos, folio_size(folio));
> > +
> >         if (i_blocks_per_folio(inode, folio) > 1) {
> >                 if (!ifs) {
> >                         ifs = ifs_alloc(inode, folio, 0);
> > @@ -1956,6 +1948,23 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >         return error;
> >  }
> >
> > +/* Map pages bound by EOF */
> > +static int iomap_writepage_map_eof(struct iomap_writepage_ctx *wpc,
> > +               struct writeback_control *wbc, struct folio *folio)
> > +{
> > +       int error;
> > +       struct inode *inode = folio->mapping->host;
> > +       u64 end_pos = folio_pos(folio) + folio_size(folio);
> > +
> > +       if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> > +               folio_unlock(folio);
> > +               return 0;
> > +       }
> > +
> > +       error = iomap_writepage_map(wpc, wbc, folio);
> > +       return error;
> > +}
> > +
> >  int
> >  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >                 struct iomap_writepage_ctx *wpc,
> > @@ -1972,9 +1981,29 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >                         PF_MEMALLOC))
> >                 return -EIO;
> >
> > +       wpc->ops = ops;
> > +       while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> > +               WARN_ON_ONCE(!folio_test_locked(folio));
> > +               WARN_ON_ONCE(folio_test_dirty(folio));
> > +               WARN_ON_ONCE(folio_test_writeback(folio));
> > +
> > +               error = iomap_writepage_map_eof(wpc, wbc, folio);
> > +       }
> > +       return iomap_submit_ioend(wpc, error);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_writepages);
> > +
> > +int
> > +iomap_writepages_unbound(struct address_space *mapping, struct writeback_control *wbc,
> > +               struct iomap_writepage_ctx *wpc,
> > +               const struct iomap_writeback_ops *ops)
> > +{
> > +       struct folio *folio = NULL;
> > +       int error;
> > +
> >         wpc->ops = ops;
> >         while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> >                 error = iomap_writepage_map(wpc, wbc, folio);
> >         return iomap_submit_ioend(wpc, error);
> >  }
> > -EXPORT_SYMBOL_GPL(iomap_writepages);
> > +EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 522644d62f30..4a0b5ebb79e9 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -464,6 +464,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
> >  int iomap_writepages(struct address_space *mapping,
> >                 struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> >                 const struct iomap_writeback_ops *ops);
> > +int iomap_writepages_unbound(struct address_space *mapping,
> > +               struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> > +               const struct iomap_writeback_ops *ops);
> >
> 
> Just curious, instead of having a new api for
> iomap_writepages_unbound, does adding a bitfield for unbound to the
> iomap_writepage_ctx struct suffice? afaict, the logic between the two
> paths is identical except for the iomap_writepage_handle_eof() call
> and some WARN_ONs - if that gets gated behind the bitfield check, then
> it seems like it does the same thing logically but imo is more
> straightforward to follow the code flow of. But maybe I"m missing some
> reason why this wouldn't work?

Yeah, that's another option. If others also prefer flag then I can
change it.

-- 
- Andrey


