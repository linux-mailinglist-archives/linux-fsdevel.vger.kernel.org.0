Return-Path: <linux-fsdevel+bounces-25785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A495057B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755FF1C22556
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580D199EAD;
	Tue, 13 Aug 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfdcpb8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6219923D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553222; cv=none; b=jdDp9X7wlloXNF6ScEdeVvmOFcp+ujXYLwxOv8dKEYElSelv+SOn/z0WOM+C+BQZiFmyVfR0AmwXLk9mF9ZRsXSmRvFbIcV9a23WZ72dX6XTX5n20LBmiQQ8Ep+5CrCJ7AxfvTqp3jSFaB1r2xiKy6nGlu7lV6FHtfi9FYfLkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553222; c=relaxed/simple;
	bh=UbwzppsBLdA3jcSIDrJIE6hxFhyy6JcX2aeZJcxgFbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBf9KvlzZXR1621D2iZDEyFRG5K+yRTBeU1xQeGYxKGmeh2HMi5hq1fjQaFzTd2Rs3W0xI8OOgcmmVoVyoev1zOB7SoAh87U5iKBcFIKybxZl5VW97UoxENdIZA4ihMXfltV8FDdLcjXTI7RH0pbaYy8nGmeJxySDQLMuSCDjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfdcpb8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A4C4AF0B;
	Tue, 13 Aug 2024 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723553221;
	bh=UbwzppsBLdA3jcSIDrJIE6hxFhyy6JcX2aeZJcxgFbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sfdcpb8yh6jhYajoiQRUnRtcKIWgMzihuJ1IKO/+Sj8Dtwri4lRJgEbhXjSgaAvgV
	 cmLVpbMreDL2zRlu+Fp4mkCt8pzZHGN5sCOXTe/A643CBKLPYnw6YXVSsP9id5+fI7
	 0NKweaOjitcVnTwfb+fDWOEeclaxI7De0fRXMulAW1oGkvIQWDFjJFsjUKg5QeaTH1
	 DUvV4poZxjaSMa9oyhe/mfOv9xGIKdguy221aqlMgwypSXA2sQeo1XQFKQYREm2Meg
	 vPbQ5gPWQQqwhwRbbHsPum+QkGeyZer9FRY7JCdB5SS+TV6HEmmmk4AGnPKmg52mJD
	 3eudElUnUMgrA==
Date: Tue, 13 Aug 2024 14:46:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <20240813-inhalieren-gravierend-72a4de93a08d@brauner>
References: <20240807180706.30713-1-jack@suse.cz>
 <ZrQA2/fkHdSReAcv@dread.disaster.area>
 <20240808143222.4m56qw5jujorqrfv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808143222.4m56qw5jujorqrfv@quack3>

> things like ->remount_fs or ->put_super. So avoiding IO from operations
> like these would rely on fs implementation anyway.

I think that needs to remain filesystem specific and I don't think this
needs to hold up the patchset.

> Right, -EROFS isn't really good return value when we refuse also reads. I
> think -EIO is fine. -ESHUTDOWN would be ok but the standard message ("Cannot
> send after transport endpoint shutdown") whould be IMO confusing to users.
> I was also thinking about -EFSCORRUPTED (alias -EUCLEAN) which already has
> some precedens in the filesystem space but -EIO is probably better.

EIO isn't great but I agree that it's the best we probably have for now.

