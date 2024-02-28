Return-Path: <linux-fsdevel+bounces-13073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64886ADE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08431C21320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E389145FF9;
	Wed, 28 Feb 2024 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOXPevuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78227145B2C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120338; cv=none; b=efpWt12nksoel6KMgPi3KNgL1SAMYoFpuKXTC6RaOsFvSJZiSZWEfzG0WBKcMeKhL42zy5fW3/j8mY5LSO/56W8Ouxu8vT4iJfFTAfPBdpULz7c7cwO7smJ27FLl8dOC+4Qr3CiVS8fcy8GwcXiGBwIw+1X9Yj45XU7BboO29Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120338; c=relaxed/simple;
	bh=hjtQESQxE6xGy5oUhCMEFsopxmFAGFC649c68eiRlQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvvbD0PXDK/Rs1CCNBgPfLOsz2KbikmVB5kIZpMtxVaKFd4tIoCbTJmxPAOKqpDu89nCWVIn8g8Yp4wWy2qQD3mXBvUmAIbYKnT9/Lmg6sznxMPKChAdbdVJttJBI/m/29puE0hlyL522Tm+gYsJeEq7zWnH4xSAQkXIGHoiTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOXPevuP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso5410459276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 03:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709120335; x=1709725135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cVHkaT8lHsHCD4Yo8gLGFh4Q3p0H7qbn5bB00yB0OU=;
        b=UOXPevuPQkwGpLiDb+yTNlMhtS1iURw3/B8tZ5vELVAYgdCEP+kPHRrKZa4U1W22y1
         psQOx/vXEv8ICejQMap8DbR9Sw7VmAWhtP3//V8DFnxWtjYg0wOYo8AAmI8kXbCIi6gk
         TT1iLY5JdqPFL5AfjJvGnfbFlpZdjMbVlKgso6oGh7i9vQM763C3j4InwMK2Pe/qNxCt
         dnuOaMXFNv5lJ19Ey6uOqpbkI5O1qJu4Bwcx0IDSk0ZPba2w98pnxoU8MTmf4mPhGAAc
         9BTwG2nEyFrZgUqhFE4eIokiyLG5bfy6shdcxOrPT/d0Ns3RY7FMxvmzmG6TingAq7k3
         zyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120335; x=1709725135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cVHkaT8lHsHCD4Yo8gLGFh4Q3p0H7qbn5bB00yB0OU=;
        b=UL8j1YuYSu23brsrMcla9VLfBE2opXmv5dajxky3/yIbqfQ/XfnCZTbWRvoWGUfnXK
         iAkJFiXhx1scfVWwcBEYgKEB/pvhZ/3YZ1mCJiW2XkRlTxl0D4p+u6v+Mg7N3l7l5ye2
         HV/OTymCTtc8Ym+rsQd9Dd/KZ08VpJDMGoRv0sQhMsdWjKE2ihv8K/zNs/oeEU0/2/s6
         8+1nKDBwOy0Y8D/cBbdn3BObDO/Thy4QKdI+zCbtaF2DQ28ru3ixeqhURq1Ton0/cH5G
         KsvGXk6ubi1bJLWrHXvyC3Ec+VZak+WNJEOWMHQRDSjogoRnzMh1C7+Q4z8dGYD3XeS0
         j7ug==
X-Forwarded-Encrypted: i=1; AJvYcCX8/QNIN+wEq7Qoyp1eRGDi2caWHIVT2tAx3KBkzLkmtYWeBicqHCtf6HOcjqzKGMkCBgiWuhD0J3CuINkv+GoFLAG9SPYe1XFNOl2KKg==
X-Gm-Message-State: AOJu0YypfhX7UF2d/bZkd0C/a1Y4zGRRSpaI9Gcy/QeyPdv+rL+IbhgM
	miBJn2lH9A6XDZrT0/6AZrstxLd7FrtMswA8W6JkvmDYlXv8He/Udtt2ciBruv69cxDf90TDilw
	qFztmrMXTySe4hZYcXQQZB9lyKEE=
X-Google-Smtp-Source: AGHT+IHY0wrUSlOw9WyRdPBNGyDCMr47R2OPgqsNZgMSxECHTeFCqFgwVKMDSze3nopO0Zj5d+T7xSEwl6jXiMijfes=
X-Received: by 2002:a25:8685:0:b0:dcc:44d7:5c7f with SMTP id
 z5-20020a258685000000b00dcc44d75c7fmr2082491ybk.62.1709120335333; Wed, 28 Feb
 2024 03:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228061257.GA106651@mit.edu>
In-Reply-To: <20240228061257.GA106651@mit.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 13:38:44 +0200
Message-ID: <CAOQ4uxhZ5KOTdi01C87wYwvB_K=HDYdLy7LHzXnC-C3U_OFEnQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] untorn buffered writes
To: "Theodore Ts'o" <tytso@mit.edu>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:13=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> Last year, I talked about an interest to provide database such as
> MySQL with the ability to issue writes that would not be torn as they
> write 16k database pages[1].
>
> [1] https://lwn.net/Articles/932900/
>
> There is a patch set being worked on by John Garry which provides
> stronger guarantees than what is actually required for this use case,
> called "atomic writes".  The proposed interface for this facility
> involves passing a new flag to pwritev2(2), RWF_ATOMIC, which requests
> that the specific write be written to the storage device in an
> all-or-nothing fashion, and if it can not be guaranteed, that the
> write should fail.  In this interface, if the userspace sends an 128k
> write with the RWF_ATOMIC flag, if the storage device will support
> that an all-or-nothing write with the given size and alignment the
> kernel will guarantee that it will be sent as a single 128k request
> --- although from the database perspective, if it is using 16k
> database pages, it only needs to guarantee that if the write is torn,
> it only happen on a 16k boundary.  That is, if the write is split into
> 32k and 96k request, that would be totally fine as far as the database
> is concerned --- and so the RWF_ATOMIC interface is a stronger
> guarantee than what might be needed.
>
> So far, the "atomic write" patchset has only focused on Direct I/O,
> where this stronger guarantee is mostly harmless, even if it is
> unneeded for the original motivating use case.  Which might be OK,
> since perhaps there might be other future use cases where they might
> want some 32k writes to be "atomic", while other 128k writes might
> want to be "atomic" (that is to say, persisted with all-or-nothing
> semantics), and the proposed RWF_ATOMIC interface might permit that
> --- even though no one can seem top come up with a credible use case
> that would require this.
>
>
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag.   In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess.
>
> Another interface that one be much simpler to implement for buffered
> writes would be one the untorn write granularity is set on a per-file
> descriptor basis, using fcntl(2).  We validate whether the untorn
> write granularity is one that can be supported when fcntl(2) is
> called, and we also store in the inode the largest untorn write
> granularity that has been requested by a file descriptor for that
> inode.  (When the last file descriptor opened for writing has been
> closed, the largest untorn write granularity for that inode can be set
> back down to zero.)
>
> The write(2) system call will check whether the size and alignment of
> the write are valid given the requested untorn write granularity.  And
> in the writeback path, the writeback will detect if there are
> contiguous (aligned) dirty pages, and make sure they are sent to the
> storage device in multiples of the largest requested untorn write
> granularity.  This provides only the guarantees required by databases,
> and obviates the need to track which pages were dirtied by an
> RWF_ATOMIC flag, and the size of the RWF_ATOMIC write.
>
> I'd like to discuss at LSF/MM what the best interface would be for
> buffered, untorn writes (I am deliberately avoiding the use of the
> word "atomic" since that presumes stronger guarantees than what we
> need, and because it has led to confusion in previous discussions),
> and what might be needed to support it.
>


Seems a duplicate of this topic proposed by Luis?

https://lore.kernel.org/linux-fsdevel/ZdfDxN26VOFaT_Tv@bombadil.infradead.o=
rg/

Maybe you guys want to co-lead this session?

Thanks,
Amir.

