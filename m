Return-Path: <linux-fsdevel+bounces-55550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D7B0BB48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 05:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0D318961AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DCE1D9324;
	Mon, 21 Jul 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IL6shCeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E352F41
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067770; cv=none; b=aSKAGD7TSK2R6K99Sj+/vw82afJpv2ZOhn/w5uBncQenm0dvE6y1eoyHu0Pvycqt9C0MnWN0pQ6D73F8mneyrJKsqk4U+pa2DS2AXcFD2tztyb445QRywG5J0hhlxcoilHz7S0cx8h+xkti9ZxAOT4vydCMgyTXvX3QYxHvQsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067770; c=relaxed/simple;
	bh=rSWv4zFTb3j8yRwlcqRSKbpvUIhdonFOb2X4SLSxZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA7PypZQGvgByAx1eCjGtYUp0ddpATLQZwFXMR/pMuMrtvTPymgc6zSEkx0Jv0m3blvXoPaN7h9ycbj/Fcp+KiqmQB3Kp5E/wbMxv3q3nYRIqA4Rher+65k2ZrZTvK47iWROvXY/yPh6MaqYdpw2Uplnf7VKurSHoxlKOlFSUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IL6shCeH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ef62066eso45257725ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Jul 2025 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753067767; x=1753672567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEHkdm832hTynzS/xLG26Wf+TEMODMOzVO5dM74VcWw=;
        b=IL6shCeHXNOsBpeqbbluC5+N5doybmEtbV4/8YrqamyfGnA30RBwcT0QlsKzM/4n/4
         5gc+8IC72JNJC+UXKMdmg+NY71d6hknL2yLRrZQmQist4G4RhQIkfswk3vygkIlgTbwL
         4TlNj4ZOSHjausxv+Wm/hEgJ/X3wAQmifd6XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753067767; x=1753672567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEHkdm832hTynzS/xLG26Wf+TEMODMOzVO5dM74VcWw=;
        b=jJqCKyORkxkqaLIAcjtZd3UyQcGcNnjHzZHMT/SuZZHNVB8KrqcMgLputsv7mAOBJ1
         coteh/aV3tH09F77Hp3X/IKB4WoaS4eMaS8PA9bwVbBVw8//jh/AjpZXnYuhaxGMKIDO
         aEoGtJqFebnxXvVYwxt5nui490HQFUwSDB17aZZeGygfcMq46xJmxeO1rPcBaOvC6fR9
         u6xrM/3PKGpAkDeDB+jz89fBU8By6vNkS0NEpNbbJzFWfiGOoE3Y9eYb81LVZqh3Ds9F
         WDoKKpXT73sbYbIJz/+WgpegIX1YvyBv/15zTESxGQayP5x84mUyUQDeJ38jGyAxRb2u
         h2xA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6ZUAyH8yzJ6Ly78UkkS0hoITUV4NoZq5/GDzDYxk/OfEP2+FBDYuPh87nr+X8FY/0MJWut6h60GjeIas@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF8OXW64gll0guugzXILdWSg3jLpqU4i6wHVJRkoWOhz4UqSS
	Z6jHpRCFySP0Gnaw8LprKjFjSgbtRqnZJMrA/kOB3Gtcwu7iNEJit1qzUBVcVnycLg==
X-Gm-Gg: ASbGncsIhqKDikYZZykzmf6ZJ2bZ/uArJ29nEndYU+ZscMKiI6UyMkVNDyWLiJrSCwt
	T0J/VSx71v6M4X+QF87O28Q684m3qmKoFC8JFU5L4pcwowPxwk/PygznKtiKZn9kYVa5loUrZeq
	R8dVVRDmnCmSFmYofSi7z+TGB3h63/uF7dFY1fHw12EWvE1FHYs7qZJh37eSmdeVt4XAP+NnDN8
	wYg5LjwZV2NaDFrxYFAIkNEcqECJqeOfVs7KGpEJulS1NXshdKv6KpASTrOoM35oVen3Rv8Z+fd
	Ly37wXZ3jp9WwgbLiKmYKXplq0KENv1KqFr3JliowQTvgrTI8fDdiHIXVROQgkseg7FbZwS5mZx
	QPfpre4cVXei1ZkoBKYoKPYxfqg==
X-Google-Smtp-Source: AGHT+IHBqV5AH7e/4eflt9c3XJvhjaEBjyadSkqKL/UtcHHt794JhemiQyNSy8Uct295fuP8sS1m9w==
X-Received: by 2002:a17:902:d584:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23e3038155bmr199322855ad.50.1753067766876;
        Sun, 20 Jul 2025 20:16:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ca29:2ade:bb46:a1fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b55ebsm48127505ad.103.2025.07.20.20.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:16:06 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:16:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: senozhatsky@chromium.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tfiga@chromium.org, vincent.guittot@linaro.org
Subject: Re: [PATCHv2 1/2] sched/wait: Add wait_event_state_exclusive()
Message-ID: <ofvya3en67l6gxw7sxzl6qsga2x46mdsusrx5az57kw7eihwoz@m5jyjhdsssit>
References: <20250610045321.4030262-1-senozhatsky@chromium.org>
 <20250720205839.2919-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720205839.2919-1-safinaskar@zohomail.com>

On (25/07/20 23:58), Askar Safin wrote:
> I booted into it.
> 
> I mounted sshfs filesystem (it is FUSE).
> 
> I disabled network.
> 
> I did "ls". "ls" hanged, because network is down.
> 
> Then I did suspend, and suspend didn't work.

The patch is for background requests, e.g. for those that
are issued on a not fully initialized fuse connection.

You probably tested one the wait_event-s in request_wait_answer()
instead (as a guess.)

