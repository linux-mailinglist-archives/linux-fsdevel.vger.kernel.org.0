Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4480199523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfHVNdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 09:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfHVNda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:33:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DC5930833BE;
        Thu, 22 Aug 2019 13:33:30 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A66311001B32;
        Thu, 22 Aug 2019 13:33:29 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: remove redundant assignment to variable ret
References: <20190822110705.19065-1-colin.king@canonical.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 22 Aug 2019 09:33:28 -0400
In-Reply-To: <20190822110705.19065-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 22 Aug 2019 12:07:05 +0100")
Message-ID: <x49h8699vfb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 22 Aug 2019 13:33:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being set to -EINVAL however this is never read
> and later it is being reassigned to a new value. The assignment is
> redundant and hence can be removed.
>
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/aio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index f9f441b59966..3e290dfac10a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1528,7 +1528,6 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
>  	file = req->ki_filp;
>  	if (unlikely(!(file->f_mode & FMODE_READ)))
>  		return -EBADF;
> -	ret = -EINVAL;
>  	if (unlikely(!file->f_op->read_iter))
>  		return -EINVAL;

Acked-by: Jeff Moyer <jmoyer@redhat.com>
