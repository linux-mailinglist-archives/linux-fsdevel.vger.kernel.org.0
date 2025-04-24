Return-Path: <linux-fsdevel+bounces-47264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4BFA9B1CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4401B81B66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1791A5BA2;
	Thu, 24 Apr 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gouCwExc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7A14F9EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507482; cv=none; b=RziMP2aRXUIos4rwdD2BvIJ6RnWVGkyFfwYq6gaefwLpSlHwtXcWAiot/u5ke7htDBetHFvZ4ECrMysmXuhU7po9m+49YTWrWP2zgeVVqGvC7hXOx8hQW7JZlKASWqcemqRrrzuhp375DxYV5vupU00cU51FSwJCu1zkl3optjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507482; c=relaxed/simple;
	bh=i0j5n5MA0G0WwVVPUBn62uDfZs8NPnZQC+0b1YodluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbjj0AL2GkSv2zRV8kQbzFFxGuBmoVmu07EsDt4agLXOJKEeEU0SEOsiK7zU2gjwPm402j5ePdfLWC4YLhj3kb+TCIyoYeqPJLg47W0FOJsObDIDcmfNr/vE+OZ6pBC1v6fxLdnYeBhvVYfFx74aMGm+PFZXyqIKayiDozuUEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gouCwExc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c554d7dc2aso201051585a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745507478; x=1746112278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nffPhy7+/1fHzsvZGaqtOAHSR9jHbQYk5b0XbZQ1C2E=;
        b=gouCwExcFAZAnHcj7zjsM7F6JWdHzHUgwQdSrY9z7nV0J2O53Eqfv/bgJlW4eLOw3D
         0OIN5f5et28qvxLN0LOZEKwlg2vgBW6r+sx4O88Ab68cahDpAnM/0bjqTSRx+racNbF9
         MicOp8SVz9tZKLVM7n8jlwxDfhauUSN+D0hupAM9FHCIVTX7B6elo6TpR5+hLfp0tbWF
         GyHB8U4LKSpSlT4w6hONzVOTCeyliGZVe8wYREFrtWp8YPSLDAYoRw/TuyOwizA/LGcI
         iMxSpEkI8KhadrXXakIVMFLqFyG9LWMC0tOaFtmxNOtvwieFTOe2k5lmvltEvYRapKm0
         AB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745507478; x=1746112278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nffPhy7+/1fHzsvZGaqtOAHSR9jHbQYk5b0XbZQ1C2E=;
        b=GiKaxJG8CH87USxWZWiBGYkHHGQjcDF3GW4W8umiDURWzuqZ132A9PqrTFm4zb3uIj
         vKQE5HY8A4bGohEBJNjFO/MxG3sdHbiXRTjoLSRxkpn6TPdaZ95JrJ1r/tfqOH9KsC8d
         hBsuYWDKtElPMQT5y85sisbn+2ui3RT2nbmhiCEQu+adxj/yQNFIWQ/86izr4r7YXW1p
         QvjLxkgPR2+lzq/In0osInyMqYoZpRYRK9y86oxBF4gFyLfjWvNVNuSUxKT9i0RSd0dx
         8ZmmF2v7iRgsbE02gt7YocJkpfdNpeOqVzJ05igWJzh7YvDU0Whb6wpn8RUMNEOyH+4z
         ZtZg==
X-Forwarded-Encrypted: i=1; AJvYcCXmfQc8bu8kfM3C2ntl2zRtZ4fNR3RAg1QauPxbzVNwzvsfFy2WcdHoc8VVkzK3oNZbHSkAF55MhxV62hJf@vger.kernel.org
X-Gm-Message-State: AOJu0YxnS07axOIo7KABblq9EWCNro8irR4O1m1z4RV/t9LQfnpNL5Du
	0dcQSKC+oKX40/B/dQrwf/F1IbJGk0e8i/4XUntGB1VmQnX0z4QXxbrwmGdy+nE=
X-Gm-Gg: ASbGnctjzzdt401s1ESMlkacDSgbySbStVtn/EuzRShhourP7c7z8bio7/BAjK4r4RZ
	Dd14RaO1cY/tOyaFlZUk5yPqMSmutf8ngRNbd+zoewQhztiGks4JtLVdVnHTn7P19xYxGrvARlR
	Lge9Q6GXV890VJRJuo8Ajcd54lEd2O5s/KxtpI1Q0TK5lGxkCWN9gDbva0q5tZsjofcQdHM98+q
	xe6se4RAPlV5jqMyoya6o4uoRajrZI7n7UX6RusRPMKXxegKeXC4+7YtW28vGxbeQXYsKsWEBdK
	m9HR59uGMoL2ihSrYyN/bgd9J4QcPlqM/Lxenz4=
X-Google-Smtp-Source: AGHT+IGugZ4dF2360yKjAcGWiDkcFFtJjxjGhEjgxriLCMHcwp/Y1qZjg2WQK27E+f+8geSIHYcM/A==
X-Received: by 2002:a05:620a:f15:b0:7c5:97ca:3ea0 with SMTP id af79cd13be357-7c956da4cdbmr405074285a.0.1745507477917;
        Thu, 24 Apr 2025 08:11:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47e9efdad60sm12934791cf.28.2025.04.24.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:11:17 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:11:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <20250424151113.GB840@cmpxchg.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <c68882dd-067b-4d16-8fb8-28bfdd51e627@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68882dd-067b-4d16-8fb8-28bfdd51e627@kernel.dk>

On Thu, Apr 24, 2025 at 08:54:40AM -0600, Jens Axboe wrote:
> On 4/24/25 8:03 AM, Johannes Weiner wrote:
> > On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
> >> userfaultfd may use interruptible sleeps to wait on userspace filling
> >> a page fault, which works fine if the task can be reliably put to
> >> sleeping waiting for that. However, if the task has a normal (ie
> >> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
> >> cause schedule() to be a no-op.
> >>
> >> For a task that registers a page with userfaultfd and then proceeds
> >> to do a write from it, if that task also has a signal pending then
> >> it'll essentially busy loop from do_page_fault() -> handle_userfault()
> >> until that fault has been filled. Normally it'd be expected that the
> >> task would sleep until that happens. Here's a trace from an application
> >> doing just that:
> >>
> >> handle_userfault+0x4b8/0xa00 (P)
> >> hugetlb_fault+0xe24/0x1060
> >> handle_mm_fault+0x2bc/0x318
> >> do_page_fault+0x1e8/0x6f0
> > 
> > Makes sense. There is a fault_signal_pending() check before retrying:
> > 
> > static inline bool fault_signal_pending(vm_fault_t fault_flags,
> >                                         struct pt_regs *regs)
> > {
> >         return unlikely((fault_flags & VM_FAULT_RETRY) &&
> >                         (fatal_signal_pending(current) ||
> >                          (user_mode(regs) && signal_pending(current))));
> > }
> > 
> > Since it's an in-kernel fault, and the signal is non-fatal, it won't
> > stop looping until the fault is handled.
> > 
> > This in itself seems a bit sketchy. You have to hope there is no
> > dependency between handling the signal -> handling the fault inside
> > the userspace components.
> 
> Indeed... But that's generic userfaultfd sketchiness, not really related
> to this patch.

Definitely, it wasn't meant as an objection to the patch. The bug just
highlights a fairly subtle dependency chain between signals and
userfault handling that users of the feature might not be aware of.
Sorry if I was being unclear.

