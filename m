Return-Path: <linux-fsdevel+bounces-78725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD15LPy0oWmMvgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:15:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459B1B986F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE0C31898B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFE438FF1;
	Fri, 27 Feb 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYPB2qwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4C436356;
	Fri, 27 Feb 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205019; cv=none; b=LtUN3ENMjUkmtCQURPVupM16CLwZrLsFddq1NvxUM7xUxZ/Nn+Fy8Jg3egz6KBiYl3PII8sl7/cI6h7truOruk5z8cmy9zvI/gcyYmUtvItErDV0DaUvH+jPFR3b5MvxhQnl5lXwHHxFFp0SbLn21A6WrKqTAOxCQl3cfWRO9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205019; c=relaxed/simple;
	bh=wnLzP+olm9LzrB34JLMNYVuHGs1RANXyxuRdPEAj4LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n363D492KCQqxitck7QUIPD2gY/Db9pDeSEQc84mh5ZIb2jpfdlSGtH+8jvoq3HHfDV11x9hXJuqQ9fqhphyoGL0emDohKYFYS6Msr1VfxX1XDbZS0QEwdrgZUnWt2GEgSOZM0namwzaoTP8+4x+egCVJ84YDNe6Eh/VZnYUv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYPB2qwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F42C19422;
	Fri, 27 Feb 2026 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205019;
	bh=wnLzP+olm9LzrB34JLMNYVuHGs1RANXyxuRdPEAj4LM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYPB2qwQXLk2C8IL9q1I9HlqLtkGkDzdVHLjV6VE7hiTcQYK5LpnzpfnSjqmBio5w
	 t20CAqX2rmwxVnwn+XIonnZdCPVLaacEUSH9NJdXmZNUmTmIruEmTRQHVTfS3zcdHO
	 dqfBZtqMpozPxkhBK4PrEk3JY0rtvIga/Litj55UZ7PraiUzUCY2Sj/ASYppcgJwgp
	 fjbIMSj3R/CnFINYsQDMf2zgehiJZAzz+z5M5eOV12A6yor0HeNeSHsLTZHoLMC3qn
	 iZNrwOnIXh/zzmsuEdsUwUw7dpUp4UOk86QJmw8PGr9IH25Frt/gmrxDuzUJF8p31u
	 YAZw3N6Jcu+uw==
Message-ID: <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
Date: Fri, 27 Feb 2026 10:10:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.com>, NeilBrown <neilb@ownmail.net>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
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
	TAGGED_FROM(0.00)[bounces-78725-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[suse.cz,gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[suse.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2459B1B986F
X-Rspamd-Action: no action

On 2/26/26 8:32 AM, Jan Kara wrote:
> On Thu 26-02-26 08:27:00, Chuck Lever wrote:
>> On 2/26/26 5:52 AM, Amir Goldstein wrote:
>>> On Thu, Feb 26, 2026 at 9:48 AM Christian Brauner <brauner@kernel.org> wrote:
>>>> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
>>>> another idea and I hope that Jan and Amir can tell me that this is
>>>> doable...
>>>>
>>>> Can we extend fsnotify so that it's possible for a filesystem to
>>>> register "internal watches" on relevant objects such as mounts and
>>>> superblocks and get notified and execute blocking stuff if needed.
>>>>
>>>
>>> You mean like nfsd_file_fsnotify_group? ;)
>>>
>>>> Then we don't have to add another set of custom notification mechanisms
>>>> but have it available in a single subsystem and uniformely available.
>>>>
>>>
>>> I don't see a problem with nfsd registering for FS_UNMOUNT
>>> event on sb (once we add it).
>>>
>>> As a matter of fact, I think that nfsd can already add an inode
>>> mark on the export root path for FS_UNMOUNT event.
>>
>> There isn't much required here aside from getting a synchronous notice
>> that the final file system unmount is going on. I'm happy to try
>> whatever mechanism VFS maintainers are most comfortable with.
> 
> Yeah, then as Amir writes placing a mark with FS_UNMOUNT event on the
> export root path and handling the event in
> nfsd_file_fsnotify_handle_event() should do what you need?

Turns out FS_UNMOUNT doesn't do what I need.

1/3 here has a fatal flaw: the SRCU notifier does not fire until all
files on the mount are closed. The problem is that NFSD holds files
open when there is outstanding NFSv4 state. So the SRCU notifier will
never fire, on umount, to release that state.

FS_UNMOUNT notifiers have the same issue.

They fire from fsnotify_sb_delete() inside generic_shutdown_super(),
which runs inside deactivate_locked_super(), which runs when s_active
drops to 0. That requires all mounts to be freed, which requires all
NFSD files to be closed: the same problem.

For any notification approach to actually do what is needed, it needs to
fire during do_umount(), before propagate_mount_busy(). Something like:

do_umount(mnt):
    <- NEW: notify subsystems, allow them to release file refs
    retval = propagate_mount_busy(mnt, 2)   // now passes
    umount_tree(mnt, ...)

This is what Christian's "internal watches... execute blocking stuff"
would need to enable. The existing fsnotify plumbing (groups, marks,
event dispatch) provides the infrastructure, but a new notification hook
in do_umount() is required — neither fsnotify_vfsmount_delete() nor
fsnotify_sb_delete() fires early enough.

But a hook in do_umount() fires for every mount namespace teardown, not
just admin-initiated unmounts. NFSD's callback would need to filter
(e.g., only act when it's the last mount of a superblock that NFSD is
exporting).

This is why I originally went with fs_pin. Not saying the series should
go back to that, but this is the basic requirement: NFSD needs
notification of a umount request while files are still open on that
mount, so that it can revoke the NFSv4 state and close those files.


-- 
Chuck Lever

