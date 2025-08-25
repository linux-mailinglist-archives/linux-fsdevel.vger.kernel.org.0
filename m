Return-Path: <linux-fsdevel+bounces-59048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AAB34030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5B3B0F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B22609FC;
	Mon, 25 Aug 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFTJDiWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989ED257842
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126654; cv=none; b=eTYH7DZJSGK70EpBqiPi7xm7L7D1swOa2CdflNQr/QcQitssc92/+iWIdOefzAyk3LnrN2i7MrUS0ej0uAFsY/jYkE3W92DW0L8VP2oVJqu/MAKyyTqLW3LEPjfFqCcL4VI4EowkQKhOI4vNcPQhnFzzzYUggwtvLr+K6puY1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126654; c=relaxed/simple;
	bh=KwyuKm+3zpf/p7kJhPZv67vlS24mw6Ff7KKRJ2TZ/N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txgaN66Jc+COPh/080KrsZgUxTyeui6qZGDgDq1TgYbD2GeSWbEEK4pcG43OM2/iOaIUY5SoEL9d3F0rISJC80an5DBVclvD6uwRM8tdrVcfKYF9HUnJ9HpjuXG+8bkj3fFPJPglw2R+65e2gcsQhukZnMuWybst5NR3XNO7bhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFTJDiWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0500C4CEED;
	Mon, 25 Aug 2025 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126654;
	bh=KwyuKm+3zpf/p7kJhPZv67vlS24mw6Ff7KKRJ2TZ/N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFTJDiWgHBh2xT2pFfzi+9dbb0GB1047H5rle3Vn1grgwwhrqZxQr5ktoooySrBut
	 Zk0SGAKkrhrZp/9NkBZR+V4jE5h/6bq//E2tIeHqFdxE/4zLDhfFHAYuAUN5jkLvWf
	 VBvpSO5dl+2G7nbkhtUG9yKtguP+nwBXQaiYOUQrqzOUASO/GLxFBdLucTq4a/6sMH
	 8hDYjDZLyuh+NOlrCbGeTehZDrzEgTyvzwtvHFEnEAEpA9N/wmFHIU7bgmkeMkhpsn
	 L+tcjlD52smBGlTxAbetkSVkhbu39WuYBKHwXoV/fWgGElQfztbhmapwIQeeWmMt3d
	 N5WieM9Z4BViQ==
Date: Mon, 25 Aug 2025 14:57:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 17/52] current_chrooted(): use guards
Message-ID: <20250825-gezielt-umsorgen-440574a1f35c@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-17-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-17-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:20AM +0100, Al Viro wrote:
> here a use of __free(path_put) for dropping fs_root is enough to
> make guard(mount_locked_reader) fit...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

