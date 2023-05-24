Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D827270EDEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbjEXGhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbjEXGhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:37:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE518C;
        Tue, 23 May 2023 23:37:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d722dac08so157870b3a.1;
        Tue, 23 May 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910256; x=1687502256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKMIdvdUFfqOqbdUAufCFsw61dClBFnE+Z15IrMaD9E=;
        b=EkgB+c4ANGqbmlkGwYHW50rvLdKZLi1OzD3AqPjws7Ozl3gmlSZdBMWVYTBuucuBtY
         TKnfn6B4Yr0HE1XIG4VFuZAwaxv7piqlfJdbahOKr3F1F7R4tnSI1eBaT74bnCTbdUe9
         sQueeEMQX112CAx+D2oeugtpAWQI1eSmtKcJai6JVZ50UTryNxwyE5RB36n/Hp3sZyIN
         ImbJ+SqTl/7gTXOLh5GgI223l1mO4Ti+DiAqi+N6hGjWi9K4lr8z+h7qGFkQ+Egg6NGx
         kaXDocGHN0iNRjL+Z7xQin10vA7GiXeoheg7N5dBfRS1F5LeoWlrnlmxSjfE+16e5+lK
         dLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910256; x=1687502256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKMIdvdUFfqOqbdUAufCFsw61dClBFnE+Z15IrMaD9E=;
        b=E7Ou8ELdvLP3yFHis83qS3VI2lR29+vNG1jp0bmPiRvU7/Q1iJZaFDrk0cRpgeeO/2
         3bZw0G72IVH2s17Mo7Ect00/l+eEaCwOzKoSCm1j8bUofYySpvkjZP7MDwvXS4awRPVR
         Slf+MIHkKdsjjbq1EuEoHKf7swgW7d3rs/rOSkRIvPLeTbsEz9WE89653zjKwLXfrz1q
         A1/soKsMvqWSeVCoc2AvALyrUr/HBdW52kPrTmlpXpPoplEvCOx+kG4/gQMmMbM+DOSI
         B/vjAoN5CxUYtWU21F+t4Wz0z/tSGkLKg6m36cOiR79lRd80xA9rdGYaN2Vt1NnbMQ1F
         LZJg==
X-Gm-Message-State: AC+VfDy36icbw8LcFegz2AjzzskpncQD0aQahrLAaQeNiuBnFCW14mQc
        Mirgb/7mewNF2Yfu25W09iQ=
X-Google-Smtp-Source: ACHHUZ7J6dSVr4eZ5LvpgpyuTFaRiOV95nIjeYCF0JJEp7ewhofMBHHrfBw4Ca/uZXZuL3fOxKHuWQ==
X-Received: by 2002:a05:6a00:1d06:b0:646:e11c:f5f9 with SMTP id a6-20020a056a001d0600b00646e11cf5f9mr15979656pfx.0.1684910255836;
        Tue, 23 May 2023 23:37:35 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b0064378c52398sm2104876pfu.25.2023.05.23.23.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:37:35 -0700 (PDT)
Date:   Wed, 24 May 2023 06:37:34 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v6 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <ZG2wrrZBLl1ApFDL@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230523065802.2253926-1-aloktiagi@gmail.com>
 <ZGzATlGu7mh6EFUi@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzATlGu7mh6EFUi@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:31:58PM +0100, Matthew Wilcox wrote:
> On Tue, May 23, 2023 at 06:58:01AM +0000, aloktiagi wrote:
> > +/*
> > + * This is called from eventpoll_replace() to replace a linked file in the epoll
> > + * interface with a new file received from another process. This is useful in
> > + * cases where a process is trying to install a new file for an existing one
> > + * that is linked in the epoll interface
> > + */
> > +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)
> 
> Functions do not control where they are called from.  Just take that
> clause out:
> 
> /*
>  * Replace a linked file in the epoll interface with a new file received
>  * from another process. This allows a process to
>  * install a new file for an existing one that is linked in the epoll
>  * interface
>  */
> 
> But, erm, aren't those two sentences basically saying the same thing?
> So simplify again:
> 
> /*
>  * Replace a linked file in the epoll interface with a new file
>  */
>

thank you for pointing this out. I'll address this in the next version.
 
> > diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> > index 3337745d81bd..2a6c8f52f272 100644
> > --- a/include/linux/eventpoll.h
> > +++ b/include/linux/eventpoll.h
> > @@ -25,6 +25,14 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
> >  /* Used to release the epoll bits inside the "struct file" */
> >  void eventpoll_release_file(struct file *file);
> >  
> > +/*
> > + * This is called from fs/file.c:do_replace() to replace a linked file in the
> > + * epoll interface with a new file received from another process. This is useful
> > + * in cases where a process is trying to install a new file for an existing one
> > + * that is linked in the epoll interface
> > + */
> > +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd);
> 
> No need to repeat the comment again.  Just delete it here.

thank you. I'll update this in the next version.
