Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042859DBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfH0Chd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 22:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfH0Chd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:37:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC527206E0;
        Tue, 27 Aug 2019 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566873452;
        bh=1IV2CM6ErWuo3N+yfdMw51ZAbsWRy4I36btniWe1qIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7Go3M99ctkACkffmRIl2U9APAA7HHwtwnMynerXPU5BSUSZR8Ru99vPmYSG2aJLa
         VYMoQrvB097EzDzv3sL6Ia+UOUks4qbnXOu6opjr96OAci7grhSLeKJjw2DQHJXYCK
         dRgXzahaJxb2PBjJQCuInQN+zjyswv+UYbfMBiFw=
Date:   Tue, 27 Aug 2019 11:37:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 01/19] skc: Add supplemental kernel cmdline
 support
Message-Id: <20190827113724.fa32ce580f5901004044d0f1@kernel.org>
In-Reply-To: <CAL_Jsq+Pm4D_fm+iG9UfGSObx2fSXshZuMW4QKwGePbg4RUEjA@mail.gmail.com>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
        <156678934990.21459.10847677747264952252.stgit@devnote2>
        <CAL_Jsq+Pm4D_fm+iG9UfGSObx2fSXshZuMW4QKwGePbg4RUEjA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Rob,

Thank you for your comment!

On Mon, 26 Aug 2019 08:27:48 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Aug 25, 2019 at 10:15 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Supplemental kernel command line (SKC) allows admin to pass a
> > tree-structured supplemental kernel commandline file (SKC file)
> > when boot up kernel. This expands the kernel command line in
> > efficient way.
> >
> > SKC file will contain some key-value commands, e.g.
> >
> > key.word = value1;
> > another.key.word = value2;
> >
> > It can fold same keys with braces, also you can write array
> > data. For example,
> >
> > key {
> >    word1 {
> >       setting1 = data;
> >       setting2;
> >    }
> >    word2.array = "val1", "val2";
> > }
> 
> Why invent a custom file format? You could use YAML (or JSON):

Yeah, actually my early idea was using JSON, since it is widely used and
many good tools. However, I thought that is not human friendly format :(.
I would like to give an easy to read/write but structured interface.

> 
> key:
>  word1:
>   setting1: data
>   setting2: true
>  word2:
>   - val1
>   - val2

(Ah, in above example "array" is just a part of key, and is not
a reserved word.)

> That would allow you to define a schema for defined options and can
> easily be manipulated with python (or any language with dictionaries
> and lists). That does imply adding a YAML parser to the kernel which
> I'm not sure is a great idea. There is a C parser lib, but working
> with YAML in C is not that great compared to python.

Yes, using plain YAML maybe requires user-space coverter to some
other format.

> 
> Another option would be using the DTS format, but as a separate file.
> That's not unprecedented as u-boot FIT image is a DTB. Then the kernel
> already has the parser. And you could still have schema now.

Yeah, that is what I consider at first. I discussed it with Frank at
OSSJ, but he suggested to not use DTS, nor touch current parser in kernel.
So I finally convinced not using DTS.

> A new interface will take a lot of bootloader work to make it easy to
> use given the user has to manually load some file in the bootloader
> and know a good address to load it to.

Right, that is what I have to do next if this is accepted. As I shown, I
modified Qemu and Grub. (Since U-Boot is very flexible, it is easy to
load skc file and modify bootargs by manual.)
What I found was, since the bootloaders already supported loading DTB,
it would not be so hard to add loading another file :)  (curiously, the
most complicated part was modifying kernel cmdline)

> Between that and rebuilding the
> kernel with the configuration, I'd pick rebuilding the kernel. Perhaps
> this version will highlight that the original proposal was not so bad.

Maybe for embedded, yes. For admins who use vendor kernel, no.

> Another thought, maybe you could process the configuration file that's
> in a readable/editable format into a flat representation that could
> simply be added to the kernel command line:

(BTW, it is easy to make a flat representation data as you can see
in /proc/sup_cmdline, which is added by [2/19])

> 
> key.word1.setting1=data key.word1.setting2 key.word2=val1,val2
> 
> That would then use an existing interface and probably simplify the
> kernel parsing.

Hmm, if it is just for passing extended arguments, that will be enough
(that was my first version of SKC, here 
https://github.com/mhiramat/skc/tree/5f0429c244d1c9f8f84711bc33e1e6f90df62df8 )

But I found that was not enough flexible for my usage. For expressing
complex ftrace settings (e.g. nesting options, some options related to
other options etc.), I need tree-structured data, something like Devicetree. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
