Return-Path: <linux-fsdevel+bounces-60888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9CB52858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E23680BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF4256C71;
	Thu, 11 Sep 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U7lkqRrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC3329F31
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570087; cv=none; b=q9xL5rveYAsSoxP7epFE7q0qQGnp9MMDT4L9+gAaJCytn4CBuInn69LpMjSi0a7e/0DnYFXIBb3P8fsnWAwZJBBUMUPlMmARDYKwEK78TsqOc/zGkwOFR8753yaG+XXURiGzAN8cxx1mMnArL+diaLbFrdJjjpNA6EZ1wPFDiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570087; c=relaxed/simple;
	bh=JLVGfMwisW3Y4JGot2IV80m6V+FOPM2PsbTbCgXGcNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJZzSwURgiD6Dqol1uUC61WtJv4bzr03vN4S3hT5aDzhBzT7B1+IEu1dTqqr1S46VAsBe+ALzJdVYfKpklEKBBjcxOgdWM0hRUncju0aZ+/kLy6bXQKxysQM4Yvb2X6uZPmnaCiqwQcMizMMD+I2PfNEaXL+4cMpzQ3GmbXBz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U7lkqRrV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b13313b1bso2212285ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1757570085; x=1758174885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7U/qSpu3brb3YBeOIJTTylaUCIcvX4SeZCWNyYbixqI=;
        b=U7lkqRrVbCuJAFHEae+IPf77lWdCcl9IPLjkxHPq1hDp6w/xxREPaRlIYLQqdQqPjf
         eqmGbQRw/LOz+9HugJNnu9uwdm0d9qdNlAoB/mONG6pFTLG4T6iV+t8YM07yPAKcvDjy
         kJlLiEAVfTIYJE7Unm+MX8kaEz8b9CHfJwPQsVymf94xxwz/ftSwODDzotlgD7nN+lk5
         TvRaCZ/7RKt7JLWuQsi9OC+RMhL6mAG0CfbhYlXWTwnOeVJERmAeGLHu8HO10Tv/DTAU
         ZUrvqrWCDllvAoQY8ZI3TuI7XbsHmZKPTpDuA7OrZqIsGHI6itChFo5s8yeJHYrWqfYt
         wYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757570085; x=1758174885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U/qSpu3brb3YBeOIJTTylaUCIcvX4SeZCWNyYbixqI=;
        b=ws5pnlpuwjCzPD0muB8gbeoc4eDuPlSXiErOHvfey5L+9/FWYR2R9Ot0hugzEO5CN9
         GJrsehStyDpvM3/DbI/eXR8n7Xq79QC1rF5rcmYeAUqgFgf31hYqsU9bcm50wsKJIyNM
         yppyh/3AZw41SOMXTnClzUU5njFVt9iANYaZwquGpIFd+GgUCgQXFooFlXqsWsEWRGaK
         7SbZJdC82+byrR/cdxqN5+Lhu8P1V+RGOTJZsHQQoovh+m/rgSSwVVq5nUF5j0SU3oOG
         izr9hiK0eloYveddErjj3IwG5pyqpf4rEGBpQRINIrMv+Gml1vwIwBbqOwGVpDXxRf9J
         bd8g==
X-Forwarded-Encrypted: i=1; AJvYcCVYULb65nvvJAeR9IJ0qYbfi2Db/RZmEX6+uJNg59zXQmXkg9Bqs+D80EJT5vnAe1F2PWi4R/p/bru3ejHc@vger.kernel.org
X-Gm-Message-State: AOJu0YyLH6WUTWs/Zs+WyuSyzuY8oJTneQDJqMRygp9g2cVsLcM65pbI
	uFQT19uydnnnslqbyzJUQyp74SauR+LvGGDwEaHLBlMqc5Cy8ijYEmz9OERSm+nEG1Y=
X-Gm-Gg: ASbGncsuH0QGdqev0+c71CaHD9IUKHgG8l/XikJ/lvzb3mE3I9tyR2NxWHrtTum80Ou
	vAiSu3FKfpXGIdFaUjdYfXjwAkHHFVrCcGqfMaZz+VBHeVumLCxd5dg6jKQn4eQekLSELYay5ml
	YuQgtFhKnXy2gN/TC96RX8/26nJwHo5qJGFuI9H1dCDnCcVAydJtsm+ChF8nFGdGfEXUAYS6uew
	0JyUoIyDNV2Jz9d01q/Ox/dBe7SGpjGvcrg8X8kWaTn4I1b95Gbg9kFrfbtb54wI43LgEJGC0rx
	iZ7Usc6EYfeTllhoN5qL8kqPFfyVE7CpBqJTs21FfRtB0JD8+gO/WXh/4VDTOLqRnCrFNcSBHIp
	0rHcoQYzIk1X+rK0ceUy4gTbagV7ZZUPkChlKRyRf8+eMsyd3GQvCr5y8nZhci4vq+jwWw5wKxQ
	zFlGe/ZL7m
X-Google-Smtp-Source: AGHT+IEJ8EWH4EX2E0dT8s/g+9UDN2nb1wl7crNvle8QYhSW73RtvbWKXJWPfnOBHU1es1wXSTrLow==
X-Received: by 2002:a17:902:c946:b0:25c:5a14:5012 with SMTP id d9443c01a7336-25c5a1457bemr5452105ad.1.1757570084813;
        Wed, 10 Sep 2025 22:54:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6c59sm6905715ad.12.2025.09.10.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 22:54:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uwaGX-00000000QEt-1mcY;
	Thu, 11 Sep 2025 15:54:41 +1000
Date: Thu, 11 Sep 2025 15:54:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/4] fs: expand dump_inode()
Message-ID: <aMJkIbDwuzJkH53b@dread.disaster.area>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911045557.1552002-2-mjguzik@gmail.com>

On Thu, Sep 11, 2025 at 06:55:54AM +0200, Mateusz Guzik wrote:
> This adds fs name and few fields from struct inode: i_mode, i_opflags,
> i_flags and i_state.
> 
> All values printed raw, no attempt to pretty-print anything.

Please use '0x' prefixes for hexadecimal output.....

> 
> Compile tested on for i386 and runtime tested on amd64.
> 
> Sample output:
> [   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
>                fs sockfs mode 140777 opflags c flags 0 state 100

.... because reading this I have no idea if "state 100" means a
value of one hundred, 0x100 (i.e. 256 decimal), or something else
entirely. I have to go look at the code to work it out, then I have
to remember that every time I look at one of these lines of output.

When I'm looking through gigabytes of debug output, it's little
things like this make a big difference to how quickly I can read the
important information in the output...

Otherwise it's ok, though I would have added the reference count
for the inode as well...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

