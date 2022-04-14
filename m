Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AC501838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiDNQGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349882AbiDNPkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:19 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F01EAF3;
        Thu, 14 Apr 2022 08:19:51 -0700 (PDT)
Received: from [192.168.0.175] (ip5f5aed13.dynamic.kabel-deutschland.de [95.90.237.19])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36EBE61EA1928;
        Thu, 14 Apr 2022 17:19:50 +0200 (CEST)
Message-ID: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
Date:   Thu, 14 Apr 2022 17:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     it+linux@molgen.mpg.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Donald Buczek <buczek@molgen.mpg.de>
Subject: ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a cluster scheduler which provides each cluster job with a private scratch filesystem (TMPDIR). These are created when a job starts and removed when a job completes. The setup works by fallocate, losetup, mkfs.ext4, mkdir, mount, "losetup -d", rm and the teardown just does a umount and rmdir.

This works but there is one nuisance: The systems usually have a lot of memory and some jobs write a lot of data to their scratch filesystems. So when a job finishes, there often is a lot to sync by umount which sometimes takes many minutes and wastes a lot of I/O bandwidth. Additionally, the reserved space can't be returned and reused until the umount is finished and the backing file is deleted.

So I was looking for a way to avoid that but didn't find something straightforward. The workaround I've found so far is using a dm-device (linear target) between the filesystem and the loop device and then use this sequence for teardown:

- fcntl EXT4_IOC_SHUTDOWN with EXT4_GOING_FLAGS_NOLOGFLUSH
- dmestup reload $dmname --table "0 $sectors zero"
- dmsetup resume $dmname --noflush
- umount $mountpoint
- dmsetup remove --deferred $dmname
- rmdir $mountpoint

This seems to do what I want. The unnecessary flushing of the temporary data is redirected from the backing file into the zero target and it works really fast. There is one remaining problem though, which might be just a cosmetic one: Although ext4 is shut down to prevent it from writing, I sometimes get the error message from the subject in the logs:

[2963044.462043] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
[2963044.686994] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
[2963044.728391] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
[2963055.585198] EXT4-fs (dm-2): shut down requested (2)
[2963064.821246] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
[2963074.838259] EXT4-fs (dm-2): shut down requested (2)
[2963095.979089] EXT4-fs (dm-0): shut down requested (2)
[2963096.066376] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
[2963108.636648] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
[2963125.194740] EXT4-fs (dm-0): shut down requested (2)
[2963166.708088] EXT4-fs (dm-1): shut down requested (2)
[2963169.334437] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
[2963227.515974] EXT4-fs (dm-0): shut down requested (2)
[2966222.515143] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
[2966222.523390] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
[2966222.598071] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)

So I'd like to ask a few questions:

- Is this error message expected or is it a bug?
- Can it be ignored or is there a leak or something on that error path.
- Is there a better way to do what I want? Something I've overlooked?
- I consider to create a new dm target or add an option to an existing one, because I feel that "zero" underneath a filesystem asks for problems because a filesystem expects to read back the data that it wrote, and the "error" target would trigger lots of errors during the writeback attempts. What I really want is a target which silently discard writes and returns errors on reads. Any opinion about that?
- But to use devicemapper to eat away the I/O is also just a workaround to the fact that we can't parse some flag to umount to say that we are okay to lose all data and leave the filesystem in a corrupted state if this was the last reference to it. Would this be a useful feature?

Best
   Donald
-- 
Donald Buczek
buczek@molgen.mpg.de
