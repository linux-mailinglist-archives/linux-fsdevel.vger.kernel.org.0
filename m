Return-Path: <linux-fsdevel+bounces-12490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94F85FD59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EC71C23164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86F14F9D2;
	Thu, 22 Feb 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd5Q5s9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FD14E2F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617511; cv=none; b=Lp9WyHqWBFTzUF1kfcruoGVfMozq60dqf2VzS3fYtbTqc6IbfTReJReGeDNgibAJePKXX56oY/OjwF3pyO7oBj9iLw2Gq2AxotenFl4pv6PjxC9fWkzdprHNIPo4ImbGGB5FR26zCr6aYHqyVlzMcfVsRKkHCf5TDiUWm8AftSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617511; c=relaxed/simple;
	bh=2P4szW9lDHK3q0STKqZ/D1opkX/JG1lEtnjJ6mXrPtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxQ2+19JEXfGlYfXfnDy4/4QMkfd5txDe/c+b5zV7bU5RNBxzvc4EtaooAvjEG5iHjU33jUUsJ6rz13t/hkHdJvVFNlWAuyWXpGW6fnNAJS4YUWLdxNc10NsmMfPckdSTQbXAXY6xmhWr9K32A30EAWXhTQ7979eU6tnj8xLDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd5Q5s9N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708617508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=regtVwyiMLMyqRNWFoerySyA3gB2joRlOQ3bFOrcFl0=;
	b=Cd5Q5s9NGC+nm99D9YIj0zMsJVrAyaayCiV/OaqEkPmFCdIOE+BwUalJ6/RqGv3F5nr17S
	BS0OSW9HbaUahb6eUWADEDxhj7yozaQBe1huycu/kfuSHkh5Y+vItF3/0Z86guyd6+siBk
	zk03NlhnEwkAEbt1Pl1vleaI8RGJqW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-CfarnFhWPHe-sHaejMJObA-1; Thu, 22 Feb 2024 10:58:26 -0500
X-MC-Unique: CfarnFhWPHe-sHaejMJObA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F74F85A596;
	Thu, 22 Feb 2024 15:58:26 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E9424E4;
	Thu, 22 Feb 2024 15:58:25 +0000 (UTC)
Date: Thu, 22 Feb 2024 09:58:24 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <aviro@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <ZddvIL4cmUaLvTcK@redhat.com>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> As filesystems are converted to the new mount API, informational messages,
> errors, and warnings are being routed through infof, errorf, and warnf
> type functions provided by the mount API, which places these messages in
> the log buffer associated with the filesystem context rather than
> in the kernel log / dmesg.
> 
> However, userspace is not yet extracting these messages, so they are
> essentially getting lost. mount(8) still refers the user to dmesg(1)
> on failure.
> 
> At least for now, modify logfc() to always log these messages to dmesg
> as well as to the fileystem context. This way we can continue converting
> filesystems to the new mount API interfaces without worrying about losing
> this information until userspace can retrieve it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
> 
> A few considerations/concerns:
> 
> * viro suggested that maybe this should be conditional - possibly config
> 
> * systemd is currently probing with a dummy mount option which will
>   generate noise, see
>   https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
>   i.e. - 
>   [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'
> 
> * will this generate other dmesg noise in general if the mount api messages
>   are more noisy in general? (spot-checking old conversions, I don't think so.)
> 
>  fs/fs_context.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 98589aae5208..3c78b99d5cae 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -427,8 +427,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
>  EXPORT_SYMBOL(vfs_dup_fs_context);
>  
>  /**
> - * logfc - Log a message to a filesystem context
> - * @log: The filesystem context to log to, or NULL to use printk.
> + * logfc - Log a message to dmesg and optionally a filesystem context
> + * @log: The filesystem context to log to, or NULL to use printk alone
>   * @prefix: A string to prefix the output with, or NULL.
>   * @level: 'w' for a warning, 'e' for an error.  Anything else is a notice.
>   * @fmt: The format of the buffer.
> @@ -439,22 +439,24 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
>  	struct va_format vaf = {.fmt = fmt, .va = &va};
>  
>  	va_start(va, fmt);
> -	if (!log) {
> -		switch (level) {
> -		case 'w':
> -			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
> -						prefix ? ": " : "", &vaf);
> -			break;
> -		case 'e':
> -			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
> -						prefix ? ": " : "", &vaf);
> -			break;
> -		default:
> -			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
> -						prefix ? ": " : "", &vaf);
> -			break;
> -		}
> -	} else {
> +	switch (level) {
> +	case 'w':
> +		printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
> +					prefix ? ": " : "", &vaf);
> +		break;
> +	case 'e':
> +		printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
> +					prefix ? ": " : "", &vaf);
> +		break;
> +	default:
> +		printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
> +					prefix ? ": " : "", &vaf);
> +		break;
> +	}
> +	va_end(va);
> +
> +	va_start(va, fmt);
> +	if (log) {
>  		unsigned int logsize = ARRAY_SIZE(log->buffer);
>  		u8 index;
>  		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
> -- 
> 2.43.0
> 


