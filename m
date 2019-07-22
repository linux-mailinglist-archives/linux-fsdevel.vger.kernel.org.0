Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD68706A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbfGVRWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 13:22:14 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44577 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfGVRWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:22:13 -0400
Received: by mail-vs1-f67.google.com with SMTP id v129so26698922vsb.11;
        Mon, 22 Jul 2019 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RwZIBmGpe6Ch1OhMIQEtezoTZ92I3yKQeRZwjwn0rdg=;
        b=juK0GCh0oGkF8/qRwfMrY4o0UWQT7ucEH7fpdfVlk9ZyzemrMFDoJrl3IxM6HwYfQg
         GUa/3zrr3j1P/CczbEAu0wXPrIKSnGQiQupv+9X/2AS/7WuzgaTMTML/z1Zd817vfVFg
         Pu6A8O63YCtKFubGdDAgY17XBKhEntxodyMgyueVWyzNMKMx8phdH/KBT1mzvKLXOmzT
         LAzmyxvVDBRhcADNrafe6TJhODZTrsjIUBlCDyJO1iCXZvFJvtdIUlTP+ymkjwxIyngz
         YyvDpfpksbKKksRkeLAMEH71pSgakrTgqGGh/QjZzuA+Wz4mizVqFDTOnw+OhcwRPQGL
         cuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RwZIBmGpe6Ch1OhMIQEtezoTZ92I3yKQeRZwjwn0rdg=;
        b=Fb68t9Brd2Dx69a418YpqASOolJ/k1t2jDlqrNiNINPYpU1HRYlFTGZ9+Vm/dzl/Hd
         cro6vclkvtmj7MTzIGLaKMkWv2E4hVSTrbOxWqiB+3sEAQbZ2ET19MZZA7hLJmng8Shd
         f2CpcCwQtTJWKZ2aWo4Xy0DGdeOEY3rrnjm7/KNFN3fEpjzwZRQBR55e0SgtS8cO9HA6
         EcRGIqOU0KlR4nXggdzlW7FLSFrbKoOvSrTopbF55SEdhcHBDbsMGGweS1s4MzmJ06kh
         EJXIsqWTuTdoFVx8Nk5qwstbOxHAjgWzXMc++RwSVH5zEvIYwQgw2hoxZcXaUago+9N6
         mA1w==
X-Gm-Message-State: APjAAAUUQNBH/AMQlpKqMnQFJHqLVd/1ybHBriV51j7Sj3001zMC7QjO
        Cx88IKQ+hHchqVpZD01kIfpEZJE4nQ==
X-Google-Smtp-Source: APXvYqx8dAyipHaafaWOQlEAfhjBgsxzkpXNAVrCHLUHFeuc5TzcqM/MAzIv6qbapb0UYqwjI8LFFg==
X-Received: by 2002:a67:c113:: with SMTP id d19mr3770488vsj.89.1563816132534;
        Mon, 22 Jul 2019 10:22:12 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id v5sm44538591vsi.24.2019.07.22.10.22.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:22:11 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:22:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH 12/12] closures: fix a race on wakeup from closure_sync
Message-ID: <20190722172209.GA25176@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-13-kent.overstreet@gmail.com>
 <8381178e-4c1e-e0fe-430b-a459be1a9389@suse.de>
 <48527b97-e39a-0791-e038-d9f2ec28943e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48527b97-e39a-0791-e038-d9f2ec28943e@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:46:46PM +0800, Coly Li wrote:
> On 2019/7/16 6:47 下午, Coly Li wrote:
> > Hi Kent,
> > 
> > On 2019/6/11 3:14 上午, Kent Overstreet wrote:
> >> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > Acked-by: Coly Li <colyli@suse.de>
> > 
> > And also I receive report for suspicious closure race condition in
> > bcache, and people ask for having this patch into Linux v5.3.
> > 
> > So before this patch gets merged into upstream, I plan to rebase it to
> > drivers/md/bcache/closure.c at this moment. Of cause the author is you.
> > 
> > When lib/closure.c merged into upstream, I will rebase all closure usage
> > from bcache to use lib/closure.{c,h}.
> 
> Hi Kent,
> 
> The race bug reporter replies me that the closure race bug is very rare
> to reproduce, after applying the patch and testing, they are not sure
> whether their closure race problem is fixed or not.
> 
> And I notice rcu_read_lock()/rcu_read_unlock() is used here, but it is
> not clear to me what is the functionality of the rcu read lock in
> closure_sync_fn(). I believe you have reason to use the rcu stuffs here,
> could you please provide some hints to help me to understand the change
> better ?

The race was when a thread using closure_sync() notices cl->s->done == 1 before
the thread calling closure_put() calls wake_up_process(). Then, it's possible
for that thread to return and exit just before wake_up_process() is called - so
we're trying to wake up a process that no longer exists.

rcu_read_lock() is sufficient to protect against this, as there's an rcu barrier
somewhere in the process teardown path.
