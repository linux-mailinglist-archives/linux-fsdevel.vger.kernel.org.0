Return-Path: <linux-fsdevel+bounces-44209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D899DA6598D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AC23BBE95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA61A3BC0;
	Mon, 17 Mar 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2lEVYEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="poWUttIZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2lEVYEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="poWUttIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E7EBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230507; cv=none; b=P98cMrmCeWaLmnl39ft9f5Y0d+oGEz9SUikxXCoDq2Lvi105N3HKrTQsjCHkzo6bkAEYHxwU/tdHP1r8tbKf/evv/BZBN0fEeQkw7+XM4F4Q4Q7XEthoXyQu6b9ikdb5hI235IoahjxN6rIZGQnxampbCT1T7g0VpcSbj2jqPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230507; c=relaxed/simple;
	bh=k4rHcq5sz0xQ5T63uDgRni8Ev8bDg9bLfWLGYucu9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiUI5K6iCOFjKN+kA7L7qzcTPGD7E8PCBQ4tc+Ho1vRv5E+qH5RyGuSNOVwLlK94AFt2qFNrTK71QU0MtOV6yo/IRbmUuSUJnbXG09DwReHXHaixCf+3pUXjw6WcXOBTLCE7U3n9FLIXtsvIp2kRaut0jTWt7RU+1b8qN+mn1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2lEVYEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=poWUttIZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2lEVYEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=poWUttIZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AA92220C7;
	Mon, 17 Mar 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742230500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NST/M5o0h0WAwSLb6pWXLQI+es6f6q/jAAZHj4lQYXE=;
	b=m2lEVYEOvoLPc8O+W23YLWjwlwfoilKOOJyrvtgf6fa+Ia2l5s7JhheLInn0SzymWpDVHp
	2k6Z/QQefZlGuQwakJxJlHTrZ6sfSGzZyXsdz/MuVVZhyRkR2snstD2VTKfvZ/24vSUMW6
	ZluRzJFhyJoaZxh48Onh5WzA942b6Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742230500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NST/M5o0h0WAwSLb6pWXLQI+es6f6q/jAAZHj4lQYXE=;
	b=poWUttIZ69DW6kYvBIN1wv6at554vv+cx+koBqoP1jLEmbHGs5e4MQHtzbOP5P3xx70u3s
	de/MwQaZbHIut7DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742230500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NST/M5o0h0WAwSLb6pWXLQI+es6f6q/jAAZHj4lQYXE=;
	b=m2lEVYEOvoLPc8O+W23YLWjwlwfoilKOOJyrvtgf6fa+Ia2l5s7JhheLInn0SzymWpDVHp
	2k6Z/QQefZlGuQwakJxJlHTrZ6sfSGzZyXsdz/MuVVZhyRkR2snstD2VTKfvZ/24vSUMW6
	ZluRzJFhyJoaZxh48Onh5WzA942b6Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742230500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NST/M5o0h0WAwSLb6pWXLQI+es6f6q/jAAZHj4lQYXE=;
	b=poWUttIZ69DW6kYvBIN1wv6at554vv+cx+koBqoP1jLEmbHGs5e4MQHtzbOP5P3xx70u3s
	de/MwQaZbHIut7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E62DF139D2;
	Mon, 17 Mar 2025 16:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FcqOONT2GdOIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Mar 2025 16:54:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 696B0A09A8; Mon, 17 Mar 2025 17:54:55 +0100 (CET)
Date: Mon, 17 Mar 2025 17:54:55 +0100
From: Jan Kara <jack@suse.cz>
To: Hui Guo <guohui.study@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Subject: Re: general protection fault in afs_atcell_get_link
Message-ID: <yia64ip2fux45qezdg4lsrsrczt5fcxuzxd7sr2or47qpnrvir@4ow5vl4zubda>
References: <CAHOo4gLcS839f=PR6Rdv9fkeyQ42GzJ2Taw551f0AQ-M5y-obA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHOo4gLcS839f=PR6Rdv9fkeyQ42GzJ2Taw551f0AQ-M5y-obA@mail.gmail.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/a29967be967eebf049e89edb14c4edf9991bc929/.config];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Mon 17-03-25 10:31:26, Hui Guo wrote:
> Hi Kernel Maintainers,
> we found a crash "general protection fault in afs_atcell_get_link" (it
> is a KASAN and makes the kernel reboot) in upstream, we also have
> successfully reproduced it manually:

Thanks for your report. Couple of remarks here though:

1) Since this looks like a problem in AFS, you have the best chance for
addressing this by writing to AFS maintainers and appropriate mailing list
(added to CC).

2) Lately a lot of various syzkaller clones are run by various people.
Usually they lack a lot of convenience that Google folks added to their
syzbot instance. Hence triaging bugs from these clones is unnecessarily
harder than it has to be and since we are swamped by fuzzer generated
reports anyway, those easier to deal with naturally get preference (some
people outright refuse to deal with bugs reported by other instances). So
if you do your research in fuzzing, I'd suggest working with Google folks
to merge those improvements into syzkaller upstream so everyone can
benefit.

								Honza

> HEAD Commit: a29967be967eebf049e89edb14c4edf9991bc929 (Date: Fri Mar
> 14 14:24:05 2025 -1000 Merge: 2bda981bd5dd 1a2b74d0a2a4)
> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/a29967be967eebf049e89edb14c4edf9991bc929/.config
> 
> console output:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/a29967be967eebf049e89edb14c4edf9991bc929/6bb2f3cbecb24c76144c18fe87734ba971041b74/repro.log
> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/a29967be967eebf049e89edb14c4edf9991bc929/6bb2f3cbecb24c76144c18fe87734ba971041b74/repro.report
> syz reproducer:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/a29967be967eebf049e89edb14c4edf9991bc929/6bb2f3cbecb24c76144c18fe87734ba971041b74/repro.prog
> c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/a29967be967eebf049e89edb14c4edf9991bc929/6bb2f3cbecb24c76144c18fe87734ba971041b74/repro.cprog
> 
> Please let me know if there is anything I can help with.
> Best,
> Hui Guo
> 
> 
> This is the crash log I got by reproducing the bug based on the above
> environment，
> I have piped this log through decode_stacktrace.sh to better
> understand the cause of the bug.
> =============================================================================================
> 2025/03/17 01:55:23 parsed 1 programs
> [ 329.138947][T17312] Adding 124996k swap on ./swap-file. Priority:0
> extents:1 across:124996k
> [ 330.753074][ T5250] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
> [ 330.760434][ T5250] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
> [ 330.768752][ T5250] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
> [ 330.771350][ T5250] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
> [ 330.773010][ T5250] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
> [ 330.774270][ T5250] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
> [ 330.986164][ T60] audit: type=1401 audit(1742176531.496:12):
> op=setxattr invalid_context="u:object_r:app_data_file:s0:c512,c768"
> [ 331.096347][ T131] wlan0: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 331.097349][ T131] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [ 331.136436][T17338] chnl_net:caif_netlink_parms(): no params data found
> [ 331.150094][ T1159] wlan1: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 331.151055][ T1159] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [ 331.219305][T17338] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 331.220247][T17338] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 331.221156][T17338] bridge_slave_0: entered allmulticast mode
> [ 331.222353][T17338] bridge_slave_0: entered promiscuous mode
> [ 331.224187][T17338] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 331.225137][T17338] bridge0: port 2(bridge_slave_1) entered disabled state
> [ 331.226071][T17338] bridge_slave_1: entered allmulticast mode
> [ 331.227178][T17338] bridge_slave_1: entered promiscuous mode
> [ 331.262149][T17338] bond0: (slave bond_slave_0): Enslaving as an
> active interface with an up link
> [ 331.264609][T17338] bond0: (slave bond_slave_1): Enslaving as an
> active interface with an up link
> [ 331.292430][T17338] team0: Port device team_slave_0 added
> [ 331.294312][T17338] team0: Port device team_slave_1 added
> [ 331.321785][T17338] batman_adv: batadv0: Adding interface: batadv_slave_0
> [ 331.322627][T17338] batman_adv: batadv0: The MTU of interface
> batadv_slave_0 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented o.
> [ 331.325513][T17338] batman_adv: batadv0: Not using interface
> batadv_slave_0 (retrying later): interface not active
> [ 331.327499][T17338] batman_adv: batadv0: Adding interface: batadv_slave_1
> [ 331.328392][T17338] batman_adv: batadv0: The MTU of interface
> batadv_slave_1 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented o.
> [ 331.333148][T17338] batman_adv: batadv0: Not using interface
> batadv_slave_1 (retrying later): interface not active
> [ 331.375374][T17338] hsr_slave_0: entered promiscuous mode
> [ 331.376698][T17338] hsr_slave_1: entered promiscuous mode
> [ 331.467995][T17338] netdevsim netdevsim1 netdevsim0: renamed from eth0
> [ 331.470680][T17338] netdevsim netdevsim1 netdevsim1: renamed from eth1
> [ 331.472541][T17338] netdevsim netdevsim1 netdevsim2: renamed from eth2
> [ 331.474378][T17338] netdevsim netdevsim1 netdevsim3: renamed from eth3
> [ 331.485409][T17338] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 331.486459][T17338] bridge0: port 2(bridge_slave_1) entered forwarding state
> [ 331.487383][T17338] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 331.488178][T17338] bridge0: port 1(bridge_slave_0) entered forwarding state
> [ 331.508905][T17338] 8021q: adding VLAN 0 to HW filter on device bond0
> [ 331.514256][T11423] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 331.516164][T11423] bridge0: port 2(bridge_slave_1) entered disabled state
> [ 331.526344][T17338] 8021q: adding VLAN 0 to HW filter on device team0
> [ 331.531824][ T1159] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 331.533467][ T1159] bridge0: port 1(bridge_slave_0) entered forwarding state
> [ 331.537485][T11423] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 331.539499][T11423] bridge0: port 2(bridge_slave_1) entered forwarding state
> [ 331.660674][T17338] 8021q: adding VLAN 0 to HW filter on device batadv0
> [ 331.684355][T17338] veth0_vlan: entered promiscuous mode
> [ 331.687412][T17338] veth1_vlan: entered promiscuous mode
> [ 331.697117][T17338] veth0_macvtap: entered promiscuous mode
> [ 331.700494][T17338] veth1_macvtap: entered promiscuous mode
> [ 331.706258][T17338] batman_adv: batadv0: Interface activated: batadv_slave_0
> [ 331.712543][T17338] batman_adv: batadv0: Interface activated: batadv_slave_1
> [ 331.715646][T17338] netdevsim netdevsim1 netdevsim0: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 331.716833][T17338] netdevsim netdevsim1 netdevsim1: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 331.718006][T17338] netdevsim netdevsim1 netdevsim2: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 331.719262][T17338] netdevsim netdevsim1 netdevsim3: set [1, 0] type
> 2 family 0 port 6081 - 0
> 2025/03/17 01:55:32 executed programs: 0
> [ 331.820640][ T5250] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
> [ 331.823015][ T5250] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
> [ 331.824751][ T5250] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
> [ 331.826775][ T5250] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
> [ 331.828183][ T5250] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
> [ 331.830272][ T5250] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
> [ 331.911544][T18718] chnl_net:caif_netlink_parms(): no params data found
> [ 331.956621][T18718] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 331.957730][T18718] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 331.958932][T18718] bridge_slave_0: entered allmulticast mode
> [ 331.960633][T18718] bridge_slave_0: entered promiscuous mode
> [ 331.963007][T18718] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 331.964012][T18718] bridge0: port 2(bridge_slave_1) entered disabled state
> [ 331.965032][T18718] bridge_slave_1: entered allmulticast mode
> [ 331.966429][T18718] bridge_slave_1: entered promiscuous mode
> [ 332.000753][T18718] bond0: (slave bond_slave_0): Enslaving as an
> active interface with an up link
> [ 332.003664][T18718] bond0: (slave bond_slave_1): Enslaving as an
> active interface with an up link
> [ 332.032450][T18718] team0: Port device team_slave_0 added
> [ 332.034642][T18718] team0: Port device team_slave_1 added
> [ 332.053267][T18718] batman_adv: batadv0: Adding interface: batadv_slave_0
> [ 332.054172][T18718] batman_adv: batadv0: The MTU of interface
> batadv_slave_0 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented o.
> [ 332.057325][T18718] batman_adv: batadv0: Not using interface
> batadv_slave_0 (retrying later): interface not active
> [ 332.067562][T18718] batman_adv: batadv0: Adding interface: batadv_slave_1
> [ 332.068369][T18718] batman_adv: batadv0: The MTU of interface
> batadv_slave_1 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented o.
> [ 332.072246][T18718] batman_adv: batadv0: Not using interface
> batadv_slave_1 (retrying later): interface not active
> [ 332.104851][T18718] hsr_slave_0: entered promiscuous mode
> [ 332.106110][T18718] hsr_slave_1: entered promiscuous mode
> [ 332.107170][T18718] debugfs: Directory 'hsr0' with parent 'hsr'
> already present!
> [ 332.108195][T18718] Cannot create hsr debugfs directory
> [ 332.643526][T18718] netdevsim netdevsim0 netdevsim0: renamed from eth0
> [ 332.645730][T18718] netdevsim netdevsim0 netdevsim1: renamed from eth1
> [ 332.647741][T18718] netdevsim netdevsim0 netdevsim2: renamed from eth2
> [ 332.650607][T18718] netdevsim netdevsim0 netdevsim3: renamed from eth3
> [ 332.677409][T18718] 8021q: adding VLAN 0 to HW filter on device bond0
> [ 332.692264][T18718] 8021q: adding VLAN 0 to HW filter on device team0
> [ 332.695569][ T131] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 332.696640][ T131] bridge0: port 1(bridge_slave_0) entered forwarding state
> [ 332.701166][ T131] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 332.702172][ T131] bridge0: port 2(bridge_slave_1) entered forwarding state
> [ 332.804497][T18718] 8021q: adding VLAN 0 to HW filter on device batadv0
> [ 332.823489][T18718] veth0_vlan: entered promiscuous mode
> [ 332.828148][T18718] veth1_vlan: entered promiscuous mode
> [ 332.843161][T18718] veth0_macvtap: entered promiscuous mode
> [ 332.845325][T18718] veth1_macvtap: entered promiscuous mode
> [ 332.851089][T18718] batman_adv: The newly added mac address
> (aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
> [ 332.852259][T18718] batman_adv: It is strongly recommended to keep
> mac addresses unique to avoid problems!
> [ 332.853803][T18718] batman_adv: batadv0: Interface activated: batadv_slave_0
> [ 332.856714][T18718] batman_adv: The newly added mac address
> (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
> [ 332.857902][T18718] batman_adv: It is strongly recommended to keep
> mac addresses unique to avoid problems!
> [ 332.860525][T18718] batman_adv: batadv0: Interface activated: batadv_slave_1
> [ 332.863772][T18718] netdevsim netdevsim0 netdevsim0: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 332.864788][T18718] netdevsim netdevsim0 netdevsim1: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 332.865835][T18718] netdevsim netdevsim0 netdevsim2: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 332.866943][T18718] netdevsim netdevsim0 netdevsim3: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 332.868813][ T86] Bluetooth: hci0: command tx timeout
> [ 332.896246][ T131] wlan0: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 332.897396][ T131] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [ 332.912170][ T131] wlan1: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 332.913304][ T131] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [ 332.962438][T18718] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000056: 0000 [#1] PREEMPT SMP KASAN
> NOPTI
> [ 332.964350][T18718] KASAN: null-ptr-deref in range
> [0x00000000000002b0-0x00000000000002b7]
> [ 332.965503][T18718] CPU: 3 UID: 0 PID: 18718 Comm: syz-executor Not
> tainted 6.14.0-rc6 #1
> [ 332.966645][T18718] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [332.967893][T18718] RIP: 0010:afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:321
> (discriminator 11))
> [ 332.968754][T18718] Code: 89 c3 89 c6 e8 43 2a 41 fe 85 db 75 64 e8
> 4a 2f 41 fe 48 8d bd b0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
> fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 89 f6 bf 030
> All code
> ========
> 0: 89 c3 mov %eax,%ebx
> 2: 89 c6 mov %eax,%esi
> 4: e8 43 2a 41 fe call 0xfffffffffe412a4c
> 9: 85 db test %ebx,%ebx
> b: 75 64 jne 0x71
> d: e8 4a 2f 41 fe call 0xfffffffffe412f5c
> 12: 48 8d bd b0 02 00 00 lea 0x2b0(%rbp),%rdi
> 19: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
> 20: fc ff df
> 23: 48 89 fa mov %rdi,%rdx
> 26: 48 c1 ea 03 shr $0x3,%rdx
> 2a:* 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1) <-- trapping instruction
> 2e: 0f 85 1f 01 00 00 jne 0x153
> 34: 4c 89 f6 mov %r14,%rsi
> 37: bf .byte 0xbf
> 38: 30 .byte 0x30
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
> 4: 0f 85 1f 01 00 00 jne 0x129
> a: 4c 89 f6 mov %r14,%rsi
> d: bf .byte 0xbf
> e: 30 .byte 0x30
> [ 332.971357][T18718] RSP: 0018:ffffc9000926f990 EFLAGS: 00010216
> [ 332.972190][T18718] RAX: dffffc0000000000 RBX: 0000000000000001 RCX:
> ffffffff8377085a
> [ 332.973263][T18718] RDX: 0000000000000056 RSI: ffffffff837707e6 RDI:
> 00000000000002b0
> [ 332.974335][T18718] RBP: 0000000000000000 R08: 0000000000000001 R09:
> fffffbfff2083d82
> [ 332.975412][T18718] R10: 0000000000000001 R11: 0000000000000000 R12:
> 0000000000000000
> [ 332.976457][T18718] R13: ffff888035f97000 R14: 0000000000000003 R15:
> ffffffff837704c0
> [ 332.977537][T18718] FS: 00005555785fb500(0000)
> GS:ffff88823be80000(0000) knlGS:0000000000000000
> [ 332.978748][T18718] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 332.979642][T18718] CR2: 00007fffacaeeea8 CR3: 000000003938c000 CR4:
> 00000000000006f0
> [ 332.980713][T18718] Call Trace:
> [ 332.981171][T18718] <TASK>
> [332.981575][T18718] ? die_addr
> (/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/kernel/dumpstack.c:421
> /data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/kernel/dumpstack.c:460)
> [332.982173][T18718] ? exc_general_protection
> (/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/kernel/traps.c:748
> /data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/kernel/traps.c:693)
> [332.982965][T18718] ? asm_exc_general_protection
> (/data/ghui/docker_data/linux_kernel/upstream/linux/./arch/x86/include/asm/idtentry.h:617)
> [332.983755][T18718] ? __pfx_afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:310)
> [332.984537][T18718] ? afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:319
> (discriminator 3))
> [332.985269][T18718] ? afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:321
> (discriminator 11))
> [332.986008][T18718] ? afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:321
> (discriminator 11))
> [332.986732][T18718] ? __pfx_afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:310)
> [332.987510][T18718] step_into
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:1915
> /data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:1984)
> [332.988131][T18718] ? __pfx_step_into
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:1949)
> [332.988789][T18718] ? lookup_fast
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:1763)
> [332.989436][T18718] path_openat
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:3778
> /data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:3986)
> [332.990073][T18718] ? __pfx_path_openat
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:3971)
> [332.990750][T18718] ? __pfx___lock_acquire
> (/data/ghui/docker_data/linux_kernel/upstream/linux/kernel/locking/lockdep.c:5079)
> [332.991477][T18718] ? find_held_lock
> (/data/ghui/docker_data/linux_kernel/upstream/linux/kernel/locking/lockdep.c:5341)
> [332.992137][T18718] do_filp_open
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:4017)
> [332.992747][T18718] ? __pfx_do_filp_open
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:4010)
> [332.993418][T18718] ? alloc_fd
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/file.c:584)
> [332.994033][T18718] ? do_raw_spin_unlock
> (/data/ghui/docker_data/linux_kernel/upstream/linux/./arch/x86/include/asm/atomic.h:23
> /data/ghui/docker_data/linux_kernel/upstream/linux/./include/linux/atomic/atomic-arch-fallback.h:457
> /data/ghui/docker_data/linux_kernel/upstream/linux/./include/linux/atomic/atomic-instrumented.h:33
> /data/ghui/docker_data/linux_kernel/upstream/linux/./include/asm-generic/qspinlock.h:57
> /data/ghui/docker_data/linux_kernel/upstream/linux/kernel/locking/spinlock_debug.c:101
> /data/ghui/docker_data/linux_kernel/upstream/linux/kernel/locking/spinlock_debug.c:141)
> [332.994760][T18718] ? alloc_fd
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/file.c:584)
> [332.995366][T18718] do_sys_openat2
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/open.c:1429)
> [332.996024][T18718] ? __pfx_do_sys_openat2
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/open.c:1414)
> [332.996740][T18718] ? __pfx_do_unlinkat
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/namei.c:4554)
> [332.997436][T18718] __x64_sys_openat
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/open.c:1454)
> [332.998116][T18718] ? __pfx___x64_sys_openat
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/open.c:1454)
> [332.998870][T18718] do_syscall_64
> (/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/common.c:52
> /data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/common.c:83)
> [332.999513][T18718] entry_SYSCALL_64_after_hwframe
> (/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/entry_64.S:130)
> [ 333.000344][T18718] RIP: 0033:0x7f9f1db9af84
> [ 333.000966][T18718] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 e6 03
> 03 00 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01
> 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c4
> All code
> ========
> 0: 24 20 and $0x20,%al
> 2: eb 8f jmp 0xffffffffffffff93
> 4: 66 90 xchg %ax,%ax
> 6: 44 89 54 24 0c mov %r10d,0xc(%rsp)
> b: e8 e6 03 03 00 call 0x303f6
> 10: 44 8b 54 24 0c mov 0xc(%rsp),%r10d
> 15: 44 89 e2 mov %r12d,%edx
> 18: 48 89 ee mov %rbp,%rsi
> 1b: 41 89 c0 mov %eax,%r8d
> 1e: bf 9c ff ff ff mov $0xffffff9c,%edi
> 23: b8 01 01 00 00 mov $0x101,%eax
> 28: 0f 05 syscall
> 2a:* 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax <-- trapping instruction
> 30: 77 34 ja 0x66
> 32: 44 89 c7 mov %r8d,%edi
> 35: 89 44 24 c4 mov %eax,-0x3c(%rsp)
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax
> 6: 77 34 ja 0x3c
> 8: 44 89 c7 mov %r8d,%edi
> b: 89 44 24 c4 mov %eax,-0x3c(%rsp)
> [ 333.003592][T18718] RSP: 002b:00007fffacaef610 EFLAGS: 00000293
> ORIG_RAX: 0000000000000101
> [ 333.004746][T18718] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f9f1db9af84
> [ 333.005833][T18718] RDX: 0000000000000000 RSI: 00007fffacaef740 RDI:
> 00000000ffffff9c
> [ 333.006910][T18718] RBP: 00007fffacaef740 R08: 0000000000000000 R09:
> 00007fffacaef510
> [ 333.008016][T18718] R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000000
> [ 333.009150][T18718] R13: 00007fffacaf0840 R14: 0000555578616640 R15:
> 00005555785fb4a8
> [ 333.010242][T18718] </TASK>
> [ 333.010665][T18718] Modules linked in:
> [ 333.011499][T18718] ---[ end trace 0000000000000000 ]---
> [333.012276][T18718] RIP: 0010:afs_atcell_get_link
> (/data/ghui/docker_data/linux_kernel/upstream/linux/fs/afs/dynroot.c:321
> (discriminator 11))
> [ 333.013191][T18718] Code: 89 c3 89 c6 e8 43 2a 41 fe 85 db 75 64 e8
> 4a 2f 41 fe 48 8d bd b0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
> fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 89 f6 bf 030
> All code
> ========
> 0: 89 c3 mov %eax,%ebx
> 2: 89 c6 mov %eax,%esi
> 4: e8 43 2a 41 fe call 0xfffffffffe412a4c
> 9: 85 db test %ebx,%ebx
> b: 75 64 jne 0x71
> d: e8 4a 2f 41 fe call 0xfffffffffe412f5c
> 12: 48 8d bd b0 02 00 00 lea 0x2b0(%rbp),%rdi
> 19: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
> 20: fc ff df
> 23: 48 89 fa mov %rdi,%rdx
> 26: 48 c1 ea 03 shr $0x3,%rdx
> 2a:* 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1) <-- trapping instruction
> 2e: 0f 85 1f 01 00 00 jne 0x153
> 34: 4c 89 f6 mov %r14,%rsi
> 37: bf .byte 0xbf
> 38: 30 .byte 0x30
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
> 4: 0f 85 1f 01 00 00 jne 0x129
> a: 4c 89 f6 mov %r14,%rsi
> d: bf .byte 0xbf
> e: 30 .byte 0x30
> [ 333.016218][T18718] RSP: 0018:ffffc9000926f990 EFLAGS: 00010216
> [ 333.017197][T18718] RAX: dffffc0000000000 RBX: 0000000000000001 RCX:
> ffffffff8377085a
> [ 333.019628][T18718] RDX: 0000000000000056 RSI: ffffffff837707e6 RDI:
> 00000000000002b0
> [ 333.022262][T18718] RBP: 0000000000000000 R08: 0000000000000001 R09:
> fffffbfff2083d82
> [ 333.023397][T18718] R10: 0000000000000001 R11: 0000000000000000 R12:
> 0000000000000000
> [ 333.024568][T18718] R13: ffff888035f97000 R14: 0000000000000003 R15:
> ffffffff837704c0
> [ 333.025981][T18718] FS: 00005555785fb500(0000)
> GS:ffff8880b8780000(0000) knlGS:0000000000000000
> [ 333.027206][T18718] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 333.028127][T18718] CR2: 00007f4cf9766050 CR3: 000000003938c000 CR4:
> 00000000000006f0
> [ 333.029388][T18718] Kernel panic - not syncing: Fatal exception
> [ 333.030620][T18718] Kernel Offset: disabled
> [ 333.031229][T18718] Rebooting in 86400 seconds..
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

