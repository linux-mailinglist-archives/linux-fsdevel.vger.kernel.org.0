Return-Path: <linux-fsdevel+bounces-59060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC8B340B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD39316B559
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248A274B56;
	Mon, 25 Aug 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTUhyu/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB41273D60
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128594; cv=none; b=nS861w0kPikVtWOMVTMjUZi6i1OrMTefuboR3iWGjOH9aiCrs64xHGP61Uo65/v0VCGOrZ9SNoQgK7y64rKvgwEDr7PPJPkE4UHFWtMLLeONoqbg1IVtaeAnh+sxK91rsPFhlfzko7E9c20zc7vDMWXPW0qZaTkronSPeY8AEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128594; c=relaxed/simple;
	bh=DfWk9zmMTW0iCsI1sPg04Psd9DFxWT/g7l+I1/FixDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzwuTKMsIcOpr3Y7rre76Bl1ZZp2+51SMf569tVPSIS+V33XjMita0GYC+GKzJNW0EVeKUEoECtvKE+P/nMoFA2LfOgfgKaqsjEE2PRuyaeKJgpIbTXgy6sXxhI2H0uj9TqWisfXcrB2IJ/QjiosqorVeMTqhjU7qsvC+6h6Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTUhyu/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E7BC4CEED;
	Mon, 25 Aug 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128593;
	bh=DfWk9zmMTW0iCsI1sPg04Psd9DFxWT/g7l+I1/FixDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTUhyu/SkAXbSaxEKRXhdNrKbTCNc++XMmfVN0nIjVbXtvYcwqzt5GzaJBTR5NFR1
	 rDhiEZifjR0Zx2JP8FY/1PKMUDsm9GGdtXYEbnCpuuICJuFYIYjr7RTLVwPBmeyufu
	 IXpa5NzFrVdefWb1ABrQHS+f3GhYRt7xRQbqhSCK5MbeUIcY6MfEeiuvjMOSPtpVjV
	 EPoxYkuXCO9kA1RsCCapjMOKDTO90QMAKc1g+n+C73bCCXoNAJzA3VUsY5ISPnoiGg
	 nYLe/BwX/db43Wegxo6GEq7EXV6UDlyRe7SE1+e7SudUJmsf3QD2dgdauqaKkJfX7K
	 HwuiipK5dYNIQ==
Date: Mon, 25 Aug 2025 15:29:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 37/52] do_set_group(): constify path arguments
Message-ID: <20250825-zahlbar-umkleiden-d0666d8cdb30@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-37-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-37-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:40AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

