Return-Path: <linux-fsdevel+bounces-23768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A5932A1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FB128811F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15A19DFA2;
	Tue, 16 Jul 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="Qf9qEUaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.python.org (mail.python.org [188.166.95.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BB198E80;
	Tue, 16 Jul 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.166.95.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142616; cv=none; b=US8dAq8yTMIHUO69ncCexNS6BREXDrvcT5ADSfXaaupfssw+4lX/63Op4zqxGAYjT6CxbLl+23qEKLTsCiUOoJRDDU4mB5Ga6EBMFZ/4OkL0aD7dWC/rsYJuEicWEphC6IAX4z5141DmQBINOl+0FGLdokuRabw5r89i/DOEjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142616; c=relaxed/simple;
	bh=DhMpYjEPORBLC4GppzbsY1w6CLAkXay9uD3n69IW9ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7WxI152f8z1cDThdKWx8SbphDHfZd1Ezk5bHfJtajo7Bp1puj/qxfnR7XUjCf+VGfAohfpxYhQJ7ai4FmcQjaaQcplFg4GVkbcVbWubNLPEKElq1oU7AlQTand0uMdxC2kd6KMlwH7x07ahV0kd821UON0AtPa2tamiIyjK/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org; spf=pass smtp.mailfrom=python.org; dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b=Qf9qEUaO; arc=none smtp.client-ip=188.166.95.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=python.org
Received: from [192.168.1.83] (unknown [2.29.184.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.python.org (Postfix) with ESMTPSA id 4WNjD85nTvznV37;
	Tue, 16 Jul 2024 11:10:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1721142606; bh=DhMpYjEPORBLC4GppzbsY1w6CLAkXay9uD3n69IW9ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qf9qEUaOtaufyFY6qYUAFTXL4DoJm8PzWJvueNX2rhKJRt1JOuQfzn83CJfxOxNTz
	 U7GK4UXBgM/hrcmiXyIfcd6koJi+dfG96/nqtTbcW1sUA47uU/HPRHndlGC++bMo/O
	 DuyO4Q+8KNvM+M9WqwwYRy4gR647CYKuAMonGCGQ=
Message-ID: <70d67323-c568-4861-ab93-8e013854eb32@python.org>
Date: Tue, 16 Jul 2024 16:10:00 +0100
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
To: Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
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
References: <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
 <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net> <202407100921.687BE1A6@keescook>
 <20240711.sequuGhee0th@digikod.net>
 <CALmYWFt7X0v8k1N9=aX6BuT2gCiC9SeWwPEBckvBk8GQtb0rqQ@mail.gmail.com>
From: Steve Dower <steve.dower@python.org>
In-Reply-To: <CALmYWFt7X0v8k1N9=aX6BuT2gCiC9SeWwPEBckvBk8GQtb0rqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2024 16:02, Jeff Xu wrote:
> For below two cases: will they be restricted by one (or some) mode above ?
> 
> 1> cat /tmp/a.sh | sh
> 
> 2> sh -c "$(cat /tmp/a.sh)"

It will almost certainly depend on your context, but to properly lock 
down a system, they must be restricted. "We were unable to check the 
file" ought to be treated the same as "the file failed the check".

If your goal is to only execute files that have been pre-approved in 
some manner, you're implying that you don't want interactive execution 
at all (since that is not a file that's been pre-approved). So a mere 
"sh" or "sh -c ..." would be restricted without checking anything other 
than the secure bit.

Cheers,
Steve

