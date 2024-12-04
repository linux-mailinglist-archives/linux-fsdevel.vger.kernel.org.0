Return-Path: <linux-fsdevel+bounces-36503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53F9E4A34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 00:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83261282924
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8191B2196;
	Wed,  4 Dec 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD13ZmRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C7193091;
	Wed,  4 Dec 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356599; cv=none; b=EcUSwOo4lHtiQ/tq+BZabTrvinSmX+FPCbQBbCK4OjpVnv2ss9Uq+UNCaDaXCVLs6plpy2kimTsHa5JEUlCRO52hO41xJcRaLEh/xEh/VzxbqT2qR2Q9kmZz0aCUb53GFG3Znp9Ds38MzPbB2rnOdWE6AhIeDUQCMhBzYNIWCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356599; c=relaxed/simple;
	bh=JZuTqkMiJci5M6VD9ttBclHzFQ2hopxCrSemkU44NuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckt1yrkwSmqRy1LdovHxIYH7EP2AxIO/lQbk/041jmQiswvmTA9gIDuc/sk0/K7IGO3IJTBVHfh3Jf2EdLgzMdk+spHzlSLAEMbS277zxidzGTAQoWLBaT895RU6W3UHrpGrTDEPJLxTXj0NgHnLh0TaYPPyFShj20TwSIZxNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD13ZmRS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so447563a12.0;
        Wed, 04 Dec 2024 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733356596; x=1733961396; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJKz2wj2juop4/IeMZVrYzFBdQURnaygM5UccUrxv6w=;
        b=kD13ZmRS/mTVptHsHWCY8WYPgv/7ypTSVYJ8O09/eP7vHtQdgi01+g6Dht7mP18N6T
         Rp8XODDTBi4T+7jQQxJRiA3jxr9rv+w8p9IZRLqxtG+c5ZK8JnceUxB4+zT7ZlYsHN1k
         XmVdYgCOpQ7WjBjkUxpXu/QJ3+BFUAcgmxz8/l+J3I1+GqFAB9Ve43Du9gIuoNu+6rxy
         wz3Xu+PYCXhDnjTsAb0TOEueayWXah3MPB2jR3v7GiIFS6w0fOdi4+YQ7IQqMJThiCS4
         uF8K8xKBAhfjuUGKxLLs0+esRVycoR7qY/1WsIIckSbCv5c9FmxVgEilAwrqGBRj7Cnk
         YMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733356596; x=1733961396;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJKz2wj2juop4/IeMZVrYzFBdQURnaygM5UccUrxv6w=;
        b=D3AAUNQvwwkjws0+J4v4bDomNdOnl0G7DtxyOEkHHLhK5ysxY4Z5edSpFAju3pyoDt
         H1k03KUMm/bcmJe3x+3U329yxRVPurpzkG6Fy7xlYyh1y3yrsjXgh35mbtWRfezquHtV
         KzgIYUGlaFJuKtgz2wUkxkkbncsuPON2JTH4EfJOsGG6gS+aw06BRgd1V4iNjLFwLV32
         cTTaNTytOpLRpwjvZbilWLuz8fSDRCPBXaaA+L+vjpGSiz0SRgB+ZfzOKNzsLksyhHDo
         afx5kQNSbLk6v5dUVlhXT7QLJY+nmGI7TuyyjXRtrDrgQYYlqNyTAUaqezTiGCsFMkaF
         DbXg==
X-Forwarded-Encrypted: i=1; AJvYcCVtgeHPX59APD+A3xiJvUMDs1SsuW7CI9buphst9PyUqFq6kOthW+Zl0G2zHIKuCMCcAfPBlZSHHWWycaX7@vger.kernel.org, AJvYcCX73lYUeYGXpVfPDdMRkyiEarDGGe7LINYbf/Jsvs35FvSIeDZHK7SgmuGGtDa5QEAVb1Jbubs/8GlnOVrp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Gj5pHIUZlR4mO8hQEuC8aZs5krx5KbB7lTz9pkO0J/HF54kh
	EbvkUL/7ulissxItG6K8+clu/lhmzD+XGevdiWt+Z4Cn8y9awMbp
X-Gm-Gg: ASbGncs5iWAbtJlWTzDW1Jh1VizM9qJFZN3+NsXbmrPLu02ifBn0crSlL/doEGm0txC
	+yYfCDwN2QJZ/IYcLFGjw8UaVOQWLICfSsLlgdCL1TVc8lHRU4+Zf5xpDtw/b4Ip8wOrsYNSHLQ
	95ywecma8mJiH2uFwtgn11BC5Aeu/fr3Ganoeh4ryGwUvJAgVauHylOQxC3b7VIYmVOsNW4KBt+
	tWg4xOX/EdPlAB1Sfov+Vr6LcB8JbSTMUR3OJYbPT1TLMs+nQ==
X-Google-Smtp-Source: AGHT+IH8dzA/+2KKrO1cHwwQZR17w7HCC+oSR5sKhkw++P4LEAldEsyaN/rRyXoeSB1VU7N5URE/zQ==
X-Received: by 2002:a05:6402:510a:b0:5d0:f9a0:7c1f with SMTP id 4fb4d7f45d1cf-5d10cb817d3mr7963616a12.23.1733356596024;
        Wed, 04 Dec 2024 15:56:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c799224sm97394a12.69.2024.12.04.15.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2024 15:56:34 -0800 (PST)
Date: Wed, 4 Dec 2024 23:56:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vma: make more mmap logic userland testable
Message-ID: <20241204235632.e44hokoy7izmrdtx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Dec 03, 2024 at 06:05:07PM +0000, Lorenzo Stoakes wrote:
>This series carries on the work the work started in previous series and
                        ^^^      ^^^

Duplicated?

>continued in commit 52956b0d7fb9 ("mm: isolate mmap internal logic to
>mm/vma.c"), moving the remainder of memory mapping implementation details
>logic into mm/vma.c allowing the bulk of the mapping logic to be unit
>tested.
>
>It is highly useful to do so, as this means we can both fundamentally test
>this core logic, and introduce regression tests to ensure any issues
>previously resolved do not recur.
>
>Vitally, this includes the do_brk_flags() function, meaning we have both
>core means of userland mapping memory now testable.
>
>Performance testing was performed after this change given the brk() system
>call's sensitivity to change, and no performance regression was observed.

May I ask what performance test is done?


-- 
Wei Yang
Help you, Help me

