Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1706A68AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCAIRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 03:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCAIRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:17:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201439CD2;
        Wed,  1 Mar 2023 00:16:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id da10so50561854edb.3;
        Wed, 01 Mar 2023 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSqaYlQUZddNvmjmRwWT7Q43mvIxxx7/x0n679k+Rr4=;
        b=Ncv5Q6I+853ziEJ9cFR2KIze1sEPOYFcl2bIAQzHg0HwDZOr++UC6svB8xjQwjP6KD
         ZDzuuASX1qYHLpto1FnMJO1X9UB/QXfEVb42wZWfmjfKGt1shD/+d+tYkZmJGm9LLThi
         9yeZwNTySbYwQOvXxFygGSc6LTPepJ0VNgjeEGr4G4j2U1UY4uuSwmVhH++ahsxuEeD9
         B0FjuskEUT2RE7VVrSlA+4J4+886/9AbOur2Th4zo3fPx0ZEMNqjYRtbhXV6jVYuwGq0
         Fn7sMh8/3PN0oiwrI8wTtaq5VRdoTjPRiZTmGn7L8bu8OS6lueukVupNM9QpQ89W3yYx
         Cptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSqaYlQUZddNvmjmRwWT7Q43mvIxxx7/x0n679k+Rr4=;
        b=vzwveZTFE4EQILtLvP5UdAyjJuF8vfASr8b6MkOaDL7PA4GHhIUsWVdN2d1xvc+EH8
         Zmhxp1TWVs9/RMSaT3SBvbtalz6Ja9fa64iphyEIev18WLxE1+v9lpiiWxws8lzr8mDK
         tZZjuG7OUPqCF3c2SPeUR1XezlvwocOuh0+o9Y0AQr9vtQNC7pjj2vVEIcy7eEzSygg+
         t1N/wlAlZ/goNHzikww+QMOfliUnifXijdg2aOOEEnElFdyVKWWXerfZeuZhSfJ73WWU
         6izuWtL2/J9hk1VopifXGbLC6HlLVkOOJVPViTFVnP6Lw8cptgS6uBRUmz6Jj/1LR1OY
         fCUw==
X-Gm-Message-State: AO0yUKXgQPwNYIq3H3rVsKtYTn2hOVC/epRyxLQmzc7yZoZMmoMEbKkY
        1CcxKKLv5kJdU+5bseJSy1U=
X-Google-Smtp-Source: AK7set95o6sHbzdX6KfRuUyx6EBQOue22QgQbKFPOQh/jgQcGhdkQTxLsOIsP3/Ms8wfhJY9TGhQew==
X-Received: by 2002:a17:907:2057:b0:8b1:319c:c29e with SMTP id pg23-20020a170907205700b008b1319cc29emr6438580ejb.74.1677658608959;
        Wed, 01 Mar 2023 00:16:48 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v13-20020a1709064e8d00b008e3bf17fb2asm5578521eju.19.2023.03.01.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 00:16:48 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 1 Mar 2023 09:16:46 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 1/9] mm: Store build id in inode object
Message-ID: <Y/8J7pkJ8g1uEQcq@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228093206.821563-2-jolsa@kernel.org>
 <20230228111310.05f339a0a1a00e919859ffad@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228111310.05f339a0a1a00e919859ffad@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:13:10AM -0800, Andrew Morton wrote:
> On Tue, 28 Feb 2023 10:31:58 +0100 Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Storing build id in file's inode object for elf executable with build
> > id defined. The build id is stored when file is mmaped.
> > 
> > This is enabled with new config option CONFIG_INODE_BUILD_ID.
> > 
> > The build id is valid only when the file with given inode is mmap-ed.
> > 
> > We store either the build id itself or the error we hit during
> > the retrieval.
> > 
> > ...
> >
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -699,6 +700,12 @@ struct inode {
> >  	struct fsverity_info	*i_verity_info;
> >  #endif
> >  
> > +#ifdef CONFIG_INODE_BUILD_ID
> > +	/* Initialized and valid for executable elf files when mmap-ed. */
> > +	struct build_id		*i_build_id;
> > +	spinlock_t		i_build_id_lock;
> > +#endif
> > +
> 
> Remember we can have squillions of inodes in memory.  So that's one
> costly spinlock!
> 
> AFAICT this lock could be removed if mmap_region() were to use an
> atomic exchange on inode->i_build_id?

right, that should work I'll check 

> 
> If not, can we use an existing lock?  i_lock would be appropriate
> (don't forget to update its comment).

ok

> 
> Also, the code in mmap_region() runs build_id_free() inside the locked
> region, which seems unnecessary.
> 

ok, if the atomic exchange is doable, it'll take care of this

thanks,
jirka
