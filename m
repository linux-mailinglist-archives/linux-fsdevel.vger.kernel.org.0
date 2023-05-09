Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB8D6FC09A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjEIHnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 03:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEIHnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 03:43:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24727DA3
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 00:43:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-306dbad5182so3434001f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683618190; x=1686210190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TrcVCLLeakLJesFm7MY9BVBUFJFOgospV/GjEA6xZc=;
        b=hjl2Wdrfx/W6pgJ76OORur6lUmD0pBPq+MkK7zPQB07soBsqUFMCkpZtSNvzmAsJfu
         A9LKDEOFthOIKt6hYU6I5tPHQ1rsOwDcZAWs3sUdOSMFtYvq2Qnm+PwBqLeFMaFGxnzk
         jMIRT16hEdMPKnkC2HlvvgKwQrrksBtscHLpBCLBGFYuJvUAYr1KJymYf/bspVWAxFKg
         KSz2nCNmNhkqbST3N+KLxjhUFiazAAcO8VrFQvA66vuKxt42jiKNTfwkOwjcHePnMpnX
         68zmbR5v0T6wynYc2eWJlW97rE0qgzdM/frgbJT5RKSVn6Z5RavM9UxF4f/2FEkkLqb0
         sOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683618190; x=1686210190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TrcVCLLeakLJesFm7MY9BVBUFJFOgospV/GjEA6xZc=;
        b=gc7mngreMg1T6ZvyoVC1vNllQCRlionW/iWI5nITCAY+115+9ypidlHq9rFqhRt3Xv
         puOy7s+T/CSgypm6OG+EITnJLfi1stkLdlTuIsg6NQFkPyEu1jPwqlNEt9ZNFUURfsm8
         YiAWSznp06kfMvTFd3wO40EKB1aYksW7PKfAcyj8YWL+z3d59f3nF+18I/qgGtrQxTzq
         uNvbQL3/3BrgerIW2XKcTKIpbS1Rp3kWDSOkgtj5gisRhyh7n8hrKzg0S3FyTbcoxa4Z
         93xv7FewAVOxHJiQv0Hp8928SbqUh/qc1we1J4aDqiPW4sp8vZFFVnPatCrPWiPC3d8G
         vHkQ==
X-Gm-Message-State: AC+VfDzolBZFIrbRVP0nDiAUa1dP+6UO9ezuTi7xw3Tps7SoXnpBHb0d
        l917tDL5/qDIG2oOtnn43abjhv5vPmV0bajjZvI=
X-Google-Smtp-Source: ACHHUZ7thWP8DO0O78r31AKPH9qWoZ/xHhiRvZurWaKmoSBGyax65xewo4yTwTPIjxY2BmFNOu/+KA==
X-Received: by 2002:a5d:43c4:0:b0:2f0:2dfe:e903 with SMTP id v4-20020a5d43c4000000b002f02dfee903mr9646567wrr.69.1683618190399;
        Tue, 09 May 2023 00:43:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002e5f6f8fc4fsm13500872wrm.100.2023.05.09.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:43:08 -0700 (PDT)
Date:   Tue, 9 May 2023 10:43:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <d98acf2e-04bd-4824-81e4-64e91a26537c@kili.mountain>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
 <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
 <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
 <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 1)  There is an existing check which complains if you have "if (p) "
>     where p can be an error pointer, but not NULL.  If I revert the fix,
>     I get the correct warning now.
> 
>     fs/afs/dir_edit.c:242 afs_edit_dir_add()
>     warn: 'folio0' is an error pointer or valid *NEW*

I ran the new code last night.  There was one more folio bug (but every
function in the call tree triggers a warning).

fs/nfs/dir.c:405 nfs_readdir_folio_get_locked() warn: 'folio' is an error pointer or valid
fs/nfs/dir.c:1000 nfs_readdir_folio_get_cached() warn: 'folio' is an error pointer or valid
fs/nfs/dir.c:1019 find_and_lock_cache_page() warn: 'desc->folio' is an error pointer or valid

Other new warnings.  Mostly harmless checks for NULL.
drivers/usb/host/max3421-hcd.c:1913 max3421_probe() warn: 'max3421_hcd->spi_thread' is an error pointer or valid
drivers/block/aoe/aoecmd.c:1259 aoe_ktstart() warn: 'task' is an error pointer or valid
drivers/target/target_core_fabric_configfs.c:482 target_fabric_make_np() warn: 'se_tpg_np' is an error pointer or valid
drivers/media/i2c/rdacm20.c:641 rdacm20_probe() warn: 'dev->sensor' is an error pointer or valid
drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:291 test_vcap_xn_rule_creator() warn: '__right' is an error pointer or valid
drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:1349 vcap_api_encode_rule_test() warn: '__right' is an error pointer or valid
fs/configfs/dir.c:1339 configfs_mkdir() warn: 'item' is an error pointer or valid
kernel/cgroup/cgroup.c:5542 css_create() warn: 'css' is an error pointer or valid
sound/soc/apple/mca.c:955 mca_pcm_new() warn: 'chan' is an error pointer or valid
sound/soc/apple/mca.c:961 mca_pcm_new() warn: 'chan' is an error pointer or valid
lib/test_kmod.c:320 try_one_request() warn: 'info->task_sync' is an error pointer or valid
lib/test_firmware.c:918 trigger_batched_requests_store() warn: 'req->task' is an error pointer or valid

False postives based on my .config:
fs/ceph/cache.c:100 ceph_fscache_register_fs() warn: 'fsc->fscache' is an error pointer or valid
fs/erofs/fscache.c:354 erofs_fscache_register_volume() warn: 'volume' is an error pointer or valid

False positive because of a bug in Smatch:
fs/overlayfs/readdir.c:906 ovl_dir_fsync() warn: 'realfile' is an error pointer or valid

regards,
dan carpenter
