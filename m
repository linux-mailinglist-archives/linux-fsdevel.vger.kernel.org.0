Return-Path: <linux-fsdevel+bounces-16963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEF8A5976
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 19:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047A11C21356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A713AA22;
	Mon, 15 Apr 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qraoAuVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96651369B8;
	Mon, 15 Apr 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203837; cv=none; b=DMM2AqC2MipIwKecgqYqZqRoiCgxG9jiVsXzKaYcySC6CrozDmnsM6Z0BhURYPEW3W9WwRBz92+Z9zGEiw6chOQW3XCuMKkcKx4HE6Vm8AcvdX59fZuJ97evFiY/HEwRMgRfAIXNxwVIpnjxQW/eq7hvjODv2yecYrJoXobTAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203837; c=relaxed/simple;
	bh=HZXXTICwCNfNnAAPksAihITX/uhY4HG81OJG+2aD0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2zN7MvKSGEjOaU3ydJOGNCAZHa5Nh4jxc2gJ5LWGGzqa8ZkCD1hsNY7OtmEh1z9NfXzgRl3WMjPQgMrweb+gMo8lZcVeoSyHtwYwP5notr/msd9nqM4lRoIdvZ/Hxu7wHOZxc/6z2uz76MpDnQsoGQ1cWdd/K7VCJcdRDxGRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qraoAuVl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7WoF/OVhja5rh0oZfHmbZHpLS9885IhKeZTon+/iGxA=; b=qraoAuVl2vW4OX78
	0mqZnQJQzqSfaofrXipcO+bzUmf69MX21EjsLpb51ayPP4EkFCxSqG5+7ZSlKXrtuUN7GTMgPVpgK
	hLL6jmykX+jjjZZRq/8++IEyjyCZS2O2oDo+1/tP4TuuE2m/YuDmBumng0J9Q2Ed0/rKUsM9gqlNi
	FauM6xkVIFCUYF/BEn9hNqQxGwd1g9Al9TFKti28M45fYuVUUuOtoEw6mkBvpMeWzEDiwIBBQdML/
	05rpf7EMZqogpYlYkNNOHvbqnjggIIZi7c3Pi9cmnHMqFXpolHVqMn8H8LvBwNWcFcc/88CO6ySHB
	eJ+bzeEJsoYoSc5YiQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rwQJO-001G0D-1x;
	Mon, 15 Apr 2024 17:40:10 +0000
Date: Mon, 15 Apr 2024 17:40:10 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <Zh1menJ5GYy2ayFx@gallifrey>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
 <ZhxDj3vQFLy62Yow@bombadil.infradead.org>
 <e770923a-6719-403c-a9f2-1f7ac4313474@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e770923a-6719-403c-a9f2-1f7ac4313474@p183>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 17:39:50 up 103 days, 20:29,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Alexey Dobriyan (adobriyan@gmail.com) wrote:
> On Sun, Apr 14, 2024 at 01:58:55PM -0700, Luis Chamberlain wrote:
> > On Sun, Apr 14, 2024 at 10:05:05PM +0300, Alexey Dobriyan wrote:
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3616,4 +3616,12 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
> > >  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
> > >  			   int advice);
> > >  
> > > +/*
> > > + * Use this if data from userspace end up as directory/filename on
> > > + * some virtual filesystem.
> > > + */
> > > +static inline bool string_is_vfs_ready(const char *s)
> > > +{
> > > +	return strcmp(s, ".") != 0 && strcmp(s, "..") != 0 && !strchr(s, '/');
> > > +}
> > >  #endif /* _LINUX_FS_H */
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2893,6 +2893,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
> > >  
> > >  	audit_log_kern_module(mod->name);
> > >  
> > > +	if (!string_is_vfs_ready(mod->name)) {
> > > +		err = -EINVAL;
> > > +		goto free_module;
> > > +	}
> > > +
> > 
> > Sensible change however to put string_is_vfs_ready() in include/linux/fs.h 
> > is a stretch if there really are no other users.
> 
> This is forward thinking patch :-)
> 
> Other subsystems may create files/directories in proc/sysfs, and should
> check for bad names as well:
> 
> 	/proc/2821/net/dev_snmp6/eth0
> 
> This looks exactly like something coming from userspace and making it
> into /proc, so the filter function doesn't belong to kernel/module/internal.h

You mean like:

[24180.292204] tuxthe____: renamed from tuxthe🐧
root@dalek:/home/dg# ls /sys/class/net/
enp5s0  lo  tuxthe____  tuxthe🐧  tuxthe🖊  virbr0  virbr1

?

Dave
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

