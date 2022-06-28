Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05EC55EABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiF1RNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiF1RNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1111CB03;
        Tue, 28 Jun 2022 10:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B61F6191F;
        Tue, 28 Jun 2022 17:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DE4C3411D;
        Tue, 28 Jun 2022 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436411;
        bh=++wCdFsjucGtnkuq8Yhv5raDPHMLZWqKu4ZBbkVtXjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4pqYPuNz2m41jfd4MnVRHF6LCmNfQL1aF6rVgm/g8u8u4MvjKLSt5yVU7RncX4BS
         6Cjb2lbSKFXYCDVvFhYku/4vUEgIXxGQkE/033KgI+9ArowJfLylafgynDnjM5wHGV
         ODJ7Eeu1eU0kAPrmuSutO8NFAzSQx5h7jEzaCMhbNPeWjPDxgu4w6jeH1VHahhJSJB
         u6eLHuw0LJAqj6GmZl4ZAuUFAyj5DDkhtjKDs3Vo9XsY+2H03pDNDHr9g+3cAyepAA
         Ib8KyWAB6/2/wcEkVB0AuBwvZ5YTiFhuFXs8ei6J+zjkJPeMf4wRV/w3rTI+wVH4tz
         esltsbhxGf8VA==
Date:   Tue, 28 Jun 2022 19:13:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
Message-ID: <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
References: <20220628161948.475097-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628161948.475097-1-kpsingh@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:19:43PM +0000, KP Singh wrote:
> v4 -> v5
> 
> - Fixes suggested by Andrii
> 
> v3 -> v4
> 
> - Fixed issue incorrect increment of arg counter
> - Removed __weak and noinline from kfunc definiton
> - Some other minor fixes.
> 
> v2 -> v3
> 
> - Fixed missing prototype error
> - Fixes suggested by other Joanne and Kumar.
> 
> v1 -> v2
> 
> - Used kfuncs as suggested by Alexei
> - Used Benjamin Tissoires' patch from the HID v4 series to add a
>   sleepable kfunc set (I sent the patch as a part of this series as it
>   seems to have been dropped from v5) and acked it. Hope this is okay.
> - Added support for verifying string constants to kfuncs

Hm, I mean this isn't really giving any explanation as to why you are
doing this. There's literally not a single sentence about the rationale?
Did you accidently forget to put that into the cover letter? :)

> 
> 
> 
> Benjamin Tissoires (1):
>   btf: Add a new kfunc set which allows to mark a function to be
>     sleepable
> 
> KP Singh (4):
>   bpf: kfunc support for ARG_PTR_TO_CONST_STR
>   bpf: Allow kfuncs to be used in LSM programs
>   bpf: Add a bpf_getxattr kfunc
>   bpf/selftests: Add a selftest for bpf_getxattr
> 
>  include/linux/bpf_verifier.h                  |  2 +
>  include/linux/btf.h                           |  2 +
>  kernel/bpf/btf.c                              | 43 ++++++++-
>  kernel/bpf/verifier.c                         | 89 +++++++++++--------
>  kernel/trace/bpf_trace.c                      | 42 +++++++++
>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++
>  tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
>  7 files changed, 229 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
> 
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
