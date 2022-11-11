Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3ED625D86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiKKOxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 09:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiKKOxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B35E9E5;
        Fri, 11 Nov 2022 06:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F6BEB8262D;
        Fri, 11 Nov 2022 14:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC919C433D6;
        Fri, 11 Nov 2022 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668178389;
        bh=WGPrvryZfOFC3wzVBHxzozHV97DRR/WI/YY1vZ/2/qE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EoNlpBMNR1ejsTCtegykgDZlopZro00NIke6A2KclFEqsmSdnfH+ul/G/mMGQgvaD
         Cbd4ng3JRSeDL7S7/wrTgoTTf3nXutv2+6gUlR8CZbWnfm26pdLK5YaJ/BLwVPE//0
         6i1xJD4nA46ZkJ72rfMGU6QkgSbUAsDQruNsTbSLZnGfVKhCrZifT6cp4cTNJvjW4s
         9nH/QMKqatRhijj7R2P8oQt6EbuJU9vcaKVvCZKEgHEkfZS+3CQHSOvBQkUWIBuWRs
         M5CSt894nfvGqdFLVMYrtX4cvqgjOspX3EMTmkNRbncYFpE6otDOvPIrFd1186KKKL
         8i8ABK+aeOxtg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-12c8312131fso5651905fac.4;
        Fri, 11 Nov 2022 06:53:09 -0800 (PST)
X-Gm-Message-State: ANoB5pmSkGN1ZlbttgRIUpBoPoVx9aOfj+XihP+U7Pj0u/qYpNvac1pU
        TEuU9X0FH4FPtQp0MM01f7k7Wb7OnRnTeTK7xBs=
X-Google-Smtp-Source: AA0mqf6vJpHLx34mdSsrAzt/LKXi2o4W6WHbkOsKLVu8I5IX1EvXNngZJHlIpEv2ym4TxyVwGPbZMTx23gLOrARs2e0=
X-Received: by 2002:a05:6870:5882:b0:13d:5167:43e3 with SMTP id
 be2-20020a056870588200b0013d516743e3mr1081624oab.257.1668178388804; Fri, 11
 Nov 2022 06:53:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Fri, 11 Nov 2022 06:53:08
 -0800 (PST)
In-Reply-To: <20221110155522.556225-1-amir73il@gmail.com>
References: <20221110155522.556225-1-amir73il@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 11 Nov 2022 23:53:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd--CCur4Pd9RhSTzV3ra7CV8zqsDgj-iOerun0sub1Xdw@mail.gmail.com>
Message-ID: <CAKYAXd--CCur4Pd9RhSTzV3ra7CV8zqsDgj-iOerun0sub1Xdw@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix copy_file_range() averts filesystem freeze protection
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-11 0:55 GMT+09:00, Amir Goldstein <amir73il@gmail.com>:
> Commit 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
> copies") removed fallback to generic_copy_file_range() for cross-fs
> cases inside vfs_copy_file_range().
>
> To preserve behavior of nfsd and ksmbd server-side-copy, the fallback to
> generic_copy_file_range() was added in nfsd and ksmbd code, but that
> call is missing sb_start_write(), fsnotify hooks and more.
>
> Ideally, nfsd and ksmbd would pass a flag to vfs_copy_file_range() that
> will take care of the fallback, but that code would be subtle and we got
> vfs_copy_file_range() logic wrong too many times already.
>
> Instead, add a flag to explicitly request vfs_copy_file_range() to
> perform only generic_copy_file_range() and let nfsd and ksmbd use this
> flag only in the fallback path.
>
> This choise keeps the logic changes to minimum in the non-nfsd/ksmbd code
> paths to reduce the risk of further regressions.
>
> Fixes: 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
> copies")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Al,
>
> Another fix for the long tradition of copy_file_range() regressions.
> This one only affected cross-fs server-side-copy from nfsd/ksmbd.
>
> I ran the copy_range fstests group on ext4/xfs/overlay to verify no
> regressions in local fs and nfsv3/nfsv4 to test server-side-copy.
>
> I also patched copy_file_range() to test the nfsd fallback code on
> local fs.
>
> Namje, could you please test ksmbd.
Works fine. You can add tested-by tag for ksmbd.
Tested-by: Namjae Jeon <linkinjeon@kernel.org>

>
> Thanks,
> Amir.
