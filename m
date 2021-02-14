Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE90E31AFD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNJUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 04:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhBNJUx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 04:20:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CB2B64D73;
        Sun, 14 Feb 2021 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613294412;
        bh=IojP/99cv2KZA0UAqkGIVvcnNQXpAQrGnDSYSmISYMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggTE3epmRlYiZpCIulQqzfZIZLk/o9Hy+eMY/vtIj4RBJvlbLU6YBe6xW+nn3Nh9o
         MyYMRX8NGusIKQSvjXjeNrYN2FzXGXOOYKN32wbF5K9UR5i2fL54NWoZ4kzch8O1fz
         0j0N6t7YI6VhKfHIfT1MILdmaVlC+bJrUkGBAjCyOCyGfWtt4wmkaNl5ygGD55KRog
         FpJCiXGCmq9B5RiAfE9vA/ahNtHagvIeFYzLpSK837gPh4weRSFHUqNEb1+FAp4m0u
         60OF5nZHG/kKqrkEsLohg2nOPziZfAIwq4U8bxWTmen5x/8iLmJMxF5gj8klmC/iDZ
         Da8cagTHmtKmw==
Date:   Sun, 14 Feb 2021 11:19:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210214091954.GM242749@kernel.org>
References: <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <20210211112702.GI242749@kernel.org>
 <05082284-bd85-579f-2b3e-9b1af663eb6f@redhat.com>
 <20210211230910.GL242749@kernel.org>
 <a903338e-3d56-ff0a-4f4f-0f23db7ec0da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a903338e-3d56-ff0a-4f4f-0f23db7ec0da@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:18:19AM +0100, David Hildenbrand wrote:
> On 12.02.21 00:09, Mike Rapoport wrote:
> > On Thu, Feb 11, 2021 at 01:07:10PM +0100, David Hildenbrand wrote:
> > > On 11.02.21 12:27, Mike Rapoport wrote:
> > > > On Thu, Feb 11, 2021 at 10:01:32AM +0100, David Hildenbrand wrote:
> > > 
> > > So let's talk about the main user-visible differences to other memfd files
> > > (especially, other purely virtual files like hugetlbfs). With secretmem:
> > > 
> > > - File content can only be read/written via memory mappings.
> > > - File content cannot be swapped out.
> > > 
> > > I think there are still valid ways to modify file content using syscalls:
> > > e.g., fallocate(PUNCH_HOLE). Things like truncate also seems to work just
> > > fine.
> > These work perfectly with any file, so maybe we should have added
> > memfd_create as a flag to open(2) back then and now the secretmem file
> > descriptors?
> 
> I think open() vs memfd_create() makes sense: for open, the path specifies
> main properties (tmpfs, hugetlbfs, filesystem). On memfd, there is no such
> path and the "type" has to be specified differently.
> 
> Also, open() might open existing files - memfd always creates new files.

Yes, but still open() returns a handle to a file and memfd_create() returns
a handle to a file. The differences may be well hidden by e.g. O_MEMORY and
than features unique to memfd files will have their set of O_SOMETHING
flags.

It's the same logic that says "we already have an interface that's close
enough and it's fine to add a bunch of new flags there".
 
And here we come to the question "what are the differences that justify a
new system call?" and the answer to this is very subjective. And as such we
can continue bikeshedding forever.

-- 
Sincerely yours,
Mike.
