Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC14769AE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBQOdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBQOdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:33:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECF62FC4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 06:33:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31AB61FEC1;
        Fri, 17 Feb 2023 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676644388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zopWuCQrC1rdeWoR6O5z7jiBljTWOgoFh6WvTassupc=;
        b=tn5vgPQzuZMEJ1LQ1jLTkSYBNzNm6hujX8veQrLZnPu2s45BRgvQG6fK2NV9HhDBhLaK11
        aVuId/HQTLj3yEP+UkymJyKOqfGoUK7VHnrDIKtCTrao3feWGp00N93elA1gsu9mPJAHjQ
        getPaOIjcHc6l68MXDPavj+vHgbgu6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676644388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zopWuCQrC1rdeWoR6O5z7jiBljTWOgoFh6WvTassupc=;
        b=CODWux77/b9omo5+Z7Br8sl43wnI++2Bj1xRIJ1oY9MfqGFrPl/CKhq9THd3ybRIAgJQiQ
        m1zc/03OOyICPvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B55513274;
        Fri, 17 Feb 2023 14:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PiGgBiSQ72ObIAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 14:33:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63E3CA06E1; Fri, 17 Feb 2023 15:33:07 +0100 (CET)
Date:   Fri, 17 Feb 2023 15:33:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Hans Holmberg <hans@owltronix.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?Q?J=C3=B8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Message-ID: <20230217143307.g774ouwddlyslqw7@quack3>
References: <CGME20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b@uscas1p2.samsung.com>
 <20230206134148.GD6704@gsv>
 <20230208171321.GA408056@bgt-140510-bm01>
 <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
 <61a40b61-2346-053d-1190-907075e1c9d2@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a40b61-2346-053d-1190-907075e1c9d2@wdc.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-02-23 10:22:31, Johannes Thumshirn wrote:
> On 09.02.23 11:06, Hans Holmberg wrote:
> > It takes a significant amount of time and trouble to build, run and understand
> > benchmarks for these applications. Modeling the workloads using fio
> > minimizes the set-up work and would enable more developers to actually
> > run these things. The workload definitions could also help developers
> > understanding what sort of IO that these use cases generate.
> 
> True, but I think Adam has a point here. IIRC mmtests comes with some scripts
> to download, build and run the desired applications and then do the maths.
> 
> In this day and age people would probably want to use a container with the
> application inside and some automation around it to run the benchmark and 
> present the results.

Yeah, although containers also do have some impact on the benchmark
behavior (not that much for IO but for scheduling and memory management it
is more visible) so bare-metal testing is still worthwhile. Mmtests
actually already have some support for VM testing and we have implemented
basic container testing just recently. There are still rough edges and more
work is needed but mmtests are also moving into the next decade ;).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
