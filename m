Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D71FB841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbgFPPyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 11:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbgFPPyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:54:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74642C0613ED
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 08:54:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so21344845wro.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aDlbEbbNRivF3ebZedTH8Z8/FH+h6CNXcJR+iNKCKPU=;
        b=ME1VbzrxAlBBwHB1G/OhYY0V2n82GKbwpAk+OYZAtww0bAtsbbSlf4okMRpWh7j+Bg
         H27gXbFGmFm00VD4/LOcE7zFeAfyMelJFT43q9zRNfHMw8VvLQtsL2qEKBhRYS0rkzf8
         OObTbu0l1g0UXn03vOXV3J8AlULwUp5xOtwbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aDlbEbbNRivF3ebZedTH8Z8/FH+h6CNXcJR+iNKCKPU=;
        b=H6WGGGJCdv1Un012twgVdrsCTRyrToR7xyDtBUGAtnjTrmTlyBTpWS+wil0IaaEA+Q
         JW306StMhbHXuPOGkVbZWMcAdGeAI7q1OTS6YyUWJRl/I/YN2zCdp83F9/WcpEfbLflz
         ax553pAxeWN4XM/Qs2jZU1N6IZUwmDLjcIpK8Jm3r1oYCUsPAhSsAgKxfUp8vUpsjiCe
         VUIVmELSL63TiiUE2W2d8qlEEBRJvcLgyAl3lcWrVpXoLFgW3WalvBHGZ/s1qRZYU5Rr
         ZRaBsbeN2ilCe9ggPGy7g7W8WBExkXFTd1iZocsSpFv0F3DU4QxmEDyWtOQ/ezxSL/Yb
         M27A==
X-Gm-Message-State: AOAM5307jzuzPL2EXMXCeCivjvMpOw8TevBAH2rPQuYyAEWJLoZmROcq
        HnPFKd4zTgiMRqUV9Bs7uquTzg==
X-Google-Smtp-Source: ABdhPJw/xY99cSSYy1TOkNlqCb1a1X4k8XHZ1Cb/ZTrXyvdfJ05YS9wh9WeiDmqxcDUWD31BZdw5oA==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr3763512wrx.61.1592322875641;
        Tue, 16 Jun 2020 08:54:35 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id v6sm31576887wrf.61.2020.06.16.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 08:54:34 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 16 Jun 2020 17:54:33 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next 4/4] bpf: Add selftests for local_storage
Message-ID: <20200616155433.GA11971@google.com>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-5-kpsingh@chromium.org>
 <CAEf4BzY0=Hh3O6qeD=2sMWpQRpHpizxH+nEA0hD0khPf3VAbhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY0=Hh3O6qeD=2sMWpQRpHpizxH+nEA0hD0khPf3VAbhA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01-Jun 13:29, Andrii Nakryiko wrote:
> On Tue, May 26, 2020 at 9:34 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > inode_local_storage:
> >
> > * Hook to the file_open and inode_unlink LSM hooks.
> > * Create and unlink a temporary file.
> > * Store some information in the inode's bpf_local_storage during
> >   file_open.
> > * Verify that this information exists when the file is unlinked.
> >
> > sk_local_storage:
> >
> > * Hook to the socket_post_create and socket_bind LSM hooks.
> > * Open and bind a socket and set the sk_storage in the
> >   socket_post_create hook using the start_server helper.
> > * Verify if the information is set in the socket_bind hook.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
> >  .../selftests/bpf/progs/local_storage.c       | 139 ++++++++++++++++++
> >  2 files changed, 199 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
> >
> 
> [...]
> 
> > +struct dummy_storage {
> > +       __u32 value;
> > +};
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > +       __type(key, int);
> > +       __type(value, struct dummy_storage);
> > +} inode_storage_map SEC(".maps");
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> > +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
> > +       __type(key, int);
> > +       __type(value, struct dummy_storage);
> > +} sk_storage_map SEC(".maps");
> > +
> > +/* Using vmlinux.h causes the generated BTF to be so big that the object
> > + * load fails at btf__load.
> > + */
> 
> That's first time I hear about such issue. Do you have an error log
> from verifier?

Here's what I get when I do the following change.

--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -4,8 +4,8 @@
  * Copyright 2020 Google LLC.
  */
 
+#include "vmlinux.h"
 #include <errno.h>
-#include <linux/bpf.h>
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
@@ -37,24 +37,6 @@ struct {
        __type(value, struct dummy_storage);
 } sk_storage_map SEC(".maps");
 
-/* Using vmlinux.h causes the generated BTF to be so big that the object
- * load fails at btf__load.
- */
-struct sock {} __attribute__((preserve_access_index));
-struct sockaddr {} __attribute__((preserve_access_index));
-struct socket {
-       struct sock *sk;
-} __attribute__((preserve_access_index));
-
-struct inode {} __attribute__((preserve_access_index));
-struct dentry {
-       struct inode *d_inode;
-} __attribute__((preserve_access_index));
-struct file {
-       struct inode *f_inode;
-} __attribute__((preserve_access_index));

./test_progs -t test_local_storage
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 4488
str_off: 4488
str_len: 3012
btf_total_size: 7524

[1] STRUCT (anon) size=32 vlen=4
	type type_id=2 bits_offset=0
	map_flags type_id=6 bits_offset=64
	key type_id=8 bits_offset=128
	value type_id=9 bits_offset=192
[2] PTR (anon) type_id=4
[3] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[4] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=28
[5] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[6] PTR (anon) type_id=7
[7] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=1
[8] PTR (anon) type_id=3
[9] PTR (anon) type_id=10
[10] STRUCT dummy_storage size=4 vlen=1
	value type_id=11 bits_offset=0
[11] TYPEDEF __u32 type_id=12

  [... More BTF Dump ...]

[91] TYPEDEF wait_queue_head_t type_id=175

  [... More BTF Dump ...]

[173] FWD super_block struct
[174] FWD vfsmount struct
[175] FWD wait_queue_head struct
[106] STRUCT socket_wq size=128 vlen=4
	wait type_id=91 bits_offset=0 Invalid member

libbpf: Error loading .BTF into kernel: -22.
libbpf: map 'inode_storage_map': failed to create: Invalid argument(-22)
libbpf: failed to load object 'local_storage'
libbpf: failed to load BPF skeleton 'local_storage': -22
test_test_local_storage:FAIL:skel_load lsm skeleton failed
#81 test_local_storage:FAIL

The failiure is in:

[106] STRUCT socket_wq size=128 vlen=4
	wait type_id=91 bits_offset=0 Invalid member

> 
> Clang is smart enough to trim down used types to only those that are
> actually necessary, so too big BTF shouldn't be a thing. But let's try
> to dig into this and fix whatever issue it is, before giving up :)
> 

I was wrong about the size being an issue. The verifier thinks the BTF
is invalid and more specificially it thinks that the socket_wq's
member with type_id=91, i.e. typedef wait_queue_head_t is invalid. Am
I missing some toolchain patches?

- KP


> > +struct sock {} __attribute__((preserve_access_index));
> > +struct sockaddr {} __attribute__((preserve_access_index));
> > +struct socket {
> > +       struct sock *sk;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct inode {} __attribute__((preserve_access_index));
> > +struct dentry {
> > +       struct inode *d_inode;
> > +} __attribute__((preserve_access_index));
> > +struct file {
> > +       struct inode *f_inode;
> > +} __attribute__((preserve_access_index));
> > +
> > +
> 
> [...]
