Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53514752498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjGMOGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGMOGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:06:18 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349C1FF7;
        Thu, 13 Jul 2023 07:06:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4R1xGs48pSz9smd;
        Thu, 13 Jul 2023 16:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689257173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMZOWPNncf/1aOM0SqCrmeem2JnHn02pihgZxljBHmQ=;
        b=QzJdzaU0KsG33pgKxrLZYRPQMPtvzQkcD8wGfhqq920WjbIqLouFXILrGp8umXb22H3vmJ
        ozwnmt3RTGLKATrmyf6XtUslDxANMZPYGAhCcVLr/QrfW9da38NsnJpCK+z8kD8a6aEZVg
        sb3sGDms4XaM0ciYU1A2bx+2DK6lqoDACJv5CrLBaei/cpHxvvA9rBYIXF46/onVQ8MkdO
        jHyeG6fgoQYau/3ytcBUCrSPCOHX2rr+P72Pvss6gJ8oWzGjgwoB1cazRYdFOvRo5wJx4w
        puPYQGdHwerjpvhNeInqhM6JbOIJEBBrp+Xv3wHfKn8xMVmIixoLUuqoPks5AA==
Date:   Fri, 14 Jul 2023 00:06:02 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH] procfs: block chmod on /proc/thread-self/comm
Message-ID: <jjls2w5xh2urrkgxzts6jfwbpa2zpi3p6nsvjy7rpsum7rtt4c@4e5z735u4ofz>
References: <20230713121907.9693-1-cyphar@cyphar.com>
 <ZK/vj5qnkaeBt6cR@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZK/vj5qnkaeBt6cR@1wt.eu>
X-Rspamd-Queue-Id: 4R1xGs48pSz9smd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-13, Willy Tarreau <w@1wt.eu> wrote:
> +Cc Thomas Weiﬂschuh <thomas@t-8ch.de> as this seems quite related to
> his finding about /proc/self/net:
> 
>   https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/#b

Yeah I saw this patch and (along with an earlier discussion with
Christian on the topic of chmod on symlinks -- see [1]) lead us to find
that there were three other cases where this happens unintentionally:

 * /proc/self (on the symlink itself)
 * /proc/thread-self (on the symlink itself)
 * /proc/thread-self/comm

The first two will be fixed by [1] so fixing them isn't necessary.

[1]: https://lore.kernel.org/linux-fsdevel/20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org/

-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>
