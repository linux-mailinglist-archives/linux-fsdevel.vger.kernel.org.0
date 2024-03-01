Return-Path: <linux-fsdevel+bounces-13269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077686E170
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC2B22938
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964F3DBB7;
	Fri,  1 Mar 2024 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCE+Xj+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C520B3E;
	Fri,  1 Mar 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298062; cv=none; b=UGtiwdNl1/DOP4/odJLRh5pR2TAiaoewfl21eHs9xL9Comg760Bh/PmY1SqTomnQUKs2We/Ny+BsyfqfidHouaG0BDYdBUD9kgc3DLdDSznO9KYeWJU3kackS2GvANNJRKCeXrMZySAxouh7dU8zl4Q/GdHUDPfGGTLDo56X03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298062; c=relaxed/simple;
	bh=uVfFW2XHjpHoR39usIXqd7I1dGvGGpVBxuCl102/2WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bd6CBvbAySxE0Y1CxQ+AQYbBL4GSFujEZpRMRw31J9hTqnIzZP3Lm08UGAth6jcZloiycdMYj6c6SOW1J24LL9Qf47h59K0YhKqw+bD1hM+T7UbnqSeb2Tx4a5MXHWevpLOmxk5L+l/qJ0jY4wGL2eNxuM/TtMHqN7lA8jgvPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCE+Xj+P; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f748cdc8bso7914326d6.1;
        Fri, 01 Mar 2024 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709298060; x=1709902860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQbRMkud0ngrhcazz2OgtLEB0PtLOR5FrU8q1FDLq5M=;
        b=CCE+Xj+P+XRVKlZo0RDCxpi6+bWizHkaHduDLq5v39dC6f3sBLJU8wGWZerCFHAuqi
         M/t42IKwc7iKPS5DmWh6JY45pJJECLo26w/+D9Gps9JMhzz/Qykh4gQQSBSFf3TdTcRi
         t+3xdzmXl43pEzyebjaIAvZiUIyzj80T1tWk88pQsdlQYXCCtzgOceeNtsuwCnxVbMfL
         NtcvSDXEerEjfuVEaBpObX5zuShKPJdyXlN1giYgdwD3GXpqzwzJcRvEIpk2VvGAIsRZ
         XxwzT3aw9mO3MqhBQ6LxsGzjtIOjP7e26DVrp4LS2N/a4lKnrZ6t9Ob9TQbbSArrfcrZ
         b7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298060; x=1709902860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQbRMkud0ngrhcazz2OgtLEB0PtLOR5FrU8q1FDLq5M=;
        b=AHkpbL3BCOrwcjxdBAJZ6faA2UbLuw9vkyVXBnR+h7LI6nPOFNH0ut0LblWDfoh24T
         u9/k40XXjls50gh+Aw5KeiTZ4StYPhIfMmhwElyhBrFmloL+/u3g9Scdfzam/DU1HjJr
         52ts329TGXBMt577Qs8Ts1O1YbRYXMUf5o6yB66L6xclyixnRNPoNoq8eOypsiZTSOBI
         NQCl69Xx1IIZlHUoyypWs3b4CV0Rt5LMA8R1QVvw1VmdUn9BXXaHrJV5NWgXWn/up+fx
         NndXX/5YjJyefkwXEIEG4gmiNy/yE8b+6Qjyd1fI5Prjul7RFS7+Z4jBWv/D3/q4sfiK
         Jp+g==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZeNpHbGYl0S+TBVqTd/ZeYbWLK8hfr0vF1Y+MqPV9f7L9gXC+xtUELMXM7MzDUv9xihCecPAKiTHDWFhWimh2rsFeHdbpe2X
X-Gm-Message-State: AOJu0YzsYoT7sNpXelkHrfNznJ0IIDjFOjm9CpDxe6ZP5Vt5QMfQWXuy
	+FWG+hDerDgt7CVLEI+ulOxLp9wa+nEh9VvMA3VfH4nim76bEknCxr+akEQEIKxDAOBpGwsaNyw
	0M37nyFXT6lB5NPaYQm8jCcYfd6I=
X-Google-Smtp-Source: AGHT+IHou6/SevcDlKoOp6ptIqFWEUA4GLAdj61km9qBinzv3SQQOQzqWNcS5QkPMoQEoQmZTEJjBIUJQYsGXkps56U=
X-Received: by 2002:a05:6214:11b1:b0:68f:ea3f:240f with SMTP id
 u17-20020a05621411b100b0068fea3f240fmr1692892qvv.5.1709298059863; Fri, 01 Mar
 2024 05:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <20240227174649.GL6184@frogsfrogsfrogs> <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
 <20240229232724.GD1927156@frogsfrogsfrogs>
In-Reply-To: <20240229232724.GD1927156@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 1 Mar 2024 15:00:48 +0200
Message-ID: <CAOQ4uxgKE+2YYo+ikKd_W=mYf1_Y575=9u6S_PaNTwdDupG_Vg@mail.gmail.com>
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data opaque
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:27=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Feb 27, 2024 at 08:52:58PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 7:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > To head off bikeshedding about the fields in xfs_commit_range, let's
> > > make it an opaque u64 array and require the userspace program to call
> > > a third ioctl to sample the freshness data for us.  If we ever conver=
ge
> > > on a definition for i_version then we can use that; for now we'll jus=
t
> > > use mtime/ctime like the old swapext ioctl.
> >
> > This addresses my concerns about using mtime/ctime.
>
> Oh good! :)
>
> > I have to say, Darrick, that I think that referring to this concern as
> > bikeshedding is not being honest.
> >
> > I do hate nit picking reviews and I do hate "maybe also fix the world"
> > review comments, but I think the question about using mtime/ctime in
> > this new API was not out of place
>
> I agree, your question about mtime/ctime:
>
> "Maybe a stupid question, but under which circumstances would mtime
> change and ctime not change? Why are both needed?"
>
> was a very good question.  But perhaps that statement referred to the
> other part of that thread.
>
> >                                   and I think that making the freshness
> > data opaque is better for everyone in the long run and hopefully, this =
will
> > help you move to the things you care about faster.
>
> I wish you'd suggested an opaque blob that the fs can lay out however it
> wants instead of suggesting specifically the change cookie.  I'm very
> much ok with an opaque freshness blob that allows future flexibility in
> how we define the blob's contents.
>

I wish I had thought of it myself - it is a good idea - just did not
occur to me.
Using the language of i_changecounter, that is "the current xfs implementat=
ion
of i_version", I still think that using it as the content of the
opaque freshness blob
makes more sense than mtime+ctime, but it is none of my concern what
you decide to fill in the freshness blob for the first version.

I was not aware of the way xfs_fsr is currently using mtime+ctime when
I replied and I am not sure if and how it is relevant to the new API.

> I was however very upset about the Jeff's suggestion of using i_version.
> I apologize for using all caps in that reply, and snarling about it in
> the commit message here.  The final version of this patch will not have
> that.
>
> That said, I don't think it is at all helpful to suggest using a file
> attribute whose behavior is as yet unresolved.  Multigrain timestamps
> were a clever idea, regrettably reverted.  As far as I could tell when I
> wrote my reply, neither had NFS implemented a better behavior and
> quietly merged it; nor have Jeff and Dave produced any sort of candidate
> patchset to fix all the resulting issues in XFS.
>
> Reading "I realize that STATX_CHANGE_COOKIE is currently kernel
> internal" made me think "OH $deity, they wants me to do that work
> too???"
>
> A better way to have woreded that might've been "How about switching
> this to a fs-determined structure so that we can switch the freshness
> check to i_version when that's fully working on XFS?"
>

Yeh, I should have chosen my words more carefully.
I was perfectly aware of your lack of interest in doing extra work
and wasn't trying to request any.

> The problem I have with reading patch review emails is that I can't
> easily tell whether an author's suggestion is being made in a casual
> offhand manner?  Or if it reflects something they feel strongly needs
> change before merging.
>

Can't speak for everyone else, but coming from the middle east,
I have fewer politeness filters.
When I write "wouldn't it be better to use change_cookie?"
I am just asking that question.

When I am asking something to be changed before merge,
I try to be much more explicit about it and this is what I expect
others to do when reviewing my patches.

Thanks,
Amir.

