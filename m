Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD3673513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjASKGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 05:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjASKF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77436E82C
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674122633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljoiPtqmLw7w9XNA0+M0g+TWHqmwEmndCJRe1l9JPl4=;
        b=e3nAj2uRsthL8UZAYdLVjbDDhKeptGkV8XL06KI5VYtO8EzND/+FkVbki3RzoQYMf/FQS3
        bFTLt2E4TFggDro7ZdilxpiYi8BFKAFxrBNST1uz4ZPI5Y0jydc6Kprf6WFhTS7RX70T5h
        TNI8g4hcckbB+qTU9ibc+l/u8aZ0Xug=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-8AFsranDMyWo5h99PqDE-Q-1; Thu, 19 Jan 2023 05:03:36 -0500
X-MC-Unique: 8AFsranDMyWo5h99PqDE-Q-1
Received: by mail-pj1-f72.google.com with SMTP id h1-20020a17090a470100b0022646263abfso703131pjg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljoiPtqmLw7w9XNA0+M0g+TWHqmwEmndCJRe1l9JPl4=;
        b=ol1qSpGt8X1CAEGqvOjQwR055cc5oo5Ram1ZKMdn/F8dxB1erXon9MRf0YD388Buic
         2cRNDxWGcnUA6YsUiQciNqFGaDU3vxeLr2Zs5Qq9iWJLkfveVIDffZ9PF501vrMGlhyh
         m5GsV1SXtbor3T3Hs055WnSO0e7BRKU4B2KX36llBGx8M8hC+t/R9Iqez02reD5jlZz9
         cmqZQeNoW32dOOI8SsFPen3hciGn+tay3S29guSXlkVlwQz0LH10JZOt+MaPXylHLZWM
         Ibwo/aEH2HQwWl9S3DPFkJinxDhdHwZKJ6E3gEcZhxmucFMuLmn2cRiVoACNPQWLGxjl
         R4PA==
X-Gm-Message-State: AFqh2kqWKEFS1dPT8vA+EE4GSvjDVndZiLgsTQ/JhkLHf8A++hoRWAfm
        XU+IGfzbOWvnWQJ459eKaSQlfhWBp3F76JE58ONG9L0BbimM6CQDLO+CJnp08UaqRpOGURjkZc8
        2hhbMnkTfDy1yjUsa4vKRyiFQ3Q==
X-Received: by 2002:a05:6a20:1a24:b0:ad:4643:9fe2 with SMTP id cj36-20020a056a201a2400b000ad46439fe2mr9799799pzb.57.1674122615176;
        Thu, 19 Jan 2023 02:03:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuF557r8N2IYQk3YKMX/Mt12eWmSMHkFRkqXCga3ID49n90PSQYMU6d38W6Iut7YVSWF+R9Zw==
X-Received: by 2002:a05:6a20:1a24:b0:ad:4643:9fe2 with SMTP id cj36-20020a056a201a2400b000ad46439fe2mr9799777pzb.57.1674122614653;
        Thu, 19 Jan 2023 02:03:34 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 8-20020a631448000000b004b25a51d6f4sm17505807pgu.36.2023.01.19.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:03:34 -0800 (PST)
Date:   Thu, 19 Jan 2023 18:03:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] generic: update setgid tests
Message-ID: <20230119100329.xnmdckqrs3wi6dk2@zlang-mailbox>
References: <20230103-fstests-setgid-v6-2-v3-1-5950c139bfcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103-fstests-setgid-v6-2-v3-1-5950c139bfcc@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 05, 2023 at 03:53:36PM +0100, Christian Brauner wrote:
> Over mutiple kernel releases we have reworked setgid inheritance
> significantly due to long-standing security issues, security issues that
> were reintroduced after they were fixed, and the subtle and difficult
> inheritance rules that plagued individual filesystems. We have lifted
> setgid inheritance into the VFS proper in earlier patches. Starting with
> kernel v6.2 we have made setgid inheritance consistent between the write
> and setattr (ch{mod,own}) paths.
> 
> The gist of the requirement is that in order to inherit the setgid bit
> the user needs to be in the group of the file or have CAP_FSETID in
> their user namespace. Otherwise the setgid bit will be dropped
> irregardless of the file's executability. Remove the obsolete tests as
> they're not a security issue and will cause spurious warnings on older
> distro kernels.
> 
> Note, that only with v6.2 setgid inheritance works correctly for
> overlayfs in the write path. Before this the setgid bit was always

retained

(I'll fix that missing when I merge this patch)

> 
> Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
> Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
> Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> Changes in v3:
> - Miklos Szeredi <miklos@szeredi.hu>
>   - Instead of fixing up the test which changed, remove them.
> - Link to v2: https://lore.kernel.org/r/20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org

This version looks good to me, old kernel and new kernel (v6.2) all test passed.
If there's not more review points from VFS part, I'll merge this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Changes in v2:
> - Darrick J. Wong <djwong@kernel.org>:
>   - Also update generic/686 and generic/687.
> - Link to v1: https://lore.kernel.org/r/20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org
> ---
>  tests/generic/673     | 16 ++--------------
>  tests/generic/673.out | 16 ++--------------
>  tests/generic/683     | 16 ++--------------
>  tests/generic/683.out | 12 ++----------
>  tests/generic/684     | 16 ++--------------
>  tests/generic/684.out | 12 ++----------
>  tests/generic/685     | 16 ++--------------
>  tests/generic/685.out | 12 ++----------
>  tests/generic/686     | 16 ++--------------
>  tests/generic/686.out | 12 ++----------
>  tests/generic/687     | 16 ++--------------
>  tests/generic/687.out | 12 ++----------
>  12 files changed, 24 insertions(+), 148 deletions(-)
> 
> diff --git a/tests/generic/673 b/tests/generic/673
> index 6d1f49ea..ac8b8c09 100755
> --- a/tests/generic/673
> +++ b/tests/generic/673
> @@ -102,26 +102,14 @@ setup_testfile
>  chmod a+rwxs $SCRATCH_MNT/a
>  commit_and_check
>  
> -#Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $SCRATCH_MNT/a
> -commit_and_check "$qa_user"
> -
>  #Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file, only sgid"
> +echo "Test 9 - qa_user, group-exec file, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $SCRATCH_MNT/a
>  commit_and_check "$qa_user"
>  
> -#Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
> -commit_and_check "$qa_user"
> -
>  #Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file, only sgid"
> +echo "Test 10 - qa_user, all-exec file, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $SCRATCH_MNT/a
>  commit_and_check "$qa_user"
> diff --git a/tests/generic/673.out b/tests/generic/673.out
> index 0817857d..4276fa01 100644
> --- a/tests/generic/673.out
> +++ b/tests/generic/673.out
> @@ -47,25 +47,13 @@ Test 8 - root, all-exec file
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
>  6777 -rwsrwsrwx SCRATCH_MNT/a
>  
> -Test 9 - qa_user, non-exec file, only sgid
> -310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> -2666 -rw-rwSrw- SCRATCH_MNT/a
> -3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> -2666 -rw-rwSrw- SCRATCH_MNT/a
> -
> -Test 10 - qa_user, group-exec file, only sgid
> +Test 9 - qa_user, group-exec file, only sgid
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>  2676 -rw-rwsrw- SCRATCH_MNT/a
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
>  676 -rw-rwxrw- SCRATCH_MNT/a
>  
> -Test 11 - qa_user, user-exec file, only sgid
> -310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> -2766 -rwxrwSrw- SCRATCH_MNT/a
> -3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> -2766 -rwxrwSrw- SCRATCH_MNT/a
> -
> -Test 12 - qa_user, all-exec file, only sgid
> +Test 10 - qa_user, all-exec file, only sgid
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>  2777 -rwxrwsrwx SCRATCH_MNT/a
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> diff --git a/tests/generic/683 b/tests/generic/683
> index eea8d21b..304b1a48 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -110,26 +110,14 @@ setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +echo "Test 9 - qa_user, group-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +echo "Test 10 - qa_user, all-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
> diff --git a/tests/generic/683.out b/tests/generic/683.out
> index ca29f6e6..de18ea5f 100644
> --- a/tests/generic/683.out
> +++ b/tests/generic/683.out
> @@ -31,19 +31,11 @@ Test 8 - root, all-exec file falloc
>  6777 -rwsrwsrwx TEST_DIR/683/a
>  6777 -rwsrwsrwx TEST_DIR/683/a
>  
> -Test 9 - qa_user, non-exec file falloc, only sgid
> -2666 -rw-rwSrw- TEST_DIR/683/a
> -2666 -rw-rwSrw- TEST_DIR/683/a
> -
> -Test 10 - qa_user, group-exec file falloc, only sgid
> +Test 9 - qa_user, group-exec file falloc, only sgid
>  2676 -rw-rwsrw- TEST_DIR/683/a
>  676 -rw-rwxrw- TEST_DIR/683/a
>  
> -Test 11 - qa_user, user-exec file falloc, only sgid
> -2766 -rwxrwSrw- TEST_DIR/683/a
> -2766 -rwxrwSrw- TEST_DIR/683/a
> -
> -Test 12 - qa_user, all-exec file falloc, only sgid
> +Test 10 - qa_user, all-exec file falloc, only sgid
>  2777 -rwxrwsrwx TEST_DIR/683/a
>  777 -rwxrwxrwx TEST_DIR/683/a
>  
> diff --git a/tests/generic/684 b/tests/generic/684
> index 541dbeb4..1ebffb01 100755
> --- a/tests/generic/684
> +++ b/tests/generic/684
> @@ -110,26 +110,14 @@ setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +echo "Test 9 - qa_user, group-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +echo "Test 10 - qa_user, all-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
> diff --git a/tests/generic/684.out b/tests/generic/684.out
> index 2e084ced..da5ada5e 100644
> --- a/tests/generic/684.out
> +++ b/tests/generic/684.out
> @@ -31,19 +31,11 @@ Test 8 - root, all-exec file fpunch
>  6777 -rwsrwsrwx TEST_DIR/684/a
>  6777 -rwsrwsrwx TEST_DIR/684/a
>  
> -Test 9 - qa_user, non-exec file fpunch, only sgid
> -2666 -rw-rwSrw- TEST_DIR/684/a
> -2666 -rw-rwSrw- TEST_DIR/684/a
> -
> -Test 10 - qa_user, group-exec file fpunch, only sgid
> +Test 9 - qa_user, group-exec file fpunch, only sgid
>  2676 -rw-rwsrw- TEST_DIR/684/a
>  676 -rw-rwxrw- TEST_DIR/684/a
>  
> -Test 11 - qa_user, user-exec file fpunch, only sgid
> -2766 -rwxrwSrw- TEST_DIR/684/a
> -2766 -rwxrwSrw- TEST_DIR/684/a
> -
> -Test 12 - qa_user, all-exec file fpunch, only sgid
> +Test 10 - qa_user, all-exec file fpunch, only sgid
>  2777 -rwxrwsrwx TEST_DIR/684/a
>  777 -rwxrwxrwx TEST_DIR/684/a
>  
> diff --git a/tests/generic/685 b/tests/generic/685
> index 29eca1a8..e4ada8e7 100755
> --- a/tests/generic/685
> +++ b/tests/generic/685
> @@ -110,26 +110,14 @@ setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +echo "Test 9 - qa_user, group-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +echo "Test 10 - qa_user, all-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
> diff --git a/tests/generic/685.out b/tests/generic/685.out
> index e611da3e..03eef362 100644
> --- a/tests/generic/685.out
> +++ b/tests/generic/685.out
> @@ -31,19 +31,11 @@ Test 8 - root, all-exec file fzero
>  6777 -rwsrwsrwx TEST_DIR/685/a
>  6777 -rwsrwsrwx TEST_DIR/685/a
>  
> -Test 9 - qa_user, non-exec file fzero, only sgid
> -2666 -rw-rwSrw- TEST_DIR/685/a
> -2666 -rw-rwSrw- TEST_DIR/685/a
> -
> -Test 10 - qa_user, group-exec file fzero, only sgid
> +Test 9 - qa_user, group-exec file fzero, only sgid
>  2676 -rw-rwsrw- TEST_DIR/685/a
>  676 -rw-rwxrw- TEST_DIR/685/a
>  
> -Test 11 - qa_user, user-exec file fzero, only sgid
> -2766 -rwxrwSrw- TEST_DIR/685/a
> -2766 -rwxrwSrw- TEST_DIR/685/a
> -
> -Test 12 - qa_user, all-exec file fzero, only sgid
> +Test 10 - qa_user, all-exec file fzero, only sgid
>  2777 -rwxrwsrwx TEST_DIR/685/a
>  777 -rwxrwxrwx TEST_DIR/685/a
>  
> diff --git a/tests/generic/686 b/tests/generic/686
> index a8ec23d5..d56aa7cc 100755
> --- a/tests/generic/686
> +++ b/tests/generic/686
> @@ -110,26 +110,14 @@ setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +echo "Test 9 - qa_user, group-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +echo "Test 10 - qa_user, all-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
> diff --git a/tests/generic/686.out b/tests/generic/686.out
> index aa1e6471..562e1ab9 100644
> --- a/tests/generic/686.out
> +++ b/tests/generic/686.out
> @@ -31,19 +31,11 @@ Test 8 - root, all-exec file finsert
>  6777 -rwsrwsrwx TEST_DIR/686/a
>  6777 -rwsrwsrwx TEST_DIR/686/a
>  
> -Test 9 - qa_user, non-exec file finsert, only sgid
> -2666 -rw-rwSrw- TEST_DIR/686/a
> -2666 -rw-rwSrw- TEST_DIR/686/a
> -
> -Test 10 - qa_user, group-exec file finsert, only sgid
> +Test 9 - qa_user, group-exec file finsert, only sgid
>  2676 -rw-rwsrw- TEST_DIR/686/a
>  676 -rw-rwxrw- TEST_DIR/686/a
>  
> -Test 11 - qa_user, user-exec file finsert, only sgid
> -2766 -rwxrwSrw- TEST_DIR/686/a
> -2766 -rwxrwSrw- TEST_DIR/686/a
> -
> -Test 12 - qa_user, all-exec file finsert, only sgid
> +Test 10 - qa_user, all-exec file finsert, only sgid
>  2777 -rwxrwsrwx TEST_DIR/686/a
>  777 -rwxrwxrwx TEST_DIR/686/a
>  
> diff --git a/tests/generic/687 b/tests/generic/687
> index ff3e2fe1..3a7f1fd5 100755
> --- a/tests/generic/687
> +++ b/tests/generic/687
> @@ -110,26 +110,14 @@ setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by an unprivileged user leaves sgid.
> -echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a group-exec file by an unprivileged user clears sgid
> -echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +echo "Test 9 - qa_user, group-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rw,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears sgid
> -echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> -setup_testfile
> -chmod a+rw,u+x,g+rws $junk_file
> -commit_and_check "$qa_user" "$verb" 64k 64k
> -
>  # Commit to a all-exec file by an unprivileged user clears sgid.
> -echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +echo "Test 10 - qa_user, all-exec file $verb, only sgid"
>  setup_testfile
>  chmod a+rwx,g+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
> diff --git a/tests/generic/687.out b/tests/generic/687.out
> index c5116c27..f72f6d30 100644
> --- a/tests/generic/687.out
> +++ b/tests/generic/687.out
> @@ -31,19 +31,11 @@ Test 8 - root, all-exec file fcollapse
>  6777 -rwsrwsrwx TEST_DIR/687/a
>  6777 -rwsrwsrwx TEST_DIR/687/a
>  
> -Test 9 - qa_user, non-exec file fcollapse, only sgid
> -2666 -rw-rwSrw- TEST_DIR/687/a
> -2666 -rw-rwSrw- TEST_DIR/687/a
> -
> -Test 10 - qa_user, group-exec file fcollapse, only sgid
> +Test 9 - qa_user, group-exec file fcollapse, only sgid
>  2676 -rw-rwsrw- TEST_DIR/687/a
>  676 -rw-rwxrw- TEST_DIR/687/a
>  
> -Test 11 - qa_user, user-exec file fcollapse, only sgid
> -2766 -rwxrwSrw- TEST_DIR/687/a
> -2766 -rwxrwSrw- TEST_DIR/687/a
> -
> -Test 12 - qa_user, all-exec file fcollapse, only sgid
> +Test 10 - qa_user, all-exec file fcollapse, only sgid
>  2777 -rwxrwsrwx TEST_DIR/687/a
>  777 -rwxrwxrwx TEST_DIR/687/a
>  
> 
> ---
> base-commit: fbd489798b31e32f0eaefcd754326a06aa5b166f
> change-id: 20230103-fstests-setgid-v6-2-4ce5852d11e2
> 

