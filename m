Return-Path: <linux-fsdevel+bounces-46344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F589A8788C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 09:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7973D16F374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDA2580CD;
	Mon, 14 Apr 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CEc1m6/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68881257ADE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615049; cv=none; b=EWg7eDOKjpLaZByqLd97a3TmzKARCFjJIuVbihkt+zP068/86dsnNXm16e56MO13DOLPv+zKkQYNKF38wE9QFtRz5ZFTAMONZyaB/g6yGkGkFyJ9UH2wowwl4R36vnt+QSZrajZblH2aYwUska2ebBva8KBZ0S485MXws3p4k2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615049; c=relaxed/simple;
	bh=XmChRJDMubkkoWDIzCsxlWX9AHt7tVxGFICv9/k4TPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lyw255SFLbiZcvr9jBPeitQXkQ7fjParO51XU21T1KKzR/KPFhotI2TjLYJLhGQHxWACtEZSRMXD1CFowzYu9UFyo+84sLtDOVin9Ioh3nU2Tsr499ompEv2n5+/oj/6dvY7BtswZJ5/quL9hj6OQhXB1NgQKqJAtZ45PJMdw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CEc1m6/1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-477296dce8dso39532641cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744615045; x=1745219845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=laLQMlge7YmD/1KwplVbwcYCiwtNenIJivO5aiKBI/A=;
        b=CEc1m6/1zSz9oBcvK3XcGns+CifJD/McW4jhvsJrEF7gdpRjOOllSfrZI/w/A/uiGK
         p4CcHUYc7BhRmT/St3AqVRSdwD6P3OPEXeuylqO3UcViEEauH47hWAXpLOchKXstKhig
         /y+MY9dWYvLjxN904fTAOMR++FFOW0v0uarXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744615045; x=1745219845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laLQMlge7YmD/1KwplVbwcYCiwtNenIJivO5aiKBI/A=;
        b=TnahbAH79Nf0e9jTUz5/SCeIbqPNvT/hBSrTBFSQWaI2fiuj7d5chNE3Z2KZ9UMOnD
         AOCcsfe2So+d/xCWjaH9qhIb9yb0taFUt9KGv0OCZrj2syozJ7L0G77WQPRnSEmwHA34
         ml3SRQ6yP6cn25GPDjrZZmIbuUjBtpWzaXE8/EbZJuMPXr81QCc8iTyywR5QLLMtF9Ms
         5+N0ykzbuA09PNyIdVqE3g0KotWN3E8qk/5/99MXcwiUDvu4ztcZi2gjuZPmgGLuWLQX
         JsL/zc5UY2ayGpXnEA5F89GFlub4ynLKOPkIXghtMdsQuAeJXQ8Tu8/PodUk2rELLPSA
         7DEA==
X-Forwarded-Encrypted: i=1; AJvYcCXW+Su4WUAmH78gbSV9ODA6laWn6dHW51zoSy+WdCVa3yHU0CdOU4NOfQOW7ZZI6Z03lu1akzcHrk8SrxGo@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+phqYToreMTj1SzqUTYfXKHnyYilS9aDRXZJ7MlwOnZ3uv8p
	V+Bu+Y+RyWRZHs3b5GOH8PVBVbLFclNGGCvsqw7xP94KssC3au1jESM/JmmCvuHNhkd5bhZDR1o
	6Nczo+0FoDBrw4jyCVf8MeT2HSDQQLauwbLaznw==
X-Gm-Gg: ASbGncsXRRwzvTWm13mJE7edzMgzM6UWex/0IZzlVhdKN4CuFHEwauxOQyzjIJeXR/C
	RTk8gPXoNShc0zGHiwS8x0Mas4zAvXFriYpHIAbNCLyuMxmDXx1mvdW5H01veilUfOBCY5+Lwsn
	9X+/Fso1z+nPFq5/889KA=
X-Google-Smtp-Source: AGHT+IGj40oKFmX0FVAJYAnXgSDdt1/ZszjYBWhdfomUngwzxr7fmgEuZ1TvtogLkBYg4hohRgX1bFl5wJ6+hlxammA=
X-Received: by 2002:ac8:5e0e:0:b0:476:7e6b:d2a2 with SMTP id
 d75a77b69052e-479775d5e40mr161977971cf.35.1744615044888; Mon, 14 Apr 2025
 00:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner> <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <3c38cf85-d31d-4c46-b9f8-e801a39ca3ff@themaw.net>
In-Reply-To: <3c38cf85-d31d-4c46-b9f8-e801a39ca3ff@themaw.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 14 Apr 2025 09:17:13 +0200
X-Gm-Features: ATxdqUEw09RfcQECoQa9OfrkUH9DRuG4hXAwyfh4amFiIWbb6cDcqxkeq2O1hxc
Message-ID: <CAJfpegsacTUd=_kXVbEZQ7vUmivPeZJFuS3C6akk7Zoomt_VYg@mail.gmail.com>
Subject: Re: bad things when too many negative dentries in a directory
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 08:28, Ian Kent <raven@themaw.net> wrote:

> > 1) putting the dentry on d_children when it's turned into positive
> > 2) getting the dentry off d_children when it's turned into negative.
>
> That shouldn't be too difficult to do ... sounds like a good idea to me.

I hadn't counted with parent pointers.  While not actually
dereferenced, they are compared on cache lookup.  So if the parent is
removed and a directory dentry is recreated with the same pointer the
cache becomes corrupted.

Keeping the parent alive while any negative child dentries remain
doesn't sound too difficult, e.g. an need an additional refcount that
is incremented in parent on child unlink and decremented on child
reclaim.  But that's more space in struct dentry and more
complexity...

Thanks,
Miklos

