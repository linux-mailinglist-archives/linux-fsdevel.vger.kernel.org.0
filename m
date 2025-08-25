Return-Path: <linux-fsdevel+bounces-59031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6478BB33F99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1DB3A7699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF015ECD7;
	Mon, 25 Aug 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDTLqHrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1411713
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125297; cv=none; b=A6zm/h7j9iMVgO6Ljyga/bKb7CD1TyGFf9BjsR9VAmj8U/bAcJqeGLBxQb667xiFL36eD+7V3/c7eoAzK7MiSF9ibSxgiRIAHJOAKBz4H2CuZsPbN+ywCte4LxuiUz/hxnuOMRSzRgFb+xSfmNaRoZ+GLmmkM7+mzqNlDsZg4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125297; c=relaxed/simple;
	bh=kUZc6fDuPk1qM8o2YNJqjM0eWkMUoE3meAD+zV63jDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd3yfUwwu5jZG8SRHqGli3aQ+TMPdydBV+MSy/c5b0oba+ac8DFI/8XbLPse4ilyVOf+DBrh6b9Gh5IgUu7kjOUtof2YLIgUjoryxT/OsCxz9DwDTPZS4W1KNtu2UEwGgWp8g5kf3TRlm5/wz8Hiyr8hPqPznQvkkRCrw3c1iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDTLqHrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE0DC4CEED;
	Mon, 25 Aug 2025 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125296;
	bh=kUZc6fDuPk1qM8o2YNJqjM0eWkMUoE3meAD+zV63jDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDTLqHrOrv5agXwGjUUEx/mEzroe8usZuIrKvvQmOKNT4gFsguUOGy2pl/kMCYos8
	 xANihAghH8p+sjKoALKKXZPHa0mXzqHcfuCT5qAlsuSBJBhQP6TC47GMLqxXWPuDSw
	 7FM8LuH11qFxjNHaZJ+M6cu02FWOPrJUzmfJDrU673wHOELu/kbddMR2R6uI1L7V+J
	 og05C1nwohdO+vvJvPDKuyRQurB7mawnBuXP0KQJiJ9h3Xx/c7kbIha6QQwDkUqf6v
	 JgmR0+oSho1QEjomE/H1kqImGp2iPY9REWgxDxdepF5VWXcYHjhP+G3T6eOA9L31L/
	 4YlrRaLkuvJ9Q==
Date: Mon, 25 Aug 2025 14:34:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 06/52] do_change_type(): use guards
Message-ID: <20250825-sperren-laken-e6e8d4761cfd@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-6-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:09AM +0100, Al Viro wrote:
> clean fit; namespace_excl to modify propagation graph
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

