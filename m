Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBD6BFBFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 18:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCRRlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCRRkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:40:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314F2213F;
        Sat, 18 Mar 2023 10:40:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p34so41759wms.3;
        Sat, 18 Mar 2023 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679161249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev2W7AwgvE+3tr7BAXXjW37/uLiVAl5wqa5Vqup/X18=;
        b=Yl7l77+G+vWuZBrzmXQxIW4PhdcbuiWftbjibBta14w9f+IW+cP4rAqaUOEf54VsBP
         XXcfsI0nfYwJA26CqS7T9F2Or0MsGLRdgDyme5Bhatkxfkcj3tht1cJWu9TO+QDzTDNj
         /+QwOVyIXX+kAOQ60wi/wjA2WoOlZiSPw/7SrmfgWl4W1SF52ThmMuN26J9efm9dsWZT
         wsgOC23KF0f0mJ0gi83B9lDDLlXm8j+xgWzfOmoVixSjCIi/R2VS0ynCo0MaWodEYm7Y
         HFFiy/qM9A7HDTs3Iizi2lRpDpkyc5F5Qu0y6qpkXshh+P2hNhr3cHN9B8b7g4ihnEOF
         8tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679161249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev2W7AwgvE+3tr7BAXXjW37/uLiVAl5wqa5Vqup/X18=;
        b=3LUngfb4BiFGfMgzvRGhmvVuBDqiroFnNS7Aom49uUkt3qR4x1QhoJCTZnbE5YwIda
         Dh03Ar/PI3CrXIelvgTx+fL0yYdCUlxeByWrlrpzi/C2tGosU+VgeQ/b2WTi2JrCAVZW
         jK4RKV2vNSJCawy88owdQ0/eTOLcTpwQzyLBKEFIFsaFDYsfZ3lab46HpyzkcEB/aQt8
         BQ/oVPJh4DEc8gyJHM/F8U7fk0Ztq+9bhzuPNkZQcNrnkNibarVlQbUd5ljJcHC2gjG6
         jLkdA73q6pWf0fG92Yo8LgLMfmXaVfu1BZY24v+8KGcE2gK3MVBGl2z81vCN22dDdfdU
         BI/w==
X-Gm-Message-State: AO0yUKXitvYhzq6k1ewfdbahaGHRwtkyLHr0ZwNajaXpRDLTuD+QiiiF
        HMVmjyRmM31UcIX4jFXZ7/s=
X-Google-Smtp-Source: AK7set9zXPa/ih+Bbwm7sQZOKAnG69++6aoehqPt/kHsTPtM2UGAPjvGCSsnG1ECr9Gokzh9oSseng==
X-Received: by 2002:a05:600c:358e:b0:3ed:2a41:8525 with SMTP id p14-20020a05600c358e00b003ed2a418525mr17932303wmq.22.1679161249516;
        Sat, 18 Mar 2023 10:40:49 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b002c706c754fesm4797373wrj.32.2023.03.18.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:40:49 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 18 Mar 2023 18:40:45 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZBX3nRWtc6+EI13W@krava>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava>
 <ZBXV3crf/wX5D9lo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBXV3crf/wX5D9lo@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 18, 2023 at 03:16:45PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 18, 2023 at 09:33:49AM +0100, Jiri Olsa wrote:
> > On Thu, Mar 16, 2023 at 05:34:41PM +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > > > hi,
> > > > this patchset adds build id object pointer to struct file object.
> > > > 
> > > > We have several use cases for build id to be used in BPF programs
> > > > [2][3].
> > > 
> > > Yes, you have use cases, but you never answered the question I asked:
> > > 
> > > Is this going to be enabled by every distro kernel, or is it for special
> > > use-cases where only people doing a very specialised thing who are
> > > willing to build their own kernels will use it?
> > 
> > I hope so, but I guess only time tell.. given the response by Ian and Andrii
> > there are 3 big users already
> 
> So the whole "There's a config option to turn it off" shtick is just a
> fig-leaf.  I won't ever see it turned off.  You're imposing the cost of
> this on EVERYONE who runs a distro kernel.  And almost nobody will see
> any benefits from it.  Thanks for admitting that.
> 

sure, I understand that's legit way of looking at this

I can imagine distros would have that enabled for debugging version of
the kernel (like in fedora), and if that proves to be useful the standard
kernel might take it, but yes, there's price (for discussion as pointed
by Andrii) and it'd be for the distro maintainers to decide

jirka
