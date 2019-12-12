Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A864911D473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfLLRrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:47:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730200AbfLLRry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576172873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASYuMc+fUDlTjfvYIhv1Vh2nVmLhsT9gDD/FqNpAF6k=;
        b=F9ubnpyFd+mWeo376TIKZcL4BtiKFF3O4Qs1BqDhWSV1QvCC/+trycWjxZodMMd9m+jlpT
        wE4mkBPUTrDN4vWdIm0Le7fSAFJSRc6jsoQRdxYDQwdcD6RjxxNRPpm0bZWDW3LgceessS
        +iUoujU1kUcPAui2CDD4ESgOQ3xDx7A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_xvQwTkPMcimFcWS1fFEvQ-1; Thu, 12 Dec 2019 12:47:50 -0500
X-MC-Unique: _xvQwTkPMcimFcWS1fFEvQ-1
Received: by mail-qt1-f200.google.com with SMTP id o24so1871692qtr.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 09:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASYuMc+fUDlTjfvYIhv1Vh2nVmLhsT9gDD/FqNpAF6k=;
        b=HJSeybldjgYaRyqvhqfcz8HhwYABZad5YFVIYde8ZIeKKozLMwUbl4NTG8UJLxpJZU
         6Nn/Zv0Yqe7NMVn0o1dQTKxvcetnfqj0X/jLT7bfHhxCfPTuKLeSkKqHYAkSQINQWOI9
         EfQ++Co2z+DNvxbo1kMhuNL1MuKiy1FF+6vKLSY+7GMvLU9BY9CA7p/w1gCB5lwf4qMb
         L8x6MH79M335yvlr77F1+xuTiErpP3RVys7Of1XSPi6Ly3niuvUu7g6Tk3eDgWqCOUiv
         5mRGq8JvrO6MBbNnh6gXZBuyEv9SFNKWzuFudrX1aK1Svtb1UWouZDYcV+O2Fmv7XkjF
         CW/g==
X-Gm-Message-State: APjAAAVtjCmTNg8j7XBJelzX4boSjD1Fgn+4o+2s4YMMgM9Bb4Hr0BVw
        taktHjVY4jUYkqZ2v4Snckzoc8Qpi80fJ4V3O0QelhODML8qcJQVIY80voiasHAK2VuHla79DKS
        jtNEEM/VBm/kUDPf0/Ku662s1DA==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr8682557qtq.17.1576172869662;
        Thu, 12 Dec 2019 09:47:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8cQXG4sfd4W+2HawtZfnusNe6YR3joXEoDhOEQpoYF8BGdk4GpmShFtI5vjEysZpsSySulw==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr8682540qtq.17.1576172869382;
        Thu, 12 Dec 2019 09:47:49 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id n129sm371776qkf.64.2019.12.12.09.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:47:48 -0800 (PST)
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191212145042.12694-1-labbott@redhat.com>
 <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
Date:   Thu, 12 Dec 2019 12:47:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 12:13 PM, Ilya Dryomov wrote:
> On Thu, Dec 12, 2019 at 3:51 PM Laura Abbott <labbott@redhat.com> wrote:
>>
>> The new mount API currently rejects unknown parameters if the
>> filesystem doesn't have doesn't take any arguments. This is
>> unfortunately a regression from the old API which silently
>> ignores extra arguments. This is easly seen with the squashfs
>> conversion (5a2be1288b51 ("vfs: Convert squashfs to use the new
>> mount API")) which now fails to mount with extra options. Just
>> get rid of the error.
>>
>> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
>> creation/configuration context")
>> Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
>> Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   fs/fs_context.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/fs_context.c b/fs/fs_context.c
>> index 138b5b4d621d..7ec20b1f8a53 100644
>> --- a/fs/fs_context.c
>> +++ b/fs/fs_context.c
>> @@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>>                  return 0;
>>          }
>>
>> -       return invalf(fc, "%s: Unknown parameter '%s'",
>> -                     fc->fs_type->name, param->key);
>> +       return 0;
>>   }
>>   EXPORT_SYMBOL(vfs_parse_fs_param);
> 
> Hi Laura,
> 
> I'm pretty sure this is a regression for all other filesystems
> that used to check for unknown tokens and return an error from their
> ->mount/fill_super/etc methods before the conversion.
> 
> All filesystems that provide ->parse_param expect that ENOPARAM is
> turned into an error with an error message.  I think we are going to
> need something a bit more involved in vfs_parse_fs_param(), or just
> a dummy ->parse_param for squashfs that would always return 0.
> 
> Thanks,
> 
>                  Ilya
> 

Good point, I think I missed how that code flow worked for printing
out the error. I debated putting in a dummy parse_param but I
figured that squashfs wouldn't be the only fs that didn't take
arguments (it's in the minority but certainly not the only one).
I'll see about reworking the flow unless Al/David want to
see the dummy parse_param or give a patch.

Thanks,
Laura

