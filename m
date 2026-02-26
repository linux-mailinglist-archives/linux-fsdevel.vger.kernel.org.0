Return-Path: <linux-fsdevel+bounces-78442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF5qLoLZn2lleQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:26:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1EA1A1089
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40B6C303076B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501238A739;
	Thu, 26 Feb 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA1ychK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9E2D94B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772083578; cv=none; b=mGKladiqSGPkCNzk29EnBn6emAajQ54I3YvW8MH3Yp1LdUQYOMHpiLQ/K7VPy4A26YTrUfDn7ZoS2k+k8R0E4bhkpjQU8gsKcuGDXpwaoTnLW1ujeJ4yzWUzSARawHX0PCIgwXN57qfZPmM/JD4wzcw6+JAjE2MPtecBXK5EdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772083578; c=relaxed/simple;
	bh=VPz3ZYgXEY2hzDLAW14PxLbQU9fmN9eElQW3U4jKlCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrjXua9KbS6Jfbtwau4LdWHzTLQ80FzefEBhs/lDMvoyoOlHY1yigbLsLe/dmwtsaopVFdyhen3sm/pAYmJlCf8c9C1yll3iCxE9EJyh9IYvAolo8oOfLhyYf84o7Jr80eoL4xrUuZ2+/bDH+2T5XV9Vc6E27cxDrfuL0ITk3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA1ychK0; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-824b05d2786so426229b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 21:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772083575; x=1772688375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7mgaU6rPDLyUHIg9CRAJuNpAGqmGXby8vxxfzwZ5sc=;
        b=WA1ychK0K33GayUwW/PQjIUk+vjhj2MIk+QC9QGKi+lMv1GIl8GkAxozlMweBqCRQV
         DpljkwYH6dATNJAS5k/1jQFtZJrwxAQqgLSv2/DtymNB4reG0T9yRxJAAaeX7wRxd1NS
         V4gGmvMi33xS9JxXuPHk++pfxw739e1FZ07JKFEXUnqaPtcozgKHvKCWSl8IhLxgkDL7
         qAisy25aLQhivuqrUTMj7lSpfQNoyxlO0d2QJkqdTzTuQb2h+c/6OqtkCAY7bC9kwD+h
         wQcvJZxUXEqfQPcrFmIiIekwAVNGXhRxdmvRSdouoKpAqwpGA0Vp6H0DAraxuHEEQyJR
         7fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772083575; x=1772688375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7mgaU6rPDLyUHIg9CRAJuNpAGqmGXby8vxxfzwZ5sc=;
        b=qVvfme9ym6/sQoqdwaq/267ZlhWT8NyhS8JjYMWHnxqFs7bX/8UU1eRKHjUIhz0Klp
         8NbZYvFIwqzbahVlwPVb3CQqmQ0JKcfGxcbrQzcfZZy2hylU5FcV2aWFjibeNojzBtfC
         HooswgelM6RfYikqxlXSStsHosxg3B7rvm69PhV9cjB/hWxV+kb+60zn1apbetnMsi3p
         gchClvQbg4OexksB0oKnXNm7akRuYmtree/kmsNQTKSGF1Cel4vL2ZHiO955vrcQxsJw
         bAVnGVoTa9byRHmZ58IYBt+D4FJ4byUI6uy3BkqdXr16K0jRypOPYuQSg/KpBmyZUIwo
         YqOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXfQGcQDOTcY+SMwtOdJKtL8hCYnDt2jMIU8GUEw4E9oGt02Vg7TO9BCC3T6wT5CiDSPTSaUK/0miUBcmt@vger.kernel.org
X-Gm-Message-State: AOJu0YypLAUEVA6jTcBVsFSIkbfp4bI5GNJfL4UmrpsDg7ophDRB06Oe
	/YpbtbVeXSt6IuDQo0pIec1eYNCSehhovEO8dOSdoGeB5uN7SauZKCqqdnICN0Q4
X-Gm-Gg: ATEYQzydC5dR8D0IBHjEUeZUrSF7hjQlrVlMfXzxHFaYB/k1SusaPF0y684A9dmhDVE
	aenq+38E6F29cfD7tIPdIxG/oFAvHloHKoZC9NYFK9yb63DHYCH2ZkQdNgOsxZZtTmsgEjHxQ18
	TbjyhMY3bwwJzbFKmZXTylYsJ+fXlUCiN96dhQYWuiugMFnPjmQu4PqFBgbyHpOjNHdN0Epf45E
	8Mr2ibwXIyut2CLYcuyS8prXzsIiK7haVi+kk0J1Zge90DRxhPTYAHaniPnuovLpFlNNbd50Nw0
	rFJ3DTZD9oiOHNdEWLw3UBL2UmgGD5EL3LG4PJsO/PXta3IvAB7umPtZ0URHoKgWGUcwXhLXv3I
	8/pccerqd8pwTtcllNuhjkGu+5FiaDCc+wLSK2qqCVgcaoqCCDbWSCWgkZ/M2KuToHdep2ESRsK
	EHr2RGXTCVUDfhLQ==
X-Received: by 2002:a05:6a21:510:b0:38d:edd4:2fc6 with SMTP id adf61e73a8af0-395b49a35a9mr1154639637.70.1772083575103;
        Wed, 25 Feb 2026 21:26:15 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm663045a12.5.2026.02.25.21.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:26:14 -0800 (PST)
Date: Thu, 26 Feb 2026 14:26:12 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] ntfs: repair docum. malformed table
Message-ID: <aZ_ZdKZ1ZHpCHcH8@hyunchul-PC02>
References: <20260226020615.495490-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226020615.495490-1-rdunlap@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78442-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: DA1EA1A1089
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:06:15PM -0800, Randy Dunlap wrote:
> Make the top and bottom borders be that same length to
> avoid a documentation build error:
> 
> Documentation/filesystems/ntfs.rst:159: ERROR: Malformed table.
> Bottom border or header rule does not match top border.
> 
> (top)
> ======================= ===================================================
> (bottom)
> ======================= ==================================================
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Looks good to me. Thanks for the patch, Randy.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> 
>  Documentation/filesystems/ntfs.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20260225.orig/Documentation/filesystems/ntfs.rst
> +++ linux-next-20260225/Documentation/filesystems/ntfs.rst
> @@ -39,7 +39,7 @@ Supported mount options
>  
>  The NTFS driver supports the following mount options:
>  
> -======================= ===================================================
> +======================= ====================================================
>  iocharset=name          Character set to use for converting between
>                          the encoding is used for user visible filename and
>                          16 bit Unicode characters.
> @@ -156,4 +156,4 @@ windows_names=<BOOL>    Refuse creation/
>  discard=<BOOL>          Issue block device discard for clusters freed on
>                          file deletion/truncation to inform underlying
>                          storage.
> -======================= ==================================================
> +======================= ====================================================

-- 
Thanks,
Hyunchul

