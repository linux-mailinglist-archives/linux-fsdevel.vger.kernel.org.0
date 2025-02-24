Return-Path: <linux-fsdevel+bounces-42545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E2A43174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 01:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DAE173646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543E20DD67;
	Mon, 24 Feb 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nJEujMpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FA20C476
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441387; cv=none; b=IFpGILMayr+uV8X6ECWPY6E2F9dy9WYkDhu1ILs5oIODE2KezeES6llfr15uPaCNoD3Vylxbyg2lRlt9pDu10dTM+jDyU1R0SH2AeLUo4hVohl/9UCH2ufdGT43F3PFaP1KWGdycoZ6LGCZzA50WV4dWacK8WLb6a4vCEKjO7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441387; c=relaxed/simple;
	bh=/RiCWg0mbwmsFtYvk5iC1bcu6u28eSML6ide49NOnRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2Y7OmhR5raEezd6fUstzuziKcI44i76+PI4HmgNBV8ERZS4Z1DtTS57PmlgUmYZBetB30mDmbZRR4RRJWn71MTOsOmmJ+WNqBTrWonah5mCNGusWUo+gC9d5I56kpDYIFOG8h3vBCNlqtg6Y5CDClX0Dr6f+h824H+kzegpApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nJEujMpz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c665ef4cso86987235ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740441384; x=1741046184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRvTiYEU0DIWKzrEf3PrUw6znX+VEmOhmQ+RurgzOXk=;
        b=nJEujMpzgX6alOMC3EjCRHclUlijvwZxMwLTmE+Z06QK21bQmPPgSy006zEmIH74CU
         f/g2J5sY9/PWhz4wB5HhtIYDIHq+bYflpYzByKGy0EXwBZhbCGgPS7svrpmAtDAU32QJ
         SZf2fM3GYvMs8IaoBkOTmzE3jVqCedNswU19ydYJ/qceng+a0O9YEmYW8azwL6MTMAoP
         E/1liHZFXcTHUWYokrG0qGjNc6Dboi+ps+v5t6gpDkCNCqia27fuEE+mKiS3B0LWopej
         rATUWTbUpm04TALp9inMte9oQRHXkR8/qUqWW287pGTm20ipxRlY8hHqWjhojw6bMYhS
         T6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441384; x=1741046184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRvTiYEU0DIWKzrEf3PrUw6znX+VEmOhmQ+RurgzOXk=;
        b=HLa9el22LTElSuROp6a0b97hVxAP+JGiNZuZUZYx9JCoH5K0BNXVUWI6HqTKiMTptQ
         93BXk74p+lorI9ms4KUmtt+mmIBgUD0oD9UOgv/NL8aAhQnuntOJqwLyIXRwROAnUXG8
         6Nk3DMWzRPDmhsGf4Sp7RgdvTidjvzSw52otcwltAZjix7s/gZDO0O/LpEGLVuhCNSmZ
         zjTwuHwKxErZJUgq3tTTR0IMt3mKoIbPTbeQhjrt6XKV+6XTRRAnMKulKbCnRWLKklJF
         HypH7LFV4uO/hIxZ8La3dmhU4bax0WTAzJ1FZGYEDQoIXP2pvUWLY39TYmbJ2D2qKjs+
         I1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6GEjoEyiIznwkxRsl56tuAaQ4ifE3br9QLI2o1H9EgMl8RLIr4kfLkZRQJm2StkUFckaeDozguJFt3LLk@vger.kernel.org
X-Gm-Message-State: AOJu0YwNj+UOAywBal/FnhIgNIuTcU8tK0nqxgjlvh6txGVn0JkwoKd1
	PFxCTXLMwUauIWlPfOoYKTsV7V7Wu6YgbKCkek6OVPlfk0TkfdN0EaRWuAnf2wI=
X-Gm-Gg: ASbGncveNhTBCvYTQTd6aGJrl72x/JHUCmhAde0SUNw2ddbUgGUaj19qJH27k9+qYY3
	8LGbWWdgPJozEi/MZ8BSXJBtcAgUmHgEGV9BlYccE9Go8y7HoU6yVH1yZ+kyNndff1JZFUGbpyY
	aSok0QLpHRdco+Oj9rFQA+Zc0q6D+/s5yXQosyhDA26iMDNLnFMTsHUpk0Fjc7rl0XaF10fH0zy
	pfX2rYaNWzkGM+QGJgDDaLYWoHMhUdqgsfeYeONmKuoQfhkkdtBhlUKqmIZgh6H4BcBQZQKvYHq
	UDuPtGmriD0lMq2WfUOGI/3lBx40wLYmF1kcqDMNsRjqSAUYCA4JAIC9FdX7Wbg26Ao=
X-Google-Smtp-Source: AGHT+IGbWPKHZBl2SGmtWlS61E5DNhroaDo/9OwE/K0b4fTSm2X9AcdRjflngJr1VE55pq8/V5a00g==
X-Received: by 2002:a17:902:e54e:b0:220:d256:d133 with SMTP id d9443c01a7336-2219ff9e7f3mr281552575ad.14.1740441384566;
        Mon, 24 Feb 2025 15:56:24 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a639dsm1805515ad.203.2025.02.24.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:56:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmiJB-00000005YIP-42JH;
	Tue, 25 Feb 2025 10:56:21 +1100
Date: Tue, 25 Feb 2025 10:56:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>,
	lsf-pc@lists.linux-foundation.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Juan Yescas <jyescas@google.com>,
	android-mm <android-mm@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	"Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <Z70HJWliB4wXE-DD@dread.disaster.area>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>

On Mon, Feb 24, 2025 at 01:36:50PM -0800, Kalesh Singh wrote:
> Another possible way we can look at this: in the regressions shared
> above by the ELF padding regions, we are able to make these regions
> sparse (for *almost* all cases) -- solving the shared-zero page
> problem for file mappings, would also eliminate much of this overhead.
> So perhaps we should tackle this angle? If that's a more tangible
> solution ?
> 
> From the previous discussions that Matthew shared [7], it seems like
> Dave proposed an alternative to moving the extents to the VFS layer to
> invert the IO read path operations [8]. Maybe this is a move
> approachable solution since there is precedence for the same in the
> write path?
> 
> [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
> [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.area/

Yes, if we are going to optimise away redundant zeros being stored
in the page cache over holes, we need to know where the holes in the
file are before the page cache is populated.

As for efficient hole tracking in the mapping tree, I suspect that
we should be looking at using exceptional entries in the mapping
tree for holes, not inserting mulitple references to the zero folio.
i.e. the important information for data storage optimisation is that
the region covers a hole, not that it contains zeros.

For buffered reads, all that is required when such an exceptional
entry is returned is a memset of the user buffer. For buffered
writes, we simply treat it like a normal folio allocating write and
replace the exceptional entry with the allocated (and zeroed) folio.

For read page faults, the zero page gets mapped (and maybe
accounted) via the vma rather than the mapping tree entry. For write
faults, a folio gets allocated and the exception entry replaced
before we call into ->page_mkwrite().

Invalidation simply removes the exceptional entries.

This largely gets rid of needing to care about the zero page outside
of mmap() context where something needs to be mapped into the
userspace mm context. Let the page fault/mm context substitute the
zero page in the PTE mappings where necessary, but we don't need to
use and/or track the zero page in the page cache itself....

FWIW, this also lends itself to storing unwritten extent information
in exceptional entries. One of the problems we have is unwritten
extents can contain either zeros (been read) and data (been
overwritten in memory, but not flushed to disk). This is the problem
that SEEK_DATA has to navigate - it has to walk the page cache over
unwritten extents to determine if there is data over the unwritten
extent or not.

In this case, an exceptional entry gets added on read, which is then
replaced with an actual folio on write. Now SEEK_DATA can easily and
safely determine where the data actually lies over the unwritten
extent with a mapping tree walk instead of having to load and lock
each folio to check it is dirty or not....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

