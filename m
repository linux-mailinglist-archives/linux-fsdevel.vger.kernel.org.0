Return-Path: <linux-fsdevel+bounces-25195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD881949B93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6751C1F230C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50B175D56;
	Tue,  6 Aug 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OW1XKP1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14C175D20
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984673; cv=none; b=R8H1NNz4IdJpUlTiaBZJrNZSjhlktZyIDXMMFLRA3oYs49+kKhu8YHt+37RpL/Lgck1+eq1Sd28JgTggdMDnHpEat4G6Dyq240UxcYY2rH78il+il8MvXdxN5L/bhsLTb9xl6Vefywa0I6jINJTee7D/RYb7joJdBkOMKCVP3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984673; c=relaxed/simple;
	bh=v2B7nVx7bGwylS1Coul36Jp/i9HWOlxXDCVw6QkBijA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhxifP9s9Sok3LAoOheiAtgzvlvj4y0o4WjaErfH7yd5if+mh8cUw+E4T2KUXy9jeDpMmdrnDX/mnxwqeImXfxYCE4x9K2lb9wEKDiYvyLlYF8PdEviKQ5j6F3QMh72uGVifWcLjR6I11UnEc6JtNIdRWwte8RsTKX4ab622j0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OW1XKP1Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fdd6d81812so10194605ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722984670; x=1723589470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QB3pdYOMTN4zfS35rYEzvo3b4e8uJgrA8HIiP1Z9cOg=;
        b=OW1XKP1Z7fPLs+FQK6koKjaoAh56LIQe4tlM4d5HcfK+4AH2IAKLK/qY05wIiUFBGB
         ICzkiqyEllzcKo+PUdePI39SC7XlF2YFaK587zZF7t1Tiu29FSYDQHIFyTT13Qt00Vhu
         n1LduAl0UIbsQzBSEVO0zuJsoj2TT2P0EJT8BhfKf5Ln6MvEmGNe9P/j/taf4awYQC32
         cPxdRwnGhhwSt3ljROGFcnUMjqbm2U835iAN1tI36Y7pAR7acDXJEdmm3UhevcSsaLCd
         Uo0NX8Hb7J3vpuO0jIqYv55IMJdN4Ns/wnPI/yLJNKQTwIcxL76JoXOw8U5XOyUWe1w6
         ksnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984670; x=1723589470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB3pdYOMTN4zfS35rYEzvo3b4e8uJgrA8HIiP1Z9cOg=;
        b=ZsoYT7aedEsejORMw2eHbAZpQ97fyWWeJAZrt+OxxpW3gIpVkCBS/YPL5zdaYiV2iV
         jlCd/GMtPmfZtbWLDEZaigdr42ix1sxUpawa8p4PdA+y9HbccuJ1GzKxu+rtVrvsNPtU
         2opCNBIoB7yp+Jjdok2PUSkw8GtlEIvxeEu4gLBx9PElAOA3UmtBFRgE2HgfuI6CTazR
         icra3YahmbwvLqj98L5cMeDVox8vTGAUUYbWy2udeVr2JlRUBARcNCtmF1A/Kij3v3f2
         Fjt2fVoC3GLnuSWAj6eNSHl0KB12l4rVmcJsV30I1t38TEAvZhBsuta0zTDR9J8mBJJl
         ciOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5VAcKpE1EfNf0QWCLZk/p+EDef+4q6W9VhG50xvunh3UYELyhfQE9w/FRN/+QYeqoJCV1ZNt/hOWvKvyijCTLK1mnvnqdzx+/jilhLw==
X-Gm-Message-State: AOJu0YxHHAxKlVrpmqFlvsWSIzKPUaENiBOLYHAmZYAvbihzs5HWoN1C
	aA8P3zLjtwkps2OEvmMRWCNx9kJpV5LCoBAkAONQGCXmdcfN+DQ//IiPDvqLA2o=
X-Google-Smtp-Source: AGHT+IFE46gLoqQz8l8cruTk5/OYiCyXCPpy+CMOkGB+am/kp+K4IXuhCfx++xe6zztsBZajWiT0Fg==
X-Received: by 2002:a17:902:d2cf:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-1ff572d48e5mr238212395ad.39.1722984670579;
        Tue, 06 Aug 2024 15:51:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff591764ebsm92926865ad.197.2024.08.06.15.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:51:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbT1H-007sHp-3C;
	Wed, 07 Aug 2024 08:51:08 +1000
Date: Wed, 7 Aug 2024 08:51:07 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <ZrKo23cfS2jtN9wF@dread.disaster.area>
References: <20240806144628.874350-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806144628.874350-1-mjguzik@gmail.com>

On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
> -	if (!error && !(file->f_mode & FMODE_OPENED))
> -		error = vfs_open(&nd->path, file);
> +	if (!error && !(file->f_mode & FMODE_OPENED)) {
> +		BUG_ON(nd->state & ND_PATH_CONSUMED);

Please don't litter new code with random BUG_ON() checks. If this
every happens, it will panic a production kernel and the fix will
generate a CVE.

Given that these checks should never fire in a production kernel
unless something is corrupting memory (i.e. the end is already
near), these should be considered debug assertions and we should
treat them that way from the start.

i.e. we really should have a VFS_ASSERT() or VFS_BUG_ON() (following
the VM_BUG_ON() pattern) masked by a CONFIG_VFS_DEBUG option so they
are only included into debug builds where there is a developer
watching to debug the system when one of these things fires.

This is a common pattern for subsystem specific assertions.  We do
this in all the major filesystems, the MM subsystem does this
(VM_BUG_ON), etc.  Perhaps it is time to do this in the VFS code as
well....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

