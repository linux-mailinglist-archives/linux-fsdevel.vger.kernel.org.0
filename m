Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907B0763C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGZQOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGZQOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8491BDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690388050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WL5UzlACeidu3wr0b3uvqHzNECinmUPyPdtvxBbLLlg=;
        b=RFSDB7fUwoys5tvUOxGDrsXNHz2LzC6b5gbtQZnAKS3j3XshrLbGgeRMfzGZqi36Jb6tAk
        5GMIo4QA++m+TBCbgw0t/9cGGcjVAMSYqQzY6wnTc3jjs5K+CrlNEjx/wJrbqcrum8Hjio
        nAbDxz0YaOOphbNYsxRQWvhoFYfMihs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-FJHKPh2ZO4u8xZh7rvXvvQ-1; Wed, 26 Jul 2023 12:14:08 -0400
X-MC-Unique: FJHKPh2ZO4u8xZh7rvXvvQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765a632f342so817295785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388048; x=1690992848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL5UzlACeidu3wr0b3uvqHzNECinmUPyPdtvxBbLLlg=;
        b=ABuYNwSFedW2ewma/6SYV7ECPZ43zIRcK55HebnJyG6qeTObDZpteXBJXPEGHSJfMm
         YOUwgI+Td8/7BBZzhwsSHlRVGGPbMFyR1u650m/y2JMYzU2X1fVCnixTGyX8ZvqBrrmm
         yTYTJA9R1OZvIJ+DA84/5gRbjFdCfmUsBPoUOl2NTjb9s+3aByYdDDoiqd6UfDps0hZx
         TGqde4VbMP8nWQr92hoi0tPTBkoeLsK+3095Q3avxM3whnT8tTRqNUhWL3Psb7HLfO7d
         Xm18tN2hQrdlVvva8S1uy8IJUaIcg1HhDzTW64LSwK+Qd/w2xLrYhT80Pg8Qv9mD+PLS
         Djqg==
X-Gm-Message-State: ABy/qLbDIKHSIbXKHP2m8P69ksDvdzxUXm6PzNk3qO2UbzNZFm8G8qZd
        RhMVlHPlP+PcxZXKXjF+yccE0yhIYq7DQzF/Op+qikeUXHQPpn2TaRYChs8ECf1qs66KV8N/ZPz
        GklM1FXa898sulFh5M+D9eY3d2Q==
X-Received: by 2002:a05:620a:4089:b0:767:954:a743 with SMTP id f9-20020a05620a408900b007670954a743mr3500636qko.51.1690388047927;
        Wed, 26 Jul 2023 09:14:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfBpqLPPyPIiWG0ac0boS5hjFeMPTr/l8604lcZrWS1ytdXC3hfKwjiOVZf183dDkNAGxAnA==
X-Received: by 2002:a05:620a:4089:b0:767:954:a743 with SMTP id f9-20020a05620a408900b007670954a743mr3500618qko.51.1690388047685;
        Wed, 26 Jul 2023 09:14:07 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id g22-20020a37e216000000b007677f66b160sm4450582qki.124.2023.07.26.09.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:14:07 -0700 (PDT)
Message-ID: <b3c92f88-4fb7-c4ee-e1a2-8f38150d7edd@redhat.com>
Date:   Wed, 26 Jul 2023 11:14:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
To:     syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>,
        agruenba@redhat.com, andersson@kernel.org,
        cluster-devel@redhat.com, dmitry.baryshkov@linaro.org,
        eadavis@sina.com, konrad.dybcio@linaro.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009655cc060165265f@google.com>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <0000000000009655cc060165265f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/23 10:03 AM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 41a37d157a613444c97e8f71a5fb2a21116b70d7
> Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Date:   Mon Dec 26 04:21:51 2022 +0000
> 
>      arm64: dts: qcom: qcs404: use symbol names for PCIe resets
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b48111a80000
> start commit:   [unknown]
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f6a670108ce43356017
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209f878c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111a48ab480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: arm64: dts: qcom: qcs404: use symbol names for PCIe resets
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
The bisect is very likely to be wrong.

I have a lot of patches to gfs2's quota code in linux-gfs2/bobquota that 
I hope to get into the next merge window, but the critical patch has 
already been merged. I'm still working on others.

Regards,

Bob Peterson
gfs2 file system

