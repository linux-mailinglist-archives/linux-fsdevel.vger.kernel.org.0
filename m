Return-Path: <linux-fsdevel+bounces-23331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05892AB4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 23:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5631C219F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDD14EC7E;
	Mon,  8 Jul 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="fRvlg0QX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.python.org (mail.python.org [188.166.95.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B561EB44;
	Mon,  8 Jul 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.166.95.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474364; cv=none; b=n7eSAGpPCxiD/50PmjMj7/X+g1nkxGyh/vCqkOF287ZlSJndoL90By7p1AB7K7MTtIUwuF/y9FVsR6LqopxLGdEMIRA2H9xhT/WoBAz+Z376KdkuYO5NGxzQexgEoqaDexKadrocbdIQFYSm/ifeNxXj3D0dJmgCHXrLYQBDHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474364; c=relaxed/simple;
	bh=qP9JJjp2wwtgqNEqstI/ReNHBLe0F8Tj7JsMZZjC+tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keNbQ3Ecg/lne3KvXI14s7Qfm3wQKR4SxkCatKDKcvsiekKX3OkHizkX9dBRcwlgn/mGxhQLXJCS9SSn36X5ZwIH+eeU1sqAiZ12zSLko/cwtUJwb2xc88CX/JecFeFv2tlZdiaiaRrsnY22zKewSmF+2ZW0OmZPztmOgzrTIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org; spf=pass smtp.mailfrom=python.org; dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b=fRvlg0QX; arc=none smtp.client-ip=188.166.95.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=python.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=python.org
Received: from [192.168.1.83] (unknown [2.29.184.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.python.org (Postfix) with ESMTPSA id 4WHxxK6lcqznVF4;
	Mon, 08 Jul 2024 17:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1720473943; bh=qP9JJjp2wwtgqNEqstI/ReNHBLe0F8Tj7JsMZZjC+tY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fRvlg0QXwIJAkXyrCKhMDJxtPyAXB0mjii1640HG3xWRb2W5P+42eQTBJPTIuhKpt
	 W7kH1zP794uZGf0rnntp5p+gP5s1k2YsFyKXYqxePPc8Ng44leBwaQk7RKeO5U7X6v
	 HzB8cs5L4tQul4iZaKKGJIvbQF7weKnmuCGRaspc=
Message-ID: <ef3281ad-48a5-4316-b433-af285806540d@python.org>
Date: Mon, 8 Jul 2024 22:25:41 +0100
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
From: Steve Dower <steve.dower@python.org>
In-Reply-To: <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2024 22:15, Jeff Xu wrote:
> IIUC:
> CHECK=0, RESTRICT=0: do nothing, current behavior
> CHECK=1, RESTRICT=0: permissive mode - ignore AT_CHECK results.
> CHECK=0, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, no exception.
> CHECK=1, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, except
> those in the "checked-and-allowed" list.

I had much the same question for Mickaël while working on this.

Essentially, "CHECK=0, RESTRICT=1" means to restrict without checking. 
In the context of a script or macro interpreter, this just means it will 
never interpret any scripts. Non-binary code execution is fully disabled 
in any part of the process that respects these bits.

"CHECK=1, RESTRICT=1" means to restrict unless AT_CHECK passes. This 
case is the allow list (or whatever mechanism is being used to determine 
the result of an AT_CHECK check). The actual mechanism isn't the 
business of the script interpreter at all, it just has to refuse to 
execute anything that doesn't pass the check. So a generic interpreter 
can implement a generic mechanism and leave the specifics to whoever 
configures the machine.

The other two case are more obvious. "CHECK=0, RESTRICT=0" is the 
zero-overhead case, while "CHECK=1, RESTRICT=0" might log, warn, or 
otherwise audit the result of the check, but it won't restrict execution.

Cheers,
Steve

