Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCD20AC6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFZGjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgFZGjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:39:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA92C08C5C1;
        Thu, 25 Jun 2020 23:39:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so4229113pfp.9;
        Thu, 25 Jun 2020 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdtlRZYBAmqNtbxp3vxoceKnVQSi5KT5PeHxRiAdxF4=;
        b=KaIVObdIVTftVUV4YuvDeA1+kJCxSZ9VcdtNHrraPGZvtTpMha8XqQStSu4it6II5M
         wRsMe2+L8ExFyQytMstxSR5xoV4VHFQ/ePPPZyGRFXhvXuxh7ajO/oeoqeC22tRXbSd3
         9lpAFaWq+Z6WxR9FWvJO2/Kxg1vNWYhq3EWqWzgAVXsAjdxru68TiDBtnqcDkkwHVMA+
         Vg2wSMMbMIegHRn5vwO8LNGzbCP0BmyQhWFs8PyG/ySl6uN/V8T71wAlg8LXVQgwmw6g
         kyN6A+SDbso7gTAxT3G0cW4M/87CVxlBIWl046j1SwFOgZ+nqYjg1XrKkSD8J2N2DX5x
         tBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdtlRZYBAmqNtbxp3vxoceKnVQSi5KT5PeHxRiAdxF4=;
        b=cjfE/2XZh/gMHuNujHTinGTq4B0Opls+AqWYBWYE7wEnqxlLz9/c3UJ9AxGhzQLqxa
         AnhlgK2d90g/XYWo3MZTEZAGwfljSozhVRlWp6pbnx18t3PJcvLZ1qdgRFnkevVHRIjd
         4AIQCYW6j5g/QgOtIvHDcmx6KyqTNVyXdWmiPViLyNes3mH06fhYPFGr0UvO51MnRlXO
         JIG+/MIjtb3HbwJFd3lq82eUhIOvFEkXhD799dp+SWuH8JR3IpScLLD1Rox+KP83oEhx
         cPwMBzW87XdVIURdMOUYA6k53FWtzJAfkdu2SJxItzIdvlrYSGt3P5caZG2i3moXlL8i
         JM5A==
X-Gm-Message-State: AOAM5311B0OL2oN9M3nAmYWy9tEM1lfNP8vyDr519D1Q3bwHyJooPTKq
        Uh/d4NbvVnEhacN4C9rHa8c=
X-Google-Smtp-Source: ABdhPJzFOMeDT+zK4n/8TEjDpPVElQCAZ0+e1YOcub/ZhaYFE/ZkS0oeDZygipuBcMfnsBcTJegnrg==
X-Received: by 2002:a63:4d53:: with SMTP id n19mr1502294pgl.60.1593153549424;
        Thu, 25 Jun 2020 23:39:09 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:986f])
        by smtp.gmail.com with ESMTPSA id ng12sm10919706pjb.15.2020.06.25.23.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:39:08 -0700 (PDT)
Date:   Thu, 25 Jun 2020 23:39:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200626063905.lvtjqp5iipdgvrer@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <20200626015121.qpxkdaqtsywe3zqx@ast-mbp.dhcp.thefacebook.com>
 <eb3bec08-9de4-c708-fb8e-b6a47145eb5e@i-love.sakura.ne.jp>
 <20200626054137.m44jpsvlapuyslzw@ast-mbp.dhcp.thefacebook.com>
 <c9a9c2b5-68cc-c35d-72c2-34de79ebfb15@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a9c2b5-68cc-c35d-72c2-34de79ebfb15@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 03:20:35PM +0900, Tetsuo Handa wrote:
> On 2020/06/26 14:41, Alexei Starovoitov wrote:
> >> I was hoping that fork_usermode_blob() accepts only simple program
> >> like the content of "hello64" generated by
> > 
> > pretty much. statically compiled elf that is self contained.
> 
> But fork_usermode_blob() itself does not check that.

As I said few emails back it's trivial to add such check.

> > In the future it would be trivial to add a new ptrace flag to
> > make sure that blob's memory is not ptraceable from the start.
> 
> I guess it is some PF_* flag (like PF_KTHREAD is used for avoiding some interference).

Kinda.
I was thinking about PTRACE_MODE_xxx flag.

> What I am hoping is that we can restrict interference between usermode blob processes
> and other processes without using LSMs,

I don't see why not.
Extra piece of mind that blob memory is untouchable by other root processes is nice to have.
