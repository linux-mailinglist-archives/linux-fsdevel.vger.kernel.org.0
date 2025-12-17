Return-Path: <linux-fsdevel+bounces-71501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A775CC59BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 01:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D561303B2C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CA1F1302;
	Wed, 17 Dec 2025 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2FhUA0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0A1E3DDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931536; cv=none; b=GFB7hldW7iSCHBp10Fv1TwnEMqHNp2Nlh4gbb4SJrtZTvE+z4837F252VUJ+0Db2bSCpL71foiw0LjKTqa0W8yZMjf860bn4S3Sll4ALy8vmzVNXodX5JajdVqOyQ1hlv037WNtoAEkPgXq+NLfP+69gUh3PmBLJ71wZknZgdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931536; c=relaxed/simple;
	bh=QeE9d0cjgTH60bZObyqT0/QqJm2AeD42a68mbSfp3pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuWn+WG0WK1KDrQbBI9nnk1XXWHzTHixjvN0nDEZXx7hhoMw+3shKXDczkdzX76JZIFFJyQVkWfJcJfT2Fk5Q/rHLGuByYhG5qrY29t8HNWpUiyMZWzQzdphAqSl35cZVrJXhm9LpNK/CAuHZxjOqWznoqin3/DqlQGykWxsCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2FhUA0q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f34c5f2f98so11028311cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 16:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765931533; x=1766536333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQ7j98K/Tr+ZclJuiJWkYJqzJxktIL5WvOfMkPYJ7Dw=;
        b=P2FhUA0q/LRfW5Tk9ptL1ltAKHrpHoOC3vhCmrLUgWSDzYwUrHBwYAcAFdVHbbXpNz
         tPp59cROFNfeA7drfoJM4t9Fhy9eCSIQYY3XPUlFnMZ9G0TKF0lGQQhlgwsiUmAX80T3
         akDTR0Nbq9bRrz8sYGAy1Ei84Y5jBU9isrjfGqM/qPzICaZ1IxBdzmb0bShwtNbd/ThB
         kaMcsHo2XpgNebpcNd5xleFWHcyyqNbq2/+XHAdZiP2NIoItM+g1MShP1zrh+qtutXcJ
         nx216fSVmouDx9dL7aWLLlnvtKl4DJ0HJjfWwRUTOvcxzfwtKFGJO1h1pX0vq9q1JJr+
         sEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765931533; x=1766536333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQ7j98K/Tr+ZclJuiJWkYJqzJxktIL5WvOfMkPYJ7Dw=;
        b=cgl3Hf9Yr83PzbLVEFZLeCa6z6S5vCW6uDT0em+Qj+SXN6ZpoawHeje6h4TpwjDFOQ
         Qe34rd2RhAOJzd2QMygnitLSW8C3e+uOKXJJlzoHb+u/WnQTa6klFtX7NGv8AjWc7n25
         q5GC85lnlozNWmsgco/8cOX43PjiVtxV+kxeMGEorPjm1UfQgMfwe+XyVCDnEG+zYGXk
         FmgB52rKHkqawOgHJ+TCpfWJSSj5o4qxd0RFD0ca2KY3FflzFeTEWuhqHVN1WFOOepmw
         5vg2gYrhgYc/GzFRvV2MepfmdmXK5hINM3k+9w1KgnH/TiW25GBcay51vy9d5EltgdNG
         ivkA==
X-Forwarded-Encrypted: i=1; AJvYcCVcFTQW89/Xvp9DjWOkTXBxe7IZTzhZB5CzrEUZ0aMRZ/fQk6ThauVueu5PimNfLIYUnQLFuINidGoE6pYS@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqCnx1BMr7S3qWY0RNBfiEsAm8P1r+59jfrb63SV/tqrqwMCw
	scMSUtnhwSWC9f8BT6iOAHdnouvg5DfxGHaLpV79w/DgZoZ3LWP98b+B/DDCbgwcXtfi9Cw8O+N
	OQQ9wzfVM1VTyTUrgFEZuXGWfjLJwzLSV1rQIAtwdVg==
X-Gm-Gg: AY/fxX7monMrdAB59X1eyUfYNgpoLvkp0lwLZmfft7b5MelD4tRJ2eWzHor6xlKgEia
	ue6066e+ufJa+P9ptO7vrPh2llSPMxVZHD7emZV+UL3U6MQmzLqo3R/7eVBvEigtbtou01N8Ohk
	AocafHWnh8o+kntgOyj90j6AZCIrg8bI6o9Jwdh0XwIQ/6A86gAcT4PtMsPUXiWx65nlk53+o8W
	MtfgnJ6q0tZ35KB729Fg4cdaB6yw7UNgiqjhuevecUjV7Um1v6pLZsnMP4hldffkzJpi+BwLdIO
	m4fu7KWnIBM=
X-Google-Smtp-Source: AGHT+IGeB7d/8/rYb2PpUn6GTMTSfGPNSAbQ2fhttcbHoR8japcIHWuJgZFjZ8vniqoOyRcX7azyDODVnXmU7Ub+oN8=
X-Received: by 2002:a05:622a:4d99:b0:4ee:d6:7a51 with SMTP id
 d75a77b69052e-4f1d04670b7mr251415441cf.12.1765931533316; Tue, 16 Dec 2025
 16:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com> <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
In-Reply-To: <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Dec 2025 08:32:02 +0800
X-Gm-Features: AQt7F2r02d9bIZH-qWqJjRBxT22L48jaD0-q4StwiqWrrjXfODBTEUYP8SYAMTA
Message-ID: <CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Bernd Schubert <bschubert@ddn.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:54=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 12/16/25 09:49, Joanne Koong wrote:
> > On Sat, Dec 13, 2025 at 2:14=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
> >>
> >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to i=
nclude
> >> an extra inarg: the file handle for the parent directory (if it is
> >> available).  Also, because fuse_entry_out now has a extra variable siz=
e
> >> struct (the actual handle), it also sets the out_argvar flag to true.
> >>
> >> Most of the other modifications in this patch are a fallout from these
> >> changes: because fuse_entry_out has been modified to include a variabl=
e size
> >> struct, every operation that receives such a parameter have to take th=
is
> >> into account:
> >>
> >>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>  fs/fuse/dev.c             | 16 +++++++
> >>  fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++--------=
-
> >>  fs/fuse/fuse_i.h          | 34 +++++++++++++--
> >>  fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
> >>  fs/fuse/readdir.c         | 10 ++---
> >>  include/uapi/linux/fuse.h |  8 ++++
> >>  6 files changed, 189 insertions(+), 35 deletions(-)
> >>
> >
> > Could you explain why the file handle size needs to be dynamically set
> > by the server instead of just from the kernel-side stipulating that
> > the file handle size is FUSE_HANDLE_SZ (eg 128 bytes)? It seems to me
> > like that would simplify a lot of the code logic here.
>
> It would be quite a waste if one only needs something like 12 or 16
> bytes, wouldn't it? 128 is the upper limit, but most file systems won't
> need that much.

Ah, I was looking at patch 5 + 6 and thought the use of the lookup
handle was for servers that want to pass it to NFS. But just read
through the previous threads and see now it's for adding server
restart. That makes sense, thanks for clarifying.

Thanks,
Joanne

>
>
> Thanks,
> Bernd

