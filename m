Return-Path: <linux-fsdevel+bounces-905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3047D2B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E811F219B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF6101F9;
	Mon, 23 Oct 2023 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sle7RCHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D123C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF370C433C7;
	Mon, 23 Oct 2023 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698046848;
	bh=vl5IqJfYY0jJ1CcjrEpy7MG/QZ6KbXPIQ4FLKA5G/Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sle7RCHjdYeHOPJ2T85/nmwJaD4RqMQ7R4/njEh6sUOblGyl0zWPckj0y/Irw6tC8
	 vu1nmSiWH+xEFMm6FSRo6SZe3YcVZUQM0EsKEcyG6sxzQpeHnKiKLZu823U9HrlYMw
	 S+crnNBUnnLxjqASSPm38/fPrsGwsid3hV/xtQ19u1/XqpSjxGNgZe6PzlJ7PeSU+f
	 AUL1SHcO2gxjkRCiaszcaPo0Nj3a98ePl1W1TAGfQlamiwPtEuqw4sF1Dg6ahNum0f
	 3uALvpoAi9HK2oygsqxlxfpI/48zucTFIR7X57uip3fsnEOPCMxcIQm1lcVSW/2rg9
	 U2BqJ3kcaue/A==
Date: Mon, 23 Oct 2023 09:40:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231023-ausgraben-berichten-d747aa50d876@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020120436.jgxdlawibpfuprnz@quack3>

> I agree that it breaks the original usecase for LOOP_CHANGE_FD. I'd say it
> also shows nobody is likely using LOOP_CHANGE_FD anymore. Maybe time to try
> deprecating it?

Yeah, why don't we try that. In it's current form the concept isn't very
useful and arguably is broken which no one has really noticed for years.

* codesearch.debian.net has zero users
* codesearch on github has zero users
* cs.android.com has zero users

Only definitions, strace, ltp, and stress-ng that sort of test this
functionality. I say we try to deprecate this.

