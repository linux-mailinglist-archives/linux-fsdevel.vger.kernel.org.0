Return-Path: <linux-fsdevel+bounces-47397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C4A9CF04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF29C7470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBC1CEAD6;
	Fri, 25 Apr 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIz6x0Bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D801C5D5A;
	Fri, 25 Apr 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599970; cv=none; b=Vo/aMLZ+jMRRqwy09Esq8PK6oI6A+DJ8EzqDc+UlBXvKqFLg5aGtL146UAvKbN6GnlPnZmcfeLdmjEq8J85tfB7UMADmjW/KNsJ8rWyLrzYJLEOiJ/MIA/JFRjL7ObgQwOXhtJgF/Vw7WO52eUIAY4G/XnMgo34uNc1OpzYUVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599970; c=relaxed/simple;
	bh=b7xROfOzVGEJ+F8+IU2YtVbSzBcJ5YtgexLbCieurdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P417MBdth86NNc7rJ3b7YOcnx2aQEeC8VTyyBDjzPWflKLCmZt/y9Ko3B+ptSLJNM8U8xrqp+GCzLack92J4OJbstzt+/7DONiVMMaIfVSDQ5obsLvEqqAZD7knNkF52Fn4CTWeKJdvqTwYP6iuxRk2eGVS92qgnDpHetNos8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIz6x0Bh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af6a315b491so2431636a12.1;
        Fri, 25 Apr 2025 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745599968; x=1746204768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUo8ldcQnt9oMg4WgBNcdcluURoGZZ9nuZ9OpdGRZpI=;
        b=gIz6x0BhI4EX2pwLdijptx94vt96kgMUzvnMhUBr7TGNyYlGC25IcBjVLhNo18PiAj
         cngpA8C41GVpXyCWQJzMQMvR6WjScCb6xyalHtaIBL0JLoSMkV9IjMLPs4z+uVvk6nMf
         yzHmTf8qco18mJKnOWr6EM32cn0jre3CBy5z91erUqMIXGTBEE3ZWDt6Ur9SL8XUUKbp
         xFS/Ow1A02h7W9ZfMMqFMB2umjOn/PnoVK9s5xcnZnWRq2HkN//OF+mx0iqsgqkT1roS
         ufBRABWLYScCyU32vw/k7rZ5tLGm2uycnCvAmREpYf/TKB+XBz/Ef49ErnEQPFCPPRPF
         jDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599968; x=1746204768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUo8ldcQnt9oMg4WgBNcdcluURoGZZ9nuZ9OpdGRZpI=;
        b=t4E2PxjlbAx1dQmrpyNmNuePOV+PRT9EB9mPLQS9PfvVIW3fRUsXMQhWaVyzL4BI++
         HoSSP23p7meKOj2GjllV5ZMTBYLnMoncSt7ZUft+RQtOISbPO3gJVl6EHiH7dFKjBqew
         UXCwe6/GAgoQGp2+8wgz7fZfsiZtqIEQdOz+hPkw8pIyxnIOQcfP2s2MWNm9hnFsjV+9
         UGaTXXLKwy4qwJfmQWll3WZm/r58DdrlEHQNbDp9URz2MDVOINJk4VHic7WofRDMC8Vc
         faAWvuyQfdafvZPUUOy2DnXyl4WDI2Fcj0y2eRFdVIWwkG8P2GU/EIgVlRdAXvbRQBmD
         CsNA==
X-Forwarded-Encrypted: i=1; AJvYcCWPGHyJtv8zoZkoqDJvxnAWprd2GZoNTeXJ+h8iOP5iDHIHOjc6BrgUartMOceV5ZTEArQ5OPukL5TNlxFX@vger.kernel.org, AJvYcCXWqHvqZf5N0+73JCHV7F/1qBD0RwlsmLtbkF9W/1OPY/hJJ3FLvaihf8Bz0FedTAjeiRj4VwP3xa0Tfr+a@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpMBj00FEismFKcHYtrfWQaQCq5Gbmmrhxvj6gUESIwlp3Irs
	ZWDnt1tfeSgpDbjOGcx0TiID+nWCDRrzfLdWnD/eBLWDCTXHAayB
X-Gm-Gg: ASbGncv6axsU0qj8IyB+29vgbw3whcX2ZA1tTuxOP+uBMrLGZwlRocYbUPdvKvQs5gu
	9AJteImqOaTdA3zaZ8wYokEsG2uR2//Ke/9MNVcgmKClYj/nBfwrkr3nW7MN4enMh6+FJfraZ12
	S8uFnNkrTtFPTfIC6sGNOPWyZ+cyrdUbvUtWDnWeXUPfZ2b0lKLTana9tm+7HdbMXtIdNC1I7Lr
	hvgwmmT9fjUR1/Kr2WMCVxn5/qx04/Aj7E7K8ikfMvCViQtsujuqP+USxz8KEktWH78R4/c9GH8
	929Dtngemc1ZpW6NGoWhxhbowNFazGq4TjyStVu0mpkComC4sT05KANFpjBvgs+yZAbG
X-Google-Smtp-Source: AGHT+IFojj7f+se3pSr/WR6LUWCeOvjNpR7dRU6l5UkaIDRsEoeOc1uUIphwPcBM8pHGM0feoLQTuw==
X-Received: by 2002:a05:6a20:6f0a:b0:1fe:90c5:7cee with SMTP id adf61e73a8af0-2045b98fd7emr4718790637.28.1745599968077;
        Fri, 25 Apr 2025 09:52:48 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:f97d:cfa2:241e:84aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a30csm3387276b3a.88.2025.04.25.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:52:47 -0700 (PDT)
Date: Sat, 26 Apr 2025 00:52:42 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] fs/buffer: Handle non folio buffer case for
 drop_buffer()
Message-ID: <aAu92k-iPbnWBKGz@vaxr-BM6660-BM6360>
References: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
 <20250423023703.632613-1-richard120310@gmail.com>
 <nfnwvcefhvm5sfrvlqqf4zcdq2iyzk4f2n366ux3bjatj7o4vl@5hq5evovwsxp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nfnwvcefhvm5sfrvlqqf4zcdq2iyzk4f2n366ux3bjatj7o4vl@5hq5evovwsxp>

On Wed, Apr 23, 2025 at 12:13:29PM +0200, Jan Kara wrote:
> On Wed 23-04-25 10:37:03, I Hsin Cheng wrote:
> > When the folio doesn't have any buffers, "folio_buffers(folio)" will
> > return NULL, causing "buffer_busy(bh)" to dereference a null pointer.
> > Handle the case and jump to detach the folio if there's no buffer within
> > it.
> > 
> > Reported-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=de1498ff3a934ac5e8b4
> > Fixes: 6439476311a64 ("fs: Convert drop_buffers() to use a folio")
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> > syzbot reported a null pointer dereference issue. [1]
> > 
> > If the folio be sent into "drop_buffer()" doesn't have any buffers,
> > assigning "bh = head" will make "bh" to NULL, and the following
> > operation of cleaning the buffer will encounter null pointer
> > dereference.
> > 
> > I checked other use cases of "folio_buffers()", e.g. the one used in
> > "buffer_check_dirty_writeback()" [2]. They generally use the same
> > approach to check whether a folio_buffers() return NULL.
> > 
> > I'm not sure whether it's normal for a non-buffer folio to reach inside
> > "drop_buffers()", if it's not maybe we have to dig more into the problem
> > and find out where did the buffers of folio get freed or corrupted, let
> > me know if that's needed and what can I test to help. I'm new to fs
> > correct me if I'm wrong I'll be happy to learn, and know more about
> > what's the expected behavior or correct behavior for a folio, thanks !
> 
> Thanks for the patch but try_to_free_buffers() is not expected to be called
> when there are no buffers. Seeing the stacktrace below, it is unexpected it
> got called because filemap_release_folio() calls folio_needs_release()
> which should make sure there are indeed buffers attached.
>

I see, it doesn't make sense to have no buffers inside
try_to_free_buffers() then, I'll dig into it more and send v2.

> Can you print more about the folio where this happened? In particular it
> would be interesting what's in folio->flags, folio->mapping->flags and
> folio->mapping->aops (resolved to a symbol). Because either the mapping has
> AS_RELEASE_ALWAYS set but then we should have ->releasepage handler, or
> have PG_Private bit set without buffers attached to a page but then again
> either ->releasepage should be set or there's some bug in fs/buffer.c which
> can set PG_Private without attaching buffers (I don't see where that could
> be).
> 

Hmm so I suppose when there're buffers attached, the PG_Private bit
should always be set in folio->flags or folio->mapping->flags or
folio->mapping->aops ?

Thanks for your patience and detailed reviewed again, I'll refer back to
you ASAP.

Best regards,
I Hsin Cheng

> 								Honza
> 
> > 
> > [1]:
> > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> > BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2881 [inline]
> > BUG: KASAN: null-ptr-deref in drop_buffers+0x6f/0x710 fs/buffer.c:2893
> > Read of size 4 at addr 0000000000000060 by task kswapd0/74
> > 
> > CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_report+0xe8/0x550 mm/kasan/report.c:491
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> >  buffer_busy fs/buffer.c:2881 [inline]
> >  drop_buffers+0x6f/0x710 fs/buffer.c:2893
> >  try_to_free_buffers+0x295/0x5f0 fs/buffer.c:2947
> >  shrink_folio_list+0x240c/0x8cc0 mm/vmscan.c:1432
> >  evict_folios+0x549b/0x7b50 mm/vmscan.c:4583
> >  try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4778
> >  shrink_one+0x3b9/0x850 mm/vmscan.c:4816
> >  shrink_many mm/vmscan.c:4879 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:4957 [inline]
> >  shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
> >  kswapd_shrink_node mm/vmscan.c:6765 [inline]
> >  balance_pgdat mm/vmscan.c:6957 [inline]
> >  kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> > 
> > [2]:https://elixir.bootlin.com/linux/v6.14.3/source/fs/buffer.c#L97
> > 
> > Best regards,
> > I Hsin Cheng
> > ---
> >  fs/buffer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index cc8452f60251..29fd17f78265 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2883,6 +2883,8 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
> >  	struct buffer_head *head = folio_buffers(folio);
> >  	struct buffer_head *bh;
> >  
> > +	if (!head)
> > +		goto detach_folio;
> >  	bh = head;
> >  	do {
> >  		if (buffer_busy(bh))
> > @@ -2897,6 +2899,7 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
> >  			__remove_assoc_queue(bh);
> >  		bh = next;
> >  	} while (bh != head);
> > +detach_folio:
> >  	*buffers_to_free = head;
> >  	folio_detach_private(folio);
> >  	return true;
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

