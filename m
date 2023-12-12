Return-Path: <linux-fsdevel+bounces-5757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51180FA38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B77C1F21E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA1660F6;
	Tue, 12 Dec 2023 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Zdx558O5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941CA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:23:22 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-202d6823844so1474863fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702419801; x=1703024601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNsTHdEEOVy+nAufT2MDnbDKTamMQgkA0hUCPXsfa1k=;
        b=Zdx558O5qfGPVmRwyjCpUzToPKsmn/k/ZKP/GS1pV7e/3ZzDwZ+AqxwRbIZiMAWGpd
         G1gPcu9rbY6Y2sM8pyUzH4wdUqALUCIYmJ32EahXQTh6CRVYWN0SiAE7cApFBtC6EFJz
         7itnrUDePMDu+MwS+rFO0DISm+3tlif0wiqR2aPn62XrbA8Bs8v8vGly1U+VuoDiNb0R
         1VJeqUaOvG/TEPz2xbqkgQF5X5FX0PG6Ch3nlHjDpsDFVzOwd30bXnEtSnFifMyB0Y1i
         pT+i0+1Ksg5VkXiY01R87axZ6jvlOF9+azOSs0g3U4GmRmFLtmgsRQJvWofUCZvvU21z
         v+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419801; x=1703024601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNsTHdEEOVy+nAufT2MDnbDKTamMQgkA0hUCPXsfa1k=;
        b=YNyVD9IxYLsFFA6g+rPW/GHVgPKgJ6wCEx0MrJy76zhr6ANhDao9Bh0ycwZinYm9Ya
         ozoVyF7d0FlL1onaoqVosqExPIB8eFqsz3mq+NBw2vUHfeRFt7wUSc9u7UtWkhpCKdHI
         BtIVrCaP8WPXQzRKq4XdujGXvop1oKHnx597/FTzNN0JahQarWdUhmuq+6IxXfsHAB3u
         c0vsQBfHLlGKlg6jQLSHLwWOM7wfsPXA+KB5u6hyRvfN6NNf2CiGMnicyrF9KupFHwul
         bglxyiQBeJW3CebYJAxleDDsCqKdolvzBKmoK68JFfLY19TXiLXH8vnTqG52WxT45jjX
         vCQg==
X-Gm-Message-State: AOJu0YyqfYJmbTC0GdR6+RLti2qwWXMI6V5FoxXKQOyBfAn+bz6U2+Up
	mcx1FvGZcwZJO5Io8/32NkgHag==
X-Google-Smtp-Source: AGHT+IGrB2jO91UINzu3b61pznBqwE7GRV6B78NsGXVn/LXpoAnDSf7grIYRqaLVYP7Xs3ww9FK7Yw==
X-Received: by 2002:a05:6870:1798:b0:1fa:fadc:4d24 with SMTP id r24-20020a056870179800b001fafadc4d24mr8705627oae.55.1702419801568;
        Tue, 12 Dec 2023 14:23:21 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id u19-20020a63ef13000000b005c661a432d7sm8622530pgh.75.2023.12.12.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:23:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDB9q-007TtP-07;
	Wed, 13 Dec 2023 09:23:18 +1100
Date: Wed, 13 Dec 2023 09:23:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Frank Filz <ffilzlnx@mindspring.com>, 'Theodore Ts'o' <tytso@mit.edu>,
	'Donald Buczek' <buczek@molgen.mpg.de>,
	'Kent Overstreet' <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	'Stefan Krueger' <stefan.krueger@aei.mpg.de>,
	'David Howells' <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
Message-ID: <ZXjdVvE9W45KOrqe@dread.disaster.area>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
 <ZXjJyoJQFgma+lXF@dread.disaster.area>
 <170241826315.12910.12856411443761882385@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170241826315.12910.12856411443761882385@noble.neil.brown.name>

On Wed, Dec 13, 2023 at 08:57:43AM +1100, NeilBrown wrote:
> On Wed, 13 Dec 2023, Dave Chinner wrote:
> > On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > > >
> > > > > > So can someone please explain to me why we need to try to re-invent
> > > > > > a generic filehandle concept in statx when we already have a have
> > > > > > working and widely supported user API that provides exactly this
> > > > > > functionality?
> > > > >
> > > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > > able to retrieve the filehandle together with the other metadata in a
> > > > > single system call.
> > > > 
> > > > Can you say more?  What, specifically is the application that would want
> > > to do
> > > > that, and is it really in such a hot path that it would be a user-visible
> > > > improveable, let aloine something that can be actually be measured?
> > > 
> > > A user space NFS server like Ganesha could benefit from getting attributes
> > > and file handle in a single system call.
> > 
> > At the cost of every other application that doesn't need those
> > attributes.
> 
> Why do you think there would be a cost?

It's as much maintenance and testing cost as it is a runtime cost.
We have to test and check this functionality works as advertised,
and we have to maintain that in working order forever more. That's
not free, especially if it is decided that the implementation needs
to be hyper-optimised in each individual filesystem because of
performance cost reasons.

Indeed, even the runtime "do we need to fetch this information"
checks have a measurable cost, especially as statx() is a very hot
kernel path. We've been optimising branches out of things like
setting up kiocbs because when that path is taken millions of times
every second each logic branch that decides if something needs to be
done or not has a direct measurable cost. statx() is a hot path that
can be called millions of times a second.....

And then comes the cost of encoding dynamically sized information in
struct statx - filehandles are not fixed size - and statx is most
definitely not set up or intended for dynamically sized attribute
data. This adds more complexity to statx because it wasn't designed
or intended to handle dynamically sized attributes. Optional
attributes, yes, but not attributes that might vary in size from fs
to fs or even inode type to inode type within a fileystem (e.g. dir
filehandles can, optionally, encode the parent inode in them).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

