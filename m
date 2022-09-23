Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654F5E7850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIWK3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiIWK2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:28:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE712C685;
        Fri, 23 Sep 2022 03:28:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CAEC1FA43;
        Fri, 23 Sep 2022 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663928908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zoKmjKWIu19I7vbLPa5SWD6K1W4QikjxPXIquASsstM=;
        b=HDiWia0Ukx6kPkGxXnYJhuLYz/Hn4TjR97NHnI157EcTVJnvcsD86hNE8QnNnGhbcrInEa
        BQqMajOhvZQciiZxrdZu6cTuwKLL9Yzq/S28CIT8j4iXLJfboHkooz/Ci7KVgmq6NZaeZh
        vRCAJ+7SY/t8U+j0Bsbecb4a6WJd770=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663928908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zoKmjKWIu19I7vbLPa5SWD6K1W4QikjxPXIquASsstM=;
        b=/1Rj58aDHzf77Mg9yTe9HyhWLHM7MfHg7cYvxnLCKFDu8Pz4i4xS7uoHBc8JSLZ4m7QgW+
        8vjRJvcvIgLwDSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B71D13AA5;
        Fri, 23 Sep 2022 10:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SIcXHkyKLWNKPwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 10:28:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E489A0685; Fri, 23 Sep 2022 12:28:27 +0200 (CEST)
Date:   Fri, 23 Sep 2022 12:28:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [bug report] disk quota exceed after multiple write/delete loops
Message-ID: <20220923102827.s6osm6tmgqviomvh@quack3>
References: <CAHLe9YZvOcbimNsaYa=jk27uUR1jgVDtXXztLEa0AVnqveOoyQ@mail.gmail.com>
 <20220922120207.3jeasu24dmx5khlz@quack3>
 <CAHLe9YbPph=6PqeDNYANvRnrmkir5iLSbVD6gAhVZju6k8cgbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YbPph=6PqeDNYANvRnrmkir5iLSbVD6gAhVZju6k8cgbA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-09-22 15:37:55, Boyang Xue wrote:
> Hi Jan,
> 
> On Thu, Sep 22, 2022 at 8:02 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > On Tue 23-08-22 12:16:46, Boyang Xue wrote:
> > > On the latest kernel 6.0.0-0.rc2, I find the user quota limit in an
> > > ext4 mount is unstable, that after several successful "write file then
> > > delete" loops, it will finally fail with "Disk quota exceeded". This
> > > bug can be reproduced on at least kernel-6.0.0-0.rc2 and
> > > kernel-5.14.0-*, but can't be reproduced on kernel-4.18.0 based RHEL8
> > > kernel.
> >
> > <snip reproducer>
> >
> > > Run log on kernel-6.0.0-0.rc2
> > > ```
> > > (...skip successful Run#[1-2]...)
> > > *** Run#3 ***
> > > --- Quota before writing file ---
> > > Disk quotas for user quota_test_user1 (uid 1003):
> > >      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
> > >      /dev/loop0       0  200000  300000               0    2000    3000
> > > --- ---
> > > dd: error writing '/mntpt/test_300m': Disk quota exceeded
> > > 299997+0 records in
> > > 299996+0 records out
> > > 307195904 bytes (307 MB, 293 MiB) copied, 1.44836 s, 212 MB/s
> >
> > So this shows that we have failed allocating the last filesystem block.  I
> > suspect this happens because the file gets allocted from several free space
> > extens and so one extra indirect tree block needs to be allocated (or
> > something like that). To verify that you can check the created file with
> > "filefrag -v".
> 
> By hooking a "filefrag -v" in each run, I find a pattern that only
> when the dd command writes out of disk quota, "filefrag -v" shows
> "unwritten extents", like this:
> ```
> Filesystem type is: ef53
> File size of /mntpt/test_300m is 307195904 (74999 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..    1023:      98976..     99999:   1024:
>    1:     1024..   18431:     112640..    130047:  17408:     100000:
>    2:    18432..   51199:     131072..    163839:  32768:     130048:
>    3:    51200..   55236:     165888..    169924:   4037:     163840: unwritten
>    4:    55237..   74998:          0..         0:      0:
> last,unknown_loc,delalloc,eof
> /mntpt/test_300m: 5 extents found
> ```

OK, this matches what I've said. The unwritten extent is there because the
inode is just undergoing writeback and that may (at least temporarily)
increase number of extents. The inode can hold 4 extents, once fifth extent
is added we have to allocate indirect block which is what breaks your test.
So nothing unexpected here. Thanks for checking!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
