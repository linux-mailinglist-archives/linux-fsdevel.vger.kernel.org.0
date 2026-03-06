Return-Path: <linux-fsdevel+bounces-79561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PH2NA0mqmkPMAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:55:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710521A0ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08037309CCBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84E2F60A7;
	Fri,  6 Mar 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpyL1Aba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09412F12CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758406; cv=none; b=W5Nuq1ShWTmGyZLqu0ylANtOKYmNt0JbgbvpAzHxrU18TBdF9YxhC/be/5ou3Zy8j5WJB14pcarwmpxIoXnJ+IDQHne7t+zJY1NMI2r6axfsVfXpDjgOrsiCi0vlmAbqem4IOHy2/x57QHxSwuPdeT2xbGJ1uuWw91/q2QkH+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758406; c=relaxed/simple;
	bh=q+1OHkZxuaWPjZLatNGpXSxU4+CbbXGnHjb3Ye+yGiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmhAjkZR6McQvPoTC5bz4SdAx3DpSRGWz0lyurEE4Pw+5V/Zj2FYLZtHWeB+pU0kHXtJH7YY6Ru+GaaeJTkV/r0MruDJCMDHOMoA0M2WNtEp8AAaIOcp9kcSEji4aaWQYbrQK1mHcUTzLgtbiBi/AF81V41cJkL22Y7LhTOaH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpyL1Aba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772758403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My480qFBpGNx50hRnNAsXaFyKvXvDH1yGohElc/bFek=;
	b=bpyL1AbaKaZpKyRUjHB4kYI8rCc65vUr5dAZCeMKXqFX+Di+c8GY+ql0v6ZHtxqw0zKraU
	l3Ry0e3zc3W3vDZZu3Y7wrHKvXuoZb2eP5tBca7e4SVcR6pHHWNajIfjNRa+WOnvaXB2bp
	K62Pl5TmOi6F9CNhqze1plNZwVzfd0o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-qrluC5POMC-PjA9ucEVRag-1; Thu,
 05 Mar 2026 19:53:20 -0500
X-MC-Unique: qrluC5POMC-PjA9ucEVRag-1
X-Mimecast-MFC-AGG-ID: qrluC5POMC-PjA9ucEVRag_1772758399
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E78C919560B7;
	Fri,  6 Mar 2026 00:53:18 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB0301800762;
	Fri,  6 Mar 2026 00:53:16 +0000 (UTC)
Message-ID: <886ceaf1-16dd-4403-bfaf-5164a598a20d@redhat.com>
Date: Thu, 5 Mar 2026 19:53:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] fs, audit: Avoid excessive dput/dget in
 audit_context setup and reset paths
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260228182757.90528-1-longman@redhat.com>
 <20260305-vorlieben-gefesselt-1673d7845270@brauner>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260305-vorlieben-gefesselt-1673d7845270@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 4710521A0ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79561-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 4:46 PM, Christian Brauner wrote:
> On Sat, Feb 28, 2026 at 01:27:55PM -0500, Waiman Long wrote:
>>   v4:
>>    - Add ack and review tags
>>    - Simplify put_fs_pwd_pool() in patch 1 as suggested by Paul Moore
>>
>>   v3:
>>    - https://lore.kernel.org/lkml/20260206201918.1988344-1-longman@redhat.com/
>>
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
>> This patch series aim to avoid this type of performance regression caused
>> by audit by adding a new set of fs_struct helpers to reduce unncessary
>> path_get() and path_put() calls and the audit code is modified to use
>> these new helpers.
> Tbh, the open-coding everywhere is really not very tasteful and makes me
> not want to do this at all. Ideally we'd have a better mechanism that
> avoids all this new spaghetti in various codepaths.
>
> In it's current form I don't find it palatable. I added a few cleanups
> on top that make it at least somewhat ok.

Thanks for the cleanup patches. They all look good to me.

Reviewed-by: Waiman Long <longman@redhat.com>


