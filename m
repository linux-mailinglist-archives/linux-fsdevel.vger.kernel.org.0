Return-Path: <linux-fsdevel+bounces-50625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0211ACE115
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221157A45F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60B17A316;
	Wed,  4 Jun 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8PQgbg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8D6AA7
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050234; cv=none; b=MrP1JOReUQlNKqpmIujgMyOhHcqI5IPZ8HJonVtlC22XeDnO4A3/qtES36FTU0xTyTS4gY0t+V0as8/pXU93OGnptmYBS5+LHHX9OdnddOfYii5PvcJti6E4bNahmTwGWSlEa+XMg3Da9QLnHDk3DlXxDC9hUmimHvHmGICCV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050234; c=relaxed/simple;
	bh=tXH56JHUlfyoRgZiUau7pzUNxZ5GWldWwVrR7Gic760=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyKrwabdAQP1m3uyLlZYJr0k1vuleuqkiiviteJM2wpSqDbf11PVsVFZwziQWHnzxkHwe4/kIKCUr/jVPENCc5wVYYwWebKbyh9Bme4CdaKD8HifkZ9VLeR9/UBEK/qeWIPV7an702cI6VdyrHfv5gAyX0pN58pxuuJP39+PX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8PQgbg0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749050231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAdOdBBJjoeMC7x6P8PsA8kBAyLqFtv7E13NLSQh4UI=;
	b=F8PQgbg028cWnr3lXSoOlg+mctu/kuCshbhznluesfnElZnmzyPpUaRFRxbzlJBaFHdQaS
	ZUrbTUu4FY24Jzgn6btPdG/5JYCDqkZWoXAjygi+wPiLWaHwC2rgD5CVy5Xhu1zUljApel
	Qmkghb43WqMd/3zAtnfYnQYTQwN9wFs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-HGNTVV8YNAeu9MyR7YrKTg-1; Wed, 04 Jun 2025 11:17:10 -0400
X-MC-Unique: HGNTVV8YNAeu9MyR7YrKTg-1
X-Mimecast-MFC-AGG-ID: HGNTVV8YNAeu9MyR7YrKTg_1749050230
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d0981315c8so716607985a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 08:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749050230; x=1749655030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAdOdBBJjoeMC7x6P8PsA8kBAyLqFtv7E13NLSQh4UI=;
        b=oR9gcpOIpQslDxN3AY9hDjHW4zIUBL3qy5khCzlFp1f77zRqJyLhOggDLkhlcv3A/a
         UVz4/7k8qhznmjEAhB9K7anRp4wKVV5AuIQNvOtid5jfNhtGfuBTIWCh6nxS7zhUW9gs
         AYOfLpVm7s/mGNDNgQ22f+AlpGNoBBaianHMSBwAuFTxLJF0KQl9CYjtYg5Si5lBPsi5
         pil42Ghl1+2q63+zCIqWDQJ2dqTdGHblwXLreHHLo7fwWvsnXNiSPtZnHOIowe8MJRFW
         z1nNleoiQLd8zuBKBHFVA2kZYcpr5XfmrhK7UDu2N5iJbSZCt4SPrpfRcDhDkqMZYKur
         kH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWe7qUhoYnTSts0zWL7cwhoYw4lOp0XExi2b2uD8LHo/jH3/SoJ5op4adD5fNAf45XvyAtQkK39MCgtNz4/@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEf7WLLailJ9itugbQZZYO6dT/3pYtYTu/XpVCneWcQ9ciE+/
	+2BbSF+zLaPL+TEPnhz+xgLHt9LjZCxQIDBeUkQwBnynKkiUQbPEs/HltFHGdp5aqg/Fe1PNGvZ
	G8d98eRiNmyAb3mR4vee94lrB6+0bVnzFtm68A0V6xZHVlWm6xCmTKwTuZcJ/y+b7Eyc=
X-Gm-Gg: ASbGncujQ4mZVtMIFUlBtMWaLzqoL1+3R8OjfRExHpKx+PZugEJYqulqY5/K2dw7IUk
	sQHtNOrCRBnI1XA8x3aeCVoqD+qkKOnVbsyieWGu94DfXCVYmzduPt+cmcWBhvBhARWPJIDVL3s
	BAUtGgWRMLX+/foF+9be5joOqhTIukx9s4/YyG+J9a8iSd174N9dXPnzrAl3t2AE0lRIa00tXF5
	ZmBder93CWV61XFmgMiEn/fArHZ3jrARg2wKu+D6s/RMV22llKvXxA01MFv4U+OCn+vA5hb33gw
	mSA=
X-Received: by 2002:a05:6214:20c2:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6faf6e6c1dcmr48552156d6.13.1749050229900;
        Wed, 04 Jun 2025 08:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Juz+/OHdwV5pYpuhISYl5xStTVIxTd7k3oUhwd8cUIXT1FVDQ61Tf1SCXJtXAFKxhE9W9Q==
X-Received: by 2002:a05:6214:20c2:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6faf6e6c1dcmr48551666d6.13.1749050229490;
        Wed, 04 Jun 2025 08:17:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1a7579sm1042399285a.106.2025.06.04.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:17:09 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:17:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pavel Emelyanov <xemul@parallels.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Message-ID: <aEBjct3IJiDX-w3P@x1.local>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-1-9c638c73f047@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603-uffd-fixes-v1-1-9c638c73f047@columbia.edu>

On Tue, Jun 03, 2025 at 06:14:20PM -0400, Tal Zussman wrote:
> vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
> The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
> allowing VM_DROPPABLE regions to be registered with userfaultfd.
> 
> Additionally, vm_flags is not guaranteed to correspond to the actual
> VMA's flags. Fix this test by checking the VMA's flags directly.
> 
> Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
> Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


