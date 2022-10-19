Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48D6043DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJSLvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJSLvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C132AA0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666178924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1fMPdNDRTHPs2yNcmd+P8KKjuGvgNkbX2eaDg7M/a0=;
        b=XO46avwzM17ftxe6Bp3SJvKiNfCPJDsYDlLOEjOwvqeVt+W0mY0sPd1Z+R+g3tmuqUf7nK
        wg/xk/q9qHno0LBPFTac6F4Ph0+zenfafnHjZfCfM7sd6BGwzfd7ptO6rXwcld4QOfuaCd
        7pMiGxvnXHXmztjSmh9/qtR+gOOKDwk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-QBrcHDtnM2CAktwIRgOaQw-1; Wed, 19 Oct 2022 07:28:42 -0400
X-MC-Unique: QBrcHDtnM2CAktwIRgOaQw-1
Received: by mail-qk1-f197.google.com with SMTP id s14-20020a05620a0bce00b006ee7e19c44bso14544893qki.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 04:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fMPdNDRTHPs2yNcmd+P8KKjuGvgNkbX2eaDg7M/a0=;
        b=SoJ+Y5R1AgUelitbl0p85woghlyj3BD1hGqnb7gwPiLVj/TWusGegEXV4VvD/k869G
         3FQ/09vfF/hl83d4opg7rkIXLqIcqB+RRATIxFgZAknR6l187aYpe+hUe1PnyTcUqfma
         b/iam3gBics9+77e+hVrA70vaFJyNWj4jyUv9JLCVQkyF8Zfga/Fe0gS5+qjEdqSkor/
         OHw3hY1Gu/70FzyuTdU4qPABQJbibR3a3IxOEJ0xdDZ/CXOOmUAWVxk5HCb2o/5URcgQ
         Zw/rDy8+gXBAt5qEl6u9ku/QDQnLBONuwlGfWzjlJxXAjlLwlDy9K7PncQ+cJkb+wMrr
         Lq2Q==
X-Gm-Message-State: ACrzQf0xoyV5bttpoFcTd99ZYc6M8jPc4rLUgUrwhw3oi2Ll2Mry+azN
        XSfTJ/DmOeMkiqIrjPlKm4CrCRth8rBUmrbetp/ZBrlMns1ju84hsMyrMo1MXCKd1LgH4vDcXtd
        v2n1ckp1Tv7jyseKRPk6TjzdOBA==
X-Received: by 2002:a05:620a:1f3:b0:6e9:e33d:3bb6 with SMTP id x19-20020a05620a01f300b006e9e33d3bb6mr5124974qkn.115.1666178922489;
        Wed, 19 Oct 2022 04:28:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZIl8JLL0yTDsItrhQcBay9ni8wtOzjRwElcsG3YXkfPsa1bo6861Y9xbC2e4ngvd/fvegFg==
X-Received: by 2002:a05:620a:1f3:b0:6e9:e33d:3bb6 with SMTP id x19-20020a05620a01f300b006e9e33d3bb6mr5124966qkn.115.1666178922282;
        Wed, 19 Oct 2022 04:28:42 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a404f00b006ee91ab3538sm5121173qko.36.2022.10.19.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:28:41 -0700 (PDT)
Date:   Wed, 19 Oct 2022 07:28:45 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v3] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y0/fbSL0QDlTU6Yv@bfoster>
References: <20221018045844.37697-1-ivan@cloudflare.com>
 <Y07taqdJ/J3EyJoB@bfoster>
 <CABWYdi37Ts7KDshSvwMf34EKuUrz25duL7W8hOO8t1Xm53t2rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi37Ts7KDshSvwMf34EKuUrz25duL7W8hOO8t1Xm53t2rA@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:51:02AM -0700, Ivan Babrou wrote:
> On Tue, Oct 18, 2022 at 11:16 AM Brian Foster <bfoster@redhat.com> wrote:
> > > +static int proc_readfd_count(struct inode *inode)
> > > +{
> > > +     struct task_struct *p = get_proc_task(inode);
> > > +     struct fdtable *fdt;
> > > +     unsigned int open_fds = 0;
> > > +
> > > +     if (!p)
> > > +             return -ENOENT;
> >
> > Maybe this shouldn't happen, but do you mean to assign the error code to
> > stat->size in the caller? Otherwise this seems reasonable to me.
> 
> You are right. As unlikely as it is to happen, we shouldn't return
> negative size.
> 
> What's the idiomatic way to make this work? My two options are:
> 
> 1. Pass &stat->size into proc_readfd_count:
> 
>   if (S_ISDIR(inode->i_mode)) {
>     rv = proc_readfd_count(inode, &stat->size);
>     if (rv < 0)
>       goto out;
>   }
> 
> out:
>   return rv;
> 
> OR without a goto:
> 
>   if (S_ISDIR(inode->i_mode)) {
>     rv = proc_readfd_count(inode, &stat->size));
>     if (rv < 0)
>       return rv;
>   }
> 
>   return rv;
> 
> 2. Return negative count as error (as we don't expect negative amount
> of files open):
> 
>   if (S_ISDIR(inode->i_mode)) {
>     size = proc_readfd_count(inode);
>     if (size < 0)
>       return size;
>     stat->size = size;
>   }
> 

I suppose the latter is less of a change to the original patch..? Either
way seems reasonable to me. I have no strong preference FWIW.

Brian

