Return-Path: <linux-fsdevel+bounces-27633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6729630EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFBB225D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399C1ABEAA;
	Wed, 28 Aug 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SOek8DVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8E1A76CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873210; cv=none; b=DwToSVyq1RPN0oXT77MUXFxXCT5c7wIPEO716bHIoe5E/C4rf6xaQ8nFuKavynjHNUfaXVlhkDwgog3+ICkiK1UhjdW+cIzGPW2Ue9WgJ1Dn34qovdiw2Jqaqjd++GMXr35nPyNPewHFzA7rRoingEk42hjgkAay0CBo6uRVI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873210; c=relaxed/simple;
	bh=7xf1I7u+DLd4YcPjBzGWhhwMtUyUjBReXr2LDbueJZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Crp3w4GdWcC7SwfnURE8NK6694BAaI7atva09vr+DcxJAd2OXJU3PCdmPROVTNKRURRkejVAA0HP2OVn+cNbu2vMMuuJJSt/Qnb/Z5wn2eSRtKKtRn7BtWxSgTNJsD4xFUZvSib6zml6LS3J9ZnVkKegwCtkI+/XciFlHDvM9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SOek8DVw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so4521524f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724873206; x=1725478006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BWPnH/8lZG8VOT7Muu9Q8tFJ7+yTh7np+tLLr9rmZU=;
        b=SOek8DVwiQ9WHUS2cO8aZxyjRclaYaYSCftDCTcnP4cI/W21ntvqAdGaF0D3KKHgGY
         zpfSz0YdOyplsc9ZYoGxWubpAl7ZtlsD/NkowB2fEbPkXeqmSvaJ0oGO3ZI2RE2OVsoR
         87WwTZAtcbRLgHQB6ACgyFhRirWpeb5SD1iLDTQ4sE2DsXcoFip26KUEx5kZt/3Xsy7N
         pc7ogaBotWPSNFfsjz4DDezZtLYlbGIIIfk6Ibnc0xtHOLDx1r0QNHUC63vdQLMDYZn6
         zIMkOrEKkzOeSJaSu6w27PgosM/ClaFJSBMjDbu6xF1bHBShLCSrbCJxvJ05msoDKfoR
         X/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873206; x=1725478006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BWPnH/8lZG8VOT7Muu9Q8tFJ7+yTh7np+tLLr9rmZU=;
        b=SXQUox0ONgImTkBjI/t9ig++rKD9CoBSCE9lY6V6HeyQwAAWS7goLn+KWpnG5NM5rE
         lLXVjfFVxI8lZz6vaFn25pN1i1wZNS5Pn06RNcg8nlVJVffyuX134aoSpbqyE1PhMNbt
         LZht8Pz1q+YVvvP+KuERq7LkVnDwTxQUkK6MkNwIdk5S6IwS85x8jPvStvUlj4eBliOO
         IX2/7LwkcXcEsqswZBxYKbHgdtkETThtKkXXp+PlkOTRGgC7Ro2zx0I5NB8j0lR/UVZS
         nBh9414J1fottRQjZbQdDlTsvnTXFHoT7CSuBjpqSrvQ3+K01mP1LJU4gRL9En+k1slD
         kHEg==
X-Forwarded-Encrypted: i=1; AJvYcCWcwZEX8dJLsUn13kahJah2WL+d+yOp5eR5L63zereXEJjR2iiYl2vKG04XBTRNPnYMb0QL3IODCs1YdjvC@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUiDMs/4H1H6NoUubKTmBLACUYSrpNVrxLPBkI0AHam4YnEsj
	RSNFhAP4Y73PhXatGjyUbc2uj4KMyiaGweTQhad7U1DXnUP9sbq8ow2NBzwDyTM=
X-Google-Smtp-Source: AGHT+IGSdX36+aZ+9SeTj1XTGLTshw7rKy42yJjltzlpBmSmdNx5/FIzbRURRgjLzDSYixg0ss1fwA==
X-Received: by 2002:a5d:6652:0:b0:367:4383:d9b4 with SMTP id ffacd0b85a97d-3749b58f28emr314412f8f.56.1724873205639;
        Wed, 28 Aug 2024 12:26:45 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cf50sm278878966b.79.2024.08.28.12.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:26:45 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:26:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <Zs959Pa5H5WeY5_i@tiehlicka>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>

On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> > On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > > unsafe locks is a potential deadlock.
> > 
> > Kent, the approach you've taken with this was NACKed.  You merged it
> > anyway (!).  Now you're spreading this crap further, presumably in an effort
> > to make it harder to remove.
> 
> Excuse me? This is fixing a real issue which has been known for years.

If you mean a lack of GFP_NOWAIT support in vmalloc then this is not a
bug but a lack of feature. vmalloc has never promissed to support this
allocation mode and a scoped gfp flag will not magically make it work
because there is a sleeping lock involved in an allocation path in some
cases.

If you really need this feature to be added then you should clearly
describe your usecase and listen to people who are familiar with the
vmalloc internals rather than heavily pushing your direction which
doesn't work anyway.

> It was decided _years_ ago that PF_MEMALLOC flags were how this was
> going to be addressed.

Nope! It has been decided that _some_ gfp flags are acceptable to be used
by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
modifiers and other flags so these are indeed safe to be used that way.

> > Stop it.  Work with us to come up with an acceptable approach.  I
> > think there is one that will work, but you need to listen to the people
> > who're giving you feedback because Linux is too big of a code-base for
> > you to understand everything.
> 
> No, you guys need to stop pushing broken shit.

This is not the way to work with other people. Seriously!

-- 
Michal Hocko
SUSE Labs

