Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E62C7491
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgK1Vtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732728AbgK1TCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606590072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8tIwvnAenXjgsfxToTzp4ehLsTt2g8v0KLzq8Kd0+Q=;
        b=HwERhJMUx34x5YHqN9lHiwhQfbIlOM1EcKOnfAhWAFL7eFyLjUzHJx7feO/b51ha63A6Rv
        BMeNVON7Ldws2ldCAFAuigbpFRmT+5ZXio4uMKhGrMwbjALy81FuwGqx93ST++TWSc6x1L
        7FUZ6Zmq4egVdGQjEtDvvXRClogUkU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-uA8Y5a2GNP-4GZ3HQXUEbA-1; Sat, 28 Nov 2020 14:01:10 -0500
X-MC-Unique: uA8Y5a2GNP-4GZ3HQXUEbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7541E802B48;
        Sat, 28 Nov 2020 19:01:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.139])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B9185D6D3;
        Sat, 28 Nov 2020 19:01:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 28 Nov 2020 20:01:09 +0100 (CET)
Date:   Sat, 28 Nov 2020 20:01:06 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: add locking checks in proc_inode_is_dead
Message-ID: <20201128190105.GC19372@redhat.com>
References: <20201128175850.19484-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128175850.19484-1-wenyang@linux.alibaba.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/29, Wen Yang wrote:
>
> The proc_inode_is_dead function might race with __unhash_process.
> This will result in a whole bunch of stale proc entries being cached.
> To prevent that, add the required locking.

I leave this to Eric but I don't understand how can this patch help,
__unhash_process() can be called right after proc_inode_is_dead().

And in any case, we certainly do not want to take tasklist_lock in
proc_inode_is_dead().

> 
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/proc/base.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 1bc9bcd..59720bc 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1994,7 +1994,13 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
>  {
> -	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
> +	bool has_task;
> +
> +	read_lock(&tasklist_lock);
> +	has_task = pid_has_task(proc_pid(inode), PIDTYPE_PID);
> +	read_unlock(&tasklist_lock);
> +
> +	return !has_task;
>  }
>  
>  int pid_delete_dentry(const struct dentry *dentry)
> -- 
> 1.8.3.1
> 

