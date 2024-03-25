Return-Path: <linux-fsdevel+bounces-15261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CB88B571
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 00:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3482B662F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD1D6EB60;
	Mon, 25 Mar 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="VaDEcqoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD96D1B4;
	Mon, 25 Mar 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402309; cv=pass; b=MquG1fKqgotoeRILD6lqCI3zVJC6wEZQSIH3ereYRbNm5qpxT5XS7uP6iYPL2FuArRRjZ6elpEP7/Am9uA3qtE1Kxqp24QEAhvfXEYUOgMMtYtIhHQTou4/pHcoyedhlF0p3AS999JLH2y/bzfA/NjL0QuyPSGzuvaRg7ngtsc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402309; c=relaxed/simple;
	bh=jM8DE0qFFQaJbtgDolpV6bNT0zgeGrR+Odr5JnEP7JE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=JQMuNHcyea65aNcDmz3BLKlqmbuk/Rr0om96ApenfDZtYdK9XUqwfdUnEzjA3xW4pCM3F1BmcJI2MHFVMrKN3HFAPRu5bRgpbXrnaP6aRHGEbg6dzbHSmxhIR6A3NtbIuaDTR//1mGr3Y2ufzRcxsTZQqyWDxFSf1E94/Xc7uPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=VaDEcqoR; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <072a3e1b9f40a44174f0738bf592a528@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711402305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxBkMuWBbb/HgWApjXW5r8lNYj02xvMJWQoocF0dLg=;
	b=VaDEcqoR/iQn20ivyB6qKpzWuAhrid8TWvhBgmBTPQtmXjCM9sXby9gHn/MyuwDH3cJKX6
	792OfXZsOEECPjY/NN7kSH34h2fgOEpUyBopztxqyXx6gjPDmbZsVIBcamEle/lqPgnB5U
	3dkQ+YX8FOT2OSkbGvJi9ok+Xk0nQDMzF6xe3m0U1OXCd8oi08Zx/q7hzfp0dOBylpu9JS
	Y/jULULETYvogwV7tdznJdqSnnMUsyvN+JNuLgJIitPZ2jeS7Y2yGAg+Iz6kR1seSv1YYf
	99qWq4OsxYUKbRJS7T0RPcqk/RN/LuiP0c93696giecqNAx21GzW7mNUJGPSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711402305; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxBkMuWBbb/HgWApjXW5r8lNYj02xvMJWQoocF0dLg=;
	b=T7APEAYUuDTM6KUiKx1UI2w1ZudxjgYPPWNbzhAMNyeUmHUUY0il18Pum/kgOO6PJkLNMr
	R2RmY2eCg7/22pwprXOCJThJArpxU0o2nXdapKnMAkfGR415DegGNF7oSqIjLrv02iCJeX
	uKqy0mEJmGLs4f2ztE6+0P9CNpcB8QBt345yVqrj4pcXcC+etnJhxpUFpsfgVDQWVGZqIX
	L/ZK0p1BV1pdbcrAtcaSVfbP659t2UOBAGyT6KJSfqc7WS3xr7NEC6JItR9Y8L1n+Fw54P
	hK5v5WaDL8c4g/BstbV+5dEuJGXT4B2vvFlC+7iqKHHBfEvBaCAGY+fM3mBgWA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1711402305; a=rsa-sha256;
	cv=none;
	b=Uj7D4acrZpkcjfPnAjNwrjb2g0SfxqONscDsMCo1DiYUg8KNGGp5v7kzdBrVkdprStS1A8
	k4FSOeUVYVw1+kGLYLLt6pxzvvjV7PgJzOS7DW6wjquYPXkxdxMgaPQ3fxhBdn5IiSgc6z
	NpgPOEm06ZuvGs63moGxGsvkQOHcydUbd4igNfXqxXwDbpJHRt4L/iCwM6XnTVBFVN5QHU
	QRXTGlICiVRo6p/G5gNQrHkPq/Fg9xOJSZQBqn9r0hKVFFBAxKlssdscnXJqCfhrJ5+dFD
	Tgq8A05S3m2TBek7szKUOmRkcIT0uNBimUpHexjsb/GwAUcDVD+t7tKdfGwTsA==
From: Paulo Alcantara <pc@manguebit.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Roberto Sassu
 <roberto.sassu@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS
 <linux-cifs@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
 Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
In-Reply-To: <20240325211305.GY538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
 <20240325195413.GW538574@ZenIV>
 <a5d0ee8c54ec2f80cb71cd72e3b4aec3@manguebit.com>
 <20240325211305.GY538574@ZenIV>
Date: Mon, 25 Mar 2024 18:31:42 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Mar 25, 2024 at 05:47:16PM -0300, Paulo Alcantara wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>> 
>> > On Mon, Mar 25, 2024 at 11:26:59AM -0500, Steve French wrote:
>> >
>> >> A loosely related question.  Do I need to change cifs.ko to return the
>> >> pointer to inode on mknod now?  dentry->inode is NULL in the case of mknod
>> >> from cifs.ko (and presumably some other fs as Al noted), unlike mkdir and
>> >> create where it is filled in.   Is there a perf advantage in filling in the
>> >> dentry->inode in the mknod path in the fs or better to leave it as is?  Is
>> >> there a good example to borrow from on this?
>> >
>> > AFAICS, that case in in CIFS is the only instance of ->mknod() that does this
>> > "skip lookups, just unhash and return 0" at the moment.
>> >
>> > What's more, it really had been broken all along for one important case -
>> > AF_UNIX bind(2) with address (== socket pathname) being on the filesystem
>> > in question.
>> 
>> Yes, except that we currently return -EPERM for such cases.  I don't
>> even know if this SFU thing supports sockets.
>
> 	Sure, but we really want the rules to be reasonably simple and
> "you may leave dentry unhashed negative and return 0, provided that you
> hadn't been asked to create a socket" is anything but ;-)

Agreed :-)

>> > Note that cifs_sfu_make_node() is the only case in CIFS where that happens -
>> > other codepaths (both in cifs_make_node() and in smb2_make_node()) will
>> > instantiate.  How painful would it be for cifs_sfu_make_node()?
>> > AFAICS, you do open/sync_write/close there; would it be hard to do
>> > an eqiuvalent of fstat and set the inode up?
>> 
>> This should be pretty straightforward as it would only require an extra
>> query info call and then {smb311_posix,cifs}_get_inode_info() ->
>> d_instantiate().  We could even make it a single compound request of
>> open/write/getinfo/close for SMB2+ case.
>
> 	If that's the case, I believe that we should simply declare that
> ->mknod() must instantiate on success and have vfs_mknod() check and
> warn if it hadn't.

LGTM.

Steve, any objections?

