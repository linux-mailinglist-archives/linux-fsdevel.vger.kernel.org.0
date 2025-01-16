Return-Path: <linux-fsdevel+bounces-39444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F7A143ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CCF169315
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885AA1D7E54;
	Thu, 16 Jan 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yE/dlS2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594019F40A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062323; cv=none; b=YGtd0WDTUd9ydhhPoXGA/1XPXk+yUwLzlmau2o9r94DDbhwlmrGWDPHSzjDlKrINcQ4JvezBuLEmCgKvheu8UWUdydaxhVwSXI2dXummcxuaiWS7DrH9Q2W0vlC3tjq7XjY6XNETSo8mPwOtS1mPDMTnQhFVYVAMK9AP7Vhba1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062323; c=relaxed/simple;
	bh=qUx7bCyYvzqnIsFv4cwiMmfDPOrDXMGio8arRFvgtrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmep9uFk6cJN5O9AEFKdTv/qhsRnZHzZ/gK9OcwNqYkjxPZlyXo/6Xd6lJnlZ7GoNiJPYhb3i47vtfBn/efVHBFnNlc64T1nGyklpp9xh0MCDuz2xQmyynJRneWkvizZNCophComCibZK+YoMpMcLe4763WHOQ+t5y+J+bBWaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yE/dlS2u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso34131145ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737062320; x=1737667120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFOvnxLpfWQDQyQ88e1dDdDpu/sReirpU/iqhVjBSxE=;
        b=yE/dlS2urlk2FQFE5wIECeH70l6EbRzNFr/DPLC8z6hjDDTwTj1ONirLh21onD8NKx
         A/OSdTlbuKT1UVeSZSa6kgWKikEoChoqrYlQFPea4rzuCkR+seENPcDllcJHoq6BG03I
         wfQUz7qblf1pBrUccerMF4aBeoQzsrdK70kkjsZ9uqtlITTsAKfAx/JUPbacfDgFsXT3
         4hEzWOVnKPVyDXigz7Z/rDcsWeiR3LxcREnpDeiPMD5hwzW69lwBrr38Lt/MLTePpRJ6
         Pv+SVk0O/TdZTMExaT/pg2/NZboKk4fZ5mJYHMRt+MKds2w3w8Ew86lzejnX60vvkAsy
         dXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737062320; x=1737667120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFOvnxLpfWQDQyQ88e1dDdDpu/sReirpU/iqhVjBSxE=;
        b=Qa2ttkhdvTTzOpAtujlEip0SHM9SsgSkjbKsQigGSGkVvqX60Sjfmmd1uXGdYOInV6
         f2gnjFP7IWD3zmqzvTAGLT9aA5jtIDBt2v/R48m63mSHpcdTKCEDSFfBYn6n6RaaZAg1
         sk7NvzCnSCbci9QEa/pOBndeoJz/1880knMWy577CWHnjnwx+FEjNtaI7EC8DyBGcLGQ
         IcTzyr68sWlWet/uYpGPYdYotpQmrzJAAdNxvgCKM4pYetKcJyC13lnFYuBGlCqHT+gD
         14ppxl1xitpLkxmuQVr/1sUybtfTaOwo/dB+RCxYDnKLzzQGZELWGLfq46noUHb5SeIb
         hPNA==
X-Forwarded-Encrypted: i=1; AJvYcCXW6hQhqoUxj8xwRsYsNNTVD/hxD2suW2sGXlYDgDL4vTuJuleIXIzxPq9W/cSU4G27B32ibkU3cMZiH6vb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cf66iWIZ/RrAka7gLu/xZX0cfjn/Sv77CpAkSrEcAksQNRKE
	qdA6LAeLWhXcta/YQa8DogJrJmvCZwKmh4jFB+S63Hg90TyvkNABeJ0CpJmiygfIt84qVoQfSv8
	c
X-Gm-Gg: ASbGncszOMcvzjpyfJe7L+dJFdIBUIusfMT2+8ad6Fbo2Rbj9E8Jp5Qv3j/lH6F1nlh
	dSArU5Y1bkdcnYZex7f9xtstBsw/RCyOlWUa7HY7Ifuj4bnqqfd8CZf8WV9ik/gti7igLcVB63D
	CmXFSk3lS5+hQVaPvSfbBEdtX1lWkTYr76WFEZ1CrK5NnN0XAeyj5yNR+InBayVmNfckfx0rXqc
	O9wfksSO6oCWLDkbS0IJYYWvpBnba8m1zgXFUAiqDQCkyx+C3KGnUKHoXwo4dfIdo49pL1M4Nbm
	gGsGmRUP2xVGBblHYDu1swosEfN3aK33
X-Google-Smtp-Source: AGHT+IH+H885sQwdqrO52Q/LDzAaPjTyaUorvSoWNxgVMy4np9vyP7cPeh2zxB3c23JSjqurHfkT4g==
X-Received: by 2002:a05:6a00:a883:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-72daf9beb73mr579392b3a.2.1737062320630;
        Thu, 16 Jan 2025 13:18:40 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e71sm434030b3a.112.2025.01.16.13.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 13:18:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tYXG9-00000006k8C-1g5V;
	Fri, 17 Jan 2025 08:18:37 +1100
Date: Fri, 17 Jan 2025 08:18:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <Z4l3rb11fJqNravu@dread.disaster.area>
References: <20250116124949.GA2446417@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116124949.GA2446417@mit.edu>

On Thu, Jan 16, 2025 at 07:49:49AM -0500, Theodore Ts'o wrote:
> Historically, we have avoided adding tracepoints to the VFS because of
> concerns that tracepoints would be considered a userspace-level
> interface, and would therefore potentially constrain our ability to
> improve an interface which has been extremely performance critical.

Yes, the lack of tracepoints in the VFS is a fairly significant
issue when it comes to runtime debugging of production systems...

> I'd like to discuss whether in 2025, it's time to reconsider our
> reticence in adding tracepoints in the VFS layer.  First, while there
> has been a single incident of a tracepoint being used by programs that
> were distributed far and wide (powertop) such that we had to revert a
> change to a tracepoint that broke it --- that was ***14** years ago,
> in 2011.

Yes, that was a big mistake in multiple ways. Firstly, the app using
a tracepoint in this way. The second mistake was the response that
"tracepoints should be stable API" based on the abuse of a single
tracepoint.

We had extensive tracepoint coverage in subsystems *before* this
happened. In XFS, we had already converted hundreds of existing
debug-build-only tracing calls to use tracepoints based on the
understanding that tracepoints were *not* considered stable user
interfaces.

The fact that existing subsystem tracepoints already exposed the
internal implementation of objects like struct inode, struct file,
superblocks, etc simply wasn't considered when tracepoints were
declared "stable".

The fact is that it is simply not possible to maintain any sort of
useful introspection with the tracepoint infrastructure without
exposing internal implementation details that can change from kernel
to kernel.

> Across multiple other subsystems, many of
> which have added an extensive number of tracepoints, there has been
> only a single problem in over a decade, so I'd like to suggest that
> this concern may have not have been as serious as we had first
> thought.

Yes, these subsystems still operate under the "tracepoints are not
stable" understanding.  The reality is that userspace has *never*
been able to rely on tracepoints being stable across multiple kernel
releases, regardless of what anyone else (including Linus) says is
the policy.

> I'd like to propose that we experiment with adding tracepoints in
> early 2025, so that at the end of the year the year-end 2025 LTS
> kernels will have tracepoints that we are confident will be fit for
> purpose for BPF users.

Why does BPF even need tracepoints? BPF code should be using kprobes
to hook into the running kernel to monitor it, yes?

Regardless of BPF, why not just send patches to add the tracepoints
you want?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

