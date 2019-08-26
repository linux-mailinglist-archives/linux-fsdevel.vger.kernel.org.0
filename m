Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255209D082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfHZN2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 09:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbfHZN2C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:28:02 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F203121872;
        Mon, 26 Aug 2019 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566826081;
        bh=VjxUxDnVuRk1DSTLUCljhelqYMjetMiX0Jgtit+/pPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eAitVO3YoyuYVrg7Km4FZM80GaTZmMfF8XtM3rxdRoM6HhgSMSp2F9PG0ox13+4Cy
         3fjRHYFpb+2S9sIgjempVLcUAjTm/MvWf1sYpH72WDCqbDiRgxekXMPhys7WQGW4Ln
         XZUZxUL3UphvQDnUcW5hAb9oFOzsOY2T2DRowQ2Q=
Received: by mail-qt1-f171.google.com with SMTP id y26so17842245qto.4;
        Mon, 26 Aug 2019 06:28:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUrgrlGqxFau6Fykf+oqttbW9HsDb+GPMxsLjdi9MP4BrloV/Wg
        gi2+fB35edzSPmXhNP0pyLW23d+8QuGaLN1yUw==
X-Google-Smtp-Source: APXvYqyW4dx7oo0NyfH+v5v1S1mxW/IB4r3yTuAklXjRgYFmYC3NHSt4KOPNnz1iCNqEuKQUONG7lWxDvV5wx6aOu1E=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr17690228qtc.110.1566826080079;
 Mon, 26 Aug 2019 06:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <156678933823.21459.4100380582025186209.stgit@devnote2> <156678934990.21459.10847677747264952252.stgit@devnote2>
In-Reply-To: <156678934990.21459.10847677747264952252.stgit@devnote2>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Aug 2019 08:27:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Pm4D_fm+iG9UfGSObx2fSXshZuMW4QKwGePbg4RUEjA@mail.gmail.com>
Message-ID: <CAL_Jsq+Pm4D_fm+iG9UfGSObx2fSXshZuMW4QKwGePbg4RUEjA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/19] skc: Add supplemental kernel cmdline support
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:15 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Supplemental kernel command line (SKC) allows admin to pass a
> tree-structured supplemental kernel commandline file (SKC file)
> when boot up kernel. This expands the kernel command line in
> efficient way.
>
> SKC file will contain some key-value commands, e.g.
>
> key.word = value1;
> another.key.word = value2;
>
> It can fold same keys with braces, also you can write array
> data. For example,
>
> key {
>    word1 {
>       setting1 = data;
>       setting2;
>    }
>    word2.array = "val1", "val2";
> }

Why invent a custom file format? You could use YAML (or JSON):

key:
 word1:
  setting1: data
  setting2: true
 word2:
  - val1
  - val2


That would allow you to define a schema for defined options and can
easily be manipulated with python (or any language with dictionaries
and lists). That does imply adding a YAML parser to the kernel which
I'm not sure is a great idea. There is a C parser lib, but working
with YAML in C is not that great compared to python.

Another option would be using the DTS format, but as a separate file.
That's not unprecedented as u-boot FIT image is a DTB. Then the kernel
already has the parser. And you could still have schema now.

A new interface will take a lot of bootloader work to make it easy to
use given the user has to manually load some file in the bootloader
and know a good address to load it to. Between that and rebuilding the
kernel with the configuration, I'd pick rebuilding the kernel. Perhaps
this version will highlight that the original proposal was not so bad.


Another thought, maybe you could process the configuration file that's
in a readable/editable format into a flat representation that could
simply be added to the kernel command line:

key.word1.setting1=data key.word1.setting2 key.word2=val1,val2

That would then use an existing interface and probably simplify the
kernel parsing.

Rob
