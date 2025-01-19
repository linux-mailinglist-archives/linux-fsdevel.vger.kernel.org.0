Return-Path: <linux-fsdevel+bounces-39627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F74A1631C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 18:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6329D3A61D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34341DFD9F;
	Sun, 19 Jan 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFzIQPA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D371DFD8D;
	Sun, 19 Jan 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305998; cv=none; b=GUPUd8JqpArRYUtuxBtd8srXAY10/uJQ2cHUgwY1+tICOlNbTLKXomR5VZKYAPrI8l3QUigxx+OdiQqeHuN6j78QF76vUxZyzX2j3nvXlYwti03l2FWPwzpPABKeKx96kbhWvYs5wEQaazGOoB/kfGBUJCYlntBK6cUzJXnSols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305998; c=relaxed/simple;
	bh=xSxN7ORDgJ47ETUkUaFbjfX5uYAfWwvFPw18aE+hpNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpXFbNdHEmt4o5QQzCAwd+gFoZr7jcLNY9BLAJyl2fNMRbh5MWVqFvsVZuu/7YTd4AJuiN0gDYFsohPXBZDcFWz34RjzztAryGSc4hSa/9s2c6jcvJWOeYXloipCyiS77i9DMPhu2KM6bklJZDvYkG2jHzFwLQZcKm/VskrIj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFzIQPA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D8DC4CEE0;
	Sun, 19 Jan 2025 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737305997;
	bh=xSxN7ORDgJ47ETUkUaFbjfX5uYAfWwvFPw18aE+hpNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OFzIQPA6FzL9pi4EwH/+H6OAB2njU37Tc6ALUmznZghPsoJ2c/8OQG7OsOkp3Fmyj
	 vf21Cuk6TRPQNtL4Ytvd6WeKtRLHuRredD4B8HnaxF4FmSGztnc8w2ks4//M9MOU+w
	 xRCbfL1ukE8HR5mTGNemUV0c0pmMw+YuVqRl8rB2XjhaX1UV+pxYb2/vE6L9JBnu9K
	 d7DD25TvkoMFjJrMj1efNVE7FCSIqojbb8iCxoX+keoVeZV5B0RlQKBm8/eQJYeQBz
	 KGpmzoM+aRYS2McndN+KOX1hmZU/y+lFId/zaJKIMDntWI5a/9znu4TcInRp3oG7Ru
	 8B8i85YouG+og==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-304e4562516so36771581fa.1;
        Sun, 19 Jan 2025 08:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq9RNQSeY7WsuL/QoaXvlwAtySyhffZ2EdV3CQCi60J571eVlfoCiwU/a1HfE/zJ7hpb4/rE21rKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0EMruwjoI9Fu1Iy9h/ZE+v6t+tUHJL8JJI46oFfbQyJrshzV
	pQa/kTcJGOUbVo9UJ4UuhCT13loAJxCVx9tJzY2e1TAIQywPScUd72W0IAvYwrh9MzWfABd8H+8
	wmUO4Oix4/oUeFANXLeA1pSXc7dc=
X-Google-Smtp-Source: AGHT+IEWVz68Te3YCn4yv2lQ324m1D1oemIj4cM9mFQESFw82Rl9IsB51R6quBSEbnQoIPfKBPlQ7C9AWPkLX7+5cgU=
X-Received: by 2002:a2e:a589:0:b0:302:49b6:dfaf with SMTP id
 38308e7fff4ca-3072d1a8e75mr32811901fa.20.1737305996019; Sun, 19 Jan 2025
 08:59:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 17:59:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
X-Gm-Features: AbW1kvZRY1dld9PxYYrWq1YM36Gr3m64B6fBAnZM4AxSlqSb_msOdjcwFrdaKB8
Message-ID: <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 16:12, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I've added fsdevel because I'm hopping some kind vfs person will check
> the shift from efivarfs managing its own data to its data being
> managed as part of the vfs object lifetimes.  The following paragraph
> should describe all you need to know about the unusual features of the
> filesystem.
>
> efivarfs is a filesystem projecting the current state of the UEFI
> variable store and allowing updates via write.  Because EFI variables
> contain both contents and a set of attributes, which can't be mapped
> to filesystem data, the u32 attribute is prepended to the output of
> the file and, since UEFI variables can't be empty, this makes every
> file at least 5 characters long.  EFI variables can be removed either
> by doing an unlink (easy) or by doing a conventional write update that
> reduces the content to zero size, which means any write update can
> potentially remove the file.
>
> Currently efivarfs has two bugs: it leaks memory and if a create is
> attempted that results in an error in the write, it creates a zero
> length file remnant that doesn't represent an EFI variable (i.e. the
> state reflection of the EFI variable store goes out of sync).
>
> The code uses inode->i_private to point to additionaly allocated
> information but tries to maintain a global list of the shadowed
> varibles for internal tracking.  Forgetting to kfree() entries in this
> list when they are deleted is the source of the memory leak.
>
> I've tried to make the patches as easily reviewable by non-EFI people
> as possible, so some possible cleanups (like consolidating or removing
> the efi lock handling and possibly removing the additional entry
> allocation entirely in favour of simply converting the dentry name to
> the variable name and guid) are left for later.
>
> The first patch removes some unused fields in the entry; patches 2-3
> eliminate the list search for duplication (some EFI variable stores
> have buggy iterators) and replaces it with a dcache lookup.  Patch 4
> move responsibility for freeing the entry data to
> inode_alloc/inode_free which both fixes the memory leak and also means
> we no longer need to iterate over the variable list and free its
> entries in kill_sb.  Since the variable list is now unused, patch 5
> removes it and its helper functions.
>
> Patch 6 fixes the second bug by introducing a file_operations->release
> method that checks to see if the inode size is zero when the file is
> closed and removes it if it is.  Since all files must be at least 5 in
> length we use a zero i_size as an indicator that either the variable
> was removed on write or that it wasn't correctly created in the first
> place.
>
> Patch 7 fixes the old self tests which check for zero length files
> on incorrect variable creation (these are now removed).
>
> Patch 8 adds a new set of self tests for multi threaded variable
> updates checking for the new behaviour.
>
> v2: folded in feedback from Al Viro: check errors on lookup and delete
>     zero length file on last close
>
> v3: convert to alloc/free instead of evict and use a boolean in
>     efivar_entry under the inode lock to indicate removal and add
>     additional selftests
>

Thanks James. I've queued up this version now, so we'll get some
coverage from the robots. I'll redo my own testing tomorrow, but I'll
omit these changes from my initial PR to Linus. If we're confident
that things are sound, I'll send another PR during the second half of
the merge window.

