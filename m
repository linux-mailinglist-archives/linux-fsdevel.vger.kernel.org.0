Return-Path: <linux-fsdevel+bounces-23501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6192D69E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C3E1F283A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB01991DF;
	Wed, 10 Jul 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="orCNdDWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.python.org (mail.python.org [188.166.95.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1C1991BF;
	Wed, 10 Jul 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.166.95.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629168; cv=none; b=QRMCvKT17gnDdQm0lUGoBkK/GAyXiCzxXnAfLtARjMaLFL2q8m191CVQVgRWX+guW6upQ44JJlXWyvPWEnhjs6rcH9tKfSTkbK+Wa+vPsCHPbR0pJ9JZ/wxISKRyDwNe2D0KV/xUCD09vMNdH3LfJbhJKzfWz0cVxRyzgqPca4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629168; c=relaxed/simple;
	bh=h2ueXzl9+sWF3YmpYxvon1twDz2ALcDQP5/oXQTST5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFKPnw1saapKzrck/ekbHq0qrHjwtsFqlXBpDySb/SdRi5n29DCEQIXLtCXYuI8iW7GRjLWx3dew61Bu9J+WCE0E6Ej9FjkHK7CRnJFQaLJcCC6F7uQs9tq6e42B2jZ9s2i2HBU6UMDNyYli58uHm+Zay+Gi8aIVr+V2p5TP4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org; spf=pass smtp.mailfrom=python.org; dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b=orCNdDWu; arc=none smtp.client-ip=188.166.95.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=python.org
Received: from [192.168.1.83] (unknown [2.29.184.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.python.org (Postfix) with ESMTPSA id 4WK3LD4nhrznVC3;
	Wed, 10 Jul 2024 12:32:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1720629158; bh=h2ueXzl9+sWF3YmpYxvon1twDz2ALcDQP5/oXQTST5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orCNdDWudCwG90M687meldIOq5/EKuuIheRaXFPgs6pRjZnOQvl0JDohh68MAjUiI
	 s4xIkd1yVurO4t3vSs1/vto/eK5p0gW0i5Yz0uvn0sdyeMtjkbfXJE5u9zsPFpqDN1
	 iXEmSBDTMNFhv/jRjzG1bSRS5+61zKFeOr4ihtow=
Message-ID: <296b11b2-5ff2-488b-ac4c-7945aabd7b3c@python.org>
Date: Wed, 10 Jul 2024 17:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Content-Language: en-GB
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Jeff Xu <jeffxu@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
 Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>,
 Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Jordan R Abrahams <ajordanr@google.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>,
 Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
 Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
 Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>,
 kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
 <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net>
From: Steve Dower <steve.dower@python.org>
In-Reply-To: <20240710.eiKohpa4Phai@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2024 10:58, Mickaël Salaün wrote:
> On Tue, Jul 09, 2024 at 02:57:43PM -0700, Jeff Xu wrote:
>>> Hmm, I'm not sure this "CHECK=0, RESTRICT=1" configuration would make
>>> sense for a dynamic linker except maybe if we want to only allow static
>>> binaries?
>>>
>>> The CHECK and RESTRICT securebits are designed to make it possible a
>>> "permissive mode" and an enforcement mode with the related locked
>>> securebits.  This is why this "CHECK=0, RESTRICT=1" combination looks a
>>> bit weird.  We can replace these securebits with others but I didn't
>>> find a better (and simple) option.  I don't think this is an issue
>>> because with any security policy we can create unusable combinations.
>>> The three other combinations makes a lot of sense though.
>>>
>> If we need only handle 3  combinations,  I would think something like
>> below is easier to understand, and don't have wield state like
>> CHECK=0, RESTRICT=1
> 
> The "CHECK=0, RESTRICT=1" is useful for script interpreter instances
> that should not interpret any command from users e.g., but only execute
> script files.

I see this case as being most relevant to something that doesn't usually 
need any custom scripts, but may have it. For example, macros in a 
document, or pre/post-install scripts for a package manager.

For something whose sole purpose is to execute scripts, it doesn't make 
much sense. But there are other cases that can be reasonably controlled 
with this option.

Cheers,
Steve

