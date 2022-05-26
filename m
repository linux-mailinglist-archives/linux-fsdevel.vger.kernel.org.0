Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D2534D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiEZKfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347031AbiEZKf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 06:35:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8ACEB93
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 03:35:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so2222898ejk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lrAmR0l8GuLtCFLXbrqxh3mKdFuTV80o+dldA7gT/o=;
        b=dE3oFEBcACntazX1/lumZLrBgZgXXCbutveUZlxHxLtPsxSlXJA68I9gK6dJwyNyHk
         u3CAV7xcZWp+FSO6dFXnPRhpXFKF6xNs2jszWvPWHKZWnVxuk4Y6XyuQjT+J4j09dEdV
         rO/juERySWE/1g8RdYAOqDukVwOikZjWcn38K7iIYU8TbOwbIdEz2kWiokwWBa3daFgJ
         eYXJSry+sKItz2tPSjROvuSoszRO7Y0KKSGUyensytSV+Pk7t97pC6qyKbFDHvGGQ8Ps
         KUOB19Km8mlAfKDFWvPDD5McyzMoI9j8QxH0e+YzhRmpHZUyEGvUVKAN5WpJziAb/Yze
         bzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lrAmR0l8GuLtCFLXbrqxh3mKdFuTV80o+dldA7gT/o=;
        b=0qxIK105ZWEsBmjbSXhvw17d975qSZjbq8X12/BDU/2B17H0ifQgCzdawzG7X/NKKd
         MqDokHYFGf7SPCkUONPAYVwk8fAZZG+zDI0UM0/mKVO5Eqx8ktKu/WiFUe/VazSuT20H
         vESRGtovqT1JpmbOndOBSpuUrIEdg+az2QlOl/J6LjQzlYAEnTl3iJCKJGuT429IRTfd
         qwU2KguUn8ovjjdrI0AhDSY8Sv1R94ZOdxgJVHuoG3tUp+fhlJsrJRq8B9MNJ8vbkxlf
         w0KOput2cErmu5pSyCCg6AeKKXcFmBR/+5V+Ugpgo18zpP1svBoat1GQomKYWsfF02PV
         hp5w==
X-Gm-Message-State: AOAM531zOKJfHVPKOpsRhtfdVTrE0xj+HIvZHoz+nZXaSLlvXwH4wV7/
        cxdcQj476XwJ3q7wiRnszhaAlg9Y3T9nCQbr6rSpLg==
X-Google-Smtp-Source: ABdhPJyRKep9sj1jLxmsZ6Al7RLvYprgoZLjKLs/LIKU9JP/IsxmqMDJmI9jCtkMPl/8euwkLv/ShuMmOPAH8skaDtk=
X-Received: by 2002:a17:907:86a5:b0:6f9:aa0f:a838 with SMTP id
 qa37-20020a17090786a500b006f9aa0fa838mr33371872ejc.340.1653561322015; Thu, 26
 May 2022 03:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACy13oVs-0_tTD80d=eL+gsZyA+zJtNMpXBBEd1t7ULsBb6cFg@mail.gmail.com>
In-Reply-To: <CACy13oVs-0_tTD80d=eL+gsZyA+zJtNMpXBBEd1t7ULsBb6cFg@mail.gmail.com>
From:   Yoni Couriel <yonic@google.com>
Date:   Thu, 26 May 2022 13:34:55 +0300
Message-ID: <CACy13oUKeff65Sf_SGjyS5Xy7DDxY3mYnvSZajxiBLuBAObGww@mail.gmail.com>
Subject: ACLs permission check is slightly not aligned with the man page
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     Shahar Hochma <shaharhoch@google.com>,
        Filestore External <filestore-external@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

The POSIX ACLs permission check algorithm implementation is different
from the man page [1] in an edge case scenario. When the mask
(ACL_MASK) is present but empty, a user who's not the owner will get
the permissions of "others" instead of being denied access.

The root cause is thought to be this line [2] in namei.c, which skips
ACL check if the mask is empty. It affects all file systems that use
the "generic_permission" function to check permissions. It can be
traced way back to old kernel versions [3].

The relevant section from the man page:
"
Access Check Algorithm
...
2. else if the effective user ID of the process matches the qualifier
of any entry of type ACL_USER, then
if the matching ACL_USER entry and the ACL_MASK entry contain the
requested permissions, access is granted,
else access is denied.
"

It would be nice to align the code and the man page, though we're not
sure which one should be fixed.


Steps to reproduce:

1) Normal operation

touch file
chmod 0777 file
setfacl -m u:user1:rw- file
setfacl -m u:user2:--- file
setfacl -m m::r--- file

# Permissions:
# user1: r--
# user2: ---

2) Clear out the mask

setfacl -m m::--- file

# Expected permissions:
# user1: ---
# user2: ---

# Actual permissions:
# user1: rwx  -> MISMATCH WITH MAN PAGE
# user2: rwx  -> MISMATCH WITH MAN PAGE


[1] See "Access Check Algorithm" in https://linux.die.net/man/5/acl
[2] https://elixir.bootlin.com/linux/v5.18/source/fs/namei.c#L349
[3] See "__ext3_permission" function in
https://lore.kernel.org/all/E17zVaV-00069k-00@snap.thunk.org/

Thanks,
Yoni Couriel
https://cloud.google.com/filestore
