Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E45AC634
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiIDTjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiIDTi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9501AD87
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Sep 2022 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662320338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3ABpshjkv87/QevZMgt/Jxr8eWoaETBvCY6qeXNguA=;
        b=XPeXGHCDABPER8f8fqM8tAbz1SaBKvny+28JQgZS8KlWO4BNjgQ1+le9Aoo3nmp/kpOTIF
        bqIkKdkg7YQfxQ95/eb45hyRl/eADAS+394rEyk5G/im+ThiFoEvarIj39enH2Wlgoapef
        dAi7tiYfHhW1OrCfxWn4L6/u+2w44f0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-6vRjenz8Ng6psc4gk-hN4A-1; Sun, 04 Sep 2022 15:38:52 -0400
X-MC-Unique: 6vRjenz8Ng6psc4gk-hN4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A9B880A0AE;
        Sun,  4 Sep 2022 19:38:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3367B40B40C9;
        Sun,  4 Sep 2022 19:38:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun,  4 Sep 2022 21:38:50 +0200 (CEST)
Date:   Sun, 4 Sep 2022 21:38:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Renaud =?iso-8859-1?Q?M=E9trich?= <rmetrich@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
Message-ID: <20220904193844.GA7953@redhat.com>
References: <20220903064330.20772-1-oleksandr@redhat.com>
 <20220904112718.b7feead47012600ef255dfdf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904112718.b7feead47012600ef255dfdf@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/04, Andrew Morton wrote:
>
> On Sat,  3 Sep 2022 08:43:30 +0200 Oleksandr Natalenko <oleksandr@redhat.com> wrote:
>
> > @@ -535,6 +539,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >  		 */
> >  		.mm_flags = mm->flags,
> >  		.vma_meta = NULL,
> > +		.cpu = raw_smp_processor_id(),
> >  	};
>
> Why use the "raw_" function here?

To avoid check_preemption_disabled() from debug_smp_processor_id().

We do not disable preemption because this is pointless, this is the
"racy snapshot" anyway. The coredumping task can migrate to another
CPU even before get_signal/do_coredump, right after exit-to-user
path enables irqs.

Oleg.

