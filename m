Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1E6A18ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 10:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBXJhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 04:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBXJhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:37:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDE64D70;
        Fri, 24 Feb 2023 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677231422; x=1708767422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qh5dHIF3Zy/2vFiSSHWmzyQvmvJlUbTRwfF+WltTESk=;
  b=WDRmYASbnHMX3Ojs54SxtR4XRQJcnzIlqgO0LVMrqnnPuoTJUGcsDl+p
   q7lTPDO1RvYqMufhR4Swyq+ciCjFN5UzzFbTRdCIH31tMDTToidONCaWO
   wwVgFq3VlbhT2hZsgq6GRfavpzfa4627vKCHOGo6QjKSlXHo1GviywI04
   Jb9qM+kFi5zX1vpLGvmsqz9i7yiHw8qHcjyh8LDYOHTZlmViKL6GS+xfP
   lh2NK0dHo/LYlKDOQrSstBW12KHy/00lN/ngwTbVod68HxdA0UGoZc79o
   DbNRlqAFoks4I6NKWKYWyptQ8/jcGFitNemb/4umoWmXqr2tOM3Kgqt9/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331171606"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="331171606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 01:36:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741608912"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741608912"
Received: from rkris18-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.190])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 01:36:03 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C84DF10A581; Fri, 24 Feb 2023 12:36:00 +0300 (+03)
Date:   Fri, 24 Feb 2023 12:36:00 +0300
From:   kirill.shutemov@linux.intel.com
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, kvm@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, linmiaohe@huawei.com, luto@kernel.org,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        mingo@redhat.com, naoya.horiguchi@nec.com, pbonzini@redhat.com,
        qperret@google.com, rppt@kernel.org, seanjc@google.com,
        shuah@kernel.org, steven.price@arm.com, tabba@google.com,
        tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz,
        vkuznets@redhat.com, wanpengli@tencent.com, wei.w.wang@intel.com,
        x86@kernel.org, yu.c.zhang@linux.intel.com
Subject: Re: [RFC PATCH 1/2] mm: restrictedmem: Allow userspace to specify
 mount_path for memfd_restricted
Message-ID: <20230224093600.osmbpilmsi64wlwb@box.shutemov.name>
References: <20230216100150.yv2ehwrdcfzbdhcq@box.shutemov.name>
 <diqzsfex5hfv.fsf@ackerleytng-cloudtop.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <diqzsfex5hfv.fsf@ackerleytng-cloudtop.c.googlers.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:55:16AM +0000, Ackerley Tng wrote:
> 
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > On Thu, Feb 16, 2023 at 12:41:16AM +0000, Ackerley Tng wrote:
> > > By default, the backing shmem file for a restrictedmem fd is created
> > > on shmem's kernel space mount.
> 
> > > With this patch, an optional tmpfs mount can be specified, which will
> > > be used as the mountpoint for backing the shmem file associated with a
> > > restrictedmem fd.
> 
> > > This change is modeled after how sys_open() can create an unnamed
> > > temporary file in a given directory with O_TMPFILE.
> 
> > > This will help restrictedmem fds inherit the properties of the
> > > provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> > > binding hints, etc.
> 
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > ---
> > >   include/linux/syscalls.h           |  2 +-
> > >   include/uapi/linux/restrictedmem.h |  8 ++++
> > >   mm/restrictedmem.c                 | 63 +++++++++++++++++++++++++++---
> > >   3 files changed, 66 insertions(+), 7 deletions(-)
> > >   create mode 100644 include/uapi/linux/restrictedmem.h
> 
> > > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > > index f9e9e0c820c5..4b8efe9a8680 100644
> > > --- a/include/linux/syscalls.h
> > > +++ b/include/linux/syscalls.h
> > > @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int
> > > flags);
> > >   asmlinkage long sys_set_mempolicy_home_node(unsigned long start,
> > > unsigned long len,
> > >   					    unsigned long home_node,
> > >   					    unsigned long flags);
> > > -asmlinkage long sys_memfd_restricted(unsigned int flags);
> > > +asmlinkage long sys_memfd_restricted(unsigned int flags, const char
> > > __user *mount_path);
> 
> > >   /*
> > >    * Architecture-specific system calls
> 
> > I'm not sure what the right practice now: do we provide string that
> > contains mount path or fd that represents the filesystem (returned from
> > fsmount(2) or open_tree(2)).
> 
> > fd seems more flexible: it allows to specify unbind mounts.
> 
> I tried out the suggestion of passing fds to memfd_restricted() instead
> of strings.
> 
> One benefit I see of using fds is interface uniformity: it feels more
> aligned with other syscalls like fsopen(), fsconfig(), and fsmount() in
> terms of using and passing around fds.
> 
> Other than being able to use a mount without a path attached to the
> mount, are there any other benefits of using fds over using the path string?

It would be nice if anyone from fs folks comment on this.

> Should I post the patches that allows specifying a mount using fds?
> Should I post them as a separate RFC, or as a new revision to this RFC?

Let's first decide what the right direction is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
