Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F17C004C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJJPWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 11:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjJJPWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:22:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1493;
        Tue, 10 Oct 2023 08:22:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65b0a54d436so32150406d6.3;
        Tue, 10 Oct 2023 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696951368; x=1697556168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+OnTbTynmIeVS0uxC9pppcMn+kx7cUxRccWDPKjmcA=;
        b=kL0O9Gp5vKGoGLTvTTe3cEym/KJ6p6+sA67LlDxX1RGEtsFNj9whnYmIzL4lRCLj1l
         quvDCJrU2gaznYZbevuJtTycYm9fg4pekQFAB5smce2PlZkHaHQ7GIpzdAh6qdIcxhnk
         aI3SDmpdlVr0ghqLHlZmtPfppURwUdDTGv1H50AT8Ayhm8zyLlHXT3MvbwRio99UH7gK
         Boc2VE8jmlE0IGN0gcaydGml/1ahSI8u4itiicxsQtxsgzvG9BJWQjzFVr3sN5BqtmMx
         J2sZIvon4Y/KVBqSjjPoReWJPEykNUF/7TcCgsyTB4MGgaxruFvzF12zMWE5q+5YXVLh
         7a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951368; x=1697556168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+OnTbTynmIeVS0uxC9pppcMn+kx7cUxRccWDPKjmcA=;
        b=eLtoJMrMBCKfL0zRMnuhkt/bsl5BVMQegKaZJgs2r1bhKVAzJg89Mjys9AiWvgPg5A
         oHe0je/LlrT+tyqmm44y/oPOEBvB3Q2jzLTtTecxTQt1JrNqkGpoTi0jEBC6zcqyvYI9
         XIGUcGc/aqF6ZUmk9d3+xEMsZjgCcJTwHRNKLqKq0pBamVts4NcJSWC3n0kSpbgVrjbY
         UyfuWtrRIsvuCwlZ1Ez9+4InKR7Pfo6XmaNm/m3EETFBuB5MWLuQwoeJpmlucFqJQQ69
         XqROrnLrWcrmeByxEW38XsrwiFKZF7U3a/K4xp8Pa1cfB8uk0d3IFowuq6tsF8p3L2nL
         lgkQ==
X-Gm-Message-State: AOJu0YyC1o0nrDFpFwkC1nxFozi1x1WB9QiX8lVnYHG/Q6c4KswIghqx
        ocFC2W+9Z2BD1NnuGkBMaF37f3ReeYrBSBD0+6IqiaJullo=
X-Google-Smtp-Source: AGHT+IG1051Zw6vv59OtUCixwFCQ5J2BzOezNsEYSYYW9Fzobg/VOwuuYXT+UMnczMErTeTted7AeCQFSYhp5JT4bfY=
X-Received: by 2002:a05:6214:440b:b0:658:59c3:c237 with SMTP id
 oj11-20020a056214440b00b0065859c3c237mr17573342qvb.40.1696951368120; Tue, 10
 Oct 2023 08:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com> <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
In-Reply-To: <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 18:22:37 +0300
Message-ID: <CAOQ4uxjY8awawG3-7cNc373_cyms69PiM=G0BzvBK0c2Zh7TkA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:34=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Sorry, you asked about ovl mount.
> > To me it makes sense that if users observe ovl paths in writable mapped
> > memory, that ovl should not be remounted RO.
> > Anyway, I don't see a good reason to allow remount RO for ovl in that c=
ase.
> > Is there?
>
> Agreed.
>
> But is preventing remount RO important enough to warrant special
> casing of backing file in generic code?  I'm not convinced either
> way...

I prefer correctness and I doubt that the check
   if (unlikely(f->f_mode & FMODE_BACKING))
is worth optimizing.

but I will let Christian make the final call.

Thanks,
Amir.
