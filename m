Return-Path: <linux-fsdevel+bounces-39628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E4A163FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 22:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D612163B6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD231DF253;
	Sun, 19 Jan 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FSHwCdyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20F155345
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737321347; cv=none; b=YZVdxpk+6lvbZyM8PySRUZLWtSna/Alxow3C/AfIS4aKEnrd9uLqc6D2J1MuwdKVapm7k5mrEOq/oQqlTehO02hYoHSPbbnIpUwTDDYkGs9laAxFvNmDtldnsHmQwb2GEOYOt86SDFAVL2g8/I/m+yKggtR/d0yhF4aIZjYWum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737321347; c=relaxed/simple;
	bh=n26uPyR3sKUNYNgSXLsv/bkEufIv/iqF0qALQVWcOPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDR4a5PeX1u41uNnoa9tWI8EVLrDlwd1HvlpHhZp0oxmBl5WjzOmbvTJ/WcZfLjmbgLftO1FjpxFL7nyA8kafK9ricPaA2iMHrxzzHQfQ6j+Vm8SYXIJeLVDyRNvRHZXoMAQrfwVWO3kQxTo5DmthEPDqCT7337KA02fODHySeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FSHwCdyH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21680814d42so62365005ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737321345; x=1737926145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWcG5ouW6h9/RXHk4L650VSDkwl1OWZ+bmDDUe69BYw=;
        b=FSHwCdyH4kqOm8p3QN/b0T8MRzK0E74UyrmUOxzDNPCWNPbk2RdCANkOViVpC3kuEE
         VGCIOZhyLuTIMnDDYIc8xqlQjHap9Du+IY7tDTr/TiK2MU7vfAEqwFRYbenzjiMHil9V
         +VWqWUe4S9vEVoq6xr49Ic2iNfUHqeHUjv2xOOEC5m4EYbmou1dTnbg9jikSlh7X9/0k
         KVy3N+I9Bi5SgH6oRBIm5s/PO/4rhqgrjRkegTTqaORzbCPd9yn9T5kHJUkxBXUfUXps
         iot2faCQMLHwyOuaBr5IrXGs6YUwsDaxJ8y8NJ7hCZFl4ujGJ7UgZvEnQZgZ8aPRiH2e
         e52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737321345; x=1737926145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWcG5ouW6h9/RXHk4L650VSDkwl1OWZ+bmDDUe69BYw=;
        b=Wxf8ahwDbn5AS0Ue3pJJqWmE38t5Zibw/4rSh4jhzlI3tIeZ/pTM66nG1cJ7e/9/02
         O9L6rDGFN8thlqmebkDtCeIr6s+46lox11Wvx8aVI66LguLi53CdajSJh4E+vWPDT112
         DpTwO8SqggpcCerVIGGqowZv9aLbsKhgNVtwx2RdrkvGEcNHWPKTVw0osxgWNhA0OKWd
         eelzsfaGGNevHzDijnHikzel/ha/kEjCgmjnaR+ROKd3x1Mipq3AE6pu0C6wHPXCryU2
         T+z46bxX5vs4QluKzjaYKt7gfypDw1zHenmPYoxcCS5imT3P4EmmksjxxalabFYmMzHL
         sjtQ==
X-Gm-Message-State: AOJu0Yzj0rHir2R2Ky0CE6TTgmqp6wm8FRgZJM6noaEEMyRPb2ZAx+74
	jO0G1faHkEWakPsPlE9lIe4SeOUifK6XbCvPWuVd6FG7/a1ZbQy2wzuGOYMeBlU=
X-Gm-Gg: ASbGnct6pmV6OqytKOg/Rdeuh+k9Y4qJcMiK8+qeCSbMD42A21snbyERRBLzrOXOszL
	9VKMed+akBjTTju9teX2m/RFsO1PvtQYj5paIP1hy0sHKX7K4Hj9RIhpUBtNQInTi2nRg6AjvNN
	JJEXE4JU6eBnmfNK8WUBCJ+7qYMdrgbtFJt6zxkvKJT3sGkcxyHmtesGsGFBipFIWnnPpbF0jLS
	WFdnMxp/Cd9IWegsVsAPzqkyG9MtjTTQIgU2pCdvrVkZ7NbG3d3fXVDtabNHK2jhzWMIPZ4MOHl
	UxG48CR37w3+6oNFfa7XJppQRmRpul6Z80IBkjyn7hGZpg==
X-Google-Smtp-Source: AGHT+IHTi720iQ+BExyeaeitISXd3GZjj2ivtUBZfKmIDA5FXcSfQIQkh+PijJJuhDlZ8CtF5zzLOA==
X-Received: by 2002:a17:903:186:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-21c352de48cmr136136445ad.8.1737321344933;
        Sun, 19 Jan 2025 13:15:44 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a9000sm48094265ad.118.2025.01.19.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 13:15:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tZcdx-00000007z7X-2j95;
	Mon, 20 Jan 2025 08:15:41 +1100
Date: Mon, 20 Jan 2025 08:15:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
Message-ID: <Z41rfVwqp6mmgOt9@dread.disaster.area>
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>

On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> Hi all,
> 
> I would like to present the idea of vfs write barriers that was proposed by Jan
> and prototyped for the use of fanotify HSM change tracking events [1].
> 
> The historical records state that I had mentioned the idea briefly at the end of
> my talk in LSFMM 2023 [2], but we did not really have a lot of time to discuss
> its wider implications at the time.
> 
> The vfs write barriers are implemented by taking a per-sb srcu read side
> lock for the scope of {mnt,file}_{want,drop}_write().
> 
> This could be used by users - in the case of the prototype - an HSM service -
> to wait for all in-flight write syscalls, without blocking new write syscalls
> as the stricter fsfreeze() does.
> 
> This ability to wait for in-flight write syscalls is used by the prototype to
> implement a crash consistent change tracking method [3] without the
> need to use the heavy fsfreeze() hammer.

How does this provide anything guarantee at all? It doesn't order or
wait for physical IOs in any way, so writeback can be active on a
file and writing data from both sides of a syscall write "barrier".
i.e. there is no coherency between what is on disk, the cmtime of
the inode and the write barrier itself.

Freeze is an actual physical write barrier. A very heavy handed
physical right barrier, yes, but it has very well defined and
bounded physical data persistence semantics.

This proposed write barrier does not seem capable of providing any
sort of physical data or metadata/data write ordering guarantees, so
I'm a bit lost in how it can be used to provide reliable "crash
consistent change tracking" when there is no relationship between
the data/metadata in memory and data/metadata on disk...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

