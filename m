Return-Path: <linux-fsdevel+bounces-77718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDPjOEMrl2nmvQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:24:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF716016B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBE0D3011370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD13446CA;
	Thu, 19 Feb 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nfweMifn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D63033FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514684; cv=none; b=cWuqp5sZLZK3lHmgb42MWc2KcUzVkXvr7MLNhhlYy7vyHKmwx+aFV/TFx/MCX+R+BTL9ALi6zDo1XVvsBnW03LsGGtzcR8rtpIcYQw/Aend4QE+p2FhluzCHu8j1x9R7r26mHNnELS79NnIMhe/Z3F8NLV7E0wFIYBy3Nvo7GVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514684; c=relaxed/simple;
	bh=lDifLTAx9n9Mk40OXQsRSz1vGqgpmvsXnNPyhYBsb2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoaTNuQVcpSJulCovDWaDGEYiRHiQOxSztyMi1EvClp1hjtJ8Pg2z3VwPTPLZycH6/hUphsqrJnVx13rfBHpTFts0L5EjnSyb8yk/k6Zn6z0etqUc13MO8f+7SrsWdy5w5bu7reP8i1nAd5UsaG2ufxqPuufzMWTj4vUyd+IP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nfweMifn; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40ee196dd78so672356fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514681; x=1772119481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=nfweMifnjHOZmoTcEy3J+1PjlBhCJxMCujx5qg+V9WHrK/hWtzTz7dSFyG/VXUArAh
         CgY6H0NmgPcqaiA5lxAHqJiaUGIehkLGoSCqSCkH5D821Pc0YtQZMS+hmYOHoVxVfHEw
         Uax4INI1Ac3q8lfAxG7CinFd8jG9XreSJyE/g3+tKUpGut7LxH4fQ/9hhFRfpxNyeqW5
         kcdCSJY7vKcg46VTk0kkoTdWsKMXusrGpf0qlSon2YpTgpecdY8B5ewRcx0SfhcIkDpm
         3gKICwk3W2OXa3BYHJc5Cxce50FFAuuFh1XswNbRUasXWB9dM1Ksdo4EHfLIPOPAAIRe
         Jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514681; x=1772119481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=eSijd8opIwdZgraTCFpXNMfQohS69nXgFIog9MI4wETTarbbQxDqfMdQe3nvzyAvqZ
         b5Md6wFH7/b9U8WTraDUb9RML+SFPiWmTGY/NAujeQXPR9iuFcMzunlEdudhHsg5WoV1
         mK1LbYL11BFUVWrC/Ydcm4gG24spL4gLXtpb1oGckSaQrhUfyAiUxGFKkIFVPFe6tNCC
         ldQSIB4XfaOLvJJEEK/tpT50aMbu3CVJH9dFj5Ru0ADQfTTxq0uGeM1EqDlSbJV0rnd6
         zSN1Wp+C2vxyWTsRLIgCQqq0+VBv19nvTQkYT8ZE+kvkxPAUK7d/kmPWNeqOHuT4sSXC
         wrhA==
X-Forwarded-Encrypted: i=1; AJvYcCXPeJd1CD3tBl8p5tjqQfgbnFbHnmBve4A0JkVuTFz4P8tlQSFk8eGK9OqThrBvJTeRH43oLVrRMtXi0VKu@vger.kernel.org
X-Gm-Message-State: AOJu0YytYCQhKDjPpfA6uhnV4BxoAEvTMvxIwfZIhrL1VTqC+RCKmv8r
	ih+Y3MZ36aRB9qlEaYJzOgAOJ3rZcTjozyz+ZtVee0Nn7RcdZGUyaDI2De9hrQLoAIQ=
X-Gm-Gg: AZuq6aJrHi9vLFF78XbORXZUR/EBZNF0LXjw+f1z/8ywJi/kaLXMO+wztmkEMx1l/z0
	n+x5x3eyDdLshPml31Xeeec/QU977X8P81oHwE1MsfM5dZAG3RPL53HFacS1Mwy10Yn9UFj73xJ
	uxqD/d1WWWtw3nMMxQrcWauTNRVl+emxw2o9vlWKIUjdzBELfE5iP3xUmCvYKhBg1l7R0ttjKDW
	zawaxbxoN9+51nZMj3R/MXLm0PqL/LJxnhPkbFOwnw7v5JzMf1umxXHN1SE9cy1dpw+wJspFug5
	dnU6t8JpICaphEm50tD6z1ThEm0nCtg7E/T9Y3TkbF8yEpgTVSwq1McmbMsMVXdYSs0EN734xqI
	YDVVRyQt9e0seQSZmyplG8XOas0E2sO2OGK4CrchCgYKycp3n4A2YWtt8CPNx+QANlu7//PdlWl
	7NV/mlHkeRnBriCV/dgXgwJIdUCQ+simGtfZyJ3dl4VVdYzOUkQ96yMcmReVSbg1aLk4cfWK7FG
	NKlPTIB88k=
X-Received: by 2002:a05:6870:a0ad:b0:414:9285:c243 with SMTP id 586e51a60fabf-41545713115mr1093784fac.21.1771514681487;
        Thu, 19 Feb 2026 07:24:41 -0800 (PST)
Received: from [172.25.209.35] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f062ee328sm17955312fac.4.2026.02.19.07.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 07:24:40 -0800 (PST)
Message-ID: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
Date: Thu, 19 Feb 2026 08:24:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77718-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7EAF716016B
X-Rspamd-Action: no action

On 2/18/26 2:13 PM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery)
> pass NULL, which preserves the existing behavior.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.

OOO right now so I'll take a real look when I'm back, but when I
originally did this work, it's not the issue side that's the issue. It's
the pruning done from completion context, and you need to ensure that's
sane context for that (non-irq).

-- 
Jens Axboe

