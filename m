Return-Path: <linux-fsdevel+bounces-31726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205399A64D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC39B1F22893
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45736219C8B;
	Fri, 11 Oct 2024 14:28:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E8212F13;
	Fri, 11 Oct 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656894; cv=none; b=HMBcsIp8d448c4/pUuyFPbguB8PTjtyZyIcWgfd5hL2Vk4w05uqX+tB0gZU59i7Q4fPdvWWLhJAYNVMzTwQW9xJzyRPoBAWoChRvi2KtJbDCWtuDOwaG34v/dLOpe3zmK8BBDnj5j4QLrHMwEX7m5LgxPTwL59gyErQyH/AxaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656894; c=relaxed/simple;
	bh=+g+0LIBGUCEHu4NvhOKBtkjnBi25i2JDzjoPYMCQ4h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtcTu2Hwy/eQ2KHYXomgKHx+xRMNCRTnKfJ1J5fyAImStdG5IpSHX/eKNQI7ZwOA8u47J2qMURGoW0ZVsbjrTdnukbXaT6+cOh07/7rerRZxt2b7DlceLmOxxGluw7gyRyJ9UuUXU9UzbnO4V9GA1cWaxTWfoqMsvy7HlavOvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49BERmJD041800;
	Fri, 11 Oct 2024 23:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49BERmnt041797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Oct 2024 23:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7b379fd1-d596-4c19-80fc-53838175834e@I-love.SAKURA.ne.jp>
Date: Fri, 11 Oct 2024 23:27:45 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
 <20241011.Di7Yoh5ikeiX@digikod.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241011.Di7Yoh5ikeiX@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/11 20:04, Mickaël Salaün wrote:
> On Fri, Oct 11, 2024 at 07:12:17PM +0900, Tetsuo Handa wrote:
>> On 2024/10/11 0:26, Mickaël Salaün wrote:
>>> When a filesystem manages its own inode numbers, like NFS's fileid shown
>>> to user space with getattr(), other part of the kernel may still expose
>>> the private inode->ino through kernel logs and audit.
>>
>> I can't catch what you are trying to do. What is wrong with that?
> 
> My understanding is that tomoyo_get_attributes() is used to log or
> expose access requests to user space, including inode numbers.  Is that
> correct?  If yes, then the inode numbers might not reflect what user
> space sees with stat(2).

Several questions because I've never seen inode number beyond UINT_MAX...

Since "struct inode"->i_ino is "unsigned long" (which is 32bits on 32-bit
architectures), despite stat(2) is ready to receive inode number as 64bits,
filesystems (except NFS) did not use inode numbers beyond UINT_MAX until now
so that fs/stat.c will not hit -EOVERFLOW condition, and that resulted in
misuse of %lu for e.g. audit logs?

But NFS was already using inode numbers beyond UINT_MAX, and e.g. audit logs
had been recording incorrect values when NFS is used?

Or, some filesystems are already using inode numbers beyond UINT_MAX but the
capacity limitation on 32-bit architectures practically prevented users from
creating/mounting filesystems with so many inodes enough to require inode
numbers going beyond UINT_MAX?



You are trying to fix out-of-sync between stat(2) and e.g. audit logs
rather than introducing new feature, aren't you?

Then, what you are trying to do is OK, but TOMOYO side needs more changes.
Since TOMOYO is currently handling any numeric values (e.g. uid, gid, device
major/minor number, inode number, ioctl's cmd number) as "unsigned long",
most of "unsigned long" usage in TOMOYO needs to be updated to use "u64"
because you are about to change inode number values to always-64bits.


