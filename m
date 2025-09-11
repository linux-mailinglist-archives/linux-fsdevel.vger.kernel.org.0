Return-Path: <linux-fsdevel+bounces-60958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F06B5378D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA14B1889A35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668434DCC1;
	Thu, 11 Sep 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAcirdMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E734DCDB
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603789; cv=none; b=e2lG7vpfyrcfIaNpO8cOksoF+tbLqfc/YfnkUYJ6Vtjxv7rMcbxSe6yMkefEZBTzVTDepauR5rledGx5rzBR+NjeIyf43nIjAksV+irYMHrhGLLP9/Mqx4RQG+9PrsspCIOu9HDdrscXdI/Ep3C4hMIfzBd4FuUeB5w1yoTS7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603789; c=relaxed/simple;
	bh=a4bwTTm8DDy1QIkTCmgQZy35/P1OSicCOauHAgByEfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCx8GXW3FhgROZ8SiYbqlKP0Ovpr/yDs5GnF26aJxOvYi76xR46MpUe9w6pucL+18N52PpggIpgOoxEz1E7pXJ+kNBcSmDOKMNL//ijSMw8DXuUCCHE/kJneV9o3F+zmI6c18C4MKpV+iyRteNt5WnPiKz7N8fZwRT6mnxnKGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAcirdMh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1122217a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757603786; x=1758208586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wBo822YD+jvyd1+EsiFuVc9oA9ouix4aflKx2NsrPs=;
        b=AAcirdMh/paP8CvnwYN0WRwP/4NlghsmNdDHjiHYsSZrehyr7phxTUNvfxxxMzGgNh
         W/pumbX+m+DF3IUpX0y/CqFw8GzXNkN+mU45BXcxzFJAV1suGvKT9+Av2wIHMte4Fbqr
         fkyM++zQwG/21hMqVPKLgWVzQ1HdXnkxr/zRmqI+NbWV8s4QJiZjLS7OMY/kA9xkpYfh
         UoUFs26Jf4sZOmDuqhLPLzsjU9dwg2Bs3JhZP6pXEKSmsbzufxuIa7AlZCL/ROjutUu4
         YzhnAYHFzLSqSNDlFVAyYxvnjjses8MKw2zW5So/2vpnsSi+ogfx0J2Ukr5fUaQqA0MU
         xbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603786; x=1758208586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wBo822YD+jvyd1+EsiFuVc9oA9ouix4aflKx2NsrPs=;
        b=ERtr2WHNq5fi7oLWMc4/A1LAyhhGiezZumA3M02UOXfJnXViS28LDrKeMN6q7MtICO
         uxyhiszLUF+ePCa5lQec2Q8CoFSSP2maav1HaCSCf38ArTLKp+a7G7HU/62NljVwz5d+
         UPfS+JpWCFIzwBqAgzeQzv/7q2YSRff/FiM8fVFGIHyAmqoOXEXN9E8c+g/ZxgR+yuXH
         VzUdafkQehPMRK9yDj5jBCxR8MUP6ihnGxFEAwnV1vCt2aqKbk0pTmrvRA2KIBtt+jO8
         3DXeuakyaTthu/Fgm3TKTomR2BSEY2CMjK3X1ConOFJohVWBNKhpuimQl0z58aMDZhmj
         t/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV+hILuen5Qee9hwc8VeJ7mjMIJ64s3ELCoZpVvZOlRTuAGzEfp43unqqwSelhfDBN3uaWFqNFDdzVVmYGg@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+FpoRDnpJHL15ukWPNltgFcnn6eiH/bM45PT2e4sTdypRkO0
	PrMSCQeTaM0izB6QFhr6jeeAs96BdC7Hykeitb91WT9YigQrfg1hjh3EicgLod/63yrlmORcxfA
	PpDc95PAZ6aAYYK7pSMhB3mOi98Ka9Cg=
X-Gm-Gg: ASbGnctTNS6ot28neKCBpbO4HrvCjIvKiGHu7vQIfmgA5TYih0rcW12qF0MEHlTRH5H
	2JpxtbVSgEuoree+e0hPUfaOg5rJc9t7qxY9JPFyjMvhZ/mj4I2QS52M6jOqCdgLTCIEGnAFMVs
	A8Ho1UfEPXqg3mnMFHupCjLPkK1ow/RnOqQ9e7/ce/H1XiE9HEaMwL+GSvT+UO8CtOwiYfZMzyF
	M9KL21AvLAfEiGO3g==
X-Google-Smtp-Source: AGHT+IEWJHProfqe9MkMrApe0nu8Lni7uWBd5hMokDX8mM8AOlkDsbauNr0xucI3RgQ39BL1u0WyoFXJ+HknrvtHBLw=
X-Received: by 2002:a05:6402:2343:b0:61e:ca25:3502 with SMTP id
 4fb4d7f45d1cf-623771096b8mr18353367a12.17.1757603785655; Thu, 11 Sep 2025
 08:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
 <20250910214927.480316-11-tahbertschinger@gmail.com> <aMLAkwL42TGw0-n6@infradead.org>
 <CAOQ4uxiKXq-YHfYy_LPt31KBVwWXc62+2CNqepBxhWrHcYxgnQ@mail.gmail.com> <DCQ2J75IZ9GN.29DY2W9SV3JPU@gmail.com>
In-Reply-To: <DCQ2J75IZ9GN.29DY2W9SV3JPU@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 17:16:14 +0200
X-Gm-Features: Ac12FXwWObOdteDLG_KWCcYb5SJCTz6npELP39lbmWonT28sMQmBU7w0_t-zMqY
Message-ID: <CAOQ4uxiQL9m2fBW6HhRkcsw=uBcU_YZT6Bs1KWw+Zppokar66Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] xfs: add support for non-blocking fh_to_dentry()
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 5:10=E2=80=AFPM Thomas Bertschinger
<tahbertschinger@gmail.com> wrote:
>
> On Thu Sep 11, 2025 at 6:39 AM MDT, Amir Goldstein wrote:
> > On Thu, Sep 11, 2025 at 2:29=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> >>
> >> On Wed, Sep 10, 2025 at 03:49:27PM -0600, Thomas Bertschinger wrote:
> >> > This is to support using open_by_handle_at(2) via io_uring. It is us=
eful
> >> > for io_uring to request that opening a file via handle be completed
> >> > using only cached data, or fail with -EAGAIN if that is not possible=
.
> >> >
> >> > The signature of xfs_nfs_get_inode() is extended with a new flags
> >> > argument that allows callers to specify XFS_IGET_INCORE.
> >> >
> >> > That flag is set when the VFS passes the FILEID_CACHED flag via the
> >> > fileid_type argument.
> >>
> >> Please post the entire series to all list.  No one has any idea what y=
our
> >> magic new flag does without seeing all the patches.
> >>
> >
> > Might as well re-post your entire v2 patches with v2 subjects and
> > cc xfs list.
> >
> > Thanks,
> > Amir.
>
>
> Thanks for the advice, sorry for messing up the procedure...
>
> Since there are a few quick fixups I can make, I may go straight to
> sending v3 with the correct subject and cc. Any reason for me to not do
> that -- is it preferable to resend v2 right away with no changes?

No worries. v3 is fine.
But maybe give it a day or two for other people to comment on v2
before posting v3. Some people may even be mid review of v2
and that can be a bit annoying to get v3 while in the middle of review of v=
2.

Thanks,
Amir.

