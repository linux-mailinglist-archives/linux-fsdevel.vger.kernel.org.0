Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7520C1C0E67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgEAGzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgEAGzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:55:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED7EC035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 23:55:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id w7so4547743ybq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DNSPQVHgnGMT7sRQ0G+bJof/EKDx7CgrZSQHfFHD7Dc=;
        b=j2a4bDgeZMcdoaIJ04V2JUGS5RaJAOfkGh2351tVXbHDd/PfRizbVOgFvAne9ZtmGZ
         6SM1jfwvKzUTNu6dnvZzse/b3g+NBAsHPdjeDcSdKXvdG5Emdkg3JTnyo05vh6ljBAdB
         zYPEmd2jxSfe2dQOvLKi4ILvXuSDEWOjBVuYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DNSPQVHgnGMT7sRQ0G+bJof/EKDx7CgrZSQHfFHD7Dc=;
        b=NZ3lWOZsYcySzn8Cxf3lI/YocJvpkl0ByRPuCWlwHzwbEG1YI1/a6+F2D38ZDOta6r
         /kwnhUhYANdUmVb5ki8ophITupKThLD0TwoGDdDyjRQ3McY1p6gIhGOjIYK3wQj+QV7W
         LZXO+qZy+XtzSFmeBBGSk9oH6ztzF44LnKIqAbSql55IgMX/XYlmSlwj+gbB13rikTIB
         3vCuNkCc1kK3wTjiZmkNjeyLTCP55I+g3jodZffurzjlnS8XVV3TRVXHf4pJ/BTMwotE
         iZ1GWs4ate+r5dZrIaZ2kbCeSaRHmmaRG5Y27fRAz9DK/ghde+bJb3HqJaqAdGWR8rAE
         rC+w==
X-Gm-Message-State: AGi0PuaIhIn7NeXYLD7w+4BitBdk96cQq9mPk4TWeQoVIU2MWnqLzJOl
        FmQFjWaDGupy28zd2m+aT3nm/kTPMOO+lFOwpdO5/NGTQ0k=
X-Google-Smtp-Source: APiQypLJquMo0bKWbryUWC9xA6bGz4i7ataG+8xOrMyQ22SxMdlX1wBFX0AZklDlXm2Qvc2zqBr/Hku8AzkuTajsV+g=
X-Received: by 2002:a25:4e57:: with SMTP id c84mr4231351ybb.95.1588316131001;
 Thu, 30 Apr 2020 23:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 1 May 2020 15:55:20 +0900
Message-ID: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
Subject: fuse doesn't use security_inode_init_security?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I noticed that the fuse module doesn't currently call
security_inode_init_security and I was wondering if there is a
specific reason for that.  I found a patch from 2013[1] that would
change fuse so that it would call that function but it doesn't appear
that the patch was merged.

For background: I currently have a virtio-fs server with a guest VM
that wants to use selinux.  I was able to enable selinux support
without much issue by adding

    fs_use_xattr virtiofs u:object_r:labeledfs:s0;

to the selinux policy in the guest.  This works for the most part
except that `setfscreatecon` doesn't appear to work.  From what I can
tell, this ends up writing to `/proc/[pid]/attr/fscreate` and the
attributes actually get set via the `inode_init_security` lsm hook in
selinux.  However, since fuse doesn't call
`security_inode_init_security` the hook never runs so the
file/directory doesn't have the right attributes.

Is it safe to just call `security_inode_init_security` whenever fuse
creates a new inode?  How does this affect non-virtiofs fuse servers?
Would we need a new flag so that servers could opt-in to this behavior
like in the patch from [1]?

Thank you,
Chirantan

[1] https://sourceforge.net/p/fuse/mailman/message/31624830/
