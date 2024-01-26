Return-Path: <linux-fsdevel+bounces-9081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC683DF42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE411C21F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D791EA7F;
	Fri, 26 Jan 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ILll+VHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEA1E889
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287945; cv=none; b=Pq4f/5+yPi1c8I37CgT8Km4wUWNfEodyeVpkYS0J6rwEyi8NlGC/D6rJQFLo410e2i5YPlFleCENXPhYq0/WNFVwoUPCxZy3hmrY/O67i+DWvYMYG88Zzu9eEPThOu8G/Rkdm0saUQcqdwrseXVDI4GpGDj/6C0sssI7bOSDCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287945; c=relaxed/simple;
	bh=Dnv9cSVt3mJm2zXgTEcexEXzzt81rjMJ6iELIuEksY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2zWGb402dMxQYyXgbi9FIoPhcH6xeRsWui8K3Q5JOl2HpHiuPyZ1XicmnAx6PYxGv3FkvelUSA8H6jJoXVSzHtb8e/vVoaze1aJSonNFRnG1aKqOFuYnJZdPh18KU007BTHxHytIhL+DleAMtOWT4kFPcDWJ70UdXA7gXNY15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ILll+VHl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74678df08so3998885ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706287942; x=1706892742; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkzp/MtILUxvbC4PPb3TNi915LSTtGzwh5axhWkAsDw=;
        b=ILll+VHl3e8nHt32s8rcphibTE8zcCxNrcaWCDeW/t1IwajhFIp9teHBG9iwFVgV4+
         zqVhmpkybIHRQ0Lk6RIX9WC/TfVQ7nvFyTzeVMq9tmBvHo6N+YXvJ5+AwPBa4S8MR+LH
         fWgi5qbLVwstWMAz9PSpTQLoReQcvDccgkPnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706287942; x=1706892742;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkzp/MtILUxvbC4PPb3TNi915LSTtGzwh5axhWkAsDw=;
        b=uzdHV1Vx2fvtdK/KWlDTZPD0FYDKV/jxHxq3wr1nm+xs5pFFwUb93IWy9k/stZKXin
         0yNkiGXfB26WT9pIS49jol5WeXQHHRb7qkuoafoAUXbzemHkFEm8iCxOyI1leHGvvSIE
         vEY6+plGhVV217IQWy0WWHpoH43gv9u/mDpVTMEGup3C2iBmox/4sQs9Iir+kpRgb166
         gkXc0+3Blt5qb5ihfbcvxfwQ7eyll98fyP38wBF/1XfIwkRvqzr2nLQEByB/4sNyVj8m
         PWbz1Yu+v2UCzwNZGX04GJtCmBRVlSHJ0dORfB6RAbig1nT4uH3vUODMvYXyVSsdgl5u
         93CA==
X-Gm-Message-State: AOJu0YxsTRbj2c1Rrk7XCH80z5wzHDGZCJFYgz7pPe+0MW06WBcr8qOf
	W26DqWi8iZO2ITA+vQVVCDdRo2jl1gcJROhqc5dZa/bk69SShIJuOoWd/FFY9Es=
X-Google-Smtp-Source: AGHT+IHgj/pRnInI6b+fMAlPmGcScOkEnr7055JlkDCNg5VW+RV4Jaw8m+wCe/hCGF7ydceuuPjpSg==
X-Received: by 2002:a17:902:6b01:b0:1d8:8b23:c6db with SMTP id o1-20020a1709026b0100b001d88b23c6dbmr32679plk.5.1706287942618;
        Fri, 26 Jan 2024 08:52:22 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001d7222d8caasm1151944plo.50.2024.01.26.08.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 08:52:22 -0800 (PST)
Date: Fri, 26 Jan 2024 08:52:18 -0800
From: Joe Damato <jdamato@fastly.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126165217.GA1463@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh>
 <20240126001128.GC1987@fastly.com>
 <2024012525-outdoors-district-2660@gregkh>
 <20240126023630.GA1235@fastly.com>
 <20240126-kribbeln-sonnabend-35dcb3d1fc48@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-kribbeln-sonnabend-35dcb3d1fc48@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Fri, Jan 26, 2024 at 11:07:36AM +0100, Christian Brauner wrote:
> On Thu, Jan 25, 2024 at 06:36:30PM -0800, Joe Damato wrote:
> > On Thu, Jan 25, 2024 at 04:23:58PM -0800, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
> > > > On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > > > > > +struct epoll_params {
> > > > > > +	u64 busy_poll_usecs;
> > > > > > +	u16 busy_poll_budget;
> > > > > > +
> > > > > > +	/* for future fields */
> > > > > > +	u8 data[118];
> > > > > > +} EPOLL_PACKED;
> > > > > 
> > > > > variables that cross the user/kernel boundry need to be __u64, __u16,
> > > > > and __u8 here.
> > > > 
> > > > I'll make that change for the next version, thank you.
> > > > 
> > > > > And why 118?
> > > > 
> > > > I chose this arbitrarily. I figured that a 128 byte struct would support 16
> > > > u64s in the event that other fields needed to be added in the future. 118
> > > > is what was left after the existing fields. There's almost certainly a
> > > > better way to do this - or perhaps it is unnecessary as per your other
> > > > message.
> > > > 
> > > > I am not sure if leaving extra space in the struct is a recommended
> > > > practice for ioctls or not - I thought I noticed some code that did and
> > > > some that didn't in the kernel so I err'd on the side of leaving the space
> > > > and probably did it in the worst way possible.
> > > 
> > > It's not really a good idea unless you know exactly what you are going
> > > to do with it.  Why not just have a new ioctl if you need new
> > > information in the future?  That's simpler, right?
> > 
> > Sure, that makes sense to me. I'll remove it in the v4 alongside the other
> > changes you've requested.
> 
> Fwiw, we do support extensible ioctls since they encode the size. Take a
> look at kernel/seccomp.c. It's a clean extensible interface built on top
> of the copy_struct_from_user() pattern we added for system calls
> (openat(), clone3() etc.):
> 
> static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
>                                  unsigned long arg)
> {
>         struct seccomp_filter *filter = file->private_data;
>         void __user *buf = (void __user *)arg;
> 
>         /* Fixed-size ioctls */
>         switch (cmd) {
>         case SECCOMP_IOCTL_NOTIF_RECV:
>                 return seccomp_notify_recv(filter, buf);
>         case SECCOMP_IOCTL_NOTIF_SEND:
>                 return seccomp_notify_send(filter, buf);
>         case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
>         case SECCOMP_IOCTL_NOTIF_ID_VALID:
>                 return seccomp_notify_id_valid(filter, buf);
>         case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
>                 return seccomp_notify_set_flags(filter, arg);
>         }
> 
>         /* Extensible Argument ioctls */
> #define EA_IOCTL(cmd)   ((cmd) & ~(IOC_INOUT | IOCSIZE_MASK))
>         switch (EA_IOCTL(cmd)) {
>         case EA_IOCTL(SECCOMP_IOCTL_NOTIF_ADDFD):
>                 return seccomp_notify_addfd(filter, buf, _IOC_SIZE(cmd));
>         default:
>                 return -EINVAL;
>         }
> }
> 
> static long seccomp_notify_addfd(struct seccomp_filter *filter,
>                                  struct seccomp_notif_addfd __user *uaddfd,
>                                  unsigned int size)
> {
>         struct seccomp_notif_addfd addfd;
>         struct seccomp_knotif *knotif;
>         struct seccomp_kaddfd kaddfd;
>         int ret;
> 
>         BUILD_BUG_ON(sizeof(addfd) < SECCOMP_NOTIFY_ADDFD_SIZE_VER0);
>         BUILD_BUG_ON(sizeof(addfd) != SECCOMP_NOTIFY_ADDFD_SIZE_LATEST);
> 
>         if (size < SECCOMP_NOTIFY_ADDFD_SIZE_VER0 || size >= PAGE_SIZE)
>                 return -EINVAL;
> 
>         ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
>         if (ret)
>                 return ret;

Thanks; that's a really helpful note and example.

I'm inclined to believe that new fields probably won't be needed for a
while, but if they are: an extensible ioctl could be added in the future
to deal with that problem at that point.

Thanks,
Joe

