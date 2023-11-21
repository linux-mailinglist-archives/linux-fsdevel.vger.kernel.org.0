Return-Path: <linux-fsdevel+bounces-3338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916E37F384D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28E41C20C75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 21:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D454672;
	Tue, 21 Nov 2023 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="orvxnHQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857FB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 13:30:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2853347502aso1706576a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1700602205; x=1701207005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zt66qY66UaPwBR/yW8QtEXWghsWH5r4t16gdohHnJRM=;
        b=orvxnHQvugkYq9VCwrXoqsyyvSxsYpeMvbZd+tEOYb7jGJJJA2NQk1Knty8ArruLaq
         TphWLLixH5aZunhnbPJyPpgWmNyJ+iK06nz/gFSe2ggmiFCh4FKQS6ZCJq2xSmNFBRTH
         cawL4DW8OVU6UdpeVLvI6LZdcByr2e0cvhfnWB7l/kTOvAS4Jces4U0bVETphlE38XTi
         45wwlycw9BiuglahmL5ZJRStvd6PHGa5Wawq7Nczd7vEThNRKlsLzP7OIgaIDPOrSvRH
         SiWQaT75wka1lth3oeNUwDiA8JDgaGZ99Do7+VEHzdC6Q+K7hEthFJ5/s8g+RPnqks2O
         L9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602205; x=1701207005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt66qY66UaPwBR/yW8QtEXWghsWH5r4t16gdohHnJRM=;
        b=nZ0ixIxn0OY1Qakg9CGjo2GjvcEZH2wZJAAksxK3BOPiUknPSR9Os0QWFItUn/S3EV
         BzI4gGC58FAglCp7a4Q4Movt4JoydckpCICX2TGG7+7xD2Ka0z2AnlfnzAU44egnjpw+
         mCJz9v7aCE4JUv0j3S1caJUTO05Lf+yVkWizeVSnQFLRAf+Y+Vh69PO4Z8KDk8d0xeiY
         alU/JY95cCzxt8/sOX2NR4Ufk0Vm7PMZNdVfYAlVJm+lHNQ3v/A55zOHu23LzEq8qlIW
         NCtoxf3f+kfjcYPjsV9ZIMZgVWFRiTBpOodFqHJG2VH+4Qa0xiQnou7AmunaHDwWXiNt
         mrPA==
X-Gm-Message-State: AOJu0YytsYAFHz00z7cEzZS70IwWOYnb54EgFSQwk2HUWqcux+Tj30Ug
	MznnvjhXQmTRM3Oabk2Jwrko8g==
X-Google-Smtp-Source: AGHT+IHtjuKn2BE6Q0RKSKOTQwN/8ieiOL784VnATQJSvPIjptWr3qFxz+pbDN2I/ezdGBRok6g31Q==
X-Received: by 2002:a17:90b:1c92:b0:281:10d:6067 with SMTP id oo18-20020a17090b1c9200b00281010d6067mr526770pjb.16.1700602204950;
        Tue, 21 Nov 2023 13:30:04 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id gq13-20020a17090b104d00b002839a4f65c5sm7312632pjb.30.2023.11.21.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:30:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r5YJl-00FjTI-29;
	Wed, 22 Nov 2023 08:30:01 +1100
Date: Wed, 22 Nov 2023 08:30:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow calling kiocb_end_write() unmatched with
 kiocb_start_write()
Message-ID: <ZV0hWVWeI6QOVfYM@dread.disaster.area>
References: <20231121132551.2337431-1-amir73il@gmail.com>
 <20231121210032.GA1675377@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121210032.GA1675377@perftesting>

On Tue, Nov 21, 2023 at 04:00:32PM -0500, Josef Bacik wrote:
> On Tue, Nov 21, 2023 at 03:25:51PM +0200, Amir Goldstein wrote:
> > We want to move kiocb_start_write() into vfs_iocb_iter_write(), after
> > the permission hook, but leave kiocb_end_write() in the write completion
> > handler of the callers of vfs_iocb_iter_write().
> > 
> > After this change, there will be no way of knowing in completion handler,
> > if write has failed before or after calling kiocb_start_write().
> > 
> > Add a flag IOCB_WRITE_STARTED, which is set and cleared internally by
> > kiocb_{start,end}_write(), so that kiocb_end_write() could be called for
> > cleanup of async write, whether it was successful or whether it failed
> > before or after calling kiocb_start_write().
> > 
> > This flag must not be copied by stacked filesystems (e.g. overlayfs)
> > that clone the iocb to another iocb for io request on a backing file.
> > 
> > Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> This is only a problem for cachefiles and overlayfs, and really just for
> cachefiles because of the error handling thing.
> 
> What if instead we made vfs_iocb_iter_write() call kiocb_end_write() in the ret
> != EIOCBQUEUED case, that way it is in charge of the start and the end, and the
> only case where the file system has to worry about is the actual io completion
> path when the kiocb is completed.
> 
> The result is something like what I've pasted below, completely uncompiled and
> untested.  Thanks,

I like this a lot better than an internal flag that allows
unbalanced start/end calls to proliferate.  I find it much easier to
read the code, determine the correct cleanup is being done and
maintain the code in future when calls need to be properly
paired....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

