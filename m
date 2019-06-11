Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497F73C8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405350AbfFKKZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 06:25:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405196AbfFKKZb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:25:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0928CADDD;
        Tue, 11 Jun 2019 10:25:30 +0000 (UTC)
Subject: Re: [PATCH 11/12] closures: closure_wait_event()
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-12-kent.overstreet@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <3130eb62-e3b7-12d7-e724-7d549c68b6cf@suse.de>
Date:   Tue, 11 Jun 2019 18:25:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610191420.27007-12-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/11 3:14 上午, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  include/linux/closure.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/closure.h b/include/linux/closure.h
> index 308e38028c..abacb91c35 100644
> --- a/include/linux/closure.h
> +++ b/include/linux/closure.h
> @@ -379,4 +379,26 @@ static inline void closure_call(struct closure *cl, closure_fn fn,
>  	continue_at_nobarrier(cl, fn, wq);
>  }
>  
> +#define __closure_wait_event(waitlist, _cond)				\
> +do {									\
> +	struct closure cl;						\
> +									\
> +	closure_init_stack(&cl);					\
> +									\
> +	while (1) {							\
> +		closure_wait(waitlist, &cl);				\
> +		if (_cond)						\
> +			break;						\
> +		closure_sync(&cl);					\
> +	}								\
> +	closure_wake_up(waitlist);					\
> +	closure_sync(&cl);						\
> +} while (0)
> +
> +#define closure_wait_event(waitlist, _cond)				\
> +do {									\
> +	if (!(_cond))							\
> +		__closure_wait_event(waitlist, _cond);			\
> +} while (0)
> +
>  #endif /* _LINUX_CLOSURE_H */
> 


-- 

Coly Li
