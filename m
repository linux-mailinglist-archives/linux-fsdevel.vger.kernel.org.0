Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35930596597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 00:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiHPWmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHPWmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:42:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6A90815;
        Tue, 16 Aug 2022 15:42:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q19so10572952pfg.8;
        Tue, 16 Aug 2022 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=JgdM6PCu4xquExA3dHL+HJQyYf6q82sc1qa9WCQu3gg=;
        b=ZnzfzCZP/hNebeixm1qHo6YLgGhuGVkdNxUrDCvXage6xxIo8K5aYhuJBElHwXNlGD
         H7keXWn5xtNUsKJC7oB1DZSN60uAjV9ILO1hz2+KPHr2sHx5qWwJHXgI7wHHT2zkeqHW
         RiRpchXpmgnqfXD4eL2i64a0Hso7KLbH8dJN218q6cXEjhPb4wObLbDn3rmBxwabtVOm
         8nOeFT4lj4HIMxMj9Jp65P8fzonyI6PwwFnSvn1dkH7ZNO3JOaiu/8HIOJVtKw+dhMLJ
         QDhUKcrNUf6IgmCAkR9wz/GM0KLrx3hcKz0Gpr8FvgMKMGYcZqOaBTL3QcDH8uL504d+
         1tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=JgdM6PCu4xquExA3dHL+HJQyYf6q82sc1qa9WCQu3gg=;
        b=qplVCjGsAITLY34AH/Cmh4AroPyz8wq0PrKTKK4pw0bHH3GzvWIlFpcxHxCMPo/elV
         R9MhZbncl6H5RiFTYn6n+w0hZwQeFdhShHau7kxfxpxakh9r0B+QB8GSPMIxqdvKY+n0
         7gfwuG4emfQPQq8r+MhBwAe9cTEhh2n+KCq+F8/7k1XXcq8PyAtluynN97lKOQSm7pkT
         aeV3NNtyjcBcFzbKhBomRXdL61RBhZPVcKtHdNqgzi89O8+z4IHScaV6sMtR1dZy4H4k
         eZZyx9N18Hi7jzfkMRlIddQELhN7ehH/5GXbsq+J0v+dZN/DB28Ja0vq06K2tnUVgPUi
         GwEA==
X-Gm-Message-State: ACgBeo1GrMLkGt6BmlFH/d12btcWpf3+EJ55aUip2OdfGH7BrWYJOC/i
        N2TJ5ARHO/WRjwhK8nyCBoM=
X-Google-Smtp-Source: AA6agR7oV11+9KJzqokY0E/MJ+Ti4nqWQcmG7NQZdyHrFhYegwzn8YN4NXJNs8GuY6k9mwbRJ1loTA==
X-Received: by 2002:a63:1857:0:b0:41c:4217:426e with SMTP id 23-20020a631857000000b0041c4217426emr19565486pgy.285.1660689740295;
        Tue, 16 Aug 2022 15:42:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0016c46ff9741sm9656054plx.67.2022.08.16.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:42:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 12:42:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YvwdShstDCK+uQ+R@slm.duckdns.org>
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
 <20220810111017.2267160-5-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810111017.2267160-5-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm bandwidth constrained right now and can't really shepherd this patchset,
so I'm not gonna ack or nack the series. That said, here are my thoughts
after glancing through it:

* I find the returning-with-rwsem-held interface and usage odd. We return
  with locks held all the time, so that part in itself is fine but how it's
  used in the proposed patch is pretty alien.

* I don't understand why the topo_mutex is needed. What is its relationship
  with rename_lock?

* Can't the double/triple lock helpers loop over the sorted list instead of
  if'ing each case?

Thanks.

-- 
tejun
