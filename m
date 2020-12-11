Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142C72D7A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 16:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393978AbgLKP6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 10:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393794AbgLKP6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:58:08 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FFAC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 07:57:28 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id r17so9196079ilo.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sy0jImmmjPyN83Ri4PgO+hrRmVWXF0qSJhzAct9CgUQ=;
        b=MGkQKCtzbzl3fMTvttR1rIFpOUfe1bW42nvS8U7qI54TDoEvUZGHZQmaDJVz+OHqKw
         abHkcFLAcayQFdgtiCaE2qgx/dCwnyr7NGvefdeg4UVmC8n3uC2R1EhrFkXONgGAc3wq
         ZoCbMjgAq5ivOAnbfCGXnY9Prkx6a6/AM6uVO21ysnOZHZijCqnwlTJHOEaQZXSTnO9U
         xATTUkuw9uI3gPSK/pXuyeED0C4TxYvF+sCZXR699qdvDFn/F8IvbzA+ff8FSQ6msYs7
         K9DfhKTfnuECfgBs2haMUROmuXhAX5fbAdnftrH1SwWNcjZCA7fIl3oT3EmhAsIkVLlT
         3wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sy0jImmmjPyN83Ri4PgO+hrRmVWXF0qSJhzAct9CgUQ=;
        b=cyaSFKqEOs/uizh2Kbn6hQXI7w5QEwnIS6H5KSirekVbFDyidY7FP5Hu7T/fUQsGrU
         x7sPanoBGTqg9UTCT+lDpDPM7/eLQ5/XHVpUjRKFrZVp1OcHeTbdibRoEIhurERCtEY/
         +mRSyRnK1Oz1W5Fw1NPlcp015rcHKhE2pGanrCxxBBaA9JqVzWkybW1ymE2L9hdhnLeP
         MqJek/Rbk2bXvrPI9sEhx9DQj1zPDMAZgkLvIRkvcC/6Yl+hDUvX1at5E/cOObJMAYSy
         L7hnAgkIpn18w9vvK5EC3+Mb70Uj0v7dNAVdx4+Ch9VdML7ijV3p9b+s/o/BPaZGV0Vg
         ZuZA==
X-Gm-Message-State: AOAM533MjXqy82ifdmIV4KMnJtwigZp7rmrNxyuTkUJscCtQD6ey4K3C
        nwo3vhuKFWWw9oaS1gJyY84A0g==
X-Google-Smtp-Source: ABdhPJzVklRCDWwyyBanUSwGdT3wuTN/OHpB+wNcPOF/2Ehi+eId9s8kivXTODT+oVXXtFpgJJfGag==
X-Received: by 2002:a92:9986:: with SMTP id t6mr17022935ilk.151.1607702247286;
        Fri, 11 Dec 2020 07:57:27 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm5512512ilc.85.2020.12.11.07.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:57:26 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <20201211023555.GV3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
Date:   Fri, 11 Dec 2020 08:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211023555.GV3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/20 7:35 PM, Al Viro wrote:
> On Thu, Dec 10, 2020 at 01:01:13PM -0700, Jens Axboe wrote:
>> io_uring always punts opens to async context, since there's no control
>> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
>> just doing the fast RCU based lookups, which we know will not block. If
>> we can do a cached path resolution of the filename, then we don't have
>> to always punt lookups for a worker.
>>
>> During path resolution, we always do LOOKUP_RCU first. If that fails and
>> we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.
> 
> In effect you are adding a mode where
> 	* unlazy would fail, except when done from complete_walk()
> 	* ->d_revalidate() wouldn't be attempted at all (not even with LOOKUP_RCU)
> 	* ... but ->get_link() in RCU mode would
> 	* ... and so would everything done after complete_walk() in
> do_open(), very much including the joys like mnt_want_write() (i.e. waiting for
> frozen fs to thaw), handling O_TRUNC, calling ->open() itself...
> 
> So this "not punting lookups for a worker" looks fishy as hell - if you care
> about blocking operations, you haven't really won anything.
> 
> And why exactly is the RCU case of ->d_revalidate() worth buggering off (it
> really can't block - it's called under rcu_read_lock() and it does *not*
> drop it)?
> 
> _IF_ for some theoretical exercise you want to do "lookup without dropping
> out of RCU", just add a flag that has unlazy_walk() fail.  With -ECHILD.
> Strip it away in complete_walk() and have path_init() with that flag
> and without LOOKUP_RCU fail with -EAGAIN.  All there is to it.

Thanks Al, that makes for an easier implementation. I like that suggestion,
boils it down to just three hunks (see below).

For io_uring, the concept is just to perform the fast path inline. The
RCU lookup serves that purpose nicely - if we fail that, then it's expected
to take the latency hit of going async.

> It still leaves you with fuckloads of blocking operations (and that's
> "blocking" with "until admin thaws the damn filesystem several hours
> down the road") after complete_walk(), though.

But that's true (and expected) for any open that isn't non-blocking.


diff --git a/fs/namei.c b/fs/namei.c
index d7952f863e79..d49c72e34c6e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -686,6 +686,8 @@ static bool unlazy_walk(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_NONBLOCK)
+		goto out1;
 	if (unlikely(!legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -792,6 +794,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
+		nd->flags &= ~LOOKUP_NONBLOCK;
 		if (unlikely(unlazy_walk(nd)))
 			return -ECHILD;
 	}
@@ -2209,6 +2212,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
+	/* LOOKUP_NONBLOCK requires RCU, ask caller to retry */
+	if ((flags & (LOOKUP_RCU | LOOKUP_NONBLOCK)) == LOOKUP_NONBLOCK)
+		return ERR_PTR(-EAGAIN);
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
 

-- 
Jens Axboe

