Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65C3C6074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhGLQ3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:29:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhGLQ3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:29:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FF7F21FAF;
        Mon, 12 Jul 2021 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626107183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3uRNTP1vCi9i90yuaaIRydXBPWq4dc9r6dmPEdVUgI=;
        b=XUz/jCxZz6zN0mw8QE2GWcbn288WwXuiqy/i4/bz8XLRfbxBwnbA2rHFp+Bg6hnxTbI89Q
        HQ3yNJKkN3/DjRiy2qEu7LAeaX14RjPmKugOEbJw9vjcWYxhwBMi3I9Jos7eV08ToR1vci
        zU+kLTm5Bhnkv63gcNrhSKbdK2WIFtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626107183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3uRNTP1vCi9i90yuaaIRydXBPWq4dc9r6dmPEdVUgI=;
        b=qhDUBppMOsrdMhWoS0TArMvCakpg97Pppi7q9Zeef7V2E9jElelxNYxDNZC7IajklVuaOq
        oik6c3lrCaquL4AQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7FEE8A3B8D;
        Mon, 12 Jul 2021 16:26:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 632F81F2AA9; Mon, 12 Jul 2021 18:26:23 +0200 (CEST)
Date:   Mon, 12 Jul 2021 18:26:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Subject: Re: FAN_REPORT_CHILD_FID
Message-ID: <20210712162623.GA9804@quack2.suse.cz>
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz>
 <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-07-21 16:00:54, Amir Goldstein wrote:
> On Mon, Jul 12, 2021 at 2:10 PM Jan Kara <jack@suse.cz> wrote:
> > On Sun 11-07-21 20:02:29, Amir Goldstein wrote:
> > > I am struggling with an attempt to extend the fanotify API and
> > > I wanted to ask your opinion before I go too far in the wrong direction.
> > >
> > > I am working with an application that used to use inotify rename
> > > cookies to match MOVED_FROM/MOVED_TO events.
> > > The application was converted to use fanotify name events, but
> > > the rename cookie functionality was missing, so I am carrying
> > > a small patch for FAN_REPORT_COOKIE.
> > >
> > > I do not want to propose this patch for upstream, because I do
> > > not like this API.
> > >
> > > What I thought was that instead of a "cookie" I would like to
> > > use the child fid as a way to pair up move events.
> > > This requires that the move events will never be merged and
> > > therefore not re-ordered (as is the case with inotify move events).
> > >
> > > My thinking was to generalize this concept and introduce
> > > FAN_REPORT_CHILD_FID flag. With that flag, dirent events
> > > will report additional FID records, like events on a non-dir child
> > > (but also for dirent events on subdirs).
> >
> > I'm starting to get lost in what reports what so let me draw a table here:
> >
> > Non-directories
> >                                 DFID    FID     CHILD_FID
> > ACCESS/MODIFY/OPEN/CLOSE/ATTRIB parent  self    self
> > CREATE/DELETE/MOVE              -       -       -
> > DELETE_SELF/MOVE_SELF           x       self    self
> > ('-' means cannot happen, 'x' means not generated)
> >
> > Directories
> >                                 DFID    FID     CHILD_FID
> > ACCESS/MODIFY/OPEN/CLOSE/ATTRIB self    self    self
> > CREATE/DELETE/MOVE              self    self    target
> > DELETE_SELF/MOVE_SELF           x       self    self
> >
> > Did I get this right?
> 
> I am not sure if the columns in your table refer to group flags
> or to info records types? or a little bit of both, but I did not
> mean for CHILD_FID to be a different record type.

Yeah, a bit of both.

> Anyway, the only complexity missing from the table is that
> for events reporting a single record with fid of a directory,
> (i.e. self event on dir or dirent event) the record type depends
> on the group flags.
> 
> FAN_REPORT_FID => FAN_EVENT_INFO_TYPE_FID
> FAN_REPORT_DIR_FID => FAN_EVENT_INFO_TYPE_DFID

Right, I didn't realize this.

> > I guess "CHILD_FID" seems somewhat confusing as it isn't immediately clear
> > from the name what it would report e.g. for open of a non-directory.
> 
> I agree it is a bit confusing. FWIW for events on a non-dir child (not dirent)
> FAN_REPORT_FID and FAN_REPORT_CHILD_FID flags yield the exact
> same event info.
> 
> > Maybe
> > we could call it "TARGET_FID"? Also I'm not sure it needs to be exclusive
> > with FID. Sure it doesn't make much sense to report both FID and CHILD_FID
> > but does the exclusivity buy us anything? I guess I don't have strong
> > opinion either way, I'm just curious.
> >
> 
> FAN_REPORT_TARGET_FID sounds good to me.
> You are right. I don't think that exclusivity buys us anything.

OK. I've realized that the exclusivity is needed if we want to report info
enabled by FAN_REPORT_TARGET_FID as FAN_EVENT_INFO_TYPE_FID. Because
otherwise it would not be well defined what information is contained in
FAN_EVENT_INFO_TYPE_FID. So either we have to go for exclusivity or for new
type of event information.

> > > There are other benefits from FAN_REPORT_CHILD_FID which are
> > > not related to matching move event pairs, such as the case described
> > > in this discussion [2], where I believe you suggested something along
> > > the lines of FAN_REPORT_CHILD_FID.
> > >
> > > [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/
> >
> > Yes, I can see FAN_REPORT_CHILD_FID (or however we call it) can be useful
> > at times (in fact I think we made a mistake that we didn't make reported
> > FID to always be what you now suggest as CHILD_FID, but we found that out
> > only when DFID+NAME implementation settled so that train was long gone).
> 
> Yes, we did. FAN_REPORT_TARGET_FID is also about trying to make amends.
> We could have just as well called it FAN_REPORT_FID_V2, but no ;-)

OK, I was suspecting that but wasn't sure :). I guess that's another reason
why exclusivity makes more sense.

> > > Either FAN_REPORT_CHILD_FID would also prevent dirent events
> > > from being merged or we could use another flag for that purpose,
> > > but I wasn't able to come up with an idea for a name for this flag :-/
> > >
> > > I sketched this patch [1] to implement the flag and to document
> > > the desired semantics. It's only build tested and I did not even
> > > implement the merge rules listed in the commit message.
> > >
> > > [1] https://github.com/amir73il/linux/commits/fanotify_child_fid
> >
> > WRT changes to merging: Whenever some application wants to depend on the
> > ordering of events I'm starting to get suspicious.
> 
> I completely agree with that sentiment.
> 
> But note that the application does NOT require event ordering.
> 
> I was proposing the strict ordering of MOVE_ events as a method
> to allow for matching of MOVE_ pairs of the same target as
> a *replacement* for the inotify rename cookie method.

Aha, I see I got confused a bit. Sorry about that.

> > What is it using these events for?
> 
> The application is trying to match MOVE_ event pairs.
> It's a best effort situation - when local file has been renamed,
> a remote rename can also be attempted while verifying that the
> recorded fid of the source (in remote file) matches the fid of the
> local target.
> 
> > How is renaming different from linking a file into a new dir
> > and unlinking it from the previous one which is a series of events that
> > could be merged?
> 
> It is different because renames are common operations that actual people
> often do and link+unlink are less common so we do not care to optimize
> them. Anyway, as many other applications, our application does not
> support syncing hardlinks to remote location, so link+unlink would be
> handled as plain copy+delete and dedup of copied file is handled
> is handled by the remote sync protocol.
> 
> As a matter of fact, a rename could also be (and sometimes is) handled
> as copy+delete. In that case, the remote content would be fine but the
> logs and change history would be inaccurate.
> 
> BTW, in my sketch commit message I offer to prevent merge of all dirent
> events, not only MOVE_, because I claim that there is not much to be
> gained from merging the CREATE/DELETE of a specific TARGET_FID
> event with other events as there are normally very few of those events.
> 
> However, while I can argue why it is useful to avoid merge of dirent events,
> it's not as easy for me to come up with a name for that flag not to
> easily explain the semantics in man page :-/
> so any help with coming up with simplified semantics would be appreciated.

Just a brainstorming idea: How about creating new event FAN_RENAME that
would report two DFIDs (if it is cross directory rename)? On the uAPI side
it is very straightforward I think (unlike inotify where this could not be
easily done because of fixed sized event + name). On the kernel API side we
need to somehow feed the second directory into fsnotify() but with the
changes Gabriel is doing it should not be that painful anymore... And then
we can just avoid any problems with event matching, event merging etc.
Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
