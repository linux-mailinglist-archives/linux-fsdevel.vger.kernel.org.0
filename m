Return-Path: <linux-fsdevel+bounces-78430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBysGrCwn2kAdQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:32:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2A1A01F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63962302DF46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769A33A9EB;
	Thu, 26 Feb 2026 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr3WqLM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA11531C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073130; cv=none; b=Q2DHhgRu0wmPsfgHQSTLLA7awzy1vu20vRB+W27JZAxSWzB+kIcsYt8y+7LPoCeqWuHCXaFgCmvEvJH0piRZn9Sg+Y+JTZUWS6MvUc0HQj+egSUjbRJj4qLKci/c8TFKpBWBIcQkxDkXcmXieX85PW2TwsOwvqX/TkarRKADYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073130; c=relaxed/simple;
	bh=Vb89xHFzy54Wt00V2fX4v17/wwSsg8RCxSpcGohoye8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuhcCtLmEthw8VBvPFCw+wP/pZl0APLSWZZBNVDq2AZ9F1mQ7eN++FXR7orMlGj3wMRimekS5piUvioEW0L/mVk/W5PYkEAVmT77mZkESvjmH4b+Zi4Pjwa5/v8CCnlNapWsu1fz4NJBpPSMpUTrICEfx1QofPgAMYoidS4fSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr3WqLM6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70b4a0cda5so93464a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772073128; x=1772677928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyaLR/WAQ6lRZ3NjaSm33RIJgsY01uZatFM5bOpfcaQ=;
        b=kr3WqLM60W/lUwpVtWZc2NHs2qLsaZwibnH/RyQWwWdSaR/8CFBkQ7U/5CMkrOWVI9
         J4v7Uv2jcWSTiG+o79YTyps+fEPXej3gM5Wka1jz9NQUmuRpY7A5gTIkaETrvj/v30m4
         zHs5va8N3OIoW2o3kMYVPCiepu+hkNAJAqLIHIpvF6MzS0H5mVszkN+uxav6TCvjGG+S
         lrsamyW9EzxEg6UlDsXH3gb9SeJBvg3fO3XYvDaOvCP9uz2ZbabSd3nnF24iRNpsmVje
         MQBGa0B6IjNCsRIlLPrmfrwt+K7A6EjyKtGiObT+RHYltE4e8RI+v1yy/+kDCcTKpXou
         +nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073128; x=1772677928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyaLR/WAQ6lRZ3NjaSm33RIJgsY01uZatFM5bOpfcaQ=;
        b=WEqimvSsIfFw4Ks4Sw+khFKB1GvRX5o0IovG2CVk3uHbEDatzUgTtpP0ICSjSLegOR
         2G5wjqP/rDYmTR+2rvT8h2cnoo9yAmt82PGZpk1R+Lbgc4o/p6GwstMEU+f1mUCqd+Lk
         taX41LVdpQYJgA5yMzDu9Y1MaPjuqauo46vjRK5t/3mzwgAB8W2t+0JBE1pY8cI8fK0v
         w6uzRmOELYXmALU4uos3cM1ihRs2d3tBGo3NhSHtoqMrYtba+sY/WNjIM4DB2K4CPBsu
         2wu2LkymUJNlHpK4plTavyBK7TVky8vbKpQ2Akf3F0z4PMlU7ogOZ23Uvs1rERJPE5ld
         Yd0w==
X-Forwarded-Encrypted: i=1; AJvYcCX+mDrMLKwppNnlKuJ49PmVNKZXbxhP31yK//4Dk3OJ8NEJkwxJnaYZfv+uJdXVAmbUtWAmS/tD9GOFsbj/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93kzn/zGCF5mMtmewzrEs6momPBplbu3jjHf8+PujrGSaGUXd
	EeHBJZ6+cBukMnwRjvJ/GD2uZTb3YF6Feru2QdMjCAgezRi7/yj7GsO/qvzcrA==
X-Gm-Gg: ATEYQzx1UlpwtiqnNA6xFRolp2ivN/GST7KsQGyRPjtjvvm6uBfKRO/gIwWYn5P2QgX
	ozMsQMO3nFCryTDoopVCCXZul+sv1zB9+4X8xsXr3ulcbZgHaXkg9iAbBMj+mK/FVxWf58yAt4P
	57Bd7+j6EvOOkpjaseWDUxr2/SknCT9ppATRMnVDxstcW2tNEbDFE4zmuFEzWWLwwhiDsBVGRX4
	/jx320UalmNRzNJ1iSwcLBNxZMD/YSsk1/dzgIWefaXOMOonYe53Hy8d3W0A4jqlznZQpuWhF60
	eNrQACIrTtkXtMNTbCUPLgXjX3p3MBv/7RrCYaxAXHT8wFJ8deKBgKTKUJ1wtONY9zkV+/5uroJ
	mBpABYUnTXU7OgeeGwI3Eu4iidcPRXSe32PtK+YTmT7qmitIFIzseYHwtL5rtYtc2KgrV0qXJ9q
	q2K1qDXmez208gHg==
X-Received: by 2002:a05:6a21:7794:b0:394:64c1:da88 with SMTP id adf61e73a8af0-395b1d312f4mr1020060637.13.1772073128506;
        Wed, 25 Feb 2026 18:32:08 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359034bbfd4sm4114745a91.10.2026.02.25.18.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:32:08 -0800 (PST)
Date: Thu, 26 Feb 2026 11:32:06 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Fix null pointer dereference
Message-ID: <aZ-wphvo8fGvJEWY@hyunchul-PC02>
References: <20260225222453.1962678-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225222453.1962678-1-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78430-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8F2A1A01F6
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:24:53PM -0600, Ethan Tidmore wrote:
> The variable ctx can be null and once confirmed to be null in its error
> path goes to label err_out. Once there it can be immediately dereferenced
> by the function ntfs_attr_put_search_ctx() which has no null pointer check.
> 
> Detected by Smatch:
> fs/ntfs/ea.c:687 ntfs_new_attr_flags() error: 
> we previously assumed 'ctx' could be null (see line 577)
> 
> Add null pointer check before running  ntfs_attr_put_search_ctx() in 
> error path.
> 
> Fixes: fc053f05ca282 ("ntfs: add reparse and ea operations")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thanks for the patch.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/ea.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 82ad9b61ec64..b2b0a9a043a9 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -684,7 +684,8 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
>  	a->flags = new_aflags;
>  	mark_mft_record_dirty(ctx->ntfs_ino);
>  err_out:
> -	ntfs_attr_put_search_ctx(ctx);
> +	if (ctx)
> +		ntfs_attr_put_search_ctx(ctx);
>  	unmap_mft_record(ni);
>  	return err;
>  }
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul

