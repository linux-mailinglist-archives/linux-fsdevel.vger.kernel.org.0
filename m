Return-Path: <linux-fsdevel+bounces-78669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKXeNr8CoWlVpQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:34:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F761B2131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381CD30626C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB82EB5CD;
	Fri, 27 Feb 2026 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9PkOwzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF977FBA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159538; cv=none; b=BILzoQCrI98BvnZ5X90IUClKlfraqSVBdFvg8XH/fDYV/raHKclDmzKPfcXuRDWPxOoIiBeV66YAl4lVi9Rej2bmoO7iP7txlqwvY2gDZICA04UHBMLLUdv6EhK0II3nmNoDoytb0SmPHlxEK3Oc1BtJhLx4c6IrvXWvS3g1G3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159538; c=relaxed/simple;
	bh=+QNGgBGk23myA0SA/WMPSLUpBjDeY69somOdOMoeXHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6vOCL6x6qaPPtOaS/QmTHDKo2j0DEVbIlenOd8fOEHVzy9wBBbZ5UrSZHisJ25t4IKmb3MC75iYPgdotCPCnBiCyXz3GlJNOSr+q06QAADI6Rr5KIB9dRTOnh6vl2YeaYFOSPTkrcqN8cZQGMJhB/r7Zr4myXtGtaJqfN5OecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9PkOwzE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748095963so435052b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159537; x=1772764337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4kgNnGHgGyMchRm6sI8YqU2dIGIe0OTPSSS5REQVtI=;
        b=d9PkOwzE0bln0jFQ5PkAdDdUt6QWr66mOSu3DwsntBsBLntcpAFi/r/T9Y2660AmMU
         87n52GdU9v38VrpogntZAUvLOYUpEx7FQBQFaQuWXeDbkJXMOS0e7OwmtZgUfVQyyBkH
         Jj0snG6uhwk05hDBJAudKiExR70f95uM1nHtOB4TzK0YbrfsjWskjUKL3+9t6m4OVwX5
         wAFkX5PMUFW+Jje/R4d54iPOf+OtO7UMqZQ7tym20bermgHcVkyJGhy1uLx3L90EkYPB
         PYZeQCTMsqkufTn/hOdUF5VKBYAEZ2lxKA+3sEIcZYaROEYmYDT9AFcRm4thf4DBiWVn
         FGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159537; x=1772764337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4kgNnGHgGyMchRm6sI8YqU2dIGIe0OTPSSS5REQVtI=;
        b=jbju5JoqmgFBQnIW5gk55v4F2c87Tj+Lj5oQGow0fRR0HXnP5yEnTCXXtOJFytEXI/
         JFxBLZbnjMdgQ7hu3l5gi9MF/cMj46QHk9V8+XhD6SxMu9BTECmn+BmmhUl2Ye8ml9ZF
         dJHfSWd2LQukpG1Sx8hV8v1pTfp/i/PC+B6JtaLYu7w8otn5mBUocO4+73bLfSnzGsNS
         gWQ0jMNFpU63BMGKG1OXGhXBIrUU6+rKkF+0/WC2V4s0fc1yb3d0glXjwKnC+x26POca
         kCegKDEh6BIi/Iy9qfUarPD1pRMlxBzvv1qPdgLhtER0kdQDEBwGmzrhryni3ORMkMbY
         NtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/+Z8q1aFbCj2zBWy6emezItIws+TRMtVec+JEfSgBUxOH47s/TDVKRPk/zacFC62/I/4hRtctNCgRRD4@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlmq8EHbMZyPRDdkdbzrU615kEBmITSpdBgUr7NgvtKOeCxeU
	rFz55vkAVX/z/VioV44q/UjlkZbMFhZxeXeHKDV00MhKOr4pvCZc6zn2
X-Gm-Gg: ATEYQzxcYEMhEKZGcuQNNvny0bHZq79aKxEgfW977w+kM4APkl58h0oweVamQ+pdl8g
	yFNm3i4cEmS0xg/8tnoW27pffMyoZym7xRIRe+simOtMXUDmIZUUfewXNCamBC/OZEqdNYrKPKF
	XreX+YAkJi7YazByPs+GSW/Hd0khTv8r3Y2b2xURONesdDTwghcAJxggjlX8o0QVcWnd1QfcCUW
	TBWBv9gBiX8K+y8gPNarJZ7T2eRjIQaFejAYxRhG8lARgJYfOSCsVqcheYSzNkjk4YxQq4XhRbD
	7D0EVEG2Vwxc+cQRqp3PlfAoiov06SI7hbLGz520vrT0+QqA84jIhKmvObU7RD72l50fXc12XE3
	DRkf5W2eIKOK/LaEleBvEuqXK4qtWWihXiHrktMWyBb2iU779IM6wdGTzXVuhZdVetvutGjEuBg
	UIvvUDK/SEEtY7KQ==
X-Received: by 2002:a05:6a00:450c:b0:7ff:885f:9c2a with SMTP id d2e1a72fcca58-8274d92e050mr1026603b3a.12.1772159537126;
        Thu, 26 Feb 2026 18:32:17 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a048615sm3448883b3a.52.2026.02.26.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:32:16 -0800 (PST)
Date: Fri, 27 Feb 2026 11:32:14 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ntfs: Place check before dereference
Message-ID: <aaECLoLaA3rXaAqf@hyunchul-PC02>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
 <20260226160906.7175-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226160906.7175-2-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78669-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 68F761B2131
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:09:04AM -0600, Ethan Tidmore wrote:
> The variable ni has the possiblity of being null and is checked for it
> but, only after it was dereferenced in a log message.
> 
> Put check before dereference.
> 
> Detected by Smatch:
> fs/ntfs/attrib.c:2115 ntfs_resident_attr_record_add() warn:
> variable dereferenced before check 'ni' (see line 2111)
> 
> fs/ntfs/attrib.c:2237 ntfs_non_resident_attr_record_add() warn:
> variable dereferenced before check 'ni' (see line 2232)
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thank for the patch

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com> 
> ---
>  fs/ntfs/attrib.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index e8285264f619..e260540eb7c5 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -2108,13 +2108,13 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
>  	int err, offset;
>  	struct ntfs_inode *base_ni;
>  
> +	if (!ni || (!name && name_len))
> +		return -EINVAL;
> +
>  	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, flags 0x%x.\n",
>  			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
>  			(unsigned int) le16_to_cpu(flags));
>  
> -	if (!ni || (!name && name_len))
> -		return -EINVAL;
> -
>  	err = ntfs_attr_can_be_resident(ni->vol, type);
>  	if (err) {
>  		if (err == -EPERM)
> @@ -2229,14 +2229,14 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
>  	struct ntfs_inode *base_ni;
>  	int err, offset;
>  
> +	if (!ni || dataruns_size <= 0 || (!name && name_len))
> +		return -EINVAL;
> +
>  	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld, dataruns_size %d, flags 0x%x.\n",
>  			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
>  			(long long) lowest_vcn, dataruns_size,
>  			(unsigned int) le16_to_cpu(flags));
>  
> -	if (!ni || dataruns_size <= 0 || (!name && name_len))
> -		return -EINVAL;
> -
>  	err = ntfs_attr_can_be_non_resident(ni->vol, type);
>  	if (err) {
>  		if (err == -EPERM)
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul

