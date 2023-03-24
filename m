Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D06C7787
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCXF4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXF4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:56:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3E23C4E;
        Thu, 23 Mar 2023 22:56:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x37so501514pga.1;
        Thu, 23 Mar 2023 22:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679637373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtbAv6zGQwJisy3TytdIn0oEo0EYBHUbeULD0hJtgII=;
        b=NLhwJIEpPbxbljedHosGdzZSJA3gxGO5JushgvWVwtuqGs7ZnfQZuOeHZYrTo6RZIq
         kKC6OvB6JprDsPLJasBbF/buoImOZQMiqkle8ZCErHKDsjdn+UstdZNzE0UgCBn8/QdW
         c6IY5zED2TaEz0JTDbW2rWZPE71GHp5AT7g/k+/67H2V3xTwbsi1IRNNOksR2xNMjzUR
         ijya5e9X32a+LRD52SyD0IJeXNtXicvXo4qewWbt+m8T51lIJ6J7XnbKoaaBB4crMeEY
         z763Dymqsn/akwcSxOBk9i2ZL7TC25meFBBYiyx6b9qp0Ake6vV9Ls9R6TJxSHOMMacc
         33Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679637373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtbAv6zGQwJisy3TytdIn0oEo0EYBHUbeULD0hJtgII=;
        b=EQqhb0Fepw2uc9TzhHeloyuIdZAy86zYYjrCidiFDgneoGYlEocbWlK74vXHHO0UBu
         9A8GJVuWLpkCs6VBOiUu4TWLd4Zl2kKj1ff+iZGVP5cx4HB3sE7rKeQbsmqsfd9e3XWC
         os8H5HI0pSbyprfxZtYFCA+p8R6ZksCa8uvRrzBUFKI5413AiZxAdMjqKMzcnoQkyebM
         ORuwL4PF81viPdFNdiClYUMhBq7ocszIl1U/BPLyhu6ZS6Kt54JdxltIVC3Bmv0qj9bc
         jjdOA/cPVVrlLKH6FoUJSuXeQntR1MUZffH23f0RYXZJplo00UUkqeYJPp1336hWajMX
         ux/A==
X-Gm-Message-State: AAQBX9eGQalWCamshoMCMvLoVF+JzVItZGqYCTkzA4H2TT+fyagvw+qu
        JkScSsvyc/DBN/G54IncNxGw/bGEL8C8+g==
X-Google-Smtp-Source: AKy350YJl6lAAHw8neRkPGmNtpkYk7GDVnHqvqWOYr2fTaJVajn/z0dL+LpBlQZ5UcexC53jIHccWQ==
X-Received: by 2002:a05:6a00:26ec:b0:5e4:f141:568b with SMTP id p44-20020a056a0026ec00b005e4f141568bmr1798270pfw.3.1679637372903;
        Thu, 23 Mar 2023 22:56:12 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm12928341pfh.193.2023.03.23.22.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:56:12 -0700 (PDT)
Date:   Fri, 24 Mar 2023 05:56:10 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>,
        aloktiagi@gmail.com
Subject: Re: [RFC v3 3/3] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZB07etlmm6torSkz@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
 <20230324051526.963702-3-aloktiagi@gmail.com>
 <ZB00Cvib+jyqCR5C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB00Cvib+jyqCR5C@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:24:26AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 24, 2023 at 05:15:26AM +0000, aloktiagi wrote:
> > diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
> > index 3337745d81bd..38904fce3840 100644
> > --- a/include/linux/eventpoll.h
> > +++ b/include/linux/eventpoll.h
> > @@ -25,6 +25,8 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
> >  /* Used to release the epoll bits inside the "struct file" */
> >  void eventpoll_release_file(struct file *file);
> >  
> > +void eventpoll_replace_file(struct file *toreplace, struct file *file);
> > +
> >  /*
> >   * This is called from inside fs/file_table.c:__fput() to unlink files
> >   * from the eventpoll interface. We need to have this facility to cleanup
> > @@ -53,6 +55,22 @@ static inline void eventpoll_release(struct file *file)
> >  	eventpoll_release_file(file);
> >  }
> >  
> > +
> > +/*
> > + * This is called from fs/file.c:do_replace() to replace a linked file in the
> > + * epoll interface with a new file received from another process. This is useful
> > + * in cases where a process is trying to install a new file for an existing one
> > + * that is linked in the epoll interface
> > + */
> > +static inline void eventpoll_replace(struct file *toreplace, struct file *file)
> > +{
> > +	/*
> > +	 * toreplace is the file being replaced. Install the new file for the
> > +	 * existing one that is linked in the epoll interface
> > +	 */
> > +	eventpoll_replace_file(toreplace, file);
> > +}
> 
> Why do we have both eventpoll_replace() and eventpoll_replace_file()?
> They seem identical?

I was following the eventpoll_release_file() convention but yes seems
unnecessary. I'll retain eventpoll_replace_file() and remove
eventpoll_replace() in v4.

> 
> > diff --git a/include/linux/file.h b/include/linux/file.h
> > index 39704eae83e2..80e56b2b44fb 100644
> > --- a/include/linux/file.h
> > +++ b/include/linux/file.h
> > @@ -36,6 +36,7 @@ struct fd {
> >  	struct file *file;
> >  	unsigned int flags;
> >  };
> > +
> >  #define FDPUT_FPUT       1
> >  #define FDPUT_POS_UNLOCK 2
> >  
> 
> You should drop this hunk of the patch.

I overlooked this. Will fix it in v4.

