Return-Path: <linux-fsdevel+bounces-53089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C789CAE9EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CDC17AC86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106C2E54B9;
	Thu, 26 Jun 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="vFVDwpPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA42E62A5;
	Thu, 26 Jun 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945039; cv=none; b=M/6eIBP6cp+Sqp6a2iAZuXbdpaBga4Cf91xaP6sBcCyo2zV/4dLfdgCxr5lhmNZDb9HNSE4fT/en/FJvTjojNmnZx2UCyUewAsbkIwvkne3impexfPuql6+AsThHJSiFveYpNbQShwwQCeEo+4K8jkp9bPmRVlC/1eicu/JYO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945039; c=relaxed/simple;
	bh=7GiEbyk2gaqqZRY0Qdms/DBiHIKNN9PuO5+EEuTOtqg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=VDaLyMyNd0nbiUzWfC3IWfS/KBeFkPCcekFD9QpDm+ejYKNSrjblPIKyStM8ns3RyarBX9Jf0S2bMt/HwzP9UW64f7VltS3G3mnmxImtOhj6KFY5WzgCafwj0v7ZCT8mpCeosBuwJ9vhdVIA1QGAgqR0Ki70hl4SF2HtSvkQVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=vFVDwpPB; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=00Zee0q/6wyci+v7KW0sch+Nn4ot5TVE+7wD9jsiKXo=; b=vFVDwpPBeCOIlZIT9jRHjHgQ7z
	JZCCbFczL/Cj2aOYuoUwv0Gf5EskJyKB69pSFlB0u3NrKRBApQrm5f+lk1ouymaUwj7hqImtC2T/r
	Bz6Cx2BlR0bMlVghibVu/w8uUVXxZuqnYdQrninaNm6f9DYMxXnATMvr8AepPRn7X19USIBhuYNZH
	YVbxS3wlldGGSkEQXs1C0qfGPHCpW7RGKD4mLRXatrJ6E7MVycCk3yApqYpld/ZKYs+8bMyuQ0QWW
	Ofv3L3bG1A7oQbBopBpLdvThDFoBK91ggATdFwZAX4oxsZfuCd2bR6yx4QtySUXmWnSWRw/d8WIwo
	EjpqeV/A==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1uUmmr-00000000fRj-36fP;
	Thu, 26 Jun 2025 10:37:09 -0300
Message-ID: <dd1b01babe2b5023e9e26c56a2f2b458@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix i_size updating
In-Reply-To: <1576470.1750941177@warthog.procyon.org.uk>
References: <1576470.1750941177@warthog.procyon.org.uk>
Date: Thu, 26 Jun 2025 10:37:08 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Fix the updating of i_size, particularly in regard to the completion of DIO
> writes and especially async DIO writes by using a lock.
>
> The bug is triggered occasionally by the generic/207 xfstest as it chucks a
> bunch of AIO DIO writes at the filesystem and then checks that fstat()
> returns a reasonable st_size as each completes.
>
> The problem is that netfs is trying to do "if new_size > inode->i_size,
> update inode->i_size" sort of thing but without a lock around it.
>
> This can be seen with cifs, but shouldn't be seen with kafs because kafs
> serialises modification ops on the client whereas cifs sends the requests
> to the server as they're generated and lets the server order them.
>
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c |    2 ++
>  fs/netfs/direct_write.c   |    8 ++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

