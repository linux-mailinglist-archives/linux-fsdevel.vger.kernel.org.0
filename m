Return-Path: <linux-fsdevel+bounces-74570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC0D3BE65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232904EB49B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102334886F;
	Tue, 20 Jan 2026 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDMTSO+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EF348465
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883317; cv=none; b=X5W9IQs5WZ1iWYNMpwjH6RH1k1FXWMZnVKRT07EUzC2InUUy/4hFPvIKpVXuYhPrvtsSVe9s2Ko8FG+8svcjGxbb4GaDf76A2HOitNAqAZxQafcucUOQil3CD1cXs2bbKqLCXcq2zxJUivFJaXrCawAdJsYFV3NMNDmNw/Cc5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883317; c=relaxed/simple;
	bh=bUsSc7sNiJhJxOcCJS6DImmgfZ2Qvmff4DHBmFghLL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkLZq5CzvtP0gTBiS2Acpx8YhvuI13fs4T0ct0c+8Ktm9Ik9jBlD+HgQYoJrA/6mfFRic0Q5ARN7QesiIiLkyQdcO1GG5/1Midy3aRrtCjaGGweM9tDQ9WjBcg1K4+cUQ5hks+EK4lhSlC9mAlexOv2jTU50JvhNzQDdfwlt/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDMTSO+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4070FC2BC87
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883317;
	bh=bUsSc7sNiJhJxOcCJS6DImmgfZ2Qvmff4DHBmFghLL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lDMTSO+vilrQjxqCTSetml7M3In9YeOdVxWzmRS+lfNcTdet48go79XAwCcLFNZcb
	 sYxV0b4pbodt8TjaHn6Mr2bPi+FnoGmO0iuxegSzK+AhBmVbvPdrHTOjVHGhuY0Tq6
	 XxQts7ulDyDBmjhJziw9BFLBSbu+1gb12RMfrvpUXDQY5n+M7WHpa//gcv9kSUJFhK
	 ZqgVq1jso45dhmWWLX+PC7Dy7+ifZ3RJYG8a9U2u2HVxIgtyVWvrDnH4vz7M01oBvi
	 8pum9V1tnS7hFJwpD/sK9+i2tUKtL0tUGEiFt0ZMpUYfcKub7mpFQajMdXeamit7So
	 jCLmqWCmcfTXA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so7530143a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:28:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUye8c114OUGsKCDCiomGie8NsS61A08w69Sjbo5JZLzgB+TpIKJWPKwNmXzTDv7rtbadFJXXTZFVA/LJVm@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmM3NXhM3p0fwuqGETKbQa+ahXt3o6tOZgjc8mhT2a8kWbbvJ
	iMBIkTIP7J76la6rR6W08drMy1K8KdFgsKXD5FhMfPIavA+q5vLwnM1tc4ZsTOMvNK1wPVbknjP
	skVSSkj0lEOYT1Lifbf+s4jGRVs0hn3o=
X-Received: by 2002:a05:6402:2342:b0:64b:8e3a:603e with SMTP id
 4fb4d7f45d1cf-654b9364192mr9322530a12.4.1768883315798; Mon, 19 Jan 2026
 20:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-8-linkinjeon@kernel.org>
 <20260116091451.GA20873@lst.de> <CAKYAXd9+P6ekYnbXuoG95Nt5-H6bie6cSm4N-9RFDN3E+smJ+g@mail.gmail.com>
 <20260119071719.GD1480@lst.de>
In-Reply-To: <20260119071719.GD1480@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 13:28:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9pYVu7cCLrJ_KWNs2ysJOx75tq5wJTZpDBdr-dvcvazw@mail.gmail.com>
X-Gm-Features: AZwV_Qi-0NLyxE64GyKZPMnLmH9ojeQMEeXlOsA8b_IbWPeVuEOkQfcOAF2VgCM
Message-ID: <CAKYAXd9pYVu7cCLrJ_KWNs2ysJOx75tq5wJTZpDBdr-dvcvazw@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] ntfs: update iomap and address space operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 18, 2026 at 02:00:09PM +0900, Namjae Jeon wrote:
> > > This function confuses me.  In general end_io handlers should not
> > > need to drop a folio reference.  For the normal buffered I/O path,
> > > the folio is locked for reads, and has the writeback bit set for
> > > writes, so this is no needed.  When doing I/O in a private folio,
> > > the caller usually has a reference as it needs to do something with
> > > it.  What is the reason for the special pattern here? A somewhat
> > > more descriptive name and a comment would help to describe why
> > > it's done this way.
> > The reason for this pattern is to prevent a race condition between
> > metadata I/O and inode eviction (e.g., during umount). ni->folio holds
> > mft record blocks (e.g., one 4KB folio containing four 1KB mft
> > records). When an MFT record is written to disk via submit_bio(), if a
> > concurrent umount occurs, the inode could be evicted, and
> > ntfs_evict_big_inode() would call folio_put(ni->folio). If this
> > happens before the I/O completes, the folio could be released
> > prematurely, potentially leading to data corruption or use-after-free.
> > To prevent this, I increment the folio reference count with
> > folio_get() before submit_bio() and decrement it in ntfs_bio_end_io().
> > I will add the comment for this.
>
> Thanks!
>
> Something else I just noticed:  I think the implementation of the wait
> flag in ntfs_dev_write is wrong.  folio_wait_stable only waits for the
> writeback bit to be cleared when mapping_stable_writes is set, but even
> without that I don't think you can even rely on the writeback bit to be
> set at this point.  If the data needs to be on-disk when this function
> returns, I'd call filemap_write_and_wait_range for the entire range
> after the folio write loop instead.  Or maybe even in the caller
> that wants it?
Right. I will call filemap_write_and_wait_range() instead of
folio_wait_stable().
Thanks for your review!

