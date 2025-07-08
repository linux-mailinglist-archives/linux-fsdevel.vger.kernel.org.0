Return-Path: <linux-fsdevel+bounces-54216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB3AFC1E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE1E1AA5151
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565A21ABBD;
	Tue,  8 Jul 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Lq6t9EsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752F1A3179
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951143; cv=none; b=aGfceMFDV8JAh2dBUnCkNwkwwWpYlrEw0WjzuCOphTZLUiK1KTKNeDfIZtcQXfkFBGv0gxZ2SIlI3EKfY3355MwbHa9QkysNhZrFoJu4Rwy9XXlI1xldWtjCB9BKXV/2F2MY3BUKFxY2mW366fQRm2zgiPGaE4dsmOk/mmEFJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951143; c=relaxed/simple;
	bh=XbHthtLjeMxvpEsokUL5L6zTC/GYu6YVUUjUxh0xdYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWKzmXFUKgwZPjof7qiZNyKLOjPafoJ1z83ZR5i9Dratu6ZAa8uNOYnWUXSk27RXHg1pFqJ4JIfhciu0K6CDumWA9ehseHG/pgat57d/GH+EpzDZ7Uvu9mt1rDSkeIoZJPqTroWPtx2yrz5AhdAbKZQoEeWLjb8FlP09/e5MvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Lq6t9EsG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3442320b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1751951140; x=1752555940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Omo6LLgJyVULzloJLyFZcLDr3jdzW0nRsKBFp8OqSOU=;
        b=Lq6t9EsGFnlp7AnwjgoAF3psgg0rrSjSLK7LyHRXhAxOBYNaAIntRKD8jPp4XOQXS5
         8hXMO7sLneKiwGG57HZ6eI2g0rtvC3cOAlA1UtBRweFciexCAcIzEXTnechd+iR/OyHh
         pfN7qLp4E80a4s1dFdbf/qAIBrNnlmzIR9SL/a4UTxAJK09ydotWicn/HQM4yCit0Mab
         1Ip/Ke5PdtbfBpjz1zCYaCpD6pea0hE662Cad5H/bIix2hmub1j+vsnnzGs8DMYN9WCe
         xLmWAHan0TVzxQUuIhaOG1P8zLeUt+RErKmJ6aICAoZZuz+IanwtDnxgqfobbdAZBNI5
         v/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751951140; x=1752555940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Omo6LLgJyVULzloJLyFZcLDr3jdzW0nRsKBFp8OqSOU=;
        b=hjCG/sKQoa0YWmP6xEwYvhxMgN4jz2CgrwSxAyj1THxKfZ+pi4SHU0j7JaqmA71OK7
         qcBetpxHS/4xAopLn+zgSSv4WOzsCCA/o7XrObnOEHjCaYiWvfBI76XJH1YvlmXUoRs9
         /Bs6MXRI6DrwBjdRAHxk+jIBG/ZkvVRMNRx8XEPEmTdxvJwnXUUwRhe66Q7CUPo+0WaT
         WeuRDxHb8Y55ha+/xUCDWcKDei17ZhWjx9dRxlZ472CBRD7t+2bFhb58FfJ7myolYnx+
         SVpKpdgNabWrCBSpSik6IU2t/GkRdniJxRwA9B1+omfCszQCm530fz6l+GOPJ9+Q+9So
         CjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3uFfTgh7ITa9w1soJ9SNuGx/epOyADqNzo/eTAC+adSXjREpnL2uxJNf08lr5pEaQboJJ7EjpnTl/sdPV@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtRzB5ltX+gT2KrZOgSbqR312olO8kQnVQTAdaeya8LDySfOS
	AEGrjVHEkQgXX2ZOloAo/0Rm1cFmbsNPvFCyTS8o17RJV1kw3zxCIYSfn2mzaWrFyaY=
X-Gm-Gg: ASbGncuEScpNP3z7fzvoFgywQOuuUUHCPPGCy1Q56VBXc1m/qF3j2o2SPcOED3s03va
	5mTtQwR1r1tUAebnbnRgAdyQ9mi+LMvZoxs0F1sLxMaxdErf6ERozcHKQQ+0GmfybNlvCtlrEoF
	SIlzS/sUYSMYfTX/A7MxfIsFXMpRPTAm5u0kzfqBPB4VzkhIyKhbcLYH3jK6AMGfc1fB5J9IORA
	9uvCih6X5Nb5aogJGivLMqUy+vpq0cjEln6Vjof4tCEAIuqe8IVHxtzaJF49kY6hh1ETXksL4Kk
	TmRh43j9YHkvnNfRyz6CCInRVJ2tMy+jp+efM1qwaXUTE3DWtTrNz/C3AYUFDqGfIG/b2GHLxCj
	NyuD9pic1xG72V1G63kSpeMunj/ew0kH3mJTw5A==
X-Google-Smtp-Source: AGHT+IGsHUT6Bi+76saZTNBr04hdGSYcx5107pQyHdDmPfUk8q23TTXe1KfcBJmRM20GAyE10VbqJw==
X-Received: by 2002:a05:6a20:728b:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-22b4449d668mr3073800637.25.1751951140491;
        Mon, 07 Jul 2025 22:05:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3918d81a3fsm4275006a12.15.2025.07.07.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:05:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uZ0WP-00000008J2c-0q8k;
	Tue, 08 Jul 2025 15:05:37 +1000
Date: Tue, 8 Jul 2025 15:05:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aGynIewLL-05fuoJ@dread.disaster.area>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <02584a40-a2c0-4565-ab46-50c1a4100b21@gmx.com>
 <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdce1e62-c6dd-4f40-b207-cfaf4c5e25e4@gmx.com>

On Tue, Jul 08, 2025 at 12:36:48PM +0930, Qu Wenruo wrote:
> 在 2025/7/8 11:39, Qu Wenruo 写道:
> > 在 2025/7/8 10:15, Darrick J. Wong 写道:
> > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > result is still a more generic and less duplicated code base.
> > > 
> > > I think dchinner makes a good point that if your filesystem can do
> > > something clever on device removal, it should provide its own block
> > > device holder ops instead of using fs_holder_ops.
> > 
> > Then re-implement a lot of things like bdev_super_lock()?

IDGI. Simply add:

EXPORT_SYMBOL_GPL(get_bdev_super);

And the problem is solved.

> > I'd prefer not.
> > 
> > 
> > fs_holder_ops solves a lot of things like handling mounting/inactive
> > fses, and pushing it back again to the fs code is just causing more
> > duplication.

This is all encapsulated in get_bdev_super(), so btrfs doesn't need
to implement any of this. get_bdev_super/deactivate_super is the API
you should be using with the blk_holder_ops methods.

> > Not really worthy if we only want a single different behavior.

This is the *3rd* different behaviour for ->mark_dead. We
have the generic behaviour, the bcachefs behaviour, and now the
btrfs behaviour (whatever that may be).

> > Thus I strongly prefer to do with the existing fs_holder_ops, no matter
> > if it's using/renaming the shutdown() callback, or a new callback.
> 
> Previously Christoph is against a new ->remove_bdev() callback, as it is
> conflicting with the existing ->shutdown().
> 
> So what about a new ->handle_bdev_remove() callback, that we do something
> like this inside fs_bdev_mark_dead():
> 
> {
> 	bdev_super_lock();
> 	if (!surprise)
> 		sync_filesystem();
> 
> 	if (s_op->handle_bdev_remove) {
> 		ret = s_op->handle_bdev_remove();
> 		if (!ret) {
> 			super_unlock_shared();
> 			return;
> 		}
> 	}
> 	shrink_dcache_sb();
> 	evict_inodes();
> 	if (s_op->shutdown)
> 		s_op->shutdown();
> }
> 
> So that the new ->handle_bdev_remove() is not conflicting with
> ->shutdown() but an optional one.
> 
> And if the fs can not handle the removal, just let
> ->handle_bdev_remove() return an error so that we fallback to the existing
> shutdown routine.
> 
> Would this be more acceptable?

No.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

