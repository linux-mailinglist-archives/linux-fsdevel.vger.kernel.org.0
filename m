Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00C02B7FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKRPAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRPAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:00:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE843C0613D4;
        Wed, 18 Nov 2020 07:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZAMfgrFUzuUjDjqhjvyKWs7Yyb4zhoUH2cqBpb/P9Y=; b=JlMuJcCm7YsUkcT6ezUZZXkyvN
        SK1fXCTZScBC0MnqyguO2d9UmA2OcR+j91CuRP1icUZO8IfGIgkqMwR51CULZ7WTzb5SmDvpDt2qS
        DlteLNjU5QqSn4FoM5FbSn2YjIymrPK7sHvFZfCRnaXQ4O0SDPxIvv1g4AR9BMSLBjEPsnsCljRRO
        uP1Fq5WswgXiWncCLl9odTz4Jc7OxifS2fLNpwN2XkpXeNsmriKDes02I5D+l20QGwcSSQdHZTuHE
        /9R+nVK/ZIOdSdph3Ao90ssdQu4oAgREvhnrL21tjaew8qpkfpzLN3jaDY+Hi8RoqZSOAezcNzqRR
        +DtMTm6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfOws-0005lu-1d; Wed, 18 Nov 2020 15:00:42 +0000
Date:   Wed, 18 Nov 2020 15:00:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        soheil.kdev@gmail.com, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
Message-ID: <20201118150041.GF29991@casper.infradead.org>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:46:15AM -0500, Willem de Bruijn wrote:
> -static inline struct timespec64 ep_set_mstimeout(long ms)
> +static inline struct timespec64 ep_set_nstimeout(s64 timeout)
>  {
> -	struct timespec64 now, ts = {
> -		.tv_sec = ms / MSEC_PER_SEC,
> -		.tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> -	};
> +	struct timespec64 now, ts;
>  
> +	ts = ns_to_timespec64(timeout);
>  	ktime_get_ts64(&now);
>  	return timespec64_add_safe(now, ts);
>  }

Why do you pass around an s64 for timeout, converting it to and from
a timespec64 instead of passing around a timespec64?

