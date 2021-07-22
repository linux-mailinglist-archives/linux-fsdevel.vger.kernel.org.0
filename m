Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966223D300A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhGVWZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 18:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGVWZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:25:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E06CC061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 16:06:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so6406754pjz.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UX80Zg7G9R6TR4N/QY6RPnMxTLMXDyaEGBPpPaGdslU=;
        b=Mg272/+koMCLUwqtk4UiQ2FwkocNUANXeoIvbzzl4CKBPyxLKbsI7h96iSHN42yWhE
         AqWXzmBjDDIzYE6JHKttstrtZgD1/8gbKqUiwPfeEss8H0bH9SYmpXKwTKG26eW6OgSx
         xFzvlWbogQ3OF8Dyv+VofXyCU5czG3ew0oCq68JlMQEwk1Xy6W9B75Hk/tHqgbBpVaqM
         iD9Id6jg8IB3PEnArAVcl6xcsO2K5n6FsYmkHkm4/mzRSkFuSc34hy/fbHKDuxWNfm25
         UrnP0Uktpj/PvnfPcgkMxRmaU1TmEWPX4vOmEDQy18dnPRK1nCZglkz5CNsxOXcXC/fe
         0XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UX80Zg7G9R6TR4N/QY6RPnMxTLMXDyaEGBPpPaGdslU=;
        b=iFYXYtbaU5pFJvsDqSSYK2C0tPRo3v1dTKgUwg5bERFfZ4A8p+HRm3P2RbUyJsWWCw
         3Ia/GVI5AOyayeOMZ6S3Ih5euPAz4vaoEY95s8mf5vExDINUkXChY3rzYoAqeBIBeHh3
         X55xdnSF/FHUxQGIw5QWdmSECRn1mQQ3m4GpEbjdKCTgft+PamrvNO1Nj+0vXYVV39GQ
         gJXqV1m64C6UnBR+702IzZ9bqkk83jiaryeOSKdoHT3v6aNM65JDmSsce5fXyIBFTe+j
         lFNBH3PZjlWnDIagLpLQn7929R5Os4EkSZRew8E/l1C4/PkKI8+LcOBy3ha5xI7KFOoV
         8BAQ==
X-Gm-Message-State: AOAM533YwoqXGxj0PXleGAFQAHJFacD+U6nPpEOpFA2jBSD4YYK1f9hB
        FKW4SU995GoPtloKtLwsrks5aA==
X-Google-Smtp-Source: ABdhPJwhJXwMjQftVM62LeKSP5qwoSyOVoOFdj8rVQZwshe3ZY0gW+v33Jy7n2UP5XHHU/LRSHQGlA==
X-Received: by 2002:a63:409:: with SMTP id 9mr2213703pge.132.1626995186236;
        Thu, 22 Jul 2021 16:06:26 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id w6sm35661105pgh.56.2021.07.22.16.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 16:06:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: refactor io_sq_offload_create()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1618916549.git.asml.silence@gmail.com>
 <939776f90de8d2cdd0414e1baa29c8ec0926b561.1618916549.git.asml.silence@gmail.com>
 <YPnqM0fY3nM5RdRI@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57758edf-d064-d37e-e544-e0c72299823d@kernel.dk>
Date:   Thu, 22 Jul 2021 17:06:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPnqM0fY3nM5RdRI@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/22/21 3:59 PM, Al Viro wrote:
> On Tue, Apr 20, 2021 at 12:03:33PM +0100, Pavel Begunkov wrote:
>> Just a bit of code tossing in io_sq_offload_create(), so it looks a bit
>> better. No functional changes.
> 
> Does a use-after-free count as a functional change?
> 
>>  		f = fdget(p->wq_fd);
> 
> Descriptor table is shared with another thread, grabbed a reference to file.
> Refcount is 2 (1 from descriptor table, 1 held by us)
> 
>>  		if (!f.file)
>>  			return -ENXIO;
> 
> Nope, not NULL.
> 
>> -		if (f.file->f_op != &io_uring_fops) {
>> -			fdput(f);
>> -			return -EINVAL;
>> -		}
>>  		fdput(f);
> 
> Decrement refcount, get preempted away.  f.file->f_count is 1 now.
> 
> Another thread: close() on the same descriptor.  Final reference to
> struct file (from descriptor table) is gone, file closed, memory freed.
> 
> Regain CPU...
> 
>> +		if (f.file->f_op != &io_uring_fops)
>> +			return -EINVAL;
> 
> ... and dereference an already freed structure.
> 
> What scares me here is that you are playing with bloody fundamental
> objects, without understanding even the basics regarding their
> handling ;-/

Let's calm down here, no need to resort to hyperbole. It looks like an
honest mistake to me, and I should have caught that in review. You don't
even need to understand file structure life times to realize that:

	put(shared_struct);
	if (shared_struct->foo)
		...

is a bad idea. Which Pavel obviously does.

But yes, that is not great and obviously a bug, and we'll of course get
it fixed up asap.

-- 
Jens Axboe

