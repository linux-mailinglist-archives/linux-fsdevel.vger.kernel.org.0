Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8442852D5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiESOLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiESOLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:11:37 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB85C74C
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 07:11:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id q135so9242645ybg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuhMk4Xj9HrN3ZC1ZjvlsypNYPWvU8txk/gn7Ni0NxI=;
        b=tivKm5r1sys75u1UFmvljUq2ee+/9npMFicKjmbSdDcGNEosNVN85RrXMb9Bbvhw+9
         yE3rlqmBaJ/4qsfEcmWQVAt8UaA1t9cXhitoz0YsBYWB01qWvoDzoxeadxVxqRFZpNEd
         7RdDMocCzFa5iqfLwo7PCo8CAk/oxEf5v7srYmgZikvvwHqdNhDVvJ+VLqLe4s5Vv6ll
         BYPvBKI1vd96eX+dmY+H+zcSj3wcjEAANgpYJNEhSolg1ncF8ozEGsxcWWn2QeywuORJ
         klK2ZnfUwSjZoNOz2wjeGlrGNrQWxrKEgetHoPhYmgLw5synMTSDi2Wq9xK/fgLB2A9i
         s6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuhMk4Xj9HrN3ZC1ZjvlsypNYPWvU8txk/gn7Ni0NxI=;
        b=0ABsxNlqMVeRaETvkfd2wR3p1TvswKJVzKMAH5NN37o7QGMm2mMoB4I8Q+l5Gr3GPr
         WW9CU6WnvQE/62RHkF5GJNN2wtthZA7lRiL9tlnDsFclNBiQ+sRqAzdnW/wGiIOVMK/z
         kuMZhNoZN5KtWiXUbarryvYLBGFIW4xATsst8Ok7bEbGMw8oaiyMICy5hfJ2jXBMhjjy
         bFU5FbKDilEkPt10N9ZD1dKE0yKvnw1c0SG5ldmVQOkW9JgIcMZyKF5ZBoTypxFA0dr+
         lCfRLmjJKipGW3MHfwcin+pKV5v2Fs1eUQx8lg3AZ2gAWvtBlfsh3RqPQQKpQRpVsrk0
         NwLw==
X-Gm-Message-State: AOAM530NwV1s0W/4Bzj/XedGn9nK2X0B3qzyV71DBy5dHicjnNVqk+uq
        furWYMTJI9PdPWFwvvj3R2R0xVgkw0+aOUftQSLdFw==
X-Google-Smtp-Source: ABdhPJzT5Xs9YBbEg7U27vml1G9OJpZ5YIkQTmA/Z12JsRedugPgfSJ+2sfMAznptjjmzPmchGqSVXBK8nDqnNEur1A=
X-Received: by 2002:a05:6902:4ae:b0:64e:ab25:b745 with SMTP id
 r14-20020a05690204ae00b0064eab25b745mr4624985ybs.246.1652969490758; Thu, 19
 May 2022 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220519125505.92400-1-songmuchun@bytedance.com> <YoZBbcEHcLqsAssF@casper.infradead.org>
In-Reply-To: <YoZBbcEHcLqsAssF@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 May 2022 22:10:54 +0800
Message-ID: <CAMZfGtWw0Jm0fr=m38djPtCpTkVPvqku5vjCmOmGgDtOHZn9Aw@mail.gmail.com>
Subject: Re: [PATCH] sysctl: handle table->maxlen properly for proc_dobool
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 9:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 19, 2022 at 08:55:05PM +0800, Muchun Song wrote:
> > @@ -428,6 +428,8 @@ static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> >                               int write, void *data)
> >  {
> >       if (write) {
> > +             if (*negp || (*lvalp != 0 && *lvalp != 1))
> > +                     return -EINVAL;
> >               *(bool *)valp = *lvalp;
> >       } else {
> >               int val = *(bool *)valp;
>
> Is this the right approach?  Or should we do as C does and interpret
> writing non-zero as true?  ie:

All right. We could obey the C rule here.

>
>                 *(bool *)valp = (bool)*lvalp;
>
> (is that cast needed?  It wouldn't be if it were an int, but bool is a
> bit weird)
>

If the cast is weird. How about:

        *(bool *)valp = *lvalp ? true : false;

Thanks.
