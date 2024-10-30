Return-Path: <linux-fsdevel+bounces-33310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B949B7006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00775282FE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B021765D;
	Wed, 30 Oct 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHZvzzKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6C217640
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328682; cv=none; b=qGpf9TBFRmmCIZgsvs5l6eq99EHMYQ0YO27YU+FdG2F7QdsTQZpLpDc4nHyUbqWmNfeQQhyy9l2/4Kv/QlSpwklH5ycONs8znZi31n6j1ENQnJFArtnoF9VQtqEYVvCfsOTWYc2dj7rQO3rcpZtNtP0LWAfZFsorqzNZiMoZ88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328682; c=relaxed/simple;
	bh=a9+mkQS/Xq2VnALxHggjQcZlPNoXcl/QA/fNr8RdeY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Re4uyMgSVT+z4JEvvTrWkZVLxfZ5pjhnqx/Eq9Gwb1ylhu0y7L4ZF27oqnCfjmVKHSBOVCncRETzUpPeB683Yca2gVgXqVUHZiObsLGLH3jIuQbf5K22W1lzE0tdKn2tVNg2VD8TB3qsAzzhmHzHQMBr8NjKLeFNDSCqg3zBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHZvzzKb; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460d1145cd8so2314671cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730328679; x=1730933479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9+mkQS/Xq2VnALxHggjQcZlPNoXcl/QA/fNr8RdeY4=;
        b=FHZvzzKbZp5cYmlKOYWPBfCwLhIp9cH6bI6PBBRToH9c8epnQ74Eo/GhBYn5+hokJ4
         QDPUBnXyo5jeFjgaw3jSPQRpXjCWeNTwRd/qMc7LDVgLcC861aNUTqKJd7iZiyIsry2U
         ia15iAgdWOnEWibgOeMDVj2mCjKoK0b8jkH5kykVG2Dz4l8sH2HvtA6z+4D3n0XuEATO
         Cd5mnLha91ApH3ERqPVUitOa7EN5Igopb9cio5ozsJ+1r9JKd3UXo22DMF+ENPP/Up+k
         4/8R8dbV/wFRQMHkVG8Uxpj+i+V/h8n9RKR1HfPmc96pFbpqLLZLqHwuS8rw62dfttRp
         1VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730328679; x=1730933479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9+mkQS/Xq2VnALxHggjQcZlPNoXcl/QA/fNr8RdeY4=;
        b=gsLWsqn0gnhrFErJzrg6HAy7BvudonkpiazRnHLD9UF+8NSXy2WIAFW6lSI6d6zl8i
         wJirNQJCNLTend4CJCKh9Xt68GyDL50Jn9LAvZQyotQGrZnvfHDJqg8NEQkqyRBAUuua
         Y3tXCTQaLSHt3dw5DVCa26BwUt3jbBYX96WDtBlBepjAwMpBq9HXJgfpzfhjd84Laj0T
         9NHGD39/NrFmG0ZRdPj+F6tPhGTyj1pbfEYVZ1Unzj8OSldSAZnT0DJ1H1KPAE2e5JLb
         P0XCBKF276MTrfNOY4XUdMshM5vySyNWHPo3ySuwItbLkEhFfKHMWOgkdaxpcTy92nv4
         sbhg==
X-Forwarded-Encrypted: i=1; AJvYcCWLJt62xrJNxuDP3vjFDOvnrzdE1fQ97Ev80OqG+ld91zhO8cbNEUiRWJHiZ3bnIPa+WGxyschJ9jMxgTUE@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaT+oJIEAnW92tjz6o5it8EZzGUttnZBc0gbqDXziAL75o12F
	puXtsLFvlHKH6FKlQpoi9o91PnUqgkJuOTXwycuzKCnsoCMI0YqvcZZIee3q4jaW5EHoFpeGfQO
	f27iVeVZsXup5c2yFbWTvm6VAsEA=
X-Google-Smtp-Source: AGHT+IGoNHmBEo6OiZmC9ikMO2u2OFawnsHhSspSXpWPT1EwaoDW/0LgfL3fQcSklPOjI+oSKjceQpkCFVOkA2Z9OkQ=
X-Received: by 2002:a05:622a:486:b0:45e:ff67:e058 with SMTP id
 d75a77b69052e-4613c19dd98mr273279091cf.44.1730328679584; Wed, 30 Oct 2024
 15:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm> <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm> <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm> <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r> <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
In-Reply-To: <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 15:51:08 -0700
Message-ID: <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:17=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 10/30/24 22:56, Shakeel Butt wrote:
> > On Wed, Oct 30, 2024 at 10:35:47AM GMT, Joanne Koong wrote:
> >> On Wed, Oct 30, 2024 at 10:27=E2=80=AFAM Bernd Schubert
> >> <bernd.schubert@fastmail.fm> wrote:
> >>>
> >>>
> >>> Hmm, if tmp pages can be compacted, isn't that a problem for splice?
> >>> I.e. I don't understand what the difference between tmp page and
> >>> write-back page for migration.
> >>>
> >>
> >> That's a great question! I have no idea how compaction works for pages
> >> being used in splice. Shakeel, do you know the answer to this?
> >>
> >
> > Sorry for the late response. I still have to go through other unanswere=
d
> > questions but let me answer this one quickly. From the way the tmp page=
s
> > are allocated, it does not seem like they are movable and thus are not
> > target for migration/compaction.
> >
> > The page with the writeback bit set is actually just a user memory page
> > cache which is moveable but due to, at the moment, under writeback it
> > temporarily becomes unmovable to not cause corruption.
>
> Thanks a lot for your quick reply Shakeel! (Actually very fast!).
>
> With that, it confirms what I wrote earlier - removing tmp and ignoring
> fuse writeback pages in migration should not make any difference
> regarding overall system performance. Unless I miss something,
> more on the contrary as additional memory pressure expensive page
> copying is being removed.
>

Thanks for the information Shakeel, and thanks Bernd for bringing up
this point of discussion.

Before I celebrate too prematurely, a few additional questions:

Are tmp pages (eg from folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0)) and
page cache pages allocated from the same memory pool? Or are tmp pages
allocated from a special memory pool that isn't meant to be
compacted/optimized?

If they are allocated from the same memory pool, then it seems like
there's no difference between tmp pages blocking a memory range from
being compacted vs. a page cache page blocking a memory range from
being compacted (by not clearing writeback). But if they are not
allocated from the same pool, then it seems like the page cache page
blocking migration could adversely affect general system performance
in a way that the tmp page doesn't?


Thanks,
Joanne
>
> Thanks,
> Bernd

