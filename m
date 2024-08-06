Return-Path: <linux-fsdevel+bounces-25188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6423949A87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D62283234
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49E16CD3A;
	Tue,  6 Aug 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="s3Y+JNoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC516B3BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981151; cv=none; b=LrFWHWzLIpxHuD2Os3aCc62PuWYrveMq4H4X5u6ZLbqBn4glW59wSe7XRvJ2K/rm4OtJXse9g8TWfkJFu0XNpUFws3r+PDbqvegJYV+8mGVTb/3urXD6h9r/eDNBNKWrM1GjBOQzv5bI7Vkxwd8TgHShmdZvOX6vtosEw8Us/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981151; c=relaxed/simple;
	bh=qV8Pt10BMkuOtNtK60B4JKISOTmz8NKmHPC0RLGb0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo8LlFaZ7/PKoGJlJrtYpTi3rhdmWuOUAOQRbzTuK/XcCsSwYSex6NFb8DpCgO/Y4KxtmTyQtdaQ4y1peRKQ6oZhOBd0B5CQ7gu+mZW1ozidbX6rLG6PPxFKvn+Vctx6FTdiMAAPKf69PpDyIXBIgChkLKNHB1F9ikEDqNecAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=s3Y+JNoD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc569440e1so11343985ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722981149; x=1723585949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqDrhWURH7vgC9EgKdY3Lu9ZKE+qUroVQsEw+kteL7Q=;
        b=s3Y+JNoDaVly2XkoR4uYD1gvIIMH/3XyZuZM3pPdoGe6R9e8vnuHLg5pDby0Rojdw0
         TTqHYUfqvS3jP5E+WRup46Asr4rzIR5crlFO311HigLJT2tXgSELxTQpHXJVB5Tb0iX1
         gEZ2wh3WWsot1YbJEhUnL+ccCmSGk2cPTbrg07vGYUiOHcFJbJPJrUV1bJJbouMjyhzB
         1bRE3UVHgWllUiSoRxGhV4rbz1S0ydJEihuewRwSzibUXmrZfBYWqRxlzzcdcwP87FHe
         fBTwISfjDEZcntkfK+eOt6mozSabZk3ZjaDQj7KG6G6dG1OX+wURABZj83EZ6+cNB+T9
         m1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981149; x=1723585949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqDrhWURH7vgC9EgKdY3Lu9ZKE+qUroVQsEw+kteL7Q=;
        b=qEPODlJOAwgFFOUIJdLt8tXs2m2xbS+LIxUx2SE0z92h7Idi5dZeKmq1EC8Z7YwcuJ
         +Et5CtbmAqQ/2ts+FYuEE8g14tzZzTYRpznrWJL0qrY07DSWTGxZ0LwopW1m8lGVWrro
         MlswmTpuj4KY7iuAxm0TExcTQI4AqVEjy+sBOmwZodQLBKIz2ebUqCXMBf0phQDniSnV
         lw7f4pZXKbKjBDhOJXBbJZ/+HDxhMYYkHYZJhcHpMOBsK97cDXABOz05F97wmezyrwME
         1qv0+KpmsoHcDxpR40qzZi03dEYoujmv4EiX8gzd8s1WvDbDluGuzMcmA/H0sustpu6/
         +3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFGhzmurArQNkxfoBj8onPc4XdCmBUypLFaKdZqz9BsVRRM+Z1bDnJD0rwk6a0oIZfuAiZAq4UQT+so670+VoARISDCo8SCWGOYP92xg==
X-Gm-Message-State: AOJu0Yz4rJc8HRUKJLOupwkGwYFkZhycGmZ+nxmvpmOHaX8bl17ICUZD
	2LYwE4zxYhXB4NMPEFD+ZsRgN/lO6jO1ba38VmuNl1k6WgobqshgJ1i2ll9Rqgo=
X-Google-Smtp-Source: AGHT+IG85IbNeariTMKfQ4JkEPs5HQ0HBX3Ty2+OFAFSryHFA97CvhKepHhFgkUsOYGM4mRrAr1ALw==
X-Received: by 2002:a17:902:d4c2:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1ff5722debemr213616545ad.3.1722981148850;
        Tue, 06 Aug 2024 14:52:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ec5sm92382175ad.20.2024.08.06.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:52:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbS6U-007pIv-0D;
	Wed, 07 Aug 2024 07:52:26 +1000
Date: Wed, 7 Aug 2024 07:52:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <ZrKbGuKFsZsqnrfg@dread.disaster.area>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
 <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
 <20240806132432.jtdlv5trklgxwez4@quack3>
 <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>

On Tue, Aug 06, 2024 at 10:05:50PM +0800, Yafang Shao wrote:
> On Tue, Aug 6, 2024 at 9:24 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > > Its guarantee is clear:
> > >
> > >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> > >   : Atomic means that all the bytes from a single operation that started
> > >   : out together end up together, without interleaving from other I/O
> > >   : operations.
> >
> > Oh, I understand why XFS does locking this way and I'm well aware this is
> > a requirement in POSIX. However, as you have experienced, it has a
> > significant performance cost for certain workloads (at least with simple
> > locking protocol we have now) and history shows users rather want the extra
> > performance at the cost of being a bit more careful in userspace. So I
> > don't see any filesystem switching to XFS behavior until we have a
> > performant range locking primitive.
> >
> > > What this flag does is avoid waiting for this type of lock if it
> > > exists. Maybe we should consider a more descriptive name like
> > > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
> > > challenging.
> >
> > Aha, OK. So you want the flag to mean "I don't care about POSIX read-write
> > exclusion". I'm still not convinced the flag is a great idea but
> > RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the flag.
> 
> That's better. Should we proceed with implementing this new flag? It
> provides users with an option to avoid this type of issue.

No. If we are going to add a flag like that, the fix to XFS isn't to
use IOCB_NOWAIT on reads, it's to use shared locking for buffered
writes just like we do for direct IO.

IOWs, this flag would be needed on -writes-, not reads, and at that
point we may as well just change XFS to do shared buffered writes
for -everyone- so it is consistent with all other Linux filesystems.

Indeed, last time Amir brought this up, I suggested that shared
buffered write locking in XFS was the simplest way forward. Given
that we use large folios now, small IOs get mapped to a single folio
and so will still have the same write vs overlapping write exclusion
behaviour most all the time.

However, since then we've moved to using shared IO locking for
cloning files. A clone does not modify data, so read IO is allowed
during the clone. If we move writes to use shared locking, this
breaks file cloning. We would have to move cloning back to to using
exclusive locking, and that's going to cause performance and IO
latency regressions for applications using clones with concurrent IO
(e.g. VM image snapshots in cloud infrastruction).

Hence the only viable solution to all these different competing "we
need exclusive access to a range of the file whilst allowing other
concurrent IO" issues is to move to range locking for IO
exclusion....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

