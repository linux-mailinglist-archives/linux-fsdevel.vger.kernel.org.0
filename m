Return-Path: <linux-fsdevel+bounces-58396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15637B2E10F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C27B19C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EA36CDEF;
	Wed, 20 Aug 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXqW1tdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB2182D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703773; cv=none; b=FxWlmMYthRqwUW4Qntongkgdk55TmiNLt7xBg/cBxyNbJyBV1NTFsNtbI8aMEmlIgIJNPygzUBbx55PDEBnMroeIdV6Gkp0yjCP4ZfI6n0xp2fC3IooBXV2N0qrjWqGMGjgPjjZqI9miLDJtXroBDGWIme9F5q63cdSC4dINmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703773; c=relaxed/simple;
	bh=vjaLecKQeLVOOj/T8Qnt6AQ78qapR5lb4Yc5btGYCCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfqUpJdDUsY68WV7/kO3hGKLmCp47yoE8IueJvjeowjVN8m1XsrLWBts8SQfoNaLUzkIuWr9G1fRgXS8KENu/BQm1jTMKMbutKu24dhJ91Qfy9CrT9caYzaq9ablLl/sBszJCr1R7ecnaF0tKv6oFLx+tsWHu45iAo7P5YLoIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXqW1tdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05143C4CEE7;
	Wed, 20 Aug 2025 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755703773;
	bh=vjaLecKQeLVOOj/T8Qnt6AQ78qapR5lb4Yc5btGYCCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXqW1tdcT2WYAmLdv92GDixjZSKvVJBsgFptvRux+apVGc2Qruy1EpEoiLHHDB9U+
	 SHSR0bKmS2v2+OF2qjlw7JWqQySiXDALPHxA3UJaE22AdIRXwVkYT/5oY8lZqMQ7Ds
	 eHs/0qmV5x97a2+UG3Le0KAhFAftsFVNSrTSvi6sGdEI0SBMNT/EP/AcAslO1xqG0y
	 iyvmeLC/mQdbkc7FBeOaHsYqesOQzKA4aCfQE5HRY+xBhcata1jGIEBPDMSwFkpF3W
	 Zy/6KeG13+UwZ5QOo7uhIpUKmu/ghQyCArG3fTD1FrRR5mQ2Z0zEeFqb3aMG0ecDm+
	 3vC0rlg6zzHEQ==
Date: Wed, 20 Aug 2025 08:29:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250820152932.GK7942@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs>
 <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs>
 <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
 <20250820150918.GK7981@frogsfrogsfrogs>
 <CAJfpegs6riQX+B43c7EgkRJBg01V_13yEyETj_qHRA2S0evNLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs6riQX+B43c7EgkRJBg01V_13yEyETj_qHRA2S0evNLQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 05:23:27PM +0200, Miklos Szeredi wrote:
> On Wed, 20 Aug 2025 at 17:09, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > > "If neither forcing nor forbidding sync, then statx shall always
> > > attempt to return attributes that are defined on that filesystem, but
> > > may return stale values."
> >
> > Where is that written?  I'd like to read the rest of it to clear my
> > head. :)
> 
> It's my summary of what you wrote as code.

Ahhh, thanks.

/me hands himself another cup of coffee. :P

--D

> Thanks,
> Miklos
> 

