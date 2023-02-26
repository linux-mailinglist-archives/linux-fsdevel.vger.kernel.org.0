Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECAD6A3308
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBZRBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 12:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZRBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:01:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBDEF941;
        Sun, 26 Feb 2023 09:01:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so3978515pjz.1;
        Sun, 26 Feb 2023 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JXRJzGuJZN00HNNHJfRJv3AmmbP6kCQMVWRc0KyX8U=;
        b=IVew+NoK6l47qKNxcUxWrRlLUX49q+1GN9+96MVBY8nOrJ2SbDHZWLVcf1wYqdb64b
         MkGa3tmpaY6IELj7MGIc06t4FGMmU1tv+by/+W6G/g49ujYx0QgmwGin1fC3OHqKak8a
         zQFoyy/ZovVXcUbOHrOyWtDms0dKlBrez+HGvJX5906yrlbogQXEA69hKsxKspOysj4Q
         MzzhIlZuZrckHi9niouh3+2hYHkCBy1ovVEd6BmFLG8d4vMx3C2NbuT+NkzphH1e2z5r
         drORQri+P2TV0KN9WpDK97OPTj9WHEjZiDnzLFMJW4C+41isLycNvDfHvBlfyVFFiIAW
         ql5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JXRJzGuJZN00HNNHJfRJv3AmmbP6kCQMVWRc0KyX8U=;
        b=nTR6uqneYTYPA8q5qeUQlLK4/WW9vJRSd1QqKyfK9ttCjj6JzVOTmTTjX+CDsW2pvw
         mRS5Tgu/uR3kV4EAIxffMZebe4l4TMk0H3L6AyaBuJU2RbMMdBuNbYoGuvrDErIR9A9R
         KGCzxziKR14jQFhhac68h+z6PfD5oPx7b//d3QfKd4AmILao9+y0Edwc4Ph8nOzFwb8c
         oe5UI9TIHvBVn3eye1jk3mxH7zv6HqMyESrzNu+x7TdtR4RGbc4iyTd6sywVLISvaeC5
         vkx1Ki2LEQdQvx/GybePFuXMK/wG8TNcj/0vcwmR606xfpKi2PYnNp4y65It5YLTxdw3
         xTkw==
X-Gm-Message-State: AO0yUKVyvSfhz9AIJuR0TpLSln9diILylFQT9A9b2taZQKrSgdDrobQw
        SDYSK/uAdJCjBFF7kekaq/k=
X-Google-Smtp-Source: AK7set+UV26zRGMa1ukPz1jMf2XulekvRMg4op9oeY3PT/q4GbUPnYliVlA3cAiWqq4s8elT6dUYrw==
X-Received: by 2002:a17:902:db08:b0:19c:da7f:a237 with SMTP id m8-20020a170902db0800b0019cda7fa237mr9714990plx.5.1677430904423;
        Sun, 26 Feb 2023 09:01:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709029a8b00b0019a7363e752sm2859138plp.276.2023.02.26.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:01:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 26 Feb 2023 07:01:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/uQdXp8ioY1WQEp@slm.duckdns.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 26, 2023 at 11:02:53PM +0700, Ammar Faizi wrote:
> Hi,
> 
> This is an RFC patchset that introduces the `wq_cpu_set` mount option.
> This option lets the user specify a CPU set that the Btrfs workqueues
> will use.
> 
> Btrfs workqueues can slow sensitive user tasks down because they can use
> any online CPU to perform heavy workloads on an SMP system. Add a mount
> option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
> to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.
> 
> This option is similar to the taskset bitmask except that the comma
> separator is replaced with a dot. The reason for this is that the mount
> option parser uses commas to separate mount options.

Hmm... the allowed cpumasks for unbounded workqueues can already be set
through /sys/devices/virtual/workqueue/cpumask and also each individual
workqueue can be exposed in the matching subdirectory by setting WQ_SYSFS.
Wouldn't the proposed btrfs option be a bit reduandant?

Thanks.

-- 
tejun
