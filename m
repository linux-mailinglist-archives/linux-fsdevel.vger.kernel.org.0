Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD374A089
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGFPMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:12:48 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D7FC;
        Thu,  6 Jul 2023 08:12:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vml4Kei_1688656357;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vml4Kei_1688656357)
          by smtp.aliyun-inc.com;
          Thu, 06 Jul 2023 23:12:39 +0800
Message-ID: <4949c20e-177f-7952-7870-41f3b3fd791f@linux.alibaba.com>
Date:   Thu, 6 Jul 2023 23:12:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
To:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-37-jlayton@kernel.org>
 <20230706110007.dc4tpyt5e6wxi5pt@quack3>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On 2023/7/6 19:00, Jan Kara wrote:
> On Wed 05-07-23 15:01:04, Jeff Layton wrote:
>> In later patches, we're going to change how the inode's ctime field is
>> used. Switch to using accessor functions instead of raw accesses of
>> inode->i_ctime.
>>
>> Acked-by: Gao Xiang <xiang@kernel.org>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> Just one nit below:
> 
>> @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>   		vi->chunkbits = sb->s_blocksize_bits +
>>   			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>>   	}
>> -	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
>> -	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
>> -	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
>> -	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
>> +	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
>> +	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
>> +	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
>> +	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;
> 
> Isn't this just longer way to write:
> 
> 	inode->i_atime = inode->i_mtime = inode_get_ctime(inode);

I'm fine with this.  I think we could use this (although I'm not sure
if checkpatch will complain but personally I'm fine.)

Thanks,
Gao Xiang

> 
> ?
> 
> 								Honza
