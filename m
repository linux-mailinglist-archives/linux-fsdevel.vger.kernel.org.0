Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097CA1AFEE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSXRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 19:17:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40166 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSXRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:17:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so3241466plo.7;
        Sun, 19 Apr 2020 16:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y10OAFrPiAt4TKEL/D56H00tjioHU0owftouG0pGmVs=;
        b=kYJ79hDgyG00Lxlp7Y5Nw32T2tPr5noj+c0ze4JgFbsvKiSJPAzdfl6jvodm5pQ3GL
         +DcKRGEFJ3nLuKHwpEx+bWsfPWKGGOgC2JxXBOReSuAOpBd3yC0K6njtsg8Vp9jA+2FE
         eNpDVd871XIYfw0LTGNtXUkdUhvg9GhvfKGaCHDMCERcXl7j5/4axJVPRdQ23ntDiRqK
         mur2jxYdDTK91KOLMwJBukdfojM97vEPYld15pgFUBdAkdJxa6iTyIbbhp8nSVEZiuNy
         E/PNIbeoUAE1I3TqOkbPw4Tj8OXXs7Y8DMRbJJMuswIBO1UKSiBzLGscO1tbwzcQOrh9
         mqPA==
X-Gm-Message-State: AGi0PubOWK08LOYWcHodfdZn2De+lW1LwoSUMXKuqbazZuhnaDFw2i2m
        tSiZFo1iL3KZQ+7DDFJVNSFtupZ1dp4=
X-Google-Smtp-Source: APiQypKhsvrI8PM8T712YWcOsxumEfkDrBj0hZKU+VjzawT2rtbTHzwbaDbzGHptgsHKL/fIupYMFw==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr18067496pjs.18.1587338268810;
        Sun, 19 Apr 2020 16:17:48 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.66])
        by smtp.gmail.com with ESMTPSA id x4sm25368167pfi.202.2020.04.19.16.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 16:17:48 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
 <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
 <20200419230537.GG11244@42.do-not-panic.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c69b67d1-f887-600b-f3ab-54ab0b7dcb13@acm.org>
Date:   Sun, 19 Apr 2020 16:17:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419230537.GG11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 4:05 PM, Luis Chamberlain wrote:
> On Sun, Apr 19, 2020 at 03:57:58PM -0700, Bart Van Assche wrote:
>> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
>>> Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
>>> select DEBUG_FS, and blktrace exposes an API which userspace uses
>>> relying on certain files created in debugfs. If files are not created
>>> blktrace will not work correctly, so we do want to ensure that a
>>> blktrace setup creates these files properly, and otherwise inform
>>> userspace.
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>    kernel/trace/blktrace.c | 8 +++++---
>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>>> index 9cc0153849c3..fc32a8665ce8 100644
>>> --- a/kernel/trace/blktrace.c
>>> +++ b/kernel/trace/blktrace.c
>>> @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
>>>    					  struct dentry *dir,
>>>    					  struct blk_trace *bt)
>>>    {
>>> -	int ret = -EIO;
>>> -
>>>    	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
>>>    					       &blk_dropped_fops);
>>> +	if (!bt->dropped_file)
>>> +		return -ENOMEM;
>>>    	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
>>> +	if (!bt->msg_file)
>>> +		return -ENOMEM;
>>>    	bt->rchan = relay_open("trace", dir, buts->buf_size,
>>>    				buts->buf_nr, &blk_relay_callbacks, bt);
>>>    	if (!bt->rchan)
>>> -		return ret;
>>> +		return -EIO;
>>>    	return 0;
>>>    }
>>
>> I should have had a look at this patch before I replied to the previous
>> patch.
>>
>> Do you agree that the following code can be triggered by
>> debugfs_create_file() and also that debugfs_create_file() never returns
>> NULL?
> 
> If debugfs is enabled, and not that we know it is in this blktrace code,
> as we select it, it can return ERR_PTR(-ERROR) if an error occurs.

This is what I found in include/linux/debugfs.h in case debugfs is disabled:

static inline struct dentry *debugfs_create_file(const char *name,
	umode_t mode, struct dentry *parent, void *data,
	const struct file_operations *fops)
{
	return ERR_PTR(-ENODEV);
}

I have not found any code path that can cause debugfs_create_file() to 
return NULL. Did I perhaps overlook something? If not, it's not clear to 
me why the above patch adds checks that check whether 
debugfs_create_file() returns NULL?

Thanks,

Bart.
