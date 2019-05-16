Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3D20ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfEPSmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 14:42:15 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32943 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEPSmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 14:42:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id k128so2979ybf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPm2kFhzFoUN2QcFfasgm/ooKXBYOc9Z1g5mqfxaQOI=;
        b=hf5sh0AAwPtSpA4vijmswvJWYIeeHHQGeHti17bjD1YZVsoY4pWOGEcA4aUlQGIeB7
         sKjiSzA6G7QI7E4Xp+X3Ziz3cvF4z2MLuKpH3zcSi9ps/eUEXPkp8H26NDn1Lm97NPaB
         6VWgMZB9OTIe71ePWWSHckO4XAYDM26XkGOgmGc1BWbWYYvShYJOAAo43ZOGLczygiyF
         TCM2yo1C6AjbT2GYgBGLM9WZOFnD6OcwAvU39AwBuTXbOcQHQ2UoVdt7BqmOMt8A9TqS
         tg6Q2PUBqsSXTIceL0P+ORFG3dLfIhTe/59AvLbm+84DMTmvSGtzEI61QfsqdIHCrdvb
         p8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPm2kFhzFoUN2QcFfasgm/ooKXBYOc9Z1g5mqfxaQOI=;
        b=evV8QNzsygEi7ZMidStL3kqIaYOpNfKVinQE3DjfjcP/8XvAiKY4LQgveckSrdE/dG
         x/U2JSWUnbp05cjHhvMt/Lz/7N36pesYng7rtvtCMrffdzmXPnKhC33Ysn3Z094Zvc1x
         35A9QtChYL2RA7xs8PAtJyYYgocKWrUcRGZa4WZFSdwtkSq1U8kzq6lqkVaXrlJHOBTu
         MwOYoLjh6yEVcD0/Xo3Z9sgrtsjfrSaB4/wHccHLrwSUagD9jM2tq7wKQdHejmOdBmdO
         x6vAGjsnIzEwkQgC3YWV2F4L2Lw0WGgmexRxDgqNFN7XvHxhe4ajEa1pFtoGoxUZ1Djh
         k0sQ==
X-Gm-Message-State: APjAAAVzasFkvi3odmrwoFtM+Tstylr1eloYocdMHUd7UPRsV+xj0ny1
        YMfQNfiZXX10Dk+m9yLmFrOBYqn0jSeAGnnVI5Q9Sw==
X-Google-Smtp-Source: APXvYqyXbJVzBTRGLHLWWAtpJ4FBUVmrY0QlLNUlF+k2NsQvrYILs+bi6SGpe4U6CQ0MowKak7I9JFyac9kspG2JCCA=
X-Received: by 2002:a25:b948:: with SMTP id s8mr24308684ybm.325.1558032134405;
 Thu, 16 May 2019 11:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-3-amir73il@gmail.com>
 <20190516170707.GE17978@ZenIV.linux.org.uk>
In-Reply-To: <20190516170707.GE17978@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 21:42:02 +0300
Message-ID: <CAOQ4uxjT=rOzQMNngU_SjP_6GfPv1M8ZC-VHH5jVCyH_pkjjFw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] fs: create simple_remove() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 8:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 16, 2019 at 01:26:29PM +0300, Amir Goldstein wrote:
> > There is a common pattern among pseudo filesystems for removing a dentry
> > from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
> > combination of simple_{unlink,rmdir} and d_delete().
> >
> > Create an helper to perform this common operation.  This helper is going
> > to be used as a place holder for the new fsnotify_{unlink,rmdir} hooks.
>
> This is the wrong approach.  What we have is a bunch of places trying
> to implement recursive removal of a subtree.  They are broken, each in
> its own way, and I'm not talking about fsnotify crap - there are
> much more unpleasant issues there.
>
> Trying to untangle that mess is not going to be made easier by mandating
> the calls of that helper of yours - if anything, it makes the whole
> thing harder to massage.
>
> It needs to be dealt with, no arguments here, but that's not a good
> starting point for that...  I've taken several stabs at that, never
> got anywhere satisfactory with those ;-/  I'll try to dig out the
> notes/existing attempts at patch series; if you are willing to participate
> in discussing those and sorting the whole thing out, you are very welcome;
> just ping me in a couple of days.

Will do.

Thanks,
Amir.
