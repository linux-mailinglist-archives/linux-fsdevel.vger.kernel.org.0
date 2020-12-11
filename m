Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425202D7A80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 17:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390523AbgLKQGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 11:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390417AbgLKQGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:06:08 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383EFC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 08:05:28 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n14so9927946iom.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmtocVwd8SIYfyxppkBTT7yqoUjf7g/Js8s1nZTs1jk=;
        b=hGPo55SofOv9IGc4UGkoFy0BR2noDPsvHpjsaVmStZ0rFFDIQ0ErFViD0S8l6zhzy6
         5vgxRLVN4LP2LDJZld7XD7YTCxyEjM0hykkdOXx0Z0DXGF3TWu3Wan95cL/GVPXS/bpn
         oW7gyzblsfitsjUAhWP3bPxRw8bFvtIof4pzGwbACxl5bU9/LiZmhC8xfejjKMPe3pe5
         k/XV+5ebU24ejtF4YTlcgv7HfuHYAwgORzwbig+C76vTAkLJoR+hwRJajLbt5D7IH6IF
         DR/3WKl8T+kpOShVc3q/mcFdfOrCJMrx92V7vUo2J1Sr7/W/HvJW2QgPzcLvsbQiNUbq
         DQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmtocVwd8SIYfyxppkBTT7yqoUjf7g/Js8s1nZTs1jk=;
        b=TG9TXWKVm5BUtazsQe+45E3xqlAXP02pZwNL9K6yO3GzbAc/X6SqXlAVnFLJJporqm
         CIyxeQQBAJbbPjSL+FwO/xHXtbnyP3V3bzRSyDBd3Xy5DBxB6m+HN7A4v4lP1kUCftIY
         jW25Q7MyDAcJ9v61zpECGsKeiXIXukpdjLqtNhfQnzuVBxwNwmU/ZuEJ1MtPAfOCAvMA
         LrLXDyim6yCA63IVBwuVfsbLh8dQls50ChxVhFEjjw+D/5baSGwmeUP5mnK61pO8xY47
         Y4pns/YqT/UhodCIAjyYJjN+weD6gFwYxwLYUfVPlS44NOzbFtujZsZy1PKKFlvud0Np
         yNDQ==
X-Gm-Message-State: AOAM531TbP3yLweBCB09NsLmGFNs+Km+GQhFPGgUFbMA18XfNahGMzOo
        9LgZ+FzsA4pdspQR16W5kFk/3YooRjToeQ==
X-Google-Smtp-Source: ABdhPJwdlUuFIj+sQr9XmBWAylkczvEtu9aGvvKfXudqvWpCUkiLHRZNh80xMatUH/Msq5Q6Z5iirA==
X-Received: by 2002:a6b:8f94:: with SMTP id r142mr1806224iod.115.1607702727121;
        Fri, 11 Dec 2020 08:05:27 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v23sm4653049iol.21.2020.12.11.08.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:05:26 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
Date:   Fri, 11 Dec 2020 09:05:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211024553.GW3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/20 7:45 PM, Al Viro wrote:
> On Thu, Dec 10, 2020 at 02:06:39PM -0700, Jens Axboe wrote:
>> On 12/10/20 1:53 PM, Linus Torvalds wrote:
>>> On Thu, Dec 10, 2020 at 12:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> io_uring always punts opens to async context, since there's no control
>>>> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
>>>> just doing the fast RCU based lookups, which we know will not block. If
>>>> we can do a cached path resolution of the filename, then we don't have
>>>> to always punt lookups for a worker.
>>>
>>> Ok, this looks much better to me just from the name change.
>>>
>>> Half of the patch is admittedly just to make sure it now returns the
>>> right error from unlazy_walk (rather than knowing it's always
>>> -ECHILD), and that could be its own thing, but I'm not sure it's even
>>> worth splitting up. The only reason to do it would be to perhaps make
>>> it really clear which part is the actual change, and which is just
>>> that error handling cleanup.
>>>
>>> So it looks fine to me, but I will leave this all to Al.
>>
>> I did consider doing a prep patch just making the error handling clearer
>> and get rid of the -ECHILD assumption, since it's pretty odd and not
>> even something I'd expect to see in there. Al, do you want a prep patch
>> to do that to make the change simpler/cleaner?
> 
> No, I do not.  Why bother returning anything other than -ECHILD, when
> you can just have path_init() treat you flag sans LOOKUP_RCU as "fail
> with -EAGAIN now" and be done with that?
> 
> What's the point propagating that thing when we are going to call the
> non-RCU variant next if we get -ECHILD?

Let's at least make it consistent - there is already one spot in there
that passes the return value back (see below).

> And that still doesn't answer the questions about the difference between
> ->d_revalidate() and ->get_link() (for the latter you keep the call in
> RCU mode, for the former you generate that -EAGAIN crap).  Or between
> ->d_revalidate() and ->permission(), for that matter.

I believe these are moot with the updated patch from the other email.

> Finally, I really wonder what is that for; if you are in conditions when
> you really don't want to risk going to sleep, you do *NOT* want to
> do mnt_want_write().  Or ->open().  Or truncate().  Or, for Cthulhu
> sake, IMA hash calculation.

I just want to do the RCU side lookup, that is all. That's my fast path.
If that doesn't work, then we'll go through the motions of pushing this
to a context that allows blocking open.

> So how hard are your "we don't want to block here" requirements?  Because
> the stuff you do after complete_walk() can easily be much longer than
> everything else.

Ideally it'd extend a bit beyond the RCU lookup, as things like proc
resolution will still fail with the proposed patch. But that's not a
huge deal to me, I consider the dentry lookup to be Good Enough.


commit bbfc4b98da8c5d9a64ae202952aa52ae6bb54dbd
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 10 14:10:37 2020 -0700

    fs: make unlazy_walk() error handling consistent
    
    Most callers check for non-zero return, and assume it's -ECHILD (which
    it always will be). One caller uses the actual error return. Clean this
    up and make it fully consistent, by having unlazy_walk() return a bool
    instead.
    
    No functional changes in this patch.
    
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/namei.c b/fs/namei.c
index 03d0e11e4f36..d7952f863e79 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -679,7 +679,7 @@ static bool legitimize_root(struct nameidata *nd)
  * Nothing should touch nameidata between unlazy_walk() failure and
  * terminate_walk().
  */
-static int unlazy_walk(struct nameidata *nd)
+static bool unlazy_walk(struct nameidata *nd)
 {
 	struct dentry *parent = nd->path.dentry;
 
@@ -694,14 +694,14 @@ static int unlazy_walk(struct nameidata *nd)
 		goto out;
 	rcu_read_unlock();
 	BUG_ON(nd->inode != parent->d_inode);
-	return 0;
+	return false;
 
 out1:
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 out:
 	rcu_read_unlock();
-	return -ECHILD;
+	return true;
 }
 
 /**
@@ -3151,9 +3151,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-			error = unlazy_walk(nd);
-			if (unlikely(error))
-				return ERR_PTR(error);
+			if (unlazy_walk(nd))
+				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */


-- 
Jens Axboe

