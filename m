Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58B2A2F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKBQJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 11:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgKBQJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:09:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BBC0617A6;
        Mon,  2 Nov 2020 08:09:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a15so6072860edy.1;
        Mon, 02 Nov 2020 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nfN3QcfqlNQ/KRixrR6/8rKzeiq3SlnS4nAb0fL8XbI=;
        b=U0CAuZsmjo7NIWeEOvIRP65Q9siKINj6bTI7b41mKBCLBMx7oWApQ0rtltjab98VTk
         Syh5PXkTyDytXZq5ED14yCXmKX+qUhw/vrrXuDVC7iyzVsMLgDPhs8HqfMchYNoeDxHb
         kmpQ5sxFVAG2R4yPProp7IcbK7t/aWB6mggTA+F3JZdsnnL2wrM7yPw752CuWd28hf3u
         DXaesC+Eslw4K4VYl5hoZf7ZfDiAuNPca1qJrlMYle7MLodYXUHEeXDiGoXvKWDZ8b23
         v0E0GYovrgd3XKdYqny7l8Id0oEyAjCtqUOdqVCn1fvg/OQ7QIpZAeq/hGwAUHYlrfOh
         V2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nfN3QcfqlNQ/KRixrR6/8rKzeiq3SlnS4nAb0fL8XbI=;
        b=BdZcBHa/ClQJSo/urWXj3DwZA90PIZx+ta23+48l9nY4/ArubTYzXW71mWwbrUMJFb
         9wE9olgsoabblIvtwUxykyJBOu2ehjfT7GaBnSPjxzn2Z75+xlS+iyR0iTVC+9d8rcU9
         V3aR0j+6PrTGIiJfDc3m+Jp1J57ynMm4kGoJU0BiUyatVDM+BMu6BngI76Qo2W54eOZg
         nbJLC5Y3XjVO7a7rElD3cM+mORiVYU77nqm7L0qKH/ltik7DT1+Oj8URxjPMN1PDoBSc
         ogO4y0kbHIWQ9NxrGAJ+vLylSNrMCVUEv55HJYNvBkO8PzeCEA6uKYM4pvJMmwr1OsHV
         RfcA==
X-Gm-Message-State: AOAM533JiFMnLTJEZoTcqQk39IZBMT9cuy33AHIp10ZyXiTLKRlJ49Do
        lSw8Qn4FOTu+IRqiGIXZEjXyahL7LmIGgDpnxrc/zMXFYGrTGg==
X-Google-Smtp-Source: ABdhPJzI8tSmWBQ9AN/oEvg73ftgJOJ3U4B1b3sC9C+PtRqOsQgrfKuBLPMLgJE6ySL1o65qh1Wdo3ZryvbtOcAY/d8=
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr17876521edb.52.1604333379256;
 Mon, 02 Nov 2020 08:09:39 -0800 (PST)
MIME-Version: 1.0
From:   Eric Curtin <ericcurtin17@gmail.com>
Date:   Mon, 2 Nov 2020 16:09:28 +0000
Message-ID: <CANpvso6CMkQjnH2FFMM9WxuQcf9q7DtW6DWaPmmaGNX+uuC2Lg@mail.gmail.com>
Subject: Solving the portable binaries problem in the elf loader
To:     Kernel development list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     Eric Curtin <ericcurtin17@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guys,

I remember watching this YouTube video years ago and something Linus
said really stuck with me:

https://www.youtube.com/watch?v=5PmHRSeA2c8

It was around the whole binaries, package management problem, because
it's been something that has been troublesome for me, building separate
binaries for separate Linux platforms.

I've examined the various efforts to fix this: flatpack, snap,
AppImage, FatELF, docker etc. The kindof solve the problem but not
100%, some aspects of their approaches are nice. I think this
problem can be addressed in the ELF loader. By the way I don't claim to
be an expert on ELF, I know just enough to do my job.

So ELF tends to depend on a filename with a version embedded in the
filename to determine if the shared library is the correct one to load,
/bin/true example:

  ldd /bin/true
  linux-vdso.so.1 (0x00007ffe0218a000)
  libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f47086c9000)
  /lib64/ld-linux-x86-64.so.2 (0x00007f47088e5000)

What if instead of depending on a filename on determining if the
library is the correct version, we used a checksum (like a SHA or
something even cheaper) taking a little influence from how git
determines if patches are valid, this is a relatively cheap operation:

  time sha1sum /lib/x86_64-linux-gnu/libc-2.31.so
  4fcd76645607f38d91f65654ddd6b9770b5ea54a  /lib/x86_64-linux-gnu/libc-2.31.so

  real 0m0.008s
  user 0m0.008s
  sys    0m0.001s

You could store a volatile cache of checksummed libraries in memory to
ensure you don't do this more than once for each inode that contains a
library.

package managers generally add their own versioning system, because
kernelspace doesn't really give you one. With this ELF loading feature
you now have that. It also opens up the possibility of distributing
binaries and libraries in a more P2P fashion as a checksum is core to
the ELF loading process.

If this feature was added I think it would percolate down to the
various distros, package managers in time.

The end product would be more cross-platform binaries, without doing
tricks like fat binaries. In code you could maintain backwards
compatibility like:

  if (legacy_elf) {
    load_libraries_based_on_filename;
    return 0;
  }

  load_libraries_based_on_checksum;

I wouldn't mind hearing thoughts from Linus on this as it fixes many of
the problems he mentions like:

"you don't make binaries for Linux you, make binaries for Fedora 19 for
Oh 20, maybe there's even like rl5 from ten year ago"

with the checksummed library approach you fix this problem. When you
execute the binary and if it doesn't have all the checksummed libraries
available you pull a library with the correct checksum.

"using shared libraries is not an option when the libraries are
experimental and the libraries are used by two people and one of them
is crazy so every other day some ABI breaks right so"

Fixes this problem because you embed checksums for the libraries you
want your binary to load, of course you must update that checksum in
the main binary if you want to upgrade. That actually doesn't seem
like a huge problem as checksums are fixed width.

"they break binary compatibility left and right they update glibc and
everything breaks you a you can"

again, the checksums fix this.

"can't have application writers do 15 billion different versions"

I think if you centralize how versioning is done by using checksums in
the elf loader you relieve this problem.

"I also guarantee you that every single desktop distribution will care
about Valve binaries so the problem is valve will build everything
statically linked and create huge binaries"

You are still using dynamic linking using this model, so this problem
is solved.

I could keep going but I think it solves most of the problems he
talks about (and I tend to have the same problems), I think it could be
solved in the ELF loader. Anybody see potential here? I'd greatly
appreciate feedback.

As a side effect you also gain more security around loading libraries,
although that's not the problem I was trying to solve here, it's the
many builds, portable binaries problem I'm trying to poke.

Might even save the environment a little, many more builds of binaries
around the world than needed, the checksum when dynamically
linking/loading seems like a fair tradeoff.
