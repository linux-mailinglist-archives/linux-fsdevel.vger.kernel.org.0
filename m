Return-Path: <linux-fsdevel+bounces-67155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A7C36BD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E953E1898DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36F335082;
	Wed,  5 Nov 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MWu2qJtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBA2EAD16
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360398; cv=none; b=QZW3BzuheSYkv78ylldvvK3ZelUdAGIAQyRKd0Mu3G6BQDCCJPLf5QCrFSms4P8TqU61WVrNwbdlf8o0cx1Gy3Z5CzQMaap5wRVmp5NJoRYNAd4Ch6i1xbquzYczuz7Cu+MX0f4i1ErMdt6jtrF7AIZk981Acpx2s6E3/M2JNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360398; c=relaxed/simple;
	bh=Q3KigkSvYwK5JS9sgke5e3cj+3o6CQW5ok3nCz3pwtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNgnWRnXg01Z2l820pkyuc546jHJgrUaXqdqgz8MgERzPMZ2gNvduRFhimN8UezACNk3EwRRLpw74GY3TBg6PvsDkdxuTRWYOreQuPibQ9ezvA6Bqvgf5h7wb0cxd/mUb2dJpv01xPs6a46uQPjawr0B+lI+axT17pJoaJe+JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MWu2qJtv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775a52e045so5835445e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762360394; x=1762965194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxgECH2xm74nun5bYq3yo2lzpHEkoDKEqM0ldiRMQUQ=;
        b=MWu2qJtv8JOAzbF1l/Dfac/mUsfdWhU2PrESm+dpybLCBJnwzUc5LHrzFeyYicizZV
         QL5LsPtr47GPBuYwF8wfqqratL1fUBnLrJQgjcd1b6s1YA5rBYsnDmKZtyC+Ow4HlU7q
         AQAzpscIlmpbTdyPvdctdJ4BMh5qMwsRjkj6Fvd9CQpDsyMSs6TflhqWP9RFDLa7M+s9
         2x+sz6cJAfEGwCS44z+5XqDOE7iMxrzY9LgrIibeHzjTnzPqRpjtAaPxUpMHDj3E8GAt
         yMCulqkogs5ujpeBt7WOZ06BLnkdGw2GL+AKqfoZKxG1ywoPe9n9aKsPQ94PivQ4Ssmu
         HHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360394; x=1762965194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxgECH2xm74nun5bYq3yo2lzpHEkoDKEqM0ldiRMQUQ=;
        b=Ds2BwNrdXi5PtFAw67HC8rt62FdjB7YjDxBKu4EyiTXZslj5/kYOMRThdymMJuPfg6
         Y/Yha5B+uLeglSwoNH1lCWsIh3/eMEsi67MHQX/CGVjSfAv7cJnbEJWAQmJ3++yG4BwJ
         QVzpw2fh1nR3Y3dYL3kIM+xMpJMePGJA9wZ0iKyQf8jZQEpmwdbfyO00i3T57vPDcFrW
         6luzLlgKA/UPhqZszhlXMY2UaZtFk1pqvogK2BwUJGik4EP8aBiLeihOj5la+sOUbKo8
         ZwXdJa/CY9jANEuPGvEDp1ytWsZfVJd5tsCSbFP/9/fU/4c5Hy9cC2HAoVNRplUNeOFm
         5EDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZORakoQeVRlqTC2WKdWBuS0WNbkFJU+PYqOzOnRV9mIpmtqTi/v45QdcgWrPzWuGoy6XZPkDCdAWIQKb@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdWyBdfvxAyvt8+69ljrL7AmgCY90iyhOvKwsPU5LP+7TPmP1
	h2phmccDESTe2fAwQHsoM/ESE8caLTRqOnmTGFMVvTHRm3W6w9o/0HfgPLDAUAsNROrcVUtyoEJ
	scCY9jX9RcM/H47yfm7QrVcQjJhzqgBnrTQTvthYKpA==
X-Gm-Gg: ASbGnctf4fHt+PpUE+p7x4u/q2LY6xCe2R82lCYIe6FiocyQ46tNTm8UQleUq9bdZ/d
	AmMBHQiZap8MNSW/3048vGF6TPFKtB4euvtP+0kMNSgBU91IYS1mupnzInYRJm9E6Itcph5+Gca
	x4xmGd9UCM6StY2L1U+4KLcgZqqUnvKOUvtD2s+skmpVKsX/o/E7WAk2OBKqr1+k9IkvlnevpVh
	Gk3TZsQakKWVS7VHVRIPReFub4I5yBcHEyHWeDjZHAAlPbBu3dqtJ7jIWfJG1Tbu+WXWYRqdtv4
	OM4ed1qK3oKx5dop1M1VZAE/rKmvzhuTB8Sukub7t7t67RzECnTPLakNyA==
X-Google-Smtp-Source: AGHT+IEz7I4CY+GlSdoe/bflZWVcU0m0o1McZfVokzTIe0B2RRVoH+RBVlVjzJASkrgFqD3eiDzaXjnkv21y5vlztVg=
X-Received: by 2002:a05:600c:4584:b0:477:55de:4a6 with SMTP id
 5b1f17b1804b1-4775cdbe238mr35989165e9.3.1762360394279; Wed, 05 Nov 2025
 08:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-2-5108ac78a171@kernel.org> <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
In-Reply-To: <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 17:33:03 +0100
X-Gm-Features: AWmQ_blmtnDHlxA5kivLFHuNDFJT0rxb6Yv2ZgkGpfB5WfZtUJKHjLM2jWHF-pQ
Message-ID: <CAPjX3Ffptip7onCpm30OiC+zvfNV05_B1GQYM4-Lem-V12_ERQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] btrfs: use super write guard in btrfs_reclaim_bgs_work()
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 21:43, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/4 22:42, Christian Brauner =E5=86=99=E9=81=93:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >   fs/btrfs/block-group.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 5322ef2ae015..8284b9435758 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1850,7 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
> >       if (!btrfs_should_reclaim(fs_info))
> >               return;
> >
> > -     sb_start_write(fs_info->sb);
> > +     guard(super_write)(fs_info->sb);
> >
> >       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
> >               sb_end_write(fs_info->sb);
>
> This one is still left using the old scheme, and there is another one in
> the mutex_trylock() branch.
>
> I'm wondering how safe is the new scope based auto freeing.
>
> Like when the freeing function is called? Will it break the existing
> freeing/locking sequence in other locations?
>
> For this call site, sb_end_write() is always called last so it's fine.

It needs to be used sensibly. In this case it matches the original semantic=
s.
Well, up to the part where a guard just consumes additional
stack/register storing the sb pointer. That is the price which needs
to be accounted for.

--nX

> Thanks,
> Qu
>
> > @@ -2030,7 +2030,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
> >       list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
> >       spin_unlock(&fs_info->unused_bgs_lock);
> >       btrfs_exclop_finish(fs_info);
> > -     sb_end_write(fs_info->sb);
> >   }
> >
> >   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> >
>
>

