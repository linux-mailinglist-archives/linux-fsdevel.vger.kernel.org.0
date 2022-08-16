Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B505962E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiHPTLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiHPTLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442E7C773;
        Tue, 16 Aug 2022 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3XcZj58ibAYo7JZ+DBGHbio8/+pmx+vaIAoYTPhszo=; b=C3ggZZuTRiGe+co72VGz5WtuLJ
        dEtZCyVzUM/eFKokG1H5+2fq5HnCQW1/XI3EnYPaBS8QQO9lxUZ1VUrcCmag9//Qh8vNBLfpz1mMI
        wPIz1JuLFLurE6ZIBrsfqaJgC46BC+tsi/iCNppteb7Iq1x5WwTqSgflaHVjt80Oo7N5zxT3TE7ME
        D47v+hXMewesjsDdRS0l90YMCI+ctr26b2bcQMrDuMV6Ik31zqsKLqtPZE7xiBkUAxOrYhr8aM+3U
        v9TQa3ty7tM2bpDblyqo+kJk2VdOjZI+nsGlYX6risKRNaTbeuVXpiySdoN5yJ2RptQrlEc7NFx1l
        ZR3SyIng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO1yO-007GSa-01; Tue, 16 Aug 2022 19:11:32 +0000
Date:   Tue, 16 Aug 2022 20:11:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        jfs-discussion@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: Switching to iterate_shared
Message-ID: <Yvvr447B+mqbZAoe@casper.infradead.org>
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:58:36AM -0700, Linus Torvalds wrote:
> That said, our filldir code is still confusing as hell. And I would
> really like to see that "shared vs non-shared" iterator thing go away,
> with everybody using the shared one - and filesystems that can't deal
> with it using their own lock.
> 
> But that's a completely independent wart in our complicated filldir saga.
> 
> But if somebody were to look at that iterate-vs-iterate_shared, that
> would be lovely. A quick grep shows that we don't have *that* many of
> the non-shared cases left:
> 
>       git grep '\.iterate\>.*='
> 
> seems to imply that converting them to a "use my own load" wouldn't be
> _too_ bad.
> 
> And some of them might actually be perfectly ok with the shared
> semantics (ie inode->i_rwsem held just for reading) and they just were
> never converted originally.

What's depressing is that some of these are newly added.  It'd be
great if we could attach something _like_ __deprecated to things
that checkpatch could pick up on.

fs/adfs/dir_f.c:        .iterate        = adfs_f_iterate,
fs/adfs/dir_fplus.c:    .iterate        = adfs_fplus_iterate,

ADFS is read-only, so must be safe?

fs/ceph/dir.c:  .iterate = ceph_readdir,
fs/ceph/dir.c:  .iterate = ceph_readdir,

At least CEPH has active maintainers, cc'd

fs/coda/dir.c:  .iterate        = coda_readdir,

Would anyone notice if we broke CODA?  Maintainers cc'd anyway.

fs/exfat/dir.c: .iterate        = exfat_iterate,

Exfat is a new addition, but has active maintainers.

fs/jfs/namei.c: .iterate        = jfs_readdir,

Maintainer cc'd

fs/ntfs/dir.c:  .iterate        = ntfs_readdir,         /* Read directory contents. */

Maybe we can get rid of ntfs soon.

fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,
fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,

maintainers cc'd

fs/orangefs/dir.c:      .iterate = orangefs_dir_iterate,

New; maintainer cc'd

fs/overlayfs/readdir.c: .iterate        = ovl_iterate,

Active maintainer, cc'd

fs/proc/base.c: .iterate        = proc_##LSM##_attr_dir_iterate, \

Hmm.  We need both SMACK and Apparmor to agree to this ... cc's added.

fs/vboxsf/dir.c:        .iterate = vboxsf_dir_iterate,

Also newly added.  Maintainer cc'd.
