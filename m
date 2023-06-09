Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C03729C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjFIOTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbjFIOTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:19:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465635A9;
        Fri,  9 Jun 2023 07:19:31 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:19:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686320369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYK4KNvEFkce/VyaNbpjmJmft8NrOeqE2CvuyKuAfes=;
        b=00/wnt2416KaOYbjeftQ8Aw+6g1+/xH5Bykdi+M2tCTxDTjKIH5TVVjahoeDe+387DvZm6
        jfj/q3HU0x5tkqj8+luaIWB4Le1dDXb66+AS8ZW5oaZaipeHwgtJrF35cD7xEDyS8Nl+BG
        peJuNm8aFmcpAKCssyvGB4OuETtzPdV3N6dKLQQpxf1NF/hwQy81tG+0ascouCLkjqFPYy
        kelvqqw9RjNA1OTEIzDORT3/uQZqc3pFjuT1Y4/vQnTg0P/c7NVVmVwuMxLVD5zLDK3yP/
        cFNnUQpkW73apHeq1L5liIAq2aAOQLQ5nCYnumvpNbfUPJvgFG9BnKGju6RapQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686320369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYK4KNvEFkce/VyaNbpjmJmft8NrOeqE2CvuyKuAfes=;
        b=/2PZz2T0R7tryMOE67dyWbMyv5wThnzmqRzYWYK6AeCsBz28nKSB6tV/RufqH3SpjOby9q
        TiGdhGrQFYAhRUDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230609141928.CDC3_W5W@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-05 15:47:23 [-0700], Andrii Nakryiko wrote:
> I understand it's safe today, but I'm more worried for future places
> that will do bpf_link_put(). Given it's only close() and BPF FS
> unlink() that require synchronous semantics, I think it's fine to make
> bpf_link_put() to be async, and have bpf_link_put_sync() (or direct,
> or whatever suffix) as a conscious special case.

Okay, let me do that then.

> > This is invoked from the RCU callback (which is usually softirq):
> >         destroy_inode()
> >          -> call_rcu(&inode->i_rcu, i_callback);
> >
> > Freeing memory is fine but there is a mutex that is held in the process.
> 
> I think it should be fine for BPF link destruction then?

bpf_any_put() needs that "may sleep" exception for BPF_TYPE_LINK if it
comes from RCU.
I will swap that patch to be async by default and make sync for
bpf_any_put() if called from close (except for the RCU case).

Sebastian
