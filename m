Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927C116EE5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgBYSt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 13:49:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44042 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgBYSt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:49:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so144735plo.11;
        Tue, 25 Feb 2020 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nvwGkkcwwig4eCR4m0+EXyPalZCNu0nCU8n4Iqik970=;
        b=G7bWyZbHZX8L5mx1qmuUrJ6R/u1VcW6191mW+YfJDBC8HLgDFKfKHWQEOoEJoVhkXn
         W/y6CCVqFL92NYn57nNRjyHA6lwYbRoweC1yYGHTkJzL53mymmUpJksjTWZ7ySbaPrRB
         n0dyGnxfMmOFoTSoRJbqDT3MGEuqUxVvZXV12P4m3+0oJWHi3DH5TMF+x/W1qg0hNMxA
         CLweY4F1EeybVJFQ04jKbevHMx8Vcg43jgMKOzPQ4W+7RIFDB5lRmOdZqHKK6pq4BKkF
         NJ9ve8xEqDSWGj1UXvCZkB5iZd0pmON/92SSjvdIELk2bdaMvOd6OKLXHoTzYJLCvTa+
         zcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nvwGkkcwwig4eCR4m0+EXyPalZCNu0nCU8n4Iqik970=;
        b=uHHAIJZKoQDrf7xJVbKS38TFWc1YeoYHpYTP4TKy221TnVQXTOu7e4hwSHjBuSi6r8
         8fb64eNsBkAbxjN3ZyIvJ+7gkM7ioTMt0wntDZTnzO20DcispTXjQGxblKDNlaRgpLyL
         wiMANgQ9n6DUCunoH3ulmZoQd4/k0ecflh9IlGCXApc25/eeQ8VAiWMlwZQlhsVskjqB
         I4xaJEzm9XBSK1s9bDSjNb4HurgOimoQ5rZjEyjLF/Vf0lmOSkW5CeckHBlcFs1jrqeC
         zlj4VlG13XprAXC853D/uRRl1s0jJiBGhjgt0rAhjTdyWYtayNhJVMSZMwlU2tpVuLQ3
         3LzQ==
X-Gm-Message-State: APjAAAXs+N4FNq/SkE71+8CPflZ4wpbrbCFNvOR+Wxad/dEXqxDn/rhI
        yLmVSTicxG3nv8ivKCnfuOA=
X-Google-Smtp-Source: APXvYqwqCzAhzlldh7y2QteC8HJxHmiV+T+MgbEcZee4Qfdqy017TQ2Ol+QM4KbM9t0bb8tGyUsHwA==
X-Received: by 2002:a17:902:bc45:: with SMTP id t5mr56453991plz.239.1582656596777;
        Tue, 25 Feb 2020 10:49:56 -0800 (PST)
Received: from JF-EN-C02V905BHTDF.tld ([12.111.169.54])
        by smtp.gmail.com with ESMTPSA id q9sm14936484pgs.89.2020.02.25.10.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 10:49:56 -0800 (PST)
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200224160215.4136-1-mic@digikod.net>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <6df3e6b1-ffd1-dacf-2f2d-7df8e5aca668@gmail.com>
Date:   Tue, 25 Feb 2020 10:49:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/24/20 8:02 AM, Mickaël Salaün wrote:

> ## Syscall
>
> Because it is only tested on x86_64, the syscall is only wired up for
> this architecture.  The whole x86 family (and probably all the others)
> will be supported in the next patch series.
General question for u.  What is it meant "whole x86 family will be 
supported".  32-bit x86 will be supported?

Thanks,
Jay

