Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358110474B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 01:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKUALm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 19:11:42 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34972 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUALm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:11:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0F09E8EE10A;
        Wed, 20 Nov 2019 16:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574295102;
        bh=+tXfVBgNIvuxtSziVEi82AvyGHjjOtLK8QV5ox0XJMc=;
        h=Subject:From:To:Cc:Date:From;
        b=P/n0/WnaxEH18dy8kC8vdqb/M67MwTPGrE4tL2dodPfV1XdmJ4y7UVONfFVO+BS0b
         BGe7ralkkV1vTFYT+LeFHXw3lUNuqEd3lw/kDa4yY0pvtVPdtRJ79Yu6I/crm+dO+G
         EBqVvHB3zHrgVzZ68H1NWOr1XJTMFpTBeDkvUSaA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CNFFbuysy5vu; Wed, 20 Nov 2019 16:11:41 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 886CC8EE0D4;
        Wed, 20 Nov 2019 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574295101;
        bh=+tXfVBgNIvuxtSziVEi82AvyGHjjOtLK8QV5ox0XJMc=;
        h=Subject:From:To:Cc:Date:From;
        b=SyIXfwTvMiMszAwb8/nVR9KfaEa3ozFAu5aIa89FwEAGO81nvVlSU1SHBe0wJ/jmP
         oEkt5RXFYZIm/iMbbIe1uhmnfacGzevlF8OHuavj7bdu0DxACHkduUtuEhoU1asbrA
         14Ycn2zcAs/bGItaiOArzt79ZHru6+tbLMuKUVWI=
Message-ID: <1574295100.17153.25.camel@HansenPartnership.com>
Subject: Feature bug with the new mount API: no way of doing read only bind
 mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Nov 2019 16:11:40 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My understanding is the new mount API will eventually replace the
current mount API, so it needs to be feature for feature compatible
before that happens.  I was looking to use the read only bind mount as
a template for reimplementing shiftfs when I discovered that you can't
actually create a read only bind mount with the new API.  The problem
is that fspick() will only reconfigure the underlying superblock, which
you don't want because you only want the bound subtree to become read
only and open_tree()/move_mount() doesn't give you any facility to add
or change options on the bind.

The way it works with the current API is that you create a bind mount
with MS_BIND and then remount it with MS_BIND|MS_REMOUNT|MS_RDONLY
which makes the subtree go read only.  It looks like the nearest way of
getting this to work with the new API would be to add an additional
fspick() flag, say FSPICK_BIND, that tells it to operate on the subtree
not the superblock and then pass this down to fsconfig() so it will
accept the "ro" and "rw" flags and the reconfigure command and nothing
else (although I'd like it to accept additional flags on down the road
for the shiftfs rewrite).

There are some caveats, in that fspick/fsconfig seem to be fairly
adamantly coded to work with the superblock, so the subtree handling
will have to be special cased, but if everyone's happy with that, I can
code up something.

Regards,

James

