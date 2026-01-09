Return-Path: <linux-fsdevel+bounces-73091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94215D0C1F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2891E3014D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63F364E97;
	Fri,  9 Jan 2026 19:55:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664E2E229F;
	Fri,  9 Jan 2026 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988512; cv=none; b=pZ6rTWs4htJwPezMf9eT7SrnfQZSyC2nltxi+ssIcyNeJuZXi6/++ubUiRQWPM1qGIqla+0Qhgj4ZJ5IjCQ0CkbPAmAsxd7Lbng9UcdeWVXv0lHe/6cNTMryQfU8rF1QljsgVe3TTuFC7+fBxF5pB3+NWDSK+YIzpU8x4JEH7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988512; c=relaxed/simple;
	bh=ygVqFmIlB6ZQuTW56hXZOjKyuZieIzxsv+VZWebUEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+pFFZ0McFnxEGAEgB0hibJfbzuYcxJaIIKr1epJOyLkGjGyQFUdSFaeMxmhxNkFQXJ6yl4uBCgiCVcdZf+xKr4/7K+m7knch2ysDj5G31bFKz5iJf4Gp8bk8d4y3ZXLBj6vUK2b4m0TxGi5JeCJvtekxdWJL+DK9ZO+Q4MGFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 9B569E0434;
	Fri,  9 Jan 2026 20:55:07 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 9 Jan 2026 20:55:06 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aWFcmSNLq9XM8KjW@fedora>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>

On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
> On 1/9/26 19:29, Amir Goldstein wrote:
> > On Fri, Jan 9, 2026 at 4:56 PM Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >>
> >>
> >> On 1/9/26 16:37, Miklos Szeredi wrote:
> >>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
> >>>
> >>>> What about FUSE_CREATE? FUSE_TMPFILE?
> >>>
> >>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
> >>>
> >>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
> >>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
> >>>
> > 
> > I thought that the idea of FUSE_CREATE is that it is atomic_open()
> > is it not?
> > If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
> > it won't be atomic on the server, would it?
> 
> Horst just posted the libfuse PR for compounds
> https://github.com/libfuse/libfuse/pull/1418
> 
> You can make it atomic on the libfuse side with the compound
> implementation. I.e. you have the option leave it to libfuse to handle
> compound by compound as individual requests, or you handle the compound
> yourself as one request.
> 
> I think we need to create an example with self handling of the compound,
> even if it is just to ensure that we didn't miss anything in design.

I actually do have an example that would be suitable.
I could implement the LOOKUP+CREATE as a pseudo atomic operation in passthrough_hp.

> 
> 
> Thanks,
> Bernd

Cheers,
Horst

