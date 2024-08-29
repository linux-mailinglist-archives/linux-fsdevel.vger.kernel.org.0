Return-Path: <linux-fsdevel+bounces-27749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5396385B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 04:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77FE28160B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BED44C77;
	Thu, 29 Aug 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNk856kS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB317547;
	Thu, 29 Aug 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899679; cv=none; b=pnL5uFModQRhC2wenvCJ4aEHFiOis32CNfWnksgjAXTG9UAAV6Be+VklzdLlISjkAtP0p8JsSir0RJ6WyLY9So0/ThaytBsfZF+Kuzq4EymuxLlZAuKkoCP397mM6jxZ6lYEVD3uHcYPlDJqb0Kw2fCaC8JEf0QKAe2vhJ8j+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899679; c=relaxed/simple;
	bh=yZBj6yB+vdP8EWPB8Ad9fGdRR9EORM7UbpU9Y+Lq7WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acGFilNVWQ0uWQ11M9jEl13zbPzu5bd/Glm3GU+TuM+OlkE6ged7HljzojZZV4dfqpSnpaLson/P6dKjm+WQO9bQCx54+lf10tmAiV7oOqJ+UAiQFllDB3bXwMfyugBDQGsQksFHQW1XFuLBqSwj777mp0DiW9tlCexrmLaYjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNk856kS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533488ffaf7so195667e87.0;
        Wed, 28 Aug 2024 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724899676; x=1725504476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=RNk856kSNr0UJNH8EuG4F17C99rG2v2JlTzf+KYLBBIn+UBwjQgo6gkqUgy/dSQMGb
         qcCD+wRNwUzYbYgONf5aFvvbOAU2gPfWOi5VnVgEcZrzVmtqkvKLF6WmZ8z978CyNEVW
         vE0ldU8FCz8ncYSM7WCWwFhU+ma6G5+O/GGiIK4FSzVSlz9pGNY7TgCxOnFgQfOe4kQ1
         aZyQbdims+DyKgWwyr5qFIA6cQFI/58VCo3mAjkGyVIyKM4XXhj3tHYgUwTvIDdGURrg
         mcaDIZvl2KNE9RJ+29nLr4jYdTAfMsoIIY+F5QT81BsTsEdyBADbPphlVsoGvEc0s/2k
         QKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899676; x=1725504476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=liUM0NmQ9+yCZtLxuxiz7zab7LfqhopEgXmb3DLhuJcjWL1s1s4G40WytKQDrA9QwT
         z+xb8+mMvNcJmXzNK7DAldFk01TxKfb5JTM9qPilo8lO6xtkmwz91cJdHTqkmFJ2Xu0b
         iKN3Wka+/OIxAfPZheexzwrniWpDX2wxnY6N0SahhotiwNbYkBRTL4dGk3BY8uz4B1A3
         5qFlbCyGqqm2CoFcRYwmVEGVFGqfxKUtvl5MbOPbBrIQLPjpnhBgXoaY+PSr2UvlWpwf
         u0SCfdRaxTWpb88hHOE36dpB/Ig3eDuu0rqTcrR8dpibO3Nri/e/B1raSzXnEEbYWbvA
         4Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPIHQdIaHoWNuuq0EPaOwcp/KvXGqoiEoTnY3LD+K/lwpK8ueUQUPd9/ZYiOLwQOIxIHWBdcBkPDW1@vger.kernel.org, AJvYcCUsjjNhO1w/RUHToWno4H3m3l+X2iQsEk4fFjn7w66mSHB9aa++HI+A29r80XjqXu+Ik9hN4juBVOsHUA==@vger.kernel.org, AJvYcCUwP9xfvVf37ySrVxxX2HOSAUPoR7tyvMc9/nkacWLmwKumekrJIM0jSeTjd7TaRkdHz/kvox0F5LOdPMLZ@vger.kernel.org, AJvYcCX1flbjSSdym0P3Fzj4O3hFVIUBh6qyTe/ABm3JAM+JO08lzkGEs0oEAoTtm455dZFmAlNS6QVwC3aB@vger.kernel.org, AJvYcCXswY0/Vi9Jbh9uPAjdJmoXENs/wZY59iYOFWF41xYuwfVVKOgtlbBZCczsXYw/N7mL+JL7Gs7h5EpfLbDEbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGW0k00L+Rdj1xUhPnKmGVG3OeZk2VaXhAGDSeRHMkRSIDeuvu
	AP/SWG6gir1wXUKcwMmsyQaHHhLlfIdy0vtWguwFWFUJ1sTV3MoUyAatB3vh3ylIGAz4ImdOBYe
	E6r9Zey2grnnueePGHNMyMpPMVok=
X-Google-Smtp-Source: AGHT+IFw6YFPE4uQg6imkFHXMbxtDADWvwTRJd5bZLVgOFxAE0atjLaGwN/Y3Vs2U2TCttK/XyhsIPdmUPLmGEsItEg=
X-Received: by 2002:a05:6512:1055:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5353e5aae01mr710771e87.42.1724899675197; Wed, 28 Aug 2024
 19:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 28 Aug 2024 21:47:43 -0500
Message-ID: <CAH2r5muvO8+Es4Y8d=VtWEp-vcC62TYEZc3W1Y0r+6ro6d9yxQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm, netfs, cifs: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

testing is going fine so far with David's series ontop of current mainline

(I see one possible intermittent server bug failure - on test
generic/728 - but no red flags testing so far)

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/207

On Wed, Aug 28, 2024 at 4:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Christian, Steve,
>
> Firstly, here are some fixes to DIO read handling and the retrying of
> reads, particularly in relation to cifs:
>
>  (1) Fix the missing credit renegotiation in cifs on the retrying of read=
s.
>      The credits we had ended with the original read (or the last retry)
>      and to perform a new read we need more credits otherwise the server
>      can reject our read with EINVAL.
>
>  (2) Fix the handling of short DIO reads to avoid ENODATA when the read
>      retry tries to access a portion of the file after the EOF.
>
> Secondly, some patches fixing cifs copy and zero offload:
>
>  (3) Fix cifs_file_copychunk_range() to not try to partially invalidate
>      folios that are only partly covered by the range, but rather flush
>      them back and invalidate them.
>
>  (4) Fix filemap_invalidate_inode() to use the correct invalidation
>      function so that it doesn't leave partially invalidated folios hangi=
ng
>      around (which may hide part of the result of an offloaded copy).
>
>  (5) Fix smb3_zero_data() to correctly handle zeroing of data that's
>      buffered locally but not yet written back and with the EOF position =
on
>      the server short of the local EOF position.
>
>      Note that this will also affect afs and 9p, particularly with regard
>      to direct I/O writes.
>
> And finally, here's an adjustment to debugging statements:
>
>  (6) Adjust three debugging output statements.  Not strictly a fix, so
>      could be dropped.  Including the subreq ID in some extra debug lines
>      helps a bit, though.
>
> The patches can also be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-fixes
>
> Thanks,
> David
>
> David Howells (6):
>   cifs: Fix lack of credit renegotiation on read retry
>   netfs, cifs: Fix handling of short DIO read
>   cifs: Fix copy offload to flush destination region
>   mm: Fix filemap_invalidate_inode() to use
>     invalidate_inode_pages2_range()
>   cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target
>     region
>   netfs, cifs: Improve some debugging bits
>
>  fs/netfs/io.c            | 21 +++++++++++++-------
>  fs/smb/client/cifsfs.c   | 21 ++++----------------
>  fs/smb/client/cifsglob.h |  1 +
>  fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++++----
>  fs/smb/client/smb2ops.c  | 26 +++++++++++++++++++------
>  fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++++++++---------------
>  fs/smb/client/trace.h    |  1 +
>  include/linux/netfs.h    |  1 +
>  mm/filemap.c             |  2 +-
>  9 files changed, 101 insertions(+), 50 deletions(-)
>
>


--=20
Thanks,

Steve

