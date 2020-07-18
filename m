Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5598622490C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 07:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGRFoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgGRFom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:44:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49773C0619D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 22:44:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so20386198wml.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 22:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qx6HCNIEzxBJQ2LhKKaEe4hUhhin7nepsQjM7Mz50yk=;
        b=L2K9eOv37PLZ5zzDhxyHvYXOmBZEIYSnPFvn+6M/BOSl30ZW2EmcNE6MbgBqKb6uAL
         DtC6NoAq/Lz1bMtHCx2tiVONbDEwABL8RkFUc9xMjbVGZJJm6XNiIAqvSJj5Av9TjLxb
         R1ALpiGmpn4tBv98T5o6rDx16T3mD1lUkHH8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qx6HCNIEzxBJQ2LhKKaEe4hUhhin7nepsQjM7Mz50yk=;
        b=VFqRjCqpPX2ZWrdGx5Gb/1AkviSNg18n6Z6SAMZTvafywplZ8WtUUOjC6b8RSy4+MO
         orA+OP9CKW3ZwcZe3dieDv5Y1MKf/3TwWBQFYweYn92jXQPS2lQiyLDw93oxkTeSsHgt
         x6RHPmSAEE5jLuyTZ7o0tr+O0ZwXacqv9BYaKVK7h0NC7s23kww0NT+7VBk5OBHsUq0n
         flaNHYa8NTEj1kAKXcVFmOWsF9jA5mKdFYoqHHxN9akOvpYelDzWyU5zb3RhC7CcClCw
         nNEawRHfhUvCccDsUeYiPbwO+wh+niv81HyMB5Wun5MTATZyB6+MgLsT49IuP3zzfk4R
         U1MA==
X-Gm-Message-State: AOAM5334BE/+YeDVfgH5lJpN/3z8EQmh48dP6NvdOCq+jLRoRT/SVzcO
        QIgfF4vFjcZkkMYecZZMo4EtM47xPGsTzQ==
X-Google-Smtp-Source: ABdhPJw0ezTYJ55HknbzYtiAGiiPgg1mv3dIqbd4Ja9oCyuLV1RJ6FLoKAZoykHZXDrXk5gPDvEzIQ==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr12810017wmj.112.1595051080587;
        Fri, 17 Jul 2020 22:44:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w7sm17168898wmc.32.2020.07.17.22.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 22:44:39 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
 <202007171502.22E12A4E9@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <99c58d32-da28-79ad-2fdb-83e0ca29660a@broadcom.com>
Date:   Fri, 17 Jul 2020 22:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007171502.22E12A4E9@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 2020-07-17 3:06 p.m., Kees Cook wrote:
> On Fri, Jul 17, 2020 at 12:04:18PM -0700, Scott Branden wrote:
>> On 2020-07-17 10:43 a.m., Kees Cook wrote:
>>> In preparation for refactoring kernel_read_file*(), remove the redundant
>>> "size" argument which is not needed: it can be included in the return
>> I don't think the size argument is redundant though.
>> The existing kernel_read_file functions always read the whole file.
>> Now, what happens if the file is bigger than the buffer.
>> How does kernel_read_file know it read the whole file by looking at the
>> return value?
> Yes; an entirely reasonable concern. This is why I add the file_size
> output argument later in the series.
There is something wrong with this patch.  I apply patches 1-5 and these 
pass the kernel self test.
Patch 6 does not pass the kernel-selftest/firmware/fw_run_tests.sh

>>> code, with callers adjusted. (VFS reads already cannot be larger than
>>> INT_MAX.)
>>> [...]
>>> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
>>> +	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
>> Should this be SSIZE_MAX?
> No, for two reasons: then we need to change the return value and likely
> the callers need more careful checks, and more importantly, because the
> VFS already limits single read actions to INT_MAX, so limits above this
> make no sense. Win win! :)
>

