Return-Path: <linux-fsdevel+bounces-20034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93F8CCAD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5344282574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 02:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ABF13AA2C;
	Thu, 23 May 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIRsWsCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7F28F5;
	Thu, 23 May 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432573; cv=none; b=ZcrXmj7tjq+Y101JnlZE8QlpHJzgZIWp0/n1BHEfvflMm3HrLlbVTf1e+b7UAsDKG3ID1uE2+eSP91m45BeqRT4WcLxkkLb66UfZ4txd4bp/YzBMyOByQEb0F9UCeyNs0LATRkT6al03jXr0/0abtcY76P+UD2ZLzIPjHiUwysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432573; c=relaxed/simple;
	bh=SL3rqfkHSw5QxRujDLLLkJv7+VRn3353omQIkm9bpaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iheFiQ9bkE8wyA6HFsjkbg21kQlTFH7HT41WmZ7Et+jbrqdSNIBNPTM1QyERQ2eSUlBHne9L5qtXkgWl1JYbJzBz7wnjXCeFuiEG/suaZV7Byqx+SQN2HMDOt2mh4TnffgI8xEZFwvvT4UIPL1SrMHuON4IaZBwEfuy6RsX4oIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIRsWsCK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b27369b0e3so3766497eaf.1;
        Wed, 22 May 2024 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716432570; x=1717037370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAW4PBEZpqdUqGs1sPsnAjNoBP69IHzEf0qSsxT3opw=;
        b=bIRsWsCKwdilyVwJk5wN5958AH56wEuXdyiEavRfR+f2QQ3ARm1/i1lWTf5QkQ2dtd
         EKBaxMNR/iN1b6itmBOoLy0MCNLuWWOeSo4X9Op17IryioKOJeu64MiLX5Eug02vit8x
         VPI71lajgPrcXoeN7XBtJUFqx9EdIjXVtKuJapOlm01sZl36nUQY+cgp6N3wSn4O6Ch4
         fSUiCNi8ZkV7wZrbGjBpOtbATmtXCBQTn/+V57LCl5p3Yb9d2doP6gMz1jURgF5sSKf2
         5+EVOJcSJlvYVKcxLhbaa+/KhgA9RZ/tgshSGukYfBK4OxmAZ6H4t53xx9HzAzrwDXVF
         gXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432570; x=1717037370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAW4PBEZpqdUqGs1sPsnAjNoBP69IHzEf0qSsxT3opw=;
        b=YXHbAr9vtYKHbcbT4FyQyQUvFR2XDvL7chV1zgXjzksFW5tVt05T/q0ac/33Yf5FCY
         d2At+GnEn6Q7Vhw8cQznBlzH3vFNd3F120KOQFM7c+GfuX5PvzyPlu+rqGXPZo7hYr1U
         +qc8m8lb2L2AYsV+2ysMVf2z+juzWD+2Q3k8aSqL5GmowI9Z/WNYh/tjAv8I09LU4HH+
         jOVKTS7T1XKMFxbbQ/j1nX7bSkNGdi8KHZOmFeq9sii/d6InsJYaidXxVgfLOmHFVwPn
         X6gbhfQIBK1p4zHxlholdGXd9Y9oD+LLYNHJzvAY4Rlr7f8AwE7bI+eqWDVJLazzm7SS
         w2kA==
X-Forwarded-Encrypted: i=1; AJvYcCVF5fgz8s25ATaiv3yfJHDSeImC/CIvbLLzYaFIzxLGqG49oLXQkrNNSbMzIXLp80mcYrgFvexF4eytFSJHrXYpv5WFSdBacNcwWYlDTvaTLVZqJBRz9WXAayV240GMRljAZH+nvfhHelUzMHdn/5sruwkOZJ3koK6HhPXe18SFi5hmKAzBgM8qPcP7sv6ZwkOVeCIlY8zEJzzQAQ9vWLgqEQ==
X-Gm-Message-State: AOJu0Yye19VCYqqR1CFdSISPCjusIUCy4J8zQbphcZKi4PWbGOhJlZ7x
	UHgqamFK8obx8Txk0XDvOGmmME+zsSTBoJyjrxYgjJwpaXAmb69K
X-Google-Smtp-Source: AGHT+IFZM4618nFwqVkK9hEvO7dFkY2TwgL+KO3fo91K9CM4WoqimHvtumIPolCf2ZrznSU8xU8dog==
X-Received: by 2002:a05:6820:618:b0:5b2:ff69:97c3 with SMTP id 006d021491bc7-5b6a0c0eb82mr3862417eaf.2.1716432570365;
        Wed, 22 May 2024 19:49:30 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5158a3bffsm2194203eaf.28.2024.05.22.19.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 19:49:29 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 22 May 2024 21:49:28 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <l2zbsuyxzwcozrozzk2ywem7beafmidzp545knnrnkxlqxd73u@itmqyy4ao43i>
References: <cover.1708709155.git.john@groves.net>
 <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>

On 24/05/22 10:58AM, Miklos Szeredi wrote:
> On Wed, 22 May 2024 at 04:05, John Groves <John@groves.net> wrote:
> > I'm happy to help with that if you care - ping me if so; getting a VM running
> > in EFI mode is not necessary if you reserve the dax memory via memmap=, or
> > via libvirt xml.
> 
> Could you please give an example?
> 
> I use a raw qemu command line with a -kernel option and a root fs
> image (not a disk image with a bootloader).

That's not the way I'm running VMs, but... I presume you know how to add
kernel command line arguments to VMs that you run this way?

- memmap=<size>!<hpa_offset> will reserve a pretend pmem device at <hpa_offset>
- memmap=<size>$<hpa_offset> will reserve a pretend dax device at <hpa_offset>

Both of the above will work regardless of whether the VM is in EFI mode.
The '$' is harder to escape through grub; and the pmem device can be converted
to devdax via 'ndctl reconfigure-device --mode=devdax...'. A dax device would
likely also need to be put in devdax mode (as the default seems to be 
system-ram mode).  

Incomplete documentation (that you have probably already seen) is at [1]

I can dig deeper if needed.

Otherwise the feedback in this thread makes sense to me and I'm planning to 
start hacking on famfs patches Thursday. Watch this space ;)

Regards,
John

[1] https://github.com/cxl-micron-reskit/famfs/blob/master/markdown/vm-configuration.md


