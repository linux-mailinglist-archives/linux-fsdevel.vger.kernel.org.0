Return-Path: <linux-fsdevel+bounces-21338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEE902281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3416281768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D5824A3;
	Mon, 10 Jun 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2kqqRDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28C78C93
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025369; cv=none; b=feLnhdztffu3DZR4NBGqZciwghAId8tESgx5llhTcrhIgE+GXZ1LtgsxWlXFWCy6+jTBFlPu6x9e3i3ZTOxe2PhYun9gtqVPjGIM3WJN5hOk+kbYuMO3Ed3oupp66fomH3tZMg3KIWpS7ZT0eas+//U0Q69uyxNeaM5JkkeBCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025369; c=relaxed/simple;
	bh=84RTdwEMrpSDUcc/NAkD1z04/4vCvu4OZ++s6/KMSlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3/GkA8vG6FvgOaTC7oDmpODgSnTGa5GdjSgMG8FcgwUVUxVPpl5yi/c5/tM93APFbnXJe+IuRoFV2H3Oqim0BGjqbsTtZ0Vm4b7pxBgcwVfyKyqDmuLuSgSW6X7rxRck7c815auBHGs9Dh448EBo1WPnD9vvg0xsYRdGjzYY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2kqqRDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0224AC4AF1D;
	Mon, 10 Jun 2024 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718025369;
	bh=84RTdwEMrpSDUcc/NAkD1z04/4vCvu4OZ++s6/KMSlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2kqqRDjCXPIM6Re+95v1A1x13iMLVJgBtc8r5WCbHgmtYTQ2mTPl4u4UPtehHX+X
	 yTsvFc1NzbOIE0z4BRHiwWzhJddNB8yR+wOhT6swCjhjafcBqm2TDq0BER5nscPSQ7
	 tA9sPuHW8Xtk7mnFbPQbwyFhxK8VvydSuUEcND04UVTQVAyHK56I4gVk8vbreUCMky
	 x0Q+ogkwiWuzgeK/DvLYomc3qUXmshA3weKBhJ2fsuP86CwRzcrKOHKyKyzXX130mN
	 37QnkMVIc/JVweg2vFlMvhLGm82O89OfdJ9Wme6DRY21P3zQ7E0/xlaOiXsXCtrjVZ
	 7fE3Jz9Mz1zTQ==
Date: Mon, 10 Jun 2024 15:16:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/4] fs: allow listmount() with reversed ordering
Message-ID: <20240610-frettchen-liberal-a9a5c53865f8@brauner>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
 <efwzpd2qlelhxiulf2bp6ygo5u3xlz6swhwuiax6fjrsyc5g4h@oj2tw4d4hwmk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efwzpd2qlelhxiulf2bp6ygo5u3xlz6swhwuiax6fjrsyc5g4h@oj2tw4d4hwmk>

> This has no bearing on the feature, but since you are cleaning up the
> syscall apart from it perhaps you will be willing to sort this out.

I'm aware of this and I did rewrite statmount() so it doesn't do that
before we merged it. listmount() can do the same. Please see #vfs.misc.

