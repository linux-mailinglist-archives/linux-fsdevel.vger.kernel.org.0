Return-Path: <linux-fsdevel+bounces-39264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E60A11E9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D201636E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE1E1EEA4C;
	Wed, 15 Jan 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGmAhkHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BA248177
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934759; cv=none; b=hXJuKBUhATKxOBolFF4GkQ8q3Z3OqRJxMd4Ha+jsejUWK4qquQ0aLhPMn+QDBkL2C5ufAVgpQfaO8E0FXiSoXHVA7+FtdpdjxU5EFp4Qq1m8ZKbckMRMF51Sovru4HAGVFk/hFbl0h8u5zHMQlnaswqI4hvR8NEMYFGC1QhxDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934759; c=relaxed/simple;
	bh=6Mp1L39au5+q4abXAZi8afq/lfXzkfd5uAJuwFDMwWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PksKO7/C7uT5xVId2/385ScK01VsUAjFzpfGPKiKvtH2NlS90fcJuDaPxIhBbK1lWKIvUzDCC5p7Y4ft3KCgfyyPEiVkfTPmxITjkKJBH+48tQWGb202jp61KKaQmX+XXHlgcYPzD3L+XUOU3/RbTvfB3N6jjcQ5rdlowltJxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGmAhkHa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa689a37dd4so1236147366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736934756; x=1737539556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trbeBr6R3RgZyqFN+J7kI/G9tr61k9osn0PDuq9VKHY=;
        b=CGmAhkHaN8ZJjGQyuxgw0eDTVI0GuyZV+dphDc11fVoaCJHdpSPTevjX6ZWcstiWqt
         sLb7zSHO1ZlbXgBq99pkTbPTOPze9vMg7QWtF8+Y3L2+8D9mlLdRI7gqRW7XSsxf/44S
         KCHat4Ot16UcgTknD7C+Wi1H5aEr2BzI9FFhEUUwVlZdi6VRbrDsbd/n+0W5xQo4ol6+
         yld19cj9ysSZFVklzzM2nfZc8AozNS9bIu0U36iPmfgwW5IYdiXcAo5Idk/DW3hhDABd
         C/9xrIihVGaA5iVjmmOQWZpFFP/Qtv+8VSrtov0Vi9RBkBZt2RPP2IMm58KTlvXPEH8u
         /yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934756; x=1737539556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trbeBr6R3RgZyqFN+J7kI/G9tr61k9osn0PDuq9VKHY=;
        b=Tg35D98xFwcyTp7wBOLi7BWu9hjde9GH/0CcbO5EgOE2rS6WkR9hrUdE+B93l07sTA
         4/uJxnLypdhGy9MCfOd4np3XwFb4kqDLOJlB9inP0xNuk+J3Umljoel4KwhEaWhWeYR1
         N9Sw06d6w7KEaxdZL66/G5DEwGvfaqLSvbgSLuWXypqDlalcz+wXRjkbf0+WEwB0JYRa
         3Z4IWUECrS2GHJkjqyTWK8iVDxtVZaPVO/t9VF1nTr9O1zqeZ9cMbVIcU81AVb31fAA7
         kQmNGIQTj3QzW1QdPDWH0Fts4zuRYR7P80vAzy7TVEKRNyJKVp8+m5UDQrfFT93wT1Pw
         +Seg==
X-Forwarded-Encrypted: i=1; AJvYcCUsmHkgnHI0buxMKqqoCQruIj0gb+v3xhjPmcZ9pP5PgiUyzkjKPWAvfjLTitSMS59ZW3UrfM0xLFli44Oh@vger.kernel.org
X-Gm-Message-State: AOJu0YykUtLKawwE3lLCP4x7fdYoCcUxvFHHVvaZ+xz6kjohyOleThd1
	PLdVkh0jy3gQtq6FGRsx2imoAbveF1mWNhIkRTrGgf6KnDGkUjyLJm3uP5My6+fo6c/zftLWJu3
	2RW1ZPfD8k3966Md25VyjmtoY5nQbiQb0
X-Gm-Gg: ASbGncsjmJlEVMBo4rP8eHGRqdRCWYiSqbXc5vfiUwYVpahgxii+i+2qpiD6D4xoAkt
	N/RaTcStU+o3zE1s2Hwz6VsDTHvtCfQiFALYGP+ECpi3nifLGG42xPDJZOjqyrWd+kcXp
X-Google-Smtp-Source: AGHT+IEDLcvardndVaj+GYPVD8O1WYeNUBhWrvT5ipyuJCaeaaHTbp3MPFk0W5eABx7T1tZjg2WfunVpOQgZrRKp680=
X-Received: by 2002:a17:906:f585:b0:aa6:7933:8b26 with SMTP id
 a640c23a62f3a-ab2ab6a8deamr2407874766b.9.1736934755415; Wed, 15 Jan 2025
 01:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <6wcmvyeuelngltuiohumo6pffwptgbgofqba453pdi45ahydkn@ern4qy4i2zoa>
In-Reply-To: <6wcmvyeuelngltuiohumo6pffwptgbgofqba453pdi45ahydkn@ern4qy4i2zoa>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 15 Jan 2025 15:22:23 +0530
X-Gm-Features: AbW1kvaPcnzVgLUg0meHPlfSZf0qt6H9NxvZB7k6fIo5mBN8fM0UifCtUtz7kUA
Message-ID: <CANT5p=rOJLL+=T1q0+7ZEZ4iNUcoMbg-NP5D4zF4KdR3YjF1oQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,
Thanks for the review.

On Tue, Jan 14, 2025 at 6:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 14-01-25 09:08:38, Shyam Prasad N wrote:
> > The Linux kernel does buffered reads and writes using the page cache
> > layer, where the filesystem reads and writes are offloaded to the
> > VM/MM layer. The VM layer does a predictive readahead of data by
> > optionally asking the filesystem to read more data asynchronously than
> > what was requested.
> >
> > The VFS layer maintains a dentry cache which gets populated during
> > access of dentries (either during readdir/getdents or during lookup).
> > This dentries within a directory actually forms the address space for
> > the directory, which is read sequentially during getdents. For network
> > filesystems, the dentries are also looked up during revalidate.
> >
> > During sequential getdents, it makes sense to perform a readahead
> > similar to file reads. Even for revalidations and dentry lookups,
> > there can be some heuristics that can be maintained to know if the
> > lookups within the directory are sequential in nature. With this, the
> > dentry cache can be pre-populated for a directory, even before the
> > dentries are accessed, thereby boosting the performance. This could
> > give even more benefits for network filesystems by avoiding costly
> > round trips to the server.
> >
> > NFS client already does a simplistic form of this readahead by
> > maintaining an address space for the directory inode and storing the
> > dentry records returned by the server in this space. However, this
> > dentry access mechanism is so generic that I feel that this can be a
> > part of the VFS/VM layer, similar to buffered reads of a file. Also,
> > VFS layer is better equipped to store heuristics about dentry access
> > patterns.
>
> Interesting idea. Note that individual filesystems actually do directory
> readahead on their own. They just don't readahead 'struct dentry' but
> rather issue readahead for metadata blocks to get into cache which is wha=
t
> takes most time. Readahead makes the most sense for readdir() (or
> getdents() as you call it) calls where the filesystem driver has all the
> information it needs (unlike VFS) for performing efficient readahead. So
> here I'm not sure there's much need for a change.

I agree that the filesystem driver can do this.
But the logic for "advising" how many dentries to readahead may be
something that depends on the workload rather than the filesystem
itself.
Most of the practical use cases would readdir the entire directory.
But there could be use cases where a partial directory could be read
too.

>
> I'm not against some form of readahead for ->lookup calls but we'd have t=
o
> very carefully design the heuristics for detecting some kind of pattern o=
f
> ->lookup calls so that we know which entry is going to be the next one
> looked up and evaluate whether it is actually an overall win or not. So
> for this the discussion would need a more concrete proposal to be useful =
I
> think.

Acked.
Simplistically, the whole directory could be read when the number of
dentry revalidations or lookups that missed the cache, but was
successfully loaded from the backend exceeds a certain number (I can
see how this number could be filesystem specific). There could be
other more sophisticated implementations.

Let me think through this further (and read the other comments) and
see if I can refine this further.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--=20
Regards,
Shyam

