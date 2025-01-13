Return-Path: <linux-fsdevel+bounces-39045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706AA0BA56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23F8160585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72023A107;
	Mon, 13 Jan 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXa8tFev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D423A0EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779738; cv=none; b=XGVNlqZRtHOp7DPgOidKkac6u9QNWhPZBAIoU8GXoSIXGHQ/hqc9ah9nz3RfwvftbM1aEKt/CevyJEi+vKdeBIdiLPJK77k29QG6F60GN+cXzcQP+80j/waiRYJ0R1jFwiYfsSsrSBu9R7w+SdoAt/0D+QC6ojRsS1iM+EJ7ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779738; c=relaxed/simple;
	bh=LUdy7xKIlQ+MQlj2iEmxIt3A9vUnwTyPV+ljWEuw468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4RQDe0iE++isXBgRKOkfjXqPFPbtyezer+oI9gdZQ+5KXBrekvOOnTStAAMzeBV361YQ8Jl7TBaAAJa0unXYbonHDEvHHUU25A05CDyuFZU2vkYWA42YDSq6ewk1mNLJKfm1pGwHzotyQRx3xdyCf+eYqCB1kfaSis4ycuW0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXa8tFev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D090C4CED6;
	Mon, 13 Jan 2025 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779737;
	bh=LUdy7xKIlQ+MQlj2iEmxIt3A9vUnwTyPV+ljWEuw468=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXa8tFevxljDx8CWA6GvIZOiyMzWJkIvU2yMVrWtAqeRqS7oHrHGa69PTkbfRBIjD
	 kPDuNMPCGY5AUZyf5WMhoiNg1/VzWAQbjVeJYpB7ieqrjY8/TAenA+yHq5+DxpOT3F
	 huAHHfYswKIIzRHVerfDsWse3g6I0QWG/UIgMSg4UhBfAhCVDQWVB4GhNAns23ieQd
	 sWhTBRsH7mHwKda5Gpdj3/wqwfG74nhmdDZDse7ZYL8CNlqxfqHUSZRSWayNoGacoE
	 KQGkcRXqPWF95i3MAeKTSWmOYkEN0xzDgev+GPINEvuHjwtGyyMZt8U63WJqGRaGKE
	 EkuzSwtPAdePQ==
Date: Mon, 13 Jan 2025 15:48:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/21] debugfs: separate cache for debugfs inodes
Message-ID: <20250113-tresen-heilbad-c79929db7803@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:45AM +0000, Al Viro wrote:
> Embed them into container (struct debugfs_inode_info, with nothing
> else in it at the moment), set the cache up, etc.
> 
> Just the infrastructure changes letting us augment debugfs inodes
> here; adding stuff will come at the next step.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

