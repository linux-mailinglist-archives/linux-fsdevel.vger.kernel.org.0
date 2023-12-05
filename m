Return-Path: <linux-fsdevel+bounces-4876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAF805765
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443B8280E88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FEE584C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:35:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D44A0;
	Tue,  5 Dec 2023 04:49:51 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rAUs0-0006bO-Oa; Tue, 05 Dec 2023 13:49:48 +0100
Message-ID: <24aa7a8b-40ed-449b-a722-df4abf65f114@leemhuis.info>
Date: Tue, 5 Dec 2023 13:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regressions] ntfs3: empty file on update without forced cache
 drop
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Kari Argillander <kari.argillander@stargateuniverse.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <138ed123-0f84-4d7a-8a17-67fe2418cf29@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <138ed123-0f84-4d7a-8a17-67fe2418cf29@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701780592;01e3973a;
X-HE-SMSGID: 1rAUs0-0006bO-Oa

[adding a bunch of people and two lists to the recipients, as Konstantin
apparently hasn't sent any mail to any lists archived on lore for ~six
weeks; maybe someone knows what's up or is willing to help out]

On 27.11.23 07:18, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Konstantin, I noticed a regression report in bugzilla.kernel.org.
> Apparently it's cause by a change of yours.
> 
> As many (most?) kernel developers don't keep an eye on bugzilla, I
> decided to forward it by mail. Note, you have to use bugzilla to reach
> the reporter, as I sadly[1] can not CCed them in mails like this.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218180 :

Konstantin, are you still around? Would be great if you could look into
this regression, as this sounds somewhat worrying.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> The problem I am facing is the following:
>> 1. I mount an NTFS partition via NTFS3
>> 2. I create a file
>> 3. I write to the file
>> 4. The file is empty
>> 5. I remount the partition
>> 6. The file has the changes I made before the remount
>>
>> I can avoid the remount by doing:
>> sudo sysctl vm.drop_caches=3
> 
> See the ticket for more details. It according to the report happens
> still happens with 6.7-rc2, but not with 6.1.y. The reporter bisected
> the problem to ad26a9c84510af ("fs/ntfs3: Fixing wrong logic in
> attr_set_size and ntfs_fallocate") [v6.2-rc1].
> 
> Side note: while briefly checking lore for existing problems caused by
> that change I noticed two syzbot reports about it that apparently nobody
> looked into:
> 
> https://lore.kernel.org/all/000000000000bdf37505f1a7fc09@google.com/
> https://lore.kernel.org/all/00000000000062174006016bc386@google.com/
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: ad26a9c84510af
> https://bugzilla.kernel.org/show_bug.cgi?id=218180
> #regzbot title: ntfs3: empty file on update without forced cache drop
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> [1] because bugzilla.kernel.org tells users upon registration their
> "email address will never be displayed to logged out users"
> 
> 

