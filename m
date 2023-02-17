Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0F69A55F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 06:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBQFwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 00:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBQFwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:52:47 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7F4A1F7;
        Thu, 16 Feb 2023 21:52:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u22so475009lfu.5;
        Thu, 16 Feb 2023 21:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhKEcQNHLahXXVVAZN/VNTQNbuPo76AKJbBDzHJgOUc=;
        b=i4sVg3Rt5qkkB82twz6yJ7yklKP63AMrO5uciaCNTatfIbYzWS8W0yu9GSv9ssFqJB
         hosNtRGyWss72q3YGpVwmbaVKxVGu6atglPUQ/iglRVjU/wKcYx9h1WYpbV1FM/lCHRi
         Zad6gTaXNW7kYPhkIASR/UVWUfK6C67bp+sJj9VwVe9Y28DxA4wp5mn51ejjbXNXzuze
         wWkJvUlmizecxndGdkkm81ywSm4nrISQpOdnP/rk1rzeqhfpQ+spGUrXp81aRucPBEuE
         sb8XK4ZASIte04pVDASai2uT0gRiFnn4/T4mWeLedzZIM+BCArUR8RqopmLVtaJA7wDY
         brpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhKEcQNHLahXXVVAZN/VNTQNbuPo76AKJbBDzHJgOUc=;
        b=4obSH3oPWr12TeO/dfb4ipvZOrFIeesTdS686Uv/y0jJUeVAmMZuz1iJmmTL7EK0JK
         7JspqJCs/+UNkH/cxoiDBRKXW7+kFMiYI0nZr4YnoJCzXZH1Bi5uZXktLagYic+UdXyM
         pEP5I6BeKh1C/9+D65PiVQtAapinOc0/IeAXsyiYlqQ0gRicZ5lWQi/xTtUt1T5iOpwH
         Bfl+ijyXDUD2DimaGksERmNSvad0UYmFQldMvEgQ9l8kFYlpn4kvgr7tVOhBlkuhkxEl
         LQpctjUOIyCxw56wfdBM/UozcqFlrej+3FGeO6P9zUfMHuYdO7ePrQe6JcpR69hTXSAw
         N50A==
X-Gm-Message-State: AO0yUKVhn/y6/lsvpQhKA9iv7uMZrfPDQns0T76+GkNvdpobg3kmj9Q0
        jgHzs0HlATmYvtIRasPn6WwYveEnNECcSmuw8q0=
X-Google-Smtp-Source: AK7set/cB6L3GkTNc49elZ1VVrbsKguVoD4zFbvB6iRnustoBN4+jp+084rglthKUbV/WhcVCix1pklnzzgNYJB23eA=
X-Received: by 2002:a05:6512:501:b0:4d5:ca32:7bc3 with SMTP id
 o1-20020a056512050100b004d5ca327bc3mr78862lfb.10.1676613163893; Thu, 16 Feb
 2023 21:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20230216214745.3985496-1-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Feb 2023 23:52:32 -0600
Message-ID: <CAH2r5mtXfAF19zrRzoLCnHYK593L8HyFTScw-FeaB=Mt7Wj0AQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] smb3: Use iov_iters down to the network transport
 and fix DIO page pinning
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tentatively merged the first 13 of this series into cifs-2.6.git
for-next (pending additional testing and any more review comments)

On Thu, Feb 16, 2023 at 3:47 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Steve,
>
> Here's an updated version of my patchset to make the cifs/smb3 driver pass
> iov_iters down to the lowest layers where they can be passed directly to
> the network transport rather than passing lists of pages around.
>
> The series deals with the following issues:
>
>  (-) By pinning pages, it fixes the race between concurrent DIO read and
>      fork, whereby the pages containing the DIO read buffer may end up
>      belonging to the child process and not the parent - with the result
>      that the parent might not see the retrieved data.
>
>  (-) cifs shouldn't take refs on pages extracted from non-user-backed
>      iterators (eg. KVEC).  With these changes, cifs will apply the
>      appropriate cleanup.  Note that there is the possibility the network
>      transport might, but that's beyond the scope of this patchset.
>
>  (-) Making it easier to transition to using folios in cifs rather than
>      pages by dealing with them through BVEC and XARRAY iterators.
>
> The first five patches add two facilities to the VM/VFS core, excerpts from
> my iov-extract branch[1] that are required in order to do the cifs
> iteratorisation:
>
>  (*) Future replacements for file-splicing in the form of functions
>      filemap_splice_read() and direct_splice_read().  These allow file
>      splicing to be done without the use of an ITER_PIPE iterator, without
>      the need to take refs on the pages extracted from KVEC/BVEC/XARRAY
>      iterators.  This is necessary to use iov_iter_extract_pages().
>
>      [!] Note that whilst these are added in core code, they are only used
>      by cifs at this point.
>
>  (*) Add iov_iter_extract_pages(), a replacement for iov_iter_get_pages*()
>      that uses FOLL_PIN on user pages (IOVEC, UBUF) and doesn't pin kernel
>      pages (BVEC, KVEC, XARRAY).  This allows cifs to do the page pinning
>      correctly.
>
>      [!] Note that whilst this is added in core code, it is only used by
>      cifs at this point - though a corresponding change is made to the
>      flags argument of iov_iter_get_pages*() so that it doesn't take FOLL_*
>      flags, but rather takes iov_iter_extraction_t flags that are
>      translated internally to FOLL_* flags.
>
> Then there's a couple of patches to make cifs use the new splice functions.
>
> The series continues with a couple of patches that add stuff to netfslib
> that I want to use there as well as in cifs:
>
>  (*) Add a netfslib function to extract and pin pages from an ITER_IOBUF or
>      ITER_UBUF iterator into an ITER_BVEC iterator.
>
>  (*) Add a netfslib function to extract pages from an iterator that's of
>      type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a scatterlist.
>      The cleanup will need to be done as for iov_iter_extract_pages().
>
>      BVEC, KVEC and XARRAY iterators can be rendered into elements that
>      span multiple pages.
>
> Added to that are some cifs helpers that work with iterators:
>
>  (*) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
>      add elements to an RDMA SGE list.  Only the DMA addresses are stored,
>      and an element may span multiple pages (say if an xarray contains a
>      multipage folio).
>
>  (*) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
>      pass the contents into a shash function.
>
>  (*) Add functions to walk through an ITER_XARRAY iterator and perform
>      various sorts of cleanup on the folios held therein, to be used on I/O
>      completion.
>
>  (*) Add a function to read from the transport TCP socket directly into an
>      iterator.
>
> Finally come the patches that actually do the work of iteratorising cifs:
>
>  (*) The main patch.  Replace page lists with iterators.  It extracts the
>      pages from ITER_UBUF and ITER_IOVEC iterators to an ITER_BVEC
>      iterator, pinning or getting refs on them, before passing them down as
>      the I/O may be done from a worker thread.
>
>      The iterator is extracted into a scatterlist in order to talk to the
>      crypto interface or to do RDMA.
>
>  (*) In the cifs RDMA code, extract the iterator into an RDMA SGE[] list,
>      removing the scatterlist intermediate - at least for smbd_send().
>      There appear to be other ways for cifs to talk to the RDMA layer that
>      don't go through that that I haven't managed to work out.
>
>  (*) Remove a chunk of now-unused code.
>
>  (*) Allow DIO to/from KVEC-type iterators.
>
> I've pushed the patches here also:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs
>
> David
>
> Link: https://lore.kernel.org/r/20230214171330.2722188-1-dhowells@redhat.com/ [1]
> Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/20230131182855.4027499-1-dhowells@redhat.com/ # v1
>
> David Howells (17):
>   mm: Pass info, not iter, into filemap_get_pages()
>   splice: Add a func to do a splice from a buffered file without
>     ITER_PIPE
>   splice: Add a func to do a splice from an O_DIRECT file without
>     ITER_PIPE
>   iov_iter: Define flags to qualify page extraction.
>   iov_iter: Add a function to extract a page list from an iterator
>   splice: Export filemap/direct_splice_read()
>   cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
>   netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
>   netfs: Add a function to extract an iterator into a scatterlist
>   cifs: Add a function to build an RDMA SGE list from an iterator
>   cifs: Add a function to Hash the contents of an iterator
>   cifs: Add some helper functions
>   cifs: Add a function to read into an iter from a socket
>   cifs: Change the I/O paths to use an iterator rather than a page list
>   cifs: Build the RDMA SGE list directly from an iterator
>   cifs: Remove unused code
>   cifs: DIO to/from KVEC-type iterators should now work
>
>  block/bio.c               |    6 +-
>  block/blk-map.c           |    8 +-
>  fs/cifs/Kconfig           |    1 +
>  fs/cifs/cifsencrypt.c     |  172 +++-
>  fs/cifs/cifsfs.c          |   12 +-
>  fs/cifs/cifsfs.h          |    6 +
>  fs/cifs/cifsglob.h        |   66 +-
>  fs/cifs/cifsproto.h       |   11 +-
>  fs/cifs/cifssmb.c         |   15 +-
>  fs/cifs/connect.c         |   14 +
>  fs/cifs/file.c            | 1772 ++++++++++++++++---------------------
>  fs/cifs/fscache.c         |   22 +-
>  fs/cifs/fscache.h         |   10 +-
>  fs/cifs/misc.c            |  128 +--
>  fs/cifs/smb2ops.c         |  362 ++++----
>  fs/cifs/smb2pdu.c         |   53 +-
>  fs/cifs/smbdirect.c       |  535 ++++++-----
>  fs/cifs/smbdirect.h       |    7 +-
>  fs/cifs/transport.c       |   54 +-
>  fs/netfs/Makefile         |    1 +
>  fs/netfs/iterator.c       |  371 ++++++++
>  fs/splice.c               |   93 ++
>  include/linux/fs.h        |    6 +
>  include/linux/netfs.h     |    8 +
>  include/linux/pipe_fs_i.h |   20 +
>  include/linux/uio.h       |   35 +-
>  lib/iov_iter.c            |  284 +++++-
>  mm/filemap.c              |  156 +++-
>  mm/internal.h             |    6 +
>  mm/vmalloc.c              |    1 +
>  30 files changed, 2515 insertions(+), 1720 deletions(-)
>  create mode 100644 fs/netfs/iterator.c
>


-- 
Thanks,

Steve
