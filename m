Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4707454012B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245350AbiFGOWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiFGOWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:22:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45468C9655;
        Tue,  7 Jun 2022 07:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D455B82024;
        Tue,  7 Jun 2022 14:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A7EC36AFE;
        Tue,  7 Jun 2022 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654611747;
        bh=cdW6Y4w/Alw2MtSKkp2MAQF/yoWm8bl718vnVRc2CbY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bW/FLgr1LyhV3jDbHxzsrvCo4c0sgFl1RlLreeNJ94XDaY0R2juLz5c6aU66y+pqd
         YI85rwNd49jnBrmgaJsFDeXMRC8G8L3TMUluWMlCK5l0vwBbvr9ariZ/agcqwoMPUS
         zebvvWklShjshP/h6qFsn/fbY9bednjgc1++mUCbA4laS3flarG5b9v8oaHTdZoOgC
         HlaioDJyKxqa/9Sbiib7zNunrLv/XPtkQMIxwGWHS5CU6D/FsoNl40otFpVMLlVUUr
         EObl+mpzXagwyC6EV8k8sTp4WYp1hKUCYuJ4zboACApQNCOZKCegxlcjOGeT7NxvzN
         FJbis+kWnT77A==
Received: by mail-wr1-f47.google.com with SMTP id q26so14034573wra.1;
        Tue, 07 Jun 2022 07:22:27 -0700 (PDT)
X-Gm-Message-State: AOAM530UgUzsfDR35bNSomB+WmLQMab2Dx0CdJi4koO2JJCo5QIZUCeI
        XSWq7nYLqBBxqBUpdM77PduQCJzSBKbSbUV9zJY=
X-Google-Smtp-Source: ABdhPJx+rv87thEe0EVZFgAZYv9Q7r/BhNorSt4RG0j/nTusqQT2mh9ZwbUgh+4BipT2bndYTCgds2+cXyAAxgI3gZc=
X-Received: by 2002:a5d:4a85:0:b0:215:ae89:5925 with SMTP id
 o5-20020a5d4a85000000b00215ae895925mr19144535wrq.401.1654611745462; Tue, 07
 Jun 2022 07:22:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Tue, 7 Jun 2022 07:22:24 -0700 (PDT)
In-Reply-To: <20220606134608.684131-1-amir73il@gmail.com>
References: <20220606134608.684131-1-amir73il@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Jun 2022 23:22:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_JguZBb51LCdR8OAUmKuCtKOTJFw1WLE8J2Y_ajXXa5Q@mail.gmail.com>
Message-ID: <CAKYAXd_JguZBb51LCdR8OAUmKuCtKOTJFw1WLE8J2Y_ajXXa5Q@mail.gmail.com>
Subject: Re: [PATCH v14] vfs: fix copy_file_range() regression in cross-fs copies
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
        linux-cifs@vger.kernel.org, Luis Henriques <lhenriques@suse.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
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

2022-06-06 22:46 GMT+09:00, Amir Goldstein <amir73il@gmail.com>:
> From: Luis Henriques <lhenriques@suse.de>
>
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
> Filesystems that implement only ->remap_file_range() (i.e. xfs) may still
> fall-back to the generic_copy_file_range() implementation when the copy
> is within the same sb, but filesystem cannot handle the reuqested copied
> range.  This helps the kernel can maintain a more consistent story about
> which filesystems support copy_file_range().
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
>
> Hi Steve, Namje,
>
> I was going to ping Al about this patch when I remembered that we have
> another kernel file server that supports server side copy and needs to
> be adjusted. I also realized that v13 wrongly (?) falls back to
> generic_copy_file_range() in nfs/smb client code.
>
> It would be great if you could review my ksmbd change and run the fstests
> as below in your test setup.
I have run xfstests against ksmbd. All tests are passed.
You can add my tags for ksmbd.

Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
