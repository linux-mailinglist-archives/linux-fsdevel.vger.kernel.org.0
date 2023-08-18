Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13014781344
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbjHRTNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379584AbjHRTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:12:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C993A9A;
        Fri, 18 Aug 2023 12:12:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-986d8332f50so166112766b.0;
        Fri, 18 Aug 2023 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692385963; x=1692990763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWrcVU87yoUh0RKV9M2yRE0DuKukk4JlACojS9ceHP8=;
        b=CD7X8wuOyJh3hjNA0vDliciCLObjw+2g/jB/UiL7vFv0dfTNz2zqt9ka7OzQXx6Etm
         GHd44gN+gUK3TGJiqA3Wpn4DaepVFxry/D4k/xOp44QZ3ZhXB+tcMiPxfijyMfy67UBe
         o4hlF2QkFz2DsrQL4A5TuxOVEMCzWZYauEekvdU4PLW1f6sZcM5U304gjCxBKYMtpZFW
         Rw17oZ4+4QtZKKBfVA+uK2PgXRtmYK+U22F1Hus5H3v2Hst5uqCaCj2sS4TghdcTYHaR
         7Y0AiZVHzv2FDxC+d2sGCOIIF1WQGRybadHOCU7RiIKaO8dOf+8p4qWkx7dAlhWnrk20
         +CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692385963; x=1692990763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWrcVU87yoUh0RKV9M2yRE0DuKukk4JlACojS9ceHP8=;
        b=I6SwD6OCeahagTs0NeD74SFl/eBjunT3VJZjFfM+DEbTafuc2F5+oBobWniYxCOBTe
         FgxqBJCJWfkUajDWj4o42dzNJQ/VYxpzBZ7OYVj9Ejf7WfSL7kG/NR7o/aRLKvHDCl4L
         32h62x2pxWrb/W2rDMaHVMxgvQG8KABEly1nm6S3VUVh0CTv9PTmH+27J3LxUUmyzwxU
         xtQFHqxtzF///aInh889RlJDgFBGDSBS2dhTR5vHkY+xMWFvfZkChG8CbBmA7dNH1uqC
         wjbSEYHMX8zT1CLC7103P979EDUq6Zv1gE4JI6jecPMD1z8gHSij1Ot8C4tBYcTQbxPF
         kWEg==
X-Gm-Message-State: AOJu0YzzX0K8gY9LCt0N3l8hiFtu8ez/Fu8giCMhF5wF+J0fQNwfrslp
        bef2cpGOqGXDrB+ceKRdvNf0/K3cdGtOtQ==
X-Google-Smtp-Source: AGHT+IGRHJbhjyMMDvx8RCIHGJ0hyAwfSTlKV+tEW0CLm2KLBsokdoIDwiEAp/HKoE8xlljK4Xul1w==
X-Received: by 2002:a17:906:cd2:b0:99c:22e0:ae84 with SMTP id l18-20020a1709060cd200b0099c22e0ae84mr77324ejh.28.1692385962652;
        Fri, 18 Aug 2023 12:12:42 -0700 (PDT)
Received: from f (cst-prg-27-89.cust.vodafone.cz. [46.135.27.89])
        by smtp.gmail.com with ESMTPSA id y17-20020a170906525100b00992c92af6f4sm1536006ejm.144.2023.08.18.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:12:42 -0700 (PDT)
Date:   Fri, 18 Aug 2023 21:12:39 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <20230818191239.3cprv2wncyyy5yxj@f>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308181030.0DA3FD14@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:33:26AM -0700, Kees Cook wrote:
> This is a double-check I left in place, since it shouldn't have been reachable:
> 
>         /*
>          * may_open() has already checked for this, so it should be
>          * impossible to trip now. But we need to be extra cautious
>          * and check again at the very end too.
>          */
>         err = -EACCES;
>         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>                          path_noexec(&file->f_path)))
>                 goto exit;
> 

As I mentioned in my other e-mail, the check is racy -- an unlucky
enough remounting with noexec should trip over it, and probably a chmod
too.

However, that's not what triggers the warn in this case.

The ntfs image used here is intentionally corrupted and the inode at
hand has a mode of 777 (as in type not specified).

Then the type check in may_open():
        switch (inode->i_mode & S_IFMT) {

fails to match anything.

This debug printk:
diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..05652e8a1069 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3259,6 +3259,10 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
                if ((acc_mode & MAY_EXEC) && path_noexec(path))
                        return -EACCES;
                break;
+       default:
+               /* bogus mode! */
+               printk(KERN_EMERG "got bogus mode inode!\n");
+               return -EACCES;
        }

        error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);

catches it.

All that said, I think adding a WARN_ONCE here is prudent, but I
don't know if denying literally all opts is the way to go.

Do other filesystems have provisions to prevent inodes like this from
getting here?
