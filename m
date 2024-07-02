Return-Path: <linux-fsdevel+bounces-22912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4091EE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043171C22428
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB62A7D405;
	Tue,  2 Jul 2024 05:04:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBE78283
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719896676; cv=none; b=WBE/eIGedYh5LCHeuJo2hWQs9xkLdhgM4nzis4io316INdxGknecJFkPxerfY9Nq6+ZGLa3wE6M3LCYdK+SH+KH7iSpo7O5pQzEBL3W4me3yhVSv/dFSIkda4G3YQfstXZk1I0NLfO+M4BkN09TLhIHAcH9LSiYjZSZPhucGBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719896676; c=relaxed/simple;
	bh=eqUbeInsgJ7Kos8B02CBh2meSk5+kyHZ4Z2mHG+Ax9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZEjaUJtVaw16oUr3utdd7VNvT+39HQoEgYiBNWILq7b7QgCwe0WvTmao7wAuQyo9lhM3sj4vxpGu6jXNt/0z5I38cZ0M1G2GcZ2HavEMUddat9QeTktjeR+mBNz+DrJTHng9fUXeqLRmut9bk2VXDLmKZpnkqtv5gO061yhxWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A32752055FA3;
	Tue,  2 Jul 2024 14:04:32 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 46254Vak060437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:04:32 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 46254VNZ346533
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:04:31 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 46254VK9346532;
	Tue, 2 Jul 2024 14:04:31 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/2 V2] fat: Convert to new mount api
In-Reply-To: <ef8519df-a1f4-4f90-9e42-0c8d91bd982d@redhat.com> (Eric Sandeen's
	message of "Mon, 1 Jul 2024 15:20:17 -0500")
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
	<2509d003-7153-4ce3-8a04-bc0e1f00a1d5@redhat.com>
	<72d3f126-ac1c-46d3-b346-6e941f377e1e@redhat.com>
	<87v81p8ahf.fsf@mail.parknet.co.jp>
	<216b2317-cec3-4cfd-9dc2-ed9d29b5c099@sandeen.net>
	<ef8519df-a1f4-4f90-9e42-0c8d91bd982d@redhat.com>
Date: Tue, 02 Jul 2024 14:04:31 +0900
Message-ID: <87r0cc8jvk.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> On 7/1/24 12:35 PM, Eric Sandeen wrote:
>> On 7/1/24 9:15 AM, OGAWA Hirofumi wrote:
>>> Eric Sandeen <sandeen@redhat.com> writes:
> I don't think that will work.
>
> For example, for the allow_utime adjustment...
>
> Before parsing begins, allow_utime is defaulted to -1 (unset) and
> fs_dmask is defaulted to current_umask()
>
> If we put the 
>
> +	if (opts->allow_utime == (unsigned short)-1)
> +		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
>
> test at the bottom of parse_param, then this sequence of parsing:
>
> ("mount -o fs_uid=42,fs_dmask=0XYZ")
>
> fs_uid=42
>  --> sets opts->allow_utime to (~opts->fs_dmask & (S_IWGRP | S_IWOTH))
>      where fs_dmask is default / current_umask()
> fs_dmask=0XYZ
>  --> changes fs_dmask from default, but does not update allow_utime which
>      was set based on the old fs_dmask
>
> leads to different results than:
>
> ("mount -o fs_dmask=0XYZ",fs_uid=42)
>
> fs_dmask=0XYZ
>  --> changes fs_dmask from the default
>      updates allow_utime based on this user-specified fs_dmask rather than default
> fs_uid=42
>  --> allow_utime is now set, so no further changes are made
>
> IOWS, the final allow_utime value may differ depending on the order of option
> parsing, unless we wait until parsing is complete before we inspect and adjust it.
>
> dhowells did, however, suggest that perhaps these adjustments should generally
> be done in get_tree rather than fill_super, so I'll give that a shot.
>
> Sound ok?

Ah, you are right. I was misread how parser works. And then your
original may be readable than get_tree.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

