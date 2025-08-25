Return-Path: <linux-fsdevel+bounces-59068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F5B340C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060333AE668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D860611E;
	Mon, 25 Aug 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Rp3+/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA533393DD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128727; cv=none; b=k/C0XPFB3/gHlM6hNy+LSrsJP5PgiKBmPKbnpiQk/dKopf2QVx/e0ZAetpuz+8ImlccxKBy98lExPi/JkRmsFS+oXM3kGfbfOuRAZ1dIf6iEkYQtSq+J7Tg7dYJCC0FTQcyk4QToQvR4OYZk/ppUuKrSnxoo8mijpgDmqb/C5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128727; c=relaxed/simple;
	bh=zlp3BwNqrSwMD875NSwFN4Q46CPoHNXj8y8EWNljlAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omwwzkK7ZgWkpyicJY3J5tmRCT9usXgb/jWMhWPU/HP4KgY+Y8KeEcbA/a62r3+NzFscAj4O3y2h26iHFMND/ir77tHWw3M2zL2KuxYK2D+JV5oN8JiHlj4hz30GmRF4kKRWeNz1j7gCyiY24E65q4rB+4adoavzf6DT8HE0SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Rp3+/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADBEC4CEED;
	Mon, 25 Aug 2025 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128727;
	bh=zlp3BwNqrSwMD875NSwFN4Q46CPoHNXj8y8EWNljlAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2Rp3+/Z2Hrr1evQr4DDHqpcfrfmKrfGkOXbkEn02w4W8w9+XFWX+YpJKav+5GbJz
	 lqlpyVodJ3q8HQ20MfTMBtlshtskjrXYdSeHhlxPw8gy09aBvpIXlAXSGsiByb1JY5
	 xA7/mYw1ViVWl91YmeEqQeGeN2352x9i62M90omMNAGBprdqsL0C8WL1i1qv7xj7vc
	 RMwx+yCQhy+Namd5aOae+/0Rcls7WaM0up5IKheGYeoe9CXyYIo/jrf+W4rSsaPSrz
	 QHmSF1KPoKcx/5211thfN7cTMRMQvTPjKmHdb9OgOVnyBgJQWf9jf6QMZQ02CsG7um
	 HaqmHm0X4RIfA==
Date: Mon, 25 Aug 2025 15:32:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 44/52] path_mount(): constify struct path argument
Message-ID: <20250825-holunder-befinden-8184c94d4201@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-44-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-44-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:47AM +0100, Al Viro wrote:
> now it finally can be done.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

