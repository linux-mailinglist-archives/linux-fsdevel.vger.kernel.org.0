Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B965418CBA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCTKbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 06:31:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52584 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTKbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:31:31 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02KAVO9E005803;
        Fri, 20 Mar 2020 19:31:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Fri, 20 Mar 2020 19:31:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02KAVIqK005753
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 20 Mar 2020 19:31:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] umh: fix refcount underflow in fork_usermode_blob().
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
 <20200312143801.GJ23230@ZenIV.linux.org.uk>
 <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
Message-ID: <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
Date:   Fri, 20 Mar 2020 19:31:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/13 18:46, Tetsuo Handa wrote:
> On 2020/03/12 23:38, Al Viro wrote:
>> 	It _does_ look like that double-fput() is real, but
>> I'd like a confirmation before going further - umh is convoluted
>> enough for something subtle to be hidden there.  Alexei, what
>> the refcounting behaviour was supposed to be?  As in "this
>> function consumes the reference passed to it in this argument",
>> etc.
>>
> 
> Yes, double-fput() is easily observable as POISON_FREE pattern
> using debug printk() patch and sample kernel module shown below.
> 

No response from Alexei, but I think that 449325b52b7a6208 ("umh:
introduce fork_usermode_blob() helper") just did not realize that
opening a file for execution needs special handling (i.e. denying
write access) compared to opening a file for read or write.

Can we send this patch?
