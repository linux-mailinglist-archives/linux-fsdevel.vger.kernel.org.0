Return-Path: <linux-fsdevel+bounces-34273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116C9C43FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269EA282DA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4E1AAE06;
	Mon, 11 Nov 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3gwQZAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56654728
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347062; cv=none; b=RPvlTKIumYtYyN74T//fMI/ngZX0N5h05FXPtDvWSNuIh3vKNepKmzzH4kQ4HXQwdlJBgOp5cBNWHNjJFa8/puGpyJ7dejYPn6vdMkmAfcPFAx0Y/+GONGa3zKF6oRTRlWht1oh6cryE5rhaXdKar1JQ0LFr/pmvtWMVKvib9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347062; c=relaxed/simple;
	bh=r/a8t1Kh72OUrs0ilo9tZXDEQ6hOyoBhTrEehsFfjBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHcgdRnsCWKPwswLclxQ31ERgSto3og960FcEsoCBzSg27czkQEmrfrU/vGI9nT/53HJKZndug9fhJyOjBmWEiuC8TugbwgWvGaZBiDShGa09sqhVfP9TQ95xqmmlZJxdFGboK8u4UE81Wm58WeesNWBSG3TJW7R9zTw2pNhDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3gwQZAT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608e389407so62877501cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 09:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731347060; x=1731951860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/a8t1Kh72OUrs0ilo9tZXDEQ6hOyoBhTrEehsFfjBQ=;
        b=F3gwQZATHkAVPkIolJ2ROy5sugLO/BJGNqkPk0OZb1OM9OUVIVbPI9pNDptNwKc0kC
         jjv0mv80U4e0Fu6CMn864sViY8ThVjqRxxXMqSrs4Sl3eQKFg/pTLWPGXmLQEt0/pRYY
         5bvT+lBbRH5GYkmMZknmx/SKPXOyGntZ8Kg95eJ2V8ntR6kmugbcEY7jE7k4ujR9Nb4H
         uDSAZ03wCwM8h82/ImYxDL9XYuaSPGGHRVbaC1MpbuA+DlnzjUcEtn/lT3UYSd/tVaNI
         8ssyMaNfzrG6cOdE0/RbfX6OBEMUQ1g7K565qo2KFn7p6zVn3TAhfBs3ibrI0qyyAxJ4
         1u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347060; x=1731951860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/a8t1Kh72OUrs0ilo9tZXDEQ6hOyoBhTrEehsFfjBQ=;
        b=N7jBVjDybhQkyKGuq55FRJwRSkOJI8/56NJkTtcul6+pUboj/g7B8+07tUlyJGY8bw
         ca976T9iwQYsZeoMfIB6Mmvwf6MJYsn5vchMisjYx8ufZ9xxPlOsJKEH+N727hbR3SnD
         iGU1bYhM6qm9D3J8dBfHYZFJ50ZEhZ4X4JMahL3mdUsiM/wWqHzmgrblFYbbsKXzgX11
         TKmuNI0R3SUAijrjgf0JYVfEfZajTJzFbE3pnzWFad4xcY8NMgV7SRKAMBmNkcMi3mra
         2DJzMYGC9D8ga7V6yzSgJF8/cJCVJnK52k6Lh2yxJHg7XF5Mhb1TEFnAe942bRI1rxnP
         mm1w==
X-Forwarded-Encrypted: i=1; AJvYcCVekU2Cf1AzUHEEhcwcTHlZ/igzy4laK7k6v4zuSLNyGOAasChy55k2Q1FkXMY4o40GNXc/5WokuhQ5kbYt@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQioWjRLswQCHeubc+k3+h2QqQnJn68mLlV+fmL08/gUlwirH
	iUs8ZuLN8q/LnemNTc/IiJBJyCCYsYKL6649UJsNBbwR2+6VzKlyAQGITLNwSmqaEiYHqaHdnSx
	CIo1PNAN8RM/nBZAiBCvMGvrXLc4=
X-Google-Smtp-Source: AGHT+IGLG2faT2dCTk1+vEoaGt6yfvBsgMUClNKwp6OakXC5maPzXmNTGaI606PVJTX4wY8Wmsq+XmYiszYVxjVpCQY=
X-Received: by 2002:a05:622a:c1:b0:460:a633:8d2b with SMTP id
 d75a77b69052e-46309331d43mr176978481cf.19.1731347059813; Mon, 11 Nov 2024
 09:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com> <9f8310d3-882f-4710-ad48-9a7b96fd6bf7@fastmail.fm>
In-Reply-To: <9f8310d3-882f-4710-ad48-9a7b96fd6bf7@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 11 Nov 2024 09:44:09 -0800
Message-ID: <CAJnrk1atz8xDB6Nwwd0XtJ6spFMVuCjki_GVzbpkoWTZygSg7g@mail.gmail.com>
Subject: Re: [PATCH 00/12] fuse: support large folios
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:32=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> thanks a lot for working on this!
>
> On 11/9/24 01:22, Joanne Koong wrote:
> > On Fri, Nov 8, 2024 at 4:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >>
> >> This patchset adds support for folios larger than one page size in FUS=
E.
> >>
> >> This patchset is rebased on top of the (unmerged) patchset that remove=
s temp
> >> folios in writeback [1]. (There is also a version of this patchset tha=
t is
> >> independent from that change, but that version has two additional patc=
hes
> >> needed to account for temp folios and temp folio copying, which may re=
quire
> >> some debate to get the API right for as these two patches add generic
> >> (non-FUSE) helpers. For simplicity's sake for now, I sent out this pat=
chset
> >> version rebased on top of the patchset that removes temp pages)
> >>
> >> This patchset was tested by running it through fstests on passthrough_=
hp.
> >
> > Will be updating this thread with some fio benchmark results early next=
 week.
>
> I will try to find some time over the weekend to improve this patch
>
> https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc98=
99c4f7f8c69f31cbff9
>
> It basically should give you the fuse interface speed, without being IO b=
ound.

Thank you, Bernd! I will use your current patch in the meantime to get
some preliminary numbers.

>
>
>
> Best,
> Bernd

