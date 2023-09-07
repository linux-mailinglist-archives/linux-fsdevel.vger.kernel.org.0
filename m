Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0D796F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 05:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjIGDHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:07:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075E133
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 20:07:33 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34e26daab46so1733935ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 20:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694056052; x=1694660852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e14vUEecm32PhguM8gY/B9eU6Ea95+R4btvZDIK0VTQ=;
        b=FPaCaULy+FDIMC7SkdYLTBcRIf6w0Iq/ZzSQs5qJ9GnCRbdlQqhQGEyQ8Oap/QdjN/
         8DAW2/TVL76L57zwxKW/E4RkQCKZBN1iv6X7kpyEih0duo99rBCVeQma7DrxfnNUTI5j
         RQZ9jNOrQBaG655wyUXE2St88iw2yeEWEKeikFEHJIYE3zM96qIg4N7434LZU+UbdG5D
         omY5YJJ6yQeh1o6HgWejhA1EWJ3kyPmQ25UH02UWVyeWt9cFwE84P/OUx9QI3m7o1TUQ
         SvsDMn35ZqiUU2fVaoCwtLkhgK+vk5hQLy77a/9CmTbavTn8t0gooujLQXfpHP+Xz4zd
         uU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056052; x=1694660852;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e14vUEecm32PhguM8gY/B9eU6Ea95+R4btvZDIK0VTQ=;
        b=Glm5zli+Dis36RZ8I7IEie7cxsciOjx/1E/gQnK4MbK+An4YbOExZT3nQlAUnRKzbc
         4QNPLix+ZBF12yYEqOQDN82J0l6VQ8nd99un4qC9lXOwJH6f6aPtVpBeEXkyYe3REBhk
         Yru3MCWOiOIuu+d5tHaV0YPyIopeUFAXB6AOvPsznJeFnLSxgSfwd16orleysO9NG6AZ
         NGIDcNxiXTLk0hU/5E4poC81D5dL5O94mpKaWNr+ocWIw5nAVYyzEbmX6RSw8NgYKt6b
         hKirNZOjSiw4c+b1tXriIY8p3JbNVghKybZ9D4EAfYDtrtijy8zGwJ6jbjCBhJODvei+
         xpAg==
X-Gm-Message-State: AOJu0YxguMCLPxYFhyxRBIUOyXyGOitM9zd11RWycYXZpoTqC8w4lnFG
        K9Z8dTP7jgQidnwKae4NxulT1g2FNnw=
X-Google-Smtp-Source: AGHT+IFROPavogwHRiRKuDteBbOkkS76nuUnDSbo+6C1fwJMBnMNu74dyAtpdYGWjtq7ewQyl45t8g==
X-Received: by 2002:a92:cb4e:0:b0:34c:d86f:46e9 with SMTP id f14-20020a92cb4e000000b0034cd86f46e9mr18632992ilq.12.1694056052271;
        Wed, 06 Sep 2023 20:07:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a195c00b00262d662c9adsm504311pjh.53.2023.09.06.20.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 20:07:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cf96f345-50ec-e3bc-b2a7-4769b7891a9e@roeck-us.net>
Date:   Wed, 6 Sep 2023 20:07:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkdxMh7jt5A7x67@debian.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
In-Reply-To: <ZPkdxMh7jt5A7x67@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 17:48, Bagas Sanjaya wrote:
[ ... ]
>> Case in point: After this e-mail, I tried playing with a few file systems.
>> The most interesting exercise was with ntfsv3.
>> Create it, mount it, copy a few files onto it, remove some of them, repeat.
>> A script doing that only takes a few seconds to corrupt the file system.
>> Trying to unmount it with the current upstream typically results in
>> a backtrace and/or crash.
> 
> Did you forget to take the checksum after copying and verifying it
> when remounting the fs?
> 
Sorry, I don't understand what you mean. I didn't try to remount.
The file system images in my tests are pristine, as created with mkfs, and
are marked read-only to prevent corruption. They are also md5 checksum
protected and regenerated before the test if there is a checksum mismatch.
For ntfs, the file system was created with

truncate -s 64M myfilesystem
mkfs.ntfs -F -H 1 -S 16 -p 16 myfilesystem

My tests run under qemu, and always use the -snapshot option.

The "test", if you want to call it that, is a simple

mount "${fstestdev}" /mnt
cp -a /bin /usr /sbin /etc /lib* /opt /var /mnt
rm -rf /mnt/bin
cp -a /bin /usr /sbin /etc /lib* /opt /var /mnt
umount /mnt

This is with a buildroot generated root file system. "cp -a" is a recursive
copy which copies symlinks.

If the file system is ntfs3, the rm command typically fails, complaining
that /mnt/bin is not empty. The umount command typically results in at
least a traceback, and often a crash. Repeating the cp; rm; cp sequence
multiple times quite reliably results in a file system corruption.

The resulting (corrupted or not) file system is discarded after the qemu
session.

Guenter

