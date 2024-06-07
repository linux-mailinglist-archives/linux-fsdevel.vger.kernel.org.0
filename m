Return-Path: <linux-fsdevel+bounces-21200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56111900475
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701A21C249E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C919412A;
	Fri,  7 Jun 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gf/8G/fz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82E78C96
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766329; cv=none; b=Fu68QThXEbm5VSnpk1h1SNQMajD4W5C9RPDb214OIg63zuKC6cO7iUa4CmMG+L6kbLWkGr1LnHhSXwQUK5iR7BRQTrFKcnQVa1In8HM7yBmE18le2WQNAMbDgzfKUZLsJa1T6YrFdXSRGP7hp1i5GOqj81L/pS9qmbEUYfsfPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766329; c=relaxed/simple;
	bh=nxrhpfJSNSOyp/3P/72Vc5v+qaFes7O1pm1nHMhjYDc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ3EQz4/L1o6rwDBEXZUMqUjzMr1m9jvV2PwHOB4ECgov3SPlCXpnuLRT/Xpxdc09uYlodhUuihAFaaVMULYoBteqySpe+4FQLVn0IA6pVmWzsINNM9FWo8RJar+x8z5knVd5yXSNBp3SbkYtTUogZct598wYFGGl5NzwQt5ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gf/8G/fz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so23390901fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717766324; x=1718371124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNOtY9kbCwarj0NKj0Q/xsdwvI1gsG+x4nJEIzhwFBs=;
        b=gf/8G/fzWqOlKvRriGjReem4l5AXOoPsaUxt3IW/kb4CSZUBp+9Y1wkpLIPIvi3mDk
         nJr5wmMwbaF4MUWpLY6gDG2N+ABPBVou3Tyst4cEp40tTvAzKC8/3lc1xdzYpp5MC6H5
         9W14vcalpgTPdni3VNLQTAPQfBBmpghzVoTxDmxuZP1KacVUpA3YC3x3EbKqGgcHGVey
         ilkWpKbqAiuih371FW72noJDMCsYk+33SwQINTM1JHy93XNK5mKtBE2kWNti+1VSEcFW
         BguTf3i3Np3W0QVzajdjXDPVvC/hZkcK6qY/NM4dWfXsGXo97MK+gFp/SLp8z1b7VmjI
         wAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766324; x=1718371124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNOtY9kbCwarj0NKj0Q/xsdwvI1gsG+x4nJEIzhwFBs=;
        b=YiIk6Ez3Br1XzUS71bH/eohbqo3clVFqHJdnGD0Fja+TIaFaL58GMRAMXRKATmWzEJ
         63z/J7matgF9unAtuOVaRnJaJ5zElJmPV3yFnxx7xfImC5enry3IbvQN61qqwwoBMBKz
         OCEcDVBzV4Ekb10w2joLT5Ods8nF6Q/f3JoCcdPOGeav/Ro5M9oFnn8yYgEYrMQVGQr/
         L+WiNbcxKgumXZVOGSRFRmsuCY9sUuvCbP+yT4jfAp9YX13OaFpuG8AFoXFtur3M7a80
         UufhEwvhVRz5pYxYgw2ES+AqmlIvKfh8t0EjJeHESzDFjueqSTuPOR8MHaotTsFeDSqs
         81hg==
X-Forwarded-Encrypted: i=1; AJvYcCXPrXSII0BzMVWnEmgXfox4dnQuYjwVbWOxss7+5/51u/e36YMI3CMpvGzzIE1hX01SQjHhVxPx2uLVJeGdi2KTrobhu2tXOJO0LOw2TA==
X-Gm-Message-State: AOJu0Yw6cFBRfVs27zmoTWXBI/NludtIPgaj9yFIwget6isOTdh9LUV5
	TyWQE+SlBPQ/PWGn+FYb75N9KkRCq4tnU/fhjuIK5uVvDJqzAt6aXMzmhIUI2v0y3Rj7QypQn65
	6
X-Google-Smtp-Source: AGHT+IEBxyjXDl9VEt7rh7TeIxG6bOvGA4j17IdvLoM+xGRwnhFMyvO9AhcxnCYNWTyb7vuvBSDlAQ==
X-Received: by 2002:a05:651c:550:b0:2ea:e12e:bee5 with SMTP id 38308e7fff4ca-2eae12ec074mr11738031fa.4.1717766324270;
        Fri, 07 Jun 2024 06:18:44 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158111143sm87617865e9.20.2024.06.07.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:18:44 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Fri, 7 Jun 2024 15:18:40 +0200
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 0/6] fs/proc: move page_mapcount() to
 fs/proc/internal.h
Message-ID: <ZmMIsJ4Yg2r9bT81@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-1-david@redhat.com>

On Fri, Jun 07, 2024 at 02:23:51PM +0200, David Hildenbrand wrote:
> With all other page_mapcount() users in the tree gone, move
> page_mapcount() to fs/proc/internal.h, rename it and extend the
> documentation to prevent future (ab)use.
> 
> ... of course, I find some issues while working on that code that I sort
> first ;)
> 
> We'll now only end up calling page_mapcount()
> [now folio_precise_page_mapcount()] on pages mapped via present page table
> entries. Except for /proc/kpagecount, that still does questionable things,
> but we'll leave that legacy interface as is for now.
> 
> Did a quick sanity check. Likely we would want some better selfestest
> for /proc/$/pagemap + smaps. I'll see if I can find some time to write
> some more.

I stumbled upon some of these issues while unifying .{pud/pmd}_entry and
.hugetlb_entry.
I am not sure what is the current state of pagemap/smaps selftest, but
since I am going to need them anyway to keep me in check and making sure
I do not break anything hugetlb-related, I might as well write some of
them.


-- 
Oscar Salvador
SUSE Labs

