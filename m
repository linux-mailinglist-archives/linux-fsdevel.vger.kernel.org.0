Return-Path: <linux-fsdevel+bounces-30849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97998EC95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C41C21DE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5814AD0C;
	Thu,  3 Oct 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ixkIPFsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E114A639
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949575; cv=none; b=hhuahHa8wxJUJSQ44mKhnkYQhuB0gk88WKjy1AxOZZDFZL2v8Jdn0UK61MPez4SEh0nH/nLfahWoOqwnQTb5llGlsP4eQy5mVX/RAWac63Xy3CjKpCrGWLr23Z+SzEuKCU4a/IyrM0zs+gtirMU7MD+zCTZnR53xn3HK4DPmn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949575; c=relaxed/simple;
	bh=ws++fftyryHhCAETNNzTX0HjvxlfudjsCorBxr25E9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuBqFUGKqSxwfRzlKrnLzHYJ25+JZ1rwwJJtrnJBBvBrK5oP7EUrmzGnVe8/ETh70cFxRdlg+sRWmXBgYPvpbM3ZsbNdMl4GC5dmRq9q6L5GLjAIX/SHJI6dxBbgosTfwsJJfA9ddfGv9HU9w7h/wfYNXmaOyF8iXk/J/C4ZxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ixkIPFsQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d7a9200947so432629a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727949573; x=1728554373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZoVePEjRG3urznVwj0SIfeUiNk8Ws/Gg0iUzR96R7c=;
        b=ixkIPFsQcNrsGNxCOjHKFh2AFYRm6FRDqg2JkLijTz9+X1TrczYA0uAqvoOXekDvtG
         uc1VgRBOBHwZpTGKoDmUqRRmKo8j2AE6uL+NaAAdRxQaEyTlFy2wsgBNOScunA/XjWNH
         gemZhcos3TMMn3L9O6yIbHxpGeU3FbusIxMUhH7KBKexdojjF5c+d5yRtMR0+OxnPCPi
         gSc4pL5GgIgL46/ZL30Ztb7k+v/X3eNBx0FFpFeqZ3vDnqLiHolbYnYjbiUZJMhIvmIE
         S6urCvkJLyqxU+zcC7f6KGJDUpZ3mElBOM+RBG7NiD1IR1I27Vd2ikpJxaEmZaqZtSFM
         Uxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949573; x=1728554373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZoVePEjRG3urznVwj0SIfeUiNk8Ws/Gg0iUzR96R7c=;
        b=Tw0usRKHQpwgQ5q+0+MILm+JAPhHH4ya4jG7irczZfbtHaSXPb8xFUVrODAhSlNsk4
         iWcftYJC0EDHVKSzxv8bNH55NX59rLDczuz/NVopjxo4qqu9z1KJo9t36q5JCMjQ8HAp
         oBJz2908ST+t80jyO5cQf9n+hhBbMGveTPnnIOnUot6Jk7xZmWcNCaJ3W3uUpDzFPJ4s
         iAHO7s6ColM0683ZuFub+eUMmdOQKbWN0iI7xcF1bOaGUmYhYxqg3aNgjcDtUFshhqei
         pv810QUYlploNIyHc8bcp8NAMUaWY36n6V15J+79Wj35pTsb+/VCNqdyZ9Za76KJWeOw
         25eA==
X-Forwarded-Encrypted: i=1; AJvYcCXkIgpcRNVzofWENbEM1Mg4cP8+YYIEXzGICqzzQvMyBf/S9yd1zwG9GGsAam2wxXpcxLjvr0fT62eEcqwb@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUQfplRjsFdv/70EHPhHqtEO9ombPKk9d/9GWMKr1TW9M+ur1
	7a0pTbNRz7lJiwFkd1O2EPjCxlcfW+lPb/92Zv8coeePT7pXhyw1XXXqom6KTkE=
X-Google-Smtp-Source: AGHT+IHRE80iIS0vtT8WICPYgmm1vV8aDhQHpiTupQ0As/uP52it766oR+Cw0QAYw1lPazD0ArHY1g==
X-Received: by 2002:a05:6a21:1643:b0:1d5:14ff:a15f with SMTP id adf61e73a8af0-1d5db20a5c0mr10402698637.11.1727949573106;
        Thu, 03 Oct 2024 02:59:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9dee6adsm974968b3a.144.2024.10.03.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 02:59:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swIcL-00DL4k-2o;
	Thu, 03 Oct 2024 19:59:29 +1000
Date: Thu, 3 Oct 2024 19:59:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv5rAYEgY3o7Rhju@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
 <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
 <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>
 <Zv32Vow1YdYgB8KC@dread.disaster.area>
 <20241003091741.vmw3muqt5xagjion@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003091741.vmw3muqt5xagjion@quack3>

On Thu, Oct 03, 2024 at 11:17:41AM +0200, Jan Kara wrote:
> On Thu 03-10-24 11:41:42, Dave Chinner wrote:
> > On Wed, Oct 02, 2024 at 07:20:16PM -0400, Kent Overstreet wrote:
> > > A couple things that help - we've already determined that the inode LRU
> > > can go away for most filesystems,
> > 
> > We haven't determined that yet. I *think* it is possible, but there
> > is a really nasty inode LRU dependencies that has been driven deep
> > down into the mm page cache writeback code.  We have to fix that
> > awful layering violation before we can get rid of the inode LRU.
> > 
> > I *think* we can do it by requiring dirty inodes to hold an explicit
> > inode reference, thereby keeping the inode pinned in memory whilst
> > it is being tracked for writeback. That would also get rid of the
> > nasty hacks needed in evict() to wait on writeback to complete on
> > unreferenced inodes.
> > 
> > However, this isn't simple to do, and so getting rid of the inode
> > LRU is not going to happen in the near term.
> 
> Yeah. I agree the way how writeback protects from inode eviction is not the
> prettiest one but the problem with writeback holding normal inode reference
> is that then flush worker for the device can end up deleting unlinked
> inodes which was causing writeback stalls and generally unexpected lock
> ordering issues for some filesystems (already forgot the details).

Yeah, if we end up in evict() on ext4 it will can then do all sorts
of whacky stuff that involves blocking, running transactions and
doing other IO. XFS, OTOH, has been changed to defer all that crap
to background threads (the xfs_inodegc infrastructure) that runs
after the VFS thinks the inode is dead and destroyed. There are some
benefits to having the filesystem inode exist outside the VFS inode
life cycle....

> Now this
> was more that 12 years ago so maybe we could find a better solution to
> those problems these days (e.g. interactions between page writeback and
> page reclaim are very different these days) but I just wanted to warn there
> may be nasty surprises there.

I don't think the situation has improved with filesytsems like ext4.
I think they've actually gotten worse - I recently learnt that ext4
inode eviction can recurse back into the inode cache to instantiate
extended attribute inodes so they can be truncated to allow inode
eviction to make progress.

I suspect the ext4 eviction behaviour is unfixable in any reasonable
time frame, so the only solution I can come up with is to run the
iput() call from a background thread context.  (e.g. defer it to a
workqueue). That way iput_final() and eviction processing will not
interfere with other writeback operations....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

