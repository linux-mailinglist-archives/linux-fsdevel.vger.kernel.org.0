Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7272F5E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjFNHS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbjFNHSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:18:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8151A2695;
        Wed, 14 Jun 2023 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3rSwxNVPekJi9MhmQkqt74FM+K0wk4asaLM8FiU3iL0=; b=m7yR69IA5MYDQQU3PJenLZgT7t
        MoKN6bXgwmoAJ1zZVQKdoO3GVkqwbSr3yc6Lnffb0UIduqTWcC4+1ydSoG10YiLw609kYMrnDRpgE
        sW0Q7yrEZTxxBgNwmt1B7JTv2TMob17unABfZUfOgKHprV9Wm7t3ff3DqAlzi88kWfyQKdS0ljbeO
        rOfdKyuq3LCZlhG/TygWyGGyfiCSHJVoZGG6u1Isazu2GUop6bHhh7pK6DsqBTeiSmFhSAafKMeGg
        rhp6KpTEmpLi69b/O/UKuURY8ZR35NjlT9JJHKzoDG6gtPgsYNamL5cHjMj9DZtgB5WOrL1eBYQQ1
        7jFynjVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Kkw-00AdBg-07;
        Wed, 14 Jun 2023 07:17:26 +0000
Date:   Wed, 14 Jun 2023 00:17:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIlphqM9cpruwU6m@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:09:14AM +0200, Dmitry Vyukov wrote:
> I don't question there are use cases for the flag, but there are use
> cases for the config as well.
> 
> Some distros may want a guarantee that this does not happen as it
> compromises lockdown and kernel integrity (on par with unsigned module
> loading).
> For fuzzing systems it also may be hard to ensure fine-grained
> argument constraints, it's much easier and more reliable to prohibit
> it on config level.

I'm fine with a config option enforcing write blocking for any
BLK_OPEN_EXCL open.  Maybe the way to it is to:

 a) have an option to prevent any writes to exclusive openers, including
    a run-time version to enable it
 b) allow to also block writes without that option.  And maybe an
    opt-in to allow writes might be the better way than doing it
    the other way around.
