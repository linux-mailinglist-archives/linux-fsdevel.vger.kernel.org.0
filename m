Return-Path: <linux-fsdevel+bounces-63863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89398BD0820
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A661895135
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6B2EC541;
	Sun, 12 Oct 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6M5COTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056F19258E
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288563; cv=none; b=kYKGqlpvoLcTiC27YdKHmfQB7P4DGJihTGsUsAAmLJbvVodE1Zv7TgOR/3uggbgA2+9ru/gYmDoDWQ13p0eDUskto9GBKknFik5S2gdLYL2K/wf/QyeBi7qeljicu0ITkHilO4iGxBIjEJnR1q3annsVFEWe057ZJCCzIQ85L+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288563; c=relaxed/simple;
	bh=fzoINW0yQf7mFi6Ce0cd67Ul/S7imhSgcKeCXM8ejzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl2ow2oW2r90qpQ1JnDhm+j8iKQs1GyHu+j4iZrlBBLE7bv4bkYWB6FGPJpp0598W2abk2wpjS/tn33OcYactUTT+7VvU4xFtDzk9UizyE70vMbygxRIFYDYhaN75N/Nqa7QcFMzb5Zh0eUNqO39CE68F4scAzoIUI1iDNzV3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6M5COTO; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-77f9fb2d9c5so31438617b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760288561; x=1760893361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/knOw+O1ez/psbJ8n6qPMWfaibnPUlgK1U5bFjqZ0Y=;
        b=E6M5COTOOHik+2wE6Y3QwYZUCGctx2RtzbMpiTTUV/e613CHGefGqOA5+jCVhWtAHG
         zhTJKMUeZtwedaEdL23mcgqynoez2LNpOnbD0PN5+4ch2pAertYeDi93pCzqmZrNmPz8
         D96/cxjwNWVlKRcWn5Vv1ul8GRhw31WQcBFOmp9Dk6iZ2QrECJsTS/wrp4xB3pinAzqk
         F6jlfku+qXOrzi/FiPx3EtJph/juUiwLPbj8Hid6RqnnpXs3361tMkXckV/Y3et3KdBg
         0vtTM7L0UE8ToJuEg2vz4ApaBz8Rn4mr6ch43E+05bW59x2wrXUuc/P/ZGVy0BioAgkr
         Pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760288561; x=1760893361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/knOw+O1ez/psbJ8n6qPMWfaibnPUlgK1U5bFjqZ0Y=;
        b=maa6vy3m7y7e3cRkahPJVmi5Pt2mBe+ailNRf0/PTEOMp4BE1R3kf+FT/EoOLZ7pCr
         j9nqEY58tRR+iDu8RBCqS4BD1xbuSqBfMKMBKfBJD60zrUJ7cabLjiUf8dMMFmTvzn1Y
         zZbH7Mjirmf4LI2wHAC3SAVevE8sLYn/NRq3/bkwtRJFwoAWmJXd7tWHR41KCzb4QO/i
         MQceJgVYMBXmr1B8lxHYJkplqjnVWDp+Nf7BDGA+t4BJIpp1VUxddAlW6+GLwbNaq+o3
         163pNpOIHVKIZb6C1sOD6spvrmnFAjC9fV6+k6Be9a4SgPMYaLwNzxPRzrlobF+BoPlQ
         W69w==
X-Forwarded-Encrypted: i=1; AJvYcCW2nqHoOghZfgllYhbkI4uPpBbnSUVljOejA01SbjaAcZ/y+eiU4wZ0anjUKePprc7m5WOe5jQEdxOK3CpH@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuVozv5hdhfrrHydQXWcHGXykTxbuZaWMDnYLjDAMCfCHdJBE
	awSnjxJC+IFCrMQ6JkixnrACBu3sgDPUsj03qVq6wT0+6BQL9/yTJdxDjazw4r8k+HsSfE+kATk
	L4PNS3MnsTmYrR0UehVwqcclEaVddU1kBPAAqlKIr5w==
X-Gm-Gg: ASbGncvgmnu8GZiq6UKWbCjRS+gt2ejlN7o+zDVXS6tqoIOEiG3CXAHLdEvliVaLvLM
	RphSPK9p6pm1GCRb7WaYlUBDJgnTIErtAqNfjyk8GDZBktgKIlgQfrWC/Nrc/l/bozcWL7kQBqc
	/zB/vzrPAS7riRS0br/MJOHD4ghYBDeVCrQkZ4Z2DbNztbWoMqXbUbUAtmffvNoMtsrdexUC6Tw
	Gdh6BmkefzWfMf86VAyDJKj2DgxccI//R0=
X-Google-Smtp-Source: AGHT+IFo+0lgBz6b0uIaeffB4CHFL5q8ijSM8dQ79T0H7f1iYlbW9aB9Z3CLXE5OXLEWTpzLM/gt7jwXbYkkxvwuesA=
X-Received: by 2002:a53:ac0b:0:b0:633:ac5d:2a03 with SMTP id
 956f58d0204a3-63ccb7fb237mr12767510d50.6.1760288560982; Sun, 12 Oct 2025
 10:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
 <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
 <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
 <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
 <CAK+_RLmbaxE9Q-ORiOUV8emrB+M6e7YgUNZEb48VwD28EuqwhQ@mail.gmail.com> <ddd2cd94-683f-462b-a475-cc04462e9bdd@I-love.SAKURA.ne.jp>
In-Reply-To: <ddd2cd94-683f-462b-a475-cc04462e9bdd@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sun, 12 Oct 2025 18:02:30 +0100
X-Gm-Features: AS18NWAXMnlVYzjcH6651G1CLcNpAFUYTk5F0bL21vafeWU9e0ABz61d0SA3M2E
Message-ID: <CAK+_RLmwT5EHC6aajJxG0_ccPe7YhnWkd_wOPhhCz3mGo8Ub_g@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Oct 2025 at 08:35, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Well, I feel that we should choose "replace the 0x0000FFFF mask with
> 0x00000FFF" approach, for situation might be worse than HFS+ case.
> ...
> -       inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
> +       /*
> +        * https://martin.hinner.info/fs/bfs/bfs-structure.html explains that
> +        * BFS in SCO UnixWare environment used only lower 9 bits of di->i_mode
> +        * value. This means that, although bfs_write_inode() saves whole
> +        * inode->i_mode bits (which include S_IFMT bits and S_IS{UID,GID,VTX}
> +        * bits), middle 7 bits of di->i_mode value can be garbage when these
> +        * bits were not saved by bfs_write_inode().
> +        * Since we can't tell whether middle 7 bits are garbage, use only
> +        * lower 12 bits (i.e. tolerate S_IS{UID,GID,VTX} bits possibly being
> +        * garbage) and reconstruct S_IFMT bits for Linux environment from
> +        * di->i_vtype value.
> +        */
> +       inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
>         if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
>                 inode->i_mode |= S_IFDIR;
>                 inode->i_op = &bfs_dir_inops;
> @@ -71,6 +83,11 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
>                 inode->i_op = &bfs_file_inops;
>                 inode->i_fop = &bfs_file_operations;
>                 inode->i_mapping->a_ops = &bfs_aops;
> +       } else {
> +               brelse(bh);
> +               printf("Unknown vtype=%u %s:%08lx\n",
> +                      le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
> +               goto error;
>         }

Agreed -- given that historical BFS may leave those "middle 7 bits"
uninitialised, we shouldn't trust any S_IFMT coming off disk. Masking
to the lower 12 bits and reconstructing type from vtype is the right
thing to do.

Two optional tiny nits for readability:

  * use a symbolic mask for the 12 bits we keep:
        inode->i_mode = le32_to_cpu(di->i_mode) &
                (S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID | S_ISVTX);

  * cache the endianness conversions:
        u32 dmode = le32_to_cpu(di->i_mode);
        u32 dvtype = le32_to_cpu(di->i_vtype);
        inode->i_mode = dmode & (S_IRWXU | S_IRWXG | S_IRWXO |
                                 S_ISUID | S_ISGID | S_ISVTX);
        if (dvtype == BFS_VDIR) { ... } else if (dvtype == BFS_VREG) { ... }
        else {
                brelse(bh);
                printf("Unknown vtype=%u mode=0%07o %s:%08lx\n",
                       dvtype, dmode, inode->i_sb->s_id, ino);
                goto error;
        }

With or without those nits, your approach looks good to me.

Reviewed-by: Tigran Aivazian <aivazian.tigran@gmail.com>

