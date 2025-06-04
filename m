Return-Path: <linux-fsdevel+bounces-50623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C1ACE0F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF86318962ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1423290DB9;
	Wed,  4 Jun 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdw3uO9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5944AEE0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049781; cv=none; b=SSQcZ9SQgVhd6YfjHHj5K5qUi9+40IDQ6wkfT2ZVLOig2uy1fC6uiReVUC0Fy2nt0vdDmUiIqbhG1s1UdsCjUK7GqcsfkyOS3l+NrIfDQXCXz7vHdV6dYpBH5KdpJbrci+4IwtIdQh/3glMy/ks/BwjQEy1AkDseONAYuJnYuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049781; c=relaxed/simple;
	bh=MStiwnmTKTIxDYoiFZ0DxSnXZqv5tV3Q2Nw8sIyap1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYB8Wg8In6cEC7Z2xiFoLg7ugbeAAAciwOPh7OQzC4PElJVXhxGZ67myZr4cpEoA/k+YTXT6SW8InAkbqIEM/EvASy8nbQElI6h5CzROxHkwYMY3Z1lSUg5192c8ntTOrOjhGm57Y/R961c+ZlkzkhLJ7iEa79E7dDYGJGVck3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdw3uO9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749049778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0Z14f5Dv0sEBCQzCT+N5xWNS5ySL+Tzir6TJSSZ+3Q=;
	b=Mdw3uO9xi3vyz+UQ4sJ5DamGPadnDvdHQ/pk9FOe8Atf0Fkyt7uPxtuCYRDVUC7nkyJ158
	0MbkXxMgVtWIpdmvcrZCCF2VmPXWjgVjoBRUHTwG73wGBVWXurlFRixfiAngf2mhSJNDEL
	FKLD+Xo1XYgTqKV7UZekiRFo/8iVXsg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-uY_ZWIlnPry4vu-w6l7lLg-1; Wed, 04 Jun 2025 11:09:37 -0400
X-MC-Unique: uY_ZWIlnPry4vu-w6l7lLg-1
X-Mimecast-MFC-AGG-ID: uY_ZWIlnPry4vu-w6l7lLg_1749049777
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fabb9286f9so114476d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 08:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749049777; x=1749654577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Z14f5Dv0sEBCQzCT+N5xWNS5ySL+Tzir6TJSSZ+3Q=;
        b=fKR9zBMtPZKtxDq9d45dQCHQqgZl5k5Go3Zm8ZwzUYO/5HLrW83Q+OZzVCjKVtDmCs
         Jzsp6ej106Ha+CoTt+fkib9sbR3G6ZGCobW+aRmaW7G4ZRbtJhgZQ2C7JdVNWfJ/WQo9
         OxmeRVsmWQHuk0SFpa7m3oPV/y11aXz1vfBlmQ8l17uDEJttt6g9YCAakQmBe+OTT13n
         sKqLBA3Q6cISWRsZEjRMOvJJLQTV38v8aJ/Pe6UGgro+briW5SUfn+i8xTJJ27t2olNh
         P313QMIEY0UOTFBKD+jm0jb0Kh2Tk+TRQKDh9ax0y5NCJ7tleR/pyXnAShd59Xh4vOge
         85ew==
X-Forwarded-Encrypted: i=1; AJvYcCXfh3aEa2ULpd3V2tJzejZ00ae0jHD055U8vPoCtz9If8CGmz8MCHKWHRrifDsoFOz/79ONQMUYUtjM/zB4@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFLC4bVvdq4ykIU4PiPSiB9t7wPPW0v+ZLWuAJPLKJ8pii1C2
	Ip/JEeXljGQ+ZdeOczZETMIsXZuD5VDYt2l2MnFb8/3JxKy0YhwWzUjHV/lcx7tb5Hxt9noS5oc
	JTHTibX/aJY7fcgVL0HnIjh9htHhlQcWywtxCi5ZjgVYRGEG7e9VRVhDPkRjpES/Ex4k=
X-Gm-Gg: ASbGncsn7JJY/lmFC+dW3GxFxWmF3IIU+cdEDhfDIPd7xW7eHxgI71bOQj+ZPa1tWdi
	FNdvo1NnBJlSVUkFgX6ituKEUZiEosfj/A45Vk2wUzzMKNRKUk/m32tiy4SHOcKboWohpo/6qoB
	uXzHQvhn6oOC64uFaBghSbSTgB8yZa/Dx6zQYpIslnL0k5g6T7YbXcv88wUwwyY8Yk423TVZlga
	2t+e0v3pWv5n9JUl406AeUOMS45stqfhMZUgPtefnj5GKVeqmkAkCZrNdfY1CcyvSULa3SIP7m+
	gHhHUKKxmB0RJg==
X-Received: by 2002:a05:6214:5086:b0:6fa:ce1e:3a4a with SMTP id 6a1803df08f44-6faf6f9312emr40237056d6.6.1749049776210;
        Wed, 04 Jun 2025 08:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSDUs50177E/rrZpx+xC+0iIv+BIQc1aieeX4oFfx7XS0nPA0qJB8ecAAJUv8L53J89ePgrw==
X-Received: by 2002:a05:6214:5086:b0:6fa:ce1e:3a4a with SMTP id 6a1803df08f44-6faf6f9312emr40235876d6.6.1749049774940;
        Wed, 04 Jun 2025 08:09:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00d42sm99700586d6.85.2025.06.04.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:09:34 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:09:31 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Tal Zussman <tz2294@columbia.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pavel Emelyanov <xemul@parallels.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Message-ID: <aEBhqz1UgpP8d9hG@x1.local>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
 <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>

On Wed, Jun 04, 2025 at 03:23:38PM +0200, David Hildenbrand wrote:
> On 04.06.25 00:14, Tal Zussman wrote:
> > Currently, a VMA registered with a uffd can be unregistered through a
> > different uffd asssociated with the same mm_struct.
> > 
> > Change this behavior to be stricter by requiring VMAs to be unregistered
> > through the same uffd they were registered with.
> > 
> > While at it, correct the comment for the no userfaultfd case. This seems
> > to be a copy-paste artifact from the analagous userfaultfd_register()
> > check.
> 
> I consider it a BUG that should be fixed. Hoping Peter can share his
> opinion.

Agree it smells like unintentional, it's just that the man page indeed
didn't mention what would happen if the userfaultfd isn't the one got
registered but only requesting them to be "compatible".

DESCRIPTION
       Unregister a memory address range from userfaultfd.  The pages in
       the range must be “compatible” (see UFFDIO_REGISTER(2const)).

So it sounds still possible if we have existing userapp creating multiple
userfaultfds (for example, for scalability reasons on using multiple
queues) to manage its own mm address space, one uffd in charge of a portion
of VMAs, then it can randomly take one userfaultfd to do unregistrations.
Such might break.

> 
> > 
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >   fs/userfaultfd.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 22f4bf956ba1..9289e30b24c4 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >   		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> >   			goto out_unlock;
> > +		/*
> > +		 * Check that this vma isn't already owned by a different
> > +		 * userfaultfd. This provides for more strict behavior by
> > +		 * preventing a VMA registered with a userfaultfd from being
> > +		 * unregistered through a different userfaultfd.
> > +		 */
> > +		if (cur->vm_userfaultfd_ctx.ctx &&
> > +		    cur->vm_userfaultfd_ctx.ctx != ctx)
> > +			goto out_unlock;
> 
> So we allow !cur->vm_userfaultfd_ctx.ctx to allow unregistering when there
> was nothing registered.
> 
> A bit weird to set "found = true" in that case. Maybe it's fine, just
> raising it ...

This part should be ok, as found is defined as:

	/*
	 * Search for not compatible vmas.
	 */
	found = false;

So it's still compatible VMA even if not registered.

It's just that I'm not yet sure how this change benefits the kernel
(besides the API can look slightly cleaner).  There seems to still have a
low risk of breaking userapps.  It could be a matter of whether there can
be any real security concerns.

If not, maybe we don't need to risk such a change for almost nothing (I
almost never think "API cleaness" a goal when it's put together with
compatilibities).

Thanks,

-- 
Peter Xu


