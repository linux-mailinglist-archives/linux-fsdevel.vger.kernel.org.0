Return-Path: <linux-fsdevel+bounces-63121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2CBAE577
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 20:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C101678B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E7239E7F;
	Tue, 30 Sep 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THfRFIZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414F22126D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258063; cv=none; b=DnSlg4TCyyMPU1kkjc5BIMzjDp6cxOyepVurjn/+yRs9n2X5fxRKNy/MJPHFHFcG4PO8OjcX14TJgl+uNuqMMc8aU+zENx7lV7nkn7e8M9/96EZq6HkA4aqvQ84m35QLElSz4nlvplEXudADjxAC2QRrz84Wefp8EGm1Eh2hV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258063; c=relaxed/simple;
	bh=WVJvVzVNCAGgw9/uh8MrdFGl+TSWah5yn/zC0RJzb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i26QEVtjpj8xfgkR6ysAESzp41pb6CzAF/piHIwXKbmNqJvar6fkYgqbt6RX6/3N11NJxRpi3sY9AJ3dHM953s+PgNCAtFp7sI5oEXIrVkDNOIHFoUmIzX3DOIEKE581frQhJZA4xcbkfKOW2w2zCQ+OpJvdWvs67sefZ0dp1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THfRFIZj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de2c597965so44221721cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759258061; x=1759862861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVJvVzVNCAGgw9/uh8MrdFGl+TSWah5yn/zC0RJzb6E=;
        b=THfRFIZju6c2vCBzO5KEb6+LtA29S/5qnLQfbDLxUlEFrcCNFMbjnPTcOyEW5TigAM
         ESsFV4WtWyHI0fHcLasfcTHiuA0DHT8fqxds1EowOZVLPwsWGF6grT1Jd+D5QXRHsUlq
         bgC4o3bsUChlBnV5ZtJDAWsT99aAs96owns/fHWtehzaOwF3TWl99cqbtMPZwqdmGfn7
         DWwsg7kJEXlQDRv5DBhx3UdEOIvoFNqlHuUItxPxCuDxqaDGarDBaivbx8yrw5P7yruJ
         9iUF6gKf1v721Bwy9yyTWli84+pDmOWx9W5NRUqlbrjS55A1b050J4fyGzq11dy8MuBS
         tEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258061; x=1759862861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVJvVzVNCAGgw9/uh8MrdFGl+TSWah5yn/zC0RJzb6E=;
        b=oGUJw43Ugincl1LJLo5kZB4oeuD2XlvbqpHa8QehJAuAE9fJpWH+Kf1phS0wHmOYCE
         i4BPDz9dT8V0XhZxNrK7hjmnBuW0EhUxyqfZyitfPJsMej6OUKhBjF0ijM8De2lznc1l
         0v50SjWuiDg4Rik0snr+JSQ08IBLDvY1oR0ib2UIcqE7bXPbEZ44lyguVZeiEjhCm3Qg
         9Qznl1EtVC4RcG4Xvh8BIq/rl2AsOEsw26xYAiS1KXshGscQX0lfeBhmDA7LLqknmr8U
         QMhWZs87V1DUjjLLC9sAQuEVnE+A1LQRTX1mjyo3QwMctU4rq1UNugtW2ULf0yJUk87i
         E09w==
X-Forwarded-Encrypted: i=1; AJvYcCXKQagG0joQV4K9UjgPaSq62ih2G9zL25vL/xwnJcwnQnDzrDBFvX1GVgKEfDg835dnoUnaqZQAhxeaG/1I@vger.kernel.org
X-Gm-Message-State: AOJu0YyweDOF9oRdaC+n1tLcuIFSc6254SID13MveKtJtZLny84OQ6WZ
	XVasfP/Je3m15lQTCOsDJ+nCvtTllSJiHbmOhTcFLEUDSJtyGlMdC97824WuZUsVq7sIA51IhdP
	koW4luwpwgg6vo8wihGCzcbNPPjXJ3uQ=
X-Gm-Gg: ASbGncuhBgJggMTfj4TZlEi9SV0IJ85vGYiimVhB35c4dfYl/0h+CsiIOFGf/ONf+eq
	P+YPAnM3jCL6Pxd67OXVQsd5Pk8Cpik9PmHQ0XMDQRJ3AOWo63w8rCmUnWPXcC90cS2R5+ozevW
	1RLvEoiKMJCt+TbgnR5v+wbg5e8KbIsPZRTkh1nJpcuGS1s6KwDQS+HMWuMwiY7adGnYsdMEKSY
	XM2Qiwpe0BHnmpm2fXUbnmbr8B7NrgKoCzEisqg6Hgs0s/53cisejWjRLSDH9yWn2D6+ugKlA==
X-Google-Smtp-Source: AGHT+IHnNH3cXy8KGwTJmzEcyqjfdHhD4WvC7JISJfcMY9H1uN4hZgRw6ez0hFTTxAwM0BBtYsW/C0cVQflVYq6zKFA=
X-Received: by 2002:a05:622a:590b:b0:4b7:90e2:40df with SMTP id
 d75a77b69052e-4e41c548ea2mr8963721cf.1.1759258060730; Tue, 30 Sep 2025
 11:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
 <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com> <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
In-Reply-To: <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 30 Sep 2025 11:47:29 -0700
X-Gm-Features: AS18NWDp1Mi0jDVHhAelI6qsmniuwTxmDCAOEjxJb7wz_yDyViUsjcoMw90-8wA
Message-ID: <CAJnrk1Zty=+n4JEeOAWywhtBNQ5cNzHVFzPVY=KSHhX5Qs_1Yw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	osandov@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 30 Sept 2025 at 04:21, Gao Xiang <hsiangkao@linux.alibaba.com> wr=
ote:
>
> > In principle, typical the kernel filesystem holds a valid `file`
> > during the entire buffered read (file)/mmap (vma->vm_file)
>
> Actually, fuse does hold a ref to fuse_file, which should make sure
> that the inode is not released while the readahead is ongoing.
>
> See igrab() in fuse_prepare_release() and iput() in fuse_release_end().

If the file is mmaped, couldn't the release happen before the page fault?

This is the chain of events I'm thinking of:
file is opened, file is mmapped, file is closed (which triggers the
igrab() and iput() you mentioned in
fuse_prepare_release()/fuse_release_end()), then client tries to read
from the mmapped address which triggers a page fault which triggers
readahead.

Or am I missing something here? I'm not super familiar with the mmap
code but as far as I can tell from the logic in vm_mmap_pgoff() ->
do_mmap() -> __mmap_region(), it doesn't grab a refcount on the inode
or the file descriptor.

>
> So I don't understand what's going on.
>
> Joanne, do you have a reproducer?

I don't have a reproducer but we saw the stack trace in the commit
message on our servers a couple of times and used drgn to pinpoint
that there was a readahead request submitted.

Thanks,
Joanne
>
> Thanks,
> Miklos

