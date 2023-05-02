Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64D96F3C75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 05:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjEBDie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjEBDib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 23:38:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934053581;
        Mon,  1 May 2023 20:38:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b67a26069so3803050b3a.0;
        Mon, 01 May 2023 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682998710; x=1685590710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9jeK1WbiwcypTGmla3kWNgoIrfPhM6KWaPpZ6YT+Bk=;
        b=XsJPAfcFHefELfP+zLqKYwE+euLdjM+gOZ9eOAFebg2yP4yAWVVVJUo8P83IgFURLf
         9N9J6k7rvDDFBs7rHQrBkE+h8BdPRT8CmImoNyrxoIQCbTk9XgoErMDmvIGIgOScSSgw
         ACsGCRj3OUZqa3wcWIScaAzruMtubAehdERyfwgtTbslvkuF5CaEcE/nItizOr1psEbV
         6AtVyN0wed3KM65+K9WuJNi6GzMy0uuvgHN/sZMP4Waj/61mNYfBOS1jj/8qu+zsJLMT
         RGCmC9yFjbCXRH7PpXmOallFPBEDb0+Gn3u/dyxGyo82YcOpg5yHSxm6bVYF7Hwxt4dR
         Z0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682998710; x=1685590710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9jeK1WbiwcypTGmla3kWNgoIrfPhM6KWaPpZ6YT+Bk=;
        b=OcApiRmmG8nCk1vza7NQOqc36fg1P429OhPNadLsSzNp2nFmwWEJ1PU4k6eK8oJgMx
         9G+MH9cweTYGTaE6ntUFzs1m/KbS/MuMAR9Dwpky6ptmihDuVYTVMbG70gQwoyF0EStH
         kLfDmgyDIHyzUH4rCrvU3lKsfPuxnGWApsmreOVGFRjUEAirDp5rhQNDjm9vgFn2ZDg4
         eGsQpEbcEvZ2cwu+d3H7/GY0OfPvFze+0EQoQqDp90peVkodAIMopIfF6kmPQ+CSVjfD
         D+dO/ZDtrLHnjVWSjrU1ppx2zM6MOmxiGq7VAUOgVuiuGvXKpALXjQ2g7nPKGN3tmBNQ
         5yNw==
X-Gm-Message-State: AC+VfDwpodrO3dhDwaP3NYWd6xozeHR2Yl8hnBUNDd24ivy20lf846J1
        wg0PUyWeKCUBcDjZmPOLAMWnnamPAw4=
X-Google-Smtp-Source: ACHHUZ68Q+sZJie50x8IkLzjGYZzCLAtUYbmqpoSIQ9PXxasFWP1mYSN3aOVLlxZN7rEd+blBqIflg==
X-Received: by 2002:a05:6a00:2ea6:b0:63f:24f1:adac with SMTP id fd38-20020a056a002ea600b0063f24f1adacmr24849208pfb.25.1682998709655;
        Mon, 01 May 2023 20:38:29 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:c9f6])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00199000b0063f1a27f2c9sm18778284pfl.70.2023.05.01.20.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 20:38:29 -0700 (PDT)
Date:   Mon, 1 May 2023 20:38:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>
Subject: Re: [RFC PATCH v3 08/37] fuse: Add fuse-bpf, a stacked fs extension
 for FUSE
Message-ID: <20230502033825.ofcxttuquoanhe7b@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230418014037.2412394-1-drosen@google.com>
 <20230418014037.2412394-9-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418014037.2412394-9-drosen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:40:08PM -0700, Daniel Rosenberg wrote:
> Fuse-bpf provides a short circuit path for Fuse implementations that act
> as a stacked filesystem. For cases that are directly unchanged,
> operations are passed directly to the backing filesystem. Small
> adjustments can be handled by bpf prefilters or postfilters, with the
> option to fall back to userspace as needed.

Here is my understanding of fuse-bpf design:
- bpf progs can mostly read-only access fuse_args before and after proper vfs
  operation on a backing path/file/inode.
- args are unconditionally prepared for bpf prog consumption, but progs won't
  be doing anything with them most of the time.
- progs unfortunately cannot do any real work. they're nothing but simple filters.
  They can give 'green light' for a fuse_FOO op to be delegated to proper vfs_FOO
  in backing file. The logic in this patch keeps track of backing_path/file/inode.
- in other words bpf side is "dumb", but it's telling kernel what to do with
  real things like path/file/inode and the kernel is doing real work and calling vfs_*.

This design adds non-negligible overhead to fuse when CONFIG_FUSE_BPF is set.
Comparing to trip to user space it's close to zero, but the cost of
initialize_in/out + backing + finalize is not free.
The patch 33 is especially odd.
fuse has a traditional mechanism to upcall to user space with fuse_simple_request.
The patch 33 allows bpf prog to return special return value and trigger two more
fuse_bpf_simple_request-s to user space. Not clear why.
It seems to me that the main assumption of the fuse bpf design is that bpf prog
has to stay short and simple. It cannot do much other than reading and comparing
strings with the help of dynptr.
How about we allow bpf attach to fuse_simple_request and nothing else?
All fuse ops call it anyway and cmd is already encoded in the args.
Then let bpf prog read fuse_args as-is (without converting them to bpf_fuse_args)
and avoid doing actual fuse_req to user space.
Also allow bpf prog acquire and remember path/file/inode.
The verifier is already smart enough to track that the prog is doing it safely
without leaking references and what not.
And, of course, allow bpf prog call vfs_* via kfuncs.
In other words, instead of hard coding
 +#define bpf_fuse_backing(inode, io, out,                             \
 +                      initialize_in, initialize_out,                 \
 +                      backing, finalize, args...)                    \
one for each fuse_ops in the kernel let bpf prog do the same but on demand.
The biggest advantage is that this patch set instead of 95% on fuse side and 5% on bpf
will become 5% addition to fuse code. All the logic will be handled purely by bpf.
Right now you're limiting it to one backing_file per fuse_file.
With bpf prog driving it the prog can keep multiple backing_files and shuffle
access to them as prog decides.
Instead of doing 'return BPF_FUSE_CONTINUE' the bpf progs will
pass 'path' to kfunc bpf_vfs_open, than stash 'struct bpf_file*', etc.
Probably will be easier to white board this idea during lsfmmbpf.

First 3 patches look fine. Thank you for resending them separately.
