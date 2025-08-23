Return-Path: <linux-fsdevel+bounces-58880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A9AB327AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C694FA08136
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27EA23D28C;
	Sat, 23 Aug 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK1XxCQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9223B618
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938597; cv=none; b=N/IEgNDRu2hraosQuO0A2z5pwTrU+D6E15E+dB99JhNJn4b9NgRI0fhKipWHjFe8m5lPOCCdfcWWbQ+fonLVQ7N5tyt1OmjVaf757GZefxoW14C6Yv7AFhONPmn1Brr5hLY9mGMNlEGTkkCKkSJ14numCgiScNxl0tzL8VCCxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938597; c=relaxed/simple;
	bh=vwT0CoRft+GqrIkEeWlH5uEscBgnhyYA/SV4+qTNQXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP7TJD2Jvbgin+prTpdS2VVxvcWWYz/eyRVjDWo8USUyjqQHd1aJGaNmTF72UuvwG8xJIoC8hCI1YLaWqZUQc7bUqRKW/btNy7jZZgzpDSheX2zqwZm7Z/AoUtcapSRHeiOfzR3ccbWQ+hbGLSu7Uhub38mnTPWPTk2oEj620tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PK1XxCQm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfULO7YLxz7Z2uNy7z4zt/dNZhLkVeddOKxR2NJeRMc=;
	b=PK1XxCQmqPnSDEVsg4ux8EJdKD+hxfiafAAUPSDwhsDBiEo1GIci8UauAlgpquJO2NFkIx
	SKq1lNI2Zcz5FwzS9b0w4s8729C4Pw3YOReF9u+uE4bEJ4Cz4YOza7lOpZwcJFP4szf7Mp
	/2dvoE2c7J/lZhWz/WYK+FofOxaVsZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-YBsiQm1INuiEhh7h9F9GBQ-1; Sat, 23 Aug 2025 04:43:08 -0400
X-MC-Unique: YBsiQm1INuiEhh7h9F9GBQ-1
X-Mimecast-MFC-AGG-ID: YBsiQm1INuiEhh7h9F9GBQ_1755938587
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so13162145e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938587; x=1756543387;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfULO7YLxz7Z2uNy7z4zt/dNZhLkVeddOKxR2NJeRMc=;
        b=hUzH9LMum09mejV/UvjJTWiTr7aoskOptwd6/F/lb4Fyg8uODhyzIts52vaz8erVcU
         4yt6/XXgUmVKpOIIIjYqk5VJRQXeuN7Vn+9aKQMF5gvME3j7+T+LVnpNZO0bV1/vNsBJ
         JTP3N0/jdlfJ2hbkxLqM3MmxtA1paEE5YoQj3jPHFJTWrwezOfUmNmGwAvz+nKw4g6D+
         TFOknJMbgkDqJqAwacU8YsFXCPJaIMionqUkOGn2v6u/bBF6jPup8iQFjOSqXLBEISPM
         /IYpNSb0ShppLsOFrpiqYRmlidy0nhpZ1mwBbKvdBGG7UXreMcrp8tEJRU51QRijlH+t
         ZlkA==
X-Forwarded-Encrypted: i=1; AJvYcCXWTjCXVJvAzS+by6RZYKi2QFkFoF3CQ06bPPNVBZQmP4/BvahbDA6b+xSyxOvkRSdj7fCKd4uMymbLjaf6@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYgCwRHFIFJEa3JYZlfvqtglgu1woiEcVekg3dPRtf18Kl5Y6
	lTNWARJaGX9iERSezhHyHP1dxb1qNbImRazP1WiMpw6GmhG6SNUNfZ0DdQk7c21YEDzJJVVNp+J
	8/otMi0CjktmfE857F9ukGzQ1dJJdwnyWkt6DOhKHkue/PmFgNtnaQODe8AqSda5HQYo=
X-Gm-Gg: ASbGnctGVtUD5lBs6c4mc1lKjozRKlE+aP4pJ3zZo1+8oLu+3lUsKqvubSQWPeGqIjK
	SSXWo70qVRBkhYuH0gMtvGhNy4XYa/UpWz9VF1fWeKvotaAkqvcOQM7rCsY7P4aOlMY7pUp1DT9
	CJmLyEVmw0ApKfZk/5M+6B2XEwXknDmwALGnqtW+2ek9hk1cg42nLRDTTwamUARerDSWc5K6H57
	dqGiEJA4uORxVyG5pgDuFA8c1Jn9RtAOu7UpYZL50Utmc/96pDwztqayVw7TMF3QT009SgiTSfX
	1lMFbiS1P60a3u7ESaCZQKFw3IJC0vAXmtEHflFYjS8HUFdjzrw=
X-Received: by 2002:a05:600c:45ce:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45b517ad7ebmr46997495e9.13.1755938587196;
        Sat, 23 Aug 2025 01:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvj5I9ZXxDJGaFwa0dfJ5P6LVd376XfbNITRqgnxSw6PLCrBR5O0c8jn+3Z4dPfT9BVo3FDg==
X-Received: by 2002:a05:600c:45ce:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45b517ad7ebmr46997215e9.13.1755938586708;
        Sat, 23 Aug 2025 01:43:06 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm2954620f8f.9.2025.08.23.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:43:06 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:43:04 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: wangzijie <wangzijie1@honor.com>
Cc: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
 <brauner@kernel.org>, <kirill.shutemov@linux.intel.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <passt-dev@passt.top>, <rick.p.edgecombe@intel.com>,
 <viro@zeniv.linux.org.uk>, <jirislaby@kernel.org>, Lars Wendler
 <polynomial-c@gmx.de>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net
 entries
Message-ID: <20250823104305.148e3a02@elisabeth>
In-Reply-To: <20250823015349.1650855-1-wangzijie1@honor.com>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
	<20250823015349.1650855-1-wangzijie1@honor.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi wangzijie,

On Sat, 23 Aug 2025 09:53:49 +0800
wangzijie <wangzijie1@honor.com> wrote:

> > Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> > as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> > entries, as shown for instance by pasta(1), a user-mode network
> > implementation using those entries to scan for bound ports:
> > 
> >   $ strace -e openat,lseek -e s=none pasta -- true
> >   [...]
> >   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
> >   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
> >   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
> >   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
> >   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   [...]
> > 
> > That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> > and it's now mandatory for lseek(). In fact, flags aren't set at all
> > for those entries because pde_set_flags() isn't called for them.
> > 
> > As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> > files") introduced flags for procfs directory entries, along with the
> > pde_set_flags() helper, they weren't relevant for /proc/net entries,
> > so the lack of pde_set_flags() calls in proc_create_net_*() functions
> > was harmless.
> > 
> > Now that the calls are strictly needed for lseek() functionality,
> > add them.
> > 
> > Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >  fs/proc/generic.c  | 2 +-
> >  fs/proc/internal.h | 1 +
> >  fs/proc/proc_net.c | 4 ++++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> > index 76e800e38c8f..57ec5e385d1b 100644
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -561,7 +561,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
> >  	return p;
> >  }
> >  
> > -static void pde_set_flags(struct proc_dir_entry *pde)
> > +void pde_set_flags(struct proc_dir_entry *pde)
> >  {
> >  	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> >  		pde->flags |= PROC_ENTRY_PERMANENT;
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index e737401d7383..a358974f14d2 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -284,6 +284,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
> >  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
> >  extern int proc_readdir(struct file *, struct dir_context *);
> >  int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> > +void pde_set_flags(struct proc_dir_entry *pde);
> >  
> >  static inline void pde_get(struct proc_dir_entry *pde)
> >  {
> > diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> > index 52f0b75cbce2..20bc7481b02c 100644
> > --- a/fs/proc/proc_net.c
> > +++ b/fs/proc/proc_net.c
> > @@ -124,6 +124,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
> >  	p->proc_ops = &proc_net_seq_ops;
> >  	p->seq_ops = ops;
> >  	p->state_size = state_size;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_data);
> > @@ -170,6 +171,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
> >  	p->seq_ops = ops;
> >  	p->state_size = state_size;
> >  	p->write = write;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_data_write);
> > @@ -217,6 +219,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
> >  	pde_force_lookup(p);
> >  	p->proc_ops = &proc_net_single_ops;
> >  	p->single_show = show;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_single);
> > @@ -261,6 +264,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
> >  	p->proc_ops = &proc_net_single_ops;
> >  	p->single_show = show;
> >  	p->write = write;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_single_write);
> > -- 
> > 2.43.0  
> 
> Hi Stefano,
> Thanks for your patch, Lars reported this bug last week:
> https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/

Apologies, I didn't see that. It's definitely the same issue.

> Jiri suggested to make pde_set_flags() part of proc_register(). I think it can help
> to avoid lack of pde_set_flags() calls in the future and make code clean.

Right, I was pondering to try something like that, but I just wanted to
submit a minimal fix for the moment being.

In any case, you have it ready, and it's obviously cleaner than my
solution, so, of course, let's discard my patch.

> I have submitted a patch:
> https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

I just tested it, it works for me. Thanks for fixing that!

-- 
Stefano


