Return-Path: <linux-fsdevel+bounces-75358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJCfEp4QdWmAAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:34:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3537E7B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1BE83013D73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D32266B67;
	Sat, 24 Jan 2026 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y9ctNrw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B862080C1;
	Sat, 24 Jan 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769279635; cv=none; b=TXQ662uYj6oogz2e0vqJBAv/q8XFNL8G0716OVA0E+6HZ0oAWJptjKeEE9LNCCDmX110XIN8x62iZ5+xjPLJSXeluw4lZecWaB1eyKWgcYB4hnAWolHOlkHPFfrd+rFaYjIhwVNpC4g167X3LzUocbeZWPblIfqy7tbGVAkvnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769279635; c=relaxed/simple;
	bh=t2nF+gD7H8+jpqbJmQmUbD70qwIMluN69XTjfEfv8rs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UDF0krHTBnftW5dOTzdpzPrA/n0/uVaWT/Jd3WtUE6WUhKEY/he98mUplOfkUCWydpkBEzK46Vc/dHKOkiaRJ+cRU8cfGxWhNZqZ46/GW2Dmdlgfgo71mjVl18O/DOVHRy8ervu7fq9xy4gwXwhAwW7uokfEH4sCqTv66GfjQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y9ctNrw4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60OIXceB1738906
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 24 Jan 2026 10:33:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60OIXceB1738906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1769279620;
	bh=t2nF+gD7H8+jpqbJmQmUbD70qwIMluN69XTjfEfv8rs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Y9ctNrw4tvWP8Ety7V4AQYAXfm4w1Mkyen4ZK474eHLEp0jd6QtvWyw+SbTQj9Vwo
	 IGv5IhLbOrcw5L29p6C/xuHTRFTJyXa7YvqocHcqKA7hu8tllkwrdJ122lqtbqbLJ2
	 DKGmSaZRLeYeucSErHr8ZtrbbV+6XAscjub/wttd41bXeTcfghJNqjppMYhK0U6WAB
	 pIpm1E/9qdIg9O5634eEJFVjM0nR5e19ojDZA3ra5NsRKGGfvEyj2q06blK6Ua/3nG
	 mPhIJlXkMimFFPpQ7bXXRtJXb2GFOC0wUN1B1C5DqyCDMQGNPe6IPs/oyLbFlyu2BM
	 xa2NJC4t0MLJA==
Date: Sat, 24 Jan 2026 10:33:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Askar Safin <safinaskar@gmail.com>
CC: brauner@kernel.org, corbet@lwn.net, jack@suse.cz, lennart@poettering.net,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org,
        viro@zeniv.linux.org.uk
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/3=5D_Add_the_ability_to_moun?=
 =?US-ASCII?Q?t_filesystems_during_initramfs_expansion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260124174150.974899-1-safinaskar@gmail.com>
References: <20260124003939.426931-1-hpa@zytor.com> <20260124174150.974899-1-safinaskar@gmail.com>
Message-ID: <5A5B4BD6-36BA-4D93-8584-9D0239068515@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75358-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,zytor.com:dkim,zytor.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3537E7B6
X-Rspamd-Action: no action

On January 24, 2026 9:41:50 AM PST, Askar Safin <safinaskar@gmail=2Ecom> wr=
ote:
>"H=2E Peter Anvin" <hpa@zytor=2Ecom>:
>> At Plumber's 2024, Lennart Poettering of the systemd project requested
>> the ability to overmount the rootfs with a separate tmpfs before
>> initramfs expansion, so the populated tmpfs can be unmounted=2E
>
>This is already solved by [1] and [2]=2E They are in next=2E
>
>[1] https://lore=2Ekernel=2Eorg/all/20251229-work-empty-namespace-v1-0-bf=
b24c7b061f@kernel=2Eorg/
>[2] https://lore=2Ekernel=2Eorg/all/20260112-work-immutable-rootfs-v2-0-8=
8dd1c34a204@kernel=2Eorg/
>

Well, all right then :)

