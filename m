Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77281DA430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESV7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgESV7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:59:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01FC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 14:59:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so883401oti.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJ30tY44Y1IVnHTs0oYR9AupzvvK3j296liG3N8OpVo=;
        b=ftiUb59LkFILedozGY9XVYdMy2l42E9hAhepGXbGxUyVa+wAu6aqRNDMJALil6/O8J
         booNhbKuCLrJsvfeGYjMVBbrzm+mRolULhd3N/LGe1R7ZdYQZzgHYrtpJe1Rq05peuT4
         SQk27e6lcCUHwKixSX6yhM/JFqcggLFmwNd5gg8N9HHaBZCEayCGGf3J4Ks/Kpuj9Pej
         A3YhDP9GJDMu627RGDh+4viwdlrocpgf05zpzxRYjp5SXVWViTZ+1x5ji3fdzeawktay
         3oKrus4lO58304pOZVtJGawndLbdhjykoMteObMV2UkVXKcxGi2g6rBzwPJLXHgcEHzI
         m1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJ30tY44Y1IVnHTs0oYR9AupzvvK3j296liG3N8OpVo=;
        b=oIf/5e4m3gcrR5C1xJuqduPgbAuQ254j8rkfPLbEIlISqSE8UKUppo5oqD85cj6eej
         mRyAyZ/bfrL33SR84TcwZUY+tuBvdIZR8QsKpkaXiH4SAwIKOyhFab4fLodf169dsAhc
         g0zW1qC6b/cVH9q8FAHsJvvq41+cWKqPGZJRtkR/kkVZ+bdQfXW0a0KmYORwned/GFUp
         bAX285Njx4DyhezleTkDIZN12cmuLnCma9ipc5vBWE8idZLn/geE2sh5qK7yQcMrwyw8
         sM9jb1uL/VCXQ0v3j0BL86YOyrKeJsqmnckqML2bENgXJQATgIUL5kjkK3DWek0yq9Ya
         IzNg==
X-Gm-Message-State: AOAM532kaYZvdQaayZhB4JOpb9hhLO+cFeRcn5HGatA6iy3IpQCGs0ph
        lMjY+M6PhPaKIUK8tBganNz9Uw==
X-Google-Smtp-Source: ABdhPJz5fkUdyC6I3ITtCnUF9yioNlVJohurqkOOttvOIHzsFSgiV696yiAtufwGdVlHGXJPR6FFyw==
X-Received: by 2002:a9d:7657:: with SMTP id o23mr694391otl.255.1589925546087;
        Tue, 19 May 2020 14:59:06 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id k7sm235221otp.46.2020.05.19.14.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 14:59:05 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
Date:   Tue, 19 May 2020 16:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/20 7:33 PM, Eric W. Biederman wrote:
> 
> Most of the support for passing the file descriptor of an executable
> to an interpreter already lives in the generic code and in binfmt_elf.
> Rework the fields in binfmt_elf that deal with executable file
> descriptor passing to make executable file descriptor passing a first
> class concept.

I was reading this to try to figure out how to do execve(NULL, argv[], envp) to
re-exec self after a vfork() in a chroot with no /proc, and hit the most trivial
quibble ever:

> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1323,7 +1323,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 */
>  	set_mm_exe_file(bprm->mm, bprm->file);
>  
> +	/* If the binary is not readable than enforce mm->dumpable=0 */

then

Rob
