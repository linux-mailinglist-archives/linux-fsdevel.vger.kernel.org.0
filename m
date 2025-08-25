Return-Path: <linux-fsdevel+bounces-59064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C3B340B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A32A1887358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F027281E;
	Mon, 25 Aug 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKil+Wpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C67269AFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128651; cv=none; b=LEjDiuCmusDDMdXqyfV6sNYVNbjXAEiEW5BgiNzZf5K1cVCUy7N/5BMgWPOq9C0ArGr1HAhU0+btNAyuTZ4UJbs42whuwr+//pkhhaprqZND9fCWQx3MdxZEPuN+pG7OsZJxW1NYSk1oVloVoOb7HAyLfLwGwaB/qruvZsXjZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128651; c=relaxed/simple;
	bh=yQmu6UX3ez6hR378vaGwo46cOcAh8NZ5/+7I4QBwTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYsABDUYau9Zko/96EXvuasQ43/AjA9gK6BHy3wR3PWPzpq8q6L3Pj8olj9YdShofkRVeLvyyTgTAQYg7JJQ9cPDgQ0MLuFB4XGuDF86PhXlorHxoo1J6TY9F5ADXZZUL90N8a9n+9JNiEf9L8OPmxbWs+e7WuuedeM3th5dWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKil+Wpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E89C4CEED;
	Mon, 25 Aug 2025 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128651;
	bh=yQmu6UX3ez6hR378vaGwo46cOcAh8NZ5/+7I4QBwTkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKil+WpoVxgoI1PcI7dOFA3V+JriJcePrtVNjmBhptjjvPKtyA6gNOFZaCvBpI+SC
	 Fjipsjxr26dlj/tejjNKlgoahoVthQ1B0cCyyWOqyqmMPOM/YnGsY9+Mc2U32nibBl
	 RT+F4tnx1Or6X3UkjsINBpsMMAzW3WpfJE1r0OwhSZic4JyPby8DOJk4GXRPCJu46i
	 0hRuoGDVtDDifb3djOiGW23s49EoU4nlz8xMYzn/j94FkpLTeAqMyXCR2IB2Q8VFfS
	 dXqwkkeKepmS63T+swbBMw9/Nykj8Ds2UJT24cLWSNau4BIWgMkkRs/foBvzYGa+NN
	 vVayrmC2/BBDA==
Date: Mon, 25 Aug 2025 15:30:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 40/52] do_move_mount(), vfs_move_mount(),
 do_move_mount_old(): constify struct path argument(s)
Message-ID: <20250825-umwerben-geheuer-fc3ed1dca763@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-40-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-40-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:43AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

