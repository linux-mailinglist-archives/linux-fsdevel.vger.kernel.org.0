Return-Path: <linux-fsdevel+bounces-64054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A31BD6BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C11B19A2486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301272C08C8;
	Mon, 13 Oct 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSeOVDRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DE296BD4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398366; cv=none; b=h1n3JlmpLNgpeUA+TTY3X8Um5UDB+LaCUc30A17vPqHwLTTJNiaJKUfZzjELlqbgEgy0eti2XojzNxoADBoefpth82WeSQ5Om5Lc/uagIYEWpopUq7vAw8OF6Fk7yS20HYe+bOwCWmKZztahH1evEEEUmlcG6vsSu44Of7K+lpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398366; c=relaxed/simple;
	bh=YKRAbY4NLAInzdfiayu3jIYMgD73poWMR3eCyQVpvwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwihPZKN7pp3Xd6pvFc37/DQpBt1/yjpo/ijUdhwGjOQrNUb79y73983KZKrEeUF7Wwp21yVdSplpIkPX/0SYGd0KtuQe+rWXqTMBLmw2uAs26DCPyuTUylFxYTS/fjQ0fbTpep+2Yh//9+4SGAfv53cO561JKS3rtsPQmd6S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSeOVDRW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87bb66dd224so57616066d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760398364; x=1761003164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpYqb2ZCluNziOmcII9ceMyb1EVm6bnboOL+/xp8D78=;
        b=LSeOVDRW+hGnlJpN+tH1JpbCDMSoyvOdKnAC39CQS/n2YMrCglFXmHFJZAPRtIbXxJ
         2HjRqYCspQrx1NWBeI+DPn+bxsnkVhGly4zN8l7T53w7ys4mSSAX5wgRJfh2BP8z1h/1
         wzwlW2CmvuLlh3qSdOD3GB7wHxv99L1Cdcob4UqLWO83wwXrnqGjEDOkZyHRI8cOhTG8
         nQZMCPrA8UNqFtD3G7ctKHbCoYufQD7eI/Pg43tYWnbOTJD4ybG767fDbQSQzXatCbSr
         vgyzLYUjqf1rghz5zxLh6owsgxrn9uC9XgxKLXLLpL0pLcfpt6ey1zIey8t2JjpeHUGI
         WFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760398364; x=1761003164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpYqb2ZCluNziOmcII9ceMyb1EVm6bnboOL+/xp8D78=;
        b=QXqWwcz0Z52EhLwxS+ZrjWdGeo+4hrH/TRWByIoG6dCPaMAVD9/QuJO4ZkyEm0iGBx
         ghVKYnJ7zEkrbgLOTmvbBp/oQ5jwzur7S7E9VcPD3ZgAqekKQdKq9XVuKFttQNiWG7cv
         iS5A87GO6NGKHuhYd2qNTT1TZEg2tffFP+Zxp/VPXfkx7XCnQaa+OL5xjo+Q0Gift6wI
         jmMphl/jCZgtzvOa52HnQX7a06ELWKByC/c4gdH1sXSBBxWJ3GwWX8uAZ8bkn2dW1kq8
         KN0GCAKSZzRotIept41MoiUsQj3XAWK9TExHy8ESU+dqi93/e1Wg04y2VkXoZ6c69wlj
         sedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcIXz7RX866DwNCLCNBtc1exTkW+x0LqGz61uFfYs7gyXzRfsegunrveki+ZgU8eqyaxviEiDK4ymGg7vn@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrU3GmlsBO8rl8UKt/p/+xi6vcWB2qNw0nMQiufDDh56t5CVj
	Q6FawTaygU8Nhkxxo3+EXf6w3I0qc0wZM5p3i8bg2BmYiFNgTR9ATTyrgdm+ESWktqfRNibhkiX
	JzW31yQtuFxP6cG5G//XHMM2TjNxzl54=
X-Gm-Gg: ASbGncu4zVQnLegcZjG4QQ3WrEFsLTSWrtmKFwBqIT5+ELh3Z0Dhoza4Y+41ROe3SV+
	5CCEhwAEx32gg8Iu/MmcxB9TfJZN+IA2fVMjnUUByxHnZsJteRFKOAhc4DN5HZBwtaQcW6dsr3t
	2EXR9Ml0Yn82ZFwVolDTP4vjFIXK/LAvbAo7yp60cVw+hxc/p9js3d/WrdppToo+RXJVvZkg8aR
	NxN/QF7SvfoequkFhujukIGYgH6VusJGLf2m0RHg1VENLRwV79QKeF+VLDkw1JiTUPR
X-Google-Smtp-Source: AGHT+IFW4AEkmHVKOwavDx5w9Ku/TO7hW0iD5YD27kh4136T2XmCfjRj4tPp4LXvC5tkFm71KBC+9sbz4BFNHPrU5iQ=
X-Received: by 2002:ac8:7f09:0:b0:4cb:979:646b with SMTP id
 d75a77b69052e-4e6ead622e0mr273951501cf.55.1760398363773; Mon, 13 Oct 2025
 16:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com> <CAJnrk1ZCXcM4iDq5bN6YVK75Q4udJNytVe2OpF3DmZ_FpuR7nA@mail.gmail.com>
 <54e30e4a-36c3-4775-a788-dc15e3558b9b@bsbernd.com>
In-Reply-To: <54e30e4a-36c3-4775-a788-dc15e3558b9b@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Oct 2025 16:32:32 -0700
X-Gm-Features: AS18NWA-25MSA2awLHIL6lQs0487lVP4jCWcezWHosoNNeei8KqR-UEwnvxgsnQ
Message-ID: <CAJnrk1Zu4WSr_YnZNa7Zf8s8-wAWTqL_xQyZhFSU6jCZMeryFg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:40=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 10/13/25 22:27, Joanne Koong wrote:
> > On Mon, Oct 13, 2025 at 1:16=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> >> On 10/13/25 15:39, Miklos Szeredi wrote:
> >>> On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrot=
e:
> >>>
> >>>> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> >>>> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, veri=
fy
> >>>> that it hasn't been invalidated.  If old_mtime is invalid or if
> >>>> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> >>>> cache is not invalidated.
> >>>
> >>> [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> >>> Link to complete thread:
> >>> https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmai=
l.com/#r]
> >>>
> >>> In summary: auto_inval_data invalidates data cache even if the
> >>> modification was done in a cache consistent manner (i.e. write
> >>> through). This is not generally a consistency problem, because the
> >>> backing file and the cache should be in sync.  The exception is when
> >>> the writeback to the backing file hasn't yet finished and a getattr()
> >>> call triggers invalidation (mtime change could be from a previous
> >>> write), and the not yet written data is invalidated and replaced with
> >>> stale data.
> >>>
> >>> The proposed fix was to exclude concurrent reads and writes to the sa=
me region.
> >>>
> >>> But the real issue here is that mtime changes triggered by this clien=
t
> >>> should not cause data to be invalidated.  It's not only racy, but it'=
s
> >>> fundamentally wrong.  Unfortunately this is hard to do this correctly=
.
> >>> Best I can come up with is that any request that expects mtime to be
> >>> modified returns the mtime after the request has completed.
> >>>
> >>> This would be much easier to implement in the fuse server: perform th=
e
> >>> "file changed remotely" check when serving a FUSE_GETATTR request and
> >>> return a flag indicating whether the data needs to be invalidated or
> >>> not.
> >>
> >> For an intelligent server maybe, but let's say one uses
> >> <libfuse>/example/passthrough*, in combination with some external writ=
es
> >> to the underlying file system outside of fuse. How would passthrough*
> >> know about external changes?
> >>
> >> The part I don't understand yet is why invalidate_inode_pages2() cause=
s
> >> an issue - it has folio_wait_writeback()?
> >>
> >
> > This issue is for the writethrough path which doesn't use writeback.
>
>
> Oh right. So we need some kind of fuse_invalidate_pages(), that would
> wait for for all current fuse_send_write_pages() to complete? Is that
> what you meant with 'fi->writectr bias'?

Yes but unfortunately this would block reads on any part of the file,
not just the part that's being written.

Looking at this more, I think we actually could just grab the folio
locks and if we need to fault anything in, unlock all the folios,
fault in the bytes, and then relock all the folios. I don't think we would
need to check anything between dropping the locks and relocking, since
if we're comparing this against the existing code where we drop the
locks on fully-copied folios, this doesn't introduce any new race
conditions as far as I can see.

Thanks,
Joanne

>
> Thanks,
> Bernd

