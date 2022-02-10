Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7874B1042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 15:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiBJOVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 09:21:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbiBJOVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:21:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E61189;
        Thu, 10 Feb 2022 06:21:44 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 63BAF48F; Thu, 10 Feb 2022 09:21:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 63BAF48F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644502903;
        bh=SmqqeCjhrHfi8tEQCKMwu5GyjRr6XXXwkR3pyw29AWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIVHMW1m/a8MlPHMqsaNyF9AWde1UOvljWQj5VIGkO8ykuI2YIwmEh+c5yJXP+h56
         53IpGUmwK6wEoEAvYHET8Jg+m0DaPOfzNTkmfr4m/O7gTlQzyqv5+4NgpxfSGSI8ye
         BQoEQTU2qJMgRgLwqlWb6WFp6RiAF6CbPQ4KeTjc=
Date:   Thu, 10 Feb 2022 09:21:43 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     jlayton@redhat.com
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Message-ID: <20220210142143.GC21434@fieldses.org>
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

Jeff, this table of locking rules seems out of date since 6109c85037e5
"locks: add a dedicated spinlock to protect i_flctx lists".  Are any of
those callbacks still called with the i_lock?  Should that column be
labeled "flc_lock" instead?  Or is that even still useful information?

--b.

On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d36fe79167b3..57ce0fbc8ab1 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -439,6 +439,7 @@ prototypes::
>  	void (*lm_break)(struct file_lock *); /* break_lease callback */
>  	int (*lm_change)(struct file_lock **, int);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_conflict)(struct file_lock *);
>  
>  locking rules:
>  
> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>  lm_break:		yes		no			no
>  lm_change		yes		no			no
>  lm_breaker_owns_lease:	no		no			no
> +lm_lock_conflict:       no		no			no
>  ======================	=============	=================	=========
