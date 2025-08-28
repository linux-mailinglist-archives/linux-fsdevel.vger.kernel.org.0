Return-Path: <linux-fsdevel+bounces-59508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A5B3A4F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173FF7A8A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362A2522B6;
	Thu, 28 Aug 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACNdUl/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EED23D2BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396343; cv=none; b=fUd+4TEryIb5dXxskzp2DyUqFmBFvtc8beEKrG5FflMcfKHvU6y1WTpZWsyG/P3fwjSttOEWfhVnUXaPoZoGonqaMRbopy5v0G+UQvp2IghwhGLEinoxw9oP1j7UAmetL4oOLli5/xfCepF1x2UGujIdq58zkXt23YWdeI0y8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396343; c=relaxed/simple;
	bh=eNoQb1H6nyxWeqxC96ErbbXSWJqwMZSZepE1g+5N4RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0sSTjRSoIL8tpt44eekgkNyuEBXoOrZp7Q4/P+xIfYbKL8WPMpKRKYr7KPibXPtL3cG9LtTBF6qwjo+XygGI7yLn0pu1EYIDxJD6hUcBBQBBQwJmvzCpa9wqEiNcGFo4l8RngJPNG26R8iNlFzwRtTpyIaY3r++zLo+TEz91aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACNdUl/A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2f0660a7bso10685341cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756396340; x=1757001140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcc9GJyQEvPaHcOzd3uEwvVTb3dNUrQksOu4oVthjig=;
        b=ACNdUl/AFU88EDOf0+kgAi4FyTk1AwhE91Z12zDkL5rqOyTBZq9COAHmLQBFJ8YvWe
         xep7fIYdcdBgT9BY/Spje40TDRrENrg/ygQLaJYptFmDiZmcp1lp6mPn7Uwn+HQ625vb
         0kCW2jdx8kUBdbq+Vgw+TiO9iLmLanUIuojc7fzkPdsvvMY+KobxuXfqI+w0/37+nfzn
         mMjjvBkzE1VUqZIOKZb8PlklfNbXSMzXLf2r+X9ZQjhGizjD+6h7S1ruv1opLCOtqvl6
         10WC+KNGNH9NVtMewgP/8xRvrPmmNgTPYr4R934DjlsJGRyRE0XBXY5p4xQP5BJ2Ng3C
         iEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756396340; x=1757001140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcc9GJyQEvPaHcOzd3uEwvVTb3dNUrQksOu4oVthjig=;
        b=XsCjo9NoZCFGhrR8v0ON1oLlCXnKMpmlIV3t6YNUwiTtF5bMAE7wfox+rX3eraKB9w
         wK48pTi59Sg3pL9JcDLWdVshWkY/ogWOcH2zKn2JyvtTTIgm0w6hcfIxiUqcPnG8Zu/t
         YoZpCuqXFuzP0tpLYPqjVsIdJni4WlqO+TzpyKhN4IzPEtvnRjuVKOCd8DZece2MUk85
         e3lig4AZJpVoe0nZXzJDUnfPV1bgYRJyHxV/oR2wvndFsomtCJFF2idqC/ydlj8QtLXN
         zJZUw7s5Id+S3L/xl5zNhalulXs0iGLKXF0z1XHcletCfumQdg6mrrdbKTjBAJzFaAfA
         lRIA==
X-Forwarded-Encrypted: i=1; AJvYcCWFF5fEutCCI9qm9y9v7LY1LsZvo6sCqMIs3jYcoLWZHes5Cvbgnip4WG8Le7rDSzEXZyK/6LRycdAUHNHK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3luJIcOkOgjGvsqpT3WzyzK+eFDt92qprcxRIirNzBOWhLjsd
	4V0dRf1Q5ulYurfXIipwPCFvgCv4RS4rWAbUg+L+EY4slZY2Anz1REku8sxVi7XmahxgSzI5nL0
	YLSrRZ5BjDR9iFPfFAkLtKIHsCNTrHZgmvjjrq6U=
X-Gm-Gg: ASbGncsisMePiFXw67p0ahwjpRpgJU3yhcNdGa/B15bo6SFIZdIKLxGSxFmAmQHLinI
	uTD2DgCwwMsVfFMdvLGmaLPlqqYomfOIYnyyJHAW/pivezyhzmel3ONZ5uaTkaLK8PJi/LTAWup
	rl0QsQoeTWyvKMuIffUW/97dKXte2HJkNpDSjC3Z3LIN7ojqm1ZoPs5QyV5Fd3CmEmkcZ8441a3
	E05mMdZ
X-Google-Smtp-Source: AGHT+IHXFZB5Vh7oR9Qu9BeeElPTY6kE4+VIXXMYYDWKIh5gCaKP6i+lJKX+IcGyo3xmF1NWQm8R7HeFQ/hHdLWJuMk=
X-Received: by 2002:a05:622a:60c:b0:4b3:9e9:acdd with SMTP id
 d75a77b69052e-4b309e9ae3fmr6266981cf.82.1756396340123; Thu, 28 Aug 2025
 08:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs> <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
 <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>
 <20250827191238.GC8117@frogsfrogsfrogs> <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>
 <20250828150141.GG8117@frogsfrogsfrogs>
In-Reply-To: <20250828150141.GG8117@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 28 Aug 2025 08:52:08 -0700
X-Gm-Features: Ac12FXxroxCfelBkTNQuaA0BkfslfGKxRTSJpWjbK___qdrW5rRqzol4W9eQDuE
Message-ID: <CAJnrk1YfAsnJmCPEifMJOO51XdWwVeo_gDsRbpFPsSpqw+3jOg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, synarete@gmail.com, 
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:01=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Aug 28, 2025 at 04:08:19PM +0200, Miklos Szeredi wrote:
> > On Wed, 27 Aug 2025 at 21:12, Darrick J. Wong <djwong@kernel.org> wrote=
:
> >
> > > Well sync() will poke all the fuse filesystems, right?
> >
> > Only those with writeback_cache enabled.  But yeah, apparently this
> > was overlooked when dealing with "don't allow DoS-ing sync(2)".
> >
> > Can't see a good way out of this.
>
> I wonder, is it possible to shift a fuse_simple_request to behave like a
> fuse_simple_background request?  For certain DOS-happy requests, one
> could use wait_event_interruptible_timeout(&req->waitq...) with a really
> high timeout.
>
> If the wait times out, we shift the completion to asynchronous and
> return -ETIMEDOUT to the (blocked) caller.  That would allow the system
> to make progress though you'd probably have to take some drastic action
> if the fuse server sends back a failure (e.g. setting FUSE_I_BAD).
>
> (The problem with timeouts is that I tried setting a 60s timeout on
> fuse2fs and discovered that certain horrid fstests actually create
> monster files that take 45min to FUSE_RELEASE and so I don't know what a
> reasonable timeout is...)

Why not just send the setattr request in fuse_write_inode() as a
background request instead of first sending it synchronously with a
timeout? for the sync() case, the only DoS path is (as Miklos pointed
out to me in his earlier comment) the sync_inodes_one_sb() ->
fuse_write_inode(). But the only thing fuse_write_inode() does is call
fuse_flush_times() to send the inode i_mtime to the server.  Is this
i_mtime info even that important? It seems fine to me to have that
relayed always as a background request.


Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Miklos

