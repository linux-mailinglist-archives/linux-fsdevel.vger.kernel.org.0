Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF67800E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 00:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355572AbjHQWL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 18:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355706AbjHQWLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:11:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F03A9A;
        Thu, 17 Aug 2023 15:11:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc6535027aso2427435ad.2;
        Thu, 17 Aug 2023 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310266; x=1692915066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pdn8ZDSU+rPV6ppPcgXHzQvQTsJ2JvZARdrVodBzFvI=;
        b=Rp0zR69UQLoBt1v5mo2rSyxCYnSlBdPz/ZH8QiQAAsmDwbA2xg83lJQDc0a72waPZ7
         k5DbDMcYA4vLUdrf1hNXNZEdBxfhDHqJSW6/9lDcEdJ/+nBMDjzWgxZ9eg90/hRt0nNV
         ZzILV235Kj571f3X3GuvtjOmYE6qUR1h51NG2j+IE/eVn5o2DlzdZevjuhEuctjo2pMA
         +qo2xDRnjrQJGXaiZgtHWPY0fcPCOtfJlEXwoZ6ayGngb1ooVkUNkb/8c2Grqltwbp2N
         9zLGAVNGzaPcNEpQaLhQiDoKXrluMK5BEWhSktvT7aTT6P9EQHiPK4e+W5b9g/n2Qxzg
         JZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310266; x=1692915066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdn8ZDSU+rPV6ppPcgXHzQvQTsJ2JvZARdrVodBzFvI=;
        b=M+EPzZbKlt8pwadeB6+w5//Xslx/3BbtoiNeLOlR599Nxq9tyOUFRTltKpCLKW37//
         qMsYicOiwZg1C4aePPneThvV/VVYXzoTKtlHaupxVBGfUzhw6h79dzU+z5m0NK123Cu+
         OlWDuqizCtbTBUV/EkJOEBqRezCaS35rgt21GxNoR902Zs3O+jlj9nXdrzg9Mfro6FJn
         9XtP/37h+QiSA4WfO9r485rOPnBOQeciTlXtAB1XNQ8k9u2gYYJgbnHpj1TwBmJqQ95D
         caQUhSSnYdr9sXiDejpFzuD0Y4BbdHz2bu16OVphuAjoPu+kKOrQdhBdJqX3ncqyz/gc
         KeJQ==
X-Gm-Message-State: AOJu0Ywr6PuzQpRBas+qoT8OpWFbWFFB3BuhJZwR544DJ+WFIJCORuCl
        3OWOovTmWTQlp5rpg7cM/z8=
X-Google-Smtp-Source: AGHT+IH9CTQPxls/ckyoXnpryTKNCctuNR4NLN4qq2q5dsCI0N1/VKk6p46dpdmH3U1D7QCziG3l8Q==
X-Received: by 2002:a17:902:bf47:b0:1be:f45c:bc38 with SMTP id u7-20020a170902bf4700b001bef45cbc38mr729196pls.2.1692310266001;
        Thu, 17 Aug 2023 15:11:06 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8d88])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b8b26fa6c1sm267290plk.115.2023.08.17.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:11:05 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:11:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Message-ID: <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815-feigling-kopfsache-56c2d31275bd@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
> > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > which allows to set a cgroup device program to be a device guard.
> 
> Currently we block access to devices unconditionally in may_open_dev().
> Anything that's mounted by an unprivileged containers will get
> SB_I_NODEV set in s_i_flags.
> 
> Then we currently mediate device access in:
> 
> * inode_permission()
>   -> devcgroup_inode_permission()
> * vfs_mknod()
>   -> devcgroup_inode_mknod()
> * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
>   -> devcgroup_check_permission()
> * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
>   -> devcgroup_check_permission()
> 
> All your new flag does is to bypass that SB_I_NODEV check afaict and let
> it proceed to the devcgroup_*() checks for the vfs layer.
> 
> But I don't get the semantics yet.
> Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
> is that a flag on random bpf programs? It looks like it would be the
> latter but design-wise I would expect this to be a property of the
> device program itself.

Looks like patch 4 attemps to bypass usual permission checks with:
@@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
        if (error)
                return error;

-       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-           !capable(CAP_MKNOD))
-               return -EPERM;
+       /*
+        * In case of a device cgroup restirction allow mknod in user
+        * namespace. Otherwise just check global capability; thus,
+        * mknod is also disabled for user namespace other than the
+        * initial one.
+        */
+       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
+               if (devcgroup_task_is_guarded(current)) {
+                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
+                               return -EPERM;
+               } else if (!capable(CAP_MKNOD))
+                       return -EPERM;
+       }

which pretty much sounds like authoritative LSM that was brought up in the past
and LSM folks didn't like it.

If vfs folks are ok with this special bypass of permissions in vfs_mknod()
we can talk about kernel->bpf api details.
The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely no go,
but no point going into bpf details now until agreement on bypass is made.
