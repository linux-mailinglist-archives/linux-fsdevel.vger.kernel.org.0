Return-Path: <linux-fsdevel+bounces-41804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80499A3777A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C361892305
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED31A2645;
	Sun, 16 Feb 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONs+MOyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD418DF6B;
	Sun, 16 Feb 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737544; cv=none; b=tXMX+k68liBv7gzWEHUVYgE64VQxmB36CxUnV2iHGPMU6P0OJPSCkOWZ4c6MQCaRAYRU/qNmthxRVnjed0zF4EOWaDVA0Akx3ah2fA9O+zWYn08oYv6Jeo3GZ9RH/8gWtHSNoCwZjrcFewxvGHC30IyI4qT3uLSn9PkqjvzBce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737544; c=relaxed/simple;
	bh=lLOMxOiYOIGtxm5reeFBqz0MJz+ra15mQJeg/eHal4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrsnMiI8Jyzl3dvMWGqTwmSDJy4Pdza6y6y24A6IxMGxp5uxUT07kL2f8TjFrUf9GY3vlaLqGOH264RF4apQQ53WFzOwJBJDEANjf4iwxU9crydRdT+gu5yaN2oFzBESoL3AS4VlP3hPUFaZl55bJd90GWI5NyqIg1H//LM2upY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONs+MOyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8904C4CEDD;
	Sun, 16 Feb 2025 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739737543;
	bh=lLOMxOiYOIGtxm5reeFBqz0MJz+ra15mQJeg/eHal4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONs+MOynFGOcLgOOTTWEGGlPhzBsHihPgTcyNsjvyMtcyfv8QWYYNnFyeyURM06IV
	 6k5UsMB4745AMaGanYYsoGp6SbW6P4tQ4n8EeyUZllve9Icb5gm8WNMmtgpc+doCDe
	 +fssOR6GwY6U6lelRR0lTHiFp1RQZ3DNXQ/dE9TYaz9B5R4YkilwbKOeuKwMz5sRki
	 9TFgi0In8vXyJrH5SqGywoH+5ZQDxJ0H5BF50TEv9eIdCo7YqOGnpE/3Wnn1jdiI8S
	 +PDxRlV2137CurNYP/wS93uSZ5cP1Ed8KtkYVFv9liMikoMy55YpfQPQ62aqjBcJvv
	 Hu8VpzRTq7wWg==
Received: by pali.im (Postfix)
	id 12D217FD; Sun, 16 Feb 2025 21:25:32 +0100 (CET)
Date: Sun, 16 Feb 2025 21:25:31 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cifs: Implement FS_IOC_FS[GS]ETXATTR API for
 Windows attributes
Message-ID: <20250216202531.cmq6wuubmse5477v@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-5-pali@kernel.org>
 <CAOQ4uxg+DnrOPcGpgS3fO7t8BgabQGdfaCY9t2mMzTD7Ek+wEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg+DnrOPcGpgS3fO7t8BgabQGdfaCY9t2mMzTD7Ek+wEg@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 21:21:27 Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 5:42 PM Pali Rohár <pali@kernel.org> wrote:
> >
> 
> No empty commit message please

This is mean as RFC, not the final version, I just included the oneline
commit message.

