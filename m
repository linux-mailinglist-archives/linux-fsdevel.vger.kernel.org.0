Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243851921B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYHYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 03:24:50 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45287 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCYHYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:24:49 -0400
Received: by mail-il1-f193.google.com with SMTP id x16so902485ilp.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cdCSEE9muytieelmK8IqMNAgh0+K2So5V1MEbiO/i4=;
        b=liwvEiPTzPiZxtipw3k8oP+lce4c0DTnSEGW+wbB+7Fw2jAAZcu1+qE+28ZtOAstrw
         aLqeL1En3FfSvSWw0rzwo0ur/l3FqvGs4WGG1CZjeQd/R5qoEnHn8QtNGpF4s1x03wuQ
         YwJxCN2YejmP4nzy2+vqqYB6buKr3QP77z0XyzblgNO5v8LK/eKlWW0AXBd9wu1V0+Sm
         1TTPZVskAmq3oUpml+xsA0TfUyatMG5ve9iyEZFg4izg4rLQpg1VpdaWAWUCMbM+IPim
         CbBmsmXb2Cwrn2+dC46ZCwXFOARgwn5cfMZmgvHfrzV8UcFu/cEQje+THDYdVTg4CeyN
         SvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cdCSEE9muytieelmK8IqMNAgh0+K2So5V1MEbiO/i4=;
        b=q71LixFuJEzP9y70vwR9d875ONfiI1+PA1/rBBUaBmVDxhCZ3IJipCdg1dkKFzCRzZ
         Y5tS/a/MNVpPdLoxUltN6jOxV1OzbslPKXrIlnb9Tlc2wmiKdUZeK9JtF/Yp8s3Nq7ij
         d0bxI8pYmPF28QVKJFG2bVvu5A3dkqcnAF7p0mcDSgAotOIiSUEALIccMHDDVuRP20na
         nkmHeaZ4LJodgVv5S8KPR92TCpsdSWMxyKg8FP0lnBTmIYMAcj90tv7F5JSt+igrNMVM
         OusC/a4VTr2jh9WE+OJaZbP5TBRfX0Y0JqUbiOwfYLjUcyVjILmQHEJC1SVo8rETIY3L
         wHhw==
X-Gm-Message-State: ANhLgQ1I067nJrPKIoakk7ag22ssPL8S+03DRTX9lq2g8iBHE4Hrc533
        33yRyIsMZ61tocUotvbzEc4qlx7fGG7VS55Hi918Mgm/
X-Google-Smtp-Source: ADFU+vvujRybdpaPkNhp9qTfN3S6mX19QLm1XDLECHaBzirtTU5Mjc5kZj/iNBeQtdqq3+XiYV2YA2ibP8LkhxCu94c=
X-Received: by 2002:a92:bb9d:: with SMTP id x29mr2278211ilk.137.1585121088796;
 Wed, 25 Mar 2020 00:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200319151022.31456-11-amir73il@gmail.com>
 <20200324175029.GD28951@quack2.suse.cz>
In-Reply-To: <20200324175029.GD28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Mar 2020 09:24:37 +0200
Message-ID: <CAOQ4uxhh8DJC+5xPjGaph8yKXa_hSxi7ua0s3wUDaV7MPcaStw@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] fanotify: divorce fanotify_path_event and fanotify_fid_event
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 7:50 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-03-20 17:10:18, Amir Goldstein wrote:
> > Breakup the union and make them both inherit from abstract fanotify_event.
> >
> > fanotify_path_event, fanotify_fid_event and fanotify_perm_event inherit
> > from fanotify_event.
> >
> > type field in abstract fanotify_event determines the concrete event type.
> >
> > fanotify_path_event, fanotify_fid_event and fanotify_perm_event are
> > allocated from separate memcache pools.
> >
> > The separation of struct fanotify_fid_hdr from the file handle that was
> > done for efficient packing of fanotify_event is no longer needed, so
> > re-group the file handle fields under struct fanotify_fh.
> >
> > The struct fanotify_fid, which served to group fsid and file handle for
> > the union is no longer needed so break it up.
> >
> > Rename fanotify_perm_event casting macro to FANOTIFY_PERM(), so that
> > FANOTIFY_PE() and FANOTIFY_FE() can be used as casting macros to
> > fanotify_path_event and fanotify_fid_event.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> So I was pondering about this commit. First I felt it should be split and

Oh yeh. The split makes things much clearer!

> second when splitting the commit I've realized I dislike how you rely on
> 'struct fanotify_event' being the first in events that inherit it. That is
> not well maintainable long term since over the time, hidden dependencies on
> this tend to develop (you already had like four in this patch) and then
> when you need to switch away from that in the future, you have a horrible
> time untangling the mess... I also wanted helpers like FANOTIFY_PE() to be
> inline functions to get type safety and realized you actually use
> FANOTIFY_PE() both for fsnotify_event and fanotify_event which is hacky as

Excellent! I avoided the FANOTIFY_E/fsn_event  related cleanups, but now
code looks much better and safe.

> well. Finally, I've realized that fanotify was likely broken when
> generating overflow events (create_fd() was returning -EOVERFLOW which
> confused the caller - still need to write a testcase for that) and you
> silently fix that so I wanted that as separate commit as well.

I don't think you will find a test case.
Before the divorce patch, the meaning of fanotify_event_has_path() is:
         event->fh_type == FILEID_ROOT;
but overflow event with NULL path has:
         event->fh_type = FILEID_INVALID;

So -EOVERFLOW code in was not reachable.
Meaning that your patch "fanotify: Fix handling of overflow event" is
correct, but its commit message is wrong.
It also says: "by default fanotify event queues are unlimited",
but FAN_UNLIMITED_QUEUE is opt-in???

>
> All in all this commit ended up like three commits I'm attaching. I'd be
> happy if you could have a look through them but the final code isn't that
> different and LTP passes so I'm reasonably confident I didn't break
> anything.

The split and end result look very good.
After rebasing my fanotify_name branch on top of your changes, it also
fixed an error in FAN_REPORT_NAME test, which I was going to look
at later, so your cleanup paid off real fast :-)

Thanks,
Amir.
