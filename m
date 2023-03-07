Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E36AD985
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCGIs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCGIs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:48:56 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB47199E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 00:48:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VdKkhxZ_1678178928;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdKkhxZ_1678178928)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 16:48:49 +0800
Message-ID: <e2ebe992-4463-1c1e-2653-1c045b71e88d@linux.alibaba.com>
Date:   Tue, 7 Mar 2023 16:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
 <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
 <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
In-Reply-To: <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/7 16:33, Gao Xiang wrote:
> 
> 
> On 2023/3/7 16:21, Alexander Larsson wrote:
>> On Mon, Mar 6, 2023 at 5:17 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>>>> I tested the performance of "ls -lR" on the whole tree of
>>>>> cs9-developer-rootfs.  It seems that the performance of erofs (generated
>>>>> from mkfs.erofs) is slightly better than that of composefs.  While the
>>>>> performance of erofs generated from mkfs.composefs is slightly worse
>>>>> that that of composefs.
>>>>
>>>> I suspect that the reason for the lower performance of mkfs.composefs
>>>> is the added overlay.fs-verity xattr to all the files. It makes the
>>>> image larger, and that means more i/o.
>>>
>>> Actually you could move overlay.fs-verity to EROFS shared xattr area (or
>>> even overlay.redirect but it depends) if needed, which could save some
>>> I/Os for your workloads.
>>>
>>> shared xattrs can be used in this way as well if you care such minor
>>> difference, actually I think inlined xattrs for your workload are just
>>> meaningful for selinux labels and capabilities.
>>
>> Really? Could you expand on this, because I would think it will be
>> sort of the opposite. In my usecase, the erofs fs will be read by
>> overlayfs, which will probably access overlay.* pretty often.  At the
>> very least it will load overlay.metacopy and overlay.redirect for
>> every lookup.
> 
> Really.  In that way, it will behave much similiar to composefs on-disk
> arrangement now (in composefs vdata area).
> 
> Because in that way, although an extra I/O is needed for verification,
> and it can only happen when actually opening the file (so "ls -lR" is
> not impacted.) But on-disk inodes are more compact.
> 
> All EROFS xattrs will be cached in memory so that accessing

    ^ all accessed xattrs in EROFS

Sorry about that if there could be some misunderstanding.

> overlay.* pretty often is not greatly impacted due to no real I/Os
> (IOWs, only some CPU time is consumed).
> 
>>
>> I guess it depends on how the verity support in overlayfs would work.
>> If it delays access to overlay.verity until open time, then it would
>> make sense to move it to the shared area.
> 
> I think it could be just like what composefs does, it's not hard to
> add just new dozen lines to overlayfs like:
> 
> static int cfs_open_file(struct inode *inode, struct file *file)
> {
> ...
>      /* If metadata records a digest for the file, ensure it is there
>       * and correct before using the contents.
>       */
>      if (cino->inode_data.has_digest &&
>          fsi->verity_check >= CFS_VERITY_CHECK_IF_SPECIFIED) {
>          ...
> 
>          res = fsverity_get_digest(d_inode(backing_dentry),
>                        verity_digest, &verity_algo);
>          if (res < 0) {
>              pr_warn("WARNING: composefs backing file '%pd' has no fs-verity digest\n",
>                  backing_dentry);
>              return -EIO;
>          }
>          if (verity_algo != HASH_ALGO_SHA256 ||
>              memcmp(cino->inode_data.digest, verity_digest,
>                 SHA256_DIGEST_SIZE) != 0) {
>              pr_warn("WARNING: composefs backing file '%pd' has the wrong fs-verity digest\n",
>                  backing_dentry);
>              return -EIO;
>          }
>          ...
>      }
> ...
> }
> 
> Is this stacked fsverity feature really hard?
> 
> Thanks,
> Gao Xiang
> 
>>
