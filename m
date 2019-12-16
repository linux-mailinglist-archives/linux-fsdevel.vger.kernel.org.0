Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE34121A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 20:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLPTjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 14:39:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLPTjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:39:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so4273579pgl.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I9OeBKtRsLmBl6NOKklX/MVPVm9L5I1LDvPG3iAqE9s=;
        b=ALIOFBI3bEMIAUXTKkKote2v3zM9qe1aVrzr0tRlt9xp6hxNUSAXldGxeRhW+pIflr
         c5bQMYaTSU2RVjEP8oTeUxiNTU1XZCNn3Kla8P+bsSS64x3zECczUEXNoyMPQK7l0vbM
         4kL5AeX0iUj5SOigJT9ZKXQHGKR4MXolQJ2Pt98IdNT2uxfJl+oeSyY7e1e0767Ga2Jx
         ghosecxY0WSC1U/06ikprx5qof7Cl6mjgzmOLpLgjPqSlez17pMmiH8xgu8JW5tbYtVC
         yVJFGffeJ89gLV3OpDDSFr0sD1qtlRGYPBxXDNSpWPsrA1omrh8JARusYUU2BkzmjjTD
         GU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9OeBKtRsLmBl6NOKklX/MVPVm9L5I1LDvPG3iAqE9s=;
        b=nkadhG88bkgDYroFjn9qs9u62q0EfvYDdfC4PgIK8zZkxuJN+RJ7P7kMwnkl/faAu7
         6JOGw1y0+9hju5q7dLc2UnRDubzpYARcJgBC0/OfwyIpH5omn8HV4PDpzbOACGTcPv8W
         jDgg5l/GtCRcDWZpXn62ADpSn7nNqy7FlT9A/GBfW4MVQcQZc2JxNes9TJZVNpDN/8HZ
         GEq7JQ8Ck12QwEJtzYlJl/pw5cJ17n2uBYx7D9CzEsCUrzlu0CKjSdr2r34HqRzChBIq
         6HalFyaiGw1xG/KwJ38ne7WxFdsiLHvQY+NSpd0ttXq3cz09XKwl7hG4s2e0AhW7jXU5
         NDtQ==
X-Gm-Message-State: APjAAAU5MAVtDHRW8nMHwKVGCw6f7hO8BzyZo+x+QfHCmKACd7HcMiFw
        pMqlp1pudT3Avj1arlTdjlTEXcoU0qE=
X-Google-Smtp-Source: APXvYqyGv15kXU7qKns1FeGYP5Jjx9Vw2i9+e3Zl9sufQl+Fuq36ToBn6f9QdN1piio/BnK2KaBO3A==
X-Received: by 2002:a62:a118:: with SMTP id b24mr17977047pff.71.1576525192147;
        Mon, 16 Dec 2019 11:39:52 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1017? ([2620:10d:c090:180::7616])
        by smtp.gmail.com with ESMTPSA id s15sm22298553pgq.4.2019.12.16.11.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 11:39:51 -0800 (PST)
Subject: Re: [PATCH 06/10] fs: move filp_close() outside of
 __close_fd_get_file()
To:     Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20191213183632.19441-1-axboe@kernel.dk>
 <20191213183632.19441-7-axboe@kernel.dk>
 <CAG48ez26wpE_K_KGsE8jfjGp3uPc_ioYhTuLv0gSmcVPPxRA3Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c88b3e49-835f-ff79-0a25-da38f2ffc6e1@kernel.dk>
Date:   Mon, 16 Dec 2019 12:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez26wpE_K_KGsE8jfjGp3uPc_ioYhTuLv0gSmcVPPxRA3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/19 12:27 PM, Jann Horn wrote:
> On Fri, Dec 13, 2019 at 7:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Just one caller of this, and just use filp_close() there manually.
>> This is important to allow async close/removal of the fd.
> [...]
>> index 3da91a112bab..a250d291c71b 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -662,7 +662,7 @@ int __close_fd_get_file(unsigned int fd, struct file **res)
>>         spin_unlock(&files->file_lock);
>>         get_file(file);
>>         *res = file;
>> -       return filp_close(file, files);
>> +       return 0;
> 
> Above this function is a comment saying "variant of __close_fd that
> gets a ref on the file for later fput"; that should probably be
> changed to point out that you also still need to filp_close().

Good point, I'll make the comment edit.

-- 
Jens Axboe

