Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171BB633E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiKVNym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 08:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiKVNyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:54:40 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B156654EB;
        Tue, 22 Nov 2022 05:54:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VVSj4Yo_1669125271;
Received: from 30.32.119.53(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VVSj4Yo_1669125271)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 21:54:33 +0800
Message-ID: <9cc55d4f-d864-aca5-78a0-ea7602c35176@linux.alibaba.com>
Date:   Tue, 22 Nov 2022 21:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
References: <20221120210004.381842-1-jlayton@kernel.org>
 <0c6a44ff-409e-99b2-eaa9-fd6e87a9e104@linux.alibaba.com>
 <a731e688122d1a6fdb2f7bdbd71d403fa110e9f2.camel@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <a731e688122d1a6fdb2f7bdbd71d403fa110e9f2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/22/22 8:20 PM, Jeff Layton wrote:
> On Tue, 2022-11-22 at 09:51 +0800, Joseph Qi wrote:
>> Hi,
>>
>> On 11/21/22 4:59 AM, Jeff Layton wrote:
>>> The file locking definitions have lived in fs.h since the dawn of time,
>>> but they are only used by a small subset of the source files that
>>> include it.
>>>
>>> Move the file locking definitions to a new header file, and add the
>>> appropriate #include directives to the source files that need them. By
>>> doing this we trim down fs.h a bit and limit the amount of rebuilding
>>> that has to be done when we make changes to the file locking APIs.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/9p/vfs_file.c          |   1 +
>>>  fs/afs/internal.h         |   1 +
>>>  fs/attr.c                 |   1 +
>>>  fs/ceph/locks.c           |   1 +
>>>  fs/cifs/cifsfs.c          |   1 +
>>>  fs/cifs/cifsglob.h        |   1 +
>>>  fs/cifs/cifssmb.c         |   1 +
>>>  fs/cifs/file.c            |   1 +
>>>  fs/cifs/smb2file.c        |   1 +
>>>  fs/dlm/plock.c            |   1 +
>>>  fs/fcntl.c                |   1 +
>>>  fs/file_table.c           |   1 +
>>>  fs/fuse/file.c            |   1 +
>>>  fs/gfs2/file.c            |   1 +
>>>  fs/inode.c                |   1 +
>>>  fs/ksmbd/smb2pdu.c        |   1 +
>>>  fs/ksmbd/vfs.c            |   1 +
>>>  fs/ksmbd/vfs_cache.c      |   1 +
>>>  fs/lockd/clntproc.c       |   1 +
>>>  fs/lockd/netns.h          |   1 +
>>>  fs/locks.c                |   1 +
>>>  fs/namei.c                |   1 +
>>>  fs/nfs/nfs4_fs.h          |   1 +
>>>  fs/nfs_common/grace.c     |   1 +
>>>  fs/nfsd/netns.h           |   1 +
>>>  fs/ocfs2/locks.c          |   1 +
>>>  fs/ocfs2/stack_user.c     |   1 +
>>
>> Seems it misses the related changes in:
>> fs/ocfs2/stackglue.c
>>
> 
> I was able to build ocfs2.ko just fine without any changes to
> stackglue.c. What problem do you see here?
> 
Okay, that's because there is prototype declaration in
fs/ocfs2/stackglue.h, and it seems has no real effect in current
version.

So it looks good to me. For ocfs2 part,
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
