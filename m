Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2B2A09D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgJ3P1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ3P1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:27:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17047C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 08:27:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u62so7891383iod.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kT6xj1Vg1avCvf83jif61+Gcst08Py5XBYy759x7DZQ=;
        b=hoPtNwVwt8sdIwotEDaBeeIXbIOm5ZiWEWDawiGxpt/NONLxZ/I2IclmI5xNNZbyh2
         2gFiBu2DLhjDzMmnCB+XXY7sY9v1Fs+Jhm5lU7zq+gqDQo5id5TJXmpM4esrP3MO+wfe
         TDjxcCX9ddrFrHZ4UzlAnmogHTkvQXMoSs1AIYEODIYhJ2ygJfs2cpMiav7qTG1K27L9
         XDttUwfL0qOtq7gBRN/Zc8A/63k+tKCfq0WutbskBUJxe12etltVvsNqkB9wNLgfzs+3
         z+F4vS7SBGdoiEyOtqvRSPdt8rf9FwALBIbVyChZuMS8IiG79MGSBl9AZSFhwnSptKYU
         x1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kT6xj1Vg1avCvf83jif61+Gcst08Py5XBYy759x7DZQ=;
        b=P3ZZ36OoFj8oA9r8/f8iQEMBlb1vx7Ja4Dpv5V7TF4odAk8BUcu8n07QCHOgfBu0jl
         iWvz95OlcxwRC3i+w+1NsD3qNDMgJQrHeKhg8HAqgfEY9kVNBPF6kPx4OqQ6Rl4J4Rcx
         ywVKpFQxbu16Q860iXajlIkw/Wf3icc5DlLkG90ubhI7oNuESNWT3ChxLzPAq3D5x0lP
         GdOceuA6pb8QkUY0/j7SOLKnaHKpI0kC4vG4RAZh82FM81XqYtnGvtpJBc0h1+Fx0418
         +xzkJu5TRhzbYjWpZ4mvLIPzaR6hG1vDVlO4j8K1jqzu27fdngmPcU1OPrKxoSzvsVUk
         aQcg==
X-Gm-Message-State: AOAM530K4F+pTcZZ1FpWB4hM5fiZqn0WZTXZebCIzMKFEFiU5d5HUgYP
        far+lOguv8Mz7AA5WSwBhIhcxw==
X-Google-Smtp-Source: ABdhPJxHqoZ5EhicbB7dSv8JmLiPqTdqwE5qEr5k9JRdHSPGfwBtOeIMnDWtk0kttP7u4LsHsJ46sw==
X-Received: by 2002:a5d:9850:: with SMTP id p16mr2277072ios.22.1604071642324;
        Fri, 30 Oct 2020 08:27:22 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t16sm5953083ild.27.2020.10.30.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 08:27:21 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Qian Cai <cai@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <251c80d6-a2d0-4053-404f-bffd5a53313e@kernel.dk>
Date:   Fri, 30 Oct 2020 09:27:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030152407.43598-1-cai@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:24 AM, Qian Cai wrote:
> We will need to call putname() before do_renameat2() returning -EINVAL
> to avoid memory leaks.

Thanks, should mention that this isn't final by any stretch (which is
why it hasn't been posted yet), just pushed out for some exposure.

-- 
Jens Axboe

