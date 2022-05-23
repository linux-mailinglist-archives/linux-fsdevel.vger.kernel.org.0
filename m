Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7953071A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbiEWBXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiEWBXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 21:23:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCCDFA5;
        Sun, 22 May 2022 18:23:34 -0700 (PDT)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L60185yqszgYCD;
        Mon, 23 May 2022 09:22:04 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 09:23:32 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 09:23:31 +0800
Message-ID: <6d9ca4b4-95f4-6bd5-33fe-e111a44ad280@huawei.com>
Date:   Mon, 23 May 2022 09:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH -next] fuse: return the more nuanced writeback error on
 close()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20220518145729.2488102-1-chenxiaosong2@huawei.com>
 <YoUIDcOmfJ5lppu3@zeniv-ca.linux.org.uk>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <YoUIDcOmfJ5lppu3@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/5/18 22:51, Al Viro 写道:
> On Wed, May 18, 2022 at 10:57:29PM +0800, ChenXiaoSong wrote:
> 
>> +	/* return more nuanced writeback errors */
>>   	if (err)
>> -		return err;
>> +		return filemap_check_wb_err(file->f_mapping, 0);
>>   
>>   	err = 0;
> 
> As an aside, what the hell is that err = 0 about?  Before or after
> that patch, that is - "let's make err zero, in case it had somehow
> magically changed ceased to be so since if (err) bugger_off just above"?
> 
> .
> 
err = 0 is no longer needed after if (err), I will send v2 patch to 
remove the redundant code.
