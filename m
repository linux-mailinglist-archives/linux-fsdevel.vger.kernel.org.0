Return-Path: <linux-fsdevel+bounces-69376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C005EC79161
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 13:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D9C182D441
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B22A332904;
	Fri, 21 Nov 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="sjz+D3AW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114772FB988;
	Fri, 21 Nov 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729755; cv=none; b=QwJZPIm8erNhY0auV0wrCCbQniwtNDQXOaEZyBvKohw+VZHXye/ky/iPbBqYZtnK37eJfPAMAN4dKR7meHUYWp+x4dyCYABZA0ZkadQG4BLqCSjMaTbyiqYa0ADYIJT9/jMNhdmZ0Gbax/emudWm3wi3zdOX9J0IZ4FLNtY9GtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729755; c=relaxed/simple;
	bh=RBTy/ZUn0+KXynD+Oy8E5Z9J37D6AgWIyOSiu4Br1BM=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=kgu3DteY3nwGB+rzUydOE6Cu0zRutmmor9Z+1HeIWjgD2dmR2a0e8j9MZ1YOODOrojEIBmF2kx/cw5dzJTAu1b7F/sHucHZzy+HGxlGlWlWNDvgcxu0099iNNwWkuCztpRKLVmZ8BrHRY+N9ToQFp2h3unES4T5DM/iawTP0FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=sjz+D3AW; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RBTy/ZUn0+KXynD+Oy8E5Z9J37D6AgWIyOSiu4Br1BM=; b=sjz+D3AWxXmG77Bvp80eRHNWkX
	/LSc6Q4GMKzgsVwzuZGlMW0tUXRcJOW/f3J+JMcGa3ytHvU4v1m2N06ojaYKsuWV/ZZkmM2qs/ExK
	DLAmHbbOoLVYj50f/EMVog/czO9utvvBknxfcJGJb5BGF5ciJFz4yDlhI7PGQcuw9be0KWC/vhEDK
	EiK4AJ89nEw0P5bM62z8f4oUCaqHhGZ9i9xZVHMP1h//W1TE7YL5uhmYpL6CFWF+Y+cyLATeBFiMo
	paz7qWCTmjwYo089kIBVjDJokUhPkrYygg589V9vn66tYc9yoLJ4r9JJuiuPA3VtDUluwDrAi1Vex
	prsk75+Q==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1vMQg2-00000000HAr-44pP;
	Fri, 21 Nov 2025 09:55:52 -0300
Message-ID: <8953f3a61990eaf13fdaf09b5607b197@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>, Shyam Prasad N
 <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] cifs: Add the smb3_read_* tracepoints to SMB1
In-Reply-To: <20251120152524.2711660-2-dhowells@redhat.com>
References: <20251120152524.2711660-1-dhowells@redhat.com>
 <20251120152524.2711660-2-dhowells@redhat.com>
Date: Fri, 21 Nov 2025 09:55:51 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Add the smb3_read_* tracepoints to SMB1's cifs_async_readv() and
> cifs_readv_callback().
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

