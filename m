Return-Path: <linux-fsdevel+bounces-42420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474AA42447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466C23B2937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD328366;
	Mon, 24 Feb 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U3Q9Visx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7515442C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407992; cv=none; b=qubfo0/79ig/8yU+F56g8VAdBa3Zai66yVPaxVqu6ab4LRCKKCQTsaIJeJ9mOuociylzzYsduNqz4rnGVR3VpFa/wzujnm9w3b40IVcfuR2ZCW7FbJ5wAyDWSPtXuSL43aQ/JjhZGERLxI2k+ruNgPwcYNiTzbR4QHWDfggnElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407992; c=relaxed/simple;
	bh=94wPLtJyrUjvI0EwVuVFieJSPjMtnqdOvnmEEzQI6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBlgjZ2xBuYNdCSPqssVFFnG3R96tAr4NKOJgcCmYovOkJHLQq17PxuqZRYswwjCbWbowX6d9mtBacyWitU+SO9GRzarXD598gcxDDcDiwydUbrslhlPyksAT91xfAmmdvueR/AMQ+JxlfoIfVsT0FYCoYj6cO8ywc4zbJH1RK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U3Q9Visx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4721aede532so46150141cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740407989; x=1741012789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JC3QeVYDt8u+GiWrpVVB4VRltEGag4G5+mxmLi1Yh1E=;
        b=U3Q9VisxsMlAMyqVuKqgyM5HxOpND3jpdjo/uZj7k4u5Jz+AKYRFJjPF1zzmsuT6RK
         OcuXeJgQg53cssk2aaTXjiVyJdRnwTH6TNmOsusJt+9vRqPQD6rKkx5vhJLWfuX1ZuTq
         lDuzxqC+jpViy1PZwyF6qSeYYJfd0vOua8EwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407989; x=1741012789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JC3QeVYDt8u+GiWrpVVB4VRltEGag4G5+mxmLi1Yh1E=;
        b=gFwUzabkGjX97j/hS7ywrKq/pNjtV69jJ4ANRZlbWdOq47uJlybs3k8DIOqMfBhKQs
         1H2weFfQ+fe0lLNmflrx17Deoc156IoK0wUjIM4/fK8r9lD6wwRedmfIWpkAwXSNzyZw
         EgsyYX7KOc3isLY5V6dQJsIiFxKng5OmDePe6+EGBAi0APQ4UiPtgyEwTBqo+Jb5p6aS
         Hyg5efd21GzFNSrQQ4OkvBC/Xwb8QtOSa+qHAwLQywWdCM+WzslYtKsUl3I39Jrgn7QU
         SWH064i1IswhkRu1ZETyXtfdj6Qikc3YqukWci6y0OOF+0f3ygydZCBJDiqKGbT3a+a9
         fk0w==
X-Gm-Message-State: AOJu0Yz2ogpsQgpNMfoXBs8tJCm5DqOIPdqQC//xA9jgP8eeaWowOp46
	X82qttllbS+ddaiToOegNnUc+bPxG4F8uI+NLddJkNHGlQx1UEIq3OC34tJ4HzceVrn4vlYsVF8
	Tb6tE+bECPmLRE9jRWgJFO9IMMdwAm67qLt/v7Kat6u8gkQ3Z
X-Gm-Gg: ASbGnctbtST1Asovnr4rjiPfdct96Qa3t8qYJu2hLUKlmUxwmjRkRMeSoUAzWirxhvY
	gtjcLeC1UjS9FO+vsvZ7I/wO5UScqbCHpSreInYbQo4jXiUbZSMsVZnwGTN+sHbhMd1hItljfis
	noJI1zY0vA
X-Google-Smtp-Source: AGHT+IHZpU5mAGW93Jd5L4tacEoM3CWPtQbRj5Xt6W3Nz6pXQ1Xx1AgYfWsJilDWbc/tX30TC8rhJxnhdq0BVyB2En8=
X-Received: by 2002:ac8:7fd6:0:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-4722485b110mr134700401cf.24.1740407989180; Mon, 24 Feb 2025
 06:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130101607.21756-1-luis@igalia.com> <CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
 <87tt8j4dqe.fsf@igalia.com>
In-Reply-To: <87tt8j4dqe.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 15:39:38 +0100
X-Gm-Features: AWEUYZlaJmnQNd54xQ10tByWjlNqJJ8043f6HbvteQ8zLViYYirluMOYpoF5EZQ
Message-ID: <CAJfpeguQTZ8KcdffKvY8kknZVnBH6h3Tz1GSESwBjXSz_25TLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
To: Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>, Teng Qin <tqin@jumptrading.com>, 
	Matt Harvey <mharvey@jumptrading.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 15:30, Luis Henriques <luis@igalia.com> wrote:
>
> On Mon, Feb 24 2025, Miklos Szeredi wrote:
>
> > On Thu, 30 Jan 2025 at 11:16, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> Userspace filesystems can push data for a specific inode without it being
> >> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
> >> However, this may race against another process performing different
> >> operations on the same inode.
> >>
> >> If, for example, there is a process reading from it, it may happen that it
> >> will block waiting for data to be available (locking the folio), while the
> >> FUSE server will also block trying to lock the same folio to update it with
> >> the inode data.
> >>
> >> The easiest solution, as suggested by Miklos, is to allow the userspace
> >> filesystem to skip locked folios.
> >
> > Not sure.
> >
> > The easiest solution is to make the server perform the two operations
> > independently.  I.e. never trigger a notification from a request.
> >
> > This is true of other notifications, e.g. doing FUSE_NOTIFY_DELETE
> > during e.g. FUSE_RMDIR will deadlock on i_mutex.
>
> Hmmm... OK, the NOTIFY_DELETE and NOTIFY_INVAL_ENTRY deadlocks are
> documented (in libfuse, at least).  So, maybe this one could be added to
> the list of notifications that could deadlock.  However, IMHO, it would be
> great if this could be fixed instead.
>
> > Or am I misunderstanding the problem?
>
> I believe the initial report[1] actually adds a specific use-case where
> the deadlock can happen when the server performs the two operations
> independently.  For example:
>
>   - An application reads 4K of data at offset 0
>   - The server gets a read request.  It performs the read, and gets more
>     data than the data requested (say 4M)
>   - It caches this data in userspace and replies to VFS with 4K of data
>   - The server does a notify_store with the reminder data
>   - In the meantime the userspace application reads more 4K at offset 4K
>
> The last 2 operations can race and the server may deadlock if the
> application already has locked the page where data will be read into.

I don't see the deadlock.  If the race was won by the read, then it
will proceed with FUSE_READ and fetch the data from the server.  When
this is finished,  NOTIFY_STORE will overwrite the page with the same
data.

Thanks,
Miklos

