Return-Path: <linux-fsdevel+bounces-58040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07014B283EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F07AE6946
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFE309DD4;
	Fri, 15 Aug 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSpBGVFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A93093A2;
	Fri, 15 Aug 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275887; cv=none; b=W7kwQ6Jd+HDeosBcCuuZJ+DZROfJ/BfcauQMeBB0J37GIQAG7jfB0D00sma5JdMdBxNoKanJGf6XPGD65pLff5/OHyCMOv/sPOwRGxaozduodJV2r+G5EA8jkUSfs/Q+K+/QKNv5jDFFwPM/550jyWGBiHri52/bqUplYmyo1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275887; c=relaxed/simple;
	bh=wvKG9q6ho4RgZrrJIdGv5TeB043vsJ7FH5BLK3VX8eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN7PFrd+hV+N58DH5PHX3QtsVD/7ziim93aHLRTRfIszyMZyZhZKUrqnzhexqxSgwYOMsulChwvLwqK+Y7zSvwyj6fmUgat2CFVqjDSO3iot/tdbHXOVSxp+a1rCOZlDcE3a+msK4SQM3iRVKUfDTBFyJZjAFrsFCE5jsVNhUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSpBGVFO; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bd4d1778cso600227eaf.1;
        Fri, 15 Aug 2025 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755275885; x=1755880685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsMGeBFSMhVbn3vuzD+PKSwFX2QkoR6dSZaKAtY6lT0=;
        b=kSpBGVFOFhbBffCpynPXoLNRUUBuMHv2OjRajjbGltzT2hGqf1sfxv6gREcjICtu9l
         SEDXyZbP5BzUrZ6MTaI7uXeuTcZAz7l4LqSTF5gy10lz7mjtBC/j6L1uuy7QGe2rAb3m
         SAweNVWoZJCAU8X/yejJQFYlH/hnffx45jn/nti6AFefv60oyxkxPJyuerrdPbck6aDT
         s0xV69ETlD4gX1USW9W5V4SgnBJLf8uLCM24nTaMtVjRSGkie+8TKxBnLT3S7ycyvdkB
         baG+IK9ExZ1kkysEkxME5MQ4mOxGdR9/XqO2AqtdDQl9KmgIVsPhmO6j3YGKNVpEogfv
         jIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755275885; x=1755880685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsMGeBFSMhVbn3vuzD+PKSwFX2QkoR6dSZaKAtY6lT0=;
        b=doQq25lgieVwCBbs7bN0oEUVV0GlGcS52jMF+nPc7cRhrk6XrX46dafPUfzcr4nj57
         C1FdxObovJwfcyWKYQlk7E0h5qQtwomFOIgYS5G1beJE8hsJLAKdBAwV7KDBwxNlYXNb
         BGkkT7i/jcrfoNMPTJIPGSVow+jpzr9R0qaHZK2VPqIQdH0IyIYk66LWeLixO1+CA8gl
         OZm9/KrZpnefbdWOP6N3sBXSY7r14cJN51xJPfsmIhaPQWs8kYYFufZrqmpaBGTbwufM
         Q9xw3uGdya7vqeqGJgbuYa1s7YTk4Vq+ME1jcZAk29DADHKCV/U6Flzu3L7rsbApEsNs
         oiTA==
X-Forwarded-Encrypted: i=1; AJvYcCVbN+sWi4Yj1sBJ5OBK2X+ZgxtFUVUHNahmpJXuQMy5IpxJ43iibJu0mSSFsBNIS6iFF64dHzbIRGk=@vger.kernel.org, AJvYcCX4GbaSoNzoZOlwT+efKi6EXZJlw6uOL+rayRe6Fp5y3yyqzC+m22/XUVdRxiRdgltSYzNFcEe53nyize6zfg==@vger.kernel.org, AJvYcCX69GPaAeOL+RBoohPlLjAcR3OlbOQ6sFNoiMh9cukd28W6loLnRULgNunkwW1FWcCXI0HsZehvRQofmgIi@vger.kernel.org, AJvYcCXgMCkyGuCfZi4Y8rh80lzICgs/Dv3qpf57Qvkx4OBy5x76P8kyrEoYVKAGDguvnoK4yIEV8dJ7p/ho@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8HoezIJguy4KtE7tbAf5PS7Z35/e7QR7SKpm4G2tzU8/1NWN
	YdAJib1VkTQHSCvH6Y98kWZKFQFnoMIhCt1TcoeZKMfy/caaYfJsT/cZ
X-Gm-Gg: ASbGncsnff1da0Zw09nqncSljDtW1M0GGkn3BZXzgog0YBmFPLMEETpAm1AjnDeWBcT
	Cnc7b12TEGrJBhZMnFxFgASiSsSym3dJNtIJvT76TJ920bjDjNL8ut0VYTlVoCKRCAENzUl13Y1
	WFDj2HjbpC9SrJSZmMna0trVGYY/3WUrPawzOCX5KYucvRsKfC/gsMwncx7z314xvf2gbU+mVV4
	jnBkbrTqDxkn0Hdr7Zxdbi2uhXUWhGYjJhS3q/mSIw9thecK45ioXZ9z1UKVvXFN7fh+12oI9yn
	HdZfU2lSnAKhWiu6RvRxY75hUY+sT2C1eo2vSJ/uD2lzwnG53CrN/P4rGLR1ovLq1kq8Kwv262k
	lBHhmI+A2cLpelhQMdvpCpxkayL+ii7loTO5E
X-Google-Smtp-Source: AGHT+IFcdjxfw9AaYkhVjHgYkiqDkUXLAcvGkFoOPrg34Eo+AprZt6K9wZhsOSbhz56+5rnDzpwgzw==
X-Received: by 2002:a05:6871:61c5:b0:2f4:da72:5689 with SMTP id 586e51a60fabf-310aab51ff6mr1625953fac.15.1755275885079;
        Fri, 15 Aug 2025 09:38:05 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c95b:3a76:bbcf:777c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310ab87a7c7sm518355fac.4.2025.08.15.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:38:04 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 15 Aug 2025 11:38:02 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <oolcpxrjdzrkqnmj4xvcymnyb6ovdt7np7trxlgndniqe35l3s@ru5adqnjxexh>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>

On 25/08/14 03:58PM, Miklos Szeredi wrote:
> On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
> >
> > * The new GET_DAXDEV message/response is enabled
> > * The command it triggered by the update_daxdev_table() call, if there
> >   are any daxdevs in the subject fmap that are not represented in the
> >   daxdev_dable yet.
> 
> This is rather convoluted, the server *should know* which dax devices
> it has registered, hence it shouldn't need to be explicitly asked.

That's not impossible, but it's also a bit harder than the current
approach for the famfs user space - which I think would need to become
stateful as to which daxdevs had been pushed into the kernel. The
famfs user space is as unstateful as possible ;)

> 
> And there's already an API for registering file descriptors:
> FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
> be used by famfs?

FUSE_DEV_IOC_BACKING_OPEN looks pretty specific to passthrough. The
procedure for opening a daxdev is stolen from the way xfs does it in 
fs-dax mode. It calls fs_dax_get() rather then open(), and passes in 
'famfs_fuse_dax_holder_ops' to 1) effect exclusivity, and 2) receive
callbacks in the event of memory errors. See famfs_fuse_get_daxdev()...

A *similar* ioctl could be added to push in a daxdev, but that would
still add statefulness that isn't required in the current implementation.
I didn't go there because there are so few IOCTLs currently (the overall 
model is more 'pull' than 'push').

Keep in mind that the baseline case with famfs will be files that are 
interleaved across strips from many daxdevs. We commonly create files 
that are striped across 16 daxdevs, selected at random from a
significantly larger pool. Because interleaving is essential to memory 
performance...

There is no "device mapper" analog for memory, so famfs really does 
have to span daxdevs. As Darrick commented somewhere, famfs fmaps do 
repeating patterns well (i.e. striping)...

I think there is a certain elegance to the current approach, but
if you feel strongly I will change it.

Thanks!
John


