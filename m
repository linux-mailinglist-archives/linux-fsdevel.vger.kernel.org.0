Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FD5B33E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIIJ27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIIJ2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:28:17 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4ADF29;
        Fri,  9 Sep 2022 02:26:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VP9-qIZ_1662715615;
Received: from 30.221.130.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VP9-qIZ_1662715615)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:26:56 +0800
Message-ID: <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
Date:   Fri, 9 Sep 2022 17:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 3/5] erofs: add 'domain_id' prefix when register sysfs
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-4-zhujia.zj@bytedance.com>
 <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
In-Reply-To: <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/9/22 5:23 PM, JeffleXu wrote:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> In shared domain mount procedure, add 'domain_id' prefix to register
>> sysfs entry. Thus we could distinguish mounts that don't use shared
>> domain.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>  fs/erofs/sysfs.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index c1383e508bbe..c0031d7bd817 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
>>  int erofs_register_sysfs(struct super_block *sb)
>>  {
>>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	char *name = NULL;
>>  	int err;
>>  
>> +	if (erofs_is_fscache_mode(sb)) {
>> +		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
>> +				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
>> +				sbi->opt.fsid);
>> +		if (!name)
>> +			return -ENOMEM;
>> +	}
> 
> 
> How about:
> 
> name = erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id;
> if (sbi->opt.domain_id) {
> 	str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
> 	name = str;
> }

Another choice:

if (erofs_is_fscache_mode(sb)) {
	if (sbi->opt.domain_id) {
		str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
		name = str;
	} else {
		name = sbi->opt.fsid;
	}
} else {
	name = sb->s_id;
}




> 
> 
>>  	sbi->s_kobj.kset = &erofs_root;
>>  	init_completion(&sbi->s_kobj_unregister);
>>  	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
>> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>> +			name ? name : sb->s_id);
> 
> 	kobject_init_and_add(..., "%s", name);
> 	kfree(str);
> 
> though it's still not such straightforward...
> 
> Any better idea?
> 
> 
>> +	kfree(name);
>>  	if (err)
>>  		goto put_sb_kobj;
>>  	return 0;
> 

-- 
Thanks,
Jingbo
