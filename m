Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55F5AC5E6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiIDS1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiIDS1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 14:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0A303F6;
        Sun,  4 Sep 2022 11:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2826560FD1;
        Sun,  4 Sep 2022 18:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A3EC433D6;
        Sun,  4 Sep 2022 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662316040;
        bh=NH1DZqWrJIou0gR8/SOQYjSqqNtQPHmi2KpVU7tMcVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WRn0kiufLkUeNTeYF9+cX0twvAtTs8Qb4t3gd+meoMl0COWVQAIibeQslpfZkDplS
         tL8imZI4F4oBjI0pgvfwKjAbR64sq8BAfLVJxVuwZJnlHY5oH14nJb84GL/ME7bJSp
         LF0A4Qd/xrN3jnuQ6+Zl2M8hJtv6TXJ41oeBYbGw=
Date:   Sun, 4 Sep 2022 11:27:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Renaud =?ISO-8859-1?Q?M=E9trich?= <rmetrich@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
Message-Id: <20220904112718.b7feead47012600ef255dfdf@linux-foundation.org>
In-Reply-To: <20220903064330.20772-1-oleksandr@redhat.com>
References: <20220903064330.20772-1-oleksandr@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  3 Sep 2022 08:43:30 +0200 Oleksandr Natalenko <oleksandr@redhat.com> wrote:

> Statistically, in a large deployment regular segfaults may indicate a CPU issue.
> 
> Currently, it is not possible to find out what CPU the segfault happened on.
> There are at least two attempts to improve segfault logging with this regard,
> but they do not help in case the logs rotate.
> 
> Hence, lets make sure it is possible to permanently record a CPU
> the task ran on using a new core_pattern specifier.
> 
> ...
>
>  			}
> @@ -535,6 +539,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		 */
>  		.mm_flags = mm->flags,
>  		.vma_meta = NULL,
> +		.cpu = raw_smp_processor_id(),
>  	};

Why use the "raw_" function here?


