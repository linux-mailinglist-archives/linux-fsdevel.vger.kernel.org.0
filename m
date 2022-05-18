Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646B152AF94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 03:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiERBD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiERBDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 21:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89A5E5401B
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 18:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652835833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9x2ImgRb6JiiWOcKdqNJTdgrbDsN6gv1+sN/DiujmeI=;
        b=VoMJzxwHPwngm0jlfImQm8UMOEoIpgOCmJxyTxdGsH3ov5WXow+k9QoDC3+D7MiR+FJzmJ
        DzkcSE9HcrvKIHPGh+5M6ZPxUTg04oWGzx2UmUBdHETtiguCn2DfZ7NGEg2geZzu1t6+2U
        EenJIIQA8LIKOO5ScPang+HAmabU7Ls=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-5RtiGhFrOlulsjABpZpg9Q-1; Tue, 17 May 2022 21:03:52 -0400
X-MC-Unique: 5RtiGhFrOlulsjABpZpg9Q-1
Received: by mail-pj1-f69.google.com with SMTP id y2-20020a17090a474200b001dead634389so193759pjg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 18:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9x2ImgRb6JiiWOcKdqNJTdgrbDsN6gv1+sN/DiujmeI=;
        b=3obmLRT0UcxXcaj2C0htQxjAv0hm4I3X7welrm65j2y1Czc1IdOPzxRn14vTKpXPEX
         zEJISBMt7BSuFO5gPbSIVBukkApnCxZeK2x4t8pjPbTDPF7Tmpv4w9A+C7dmXLaCfmhq
         hJsxYTlMfTy1j3PPhr1nnscXmSYUHIAjQD5JbTpt2uz3LfApTP9lHIrHK3RaU5Avmxrg
         c+4Mxuf9PqKFO4Wrw6sl8UtJZtRLwDFomL9Z7FOr1gqvNK/S2ny0UGeleiciN1Wyci83
         dNesVllDaPR2kPwKgd+yz16UsEhn3CbrYxDXtgWxAXtpUlfk7Yfg5k28VuxGlCudIHcP
         gv2Q==
X-Gm-Message-State: AOAM533/6lM4tAl+Ffe+L1Kfwy65HCSYn2t23/6UC0XVA16tZShp8K6g
        NCtInVaiIrIh809pgTiKT1PEnhp4sOagJJbdkRAfiwvnaLaB8D25/KgRCT9triKrC6bRlQf3Kwj
        8Tz2YIvDw7HyN2VdJRA+Aj3qWuQ==
X-Received: by 2002:a63:1d42:0:b0:3ed:6b3d:c52d with SMTP id d2-20020a631d42000000b003ed6b3dc52dmr16746022pgm.295.1652835831203;
        Tue, 17 May 2022 18:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyppbvBjtek7vEiI0QwxGuQYIG67ZQO++TbEncsJOLajE9N12wwbpkr93VWwAtchDRR3dKYog==
X-Received: by 2002:a63:1d42:0:b0:3ed:6b3d:c52d with SMTP id d2-20020a631d42000000b003ed6b3dc52dmr16745999pgm.295.1652835830931;
        Tue, 17 May 2022 18:03:50 -0700 (PDT)
Received: from [10.72.12.136] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b0015e8d4eb1besm246751plo.8.2022.05.17.18.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 18:03:25 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] ceph: wait the first reply of inflight async
 unlink
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, viro@zeniv.linux.org.uk, idryomov@gmail.com,
        vshankar@redhat.com, ceph-devel@vger.kernel.org,
        dchinner@redhat.com, hch@lst.de, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220517125549.148429-1-xiubli@redhat.com>
 <20220517125549.148429-3-xiubli@redhat.com>
 <YoOy40sGQv4DjmAq@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <acf2457a-a984-d490-2833-be7cfd25c729@redhat.com>
Date:   Wed, 18 May 2022 09:03:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YoOy40sGQv4DjmAq@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/17/22 10:36 PM, Matthew Wilcox wrote:
> On Tue, May 17, 2022 at 08:55:49PM +0800, Xiubo Li wrote:
>> +int ceph_wait_on_conflict_unlink(struct dentry *dentry)
>> +{
>> +	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
>> +	struct dentry *pdentry = dentry->d_parent;
>> +	struct dentry *udentry, *found = NULL;
>> +	struct ceph_dentry_info *di;
>> +	struct qstr dname;
>> +	u32 hash = dentry->d_name.hash;
>> +	int err;
>> +
>> +	dname.name = dentry->d_name.name;
>> +	dname.len = dentry->d_name.len;
>> +
>> +	rcu_read_lock();
>> +	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
>> +				   hnode, hash) {
>> +		udentry = di->dentry;
>> +
>> +		spin_lock(&udentry->d_lock);
>> +		if (udentry->d_name.hash != hash)
>> +			goto next;
>> +		if (unlikely(udentry->d_parent != pdentry))
>> +			goto next;
>> +		if (!hash_hashed(&di->hnode))
>> +			goto next;
>> +
>> +		if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
>> +			pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
>> +				__func__, dentry, dentry);
>> +
>> +		if (d_compare(pdentry, udentry, &dname))
>> +			goto next;
>> +
>> +		spin_unlock(&udentry->d_lock);
>> +		found = dget(udentry);
>> +		break;
>> +next:
>> +		spin_unlock(&udentry->d_lock);
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	if (likely(!found))
>> +		return 0;
>> +
>> +	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
>> +	     dentry, dentry, found, found);
>> +
>> +	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
>> +			  TASK_INTERRUPTIBLE);
> Do you really want to use TASK_INTERRUPTIBLE here?  If the window is
> resized and you get a SIGWINCH, or a timer goes off and you get a
> SIGALRM, you want to return -EINTR?  I would suggest that TASK_KILLABLE
> is probably the semantics that you want.
>
Sounds reasonable.  I will switch to use the TASK_KILLABLE.

@Jeff

I just copied this code from ceph_wait_on_async_create(). BTW, do we 
have any other consideration that we must use the TASK_INTERRUPTIBLE there ?

Thanks.

-- Xiubo

