Return-Path: <linux-fsdevel+bounces-32823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CF9AF48A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 23:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2841C21CD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99592178EA;
	Thu, 24 Oct 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0p+Ehihi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3819E975
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804406; cv=none; b=BudmgggyaUQZyvzdH5FpnD1m1kdxdvRbsgrYObkxVXam6NY02L0b+0c4YUPUYy9nROfc9orCVKK2vAk/WHQLh91lzCVFuWKYC4TOpaueydr+YESq+R2V/0FSC5zr0bj7UvGHTVk9gwJQI/mteVPhWLgzLgHlCxe8hmudtCRf2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804406; c=relaxed/simple;
	bh=+4voujdCR3hr+aHqsPplZcNQHMESshBlhtCDJ+kukfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsPRW3HwtLrLc97aSa3UZ8n9HWEEQkfYV4KfkW3lIDoaa3ioUQ1K3W3lFUQzHrlqkdslGDKbDt1gooszSDsSISENKNQdEoKJplbkPe5o26qrPkouEfC1XNLhopIu3ondH5N9CW4qEC7XbqW1L42yu44XhhwAj7sojb7nDUQ/Lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0p+Ehihi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e6981ca77so13989805ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729804404; x=1730409204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK26aUi6oOdLrlZvhuXktuYwEbsoIROsGkYCLCMengk=;
        b=0p+EhihiDUF8zpQ+Pt9zGQpDYKfNUNv7ZQanx304Ax5X2w5DkaH4AB6pb0G0N1qxWQ
         NSg4PKfbUdhKn0SXo5/JiCwK3bIW6sSouqhXqI2Z8hXTJF7kvEbTy8LJyU1v95e6Jq+c
         tMTFCcIK42RLSKEuimldWtAUOPFxH7R8d+nXGu/783lDc+CQr7uBfDGHcLOKqvMQuTvi
         1qdneUBwZ1NxpUfcPBZ5BEiX7CYHaQ6MF2aMn0Ydo4p5nXYpJARyxLC+cTVT8HiBWJFh
         aGsFDd5jslV94c/dJ5MToNNmnTMNyGvyXRDg6ILPeuHejMSwe+RgUUeOjz3myeN+8Li3
         sQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804404; x=1730409204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK26aUi6oOdLrlZvhuXktuYwEbsoIROsGkYCLCMengk=;
        b=nyDmE0+s9c/+RI1Qm7fHu8D1OYHG+tz0VnM3I43xwsgFoH+NXvoDEk2BFzUou80vHO
         tVcOhScQkpLpH3Ikc2cfdHcnAm/2vlG8jxZ8jnEFnHdELWgrD6bMd0KetcMHA3TDmkyg
         ak4Ks79vBz5FQzMuV4Yag1lm/3S/oKDmzaSH/no+4n4DuummTTvOZcVq0AB/tIjETucy
         CV6ov8wrFgkQVIUA216pgd/HebpijbOFi7+YvdVJIdXndgMuRhiQt0nx3aq1Vdb0pAJa
         t687nrzbB+2gIxkHz2WMoxgfkWKAY2ZtQaOLd7Bg5+HD1svjKc6gIV28CGJQNpj0cf/Y
         91PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+91zx0nmXZQTg6p/m4DtsYReQJTCo56BLFxvGmNAhr7vcJT9+J5jJnnW7d48OP9pjZFGttjZVEkMKLIuc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuev1nbcw6YAQv6cxsUHaTyPDRD7BhUdu44hEFrfk/hUGi/qAZ
	Bfp9mFOQHPF6pRuF3B6OWZSKE2mzvghKdTDKYV/NevhI/uw++6pecXYgpSX0B3o=
X-Google-Smtp-Source: AGHT+IF34KaG6GXfaaaywzM5bq3qP6x5Bi6ZvJDtJlgnWUmss4RpecpUJtyGc1S55aYfogVCTDFtqg==
X-Received: by 2002:a17:902:db12:b0:20b:5645:d860 with SMTP id d9443c01a7336-20fa9e7f26bmr87877135ad.36.1729804403697;
        Thu, 24 Oct 2024 14:13:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab581e4sm9112686a12.50.2024.10.24.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:13:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t458y-005IfU-0T;
	Fri, 25 Oct 2024 08:13:20 +1100
Date: Fri, 25 Oct 2024 08:13:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <Zxq4cEVjcHmluc9O@dread.disaster.area>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023203951.unvxg2claww4s2x5@quack3>
 <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>

On Thu, Oct 24, 2024 at 10:35:29AM +0100, John Garry wrote:
> On 23/10/2024 21:39, Jan Kara wrote:
> > On Wed 23-10-24 11:19:24, John Garry wrote:
> > > Hi All,
> > > 
> > > I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
> > > master branch:
> > > 
> > > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > > Oct 22 09:07:15 ...
> > >   kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]
> > 
> > BTW, can you please share logs which would contain full stacktraces that
> > this softlockup reports produce? The attached dmesg is just from fresh
> > boot...  Thanks!
> > 
> 
> thanks for getting back to me.
> 
> So I think that enabling /proc/sys/kernel/softlockup_all_cpu_backtrace is
> required there. Unfortunately my VM often just locks up without any sign of
> life.

Attach a "serial" console to the vm - add "console=ttyS0,115600" to
the kernel command line and add "-serial pty" to the qemu command
line. You can then attach something like minicom to the /dev/pts/X
device that qemu creates for the console output and capture
everything from initial boot right through to the softlockup traces
that are emitted...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

