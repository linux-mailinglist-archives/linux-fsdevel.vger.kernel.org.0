Return-Path: <linux-fsdevel+bounces-19996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B361A8CBF6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 12:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EAD1C21CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A68248D;
	Wed, 22 May 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEmyzazu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8A824B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374717; cv=none; b=KR54NRekSegJPP6zEEKtnbPRpumTqbrvcOYz7zemmruc2AU5sghOnx1rioyqp7l4dD7ZTdwfo/Y70Y1l5qyB6+3XJf6NhiANVZhutKw61VlyAglgsw71QeSi+x8aPUQkihNlgJxolS30AGG6JQrXF3Q9vmMsM0zJQ4HqNpHbNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374717; c=relaxed/simple;
	bh=zaatjUYULPlbpZG5Ebw8WB5T/FrTZCoGN+CUaJ2P/HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du2YtxxGjNrgrUywcW4XXNYnJ9usw1SVvnqsIN1/a2jFVfy+bqWEq3I5aKMYmQZMhupw4VWoBxvP9e7rQNsQplAH7iakERBM6epVEzkv31duHodz53tTxMa6zA2Hsk4UCrrymj0k9xtJyAk+KXU2yUshijZYuByVmNhsq55nhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEmyzazu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716374714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yzEZYGvsKTatsJIFrK3zd8ka9ZwVipzy8I9kGsj3TE=;
	b=DEmyzazuwWiebnyWNqVCTBgKJcIPcfXyoesmX8qXwIX4Un3LSvyddqlR1B4HspE51SIlaf
	ogTTWH/G/1TzB43J0ceg4XJc6s9NrEtx2WGd30BoNuf31oCNY/2SWvqHG6rV9D+G+vajqf
	jDspo1nHdD1rGlb1qWCTa3WBF/843EE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-QD-41zmaOCSZ0yQKq4UT8A-1; Wed, 22 May 2024 06:45:12 -0400
X-MC-Unique: QD-41zmaOCSZ0yQKq4UT8A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34f10f6b3aeso9437257f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 03:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716374711; x=1716979511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yzEZYGvsKTatsJIFrK3zd8ka9ZwVipzy8I9kGsj3TE=;
        b=fMYJAhNKEYGlW0WTpUxiwt4vF2i9LSiCIHazukgrnafrZJEZ3iRNBhZbwSPB1fvZhq
         MgrKmlKd5+bTRVh9JZvBySDIc6PJ8Ed7JZnwci36snjQ+qrNitxavAydAGW+f0ra91ON
         UwNJkj5wjxBMi8ngCQLg9pUeWUzmWKjsjEG7+6Nn2+Y0UAqqu9ahbmkqY7CnyovvE356
         HsnJFHjJJ8dpyR1aRq3GpW+BqE/423dDA6g916q6UcrmHiMcg8Ci5lIxb3Mi5/z1b0gu
         Gi5+dVLLovZNszziWGaemx2mG8vBENa3ZJG84RFEM61P2YfJOMQmuxhgYS+mAwKqsY3s
         GV7Q==
X-Gm-Message-State: AOJu0YywaxYohr5mjWuHdCDCUmDiJkWNnvRNuLMT9fU1pJ8GgjJKKC6V
	pvze0AW54QsZNiLqwgaWNreRTbILAkgMvrOyYFxghx0Hfy51m18t3RK9orDgcWG3lvOpUKhLnp7
	6N8VA7aHuMlHF5oMMG/urIbbdYExF5+mIx+4XOeUmSOquYFwTcel9tqabwelYPg==
X-Received: by 2002:a05:6000:4011:b0:354:e0e8:e8c2 with SMTP id ffacd0b85a97d-354e0e8e9aemr946309f8f.37.1716374711306;
        Wed, 22 May 2024 03:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIwOVQjszn/3K/hNclw0G1v107/oafEVJoy9zBhvsLyiszCBVHmgMSKchT33DjJt9iL1nz4A==
X-Received: by 2002:a05:6000:4011:b0:354:e0e8:e8c2 with SMTP id ffacd0b85a97d-354e0e8e9aemr946283f8f.37.1716374710724;
        Wed, 22 May 2024 03:45:10 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354cece0054sm4224006f8f.102.2024.05.22.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:45:10 -0700 (PDT)
Date: Wed, 22 May 2024 12:45:09 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522100007.zqpa5fxsele5m7wo@quack3>

Hi,

On 2024-05-22 12:00:07, Jan Kara wrote:
> Hello!
> 
> On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > inode from VFS. Therefore, some inodes are left with empty project
> > ID. Those inodes then are not shown in the quota accounting but
> > still exist in the directory.
> > 
> > This patch adds two new ioctls which allows userspace, such as
> > xfs_quota, to set project ID on special files by using parent
> > directory to open FS inode. This will let xfs_quota set ID on all
> > inodes and also reset it when project is removed. Also, as
> > vfs_fileattr_set() is now will called on special files too, let's
> > forbid any other attributes except projid and nextents (symlink can
> > have one).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> I'd like to understand one thing. Is it practically useful to set project
> IDs for special inodes? There is no significant disk space usage associated
> with them so wrt quotas we are speaking only about the inode itself. So is
> the concern that user could escape inode project quota accounting and
> perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> for something that seems as a small corner case to me?

So there's few things:
- Quota accounting is missing only some special files. Special files
  created after quota project is setup inherit ID from the project
  directory.
- For special files created after the project is setup there's no
  way to make them project-less. Therefore, creating a new project
  over those will fail due to project ID miss match.
- It wasn't possible to hardlink/rename project-less special files
  inside a project due to ID miss match. The linking is fixed, and
  renaming is worked around in first patch.

The initial report I got was about second and last point, an
application was failing to create a new project after "restart" and
wasn't able to link special files created beforehand.

-- 
- Andrey


