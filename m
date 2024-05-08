Return-Path: <linux-fsdevel+bounces-18985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49408BF404
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634411F23B74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE046C13B;
	Wed,  8 May 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZzgEY+aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD5B647
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131284; cv=none; b=CGPxs2+I3j6Pxw8PBIEz1sQDARySbPr3QF11fvWn3Qu7fGJxjvd4lBytBial3gsoO/EnHjSgLnsXHmXSH6H7hz/n9HqlSQKbJiesGEqUR1/SUm6LvHQagvUb9gKHLcHrQN3qbnDL2hXPT/oUTySfW+dIRhZVf8Ek4pwqm5dbmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131284; c=relaxed/simple;
	bh=swmvHkWAt6mZSEzNdM50W50K8sKA0Y3zZvFwBOp25EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYPCKNiyCnOPYq2qUTh7qL8GU9EhQZ8hC8VrdbTHy/RjJim/BPn4FKqSYN+KOhYWjuhiBszwSwo5jiRqkmxSYmWX1v/NbynessIOnS5AINzPkxRo5QJ5F3PbD4ZkV92RTNgzGKVzuqbpYBVXhk7Y1WPQkxXT7FavyIA9800Sa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZzgEY+aj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 21:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715131280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omz2Z73asoBCYFW4lWbzGyZDJr0g0ILH5q94fOP8bB8=;
	b=ZzgEY+ajY/O6dd9ouTT8PqTLRZjQ6r4TGs7v5oyAmyIuV3YudOg9lxxadNV5uyJJH25EoV
	Unwm/9+JV+nf2VPBdA/jfGPvHPROxj4yYEEjWb4KD2M9YdI5dqargs8tdE3Y5mKfkaZwRK
	4X7AhvZscFOt5D8KBgbrasUaI+Rmpsc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <nq3ka3ovvksptfkl5c53c4yn54efhu6dtt356lrda2wg7xzwak@tutbtfe7eskb>
References: <7chwa5h2y2eotafxfnapxn754n7y3zpze2sm5dif3zyx7hkxcc@2zu6pskc7fbo>
 <tencent_CBBB5E331C9E521B014B6C1B9B2576BA8E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CBBB5E331C9E521B014B6C1B9B2576BA8E08@qq.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 09:11:37AM +0800, Edward Adam Davis wrote:
> On Tue, 7 May 2024 20:59:14 -0400, Kent Overstreet wrote:
> > > > diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> > > > index 35ca3f138de6..194e55b11137 100644
> > > > --- a/fs/bcachefs/sb-clean.c
> > > > +++ b/fs/bcachefs/sb-clean.c
> > > > @@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
> > > >  		return -BCH_ERR_invalid_sb_clean;
> > > >  	}
> > > > 
> > > > +	for (struct jset_entry *entry = clean->start;
> > > > +	     entry != vstruct_end(&clean->field);
> > > > +	     entry = vstruct_next(entry)) {
> > > > +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
> > > > +			prt_str(err, "entry type ");
> > > > +			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
> > > > +			prt_str(err, " overruns end of section");
> > > > +			return -BCH_ERR_invalid_sb_clean;
> > > > +		}
> > > > +	}
> > > > +
> > > The original judgment here is sufficient, there is no need to add this section of inspection.
> > 
> > No, we need to be able to print things that failed to validate so that
> > we see what went wrong.
> The follow check work fine, why add above check ?
>    1         if (vstruct_bytes(&clean->field) < sizeof(*clean)) {
>   268                 prt_printf(err, "wrong size (got %zu should be %zu)",
>     1                        vstruct_bytes(&clean->field), sizeof(*clean));
> 

You sure you're not inebriated?

