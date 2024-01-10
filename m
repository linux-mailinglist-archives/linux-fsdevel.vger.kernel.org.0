Return-Path: <linux-fsdevel+bounces-7685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCA8295CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EC01C217BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A13EA8D;
	Wed, 10 Jan 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gucAvcII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF23EA86
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680b12e5d42so26353286d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704877709; x=1705482509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCw/3Ewd+U2ktVVrDxFwfQgPCY3+ozzc9OmlzbcBddY=;
        b=gucAvcIIr7yTX3+lC48+bsSznfzoNYDc9FSWj0OSt+lXCKB7C77M7CHxZTnWfSM5DM
         LLb1t5hBLQacDTb4jNd4H4OY8ytgtVqVtX+6SQuse2wiBs6ySsBS2EpXsSJrx+kFx+a4
         F6fLiGrVfHtbe0TFS5tERc30EQSSCg7N6Qs72IqnGRRzfC1AA3drUkCNZs3ur8uOkFa9
         gUSq95TGh6amwofr6Orc+nGYfXxnWuRUm3sYFbSodApS/0CPthKnYjb2hOG0JAoZn9UF
         W+MTL8/WaBGCjcxFfM95VXOJRdcWdNSH/X8GsR/9FnK6Mu/Hfyck0cI8UFkEilSW49vR
         O0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704877709; x=1705482509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCw/3Ewd+U2ktVVrDxFwfQgPCY3+ozzc9OmlzbcBddY=;
        b=tcbJkWjmoOE2PFBCcClSWcMKfIllEK1OR0JC7arvpBWlDVZbVibgA41dUGWJiMeFmE
         1ry2tb2SYcLVWb7ngENxBsrmMj1iSy4uj4rGNQgBNiyF8HdVtsQZ1Cam1JkSxbBZdyO0
         5SBWTgnwoUHCX+ZkRU1qkrsIo9BtTALRu9qzb7CYd5maKiwly4ksoydMsiZ6Il12CI4a
         Drk59VO2cXc3rgWONVkmPsOUayqdZ4SHrEiTiFfkdEXRwI7ry2pvRznYkNqkXJ6+4HWo
         7z4NnZspbhI7e5oxqDn50Irx3JYdEep9xFXKn7OgyIsbkuL8HB61kktBQ13OcrwEPAJ6
         fMiw==
X-Gm-Message-State: AOJu0YxgT9u+5KcV4wK/jAkdemAoXjYa0V1z+V6Nx/OLL0DKOEk2Ntrx
	0bJ1AjaIG2O3zxsrUtDYpBaWm3PKryxHakv8t9IO9bochEM=
X-Google-Smtp-Source: AGHT+IH+tcHgMpqKqq+2EeCKSms8puT3rfJTVC8X4ft1cNswYXe2G2R07l2TdrfcmvK8ncVil1+/PTYt1xDnP6Kculc=
X-Received: by 2002:a05:6214:2461:b0:680:f7c2:76ed with SMTP id
 im1-20020a056214246100b00680f7c276edmr1045127qvb.27.1704877709625; Wed, 10
 Jan 2024 01:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109194818.91465-1-amir73il@gmail.com> <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
 <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk>
In-Reply-To: <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 11:08:17 +0200
Message-ID: <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:24=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/9/24 1:12 PM, Jens Axboe wrote:
> > On 1/9/24 12:48 PM, Amir Goldstein wrote:
> >> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any t=
ype")
> >> optimized the case where there are no fsnotify watchers on any of the
> >> filesystem's objects.
> >>
> >> It is quite common for a system to have a single local filesystem and
> >> it is quite common for the system to have some inotify watches on some
> >> config files or directories, so the optimization of no marks at all is
> >> often not in effect.
> >>
> >> Access event watchers are far less common, so optimizing the case of
> >> no marks with access events could improve performance for more systems=
,
> >> especially for the performance sensitive hot io path.
> >>
> >> Maintain a per-sb counter of objects that have marks with access
> >> events in their mask and use that counter to optimize out the call to
> >> fsnotify() in fsnotify access hooks.
> >>
> >> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> ---
> >>
> >> Jens,
> >>
> >> You may want to try if this patch improves performance for your worklo=
ad
> >> with SECURITY=3DY and FANOTIFY_ACCESS_PERMISSIONS=3DY.
> >
> > Ran the usual test, and this effectively removes fsnotify from the
> > profiles, which (as per other email) is between 5-6% of CPU time. So I'=
d
> > say it looks mighty appealing!
>
> Tried with an IRQ based workload as well, as those are always impacted
> more by the fsnotify slowness. This patch removes ~8% of useless
> overhead in that case, so even bigger win there.
>

Do the IRQ based workloads always go through io_req_io_end()?
Meaning that unlike the polled io workloads, they also incur the
overhead of the fsnotify_{modify,access}() hooks?

I remember I asked you once (cannot find where) whether
io_complete_rw_iopoll() needs the fsnotify hooks and you said that
it is a highly specialized code path for fast io, whose users will not
want those access/modify hooks.

Considering the fact that fsnotify_{modify,access}() could just as well
be bypassed by mmap() read/write, I fully support this reasoning.

Anyway, that explains (to me) why compiling-out the fsnotify_perm()
hooks took away all the regression that you observed in upstream,
because I was wondering where the overhead of fsnotify_access() was.

Jan,

What are your thoughts about this optimization patch?

My thoughts are that the optimization is clearly a win, but do we
really want to waste a full long in super_block for counting access
event watchers that may never exist?

Should we perhaps instead use a flag to say that "access watchers
existed"?

We could put s_fsnotify_access_watchers inside a struct
fsnotify_sb_mark_connector and special case alloc/free of
FSNOTIFY_OBJ_TYPE_SB connector.

Using a specialized fsnotify_sb_mark_connector will make room for
similar optimizations in the future and could be a placeholder for
the "default permission mask" that we discussed.

Thoughts?

Thanks,
Amir.

