Return-Path: <linux-fsdevel+bounces-17145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B058A8599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3618A1F236DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD61411DB;
	Wed, 17 Apr 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="iTYVQPlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E113F444;
	Wed, 17 Apr 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362984; cv=pass; b=Y65RszjLSlGMaqIPSxQG6bpKsFD0o3MGub3MZyc1RfrT/yC/d+B3k8FLo4eotEJPmiuJ1WAhMaIEsMG6OTMtdf8nxIfAJUPgm8bvAiEkZ3AzFlRuSuHOcd2f3PoZSXlyqid91Dn3Hk691wxA7lk9ROlrcJ3i1Yk755SY/JMNb7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362984; c=relaxed/simple;
	bh=H72tLTn+tWh4iBVxWF+IWpBSQiW9MHUNPXx+EST5u0M=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=iZw/dz731dNgOqPRLlrRJLGv4U+2lH+HCjE9BTEimvBkiQXVcm9RGV6SgCZ0uk6tGVNxBCnyUIGCFsvYciR3mUkRCxe0toVv1NPu5CiXbnffQ53NtDbLO1FeUFlcGYgWg6kVengL0bXvFXKaWi49+DJ9ZxvnKss3f7dP327ADLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=iTYVQPlS; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713362970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NcQc5OWiwLGuJmRXBj5L2SzigKuTXfrhVqalxKbG7I=;
	b=iTYVQPlSQXvYnVvF9DHSaoux8qzgCkS7i8jKr5tR2PEaJqZnpWTSDJ7r2JxPla1uYhmVwS
	AJToe7ezCYx7N+FCGDcc1+W0qzvPDrC6ujlsPar0UMoqYT/2wfupZuAmDyczHSgyF+VHS7
	FSAArrkiwk5FlIGD876+2hsoDiNgxLSmzzOJqtxiBIsP7mwhhraHVX6ZVXHCLvAlFOW/Ku
	wVAdt3ww8GcX2Vs+1eekGrF7xJYxKVhKRDvoF8rfiBOIEWBIrXnQPLTaCSziIAzzb8u9Yz
	PdqfSr1jcIpr6i1kXi5kwGHMI6Egv5YMTJcNufuElHRPbDaLahznU9Qth3z5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713362970; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NcQc5OWiwLGuJmRXBj5L2SzigKuTXfrhVqalxKbG7I=;
	b=g5SlQfIg7qyItlFMAB8wRrSeuLG/e2Z6fGelUhfLg2/e6ia6OrkFXzUpyQFZlt6NEEhV8O
	xUpi793zP4VjMn6XtonhWnQoHdXXzuyLQJVoJG1lP1mk8j0aafkhD0o9MieYMTFXLyF1Zi
	DLZx/nSFyb6k6ws01XO1TruzFjyg8+UDY/phZj45xXSVZ3JpwXVMZa77GMcoxtmQKjRExB
	gXvp/xwbnC333EXaCohJ8VFDF6UIFtuiidzRY7EVcvJ0aMZ3tIWSO8vSPZ40EqItVPOYi9
	xZpnBTqX6jOPI4pKIxIDm1etdkpqaQLIP6vJYo01WgHwRidA+H5ptnEEPxjl+Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1713362971; a=rsa-sha256;
	cv=none;
	b=eTTAKlGFj10Rh/eoPObR+VqOpiGFPeu8c+9/AArcgN+ZoasyMtOo3K3SDzeWQYEAePPqZx
	aubDeVPSEQk9/szK6ypV/iIf0XpYugetuuJSxJE5gc1n4vRPr5UdVvkmEgBP3XOjX703Tk
	0gmsWd574A0Z2ARWIxvlDEwioDJRmUv8ZAlazujyl9PpeovNLGWVK9Ld7gbwJ78dO2jPNW
	SIEuzjmIyAmvwvZuCgcqvBfQUTrTrum9qO9QW3KnbQ4RxGyX8XtDDrIu/XcXEoT7QLj8Ou
	AE74eLM+1BGd1BjWySUIGGld5w62a1PDf0rA9NoxPTAwCXUWU85b1Zp9oG/HAA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>, Shyam Prasad N
 <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live
 connection
In-Reply-To: <2713340.1713286722@warthog.procyon.org.uk>
References: <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
 <3756406.1712244064@warthog.procyon.org.uk>
 <2713340.1713286722@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 11:09:27 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Paulo Alcantara <pc@manguebit.com> wrote:
>
>> Can't we just move the cookie acquisition to cifs_get_tcon() before it
>> gets added to list @ses->tcon_list.  This way we'll guarantee that the
>> cookie is set only once for the new tcon.
>
> cifs_get_tcon() is used from more than one place and I'm not sure the second
> place (__cifs_construct_tcon()) actually wants a cookie.  I'm not sure what
> that path is for.

__cifs_construct_tcon() is used for creating sessions and tcons under
multiuser mounts.  Whenever an user accesses a multiuser mount and the
client can't find a credential for it, a new session and tcon will be
created for the user accessing the mount -- new accesses from same user
will end up reusing the created session and tcon.

And yes, I don't think we'll need a cookie for those tcons as the client
seems to get the fscache cookie from master tcon (the one created from
mount credentials).

> Could all the (re)setting up being done in cifs_mount_get_tcon() be
> pushed back into cifs_get_tcon()?

AFAICT, yes.  I'd need to look into it to make sure that's safe.

>> Besides, do we want to share a tcon with two different superblocks that
>> have 'fsc' and 'nofsc', respectively?  If not, it would be better to fix
>> match_tcon() as well to handle such case.
>
> Maybe?  What does a tcon *actually* represent?  I note that in
> cifs_match_super(), it's not the only criterion matched upon - so you can, at
> least in apparent theory, get different superblocks for the same tcon anyway.

tcon simply represents a tree connected SMB share.  It can be either an
IPC share (\\srv\IPC$) or the actual share (\\srv\share) we're accessing
the files from.

Consider the following example where a tcon is reused from different
CIFS superblocks:

  mount.cifs //srv/share /mnt/1 -o ${opts} # new super, new tcon
  mount.cifs //srv/share/dir /mnt/2 -o ${opts} # new super, reused tcon

So, /mnt/1/dir/foo and /mnt/2/foo will lead to different inodes.

The two mounts are accessing the same tcon (\\srv\share) but the new
superblock was created because the prefix path "\dir" didn't match in
cifs_match_super().  Trust me, that's a very common scenario.

> This suggests that the tcon might not be the best place for the fscache volume
> cookie as you can have multiple inodes wishing to use the same file cookie if
> there are multiple mounts mounting the same tcon but, say, with different
> mount parameters.

We're not supposed to allow mounts with different parameters reusing
servers, sessions or tcons, so that should be no issue.

> I'm not sure what the right way around this is.  The root of the problem is
> coherency management.  If we make a change to an inode on one mounted
> superblock and this bounces a change notification over to the server that then
> pokes an inode in another mounted superblock on the same machine and causes it
> to be invalidated, you lose your local cache if both inodes refer to the same
> fscache cookie.

Yes, that could be a problem.  Perhaps placing the fscache cookie in the
superblock would be a way to go, so we can handle the different fscache
cookies for the superblocks that contain different prefix paths and
access same tcon.

> Remember: fscache does not do this for you!  It's just a facility by which
> which data can be stored and retrieved.  The netfs is responsible for telling
> it when to invalidate and handling coherency.

ACK.

> That said, it might be possible to time-share a cookie on cifs with leases,
> but the local superblocks would have to know about each other - in which case,
> why are they separate superblocks?

See above why they could be separate superblocks.

