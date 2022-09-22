Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698575E61E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIVMCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVMCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:02:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD89B774C;
        Thu, 22 Sep 2022 05:02:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 459D81F90A;
        Thu, 22 Sep 2022 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663848128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzraJ08XbFjKvF3H8c6KILYdRR2eaJrzAO7H5AN4OPE=;
        b=nBWcPFYu+B37fjNNGJyCYovOcI5HXTBNjnyousgO5QBihaaIegJF34HHO/otCHi2IWF6pr
        TvqyU8N+84nPEqgytFBAdNm1xSOgd2JueqLiveKWanjTpU9NhfhKjY1q9GMI3kfMwPwosc
        IfYXNqL0u+kQ8ynXPkInhg+2nroRrQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663848128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzraJ08XbFjKvF3H8c6KILYdRR2eaJrzAO7H5AN4OPE=;
        b=Otyf8rmsFxydujS408TICq0B91m7wiegCNqTMhb4wroUcweQpfoSM0RfgYznpAhLdMa9KA
        gidmZTAnaWiVgCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36BA813AA5;
        Thu, 22 Sep 2022 12:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIdWDcBOLGPISwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Sep 2022 12:02:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B0496A0684; Thu, 22 Sep 2022 14:02:07 +0200 (CEST)
Date:   Thu, 22 Sep 2022 14:02:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [bug report] disk quota exceed after multiple write/delete loops
Message-ID: <20220922120207.3jeasu24dmx5khlz@quack3>
References: <CAHLe9YZvOcbimNsaYa=jk27uUR1jgVDtXXztLEa0AVnqveOoyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YZvOcbimNsaYa=jk27uUR1jgVDtXXztLEa0AVnqveOoyQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Tue 23-08-22 12:16:46, Boyang Xue wrote:
> On the latest kernel 6.0.0-0.rc2, I find the user quota limit in an
> ext4 mount is unstable, that after several successful "write file then
> delete" loops, it will finally fail with "Disk quota exceeded". This
> bug can be reproduced on at least kernel-6.0.0-0.rc2 and
> kernel-5.14.0-*, but can't be reproduced on kernel-4.18.0 based RHEL8
> kernel.

<snip reproducer> 

> Run log on kernel-6.0.0-0.rc2
> ```
> (...skip successful Run#[1-2]...)
> *** Run#3 ***
> --- Quota before writing file ---
> Disk quotas for user quota_test_user1 (uid 1003):
>      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
>      /dev/loop0       0  200000  300000               0    2000    3000
> --- ---
> dd: error writing '/mntpt/test_300m': Disk quota exceeded
> 299997+0 records in
> 299996+0 records out
> 307195904 bytes (307 MB, 293 MiB) copied, 1.44836 s, 212 MB/s

So this shows that we have failed allocating the last filesystem block.  I
suspect this happens because the file gets allocted from several free space
extens and so one extra indirect tree block needs to be allocated (or
something like that). To verify that you can check the created file with
"filefrag -v".

Anyway I don't think it is quite correct to assume the filesystem can fit
300000 data blocks within 300000 block quota because the metadata overhead
gets accounted into quota as well and the user has no direct control over
that. So you should probably give filesystem some slack space in your
tests for metadata overhead.

> --- Quota after writing file ---
> Disk quotas for user quota_test_user1 (uid 1003):
>      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
>      /dev/loop0  300000* 200000  300000   7days       1    2000    3000
> --- ---
> --- Quota after deleting file ---
> Disk quotas for user quota_test_user1 (uid 1003):
>      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
>      /dev/loop0       0  200000  300000               0    2000    3000
> --- ---
> ```

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
