Return-Path: <linux-fsdevel+bounces-19521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738C8C6617
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00100282C39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956474416;
	Wed, 15 May 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="u6H+7BQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B2219E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774778; cv=none; b=Dimfq0kf8vqOEUozzQK2lL0xgc9X2r3z5RDD0wDdi47oDo2PQsIEscW8HaGXXyoMfY80a3CjhVv0jL/TeewbK/ueP1ytwyWvekIaYglIsgXkUHMBe+F3FG1PbKucIqb5qUZN2fpjbrutjrFUkpl2NpFttGg0kmYEcJ6P5QeAHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774778; c=relaxed/simple;
	bh=Wf4PtMcK4TWbBm/o2EnpN3Y26qLxkxka0G6bwrOg3aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKH0e/q7YZ6Nsg9WBprWzP51xOGDdeDbFReD4hdKqUt/UjaKGSXxXZcdebg0syq6XXMRWhe0ieYSIBZWHbZuPdXvxLatlaaY6yPkq2XfSQlw6ykMgMQ12sbSdRPpDHHJZLIyGBzo0E0PgesQ7lSsMPVzZ4WC79CKvKieFqFX8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=u6H+7BQb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b5897so22597995e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715774775; x=1716379575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJYF6H91YS9YSoXm+Tl9JERoBMf7eBC9ZSy+O3IfVoo=;
        b=u6H+7BQb9llJ+GoUyqhx9nL12eq1QZTpEYwVKf4L6Kk8pxybMMa6wGPamt1Bg1ep4d
         C/lsdKjdJeZdXwMLWp5fxgO6nHcC9zVgGTXn9zymZ6xqiiOGQW4rrxGI9jgMEd1nbgYA
         3zZ5OzYV1RLUm4QAEl4pAqnDflIDLagY3fotksWvN5G5S8JQRnwavg71k78sQdNQSyGG
         eNyDwXYPYfDTTtrAth6G5gdKHPHtbfOX2QJbdr59n1S9no5Kz15fhFmCr3jnxK5+YEqu
         ve6MqQrYhJPoB6C1CRuR5F1dkin6pAE07+u2g+nP8Yhoa3ZGe855d6flwjmZT/e1NoCt
         ZGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774775; x=1716379575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJYF6H91YS9YSoXm+Tl9JERoBMf7eBC9ZSy+O3IfVoo=;
        b=NHBkCamGoJ5b1nq88LKILHdVID18oEHF8oGROEZidXlPRjWLm6y2/yk3Gwj4IbPcr1
         ZuWXSt/y0Ejp7sLbnHhWNLVP0EBMMt3L2E7QBhYCrO8lExXvR1dTOzKVEFJDp/BkfCh0
         Zz0nyvcO5vV/moae9ETu30PNuE5EDRyNPJh+ACDnVZNWOTgwVIaXr6WZGmcwsrSNIfat
         jDRG/ud9584zK0WLmRtgSIm1RNAJsQA2AcYnWZhz1av148D5aCeXiekHQKGdxG3QvEks
         myC6IIVxOh4pP+/KfE7iUfQKKzcERRgBVBcltu88W98q2GTeCNWCfXVRg0Wo4mqqjugs
         /PlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUOgOgIpy2Ph1KhGF1RcwGTmnakRs3XRAKktFrjKZWyZtm/9xHwAqqjjcjfkJ0HTKNOXepoe2j91Qo1ZdPEs+HZYixga1xYjU0xizA9w==
X-Gm-Message-State: AOJu0YzwGzBqLUADO0rVlrbo34Nxvq6Nbrd3H32tzOWizxHKQ+BDXpEY
	DzzphAm1X0zgELf+Cv1kbTbiyw7u/fNjM4DndJLC/e+iS7zpbqq4T40HI6XZ2Ps=
X-Google-Smtp-Source: AGHT+IFLpgfv8/Esnolm22txMsxpEfskLJZ4i6egdOEr6U9kJff2jGBqFVP62Bj1ZgVi3f/r+yf4Tg==
X-Received: by 2002:a05:600c:2187:b0:419:ec38:f34b with SMTP id 5b1f17b1804b1-41feaa439d6mr115391895e9.20.1715774774868;
        Wed, 15 May 2024 05:06:14 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm266011555e9.25.2024.05.15.05.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:06:14 -0700 (PDT)
Date: Wed, 15 May 2024 13:06:13 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] sched/rt: Clean up usage of rt_task()
Message-ID: <20240515120613.m6ajyxyyxhat7eb5@airbuntu>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
 <20240515112050.GA25724@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515112050.GA25724@lorien.usersys.redhat.com>

On 05/15/24 07:20, Phil Auld wrote:
> On Wed, May 15, 2024 at 10:32:38AM +0200 Peter Zijlstra wrote:
> > On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> > > 
> > > Hi Qais,
> > > 
> > > On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > > > rt_task() checks if a task has RT priority. But depends on your
> > > > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > > > task, which includes RT and DL classes.
> > > > 
> > > > Since this has caused some confusion already on discussion [1], it
> > > > seemed a clean up is due.
> > > > 
> > > > I define the usage of rt_task() to be tasks that belong to RT class.
> > > > Make sure that it returns true only for RT class and audit the users and
> > > > replace them with the new realtime_task() which returns true for RT and
> > > > DL classes - the old behavior. Introduce similar realtime_prio() to
> > > > create similar distinction to rt_prio() and update the users.
> > > 
> > > I think making the difference clear is good. However, I think rt_task() is
> > > a better name. We have dl_task() still.  And rt tasks are things managed
> > > by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> > > and dl_ but this change would be the reverse of that pattern.
> > 
> > It's going to be a mess either way around, but I think rt_task() and
> > dl_task() being distinct is more sensible than the current overlap.
> >
> 
> Yes, indeed.
> 
> My point was just to call it rt_task() still. 

It is called rt_task() still. I just added a new realtime_task() to return true
for RT and DL. rt_task() will return true only for RT now.

How do you see this should be done instead? I'm not seeing the problem.

