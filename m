Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6176B533
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHAMxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjHAMxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:53:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192EDE6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:53:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b962535808so86184861fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690894418; x=1691499218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Lx4dB17LVBJWGUEA9QJyHkKX9VBphHZ2Z9Sn7D5kEw=;
        b=jtdIpXgZ8chrW4jrdRxe0v9LNviS1LEbfC1Nu8VD/6IsCS2T5OqY6qkWVHLHKCNLeF
         s1QXu5Z9VHyGWNuyUWL/go+k8+PNuRh1Bs0G1B+3xrnLG12Z54g/OsmN9OZrU4xwD5H7
         Ya1IJifLqtgGE09/jzkgsvEo7Qsef3ayQVQ1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894418; x=1691499218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Lx4dB17LVBJWGUEA9QJyHkKX9VBphHZ2Z9Sn7D5kEw=;
        b=Y0XbHBrFqCOLrYZwM/vj3rrjfHgeszOP3NoMWVOo43PyD71g1q9BINWTYSzLx1MR35
         A/OTWV+9SIaUDN+Sh45FqoAYs24dHO0KbEJcJT6SmSTWFDu21MccJGMMtjuJX+7WDt4Y
         0fAL7ln+AluLpnLa5YUOUUJr0//pLF2V56vYNEJruOSg4jDgMMC2iI8aNs6+Ku7AsPci
         TJFv27iRHDLr7HB7aPBi8aFWrT9n7U4nabw0Y3eV94Tu66xv++YGlAe94fjVs+aO6qYZ
         g9RPZuI2OcJe1tuJBH5Rn0pt/TloIytkNAg7bIBWV3QiHOnDvZgMcR12AWMoCOMN7jya
         sbHg==
X-Gm-Message-State: ABy/qLZo4WuPPFejM2CjWyB8OhLrt230U5lfTB1Gw9O9+sHTkNNoGH55
        HqjWWfUlJ3+IYb/HHX72nxdBR00cHu6nBAFtuv2ALQ==
X-Google-Smtp-Source: APBJJlGnCFPUx4hlSF2m//OXXH75UxXAAZ1yPrwZ/XKZRrtzlAES2XUd7qQt0wEnfIxb+ayOzKfzNbeQX/MA+M3Vpkg=
X-Received: by 2002:a2e:3e07:0:b0:2b9:dd5d:5d0c with SMTP id
 l7-20020a2e3e07000000b002b9dd5d5d0cmr1984051lja.52.1690894418281; Tue, 01 Aug
 2023 05:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
 <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
 <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com> <87o7jrjant.fsf@vostro.rath.org>
In-Reply-To: <87o7jrjant.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Aug 2023 14:53:26 +0200
Message-ID: <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Aug 2023 at 12:54, Nikolaus Rath <Nikolaus@rath.org> wrote:

> This sounds like you're using s3qlrm from one version of S3QL, and
> mount.s3ql from a different one.

Indeed, I forgot to checkout the debug branch.

> If you want to keep the Python packages separate, the best way is to use
> a virtual environment:
>
> # mkdir ~/s3ql-python-env
> # python3 -m venv --system-side-packages ~/s3ql-python-env
> # ~/s3ql-python-env/bin/python -m pip install --upgrade cryptography defusedxml apsw trio pyfuse3 dugong pytest requests cython
> # ~/s3ql-python-env/bin/python setup.py build_cython build_ext --inplace
> # ~/s3ql-python-env/bin/python bin/mount.s3ql [...]
> # ~/s3ql-python-env/bin/python bin/s3qlrm [...]

Here's one with the virtual env and the correct head:

root@kvm:~/s3ql# git log -1 --pretty="%h %s"
3d35f18543d9 Reproducer for notify_delete issue. To confirm:
root@kvm:~/s3ql# ~/s3ql-python-env/bin/python bin/s3qlrm mnt/test
WARNING: Received unknown command via control inode
ERROR: Uncaught top-level exception:
Traceback (most recent call last):
  File "/root/s3ql/bin/s3qlrm", line 21, in <module>
    s3ql.remove.main(sys.argv[1:])
  File "/root/s3ql/src/s3ql/remove.py", line 72, in main
    pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
  File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'

Thanks,
Miklos
