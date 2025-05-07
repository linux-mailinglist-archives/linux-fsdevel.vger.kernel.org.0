Return-Path: <linux-fsdevel+bounces-48393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB3AAE3BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FADB7A89AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC37289835;
	Wed,  7 May 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlLyWyhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA832186E2E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630155; cv=none; b=B53rCLe1dPod/XFKoy8frWNKtua7gEXefKuUmgCWF+SAdRdxRd+Cur5lH03IpjqaKsfSeRhvrg2F+RNf8UwuaQI1G/pm4LqN49Y4OOF8e2/P4jgLySluh6qnYLoJeKyux3kk6IuKJbsC1IIb7glp99Db8rHT/933wHGeHOnSgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630155; c=relaxed/simple;
	bh=C3hKf6zUM2iwJaaEM6d5NG8bscA/uwedt9zyDhq/gJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRjfRB1VAQTkObwJ54Rn4KYisFAV3kn8yrFa6rAjWRthNIS2bIy7GTf8MDDkZb2NdS3p8l/w8QI2pQGHGGiILBo0moTR9/chuX2S8oWdUcIJZINjv4mIQB4zX3hvl7gSGQjW5oZkoQQ+cv9056HTfzJJ69VxRIFhhjiMpSUP5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlLyWyhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011D1C4CEE9;
	Wed,  7 May 2025 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746630155;
	bh=C3hKf6zUM2iwJaaEM6d5NG8bscA/uwedt9zyDhq/gJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlLyWyhOE4fynVjBjR2zDEybj3DpCrntBeIXcvoR2xm4KaD1PlMfZhWVkItO3EkDO
	 ikQHVIzEqHB30FW+t1XjBw/skBtFK7tnz8hh2wVeHbJwIC1STWLtf4+80kt0st+rhq
	 UuIm8pIpys9mhuxh90sSZe4uBcaB4cPc82WE5El5dff2Zy+YoXoRCvHVTEnURxxObp
	 BPnHC8EfG8zjcyd5dHEmSil7anV+GPNmRv5VQowT1fRdFzmiPHJewlgG62qRpfdGps
	 N7gTM8QJD1RHD1zb+jGltnXY6VwIbnv8E9AXhfH0yKM6HN8EEbThyfNn1HYm8zwQiE
	 m2V454mINaKfw==
Date: Wed, 7 May 2025 15:02:33 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH 2/7] f2fs: move the option parser into handle_mount_opt
Message-ID: <aBt2CVnq8LnrbMzn@google.com>
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-3-sandeen@redhat.com>
 <2e354373-9f00-4499-8812-bcb7f00a6dbc@kernel.org>
 <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>

On 05/07, Eric Sandeen wrote:
> On 5/7/25 6:26 AM, Chao Yu wrote:
> > On 4/20/25 23:25, Eric Sandeen wrote:
> >> From: Hongbo Li <lihongbo22@huawei.com>
> >>
> >> In handle_mount_opt, we use fs_parameter to parse each option.
> >> However we're still using the old API to get the options string.
> >> Using fsparams parse_options allows us to remove many of the Opt_
> >> enums, so remove them.
> >>
> >> The checkpoint disable cap (or percent) involves rather complex
> >> parsing; we retain the old match_table mechanism for this, which
> >> handles it well.
> >>
> >> There are some changes about parsing options:
> >>   1. For `active_logs`, `inline_xattr_size` and `fault_injection`,
> >>      we use s32 type according the internal structure to record the
> >>      option's value.
> > 
> > We'd better to use u32 type for these options, as they should never
> > be negative.
> > 
> > Can you please update based on below patch?
> > 
> > https://lore.kernel.org/linux-f2fs-devel/20250507112425.939246-1-chao@kernel.org
> 
> Hi Chao - I agree that that patch makes sense, but maybe there is a timing
> issue now? At the moment, there is a mix of signed and unsigned handling
> for these options. I agree that the conversion series probably should have
> left the parsing type as unsigned, but it was a mix internally, so it was
> difficult to know for sure.
> 
> For your patch above, if it is to stand alone or be merged first, it 
> should probably also change the current parsing to match_uint. (this would
> also make it backportable to -stable kernels, if you want to).
> 
> Otherwise, I would suggest that if it is merged after the mount API series,
> then your patch to clean up internal types could fix the (new mount API)
> parsing from %s to %u at the same time?

Yeah, agreed we'd better applying the type change later, once mount API is
successfully landed. Chao, let's keep checking any missing cases. :)

> 
> Happy to do it either way but your patch should probably be internally
> consistent, changing the parsing types at the same time.
> 
> (I suppose we could incorporate your patch into the mount API series too,
> though it'd be a little strange to have a minor bugfix like this buried
> in the series.)
> 
> Thanks,
> -Eric

