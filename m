Return-Path: <linux-fsdevel+bounces-51779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7BADB453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C4C7A3220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176A1A4F3C;
	Mon, 16 Jun 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAGoptXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CE202C45
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085009; cv=none; b=Y8Vr/dfPxHJ4GYrt7BjKenn6I5yyo2RBkOZZ5UxrzkYoAX78KZI7yNc5yXr1UAsd1KPNoLKCU6NjGGsQ/QWAhFIFvssOXwKn9l8yACpfXtHGdtcCugk92SIgDPhBHtm1W79hLBaLmqmIKdCVXo3bBgnBIzCglTMLfSLg3Jdfmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085009; c=relaxed/simple;
	bh=+sRJiMT4TxscWIv0Z6okoJ9JIuyQJikA6RKHcCq0sek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWLrqdOu/uXCe9/x0CkwHTidxiVbraiX1WkJNXuRVRuHHqfAArpbth+rWpVEQCWyktisxSvOYkQsmSH3LABQR2D2Uu5vjQxPkQSUwRSSfiTg4s9eUKEbXzuDpMQC17IDojBPCns/xacdZN2sWdxeGzOxW4nHfTux4Kbk4eZLYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAGoptXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91ABC4CEEA;
	Mon, 16 Jun 2025 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750085009;
	bh=+sRJiMT4TxscWIv0Z6okoJ9JIuyQJikA6RKHcCq0sek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAGoptXwoVpr6ZYsOgAoNjnPnwOZ1zKUkHyTfy54polUf+SPQWLf1jzgPAxlds81v
	 Hb8a/BfmajknKAi+eZ9jWCbKF7eiWGrD+FrRkMbtm4bnbxM6zUE9UnK9dK2Xd3o5cU
	 N6f3yHZTS0Ylo4Eqpneps7KlsBGm5Jh2QOK9y5eErWlhERjcKCURvh/nIr5ZMbt2Qb
	 bWhBxq/MUhn9aqEkLsZje9FiMnLUsnQcIYeGqNc9qpnah39AHK4b+l1HnFBIf64eTc
	 LJmDq8g8rXiK6VOVuC72YkjlIMdbY1MBTJXK2GSsbScCITuxwBwHCGKHlDHrgHpf3D
	 lg2w2p58gw0OQ==
Date: Mon, 16 Jun 2025 16:43:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 5/8] pstore: switch to locked_recursive_removal()
Message-ID: <20250616-anwalt-tresor-3cb1803e21ad@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-5-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:27AM +0100, Al Viro wrote:
> rather than playing with manual d_invalidate()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

