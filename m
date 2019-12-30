Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D278312D4BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2019 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfL3WDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Dec 2019 17:03:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3WDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Dec 2019 17:03:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so15153662plj.5;
        Mon, 30 Dec 2019 14:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sWcIwqwAQVaMiL6AbIBVoLXwMM9wjsoCuHsXRphgo8Y=;
        b=nEQfUB9BU7XTfjYvCMI6Yd/qByThVkk2PiHeRSy9HqRXeXx/ACLKilBsXAOBcCROWX
         wuYYWc18pechAi8K+EkPH15KMlWyQ6nb0StYh3i01u248ouxra+l0YzVMzSbAIdPpj32
         8IklPGgLy/ca2jvIWXCX+wjrXBcw+YhdM6dG2drTzpt9BJH4W/VMrXUHA7PFo1I1D0fp
         bV/2HKq3EUqlQLAmrkiIYXp5l16qLryAJoIvQkBet0s7dkrKl35d2kNDuDe+cTkV6CtO
         pdBNwQkWVWBXVmtsGPAeYKEJ7QDU9Bg9dcnJKVDvMxCHqk2OAX0edZ0X4oodFaH8Hq0U
         10lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sWcIwqwAQVaMiL6AbIBVoLXwMM9wjsoCuHsXRphgo8Y=;
        b=hVBUeYUlCs6CqAhqAz823TJP4I7aok2n7HhCS49Q+MIV6qlAPVj1aeV+ulYZh4yk0s
         9thbKAY9G/bOcbFwXO045HrVI/GQUWdWsSQGx5IJpowDcnW+9wdcNN+rKbFwZJ6UMUEP
         cMHMXE9g+qQlG4WCbCzEovuR1dvQsBNesfpeXWV1RnwZ4e0e1gqhPpcL//2xYoDIgVJZ
         S427ewzNvTEb6irnPBgrnHdQlMnq3IoxpTr3b+WrtwlVONJrhIp6jzxOQSB0IGUwE5Gb
         mFmqQ6Vhx8V+99kV7PKPHn89ECDfEt7iPt8XmspaARKoIyfLecDhmS5rJKrK+HKSig9o
         pEQA==
X-Gm-Message-State: APjAAAUy/YfQAqm4vm79o9LeA8YY6ValEGXJrOWrVcucn3aCP4B8SyK9
        LDtSX2t+F8XF6zVLNJQmYxE=
X-Google-Smtp-Source: APXvYqzCT9zC3ZgKpQpD5zdYtsdEacKle/p/witN0yVp/CLOmZS4R1vbOaH6CIUVFPPMG9wX2sUhEg==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr1776310pja.78.1577743416953;
        Mon, 30 Dec 2019 14:03:36 -0800 (PST)
Received: from JF-EN-C02V905BHTDF.tld ([12.111.169.54])
        by smtp.gmail.com with ESMTPSA id l8sm511900pjy.24.2019.12.30.14.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 14:03:36 -0800 (PST)
Subject: Re: [PATCH v6 07/10] proc: flush task dcache entries from all procfs
 instances
To:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
 <20191225125151.1950142-8-gladkov.alexey@gmail.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <8d85ba43-0759-358e-137d-246107bac747@gmail.com>
Date:   Mon, 30 Dec 2019 14:03:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191225125151.1950142-8-gladkov.alexey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

snip

.

.

.

>   
> +#ifdef CONFIG_PROC_FS
> +static inline void pidns_proc_lock(struct pid_namespace *pid_ns)
> +{
> +	down_write(&pid_ns->rw_proc_mounts);
> +}
> +
> +static inline void pidns_proc_unlock(struct pid_namespace *pid_ns)
> +{
> +	up_write(&pid_ns->rw_proc_mounts);
> +}
> +
> +static inline void pidns_proc_lock_shared(struct pid_namespace *pid_ns)
> +{
> +	down_read(&pid_ns->rw_proc_mounts);
> +}
> +
> +static inline void pidns_proc_unlock_shared(struct pid_namespace *pid_ns)
> +{
> +	up_read(&pid_ns->rw_proc_mounts);
> +}
> +#else /* !CONFIG_PROC_FS */
> +
Apologies for my newbie question. I couldn't help but notice all these 
function calls are assuming that the parameter struct pid_namespace 
*pid_ns will never be NULL.  Is that a good assumption?

I don't have the background in this code to answer on my own, but I 
thought I'd raise the question.

Thanks,
Jay

