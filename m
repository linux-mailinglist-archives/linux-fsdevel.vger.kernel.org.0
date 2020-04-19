Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F851AFE9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDSWW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgDSWW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:22:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445DC061A41
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 15:22:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so2996308pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZGGvjnGunABiy25qrhz6ksRUn1sXB4cu8ILhBoEIw4=;
        b=q361Dw3uF5Qr1t4y5v+dPldxAaxHS8ShKiBGG9s7RVfzTEnTG5VLizSByAFZb1rMpb
         ayBMS4rffRqTEtTGq2GcohUU29nxm4JKb9Jy5YuH4M4v07exxqLF3Ya15BzgFws3bGTa
         cWV1MEg+VFSJUKMHu8BHH6cyJOvBubkmQ2UaSzQFLXCfiapBdMcZb2j7MlepzaTnhlnI
         ROEhJvJXGkqhZ/AjMcEbWz+7k/7F4jFOuj8/yE7edpR+U1yixc08d+SqPbFZtY3Xs4sK
         dsxKekAYVfOXOuF/pdJghZiesUM7RdHfCFYAb1u+pcI/CUtsrY5VVycGGZnrYTGI00Re
         oUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZGGvjnGunABiy25qrhz6ksRUn1sXB4cu8ILhBoEIw4=;
        b=VSYjHOUg5u8gq4ieCscgzCP323wIbj8N823EJbz6J/8BOmZ91ogRGjQoHPog862RqD
         VeYakmQ75NvNSwbZXqX07M/anyYAUth2X3evAJQ6QMFhXjj3A5ciT4YCrPJy5Aedrhlo
         ILATYcuFWFVtMQXtKYwRwpX+ENs+VjDITqnhKa1nefyem314OsYVnGdO8USleeqDeGOu
         l3FiUHF4rWlUhIl9MwnaPwXAn2NE0mKuXiT7D3GrH+ufmhqi63cYVXaVJ6Vsuj/+3Q1v
         Qwo8J7VDTxOPQmkXKFsEF1VkQML6bixHpmi+1Wd33bDmz6nJstK03kePtFJXxDi23MUY
         g5iw==
X-Gm-Message-State: AGi0Pua37D/iKRTtGWUIOnnVH1HiyggArSm4zHlz9fdHqRUwZG3ckJhd
        4U3x+yThSrMpnsgMQTYd+pg9aA==
X-Google-Smtp-Source: APiQypLVocmgSAnp2tycKBAS6H3WFAfrUrUN7XSJV8KonygiDW2GikHzh3bDUBJj0YUm49eMWZW93g==
X-Received: by 2002:a17:90a:8d0f:: with SMTP id c15mr16391639pjo.100.1587334975940;
        Sun, 19 Apr 2020 15:22:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e66sm21780994pfa.69.2020.04.19.15.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 15:22:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1586830316.git.josh@joshtriplett.org>
 <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7dae79b-4c5f-65f6-0960-617070357201@kernel.dk>
Date:   Sun, 19 Apr 2020 16:22:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 4:44 AM, Aleksa Sarai wrote:
> On 2020-04-13, Josh Triplett <josh@joshtriplett.org> wrote:
>> Inspired by the X protocol's handling of XIDs, allow userspace to select
>> the file descriptor opened by openat2, so that it can use the resulting
>> file descriptor in subsequent system calls without waiting for the
>> response to openat2.
>>
>> In io_uring, this allows sequences like openat2/read/close without
>> waiting for the openat2 to complete. Multiple such sequences can
>> overlap, as long as each uses a distinct file descriptor.
> 
> I'm not sure I understand this explanation -- how can you trigger a
> syscall with an fd that hasn't yet been registered (unless you're just
> hoping the race goes in your favour)?

io_uring can do chains of requests, where each link in the chain isn't
started until the previous one has completed. Hence if you know what fd
that openat2 will return, you can submit a chain ala:

<open file X, give me fd Y><read from fd Y><close fd Y>

as a single submission. This isn't possible to do currently, as the read
will depend on the output of the open, and we have no good way of
knowing what that fd will be.

-- 
Jens Axboe

