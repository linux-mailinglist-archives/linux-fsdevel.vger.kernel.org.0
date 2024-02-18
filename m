Return-Path: <linux-fsdevel+bounces-11944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE648595AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CA41F219F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C6B656;
	Sun, 18 Feb 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCZ6jDrb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEEFC1D;
	Sun, 18 Feb 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245287; cv=none; b=Kp1fNginZSjcUy/EPBoswyRuFL5aeZ1U0l3XaSYf4ny+SA06+hpAysSLGJjt4sz85vGHW7Gk1Pnr5yWYAB0ACsvsHJhAr1DDqD+3f0xKwDaLol7QhbFfDPDluO4f98LMDzTVarP8vFQRcGEz6i0/difNNHnTYpj/CudyQ4H2crE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245287; c=relaxed/simple;
	bh=qc+UCTRb1KR6l5sto2n9TbI/UzZLjuY9XDSXQ5LHKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6hpkoQKEqeDbtQMaPKkzayO3rztsi2ythfFxgBBxA1HpnSV+bx1mqZvYQ/B+KIFIe7pOwfDDjThGoUG2FRo0PUWpVqTJ5M/74iSbTMVy9aibYhSpNXLMGQUiey2ps78K+vHNKd4iRd7V0lR1HLVLhPQ1vGMgpy8njJUqdGuB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCZ6jDrb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d32f74833so422840f8f.3;
        Sun, 18 Feb 2024 00:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708245284; x=1708850084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqWKji3lDeoxYSsJBuZx5zJrttqSuamWNHrVMpRLY04=;
        b=PCZ6jDrb4natI1o3DeA7VFEV+eyCUL9aaUbEXDbY6zErIPN9rrWj8Tnwxkuvjt0Lzw
         aJEvoYVw3oFgH3Zq7zIFGi3t/BGeeZiIwXGCPO05sSHZQhSRqxYByTLq6/tAB1nmwf7s
         OBU26umaxIUC6xgSKTm8GR8EMo+SCKF8QjpO4oFkITvl4wK7Bcj5WmE4IfYwE5QrD2W6
         NI4j+twxptROZTn0Cpga/o4lwX8Z/dBzRYIZXFNffzWWoAh/rznQmvCbuWP5IbMqCPgd
         Dhni4OJCHvHkDb4gxc0QgvOxTny4Var5CMz/tWIUtgz5c5QvQHN85GU7JDm9ur3HI99g
         8OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708245284; x=1708850084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqWKji3lDeoxYSsJBuZx5zJrttqSuamWNHrVMpRLY04=;
        b=oAGeoohswDPyFIKx3SSYDXDtqioIuiqsEtY8JGRtGP2kLRvm1jAhx6Oq9/iN16h1r7
         EXgS1Uuj90eJqsgyyVILsIKWtAi+hvaQr7l7o+23q3RVr3yZnTkUaJH3oDWJ9bxRTUL9
         sxwOWwV/e49bWbHrdnyy6B9+sK1j+m+qZ7BrzW6ZFX90IYhXW8HKOEuX15g4Vu/lbaFL
         O/hvJKb7PLAlozCt4YWUiutuoCWcOP0N7GeIqKinyjOnU1aY61dzw0T522jzaKEG4jae
         erf3QZL0DKE2OsSJqwA8o0uWfo7KnbeOxIOYEWqZk/Ak1tRpynMrYgmuBPPlRXOASCS+
         /IZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq5YX8vazi9JWjE6PNoeWCuQz9w8rvLpDhASV/qBV0Ig3Tfj22/sYv9Y6rmf4osFmqT2nAYLsSqUhQpbR6i2Bkmppmvc+BtLprO84ONRuUzN6K5Fn5csFV09hwc2wx2nBFHy8epcpfC/tAzhuWXmwCG+6BTQ==
X-Gm-Message-State: AOJu0Yw756mtZ4e4no0xTMexrMljd8fUlTbSXgtERLQh82zgIS58O6q6
	/uM/8KgZnqjXaCSE3Uq7gVeVaBkOcvqPEEX8YKazXCQp6tMzqYmM
X-Google-Smtp-Source: AGHT+IHCVMjoAp45T7U3Tv/4Nlcw9YXWGfagh2yClHkXSUbyewysaSHeEMIvNCLRM2kk3ZUTOt1TqQ==
X-Received: by 2002:adf:ea82:0:b0:33d:29d3:1aa2 with SMTP id s2-20020adfea82000000b0033d29d31aa2mr2002036wrm.12.1708245284238;
        Sun, 18 Feb 2024 00:34:44 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:63b6:5e21:e19f:4684])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056000071100b0033d47c6073esm738533wrb.12.2024.02.18.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 00:34:43 -0800 (PST)
Date: Sun, 18 Feb 2024 09:34:39 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	Michael Kerrisk <mtk@man7.org>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240218.a01103783ca4@gnoack.org>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <ZcdbbkjlKFJxU_uF@google.com>
 <20240216.geeCh6keengu@digikod.net>
 <20240216.phai5oova1Oa@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216.phai5oova1Oa@digikod.net>

On Fri, Feb 16, 2024 at 04:51:40PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 16, 2024 at 03:11:18PM +0100, Mickaël Salaün wrote:
> > What about /proc/*/fd/* ? We can test with open_proc_fd() to make sure
> > our assumptions are correct.
> 
> Actually, these fifo and socket checks (and related optimizations)
> should already be handled with is_nouser_or_private() called by
> is_access_to_paths_allowed(). Some new dedicated tests should help
> though.

I am generally a bit confused about how opening /proc/*/fd/* works.

Specifically:

* Do we have to worry about the scenario where the file_open hook gets
  called with the same struct file* twice (overwriting the access
  rights)?

* I had trouble finding the place in fs/proc/ where the re-opening is
  implemented.

Do you happen to understand this in more detail?  At what point do the
re-opened files start sharing the same kernel objects?  Is that at the
inode level?

The documentation I consulted unfortunately did not explain it either:

* The man page (proc_pid_fd(5), or previously proc(5)) does not
  discuss the behavior on open() much, apart from using it in some
  examples.

* Michael Kerrisk's "Linux Programming Interface" book claims that the
  behaviour of opening /dev/fd/1 is like doing dup(1) (section 5.11)
  -- that is true on other UNIXes, but on Linux the resulting file
  descriptors do not share the same struct file* apparently.  This
  makes a difference for regular files, where the two FDs subsequently
  use two separate offsets into the file (f_pos).

Thanks,
–Günther

