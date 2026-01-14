Return-Path: <linux-fsdevel+bounces-73779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F81D203E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0204300D337
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749D3A4F2B;
	Wed, 14 Jan 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RrDRW3+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448693A1E66;
	Wed, 14 Jan 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408713; cv=none; b=gQpdjj310LUkYWyhLv63QaR9EaCxUWQVtxavEyL8vqzy+Q3Jfx7nNd1xR08GJ7BM+SUV0+OhJoxT9uxBikZyaTgwNjrkbz4zWvdegYq/JQ2upeD+lnpjPQZLC3dtrChpcJWClXi7YIp3EIYM1mfxzQL8ffORdb1NHe8srUmd4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408713; c=relaxed/simple;
	bh=/DFbk4bWQdmProW1/5+uetwcFB6FreSLo5Piq1yNVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmK+eCJPpZdiDc8Obe+N8ncKOnZiNu/+KSJIwBs6pgg7Q8Ztktu0yWO6WsOubCui+pzXny+JdKPkPMAsvp2T10KIceg3ItKps4cSbOsQ3x2pzfeerU/vhBv7KcIbbJnr+HP/EIVfw3tPyrYl7GHBPGQHVjBJ7RHbWCvE7tYydhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RrDRW3+6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KUF3ougF3Q9JUs67uSURJ3D+CBB/q/SFzNi1ZOftFWg=; b=RrDRW3+6dEnWAcenTJBGFPVX8d
	SGkAuEvymx9i0BSDS/7nWgqHlVfPcK0lszAcIDko6p/jKcWiKPLBW5irxaMus6QmtZ7o9vqNv9Sq5
	NlmtMlEltyhQV9KHWwMqUsJu7SJ8+ieLSlDhA1f3HW8WB93bbmw436b3Yl/WFMxbnPyyeXwvdV1vJ
	h99TJIxl7MnfLMgk2Mv2AbauC+t950t/HeWFKeeadGPk+5THxQbMC8gjQLnzY14AOyVMIy871KSyF
	tRkOVcOW7fZgpOzBnvGfviHZJtXPVAwQY2IjxRLK7OeKjOIOV7iFKrMTgAQoYb3Z19Rbfgbc56Tnp
	LSrWV4gA==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vg3sp-005MFt-Vt; Wed, 14 Jan 2026 17:38:12 +0100
Message-ID: <cb5a8880-ed0c-495f-b216-090ee8ff1425@igalia.com>
Date: Wed, 14 Jan 2026 13:38:06 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>
 <20260114061028.GF15551@frogsfrogsfrogs> <20260114062424.GA10805@lst.de>
 <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 14/01/2026 07:12, Amir Goldstein escreveu:

[...]

> 
> Whether or not we should repurpose the existing get_uuid() I don't
> know - that depends whether pNFS expects the same UUID from an
> "xfs clone" as overlayfs would.
> 

If we go in that direction, do you think it would be reasonable to have 
this as a super_block member/helper? Also do you know any other fs that 
require this type of workaround on ovl?

