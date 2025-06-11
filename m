Return-Path: <linux-fsdevel+bounces-51320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C6AD5621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF66F174EA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73452836B5;
	Wed, 11 Jun 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvcvQhpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29B278165
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646611; cv=none; b=pgOgmxA6B1ZTm+ZS0Y2zP0GPT6KPnf9Js9jNhELTBfagrAJ46LFjx36+Lzfzsc7/0ND8h9Jc9MYNyKFIvM04E4py5h7n77nj+Y1BI3W+tTtk64xR84MgGQm2oCpdp2LSubE8WXQe0+qpvqNefZ6JVtyrD8zZbYukgBiikDRiFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646611; c=relaxed/simple;
	bh=8buD8yDg3TR0fx8Q7bXACvJc4a/CvqRbB7CH+Pikfmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgLSZZ09Wj5Yv4FgtjH1IIN/v/r49Q+Ju5iU1dQTPiN+aROGXO6QmFQahinvjnLxd4Ls6q8PPqSdH+vTVsNCtU2iSzLGQRZ12Oo6YJHCj0oZ+s/A7g4rbAL60Ihbxet86h277IBsZAzj8TbGqtHgG8E5MuOyfrAJcyIEHAuGZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvcvQhpl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749646607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5Kas9xwQ+OPm3yoVaGIsnzULAQTcfMhc6nbP8S9fvE=;
	b=QvcvQhplfihYlpgq4DVTicbMK50f+BQ2JmqC0nyS5vYk9jeMUf7l+0xXeijP7khPt6adrL
	bPknNRf2j63k92IiTG5FBFy9JGcU6INKbq+2Em52kupa6sbIU0JEPiq4FdwM//2A7NmfVh
	XxeGUHzCp8XMZ3WGdpt1VnqIWk3CY3o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-SSl_n0ExPOajnA6KjUJI1A-1; Wed, 11 Jun 2025 08:56:46 -0400
X-MC-Unique: SSl_n0ExPOajnA6KjUJI1A-1
X-Mimecast-MFC-AGG-ID: SSl_n0ExPOajnA6KjUJI1A_1749646606
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso171510036d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 05:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646606; x=1750251406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Kas9xwQ+OPm3yoVaGIsnzULAQTcfMhc6nbP8S9fvE=;
        b=qNe419Xw41olj3uSROcljiWswE2UJHhAjt7D8Jhh7ubMp6nq6QnwpUnMd1E/Ap9inL
         kZM9h8nTkbW0jTYNimzWEP3dk/7uSNehYuVv3iR97idjHHqSb1uBD5bjkujaviUpmtqi
         rm3Pw5qgOioI17438duisZ39WK5MdCcHo09O140XU/VGb5cFdLN/tg54xjwXt7IgOAfd
         OmDA6wCw/L/YE5l4Lw/yBRctdmLaSjjsvbNjnLMh3KWHVw9H75rKCc43Ypzeab5F7pir
         DaBHkauvtGmU2Ppyz/aJthDpylpb2boDrPMa3OWS4sypEuw0yCTjn0MgD7aBVWkWrjqX
         7osQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfSTQ4e8niORBefDQeyIamThlLbJ6FGtXpdpYpUg/waCQvc0LLzR9sm3DY4dIdJbHqBA5O01YKhqM7Qx6V@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbeiKnxA01KseWnP/Chjft146MvrFXgEBnFWOmMzNLMddayrJ
	vRFxOZAd4mQ9XkT7kyNpXCo/CYQCiE/OvXVjYIcHArfT64d4zYIhg7SA7QZ8HpwbEu+/fzER8Ko
	f9c+oibZiladVu9aIJ7/4tFXi0x6PatdmUDEtxquynROylS03R7sjDSa1LdEjUlCGYWM=
X-Gm-Gg: ASbGncv6v4YK2LXepRsbCtpWsQvdIHCVrzhnvFn+JnSzSizniDdL6uFeU68pSoW09UK
	MEVU1UeNWRUCD6Ws39mIaXtM7F7sI20H/tNYY0ztuFjcekqGOHKK7vZIkypgrItMHQy8/aSHpRX
	tJ4nlyVDC1LlpapaqX6fIGhNz55bQbk5SyMPHj20IfGObS2IzgXAXDj0a7/sDjSrY+i4zhTDaB9
	xeextYaiOZ72yw0pKxcvVvwA92ng9EgVTyajhBDdch3fw9XH2B95Q/265xQccFMAOs/w6VupWv4
	B/Rz054YlMQE6g==
X-Received: by 2002:ad4:5de3:0:b0:6ea:d033:2846 with SMTP id 6a1803df08f44-6fb2d150f50mr46124846d6.25.1749646605490;
        Wed, 11 Jun 2025 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ3II3J1nqirG0Y1l89AqC5v1uU5YGX748p4ie8CqW4+N2aTm8LOyMY61BMCGc48dang2fKg==
X-Received: by 2002:ad4:5de3:0:b0:6ea:d033:2846 with SMTP id 6a1803df08f44-6fb2d150f50mr46124046d6.25.1749646604859;
        Wed, 11 Jun 2025 05:56:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab8a0esm82314846d6.25.2025.06.11.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:56:44 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:56:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
Message-ID: <aEl9CNGLY0Sil7nq@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com>
 <aEiwHjl4tsUt98sh@x1.local>
 <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>

On Wed, Jun 11, 2025 at 01:09:32PM +0100, Nikita Kalyazin wrote:
> 
> 
> On 10/06/2025 23:22, Peter Xu wrote:
> > On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
> > > Remove shmem-specific code from UFFDIO_CONTINUE implementation for
> > > non-huge pages by calling vm_ops->fault().  A new VMF flag,
> > > FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
> > > handle_userfault().
> > 
> > It's not clear yet on why this is needed to be generalized out of the blue.
> > 
> > Some mentioning of guest_memfd use case might help for other reviewers, or
> > some mention of the need to introduce userfaultfd support in kernel
> > modules.
> 
> Hi Peter,
> 
> Sounds fair, thank you.
> 
> > > 
> > > Suggested-by: James Houghton <jthoughton@google.com>
> > > Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> > > ---
> > >   include/linux/mm_types.h |  4 ++++
> > >   mm/hugetlb.c             |  2 +-
> > >   mm/shmem.c               |  9 ++++++---
> > >   mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
> > >   4 files changed, 38 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 0234f14f2aa6..2f26ee9742bf 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
> > >    * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
> > >    *                        We should only access orig_pte if this flag set.
> > >    * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
> > > + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
> > > + *                                 minor handler as it is being called by the
> > > + *                                 userfaultfd code itself.
> > 
> > We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
> > as it's not easy to follow when without userfault minor context.  It might
> > be better to use generic terms like NO_USERFAULT.
> 
> Yes, I agree, can name it more generically.
> 
> > Said that, I wonder if we'll need to add a vm_ops anyway in the latter
> > patch, whether we can also avoid reusing fault() but instead resolve the
> > page faults using the vm_ops hook too.  That might be helpful because then
> > we can avoid this new FAULT_FLAG_* that is totally not useful to
> > non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
> > struct below just to suite the current fault() interfacing.
> 
> I'm not sure I fully understand that.  Calling fault() op helps us reuse the
> FS specifics when resolving the fault.  I get that the new op can imply the
> userfault flag so the flag doesn't need to be exposed to mm, but doing so
> will bring duplication of the logic within FSes between this new op and the
> fault(), unless we attempt to factor common parts out.  For example, for
> shmem_get_folio_gfp(), we would still need to find a way to suppress the
> call to handle_userfault() when shmem_get_folio_gfp() is called from the new
> op.  Is that what you're proposing?

Yes it is what I was proposing.  shmem_get_folio_gfp() always has that
handling when vmf==NULL, then vma==NULL and userfault will be skipped.

So what I was thinking is one vm_ops.userfaultfd_request(req), where req
can be:

  (1) UFFD_REQ_GET_SUPPORTED: this should, for existing RAM-FSes return
      both MISSING/WP/MINOR.  Here WP should mean sync-wp tracking, async
      was so far by default almost supported everywhere except
      VM_DROPPABLE. For guest-memfd in the future, we can return MINOR only
      as of now (even if I think it shouldn't be hard to support the rest
      two..).

  (2) UFFD_REQ_FAULT_RESOLVE: this should play the fault() role but well
      defined to suite userfault's need on fault resolutions.  It likely
      doesn't need vmf as the parameter, but likely (when anon isn't taking
      into account, after all anon have vm_ops==NULL..) the inode and
      offsets, perhaps some flag would be needed to identify MISSING or
      MINOR faults, for example.

Maybe some more.

I was even thinking whether we could merge hugetlb into the picture too on
generalize its fault resolutions.  Hugetlb was always special, maye this is
a chance too to make it generalized, but it doesn't need to happen in one
shot even if it could work.  We could start with shmem.

So this does sound like slightly involved, and I'm not yet 100% sure this
will work, but likely.  If you want, I can take a stab at this this week or
next just to see whether it'll work in general.  I also don't expect this
to depend on guest-memfd at all - it can be alone a refactoring making
userfault module-ready.

Thanks,

-- 
Peter Xu


