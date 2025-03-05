Return-Path: <linux-fsdevel+bounces-43250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AEBA4FE3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A07170FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A61FDA73;
	Wed,  5 Mar 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR3n1HIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD024290A
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176435; cv=none; b=DRMZZnmSXtCNFLtOjCAXcmKfZN7e0IdfNw0LbYCyINek080BFYTjfRGm7Idix5FugPBJWyUFGmZ1HooSh73FdU1JK47JiNoJ+eMSwKYV5vBpwOaV/jV3E7HvrEL8L0BFzdxANtmbtlC5DKmL5E1JtQfsBqFmL06KbN09/SpCL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176435; c=relaxed/simple;
	bh=9RLf4dYMzb/QnWo4CUSDEibiPOQsIOYtbQSXgE1fo1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBsYmaAfNknFk4CsvMf2GTLcqSC08Sy9V+FptQRzJN2Vt3QZ5Cpy70rCIwVxkSZJ0TPcsTIksyD1rwFdB9TlgkYdOYkwTHPgInTHwiCYE74/o3VPCOHQRoyja+IbarU6KfZnoulUmm0oRxKf4YzojG+BNgj+FyaKB95P84P1vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR3n1HIr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741176432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw2By5fvbT84oLmpqGp7NRAQK/aTIT1EpTTu2ug9yF4=;
	b=CR3n1HIrGncyB98N2yXhcoc1UMX00oIq/acIGOnO2gsWe3DG+sbg7AshikkgkbhzoKIxbx
	ggddzDEOPDLuHh9SZ2HihS8guvBfUDz4fA6OLTeLN5qtzYrZy7wXC4t7RqEmumqAwKN0MW
	YeLWvyjMeC7LuO6aRyv9nR4yTyPlX4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-igj6t1GFNgKCCIweJqTBJA-1; Wed,
 05 Mar 2025 07:07:11 -0500
X-MC-Unique: igj6t1GFNgKCCIweJqTBJA-1
X-Mimecast-MFC-AGG-ID: igj6t1GFNgKCCIweJqTBJA_1741176430
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C95111800259;
	Wed,  5 Mar 2025 12:07:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.66])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 394651954B32;
	Wed,  5 Mar 2025 12:07:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Mar 2025 13:06:39 +0100 (CET)
Date: Wed, 5 Mar 2025 13:06:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 00/16] pidfs: provide information after task has been
 reaped
Message-ID: <20250305120622.GA30741@redhat.com>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/05, Christian Brauner wrote:
>
> Christian Brauner (16):
>       pidfs: switch to copy_struct_to_user()
>       pidfd: rely on automatic cleanup in __pidfd_prepare()
>       pidfs: move setting flags into pidfs_alloc_file()
>       pidfs: use private inode slab cache
>       pidfs: record exit code and cgroupid at exit
>       pidfs: allow to retrieve exit information
>       selftests/pidfd: fix header inclusion
>       pidfs/selftests: ensure correct headers for ioctl handling
>       selftests/pidfd: expand common pidfd header
>       selftests/pidfd: add first PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add second PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add third PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add fourth PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add fifth PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add sixth PIDFD_INFO_EXIT selftest
>       selftests/pidfd: add seventh PIDFD_INFO_EXIT selftest

I see nothing wrong in V3. For 1-6

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


