Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E784B1064
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiBJO20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 09:28:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242924AbiBJO2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:28:25 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA53FB19;
        Thu, 10 Feb 2022 06:28:26 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6086EBDE; Thu, 10 Feb 2022 09:28:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6086EBDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644503306;
        bh=bJ6y98wbmIYdcbJEh9WTmMjbBupTCJb/ugof+qHQeYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pvr2bqXsVIE6dmDphzBIHsyJT9iXJmri4j4iHpyA//NZ8YRHnjiSOkNRn68o9skoD
         PNEtbLt/yYZ3UoFXMBvheQyMMYIZlRKlbAThOY+T9j6zMRMC2vBeL3MlLQZaT2h17r
         /RWwaYuCwjs5NG+kj6Lxx0twbQb95HDynOffYGCg=
Date:   Thu, 10 Feb 2022 09:28:26 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Message-ID: <20220210142826.GD21434@fieldses.org>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbf812ce89a8..726d0005e32f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1068,6 +1068,14 @@ struct lock_manager_operations {
>  	int (*lm_change)(struct file_lock *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lock *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	/*
> +	 * This callback function is called after a lock conflict is
> +	 * detected. This allows the lock manager of the lock that
> +	 * causes the conflict to see if the conflict can be resolved
> +	 * somehow. If it can then this callback returns false; the
> +	 * conflict was resolved, else returns true.
> +	 */
> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>  };

I don't love that name.  The function isn't checking for a lock
conflict--it'd have to know *what* the lock is conflicting with.  It's
being told whether the lock is still valid.

I'd prefer lm_lock_expired(), with the opposite return values.

(Apologies if this has already been woodshedded to death, I haven't been
following.)

--b.
