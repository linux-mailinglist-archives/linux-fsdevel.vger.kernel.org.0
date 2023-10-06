Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F857BB8ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjJFNVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFNVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:21:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92083;
        Fri,  6 Oct 2023 06:21:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso18722705e9.3;
        Fri, 06 Oct 2023 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696598509; x=1697203309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcSsScFohaaUgke/VGA61awbehmAnr/eIu/hS13xN0w=;
        b=Fr+Gt5/mTWwiEOOIbcxbgWw4Gu2CYGbbrVCcB464d2nkhFWAqYYPNC/VfNLHmzO0+n
         RuLI6nzdGzA3iEhrt9MP+bptUASPcYTjkYvNqU5uaExM2iE2WdWJmPGIRAgra3VAR9QC
         aTUE7VOYADVupn1QDraD34wNC08RbawFdaqy7VG0NSmXmLiH2cfkwdbTQJDYRmf+5af2
         Y4ZzXJfDiYepagGxUuoM4PWFey/biY/F8qEhs8cBJEzwIdwMU2789OA0MBiPPK5Tl4a9
         djB+x3y1ROprJPOWEBl86fR0P0mjskOnGjYOr62K1hFyGGMOt/wvnTbxSEgG1jkzFk0e
         imQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696598509; x=1697203309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcSsScFohaaUgke/VGA61awbehmAnr/eIu/hS13xN0w=;
        b=utFm4jQHP+L2PU0hYN+/iss8jhWr93TKk0eo84Hw9KBCotAQBAylR+76Tl9/cPgK4b
         PdLKNg0bWg7gxMF4CDg/7/Fh5q0G/M2KYBZEGiFPlU288ecAfkpwtWRvAzziHT4Xel6Q
         qYMiazIXV3R5qarVNOxOi7XR9ykRd1OxvaOB1qeXtuf/gNGXDSkTit3eOspT2dvOaBjZ
         aNb0AZE3nThietdJ77HB17BHUQqYxnUo3BgALN6tVIsLN3ZSlAcEj4kUHXjDeXFkhdA7
         EMF4o3EzoL0eC+lsaN1MHAGuwp8w9j8jkLpN5N2n/ZzJXfEyxhnHU6bDZ4d6NSHmetj1
         y2NA==
X-Gm-Message-State: AOJu0YwvGQFa4BF6Fn7dFKaDOj87u9M/5FLICKyfxm6Nly1YMzkyG9ey
        hcbSZYmUmTKX7fzPTPzF8BPeQWOvGsk=
X-Google-Smtp-Source: AGHT+IEkEnXvwPBfRV8MhZybGFH1V7FT5Jj/vEHcDhaYjX/1/i08rqwDhd2s2p1lOpg7vpQpLAHjqQ==
X-Received: by 2002:a7b:c4d6:0:b0:405:3455:d603 with SMTP id g22-20020a7bc4d6000000b004053455d603mr7846261wmk.17.1696598509245;
        Fri, 06 Oct 2023 06:21:49 -0700 (PDT)
Received: from f (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b004063cced50bsm3760071wmc.23.2023.10.06.06.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:21:48 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:21:30 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <20231006132130.bpekoewcsjqz4qps@f>
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
 <yt9dil7k151d.fsf@linux.ibm.com>
 <ZR//+QDRI3sBpqY4@f>
 <yt9d4jj3zzbn.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yt9d4jj3zzbn.fsf@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 02:54:04PM +0200, Sven Schnelle wrote:
> Mateusz Guzik <mjguzik@gmail.com> writes:
> 
> > On Fri, Oct 06, 2023 at 11:19:58AM +0200, Sven Schnelle wrote:
> >> I'm seeing the same with the strace test-suite on s390. The problem is
> >> that /proc/*/fd now contains the file descriptors of the calling
> >> process, and not the target process.
> >> 
> >
> > This is why:
> >
> > +static inline struct file *files_lookup_fdget_rcu(struct files_struct *files, unsigned int fd)
> > +{
> > +       RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> > +                        "suspicious rcu_dereference_check() usage");
> > +       return lookup_fdget_rcu(fd);
> > +}
> >
> > files argument is now thrown away, instead it always uses current.
> 
> Yes, passing files to lookup_fdget_rcu() fixes the issue.

so i wrote this as an immediate fixup. not the prettiest, but should
prevent the need to drop the patch from linux-next.

diff --git a/fs/file.c b/fs/file.c
index 2f6965848907..8d62d6f46982 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1024,7 +1024,7 @@ static inline struct file *files_lookup_fdget_rcu(struct files_struct *files, un
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious rcu_dereference_check() usage");
-	return lookup_fdget_rcu(fd);
+	return __fget_files_rcu(files, fd, 0);
 }
 
 struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd)
