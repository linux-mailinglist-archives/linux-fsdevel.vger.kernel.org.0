Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C854D6CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbiFPBOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 21:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiFPBOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:14:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45BD4D605;
        Wed, 15 Jun 2022 18:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D087B8216A;
        Thu, 16 Jun 2022 01:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22244C341C0;
        Thu, 16 Jun 2022 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655342057;
        bh=F5tbGSVtmtyru8j/GWLjm1O7l/KXlL/Ji+cKQzlskVs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jLFtxxOQKCdXV8qk551IPgiKVerltRCjnRn4oVHnXb5MSfuH0gPMV97T6qlCq06eZ
         b3K9IJYiQysKGurpBS7ZWL9RiR7OQnu06f8BYKMBGQ8CmQqAcPqB0YWMk0JpTI3aH1
         vOeEAJcoKlL/Hh+CsGP6Xttr7UDeFpGPcf4AlCekuLn7d+OS2PqUiwq8tQD8aF4x4n
         LW25DJMMKfTXHfoeK0nd4rhH8Cvrdxsy4yHhxb4YxblevhlFeZe+PjkQbNktbohh55
         bNze0GUNmnL+NPZoNspsDDHTID/VT+Lqd4Qv9sUG/QkPNzszf0Ism77lrpOsXqwhw5
         Dg3ctmoetnb5g==
Received: by mail-wr1-f47.google.com with SMTP id g4so849145wrh.11;
        Wed, 15 Jun 2022 18:14:17 -0700 (PDT)
X-Gm-Message-State: AJIora9i/IW0p+VQayOpSzM4dfA2t+uqBBR5zc/Q6V0FIuDcilHuCOmp
        wGRZhbmB+ULNdGECkxyqoi6m8S8306MnFjmiMgg=
X-Google-Smtp-Source: AGRyM1vNWa9NvzjYFrEsgV+RnaYCGzG4zUhnlGwZEdoJjeEZmOhzO5ekoczWg00a+UudLbDXapjdfYHa6B0wlf0am/0=
X-Received: by 2002:a5d:64c7:0:b0:216:5021:687f with SMTP id
 f7-20020a5d64c7000000b002165021687fmr2276576wri.295.1655342055301; Wed, 15
 Jun 2022 18:14:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:18ad:0:0:0:0 with HTTP; Wed, 15 Jun 2022 18:14:14
 -0700 (PDT)
In-Reply-To: <20220615130014.1490661-1-amir73il@gmail.com>
References: <20220615130014.1490661-1-amir73il@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Jun 2022 10:14:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-jvj4Bm5tZFM6TxRLOVJx7v2WZhQx5+X5=RQnTTkd8cA@mail.gmail.com>
Message-ID: <CAKYAXd-jvj4Bm5tZFM6TxRLOVJx7v2WZhQx5+X5=RQnTTkd8cA@mail.gmail.com>
Subject: Re: [PATCH v15] vfs: fix copy_file_range() regression in cross-fs copies
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        He Zhe <zhe.he@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Luis Henriques <lhenriques@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-06-15 22:00 GMT+09:00, Amir Goldstein <amir73il@gmail.com>:
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> Another regression has been reported by He Zhe - the assertion of
> WARN_ON_ONCE(ret == -EOPNOTSUPP) can be triggered from userspace when
> copying from a sysfs file whose read operation may return -EOPNOTSUPP.
>
> Since we do not have test coverage for copy_file_range() between any
> two types of filesystems, the best way to avoid these sort of issues
> in the future is for the kernel to be more picky about filesystems that
> are allowed to do copy_file_range().
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices"), namely, cross-sb copy is not allowed for filesystems that do
> not implement ->copy_file_range().
>
> Filesystems that do implement ->copy_file_range() have full control of
> the result - if this method returns an error, the error is returned to
> the user.  Before this change this was only true for fs that did not
> implement the ->remap_file_range() operation (i.e. nfsv3).
>
> Filesystems that do not implement ->copy_file_range() still fall-back to
> the generic_copy_file_range() implementation when the copy is within the
> same sb.  This helps the kernel can maintain a more consistent story
> about which filesystems support copy_file_range().
>
> nfsd and ksmbd servers are modified to fall-back to the
> generic_copy_file_range() implementation in case vfs_copy_file_range()
> fails with -EOPNOTSUPP or -EXDEV, which preserves behavior of
> server-side-copy.
>
> fall-back to generic_copy_file_range() is not implemented for the smb
> operation FSCTL_DUPLICATE_EXTENTS_TO_FILE, which is arguably a correct
> change of behavior.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link:
> https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link:
> https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link:
> https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Link:
> https://lore.kernel.org/linux-fsdevel/20210630161320.29006-1-lhenriques@suse.de/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> Fixes: 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
> Link:
> https://lore.kernel.org/linux-fsdevel/20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com/
> Reported-by: He Zhe <zhe.he@windriver.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Hi Luis, Namje,
>
> Thank you for testing v14 [1].  Unfortunately (or fortunately),
> kernel test robot has alerted me on LTP test failure [2] with v14.
>
> The patch had changed behavior of same sb case when it should not have.
> So I did not apply you Tested-by and I would like to request from you
> to test v15.
Works fine. You can add tested-by tag for ksmbd.
Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
