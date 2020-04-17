Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29571ADE44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 15:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgDQN1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 09:27:19 -0400
Received: from verein.lst.de ([213.95.11.211]:57695 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbgDQN1T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:27:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2566768BFE; Fri, 17 Apr 2020 15:27:15 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:27:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200417132714.GA6401@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de> <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com> <20200415074514.GA1393@lst.de> <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, Apr 15, 2020 at 10:20:11AM +0200, Arnd Bergmann wrote:
> > I'd rather keep it out of this series and to
> > an interested party.  Then again x32 doesn't seem to have a whole lot
> > of interested parties..
> 
> Fine with me. It's on my mental list of things that we want to kill off
> eventually as soon as the remaining users stop replying to questions
> about it.
> 
> In fact I should really turn that into a properly maintained list in
> Documentation/... that contains any options that someone has
> asked about removing in the past, along with the reasons for keeping
> it around and a time at which we should ask about it again.

To the newly added x86 maintainers:  Arnd brought up the point that
elf_core_dump writes the ABI siginfo format into the core dump. That
format differs for i386 vs x32.  Is there any good way to find out
which is the right format when are not in a syscall?

As far a I can tell x32 vs i386 just seems to be based around what
syscall table was used for the current syscall, but core dumps aren't
always in syscall context.
