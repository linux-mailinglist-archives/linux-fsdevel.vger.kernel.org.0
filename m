Return-Path: <linux-fsdevel+bounces-38350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23270A001BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 00:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529A33A53A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D41C5F33;
	Thu,  2 Jan 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uttgSEl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B591CC8A7;
	Thu,  2 Jan 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860338; cv=none; b=h94Q1moH/xna+D1QbQWUn5opdPkwr3aQMRo0FLbaTPY03J+9AS6PIadzKpJuxUbjn1UECx2I/grt3qpn5J1QXjmWm45QaLaBBB0AZMSG7YljOU9bjkYJdo/nwdZWoWE1K2Gi0qaQElAVtfN+2Xa/Mthc7CwFk76ZxtGG/j2LYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860338; c=relaxed/simple;
	bh=mX7FJpx4118ooaZkB/8HWQSJOOPye7uU6pAwUySw0ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEScSvVm4y8ZxNOgvVg5ZgiRGKS2guzx3qTJQtavhNLodrXQLLsKVktTwNZCexajalQOOyjB7aBxg8ZcGzbW817mEgGvUICJIdILjKN+YqpjRJEaarvgpIkuXJHg+G+26hdA0GwdrYvtTcYtdJTDGqcjzXbumIWx652ruL5tWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uttgSEl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0325C4CED7;
	Thu,  2 Jan 2025 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735860338;
	bh=mX7FJpx4118ooaZkB/8HWQSJOOPye7uU6pAwUySw0ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uttgSEl7WvTBTYvBOym5lnIvpwq8txSb23qqFP27KtrOUAanmgGQ004iJ6FfHDtiM
	 0HD1sZbdxJ1CjrVZJAk3hX0kmJpVSYUJWKvUlgIh/pIzXsdOLEnXSj0XocPnFxSLFC
	 2w2ZnazfF61HEAyhIaGtJUglqSUU/5ytT9jA9FbMWljXfSX/r2Sme53K8Gm25wGDKZ
	 p+PhosAjMCdJ6mi9wzLUSEBkMVFqhDm/Syc5n7SHg0DCE77CQBEDBWfEmCA8zZB0GT
	 SqWGh/G3pPbtNNerhevUszf9B/G3jHro6J6GusdFeJxkFKp1fSRlObgBRUCknxnnsy
	 rAnCT/TwJzsog==
Date: Thu, 2 Jan 2025 15:25:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Nelissen <marco.nelissen@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] filemap: avoid truncating 64-bit offset to 32 bits
Message-ID: <20250102232536.GW6174@frogsfrogsfrogs>
References: <20250102190540.1356838-1-marco.nelissen@gmail.com>
 <20250102141015.bc8ef069a91cfd9664538494@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102141015.bc8ef069a91cfd9664538494@linux-foundation.org>

On Thu, Jan 02, 2025 at 02:10:15PM -0800, Andrew Morton wrote:
> On Thu,  2 Jan 2025 11:04:11 -0800 Marco Nelissen <marco.nelissen@gmail.com> wrote:
> 
> > on 32-bit kernels, folio_seek_hole_data() was inadvertently truncating a
> > 64-bit value to 32 bits, leading to a possible infinite loop when writing
> > to an xfs filesystem.
> > 
> > ...
> >
> > +++ b/mm/filemap.c
> > @@ -3005,7 +3005,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
> >  		if (ops->is_partially_uptodate(folio, offset, bsz) ==
> >  							seek_data)
> >  			break;
> > -		start = (start + bsz) & ~(bsz - 1);
> > +		start = (start + bsz) & ~((u64)bsz - 1);
> >  		offset += bsz;
> >  	} while (offset < folio_size(folio));
> >  unlock:
> 
> Thanks.  I'll add
> 
> Fixes: 54fa39ac2e00b ("iomap: use mapping_seek_hole_data")
> Cc: <stable@vger.kernel.org>
> 
> The
> 
> 	offset = offset_in_folio(folio, start) & ~(bsz - 1);
> 
> a few lines earlier is worrisome.  I wonder if we should simply make
> `bsz' and `offset' have type u64 and sleep well at night.

I think that callsite is ok because offset_in_folio() should never
return a value larger than 2^31 ... right?  IOWs, only the second case
needs casting because @start is loff_t.

--D

