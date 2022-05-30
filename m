Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0653253869C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiE3RLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiE3RL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 13:11:28 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13652E77;
        Mon, 30 May 2022 10:11:27 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F329C1F86;
        Mon, 30 May 2022 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653930655;
        bh=8VawmhTG+GHXT/MqMClG55CYn/p1qfgGoNeayV4I14I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FppLj4+tXN0lfjH0ZLbXyWZlpqsHu4M6HQkX8W5yhH79I9PSoeMTVxIYzm7xlCOss
         Rc4HfZIOf62fcCL9mateBBiSLrBMMeULR1cvY3KU99IDX/gdXOgZLPS/9oAKXBuZ0Y
         pSMhTGFE25hCSX83f5CSwiCOKd6+hfqLO84cYQlw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 20:11:24 +0300
Message-ID: <075d601a-1d79-acbd-2d03-92a1a73cf9c7@paragon-software.com>
Date:   Mon, 30 May 2022 20:11:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] fs/ntfs3: Refactoring of indx_find function
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
 <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
 <94dd870e498e89e0998dee4dd0dbaaa4b4497929.camel@perches.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <94dd870e498e89e0998dee4dd0dbaaa4b4497929.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

Thanks for your input.
It's nice to have a clear typical return value, so I've updated patch.


On 5/27/22 19:07, Joe Perches wrote:
> On Fri, 2022-05-27 at 17:21 +0300, Almaz Alexandrovich wrote:
>> This commit makes function a bit more readable
> 
> trivia:
> 
>> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> []
>> @@ -1042,19 +1042,16 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
>>    {
>>    	int err;
>>    	struct NTFS_DE *e;
>> -	const struct INDEX_HDR *hdr;
>>    	struct indx_node *node;
>>    
>>    	if (!root)
>>    		root = indx_get_root(&ni->dir, ni, NULL, NULL);
>>    
>>    	if (!root) {
>> -		err = -EINVAL;
>> -		goto out;
>> +		/* Should not happed. */
>> +		return -EINVAL;
> 
> s/happed/happen/
> 
>>    	for (;;) {
>>    		node = NULL;
>>    		if (*diff >= 0 || !de_has_vcn_ex(e)) {
>>    			*entry = e;
>> -			goto out;
>> +			return 0;
>>    		}
> 
> might be nicer with a break; or a while like
> 
> 	while (*diff < 0 && de_has_vcn_ex(e)) {
> 		node = NULL;
> 
> 
>>    		/* Read next level. */
>>    		err = indx_read(indx, ni, de_get_vbn(e), &node);
>>    		if (err)
>> -			goto out;
>> +			return err;
>>    
>>    		/* Lookup entry that is <= to the search value. */
>>    		e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
>>    			       diff);
>>    		if (!e) {
>> -			err = -EINVAL;
>>    			put_indx_node(node);
>> -			goto out;
>> +			return -EINVAL;
>>    		}
>>    
>>    		fnd_push(fnd, node, e);
>>    	}
>> -
>> -out:
>> -	return err;
> 
> and a return 0;
> 
> or
> 	*entry = e;
> 	return 0;
> 
> so it appears that the function has a typical return value.
> 
