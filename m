Return-Path: <linux-fsdevel+bounces-48908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0CAB58BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E5C3A376F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68722BE0E2;
	Tue, 13 May 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMvVN74N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA228E616
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150582; cv=none; b=UU2T0BlSOKa+LD5s5ikvkTZXuIB4KJ5cDFmTKM3Efp2hc9K2k7pGjrKofFfYBCah6fa0O1tHpcb8o6tf6IRZl6y3LSKQyyh/EvypHiLfrJow2UjFXu8n0omFHEWTX8E8HsjR0wY7Ou4cC0qwUgfXooE4JhwDp2WDPg7IdCra2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150582; c=relaxed/simple;
	bh=h0SueSLRMRwCJxCC2plmOq+6rDfK1UJPAlE3HaRh1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg2wVxLueWTO50y6VGMG4KdpJm4xwmhqGcRVXr7BDXfugXc1I68+BNZrLo8H0OZ3UdgrZ95tGLlqeMIvLu4c+xdwqIUIvqYcvJowZM55BJxMo5+y4dCCJZeVgFAMEFAgW1VhvmXJs2jCewUXOp/UzZOKGPSKDwWEtdhe6UT9u7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMvVN74N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C53DC4CEE9;
	Tue, 13 May 2025 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747150581;
	bh=h0SueSLRMRwCJxCC2plmOq+6rDfK1UJPAlE3HaRh1B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMvVN74NU4eXkIncpamPk1rXO6UCCOOAE30o+R3Wr5hjj1UDJK3/PZT8I2LEFu8Az
	 28nFQDVOA8HYw1vXatKyFdf953ssP+jtDnzh8EqqSZLqVIRXyb65DaMyUg4F3+GlVv
	 hqd2ab+XZ4C3+XfR+i2BfQqSqIfmXSuYTwJuknSjMuTmUzYaGRB8Yflvy9pXKLZrZJ
	 mk6KKhIJgs3SOlP0g2lwaPLaIShq61fKf7jQXe8bQIkvNIYD/qVvq7RdjYUzW5+q56
	 gjT3iNtTOGPq6fxM6nw7EIjxukOKEAWb1uf/p4X+FJHkQY84EU984BGPV3bELdOMGd
	 V+D6V5YSd7fpQ==
Date: Tue, 13 May 2025 15:36:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>,
	linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
Message-ID: <aCNm858Rtt1ozdLp@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
 <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
 <74704f7c-135e-4614-b805-404da6195930@kernel.org>
 <3fe6be01-b9bf-4e26-b3f6-32dafe0a8162@redhat.com>
 <fb54f933-1669-4e89-8b85-9b88030a68d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb54f933-1669-4e89-8b85-9b88030a68d2@kernel.org>

On 05/13, Chao Yu wrote:
> On 5/13/25 10:19, Eric Sandeen wrote:
> > On 5/11/25 10:43 PM, Chao Yu wrote:
> >> On 5/8/25 23:59, Eric Sandeen wrote:
> >>> On 5/8/25 4:19 AM, Chao Yu wrote:
> >>>>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct
> >>>>> super_block *sb, int *flags, char *data)
> >>>>>
> >>>>> default_options(sbi, true);
> >>>>>
> >>>>> -	memset(&fc, 0, sizeof(fc)); -	memset(&ctx, 0, sizeof(ctx)); 
> >>>>> -	fc.fs_private = &ctx; -	fc.purpose =
> >>>>> FS_CONTEXT_FOR_RECONFIGURE; - -	/* parse mount options */ -
> >>>>> err = parse_options(&fc, data); -	if (err) -		goto
> >>>>> restore_opts;
> >>>> There is a retry flow during f2fs_fill_super(), I intenionally
> >>>> inject a fault into f2fs_fill_super() to trigger the retry flow,
> >>>> it turns out that mount option may be missed w/ below testcase:
> >>>
> >>> I never did understand that retry logic (introduced in ed2e621a95d
> >>> long ago). What errors does it expect to be able to retry, with
> >>> success?
> >>
> >> IIRC, it will retry mount if there is recovery failure due to
> >> inconsistent metadata.
> > 
> > Sure, I just wonder what would cause inconsistent metadata to become consistent
> > after 1 retry ...
> 
> I don't remember, Jaegeuk, do you remember?

I remember, if the roll-forward recovery ended up with an error, we had better
retry mount() as we may have some online fixes.

> 
> Thanks,
> 
> > 
> >>>
> >>> Anyway ...
> >>>
> >>> Can you show me (as a patch) exactly what you did to trigger the
> >>> retry, just so we are looking at the same thing?
> >>
> >> You can try this?
> > 
> > Ok, thanks!
> > -Eric
> > 
> >> --- fs/f2fs/super.c | 6 ++++++ 1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> >> 0ee783224953..10f0e66059f8 100644 --- a/fs/f2fs/super.c +++ b/fs/
> >> f2fs/super.c @@ -5066,6 +5066,12 @@ static int
> >> f2fs_fill_super(struct super_block *sb, struct fs_context *fc) goto
> >> reset_checkpoint; }
> >>
> >> +	if (retry_cnt) { +		err = -EIO; +		skip_recovery = true; +		goto
> >> free_meta; +	} + /* recover fsynced data */ if (!test_opt(sbi,
> >> DISABLE_ROLL_FORWARD) && !test_opt(sbi, NORECOVERY)) {
> > 

