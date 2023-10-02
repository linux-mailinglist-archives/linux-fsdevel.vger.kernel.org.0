Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601AE7B5773
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjJBPqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbjJBPq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:46:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93DCB8
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:46:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405505b07dfso19101745e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696261584; x=1696866384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GpMdvzAhSdXiBMXOyN3F1QMGpt/m//1LDMJoTB334A=;
        b=ZrF4qCCJOkE1NbJu85xCV7Aw9uMwnjHr9keoXCpj2emPn/Z//eQnhb6qL9U0pYSBZD
         ix2Yl5Sn2J/ecHuIKoPcPniQ6eA0zjRD3BbTTEdfLd1YyEqgHmdKx1VZbIccwg3l9DhC
         QhyN8Vxz2YW0I4GXEZUDojrGmge5C/u3IFR3imI8VbNZ7yATaaKeCBggHtCaZUZnubYr
         JYZRbWuFTdEmY6owceXSgzRofke/dcy5fbFzm0oF7tZCUlELPNTLEvlbxTxQ+uFyngkm
         kbMuTmOBjFCqU+ET1NEFHl5cA2csLbn/l7ASNXYfltMLKAaLcdEqSAYOFnjtPkp32yUT
         2Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261584; x=1696866384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GpMdvzAhSdXiBMXOyN3F1QMGpt/m//1LDMJoTB334A=;
        b=Db4iA9/fQgt1BPibM+3K8RhmdEYmRTMoTWT8l56z3gRRqFf/vRjEtEkWn7BREbNKCm
         H2T7ir2mbmt3t4b3YYJRQKt99qpfzoFXABMhiTF+G1+uPRlcJtO8vxLgoVQnnwXCtO+j
         i4A8Q5hx5kwW7IWjoLUmJaVUoQQ36nXYjsMbnRFO9X5zTlNX5m4qg5mGy5Ny1XT1B84/
         2LKPsuVWpeHyukJMWq9yphNqQIIjIEngO0PaomRj4PzTocKZzvBE2g/HzFefmov/K8zb
         dp+9q7dKZ0hXthQuE3iMi0lcLlh0/AzwjNjkeKTKPLXocEAs3IT8pvHt5HjAzEca/lsq
         wWQg==
X-Gm-Message-State: AOJu0YxBNtD5N+fSeeuPnbyVk/01Hc8d5BZdUZtLkwooO0/oJ9YjKnlG
        kCEGsrlI77WP+D1y/cQxBkEgI7luT0Kj9kOBqHWqwA==
X-Google-Smtp-Source: AGHT+IGEVLTkfWI+L/ulZiTspdc5BVdb2gZ1malMtYF9uJmeShnHEQls1etvNfmxXXXmazmJYi3tfR+ki49hFstKvsI=
X-Received: by 2002:a5d:6d47:0:b0:317:6579:2b9f with SMTP id
 k7-20020a5d6d47000000b0031765792b9fmr2579wri.30.1696261583969; Mon, 02 Oct
 2023 08:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
In-Reply-To: <ZRrf8NligMzwqx97@x1n>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 2 Oct 2023 16:46:11 +0100
Message-ID: <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 4:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> > In case we cannot simply remap the page, the fallback sequence (from th=
e
> > cover letter) would be triggered.
> >
> > 1) UFFDIO_COPY
> > 2) MADV_DONTNEED
> >
> > So we would just handle the operation internally without a fallback.
>
> Note that I think there will be a slight difference on whole remap
> atomicity, on what happens if the page is modified after UFFDIO_COPY but
> before DONTNEED.
>
> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
> during movement, and it will generate a missing event after moved, with
> latest data showing up on dest.
>
> I'm not sure that means such a fallback is a problem, Suren may know
> better with the use case.

Although there is no problem in using fallback with our use case but
as a user of userfaultfd, I'd suggest leaving it to the developer.
Failing with appropriate errno makes more sense. If handled in the
kernel, then the user may assume at the end of the operation that the
src vma is completely unmapped. And if not correctness issues, it
could lead to memory leaks.
>
> Thanks,
>
> --
> Peter Xu
>
