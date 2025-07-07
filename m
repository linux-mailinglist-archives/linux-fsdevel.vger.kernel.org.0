Return-Path: <linux-fsdevel+bounces-54151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3010AFB9BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E76189C1F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85C292B22;
	Mon,  7 Jul 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Id3Etn8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302C253B58
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908843; cv=none; b=Vr48ClSWX5gn0OedAt+sTTTAzgbgK1s6je3b7/KVJzc6Sx2Vb1a2jsiVuyH4iGCNSHhprHUhcv0sdhUusNJDzoKrdeKUZqZMF0lWdaYXJPOs3ylrKtvVhNxw7fXpp8HLugZIgQLa+Pd76OFzvftV//9l6/EL0zZIlcs3Kzs7kBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908843; c=relaxed/simple;
	bh=t17GgP0a5QZ5Y6YG+pWr+WFptlnM29P4uvURdZblgkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULCxd4NY3dqVHjGMvz+/O9WXgrpzXwICT7BiyErvdyYiJt5ybo8P0EZc4gTZFLEeguAaMtquxyKQ+LzuK3gA01MKcNK+kVbR/75K48EqMp4dv0mdrcqRZEjW5PCIkWT8pOx5runzzhCAykCTVBVftY5n4Fc3siRk5XV6RnM+oU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Id3Etn8r; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso6126590a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751908840; x=1752513640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZeDTqgIGWpnZjCb/89i1/Hn9tds2HMONcUE/1gGz1U=;
        b=Id3Etn8rgfbBENPBT3e0Bil8edS02JCyKuFSmvR/Fa3klMk7M+I4oXJzaXMsxyk2Qf
         vGoKJhqseLebdgkyCwu08wK4texC771pOcbn9ruq2288hPoE5v9nRDQ2kKq+YTVGSQOq
         DrAIABa32uy7/yLUBgjgiyHoPC+4HZoSDN9DEqr2hY6H5fEawdHgzaka6r6zejEcCRP9
         tW00xi4cHIo81s/2cpYzgcxMcJDiYPQCoSaTZEViDjTPUTQXmAet+Q7UvdsBB6CP3QMI
         WfkKg7dk9M04TMqjTYpScUPbLw5TAGWmsdDgXc7uhziODN2XEK+L1CQCUByiABQWIzAu
         lzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908840; x=1752513640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZeDTqgIGWpnZjCb/89i1/Hn9tds2HMONcUE/1gGz1U=;
        b=i3J1NosegZi4DFIonfHUhAuVeJxn0jlZJ4OGzjhfnqvvArh/AXJUzKZpXEEHDfphCH
         KZ8L1Tj7KRa+1QIJXzHWeXYQDwWXBWAJrZ1G0j6NHJCSIe+sIx9W5ohMSZiiDrdoVbhK
         2/E6t+ILySfk2TLOJMcLitZ1XwIxL+GtTgjCPaMLSKCiZYVWcLZBVSg1laF/sEcKQOAL
         VBq2849umAYQ55Nvhk6q77ifjEyfvZ55PuLZT8IMvP1SWR/g2MTjUZ/j/m5/iiPlM1sg
         T26z6mY8nKHVntB3CKfQkd87a0KVHCsCTrGljL5hcHbPNj+01Z2t3CJtEOh2WCxLnBlD
         8xqQ==
X-Gm-Message-State: AOJu0YwkKYDNra8wLaNCxMaTk59CrfYtMXCQy/2OfUB6WqXb6ThGgiU/
	lbks2XVieAD5pRYhYuBfD1KSGCfMeecuVWRF6+qM+A99G1iylE1s8y20K5t0XFF5iPT4CjFCuFs
	k+BOfe3FvBEVZeJQMiS1lUDXYZvxZtFsoaJJZ8cnY5Q==
X-Gm-Gg: ASbGnctSf2X9xeJp0fov5CjOo3Vmh7JU7K66BFjSKwvwdG/xXqrw9Cc3aAzD3zDjBPR
	SVGnzPC2DNyxU+cqt5Bp/SOgB4sCTVnQGKGO9+yZ19KvZKcav5eVuXRJ7+GmHtoyl5ExRfoPsE5
	6ALN2Eff0nWE/Z7YYG4KtaF9oMxi/qyum4QnZGX9PBWc6SmnOHjFoiK2dL9rum1uCTJ7utQ7Y=
X-Google-Smtp-Source: AGHT+IE7sgJMD6GBK/UnuH5TxA4s0337Q+7JLz5zU3aez4fLQvXP//BGTFzZ9iEgzJ38nHcds+i3r0pxW6p+qpWl214=
X-Received: by 2002:a17:907:969f:b0:ae0:d97d:7fa0 with SMTP id
 a640c23a62f3a-ae3fe6ff5f6mr1368890666b.38.1751908839758; Mon, 07 Jul 2025
 10:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060422.576198-20-viro@zeniv.linux.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 19:20:28 +0200
X-Gm-Features: Ac12FXxlaES8aAdQ9DJtqsVKAgsYs9Moj4Gd3KYDqdYvXJLYHc0irmCI1oLaVcY
Message-ID: <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Mon, Jul 7, 2025 at 7:04=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> @@ -1478,6 +1444,8 @@ static enum d_walk_ret select_collect(void *_data, =
struct dentry *dentry)
>         } else if (!dentry->d_lockref.count) {
>                 to_shrink_list(dentry, &data->dispose);
>                 data->found++;
> +       } else if (dentry->d_lockref.count < 0) {
> +               data->found++;
>         }
>         /*
>          * We can return to the caller if we have found some (this

I have doubts about this part of your patch. (Warning: I don't really
know what your patch is about.)

Why does this new check exist?
(It checks for "dead" or "killed" entries, but why aren't you using
__lockref_is_dead() here?)

Actual problem why I found this: while debugging (yet another) Ceph
bug, I found that a kworker is busy-looping inside
shrink_dcache_parent(). Each iteration finds a dead/killed dentry,
thus "found=3Dtrue" and the loop keeps on looping forever, yet nothing
ever gets done.
It does this because a userspace process is trying to write to Ceph
file, that write() system call invokes the shrinker (via
filmap_add_folio() / memcg). The shrinker calls shrink_dentry_list(),
__dentry_kill() - now that dentry is dead/killed, but it remains
listed in the parent because the thread is stuck in ceph_evict_inode()
/ netfs_wait_for_outstanding_io().

I am seeing this because Ceph doesn't finish I/O on the inode, which
causes the kworker to busy-loop forever without making any progress.
But even if Ceph weren't as buggy as it is, there may still be some
time waiting for the Ceph server, and that will always cause brief
periods of busy-looping in the kworker, won't it?

I don't know how to solve this (I have no idea about the dcache,
having opened its source for the first time today), but I wonder why
select_collect() ever cares about dead/killed dentries. Removing that
check seems like the obvious solution, but there must be a reason why
you added it.

Max

