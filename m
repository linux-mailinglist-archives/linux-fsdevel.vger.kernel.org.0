Return-Path: <linux-fsdevel+bounces-50844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED212AD0322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD23B2CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C328934B;
	Fri,  6 Jun 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMeXzgKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BE288C36
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216298; cv=none; b=n9/vnpTR62CYuBw1bvRnoaf3NJnZ/3AAAokryiB9+ybTaHyrQqbVxPwEUy4HGd3r3ChHjX+cwHt3lSBL1boP2rnky6gpdFMB+IqX8IkQEdVqZ/B3ECu+7d8OIMZNoR5RpWch7MIpyK8TigjLwnW6XtMfhaz7qRA5o47z1HUx+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216298; c=relaxed/simple;
	bh=XaUFchsTlj47ki7jmwSOkGfvA6QoHDzYcRN06zVBsh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0a3MMWd5T1XfKJjpdfmsHwU2aGKU40OIM3oOPfPEON2sXlGYt56R7g/+Jz44VG70kW+op72OiYp+8Mmwep4WiuPiXxCH+cVWwpIfRlso5uzKpd+Dc8dHEQsKTyy5UAf94bHKABZg0GpZ2LyTp2SlAvBeByBx7wArVJQN/KlHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMeXzgKt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749216295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky+WeROHZ4Ae+uVfELGBGltSg87Rkj3Uw9xYsa9j3qg=;
	b=bMeXzgKtFZH5L+oZf1hFR+XQI6E8Tbd/sEYeWgE75j5Rs4jXghP8SAo4wlrfFI16vuJtk+
	LVSjAOXGf2EaHjNJuxT8dlTk3E6Oj6qFWAg0XUnZztTdhFpWZxmFZp1brkqiUSsPTAIbav
	PSrrx4kbcrTWiMhLzJVQChORU/XrmWQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aA6b4nwxN-adQvsq48UqYA-1; Fri, 06 Jun 2025 09:24:54 -0400
X-MC-Unique: aA6b4nwxN-adQvsq48UqYA-1
X-Mimecast-MFC-AGG-ID: aA6b4nwxN-adQvsq48UqYA_1749216294
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5d608e703so404787385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 06:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749216294; x=1749821094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky+WeROHZ4Ae+uVfELGBGltSg87Rkj3Uw9xYsa9j3qg=;
        b=rCzuNQ1cLH8eS/MQvIVJsPM3A0hPc5Ag18JTmIK6wGl83iegDUgF7T5Oy0N9v6YXpe
         2rQJ8tbA7L1iWi2nPJbTWh/rQR9jvrcP+J/DqitM/MkBCcOP5pfbqSOsNSo4MC0/hvdv
         r8x3nVchZY+DiyuzXR45IeT4/FnvXhk+hjNapCrJm0SAWuaIVabniR6uKuNGrdx+5Bz3
         S6EG9xrEBh7XUA8yTRN60Z/9af4w0kMk8Lm89Gpf1Kpmsue3HIDKg9XsoedF/D6YkHXe
         EVFvaApck6QnQwCNV1IepeV0TQkqbIdpoOIZXYWGiPYEA+7pY+NLYPzgJzTLjRJyYOH6
         ZcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUjR6pUbs9ox+24AHn8DONTEmColYZTHp7tKb8uCmrseZOVNElTgv3EjoN3wKK8ZrKXcJ00mnPSRYEuJMgc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx07HkIrNimpHSklfH6bWxv9GHmRoFRiu8w7ZcVNPYYlv/UBCS
	xhtJ8ldEOm+EYKgSSQkshwnZR+ujIYvgU0fUk2XsbEE4Dr32BnhTOz2jA9raDvHu6N3V2ZxawSi
	OqN2IsFHsFOY+yPkKmXXinHcicqQzkHGCu+Ovgo4e0sZrnCFJYjuytgxDy6rdAZQKH94=
X-Gm-Gg: ASbGnctTDkK0MEWm39fXzzECx0pkUhmVo/kjW3BDW4RgP/BAnhcSxwhJdcub6FxA/VM
	pYbGvpfGLIBteUeAHwstzLa7U8xmUkMdGveZ0KWHoK63BKgHCMPeek9z52h1hkfT6RhVWeCUIYJ
	5QfHKminJav3dXg71lRvMvXdOZBeeWQ+qkYJ6BfieLUt5SGfnH7+yeyNtsBburgZ/jjJwWTSUXa
	s9Eo77VfB0n8ScqTFuLAC+DMJnMenw8c1t63dnVVGclvq9uwAVO7JWAxBTWf26DNAysFZvGSd1i
	1kQ=
X-Received: by 2002:a05:620a:2608:b0:7d0:9688:b650 with SMTP id af79cd13be357-7d22990277cmr623270985a.54.1749216293751;
        Fri, 06 Jun 2025 06:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyw7rhIbtMEbMw7aXS5kBcEv8c0niayT/VMXPsAHzS6JTC/rav5RqlYy0t+iQ6S4rhlqvdfA==
X-Received: by 2002:a05:620a:2608:b0:7d0:9688:b650 with SMTP id af79cd13be357-7d22990277cmr623265985a.54.1749216293377;
        Fri, 06 Jun 2025 06:24:53 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a5948f8sm129289485a.49.2025.06.06.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 06:24:52 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:24:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Message-ID: <aELsIq2uOT5d1Tng@x1.local>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
 <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
 <aEBhqz1UgpP8d9hG@x1.local>
 <CAKha_sqFV_0TsM1NgwtYYY0=ouDjkO7OOZc2WsR0X5hK5AUOJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKha_sqFV_0TsM1NgwtYYY0=ouDjkO7OOZc2WsR0X5hK5AUOJA@mail.gmail.com>

On Thu, Jun 05, 2025 at 05:11:53PM -0400, Tal Zussman wrote:
> On Wed, Jun 4, 2025 at 11:10 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jun 04, 2025 at 03:23:38PM +0200, David Hildenbrand wrote:
> > > On 04.06.25 00:14, Tal Zussman wrote:
> > > > Currently, a VMA registered with a uffd can be unregistered through a
> > > > different uffd asssociated with the same mm_struct.
> > > >
> > > > Change this behavior to be stricter by requiring VMAs to be unregistered
> > > > through the same uffd they were registered with.
> > > >
> > > > While at it, correct the comment for the no userfaultfd case. This seems
> > > > to be a copy-paste artifact from the analagous userfaultfd_register()
> > > > check.
> > >
> > > I consider it a BUG that should be fixed. Hoping Peter can share his
> > > opinion.
> >
> > Agree it smells like unintentional, it's just that the man page indeed
> > didn't mention what would happen if the userfaultfd isn't the one got
> > registered but only requesting them to be "compatible".
> >
> > DESCRIPTION
> >        Unregister a memory address range from userfaultfd.  The pages in
> >        the range must be “compatible” (see UFFDIO_REGISTER(2const)).
> >
> > So it sounds still possible if we have existing userapp creating multiple
> > userfaultfds (for example, for scalability reasons on using multiple
> > queues) to manage its own mm address space, one uffd in charge of a portion
> > of VMAs, then it can randomly take one userfaultfd to do unregistrations.
> > Such might break.
> 
> As I mentioned in my response to James, it seems like the existing behavior
> is broken as well, due to the following in in userfaultfd_unregister():
> 
>     if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>             goto out_unlock;
> 
> where wp_async is derived from ctx, not cur.
> 
> Pasting here:
> 
> This also seems to indicate that the current behavior is broken and may reject
> unregistering some VMAs incorrectly. For example, a file-backed VMA registered
> with `wp_async` and UFFD_WP cannot be unregistered through a VMA that does not
> have `wp_async` set.

This is true.  Meanwhile it seems untrivial to fix the flag alone with the
prior per-vma loop to check compatibility.  We could drop the prior check
but then it slightly breaks the abi in another way..

Then let's go with the change to see our luck.

Could you mention more things when repost in the commit log?  (1) wp_async
bug, (2) explicitly mention that this is a slight ABI change, and (3) not
needed to backport to stable.

Thanks,

-- 
Peter Xu


