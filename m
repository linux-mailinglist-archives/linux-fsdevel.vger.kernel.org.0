Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD607763B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjHIPcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHIPcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:32:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FA10F6;
        Wed,  9 Aug 2023 08:32:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75DE01F45E;
        Wed,  9 Aug 2023 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691595128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBSdg5lGWPozZuQqsIRUzfuQJQeSHKdh98LQD8hsqUA=;
        b=0QI+gdRBhzw7a0KS8OlwzTIibiLKOjQAZnC+j81V4UaWZ5o1FEQZwPI0tU6qf75FIsYxLl
        v1eVLAw9p/xZvplS1eTe+A3wkX4dKmoIWyp1roxJefHiD3rM7qtFBzy1/W/PcVEpRDCCV+
        Lcjf/jfZmJIn7FePH/dWKNAMqZPb3Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691595128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBSdg5lGWPozZuQqsIRUzfuQJQeSHKdh98LQD8hsqUA=;
        b=4KPkP26CMTm9vBgsEriOtGdAbcX4UNO7L3/VJEVwjJDk0zXrnxklDskrxYfjQajW0XM7rM
        VHJp/fEoItWgPNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67C7A13251;
        Wed,  9 Aug 2023 15:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kHNNGXix02TBSwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 15:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA453A0769; Wed,  9 Aug 2023 17:32:07 +0200 (CEST)
Date:   Wed, 9 Aug 2023 17:32:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Zhiyu <zhiyuzhang999@gmail.com>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: A Discussion Request about a maybe-false-positive of UBSAN: OOB
 Write in do_journal_end in Kernel 6.5-rc3(with POC)
Message-ID: <20230809153207.zokdmoco4lwa5s6b@quack3>
References: <CALf2hKvsXPbRoqEYL8LEBZOFFoZd-puf6VEiLd60+oYy2TaxLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALf2hKvsXPbRoqEYL8LEBZOFFoZd-puf6VEiLd60+oYy2TaxLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Tue 01-08-23 23:48:59, Zhang Zhiyu wrote:
> I found a UBSAN: OOB Write in do_journal_end reported on Linux Kernel
> 6.5-rc3 by my  modified version of syzkaller on 25 July. I tried to
> send an email, but it was rejected by the mail system due to HTML
> formatting included in the email. Here is the plain email text:
> 
> The .config, report*, repro.prog, repro.cprog can be found in:
> https://drive.google.com/file/d/1GPN68s6mA0Ee3CyK7OSbdBNABuFEzhtv/view?usp=sharing
> And the POC can be stably reproduced in the latest kernel (in/after
> 6.5-rc3) and the kernel panics. Reproduced screenshot:
> https://drive.google.com/file/d/10_4PQHSSwEBCHIMDxjb9EzB6UylRjocP/view?usp=sharing
> 
> After analyzing the root cause, I found it may be a false-positive of
> UBSAN. Firstly, the oob behavior happened at
> fs/reiserfs/journal.c:4166. When i == 1, it overwrites the
> desc->j_realblock[i], which is declared with a size of 1. However,
> with a further sight, the desc is wrapped with a b_size=0x1000 when
> allocating and i won't be larger than trans_half (smaller than
> blocksize), which would prevent the overwriting at line 4166. It seems
> a trick of memory access of j_realblock.

Yes, j_realblock is in fact a variable length array declared in an ancient
way which is likely confusing UBSAN.

> But in fs/reiserfs/journal.c:4169, is it possible to manually
> construct an extremely long journal link and let i-trans_half >
> 0x1000? In this way, commit->j_realblock[i - trans_half] =
> cpu_to_le32(cn->bh->b_blocknr); may destroy the memory outside the
> block "barrier". And maybe conduct a heap spray?

No, it is not possible. Just check how that list is constructed - new
members are added to the list in journal_mark_dirty() and there we check
there are less than journal->j_trans_max members in the list. And
journal->j_trans_max is selected so that the block numbers fit into the
descriptor + commit block.

> I'm not sure if it's actually an fp, so I haven't patched it yet. I
> hope to have some discussion based on my analysis.
> 
> Thanks for your time reading this discussion request. Although I'm a
> newbie in kernel security, I am very glad to help to improve the
> kernel.

Improving kernel security is certainly a worthy goal but I have two notes.
Firstly, reiserfs is a deprecated filesystem and it will be removed from
the kernel in a not so distant future. So it is not very useful to fuzz it
because there are practically no users anymore and no developer is
interested in fixing those bugs even if you find some. Secondly, please do
a better job of reading the code and checking whether your theory is
actually valid before filing a CVE (CVE-2023-4205). That's just adding
pointless job for everyone... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
