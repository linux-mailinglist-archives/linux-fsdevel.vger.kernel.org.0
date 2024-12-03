Return-Path: <linux-fsdevel+bounces-36308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5A9E126B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4901640E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E2126C03;
	Tue,  3 Dec 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTjwUqzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9217E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200286; cv=none; b=mmZt2gD06dFa29i5Pt1Z8z2PQLjlzcee7+Xs9/zHxgHkNbHgfMjFcQWTk72oKACs88KoYYM3QDWtaWrcsKaAOlfOpg87fD+IkNMs2Gv2ZUZg2IxCu+e0Do0C9NfhmUVeuexYdIqvgCCdOy07iZBYkOp5dlIaRWbf1MARrgD3afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200286; c=relaxed/simple;
	bh=TlNdYGinqUVah6c0G2yPu+awIwhzsCIvHd059gH/wE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P54tB9SM/GG51rMKHVYT+KT/MGSvB6si53hVy4brGf5Ug9mYt6aeUc/icLMPtzU7uMHoZNnNdAIxodHv8i2hqn66upzcYX+hWScwyF5p9+Vyf7+sjOiOPoBwjxtQ36bNtNRObyQ4pQ8wPa9OJlI8bkvXEw3SXZsa+F0NOEjpEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aTjwUqzb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215513ea198so23742445ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 20:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733200284; x=1733805084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGahhZ5hgr1dmdvu10Pb6ZutQ2Fjf6o71aPZ6EEw6pE=;
        b=aTjwUqzbN7zVk2wD8aPvUoyxdouN6Dw5WhH2rG9224aIea09JNHcAqu9wbgj4mZwT1
         9rUeAyd+/QSLOoEyztgbgV5bkQ3xFCIuvtXO58H92urCExYOGc65Zr7nksSztuI5mbPa
         7AwOZboD/Ag/fx+Ofo9/7xf2AHp07z7/HQ5OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733200284; x=1733805084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGahhZ5hgr1dmdvu10Pb6ZutQ2Fjf6o71aPZ6EEw6pE=;
        b=tGzHEwHcQtX/JvmkqlTk7EH3oPysNvo+qFPpOcNhVZdmbyprno7ycX/IFbS2krogtB
         p5revt6zE8WgncYwKSW5TE89/WoXlnhkALuIvWHra9QqSv45xG2YCHUmzBjFsggX/vqy
         b58I5SGkc4d6sc84K5b8Usa0ZGXsmn9rQ3CV6PrBov17Ekh0rO+KuvCvJd1S+1JT/Ytn
         HvfUPCXYCQp90HgIqonKR0InjFzv6GyyWxXkyGuMSSiBirx+fKrSgAUU4EyLJxxxpJoD
         pZuMVHEmptQXIk/gam05keNFpueuR7OFAYlABidmFY6dl/AGxr+ZSJI/tiua/A7VuIvn
         SrfA==
X-Forwarded-Encrypted: i=1; AJvYcCV0oM9H9G3JaPO159kVzYi5wz/zcUP+OSYYKnmpsBt5jp9CAYUGEzaFdiAMg1/V5spyqQCKJ6+Ey07SYpXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7V1p4qkbR4/80dmhAz0MRqZd7OT+XXPOeiDj7iBF59Tu1xpQc
	BHXwANnKt+pSGQ8dIY7ltCP0VX9FJi3FBsNIrino22Sg6/babVCiNTjVpbh8fg==
X-Gm-Gg: ASbGncugRpo6KEabPLTHv04a7priaIPr4PHLfX5JZS+CykB7vT2cTQzJdb9V0FAzYzl
	vDa/pmfIOreF3xtreDyYQtD6j/qN4Knz4T8qU8nxEW4SILkRiyQ2fTBNbaRgIDyGfl83lG4RS2Q
	hRdfyFyE+XIcLhi0ibdysmVx2Cf0/tFSERymKQsLMoO/JF76wSb3pppAPk6Xb3/Z+SvsDOlc1AF
	BufcmgP0F2A1UQ/NyNUOXqocewfKk5wdDhsYwENiaLuCUCbQe0=
X-Google-Smtp-Source: AGHT+IGS8Eu9nXTaGsnU9HNTvjdEsZbXPfRpFr1J1NaV7JBbKUdUmEqA8wH0GfbBpnau9QxuI2Yg5A==
X-Received: by 2002:a17:903:186:b0:215:9eac:1857 with SMTP id d9443c01a7336-2159eac1b3fmr90306055ad.5.1733200284183;
        Mon, 02 Dec 2024 20:31:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c5f:1de:5acd:2474])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbfd0sm9368140b3a.115.2024.12.02.20.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:31:23 -0800 (PST)
Date: Tue, 3 Dec 2024 13:31:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Bernd Schubert <bschubert@ddn.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"laoar.shao@gmail.com" <laoar.shao@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241203043118.GC886051@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
 <20241128115455.GG10431@google.com>
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
 <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>

On (24/12/02 11:29), Joanne Koong wrote:
> > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
> > >> and then the question is whether HUNG_TASK_PANIC is set.
> > >>
> > >> On the other hand, setups that set much lower timeout than
> > >> DEFAULT_HUNG_TASK_TIMEOUT=120 will have extra CPU activities regardless,
> > >> just because watchdogs will run more often.
> > >>
> > >> Tomasz, any opinions?
> > >
> > > First of all, thanks everyone for looking into this.
> 
> Hi Sergey and Tomasz,
> 
> Sorry for the late reply - I was out the last couple of days. Thanks
> Bernd for weighing in and answering the questions!
> 
> > >
> > > How about keeping a list of requests in the FIFO order (in other
> > > words: first entry is the first to timeout) and whenever the first
> > > entry is being removed from the list (aka the request actually
> > > completes), re-arming the timer to the timeout of the next request in
> > > the list? This way we don't really have any timer firing unless there
> > > is really a request that timed out.
> 
> I think the issue with this is that we likely would end up wasting
> more cpu cycles. For a busy FUSE server, there could be hundreds
> (thousands?) of requests that happen within the span of
> FUSE_TIMEOUT_TIMER_FREQ seconds.

So, a silly question - can we not do that maybe?

What I'm thinking about is what if instead of implementing fuse-watchdog
and tracking jiffies per request we'd switch to timeout aware operations
and use what's already in the kernel?  E.g. instead of wait_event() we'd
use wait_event_timeout() and would configure timeout per connection
(also bringing in current hung-task-watchdog timeout value into the
equation), using MAX_SCHEDULE_TIMEOUT as a default (similarly to what
core kernel does).  The first req that timeouts kills its siblings and
the connection.

