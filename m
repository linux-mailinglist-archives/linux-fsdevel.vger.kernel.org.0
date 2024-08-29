Return-Path: <linux-fsdevel+bounces-27828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC249645F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70318B258DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8841A7047;
	Thu, 29 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cC025rxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF61A4ADE
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937145; cv=none; b=Oeatgq/AOHFOxi70BnklTuCyiTM6jDJezX6XJbhs3Jf6rLfcEYaGRPf2yXOTBqV2ffYbA8savfYTdQAnaPvNRomkfHwzp2+XAXTbiQ0yhxJCxrUC/o6lGnI4nzpzl3FZ5vUeR4SMObEArzxd4mNfOBkBji/ncHpXnyEtkunoSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937145; c=relaxed/simple;
	bh=A/ukJ4jBr8jJQwS6YKUvYcuWgw8ce4anDS07GtBUeqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4SN6BosRO/kRyFxpOZTQWAeHBhEJqHbj30ojeCY7RYvo0IQtWuM/cN/MQyUujex1xr7Eg+mVqAnMb43mksEBDGgmLEh0dn7Wfb6mutJCheEIUr9JZ3c6cunCxZ1XYwOQEd/KVHy/Uty1wpDGARAed+NInzH06gz1VwB90wj/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cC025rxp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so485906a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724937143; x=1725541943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qX/f6dofDtGfqoUjh7wF0DGgkcB4Ol606CTys8bLCc=;
        b=cC025rxp2s0f9GU8p4vFM6gK/4CEuAH6aoyzZVG8TzaHQKelvBm+U9hT0BRgzwgDR+
         kABSDebTyiEq/IJ11jRgRMkAdcrQmWqqTKbHsLB+XyWVgv3aXDNwND1ac5zT49GaBQuy
         We/n4Is49FIPa2ssOupls8mNrbPnHleE+x9mLiZLokPnEDhe7PtVSRycuXJ7noZrlLMl
         DhM5WSSCbQZN4QsYUVw4ELdyVw0v9f+3TcrcQAbz1tg35HcgpY/XHlUebzmx2sO7uGjX
         IwpeXFw3oHa77o5TM3pEqgZvJaug/Km4747KQweRsFHIFJ5sFLqVG5ii0gLQxQidO2B/
         NIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937143; x=1725541943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qX/f6dofDtGfqoUjh7wF0DGgkcB4Ol606CTys8bLCc=;
        b=K4CVN0dGstoTJlagXi+N3+GjrPuftaRW432QcA4ibxtZ2SSR5NJUptczuSKH8djGo/
         2YPmycHoy3JNJ6lTf+2ShkJuwiRnNfQVCbRB9K9jLK3ToUmzZzhXVzSGT61ItTixiXk5
         xvLBZ/nIT8716jnLS+ryYj5NuinUOsyQP6Kn09Gv6w8eWOV6ejKEhLT9psO/Tdk+uefv
         sn8pErw7Cx0hoaRPAFGSz928CFzzkF+qiBpx6ZNFVTs80jaDAvsXjxCQxD4XgeHpQlTr
         DCPwollIVtAJ7nV0SzNYsY6q0kXudbbAjwcjf+MRhMKj1EQkMpxoTYMi5O8dYVCeteCS
         RybA==
X-Forwarded-Encrypted: i=1; AJvYcCVzpMYw8QMWFUO79v7dMkJoPtO017gOK5ZG6JTYUg/T5aKaI5u8ZucYzXLiZylyhxbAz++3othfbFJjBBvq@vger.kernel.org
X-Gm-Message-State: AOJu0YyFn9UTHAzMZSE7vhsN/vbuAwYVic40Xb93Q40Y1Jjfwx/iXo2b
	V32PeJcpfcjy5Nvx5LEHiKEDnjWXMJULqTLDOr04NKJ6hwaGDpQU/WNNG00hWd8=
X-Google-Smtp-Source: AGHT+IE5og1QyFjbYL+fjlxeemY0chdVMvPBO6yd0H47y0vJ8/ygu0YjmhWpP08sTZ8j5BBHBY/dlw==
X-Received: by 2002:a17:90b:c12:b0:2cb:5829:a491 with SMTP id 98e67ed59e1d1-2d85c7d28c3mr2403333a91.20.1724937142595;
        Thu, 29 Aug 2024 06:12:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542376sm10955575ad.204.2024.08.29.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:12:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjewk-00GwzF-1j;
	Thu, 29 Aug 2024 23:12:18 +1000
Date: Thu, 29 Aug 2024 23:12:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtBzstXltxowPOhR@dread.disaster.area>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>

On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > 
> > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > dangerous to use if the caller doesn't control the full call chain with
> > > this flag set. E.g. if any of the function down the chain needed
> > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > cause unexpected failure.
> > > 
> > > While this is not the case in this particular case using the scoped gfp
> > > semantic is not really needed bacause we can easily pus the allocation
> > > context down the chain without too much clutter.
> > > 
> > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> Reposting what I wrote in the other thread:

I've read the thread. I've heard what you have had to say. Like
several other people, I think your position is just not practical or
reasonable.

I don't care about the purity or the safety of the API - the
practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
allocation can now fail and that will cause unexpected kernel
crashes.  Keeping existing code and API semantics working correctly
(i.e. regression free) takes precedence over new functionality or
API features that people want to introduce.

That's all there is to it. This is not a hill you need to die on.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

