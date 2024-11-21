Return-Path: <linux-fsdevel+bounces-35483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264B9D54C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B2B282CF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD91DD0FE;
	Thu, 21 Nov 2024 21:32:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75D1DA60B;
	Thu, 21 Nov 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224770; cv=none; b=WK3iFSilED86MgnYZQTfno5Xk1gcLUfZLNsVLCl4Y5a69e3yToTwy4VmCeSiIviseER0sxVWNTd4FzU/pXT6Q22t742DRU0qrJDjvT2ucDNDMMz4SIt5xa8Na2oWfCLHzhJBhuERuhJ3ZaMv+8LWKSoGbe3KciB9eoQDIprQ9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224770; c=relaxed/simple;
	bh=f2zjqGjXIS0zXz+SfweyuQuJmizq0SK3ammdZElZGAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIFRKwS1zqLQzMmk1aiqF6+9Ks4W2KL9zp8f6WyANsurXKsSWa1qP/kyLLitaE/M33XamttcnC+Usx750sjQkvXTK6pt76Qc6jx4g03y9EYWPaoPN8h5fwLDwqixRPfpQWYc/1M1rspHonzsADmvVWFUb4JKfdnEy8bRvhBRBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id DFC898FC39;
	Thu, 21 Nov 2024 21:32:44 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>, Theodore Ts'o <tytso@mit.edu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>,
 Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Date: Thu, 21 Nov 2024 22:32:44 +0100
Message-ID: <7747240.EvYhyI6sBW@lichtvoll.de>
In-Reply-To: <20241120234759.GA3707860@mit.edu>
References:
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Ted, hi everyone.

Theodore Ts'o - 21.11.24, 00:47:59 MEZ:
> If you look at the git history of the kernel sources, you will see
> that a large number of your fellow maintainers assented to this
> approach --- for example by providing their Acked-by in commit
> 1279dbeed36f ("Code of Conduct Interpretation: Add document explaining
> how the Code of Conduct is to be interpreted").

A large number of people agreeing on a process like this does not 
automatically make it an effective idea for resolving conflict. As I 
outlined in my other mail, this kind of forced public apology approach in 
my point of view is just serving to escalate matters. And actually it 
seems that exactly that just happened right now. See my other mail for 
suggestions on what I think might work better.

A large number of people agreeing on anything does not automatically make 
it right.

I'd suggest to avoid any kind of power-play like "we are more than you" in 
here. What would respectful communication would look like? What does 
happen if *everyone* involved considers how it might feel in the shoes of 
the other one?

I have and claim no standing in kernel community. So take this for 
whatever it is worth for you. I won't be offended in case you disregard it. 
Also I do not need any reply.

And again, just for clarity: I certainly do not condone of the tone Kent 
has used.

Best,
-- 
Martin



