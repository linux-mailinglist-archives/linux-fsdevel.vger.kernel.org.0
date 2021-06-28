Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21153B66EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhF1Qqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 12:46:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhF1Qqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:46:50 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCbMx-1m6x2M1VmF-009f0p; Mon, 28 Jun 2021 18:42:53 +0200
Subject: Re: [PATCH 09/14] d_path: introduce struct prepend_buffer
To:     Justin He <Justin.He@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, nd <nd@arm.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <f9908c77-77e2-03fd-25a4-f7ce9802535e@metux.net>
 <AM0PR08MB4370B5A85FFDD36D79DE73E2F7069@AM0PR08MB4370.eurprd08.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <eedc09ed-f13a-8a08-4e3a-83b2382d43cc@metux.net>
Date:   Mon, 28 Jun 2021 18:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AM0PR08MB4370B5A85FFDD36D79DE73E2F7069@AM0PR08MB4370.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dthrUENFPhTDAJHaXxtOOW91ZJIlIa6ia2+y8lO4+z2hXozUBj6
 DYlAEctl+dx18Zb5Drgx+eJKDYh2QJCaGKuRZZuo6b/S/CDBqhYbBHKEsVeIU8Wq1TxInTF
 rD0wPFlZ25k7mQUc/0Fo2K5+lktddQ50V0lD6frUWtFy7+Czqz6cVdO4xfZD047J1qvoI4z
 Vfe2uHxfJJsWZ4o5JTUPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mFKrgfwtuQ=:rl6UFEQVjySGuqWqR0IjNV
 4s2TFBnkMaQLnlsLBPq4dHlCuBX8PJ8aIXxoIxH5OTn6GFEC+W0mJFbZCdQ+NwpwqeSx5+xai
 Q+7wYY6QxQnj33ZsVIQDqsZzrYAopIaO+EOpegH9uU/YWQyZJWHBg2eVnqB3MMeccebe9T6Zu
 vVSWRsFmJS5mNWQs911NZCDOD+hpZtC9oan/ZDjMmthWnP5NAbH0fASCHQ86LHaSdRxPx4Rzi
 u3AciwqlX0eTg/6G0sdXi2GIoiAeMaM9CtlZ8XNro6vR4LM9GoAj0bToc7ahdpUtf5N1KoNKJ
 BjdZ4ZK8uhbdnqHv2J6wITmk6AXz6Mn0LRnEO7bRsE90LCWgxUN7TP/v3+hBv6kCHQF7T5Lmm
 /ytRccwOlUZRvqC6m1rsSbCkoNiC4aDbKC2nJKdWsofnDtfc9jdKbQCZvZLqzzc/W/XWCbIZR
 FaQYny11FmDqoJgH3sK+iL9C7ljkS9lSVP+3AGTfQFMJ6Bksf7T02z9xE1Wr6ZCUn2yCcdctL
 7MBVLAHkIYPRNtUs8MA3RM=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> this smells like a generic enough thing to go into lib, doesn't it ?
>>
> Maybe, but the struct prepend_buffer also needs to be moved into lib.
> Is it necessary? Is there any other user of struct prepend_buffer?

Don't have a specific use case right now, but it smells like a pretty
generic string function. Is already having more than one user a hard
requirement for putting something into lib ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
