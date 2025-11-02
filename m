Return-Path: <linux-fsdevel+bounces-66693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC5C2932C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 18:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 537F54E80A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41F2D9ECD;
	Sun,  2 Nov 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhT/8kc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3A1F4169
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762103195; cv=none; b=RMKcdmiH+2uepMm1aNZh0GynrrZSRyOMal8YhHF+HmnULspYZ1Wjn9uB1BBGOJ3Apur8zmGyue9uFYOExT2WWoG958EMaQdqtKINvmS3k4vV7+ib7ZNVjDPCuvNPMssN6L0mwd65DShq1JVnEX4JAaAUZbLsiDNsc22NnjKekL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762103195; c=relaxed/simple;
	bh=oedeZmsFxLhCFl1kUSF9/KJ/zIF/AaWI2eynqQGqXh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM4GKn6nPis37rvE9AEMqb+0Y0Io/oN+6qZrKGfpRGTT1W5iACkMf54WGXEYo+tA66GRXVffMfUbiR0vN89kvsuuqdm2YtP/NmrZ5SSiafskVO+KIa+zNqYR9e57XihvJooKZuOlV57H+YEwnCmu8AI57yb+7Xg3DFnmGqzeEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhT/8kc9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762103192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP4XinEpyvd8kaWWhUtBs6CxqYLY+EFwwqKCaZv/Q+U=;
	b=BhT/8kc9YEstHQuhb50HeVV18A6M5OwWUR4gFnGWxvG08uYdQ7O7G7oHOLAKyXYfUeWzzG
	VyFfz2IWaVTNq72rJYd7U+lu0Vdgyg/zHv8KNb/TQqYRxCV7L26e0IN7nLMNnnqiWdAZKd
	f5tWypq4zCkjORyr4BPE/9jHmP1ZDAI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98--iPxFb9KM8WqsRCXT3-xOQ-1; Sun,
 02 Nov 2025 12:06:07 -0500
X-MC-Unique: -iPxFb9KM8WqsRCXT3-xOQ-1
X-Mimecast-MFC-AGG-ID: -iPxFb9KM8WqsRCXT3-xOQ_1762103120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB6A619541B5;
	Sun,  2 Nov 2025 17:05:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.84])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B31AD1800576;
	Sun,  2 Nov 2025 17:05:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Nov 2025 18:04:01 +0100 (CET)
Date: Sun, 2 Nov 2025 18:03:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Yu Watanabe <watanabe.yu+github@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH 00/22] coredump: cleanups & pidfd extension
Message-ID: <20251102170353.GA3837@redhat.com>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/28, Christian Brauner wrote:
>
> Christian Brauner (22):
>       pidfs: use guard() for task_lock
>       pidfs: fix PIDFD_INFO_COREDUMP handling
>       pidfs: add missing PIDFD_INFO_SIZE_VER1
>       pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
>       pidfd: add a new supported_mask field
>       pidfs: prepare to drop exit_info pointer
>       pidfs: drop struct pidfs_exit_info
>       pidfs: expose coredump signal

I don't think these changes need my review... but FWIW, I see nothing
wrong in 1-8. For 1-8:

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


