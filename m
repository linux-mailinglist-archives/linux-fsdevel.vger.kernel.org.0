Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE287518F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfGYOnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 10:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfGYOns (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58F673092647;
        Thu, 25 Jul 2019 14:43:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93A205DE6F;
        Thu, 25 Jul 2019 14:43:47 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     "zhangyi \(F\)" <yi.zhang@huawei.com>
Cc:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcrl@kvack.org>,
        <viro@zeniv.linux.org.uk>, <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 25 Jul 2019 10:43:46 -0400
In-Reply-To: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com> (zhangyi's
        message of "Thu, 25 Jul 2019 15:21:29 +0800")
Message-ID: <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 14:43:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"zhangyi (F)" <yi.zhang@huawei.com> writes:

> io_[p]getevents syscall should return -EINVAL if if timeout is out of
> range, add this validity check.
>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/aio.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 01e0fb9..dd967a0 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -2031,10 +2031,17 @@ static long do_io_getevents(aio_context_t ctx_id,
>  		struct io_event __user *events,
>  		struct timespec64 *ts)
>  {
> -	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
> -	struct kioctx *ioctx = lookup_ioctx(ctx_id);
> +	ktime_t until = KTIME_MAX;
> +	struct kioctx *ioctx = NULL;
>  	long ret = -EINVAL;
>  
> +	if (ts) {
> +		if (!timespec64_valid(ts))
> +			return ret;
> +		until = timespec64_to_ktime(*ts);
> +	}
> +
> +	ioctx = lookup_ioctx(ctx_id);
>  	if (likely(ioctx)) {
>  		if (likely(min_nr <= nr && min_nr >= 0))
>  			ret = read_events(ioctx, min_nr, nr, events, until);

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

The previous suggestion[1] of fixing the helpers never materialized, so
let's just get this fixed, already.

-Jeff

[1] https://marc.info/?l=linux-fsdevel&m=152209450618587&w=2
