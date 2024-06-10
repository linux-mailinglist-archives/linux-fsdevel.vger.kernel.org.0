Return-Path: <linux-fsdevel+bounces-21352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C690292F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 21:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1261F21BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A4114F132;
	Mon, 10 Jun 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="yu4AdpGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F514D6E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047306; cv=none; b=B3RknQpMXsCr4kZmocoJUgcG/XrCIrDLfUwjCSDJGqHkNxMjJrtYnifsveVlJDvnsgD97FY96rk4oGgdp22QsNogJkDlZdE+sq3ecjn08fYm8RHX+OILcJe1Y93vhw1Jnsz6MJ1ilhIOghQL5hgU19velcabqxD9Qc//4HHrCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047306; c=relaxed/simple;
	bh=sRPSbauIiYaJtGBZEqHyUjPGKFPTk5/HdK22FraU4hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyvPxH6mEjCWc3fkDjXrAMrOEiFjvCc9DDtwgvNsA0TTvlInpbUiYKiuAANxxLGvM2V9h4mO/vd/fkGawqcBCCLwvWCqJaOy47ivLvaRazyRYZmfB6RmrV7VBM/KsTibpsU0KVzI+eEsX0w+mXhKpjvS+DtWO8vVscdtnn8Fjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=yu4AdpGP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so4732965e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718047303; x=1718652103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBntJYSpEKXr0eXUi25C7jSWwKZG1Ap3DYhbE+QGCrQ=;
        b=yu4AdpGPnGacd6cwDL/DtvxZdGK7JNjq6XhqddfsUOrB9ei6PFiw9i+1x+XCuAeY0p
         23+RU+W+zLREQV9HwK8KBYtOrpYNJy5UavMnUMZ/lIFargodujaMzg5YBo4gNcRouLS/
         dCAlI/AXRrRr0hte6iC79QKf3wcx3kr2qhDRxVpen/FvdMBkVLz9OHmV2PskG7TBXJSd
         G2hrJubxJ6oaXs0SFJHQh2ixFBQoB45sPXW/GLH70gWUT6UrH++tnKjk8dJd/vVVHQqY
         NbIZTKoJ8TGVZeQq4JCT6ZFSPDc1yGd6MVliszLBXrJ56JwkDHsOrv3Kvkr4jv+eSVF0
         pgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047303; x=1718652103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBntJYSpEKXr0eXUi25C7jSWwKZG1Ap3DYhbE+QGCrQ=;
        b=OAZUX1eMhRkdJEzFiFroBUtTQpQ2hjTn+AM8tBYc8HaZH7BDUgwkGar1da6yneFwJW
         zFkPtUX5kYVi2OMYTyVM6A9bGo2NQzHqPvjHN4orLWFmZdIPyzbl4SztOlGkn+geebzk
         7QPqPmdNYCkipjIKGL77DtQNDbGGNF1cGvnI022Q7HWnaAD+eBsVUWw3/89PLAGj/xsB
         ftjbLo60I/O5SbDAt2iWU59u9P6JZqV1/bJOZ4JTKG36KCL2/TPO34we8kITffGrgDJD
         VF+BsZ4PpPw3fqIhxIc8eEyxGE2/Bp6uddwhJAgSFhLIoYDUSaEPTp5NOpArC2egWWqK
         hP/A==
X-Forwarded-Encrypted: i=1; AJvYcCWo0XnxTu0atPyr6h+4+pUQUUlYMBweoIxlnfInTgVeewZcM68KUg8whnqRTWPVoOGviA0ctefCCzRpgGXIAVugI2oAZOS8Mn9K6GuuzA==
X-Gm-Message-State: AOJu0YzY0EfHDgpXkEew/nO8xiZOdnvEfJtTvcjnhbw+y0TitukXL2ZN
	SgE5/aJ/2Cg9+hINtX0Iv2ePQGBL8obBeuiAS99hf2+Nxv7tQcateF4Xi91W+z0=
X-Google-Smtp-Source: AGHT+IG5R+6QdrL5vtPI3P3UQJ+Eps+bOHM+4T1uVpoya5SI1oL4hgnotnXL1Fs02cAYdrCTAMaMxg==
X-Received: by 2002:a05:600c:138e:b0:421:2df2:2850 with SMTP id 5b1f17b1804b1-42164a21d60mr105810015e9.31.1718047303182;
        Mon, 10 Jun 2024 12:21:43 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4218193b0c0sm65469985e9.31.2024.06.10.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:21:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:21:41 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240610192141.dibvhzrvx7hacvd7@airbuntu>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
 <20240605132454.cjo4sjtybaeyeuze@airbuntu>
 <af031e33-74db-40ba-abdd-ef1bf32e4caf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af031e33-74db-40ba-abdd-ef1bf32e4caf@redhat.com>

On 06/05/24 16:07, Daniel Bristot de Oliveira wrote:
> On 6/5/24 15:24, Qais Yousef wrote:
> >>> But rt is a shortened version of realtime, and so it is making *it less*
> >>> clear that we also have DL here.
> >> Can SCHED_DL be considered a real-time scheduling class as in opposite
> >> to SCHED_BATCH for instance? Due to its requirements it fits for a real
> >> time scheduling class, right?
> >> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.
> > Yeah I think the usage of realtime to cover both makes sense. I followed your
> > precedence with task_is_realtime().
> > 
> > Anyway. If people really find this confusing, what would make sense is to split
> > them and ask users to call rt_task() and dl_task() explicitly without this
> > wrapper. I personally like it better with the wrapper. But happy to follow the
> > crowd.
> 
> For me, doing dl_ things it is better to keep them separate, so I can
> easily search for dl_ specific checks.
> 
> rt_or_dl_task(p);

I posted a new version with this suggestion as the top patch so that it can be
shredded more :-)

Thanks for having a look.


Cheers

--
Qais Yousef

