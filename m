Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659953EB321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 11:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhHMJEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbhHMJEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:04:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D499C0617AF;
        Fri, 13 Aug 2021 02:03:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q16so9959456ioj.0;
        Fri, 13 Aug 2021 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IU1MAs15QhSOokA/mCAGpwR945tDiRgha6UsXNzqLU=;
        b=nr7o1wZsCIhIxvDXWivw8rxFiJBJmO5C6sudjJpZe/yyZiO8KioNVBGiQvxvmi9/G8
         RLzIyWYocj/Ql6pldt5lgD+qTMFkR9ZpA5YdO6gvaibl8PzG02WF8L7scloMyCkxm7FP
         +kx1gvVPpHYWg7tDe/EHLcBvhJXA+x59VjP+uXkm19PLFT2cXxzv3vG1UZ7qKjem2sbR
         a9off+AWIZZc047VIpzLcDNaBltK1fticdUX6+IR1bcGgsL2BO/opdSWLwqeEKYkoyEg
         f2EaWWK1yk1GmuiFHqbuouQQ1WL5h6Na4XITT628VbBRCNOFUh65o0iKgdM5hGWb+n8d
         b3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IU1MAs15QhSOokA/mCAGpwR945tDiRgha6UsXNzqLU=;
        b=H/VdscNnP3zBDl2/nBMk1k3rorrcM8Y8pvjykWn6RBcbJU7UnpgjhXgQclAuL9n1di
         bERFLynm+DCnrJXiUCayqs+ijcT2dgZKOmiblbqNZD+xRNYFgOwiW5uQ3ssurp1y6U2q
         61Wt4468aIlVqq1qvAYxA+6tNvJlrpfdQej7jA41o0aoXVdP4w/TbN1xDVkcZnl9na4E
         5xlwlDtV62L9ATt+qPl3rnPhI20yL3C9je49ng1+wMduwA83zUB/ioVsFE6QhH14aJOr
         Gn9OMmHyiDsFsQx29yCE5LATjR6sYEuMAcaDJz54ttaDNcxnKVJsynHZ83CFy14Y9nPh
         aJFQ==
X-Gm-Message-State: AOAM533lvLNLp4qhkjfQlGpIVbGdcxn0Phxxn9AKfnDzxaOgACf1njmX
        mkDorpmJS4BL+tkOk9cPveww5nhkxwtx2U+yQO4=
X-Google-Smtp-Source: ABdhPJxi3Ff7yD+kkBUjfAxzkgjGhuUfI5DfvJHaYB/yBirw8OGJGJtBArG9eOpPHVYgvJktWOw97JE5cAeK8r1lLQY=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr1255731ioq.5.1628845414661;
 Fri, 13 Aug 2021 02:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-18-krisman@collabora.com> <CAOQ4uxg1ZhZi25aeF80a2bdWo8p+3ZNMZegZBi2PKM5fa_GfYg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg1ZhZi25aeF80a2bdWo8p+3ZNMZegZBi2PKM5fa_GfYg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 12:03:23 +0300
Message-ID: <CAOQ4uxjJkh8983mL-X5kJLvBgH5MqOvHycwx+Bawmfrm9XS4Yg@mail.gmail.com>
Subject: Re: [PATCH v6 17/21] fanotify: Report fid info for file related file
 system errors
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Plumb the pieces to add a FID report to error records.  Since all error
> > event memory must be pre-allocated, we estimate a file handle size and
> > if it is insuficient, we report an invalid FID and increase the
> > prediction for the next error slot allocation.

This commit message is out dated.

Thanks,
Amir.
