Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920551FA5C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 03:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFPBz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 21:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFPBz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:55:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE937C061A0E;
        Mon, 15 Jun 2020 18:55:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so721532pju.3;
        Mon, 15 Jun 2020 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7lL6+Gx9T4fc8FO7k8drMdevbcmV6gSseFSR7jooStY=;
        b=s9UQsDYQw7CHhpJNeiG1fqZ+8vHFEZPqM0tlohLSmj2sl/AVeWnjGN8VSLmezYCWEI
         Q1qMfUkD3VxsXR17VzbJ6ir6lS8rt5AzgXLp4AW8oDHllQx62PRocWXHWMvBNmLKSFCP
         5hC2hQyFHHK1+9uXfzGqOpBK5bNnYiPASwz5jWBMSGCEiNaqCOLJ/CKgNtwX4egpz0ZA
         v2amUTwUuir1oQs3qigQLJnwGS3niP22liIzMxP+I7PktQOJuf5X+mMzBJxW3uokJuPl
         YFePMeJy+QsUaUrYUKQAS3lRs7/It3pYWPmIc2tbDD2q1cUcNCK386aY/sfOrJYY56MP
         4qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7lL6+Gx9T4fc8FO7k8drMdevbcmV6gSseFSR7jooStY=;
        b=lbr2IGH4fTBHxoOosjyEE+PTJEG2BWOsUr3HAbfgEs4+fIK66uu2pW5twQBjb3GfQw
         oLDSPNcDXlqLNo8NZvqqFSJ2yRQjDiJgsgwrnepaF2gWub2uHoEbe8QIGjtV59VsnBID
         1fA7YiqPwAHAH72dL+12S+qse1FKLfvj4ez0fsqx/RDQlbTWfAPPbhrhQh5yTSueSmSA
         y51+hi4dY6DL3hkynXUp8s5svgpSS9wHdQQlCMs+7YkMSoTiUGYyvqdRGpsO340GBnD8
         BbUB78Jdxaicc/mOo5X/ViA/oUCgXQXWg7XdiFjA2Q9HGfnWBLVEaAB1SZFD/qq4kse7
         tHjQ==
X-Gm-Message-State: AOAM533mfrVaIHAuNPRGzUid8VdNuWase3zQpsWtCeXymhJANOoJ8ZLO
        m1VME424AKdp1tO5daufke8=
X-Google-Smtp-Source: ABdhPJwgUDkcqmTUKhMvrsIth/LimqxsIB9UKGnzWzmzI5v5zHU5h86Cyo/00r+TvNxDXwN8gLnMRg==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr100817plr.64.1592272556065;
        Mon, 15 Jun 2020 18:55:56 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1a2c])
        by smtp.gmail.com with ESMTPSA id ca6sm635401pjb.46.2020.06.15.18.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 18:55:54 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:55:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
References: <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftaxd7ky.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 14, 2020 at 09:51:09AM -0500, Eric W. Biederman wrote:
> 
> There are some asperations to use fork_usermode_blob but no commitments
> that I can see to actually use this code.

huh? I've listed three projects with concrete timelines that are going to use
fork_usermode_blob.

> If someone who cares can step up so other developers don't have to deal
> with the maintenance problems, then there is no problem in keeping the
> code.

That code has been there for two years and wasn't causing 'maintenance
problems'. Quite the opposite was happening. Initial way of embedding blob
into ko has changed quite a bit thanks to work from Masahiro.
See commit 8e75887d321d ("bpfilter: include bpfilter_umh in assembly instead of using objcopy")

What is happening that this bit of code is somehow in a way of some refactoring
that you're doing (I'm not even sure what kind of refactoring you have in
mind), but instead of working with the community on the best ways to do this
refactoring you're arguing for removal just to avoid tweaking few lines of code.

> Now there is one technical issue I see that has implications for how
> this gets fixed.  The current implementation requires that 2 copies
> of the user mode executable be kept.
> 
> int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> 
> 
> The function fork_usermode_blob is passed an array and a length.  Today
> that array is stored in .rodata.  Not in a init section where it could
> be discared.

It's a one line change in bpfilter_umh_blob.S to make it .init section,
but for bpfilter init may not work.
For some ko init is appropriate for some other it's not.

> Now userspace in general and exec in particular requires the executable
> to be in a mmapable file.  So fork_usermode_blob creates a mini
> filesystem that only supports one file and no file names and opens
> a file within it, and passes that open file to exec.
> 
> If creation of the filesystem and copying of the data can be separated
> from the actual execution of the code, then there will be no need to
> keep 2 copies of the executable in memory.  If the file was also given a
> name there would be no need for fork_usermode_blob to open the file.
> All fork_usermode_blob would need to do is make make it possible for
> exec to find that file.
> 
> The implification this has for fixing the issues with exec is that once
> the file has a name fork_usermode_blob no longer needs to preopen the
> file and call do_execve_file.  Instead fork_usermode_blob can call
> do_execve.  Which means do_execve_file and all of it's strange corner
> cases can go away.
> 
> We have all of the infrastructure to decode a cpio in init/initramfs.c
> so it would be practically no code at all to place the code into a
> filesystem instead of just into a file at startup time.  At which
> point it could be guaranteed that the section the filesystem lives in is
> an init section and is not used past the point of loading it into a
> filesystem.  Making the code use half the memory.

Could you please re-read the explanation just up the thread:
https://lore.kernel.org/bpf/20200613033821.l62q2ed5ligheyhu@ast-mbp/
that goes into detail how bpfilter is invoking this blob.
Now explain how initramfs could work?
How bpfilter can load its blob when bpfilter.ko was loaded into
the kernel a day after boot ? Where is initramfs?
bpfilter can be normal ko and builtin. In both cases it cannot rely on
a path. That path may not exist. initramfs is not present after boot.
Any path based approach has serious disadvantages.
The ko cannot rely on an external fs hieararchy. The ko is a self contained
object. It has kernel and user code. A blob inside ko is like another kernel
function of that particular ko, but it runs in user space. The root fs could
have been corrupted but ko needs to be operational if it was builtin.

Another reason why single fs (initramfs or other) doesn't work is multiple
ko-s. Theoretically all ko-s can agree on dir layout, but ko-s are built and
loaded at different times. Say we put all possibles blobs from all ko-s into
some new special fs that is available during the boot and after the boot. In
such case the majority of that ram is going to be wasted. Since ko-s may not
need that blob to run or ko-s may not even load, but ram is wasted anyway.
All these show stoppers with fs and path were considered two years ago
when design of user mode blobs was done.
