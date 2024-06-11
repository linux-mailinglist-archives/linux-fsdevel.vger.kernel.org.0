Return-Path: <linux-fsdevel+bounces-21481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F02904774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C80286D36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B4156221;
	Tue, 11 Jun 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAVW2kfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B7155CA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147086; cv=none; b=kHbRWHks1yxgVOr+cYL7Iy5qMNfeY0LuqRrpXtEHtPusBqrf921KXRA+8TRgXvRg9paorYFUyfcDm0fujSVb/hslZ/z5w7Qj1awPJYOUbkK2ivuBN67c8samQKUj6eYFcs0sOeKnxKwXadk86wd18XSVp196qGB3B3GGTyK/TiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147086; c=relaxed/simple;
	bh=WgQTsjhgFTPo5g3swBUHYLB5cTMjLhRB5VKwujox9LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3bLSfMm1Nvr91VeRNrZnmOi3kuhnnoagVZF45bZjYcuOdd7RVBG4r7NvBrHYlBGNIR8dr/Lw4jmMNm9/ENgDdFkwYZslaiMOtwpO+C/PFFv9iVIbDhwf0AxnEaYi1NzQvLKG27Wijgi5Mk11IZ7GGGRk6PYTokmTMmd9oMv2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAVW2kfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718147084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDzDu+45eFDjY4XI9ncsaJcxp9S5zkG6Iy9Nqh5PCDc=;
	b=GAVW2kfHMQsg3rMbb60UunKT73iY7+vcFgBCe/MwBkfwMG0YJUdb28F2bI0TYR2R65O7Jr
	jOkazwqmoUrJMzzLLJAw+xxLhs1utITzPl8SDsBHhfEn3c3hCTOJ57Xp4peIpm7LzV0GB4
	XR440gA41WZRTt003w4ABA/MBvY6pdA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-aQxh0pNsMeSd4hii6xfreA-1; Tue, 11 Jun 2024 19:04:42 -0400
X-MC-Unique: aQxh0pNsMeSd4hii6xfreA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-255112df14aso121078fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 16:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147082; x=1718751882;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDzDu+45eFDjY4XI9ncsaJcxp9S5zkG6Iy9Nqh5PCDc=;
        b=oa29JYiLUnMbmG/cG0HCiVpj90B4tgcdu/RgL+RgC88Io0uXPC4F90X1xn8v352FUr
         p1SJhB3xqF3Cq9STi4NY0tugwvJz/pkKeq9z5E4uiLZsWNB7HlmmPI6vjbZ/3+9pX1Xu
         IBKl+kIYezQ3ICiHnzAxtK0Kf0SIJJVmVu7iitXqsaisEjA5SXNAWLfC/NbxW8XoJEM3
         4NAaNFa5S1IQrmSK+P+DLjnQXQ5A0pil+SFdotC1CauofexmhqvXnZN/tObsi2Vq08zi
         Mkl9wspMBizrh7Ysfk8mHPqIZ34qH2DlNF4JUXKGbsCwE5Dark8Fhwegg7FYLH1sBJ57
         lZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfmI/+a2IXp2wAX5QxGyNfPcY641hyG0L5sGGIMKk18khxkre1bE9XT+GTgBw/jULqEG7gfcWo+bSRotXocUEvuw2NOwsso5vWNEY4oQ==
X-Gm-Message-State: AOJu0Yx7F7tOYsyPHVGf3sM7LhhogVFHqHmfWQ3xLNsg64ua9MeaQEOm
	TCku3N/k8N4DagAiHuZ+O1DsZ1UVDVbFqYRE7yWugtIh00q++b4y4YM1eMpK0DkPoWc+u4rYF/o
	xT+hB7SSgbzfr319aMb8wxtRDjTboMjgaXrGDZhdfg3pH724515mElwJK/86tWmZSVBN2tQA=
X-Received: by 2002:a05:6871:588d:b0:254:d4e3:bdd6 with SMTP id 586e51a60fabf-25514feac95mr198510fac.56.1718147081675;
        Tue, 11 Jun 2024 16:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+DcQwiV3pGkiKFHbIDKxUzbnnLgfKf0YMRMgmxgySBftfspyxgrkYZBI8AWfucEMkV5fD4w==
X-Received: by 2002:a05:6871:588d:b0:254:d4e3:bdd6 with SMTP id 586e51a60fabf-25514feac95mr198477fac.56.1718147081153;
        Tue, 11 Jun 2024 16:04:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25447ecc81dsm3053041fac.32.2024.06.11.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 16:04:40 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:04:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Fei Li <fei1.li@intel.com>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240611170438.508a2612.alex.williamson@redhat.com>
In-Reply-To: <20240610205305.GE1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
	<20240607015957.2372428-1-viro@zeniv.linux.org.uk>
	<20240607015957.2372428-11-viro@zeniv.linux.org.uk>
	<20240607-gelacht-enkel-06a7c9b31d4e@brauner>
	<20240607161043.GZ1629371@ZenIV>
	<20240607210814.GC1629371@ZenIV>
	<20240610051206.GD1629371@ZenIV>
	<20240610140906.2876b6f6.alex.williamson@redhat.com>
	<20240610205305.GE1629371@ZenIV>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 21:53:05 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Mon, Jun 10, 2024 at 02:09:06PM -0600, Alex Williamson wrote:
> > > 
> > > We could move vfs_poll() under vm->irqfds_lock, but that smells
> > > like asking for deadlocks ;-/
> > > 
> > > vfio_virqfd_enable() has the same problem, except that there we
> > > definitely can't move vfs_poll() under the lock - it's a spinlock.  
> > 
> > vfio_virqfd_enable() and vfio_virqfd_disable() are serialized by their
> > callers, I don't see that they have a UAF problem.  Thanks,
> > 
> > Alex  
> 
> Umm...  I agree that there's no UAF on vfio side; acrn and xen/privcmd
> counterparts, OTOH, look like they do have that...
> 
> OK, so the memory safety in there depends upon
> 	* external exclusion wrt vfio_virqfd_disable() on caller-specific
> locks (vfio_pci_core_device::ioeventfds_lock for vfio_pci_rdwr.c,
> vfio_pci_core_device::igate for the rest?  What about the path via
> vfio_pci_core_disable()?)

This is only called when the device is closed, therefore there's no
userspace access to generate a race.

> 	* no EPOLLHUP on eventfd while the file is pinned.  That's what
>         /*
>          * Do not drop the file until the irqfd is fully initialized,
>          * otherwise we might race against the EPOLLHUP.
>          */
> in there (that "irqfd" is a typo for "kirqfd", right?) refers to.

Sorry, I'm not fully grasping your comment.  "irqfd" is not a typo
here, "kirqfd" seems to be a Xen thing.  I believe the comment is
referring to holding a reference to the fd until everything is in place
to cleanup correctly if the user process is killed mid-setup.  Thanks,

Alex


