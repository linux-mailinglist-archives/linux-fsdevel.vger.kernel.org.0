Return-Path: <linux-fsdevel+bounces-46302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4EA86543
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC928C8256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB6258CFF;
	Fri, 11 Apr 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aPhTPd4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A32586FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395263; cv=none; b=UniKSg1Snwg8rBBFxXtIRQ4Km35tWgkUmWuLcH4yCxHAVb/g8xc1Q6l5Vtb5T2ErI0GhReMriIbObT2x2cD1IJH33cTeK+ve2KUaYcmQPFENKOdPv9ymuoPbJpg9cEPdr1Qqj/PL4pHeDt47pLYqAzPRWk7FWIawnJMMoZPLuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395263; c=relaxed/simple;
	bh=+0uNU7Oeos0VO05Dwi4rcMvnJVrCn/uWmtDIXT53pwc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EBgQDJJz/NtYuUZSDfhPtPMN1cXpLzkPJXiYuQUc/a2qgOcnGVAkTxSlv5tXcIWFPRR9LXqprDMvYnflaI5e0P5/79ZJPhg/UAtr/uE6XRbH2Fpau+NBe8n0AqQhPq5l45l0WSMlBZ0U/00LMHIdt3bIlq2szhRZfMmWDoCJLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aPhTPd4M; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c597760323so222175085a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744395260; x=1745000060; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpax22jUpEC8/o2V84iV6AYGXauCao5nHo6OcPn1kRA=;
        b=aPhTPd4MS61wzwm4pgEDBey+40jAtZyTSs5ISKVkta0oqb2AqYssvQbwN9sB7xXs1z
         APtOMOFEeP/Nyn3y89P8e7ihmAZ4nk9BJiiyvjvsYmmwaw+tMPRAPiZkt/uF5adePF7C
         0VCjZJoCB5M5aNMRj7F46bqVe3wHbuxkufx0Fl2CmeyDauqqsPNomg0UjSgcmQhIpNXf
         jO5qbG06J4v5cVbMcfOdpoPGJm9nj0IWmhfiFIxpk1hg95YcxUSBujM2hSTPRID+E1JM
         9SIHtBJRQuD0YckB/zIfNwhuSEQpnU/DJfNqECn32beAqEqkkHCzJIUUdCo6CZfHjtOy
         Xpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395260; x=1745000060;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpax22jUpEC8/o2V84iV6AYGXauCao5nHo6OcPn1kRA=;
        b=IUcXepr20OK4s4X3sngGSKRAkRPGcuvFiLXSFpM+s0DOxlPKNsj+zd0q1mL2kKKfCv
         OfADLRtF4dTFlNlryga0tnY0TJnyFklubudfgDol+XNsV62gT3ypeWAMqK7Td7L3LsSR
         ljN+xBnd4GmidqtXL5k98fhoJtF0xHIacT/WdB2HM86s7jWnHBbPtTwUIDOehx9oG8Bj
         L/wiIsyeFRw/I8GJAyLGtAADJ3cIqlCsz00lhYMaBl3cni3uuryJbenv5C3RBotdmkpO
         5TFoxZ0jWPF0efcNknUvx+e3rgb2O79+3QXXKoxKdtyuddLHdVJr/GwKEihbOYmqsucW
         wEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVyUgoTNWiSMwH4YBW2AGmm/ew+TuDrf4VFcaojBKKPZoYTspgx5b4CSd3grpe5Ak0syndMWpOcudCur1qz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gXg98xkz1aA2OxyWOCioZg5IYWe4Pl27MRjqy4a6e8hqHBws
	RWgrd4XfaMUdywXk+etFht/ZhQxS9o9uRcSolJvvGHqqFZw1fS88VKmWC3Buvg==
X-Gm-Gg: ASbGncvQ0dTdMHWZ6aX9ttG2KaToRyfqOY+3wiIvHNOtjDYfdfeSmMYjZf5dJXSxB5x
	EaRjtxTNgjvXaICWdeX74NSIuzg1oeyP9gfnvDz9hv412JPTFnE58vxGAp349+4nv+OaFKYtclP
	N0wvQFjNS1191WdCxRG3nvc6mKVHOwJ9hQaZLqNO9Y1zZDp+KyuX5vlHTN4gKvokZUdZG9CcTix
	drTfRRVzRjQa2FCpekPEfUnxSz/IyAyyuC6m34/MVriIhCnl6gOwdnYbN8wI88elqVZCxKDe5Sp
	tGVEU3H6wShB4jmX7xlRxWENkRUr8wKUahtH6Th56+HDao8gnfRw0DG1qyGzXjGFkdDybBZNHkK
	bwPctQkDO4w==
X-Google-Smtp-Source: AGHT+IE83Ajq4beiDm1bFY4FGCw5MiahPXF6d4P6EXZKH9SzDGizkbA3x/o6nOpdUtJ2dcUATqen3Q==
X-Received: by 2002:a05:620a:3182:b0:7c5:5f08:3c5c with SMTP id af79cd13be357-7c7af116707mr505028685a.3.1744395260493;
        Fri, 11 Apr 2025 11:14:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a1c772sm294412585a.115.2025.04.11.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:14:20 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:14:19 -0400
Message-ID: <fb8db86ae7208a08277ddc0fb949419b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250410_1510/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of presence  of rules
References: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
In-Reply-To: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>

On Mar  5, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-1367
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/audit.h | 8 +-------
>  kernel/auditsc.c      | 2 +-
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..d0c6f23503a1 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_openat2_how(struct open_how *how);
>  extern void __audit_log_kern_module(char *name);
> -extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> +extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> @@ -525,12 +525,6 @@ static inline void audit_log_kern_module(char *name)
>  		__audit_log_kern_module(name);
>  }
>  
> -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> -{
> -	if (!audit_dummy_context())
> -		__audit_fanotify(response, friar);
> -}

It seems like we should at least have an audit_enabled() check, yes?
We've had people complain about audit events being generated when audit
is disabled, any while we don't currently have such a check in place
here, I believe the dummy context check is doing that for us.

  static inline void audit_fanotify(...)
  {
    if (!audit_enabled)
      return;
    __audit_fanotify(...);
  }

>  static inline void audit_tk_injoffset(struct timespec64 offset)
>  {
>  	/* ignore no-op events */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 0627e74585ce..936825114bae 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2880,7 +2880,7 @@ void __audit_log_kern_module(char *name)
>  	context->type = AUDIT_KERN_MODULE;
>  }
>  
> -void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> +void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
>  {
>  	/* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
>  	switch (friar->hdr.type) {
> -- 
> 2.43.5

--
paul-moore.com

