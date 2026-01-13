Return-Path: <linux-fsdevel+bounces-73410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B8D18418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D433E3040685
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0F392836;
	Tue, 13 Jan 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UenjutGG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t72aYepe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD33921E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301417; cv=none; b=CtKpuBNVi2PNzACGFVcC+Rkxv+5ldQDdRs/n+rurUijh1mrm6FhaGeLyYrBzT78H/c0LVDbZpqobRG0mloXZKempLJ9hD5IVR+DWQH32jwaweE0Qo/6exlMHCCGz6DJw2V2agqlf10uniaL+ZOBPkvSntCPkz1Bu0c49yD9GhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301417; c=relaxed/simple;
	bh=zs4+pY6UFBBhQer26MrIS2bBpKEtlbeski6Dk0lOabo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bieRwDLc0TNgB3sab1rIUPMPtoNsk6Jo2wgsjpq0zxDn08MjjiOgSor3KOAdcOnq4DTrnSrjGc5Bd1iT8AxRmKRfs4v296XBfhGmDP5nNP4wyn8eb/vqRHqDfvGdvQs9TAzM3pJVKsKKWNNQXSxP16mK6Xo41EFi/56oNBrVldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UenjutGG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t72aYepe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768301411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZ3j0SOHASLnmo9OqDChCwBfxwLNuYXaGvQPIXl45AM=;
	b=UenjutGGvRHrAJXE/eXDj0TfRyGehZ9g6C3siI8bA+dCO2LpqZpfWZ9pUwzPg2zhkLk9jU
	c0Q9e+940xRgXIS914yP0quZuucb9anrGa/nPYmwnOgqnsz3KnAYhhh0yKfK9y+GWPaih3
	+DP5OHW2by5fthewEn9OkSQrh2NdgzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-lZBE2iTbPYyI9pRqtJAuaw-1; Tue, 13 Jan 2026 05:50:10 -0500
X-MC-Unique: lZBE2iTbPYyI9pRqtJAuaw-1
X-Mimecast-MFC-AGG-ID: lZBE2iTbPYyI9pRqtJAuaw_1768301409
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432488a0ce8so5585225f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768301409; x=1768906209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ3j0SOHASLnmo9OqDChCwBfxwLNuYXaGvQPIXl45AM=;
        b=t72aYepeiDvfB2RvQsYfvtDskmyzpkrHqYxx9sqdc0t3paG/LbyhG9d/+zhPk3HIo4
         2PqZEBLEfC85Xh4/l1wf02bpjEi884kJVI3N7pS396OGG/mSxt4CTisZqhEMPmDnX7yA
         yUzeuAcO34HkDU9Wvwo7VnAt1vuAnGhRQgBoAanfbX1vFZFRytz+dYEsfCc9YNQ55BFP
         1vkTi1/fEGY6Kjph1b4bX95hF8ntY0G2i9I12SMpfdOoiXIRVvsz4u1y/J1PCNW+Aw//
         C//8YgLYHloW4qJWmREmAH2J/QSUvvuzksE6zA0KSOrCmEDm8JAgTPpOk2rZb3sjNctK
         bxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301409; x=1768906209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ3j0SOHASLnmo9OqDChCwBfxwLNuYXaGvQPIXl45AM=;
        b=Oc0Ka1DhmAU32iGC7F9rQ3TP8rB4pQT5RBC+ojTQgUxF5gOFWYSglmtswcOD+H6Pli
         BtVrtPBW/yDuqH7i/kS6rm0IGbNi+Qbm+JDwpT/G1IQR5SSnASu7wpZ7c74lFLZ3W2Ga
         bMl6+vPlgP39FhbKsFk3HDVdQYyD2tId1oxNkaBOR7Q4QV11sTzkvjemPndRc3+uTIQH
         bS0Ll/NQS6vgXbJl5Q6vXuiuOzDRCOQpxZFr6jKXRwK7OIYBgCPGfDo9f1GVgGwl4U8r
         fUIfLywGVpoJvm0oGX2WArTLQ4WX8TYRM031yWinWQuKXxfAw7WzCvlCjMoh/GCZqnuW
         /4jw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJkRgZwr1IUHghdzfOnzDTcIBdcPi/T8xwfheDckx9D26iQqHT5XeSre7VUE3unLTgjlHsp2T0efgKPa9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9xvKp4/wXM4csvXCq0BxGc6f3aH+0r56LNGm6dx3h+idoNbh
	/ymnP5tNYXQ1mtwF0X+5r893ZvG6o3e8lawgW/oAWAvwA81ugKw31tuoziHbPkrIeV6jElz5xrs
	1UOvTp+TM6+VUjsywW76iLe4U3Owh1pwkEJDfzKoFNd/BWetvsp6kaK9iKPZkGtthXA==
X-Gm-Gg: AY/fxX5B873zxZKNrltgGZ/QySQe6tTajKLU9froYWQv+oH21qBeeNlJy3yf0BxIr+a
	CH1m053LwFcVw6GKf+xYBqmR7LCeE452x8aXiyKFUh4lz2MM0bql2tC61kZ/xNBDrPAcW0l/LcZ
	U+zrVzOSHQVEnC43+Uw1TrYCh9fCz5lfu2aZ/XwPjNv9oE6/g2vWEH81Wm0MyHUCpxZdoM4WcCc
	lovXUR5v/f9unxRc3CAPk3+YzVuaowbtKMldQHM1GVYcn2kSIRclQJV7/K+eL9gw3rch2oJGR5L
	xiVZew+cWsVmTKAOiJrHJMVdUVA6le6X1agOGqBnstwDm47JNdvr9myD/OGTEFZYCl8vseKXY94
	=
X-Received: by 2002:a05:6000:3102:b0:429:c851:69ab with SMTP id ffacd0b85a97d-432c38d22e5mr20813941f8f.55.1768301408656;
        Tue, 13 Jan 2026 02:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcmNmJys26XuZztJOyKdSJM/PHCDpO7qgbJlWds4OOLxDbjN5kxlCB20323N+1/6DIlpZFFA==
X-Received: by 2002:a05:6000:3102:b0:429:c851:69ab with SMTP id ffacd0b85a97d-432c38d22e5mr20813895f8f.55.1768301408145;
        Tue, 13 Jan 2026 02:50:08 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm29847812f8f.7.2026.01.13.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:50:07 -0800 (PST)
Date: Tue, 13 Jan 2026 11:50:07 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <xjz5a35ypk3am6fbhkfdeeeilu54lhbcymginjv6srjve4qfjn@uucfin46ylhj>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
 <20260112221853.GI15551@frogsfrogsfrogs>
 <20260113081220.GB30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113081220.GB30809@lst.de>

On 2026-01-13 09:12:20, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 02:18:53PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> > > Flag to indicate to iomap that read/write is happening beyond EOF and no
> > > isize checks/update is needed.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 13 ++++++++-----
> > >  fs/iomap/trace.h       |  3 ++-
> > >  include/linux/iomap.h  |  5 +++++
> > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index e5c1ca440d..cc1cbf2a4c 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -533,7 +533,8 @@
> > 
> > (Does your diff program not set --show-c-function?  That makes reviewing
> > harder because I have to search on the comment text to figure out which
> > function this is)
> 
> Or use git-send-email which sidesteps all these issues :)
> 
> > Hrm.  The last test in iomap_block_needs_zeroing is if pos is at or
> > beyond EOF, and iomap_adjust_read_range takes great pains to reduce plen
> > so that poff/plen never cross EOF.  I think the intent of that code is
> > to ensure that we always zero the post-EOF part of a folio when reading
> > it in from disk.
> > 
> > For verity I can see why you don't want to zero the merkle tree blocks
> > beyond EOF, but I think this code can expose unwritten junk in the
> > post-EOF part of the EOF block on disk.
> > 
> > Would it be more correct to do:
> 
> Or replace the generic past EOF flag with a FSVERITY flag making
> the use case clear?
> 

I will rename it to _FSVERITY

> > > @@ -1815,8 +1817,9 @@
> > >  
> > >  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
> > >  
> > > -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> > > -		return 0;
> > > +	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
> > > +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
> > 
> > Hrm.  I /think/ this might break post-eof zeroing on writeback if
> > BEYOND_EOF is set.  For verity this isn't a problem because there's no
> > writeback, but it's a bit of a logic bomb if someone ever tries to set
> > BEYOND_EOF on a non-verity file.
> 
> Maybe we should not even support the flag for writeback?
> 

Hmm not sure how you see this, the verity pages need to get written
somehow and as they are beyond EOF they will be zeroed out here.

Regarding your comment in the thread to use direct IO, fsverity
wants to use page cache as cache for verified pages (already
verified page will have "verified" flag set, freshly read won't).

So, I think writeback has to know how to handle them

-- 
- Andrey


