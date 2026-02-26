Return-Path: <linux-fsdevel+bounces-78480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JqeKDFLoGnJhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:31:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 410321A69AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F8B3039806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6212326957;
	Thu, 26 Feb 2026 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+ftwt1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC12135AD;
	Thu, 26 Feb 2026 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112422; cv=none; b=T9Uhwg39X1oMnjRV8VvrxLVl91haiAg8ijhn8b1sBTd3dZfu/Cd5uax4koZr8I/1kCKB/E4ujG0V1NZhwLbuz0ra9+/LkmewEq71Pl3sM8v6tging2s9XW72EIdlbWPvG7ymK2P6dmRXBUn72k8yL/u+favTx1Yfh+HBsvEzJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112422; c=relaxed/simple;
	bh=f0Ps20ke6Tu90NeJbb7BlgaGF8G/k6iumdbr2OfaiE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNnwxXz6wIMUtAX8pWB5AGHrWfYDHifg9TqzdNKsvkHdFtEubEfYathW1+GWBf33iqrO02vdI4vrR2ig3Ud1sFsdZuufkN0CAATU80zgjm/qqVl6wS0KvIDyLBOFx5J7wuIepRXYzzE4mIsgmUjO2g1xGdWE0noPuQ888awQC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+ftwt1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262A6C116C6;
	Thu, 26 Feb 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772112422;
	bh=f0Ps20ke6Tu90NeJbb7BlgaGF8G/k6iumdbr2OfaiE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+ftwt1hFWuk0zBQ+q5kizu3/Zw+G/ztSnBuF4hGTnLedZ+PsXAJkVqQxp3oiKTmC
	 VbPuyqXIM6bziJGo26/ar9QPa3Mn9n7SU4gDHWH5F/76KM6qwWoy2IXEcO8gbLGgHT
	 ZIn+kP1Dx08x3xalaDxmCShdXjZOO+iMhBhphXRkl9VJurk3Yvi6tyqXSKYPyUtMM0
	 bcFX5semSa9iYA6IFukrlNBcw97UNUp1KGnfCgsKG0Q9zJP2z6HVnRIMy/ZKCmZ2F6
	 WNd18/gy9eag+XTve+r+FEq3gCrEps6LK+j09UOM4xSg0HKqC4MEvgkneaPttl1KWF
	 YafZ576b3ZCOQ==
Message-ID: <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
Date: Thu, 26 Feb 2026 08:27:00 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.com>, NeilBrown <neilb@ownmail.net>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78480-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 410321A69AF
X-Rspamd-Action: no action

On 2/26/26 5:52 AM, Amir Goldstein wrote:
> On Thu, Feb 26, 2026 at 9:48 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Tue, Feb 24, 2026 at 11:39:06AM -0500, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Kernel subsystems occasionally need notification when a filesystem
>>> is unmounted. Until now, the only mechanism available is the fs_pin
>>> infrastructure, which has limited adoption (only BSD process
>>> accounting uses it) and VFS maintainers consider it deprecated.
>>>
>>> Add an SRCU notifier chain that fires during mount teardown,
>>> following the pattern established by lease_notifier_chain in
>>> fs/locks.c. The notifier fires after processing stuck children but
>>> before fsnotify_vfsmount_delete(), at which point SB_ACTIVE is
>>> still set and the superblock remains fully accessible.
> 
> Did you see commit 74bd284537b34 ("fsnotify: Shutdown fsnotify
> before destroying sb's dcache")?
> 
> Does it make the fsnotify_sb_delete() hook an appropriate place
> for this cleanup?
> 
> We could send an FS_UNMOUNT event on sb, the same way as we send
> it on inode in fsnotify_unmount_inodes().
> 
>>
>> What I don't understand is why you need this per-mount especially
>> because you say above "when a filesystem is mounted. Could you explain
>> this in some more details, please?
>>
> 
> The confusing thing is that FS_UNMOUNT/IN_UNMOUNT are sent
> for inotify when the sb is destroyed, not when the mount is unmounted.
> 
> If we wanted we could also send FS_UNMOUNT in fsnotify_vfsmount_delete(),
> but that would be too confusing.
> 
> I think the only reason that we did not add fanotify support for FAN_UNMOUNT
> is this name confusion, but there could be other reasons which I don't
> remember.
> 
>> Also this should take namespaces into account somehow, right? As Al
>> correctly observed anything that does CLONE_NEWNS and inherits your
>> mountable will generate notifications. Like, if systemd spawns services,
>> if a container runtime start, if someone uses unshare you'll get
>> absolutely flooded with events. I'm pretty sure that is not what you
>> want and that is defo not what the VFS should do...

I agree with Al's earlier comment and have added some protection there
for the next revision of the series.


>> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
>> another idea and I hope that Jan and Amir can tell me that this is
>> doable...
>>
>> Can we extend fsnotify so that it's possible for a filesystem to
>> register "internal watches" on relevant objects such as mounts and
>> superblocks and get notified and execute blocking stuff if needed.
>>
> 
> You mean like nfsd_file_fsnotify_group? ;)
> 
>> Then we don't have to add another set of custom notification mechanisms
>> but have it available in a single subsystem and uniformely available.
>>
> 
> I don't see a problem with nfsd registering for FS_UNMOUNT
> event on sb (once we add it).
> 
> As a matter of fact, I think that nfsd can already add an inode
> mark on the export root path for FS_UNMOUNT event.

There isn't much required here aside from getting a synchronous notice
that the final file system unmount is going on. I'm happy to try
whatever mechanism VFS maintainers are most comfortable with.


-- 
Chuck Lever

