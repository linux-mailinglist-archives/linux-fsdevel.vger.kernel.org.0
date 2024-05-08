Return-Path: <linux-fsdevel+bounces-18981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE58BF3E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC80285E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82CEC4;
	Wed,  8 May 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hYozxBpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B141399
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129965; cv=none; b=gcAyYOF/iJpVv2NhSBFn2g2YZfJ9zi0nNgGg0XAim3ak/Kv6ZAt4S+OoE8X4x5ytp5Jesm/U0HvEVStTtnlUGVcKESymYMhw0/d9Y4ilEIRglcDIiiFPeHBwYEPC/rbOMKLcWGdt+4GctxozSUC/poCKux9cjZLDRQj1pKx/h1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129965; c=relaxed/simple;
	bh=HPKo0kjA4VMAEdS3jgdkrkVKvRNlcwe01fWxC6/gNfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkeWsIJI5hkrBfExuybShANYRVEVflAHECaspfA+szTvfm0NZqLH5pslanZE7drjuoehbgvjlWGG7tqk3P162fnFTsHHKADp3eTa2NaSqmVWBHVU3dz7ju+QdVBMCGvzCsnQUo5J/c95gG2zLa228arv32riEJxOUSn4PfHq4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYozxBpU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 20:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715129960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CKJj04qCaWozA5OZiCOs2YLUCi6uSucwcFVp9F+GYz0=;
	b=hYozxBpUi13Ihp6MHSC3zJItNcCVYBGiy5gWX8Cs0A6y+Himp+jshK97g07kCOl3TFq88i
	Zt4sN7Z/Mdhg79dg+hAEgGzsQHKwbgZ8KNdJh1Vy9rVJwc1MZRjoKopdTONURw2+FmmZKI
	m2QLFJSDTFZEtSm+HF1ArKHYMD8FvDs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <7chwa5h2y2eotafxfnapxn754n7y3zpze2sm5dif3zyx7hkxcc@2zu6pskc7fbo>
References: <x73mcz4gjzdmwlynj426sq34zj232wr2z2xjbjc4tkcdbfpegb@hr55sh6pn7ol>
 <tencent_6086EB12C2C654899D6EE16EF28C8727EC06@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6086EB12C2C654899D6EE16EF28C8727EC06@qq.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 08:49:39AM +0800, Edward Adam Davis wrote:
> On Tue, 7 May 2024 10:14:22 -0400, Kent Overstreet wrote:
> > > When got too small clean field, entry will never equal vstruct_end(&clean->field),
> > > the dead loop resulted in out of bounds access.
> > >
> > > Fixes: 12bf93a429c9 ("bcachefs: Add .to_text() methods for all superblock sections")
> > > Fixes: a37ad1a3aba9 ("bcachefs: sb-clean.c")
> > > Reported-and-tested-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > 
> > I've already got a patch up for this - the validation was missing as
> > well.
> > 
> > commit f39055220f6f98a180e3503fe05bbf9921c425c8
> > Author: Kent Overstreet <kent.overstreet@linux.dev>
> > Date:   Sun May 5 22:28:00 2024 -0400
> > 
> >     bcachefs: Add missing validation for superblock section clean
> > 
> >     We were forgetting to check for jset entries that overrun the end of the
> >     section - both in validate and to_text(); to_text() needs to be safe for
> >     types that fail to validate.
> > 
> >     Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
> >     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> > index 35ca3f138de6..194e55b11137 100644
> > --- a/fs/bcachefs/sb-clean.c
> > +++ b/fs/bcachefs/sb-clean.c
> > @@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
> >  		return -BCH_ERR_invalid_sb_clean;
> >  	}
> > 
> > +	for (struct jset_entry *entry = clean->start;
> > +	     entry != vstruct_end(&clean->field);
> > +	     entry = vstruct_next(entry)) {
> > +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
> > +			prt_str(err, "entry type ");
> > +			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
> > +			prt_str(err, " overruns end of section");
> > +			return -BCH_ERR_invalid_sb_clean;
> > +		}
> > +	}
> > +
> The original judgment here is sufficient, there is no need to add this section of inspection.

No, we need to be able to print things that failed to validate so that
we see what went wrong.

