Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8E538F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiEaKii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiEaKih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:38:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2F996B0;
        Tue, 31 May 2022 03:38:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BACC11F975;
        Tue, 31 May 2022 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653993514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HvcditncinzmTgMYfdt0TIwv9F6NSjZGvjIg4D6xtE=;
        b=WGEK0khVXa2/t47RV+bWG0XCY6vS4bXKy8oLscmGAAWF7A4Dnv8/L3gPBf7OUauDL0aIV7
        TUTjF+MRLZfBX0QKnUp4AJHeFnXQQ5nyJUmGYe0DGcy+aXav0dw9tCR04zrHF9FlDTrpyE
        /b7iFcs2iTuHHMdEa2dxjjZPAFF13ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653993514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HvcditncinzmTgMYfdt0TIwv9F6NSjZGvjIg4D6xtE=;
        b=1gYmoWoUdytQiC6FidCdrB2vVgvAasVLIge8Q7ErhVzfRNWilqNCk0QdL1A7fhbNSkMFny
        elgNlYXtwAT9EAAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A88F82C141;
        Tue, 31 May 2022 10:38:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3955DA0633; Tue, 31 May 2022 12:38:34 +0200 (CEST)
Date:   Tue, 31 May 2022 12:38:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, it+linux@molgen.mpg.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
Message-ID: <20220531103834.vhscyk3yzsocorco@quack3.lan>
References: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Late reply but maybe it is still useful :)

On Thu 14-04-22 17:19:49, Donald Buczek wrote:
> We have a cluster scheduler which provides each cluster job with a
> private scratch filesystem (TMPDIR). These are created when a job starts
> and removed when a job completes. The setup works by fallocate, losetup,
> mkfs.ext4, mkdir, mount, "losetup -d", rm and the teardown just does a
> umount and rmdir.
> 
> This works but there is one nuisance: The systems usually have a lot of
> memory and some jobs write a lot of data to their scratch filesystems. So
> when a job finishes, there often is a lot to sync by umount which
> sometimes takes many minutes and wastes a lot of I/O bandwidth.
> Additionally, the reserved space can't be returned and reused until the
> umount is finished and the backing file is deleted.
> 
> So I was looking for a way to avoid that but didn't find something
> straightforward. The workaround I've found so far is using a dm-device
> (linear target) between the filesystem and the loop device and then use
> this sequence for teardown:
> 
> - fcntl EXT4_IOC_SHUTDOWN with EXT4_GOING_FLAGS_NOLOGFLUSH
> - dmestup reload $dmname --table "0 $sectors zero"
> - dmsetup resume $dmname --noflush
> - umount $mountpoint
> - dmsetup remove --deferred $dmname
> - rmdir $mountpoint
> 
> This seems to do what I want. The unnecessary flushing of the temporary data is redirected from the backing file into the zero target and it works really fast. There is one remaining problem though, which might be just a cosmetic one: Although ext4 is shut down to prevent it from writing, I sometimes get the error message from the subject in the logs:
> 
> [2963044.462043] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
> [2963044.686994] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
> [2963044.728391] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
> [2963055.585198] EXT4-fs (dm-2): shut down requested (2)
> [2963064.821246] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
> [2963074.838259] EXT4-fs (dm-2): shut down requested (2)
> [2963095.979089] EXT4-fs (dm-0): shut down requested (2)
> [2963096.066376] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
> [2963108.636648] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
> [2963125.194740] EXT4-fs (dm-0): shut down requested (2)
> [2963166.708088] EXT4-fs (dm-1): shut down requested (2)
> [2963169.334437] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
> [2963227.515974] EXT4-fs (dm-0): shut down requested (2)
> [2966222.515143] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
> [2966222.523390] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
> [2966222.598071] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)

> 
> So I'd like to ask a few questions:
> 
> - Is this error message expected or is it a bug?

Well, shutdown is not 100% tuned for clean teardown. It is mostly a testing
/ debugging aid.

> - Can it be ignored or is there a leak or something on that error path.

The error recovery path should be cleaning up everything. If not, that
would be a bug :)

> - Is there a better way to do what I want? Something I've overlooked?

Why not just rm -rf $mountpoint/*? That will remove all dirty data from
memory without writing it back. It will cost you more in terms of disk IOs
than the above dance with shutdown but unless you have many files, it
should be fast... And it is much more standard path than shutdown :).

> - I consider to create a new dm target or add an option to an existing
> one, because I feel that "zero" underneath a filesystem asks for problems
> because a filesystem expects to read back the data that it wrote, and the
> "error" target would trigger lots of errors during the writeback
> attempts. What I really want is a target which silently discard writes
> and returns errors on reads. Any opinion about that?

> - But to use devicemapper to eat away the I/O is also just a workaround
> to the fact that we can't parse some flag to umount to say that we are
> okay to lose all data and leave the filesystem in a corrupted state if
> this was the last reference to it. Would this be a useful feature?

I think something like this might be useful if the "rm -rf" solution is too
slow. But it is a bit of a niche usecase ;).


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
