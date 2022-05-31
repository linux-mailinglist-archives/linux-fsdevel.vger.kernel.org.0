Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA905391FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbiEaNsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiEaNsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 09:48:16 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CB26D4;
        Tue, 31 May 2022 06:48:13 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0CE5C61EA1928;
        Tue, 31 May 2022 15:48:11 +0200 (CEST)
Subject: Re: ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, it+linux@molgen.mpg.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
 <20220531103834.vhscyk3yzsocorco@quack3.lan>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <3bfd0ad9-d378-9631-310f-0a1a80d8e482@molgen.mpg.de>
Date:   Tue, 31 May 2022 15:48:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220531103834.vhscyk3yzsocorco@quack3.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/22 12:38 PM, Jan Kara wrote:
> Late reply but maybe it is still useful :)

That's very welcome!

> On Thu 14-04-22 17:19:49, Donald Buczek wrote:
>> We have a cluster scheduler which provides each cluster job with a
>> private scratch filesystem (TMPDIR). These are created when a job starts
>> and removed when a job completes. The setup works by fallocate, losetup,
>> mkfs.ext4, mkdir, mount, "losetup -d", rm and the teardown just does a
>> umount and rmdir.
>>
>> This works but there is one nuisance: The systems usually have a lot of
>> memory and some jobs write a lot of data to their scratch filesystems. So
>> when a job finishes, there often is a lot to sync by umount which
>> sometimes takes many minutes and wastes a lot of I/O bandwidth.
>> Additionally, the reserved space can't be returned and reused until the
>> umount is finished and the backing file is deleted.
>>
>> So I was looking for a way to avoid that but didn't find something
>> straightforward. The workaround I've found so far is using a dm-device
>> (linear target) between the filesystem and the loop device and then use
>> this sequence for teardown:
>>
>> - fcntl EXT4_IOC_SHUTDOWN with EXT4_GOING_FLAGS_NOLOGFLUSH
>> - dmestup reload $dmname --table "0 $sectors zero"
>> - dmsetup resume $dmname --noflush
>> - umount $mountpoint
>> - dmsetup remove --deferred $dmname
>> - rmdir $mountpoint
>>
>> This seems to do what I want. The unnecessary flushing of the temporary data is redirected from the backing file into the zero target and it works really fast. There is one remaining problem though, which might be just a cosmetic one: Although ext4 is shut down to prevent it from writing, I sometimes get the error message from the subject in the logs:
>>
>> [2963044.462043] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
>> [2963044.686994] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
>> [2963044.728391] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
>> [2963055.585198] EXT4-fs (dm-2): shut down requested (2)
>> [2963064.821246] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
>> [2963074.838259] EXT4-fs (dm-2): shut down requested (2)
>> [2963095.979089] EXT4-fs (dm-0): shut down requested (2)
>> [2963096.066376] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
>> [2963108.636648] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
>> [2963125.194740] EXT4-fs (dm-0): shut down requested (2)
>> [2963166.708088] EXT4-fs (dm-1): shut down requested (2)
>> [2963169.334437] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
>> [2963227.515974] EXT4-fs (dm-0): shut down requested (2)
>> [2966222.515143] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null)
>> [2966222.523390] EXT4-fs (dm-1): mounted filesystem without journal. Opts: (null)
>> [2966222.598071] EXT4-fs (dm-2): mounted filesystem without journal. Opts: (null)
> 
>>
>> So I'd like to ask a few questions:
>>
>> - Is this error message expected or is it a bug?
> 
> Well, shutdown is not 100% tuned for clean teardown. It is mostly a testing
> / debugging aid.
> 
>> - Can it be ignored or is there a leak or something on that error path.
> 
> The error recovery path should be cleaning up everything. If not, that
> would be a bug :)
> 
>> - Is there a better way to do what I want? Something I've overlooked?
> 
> Why not just rm -rf $mountpoint/*? That will remove all dirty data from
> memory without writing it back. It will cost you more in terms of disk IOs
> than the above dance with shutdown but unless you have many files, it
> should be fast... And it is much more standard path than shutdown :).

This is in fact what we are doing now, after I've rejected the above solution
because of the fear of a leak on the probably not so well tested error path.

You answer encourages me to maybe just try it. The problem is, that if a few pages
or inodes keep hanging around only occasionally, the systems would probably need month
and month until this manifest as a problem. So I'd never know when to declare the
test as finished and trust the solution.

The "rm -r" does help a bit but not as much as I've hoped. It might take half
the time for some workloads but it is still in the same order of magnitude
for typical loads.

>> - I consider to create a new dm target or add an option to an existing
>> one, because I feel that "zero" underneath a filesystem asks for problems
>> because a filesystem expects to read back the data that it wrote, and the
>> "error" target would trigger lots of errors during the writeback
>> attempts. What I really want is a target which silently discard writes
>> and returns errors on reads. Any opinion about that?
>
>> - But to use devicemapper to eat away the I/O is also just a workaround
>> to the fact that we can't parse some flag to umount to say that we are
>> okay to lose all data and leave the filesystem in a corrupted state if
>> this was the last reference to it. Would this be a useful feature?
> 
> I think something like this might be useful if the "rm -rf" solution is too
> slow. But it is a bit of a niche usecase ;).

I've abandoned the "dm"-path as well, more or less for the same reason:
This would trigger seldom used error paths in the filesystem.

Aside from the already mentioned one, I could think of others usecases:

- You've already unplugged a removable drive. Whatever happened to the data on
the device already happened and you just want to make sure, the system releases
all resources.

- Anything which uses file system images where the final state of the image
doesn't need to be kept (build systems, test systems).

Another idea I've had is to add a ioctl for the block layer which just undirtyes all
pages which go to that backing device. It would help for file data only, not for
the metadata, but I guess that would be enough. I wouldn't need to mess with the
layer under the filesystem. Good idea or bad idea?

But I have the feeling this would be complicated taking all the required locking
and possible in-flight states into account. This could well be over my level. And
it would never be accepted upstream, so I'd need to forward-port that forever.


Thanks!

   Donald

> 								Honza


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
