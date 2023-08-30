Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC378DA9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjH3Sgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbjH3M4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC96185
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693400151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gj/kkqvSdBg9gM5suDHTT489MFnXm9/ZuicaQfNNO8=;
        b=gV0IejqFPwpStIz3h9tTxYRymSUU+WqvHHTzdP5ionH7rPnGH8Es8lGUCsgoMcp1DS3e37
        OnYbYcJyKuZ7Z0AwljHw1eLU8s8FntzvKzTPvSeb+Beao6OoSiNKjnDboHgKMo9GKvjJAi
        luveaYWGTwTmKVBNke4rFGU1WJzm89w=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-u5K3rIi5NbyWT_QGd5PolQ-1; Wed, 30 Aug 2023 08:55:49 -0400
X-MC-Unique: u5K3rIi5NbyWT_QGd5PolQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68bec515fa9so6766172b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400148; x=1694004948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gj/kkqvSdBg9gM5suDHTT489MFnXm9/ZuicaQfNNO8=;
        b=MP0nPSZl/IlgbX7C5xZZtf4y+jrQTzJFUFLwJNJoXeqBKPVzonP0W2V15nS+0mnVkc
         9B5EDYJt6KvyNzGIUMsQX9tXZ/sxe1sWzeXDN+VLloyWAYoVkUYvqjO+J6LylusIZF0B
         9Stc/lTrNxcnzNIesalnvGuHZ62GRNe/S6Qi7om1BJfwwbCWXplaiIHszfpM4vP5DWq1
         F4aBY3LuTw8KTrdzLyZmMr6WtwzDHrG3aTYIxWeE/Sm4yJA1hnSknpAjk7XXtULn5/zj
         joskvEl36iWkQz7Gfqc+aWYNWJm64DXr5dTtPTubh0wvNTDRL1f+71V+0924SD2ttoXo
         FguQ==
X-Gm-Message-State: AOJu0YxaxULsTd1HmroObQgsalrJVeIeXLkly+I9OWvJS+6cZzReR5qM
        kYWicxWPYh6JSJZP/GFH09Fb3VVvbgdUyK4R4e6zcKe/nQa0ewz0N2Rs71/nNiMrOLu3yzQn+F2
        +TzjAMjwrCR6GVpdYXHWu7v0HpQ==
X-Received: by 2002:a05:6a00:1393:b0:68c:57c7:1eb0 with SMTP id t19-20020a056a00139300b0068c57c71eb0mr2442350pfg.11.1693400148619;
        Wed, 30 Aug 2023 05:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4YJ5wmCeyn5temyXgtN3k4eROEzFKu80i/MWNBecBpVdA9/skK+WmoR79XsCIkWrmc56ang==
X-Received: by 2002:a05:6a00:1393:b0:68c:57c7:1eb0 with SMTP id t19-20020a056a00139300b0068c57c71eb0mr2442339pfg.11.1693400148367;
        Wed, 30 Aug 2023 05:55:48 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ey20-20020a056a0038d400b006877ec47f82sm10094700pfb.66.2023.08.30.05.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:55:47 -0700 (PDT)
Date:   Wed, 30 Aug 2023 20:55:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yongcheng Yang <yoyang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v3 2/2] generic/578: add a check to ensure that
 fiemap is supported
Message-ID: <20230830125544.chmzf5trejj4tppz@zlang-mailbox>
References: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
 <20230825-fixes-v3-2-6484c098f8e8@kernel.org>
 <ZO6vh5+ZLdLSFbB7@yoyang-vm.hosts.qa.psi.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO6vh5+ZLdLSFbB7@yoyang-vm.hosts.qa.psi.pek2.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:55:03AM +0800, Yongcheng Yang wrote:
> Hi Zorro,
> 
> Can we assume all the FIEMAP tests need this check first?
> If so, there are some others need the same patch.
> 
> I.e.
> [yoyang@yoyang-vm xfstests-dev]$ grep url .git/config
>         url = git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> [yoyang@yoyang-vm xfstests-dev]$ git pl
> Already up to date.
> [yoyang@yoyang-vm xfstests-dev]$ git grep _begin_fstest tests/ | grep fiemap | wc -l
> 101
> [yoyang@yoyang-vm xfstests-dev]$ git grep _require_xfs_io_command tests/ | grep fiemap | wc -l
> 86
> [yoyang@yoyang-vm xfstests-dev]$

Hi Yongcheng,

Thanks for taking attention on it. 101 - 86 = 15, let's check these 15 cases
one by one:

[zorro@zlang-laptop xfstests-dev]$ for i in `egrep -rsnl _begin_fstest.*fiemap tests`;do grep -q $i < <(egrep -rsnl _require_xfs_io_command.*fiemap tests) || echo $i;done
tests/btrfs/079
tests/btrfs/140
tests/btrfs/004
tests/ext4/001
tests/ext4/308
tests/generic/655
tests/generic/654
tests/generic/578
tests/generic/541
tests/generic/542
tests/generic/516
tests/generic/519
tests/generic/540
tests/generic/543
tests/overlay/066

btrfs/079: It doesn't use fiemap direclty, it use filefrag command to trigger
           fiemap (if support). If FIEMAP is not supported then filefrag will
	   fall back to using FIBMAP. So it's not necessary to _notrun this case
	   if FIEMAP isn't supported I think.
btrfs/140: Similar as above
btrfs/004: Similar as above
ext4/001:  It use fiemap through _test_generic_punch helper, so I think it should
	   has "_require_xfs_io_command fiemap"
ext4/308:  I think it missed the `_require_xfs_io_command fiemap`
g/655:     It doesn't use fiemap, but use filefrag. And filefrag will fall back to
           FIBMAP, if FIEMAP isn't supported.
g/654:     Similar as above
g/578:     Similar as above
g/541:	   Similar as above
g/542:	   Similar as above
g/516:	   Similar as above
g/519:	   Similar as above
g/540:	   Similar as above
g/543:	   Similar as above
overlay/066: Similar as above

(If anything I said above is wrong, feel free to tell me:)

So I think ext4/001 and ext4/308 can have the `_require_xfs_io_command fiemap`.
But as they're ext4 specific test cases (not generic), so they won't affect
other fs (which doesn't support fiemap) testing. If you'd like, you can add
`_require_xfs_io_command fiemap` to these two cases.

Thanks,
Zorro

> 
> Best Regards,
> Yongcheng
> 

