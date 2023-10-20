Return-Path: <linux-fsdevel+bounces-811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF37D0A95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 10:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E45C28243C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6151118B;
	Fri, 20 Oct 2023 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4ED10A0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 08:34:43 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A5D41;
	Fri, 20 Oct 2023 01:34:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qtkxp-0007ci-Gi; Fri, 20 Oct 2023 10:34:37 +0200
Message-ID: <38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>
Date: Fri, 20 Oct 2023 10:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] attr: block mode changes of symlinks
Content-Language: en-US, de-DE
To: Jesse Hathaway <jesse@mbuki-mvuki.org>,
 "Christian Brauner (Microsoft)" <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
 Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697790881;dcf01234;
X-HE-SMSGID: 1qtkxp-0007ci-Gi

[adding Christian, the author of what appears to be the culprit]

On 18.10.23 20:49, Jesse Hathaway wrote:
> On Wed, Oct 18, 2023 at 1:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:

FWIW, this thread afaics was supposed to be in reply to this submission:

https://lore.kernel.org/all/20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org/

That patch later became 5d1f903f75a80d ("attr: block mode changes of
symlinks") [v6.6-rc1, v6.5.5, v6.1.55, v5.4.257, v5.15.133, v5.10.197,
v4.19.295, v4.14.326]

>>> Unfortunately, this has not held up in LTSes without causing
>>> regressions, specifically in crun:
>>>
>>> Crun issue and patch
>>>  1. https://github.com/containers/crun/issues/1308
>>>  2. https://github.com/containers/crun/pull/1309
>>
>> So thre's a fix already for this, they agree that symlinks shouldn't
>> have modes, so what's the issue?
> 
> The problem is that it breaks crun in Debian stable. They have fixed the
> issue in crun, but that patch may not be backported to Debian's stable
> version. In other words the patch seems to break existing software in
> the wild.
> 
>> It needs to reverted in Linus's tree first, otherwise you will hit the
>> same problem when moving to a new kernel.
> 
> Okay, I'll raise the issue on the linux kernel mailing list.

Did you do that? I could not find anything. Just wondering, as right now
there is still some time to fix this regression before 6.6 is released
(and then the fix can be backported to the stable trees, too).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

