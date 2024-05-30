Return-Path: <linux-fsdevel+bounces-20507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA48D46FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED54AB23AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1614D45A;
	Thu, 30 May 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h4IQ0fk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E214B967
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057556; cv=none; b=ckpowRsgGixjZ8rNbC4t+NUWbAI1LK/EvFiFiS2jsg5LWY+tifAwrH+gHjWybSeMA1r0E4NVjbunngBAh3TC4t1n5pX+T3BLjszVUYmXtqMZ3oMNjDWtkqN2eKXhBWERfdNDiKpTSshdreIkkHsz+lTxIt2EOlmSHh09qqVle1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057556; c=relaxed/simple;
	bh=Mh+aQDHzYgLaU+Il1QYQyK3zbaYC3IDaUh6LhiP0mKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA4LQEpWgr7xQMoBlX37L1dy1Df/16vmJbypOYdRGtDO4h+XmEn8T4kEP2Oc5WmZaCGNPs6ya2OdhZmuEeqtn7gg68xWimDZ5xQI/ejjyjzna27E+ziBpilPmlAnCkDEZjrhpOnAk/TSmr7zu9HH7QnfMhjcLZoFCabYhr768Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h4IQ0fk7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a653972487fso30700666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717057551; x=1717662351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzVFVVzRu2A8BuocCgv4mvFhjQF5B5aQV6bx9DrZsKk=;
        b=h4IQ0fk71XLY1LRrlTCE9JsHrhbDtVnLXq4Iox8Ism8QesQeVEn47OnnAb+Uq8F/WV
         Rgvyn81+BYmAH8Qh6MtsfG1byLDZQJ792ETR/Vxy6S7PHtS2WIJWFO9qQIMxDB30NIGV
         ii7WrCOkr627qrv63AOCy7kZ1tA3s6lSzg6Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057551; x=1717662351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzVFVVzRu2A8BuocCgv4mvFhjQF5B5aQV6bx9DrZsKk=;
        b=Hlca2Q4+FdO405j2pBkqasLcLBwnHh81e1Nb6KoY0fZb0YaSST5CR9vcOBX+XhLZxe
         wFfRBSZwcRbhGtX99J/ygvbiO3wbOjK+R/Cat7KbcYvdQCROp920qdWvjpdCjLiWl0CF
         t6CHlDE2mcoxKM3nrV74WmD50fqGZ7rP9QJeCaItOfiyB0OE9DDRnTPoUmbFpjlVyRFy
         MIhw7/8ljZo7qwtvnr8/OqYiU86/j23HzF968pFzsNTMvLewWaEv9ydZOK0uTFUne7B+
         yTjf5P6SKw5Qs7OQhGJzHAt1IY5hporO2lh4XUcOPP2jsj1UwgmZwEYXNumHJe4mafGl
         7Rmg==
X-Forwarded-Encrypted: i=1; AJvYcCUUqc5M6HxXeaYE4JOmTBR/qUZ2P5EnghBYtf5IDTl3ykEogDi1/psLOlFFF470s41Szmf+DRiHWi1UWPnGv3bKQqOP/M2R6X1JQeNyPg==
X-Gm-Message-State: AOJu0YxmMi7pUaljUP63fPAdgL0yDmgLX+sqRG2WtAIvYbuNROyT6tsN
	pCDe5j93jGshH458GeNNdObT2MY7gpHyypoi8nrQR0ElyppbcdH7b5d5sLE5HmXd8QCWFIUUjEC
	MdcNLMMe6x0W8S6CGoky4Dj25PaDS4UC3DTFXeQ==
X-Google-Smtp-Source: AGHT+IGTvAY/5EuKWYcdbe5yLKL7KjM49nxRJdoR5opaEOCu0cOeIqfcg1haeH6tSTBQCPY3eeszBLLP8Bnf1fbRvu0=
X-Received: by 2002:a17:906:4906:b0:a59:9e01:e788 with SMTP id
 a640c23a62f3a-a65e8f74b7dmr83473566b.34.1717057551310; Thu, 30 May 2024
 01:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11382958.Mp67QZiUf9@tjmaciei-mobl5> <20240530-hygiene-einkalkulieren-c190143e41d9@brauner>
In-Reply-To: <20240530-hygiene-einkalkulieren-c190143e41d9@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 May 2024 10:25:39 +0200
Message-ID: <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>
Subject: Re: statmount: requesting more information: statfs, devname, label
To: Christian Brauner <brauner@kernel.org>
Cc: Thiago Macieira <thiago.macieira@intel.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 09:16, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, May 29, 2024 at 03:36:39PM -0300, Thiago Macieira wrote:

> > First, the information provided by statfs(), which is the workaround. It's
> > easy to call statfs() with the returned mount point path, though that causes a
> > minor race.

It's easy enough to shove struct statfs fields into struct statmount.
I didn't do that for the first version to minimise the size of the
patch but I think it makes sense.  Even Linus suggested that this
syscall should be an extended statfs(2), which implies that statfs
info should be included.

> > The second is the filesystem label. The workaround for this is opening the
> > mount point and issuing ioctl(FS_IOC_GETFSLABEL), but that again introduces a
> > minor race and also requires that the ability to open() the path in question.
> > The second fallback to that is to scan /dev/disks/by-label, which is populated
> > by udev/udisks/systemd.

FS_IOC_GETFSLABEL seems to be implemented only by a handful of
filesystems.   I don't really undestand how this label thing works...

> I think that mnt_devname makes sense!
> I don't like the other additions because they further blur the
> distinction between mount and filesystem information.

mnt_devname is exactly that: filesystem information (don't let it fool
you that it's in struct mount, that's just an historical accident).
It's just a special option that customarily refers to a device path,
but in general is very much filesystem specific.

I don't think we've promised that statmount(2) will only return mount
information.  In fact it does already return a fair amount of
filesystem info as well.  Note, stat/statx also return various bits
and pieces, some inode some mount and some fs specific.

I'd put fs options in there too, but that was something Christian
disliked.  We should have a discussion about how to retrieve options,
and maybe the other things like label, devname, etc will fall out of
that too.

Thanks,
Miklos

