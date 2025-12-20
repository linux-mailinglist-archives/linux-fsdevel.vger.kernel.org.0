Return-Path: <linux-fsdevel+bounces-71804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DACD38E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699B23010CC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9A2FBE00;
	Sat, 20 Dec 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VyHA53nD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746914F112;
	Sat, 20 Dec 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274629; cv=none; b=aBAmd9ncW4DHYbqtugPcTS16Ze/5jWoq+rMIKwQXsNXCYXZWgLq3F0hVAcfr1Py7kc3Su4R+iZJ1lXMFeQ042xQy0+xYAinNTkGDYfTq3bs6VkCvMntloA4/RJd4F+AyLPrErFqzqMVYDdbjdtNfc7oADZu5oaUM0MuLRNVkGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274629; c=relaxed/simple;
	bh=ppz58eOKLPGxDuNvfdJ5krKR+xOC31BvvHD+9u3HPpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhFAEGVS+j7GnTl6v+Rcu1oCC2AuWgqouoH3BocAEIhdA43TD1HMjK37wy7lxZ99w5OAIe3r/l/87WWNnAJQc+ypPOjoyaWCZwOd2ytzMcFuho6pi7MASCP7kT9MyxYn+jAeQ4YkTDpweNCQMfwJxgAHVodawvcBTcjDaQuArlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=VyHA53nD; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ppz58eOKLPGxDuNvfdJ5krKR+xOC31BvvHD+9u3HPpI=; b=VyHA53nDtwv41lzXOuG16N0Cwa
	LQsEA+23dIrZWjdrG5mcikvyZz6ruwFYVE3A6TczLQM6WVRKoS4YRYBPGQVWEpsJwp2JL2/zUdgDJ
	8kdo2Jl9RUJP5an9POHmXRZmOaTyqDeOwi88vY9AMMAhXPG5QHzZvY+YMQ28hyXs6IJx/SN+sXlBE
	a3d/ELkPNkWZ2VuADsXwEEpovs9eMOX2yoxXPC+vTLttzV/+Z/jshkkHbppnecJCnNJ+E/bKaKIPK
	EcYG0B8yrmq1RDkjTeJe6NNWCMbSmJ4uG4pBSEJY2s7ffmWaWChAfw95KFx+E9aeqyAck9cGdnBCk
	cvmI/SGAFizz7BvTg7LphrDr3aCqupEykwdMty4arGMyDWszmDVGklGTIzacSOofZO8JGRrQVlgMJ
	C/6EJslMm0W2wDuwt9XiCqDI5w7nk1jjB87GLg4FfXQ0lBgzF5Wd0jdhuYWrD5cuUaJqwhftMffcH
	kzPvnrBui9KJzcuwzGbd1LhsEmrQJ8Td8vrdYi6yFlQlILo++m+Ctd36AoXcHAKPuW2Ziy82W4tKj
	BTgbovVulx8iAKOThnnuiaGG+wjjcg9cRfTQCAMizuYAdyS0MlpQ1yD8nOBxoNWGqq+2pfjRza4HI
	dHxQMD2yS29RYSW1uSfFx5XPccx60e45Nkz9bGv+g=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Chris Arges <carges@cloudflare.com>,
 Matthew Wilcox <willy@infradead.org>, Steve French <sfrench@samba.org>,
 v9fs@lists.linux.dev, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Date: Sun, 21 Dec 2025 00:50:09 +0100
Message-ID: <22941732.EfDdHjke4D@weasel>
In-Reply-To: <8618918.T7Z3S40VBb@weasel>
References:
 <938162.1766233900@warthog.procyon.org.uk> <8618918.T7Z3S40VBb@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 20 December 2025 15:55:09 CET Christian Schoenebeck wrote:
> On Saturday, 20 December 2025 13:31:40 CET David Howells wrote:
> > The read result collection for buffered reads seems to run ahead of the
> > completion of subrequests under some circumstances, as can be seen in the
[...]
> With the patch applied, this issue disappeared. Give me some hours for more
> thorough tests, due to the random factor involved.

Dominique, David, looks good! Thanks!

Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>



