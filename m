Return-Path: <linux-fsdevel+bounces-5762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8980FB04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587191C20DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790E6470C;
	Tue, 12 Dec 2023 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wQQTX9+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B2912E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:06:41 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d67870032so39594295ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702422401; x=1703027201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPu9OJuRoySeT6EQUZCVlx9vnkyIloc86JjG7P6vc+4=;
        b=wQQTX9+r4Q1R9JGnhCDMmJJXnUcQEK/y7DFgVVYOilBCvdiamLRmvitj61SVWGephz
         ZnUXQDs+Lla84KJOE+duDT2oUBDFRpC+sD2MZ6PyyzRl5EDDTAVv5PMj7j191VYV1+6P
         jyhagKX+yQYwy5QKhCw6bTZcFnA/S2YjR/eEl/6zhWXxm/p9GVI3JauAA9CkRD1tXInl
         G9fc/wmh6yFi4vCH0vgP/cPJ/B8RQRDPA16b9uTSc9H1BkMsAHWaalz6QDOUer/JlttF
         ly2nTx731PDgSQqRY87T6DQyopLjsJYwAZ26VUe4iIQV+Lt/yy1+nBP3CQeJUQv3a7sE
         4CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702422401; x=1703027201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPu9OJuRoySeT6EQUZCVlx9vnkyIloc86JjG7P6vc+4=;
        b=qwvdRXjUQSzJs5+B4QFnbvz4sQaDJ0wKIU+PyHrM7LMqQ7EumvmVya0qVAW69AHFJJ
         5vyoKvCgZ2esZqFjF6e+d4SJX0zRQMH+gcQiRWxrf9lV3jdZ4rARrKbiRvhPfvGJ3Np7
         qufk/OGHGkAqYXexthsxBdhgHdqcyRLowAMzqAYcarUGz1GvDTuyEirUH7uGxZbbyjE0
         hSu52zjKvPWFwQiwHrrAzrTUGlGOf2dAeKdxQP+x7ubRCw8JgvTN9J0NmPanjJ+jf1F/
         Kmtg/sB7ieyJIr1vPgrSHt9TQoWY9nlV4zC2RwcaGpjyYDhnUNy6LRtuXKjQIoc7nwiW
         waqw==
X-Gm-Message-State: AOJu0YzSMR+zsWJKjLoyrVAeyvM0qNtc7rySJyhmH3VACEgwuzNmuHCh
	dVpVR2zWUYuErDwDvgQDugWLtQ==
X-Google-Smtp-Source: AGHT+IGDEkxi5C9eKXRu2Df4eSKaVBRfjiKd3GCoS0nCA4pc7+cRAGniuFwyEqLHQ+B4KC+5ZfKcNg==
X-Received: by 2002:a05:6e02:1d09:b0:35f:70e3:220c with SMTP id i9-20020a056e021d0900b0035f70e3220cmr370829ila.54.1702422400751;
        Tue, 12 Dec 2023 15:06:40 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090aa38c00b002858ac5e401sm10762985pjp.45.2023.12.12.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:06:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDBpl-007UqY-1k;
	Wed, 13 Dec 2023 10:06:37 +1100
Date: Wed, 13 Dec 2023 10:06:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <ZXjnffHOo+JY/M4b@dread.disaster.area>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
 <ZXjHEPn3DfgQNoms@dread.disaster.area>
 <20231212212306.tpaw7nfubbuogglw@moria.home.lan>
 <ZXjaWIFKvBRH7Q4c@dread.disaster.area>
 <170242027365.12910.2226609822336684620@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170242027365.12910.2226609822336684620@noble.neil.brown.name>

On Wed, Dec 13, 2023 at 09:31:13AM +1100, NeilBrown wrote:
> On Wed, 13 Dec 2023, Dave Chinner wrote:
> > 
> > What you are suggesting is that we now duplicate filehandle encoding
> > into every filesystem's statx() implementation.  That's a bad
> > trade-off from a maintenance, testing and consistency POV because
> > now we end up with lots of individual, filehandle encoding
> > implementations in addition to the generic filehandle
> > infrastructure that we all have to test and validate.
> 
> Not correct.  We are suggesting an interface, not an implementation.
> Here you are proposing a suboptimal implementation, pointing out its
> weakness, and suggesting the has consequences for the interface
> proposal.  Is that the strawman fallacy?

No, you simply haven't followed deep enough into the rabbit hole to
understand Kent was suggesting potential implementation details to
address hot path performance concerns with filehandle encoding.

> vfs_getattr_nosec could, after calling i_op->getattr, check if
> STATX_HANDLE is set in request_mask but not in ->result_mask.
> If so it could call exportfs_encode_fh() and handle the result.
>
> No filesystem need to be changed.

Well, yes, it's pretty damn obvious that is exactly what I've been
advocating for here - if we are going to put filehandles in statx(),
then it must use the same infrastructure as name_to_handle_at().
i.e. calling exportfs_encode_fh(EXPORT_FH_FID) to generate the
filehandle.

The important discussion detail you've missed about
exportfs_encode_fh() is that it *requires* adding a new indirect
call (via export_ops->encode_fh) in the statx path to encode the
filehandle, and that's exactly what Kent was suggesting we can code
the implementation to avoid.

Avoiding an indirect function call is an implementation detail, not
an interface design requirement.

And the only way to avoid adding new indirect calls to encoding
filesystem specific filehandles is to implement the encoding in the
existing individual filesystem i_op->getattr methods. i.e. duplicate
the filehandle encoding in the statx path rather than use
exportfs_encode_fh().....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

