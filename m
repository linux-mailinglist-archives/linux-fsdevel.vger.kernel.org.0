Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC2337953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 17:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhCKQ3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 11:29:34 -0500
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231]:51579
        "EHLO p3plsmtpa07-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234330AbhCKQ3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:29:19 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id KO4Wlnvvvw7iwKO4WlDLts; Thu, 11 Mar 2021 09:22:01 -0700
X-CMAE-Analysis: v=2.4 cv=LJqj/La9 c=1 sm=1 tr=0 ts=604a43a9
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=UxtMAKUnOHX9nP3ZsQcA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
Date:   Thu, 11 Mar 2021 11:21:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87sg52t2xj.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCw6KXGwBnnLP3nf5yMK/JbbS5lnZCXOTKhzHPQ0oQg9HY7Qi8kH8kiddRsUcU0WmeGZEMFe9eAcERzBJf3ZdG1QCnAf+/Cx4BkBKP7OH8Kh1O9sYjYX
 ShFVSqGzUYHhgyv43zxSOiz+tD9CpVdn3rBWfj+/HeAP4fvRvntpnXYvvEC5o7t2hZd/mxcOXZqsJ0ARPqiWNVOZ2h5YLz1BPJDzb/ERHiYfI+s+Jsu0KPor
 7jGPeJKgxPseyw21Rv62Wn4KFAJWAKiWlwmfGrBgWd+sj7eLiyo2DP5YTTw+7mVLNvImRfISJd1QmsC1h8LfxmIJkajGBTBPTvrpl38tlJmU+7Efae9uIVb4
 njk4EJP1V2LRYAF8G1rD8DfpAXgJF+eS3fOhRmZw93Qji0jGEt4=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/2021 5:11 AM, Aurélien Aptel wrote:
> "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:
>> I agree with Tom.  It's much easier to read if you just say that 'nobrl'
>> torns off the non-locale behaviour, and acts as 5.4 and earlier kernels.
>>    Unless there's any subtlety that makes it different.  Is there any?
> 
> nobrl also makes fnctl() locks local.
> In 5.4 and earlier kernel, flock() is local but fnctl() isn't.
> 
>> BTW, you should use "semantic newlines":
> 
> Ok, I'll redo once we agree on the text.

I wonder if it's best to leave the nobrl details to the mount.cifs
manpage, and just make a reference from here.

Another advantage of putting this in a cifs.ko-specific manpage
is that it would be significantly easier to maintain. The details
of a 5.4-to-5.5 transition are going to fade over time, and the
APIs in fcntl(2)/flock(2) really aren't driving that.

If not, it's going to be messy... Aurélien is this correct?

cifs.ko flock()
- local in <= 5.4
- remote by default in >= 5.5
- local if nobrl in >= 5.5

cifs.ko fcntl()
- remote by default in X.Y
- local if nobrl in X.Y

Not sure what the value(s) of X.Y actually might be.

It seems odd that "nobrl" means "handle locking locally, and never
send to server". I mean, there is always byte-range locking, right?

Are there any other options or configurations that alter this?

Tom.
