Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07C6558DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 08:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiLXHRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Dec 2022 02:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLXHRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:17:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6CDF32;
        Fri, 23 Dec 2022 23:17:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bx10so6323802wrb.0;
        Fri, 23 Dec 2022 23:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYdZuRzobQmIoU+GUW5xOEJnXoxJQHcF7omPb4wLhQE=;
        b=eq72v+3LBcvOBON4Ls8rGWFwmCnNJ9OoeCpYt2shZ7Ig+ysrUxOmn9O11XkB6/zY5s
         aMC049QaZskHhQ4SRo08bepBWyFG+c2jdBMUY/oO5LFX+2EWeK6heXXIzUJnRRbwLbqk
         r0JM+zP3L++NEEyKLOnrWzxnv4/etWfrwRAkW4bueLz7YXb5SO9WLJVTYOcIwpGFNrfa
         qmBtdsPFf1+iKGbNt4PEWFZTMPkARWda5C8Rv1VvK08SobuZGHuPwoi9h2iIrBaGcbPL
         uqU68dwGSxGevUWA9iiqaotddgjnh38XJohEa0VW+yfW6hm0ptId0uRHXrJtY09ItW9u
         ZfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYdZuRzobQmIoU+GUW5xOEJnXoxJQHcF7omPb4wLhQE=;
        b=N3U42WV8yh5KB26d6srPvAmcfqH01E+SC9DsoG7I3p5WXgq/ABI0vmsrzQcSnm31gZ
         okGBl9A76EVVGPdIhrm2pYWsfe6C3qFn68IvsArbJwlXy4WouPKcRKBiEjwCgmoGZH2Y
         PdgznCRkybATvrUPe/dEsn6dXhcuLj5T5uTRPQggo8iF9Z19fVpdBQ4pVoW2tliXYHnv
         PsTB8D1Xj9a7DF1lp8z6vQfMmuhYwyJgzPxMHSBppTlmd6vXZEX1KHOCP3pNH9P5Ho/U
         blVraGiLjmGJlggqqMfgdZGhzgEHTt6ReS9IXI7Z11cLlUPcfPtnBaiMzH83hxBzoA0x
         FX/A==
X-Gm-Message-State: AFqh2kqiLsrQWCkkqiLAojnGF0iax7ESVSY2dobujsixuWseiC/xJr7b
        1WvqkbWViQRYGsLaSH+85Fc=
X-Google-Smtp-Source: AMrXdXsBK3+3LWL4MW0/QLZP0R0349A+rn33at/1vXHt8anZlbc/DKK8ciK4wp9oBd2h+g0CELjmww==
X-Received: by 2002:adf:ec88:0:b0:242:52b6:9054 with SMTP id z8-20020adfec88000000b0024252b69054mr8030764wrn.58.1671866219446;
        Fri, 23 Dec 2022 23:16:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm4865843wrx.61.2022.12.23.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 23:16:59 -0800 (PST)
Date:   Sat, 24 Dec 2022 10:16:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, wenyang.linux@foxmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Wen Yang <wenyang.linux@foxmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: use a generic helper instead of an open coded
 wait_event
Message-ID: <202212240819.6KA20geM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B38979DE0FF3B9B3EA887A37487B123BBD05@qq.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wenyang-linux-foxmail-com/eventfd-use-a-generic-helper-instead-of-an-open-coded-wait_event/20221222-234947
patch link:    https://lore.kernel.org/r/tencent_B38979DE0FF3B9B3EA887A37487B123BBD05%40qq.com
patch subject: [PATCH] eventfd: use a generic helper instead of an open coded wait_event
config: i386-randconfig-m021
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/eventfd.c:254 eventfd_read() warn: inconsistent returns '&ctx->wqh.lock'.

vim +254 fs/eventfd.c

12aceb89b0bce1 Jens Axboe     2020-05-01  226  static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
e1ad7468c77ddb Davide Libenzi 2007-05-10  227  {
12aceb89b0bce1 Jens Axboe     2020-05-01  228  	struct file *file = iocb->ki_filp;
b6364572d641c8 Eric Biggers   2018-01-06  229  	struct eventfd_ctx *ctx = file->private_data;
b6364572d641c8 Eric Biggers   2018-01-06  230  	__u64 ucnt = 0;
e1ad7468c77ddb Davide Libenzi 2007-05-10  231  
12aceb89b0bce1 Jens Axboe     2020-05-01  232  	if (iov_iter_count(to) < sizeof(ucnt))
b6364572d641c8 Eric Biggers   2018-01-06  233  		return -EINVAL;
d48eb233159522 Davide Libenzi 2007-05-18  234  	spin_lock_irq(&ctx->wqh.lock);
12aceb89b0bce1 Jens Axboe     2020-05-01  235  	if (!ctx->count) {
12aceb89b0bce1 Jens Axboe     2020-05-01  236  		if ((file->f_flags & O_NONBLOCK) ||
12aceb89b0bce1 Jens Axboe     2020-05-01  237  		    (iocb->ki_flags & IOCB_NOWAIT)) {
12aceb89b0bce1 Jens Axboe     2020-05-01  238  			spin_unlock_irq(&ctx->wqh.lock);
12aceb89b0bce1 Jens Axboe     2020-05-01  239  			return -EAGAIN;
12aceb89b0bce1 Jens Axboe     2020-05-01  240  		}
c908f8e6a3a1eb Wen Yang       2022-12-22  241  
c908f8e6a3a1eb Wen Yang       2022-12-22  242  		if (wait_event_interruptible_locked_irq(ctx->wqh, ctx->count))
12aceb89b0bce1 Jens Axboe     2020-05-01  243  			return -ERESTARTSYS;

spin_unlock_irq(&ctx->wqh.lock);

e1ad7468c77ddb Davide Libenzi 2007-05-10  244  	}
b6364572d641c8 Eric Biggers   2018-01-06  245  	eventfd_ctx_do_read(ctx, &ucnt);
9f0deaa12d832f Dylan Yudaken  2022-08-16  246  	current->in_eventfd = 1;
e1ad7468c77ddb Davide Libenzi 2007-05-10  247  	if (waitqueue_active(&ctx->wqh))
a9a08845e9acbd Linus Torvalds 2018-02-11  248  		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
9f0deaa12d832f Dylan Yudaken  2022-08-16  249  	current->in_eventfd = 0;
d48eb233159522 Davide Libenzi 2007-05-18  250  	spin_unlock_irq(&ctx->wqh.lock);
12aceb89b0bce1 Jens Axboe     2020-05-01  251  	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
b6364572d641c8 Eric Biggers   2018-01-06  252  		return -EFAULT;
cb289d6244a37c Davide Libenzi 2010-01-13  253  
12aceb89b0bce1 Jens Axboe     2020-05-01 @254  	return sizeof(ucnt);
cb289d6244a37c Davide Libenzi 2010-01-13  255  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

