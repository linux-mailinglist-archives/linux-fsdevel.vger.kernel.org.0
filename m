Return-Path: <linux-fsdevel+bounces-35074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE29D0E40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D278228160C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3B1974FA;
	Mon, 18 Nov 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ng/vFZMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93D194AD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924904; cv=none; b=oLwp6BMtGHURzHPdNPFw/wGDdPefeBQCsKSXUZ/tfdgK6Jszifw+J+efz069/9w7nz+Oc7cK+iGsVl+cMVaNJXjPNBkzOibxT4vMEfdsySWSGxCFMFPvIPDEbMd0AHi5Guxc7ktP1Pmsq6Ut/pYOqlJR201SU5ugSEKA11Uom6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924904; c=relaxed/simple;
	bh=VgZc9WgLY4GTSHitRZlL1UjHtqbjSNb9UuqP6p6n02M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXer1urQ2aUZVkthEaJQkgvuv6GlmSx97jLTXKsbb1xGJlIdUYwf1BX41P0EeLDWnvqyD7it0VJCd7UCaTig5jucLMtoXhS1A2x3QK0yHMnRhi/YdvrdRujqzOPu8jm9aUeT9KhvqtIB0zXic7hTHto+CB7J4UG3THrcpXFSaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ng/vFZMb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so1072553a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731924902; x=1732529702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NIDiweyvQXVWlSs4nNHBLpApFjUOt/gpJgjwpqppQ+0=;
        b=Ng/vFZMbYGpxPZ/bbLC2PvReu70X8ayp4pZFs+YpwS54XvS2iT4StEckmOPp1YUTgg
         w84StBDhro1ElsxThKOYXTagM+AZ60N3qLrj6i1fLWmlH34et7TBNVDBzS5IQX8zUYCT
         Q+ThTaBAa8dR9vjxIBPIVQMcH09t0YXgyyelqC7GoQ5E/aKkWB/xudUc4TOOWjEIgiby
         NudJfPOtztaSYDfUPjPMKa71qZEnDcm9xmuD6oof4Td0pogYbCvo7G+L50LfmaJkx3yv
         KSohDmHkd//Th08UFWmDH6SkWuke0suwtObGTX/ZmVz0psCx1I47fOwGnHHnxUZtcxUW
         12VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924902; x=1732529702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIDiweyvQXVWlSs4nNHBLpApFjUOt/gpJgjwpqppQ+0=;
        b=aTA6Rr4FoT54+OCTd33yUbNWMkkKdgrU/LPvDYLPT4V1dT4FZBTqIfDIz6e9MwK7I1
         WpOhPeoEFFV2zSoZqRFmgFnnlEfU9/rrSWhjWRmMzZTRbDxkF4VO4+7Q2A+/UYRx/PtB
         iSdfdBnofkNg2xY4pd1xX7q+EtB5qSnBQkbAm2pCXPz1SDUIt/HjVgGB1Yw0CQlxydQO
         x6yUQnHGeYlbEEAdJpYXDuytsjYrkEwQ/VZtv1wCvKLv0CKLSxGfMbz8IMPHVT4TPVur
         Eu06iX+7q6c4bVxIZ4nsdPO5sZ1yULmGK6t1zcyO0QdTGr7AZ8ufgVIDhs9pw+/Co5yj
         L+Ag==
X-Gm-Message-State: AOJu0Yw0UjJCVVgG8xpb2YZ+6S55WBhF7F8Yka/w/maFWBrINHIXBZ5e
	6BwNYqZU4Elgd29eBWG06Lg84UVutw5qtvh8CGozbqxnwzCT9sFx00t77+wemfNMqDBgHrfSFiQ
	vtz5ZL9BGgBRczpKe0oIcqmKbFXFTMKaAoTK4Rg==
X-Google-Smtp-Source: AGHT+IE03Dnz9IB1V2vd8Tz4seKW9DCt/IH1Y3NNeUkESMcxjmV3Zu6mC9baHdt6E8R0wKk0SDO4HWaQ8R8wKE+nNO4=
X-Received: by 2002:a17:90a:c10f:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2ea5deaf3cdmr5192834a91.4.1731924902534; Mon, 18 Nov 2024
 02:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com> <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com>
In-Reply-To: <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Mon, 18 Nov 2024 18:14:51 +0800
Message-ID: <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: check attributes staleness on fuse_iget()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi Miklos,

Thanks for your incremental patch, I test it and find one little problem:

> @@ -207,7 +214,8 @@ static ino_t fuse_squash_ino(u64 ino64)
>
>  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>                                    struct fuse_statx *sx,
> -                                  u64 attr_valid, u32 cache_mask)
> +                                  u64 attr_valid, u32 cache_mask,
> +                                  u64 evict_ctr)
>  {
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_inode *fi = get_fuse_inode(inode);
> @@ -216,8 +224,20 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>
>         fi->attr_version = atomic64_inc_return(&fc->attr_version);

Here we initialize fi->attr_version.

>         fi->i_time = attr_valid;
> -       /* Clear basic stats from invalid mask */
> -       set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
> +
> +       /*
> +        * Clear basic stats from invalid mask.
> +        *
> +        * Don't do this if this is coming from a fuse_iget() call and there
> +        * might have been a racing evict which would've invalidated the result
> +        * if the attr_version would've been preserved.
> +        *
> +        * !evict_ctr -> this is create
> +        * fi->attr_version != 0 -> this is not a new inode
> +        * evict_ctr == fuse_get_evict_ctr() -> no evicts while during request
> +        */
> +       if (!evict_ctr || fi->attr_version || evict_ctr == fuse_get_evict_ctr(fc))
> +               set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);

This check should be moved to before the initialization of fi->attr_version.

>
>         inode->i_ino     = fuse_squash_ino(attr->ino);
>         inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);

And I will send out the v2 patch later.

Thanks,
Tianci

