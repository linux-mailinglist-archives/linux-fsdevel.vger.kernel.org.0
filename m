Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A96A066C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjBWKjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 05:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBWKi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:38:56 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4555A3A3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 02:38:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i10so3364158plr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 02:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVSa2HEsQUgf21db/3wCzFJNJMjWdnCpTJDc8PUFVUg=;
        b=lU8FgkKvew6zeeC7G69X4TxFJBb6QWZlDuZ9v7A0KzpCZLQyd29EW+Na2IinIktbsa
         3MjN3Fuwg3McSkkeOZ4E7Yohs6gz03s/dGdfUhKDTrC2pdJMfPjsX+FB6rMSohUykLiN
         VtwNNUPznaDrmtLGDMEoU1kFhT7MHvN/OFEFn/WlKJigKPpkArcaOEDC9y5m9ZxwQxon
         9UYmUk2BCOnm6xBdo7L9U7MM/56n8lPPC1lWhvv9r0iexkhYJwAF65D56uvpPtqAeIQA
         v9Y5zP8xzKuVVMgFP9mFRcciYNwRzeGbOCsEWYA5kt0z9xL1N8uI7Ga+Te/Jq1Tpa6Eb
         oGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVSa2HEsQUgf21db/3wCzFJNJMjWdnCpTJDc8PUFVUg=;
        b=NbeqX7TKTKeURoV9z1NG+2QqKuP//yrZ3n1lIYqP6NPIJKCxvWqF+jccGcDmSamqlG
         WkSCvDQs1vF6hAQwAdFPqx1zC56WlxGz9YUiR/f7qEzvvv+mIJ4Bh40r5/yPLGXQPiR8
         xqZfgRsNxL0HrnoKVJWNRG1RWkhEw4Ww2X6lQ9oMaV7jc43x+ANeBeQfQNc/ngorVjm7
         UPNQB9c6PfZIKdJ86f4eIGyHqeri5X8ASA77lQwdjF+6g34ou3QyFHBTW9gPfQQg2tNr
         li0hGWJdq4gsIOJcEM3C43Gr5ts6gW+hnSpcagGD396b4gRMJdjTtlhkOyk4U7X44MBS
         DWWw==
X-Gm-Message-State: AO0yUKUsxO2XetM4cHVamSmAHQdM2oxJzIFwX0dGQNGLwnLICDwDjIW3
        iCUZeJumAVJS6Xc1TTtG8aQEcA==
X-Google-Smtp-Source: AK7set+0jn8Cq1tdeYA8ETTeDoEUzWWKCbB49zI0EQps1JzP1Nkvgo7c6CHnCE4d8nV1/gVLsQdesw==
X-Received: by 2002:a17:902:d2ca:b0:19a:e762:a1af with SMTP id n10-20020a170902d2ca00b0019ae762a1afmr12972180plc.33.1677148705621;
        Thu, 23 Feb 2023 02:38:25 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019896d29197sm5639913plo.46.2023.02.23.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:38:25 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     xiang@kernel.org
Cc:     kernel-team@android.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lsf-pc@lists.linuxfoundation.org, dhowells@redhat.com,
        jefflexu@linux.alibaba.com, Xin Yin <yinxin.x@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use cases & directions
Date:   Thu, 23 Feb 2023 18:38:16 +0800
Message-Id: <20230223103816.2623-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y7vTpeNRaw3Nlm9B@debian>
References: <Y7vTpeNRaw3Nlm9B@debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/1/9 16:43, Gao Xiang wrote:
> Hi folks,
> 
> * Background *
> 
> We've been continuously working on forming a useful read-only
> (immutable) image solution since the end of 2017 (as a part of our
> work) until now as everyone may know:  EROFS.
> 
> Currently it has already successfully landed to (about) billions of
> Android-related devices, other types of embedded devices and containers
> with many vendors involved, and we've always been seeking more use
> cases such as incremental immutable rootfs, app sandboxes or packages
> (Android apk? with many duplicated libraries), dataset packages, etc.
> 
> The reasons why we always do believe immutable images can benefit
> various use cases are:
> 
>   - much easier for all vendors to ship/distribute/keep original signing
>     (golden) images to each instance;
> 
>   - (combined with the writable layer such as overlayfs) easy to roll
>     back to the original shipped state or do incremental updates;
> 
>   - easy to check data corruption or do data recovery (no matter
>     whether physical device or network errors);
> 
>   - easy for real storage devices to do hardware write-protection for
>     immutable images;
> 
>   - can do various offline algorithms (such as reduced metadata,
>     content-defined rolling hash deduplication, compression) to minimize
>     image sizes;
> 
>   - initrd with FSDAX to avoid double caching with advantages above;
> 
>   - and more.
> 
> In 2019, a LSF/MM/BPF topic was put forward to show EROFS initial use
> cases [1] as the read-only Android rootfs of a single instance on
> resource-limited devices so that effective compression became quite
> important at that time.
> 
> 
> * Problem *
> 
> In addition to enhance data compression for single-instance deployment,
> as a self-contained approach (so that all use cases can share the only
> _one_ signed image), we've also focusing on multiple instances (such as
> containers or apps, each image represents a complete filesystem tree)
> all together on one device with similar data recently years so that
> effective data deduplication, on-demand lazy pulling, page cache
> sharing among such different golden images became vital as well.
> 
> 
> * Current progresses *
> 
> In order to resolve the challenges above, we've worked out:
> 
>   - (v5.15) chunk-based inodes (to form inode extents) to do data
>     deduplication among a single image;
> 
>   - (v5.16) multiple shared blobs (to keep content-defined data) in
>     addition to the primary blob (to keep filesystem metadata) for wider
>     deduplication across different images:
> 
>   - (v5.19) file-based distribution by introducing in-kernel local
>     caching fscache and on-demand lazy pulling feature [2];
> 
>   - (v6.1) shared domain to share such multiple shared blobs in
>     fscache mode [3];
> 
>   - [RFC] preliminary page cache sharing between diffenent images [4].
> 
> 
> * Potential topics to discuss *
> 
>   - data verification of different images with thousands (or more)
>     shared blobs [5];
> 
>   - encryption with per-extent keys for confidential containers [5][6];
> 
>   - current page cache sharing limitation due to mm reserve mapping and
>     finer (folio or page-based) page cache sharing among images/blobs
>     [4][7];
> 
>   - more effective in-kernel local caching features for fscache such as
>     failover and daemonless;
> 
>   - (wild preliminary ideas, maybe) overlayfs partial copy-up with
>     fscache as the upper layer in order to form a unique caching
>     subsystem for better space saving?
>

We also interested in these topic, page cache sharing is an exciting feature, and may can save 
a lot of memory in high-density deployment scenarios, cause we already can share blobs.

Hope to have further discussion on the failover, mutiple daemons/dirs and daemonless feature of fscache & cachefiles.
So we can have a better form for our production.

And Looking forward to the opportunity to discuss online, if I can't attend offline.

Thanks,
Xin Yin

>   - FSDAX enhancements for initial ramdisk or other use cases;
> 
>   - other issues when landing.
> 
> 
> Finally, if our efforts (or plans) also make sense to you, we do hope
> more people could join us, Thanks!
> 
> [1] https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
> [2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
> [3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
> [4] https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
> [5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
> [6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
> [7] https://lwn.net/Articles/895907
> 
> Thanks,
> Gao Xiang

-- 
2.25.1

