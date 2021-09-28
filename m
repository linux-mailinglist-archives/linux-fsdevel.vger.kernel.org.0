Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42A741AC75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhI1J5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhI1J5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:57:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29BC061604
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 02:56:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so88995308lfe.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sU/LhEZ8q3BeQ6P/PiHIYla/ZdlSW3YiCmnYV8PIXuI=;
        b=VZb+3cpQfdzvddM3ZSwyo95tO1IwqURM2VUyschymPHl9RVL+g8ruFk5g23boV7dhD
         nI0uXn9W2EmbAY9wgbbOZoGKTUdapoQYzHW5BdSyxvA7ygd+xNKNK5TilO2yE8708XAo
         7IWDjKg5fWb3I6i4p631kDaURnh4cIsZuiaHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sU/LhEZ8q3BeQ6P/PiHIYla/ZdlSW3YiCmnYV8PIXuI=;
        b=Ky3krlV3iXUMBf/Z9cqZzFhIAesmu2BD2DYUe4vH+DmGtXq6dAI8S5HfbX6L2zMdY4
         f9wqbHbxfJ3T8dz8/b6B4QZsvW76a9F/DW1EHeg8LogTn3Un13n4cORIlgOsKSC+uHj9
         zZywIIbJd11HI5Ww66ux6+PoVHQpC40PAXGStOIY3DZXgGKi5wNXdKJGy6N+VH6qMuQk
         KGYW6s60HPOVyaVLYmKc40BTwhsPQrDVnP1yYLWee1QJLJNWf30Rd0pz7iJ0k8sGDvQS
         LUkDbwBmttDjVOrjsNVBs9bq3M7hlJbRTmCw0J4l7qEbYZ6Xvy6nS1V2S8r95qGhCsEv
         4o9w==
X-Gm-Message-State: AOAM532j3zupr5WvWXNCwkVCfDt99PHxc935DnSoB+/hITf49ZI8fTcs
        V22io5RslLb3pJ9/s33M5JyMEA==
X-Google-Smtp-Source: ABdhPJxjuKx366aHmjXKCPqMcpTQrMD3DfYUL7mY6FrOib4BAVfQ6jz5zRT6TMz0E0yCtzNZ314LdA==
X-Received: by 2002:a2e:974b:: with SMTP id f11mr4842574ljj.385.1632822973596;
        Tue, 28 Sep 2021 02:56:13 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y20sm2304960ljn.88.2021.09.28.02.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:56:13 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20210927094123.576521-1-arnd@kernel.org>
 <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
 <20210927130253.GH2083@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <78f6d6cc-2be5-c69b-bd17-7da135448438@rasmusvillemoes.dk>
Date:   Tue, 28 Sep 2021 11:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927130253.GH2083@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/09/2021 15.02, Dan Carpenter wrote:
> GCC handles it the same way as Clang.  '\377' is -1 but in Sparse it's
> 255.  I've added the Sparse mailing list to the CC.

FTR, while examples are not normative, this:

EXAMPLE 2 Consider implementations that use two's complement
representation for integers and eight bits for objects that have type
char. In an implementation in which type char has the same range of
values as signed char, the integer character constant '\xFF' has the
value -1; if type char has the same range of values as unsigned char,
the character constant '\xFF' has the value +255.

doesn't leave any ambiguity or (implementation|un)-definednes, and
sparse interpreting '\377' as 255 independent of its
target->unsigned_char is a plain bug in sparse.

Rasmus
