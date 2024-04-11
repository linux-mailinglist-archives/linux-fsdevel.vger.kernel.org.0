Return-Path: <linux-fsdevel+bounces-16736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A88A1EDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BF81F2B7CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D06134B0;
	Thu, 11 Apr 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P1yZ9b1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41F205E15
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861148; cv=none; b=KtHmJkIEBeIj4nYlHlERTCepupyTrz1fePoHwR125NnjuX6kvKDHt0mVXYkDGde+hwTgxiJwXAz+pj2ufIdKOfA60LRpXqkQmPb5ldO7hiCmn0pW5c3mlk36S5eRsMtMwgEqdzRDcdPwigcIUUWrewx7eLhDGhbKpTeeZbaM94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861148; c=relaxed/simple;
	bh=oVMdIyNqBeXSXnx7wDKSkd3EgqG0HvyDwjqk5K10aFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR90NVEhecH0Q4mJRzPWXNUOyQaIIQAyU0DvuDQevGE/k2o2jMoJPrnswVcffESxQjjJ3KHwEzK/nez8/c9K2saOAg8PMduKI+GjRfqXwQJFEBy+nnIen73kkpDwsZxSyaBEU0QqjRTNnEAXwRWIw6On3HYwEJJh1Vqhw12knGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=P1yZ9b1Z; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d57bd577dso8286385a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712861146; x=1713465946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT33Nx43+d+3gMdSLbU7Cu58/JxP71aX5N4ktQ89HWU=;
        b=P1yZ9b1ZHRnxlw1wdhYCSReOoSmeKNwiuVZD7w8ORP+hkOLsRdleler54eX0XJiF3s
         PGS3VLuckCQIxP7hl8Bdv4RDMVwWF7FQKGaOwkuRbJZSiC5hmaVVLHDRz565aMZpMCB+
         O1hy6GnK13TKBxdpwMtDLbyKbr42+bz9H6YLnLA2E25SbMSagBstjD9GSd9tB7kEFxJn
         YX/dZc3jPO+huqzqZWujBZVsPXraaoxue+91fefND+MWft5HTz8ZaeVQMp+Od9eEbh6c
         hhQNJM0FgOIo8rcMGkzOtvouw1m5Alj6f7SUEyOEG5U8DZoQYp9wSJI10hQ/1XFEoGVW
         L3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712861146; x=1713465946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT33Nx43+d+3gMdSLbU7Cu58/JxP71aX5N4ktQ89HWU=;
        b=RcaxQ7pSB9B9t8cl9UmBeVDJephF65loIiF/ElCKMZ+tDoPeJUSfVtpKygcWRnjoK5
         yMqe9iNBk2SytFeoqF/fZnqOP/rZWfnfOAykA/jrY6szbu5eVjudR1LdnD1rUbvmMdQ+
         As3vlQ/QPoRxRAFYBMNJQEy/9IoCBV7bDpPE6eqGr9IbGxap7EoVufVgL8Qhzex8UD33
         tA5otdcp1gAoexM/DPwYE6yI841GVrCn4bboiW2RK8rDVixKBs4Fnh8VlEE77wehYStS
         /eQrCuPGBtG4FN/6qOwnRB/gGgZsTBaAd0ZdP9PiSO6jVR9mfBuQODSsu3WJEe4lD6Oy
         NVSw==
X-Forwarded-Encrypted: i=1; AJvYcCWAV96to6OFre3w1WjACziHEK+VGtRR7/GZSXYie/AFk+ixq+MhctWsWXzHRqmlAgalbI++lQw9X6DiX6/9cpE0qXa1u86ruwCKEgclwQ==
X-Gm-Message-State: AOJu0Yx4Xs56fakbtr/kOa4yvozyNdVf0J1JDdKM6LUBLVUGBMuKaVtR
	c8S68vrNJVOWm6G+OgakIKDndI4yKizDUB/e/zU2GBspPfNDJc3Fp5PCmdJHsfM=
X-Google-Smtp-Source: AGHT+IGLaaNLGKir3cJVdY7/H7iSf6w4PHXqQuqqVWzoZf/NEr8GKe4qBLcjYGfA+RqTIe+K7c9yzw==
X-Received: by 2002:a05:620a:166c:b0:78d:61ff:d608 with SMTP id d12-20020a05620a166c00b0078d61ffd608mr492045qko.22.1712861145775;
        Thu, 11 Apr 2024 11:45:45 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c42-20020a05620a26aa00b0078d70336243sm1362946qkp.49.2024.04.11.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:45:45 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:45:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v4 00/46] btrfs: add fscrypt support
Message-ID: <20240411184544.GA1036728@perftesting>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <20240409234222.GB1609@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409234222.GB1609@quark.localdomain>

On Tue, Apr 09, 2024 at 07:42:22PM -0400, Eric Biggers wrote:
> Hi Josef and Sweet Tea,
> 
> On Fri, Dec 01, 2023 at 05:10:57PM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > v3 can be found here
> > 
> > https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/
> > 
> > There's been a longer delay between versions than I'd like, this was mostly due
> > to Plumbers, Holidays, and then uncovering a bunch of new issues with '-o
> > test_dummy_encryption'.  I'm still working through some of the btrfs specific
> > failures, but the fscrypt side appears to be stable.  I had to add a few changes
> > to fscrypt since the last time, but nothing earth shattering, just moving the
> > keyring destruction and adding a helper we need for btrfs send to work properly.
> > 
> > This is passing a good chunk of the fstests, at this point the majority appear
> > to be cases where I need to exclude the test when using test_dummy_encryption
> > because of various limitations of our tools or other infrastructure related
> > things.
> > 
> > I likely will have a follow-up series with more fixes, but the bulk of this is
> > unchanged since the last posting.  There were some bug fixes and such but the
> > overall design remains the same.  Thanks,
> > 
> 
> Is there a plan for someone to keep working on this?  I think it was finally
> getting somewhere, but the work on it seems to have stopped.
> 

I fixed up all your review comments, but yes we don't care about this internally
anymore so it's been de-prioritized.  I have to rebase onto the new stuff,
re-run tests, fix any bugs that may have creeped in, but the current code
addressed all of your comments.  Once I get time to get back to this you'll have
a new version in your inbox, but that may be some time.  Thanks,

Josef

