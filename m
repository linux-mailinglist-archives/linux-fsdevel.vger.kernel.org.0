Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA14E192BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYPIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 11:08:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40903 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCYPIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:08:06 -0400
Received: by mail-io1-f68.google.com with SMTP id k9so2553917iov.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5Tg5M04U8oRaersYuusHhIyqF1Ubk5gegSQL8NO9to=;
        b=l1fWZgoXK0sYc3yzJVAuyyxccAqsRcaXFlqx3cWeBGavHVO6wVot318KyHS99i60VD
         YxiWyqQ2cHUPBqyiFnztg7Wsq32z02ms3GG10X2pnaHuC/PaJuaZWihmSzDl1Da6NYys
         RxesEvrTHF2X9j18dj2/nPMuttyoWnYjNNNxZGXJIGPRxv6FG97vgByHXPSuvn1i+kpA
         NT1p612IEcbPbzCRJzAletKyAp5jtFm6QjkyrUO7Nm4nnZUO6cbRNdRaVLK556yUVMEB
         9wWCr33VCk6TCcCUNS77NKrv5gKUJ6eecNmcrGaSPq3A3PH42XdTasDKjoW7cDBY2yq6
         refw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5Tg5M04U8oRaersYuusHhIyqF1Ubk5gegSQL8NO9to=;
        b=I9vI61mCkRSHjylWfgKy3gPQzIWrHJFkw2mvDM76t6Iu5YGwO7p242Gmdnc2CM+QBB
         zgyRyiYZEoUTxAi2j8tFTJ4fycPJUcx4B/ccjW1pU1PB3LDSVPuaBYV3Qpx25EaKrRNG
         UylUfHWOYfMLdMsKnG3MO70y4ZtFWu+i07WfMv5KcDQhcuPUKlUvTQNjZYoQzRDTO8lc
         7ck5pQOCgNTxu8T0MEQEDNEyXaVgyUt20hMjhV+yWo00XOFfSd00jBKqsO6ZfDzD2NCU
         7luQFHW0c5iqxXoJf5h3RAkSBwdYHdp8/v3ipbnebRigyCcGZgDbx/W8IujEPVZwLriV
         RwYw==
X-Gm-Message-State: ANhLgQ0shaS6mwhh7HDQ4JZUWgUnEPgOO5wc11WMMV9VXoMCLrbNk437
        9rFewv12e5L5pTFq3S7bYopbHUsL93U4elJMvcSNvw==
X-Google-Smtp-Source: ADFU+vvodtFXlvXZAcgGT75rfq+O2iHYaz1LjspGd9D2759qSYfwJKII3ntBrW9gfMly0k+0qmtufg0enzZIPKCFhAQ=
X-Received: by 2002:a02:2b02:: with SMTP id h2mr3275931jaa.81.1585148885405;
 Wed, 25 Mar 2020 08:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200319151022.31456-15-amir73il@gmail.com>
 <20200325102150.GG28951@quack2.suse.cz> <CAOQ4uxhNSHiMJROnw9gBqNq9n3nPjkxsYcUhkoAKOeF4bYVsew@mail.gmail.com>
 <20200325145315.GK28951@quack2.suse.cz>
In-Reply-To: <20200325145315.GK28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Mar 2020 17:07:52 +0200
Message-ID: <CAOQ4uxggQ9o4U6aXy0FugxhzpfObgC3o7s_cttTHW==sCxDHrA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] fanotify: report name info for FAN_DIR_MODIFY event
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:53 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-03-20 13:17:40, Amir Goldstein wrote:
> > On Wed, Mar 25, 2020 at 12:21 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 19-03-20 17:10:22, Amir Goldstein wrote:
> > > > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > > > to how fid's are reported.  With name info reporting implemented, setting
> > > > FAN_DIR_MODIFY in mark mask is now allowed.
> > > >
> > > > When events are reported with name, the reported fid identifies the
> > > > directory and the name follows the fid. The info record type for this
> > > > event info is FAN_EVENT_INFO_TYPE_DFID_NAME.
> > > >
> > > > For now, all reported events have at most one info record which is
> > > > either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
> > > > FAN_DIR_MODIFY).  Later on, events "on child" will report both records.
> > >
> > > When looking at this, I keep wondering: Shouldn't we just have
> > > FAN_EVENT_INFO_TYPE_DFID which would contain FID of the directory and then
> > > FAN_EVENT_INFO_TYPE_NAME which would contain the name? It seems more
> > > modular and following the rule "one thing per info record". Also having two
> > > variable length entries in one info record is a bit strange although it
> > > works fine because the handle has its length stored in it (but the name
> > > does not so further extension is not possible).  Finally it is a bit
> > > confusing that fanotify_event_info_fid would sometimes contain a name in it
> > > and sometimes not.
> > >
> > > OTOH I understand that directory FID without a name is not very useful so
> > > it could be viewed as an unnecessary event stream bloat. I'm currently
> > > leaning more towards doing the split but I'd like to hear your opinion...
> > >
> >
> > I was looking at this from application writer perspective.
> > Adding another record header for the name adds no real benefit and
> > only complicates the event parsing code.
> > You can see for example the LTP test, the code to parse FID info header
> > is the exact same code that parses DFID_NAME info.
> > As a matter of fact, I was considering not adding a new info type at all.
> > The existing FID info type already has an optional pad at the end and
> > this pad can be interpreted as a null terminated string.
>
> Well, but *that* would be really confusing because to determine whether
> there's name at the end or not you would have to check whether file handle
> reaches to the end of info record or not.
>
> > The reason I chose to go with and explicit DFID_NAME type is not
> > because of FAN_DIR_MODIFY, it is because of FAN_REPORT_NAME.
> > With FAN_REPORT_NAME, there are 2 info records, one FID record
> > for the victim inode and one DFID_NAME record for the dirent.
> > I really don't think that we should split up DFID_NAME because this
> > is the information that is correct to describe a dir entry.
>
> OK, that's what I figured and I guess it is fine if we explain it properly.
> I've expanded the comment before struct fanotify_event_info_fid definition
> to:
>
> /*
>  * Unique file identifier info record. This is used both for
>  * FAN_EVENT_INFO_TYPE_FID records and for FAN_EVENT_INFO_TYPE_DFID_NAME
>  * records. For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null
>  * terminated name immediately after the file handle.
>  */
>

Sounds good.

Thanks,
Amir.
