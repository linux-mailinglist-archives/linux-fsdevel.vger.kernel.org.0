Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026C4BF394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 09:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiBVI2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 03:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiBVI1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:27:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455319BBB3;
        Tue, 22 Feb 2022 00:27:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1AA31F397;
        Tue, 22 Feb 2022 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645518444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKa9YzG6WdPDW42WrXRDZOX/ZgG302zZsU6kzGjfuRk=;
        b=Td2+1nGSGsZ5KMAOXZdDV1sjvAKTWie8Ea7gXdjxrT1MQOLxRE4sf1yFUF0ozBZVaxx57G
        F2w6B+J4F1f3Eg7LYwOH4bUr084LTNnx3qdml8GVzZw7C34nAkA10vZYP/GcPXeYqmArAE
        wCViF/uK3oZXRCgtuFDkWlfv6CnR2eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645518444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKa9YzG6WdPDW42WrXRDZOX/ZgG302zZsU6kzGjfuRk=;
        b=NGZGyoSgJN2YJMiLD1FSYJmywAnquy44CmumlY0Lj78LVdd0HvqzHfi6xzzURKNLWHg+/L
        L+QdSHBoxKlpW+CA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE5A8A3B88;
        Tue, 22 Feb 2022 08:27:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F9B5A0606; Tue, 22 Feb 2022 09:27:23 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:27:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 1 in ext4 and journal based on v5.17-rc1
Message-ID: <20220222082723.rddf4typah3wegrc@quack3.lan>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-02-22 20:10:03, Byungchul Park wrote:
> [    7.009608] ===================================================
> [    7.009613] DEPT: Circular dependency has been detected.
> [    7.009614] 5.17.0-rc1-00014-g8a599299c0cb-dirty #30 Tainted: G        W
> [    7.009616] ---------------------------------------------------
> [    7.009617] summary
> [    7.009618] ---------------------------------------------------
> [    7.009618] *** DEADLOCK ***
> [    7.009618]
> [    7.009619] context A
> [    7.009619]     [S] (unknown)(&(bit_wait_table + i)->dmap:0)
> [    7.009621]     [W] down_write(&ei->i_data_sem:0)
> [    7.009623]     [E] event(&(bit_wait_table + i)->dmap:0)
> [    7.009624]
> [    7.009625] context B
> [    7.009625]     [S] down_read(&ei->i_data_sem:0)
> [    7.009626]     [W] wait(&(bit_wait_table + i)->dmap:0)
> [    7.009627]     [E] up_read(&ei->i_data_sem:0)
> [    7.009628]

Looking into this I have noticed that Dept here tracks bitlocks (buffer
locks in particular) but it apparently treats locks on all buffers as one
locking class so it conflates lock on superblock buffer with a lock on
extent tree block buffer. These are wastly different locks with different
locking constraints. So to avoid false positives in filesystems we will
need to add annotations to differentiate locks on different buffers (based
on what the block is used for). Similarly how we e.g. annotate i_rwsem for
different inodes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
