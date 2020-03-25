Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49503192B88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 15:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCYOxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 10:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCYOxR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B891AC1D;
        Wed, 25 Mar 2020 14:53:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 40A081E1108; Wed, 25 Mar 2020 15:53:15 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:53:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 14/14] fanotify: report name info for FAN_DIR_MODIFY
 event
Message-ID: <20200325145315.GK28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200319151022.31456-15-amir73il@gmail.com>
 <20200325102150.GG28951@quack2.suse.cz>
 <CAOQ4uxhNSHiMJROnw9gBqNq9n3nPjkxsYcUhkoAKOeF4bYVsew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNSHiMJROnw9gBqNq9n3nPjkxsYcUhkoAKOeF4bYVsew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-03-20 13:17:40, Amir Goldstein wrote:
> On Wed, Mar 25, 2020 at 12:21 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 19-03-20 17:10:22, Amir Goldstein wrote:
> > > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > > to how fid's are reported.  With name info reporting implemented, setting
> > > FAN_DIR_MODIFY in mark mask is now allowed.
> > >
> > > When events are reported with name, the reported fid identifies the
> > > directory and the name follows the fid. The info record type for this
> > > event info is FAN_EVENT_INFO_TYPE_DFID_NAME.
> > >
> > > For now, all reported events have at most one info record which is
> > > either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
> > > FAN_DIR_MODIFY).  Later on, events "on child" will report both records.
> >
> > When looking at this, I keep wondering: Shouldn't we just have
> > FAN_EVENT_INFO_TYPE_DFID which would contain FID of the directory and then
> > FAN_EVENT_INFO_TYPE_NAME which would contain the name? It seems more
> > modular and following the rule "one thing per info record". Also having two
> > variable length entries in one info record is a bit strange although it
> > works fine because the handle has its length stored in it (but the name
> > does not so further extension is not possible).  Finally it is a bit
> > confusing that fanotify_event_info_fid would sometimes contain a name in it
> > and sometimes not.
> >
> > OTOH I understand that directory FID without a name is not very useful so
> > it could be viewed as an unnecessary event stream bloat. I'm currently
> > leaning more towards doing the split but I'd like to hear your opinion...
> >
> 
> I was looking at this from application writer perspective.
> Adding another record header for the name adds no real benefit and
> only complicates the event parsing code.
> You can see for example the LTP test, the code to parse FID info header
> is the exact same code that parses DFID_NAME info.
> As a matter of fact, I was considering not adding a new info type at all.
> The existing FID info type already has an optional pad at the end and
> this pad can be interpreted as a null terminated string.

Well, but *that* would be really confusing because to determine whether
there's name at the end or not you would have to check whether file handle
reaches to the end of info record or not.

> The reason I chose to go with and explicit DFID_NAME type is not
> because of FAN_DIR_MODIFY, it is because of FAN_REPORT_NAME.
> With FAN_REPORT_NAME, there are 2 info records, one FID record
> for the victim inode and one DFID_NAME record for the dirent.
> I really don't think that we should split up DFID_NAME because this
> is the information that is correct to describe a dir entry.

OK, that's what I figured and I guess it is fine if we explain it properly.
I've expanded the comment before struct fanotify_event_info_fid definition
to:

/*
 * Unique file identifier info record. This is used both for
 * FAN_EVENT_INFO_TYPE_FID records and for FAN_EVENT_INFO_TYPE_DFID_NAME
 * records. For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null
 * terminated name immediately after the file handle.
 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
