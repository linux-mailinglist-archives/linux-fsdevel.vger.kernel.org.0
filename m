Return-Path: <linux-fsdevel+bounces-77733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPXeJr1Zl2n8xAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:43:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E999B161C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D3730182B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910AA2DFF3F;
	Thu, 19 Feb 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5VpLn2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4972E228D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526544; cv=none; b=cBrvVV1wZTj6bmxVZAMqqNsVylDOoA8DArVksB/Aaauhs1iSAFz+PSnQvYX7v1L85K8dBFOg2QhONxwjsQCyW48eLqPBu/HylZiPDJCk8m6w3XaVn0l6O1p0BRiES8zAFenJ5LtDjnaifZLHllDhb2Z5BA7fu1YYL+KkuIK1Xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526544; c=relaxed/simple;
	bh=LiaSNZbJdqQPS6VqwJAySKUKXPc//Tmc32mBrJpkF50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VF8S3XpwSsffNQyyNxy8/jwTvqJbmzMNlXnILCJurH+3lFXayPRdN7NBSnLvPzgfPi/rce5Cc5wz6oNEFG5IqPL9UPYFJQQHbpIJRnSVFIrDKinF2p+yxdx3R2OrZaVWYxaRLBqFo3+nbkDdAFFjwSQQiPM/bIJXO1XxkIjv5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5VpLn2M; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069b3e0c66so26518481cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771526542; x=1772131342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30yCAFVAnO/Wgt24GdW2Jh4SIgjFvA/a8tDI8ygXSNs=;
        b=C5VpLn2MPK7MjyXTzbfwKkyBL52xOZdiruuzQNR0ea7ryxLrZxQLiKQPi5FG2/EyRE
         4Z/Y5nmxjc2mTOGBjGbEf/KFXUAJDQJC2WSkm9jTN7qMzRVitiPxZYCqoEvlY54jTPLE
         CoJFyE7mjPwtUbHptoiDoZ4tbYSZJ/aJ+J3JkxOXtkPhZ18oAAN1VzhQd11HTh1Hv8c6
         tnDYAY9tVIW+vKrMtPw/qUjG+SbOXHVzfEA2I53kcz7jYdG4dQZCiR/1jA1z/nqwrRJN
         Hf6r9hF+8fyVqns/Gqln0hALFlH9S/r1Xg5ZtuVCcIs5lw/gZcNtaPBlqArdG1ndnwM8
         joOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526542; x=1772131342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30yCAFVAnO/Wgt24GdW2Jh4SIgjFvA/a8tDI8ygXSNs=;
        b=qw012MIUwOimp9tkX8KZnCbXML/20IsI6NsXym4J+LN8nA+Ir9+uICABlum6UpiDvf
         H/3yMmbKY7a8T9j+O7U6w55sRDsrNb7ll3PQJ7QFVbHbj4lxPHd5MGBF2Dv55blF+m4R
         TMZgGEUPF5C/DOp2d+o7jJc1mqKmf5jLwuKskTqIkeGjulgbGbcnE/XZmIvy4y+8U1BE
         1zv5j4qPfDNV9FI7YSV74Hk6ZB9GX7rWp0X/WZ8tHI9Nxq0Jm2T2FgdCK+eZ+IBkBmJ3
         0OWplMFCYlfXe2ji/2KuUlgexZ4RgfDIzyieWebPCCT7T0Xl6SIO90FNOKv4jxwkzjp1
         YYfg==
X-Forwarded-Encrypted: i=1; AJvYcCUKdIJ75hfGLP6BdmZfIvI1c8gTirdx0pbgEV6zuVpu9I7ANyq1mAlRLOVt9KwRo3kGn8fR/5MK5+WIGfYA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23BM6z4P/q9cpNY4Du1O/OFYLVoMUVwtVDZYBZn989oH7U8wk
	r3GFvqEeavPoHnMkdLRNdBNyywVeE9xiMW+mgakYAogNQrAe4HkxY4Lr
X-Gm-Gg: AZuq6aLQBF9GPIQVoHgqVyYwLXHeeTkOxmo4EPi1TtAgpCpwkHZVd5jULRwxA7HnDp0
	qGNHx9hAbHKQRn3l3lAduQ509omLVh5R4zUiZ5ZqNqb5k3Yf6YFV7iqOWGNar2ksifpZRVxlE3y
	2FeLh0Nckx5q9li2z79A79OSkRdYHozzGKYTUNEIAVbeWbl1GD9NY352Dp8sE04UhKlgtVtd3lq
	w/WUHjCalIq7Xv41i6E5jEuHjc0OW//XJ3xrsXx/FV6LUrp2yoog/yhseNHuHyAVr+1yTCHgsPx
	qUjUzdSXYSvvTPTDkifMmOMXU+3VAKdUzEC1s7F4RY7uzlFxxab05vOeLe3jqFxLaOW7Vor6BVj
	ITypNjHLmenHsawHiYJ6U/OOltEjcmnFt088zcN2KiOOh7uMV/yfMr/nW2M7ergQG0Ef5n727Eq
	XR+JUZ5VORJu83a2o7jpG0VZEa2zjnWwge9xrjweD5g8bMgAKNmFP0gZagZ8dqrHrTM6JoEOrcU
	98=
X-Received: by 2002:ac8:7fc5:0:b0:4ff:a6b7:6c9d with SMTP id d75a77b69052e-506f33e5aafmr34139201cf.38.1771526541823;
        Thu, 19 Feb 2026 10:42:21 -0800 (PST)
Received: from ?IPV6:2600:4040:5f65:ed00:949f:f477:ddea:7dba? ([2600:4040:5f65:ed00:949f:f477:ddea:7dba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506f715e9b1sm11497341cf.33.2026.02.19.10.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:42:21 -0800 (PST)
Message-ID: <965f4c91-e2ba-42bd-9d77-321e5f443ee3@gmail.com>
Date: Thu, 19 Feb 2026 13:42:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system testing
To: Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org
References: <20260218150736.GD45984@macsyma-wired.lan>
Content-Language: en-US
From: Ric Wheeler <ricwheeler@gmail.com>
In-Reply-To: <20260218150736.GD45984@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77733-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricwheeler@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E999B161C35
X-Rspamd-Action: no action


On 2/18/26 10:07 AM, Theodore Tso wrote:
> I'd like to propose a perennial favorite file system testing as a
> topic for the FS track.  Topics to cover would include:
>
> 1) Standardizing test scenarios for various file systems.
>
>     I have test scenarios for ext4 and xfs in my test appliance (e.g.,
>     4k, 64k, and 1k blocksizes, with fscrypt enabled, with dax enabled,
>     etc.)  But I don't have those for other file systems, such as
>     btrfs, etc.  It would be nice if this could be centrally documented
>     some where, perhaps in the kernel sources?
>
> 2) Standardized way of expressing that certain tests are expected to
>     fail for a given test scenario.  Ideally, we can encode this in
>     xfstests upstream (an example of this is requiring metadata
>     journalling for generic/388).  But in some cases the failure is
>     very specific to a particular set of file system configurations,
>     and it may vary depending on kernel version (e.g., a problem that
>     was fixed in 6.6 and later LTS kernels, but it was too hard to
>     backport to earlier LTS kernels).
>
> 3) Automating the use of tests to validate file system backports to
>     LTS kernels, so that commits which might cause file system
>     regressions can be automatically dropped from a LTS rc kernel.
>
>     	       	      		    	    	 - Ted


This is a very interesting topic to me as well.  I also am interested in 
testing on larger and aged file systems, not just file systems that are 
newly created for test runs....

Ric



