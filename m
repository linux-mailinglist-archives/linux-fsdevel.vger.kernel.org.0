Return-Path: <linux-fsdevel+bounces-78836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFC3NDVKo2nW/AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:04:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D871C7DBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 164CA30B89C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FB35DA6F;
	Sat, 28 Feb 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCfcJdQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914A35DA6C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304148; cv=none; b=EQuLFxzJ+9iGEQdn8sB19JTy3pVbvCI9mmtcgabdi7AFomjrtmp+LNTqYxUlB/A3KcHaabbCIjtel6ns8E89RM0qOoNkp5/zhBtVMbwnLynYCcFbz9WsyxMNWnX7qwPStOq83t/n41Kba9ELemQQVhUa8gYWfI3EQTnlICdXuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304148; c=relaxed/simple;
	bh=fv2lYk+RQp2QQElmPQdKpUeZJLY4GF8Qnc0oQSdqxVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=po5Jq+2kdfgZLRGPrRANFRH6F2rUGlj82JUqR0BYKi+Vmva6y2JONs95RWTx8dpkktNRP6A34fjExtDWOBTg19iagff/VS7NYdTbdS394aqC0kGSLKtT/V0ugFOQOUsABn5vY76orA/Qoj6zuDcg9tqJZwqbgCFamqn+o42tKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCfcJdQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772304143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEU7HuMNHAAJLrz/KOTpjg/+IOVIO36NIMGTmbHVTd8=;
	b=BCfcJdQ6CYVwTB1U5jr2SH1gATdp4FoOMiUo/MmiSWeqnXpt1R5V5gNuXapjKLE0CbJ5Gf
	MeJOJHYP0vLX+X2rwiVFCuW8NuVz/uE3dWulBVPhh4apq+GtJYfoFnF5FQn9QuM12KBYSJ
	u1ym7NT5olMzdFKGndA4dcTVY7h1j9Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-ajFcKkRFPv-5jtzLV11ueQ-1; Sat,
 28 Feb 2026 13:42:19 -0500
X-MC-Unique: ajFcKkRFPv-5jtzLV11ueQ-1
X-Mimecast-MFC-AGG-ID: ajFcKkRFPv-5jtzLV11ueQ_1772304138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27D0118004BB;
	Sat, 28 Feb 2026 18:42:18 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5412230001B9;
	Sat, 28 Feb 2026 18:42:15 +0000 (UTC)
Message-ID: <e4b0a196-ec20-48ec-adc1-2d995e27a0ff@redhat.com>
Date: Sat, 28 Feb 2026 13:42:14 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] fs: Add a pool of extra fs->pwd references
 to fs_struct
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260206201918.1988344-1-longman@redhat.com>
 <20260212180820.2418869-2-longman@redhat.com>
 <CAHC9VhTA+b1sdg88o1wXgMUcPDpxd_nQYc-aPEcBuzUuNVz+ag@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAHC9VhTA+b1sdg88o1wXgMUcPDpxd_nQYc-aPEcBuzUuNVz+ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78836-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1D871C7DBE
X-Rspamd-Action: no action

On 2/19/26 5:20 PM, Paul Moore wrote:
> On Thu, Feb 12, 2026 at 1:09 PM Waiman Long <longman@redhat.com> wrote:
>> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
>> calls to get references to fs->pwd and then releasing those references
>> back with path_put() later. That may cause a lot of spinlock contention
>> on a single pwd's dentry lock because of the constant changes to the
>> reference count when there are many processes on the same working
>> directory actively doing open/close system calls. This can cause
>> noticeable performance regresssion when compared with the case where
>> the audit subsystem is turned off especially on systems with a lot of
>> CPUs which is becoming more common these days.
>>
>> A simple and elegant solution to avoid this kind of performance
>> regression is to add a common pool of extra fs->pwd references inside
>> the fs_struct. When a caller needs a pwd reference, it can borrow one
>> from pool, if available, to avoid an explicit path_get(). When it is
>> time to release the reference, it can put it back into the common pool
>> if fs->pwd isn't changed before without doing a path_put(). We still
>> need to acquire the fs's spinlock, but fs_struct is more distributed
>> and it is less common to have many tasks sharing a single fs_struct.
>>
>> A new set of get_fs_pwd_pool/put_fs_pwd_pool() APIs are introduced
>> with this patch to enable other subsystems to acquire and release
>> a pwd reference from the common pool without doing unnecessary
>> path_get/path_put().
>>
>> Besides fs/fs_struct.c, the copy_mnt_ns() function of fs/namespace.c is
>> also modified to properly handle the extra pwd references, if available.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   fs/fs_struct.c            | 26 +++++++++++++++++++++-----
>>   fs/namespace.c            |  8 ++++++++
>>   include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
>>   3 files changed, 58 insertions(+), 6 deletions(-)
> ...
>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index c58674a20cad..a2323ba84d76 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -40,6 +41,33 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
>>          read_sequnlock_excl(&fs->seq);
>>   }
>>
>> +/* Acquire a pwd reference from the pwd_refs pool, if available */
>> +static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
>> +{
>> +       read_seqlock_excl(&fs->seq);
>> +       *pwd = fs->pwd;
>> +       if (fs->pwd_refs)
>> +               fs->pwd_refs--;
>> +       else
>> +               path_get(pwd);
>> +       read_sequnlock_excl(&fs->seq);
>> +}
>> +
>> +/* Release a pwd reference back to the pwd_refs pool, if appropriate */
>> +static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
>> +{
>> +       bool put = false;
>> +
>> +       read_seqlock_excl(&fs->seq);
>> +       if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt))
>> +               fs->pwd_refs++;
>> +       else
>> +               put = true;
>> +       read_sequnlock_excl(&fs->seq);
>> +       if (put)
>> +               path_put(pwd);
>> +}
> This is a nitpick, and perhaps I'm missing something, but I think you
> could skip the local 'put' boolean by setting 'pwd' to NULL in the
> pool case, e.g.
>
> static inline void put_fs_pwd_pool(fs, pwd)
> {
>    read_seqlock_excl(&fs)
>    if (fs == pwd) {
>      fs->pwd_refs++
>      pwd = NULL
>    }
>    read_sequnlock_excl(&fs)
>    if (pwd)
>      path_put(pwd)
> }

Thanks for the suggestion. It does make the function simpler. I have 
included that change in my v4 patch.

Al & Christian, are you OK with taking these patches for the next v7.1 
release or do you have other suggested changes you would like to see?

Thanks,
Longman


