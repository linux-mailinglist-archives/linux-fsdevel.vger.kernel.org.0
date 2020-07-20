Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218AD227377
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGUAF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGUAF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:05:27 -0400
X-Greylist: delayed 1140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jul 2020 17:05:27 PDT
Received: from dancol.org (dancol.org [IPv6:2600:3c01::f03c:91ff:fedf:adf3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E18C061794;
        Mon, 20 Jul 2020 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
         s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=M7ne2wNKGUVfQ0Rq3JJyzcSeIutkzaWRH6uidYm39t4=; b=Cf9bd9kD7v15wkq5sgFaaARD9w
        l+ogJcTLirmPy+sz6hVZY9VSrPOk3KqeB8fKR6CFfBqwanb1SAgwQcLszVewUHssb2ckJp5hC5GPL
        7rAUYbNVVRhEsIclBaQmtdjQ4cy9xpzA7CLRX5PeSEtgmROcx1rO+Zncr4xhJNy0AtXyqoLvAwT0D
        vZ3QgzCD1utTm1+ctnDxX9cItabFAlzM8UKbyOMtd2BSztER8X+QMWUZTgoLRdaF8YgOOrorEK/Lh
        OPn6vp7jVmuczxtaA4mSE09zHR3BqXa02Bwwoc66unZ8KlhkzAAJZpt6sIZw4/Wt46F7tqFl7HVFj
        LKXEuaag==;
Received: from [2604:4080:1321:9a00:cd6:9ee0:a66c:7274]
        by dancol.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <dancol@dancol.org>)
        id 1jxfUC-0000tF-Re; Mon, 20 Jul 2020 16:46:20 -0700
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
To:     Al Viro <viro@zeniv.linux.org.uk>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Markus Elfring <Markus.Elfring@web.de>
References: <0000000000001bbb6705aa49635a@google.com>
 <20200713084512.10416-1-hdanton@sina.com>
 <20200720160059.GO2786714@ZenIV.linux.org.uk>
From:   Daniel Colascione <dancol@dancol.org>
Message-ID: <1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org>
Date:   Mon, 20 Jul 2020 16:46:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720160059.GO2786714@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/20/20 9:00 AM, Al Viro wrote:
> On Mon, Jul 13, 2020 at 04:45:12PM +0800, Hillf Danton wrote:
> 
>> Bridge the gap between slab free and the fput in task work wrt
>> file's private data.
> 
> No.  This
> 
>> @@ -2048,6 +2055,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>>   
>>   	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>>   	if (fd < 0) {
>> +		file->private_data = NULL;
>>   		fput(file);
>>   		goto out;
>>   	}
>>
> 
> is fundamentally wrong; you really shouldn't take over the cleanups
> if you ever do fput().

Yep. I don't recall how the O_CLOEXEC got in there: that's indeed wrong, 
and probably the result of patch-editing butchery. As for the exit 
cleanup: yes, that's a bug. I was trying to keep the exit paths 
together. We could fix it forward (which seems simple enough) or re-submit.
