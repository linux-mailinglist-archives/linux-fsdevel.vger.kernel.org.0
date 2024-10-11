Return-Path: <linux-fsdevel+bounces-31686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA499A211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7471F22F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD749213ED3;
	Fri, 11 Oct 2024 10:55:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD4212EE0;
	Fri, 11 Oct 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644117; cv=none; b=g/Yxj6xihw5tZM6gyiADo4QKKinwtwmqMsBStHfqk6/h0X9KLXj9QI2q3iM9ChbyuD8lEF9gGo8KFP84HBO2l5SJxIKvdum3YvUkfkIHt4V2sNx1AgP7FSQ241smH9X2e7wjyA5I4VA5V4RInhIODD/c/Y++fwqCA1iIT7vnEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644117; c=relaxed/simple;
	bh=o1UxxF77W2DeqnYVIgmDfhMh70vkM3V+7XbHkdXn5a8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CaOyha9t4KEKrM+UdHXuo+IhVP58dhw9yNXiyRZxT0Yrk9o7VZuXPL8LqaRrjjsQG1AiDxBIkD4kBZgbhjHzoRVkEdDb9Ryi9lJ66i5OLKIVMzNgfw03ETfsf0H+XzrTKnUFEUXdfX31VlzjMbAqhZQ2Ar/Tq1qqVAELPguqEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49BAswgL064962;
	Fri, 11 Oct 2024 19:54:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49BAswn6064959
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Oct 2024 19:54:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a5fb2a24-d109-41fd-b00a-afe5280b6ffc@I-love.SAKURA.ne.jp>
Date: Fri, 11 Oct 2024 19:54:58 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/11 19:12, Tetsuo Handa wrote:
> On 2024/10/11 0:26, Mickaël Salaün wrote:
>> When a filesystem manages its own inode numbers, like NFS's fileid shown
>> to user space with getattr(), other part of the kernel may still expose
>> the private inode->ino through kernel logs and audit.
> 
> I can't catch what you are trying to do. What is wrong with that?
> 
>> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
>> whereas the user space's view of an inode number can still be 64 bits.
> 
> Currently, ino_t is 32bits on 32-bit architectures, isn't it?
> Why do you need to use 64bits on 32-bit architectures?

Changing from 32bits to 64bits for communicating with userspace programs
breaks userspace programs using "ino_t" (or "unsigned long") for handling
inode numbers, doesn't it? Attempt to change from %lu to %llu will not be
acceptable unless the upper 32bits are guaranteed to be 0 on 32-bit
architectures.

Since syslogd/auditd are not the only programs that parse kernel logs and
audit logs, updating only syslogd/auditd is not sufficient. We must not break
existing userspace programs, and thus we can't change the format string.

> 
>> Add a new inode_get_ino() helper calling the new struct
>> inode_operations' get_ino() when set, to get the user space's view of an
>> inode number.  inode_get_ino() is called by generic_fillattr().
> 
> What does the user space's view of an inode number mean?
> What does the kernel space's view of an inode number mean?
> 


