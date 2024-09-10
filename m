Return-Path: <linux-fsdevel+bounces-28968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044F97264A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 02:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022971F241D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7355884;
	Tue, 10 Sep 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EZcBaW8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554964D8B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929080; cv=none; b=YrSIIE1hJfa5nzM8wwADBiMKQ15gaADCKRCcuj3BIht3EEHzHVoUgoo5x9kwCPuqhYRpeXre8mHFKAc6IT7a+Qi7k+w7PIJFA+oI9ldvszmtEUYAJsvQxy62VUnKz7AqsScJM27HGfIglvEsWpwbnNvE3dQ2fI/0JSo9ox5F4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929080; c=relaxed/simple;
	bh=PXmnCfmHeba7ueGMsG0DI1tH6tPECY/lOssymhZ3VJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEsZQOS0PacjgyfMAm9Ti+AOfe3r5jlGKapWvyMxXWJ2MuCczyKXgGpepZnCAIhLrVumJesbGgly9ClihUS6MxqLlolwJlRicOAaIrQ9SWzACBKuVef1FtK58rtYrFo8OSoKT/niqV+gfCJ6ACI5DQijJN0aau5ymev/OUr1Tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EZcBaW8r; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e285544fso1954184b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725929078; x=1726533878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CndvcWxXnjAtK2uayCtw1XDiHhZpnrOg7jGiA1L7GV0=;
        b=EZcBaW8rL+I6QqJBbc+Px2goe+0qUMJyPbZUiHnBNm5SvnpX0g1e9ICWWsXpSeyZ7h
         f/IfaE5PqnXQSBbN0SUpLi5J1XSXVylS6SNXXR8UVq8wGz0mel+Uk4bgPkhqvcIWhzPA
         +OClEb9njWdDYQoI5LJdVPEQrs2RqUrWDoNIJ2Fh6l3SjBMtTeHc90eVD3tI/6hQVyaU
         78+HB5MAhBJkQqtgPZy8yIjiuJ7RZoLR44Cx4FDVmxLBvVnBVGwKDWziVgymK23oi32C
         iiXjMfYdO5itawX1wgVlXC/XzfbuD/aYWkJHsoYkA0ZHoc73DF6MEhfmASnOCFwDTpcV
         CWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725929078; x=1726533878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CndvcWxXnjAtK2uayCtw1XDiHhZpnrOg7jGiA1L7GV0=;
        b=hwKvPvHzeLwDFy2KswdMSIxdImB9vcGVBUifmMB6v4uqThSecE9/kD261zVLIgjtnT
         UZRZ7XkyT2Og+QQVMGefe8UdlSqEeRyG+67+50IgETF40ympAjzxQ+35T8lRe9C6srP/
         el6YX5ZOorZdyebzpsF5raSvH9/ZqXEG0iR4VcHEBd2XYejRL1KBu/TF5jvPsuB+NSIT
         ChLXJhORERhavavnMTEKTNyKF7NWWM6j2zsQpPjTQig70DC4IzjadruI52duIMZC5kVs
         tr94nHGItYps0aW3VVcDzbbJYyiOukjF1GhUF9THxO2H5CS8rz1JfKW6ZqncJ0lmjgfw
         3Ffw==
X-Gm-Message-State: AOJu0YzmXrtMCgJr49P3KEAhM0aUBr69U+9/TlHXJYjGAqFknG4qH/Rc
	b1MegMw7oHeeWoQ6V7zzGPybtYA8zhJlFo1+fSSM+m48rI4cb8StXj9BpHXoSI8=
X-Google-Smtp-Source: AGHT+IFDF8caNXq4EvNWT5MK122HgpnrfuxARrwQin7Y2RIDQebWQv5D5wRvr14g/9grx4HbIyXwcw==
X-Received: by 2002:a05:6a00:181e:b0:714:173f:7e6b with SMTP id d2e1a72fcca58-718d5ded08bmr13004003b3a.2.1725929078492;
        Mon, 09 Sep 2024 17:44:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090922e4sm312606b3a.140.2024.09.09.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 17:44:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1snozi-0036J0-2v;
	Tue, 10 Sep 2024 10:44:34 +1000
Date: Tue, 10 Sep 2024 10:44:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, djwong@kernel.org, hch@lst.de,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
Message-ID: <Zt+WcsV+GYoTdSjA@dread.disaster.area>
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905102425.1106040-1-sunjunchao2870@gmail.com>

On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> Attempting to unshare extents beyond EOF will trigger
> the need zeroing case, which in turn triggers a warning.
> Therefore, let's skip the unshare process if extents are
> beyond EOF.
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86ac..8898d5ec606f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  	/* don't bother with holes or unwritten extents */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return length;
> +	/* don't try to unshare any extents beyond EOF. */
> +	if (pos > i_size_read(iter->inode))
> +		return length;
>  
>  	do {
>  		struct folio *folio;

iomap isn't the place to do this. The high level fallocate code in
the filesystem should be trimming unshare length to EOF long before
we get anywhere near the iomap layer.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

