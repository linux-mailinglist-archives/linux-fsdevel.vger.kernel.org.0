Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C316440C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBSMSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 07:18:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSMSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:18:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 342B7B0E6;
        Wed, 19 Feb 2020 12:18:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A715FDA838; Wed, 19 Feb 2020 13:18:04 +0100 (CET)
Date:   Wed, 19 Feb 2020 13:18:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marco Elver <elver@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: fix a data race in i_size_write/i_size_read
Message-ID: <20200219121804.GV2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Marco Elver <elver@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200219045228.GO23230@ZenIV.linux.org.uk>
 <EDCBB5B9-DEE4-4D4B-B2F4-F63179977D6C@lca.pw>
 <20200219052329.GP23230@ZenIV.linux.org.uk>
 <CANpmjNM=+y-OwKjtsjsEkwPjpHXpt7ywaE48JyiND6dKt=Vf1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM=+y-OwKjtsjsEkwPjpHXpt7ywaE48JyiND6dKt=Vf1Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:21:46AM +0100, Marco Elver wrote:
> Right. In reality, for mainstream architectures, it appears quite unlikely.
> 
> There may be other valid reasons, such as documenting the fact the
> write can happen concurrently with loads.
> 
> Let's assume the WRITE_ONCE can be dropped.
> 
> The load is a different story. While load tearing may not be an issue,
> it's more likely that other optimizations can break the code. For
> example load fusing can break code that expects repeated loads in a
> loop. E.g. I found these uses of i_size_read in loops:
> 
> git grep -E '(for|while) \(.*i_size_read'
> fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
> fs/ocfs2/dir.c:                 for (i = 0; i < i_size_read(inode) &&
> i < offset; ) {
> fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
> fs/ocfs2/dir.c:         while (ctx->pos < i_size_read(inode)
> fs/squashfs/dir.c:      while (length < i_size_read(inode)) {
> fs/squashfs/namei.c:    while (length < i_size_read(dir)) {
> 
> Can i_size writes happen concurrently, and if so will these break if
> the compiler decides to just do i_size_read's load once, and keep the
> result in a register?

It depends on the semantics and the behaviour when the value is not
cached in a register might be the wrong one. A concrete example with
assembly and analysis can be found in d98da49977f6 ("btrfs: save i_size
to avoid double evaluation of i_size_read in compress_file_range"),
which is the workardound mentioned in the my other mail.

C:
    actual_end = min_t(u64, i_size_read(inode), end + 1);

Asm:

        mov    0x20(%rsp),%rax
        cmp    %rax,0x48(%r15)           # read
        movl   $0x0,0x18(%rsp)
        mov    %rax,%r12
        mov    %r14,%rax
        cmovbe 0x48(%r15),%r12           # eval
    
      Where r15 is inode and 0x48 is offset of i_size.
    
      The original fix was to revert 62b37622718c that would do an
      intermediate assignment and this would also avoid the doulble
      evaluation but is not future-proof, should the compiler merge the
      stores and call i_size_read anyway.
    
      There's a patch adding READ_ONCE to i_size_read but that's not being
      applied at the moment and we need to fix the bug. Instead, emulate
      READ_ONCE by two barrier()s that's what effectively happens. The
      assembly confirms single evaluation:
    
        mov    0x48(%rbp),%rax          # read once
        mov    0x20(%rsp),%rcx
        mov    $0x20,%edx
        cmp    %rax,%rcx
        cmovbe %rcx,%rax
        mov    %rax,(%rsp)
        mov    %rax,%rcx
        mov    %r14,%rax
    
      Where 0x48(%rbp) is inode->i_size stored to %eax.
