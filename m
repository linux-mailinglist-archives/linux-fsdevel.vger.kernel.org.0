Return-Path: <linux-fsdevel+bounces-20035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601758CCCD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6782817E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76A13B5AD;
	Thu, 23 May 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U/+pp9O3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4543B29D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448727; cv=none; b=IjKyNxgZ7LKcCv44BN57g1BeAAkV6pAViQGzkhnjQHHW5mjRUYw9qM0D2VPySRlwB4msSWc/vA9GPdxhWrQzraH2IaSpMpOYcNcAfn5jzrTNFlbbCnREKUAoIhNLghqTsOaHvlIF3qpzeGwf9242iWIgAYzYn8ujAXRHE88wWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448727; c=relaxed/simple;
	bh=/icM3O7GAxvCO8V0cILBlcRIF2jH1xDM8t7fKPxNgys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3RqE/WQJf7nxO3h0/BD/qCmnrDp6I3J8I3y7M8wPw2uy3BxKQROZONhE52p2SoclIy501SjbhVy8kn7JbIMoXeGAKtcsQler5eVM8nUsVp4CbYiycRE6UrooOPWEeuCEXbvxJ3kwm6wSOMUYhO3HKQwyXWCKI93jwvTP19mEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U/+pp9O3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2720541a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716448725; x=1717053525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHVpOWiuchpA4qG0ZowU3b187JgmRat2AqSceusHQQI=;
        b=U/+pp9O3AfyT6BjNmrFZnbdPyZ/HENT/5QZXjBHHSh5ZbXtZN0uWkNFy+RAhEemRPF
         CuhZd2nKPxQFfvl9Lx7dizO/o9pyKxbq8sdDIPS/KUu5/Uj3nlk1gcrhDKSPhlKln02e
         MzqGlFUvcUtTV9FR8nYlGDdmQbcwghsAsuCO+9kqk/hxZzqmGwi0we59k0JzRgvI7POE
         gv3oHqmfFXe8vm+8/SDIMim9yFZCmEwSrFlEtIpp2D0RpQm6J0UvzJWOIU27BYIbQJPB
         /7FQO/n1Om+T+auMsqU1cUlWWLznRtWFELt1dPDvIjxgQrGE90zCfZlo+a0yPRceZpLM
         mOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716448725; x=1717053525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHVpOWiuchpA4qG0ZowU3b187JgmRat2AqSceusHQQI=;
        b=oyI/4D20GAo3B+KeWxbM4UBSP2K69oqz6yM1YSNDk86efB+At6MSJJWVy9eFTUHR2a
         enGKNxYakAk7nS+sTS/feHzhn5wysJw54pNAw5Yfsj9Su2NwSRMWtjGJ3K6r4CZjFhM1
         36w6OAqGI/M1Qvec1/8rHqs4+0Co+VNQ6Iw3gR/HgJhx4zcrKC8nP/9rFmntyiZ5WKZn
         n+kJo8urYcTIaPqDp4+CPsJURODSQ22lr+Fl8O0PrAiynE7zQeCVk2ogJ8IqZdHHhjyF
         wnIU3I3G55ejUMYNPaghGBoH4oGDZmOAaFSxcZJOXjeS524u8S8+cjkbL2cJRw2T//Fr
         nppQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0bpqK0SPtp2jXK6LALJgTQ+pius+nSUMelIQ6VrbPZcIFG/4yLdo3hhv2VF8onTxoL7Jw6j1qWW1+Y/TlNbw0wc4o3c3VNEfe/05QSg==
X-Gm-Message-State: AOJu0YwOwAWpaiZmfcBU+OlJvfksd/+nfsduZCfY+kA6NpKXll8bhWQu
	TjB20pO/wHXxxortB8M8UWC5/4A3zwkGA174OHxPDumFn7HlDEVmZLsIViqyMQU=
X-Google-Smtp-Source: AGHT+IHMEnFT+ifYQxq03p3yQuztKQ2dE25qirVhPJ8G9AWbQ0zmKn18yB2GA+24QDyQAZx0Sl8mtg==
X-Received: by 2002:a17:902:c948:b0:1f3:126b:76bd with SMTP id d9443c01a7336-1f31c964aa8mr54669165ad.3.1716448725262;
        Thu, 23 May 2024 00:18:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad86ffsm250431185ad.101.2024.05.23.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:18:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sA2in-007PNO-2x;
	Thu, 23 May 2024 17:18:41 +1000
Date: Thu, 23 May 2024 17:18:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <Zk7t0WdpHE24UNDG@dread.disaster.area>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV>
 <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
 <20240513053140.GJ2118490@ZenIV>
 <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
 <20240513163332.GK2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513163332.GK2118490@ZenIV>

On Mon, May 13, 2024 at 05:33:32PM +0100, Al Viro wrote:
> On Mon, May 13, 2024 at 08:58:33AM -0700, Linus Torvalds wrote:
>  
> > We *could* strive for a hybrid approach, where we handle the common
> > case ("not a ton of child dentries") differently, and just get rid of
> > them synchronously, and handle the "millions of children" case by
> > unhashing the directory and dealing with shrinking the children async.
> 
> try_to_shrink_children()?  Doable, and not even that hard to do, but
> as for shrinking async...  We can easily move it out of inode_lock
> on parent, but doing that really async would either need to be
> tied into e.g. remount r/o logics or we'd get userland regressions.
> 
> I mean, "I have an opened unlinked file, can't remount r/o" is one
> thing, but "I've done rm -rf ~luser, can't remount r/o for a while"
> when all luser's processes had been killed and nothing is holding
> any of that opened... ouch.

There is no ouch for the vast majority of users: XFS has been doing
background async inode unlink processing since 5.14 (i.e. for almost
3 years now). See commit ab23a7768739 ("xfs: per-cpu deferred inode
inactivation queues") for more of the background on this change - it
was implemented because we needed to allow the scrub code to drop
inode references from within transaction contexts, and evict()
processing could run a nested transaction which could then deadlock
the filesystem.

Hence XFS offloads the inode freeing half of the unlink operation
(i.e. the bit that happens in evict() context) to per-cpu workqueues
instead of doing the work directly in evict() context. We allow
evict() to completely tear down the VFS inode context, but don't
free it in ->destroy_inode() because we still have work to do on it.
XFS doesn't need an active VFS inode context to do the internal
metadata updates needed to free an inode, so it's trivial to defer
this work to a background context outside the VFS inode life cycle.

Hence over half the processing work of every unlink() operation on
XFS is now done in kworker threads rather than via the unlink()
syscall context.

Yes, that means freeze, remount r/o and unmount will block in
xfs_inodegc_stop() waiting for these async inode freeing operations
to be flushed and completed.

However, there have been very few reported issues with freeze,
remount r/o or unmount being significantly delayed - there's an
occasional report of an inodes with tens of millions of extents to
free delaying an operation, but that's no change from unlink()
taking minutes to run and delaying the operation that way,
anyway....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

