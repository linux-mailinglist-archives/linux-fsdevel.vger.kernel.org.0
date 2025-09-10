Return-Path: <linux-fsdevel+bounces-60859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70111B523BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 23:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A5561CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606DB3093C9;
	Wed, 10 Sep 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jl66o85u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43A25A350;
	Wed, 10 Sep 2025 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540811; cv=none; b=e0w4oBHunlWJ2paFItohDi3Jve8T7IAOVez+RETZYldaS5JZA/y7hxnCcT/8woECEtX4GqFO6HsSTEVM1HzSKfL6XfrAlm6dV1HvYPuZ3nkCNRFqCbolVxKEBZvy5PCEvifewsVjeHTkLT4Al8O4CtAmAwNB1GudfcUI4uSPpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540811; c=relaxed/simple;
	bh=xI5dr2WLtU48h2vDzwYeGhyj45s9yfxwH9ivM8zY9+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKv6fqOWvsl4IZuQ5c3Pqh8LYAYRpB92U5iOx2YSZ4aDaK0mh3rSskQFohg8OpIeArA12xP9sJkYOHxH0KXrSWWCsOIgVQ81EE8QS1UQoSrC5yPNsyKEmJs39KZWtE4eCyNxOgxdxkX7yiL+82cp4mBhn1mdzSi47VClmBSoRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jl66o85u; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cMZ5h6MjrzlgqTy;
	Wed, 10 Sep 2025 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757540804; x=1760132805; bh=SblCa7b4/NTLO3n25U9sMwdZ
	RzviXHPZ/qYAZnJLH+o=; b=jl66o85uqkGn0HhU8xIV8VJzDOn50wzA/PhwxG7y
	83Eu311QE0FTDgG8Vfs5pcUIEB3I/PMqK1NA+f+F/CmhRyiYsbAfvgKI9NGeDbfA
	oJgkcHG+363CIcJIrRIxkmA6QMB7Hbcg6bbk8iwjTGfvIGZ5yMlIhV2oUxk7Y/Lp
	m+PR8mVloka1g9R9ADPdLGv8qtSaPtKhfQ9Sdojz8M5vz49Y4aftvaV79mvlf4dv
	8uG1wzNP3j7mcX8/TZz2eBsFI1Fg9L89Ti2/Skn0SQZVLxQjnbZer+thswakrtTQ
	sNm2OmK3oEqu6RxA0pfn+4DCcecegAif4i28pRwh3TfPNg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ynXkrDbBFREF; Wed, 10 Sep 2025 21:46:44 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cMZ5F0NFBzlgn8k;
	Wed, 10 Sep 2025 21:46:23 +0000 (UTC)
Message-ID: <f65cf3ae-069d-4ade-9fc9-03f01c7e1649@acm.org>
Date: Wed, 10 Sep 2025 14:46:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/32] selftests/namespaces: add file handle selftests
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 7:37 AM, Christian Brauner wrote:
> +	snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/net");
> +	ns_fd = open(ns_path, O_RDONLY);

Here and also in TEST(nsfs_uts_handle), ns_path is not modified. Does
this mean that "/proc/self/ns/net" can be stored in a static const char
array and also that the snprintf() call can be left out? In case I would
have missed the reason why the path is copied, how about using
asprintf() or strdup() instead of snprintf()?

Thanks,

Bart.

