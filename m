Return-Path: <linux-fsdevel+bounces-20044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A98CD118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808F128272F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B41146A7E;
	Thu, 23 May 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B40TCa2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC514659F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463016; cv=none; b=SA9+P7/1VlylG6ZF5kikGr98M6jGQ/EAIzRJsGnPDxa3e958gGQV4DuhGEgw9pS9zqwgNVMjQs896IHnBGDEkTmf2wVTkVGv3GvH0gx83JshkAKM7lV4UoFJmDgoRQNKT9iK7MikGCPEAHaDUcauAQ5DbJj8B/daAP/KsH5tSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463016; c=relaxed/simple;
	bh=otl74JqmPbnUPThJ/RuOgkQJPMPVdyGphnqV0U7urJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVn8qR26CUX4pRrMLPk0l9urtqXklQBk+LCeoL7CbkhuU4j6bmx2cu0haHXjlbGKZhhqj3F85e3+RJ7Vr02cES6e+PRumDjsQdw3CTp0jyNed+kXLGJxW3/nQFok5tGSgwsyjJ34AZWGM27Z2t3eh5yq1tjs2aeulCXJCXKtPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B40TCa2U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716463013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ioDzKl72WQKimsqiST+JQLPZsr4nX54Z/eEORuxFQXc=;
	b=B40TCa2ULuPbbMQxsxXGB5eU54GGVeJTDftbst1FLadraX60kaLkGAIEOx5vss0ClJzdGp
	SnBpdR5hGjU4ZCblswRK+YZl0lGjotimsJzeLObTUKFy73TfVRjU10g3ji3jqhnKCq5KqB
	IKcUvQfr6xE/jKRoA/AL9No1pC8IvBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-gnoaNDT4OQuTl2e0YrjThQ-1; Thu, 23 May 2024 07:16:52 -0400
X-MC-Unique: gnoaNDT4OQuTl2e0YrjThQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4200ebdbf55so74167445e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 04:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716463011; x=1717067811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioDzKl72WQKimsqiST+JQLPZsr4nX54Z/eEORuxFQXc=;
        b=TNWaK6I81eLxsH0f+4uLgym+tuxJTWMt9/4TZwpXvERXv4jXjpaohZ8+OZ7sGSBhco
         pELr9uTCDBtJLwdb1ivIe7Y4nMzYrvCO8iuHCtINreRwdRCzlfyde+tObtCioDJRM8mo
         TTKsrCVj8L1XY1mLuSFg4neVgZcIY8yKMGsN2BUrLY4upzM+t1uyjOoG2ZzOquPmQHv5
         5mjCgDv6DgReZ+f0+YQIvr1WyoZOSxfAwUMCUyLTy2OkPrt5YQkIQtPQ5FR4CObnjM0T
         6HJ3qPW/Epj6r4ztEbW9K2GPEckIc2CNqOCzRINTQMYDy70za8+5/3utRcDynQXVkktP
         VS5A==
X-Gm-Message-State: AOJu0Yw5cfFQbvqgEqnBzxxAH7oTMi6c9jiod/W0X5OZQdyqiMp7Xuba
	tbsoEHpnrRvKzoH4aQg4YGdHDWkFFHStBOzio71vUhqqf5wi2GKkzCwDO558kZ00eGgPvDWyphY
	VuT1FBt1gCMHk5WQR4YB3FS/qSjjw8NCCtWLP0sRooJybzUB+W+fWkypT1H0KEM2qFtB2lA==
X-Received: by 2002:a05:600c:5112:b0:41f:ef1e:7312 with SMTP id 5b1f17b1804b1-420fd301fa0mr35258635e9.14.1716463010393;
        Thu, 23 May 2024 04:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdWKIYx0plxWJVGAVNGLFah0xBFwVr9mMCjBYCLUy3ChRsMrhODZiJC2ZZKrEt1n723gYByg==
X-Received: by 2002:a05:600c:5112:b0:41f:ef1e:7312 with SMTP id 5b1f17b1804b1-420fd301fa0mr35258435e9.14.1716463009808;
        Thu, 23 May 2024 04:16:49 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f138ebsm22615985e9.12.2024.05.23.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:16:49 -0700 (PDT)
Date: Thu, 23 May 2024 13:16:48 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523074828.7ut55rhhbawsqrn4@quack3>

On 2024-05-23 09:48:28, Jan Kara wrote:
> Hi!
> 
> On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > Hello!
> > > 
> > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > XFS has project quotas which could be attached to a directory. All
> > > > new inodes in these directories inherit project ID set on parent
> > > > directory.
> > > > 
> > > > The project is created from userspace by opening and calling
> > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > ID. Those inodes then are not shown in the quota accounting but
> > > > still exist in the directory.
> > > > 
> > > > This patch adds two new ioctls which allows userspace, such as
> > > > xfs_quota, to set project ID on special files by using parent
> > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > inodes and also reset it when project is removed. Also, as
> > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > forbid any other attributes except projid and nextents (symlink can
> > > > have one).
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > I'd like to understand one thing. Is it practically useful to set project
> > > IDs for special inodes? There is no significant disk space usage associated
> > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > the concern that user could escape inode project quota accounting and
> > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > for something that seems as a small corner case to me?
> > 
> > So there's few things:
> > - Quota accounting is missing only some special files. Special files
> >   created after quota project is setup inherit ID from the project
> >   directory.
> > - For special files created after the project is setup there's no
> >   way to make them project-less. Therefore, creating a new project
> >   over those will fail due to project ID miss match.
> > - It wasn't possible to hardlink/rename project-less special files
> >   inside a project due to ID miss match. The linking is fixed, and
> >   renaming is worked around in first patch.
> > 
> > The initial report I got was about second and last point, an
> > application was failing to create a new project after "restart" and
> > wasn't able to link special files created beforehand.
> 
> I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> inherit project id for special inodes? And make sure inodes with unset
> project ID don't fail to be linked, renamed, etc...

But then, in set up project, you can cross-link between projects and
escape quota this way. During linking/renaming if source inode has
ID but target one doesn't, we won't be able to tell that this link
is within the project.

-- 
- Andrey


