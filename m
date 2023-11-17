Return-Path: <linux-fsdevel+bounces-3005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F97EEAF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 03:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5042810A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71E469E;
	Fri, 17 Nov 2023 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from p3plwbeout17-03.prod.phx3.secureserver.net (p3plsmtp17-03-2.prod.phx3.secureserver.net [173.201.193.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEC1A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 18:17:41 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.144])
	by :WBEOUT: with ESMTP
	id 3oQMrHXpzRBA43oQNrShF8; Thu, 16 Nov 2023 19:17:39 -0700
X-CMAE-Analysis: v=2.4 cv=WanJ12tX c=1 sm=1 tr=0 ts=6556cd44
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=TT3OXX8_H1iH7GK2:21 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10
 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=TlpUs8yM1Nx5ixtUQMgA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=b0R6z3OkPTeaBGj_aaBY:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID: 3oQMrHXpzRBA4
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.90])
	by smtp06.mailcore.me with esmtpa (Exim 4.94.2)
	(envelope-from <phillip@squashfs.org.uk>)
	id 1r3oQM-00063O-FT; Fri, 17 Nov 2023 02:17:39 +0000
Message-ID: <748e3619-6569-2f71-7ed1-f67225892e14@squashfs.org.uk>
Date: Fri, 17 Nov 2023 02:17:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the length
 is 0
To: Andrew Morton <akpm@linux-foundation.org>,
 Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
References: <0000000000000526f2060a30a085@google.com>
 <20231116031352.40853-1-lizhi.xu@windriver.com>
 <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfPaHxhWB8AlONqti6fk0Il/mSHpwpY8m7Odf17tgDcdcVa1CwBZvmbUwDwIksFKL7MkNAhcfdeXF7uSpW5dQ2kru2gDgaNa+EYDLbf7hO/h94YRY6yy+
 ybi9mio24R4INS/pa2jEADr4b4xjXG+1R8IiiMfdIuO5gMi9G1cGsFhg2ItLaMvviVf0ML4+BOiEshL0VdfEU3r63KFfmTy5anOp8fLJGnHh8Xya2XTpa/Qt
 RSrcG0xvdAaQvS5pKHoSLQ==

On 16/11/2023 21:43, Andrew Morton wrote:
> On Thu, 16 Nov 2023 11:13:52 +0800 Lizhi Xu <lizhi.xu@windriver.com> wrote:
> 
>> when the length passed in is 0, the subsequent process should be exited.
> 
> Thanks, but when fixing a bug, please always describe the runtime
> effects of that bug.  Amongst other things, other people need this
> information to be able to decide which kernel versions need patching.
> 
>> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com
> 
> Which is a reason why we're now adding the "Closes:" tag after
> Reported-by:.

Which is also one reason why you should always run scripts/checkpatch.pl
on your patch.  This alerted me to the need for a "Closes:" tag
after Reported-by: on the last patch I sent.

> 
> I googled the sysbot email address and so added
> 
> Closes: https://lkml.kernel.org/r/0000000000000526f2060a30a085@google.com
> 
> to the changelog.

Thanks.  That is indeed the sysbot issue that the patch fixes.

> 
> I'll assume that a -stable kernel backport is needed.
> 
> 

Yes.

Phillip


