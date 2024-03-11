Return-Path: <linux-fsdevel+bounces-14090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ABA87798C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 02:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC971F21DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D442A35;
	Mon, 11 Mar 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YOkJfAcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3027EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710120766; cv=none; b=JZxJbN1HpSrRXXXT4Y4qaFQzHYjC1AR4F3z1aA7C8RxEH9DgOtcpIBPeVAo7wUnOq0nkD78KlHxrg36rlohA0+JrmGzaO6aNdE6sj1oPjM8/fJNsHSnN87HdTAFv4lrNIv7lCBL/jDYZrGYoA2g758J+RUkjIFR0aZNzdQq3rvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710120766; c=relaxed/simple;
	bh=Ep10hIbvrGsZBzXuNEE8wAKUn3c9mk49x3u2O0Z37zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxbFPVy4OKeNhSxIEyZiFmMaFK6w60PvILtdpebGoOofc/2ApvuwEx2/I4RYWzPBjNmqzxVCwXyuhx+OZ224bjxEmHcCo4FvclsuhNXC6GIH05WISD0OmBKIvcsFpFwCmUmTzdTi+bjF95r7gGTNmc+pgCkeZHTQB6cPpmGMNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YOkJfAcc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd5df90170so25779195ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710120764; x=1710725564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjlIphenCJKDD5eIjpHxK5YCc1VV/vBPjjvKAIpGaqc=;
        b=YOkJfAcca74DuFap45pMNViQfCFpWYMh6CrcqbfhNz6237TdEQf1s1g0g8SsuonONp
         llvIatj7OwZ0WDdCM20skN77amJz2i7ZPKQThIrVHbPiUxkhmV44BmRpbp0h0INBxmf7
         wZm4Q9RQlWGeL6zpWpFgrWl88tAH4UJtXA80RZL2mkeXiB/Ar+1QQId3wZucYsNDMYjo
         ky2ILh+ZN3ps++OPn60+/F287P3sQDg1Oc918UlxTDHIPjbrMJRJMEaImylczVHSxadj
         n0B+vwCz6PdjZaUMnUai8WEF5coYVHBBGxSFTug3FfXbhWFBu8RO1PkJK6P/FgMD0w16
         f+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710120764; x=1710725564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjlIphenCJKDD5eIjpHxK5YCc1VV/vBPjjvKAIpGaqc=;
        b=teqvIz6PutaRciQHVItIHcpfvLKLmGueI7sv+l/w8MZEsjqlLHUaMls5XzjHuQi68y
         uZUzhfaLE4Edu/fuU34Pi+VopBReh3Ih12Ia/4zR9Ez3CAQ5lOCUjysqrtEOMmBkt0eG
         JqHEvD1SFOEy8hUC1JpcLqwJWmY/hJMl3+g0vg2HTLkrJxlSQ0VoWTLCSvlhdGADQoyN
         bkq9BEQclMQq5VR5gnFmYpM8UQoGjR0SqXPp/DAcOkXxteNVVh5enbsjP2YnXzVo4qb8
         0gVd8DORI+m+NhfvKZxfiQy8nq1Ug9P5k+0P55HyMri1zLj9Abyxf0sSQZ9waW0E/e4R
         uqmA==
X-Gm-Message-State: AOJu0YyFPYDlwWBV32YJ59ZKMb8pIE15krnYtiPbnKJcne+UIOXUCgC7
	VlQMIA7w3OR2Bnegel0h1LgYxRLXWpfBG0vTeGXuAeIV4VIOvOkzBUAwf5tLwCtbQvtiT2cTjlg
	b
X-Google-Smtp-Source: AGHT+IH+NtS7mbgOvrkH19MDZ7dENV89+UNwMW2eSp3aVp6hJQlHmQysEFaa1wBDx0w7m51hi+vw0g==
X-Received: by 2002:a17:903:1c2:b0:1dd:8a51:7b49 with SMTP id e2-20020a17090301c200b001dd8a517b49mr5848433plh.15.1710120764190;
        Sun, 10 Mar 2024 18:32:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001db8a5ea0a3sm3354891plb.94.2024.03.10.18.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 18:32:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjUWv-000FRw-0s;
	Mon, 11 Mar 2024 12:32:41 +1100
Date: Mon, 11 Mar 2024 12:32:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <Ze5fOTojI+BhgXOW@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cieqhaw.fsf@vps.thesusis.net>

On Thu, Mar 07, 2024 at 08:53:43AM -0500, Phillip Susi wrote:
> I have noticed that whenever you suspend to ram or shutdown the system,
> runtime pm suspended disks are woken up only to be spun right back down
> again.  This is because the kernel syncs all filesystems, and they issue
> a cache flush.  Since the disk is suspended however, there is nothing in
> the cache to flush, so this is wasteful.
> 
> Should this be solved in the filesystems, or the block layer?
> 
> I first started trying to fix this in ext4, but now I am thinking this
> is more of a generic issue that should be solved in the block layer.  I
> am thinking that the block layer could keep a dirty flag that is set by
> any write request, and cleared by a flush, or when the disk is
> suspended.  As long as the dirty flag is not set, any flush requests can
> just be discarded.
> 
> Thoughts?

How do other filesystems behave? Is this a problem just on specific
filesystems?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

