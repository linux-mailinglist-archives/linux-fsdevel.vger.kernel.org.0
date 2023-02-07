Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E768D00B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 08:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBGHDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 02:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGHDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:03:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15637B5D;
        Mon,  6 Feb 2023 23:02:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k13so5149287wrh.8;
        Mon, 06 Feb 2023 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERzIHPqO65eg6P6JRWROd+ibAaAHzChz6DmY2oH7dlU=;
        b=HU25VSO1pPNZk/CKpZHxSWpXjgUGqG03qCfvV1q1iTjEoiXJylDRB5m+BIlyZ9XR/7
         rqA9iqsmyJSF8XMn/J96sS4WLde++xuRzYjU8uBUoZ8FNqU5R3Bsj+Yv6rR9XR1pMaPu
         2wbeG4FpGVLRD+xlSrKYFUE0IqLibLwSL0ZWwpKFDUKGqDn8dqs7qIwKC3cH9DbiKduX
         EeWG4hWay6YxFDwx1C4Z6GrHyIkCpx/ALaDpY1WtpJNhlYxwJ56d5pF1BpdugM4Fws1X
         +8dbcI1KDIoGqrBzn51oX6Zr1AY/rqXJhmG5KwcWKhs3ViL7nOLnZVIWdUcMW8DZIUhc
         t5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERzIHPqO65eg6P6JRWROd+ibAaAHzChz6DmY2oH7dlU=;
        b=z81qhSqx+mb5FeUC3ephA+neWxKW2GoaSEy487DF/DlvuQu3VbTuOgEQKpRdQ+M0EL
         +0POlEYcpj38u0SCPJ6VFvxFyFz944q7896upWf8XjPQVjwU9c+PZRf8K+jGa57yicAu
         6auzpbTIrxgyWp9n3aB0ZCZ9Go108Cw6cKM8mykJ3R21FI/84SFmw4CgCW2vIZNc4Hcp
         cM95bzzPbJAPL3KCW4N6K+OWddlwkgDLqO3+Ssh6kH0qn+2RiHAKnBzmzj1aMs4st33k
         6pOEvKfnUzj1zeO6L1O7gJsOv/mY/ZhGRCMJojTHvscA0LQZSQaXuJKdXX1SYeeJ3ipl
         GZiA==
X-Gm-Message-State: AO0yUKVAPN6DyJBGlXOMBh0N43cqdnvZ8JmFvab27b8NYMrkXC0i3f6R
        0z+cExriEHx2+rG1ntIZks4=
X-Google-Smtp-Source: AK7set9u8PMnsUeYJ01lhjHW67nTJ+EyTQUGI3Wh+OB6a1SumZCD2e4QejDMZEKAvvV7cccd0nusvw==
X-Received: by 2002:a05:6000:104:b0:2bf:ae3c:e963 with SMTP id o4-20020a056000010400b002bfae3ce963mr1445440wrx.9.1675753345885;
        Mon, 06 Feb 2023 23:02:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b003dfe8c4c497sm12722439wms.39.2023.02.06.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 23:02:25 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:02:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Julia Lawall <julia.lawall@inria.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y+H3eyrHFvv0tl50@kadam>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+EupX1jX1c5BAHv@kadam>
 <Y+E+57DfSM9mW62+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+E+57DfSM9mW62+@bombadil.infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:54:47AM -0800, Luis Chamberlain wrote:
> > block/blk-mq.c:4083 blk_mq_destroy_queue() warn: sleeping in atomic context
> 
> Let's see as an example.
> 
> blk_mq_exit_hctx() can spin_lock() and so could disable preemption but I
> can't see why this is sleeping in atomic context.
> 

I should have said, the lines are from linux-next.

block/blk-mq.c
  4078  void blk_mq_destroy_queue(struct request_queue *q)
  4079  {
  4080          WARN_ON_ONCE(!queue_is_mq(q));
  4081          WARN_ON_ONCE(blk_queue_registered(q));
  4082  
  4083          might_sleep();
                ^^^^^^^^^^^^^^

This is a weird example because today's cross function DB doesn't say
which function disables preemption.  The output from `smdb.py preempt
blk_mq_destroy_queue` says:

nvme_remove_admin_tag_set()
nvme_remove_io_tag_set()
-> blk_mq_destroy_queue()

I would have assumed that nothing is disabling preempt and the
information just hasn't propagated through the call tree yet.  However
yesterday's DB has enough information to show why the warning is
generated.

nvme_fc_match_disconn_ls() takes spin_lock_irqsave(&rport->lock, flags);
-> nvme_fc_ctrl_put(ctrl);
   -> kref_put(&ctrl->ref, nvme_fc_ctrl_free);
      -> nvme_remove_admin_tag_set(&ctrl->ctrl);
         -> blk_mq_destroy_queue(ctrl->admin_q);
            -> blk_mq_destroy_queue() <-- sleeps

It's the link between kref_put() and nvme_fc_ctrl_free() where the data
gets lost in today's DB.  kref_put() is tricky to handle.  I'm just
puzzled why it worked yesterday.

regards,
dan carpenter

