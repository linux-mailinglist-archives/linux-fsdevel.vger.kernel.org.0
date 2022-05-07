Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002DD51E77A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385216AbiEGNh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385152AbiEGNh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 09:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C78EA1929C
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651930418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyotHlnPBZMTbWwbWZV56jLBQCGIO3aie4DIO5CGBeM=;
        b=DYVu/8Yl5d+fs/ALtuLk0NChuOszDlAOnox6JPgNk3gYDUATb6Hv/AtHrHRcoWguBswbke
        bQQRGUn4Q66Efo+y/4y6oFrvRXtK021St9lDb1X/UTElQLaLLUoQ+ZwSwq6ay6L0+9rMz0
        D4EygKMnW3BiwuL3N7p/SMqMGttmcUk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-lRTWxHpmO3eNzS0i2G_2iA-1; Sat, 07 May 2022 09:33:37 -0400
X-MC-Unique: lRTWxHpmO3eNzS0i2G_2iA-1
Received: by mail-qv1-f69.google.com with SMTP id d13-20020a05621421cd00b0045a99874ae5so8073334qvh.14
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 06:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XyotHlnPBZMTbWwbWZV56jLBQCGIO3aie4DIO5CGBeM=;
        b=D64aFuKyXVXx6uaZFg4HMMnJEzZWv+jpMWVpMMXt5naQvgHknYwflsc1aLB8g3LxZw
         t1cpPQT8fKHaSlNqZhssjHQwXMFQztmw0VjkLF+KoW5x44PJW33e4X0usFRekpYgNWzy
         w/xYT/Z9BC+u46/Z64NibjbCkI3PCjj/abEMZIjUloyS08TEIduYlt47YgN+tdcHZTmJ
         KfdbdimaFXbnUyOrgGMR7T4Bh5Voc7MVvDNQv6CeK/wglQ+uIHbtfRv4bQBH7ZiWyzol
         GqJdMdvErhOciAtvXjkpp0GVRO4xlFDcfBZWbHAjhhsabMuCeakK7W5FHj2IY07GMY2W
         acUA==
X-Gm-Message-State: AOAM530r6CLZHNSUdh9cCW8U/Nfb+K92bMugBlgLdOmO3zUzuaCK6dvU
        eHpKxZj1IX900Y7D2GFdaaSO8/qWdPp2/VNkcA4ROt914H4nCxfENhI/LRz+go6cWKNLEFKOEDI
        Zdjpb1YW1ldcm/HizKPA5dG+2Vw==
X-Received: by 2002:ac8:5f0d:0:b0:2f3:b0d6:fb6f with SMTP id x13-20020ac85f0d000000b002f3b0d6fb6fmr7300803qta.663.1651930417014;
        Sat, 07 May 2022 06:33:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxygjzsutNY00Piq+Q/Su60QU41qUNYOoCdOYhiBDj+IBvdTk7ZkR014dUPH0Ys1ohMGBtobQ==
X-Received: by 2002:ac8:5f0d:0:b0:2f3:b0d6:fb6f with SMTP id x13-20020ac85f0d000000b002f3b0d6fb6fmr7300787qta.663.1651930416789;
        Sat, 07 May 2022 06:33:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l6-20020a37f906000000b0069fc13ce23dsm4137451qkj.110.2022.05.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:33:36 -0700 (PDT)
Date:   Sat, 7 May 2022 21:33:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before
 run_test
Message-ID: <20220507133330.xxuw2x7buluhpnlu@zlang-mailbox>
Mail-Followup-To: Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
References: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 09:05:24PM +0800, Yang Xu wrote:
> If we run case on old kernel that doesn't support mount_setattr and
> then fail on our own function before call is_setgid/is_setuid function
> to reset errno, run_test will print "Function not implement" error.
> 
> We also check whether system support user namespace, so reset errno to
> zero after userns check.
> 
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This patchset bring in a new failure [1] on kernel 5.18.0-0.rc4+. Before I push,
just confirm that is it as your expected, not a regression ?

Thanks,
Zorro

[1]
# ./check generic/633
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-xxxxxxx-xx 5.18.0-0.rc4.20220427git46cf2c613f4b10e.35.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 27 13:03:32 UTC 2022
MKFS_OPTIONS  -- -f /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

generic/633 14s ... [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//generic/633.out.bad)
    --- tests/generic/633.out   2022-04-29 23:07:23.547501513 +0800
    +++ /root/git/xfstests/results//generic/633.out.bad 2022-05-07 21:20:40.205852662 +0800
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +idmapped-mounts.c: 8244: setgid_create_idmapped - No such file or directory - failure: linkat
    +idmapped-mounts.c: 14437: run_test - Success - failure: create operations in directories with setgid bit set on idmapped mounts
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/633.out /root/git/xfstests/results//generic/633.out.bad'  to see the entire diff)
Ran: generic/633
Failures: generic/633
Failed 1 of 1 tests

> v3->v4: move this reset step after sys_has_usersn()
>  src/idmapped-mounts/idmapped-mounts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index ce3f73be..2e94bf71 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -14232,6 +14232,8 @@ int main(int argc, char *argv[])
>  		exit(EXIT_SUCCESS);
>  	}
>  	t_has_userns = sys_has_userns();
> +	/* don't copy ENOSYS errno to child process on older kernel */
> +	errno = 0;
>  
>  	stash_overflowuid();
>  	stash_overflowgid();
> -- 
> 2.31.1
> 

