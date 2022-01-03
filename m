Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518D4833D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiACPAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiACPAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:00:39 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A87C061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 07:00:39 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e128so40685185iof.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iX+J3aUp4/IGEYlAX+jrwzk7n9Ng8QNRRPfY0+N+Kk0=;
        b=HO7yn1sHsLHQ8xV6Fb5gP9LX9CRdwL8v10dc8u0Qz9x1J7mhvwM/WuLdgcLLj+ocHF
         tKYU+TzUGmAhpJj8Rj0+X/XJaOC0/u+OBLLfMLVZF5n95is3OMam9ROEaJUtWEMyURge
         nf3JVFnvfvSdt0QPx41emgEZ0y2MW1ouDMFOH0gW7TP6PJ/B500/5yyto3V4k+KFFR79
         kvVYxR/l182j+Onmfda+fHwr9lwQIkWsOG3cWajZPizzt2u5b6u0cCevtAvskcUATmS9
         tPrZ5olhHdTZZAzlxtYSCS2eH2kpIRLBXaHqJPZQrVNno91OHRl8yktJesxZphVqHSte
         n0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iX+J3aUp4/IGEYlAX+jrwzk7n9Ng8QNRRPfY0+N+Kk0=;
        b=KaZUJ+Kbv/JoKQv9qYcgtBypRy0ScDjOoK+Ypt2jgQs2EjlIfvnwUs+OygelYEE9dR
         DKD7RTFPl2M3XJp7BoHdKLd5tu17/VhacJqSZPO+PJZdarDpaQnQYt/jhj72lD0CSB4D
         /TjCmDAsoEDgCjp8RbBrWejVKXPt4qtBwriSsuvMRqW5DJFzxkNBriMmxScwh2OXIqpf
         DFEt8l0lVvVV6zmwVTDzeItVMobS+MsiD5w7VcAJnOiLJ15W6FhxHKa+LpcyWrHUNyGQ
         NuG9qkcu1D37uUlq22Wv+GSJjrQTh7yuxZRUhDyFCu6ZUlOW26SG9zNnSgXpikC0WdCN
         Ookw==
X-Gm-Message-State: AOAM531EgVucD8mY9yatWLLfbzFZIPMXM6nNdhVJa8Pq/XYT9evuM/J/
        qZxDRJvq4WthzMiFFab2srLNE7sZB31sSg==
X-Google-Smtp-Source: ABdhPJxpUJWBb8t7exxUVuaHvXrw5nM1iSJzHo9x/1RIfXrTiIGXiV1X9VTNjSB411TykyOMMeTNbA==
X-Received: by 2002:a02:734b:: with SMTP id a11mr12608906jae.168.1641222038571;
        Mon, 03 Jan 2022 07:00:38 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z13sm2228796iln.43.2022.01.03.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 07:00:38 -0800 (PST)
Subject: Re: [PATCH v7 0/3] io_uring: add getdents64 support
To:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20211221164004.119663-1-shr@fb.com>
 <CAHk-=wgHC_niLQqhmJRPTDULF7K9n8XRDfHV=SCOWvCPugUv5Q@mail.gmail.com>
 <Yc+PK4kRo5ViXu0O@zeniv-ca.linux.org.uk>
 <YdCyoQNPNcaM9rqD@zeniv-ca.linux.org.uk>
 <CAG48ez1O9VxSuWuLXBjke23YxUA8EhMP+6RCHo5PNQBf3B0pDQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <308dafb1-9ed8-c626-2cf5-34ecf914db4f@kernel.dk>
Date:   Mon, 3 Jan 2022 08:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1O9VxSuWuLXBjke23YxUA8EhMP+6RCHo5PNQBf3B0pDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/2/22 11:03 PM, Jann Horn wrote:
> io_uring has some dodgy code that seems to be reading and writing
> file->f_pos without holding the file->f_pos_lock. And even if the file
> doesn't have an f_op->read or f_op->read_iter handler, I think you
> might be able to read ->f_pos of an ext4 directory and write the value
> back later, unless I'm missing a check somewhere?

I posted an RFC to hold f_pos_lock across those operations before the
break:

https://lore.kernel.org/io-uring/8a9e55bf-3195-5282-2907-41b2f2b23cc8@kernel.dk/

picking it up this week and flushing it out, hopefully.

-- 
Jens Axboe

