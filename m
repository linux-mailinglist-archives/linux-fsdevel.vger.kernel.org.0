Return-Path: <linux-fsdevel+bounces-63933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C0BD1F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5CB44E7C71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CC2ED14B;
	Mon, 13 Oct 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWUOxepc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592E2EC0BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343316; cv=none; b=cZcVZR1SzaR9ae1foHcgZSVoLLwk/+iL5HaglWD1ZETsvY4lg+Qt5ZJ2TviX3pYAmCP1jzj1uRzdKca1rMBlq7qmBcTwnhczRRDh1uuaQUoU9Oapb7uX8Ciaodw/nnZzv5XMEHnT3OKix3/miVuRoKQ6fy/0SwJug9WVEdkPWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343316; c=relaxed/simple;
	bh=ZDF9V6SdJC6O5Ci089i93CmqQdlIvNR7SmEpklYtaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OURJb1JML9J6KGr03s01K6x/f/sG5qttZPg3JZtF9atsoPf2mRVL9PywwSeMnKYKIvsf7zKu7j3UB3xxxZFZXr4UUd5E+5x0aWg8CJ2tRc2j5fhKp7YjIuBe5lVIRSBoIDGApI4ru+aqF4KwS1HUrCuk7SOH5X6X+4+5Ya7kHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWUOxepc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece1102998so2216116f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343312; x=1760948112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=TWUOxepc3LLnWjGWhlpuHdQuyOvh1ON8xPxTWN1Zt6RiP1dtffxt4BH+p9AwPuPWyA
         geHyO99HKN5xJeEgPSwZSVggoXYsZPRq4ILO8nzuMg5ZksDS24Zk+jMdG16+tMSJImxz
         wtpNPgMSRbeik7p43Pew6RjImi0HsVflcYX0kBYv0BIi5iPuPZO6MNT5BEoyQ3Axt4hL
         IrsdBj05F4bFxR+l/enqx/DIwwBTw8wttmrzTfskfs/TkXAAGD9nuV6pFiLgc9vaRJZ8
         HHMC3vJMy38yQU6/w5sVcUlez0lZ+Ayesxup9glXl39siTmpxyelVxLCOFwS7MPAsAHF
         J0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=Lnnvoen+SVCqAjWEaX8KzczUSn5sATmP85aEPw3z+SpuohgL2a6/8EiZt1eU8z0UpD
         hI2dR/Y1PNtRO2HUClHGKMDLGVxqQKxRMbsekfPwfXtfx8/HPstePTZijaXJvTbbwHsu
         zt/BujBKqXR4TP/ESWIOHY6BKi9KK739onbPJu6jtQmyihEcXN7pucSOiAf7rcnJTKil
         iKsUTSw0AkuUmZP9sV00LoPXo42Vu448oCvw/VYMeRnAizZp/3iEbfg2iTiVj2kwTBRJ
         oG4FrmWfPuO9wdjMBNvsQZvTRuQY2ECB4WTp+qp7E+tnilgGISIYWubXR5Ff+hnAOx2M
         F2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWOrX4TP5ZmGkWCHqAKo4Tn+FPMR0S0TsQ/HgpZ4hT52cFQkkQLk6DyYa21a3do7vVpCJT043KVxAvYSvKf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt49VZEmET2OWDSSzWJbYmdJ1uB2bN47rlVFxe/hd9JnNc7QR
	4/u5a9qAcnN9xFJw9qduuuCrNJYAnwokDAcklNUzKlp+V4MSdXmmUnZThAV9Z7UVnLEJYKYVS/+
	2IV1pYqdCAhMjYY0u5N02W9GX5RNfZatyW6oVwutFJA==
X-Gm-Gg: ASbGncuaeO4zLt/K0I6gAMwyqiFYRQntnXZmEDCFAjYzdL+QpYWrOaXJ+MIj5otSLUu
	efAZbKSxV1dJ5w6QoOYVcfl7mmFxMvLUlm9RdBud6xgtoXNK32I6mvNjqiiidPPJFeDjTBX+FS7
	x8zuSczPoChNJ+1HzstgRouzFJG2mp055ltHn/TSbXjC6gUMIuSVQ5RW1ik0U+hqjaUeqi+uPUZ
	VXH1TpBPKtOUPgiY7JqKyrBPHN45n50VRg=
X-Google-Smtp-Source: AGHT+IEXSnK8vgh5qb4+sZ5l2hFRJWnorbBdcfDu2E4RvgYsaMIAeq5q8p6/Cp6GKDAeCkB0EX+DEBuZJrHy3pYKRvM=
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr13043087f8f.17.1760343312390; Mon, 13 Oct 2025
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
In-Reply-To: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 13 Oct 2025 10:15:01 +0200
X-Gm-Features: AS18NWCgT3XSP_MN-BMfr65K92-imDhnpGub1dZ7jpbkZ5N0Fj6p03e4QIM-oxw
Message-ID: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > In preparation for changing the filemap_fdatawrite_wbc API to not expose
> > the writeback_control to the callers, push the wbc declaration next to
> > the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>
> s/thr/the
>
> > start_delalloc_inodes.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> ...
>
> > @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >                              &fs_info->delalloc_roots);
> >               spin_unlock(&fs_info->delalloc_root_lock);
> >
> > -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> > +             ret = start_delalloc_inodes(root, nr_to_write, false,
> > +                             in_reclaim_context);
> >               btrfs_put_root(root);
> > -             if (ret < 0 || wbc.nr_to_write <= 0)
> > +             if (ret < 0 || nr <= 0)
>
> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
> asked for. So I think you need a change like you did in start_delalloc_inodes(),
> no ?

I understand nr is updated to what's remaining using the nr_to_write
pointer in start_delalloc_inodes(). Right?

--nX

> >                       goto out;
> >               spin_lock(&fs_info->delalloc_root_lock);
> >       }
>
>
> --
> Damien Le Moal
> Western Digital Research
>

