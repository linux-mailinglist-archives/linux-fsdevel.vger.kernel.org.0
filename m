Return-Path: <linux-fsdevel+bounces-42899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E73A4B1C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 14:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1118929C8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A31E5B6C;
	Sun,  2 Mar 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeu8EcGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6A1BD00C
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921024; cv=none; b=CFVpHXelxNdjtMpRY6Vl8hssi8svKGiKCtUtTrcFZSWFmsDKpHD1O7/FTAwP6TXKq//eBcm+9qBdyvMq+Hg5DoO9bi16pqcChK0igTGR5yA3J53TGI0Pvd6FmUmIBg2w5gUotPwtcSTgMc+puwg+hRjts9/Eucpv0MisTPW8q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921024; c=relaxed/simple;
	bh=e5t/br0Z1HHj8tzxzwrk5/bTTpSf9QRZoi55vbXWeu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGcwL0lKbatuMz5Il2CePkDJJL6kIUW+d+VVruz67NZCRpODS1stwZweteTuDlnZRjN10wBudUVFJatBfPUOvZrpeu0YyIg+QZtfkFENNmIxVq9rcUamE8cXKTBX6D/mtkXXX4pMUpLx9Xd/LKtgDqQdfB2IInLDHTw2XbeCJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeu8EcGB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740921020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clwr5UHAVnDniH48NwP08kvc7NXJrgbt38kUSnNT80c=;
	b=aeu8EcGBwjp4u6WnWlgXxrlEH+5MejXiDiFfv6KYKq/Plm+OltpxjBe/NnZoB69XV3JNJI
	Q38ck7/2HEfD2LuR8Fzbq7boNI7RRCPijj9Q3hbTIkmODNc8b1zSiRO1HH6Hq5j7mduhyX
	kQ5xdNuquNm6Rda/2uAg2E7CbzgtZ9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-ohFscfswOuKH16302HqS6Q-1; Sun,
 02 Mar 2025 08:10:12 -0500
X-MC-Unique: ohFscfswOuKH16302HqS6Q-1
X-Mimecast-MFC-AGG-ID: ohFscfswOuKH16302HqS6Q_1740921011
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0AA3180034E;
	Sun,  2 Mar 2025 13:10:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5055C19560AB;
	Sun,  2 Mar 2025 13:10:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 14:09:40 +0100 (CET)
Date: Sun, 2 Mar 2025 14:09:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 03/10] pidfs: move setting flags into
 pidfs_alloc_file()
Message-ID: <20250302130936.GB2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/28, Christian Brauner wrote:
>
> @@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  		return ERR_PTR(ret);
>
>  	pidfd_file = dentry_open(&path, flags, current_cred());
> +	/* Raise PIDFD_THREAD explicitly as dentry_open() strips it. */
                                            ^^^^^^^^^^^^^^^^^^^^^^^
Hmm, does it?

dentry_open(flags) just passes "flags" to alloc_empty_file()->init_file(),
and init_file(flags) does

	f->f_flags      = flags;

so it seems that

> @@ -2042,11 +2042,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>  	if (IS_ERR(pidfd_file))
>  		return PTR_ERR(pidfd_file);
>
> -	/*
> -	 * anon_inode_getfile() ignores everything outside of the
> -	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
> -	 */
> -	pidfd_file->f_flags |= (flags & PIDFD_THREAD);

we can just kill this outdated code?

Oleg.


