Return-Path: <linux-fsdevel+bounces-22881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64191E157
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BD61F2473A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2415FA9E;
	Mon,  1 Jul 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PUYY55MY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CC15EFD4
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842016; cv=none; b=F15AUxYMNOa9d2LCvpkap6Thkx134E0n/Wb+MvtupsToztqJ/L7NYcksD9xoL8k2qt2YaiscuUxzDgWR3ZW/3awgvks2sT0Ylb610+k01/cFeUoVGYzRhtK/R51PpDoae2pZKJPloZxYJAV9XX5ELJIa1kQkkXkL7eZmNtJNX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842016; c=relaxed/simple;
	bh=50ggolp/r0VZjqr5XlambBewvkAet5ErB4zOQJyxh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROQ+hc4pEhc6160SHjvFn1wh3SeOhz06BWDCB057XtExXiIc6FWstQgvxuBWqqosvADaGlywilQY3PqvmNHBfCxI/f7g3oGd8h1oXK/CI9M45E812syDIIaLL0mQhXDiLRRE0sWaBKClWi1YXJjzbs7SSrYHlu+Xjwlbkbu1HPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PUYY55MY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b593387daaso31037006d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719842014; x=1720446814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGkmZLClwxRQ5wYzCN604PWlDaKRDeFDexxSEzqTfW0=;
        b=PUYY55MYXkvrx2UHdaUSt95HukXAUnkcoP/huWKxY9+pXiKsdIVggdmLbt6dbgHSec
         QHb1xmSOdYSWABIoHLk3xFNArEuq/Yw6n1L1YozH9xazcXNRsgwrZhsBOrHpDnNpMC+u
         N72T7KtbSH97Td3eCb7IdR6PjSHoKDC5EqraCtef9kA3+KWBj43pulCtw7Bhq3dnuzqB
         ME/UynyUh+UAMnvGN73mkF0R0b+Hu/rih6u7HIm4NOCnkwMJ9Y5G2k02mJOXymQMp+L5
         vu6Jjawo1E9c9VNbnAOOltlYPjX943eNFX5g0K7W0053o9vVNxL2lpBaGcuJKTcz5EfX
         BkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842014; x=1720446814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGkmZLClwxRQ5wYzCN604PWlDaKRDeFDexxSEzqTfW0=;
        b=Gr1TuFlVOy2PUbE/mfYARCI+lCXnE0eJMyJdstDeVXE4u6EbGuZ7kApImowd+70RfS
         tNuup8TDE71DvKK5t33pdJCSCN+DB2FjMK7fYNtznDN/LmLhWWYVZEZu4LM0EXDNOb0N
         i2YArgwU0gWTxudzIpVfHybob/2zCqMfQjt9rmUAJwUhYecb7ry6bIEfmW0oo64cNVWx
         /37hkEVf3btGeFg4/mUMLzpwOI/bTT9VF5/P924n3S1938M8kMOzRpt5lHGhn1VpRezf
         ZOUCGNHGEe+TD148V3hWw0X30JGwxq0AgUgRUh+BnuHwPYB3+gJjTWqS3ab1iCneeKOW
         eGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVpC9rEH2N4SXl6eHLi3DMgq4Es1rBe9yEIwW9RRSAMTXOnq85DoLUfwU58111YlUZC5YH81MuBz96D5zeP5IJy8FhRLZsfxj9bh2+1jg==
X-Gm-Message-State: AOJu0YyUQfxBtByS4hSs6HiGZsplHkNQKPx68J987ql2RXumaywEtI3R
	SQohwrrpnrsFHJ7vdlVWsh1hdpLpwbRa0utFJB9byu7M2RBMbck0YUWauLhPopI=
X-Google-Smtp-Source: AGHT+IHm2/95kxXclblhwH1XWI43VIUQy9+CryR0wDr5yVVClG9FOmbCdJsGBV8B1kk6bbVv/+DnBg==
X-Received: by 2002:ad4:4ee4:0:b0:6b5:337b:da4e with SMTP id 6a1803df08f44-6b5a5483dd8mr141333876d6.32.1719842014105;
        Mon, 01 Jul 2024 06:53:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e564455sm33241616d6.42.2024.07.01.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:53:33 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:53:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] fs: multigrain timestamp redux
Message-ID: <20240701135332.GD504479@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>

On Mon, Jul 01, 2024 at 06:26:36AM -0400, Jeff Layton wrote:
> This set is essentially unchanged from the last one, aside from the
> new file in Documentation/. I had a review comment from Andi Kleen
> suggesting that the ctime_floor should be per time_namespace, but I
> think that's incorrect as the realtime clock is not namespaced.
> 
> At LSF/MM this year, we had a discussion about the inode change
> attribute. At the time I mentioned that I thought I could salvage the
> multigrain timestamp work that had to be reverted last year [1].  That
> version had to be reverted because it was possible for a file to get a
> coarse grained timestamp that appeared to be earlier than another file
> that had recently gotten a fine-grained stamp.
> 
> This version corrects the problem by establishing a per-time_namespace
> ctime_floor value that should prevent this from occurring. In the above
> situation that was problematic before, the two files might end up with
> the same timestamp value, but they won't appear to have been modified in
> the wrong order.
> 
> That problem was discovered by the test-stat-time gnulib test. Note that
> that test still fails on multigrain timestamps, but that's because its
> method of determining the minimum delay that will show a timestamp
> change will no longer work with multigrain timestamps. I have a patch to
> change the testcase to use a different method that I've posted to the
> bug-gnulib mailing list.
> 
> The big question with this set is whether the performance will be
> suitable. The testing I've done seems to show performance parity with
> multigrain timestamps enabled, but it's hard to rule this out regressing
> some workload.
> 
> This set is based on top of Christian's vfs.misc branch (which has the
> earlier change to track inode timestamps as discrete integers). If there
> are no major objections, I'd like to let this soak in linux-next for a
> bit to see if any problems shake out.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I have a few nits that need to be addressed, but you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series once they're addressed.  Thanks,

Josef

