Return-Path: <linux-fsdevel+bounces-46303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB0A86545
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1478C858B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35BE259C89;
	Fri, 11 Apr 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZimrOtKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156B258CEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395264; cv=none; b=UXeBKl96zx1MfGh98Am7NNkySElzXP0uFrrFCPtltbc6pnp155/SEPMRNhHydb7qWP25ujhjFpAF+zJzcpA2YYAzUkYsunEL3biPR2uwiNk5Biv26tMdbMwguWT1H/O6UXY2wauur65SOpSYGrMmn3EU3WU0dTAypVgfJCw+OoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395264; c=relaxed/simple;
	bh=vY9f4r3cDFd7jHvFFQfWrOifGUvOJEYGZayNf2ssz0A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SKw6E23G2QJzztfZiwL1yF0ONkrEM7NMjjzfcrvEPkxxoQExxQ9HUpVSfIfr2t20KRKcNj/086BKpd6ILOmdf3PkkMFA0id8nZEytTCSWXjg2RkOJsF/8bCu14iQSeZt3yL0gasps84wklXJPH9XMa6c5MMsa690VfEKw9RLaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZimrOtKQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c081915cf3so301367385a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744395261; x=1745000061; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jV3A2FFsRjYecUjGnpxB7VVu0ug7im1apcSVtwUE9WM=;
        b=ZimrOtKQaURawXF07OELJeksndLNqBm2V4Dn8vSTPJjXEokuBOwvl0/i627lefZzoh
         KO7Yd3KonTdhCI9Kij+0UX6toTeXFuFEH932QBAbTZ96KqSG0tO6atT5sXqJKfnCIMjC
         AhhFRhVyUaV1angFOkS3KlHlZKcHXAUXxIbV6YsYiHvyJOvUrSYARU3CppEp9MQP4zuH
         1wywV2GvQxRAmK4GEPhgcwcN2uwkUQYa+2sFexG2W29b1+Tat1/lLqmRLd4xecqv6dJn
         b19jpCptBkVS58dGBGAfIbh5vl4bDTC4KdjVdSf7kgbEkEXR+0q3U1BW0kUh1a+e14/K
         vz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395261; x=1745000061;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jV3A2FFsRjYecUjGnpxB7VVu0ug7im1apcSVtwUE9WM=;
        b=t9OlFXrFD8rKFgM2PDpTD+g2CXLa430Sb33aHqA+aux8sNBQPi92+AOLnbr1abGPCF
         QOg7oBPtuxkZHuduyv5dTXoOiX9WHh/8dcTZJVPq4JKzPeOroUbwZRapLy+B+dcwjH2B
         NVZ/OvsMa/UkXb6TqUwxBENNtUzRZ8nBHeDbCHZEJ8xelFlDZWa7hMp40nNyCpPzP9D+
         v0S32yVwUqUPAWLZcOEfOsMuBimAHlKl00F+hmUssBceRIxV0Ga70SKKQJLbB6aWSpUu
         Omb4E3A8BPCusIKuCMRip6ph1YHaEoQYLqO1QLJBG4BXlHw5t9IaDGwQ6aUaUgtCZpBE
         3TTw==
X-Forwarded-Encrypted: i=1; AJvYcCWnwB2Z7ZV/hgNhkJFmn9NymVHzK+kr2qDpfWoz/sKEZ/XvSZPJ9nhlJWzWP50xQtxNZ+Id0BBsdzcl//qR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45ezIMMAiXDPWf9s5/qX2kuojGFBL/A9mgGsc3Mj6nzFhvUnb
	hY7l37mzaJMO7IMz9dllhmPtTyM9R4BoQz/ikzI+OeOKy93KRAEhiu7feg57rw==
X-Gm-Gg: ASbGncv67KSipSbMDJWrmk+B2lPVgm004dM5Sj7pYQ1BPvTagVz39JUSgQ3qdKwouzh
	0tmRU+rfJKMI7LNt/voVDcfTPs7hYuRs1vJCLAKX7RNAafLOITonaAypGjtfY7N/lLHWo0BK2j3
	8FnF57Xghf6kKzOX5noYEy5ScES7zzZHdpJR4GQym5N3S2jn7xnQNx1XDtiR813VaQ9Xm0kXJKi
	9SNkNx/0XPAGOoAFTUC0hLBCLtEEeMpq4e0dO8TRrNX3ZP7Aj2LCjJG7s4ZJp/PsZl4t7uHszfu
	XgqxLA00AG6h8w2npatB1nTBczeOs+Ay1pMskFECUXRTlnQqmdSBEOu7mf8Q+4OSkNMenA2nziK
	2MKDFPLuQLA==
X-Google-Smtp-Source: AGHT+IEsqHKJznBTfLH+wkhI97bKZraZjSQVcHcEj/HWL1HRD7kYNCXyQIZNuApWR29/gaG09j4C2A==
X-Received: by 2002:a05:620a:25cf:b0:7c5:4be5:b0b3 with SMTP id af79cd13be357-7c7af1f4977mr580390785a.48.1744395261418;
        Fri, 11 Apr 2025 11:14:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8951803sm294878985a.36.2025.04.11.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:14:21 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:14:20 -0400
Message-ID: <6ab93e8c449191e0a65668cf37602bd2@paul-moore.com>
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
Subject: Re: [PATCH v1 2/2] audit: record AUDIT_ANOM_* events regardless of  presence of rules
References: <0b569667efde7c91992bf3ea35b40c3a8f10e384.1741210251.git.rgb@redhat.com>
In-Reply-To: <0b569667efde7c91992bf3ea35b40c3a8f10e384.1741210251.git.rgb@redhat.com>

On Mar  5, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, AUDIT_ANOM_{LINK,CREAT} events
> reported in audit_log_path_denied() are unconditionally dropped due to
> an explicit check for the existence of any audit rules.  Given this is a
> report of a security violation, allow it to be recorded regardless of
> the existence of any audit rules.
> 
> To test,
> 	mkdir -p /root/tmp
> 	chmod 1777 /root/tmp
> 	touch /root/tmp/test.txt
> 	useradd test
> 	chown test /root/tmp/test.txt
> 	{echo C0644 12 test.txt; printf 'hello\ntest1\n'; printf \\000;} | \
> 		scp -t /root/tmp
> Check with
> 	ausearch -m ANOM_CREAT -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-9065
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks okay to me, merged into audit/dev, thanks!

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 53e3bddcc327..0cf2827882fc 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2285,7 +2285,7 @@ void audit_log_path_denied(int type, const char *operation)
>  {
>  	struct audit_buffer *ab;
>  
> -	if (!audit_enabled || audit_dummy_context())
> +	if (!audit_enabled)
>  		return;
>  
>  	/* Generate log with subject, operation, outcome. */
> -- 
> 2.43.5

--
paul-moore.com

