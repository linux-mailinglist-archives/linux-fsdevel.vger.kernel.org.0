Return-Path: <linux-fsdevel+bounces-73413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D202D186F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C895530198FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428236BCD1;
	Tue, 13 Jan 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XibTk0kx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oBqk29dQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40635C1BA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303012; cv=none; b=ZcTJ1fH8AIaFWu/UDV2Ape+y9dqIJWFM4J9xarH0KfRSKPuoxvlUpbSmqi4f9qcd2Zj98elEtnne/PRAE5E/hbMVryjKhY+23uSVPn+6fZRy80xa4uIHaRx1HMxlO1gHUHhZgflOzCezmnqezU62QNnwvHLSpIgyr0W/V8TPVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303012; c=relaxed/simple;
	bh=AmU0GKiuCJ+4Qe+dqer8i7dSl9l/acUK62fHtoMX+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwVx/eu0PliwNV3s2/wXvqiUL+AJU3Bx9S4jGiPF/DdgYWrh036ZYOoawR5DfbOUg5mw99IjlKNYpXmEUA0E341jr2Ek9Epq8onDXU0EFnceLV1j4WPOSl8Q2UU9c/VV3bHlh+5vmy+0RFAh6T+ApfO9oeKBXeMuxqLpuHfBU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XibTk0kx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oBqk29dQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768303009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVvfGyEDgnITgpd/RH07Kuh2vfJUyfB4HEN6kFlg01E=;
	b=XibTk0kxnBpTADmBc+avht2AweO8XOdod+GU2ytz5j+UdZY5vrJrv8Wn+1V5MITjkft4bZ
	FhCKefFy4+OJ9+gxtFQrDAxXTWVSWgihk2nDrAShJDrJdYrKWguD7BNEXCgNhDxVXl44bN
	C/lOGGLmKEdkOz5Jrh/qFlJ710ykvaw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-w1W-g0CaNqam1AzDL-iVsQ-1; Tue, 13 Jan 2026 06:16:48 -0500
X-MC-Unique: w1W-g0CaNqam1AzDL-iVsQ-1
X-Mimecast-MFC-AGG-ID: w1W-g0CaNqam1AzDL-iVsQ_1768303007
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fb8d41acso4884237f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768303007; x=1768907807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVvfGyEDgnITgpd/RH07Kuh2vfJUyfB4HEN6kFlg01E=;
        b=oBqk29dQ5hsDsBxXjUArf5jqwyxwj7srLT17ddmTB7UkWh6daxq2AeRc74g4LCj+eO
         4wce3Ih/PCxAyjLouXx0SWpX6ND2cs4EngWerzWJXB2I3PAl1FhGq7UgeDavR2cSQZ0P
         lnPzV9eck6k48qrhbN8eRdj/V83JQFLDNNkvV8wMNSSkcg7MIpNYLw9k27SQUoI14YRN
         T2YmHDcjCAJAblAM9bVDeCx/hJfMXQh6xh/5KlllxRvcXv2ONPYBeKcLxUephtrhlXVC
         JiH2cFcnpSeCISiLVoUfNE37at6wdrzxNFBgrNt8foVVSmyiw5OjXdGSWU8yacg6/XNh
         Y17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303007; x=1768907807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVvfGyEDgnITgpd/RH07Kuh2vfJUyfB4HEN6kFlg01E=;
        b=RyiQahtkk0slUeHwyopgAdnsfbLR8fIT05O8pQpznG5Ny+MtpVVsRG8GNf9GCBxvyJ
         hE/vqXlbFFo9zP0jAcRP7I+/4SrEzgtMOUmId4F0GdcTNpb6I+F+JkQMwv9zbtAtr/Z5
         kDv1RKX9TLe17DR/xvnOXPdK92SmhNNgnDtOukuUMuWFCY8VT0Tnm8OUcIqPsbPCg13e
         G0qTRWdAJYZQb8MJhi5aXVmoWLZYzp70CVYLq8HFqeRQ6iJfLv724TGHCUDWXxsljiSr
         QMW2pGKprahsDLjhaDrjFLsRisbVJ+ISuehZDRrGnYWFNfrKNKyBFmYTtFbff5/mN/BN
         X1aA==
X-Forwarded-Encrypted: i=1; AJvYcCWbou16jPN2+yq5nWmfrqBwS87MaVzJzlesHXRzoz65W5T0CK/0/Bx0asgnZ7M7fQ6K+VnMedykMXJ9XTVd@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOfadlGCAJKjGxsV75B6EX+U+QizQrvz8b/XPT6MsQU2dQ86G
	i0umCuh/JZzZVCWBQf0fQtH3OTCmj4IzaLzuETkQi4pA7WluFOPWr+qyOtcQn7BVDUjyznGHfZK
	3dt64q3w5cQ3VlbJWNzQZrnez/ov5N78cmWSh+2cFYfT5PpGt00+o+2/MeoyynqXCWA==
X-Gm-Gg: AY/fxX6dcXGupT9ly+aLLkVcK0o6RKVnZ09sEbX6575sDz3yta2wL9ffH1f09aMFVBC
	kealde7ghaZA9bwGLdkJp2qFEdJtH/8d20EMnK24YBClTgDKh0ulgFS3KioSQmGG+ZXpAXGW3By
	/sErtKlDGOLRYaSgAGLDWlDw9+c/8EFrMYZyobVRsnd9TJr6tsv4WOXVG4rw1AE5ausDL4AoUsZ
	GCCNxB9DsPGZV7b6eC9/1yqmIZ5HL+ztMzRkbaqOIHtyoAptPC0QEPakbRvXGFlE9bSALkGvWmn
	+LSGrHylN+jHzeLAjQ4tjhLHSvjr/n69jl/IHPBRUV9mMRgVaWB6faB7O/cWFaAjX3vOM8pFuMM
	=
X-Received: by 2002:a05:600c:3e0d:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-47d84b0a279mr220891135e9.2.1768303006990;
        Tue, 13 Jan 2026 03:16:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdIEOqsc71XSJgq6BNxiwINXMFW/+1X+/6MZ3YB9J1o13YbvNTcvNa0txlFxOzGEx83ctutA==
X-Received: by 2002:a05:600c:3e0d:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-47d84b0a279mr220890675e9.2.1768303006513;
        Tue, 13 Jan 2026 03:16:46 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed98abad1sm33030435e9.10.2026.01.13.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:16:46 -0800 (PST)
Date: Tue, 13 Jan 2026 12:16:45 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 5/22] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <vwx7hktpfbdbstxloryrfwcbk373pugjeqcozm7nuvl3uykr5z@gdgmpr7pgp34>
References: <cover.1768229271.patch-series@thinky>
 <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>
 <20260112223555.GL15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112223555.GL15551@frogsfrogsfrogs>

On 2026-01-12 14:35:55, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:50:26PM +0100, Andrey Albershteyn wrote:
> > This patch adds fs-verity verification into iomap's read path. After
> > BIO's io operation is complete the data are verified against
> > fs-verity's Merkle tree. Verification work is done in a separate
> > workqueue.
> > 
> > The read path ioend iomap_read_ioend are stored side by side with
> > BIOs if FS_VERITY is enabled.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/bio.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  fs/iomap/buffered-io.c | 12 ++++++++-
> >  fs/iomap/ioend.c       | 41 +++++++++++++++++++++++++++++++-
> >  include/linux/iomap.h  | 11 ++++++++
> >  4 files changed, 123 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> > index fc045f2e4c..ac6c16b1f8 100644
> > --- a/fs/iomap/bio.c
> > +++ b/fs/iomap/bio.c
> > @@ -5,6 +5,7 @@
> >   */
> >  #include <linux/iomap.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/fsverity.h>
> >  #include "internal.h"
> >  #include "trace.h"
> >  
> > @@ -18,6 +19,60 @@
> >  	bio_put(bio);
> >  }
> >  
> > +#ifdef CONFIG_FS_VERITY
> 
> Should all this stuff go into fs/iomap/fsverity.c instead of ifdef'd
> around the iomap code?
> 
> <shrug>

oh, sure, this would be better

> 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 79d1c97f02..481f7e1cff 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/swap.h>
> >  #include <linux/migrate.h>
> > +#include <linux/fsverity.h>
> >  #include "internal.h"
> >  #include "trace.h"
> >  
> > @@ -532,10 +533,19 @@
> >  		if (plen == 0)
> >  			return 0;
> >  
> > +		/* end of fs-verity region*/
> > +		if ((iomap->flags & IOMAP_F_BEYOND_EOF) && (iomap->type == IOMAP_HOLE)) {
> 
> Overly long line.

will fix

> 
> Also, when do we get the combination of BEYOND_EOF && HOLE?  Is that for
> sparse regions in only the merkle tree?  IIRC (and I could be wrong)
> fsverity still wants to checksum sparse holes in the regular file data,
> right?

The _BEYOUND_EOF is only for fsverity metadata. This case handles
the merkle tree tail case/end of tree. 1k fs bs 4k page 1k fsverity
blocks, fsverity requests the page with a tree which is smaller than
4 fsverity blocks (e.g. 3072b). The last 1k block in the page will
be hole. So, just zero out the rest and mark uptodate.

> 
> > +			folio_zero_range(folio, poff, plen);
> > +			iomap_set_range_uptodate(folio, poff, plen);
> > +		}
> >  		/* zero post-eof blocks as the page may be mapped */
> > -		if (iomap_block_needs_zeroing(iter, pos) &&
> > +		else if (iomap_block_needs_zeroing(iter, pos) &&
> 
> 		} else if (...
> 
> (nitpicking indentation)
> 
> >  		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> >  			folio_zero_range(folio, poff, plen);
> > +			if (fsverity_active(iter->inode) &&
> > +			    !fsverity_verify_blocks(folio, plen, poff)) {
> > +				return -EIO;
> > +			}
> >  			iomap_set_range_uptodate(folio, poff, plen);
> >  		} else {
> >  			if (!*bytes_submitted)
> > diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> > index 86f44922ed..30c0de3c75 100644
> > --- a/fs/iomap/ioend.c
> > +++ b/fs/iomap/ioend.c
> > @@ -9,6 +9,8 @@
> >  #include "internal.h"
> >  #include "trace.h"
> >  
> > +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> 
> How do we arrive at this pool size?  How is it important to have a
> larger bio reserve pool for *larger* base page sizes?

Well, this is just a one which iomap uses by default for read pool.
I'm not sure I know enough to optimize pool size here :)

-- 
- Andrey


