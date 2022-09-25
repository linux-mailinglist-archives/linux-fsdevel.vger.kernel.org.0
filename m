Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F05E96B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIYWxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIYWxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:53:15 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49332A712;
        Sun, 25 Sep 2022 15:53:14 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 63so5001503vse.2;
        Sun, 25 Sep 2022 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6pp/I+EL+ZGpawFf74Dn6cDUTXmZe9ODqMPcA6Z+HGI=;
        b=jPtfisITLAgBXutOTYnPEtR25wWSafODamyAJO4zz+ElcW+rgFb2K3CPLpwAF9vDzH
         tyHCptr7GDRBHJZ53D3Nosfwmm59aPlC/fx9C5+1PMG9jwk8VvCh6Ih72EdibvANxAFs
         +W8+oZQyfVG6jV5c4e05YzprFmwmHmG+CyVUZwNttUc7JtBTGcgRB/SAPbIzb5LZtaxu
         77raljPNTc3p242/p3QUF0keFMrmFVn301DKDqIkxUWYsl53JzjMSMB+Vdk6pR6xUdx9
         2q4qBHHd9aide3N7yc/p0NmWWorIHOhJsypYkNpF61MUBorx1a/gLe+O5jZcE+sE6Ntz
         6HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6pp/I+EL+ZGpawFf74Dn6cDUTXmZe9ODqMPcA6Z+HGI=;
        b=CeZ7sefGFs2lmhv6xRN/mKqiOYReF41lHlmBX7FNDRZQvIgZ2lUUy9y1eVuJ6gqWlo
         LiUPiscO2Cai+x7mFf6ZLEIi1TqLAQi7eXbtgIh39kJtaPij535KChCeS7RfqVCjcEfC
         2k9+1qzKkx+6xtkSk2oVqw39xJNDSR+xUUHR5CbYFnJrnV8Oc1dbZyzGMoLvB19ns81+
         iQCe6U2xuq/jjAggOQdzExkaUWsZ0VRv2GLnHCcLeqTklkLcGdAuCt2wgCRDkoAgBIPO
         +1juoje2VnEguZXCS4SNYsVhA8Cd7YNMws/B6ouU8LJvCpKPkbJOwztkLg4sbmzLrgfA
         uwuA==
X-Gm-Message-State: ACrzQf28GKFNO7JHIOz99CF3jvt8+09ZfOlweBVcdU+rcLovJsZb8KJy
        qJfMbQw8ND3WzCnVJzPwqxp7xEQIZvQ99P0bO+8=
X-Google-Smtp-Source: AMsMyM6utbtVMOl6kMkXwYhwuTJ+moSzt6DvbS3TGArQXjGFGPxmDInP/aYGv+Z63tWH7ERx0t7rF2VO28VTQqOvk24=
X-Received: by 2002:a67:ad15:0:b0:398:6aef:316b with SMTP id
 t21-20020a67ad15000000b003986aef316bmr7864303vsl.17.1664146393908; Sun, 25
 Sep 2022 15:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-5-brauner@kernel.org>
 <CAH2r5mvkSW1FY2tP87mKGrOMkoN8tbOP9r=xJ4XnVbkcrE9guA@mail.gmail.com> <20220923083810.ff7jfaszl7qhoutd@wittgenstein>
In-Reply-To: <20220923083810.ff7jfaszl7qhoutd@wittgenstein>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 25 Sep 2022 17:53:03 -0500
Message-ID: <CAH2r5mt2Em03zN+HgL0=YZ335PLyJoBf5z3H2_Mn7y3rF=xS=A@mail.gmail.com>
Subject: Re: [PATCH 04/29] cifs: implement get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 3:38 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Sep 22, 2022 at 10:52:43PM -0500, Steve French wrote:
> > Looks like the SMB1 Protocol operations for get/set posix ACL were
> > removed in the companion patch (in SMB3, POSIX ACLs have to be handled
>
> Sorry, what companion patch? Is a patch in this series or are you
> referring to something else?

I found it - the patch order was confusing (I saw patches 4 and 27,
but patch 5 was
missed).  The functions I was asking about were deleted in patch 27 in
your series but readded in patch 5 which I had missed.

On the more general topic of POSIX ACLs:
- Note that they are supported for SMB1 (to some servers, including Samba)
- But ... almost all servers (including modern ones, not just ancient
SMB1 servers) support "RichACLs" (remember that RichACLs  were
originally based on SMB/NTFS ACLs and include deny ACEs so cover use
cases that primitive POSIX ACLs can't handle) but for cifs.ko we have
to map the local UID to a global unique ID for each ACE (ie id to SID
translation).  I am interested in the topic for how it is recommended
to map "POSIX ACLs" to "RichACLs."  I am also interested in making
sure that cifs.ko supports the recommended mechanism for exposing
"richacls" - since there are various filesystems that support RichACLs
(including NFS, cifs.ko, ntfs and presumably others) and there are
even xfstests that test richacls.


> > by mapping from rich acls).  Was this intentional or did I miss
> > something? I didn't see the functions for sending these over the wire
> > for SMB1 (which does support POSIX ACLs, not just RichACLs (SMB/NTFS
> > ACLs))
>
> I'm sorry, I don't understand. This is basically a 1:1 port of what you
> currently have in cifs_xattr_set() and cifs_xattr_get() under the
> XATTR_ACL_DEFAULT and XATTR_ACL_ACCESS switches. So basically, the
> patches in this series just add almost 1:1 copies of
> CIFSSMBSetPosixACL() and CIFSSMBGetPosixACL() just that instead of
> operating on void * they operate on a proper vfs struct posix acl. So
> nothing would've changed behavior wise. Ofc, there's always the chance
> that I missed sm especially bc I'm not a cifs developer. :)
>
> >
> >         pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
> >         pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_ACL);



-- 
Thanks,

Steve
