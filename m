Return-Path: <linux-fsdevel+bounces-62427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A011B93422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BF7444935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91C78F51;
	Mon, 22 Sep 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b="pcQZLPl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF47C2E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573999; cv=none; b=EtyjSCFGUAmeB/jlTVqCw/pv+zqdficinjW3B0Tsm5/DyHAHww3Mn6PQtzf/MsBZfB3v1VZS+cILXiwK9/5D7kT4rHf7jrfQ3z3tGb7E0SAhM9DDzmI81s8o1kfHN+KJaJeVIA56WQ0vLu0gOYtzeDrjq6+jhnzWRrGYa95fRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573999; c=relaxed/simple;
	bh=sNif52s5HMeO2NlnrMaxGGClU/Jt3ksk6/Z0pkabfhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMtIjdFmgqrMFochXJdS2OeK+OuBvHLpVt7a4+Ihd8MXNdVrBe8YBg9t3EvU5d1QQHKW2UZwV+6gYD5+TX/KPyDhyfDXHYIuJ4tQd0w+5GmTJYZ0h0IfuPaMRklxZN0ck8936XNCwhJP8EPVCFleNhE0OSO5gT8+nqWkywamD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net; spf=none smtp.mailfrom=jjmx.net; dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b=pcQZLPl+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjmx.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698d47e776so35625865ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjmx-net.20230601.gappssmtp.com; s=20230601; t=1758573997; x=1759178797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVGiCj6E3P2w0QKnUVf/ItLsVX3vc/6pS/TsrG5gIrc=;
        b=pcQZLPl+6UWudl7enkICtHYMhr6uNZW/D4/P1CiEQ9ySbC0UVPNMECZd7wlvZh8FYn
         sTubGoviA2i+EHWcFeMTt8kAeTHTHF1UZG310YDRRwENM29pYklxP+xBGifC+6xb64NF
         SwglEQAVbTbXqSLJrAK++ODwHgnEK1Macnz+bkEGx81PBE+h+zAUiGmtRIid2lXWEhL/
         uY10WrSvTJieLXqWVGN1gRuSNhWiyoJl+p3iRWVZHscQeulnyV8egxI9Z8khPsUFTkll
         0E/C5padmmoTgkC70hORPYMCearRyudOgiU4sJN6xSY8194vN+4Mt213nrIJYCwgjfD1
         eAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573997; x=1759178797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVGiCj6E3P2w0QKnUVf/ItLsVX3vc/6pS/TsrG5gIrc=;
        b=U6JNPzLS4X3AOfxfsMxS1o1DXoZKo3TLFmdBFkl3dJrLjELkHXuzNWdxoJHtkpb+IX
         1GjkRYAg61DaG68fAyBoPiGFN5zlwxiLowQcrRJqqq9+4yj3KqO+E81tWlFwDYPRCEEp
         0BdxmXcPl+6SOyKl9oWx77WW2w3dD0Y6/91Vqk2ejyee5jS9fUHdnbx+Iq5hbgZA2hHF
         6gX3DVFtGfFG6DCQK3EThMFeNRP4d8u6Y10k/aUEqCxBYmOJUQjTy5iQlkuYEIrvDr9X
         7b7PqthMldtl/xuCiTTcfsDsIDokcVEn3gxTL1JiIgeuf6qgRzVk0imzy1akgT798FE9
         wUdQ==
X-Gm-Message-State: AOJu0Ywd0n6Y4yJgicpy4g0AUFAekhbPypK5KF0TFxjrTvswjJ0Hq+zz
	sjmjFVMXcQsmvf29fA+isDiQAY7rcw8zkGnLQbXPi19IlLBipfiZFHe8n0UeCg5llzw=
X-Gm-Gg: ASbGnctLmmhF4cIP9xr9FXUZd8PfmzEaFkkpNKB5KfeYU+Dcj9paHHkgr2ic5nEQ30Z
	THM4e9Lil8bmvcEEcBxXSq4NfIhJgi/6JfFwKNWUIObwcJfXwEr/iukjnYE4HhMwbz8qi9mmdde
	UugvxxTcVE3HPKFgjimfpbw/0lVIOD+gq19gyFacRhOvnNa8XYA1yK2BQOUe79Pffov9yvkjCTJ
	A3ZjAnJUOOpXQAAFk9hRcSDLuPEZfn9QVzrQJriKLI/bkjzLfqLvBdMntsF1QQw2Be/aScjtMte
	HCPs6IiotbepVQHxznaz9u6I4J9/cns5P+0j4s03YwC8NDMuROckQ54Wt7RiPdDDle0hcqFB/Vv
	t74S7eNJnYmj7sQNT0Q==
X-Google-Smtp-Source: AGHT+IGBzzduIGdXk7smDwhz6jjD79u61jKRRV7zYAexJaW7VRjMNqpCoiLIhN+qiOPpju/KPP3k7w==
X-Received: by 2002:a17:903:2f82:b0:278:9051:8ea5 with SMTP id d9443c01a7336-27cc2101372mr2088225ad.21.1758573997132;
        Mon, 22 Sep 2025 13:46:37 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698035d337sm138464615ad.139.2025.09.22.13.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 13:46:36 -0700 (PDT)
Message-ID: <d3816b71-b9c5-48da-acb9-a27702c8cf8a@jjmx.net>
Date: Mon, 22 Sep 2025 13:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what's going on with aa_destroy_aafs() call in apparmor_init()?
To: Al Viro <viro@zeniv.linux.org.uk>, John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250921073655.GM39973@ZenIV>
Content-Language: en-US
From: John Johansen <john@jjmx.net>
In-Reply-To: <20250921073655.GM39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/25 00:36, Al Viro wrote:
> 	Correct me if I'm wrong, but as far as I can tell apparmor_init()
> ends up being called from security_init(), which is called before the call
> of vfs_caches_init(), not to mention fs_initcall stuff.

sigh, yes that is what is happening.

> 	If that's the case, what is this doing there?
> error:
>          aa_destroy_aafs();
> 	AA_ERROR("Error creating AppArmor securityfs\n");
> 	return error;

it shouldn't be it should have been dropped ages ago. Its a mess up on a
patch and then it just got carried forward

> aa_create_aafs() is called via fs_initcall; moreover, it will bail out
> if called before apparmor_initialized has become true, so...
>
> While we are at it, what will happen if apparmor_init() succeeds, but
> aa_create_fs() fails afterwards?

Yeah that one is ugly. I will have to poke at the best solution atm.
For current kernels, no policy will load. Backing out the LSM hooks
isn't going to happen but we will need to just run in an unconfined
state and make sure any references to the fs handle the null condition.

> If nothing else, aa_null_path will be left {NULL, NULL}, which will
> immediately oops dentry_open() in aa_inherit_files()...

indeed, I have to wonder if it was always that way or I just messed up.
I borrowed the pattern from selinux but should have also dug into what
it was doing.

regardless it needs to be fixed.
We can check that its null and set the file to null for replace fds.

Give me a bit to see about some patches.


