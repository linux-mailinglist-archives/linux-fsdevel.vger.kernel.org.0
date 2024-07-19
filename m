Return-Path: <linux-fsdevel+bounces-24000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B3937877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92570B21DED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32331411DF;
	Fri, 19 Jul 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agu8qZwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778824211;
	Fri, 19 Jul 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395552; cv=none; b=LYz/j5J9QNxq7wjPHXrGZg6BIUEsNTf+Ui9Ag3v/z99WJ0GjGuiHH+Aabalvz+DhIJjlT5RDoYPR+CeW9/AJeSKKXnBaFvpLW/XNPyRDtKMk7lNRr4IE8euqVjzleV0v9qP3Y3IO31KYORKXcDVPc6XxVzm70Uw1agSDtZ0Fduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395552; c=relaxed/simple;
	bh=2qmbXe339W3mDTQ41WTqqBuL+WW9E8RQjxj4xyPJh8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHSdGyULpiyQlVWDAVUU0Y6uPSkun8q1VLcN1RcLfm6dFAaA8cLzOechrG2UIPJrsh5i7OSA+McML4hIiTyubK3agKtbnRmKhWQNMZ2ZfMmFSCzhmpc9BzIjPgO+xPe+BDeOdITkcE6GX+rtTfM+qRiD+LBpTVJ+wT3nzXdhAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agu8qZwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94829C32782;
	Fri, 19 Jul 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721395552;
	bh=2qmbXe339W3mDTQ41WTqqBuL+WW9E8RQjxj4xyPJh8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Agu8qZwJxorgTYimHY7Pr5qk8SaCrnMakuHlqrab97LfKJvWlh+R44sHA0pKfiL+F
	 21ysPZ/kr+8Yamxbh4Fg5QUdemD4gvc/YlR62RLu8wUhzxnsDScj34bDHb8dYkaKGl
	 ZG+ozgMGDqzpeXL2UXZNtFAAkctoWMPgVeywumYuHMgVQHL4ywKGUzlYtG4trzLUOW
	 dRZsi9VAqKUNWdDCDf5VZVQQUrVHHBsTeFQc6Zs/2/tdcvxFzWWrvNDB+0Hkl8VT/p
	 kZxqVXAEaAFb8cQCQTdrjggnJaOXstzXlGtTJhlTJujiiqXaiGvk/tcq3yh7FSC15I
	 SO7s7Ps0Kd4tA==
Date: Fri, 19 Jul 2024 06:25:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dominique
 Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Message-ID: <20240719062550.0c132049@kernel.org>
In-Reply-To: <20240718151838.611807-1-mjguzik@gmail.com>
References: <20240718151838.611807-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 17:18:37 +0200 Mateusz Guzik wrote:
> Link: https://lore.kernel.org/v9fs/20240717102458.649b60be@kernel.org/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>

=F0=9F=A7=90=EF=B8=8F click on that link... Anyway, can confirm, problem go=
es away:

Tested-by: Jakub Kicinski <kuba@kernel.org>

