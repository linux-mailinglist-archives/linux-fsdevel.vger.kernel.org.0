Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E651C000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiEENAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiEENAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 09:00:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724D4A922;
        Thu,  5 May 2022 05:56:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o11so3028057qtp.13;
        Thu, 05 May 2022 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2zNSZ7z34605RGjUSbGcNOfuH/EFE45DeZ21jtbg80=;
        b=SgrSvcG/zqMmD1Aq5+dRqptKSr4wQVOtA78nyzkGuTxRDgDarD6x70+FKTZsqDEKce
         S6VGcmdrmiXUsKH+J9XAe/56mJ7lX9hCi+Y4Ux50734ZctiUYS1jzX5BXtb1QdJ74jJK
         uZFIHv2GCuldAMktpgap9Wfmfsf/vjbLsMulp4tKGCzvo9pP/LrJqGSbkOq86LCc5GG6
         OIbNS/Uaa/a0et+soE2hcLGgSg6JWOgayepBljz2VKzj6epRtQmF8d2GgxZ64Cbv7Rfs
         ETxmwXynFNaoi2XxSif8YE9TNpEH/zWCcqsBLdrlytWRV3FzfVIOmjg1Vsz07I8r58qY
         UWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2zNSZ7z34605RGjUSbGcNOfuH/EFE45DeZ21jtbg80=;
        b=Qd/8SfUskcI9T1HptI73e9Dt/GHGmcBG3cF5iphjs5JUYEolNt77SzQKtUV+M/jwp9
         JX03Wt7DXuMM2CfHl0T9X6tDVWEsxYRx01RaHz4NirJZ8Qr9V9qgDX633diAsliBg2zU
         W5If9W2qLmvbufsgWZsIATqkF0G08nfwqrvzLr26b9NYw9u74M/a23/OCiAeR2ElOynJ
         t+wJ7c+YLbE4w8n9qxn0nBYz4dZmZ6+YkYtbhbne8vgzy7KCoHSb/ab+B3YU2ojZkOdo
         u2RXqZ8t1hLJaLGJJi9OPPLSZ5oyZZESt/YAOTVF+MAyUbPmzAYffAVpIQX9U/qURqPJ
         VvSg==
X-Gm-Message-State: AOAM531PO/llTXaoNKOQmkvHWHfLGhTQEcB+0THczTpilY7mvOXfYYIj
        l1AIezDho/OTtEx7mXJMiw5M+2OVZ3PwBSJigcMm9ZBERy9R4A==
X-Google-Smtp-Source: ABdhPJzZisT99LrTtQb1wsHfJwtfXf2HzLuXv1MlTV4JfrfapOznKr2ZY0Y2uDJX2DE0/YDSegcKrkRMizizlE7xEnI=
X-Received: by 2002:ac8:5a4f:0:b0:2ed:d39b:5264 with SMTP id
 o15-20020ac85a4f000000b002edd39b5264mr23780497qta.477.1651755387623; Thu, 05
 May 2022 05:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <YnOmG2DvSpvvOEOQ@google.com> <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
In-Reply-To: <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 May 2022 15:56:16 +0300
Message-ID: <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
Subject: Re: Fanotify API - Tracking File Movement
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+fsdevel

On Thu, May 5, 2022 at 2:22 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Matthew!
>
> On Thu 05-05-22 20:25:31, Matthew Bobrowski wrote:
> > I was having a brief chat with Amir the other day about an idea/use
> > case that I have which at present don't believe is robustly supported
> > by the fanotify API. I was wondering whether you could share some
> > thoughts on supporting the following idea.
> >
> > I have a need to track file movement across a filesystem without
> > necessarily burdening the system by having to watch the entire
> > filesystem for such movements. That is, knowing when file /dir1/a had
> > been moved from /dir1/a to /dir2/a and then from /dir2/a to /dir3/a
> > and so on. Or more simply, knowing the destination/new path of the
> > file once it has moved.
>
> OK, and the places the file moves to can be arbitrary? That seems like a
> bit narrow usecase :)
>
> > Initially, I was thinking of using FAN_MOVE_SELF, but it doesn't quite
> > cut it. For such events, you only know the target location or path of
> > a file had been modified once it has subsequently been moved
> > elsewhere. Not to mention that path resolution using the file
> > identifier from such an event may not always work. Then there's
> > FAN_RENAME which could arguably work. This would include setting up a
> > watch on the parent directory of the file of interest and then using
> > the information record of type FAN_EVENT_INFO_TYPE_NEW_DFID_NAME to
> > figure out the new target location of the file once it has been moved
> > and then resetting the mark on the next parent directory once the new
> > target location is known. But, as Amir rightfully mentioned, this
> > rinse and repeat mark approach is suboptimal as it can lead to certain
> > race conditions.
>
> It seems to me you really want FAN_MOVE_SELF but you'd need more
> information coming with it like the new parent dir, wouldn't you? It would
> be relatively easy to add that info but it would kind of suck that it would
> be difficult to discover in advance whether the directory info will arrive
> with the event or not. But that actually would seem to be the case for
> FAN_RENAME as well because we didn't seem to bother to refuse FAN_RENAME on
> a file. Amir?
>

No, we did not, but it is also not refused for all the other dirent events and
it was never refused by inotify too, so that behavior is at least consistent.
But if we do want to change the behavior of FAN_RENAME on file, my preference
would be to start with a Fixes commit that forbis that, backport it to stable
and then allow the new behavior upstream.
I can post the fix patch.

> > Having briefly mentioned all this, what is your stance on maybe
> > extending out FAN_RENAME to also cover files? Or, maybe you have
> > another approach/idea in mind to cover such cases i.e. introducing a
> > new flag FAN_{TRACK,TRACE}.
>
> So extending FAN_MOVE_SELF or FAN_RENAME looks OK to me, not much thoughts
> beyond that :).

Both FAN_RENAME and FAN_REPORT_TARGET_FID are from v5.17
which is rather new and it is highly unlikely that anyone has ever used them,
so I think we can get away with fixing the API either way.
Not to mention that the man pages have not been updated.

This is from the man page that is pending review:

       FAN_REPORT_TARGET_FID (since Linux 5.17)
              Events for fanotify groups initialized with this flag
will contain additional information
              about the child correlated with directory entry
modification events...
              For the directory entry modification events
              FAN_CREATE,  FAN_DELETE,  FAN_RENAME,  and  FAN_MOVE,
an  additional...

       FAN_MOVED_TO (since Linux 5.1)
              Create an event when a file or directory has been moved
to a marked parent directory...

       FAN_RENAME (since Linux 5.17)
              This  event contains the same information provided by
events FAN_MOVED_FROM
              and FAN_MOVED_TO, ...

       FAN_MOVE_SELF (since Linux 5.1)
              Create an event when a marked file or directory itself
has been moved...

I think it will be easier to retrofit this functionality of FAN_RENAME
(i.e. ...provided
by events FAN_MOVED_FROM, FAN_MOVED_TO, and FAN_MOVE_SELF).
Looking at the code, I think it will also be much easier to implement
for FAN_RENAME
because it is special-cased for reporting.

HOWEVER! look at the way we implemented reporting of FAN_RENAME
(i.e. match_mask). We report_new location only if watching sb or watching
new dir. We did that for a reason because watcher may not have permissions
to read new dir. We could revisit this decision for a privileged group, but will
need to go back reading all the discussions we had about this point to see
if there were other reasons(?).

Thanks,
Amir.
