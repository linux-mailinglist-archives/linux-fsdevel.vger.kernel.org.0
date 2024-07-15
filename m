Return-Path: <linux-fsdevel+bounces-23700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482B931693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFBB22159
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15F18EA9A;
	Mon, 15 Jul 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Tq5Z9LCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88B18EA85
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053328; cv=none; b=TP8WbffhBY5A5yMeik19oq27z3Mxu4hlsMJ31bEU0jJrWZmofN+OVvaVrlqEMX8AL2b1X3wfYDkxFdBTTTzxg8joQxbmquA2k2F7e8ZV+1vIYClm5utYMTqNddHHkbfsO7bDUmwLqvzNrkptfKbUfQXZf9kB38IyQE/xufdZrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053328; c=relaxed/simple;
	bh=WZ9DqmpTCpv53sLZmfApN6B7cdChfHWd2Csv103VR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alA9iB04Jw0uuT+oaOyCSap40hhjQhw3je95FaTEG7NytyWgVVJt6p9/F1xlapXXU0zY5RgjnyFIEhd3NVLM5Sxg1LJrg4kCQz3J+qohE557wu8EYrO4K2MQpy8adcmWVeir6C6WnWLmfFDc0CQ36ekxFwIJU7WMtYnyMbROzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Tq5Z9LCE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44931f038f9so43138191cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721053325; x=1721658125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D40OJun1kj+xLgrmaa8fsvT76PBQYXwEjzXS6FAwle4=;
        b=Tq5Z9LCErB6HVCtgcX3GZNDG2d3pFqaix1V1Klly+wVczN1ChClSjwWr5QexxZYOmP
         mYQuv8Ud86+fdSd6R4Are2K7bHKe2I9PdDdtHRzTkIEhEL0F7IIW+sNiGOsksAWrP9aI
         RzTPxNjZZICUVxzHmaFprRubFvC3kujzzlJFtaE7+g3QRwl/X+9SrBLv3o7Y594Q9u9g
         QBFx2VjixBt404CBuPAjeZXo7W9nEFylt4WqlXB0AIJZJQen2sagMUApNMY2iKzHrHKe
         R0u8JaW/MC4pUhZhyy/FPOkbSNwJYEZWOlQaM46nYOlUhAtYZORLt1fTsK+SOUhBw7ws
         /viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053325; x=1721658125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D40OJun1kj+xLgrmaa8fsvT76PBQYXwEjzXS6FAwle4=;
        b=XZCpzpI1gbZiM/gFklnwQONmgVoKrXcuMaIcgo1rxboPLHdxSaWmqq0uCnBC1RkBxF
         uLJGbzjQkFccutgi0HScBOPaEc4ZnQ3eWsx0gJw2yhR5lGOYkjHXu7mWr0JYD4lsXMom
         dj+8C+6vbtKiSfMh5OXsFhb5kIIxVWv64hZJpwCCN5u7N8xnVy7CMHI8O6cR35oBYz50
         0wq9uex4rTjROcv5OnVMhT6BVL0AGvADN2pnCa40gvsYU1mvTe79M2d6xhvDcxsI/d85
         5KJtAu2reiR64yJ7WnLUKyv7wuswdep4jQAeqOgBpand4ClHUw/MlDaRCHmfpDAOvbbu
         nmbg==
X-Gm-Message-State: AOJu0Yw7Lp6gSAbQ/7tA5nwC65vPjJc/aXrs5fFs1RlxrecfhjF8496U
	GAyrfbM4MttmX2W26K2K3KBqt7HO8zM155jkvH4YiFW7F6QPU4fF/16YciWJnnY=
X-Google-Smtp-Source: AGHT+IFD+iTfn9SCLkyD6edAEskPxtRzaO0HgnXTsBx+IsOoXGHA8THZOpX3dv11Nb2GIR/65OHoWw==
X-Received: by 2002:ac8:7e95:0:b0:447:e6f9:f61c with SMTP id d75a77b69052e-44e57c4ac1emr205189881cf.22.1721053325246;
        Mon, 15 Jul 2024 07:22:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba7e7esm204513285a.8.2024.07.15.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:22:04 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:22:03 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fsnotify: Avoid data race between
 fsnotify_recalc_mask() and fsnotify_object_watched()
Message-ID: <20240715142203.GA1649877@perftesting>
References: <20240715130410.30475-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715130410.30475-1-jack@suse.cz>

On Mon, Jul 15, 2024 at 03:04:10PM +0200, Jan Kara wrote:
> When __fsnotify_recalc_mask() recomputes the mask on the watched object,
> the compiler can "optimize" the code to perform partial updates to the
> mask (including zeroing it at the beginning). Thus places checking
> the object mask without conn->lock such as fsnotify_object_watched()
> could see invalid states of the mask. Make sure the mask update is
> performed by one memory store using WRITE_ONCE().
> 
> Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

I'm still hazy on the rules here and what KCSAN expects, but if we're using
READ_ONCE/WRITE_ONCE on a thing, do we have to use them everywhere we access
that member?  Because there's a few accesses in include/linux/fsnotify_backend.h
that were missed if so.  Thanks,

Josef

