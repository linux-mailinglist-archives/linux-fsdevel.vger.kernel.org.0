Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA44D44EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 11:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiCJKqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 05:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCJKqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:46:18 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524C13EF93;
        Thu, 10 Mar 2022 02:45:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id k2so5514431oia.2;
        Thu, 10 Mar 2022 02:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtZtiS/uvYJbJIxJCwqUP3IusviE+rDCLljjvUkKfns=;
        b=l+h4ZwS/kegEuXydA/53sMRa2wkPkF8H6GG4VtP/aKj7vUtR6RxSNYpQnqKHxfL7iK
         Ki84aCdjaEaFOrJscJdmUO9bDdDU8PQTVH2s42YhumBebe6sAOsib7paEEMDHYrSdf6a
         bpr6qnrW+fYDicjjr6D2BLRa4lLeKCVP9Gv2Fz12w/isEDvTB1ljvcg+LNxO6BixQmfd
         WfSZel1JiHokPI0dQu4KhSLE6keu5SZYLmnAFLK7kAqt+j33ctDu5IxNTkbZFSu9vLgI
         3kQXzUc1rODWPLhqDWH+Cqfx9XbI4/wRoUiq/5nonTNfPtYs5QeGZ9oCPxBMkV3GVXFk
         9eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtZtiS/uvYJbJIxJCwqUP3IusviE+rDCLljjvUkKfns=;
        b=vjU4fumc681ssfqhTC5oum1uBltxu3eNbbs/RFBeZpmlo8+qgGkdYvw6ZunjbPA5Xp
         SfuH6N9HJFQmToV9wNgjRV6+nzr3NsuOVuN64JhJSegKx/vTtLGdnVwBLA0pgo5TNboW
         D+hrCAmo3qBEsgd4kC6GQXK+Ks10scR3n0e0/GsaWf6Uo2WEKbjb4cHNVzNcTJvE8bRT
         SY/I1WX00XfI+WKFjMNPMZxY99FcHxf1dhVBFYqOB6UYVNSuI9W1KupDCSAG644jspKW
         +ooR4qb3X1XGc3G3JSLoBSMhlWqpx1y9QNkIi5YzGSHtm+BdySTVAC/pAS2YDKwK6019
         cjLA==
X-Gm-Message-State: AOAM530huvpj9yxNe38EhK1ztgLDBUgWOR5dPE2zeNw2fMU5T+Q7ATAU
        onpjm2R3zBjMtp5hAA9+hnujKMj6d4m/6mrtI+MuCLE/
X-Google-Smtp-Source: ABdhPJxnrkuSnEwK1qTJfsGE5y/Vkdpiag0Ibv58unesK7f2zMPzy1/j0bTJ8a4PAszSeVVd9XmpRIUSvn/TfqcNdhw=
X-Received: by 2002:aca:b845:0:b0:2d4:4207:8fd5 with SMTP id
 i66-20020acab845000000b002d442078fd5mr9172773oif.98.1646909116945; Thu, 10
 Mar 2022 02:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20220305160424.1040102-1-amir73il@gmail.com> <20220305160424.1040102-7-amir73il@gmail.com>
 <CAJfpegveDAJMPste+514imoi74MHcgQ_A+BbQEyXmrmAMnEz-A@mail.gmail.com>
In-Reply-To: <CAJfpegveDAJMPste+514imoi74MHcgQ_A+BbQEyXmrmAMnEz-A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Mar 2022 12:45:06 +0200
Message-ID: <CAOQ4uxhXz0_vY6Hn+x_6L1CVK_6akiYLg3Lm12A7PJ=Q+AFD-w@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] fs: report per-sb io stats
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Ted Ts'o" <tytso@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
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

On Thu, Mar 10, 2022 at 11:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sat, 5 Mar 2022 at 17:04, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Show optional collected per-sb io stats in /proc/<pid>/mountstats
> > for filesystems that do not implement their own show_stats() method
> > and have generic per-sb stats enabled.
>
> I still think it's wrong to extend the /proc/*/mount* family of
> interfaces.  The big issue is that the kernel has to generate this
> info for *all* mounts, even though the user may be just looking for
> information on a specific mount.  Your workaround is to enable the
> info generation for only a subset of fs types, but this doesn't solve
> the fundamental issue.
>
> So let's please implement a per-mount interface.  Yes, it's a much
> bigger project, but one which needs to be done at one point, and which
> would be generally useful.   There was tons of discussion around this
> when dhowells tried to create one, and there was a suggestion by Linus
> which I think all parties found acceptable:
>
>  - return basic info in a binary format (similar to e.g. statx)
>  - after the fix binary structure allow misc info to be added using an
> ascii format
>
> And since generating the info may be expensive in some cases, the
> interface would need to allow selective queries (which statx does for
> binary fields, but for ascii ones this is a new challenge).
>
> I think allowing the user to query the list of supported fields should
> also be possible (again, statx supports this).
>
> So there are a number of requirements for this interface, and I'm not
> quite sure what the best solution is.   I can try to put something
> together if there are no objections...

No objections on my part.
Feel free to use the iostat info as a case study for how common vfs info
could be exported using this interface.

Thanks,
Amir.
