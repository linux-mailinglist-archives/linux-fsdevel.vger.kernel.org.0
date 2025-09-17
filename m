Return-Path: <linux-fsdevel+bounces-61956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B3B80B78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6439A167108
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02948321267;
	Wed, 17 Sep 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T7Ef5E9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AA2D3756
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123756; cv=none; b=kiax7EplLzyEPDyTf75bPPAZ7m5X/sNQBlJ9KcYd+bTGu0mkhrle3b79rhfeWzDphr5bYoRU8wnTTIJaqaARyPq0q0o6iZAHosVgckJXoEPfgxqXhNL6Fb+N+g4yrwv4uevYD2MrxpXWYv8WnXBj2rp1/tzz5+6mIk0dIcbH620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123756; c=relaxed/simple;
	bh=FRJ2cFVLo9OzvbiA8cpNRwK/IOHwNXJdHHSj1E5ekMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDxBwGJp23iwl5XseWB5PBfUO9E4Z/884WSZatDsJc2fEh2h6Cc8is9ignTDM/6+tWedA7U15VG3eP18/EkYsMBxAEYlWRCaHxIFpCsoJi+VZ02uWxXsZKWhIKNtR8BmxwD2LhYd7nzZcVph111hDpgYnPejbTk1JL5ig85nfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T7Ef5E9C; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b38d4de6d9so38372691cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758123752; x=1758728552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxOThsfUexi/WOpBwEOhJOFBjsFF1HZVVx2QVUQWzZs=;
        b=T7Ef5E9CO1vABL3Bc372hTpnctCOEfPfRXN+aeDjAqVe+o2G9RfNd5+8/7bLcsd7mQ
         Rin/ZSr3wG+srQc2bpkxfO95P14rNnUKzhvqqreFZ+x+m/cDQn325gw+H1spBwWvzrzh
         HCICBfgthCkS/SvMp1a/+3nxlxzXZPNQ3zt3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123752; x=1758728552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxOThsfUexi/WOpBwEOhJOFBjsFF1HZVVx2QVUQWzZs=;
        b=G4Dcn/WZTcEQbxqfols/8v9dCh5nlUC2LxMXpsDWuUcL1YgjmuG5qFhYPnAyxQ24ZI
         YWtQGbP6IGfimQ1GiJZx5eu+5CQCtMqF4GtS7A+XGSANvH4VZu87EkWZrG8mF7UCQogv
         eToWGYWOo5ERqkafohDvA1YBc6OKVnJ7IlYS0jgNkOw4xPX/+lMwW2SxY00iC+oZ4LF1
         PuuHcqUlrZwRFy1N9cQVXBwy7tu1SP/R6657KNgQ1ChkwREVTTK79Smv+5DMuhhnD2w2
         VEvEETDMJWBBud7M89j8sgL/F+XZtEX4BdUsxP6+dJCGW46YDmUvi58FXfLXnA05H4vo
         yf0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVOd2mKWRvo9qn0vY6dP2wGrLymZqkP9TbQ8RGPkcmN0GQgYGswvap//PTM+55NsPa4w8xoPj+8i/sCZpY@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMq97tmMFs1pNDsIE2SMiJSLB2Jn0U6uNndtdkJSy7ssspOzl
	ChQPvWEoW2fbjo9euvyr27Rnf+SFmf7UMtQ7fV58TsiAlRJ/BVkLvDYaFFgo+WhoJEBvZS2F96W
	wqoupSXKnxg8ayIwjR0R3KPsPx0A05CQr+bMI72sF6Q==
X-Gm-Gg: ASbGnctVHnJaOAk8Cvkq1RGAeiUpqu+x5/LBIMhjQ/VzkxWIX2O1eamgQMNzXYS+EbC
	RSLDt+h9Lr00nlHLVCAwfwbtcwSr0y1WesILpsLm9bSzDmISyj0pWBDitjfErPjY0eJf01jirQ8
	4yUKlzikec56ng4fYjj/mxqZ6pYPDgGfVexikCOHL/Q60dT6PLVq7rO6Pyi/OC0ac7qtPF6tghs
	rZO7FHxum/SGbqO5BKI+AdCNXQNY0WETpJVYTpN
X-Google-Smtp-Source: AGHT+IE5T+g8K4CM7DpWA00rNY/qmgz5QHqTA1z6pfAaXK68bgE4m57xgh7/egDEmEb1cVVdlaEONZNPa1gnmEmCnGI=
X-Received: by 2002:a05:622a:18a9:b0:4b7:9c98:aed6 with SMTP id
 d75a77b69052e-4ba69d348abmr30721941cf.41.1758123751710; Wed, 17 Sep 2025
 08:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153031.371581-1-mszeredi@redhat.com> <20250917153655.GU39973@ZenIV>
In-Reply-To: <20250917153655.GU39973@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Sep 2025 17:42:18 +0200
X-Gm-Features: AS18NWCZDiXToVmUmgeIzykzUht2HpVeLHCTVEbx-9_JwpiTiDy49yCUPdj4H5g
Message-ID: <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 17:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 17, 2025 at 05:30:24PM +0200, Miklos Szeredi wrote:
> > If a path component is revalidated while taking part in a
> > rename(RENAME_EXCHANGE) request, userspace might find the already exchanged
> > files, while the kernel still has the old ones in dcache.  This mismatch
> > will cause the dentry to be invalidated (unhashed), resulting in
> > "(deleted)" being appended to proc paths.
> >
> > Prevent this by taking the inode lock shared for the dentry being
> > revalidated.
> >
> > Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
> > inode and expected name to ->d_revalidate()") is that the name passed to
> > revalidate can be stale (rename succeeded after the dentry was looked up in
> > the dcache).
> >
> > By checking the name and the parent while the inode is locked, this issue
> > can also be solved.
> >
> > This doesn't deal with revalidate/d_splice_alias() races, which happens if
> > a directory (which is cached) is moved on the server and the new location
> > discovered by a lookup.  In this case the inode is not locked during the
> > new lookup.
>
> > +             inode_lock_shared(inode);
> > +             if (entry->d_parent->d_inode != dir ||
> > +                 !d_same_name(entry, entry, name)) {
> > +                     /* raced with rename, assume revalidated */
>
> ... and if the call of ->d_revalidate() had been with parent locked, you've
> just got a deadlock in that case.

Why?

Thanks,
Miklos

