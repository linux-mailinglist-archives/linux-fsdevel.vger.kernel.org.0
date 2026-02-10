Return-Path: <linux-fsdevel+bounces-76863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM5OOeNui2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:46:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3B11E10A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6DD304500F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCF26A08A;
	Tue, 10 Feb 2026 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfyN6Nk0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uHm3KmVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FF318BB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745547; cv=none; b=cQ2ipSkm9xSQAX4f6em0DajxA+elhaezbM+btAO6QKsr/6vcGTJ18foWYgcUXy3BITbT8RNgg9nGdkkredNzLXGo23W3MZoEijTIsLBprd9CVrOQ5+LluoLVff4uS4o9KEDSnYwkqOPcKsgl3nRGCTWYF1wqUBcI6kjjTDmSgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745547; c=relaxed/simple;
	bh=CPkvK7XkxBtLfxrYYEVvyrGgJ1BgYqj5KCtOpBrIFu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kseGE7cTuK3bieuIIjXmZANUDxmohWL5nOxtOxnkz9Lis24WxL+aWsAym+G4gtgs9dW8cEpYvblDhi+8kiOsaLlhj/NP1zF8gSq09QUXt7Y9TYnc4fp0++My20PyK2yV+fxXWHa6CnjogcPG5q+g7hsvzzjY0vxnECRgiVsqFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfyN6Nk0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uHm3KmVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770745545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
	b=QfyN6Nk0XFVn1RhRcDP9F44sEaj8IubQYq0djS39niI5eoOEladEnWaN1GGmXqSxEXfS21
	oyouFMZ2PRt+5r1rIpnYgYXImMz+oCUE/mL5ISJOBc4OviD1VXVJMgD6L9+gOsREQwXzzL
	6GZQt9En3Uy2JM5ql/VSqzYjtcvYRxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-QP3P3-_rPdKEt8q3toQu1w-1; Tue, 10 Feb 2026 12:45:44 -0500
X-MC-Unique: QP3P3-_rPdKEt8q3toQu1w-1
X-Mimecast-MFC-AGG-ID: QP3P3-_rPdKEt8q3toQu1w_1770745543
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435af2d3144so2763586f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770745543; x=1771350343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
        b=uHm3KmVX6WwNf0mll+cqSiNej64+aaQoC+ht46IFRxbO+jdxRisHW7hMyZPZOBBfmD
         beTu2/NF5VMhSWcZQFk/LEt6VfYb/0psKf5/8H26IwZQXY57Q/hmG6h3Aq9spWGf1lZs
         5u7O1skcUJCarvdJlOsqoXP6WlGb9yD4pT2h+dXJjjsfHbXm8nJ/O7wu5j7QaIda0Rve
         W8+wqWdl3kVFNmazswiR4EIgnF2LlESRisPBiu8pJkeucVTgsZemRELHT1uPzrEFy2ed
         803bAzKZEh2Dibf1EWPh1ZE2DFfageB3FNvONY8R6+ZuwgEN4B3Nl+Kqg/2M3wNf/pFc
         N/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770745543; x=1771350343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
        b=rFLi3F/bfstH3Tm3qpEXyTj8sTh8sscIjPMyZmSdl9B92dYhO3bGfiASdrP5BGIAhu
         KPq7OC+hDK74tHHUd55p2ZzuQk07aezPn1gZ1AVDhc8ygU6/c033ZOER05jqT4cEqAMm
         pP+mQRMLWyDcWgcVjFw4MhyxsAY6dvJ0Wkz6Uhrp1bHlflGIILZFzDkEfiNLf2ZbrPrN
         +UE/5o4aeruWtIDrV9fynnKwwPNogKLBgcxDZpNuDltIWkWbW/a6SNZeKe8FjtJ8ts4x
         bV2fBZUlwFtLiDIWE5pueeqz6Mow81jFn23Gntfv5Adij7OlpeOXqLl0bxZT54aTLhUi
         k5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKBGA6wi3w3UxQ1OYJoNDI8yOG8RZ/CWTcvBo8+elJqqGjIJrR8azL0/xSVPk+5feINo0DJMuO3QmJIou@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DhpTfFkR7BLiISWrhWMy0veEeMwio17CCtGsoTdJpos/zdDb
	LYR/LuSF5Atr3Wnk13n1EWVD+ewl79WfZoZCv4TM+7n9mC7EbzT3vywYBdcyLLdO3mwrMV6eJeZ
	Q5IjDKzDGoGIXsLSgWHGCbgDFw2FXBJXYibBcQ+hhQTf7JovGdTXQG37+cKqln0eJUw==
X-Gm-Gg: AZuq6aLp/IIrNuZhtmO8B+zZRS+0NmzfueFXHxsbKf011++GuE7UEKuKcidtEfnADG7
	osL8CMJuC+wgJYFmf6vCEQfMIlZtSIMRlcjsMFnHmb+m0YIVNLhtQ1boz18IPMBukGuf+yGy1/7
	m1KgKsARMLyCAMuLMzklerW6bxWHj5zOc5eCPXQFTjMu6fGe3AORogUAz/kLO8F/GmcjywSxUVU
	hjHhkn5dzAOMhz9Z4tOBCO/2mDFepQQ9S28/gG/zuntKjneshCq8GgywFcScj7Ve0JaqFDCm5u/
	tZ6r+OP8hf3VVOSaYA2KPvfH/ks0WsM44idO3nidQUQpnteKRLGynUlU7EFqIAKDabz82qbVxEQ
	ECqXy0K+Qc8o=
X-Received: by 2002:a05:6000:1a42:b0:436:38a4:2423 with SMTP id ffacd0b85a97d-43638a42694mr13750881f8f.22.1770745542809;
        Tue, 10 Feb 2026 09:45:42 -0800 (PST)
X-Received: by 2002:a05:6000:1a42:b0:436:38a4:2423 with SMTP id ffacd0b85a97d-43638a42694mr13750844f8f.22.1770745542317;
        Tue, 10 Feb 2026 09:45:42 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm22681690f8f.37.2026.02.10.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:45:41 -0800 (PST)
Date: Tue, 10 Feb 2026 18:45:40 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com, 
	Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
Message-ID: <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
References: <20260210095042.506707-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210095042.506707-1-amir73il@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76863-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,fa79520cb6cf363d660d];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 7FE3B11E10A
X-Rspamd-Action: no action

On 2026-02-10 10:50:42, Amir Goldstein wrote:
> The vfs_fileattr_get() API is a unification of the two legacy ioctls
> FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.
> 
> The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
> which overlayfs and fuse may use to convert back to one of the two
> legacy ioctls.
> 
> The new file_getattr() syscall is a modern version of the ioctl
> FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
> uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
> to happen in fuse_fileattr_get().
> 
> Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@google.com/
> Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr syscalls")
> Cc: Andrey Albershteyn <aalbersh@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/file_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 53b356dd8c33a..910c346d81bcd 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	struct filename *name __free(putname) = NULL;
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> -- 
> 2.52.0
> 

There's same patch a bit earlier from Edward
https://lore.kernel.org/linux-fsdevel/tencent_B6C4583771D76766D71362A368696EC3B605@qq.com/

Looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

-- 
- Andrey


