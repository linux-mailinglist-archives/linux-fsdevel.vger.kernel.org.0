Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0755D49C448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 08:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiAZH2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 02:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAZH2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:28:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0AC06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 23:28:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d187so635225pfa.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=448JCS0TGCs/U5wG+pc2JmntI58AwzlCPEMKNV4EXYk=;
        b=a/JcIhDUOXwcISRz0g8PmQvhyiFI0JcDogXwV30CyILKkvF3V0johQ63p5xrtGGzQm
         uwYUOArzwOlr1xd1oMQT6FwmoQ0cGVNS570QOF0gj3YQ6BNk3TDe1Ka7WqREq0AvrVnC
         v8QmtCDVTJZfHKmicq3bPuTfRQxG5/CjwrUaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=448JCS0TGCs/U5wG+pc2JmntI58AwzlCPEMKNV4EXYk=;
        b=YoBQo5a0Hj59iZc1juoPAUuWehYgg4UCR8/lqaKpA5Qr0eFzUl3hLCExZ5EMi5CbkF
         ngfnMwR4juhPzBP7RxaFas2weQioRW8fCpg0oH/RvBAy5eYiL0v9mdqscaUrLcVnTDTv
         uXUcs1WO0jcbClqscF9fJH1SSEW/ej+P+3BV3WeEK11t0lwD5KjDa/VEW3h8rE2rDeE9
         QcXFfrs+bviO+C9GBehTdhk6tcVIZhh1e54Rwome8cJBqGDGXPO+DC+BbLzng5ijS0SP
         FjoANw9QfsQOP/e8VXL7ku4Yo+qutGUWbJ34OlbF0tRRALbMI90gT8k6Z8erM+bwLRPe
         2wMQ==
X-Gm-Message-State: AOAM530vtqm/Ag+TpR7Ro+lVMhgvOa31lxfqP7jO3NGCxGXlFPnCKjos
        URGkvSmGxjEjNwrdh3iGdcIXPw==
X-Google-Smtp-Source: ABdhPJx2uSdm7HvCKN19LBtH67R2De57zlHrlTdNoltu1BiwBIIREJCnptYM/aaVmtzxkQ4ktak4gg==
X-Received: by 2002:a63:8649:: with SMTP id x70mr13616091pgd.530.1643182087779;
        Tue, 25 Jan 2022 23:28:07 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w19sm1203427pfu.47.2022.01.25.23.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 23:28:07 -0800 (PST)
Date:   Tue, 25 Jan 2022 23:28:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
CC:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
User-Agent: K-9 Mail for Android
In-Reply-To: <202201252241.7309AE568F@keescook>
References: <20220126043947.10058-1-ariadne@dereferenced.org> <202201252241.7309AE568F@keescook>
Message-ID: <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On January 25, 2022 10:42:41 PM PST, Kees Cook <keescook@chromium=2Eorg> w=
rote:
>On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
>> The first argument to argv when used with execv family of calls is
>> required to be the name of the program being executed, per POSIX=2E
>>=20
>> By validating this in do_execveat_common(), we can prevent execution
>> of shellcode which invokes execv(2) family syscalls with argc < 1,
>> a scenario which is disallowed by POSIX, thus providing a mitigation
>> against CVE-2021-4034 and similar bugs in the future=2E
>>=20
>> The use of -EFAULT for this case is similar to other systems, such
>> as FreeBSD and OpenBSD=2E
>>=20
>> Interestingly, Michael Kerrisk opened an issue about this in 2008,

For v2 please include a URL for this=2E I assume you mean this one?
https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D8408

>> but there was no consensus to support fixing this issue then=2E
>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>> of this bug in a shellcode, we can reconsider=2E
>>=20
>> Signed-off-by: Ariadne Conill <ariadne@dereferenced=2Eorg>
>
>Yup=2E Agreed=2E For context:
>https://www=2Equalys=2Ecom/2022/01/25/cve-2021-4034/pwnkit=2Etxt
>
>> ---
>>  fs/exec=2Ec | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/exec=2Ec b/fs/exec=2Ec
>> index 79f2c9483302=2E=2Ede0b832473ed 100644
>> --- a/fs/exec=2Ec
>> +++ b/fs/exec=2Ec
>> @@ -1897,8 +1897,10 @@ static int do_execveat_common(int fd, struct fil=
ename *filename,
>>  	}
>> =20
>>  	retval =3D count(argv, MAX_ARG_STRINGS);
>> -	if (retval < 0)
>> +	if (retval < 1) {
>> +		retval =3D -EFAULT;
>>  		goto out_free;
>> +	}

Actually, no, this needs to be more carefully special-cased to avoid maski=
ng error returns from count()=2E (e=2Eg=2E -E2BIG would vanish with this pa=
tch=2E)

Perhaps just add:

if (retval =3D=3D 0) {
        retval =3D -EFAULT;
        goto out_free;
}

>
>There shouldn't be anything legitimate actually doing this in userspace=
=2E

I spoke too soon=2E

Unfortunately, this is not the case:
https://codesearch=2Edebian=2Enet/search?q=3Dexecve%5C+*%5C%28%5B%5E%2C%5D=
%2B%2C+*NULL&literal=3D0

Lots of stuff likes to do:
execve(path, NULL, NULL);

Do these things depend on argc=3D=3D0 would be my next question=2E=2E=2E

>
>-Kees
>
>>  	bprm->argc =3D retval;
>> =20
>>  	retval =3D count(envp, MAX_ARG_STRINGS);
>> --=20
>> 2=2E34=2E1
>>=20
>

--=20
Kees Cook
