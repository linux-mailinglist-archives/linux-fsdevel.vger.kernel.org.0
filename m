Return-Path: <linux-fsdevel+bounces-13150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20686BE16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 02:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC81C21AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEF364BF;
	Thu, 29 Feb 2024 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cHRKEfoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601362D042
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168828; cv=none; b=HjEVbY3QmNN0WVoE3V152nQN0Q1Z6HN4C6s2H8CMCWiu38tg5s4RqiGero8JiEKuaUBJhaPQR/EpGtohe49b8qhOvt8F5ms5mweizFB7liVrS9w/k3aHc1HzfwZUqSjSYRKQAQQsAD+9Tfb/x/8FTMmwQ2FYGiYOkpcX506PZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168828; c=relaxed/simple;
	bh=nlvVNmmrxk/JuiTn6OS+XGd1cdndOqQfBeAH7g6jhGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyeLQIGn1BqYSuZuWK8+cLg0Su3UrlICmEaL+FfwcH7SHLGPEaadt30A8yoF3/J50gq8Ahv8MqZAvTEUKRQ90CdvW84VLFWR4XcKXLWW+OXo3PNucDvkj1z1ucqko3QwH3+JSvjgIo6ZcBF07napZwAxwW8T7/nyI5u3d/u6Ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cHRKEfoV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so3261965ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 17:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709168826; x=1709773626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrzdtSOupJJBK7dKXluhkHSUFQeW/bSHKTHR/2daV1E=;
        b=cHRKEfoVNJ2YGiSxi+TsTwXCU5xkKLxyY5KcaRT490mNshaBTJpe04v7ifkzkbDcyo
         UtzKumLIvXKQ6eCU+vK3aHnxf/PtnEDQvaaziPfaVCum+iC7iz/GSbXqYpCxy2XkshMQ
         qAQI9YNF4NT79XoSIrBN1zHwXSncrOoBtsP4T24kka9NtAAkDqyKAJ66j6c3yazxj6SV
         bzQ+QnZF6BdEdo2wlNBLUOn4WboYKG6NxEdLYKcRNSfzXq0yOP9IfZfYQ7xv3wBe+K8I
         fIZ3FfYmCr4m9hzzoPZU0Bac9ihR/1QP4uiDnXn/XBl5tN3x8HtNKQ/4pMLHqEO5D0XN
         dGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168826; x=1709773626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrzdtSOupJJBK7dKXluhkHSUFQeW/bSHKTHR/2daV1E=;
        b=mIXz0aqn3TzFPkFFXVWiRaAmkFmKKIYXRdQbyTuU2lr12J3WSsHQ65UeFPv3iWgpNq
         lK3Ig0ZJQ0v74uEUlcj0ZFIEeijy08C0Vzsfd3iRCAYxOXMZZ7aFbakP7/CebSxsdxRT
         sugOXJLQjymcC82KCsIpZUjfBBzRO0AhuS4O8bOokihQK7IPUC/1nMIFhy/t5Grt4yj8
         fwRK4X+cS0+vkyWfP92XyoNhTNmCAQ7nlRJjwpKP0pi/Y8uyzQtHZsVr5p1l9lCiWTNZ
         O3TFrogxBC/C6qYD4iJjFXVW020nh2jxFe6LEF3S8hfbon0K6a3jn3AddnzOPIrTmzRm
         D+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWO/JPGTDyOme1yVnDv58Lf3RGsgLim1B3uLCnN+HZSsY6pDusvmZXyGrlvQuS1haHlRGMuKCZwAcgMuqKdblTVnDz7lQOVzRj+9fv/4A==
X-Gm-Message-State: AOJu0Ywg9ifhq9QWqLbpxz3bOmyceSYKFKoJZqIpPzB5hXcBdsnmwD9/
	0c0O/0icdfHa76cw4olNdKDSIvK0F/QatXtbtzX+uvxN/IfK352r95XahFtHZWkBxFDc3YdjDhJ
	P
X-Google-Smtp-Source: AGHT+IHnVSbdGfy5S2qVm0yA9yYOqPfRfXhuAXhBUKQbPCChjbOp6PZu4LehIXhjbQNAaNRtbHSXFA==
X-Received: by 2002:a17:902:ef81:b0:1dc:cc98:ef33 with SMTP id iz1-20020a170902ef8100b001dccc98ef33mr445511plb.31.1709168825659;
        Wed, 28 Feb 2024 17:07:05 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001dcb4a4e461sm82337plh.163.2024.02.28.17.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:07:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfUt4-00CtZf-2V;
	Thu, 29 Feb 2024 12:07:02 +1100
Date: Thu, 29 Feb 2024 12:07:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <Zd/YtmTBUN7jFg4X@dread.disaster.area>
References: <20240228061257.GA106651@mit.edu>
 <Zd8--pYHdnjefncj@casper.infradead.org>
 <20240228233354.GC177082@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228233354.GC177082@mit.edu>

On Wed, Feb 28, 2024 at 05:33:54PM -0600, Theodore Ts'o wrote:
> On Wed, Feb 28, 2024 at 02:11:06PM +0000, Matthew Wilcox wrote:
> > I'm not entirely sure that it does become a mess.  If our implementation
> > of this ensures that each write ends up in a single folio (even if the
> > entire folio is larger than the write), then we will have satisfied the
> > semantics of the flag.
> 
> What if we do a 32k write which spans two folios?  And what
> if the physical pages for those 32k in the buffer cache are not
> contiguous?  Are you going to have to join the two 16k folios
> together, or maybe two 8k folios and an 16k folio, and relocate pages
> to make a contiguous 32k folio when we do a buffered RWF_ATOMIC write
> of size 32k?

RWF_ATOMIC defines contraints that a 32kB write must be 32kB
aligned. So the only way a 32kB write would span two folios is if
a 16kB write had already been done in this space.

WE are already dealing with this problem for bs > ps with the min
order mapping constraint. We can deal with this easily by ensuring
that when we set the inode as supporting atomic writes. This already
ensures physical extent allocation alignment, we can also set the
mapping folio order at this time to ensure that we only allocate
RWF_ATOMIC compatible aligned/sized folios....

> > I think we'd be better off treating RWF_ATOMIC like it's a bs>PS device.

Which is why Willy says this...

> > That takes two somewhat special cases and makes them use the same code
> > paths, which probably means fewer bugs as both camps will be testing
> > the same code.
> 
> But for a bs > PS device, where the logical block size is greater than
> the page size, you don't need the RWF_ATOMIC flag at all.

Yes we do - hardware already supports REQ_ATOMIC sizes larger than
64kB filesystem blocks. i.e. RWF_ATOMIC is not restricted to 64kB
or any specific filesystem block size, and can always be larger than
the filesystem block size.

> All direct
> I/O writes *must* be a multiple of the logical sector size, and
> buffered writes, if they are smaller than the block size, *must* be
> handled as a read-modify-write, since you can't send writes to the
> device smaller than the logical sector size.

The filesystem will likely need to constrain minimum RWF_ATOMIC
sizes to a single filesystem block. That's the whole point of having
the statx interface - the application is going to have to query what
the min/max atomic write sizes supported are and adjust to those.
Applications will not be able to use 2kB RWF_ATOMIC writes on a 4kB
block size filesystem, and it's no different with larger filesystem
block sizes.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

