Return-Path: <linux-fsdevel+bounces-38984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC2A0A843
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0C83A80BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54119E968;
	Sun, 12 Jan 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goh6LFI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2719F115
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678210; cv=none; b=YUedG0EtayC0bWv01qB0PgT9teB4aDMtlqF+bI17WaIRMxpW3q/W965WAfJqTicUFHXgvP62jU1XPkQide0qDTJq2OcvldvIBAbIhf+aisNI9TGsOzo2Y12qO2EhFlAv8APEKb6YWrbHaoSgk4T1Wj6CA2t7G8quQQlRve7q/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678210; c=relaxed/simple;
	bh=REgFctRGG2i+aWyJ1ZRxJ6TwTZBV1cOPjFQdvPEnzK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mziqdLOPSk3ZIutYqPi8wSUsNG3+Y1Ke5RNj9Oc/wFu1GeF95x6yIAfq9nWO56VFBu1ODpBhUjRhaaZJmn/7tXCm9e5a6eMnHHyEtlk8DWi5URUFHRMXssLoOr9roN+PKVb0y4guqJXm418bMQmniOiiGnqVokPhlhyfEg/PtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goh6LFI0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736678207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjZIf+MqzlX40O8hdTacUc+jXg2UIC0x4trWd6422To=;
	b=goh6LFI0BorCJNDiSrzjPNHTJPbuCbid6WOTNGhx7jU99Bm5zzdEvIo168uYZTDDpGuBp7
	UnSKNw3LiOYAUyn9/jY+Hj8q5VKzPF7uEs6j9R1lDkNz92IQ3905eGmtInMMCNrgQLCm/E
	LGMY9P8MDhWMPusJynLhGLHCy3iH3k8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-0DSN8VPiNBSr_DA-YHIeIA-1; Sun,
 12 Jan 2025 05:36:43 -0500
X-MC-Unique: 0DSN8VPiNBSr_DA-YHIeIA-1
X-Mimecast-MFC-AGG-ID: 0DSN8VPiNBSr_DA-YHIeIA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2F3A19560BB;
	Sun, 12 Jan 2025 10:36:36 +0000 (UTC)
Received: from localhost (unknown [10.72.113.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5808B195608A;
	Sun, 12 Jan 2025 10:36:31 +0000 (UTC)
Date: Sun, 12 Jan 2025 18:36:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	Song Liu <song@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
Message-ID: <Z4ObK5hkQ7qjWgbf@MiWiFi-R3L-srv>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/10/25 at 03:16pm, Joel Granados wrote:
...snip...
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0caa14880c3..71b0809e06d6 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -925,7 +925,7 @@ static int kexec_limit_handler(const struct ctl_table *table, int write,
>  	return proc_dointvec(&tmp, write, buffer, lenp, ppos);
>  }
>  
> -static struct ctl_table kexec_core_sysctls[] = {
> +static const struct ctl_table kexec_core_sysctls[] = {
>  	{
>  		.procname	= "kexec_load_disabled",
>  		.data		= &kexec_load_disabled,

For the kexec/kdump part,

Acked-by: Baoquan He <bhe@redhat.com>
......


