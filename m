Return-Path: <linux-fsdevel+bounces-44595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8DA6A884
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F038A101B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA62236E8;
	Thu, 20 Mar 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfCbgHwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36A21D5B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480941; cv=none; b=NTu59e49Duc1OzCh4clZ4ll7eo6VDK2mz/E0crLGBn2P3aBWDKUz7I0h6lyHyzg4E6OhUtslLJc+y7hmVpqb5kZuxx+Qr+0byG69FxmM4nUBuYWqEw7YBpnQRhVQz83cyC+qqhBu8wqjMzBpmw706RuyuqOibY7Jf+6+ao0fQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480941; c=relaxed/simple;
	bh=qqFuMihvU/vsD0CG0K8GtCxouXSAGMzBJhm6zySHkSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omU0QMn1MHuUcS5MxN20zg7AAO9rghIpZMq3+HnsRuSqNH5vVoTy/lUytw4MM2xfywW3n9pUSuwb9RYC3/adYLkAL6aG8f7ZHW0BnzpRn2/PZ39cJxCP157+Z4FnSXxR3YIg9/oyEipR1bpoYCmwpYaOoqyLMCkh33oNnj4v+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfCbgHwF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742480939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smcKbFhDAt6iyAdl+UHuRdI4tE2IxZD3l92n/lPXjAE=;
	b=GfCbgHwFDYU7cLmIOCNv0YEyeiUnVSu5Vgh5yFGNwn0osJLmrQX+gDO+ovb/0J0Or84S+k
	Qr51G6Ka0IkLGbLEzlJvTFMq/vzC+xydd6jiwqNWXpo83az8ULQIpPXB1hqKRFkkMDI43c
	7Xcn7camhSyiTrsAetjk5pcc8Sfwb5w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-c8n173r2OqW1YcpW9h_-7Q-1; Thu,
 20 Mar 2025 10:28:55 -0400
X-MC-Unique: c8n173r2OqW1YcpW9h_-7Q-1
X-Mimecast-MFC-AGG-ID: c8n173r2OqW1YcpW9h_-7Q_1742480934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7B618EBE8F;
	Thu, 20 Mar 2025 14:28:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BC7623001D16;
	Thu, 20 Mar 2025 14:28:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Mar 2025 15:28:21 +0100 (CET)
Date: Thu, 20 Mar 2025 15:28:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v4 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320142817.GE11256@redhat.com>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250320-work-pidfs-thread_group-v4-1-da678ce805bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-work-pidfs-thread_group-v4-1-da678ce805bf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/20, Christian Brauner wrote:
>
> Co-Developed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c      | 9 +++++----
>  kernel/exit.c   | 6 +++---
>  kernel/signal.c | 3 +--
>  3 files changed, 9 insertions(+), 9 deletions(-)

Thanks, LGTM.

Todo:

	- As we already discussed, do_notify_pidfd() can be called
	  twice from exit_notify() paths, we can avoid this.

	  But this connects to another minor issue:

	- With this change, debuggers can no longer use PIDFD_THREAD.
	  I guess we don't really care, I don't think PIDFD_THREAD was
	  ever used for this purpose. but perhaps we can change this
	  or at least document somewhere...

I'll try to do this but not today and (most probably) not tomorrow.

Oleg.


