Return-Path: <linux-fsdevel+bounces-31679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C399A0F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA8B25DD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCB210C2C;
	Fri, 11 Oct 2024 10:13:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C319210C19;
	Fri, 11 Oct 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641580; cv=none; b=NHB9VqLfg3CAj8tAT0iGGwWv5py+KXLnLnmeaaLlwdp0IeacI+fD9TD4Dp9FO9TFBi8G35pt7L7uv6pFRP618hgExdaoqO1go4FfkXhz24R+JE4GYo+ABPTFt7s6L9osmvU7Q/1H1RjbUWTvVqE/YkR/uuG3QV8IJY0pGOanYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641580; c=relaxed/simple;
	bh=FxwPMqz9jqHmQNGZ8DCNJY505mhVjOoYhju2JuB1T40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKBKHi81FMKlvtXhfgnbsKzcbfB09uLfYMWN7K1cp8UWngym5xNCBv+b84K9pmAjzNarYkiDQxdoo6I3s57hBSgA9rqGVSR/ZZHrmgh3Dk4dnYrO4v9KE2JjEoDeAhqkcOaEhVMyyCUvHYHgHAHdBXvoAtyrR08dr8b7LSW7eSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49BACIpi050471;
	Fri, 11 Oct 2024 19:12:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49BACHdD050464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Oct 2024 19:12:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
Date: Fri, 11 Oct 2024 19:12:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20241010152649.849254-1-mic@digikod.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/11 0:26, Mickaël Salaün wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid shown
> to user space with getattr(), other part of the kernel may still expose
> the private inode->ino through kernel logs and audit.

I can't catch what you are trying to do. What is wrong with that?

> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64 bits.

Currently, ino_t is 32bits on 32-bit architectures, isn't it?
Why do you need to use 64bits on 32-bit architectures?

> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of an
> inode number.  inode_get_ino() is called by generic_fillattr().

What does the user space's view of an inode number mean?
What does the kernel space's view of an inode number mean?


