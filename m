Return-Path: <linux-fsdevel+bounces-58034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE86B2829A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A84AE4322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2A22616C;
	Fri, 15 Aug 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HElOWDL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935720297B;
	Fri, 15 Aug 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270367; cv=none; b=VJrNcz2jAHxwfZI0V/D+PU6WdyTtE2+BlrPdIMCA9Bbcs9b0RQ9UWCwTVkBfg89nranksTZJEkXw+S0pOfd9aC5XTDWqxdCDWDrY/pdGRo+/YNImF/t9kad2Y4vaWpZJ4RD1ep4sHEK7Guq0fuABAcTLV2exTn1IoxCu50ed9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270367; c=relaxed/simple;
	bh=Hv6COFjM439OcVUsu3MmySHKd9Z183npAzo+Lkk0SrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJOlqZ1mh7/82Mx7al7bcu4ZVt9QQ8Og7zzVnq4GU5BhMdEakeWJDJnQTnrQW0etGcinlhgqP3kBG2HFejRj5RzZH1Ur1SdJJPlp6cBTYswt2AiNFhM086Yl+fESR02IZMAPnh5qR+aoZr/bmE0CVtqmkzt0fx5TRVlUsyuZ/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HElOWDL3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381dd4c61so1106991a34.0;
        Fri, 15 Aug 2025 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755270365; x=1755875165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMU3P7S8F7Aw6uN0IIUSqn9Ly+qBjCwhp5TaPqOj3Q8=;
        b=HElOWDL3C/1zYBi+41Tp/rAmEPkkn8kULFhXq1w0efYcfvvRNtMkSEJHfIx4yiNjzR
         tCnCWLp4ZQa06DF89gUALJ0GZ7LwIxDoA7yObwe5aVwXJ4GAIfJeWV33Kc3vqfOetKRH
         HzsWUS/ab2BT6pKEQLyD1dI9QAEx6cFjw0ycQRO2JJnVYx/t+gyey4nxy/SJYfoUZeLu
         9Uo/lD1nN2xwpx+SohnrnoqK17U/qhofcKh/8EOhhl5ufgncC+mTNXP4GvGsiJ+WXOJu
         O+NRxne3kafjWwREN/26w1tCLsIuQlfJOjw36T0kR/lt39zzxrjZ5Xxe2TFEAUD2gP+W
         UTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270365; x=1755875165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMU3P7S8F7Aw6uN0IIUSqn9Ly+qBjCwhp5TaPqOj3Q8=;
        b=gedPEsQsRquR0AtYmp1lvwYNzeX0a0N2rn5/FUFVBIqxLP4Nv6kGtEGdZJP7CYPMwo
         2758cFy61kzAP2O/BrMrbw/h4Fee8aBZqAFSzhKeM2PtHB0w2efG+MqCPArGCziAPdcD
         eTegeijDYbM8TufaUNNVCXIbVu2KE3cefr4WRT/4RpdmrMXYhHOI/vsmpcInGOpcsaN2
         tu7jykWzN5S0VD1NhBNH/f37nUg/W8IDMFo+ul5aqSU5Om8JV//9HZI0hMrerWvpNjNv
         T3cgNi5zQCA73Ac1Qu3W+KFTx3vsiieuTZiY8R9LI0cGTVF5n7o++Bb3BI7GqBPsXKEj
         Jj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBs/64NF2jLPSFMxKkk+R8X7qs0vSOdeTkfYjAVad5rSdg/Hs//1BVgw84CUthoQZYA/SkvPh6kJ4M4rpyLQ==@vger.kernel.org, AJvYcCUNBQTNiD3ba2SvpiTx3pK5mODP+vOUSVEpHOj4+mRcItPI1beC4BbysFwt5Xu1tlwOqtz9/EcEhMcD@vger.kernel.org, AJvYcCVhjqMXs+KdCr2RIxof3ixCAkxR9UPqqi56Leymk58ZqudFkgHelRtiCBEKYR7cOnguwLd4F+2ev4Y=@vger.kernel.org, AJvYcCW63xILkbyj4ruDJKwlCr7skI5fPPZ8ZMTxIxVrmAeUh209Y0Ph7P6jacLk0PAZlnEdTh5mwOhDrU8JocY/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22IKCZp/Ii5wSm5qDayNjEg1A1VgxEytD0UhMvbj7GuLYJ06K
	RLAFBldkXXl/UXG1SQeOoImbZJlU7m/ytg/5CtYphAeEMczzW9+tLNfQ
X-Gm-Gg: ASbGnct1IFGI09miu0nnHFwFH0rnuv7Jwo4xqlPM+QQwGEYzUEqMxhM++PqHO5fX5XD
	N28q+6F9bP9BJrMFV8/Vk66yqlOmJbtJQEZh4vXqrPg/wtN3jM+iB2yG331bBYw6/kzC1Tt1Ps0
	E5Jv7CzN16OzSPkDVzfhGqPUHdyI+GoybAiNWaw1Z9MyhKN7MBMR0kwg2YHwQSMZd8T16MfFeYS
	TP1sbHOfctWXksCxbu1s2ru5v9yIhT+KhdEqZQUv7Bzul4hZ+AINAaMKQpcLZNDTzQ/WJdEi0AN
	fCZrx0NnO0st/NYmNJTvDj1PSjFyaYBGtQqT3Fgq4z6mdOBHMjBsvP0iBb75FipbI2EBdCuWEyJ
	ImG0bVNpW1lyIazWLm5gdNJJHGZ9RULVG46yL
X-Google-Smtp-Source: AGHT+IExS7Qt3BoP7WsTyBTrr1V2BYGnO3GcQJg9xqGFg1jMcr6eYkPlR3LXsnRgQW/iQZY9uRNbxw==
X-Received: by 2002:a05:6830:448c:b0:739:f3b2:80f6 with SMTP id 46e09a7af769-743924651c2mr1338051a34.14.1755270364063;
        Fri, 15 Aug 2025 08:06:04 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c95b:3a76:bbcf:777c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec13e5c6sm145880eaf.25.2025.08.15.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:06:03 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 15 Aug 2025 10:06:01 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <hd3tancdc6pgjka44nwhk6laawnasob44jqagwxawrmxtevihe@2orrcse6xyjx>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
 <20250814182022.GW7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814182022.GW7942@frogsfrogsfrogs>

On 25/08/14 11:20AM, Darrick J. Wong wrote:
> On Thu, Aug 14, 2025 at 04:36:57PM +0200, Miklos Szeredi wrote:
> > On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > I'm still hoping some common ground would benefit both interfaces.
> > > Just not sure what it should be.
> > 
> > Something very high level:
> > 
> >  - allow several map formats: say a plain one with a list of extents
> > and a famfs one
> 
> Yes, I think that's needed.

Agreed

> 
> >  - allow several types of backing files: say regular and dax dev
> 
> "block device", for iomap.
> 
> >  - querying maps has a common protocol, format of maps is opaque to this
> >  - maps are cached by a common facility
> 
> I've written such a cache already. :)

I guess I need to take a look at that. Can you point me to the right place?

> 
> >  - each type of mapping has a decoder module
> 
> I don't know that you need much "decoding" -- for famfs, the regular
> mappings correspond to FUSE_IOMAP_TYPE_MAPPED.  The one goofy part is
> the device cookie in each IO mapping: fuse-iomap maps each block device
> you give it to a device cookie, so I guess famfs will have to do the
> same.
> 
> OTOH you can then have a famfs backed by many persistent memory
> devices.

That's handled in the famfs fmaps already. When an fmap is ingested,
if it references any previously-unknown daxdevs, they get retrieved
(FUSE_GET_DAXDEV).

Oversimplifying a bit, I assume that famfs fmaps won't really change,
they'll just be retrieved by a more flexible method and be preceded
by a header that identifies the payload as a famfs fmap.

> 
> >  - each type of backing file has a module for handling I/O
> > 
> > Does this make sense?
> 
> More or less.

I'm nervous about going for too much generalization too soon here,
but otherwise yeah.

> 
> > This doesn't have to be implemented in one go, but for example
> > GET_FMAP could be renamed to GET_READ_MAP with an added offset and
> > size parameter.  For famfs the offset/size would be set to zero/inf.
> > I'd be content with that for now.
> 
> I'll try to cough up a RFC v4 next week.

Darrick, let's try to chat next week to compare notes.

Based on this thinking, I will keep my rework of GET_FMAP to a minimum
since that will likely be a new shared message/response. I think that
part can be merged later in the cycle...

John


