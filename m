Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393221926F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYLRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 07:17:54 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38665 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYLRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:17:53 -0400
Received: by mail-il1-f193.google.com with SMTP id m7so1458873ilg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl6ezVCf3X1P/JgOgid/+M/E+x7M+YudH57ISIINcRE=;
        b=pkV4XWyu2DtFEN0kZ/X6zb7G2mp9bS0m9C7LOtU0G6jdRNls6drvxyZR4gtbC13W3T
         BgG8zznfQsZyyRYWZMxyxrBwechtMPYpP7aqii31K+sTqkORTBGC+qdY7Ic5mW2KwVgF
         ry55PeSd6duxK5zXBeeieNtZcA1LpIeuda4B0ZNriI8vLcfqR7ykMA2kZztRTYISKtOn
         5bnj/vJGm0rkXgSLzeFdHAiN5pvYiKHwSAHeI/RFmsRCPRkQHjnYuxWJ/DyrtYSPaST/
         tLGmCmbdD7ClzMha19FuuGaRLhdl2CUETj6VFvT1h8S7i9JhQTlGcbeiCbiW7gZVo0Zo
         vxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl6ezVCf3X1P/JgOgid/+M/E+x7M+YudH57ISIINcRE=;
        b=UP3KPjzJy7yuUz1gUtqp8pQq/yC26dOXpSNR/9E6qMrRzYmMVNjwsl+PEE66oufQDs
         oGgOdmE8elng/vV/XaDgnvnARr4ls3vXy0qM2+hTco8wnsuvHW32YSkQHyi8aG9vF/Vw
         u6exnyIZeDF7VnhHsQ91yvTYHsRoRmJQFkw8tpv4CixhBdped8cfqj0Qt+nxlnL30Ryw
         sazXwkOgBavdAuSe5NRfl0njC2qPp9ExoA5Dbh/hri5MjGrodZsG5kXdF34b/QElbs39
         frlt6eJIqBukgT5UUT2GOS6bofkkRV/UzsUVSKBtpexFtYmSNzYeY/HITlUdVJvWRfIW
         6npA==
X-Gm-Message-State: ANhLgQ1XftuLWTuMvelGgUGyeHxw2t9MMdxrF2cqfRkBNumekg6IoGxV
        V9undmTImjEtbzXuV5JFrQch7gUvLYZhQdGka4o=
X-Google-Smtp-Source: ADFU+vstg6oTmXM0n7nLYzzZswHeZJ/Ka3z62qOHsitEE0R/Lyw+eUAvJGfKqWxCOqwbPl8VXIb89kDfcbKbrnn4JRM=
X-Received: by 2002:a92:5b51:: with SMTP id p78mr2878884ilb.250.1585135072737;
 Wed, 25 Mar 2020 04:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200319151022.31456-15-amir73il@gmail.com>
 <20200325102150.GG28951@quack2.suse.cz>
In-Reply-To: <20200325102150.GG28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Mar 2020 13:17:40 +0200
Message-ID: <CAOQ4uxhNSHiMJROnw9gBqNq9n3nPjkxsYcUhkoAKOeF4bYVsew@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] fanotify: report name info for FAN_DIR_MODIFY event
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:21 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-03-20 17:10:22, Amir Goldstein wrote:
> > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > to how fid's are reported.  With name info reporting implemented, setting
> > FAN_DIR_MODIFY in mark mask is now allowed.
> >
> > When events are reported with name, the reported fid identifies the
> > directory and the name follows the fid. The info record type for this
> > event info is FAN_EVENT_INFO_TYPE_DFID_NAME.
> >
> > For now, all reported events have at most one info record which is
> > either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
> > FAN_DIR_MODIFY).  Later on, events "on child" will report both records.
>
> When looking at this, I keep wondering: Shouldn't we just have
> FAN_EVENT_INFO_TYPE_DFID which would contain FID of the directory and then
> FAN_EVENT_INFO_TYPE_NAME which would contain the name? It seems more
> modular and following the rule "one thing per info record". Also having two
> variable length entries in one info record is a bit strange although it
> works fine because the handle has its length stored in it (but the name
> does not so further extension is not possible).  Finally it is a bit
> confusing that fanotify_event_info_fid would sometimes contain a name in it
> and sometimes not.
>
> OTOH I understand that directory FID without a name is not very useful so
> it could be viewed as an unnecessary event stream bloat. I'm currently
> leaning more towards doing the split but I'd like to hear your opinion...
>

I was looking at this from application writer perspective.
Adding another record header for the name adds no real benefit and
only complicates the event parsing code.
You can see for example the LTP test, the code to parse FID info header
is the exact same code that parses DFID_NAME info.
As a matter of fact, I was considering not adding a new info type at all.
The existing FID info type already has an optional pad at the end and
this pad can be interpreted as a null terminated string.

The reason I chose to go with and explicit DFID_NAME type is not
because of FAN_DIR_MODIFY, it is because of FAN_REPORT_NAME.
With FAN_REPORT_NAME, there are 2 info records, one FID record
for the victim inode and one DFID_NAME record for the dirent.
I really don't think that we should split up DFID_NAME because this
is the information that is correct to describe a dir entry.

Thanks,
Amir.
