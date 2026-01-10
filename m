Return-Path: <linux-fsdevel+bounces-73138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86732D0DD3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 21:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F0B304D846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C02BEC44;
	Sat, 10 Jan 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfb8fhCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72987260565;
	Sat, 10 Jan 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075662; cv=none; b=n3unJrET90fZ7b0FO1+bBfjEQr2tQDg2OdbzDv/fTnWpIiB8npe+hzgayQI8F8XIyeLevMj+UWr6nh6oPgKf3HKAAWmlB6knrMq2oiOIa2jucy7ClniyLogNeGONkt/tJPvCAtvFAT2FjYDXq/g7vZJwbrZyaNwdBXWsr5snskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075662; c=relaxed/simple;
	bh=lSVwa7cBxtP0gid5x46tGec04JbPsPf6d6W6GB58fss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvw+dWMab84e7WZY4iulcEllbeumdvdmHKCrO08PWJP61fQaOiaDlWQ023TcIoeod32+KJtv83Wy38eVvGgH30MsI7qdoh9suxv+SnM0be9Qdud3rh8mhCJlG8Us9H1j1e2JjGqVenmxDwJ/6x+riTGkCA+H3udrZd1/lfqfVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfb8fhCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75AC4CEF1;
	Sat, 10 Jan 2026 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768075662;
	bh=lSVwa7cBxtP0gid5x46tGec04JbPsPf6d6W6GB58fss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jfb8fhCr2MuOtGjbpLFjk7PDV6U7aRdriEQROnpOX173AwSUoV9qXhAw67CRY/sb6
	 3F3yZgkYBDmomGKlejYZtW3vbls6VMA6hJeRMN3ceCHUwMrKyA1a7L1vcRCE4uEfcT
	 VEXaSY2MUjVvrsQ8sNrhNvflKq9wGHbUr6498uzlK6V+r+tGbv/vdqVJx6QSFk71V4
	 yyButukmBRl/J37YlXU6voOAH1qWMe8DQhLvxTG+EdvMulhq/ixC6HrDs824fgyQDm
	 sfCISdxwSxk8e2p2VrfVmDiZYhD3Yd6UiglvIpWFq6bBXBwlGRfAkN1G5c1JVNvD3R
	 iYQdiu5WTXeCA==
Message-ID: <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
Date: Sat, 10 Jan 2026 15:07:38 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260108004016.3907158-1-cel@kernel.org>
 <20260108004016.3907158-5-cel@kernel.org>
 <176794792304.16766.452897252089076592@noble.neil.brown.name>
 <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
 <20260110164946.GD3634291@ZenIV>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260110164946.GD3634291@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 11:49 AM, Al Viro wrote:
> On Fri, Jan 09, 2026 at 11:04:49AM -0500, Chuck Lever wrote:
> 
>> Jeff mentioned to me privately that the fs_pin API may be deprecated,
>> with its sole current consumer (BSD process accounting) destined for
>> removal. I'm waiting for VFS maintainer review for confirmation on
>> that before deciding how to address your comment. If fs_pin is indeed
>> going away, building new NFSD infrastructure on top of it would be
>> unwise, and we'll have to consider a shift in direction.
> 
> FWIW, fs_pin had never been a good API and experiments with using it
> for core stuff had failed - we ended up with dput_to_list() and teaching
> shrink lists to DTRT with mixed-fs lists instead.
> 
> TBH, I'd rather not see it growing more users.

Fair enough. I will look for a different solution.


> Said that, more serious
> problem is that you are mixing per-mount and per-fs things here.
> 
> Could you go over the objects you need to deal with?  What needs to be
> hidden from the normal "mount busy" logics and revoked when a mount goes
> away?
> 
> Opened files are obvious, but what about e.g. write count?

This is my understanding:

1. Open/lock/delegation state in NFSv4 is represented to clients by an
opaque token called a stateid. NFSv4 open, lock, and delegation stateids
each have an open file associated with them.

2. The "unexport" administrative interface on our NFS server does not
revoke that state. It leaves it in place such that when the share is
subsequently re-exported, the NFS client can present those stateids
to the server and it will recognize and accept them. This makes a
simple "re-export with new export options" operation non-disruptive.

3. While the file system is unexported, I believe that those files are
inaccessible from NFS clients: when an NFS client presents a file handle
that resides on an unexported file system, the response is NFS4ERR_STALE
until such a time when that share is re-exported.

4. The result is that if a share is unexported while NFSv4 clients still
have that share mounted, open/lock/delegation state remains in place,
and the underlying files remain open on the NFS server. That prevents
the shared file system from being unmounted (which is sometimes the very
next step after unexport). As long as the NFS client maintains its lease
(perhaps because it has other shares mounted on that server), those
files remain open.

The workaround is that the server administrator has to use NFSD's
"unlock file system" UI first to revoke the state IDs and close the
files. Then the file system can be unmounted cleanly.


Help me understand what you mean by write count? Currently, IIUC, any
outstanding writes are flushed when each of the files that backs a
stateid is closed.


-- 
Chuck Lever

