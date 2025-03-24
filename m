Return-Path: <linux-fsdevel+bounces-44887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08CA6E245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E483A757E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6C264A86;
	Mon, 24 Mar 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtKujzQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526D2641F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840889; cv=none; b=PWnpvXC2sYJNyj6HckUu0Pv8WMfMJqOOQNag5aLotlxkhkI3k/6r6FuGxTEJxJxupV1sYM4BtOOfSMvyiwZYCMsZ1i+GZZgoV+xNzSl9zcUvDyGh0RKkppHMRKxBiSvcA+nnmM7EdrAQnNG8SLY3Ef3GvV8OCanWA3wbxgevnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840889; c=relaxed/simple;
	bh=xKXLckG3JcEYiJLm25eTT4GpebPkKVPJ6WMyBA2uJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0HkcvtZHeshPMggQrJvRORfvsX8+bUBIaIzXIwbHVRs8JakvTVfRXpk4xF10z4L0owgkz31bIdRtu5OOkNz/Tieu0s/1EV+Zd02pEJEFCZ1VE6t5px8F0W8KB7bLFJMjeSHBjV89zKOUo6QCCIV2WP0QRTAr2gJHclfQKM3NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtKujzQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742840886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKXLckG3JcEYiJLm25eTT4GpebPkKVPJ6WMyBA2uJV0=;
	b=NtKujzQ1NYXkyUeA1NKYWrp0wH15amtiZ/yIjN1GUyXdVw3k7aQk1L/Ev51yEPQs7qB4J0
	rxKidp2qx4+kPBWSyzC+hxC0cag73fbEp0C2RUv7U7xAJbOY/y2Yppfws5OKwKnk9fhMHt
	x3SHuFxutkF9khhYtdAWbRF4lBYZl+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-Nv2AS9tqP9uVkEWzJ_qCJA-1; Mon,
 24 Mar 2025 14:28:02 -0400
X-MC-Unique: Nv2AS9tqP9uVkEWzJ_qCJA-1
X-Mimecast-MFC-AGG-ID: Nv2AS9tqP9uVkEWzJ_qCJA_1742840881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1534180AF55;
	Mon, 24 Mar 2025 18:28:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B5869180B48C;
	Mon, 24 Mar 2025 18:27:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Mar 2025 19:27:27 +0100 (CET)
Date: Mon, 24 Mar 2025 19:27:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250324182722.GA29185@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/24, Mateusz Guzik wrote:
>
> I had cursory glances at this code earlier and the more I try to
> understand it the more confused I am.

You are not alone ;)

> Per my other e-mail the obvious scheme would serialize all execs
> sharing ->fs and make copy_fs do a killable wait for execs to finish.
> Arguably this would also improve userspace-visible behavior as a
> transient -EBUSY would be eliminated.

I had the same feeling years ago. Why didn't I do it? I can't recall.
Perhaps because I found some problem in this idea, but most probably
because I failed to make the correct and simple patch.

> is there a problem getting this done even for stable kernels? I
> understand it would be harder to backport churn-wise, but should be
> much easier to reason about?

I won't argue with another solution. But this problem is quite old,
unless I am totally confused this logic was wrong from the very
beginning when fs->in_exec was introduced by 498052bba55ec.

So to me it would be better to have the trivial fix for stable,
exactly because it is trivially backportable. Then cleanup/simplify
this logic on top of it.

Oleg.


