Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A01C2E05
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgECQuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgECQuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 12:50:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E33C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2020 09:50:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so4353861pfn.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2020 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+hDv4e42XPVpaU7hW2zsXn/CRTTWYsAxn7Kxlnx+tM=;
        b=b0nggKJPlLlCCGh93YpcszVXwxwMkK2lGTEPN1J/nf+PqAWjtCIrD7yq++BEc4Pc5p
         82+uIWJmP+E94cwVK4pfSTFHRwPdEveebnUudRiZiXdkCiHBZOOIPrCujeSiwx19R1BV
         ZLRaDcRIN33v5hWuoMJHTQPG4SxFPWgj+RmAdbGU+B30jOw0j9tQDOW5F80guTd4VYC5
         q+1xjpmvnkeTibW1RLKMKuPhHiL0ZcwQeHpdrDVp8s+PfpL0UrBP1tP/yfmV975VrsHi
         GKe9jWh518rRCtz9p2GRn8D+TTK3S33oJEsNwCiCfzp1eV/V5i7BWnWwwNVeoE4T5lFe
         X4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+hDv4e42XPVpaU7hW2zsXn/CRTTWYsAxn7Kxlnx+tM=;
        b=Ne2I84zMw4aBzSZ9MwmPz0qtIRiZYeb1itDvQR8c8HiU5lNikWvMVTdTZ6o56bbMaD
         ce69dhc8nsRRQKn/T8p7hDEaZnRnfQCtL49sNTwCklnR4ht2/gIT408z+M6Yhd69/Z2H
         1LNm4+U63jOtsyrYLmnc1Qy71H/K/5uGX+duDd6SNRqGVZiPr/ZPRNOAvh8dD3dBxzBB
         YLcoR/mgZhC2zXT0kLLbpjfJKlCrf5a9NYAlWUP1l6Pzc3gToZ1Ig8/ikQ+pHk1IPuBH
         tmu6IAKAA2i9ejiKH/rq6x5+XOFGxDALygAWMzfpAC6aGm1jd/zW77ERNjo3tLvAsQPh
         Tt1A==
X-Gm-Message-State: AGi0PubKr/PUZWkxyaUuVnpjjwHYXlvOgCN34FjdTlWwve9NNKlUZBTl
        3bGMf2CZkCsFPz7GjlSQ5h6yWg==
X-Google-Smtp-Source: APiQypIYiM7wd1TgxxhVB68L2GiEcwGI2ZqeyG5g7hyx33lJcIt5g3IXRV2M98kxz/uPgwnWED3MtA==
X-Received: by 2002:a63:d904:: with SMTP id r4mr13484097pgg.323.1588524619294;
        Sun, 03 May 2020 09:50:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b13sm6848308pfo.67.2020.05.03.09.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 09:50:18 -0700 (PDT)
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
 <20200501231231.GR23230@ZenIV.linux.org.uk>
 <03867cf3-d5e7-cc29-37d2-1a417a58af45@kernel.dk>
 <20200503134622.GS23230@ZenIV.linux.org.uk>
 <435c171c-37aa-8f7d-c506-d1e8f07f4bc7@kernel.dk>
Message-ID: <c8129f11-38a8-64e6-be8e-b485d2b7fb26@kernel.dk>
Date:   Sun, 3 May 2020 10:50:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <435c171c-37aa-8f7d-c506-d1e8f07f4bc7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/20 8:42 AM, Jens Axboe wrote:
> On 5/3/20 7:46 AM, Al Viro wrote:
>> On Fri, May 01, 2020 at 05:54:09PM -0600, Jens Axboe wrote:
>>> On 5/1/20 5:12 PM, Al Viro wrote:
>>>> On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
>>>>> +	flags &= EFD_SHARED_FCNTL_FLAGS;
>>>>> +	flags |= O_RDWR;
>>>>> +	fd = get_unused_fd_flags(flags);
>>>>>  	if (fd < 0)
>>>>> -		eventfd_free_ctx(ctx);
>>>>> +		goto err;
>>>>> +
>>>>> +	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
>>>>> +	if (IS_ERR(file)) {
>>>>> +		put_unused_fd(fd);
>>>>> +		fd = PTR_ERR(file);
>>>>> +		goto err;
>>>>> +	}
>>>>>  
>>>>> +	file->f_mode |= FMODE_NOWAIT;
>>>>> +	fd_install(fd, file);
>>>>> +	return fd;
>>>>> +err:
>>>>> +	eventfd_free_ctx(ctx);
>>>>>  	return fd;
>>>>>  }
>>>>
>>>> Looks sane...  I can take it via vfs.git, or leave it for you if you
>>>> have other stuff in the same area...
>>>
>>> Would be great if you can queue it up in vfs.git, thanks! Don't have
>>> anything else that'd conflict with this.
>>
>> Applied; BTW, what happens if
>>         ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
>> fails?  Quitely succeed with BS value (-ENOSPC/-ENOMEM) shown by
>> eventfd_show_fdinfo()?
> 
> Huh yeah that's odd, not sure how I missed that when touching code
> near it. Want a followup patch to fix that issue?

This should do the trick. Ideally we'd change the order of these, and
shove this fix into 5.7, but not sure it's super important since this
bug is pretty old. Would make stable backports easier, though...
Let me know how you want to handle it, as it'll impact the one you
have already queued up.


diff --git a/fs/eventfd.c b/fs/eventfd.c
index 20f0fd4d56e1..96081efdd0c9 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -422,6 +422,10 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+	if (ctx->id < 0) {
+		fd = ctx->id;
+		goto err;
+	}
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;

-- 
Jens Axboe

