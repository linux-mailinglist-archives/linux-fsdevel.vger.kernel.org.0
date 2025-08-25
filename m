Return-Path: <linux-fsdevel+bounces-59073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58887B340F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119537B2AF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216D274FE8;
	Mon, 25 Aug 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvGOklB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE56272811
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129199; cv=none; b=rDcyCJXkgJ5ZIBlbB+dE9+7r1WNC4HmqzY0bdurs/Y0VPz6D5nXs4P0m2KEDRXqsdQi21pzT3EZSOXAmuyBx/CcOQiAHuvc7EN6Gma9hNVrd2OhpoNTpmOMliLJ016MAwsZNNtZA0WaKsH3fDMoWHMrtqBI+HiqTNz3W4rzvJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129199; c=relaxed/simple;
	bh=wKMXQ0Z3izTkwaoQK2UV38tWM1iw8DoJaSaluFk5mCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5+jscUCm/5hEsjItqMYi8wuxDqR3+WobCadivgQzWWH+/KI+K0Y2DIzgn8GPHgLT9P4qdgRF/pg9+F3zUOAuihFSKzTpqL00hP73naIWLQzOuHzmU4pRIyC3tqXdh0kBymww0piHdVYLvDHH87Y8BZv++ZH+OAxhqscH1yav40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvGOklB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B449C4CEED;
	Mon, 25 Aug 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129199;
	bh=wKMXQ0Z3izTkwaoQK2UV38tWM1iw8DoJaSaluFk5mCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvGOklB1LJj7V/CyVSPKEZ8+MmnKY7eLlNk7MH2HBQHw4OeHLtSTif+UONjT4Pomg
	 h0XpnrxDja65oZWybCzPZbnxROsCtOXBm+7Z3j4GdQXXrHLsHL5Z+cBx+OACmTca9/
	 GiD3moLmpGhBcHYxmWz+S5FipYNmNeT1EisxX8/JPvq9k85BXKgz4gPSkXg1l15n1m
	 xguQjetvoAFOhnT2ch1Qd6hUxiFQYWL1Qsdbr2X83FWBwoq6EbXb56NcYE7+M3T7Nx
	 8oWS/sPnzmaxgLNprbc5oHibKDef2yoUM1u/uBgl7DDLuHV+JQ8pz5wPGtdi68u4Jc
	 cfYrGAuihcSCQ==
Date: Mon, 25 Aug 2025 15:39:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 47/52] constify can_move_mount_beneath() arguments
Message-ID: <20250825-hyperaktiv-video-6e8ca3f02b7b@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-47-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-47-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:50AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

