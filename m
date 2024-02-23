Return-Path: <linux-fsdevel+bounces-12563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED6861203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8486B22C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E37D41D;
	Fri, 23 Feb 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAn5uSyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744177CF1D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692928; cv=none; b=trgJvYVPourttTjw9ma9Ei8WI0JZcJce/OrsB/ff9etXS165RO8dgLxCiq8zi+kZXGIJE38/fos/FVN67orK3hjNUXkaN6kC5YP+MRG9OmTWl3BSK562MMs5oviQIxeJrvjV60Vg3vM1KRygeyke9OpnpZ5WtP/CfiKk9Gsbu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692928; c=relaxed/simple;
	bh=aVFT9EQp7q7JonJdV47KeTLSynCJZvyp7XBYXfrWLoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir15B04Tc/9/1X6GlrHbGTCPONUNu8Y6pO9gqL3oZAFNF4V/jeliZgFggWjMxbA/Z34WxEUOneEDIj+YoTEvItQ3mmmFKf+zV5GrkmWfnapdcf6m2sk+73lyB63CehFfhRYT3HlL+V7YSZIpkhEeRe9t4Eg+7RNJvkRLWhvwWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAn5uSyT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708692925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+w29RIGjR3n8ArJXrNp/EUd5heRIsgahlaJ2sqHGvU=;
	b=CAn5uSyTB+eJszhSSS7IFDSAAebn/2m9325Dr1cyVBLmrtc6RvTdPS/g6Wjwy+n3NO2o35
	RkbgomplSDLn66mcHdvHQWPDbWQ1u0lUOwcToxnug1xmK4ykTknALgOCzlMbT/0bvUhgCk
	YTzH0wJYI1gzb6U3IzCTZSrpG+aCGZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-fJ0GLLfaOY2AktcIB4g5Fw-1; Fri, 23 Feb 2024 07:55:24 -0500
X-MC-Unique: fJ0GLLfaOY2AktcIB4g5Fw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d9f425eaaso118382f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 04:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708692923; x=1709297723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+w29RIGjR3n8ArJXrNp/EUd5heRIsgahlaJ2sqHGvU=;
        b=vphnkN7oz7qCQGCYiyIu/QFQfDG8elTLr+f4+NGCI4kqXy915iK1jIWiCBbkMDUqx7
         obwQa7nLSnPw+1tOGDxyY0329+AlA6oiQyYN4N2etCPPkQnbmvO+v7F54TnXveWGXR49
         DnHKeVwc5fpgSR8HXUnBtxfzMVb7dEPaJIslR6DeIYFIivvj5ABM0eaBdZbcNemUHzth
         AlbzputQ/LoFRkyLhtw2RCaC6W8u/W1ZCrNQvd4PH1KtRZZCFpBOTnkagUU6pFXzFR7C
         lCaX761cNY4fOR3ZAfQnIib2iDDYLA/gNUJQ+89uVz+tk6jBZsalr2qLaJRyRIb6tDjY
         w+0w==
X-Forwarded-Encrypted: i=1; AJvYcCVg3aonxSYceMODbPTtXvmNioCH0YpbY4oCSQQojWQsC6jVgvtOLZHD9YE5RlvYB7ugdRDbxlEEIdYnmEvDuP7pTQbEmORRqat14t2/2g==
X-Gm-Message-State: AOJu0YyX0MTntW1YhaR0eMiQ1AlDEvZk4VlcyjDquy4GWtoDLXtRhecS
	VDYbmfOUUIROcD4rzvv9KG+XAypdrinrN4YaosMx2GLVXFyNRMBFULhLG8BXU9TxeHxWZcuAJg6
	rSuUkLJ7Ud5x1zq7UvazocuhSrdmu7fQy/pin/ysmzzaJ4aGpF3usTBO+DiTJeQ==
X-Received: by 2002:adf:f887:0:b0:33d:282c:af48 with SMTP id u7-20020adff887000000b0033d282caf48mr1328745wrp.69.1708692922932;
        Fri, 23 Feb 2024 04:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzOl5wggUxVEAyYw4DG2qkmOXnqF8Ch6/f5lpfvycnx7OLTSTxLLFHYWaS+EMxDphokC898g==
X-Received: by 2002:adf:f887:0:b0:33d:282c:af48 with SMTP id u7-20020adff887000000b0033d282caf48mr1328721wrp.69.1708692922521;
        Fri, 23 Feb 2024 04:55:22 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id x3-20020adff643000000b0033b278cf5fesm2674349wrp.102.2024.02.23.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:55:21 -0800 (PST)
Date: Fri, 23 Feb 2024 13:55:21 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH v4 05/25] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <ck7uzvtsfxikgpvdxw5mwvds5gq2errja7qhru7liy5akijcdg@rlodrbskdprz>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-6-aalbersh@redhat.com>
 <20240223042304.GA25631@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223042304.GA25631@sol.localdomain>

On 2024-02-22 20:23:04, Eric Biggers wrote:
> On Mon, Feb 12, 2024 at 05:58:02PM +0100, Andrey Albershteyn wrote:
> > +FS_IOC_FSGETXATTR
> > +-----------------
> > +
> > +Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
> > +files. The attribute can be observed via lsattr.
> > +
> > +    [root@vm:~]# lsattr /mnt/test/foo
> > +    --------------------V- /mnt/test/foo
> > +
> > +Note that this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity
> > +requires input parameters. See FS_IOC_ENABLE_VERITY.
> 
> The lsattr example is irrelevant and misleading because lsattr uses
> FS_IOC_GETFLAGS, not FS_IOC_FSGETXATTR.
> 
> Also, I know that you titled the subsection "FS_IOC_FSGETXATTR", but the text
> itself should make it super clear that FS_XFLAG_VERITY is only for
> FS_IOC_FSGETXATTR, not FS_IOC_GETFLAGS.

Sure, I will remove the example. Would something like this be clear
enough?

    FS_IOC_FSGETXATTR
    -----------------

    Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
    files. This attribute can be checked with FS_IOC_FSGETXATTR ioctl. Note that
    this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity requires
    input parameters. See FS_IOC_ENABLE_VERITY.

> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 48ad69f7722e..6e63ea832d4f 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -140,6 +140,7 @@ struct fsxattr {
> >  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> >  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> >  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> > +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
> 
> There's currently nowhere in the documentation or code that uses the phrase
> "fs-verity sealed inode".  It's instead called a verity file, or a file that has
> fs-verity enabled.  We should try to avoid inconsistent terminology.

Oops, missed this one. Thanks!

-- 
- Andrey


