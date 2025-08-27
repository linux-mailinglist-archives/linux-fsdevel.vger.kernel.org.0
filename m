Return-Path: <linux-fsdevel+bounces-59443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F9B38B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 23:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4947B16631A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71E30DEA4;
	Wed, 27 Aug 2025 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oTmL/8S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B630C605
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331223; cv=none; b=AusukHZUkknUONg0IWXIudVQOUbMbsy/AQy17s8gGlVpmOdwm9R64vQLijVIUdwqAaOVGgmZi8XzbwQqNECNbOt5zcByCGafKE1/YKpZ+fgj+DyPbcAEgOq/d/QoYysonBFzK0PbTZcVpxNc7uVDxK+3XYooEi0/i6HMegcFoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331223; c=relaxed/simple;
	bh=p7brPDy2olHFfAC7S4q3Vp+PKM6Nm9aH82XdvCJ8awI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp8crw7wPkwfpNiPgPfFK/pXx65ch+hxHFa5ZdmbUJfoqYKEtOMG19WRI3rnFOkSJvOFUo+UHeBJSc6n4cBCEZoDesHCfNPcT7H/oKATu67n71kdKAQ1ARzGS5wYOFMcbMY+ZTBi05G1D3Hp1pfzp0k1qdvkyCSCie7g+VzxSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oTmL/8S2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7718408baf7so346106b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756331221; x=1756936021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1brA+k4hD/Yqcu3E+OzWK4Zw3vVchK7SPI3ZmUa+ClY=;
        b=oTmL/8S2U0QYx+4QQGCxzpTYxxbY2M847yIFjACe3uxKSxUtpm9qlqz7Ets000hEGT
         eIlJIh/5HkEN4W8yhMs7iQIcBBI8FCGR6qgATvk8QiXPmAACVNI2FuqOYKsPDLtIC01u
         W5n9bD10pqz1hqvN39di9RF5l7AwgDEZevx+3g0lZpbypK6Mg9oIF2eJWXPanYxofjOF
         sfFkKPdVPpnOU8VyGa/MjGDpJYfJSq4ccjwXjn9iBdSNAR9wIaImSVISg9EHkTjc4TcF
         aqb2Aygkz2vYxwm5obVtQ60Ayx/IneMQkZDZKAS6Fg/q94wLCXZAqV1rvfPcFRjB/hBz
         ADRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331221; x=1756936021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1brA+k4hD/Yqcu3E+OzWK4Zw3vVchK7SPI3ZmUa+ClY=;
        b=qyIcxX9qhHVCDzDW+ChIkzFAaNHQaJoecvcI312x/XmgJD8uIzktSsU1CVRdWMgb9K
         6cs0O31bL/TZt9oHkXuj1gfZ76iAXJ+VB/xuKJEk9K6KsOQSST6wtvpzMxQB3moHU1OI
         GVoXZZsxmd/AA+DuU7TgaTpW22HONxIEu943j3e4CofNki06JxYYwPOhd7BHf7pEaIL6
         dvJN1PxX5gx7hO0jdzYxIycEdBugj7CWEMPNRmJf0RJQM/jvV4kntBjmziu39YMAajlx
         zOcNAt8v6c4Ap/iKTrHKeUjBSXLNM7q5tcZTv9PpVjtUq7i/RbZhVaW1k5dZG74Hew6M
         kgOA==
X-Gm-Message-State: AOJu0YzNntFqjGPQFCf8Ld2UdHVnZdcD5IvDGN2662QTKwyHDOCeRHJ8
	8zsGeXPE3zndyTuOE5RTWzuiVNmnVIIQZEP0SaICOBPW53edx2aUUgAkXIhDO56gFs8=
X-Gm-Gg: ASbGncsRqk418ajKnxnr4rxbZZ7FA/YRkCig8vb2r/tuYrVy3fYlbL6tkzw/L1WY0+I
	7Li1TeUmUCjRFnYruvdatezAkdkfNJTtw1ibVkgqnplahVMGJO1mKznSOs9VtFpPt345A3uJ7lU
	LDF2/xZLFfpDHq0MsUqz+MqeGq7sE5kV4YwLyLymQpjAqSGUMzdre1ek41uPdDFCxZU8Em6PB+g
	N4JC+i29U42L+1qSMq/lTqBameV+mpqFq1MCEASjLaWJb5gIVgOMfY+r8vV8FmN+zKO/oQkehMd
	OUDUbkqONKryh0/SfT0VQVgU3RbOpQ/33vMEAOzEwgLI77OX6jkxWjCOLESxdYwDu4aBrtt9lfe
	pMK4npXKTklZv/G2Ltr3muVzfI1PytkpCBVK4BSrzW3gdFMpaIFXHu2g/1TmCJ8ckJbcz4SG50f
	/sjTRt8gxC
X-Google-Smtp-Source: AGHT+IGwubMhrkeveyZScO9SyGs6JfX0VeRusyOBY+29aVn++TMuUkFVK5pCfTn+imoo/NPkWa8qcg==
X-Received: by 2002:a05:6a00:14ca:b0:771:ea86:3f73 with SMTP id d2e1a72fcca58-771ea864584mr15877772b3a.32.1756331221445;
        Wed, 27 Aug 2025 14:47:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f34ecccesm6566839b3a.61.2025.08.27.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:47:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urNyr-0000000BvQF-035E;
	Thu, 28 Aug 2025 07:46:57 +1000
Date: Thu, 28 Aug 2025 07:46:56 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Message-ID: <aK980KTSlSViOWXW@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:16AM -0400, Josef Bacik wrote:
> When we move to holding a full reference on the inode when it is on an
> LRU list we need to have a mechanism to re-run the LRU add logic. The
> use case for this is btrfs's snapshot delete, we will lookup all the
> inodes and try to drop them, but if they're on the LRU we will not call
> ->drop_inode() because their refcount will be elevated, so we won't know
> that we need to drop the inode.
> 
> Fix this by simply removing the inode from it's respective LRU list when
> we grab a reference to it in a way that we have active users.  This will
> ensure that the logic to add the inode to the LRU or drop the inode will
> be run on the final iput from the user.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Have you benchmarked this for scalability?

The whole point of lazy LRU removal was to remove LRU lock
contention from the hot lookup path. I suspect that putting the LRU
locks back inside the lookup path is going to cause performance
regressions...

FWIW, why do we even need the inode LRU anymore?

We certainly don't need it anymore to keep the working set in memory
because that's what the dentry cache LRU does (i.e. by pinning a
reference to the inode whilst the dentry is active).

And with the introduction of the cached inode list, we don't need
the inode LRU to track  unreferenced dirty inodes around whilst
they hang out on writeback lists. The inodes on the writeback lists
are now referenced and tracked on the cached inode list, so they
don't need special hooks in the mm/ code to handle the special
transition from "unreferenced writeback" to "unreferenced LRU"
anymore, they can just be dropped from the cached inode list....

So rather than jumping through hoops to maintain an LRU we likely
don't actually need and is likely to re-introduce old scalability
issues, why not remove it completely?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

