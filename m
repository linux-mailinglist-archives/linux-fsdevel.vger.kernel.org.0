Return-Path: <linux-fsdevel+bounces-36509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88E9E4C9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 04:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753FB1880308
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DB18C903;
	Thu,  5 Dec 2024 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UhdLCo6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387638C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369036; cv=none; b=PwwkTH2pLggZcrDYL71favLfGaLpXmJtAcpkHYWre4BeuurFr2c3sS7xgXWt62MU9cdIdV/4MZ1H5VYAAGx4sUjWHzB1kpK+3SbmtxXoCGo/pjfOE9SZOgdqSmCsCo1yOfm1+2cDJ1K+hj1Eif4wbxdL590JVim8Dw92DW56X5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369036; c=relaxed/simple;
	bh=fzmRWM2aqz4onjKaSgqJU0oPs81HOmbtsz5OUsfBpvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFBCGMCNgnOcG9cnsSh1glxH7v+ju7PKWNdXTXnc9rn70fhOfrm9XD2BFF7eLBtbEg8Qp938C7YMMXjn5SWcINMLwYf3DpdYV2wxOks+sMJlsoYWuie+poOjH+Ct4ZaLHi6kRLhupG5SSXjcXSSXBctsSmfMLFG6l4AI3Vqky64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UhdLCo6C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724ffe64923so548474b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 19:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733369034; x=1733973834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXz3JBA9LjdiOjWaRBKDYuVw25crlgz8O885soR/KQw=;
        b=UhdLCo6CZdwAdVwTYi/IN6kDYGIcSd0a80Zk/q1+SHpBe8TnNevs4nrjcmOMC8yMbZ
         /gHHyo257XYcVKxkkatnWrlwOrsUcBit67S+SGLJbLnOEZrTvSpLQlsqmOQZCuJpQUCq
         hajt518YlRuDrQ2qK0Pj8n2wYTHXiNhMEJlzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369034; x=1733973834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXz3JBA9LjdiOjWaRBKDYuVw25crlgz8O885soR/KQw=;
        b=Mmth0V7ZXsr5kalPTALH9HuG0sVeID7BsbnE6fcm7vHo3B4fjSOEtNMeQUFMHL+QYq
         a1R0/M4xrFb8xlJcUT2zK3rOqeQFqb4hB6RvS2SsqKBfXBwxT6DM1Ew+l2HUEA6+w+6W
         hw//O4Puhv3DE310zGWNzuyR6b4JRMTU/u3hzso6m9sHDpeG8cY52lzTf7ju5C8hn0X6
         SMTkJVc6GZYQBCzGQt5AwSadmc6GQYA6rFqohWLB43wcne01NO1H70RzVgIWPLjvd34P
         XA34JtSgVSKR6BmjwNMXrF6fqNMEnSPl4CiUZrKWuq/+i21HREn8F818zoOI2QlFX7tN
         aQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVK9I3ksuJVwM6WJhZERd6eA9hK3DhMPxxIHeOV6bR79eJ6yUK78BlJnzbXccFtz3zPiBvYHwusk3HoLy4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HYwc1Zlli77DH3ZMMGDr7vHKo4pOYh6zxfu5JJR4cWYZaSpf
	0bR5HXjaMmob97p0KbUM1yPnblw+yNQ1vyUSQSeIb5j9ZSb+cDb8CiNS07daoQ==
X-Gm-Gg: ASbGncuERFN3p2w6/SX5hrUrGnz3y+cutG7Js3YJmnU0uWwVwXYosa2tv0jHEpICVnQ
	59n2sj6/rJqLlJrkoOjSiwGDRIe6+bb9r75INTFdluOpBok6Oz/65oF3a/o1JWxCIGQCXOfgvFs
	5dMJFwBCeEpjcQr7+o6DMYSCSOEOSDLkQ2MZ4NiClKJ2AxbYQH9yih9J2Pumjgg8+toISaUZVxy
	yOfM4160PyXQuiBO4Q57z3e4TcO9gM9J+o2D1PU7lCbPaK16zMK
X-Google-Smtp-Source: AGHT+IEpyrT8eT7RRCqiYETrCdd449xWC/nrsVfWpHb7iaYkZnQKEaRG9GU5eysx1LEGeZo1SmXXTg==
X-Received: by 2002:a17:903:1790:b0:215:711f:4979 with SMTP id d9443c01a7336-215bd24b939mr134104315ad.35.1733369034282;
        Wed, 04 Dec 2024 19:23:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f30fsm2758825ad.74.2024.12.04.19.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 19:23:53 -0800 (PST)
Date: Thu, 5 Dec 2024 12:23:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
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
Message-ID: <20241205032349.GC16709@google.com>
References: <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
 <20241128115455.GG10431@google.com>
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
 <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
 <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
 <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com>

On (24/12/04 09:51), Brian Geffon wrote:
> > > > >>
> > > > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
> > > > >> and then the question is whether HUNG_TASK_PANIC is set.
> 
> In my opinion this is a good argument for having the hung task timeout
> and a fuse timeout independent. The hung task timeout is for hung
> kernel threads

Sorry, but no, it's not only for kernel threads.

> in this situation we're potentially taking too long in
> userspace but that doesn't necessarily mean the system is hung.

And it's not for hung system.  It's for tasks that stuck unreasonably
long waiting for a particular event or resource.  And those tasks very
well can be user-space processes, being stuck in syscall waiting for
something.

> I think a loop which does an interruptible wait with a timeout of 1/2
> the hung task timeout would make sense to ensure the hung task timeout
> doesn't hit.

The point here is not to silent watchdog, we might as well just disable
it and call it a day.  The point here is that fuse can be used (and IS
in our particular case) as a network filesystem, and the problem can be
way outside of your system, so spinning in a wait loop doesn't fix any
problem on that remote system no matter how long we spin, and that's
what watchdog signals us.

