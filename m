Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4855062A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 05:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbiDSDfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 23:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346806AbiDSDfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:35:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC82B266;
        Mon, 18 Apr 2022 20:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84B160FCA;
        Tue, 19 Apr 2022 03:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9EBC385A7;
        Tue, 19 Apr 2022 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650339144;
        bh=NUPu4YWlrvlHt/n0rKRmUg75CJPp5wRqgNcYElGbLxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GtVMzzCP4TQ9o7chQQyqm2nRj7zyWGe1ngPSYR4tF2+k81uD8uWW9xwuwtYj8M0qq
         5Jg1ytKk0XJevilQgynjZN0yG7B9+qAqcauyXI1IJDTZcM/N6ptPOSyspSG5B7aQzc
         xm999DA8Af2V6LItS6IQPXgN/od/Jv9e3GIUAf9Q=
Date:   Mon, 18 Apr 2022 20:32:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/2] userfaultfd: selftests: modify selftest to use
 /dev/userfaultfd
Message-Id: <20220418203223.02d00391505b662e71e8c1db@linux-foundation.org>
In-Reply-To: <CAJHvVcj=pL8y_b_urq8QvtDvRRMmjgGkquQM6xhxWwiajNrhKQ@mail.gmail.com>
References: <20220412202942.386981-1-axelrasmussen@google.com>
        <20220412202942.386981-2-axelrasmussen@google.com>
        <20220412134159.f0a1d0d77f5b01638007bf4b@linux-foundation.org>
        <CAJHvVcj=pL8y_b_urq8QvtDvRRMmjgGkquQM6xhxWwiajNrhKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Apr 2022 15:16:02 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> Thanks for looking Andrew. And, fair criticism.
> 
> In keeping with the status quo, I'm thinking of just adding a new
> command-line argument which toggles between the two modes.

But I think you could tweak the test pretty simply to run itself twice.
Once with the syscall then once with the /dev interface.

I suppose that adding the commandline argument is equivalent, as long
as the upper level script/makefile invokes the test program twice.

> But, if I'm honest, it's starting to feel like the test has way too
> many arguments... I'm tempted to refactor the test to use the
> kselftest framework [1], get rid of all these command line arguments,
> and just always test everything. But, this seems like a big and
> perhaps controversial refactor, so I may take it up after this
> series...

Yes, that's a separable activity.


