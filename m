Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385F263516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIIRzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:55:50 -0400
Received: from smtp-8fac.mail.infomaniak.ch ([83.166.143.172]:49245 "EHLO
        smtp-8fac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgIIRzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:55:50 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BmqSL5vl0zlhLB1;
        Wed,  9 Sep 2020 19:55:46 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BmqSH5cwXzlh8TF;
        Wed,  9 Sep 2020 19:55:43 +0200 (CEST)
Subject: Re: [RFC PATCH v8 0/3] Add support for AT_INTERPRETED (was O_MAYEXEC)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200908075956.1069018-1-mic@digikod.net>
 <20200908185026.GU1236603@ZenIV.linux.org.uk>
 <e3223b50-0d00-3b64-1e09-cfb1b9648b02@digikod.net>
 <20200909170851.GL6583@casper.infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <3e83b98e-a99d-2e7d-a205-aa83ce94f3fe@digikod.net>
Date:   Wed, 9 Sep 2020 19:55:48 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200909170851.GL6583@casper.infradead.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 09/09/2020 19:08, Matthew Wilcox wrote:
> On Wed, Sep 09, 2020 at 09:19:11AM +0200, Mickaël Salaün wrote:
>>
>> On 08/09/2020 20:50, Al Viro wrote:
>>> On Tue, Sep 08, 2020 at 09:59:53AM +0200, Mickaël Salaün wrote:
>>>> Hi,
>>>>
>>>> This height patch series rework the previous O_MAYEXEC series by not
>>>> adding a new flag to openat2(2) but to faccessat2(2) instead.  As
>>>> suggested, this enables to perform the access check on a file descriptor
>>>> instead of on a file path (while opening it).  This may require two
>>>> checks (one on open and then with faccessat2) but it is a more generic
>>>> approach [8].
>>>
>>> Again, why is that folded into lookup/open/whatnot, rather than being
>>> an operation applied to a file (e.g. O_PATH one)?
>>
>> I don't understand your question. AT_INTERPRETED can and should be used
>> with AT_EMPTY_PATH. The two checks I wrote about was for IMA.
> 
> Al is saying you should add a new syscall, not try to fold it into
> some existing syscall.
> 
> I agree with him.  Add a new syscall, just like you were told to do it
> last time.
> 

OK, but I didn't receive a response for my proposition to extend
faccessat2(2).
