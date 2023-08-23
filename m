Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DE785685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHWLMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjHWLMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:12:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108071A5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 04:12:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a2e59cf85so3088882b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692789166; x=1693393966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l/C/Em55hDWEZsHiOtUwvmf9bvizEENoPNvEct/EfI=;
        b=KP1ChHFNfM0e8toOlV+hECyU3u1mwZA4fCDAIuIBoDsCINkYYwUNx/uyNtnzVS1X+W
         tLlWGrw4f31BtIWSLy/MKwD2LysTeZPQjA/pvFNsf4aOGaM2IiJuIx6O8vmDU48DTSeR
         aWmZwfKSZy8U5Nh/LRsbJvk7BdR8IE8HWUiPt3xWoyH9dH0psaU9LfYkVVMyLtqX6lEw
         En7Yz8R7yFeGrv1l0UxpDPS5An2HvGCgplhkvNEZ3w1ILVNL/DQSEMxbtTqLS3F0+gqk
         exBdyVgu/fMj9G7MQym2TQ1KNBlSOsYu30fxLGZC13pgE6zCjt/8oL4uO9nCN7o/tgDq
         hLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789166; x=1693393966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9l/C/Em55hDWEZsHiOtUwvmf9bvizEENoPNvEct/EfI=;
        b=YirzGl1HElQqSFZKT1gh+QbFZ7qBzpPGWC9WB6DAhUgyvw4Gkj7qjSgfmH4uBqebyb
         XMpjN58x40bLUc/feooiBbWKviKfPN3DzIxygaRghttnRD0hE2j1tbH+pPbCkBSGeEbK
         TmGiXISY9QZh3QX6yzIT1MHrQK6w54rvejqY53bWPS8WsxmGrF2eZ6zr+hJ0otZfPNmg
         VSnE/yq33lQCiREpM8RiHkk+E8FYKO203pcwhGHSTrC6cVRUjQmTPzRsk36SZs62Bgcq
         yp+6AisSjjSzqj+BJwoJdm7iJNvy7DTWNq650ekwdOB/nWuw/IvaQa6YFN99BgMsEDAE
         iwng==
X-Gm-Message-State: AOJu0Yz/oH6A0+e5I3j71iwPB7BerdEcjqUPo26Zspup61P7j9BFmQT3
        IRrVTm0mF+BGpTukrIe/sDlsTQ==
X-Google-Smtp-Source: AGHT+IH6qjCXnJXfdTQcWKr9U/NGAmqaIa6a51NYKXyh+nsa4CDocmJi35FlCNTOYm6GU3g0v8EN1g==
X-Received: by 2002:a05:6a21:3d8b:b0:132:ef90:1d1d with SMTP id bj11-20020a056a213d8b00b00132ef901d1dmr13871845pzc.0.1692789166350;
        Wed, 23 Aug 2023 04:12:46 -0700 (PDT)
Received: from [10.255.208.99] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001bb99e188fcsm10702619plg.194.2023.08.23.04.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 04:12:45 -0700 (PDT)
Message-ID: <446c65f1-e5e9-4f99-467f-a64654bcf131@bytedance.com>
Date:   Wed, 23 Aug 2023 19:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/5] fuse: add FOPEN_INVAL_ATTR
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
 <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
 <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/23 17:01, Miklos Szeredi wrote:
> On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
>>
>> Add FOPEN_INVAL_ATTR so that the fuse daemon can ask kernel to invalidate
>> the attr cache on file open.
>>
>> The fi->attr_version should be increased when handling FOPEN_INVAL_ATTR.
>> Because if a FUSE request returning attributes (getattr, setattr, lookup,
>> and readdirplus) starts before a FUSE_OPEN replying FOPEN_INVAL_ATTR, but
>> finishes after the FUSE_OPEN, staled attributes will be set to the inode
>> and falsely clears the inval_mask.
>>
>> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>> ---
>>   fs/fuse/file.c            | 10 ++++++++++
>>   include/uapi/linux/fuse.h |  2 ++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index de37a3a06a71..412824a11b7b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -215,6 +215,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>>                  file_update_time(file);
>>                  fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>>          }
>> +
>> +       if (ff->open_flags & FOPEN_INVAL_ATTR) {
>> +               struct fuse_inode *fi = get_fuse_inode(inode);
>> +
>> +               spin_lock(&fi->lock);
>> +               fi->attr_version = atomic64_inc_return(&fc->attr_version);
> 
> No need to add locking or change fi->attr_version.  This will be done
> next time the attributes are updated.
> 
> Thanks,
> Miklos

Hi Miklos,

Thanks for the review! As said in the commit message, increasing the
attr version here is to prevent the attr updated by staled operations. 
If such cases happen, inval_mask will be falsely cleared, and 
FOPEN_INVAL_ATTR takes no effect from the user's point of view.

The increasing of attr_version here can also be explained as the
attr has been updated from the server side.

Thanks,
Jiachen
