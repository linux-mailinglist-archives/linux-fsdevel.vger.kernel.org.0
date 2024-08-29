Return-Path: <linux-fsdevel+bounces-27800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF519642B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C41F25FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EB191478;
	Thu, 29 Aug 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="awP7wa9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12B18E373
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929738; cv=none; b=DxwuUGj3lsrvkFXRqZuXlq2jC5d+bVIfegKV9k/xe0OpEBjnrxv881y6pah0gvpJeaVbh5kTv8mfCreqYj0OGvjaisKOU4s95urxtkZ0fHRrpofmborX1oqWdj9c6SKH5Lpadmka5Jbxvh7eLbvhdCqyGdAdU82nCMSt0xLLWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929738; c=relaxed/simple;
	bh=6gcX3UzsjDY3Cccp5eZL+uE4FKOxL+J94MPBBQuh3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxt1RqLOKAdvT/wxJiN6w9kJ1S/QQQM4ABp4/6llGW6pJGJQ9vBCYc1WEHwm9vOXllutvxdwcOY9QA3EUuqm8fgz/1q/RsX0AOCCOTpwB5SncKTqhefQaC4Thiwoz1cnsHczpCHAKbxgdiVwMp1c+D+TSKrVoaiLNdF4XBWtsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=awP7wa9H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so4945705e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724929734; x=1725534534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHWgXXg7l/fVXrIi7EOmqx3KL96WeyQfolynqyBIiyM=;
        b=awP7wa9HGAocV2DBUEkrCM2BGsCCppdL5LkVHGAl5LDA5C6kqispVi27h0s7SNsmYf
         /SkUT7HTxWKpJ9WuQtUbVNFY6XoF3YsMxlzXEYV75lPJdKpaiEal5ebBg3iKhRDl/jVP
         5NJLaC8yH47NHGdfzjL51+eh2Um9pXtjexrBqn7YiNOOJfVQjfJIBhvoLqFPEJ7qyG1f
         fN3X2vFImzX44oK73oiK++EwOXngw0hp4FVFv1/7vEXlWa7l/tXSUzMNknq/GfbAl+k0
         BtTIKuHKejomKL1cdjO4vbuBFYmbX0F6HJ8loOYtQskk6ATDFMhUM40yDhRf6VVedDUc
         yJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929734; x=1725534534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHWgXXg7l/fVXrIi7EOmqx3KL96WeyQfolynqyBIiyM=;
        b=GETj3XLt45EhGsT7D21Fz+n1VW7qqQ1e0XSU2jtDIgpgBzbNR/rWF4ooz4RmMeDQgd
         W79WZKzS1MbMQww4w2VBtcaPqQhzbX01OXEBFtLqKHszqGSu7S2Nnp+1+VXPJUDxIjul
         jIHSNHn/iNAaNQdIg1vS/j1j8kzwVIvlg7QB/5qOhRY2cLqrirJF2v0v8bn7DYyWVtxQ
         NvyjIEHOyeglNrSqWrbsNv8MQhMLIOw9u57NzpFbVD5WgSoX5MklcqV8wMVKxRHYbiZS
         HYwjcSwtOGy9v1dSYhfGajYKYLcmWVWGcfiptwr3CnIS16BGjN85W3p4LyUG4cN0hAGV
         sS4A==
X-Forwarded-Encrypted: i=1; AJvYcCVhSFgjolZHEPqGxWNQtcNkSTLx9xnbmVdv2hcluaO1254R7WJ8dxAg0Cky26P8EWmdOlI+1iajmtu0pUbx@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzHhHlS7cignFPnb9+PQvSq4zqLEz0F1W32iXWIs3yXqZW6ua
	0Nw3MZBYhg3wnvX8wMstomc7wwQLGibZEqLr2V4Bq87/8SjyNZlHudv1bztnReU=
X-Google-Smtp-Source: AGHT+IFu5KZqvebb/Rgm2t93l+uZ71HKcObnBSTt523ilS4l+nccDCBApQWByso4xCKbk6PBDWSSKg==
X-Received: by 2002:a05:600c:3c93:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-42bb02c1d88mr16490455e9.7.1724929734254;
        Thu, 29 Aug 2024 04:08:54 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e109sm1108794f8f.67.2024.08.29.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:08:54 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:08:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtBWxWunhXTh0bhS@tiehlicka>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>

On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
[...]
> > > It was decided _years_ ago that PF_MEMALLOC flags were how this was
> > > going to be addressed.
> > 
> > Nope! It has been decided that _some_ gfp flags are acceptable to be used
> > by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
> > modifiers and other flags so these are indeed safe to be used that way.
> 
> Decided by who?

Decides semantic of respective GFP flags and their compatibility with
others that could be nested in the scope.

Zone modifiers __GFP_DMA, __GFP_HIGHMEM, __GFP_DMA32 and __GFP_MOVABLE
would allow only __GFP_DMA to have scoped semantic because it is the
most restrictive of all of them (i.e. __GFP_DMA32 can be served from
__GFP_DMA but not other way around) but nobody really requested that.

__GFP_RECLAIMABLE is slab allocator specific and nested allocations
cannot be assumed they have shrinkers so this cannot really have scoped
semantic.

__GFP_WRITE only implies node spreading. Likely OK for scope interface,
nobody requested that.

__GFP_HARDWALL only to be used for user space allocations. Wouldn't break
anything if it had scoped interface but nobody requested that.

__GFP_THISNODE only to be used by allocators internally to define NUMA
placement strategy. Not safe for scoped interface as it changes the
failure semantic

__GFP_ACCOUNT defines memcg accounting. Generally usable from user
context and safe for scope interface in that context as it doesn't
change the failure nor reclaim semantic

__GFP_NO_OBJ_EXT internal flag not to be used outside of mm.

__GFP_HIGH gives access to memory reserves. It could be used for scope
interface but nobody requested that.

__GFP_MEMALLOC - already has a scope interface PF_MEMALLOC. This is not
really great though because it grants unbounded access to memory
reserves and that means that it isreally tricky to see how many
allocations really can use reserves. It has been added because swap over
NFS had to guarantee forward progress and networking layer was not
prepared for that. Fundamentally this doesn't change the allocation nor
reclaim semantic so it is safe for a scope API.

__GFP_NOMEMALLOC used to override PF_MEMALLOC so a scoped interface
doesn't make much sense

__GFP_IO already has scope interface to drop this flag. It is safe
because it doesn't change failure semantic and it makes the reclaim
context more constrained so it is compatible with other reclaim
modifiers. Contrary it would be unsafe to have a scope interface to add
this flag because all GFP_NOIO nested allocations could deadlock

__GFP_FS. Similar to __GFP_IO.

__GFP_DIRECT_RECLAIM allows allocation to sleep. Scoped interface to set
the flag is unsafe for any nested GFP_NOWAIT/GFP_ATOMIC requests which
might be called from withing atomic contexts. Scope interface to clear
the flag is unsafe for scoped interface because __GFP_NOFAIL
allocation mode doesn't support requests without this flag so any nested
NOFAIL allocation would break and see unexpected and potentially
unhandled failure mode.

__GFP_KSWAPD_RECLAIM controls whether kswapd is woken up. Doesn't change
the failure nor direct reclaim behavior. Scoped interface to set the
flag seems rather pointless and one to clear the bit dangerous because
it could put MM into unbalanced state as kswapd wouldn't wake up.

__GFP_RETRY_MAYFAIL - changes the failure mode so it is fundamentally
incompatible with nested __GFP_NOFAIL allocations. Scoped interface to
clear the flag would be safe but probably pointless.

__GFP_NORETRY - same as above

__GFP_NOFAIL - incompatible with any nested GFP_NOWAIT/GFP_ATOMIC
allocations. One could argue that those are fine to see allocation
failure so this will not create any unexpected failure mode which is a
fair argument but what would be the actual usecase for setting all
nested allocations to NOFAIL mode when they likely have a failure mode?
Interface to clear the flag for the scope would be unsafe because all
nested NOFAIL allocations would get an unexpected failure mode.

__GFP_NOWARN safe to have scope interface both to set and clear the
flag. 

__GFP_COMP only to be used for high order allocations and changes the
tail pages tracking which would break any nested high order
request without the flag. So unsafe for the scope interface both to set
and clear the flag.

__GFP_ZERO changes the initialization and safe for scope interface. We
even have a global switch to do that for all allocations init_on_alloc

__GFP_NOLOCKDEP disables lockdep reclaim recursion detection. Safe for
scope interface AFAICS.

-- 
Michal Hocko
SUSE Labs

