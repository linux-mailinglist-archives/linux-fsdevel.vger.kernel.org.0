Return-Path: <linux-fsdevel+bounces-78671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UARqBbwDoWlVpQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:38:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7101B2192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA6630530DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01DC26F2AD;
	Fri, 27 Feb 2026 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM7u/AeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609322777F3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159923; cv=none; b=Zx/W7Em3qsFvvxtNOv7FiEZnHqExLpnB8JDIqE/pP8ii8hzfC4tZYYK3Dtz1eXcM8OCyvdsrrlkSwLCWl/DwGjD1UB5FRGcoWVJsaPOQJIX1CyH2WyPdeNrGW4LfiMr1nXQsbGomVOJhAiWSYu0fbwhaEk2hy1n0PbARTonhF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159923; c=relaxed/simple;
	bh=vGFd9z/E/ywuuI5wTR3Yy2I97bE0XC0/msZcvxIYU6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9Q0OkpkatF39VxL67B6rlBwQqUChyHGguE2ZrTahQMdd++kYdHMnxyFdZoWzmzeRGpLd1z/G0W2BnRSj+Y01FqClgD5lZLmhJrSwNktdURlIUIHj+zsFiLeqdSOlP07/Lvge8TDCP876el7EYlcMcLa7uuGnehljNIRtBi1SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM7u/AeM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaed195901so7720985ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 18:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159922; x=1772764722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9Fy5twOQmqd13IJtP3D2OUD99NwYh0uDaBdljqk6Dg=;
        b=mM7u/AeMUaHhEm42RNpgAi41KQaUPpE9Vyb7pkiRjQUY5QyuOlOw5MWnh8LUu0SpEa
         rmaW6z/k6wDrasgARwTG1Zzq69MboglPggKXHJFIMGcPt8lfko4Quw+uRgAeCRvGrRmC
         LUXjjW7AfZtHBkSM2V/fwnKcDzWrT32VqyuV+VzXoJokq1c2aBSz0bgi41ZnSjbtNnb9
         Y+g8WmzpnbYQYxu1gxLdXIyTzVv7k8UjAYdq9vg5C+U4Vsbgr+V4iaWUAb2IRd3avz/l
         xrT2HhsWJsO5EWUYQW9k43t58hVgWcIdxCLtvQ2mJ6QLLEoEMdKTfMIWw0cfqyOC8eZC
         PHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159922; x=1772764722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9Fy5twOQmqd13IJtP3D2OUD99NwYh0uDaBdljqk6Dg=;
        b=dV8nZfreP7nK1QfzUMFzCqWlaTkSeNBpG0PpTozBwQtGlPGODaQkT0z8gnLHIeKHrZ
         FmFbfUsSO/iqgqJ5Q6BnNXCR7+DP8rG7tEqxEAoh2lVY+LMFVEDrDbPqX6Ahlgcin/Bb
         ammj5MNaoH1AqZkox2bBOh3xgAB8sKtjBQ/wCUkZlEAD+lEfHs+EyLF/wlT2O3Eph+6y
         Y7SYrQ4Fyu+j7wcPPKNXWhMX2o3ol38oDOwsxYynf5dUwfnIcNWhM38sZUlAr5Kt4soK
         DiMGYdICaMlc+BrSMwlw5FiOP0q3uP3S9uQxlrz4pQnnn7BIl+gTb3zDvi2wzNkjOn//
         ORaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDp0+HUvW1mBPfxjkVnk83oSrvybGz9a80YdRjnaYw/lcFo/XcQSfnI7jtbgqjmpNLKWfGQhi2HmlkcQgl@vger.kernel.org
X-Gm-Message-State: AOJu0YwcH2A9sKZHwATBARvgTFGf1ac2iJOFtOENe9UFFp/GHJFstLib
	b+woVvc+zTeIl1WOd+v4FS7iu/SiMq/Qpece54vDDBb9PM7qfkziwT2QrU0whnDK
X-Gm-Gg: ATEYQzyxi2zJNjHlZ6Ugs+okbAaQzZqqc6WCiTZEKFj6cfrWsLZmQUJZhSrX/cF2If0
	j2iSwUO637FxctqS2HM2M+/3Rkd0NIkg1jFh2D+TwRvfcDnBP/3ykEFv9+x/Ud3wINLqoJskupH
	KVaI/OESy1NqYOTxXYxsnmO1YzLahKshFSayFO+xrWQ2lE6dXBNxBRBaL67Vyk89iz5NYUqGcZC
	+r3XcffOUG5n+fF8Z/+OHbnNvyLJSfKw+ru5oJ6OpkZzOm4zJxUdYnaws+KekkQdvhQCl4DboDS
	AySzYEzDBjrWGUewsDDK+fSxK1SVHUH9zLzGiBEZ+ZcdUKCxT3YosIoTGAWWBss+KwrtAX66U3W
	ztCBGxA5kSjNLt3Usr4mseFn9kvNrq7hEfYA1fg2QrIBtlOBf+41wSs83XJPhlYE0uxDBPpSom3
	tv37FwhF/sbxkNCw==
X-Received: by 2002:a17:902:db08:b0:2aa:d672:3be with SMTP id d9443c01a7336-2ae2e4f8590mr8314625ad.52.1772159921649;
        Thu, 26 Feb 2026 18:38:41 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm54736215ad.37.2026.02.26.18.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:38:41 -0800 (PST)
Date: Fri, 27 Feb 2026 11:38:39 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ntfs: Fix possible deadlock
Message-ID: <aaEDr3xj9rXZrHma@hyunchul-PC02>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
 <20260226160906.7175-4-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226160906.7175-4-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78671-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A7101B2192
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:09:06AM -0600, Ethan Tidmore wrote:
> In the error path for ntfs_attr_map_whole_runlist() the lock is not
> released.
> 
> Add release for lock.
> 
> Detected by Smatch:
> fs/ntfs/attrib.c:5197 ntfs_non_resident_attr_collapse_range() warn:
> inconsistent returns '&ni->runlist.lock'.
> 
> Fixes: 495e90fa33482 ("ntfs: update attrib operations")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thank for the patch

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com> 
> ---
>  fs/ntfs/attrib.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 71ad870eceac..2af45df2aab1 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5124,8 +5124,10 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
>  
>  	down_write(&ni->runlist.lock);
>  	ret = ntfs_attr_map_whole_runlist(ni);
> -	if (ret)
> +	if (ret) {
> +		up_write(&ni->runlist.lock);
>  		return ret;
> +	}
>  
>  	len = min(len, end_vcn - start_vcn);
>  	for (rl = ni->runlist.rl, dst_cnt = 0; rl && rl->length; rl++)
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul

