Return-Path: <linux-fsdevel+bounces-45690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD4A7AFB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 22:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6FF4409B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2BE266569;
	Thu,  3 Apr 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abD0OX1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0963253F24;
	Thu,  3 Apr 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708823; cv=none; b=OppHiNZ6qdIBOCizW+VxhNhTfL2G4xiNsdWYxn5WQkrDLkzboKoyp7xzWwlEm2tUZALIy1BLhef2odTGWVDksNQ9DQntuT78z0c5ZbZOfz0MZaK0vhBQC5yeAlO0GpvA0p64UkA5kND/4+8GwBW/8ue1xmerxcITUIcyH2BElMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708823; c=relaxed/simple;
	bh=wAXRn9yzJMIqnspk40RHmhT1W8V47pEbNLicMxRvDzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DywK536fFMpk+Xlb6iPvxYByW/DYC8Aepkf0jamDA+XsLXmEOXWEtCoy2mMiaXpv2h66qW/E2M+TEdi/UZjY6X3ZnWI+YYsvg2roZhqAUx3vvKw+Gf+hmGZbN3DZa826QKBq9i096BltQRpSqP4K+wzNJ1pV3JpxRie9mWMrCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abD0OX1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C8C4CEE3;
	Thu,  3 Apr 2025 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708823;
	bh=wAXRn9yzJMIqnspk40RHmhT1W8V47pEbNLicMxRvDzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abD0OX1/JRVXeua20p28B8YfKIiRqsH7xmnkGPA4IGi5Ck+LhawMGpXU8yd2RlsmI
	 +EwYQWBqjsucQi+KxBoaQepInKmhW71O+2jsX1VMruwVNxHoa1n/T5uu4C8qGb1EQ2
	 JsWQYc92qX9S5rQM2MVDEYjfsdXI3NQCnOOpaDAt4PZsmLouKZrbjV5FJjiy8nc5TI
	 /gqOnx3O37vCCyjr+mrlNfEkOieUcsGlKBPdgiZPnMBdcJFfTX8Mv9Jvxfc9Ktb6LJ
	 QdDA5/uvlcdjUoPyhWGP0N8WatJsQuBlWbr/kqna6aLkqVTmsL/j2RNRhTDHtPHP2r
	 2/kqlr9S+b0Dw==
Date: Thu, 3 Apr 2025 21:33:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 1/4] fs: add owner of freeze/thaw
Message-ID: <20250403-behielt-erhaben-c228a6958d11@brauner>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-1-6719a97b52ac@kernel.org>
 <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>

On Thu, Apr 03, 2025 at 04:56:57PM +0200, Jan Kara wrote:
> On Wed 02-04-25 16:07:31, Christian Brauner wrote:
> > For some kernel subsystems it is paramount that they are guaranteed that
> > they are the owner of the freeze to avoid any risk of deadlocks. This is
> > the case for the power subsystem. Enable it to recognize whether it did
> > actually freeze the filesystem.
> > 
> > If userspace has 10 filesystems and suspend/hibernate manges to freeze 5
> > and then fails on the 6th for whatever odd reason (current or future)
> > then power needs to undo the freeze of the first 5 filesystems. It can't
> > just walk the list again because while it's unlikely that a new
> > filesystem got added in the meantime it still cannot tell which
> > filesystems the power subsystem actually managed to get a freeze
> > reference count on that needs to be dropped during thaw.
> > 
> > There's various ways out of this ugliness. For example, record the
> > filesystems the power subsystem managed to freeze on a temporary list in
> > the callbacks and then walk that list backwards during thaw to undo the
> > freezing or make sure that the power subsystem just actually exclusively
> > freezes things it can freeze and marking such filesystems as being owned
> > by power for the duration of the suspend or resume cycle. I opted for
> > the latter as that seemed the clean thing to do even if it means more
> > code changes.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I have realized a slight catch with this approach that if hibernation races
> with filesystem freezing (e.g. DM reconfiguration), then hibernation need
> not freeze a filesystem because it's already frozen but userspace may thaw
> the filesystem before hibernation actually happens (relatively harmless).
> If the race happens the other way around, DM reconfiguration may
> unexpectedly fail with EBUSY (rather unexpected). So somehow tracking which
> fs was frozen by suspend while properly nesting with other freeze users may
> be actually a better approach (maybe just a sb flag even though it's
> somewhat hacky?).

The approach that I originally had was to add FREEZE_POWER which adds a
simple boolean into the sb_writers instead of a holder and then this
simply nests with the rest. I'll try to post that diff tomorrow.

