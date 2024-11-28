Return-Path: <linux-fsdevel+bounces-36063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC949DB5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E58B28177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88EC192D95;
	Thu, 28 Nov 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQYoUpnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A41369BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790720; cv=none; b=bYpKxJEflI+DKhreiacfTZl3suJ3mW+/R40gh8NsOoJPc2w/9qZNraab3vXxj3IQHZIwD5+PEhly5tWHEiN7BUgEo+3pda3+GblpjKbki2YsARobQXRZ1EUrkhcpnULgusfi1A7TFQOQLRKtORibIOM/ehEcutmaFPMmTrUyta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790720; c=relaxed/simple;
	bh=ioO9MGJ8RFcxU0OEleMWJT4fb8p5fWpDnbkoHKnnrbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG5b7eF+M5a9C4ewQcau8WPi2AAHRBidEjL+pWC1TO9scuScFMVtyFVueHs9R4uLo0rn5n9aJ6mNTdW/ILaOx+vfExYctm38H/QmJJNWGuoRN8syyhdu6+7FDtodB+2sH/h3UxjQAuZ0Ao6MVmA8JodZKC28rv/OJkrZJhrWb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QQYoUpnm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso571912b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732790718; x=1733395518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra+nPWwa1InJSk6iw9XH2tYRQj9xj6wEO3y2HewRSbM=;
        b=QQYoUpnmlTCFd1u2im0ISl4NP9yDQ5ZWpms4Rl3qjXIRSe9LhyiVIoC1LV1lEIQceE
         xNj9/efmvqPTLLmuKlTssKmKKH3o0XCe4ZXFVpMzPiicJu6D8NdhncrTaYYHNVJtsJda
         zu0w8Uq0uK1q7Zsdo3O5uuGHK3zXnJIOV/aew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732790718; x=1733395518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra+nPWwa1InJSk6iw9XH2tYRQj9xj6wEO3y2HewRSbM=;
        b=BvDiSVs4lSfjBjXaJgRAgv9kZH1iOoPhONvcqnADzJreeImNOVC/uPjCsCh78VduZP
         TlPDAU3ptfsEgqFXONelcN9tkWQ8Ztor0qi7oI+tvNMNfogtWcSobjpIn1Mj4LdfScOi
         Mr9AubWIS+yRGWuZvq+x7IIgUtdoOSmYw1wL1Q9XBJBuURb/bK28TyE/UmausEi0SNWM
         AM+kXwYifwMKh5W7ZGHUkaE7+dCalJ5pjGNo9zYt/E9rT4MWxu3l0Wo/q7iHJEyRI350
         +42JAMYMfHbm3rxCBB0Keuveb1/NU2M6JS8bKALJNsIxSwK6PCS7wWwXd5FKdr/KQNHQ
         K19Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7hmviMTvIDqezlVNupKPFag45lc1kOd5nS9ucSKbVuGiud40zFzhJafO1qQoqc1JHGhfd7j/6I7M8bqQ7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvl3KAOppqLtNRLwTCLXR4fxyvOkjbNex7pDcXEhdavHUgHC4V
	qd57tDcihGw6X7hgdOq4Qi6qATJc137XOztwIPaje7OqZoVacuqg8A6wYnZrpvYDLqUGgxgTld0
	=
X-Gm-Gg: ASbGncumqqk0z7Csgc9tmJwsw8BwOEVAhHoau7PUJ7faYsJoujUO+bSlZ45mdqVjoxU
	BF4YyTkuRrqJuBzAie+ezGeygJZOHBhJnTqTwcbWGt+zVXT6gqz3WpZS86hF046ZYmqM9TD7Y2m
	MPwZVA2TGGTdfCe1BVvIrQ/jUwO/HCv41c8VbbUA2I6/YVYVHi0mMo5BqmooA2114glhpEi6/ve
	yBU92iriPTuwPXpkxkskvrdUzMWw6QmLEFP0AalVO3iVB7qSSsXHg==
X-Google-Smtp-Source: AGHT+IEIQGcWD1j2zqd9Z7eniwrjeF+M26Y7kRStHyL6ZBIdiQ4WELp7bX7g43tSEb4fQEtQElvAIw==
X-Received: by 2002:a05:6a00:228b:b0:724:d511:3d60 with SMTP id d2e1a72fcca58-7252ffc9399mr9280355b3a.2.1732790718058;
        Thu, 28 Nov 2024 02:45:18 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848b4dsm1238011b3a.186.2024.11.28.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:45:17 -0800 (PST)
Date: Thu, 28 Nov 2024 19:45:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: fuse: fuse semantics wrt stalled requests
Message-ID: <20241128104514.GC10431@google.com>
References: <20241128035401.GA10431@google.com>
 <45da8248-d694-4220-a120-3d85a463c0cf@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45da8248-d694-4220-a120-3d85a463c0cf@fastmail.fm>

On (24/11/28 11:29), Bernd Schubert wrote:
> On 11/28/24 04:54, Sergey Senozhatsky wrote:
> > Hello Miklos,
> > 
> > A question: does fuse define any semantics for stalled requests handling?
> > 
> > We are currently looking at a number of hung_task watchdog crashes with
> > tasks waiting forever in d_wait_lookup() for dentries to lose PAR_LOOKUP
> > state, and we suspect that those dentries are from fuse mount point
> > (we also sometimes see hung_tasks in fuse_lookup()->fuse_simple_request()).
> > Supposedly (a theory) some tasks are in request_wait_answer() under
> > PAR_LOOKUP, and the rest of tasks are waiting for them to finish and clear
> > PAR_LOOKUP bit.
> > 
> > request_wait_answer() waits indefinitely, however, the interesting
> > thing is that it uses wait_event_interruptible() (when we wait for
> > !fc->no_interrupt request to be processed).  What is the idea behind
> > interruptible wait?  Is this, may be, for stall requests handling?
> > Does fuse expect user-space to watchdog or monitor its processes/threads
> > that issue syscalls on fuse mount points and, e.g., SIGKILL stalled ones?
> > 
> > To make things even more complex, in our particular case fuse mount
> > point mounts a remote google driver, so it become a network fs in
> > some sense, which adds a whole new dimension of possibilities for
> > stalled/failed requests.  How those are expected to be handled?  Should
> > fuse still wait indefinitely or would it make sense to add a timeout
> > to request_wait_answer() and FR_INTERRUPTED timeout-ed requests?
> > 
> 
> Please see here
> 
> https://lore.kernel.org/all/20241114191332.669127-1-joannelkoong@gmail.com/

Thanks for the pointers!

