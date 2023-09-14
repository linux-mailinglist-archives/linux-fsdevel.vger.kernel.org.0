Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D579FEF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjINIuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbjINIuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:50:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4E1FC6
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 01:50:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3950724a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694681416; x=1695286216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=If2+Px/j1i2usZxS7gF0O94KGwHevrnZjdMBKU2+tpg=;
        b=jIQ2VYXgZuR/ZKNRr4CLdrhSJts6SWFagvZvk7PCo5Q20GmK8DcL8veOTRYLtyx3ee
         NJFySQfrltJJ8Sy8s8D41pV2nX6zr1ctRMrWuViEfU0jyPoMe069b6hSIQavd5LOn2WA
         Tn9KP5PgOFnjYXlFX/5wC6Aw8C64/lmxRv+0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681416; x=1695286216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If2+Px/j1i2usZxS7gF0O94KGwHevrnZjdMBKU2+tpg=;
        b=iBaq9kh+X5Ry6YsEaMJc316d5j9/EQ9Ie/0CTIIKDte8JyqIJtYMlL49M7qTidcfrg
         RLw6fsCnf0tGfWtnRJbms4hv4IxV5EhiJAjbnvDaGeuG5Tik7fpy7sntlq5nuQ9AxM6a
         uYC6ikswd3zuNbHGaHnxAriAa7YNlu9xnXVfMP3h3OgJYpqhonU5UP1QzF0DM4nhCvTU
         yNh4/tptnoe71vMTSqgY6rSzaz82t+qAXQ3WGVjo0CYAIBQcEGvRydnpQwrnC+WHr7+T
         xsTMoNvWl6jo/0QSG7o+n6Am2qdYdfsgqQIeBnUnWB7oAR4otF2bah6zwT3h1hFYZdWT
         +46g==
X-Gm-Message-State: AOJu0YyW87At1+hw20PK9wD+1zpMnutPbDNrAngTvqA4lkef7W03geFH
        rJXAI/SX6aCtprrsC9/FgW/Sr6MLjhz7nXV9zPDLQg==
X-Google-Smtp-Source: AGHT+IFq8m9XcKLtOZhLaV1arOz7ua+SOqJfLVSYytrKwDeB8LEuqfrYb76LxaqAosv+sz3tPa3lHMJ0qAc+k0UEbOc=
X-Received: by 2002:a17:906:cc16:b0:9a5:a543:2744 with SMTP id
 ml22-20020a170906cc1600b009a5a5432744mr1507370ejb.33.1694681416107; Thu, 14
 Sep 2023 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 10:50:04 +0200
Message-ID: <CAJfpeguE97q=esmS6zE4OaZBwkBBWykwH1MTnUvLeHcfb7NeTw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Sept 2023 at 08:00, Amir Goldstein <amir73il@gmail.com> wrote:

> > +               if (ctr >= bufsize)
> > +                       return -EOVERFLOW;
> > +               if (put_user(r->mnt_id_unique, buf + ctr))
> > +                       return -EFAULT;
> > +               ctr++;
> > +               if (ctr < 0)
> > +                       return -ERANGE;
>
> I think it'd be good for userspace to be able to query required
> bufsize with NULL buf, listattr style, rather than having to
> guess and re-guess on EOVERFLOW.

The getxattr/listxattr style encourages the following code:

  size = get(NULL, 0);
  buf = alloc(size);
  err = get(buf, size);
  if (err)
      /* failure */

Which is wrong, since the needed buffer size could change between the two calls.

Doing it iteratively is the only correct way, and then adding
complexity to both userspace and the kernel for *optimizing* the
iteration is not really worth it, IMO.

Thanks,
Miklos
