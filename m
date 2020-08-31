Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA48257F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHaRFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgHaRFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:05:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04993C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:05:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d190so5810731iof.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NupQwOin7OIUMIEQkBORyIATGdqAz+bfGvsiSPmfA0g=;
        b=ZSrrE7lja8S44m6VDFYpuUVPj180evZgepv+n5Olz62tJeG0Mm1veMfhBfsAzclMDD
         rCgw+cTEYzFaVjKm8FruvNBxQ+DCr6mi7KNx8Yu5V04AlHm2IP73U+weUhecberMWoiN
         dJysYL7nXrAjuGZhjiwnFAbOdk08W2jihSLi6xBeLQ+6/5Y4J7YlSB8/czZ9Xdam4hF9
         ItM4t8BNCQexQ0BtVZoPD01thRQKRh7R0QHo/AyofQXoJZw3l8l/sOXubq1s4NET6gtj
         3IAcyViBF75bWfpg7iP8tyZYH6pziaXSAWfgSzbdnJ2dQQPOHdvgP3JZal708Ib+4zY7
         Bp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NupQwOin7OIUMIEQkBORyIATGdqAz+bfGvsiSPmfA0g=;
        b=TX0nlmSUy6fJ4hiF5GOuTO331IsgA2gM9AuYG3VMhdX1DZs3PDwvTr6FpLvoA0AC0K
         R9e0id1XgMX8R52lWmjjVX1+9Brg46wBC5r9QXnRndA29+qKOiIKjSB/8fyGRvuUi3+V
         QCfj5OlR9E26+O5XzktcdspQuvpkmnyDRWy5amb3S76XIuxC4T4ecPBlrtH76NmgBb+5
         NqA80jRwPxFbLMaAv4zp6WzVBpgdvj0Yvk67ZiKv7/5l0OluliRTKby87vpEK2N63K8F
         vbPNv9qCgQNxTEQYIKXhEJisf5HNSXdm7p2E73IC8a/sS/uKpV3ZRWnnGV43w0yc0bub
         Kg3A==
X-Gm-Message-State: AOAM532u3DtHswk0uD8ECzKr/Yy5oRnS9q58k6T2dDC9rpPjf3YsGXAp
        0wyOZCC7OLMao9M8td02shkhwA==
X-Google-Smtp-Source: ABdhPJwEAn6jxmt9zWEmcq/dBYqtgWifA/B8Ppg0qLdObo/ZA6Scud2q2DgBy9rgnrAG+TkyWisGkA==
X-Received: by 2002:a02:a30b:: with SMTP id q11mr2053911jai.77.1598893536338;
        Mon, 31 Aug 2020 10:05:36 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k16sm4626707ilc.38.2020.08.31.10.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:05:35 -0700 (PDT)
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Jann Horn <jannh@google.com>, Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
 <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9d26744-ba7a-2223-7284-c0d1a5ddab8a@kernel.dk>
Date:   Mon, 31 Aug 2020 11:05:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 9:46 AM, Jann Horn wrote:
> On Mon, Aug 31, 2020 at 5:32 PM Rich Felker <dalias@libc.org> wrote:
>> The pwrite function, originally defined by POSIX (thus the "p"), is
>> defined to ignore O_APPEND and write at the offset passed as its
>> argument. However, historically Linux honored O_APPEND if set and
>> ignored the offset. This cannot be changed due to stability policy,
>> but is documented in the man page as a bug.
>>
>> Now that there's a pwritev2 syscall providing a superset of the pwrite
>> functionality that has a flags argument, the conforming behavior can
>> be offered to userspace via a new flag. Since pwritev2 checks flag
>> validity (in kiocb_set_rw_flags) and reports unknown ones with
>> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
>> don't support the new flag; the error is reported and the caller can
>> decide how to handle it.
>>
>> Signed-off-by: Rich Felker <dalias@libc.org>
> 
> Reviewed-by: Jann Horn <jannh@google.com>
> 
> Note that if this lands, Michael Kerrisk will probably be happy if you
> send a corresponding patch for the manpage man2/readv.2.
> 
> Btw, I'm not really sure whose tree this should go through - VFS is
> normally Al Viro's turf, but it looks like the most recent
> modifications to this function have gone through Jens Axboe's tree?

Should probably go through Al's tree, I've only carried them when
they've been associated with io_uring in some shape or form.

-- 
Jens Axboe

