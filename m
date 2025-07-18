Return-Path: <linux-fsdevel+bounces-55489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C8B0AC26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D874587C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE9221FBC;
	Fri, 18 Jul 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUOosauB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516F1F4E57
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877424; cv=none; b=pZL21lxggB3iWqULf2AGCKrfm3jNrrly0Iyej2Ctel8hNJItfQ0bPyUXq38FBspVTHWOZpgxkDIURh9ojjncAFQVlkIp6jOcT7wMMyqLJp5iHr0h7FrKhxOxGoH8IWqZfN1U/AXeKXNfO76CBhED+b1AobbfPg7wCIr2dwD8tE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877424; c=relaxed/simple;
	bh=grXeon7PW5jztM5Ot91wl2v7x1A7inJaGIZkUxAxOA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNgpOXFaK6HYFjYvSuL968+GmQ/sT+YK/ogKPaOQanEPzkT6afMRC+kInUvNznPiNzoMlh2ZVjk/XSFGcoyAzUEUlJY8yDCwlL5dnbDSjBEnlhcyEVu1Pt9OrwlKcElSDteurwG4luj/cGEiNm8ZI0waqmaKu4ffUNmS5tD6eSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUOosauB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab814c4f2dso49543391cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752877421; x=1753482221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLcE3c97bswhvDcpb/Mu89yECSqg+qzgzNEOXeMdRcA=;
        b=EUOosauBJTtHc2Kh5rUGRbSMGBMbWSRUQBsvEIs+MnNQOqlESvw63HWlKBooj8mKYL
         F45OLYLk/PqLKQ87J833JFbbxYYf2aKDiyx8CWU6noUdDgCik3mGk0Y85x1hFKaru+nz
         LDKxKO1cvWxGmZvKcxgv3bRIGLizCjgmTW7zZvbruGt+5wRyqRPZXbsxOwSGCZHf7XPK
         A7rWU7nrWArUpSUZwbjNA3vwjbCnBKd9D4M6fMFPJy0+PmbTlJJ3TB8FqZ4y4dZKdPx+
         xZ6L0M3Wh6wsNkIF2kdR1usfC20Sa1YrxLJFvjdlU9kPu+XFaqGpXNGSp7Xzj9wv7g/B
         v3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752877421; x=1753482221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLcE3c97bswhvDcpb/Mu89yECSqg+qzgzNEOXeMdRcA=;
        b=XFUolFqXlfjdY+y2CIOvFzzhmQ+5F5teI3qnfW3JiH6I7bOhFarG9YLib9gaZNdERI
         T391T7g480yOgXYJ0YcLHUJkc1i5zSekoVaMAN6Z37pScjzLjJKFLGPmbvXW1h0nHkWe
         /7b3AOTemzA+KjFPoSY5SJ2tH1Y8iOhrkjbKrm+iPlenbmrq6VSe/AmdSKmhE+cK37MC
         g5JqMSKjOvz7ggMd+m+zwJY0oHav09lrjMAkXlkIf8YuzIn2tINYShWFLJNtSlbQfnYO
         jadlzvEDI6ORp0iVle6166/CbV2d2aFoqO6W5vdXtCv2jOBSC96qQzO2UusJ2nLzoUmf
         DA2Q==
X-Gm-Message-State: AOJu0YyNqDoVbGxLDsxFLqbbxCpN8cQID3Wqt1MS244ki3woTeAFOyo5
	pVQdm0SCSDvGw0wixN5RWqiiP86ReRMwdqYeA+Li77poNKRH7X10F1x43A7RxtCHQgr0t18FJ6b
	k2Yr6nVHUchB59NF8lhibvXaJyr9eCP8=
X-Gm-Gg: ASbGncvl4bV7L6h/JDHE5zxJUvwNDiqvslZBuaImz0qX8s/kWnbs3pQQyPPKCjSySOd
	ZqjrMwaQgMzvNXwQfnbkIBy6xu8MYgayZJL6GE77aPVxwA0EykBGRKNPiQGA9l996+GE2SGiJtW
	t70WlDKMcW2zBosfqAXLR8niReteUk72GhWLAMzEnR1l1JfBGTqusBMI2E9USEB+XJqv2gaSu8F
	SfKuGJLOGh52V2+HkZsiV8UVcqqvJhzhg==
X-Google-Smtp-Source: AGHT+IHdY+eZt60EWYhnTaL1xsqOBW2bVVeus+4Vf8EVCXkp94Zj0yDzzfTzPbaUQBfQhaSxRAIeOIbN3fOFsIHp33w=
X-Received: by 2002:a05:622a:1646:b0:4ab:8f1b:c033 with SMTP id
 d75a77b69052e-4ab93d5dc6dmr157093261cf.30.1752877420965; Fri, 18 Jul 2025
 15:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs> <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 18 Jul 2025 15:23:30 -0700
X-Gm-Features: Ac12FXw4PUkTABI2M7Z33_rZrqPylCIA65A4OzBugJ8QcT6MSKDgBvlwXAFIlAM
Message-ID: <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> generic/488 fails with fuse2fs in the following fashion:
>
> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is in=
consistent
> (see /var/tmp/fstests/generic/488.full for details)
>
> This test opens a large number of files, unlinks them (which really just
> renames them to fuse hidden files), closes the program, unmounts the
> filesystem, and runs fsck to check that there aren't any inconsistencies
> in the filesystem.
>
> Unfortunately, the 488.full file shows that there are a lot of hidden
> files left over in the filesystem, with incorrect link counts.  Tracing
> fuse_request_* shows that there are a large number of FUSE_RELEASE
> commands that are queued up on behalf of the unlinked files at the time
> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> aborted, the fuse server would have responded to the RELEASE commands by
> removing the hidden files; instead they stick around.

Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
of synchronous. For example for fuse servers that cache their data and
only write the buffer out to some remote filesystem when the file gets
closed, it seems useful for them to (like nfs) be able to return an
error to the client for close() if there's a failure committing that
data; that also has clearer API semantics imo, eg users are guaranteed
that when close() returns, all the processing/cleanup for that file
has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
the server holds local locks that get released in FUSE_RELEASE, if a
subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
grabbing that lock, then we end up deadlocked if the server is
single-threaded.

I saw in your first patch that sending FUSE_RELEASE synchronously
leads to a deadlock under AIO but AFAICT, that happens because we
execute req->args->end() in fuse_request_end() synchronously; I think
if we execute that release asynchronously on a worker thread then that
gets rid of the deadlock.

If FUSE_RELEASE must be asynchronous though, then your approach makes
sense to me.

>
> Create a function to push all the background requests to the queue and
> then wait for the number of pending events to hit zero, and call this
> before fuse_abort_conn.  That way, all the pending events are processed
> by the fuse server and we don't end up with a corrupt filesystem.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    6 ++++++
>  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/inode.c  |    1 +
>  3 files changed, 45 insertions(+)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> +/*
> + * Flush all pending requests and wait for them.  Only call this functio=
n when
> + * it is no longer possible for other threads to add requests.
> + */
> +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)

It might be worth renaming this to something like
'fuse_flush_bg_requests' to make it more clear that this only flushes
background requests

