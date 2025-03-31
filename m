Return-Path: <linux-fsdevel+bounces-45328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D6A7641D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432297A3B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A81DF987;
	Mon, 31 Mar 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAivgiKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25041DF244;
	Mon, 31 Mar 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416741; cv=none; b=cbUoh5/2970FQzf3OTcI3gOiEZSeY53cipbpyt4ZDVhthGwklOdMsUPV68oooMrzfmQ2zWbXQuHRhWViFqvDYhgwUfV4FMFAUtu91wMNm96UMQ21TWbiooiMxm1WELvboE5AYlzK3pkwlI7E89jddlWgs4PIBlrzp7/+dUlhXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416741; c=relaxed/simple;
	bh=mmOyZTYzFrsIc3BpeorotLXoS3/nnmtIz+2gGycd45w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVThJrGoRZrTlWU6wZjjj3EtOiWGWlO1/LOVL9zdCVL0Fztk+eoskRuIztI/N2GwnWeducgUjwr3x/4KJWXhn+jI9n4J9Cf34RC8TJpXaGpRReeS1Js/zg6Vl6sd5ytdT+BKP8bz4foFTNufYgR31sihZnscoMBQIj89Xer84HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAivgiKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF588C4CEE3;
	Mon, 31 Mar 2025 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416741;
	bh=mmOyZTYzFrsIc3BpeorotLXoS3/nnmtIz+2gGycd45w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAivgiKttyt/D0UZhjMbl6KA50ZzDbqyKboVcSsVGQS0T1Z8dAZbKwNa4lC0hkKml
	 P4nitoKBL6RcfdH92bLNtijTiKMyyPLEi8XE+5+Cn05GQraNOLxoPUOSPINkXmZEHD
	 dPmxi5wK/hF0rUWTFIYe++Q3gwuLvP9uLW/oKqYto2apDRcHrCQIDIi7o8E/fWQzDe
	 u4/2duWKn+JzF+wboJJ1+YpgjRLBolqUcvsmCz6MBZx+Rzc4dPhOe/CFPSSt0C4UKd
	 0Ljxth/ew9C/jmMoOH95DLbMlZQ6JY6e0MHQpM1qnU268hlAZo9vGf8GScBc2G432c
	 rWsEtnmlVYnyw==
Date: Mon, 31 Mar 2025 12:25:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 6/6] super: add filesystem freezing helpers for
 suspend and hibernate
Message-ID: <20250331-postfach-suchaktion-b7f7c696b632@brauner>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>
 <k2xbbfnkklbndjbrrnp5lpyrajp3uuw4oxe6xksbtskb2p4myy@o4ypfbabhuu5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <k2xbbfnkklbndjbrrnp5lpyrajp3uuw4oxe6xksbtskb2p4myy@o4ypfbabhuu5>

On Mon, Mar 31, 2025 at 12:23:04PM +0200, Jan Kara wrote:
> On Sat 29-03-25 09:42:19, Christian Brauner wrote:
> > Allow the power subsystem to support filesystem freeze for
> > suspend and hibernate.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One comment below. Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > +void filesystems_thaw(bool hibernate)
> > +{
> > +	__iterate_supers(filesystems_thaw_callback, NULL,
> > +			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
> > +}
> 
> I think we should thaw in normal superblock order, not in reverse one? To
> thaw the bottommost filesystem first? The filesystem thaw callback can
> write to the underlying device and this could cause deadlocks...

Yep, I've fixed that already up in vfs-6.16.super yesterday.
Sorry, forgot to mention that here. Thanks for noticing!

