Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C761F1E619C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbgE1NE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:04:29 -0400
Received: from nautica.notk.org ([91.121.71.147]:34553 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389949AbgE1NE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:04:28 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 09:04:15 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DC01DC009; Thu, 28 May 2020 14:57:06 +0200 (CEST)
Date:   Thu, 28 May 2020 14:56:51 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, robinhood-devel@lists.sf.net
Subject: Re: robinhood, fanotify name info events and lustre changelog
Message-ID: <20200528125651.GA12279@nautica>
References: <20200527172143.GB14550@quack2.suse.cz>
 <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein wrote on Thu, May 28, 2020:
> Since you started this thread privately, I am replying privately,
> but if you don't mind, please respond with CC to linux-fsdevel, linux-api
> and also lustre lists if you like, so other developers may participate in
> the discussion.

No problem going public; added linux-fsdevel, linux-api as suggested and
robinhood-devel for the robinhood side.
It might be interesting to retrofit lustre changelogs into the fanotify
API at some point but I don't see it likely to happen, so let's start
small for now :)

> > (Probably the same as most filesystem indexers would want, I would use
> > it for robinhood[1] - it normally consumes lustre changelogs and not
> > local vfs events so $job doesn't really care, but I would use a fanotify
> > mode for home once it becomes useable because why not :D)
> >
> > [1] https://github.com/cea-hpc/robinhood/
> 
> This looks very interesting.
> So, do you intend to integrate fanotify with robinhood as a hobby project?
> I wonder, I did not find much evidence of robinhood being used outside of
> the Lustre community and without the Lustre Changelog.
> At least least since 2008, I see no public discussions on devel lists
> and only changes seems related to the Lustre mode.

I know robinhood has also been used to purge NFS home directories
("temp" directories that are less restricted than homes in volume but
get purged after x days), both at CEA and in other companies who reached
out to me privately so I cannot name them.
FWIW on this side netapp filers support something similar to changelogs
in the form of audit loggings, which we never bothered implementing but
would probably be accepted if someone bothered -- but with linux knfsd
maybe fanotify on the server side might work ? I haven't tried.

As far as I know that means people using robinhood on NFS just run full
filesystem scans every day/week/x.



That being said, it is also true that robinhood has very few users
outside of the lustre community; I use it for manual file scrubbing
(verifying checksums on a semi-regular basis) at home. As you pointed
out, that really is in the realm of hobby project even if that helped
find a few bugs.


> I am asking because this project looks like it could be interesting for $job.
> I was looking for a "champion app" to demonstrate new fanotify features.
> I chose inotify-tools for the demo, because it was the easiest to adapt,
> but was going to start a more serious look into Watchman.
> Watchman seems to be in heavy use in Facebook and actively maintained.
> It's starting point is inotify (+fs scanner of course), so I expect it
> would be an
> easier fit than to start from Lustre Changelog as a starting point. or
> not?

robinhood (current master branch) is quite heavily tied to lustre. I
think Cray had started porting the code to use VFS file handles instead
of lustre FIDs to make it easier to use but that never quite finished.
OTOH, robinhood v4 has no adherence to lustre, but is still work in
progress. Quentin in Cc has some proof of concept at ingesting
changelogs.
It has been designed with me in mind so should be much easier to
integrate in there (the lustre portion just converts changelogs to a
robinhood-specific 'fsevents' format which is then injected, so there
would be just that fanotify->fsevents conversion to do), but it is still
very young and doesn't have all the features of v3 so might be less
adapted for a champion project.

I'm not sure what to advise on there, from what I'm reading of watchman
it would probably be easier to integrate with than robinhood v3 for
sure, so if you want code to go into a currently-running version it
might be easier to go with that.
(if you do want to do the work for robinhood v3 though I think we would
be happy to integrate the change even with v4 underway, but I am not
responsible for that so cannot make promises; we'd probably be happier
with v4 as a target in the long run)


> I couldn't find the documentation for Lustre Changelog format, because
> the name of the feature is not very Google friendly.
> But looking at the robinhood source code, the direction we are going
> with fanotify seems to be consistent with the designs of Lustre Changelog.
> 
> I am including some snippets from robinhood  chglog_reader.c
> that Jan may find interesting:
> 
> #define PFID(_pid) (_pid)->fs_key, (_pid)->inode
> #define CL_NAME_ARG(_rec_) PFID(&(_rec_)->cr_pfid), (_rec_)->cr_namelen, \
>         rh_get_cl_cr_name(_rec_)
> #define CL_EXT_FORMAT   "s="DFID" sp="DFID" %.*s"
> #elif defined(HAVE_CHANGELOG_EXTEND_REC)
>         if (fid_is_sane(&rec->cr_sfid)) {
>             len = snprintf(curr, left, " " CL_EXT_FORMAT,
>                            PFID(&rec->cr_sfid),
>                            PFID(&rec->cr_spfid),
>                            changelog_rec_snamelen((CL_REC_TYPE *)rec),
>                            changelog_rec_sname((CL_REC_TYPE *)rec));
> 
>     /* parent id is always set when name is (Cf. comment in lfs.c) */
> 
>             /* Ensure compatibility with older Lustre versions:
>              * push RNMFRM to remove the old path from NAMES table.
>              * push RNMTO to add target path information.
>              */
> 
> It looks like the Lustre change record "extended" format is on par with
> the information that the fanotify name info events that patches v3 [1]
> are providing for events "on child" (e.g FAN_MODIFY).

Here are a few example (logs of) changelogs so you get an idea; but it
looks like you understood this correctly (filenames and jobnames
retracted for privacy; we don't actually use the jobnames for robinhood
itself)
2020/05/28 03:49:26 [383/2] fsname-MDT0001: 62545421787 13TRUNC 1590630534.494881281 0xe t=[0xcc005c7aa:0x12cf7:0x0] J=jobname
2020/05/28 03:49:26 [383/2] fsname-MDT0001: 62545421788 11CLOSE 1590630534.495782850 0x43 t=[0xcc005c7aa:0x12cf7:0x0] J=jobname
2020/05/28 03:49:26 [383/2] fsname-MDT0001: 62545422212 01CREAT 1590630535.038294162 0x0 t=[0xcc0056422:0x1e071:0x0] p=[0xcc0056422:0x1e005:0x0] filename J=jobname
2020/05/28 03:49:26 [383/2] fsname-MDT0001: 62545448338 08RENME 1590630550.659753428 0x0 t=[0:0x0:0x0] p=[0xcc005f145:0x12da:0x0] filename_from s=[0xcc00600d7:0xe0:0x0] sp=[0xcc005f145:0x12da:0x0] filename_to J=jobname
2020/05/28 03:49:26 [383/2] fsname-MDT0001: 62545449617 06UNLNK 1590630551.756078437 0x1 t=[0xcc005ff7f:0x42bd:0x0] p=[0xcc0057c27:0x1dc1d:0x0] filename J=jobname
2020/05/28 03:49:58 [383/2] fsname-MDT0001: 62545494822 14SATTR 1590630574.376208143 0x14 t=[0xcc005f9a4:0xa9a6:0x0] J=jobname
2020/05/28 03:51:02 [383/2] fsname-MDT0001: 62545616687 02MKDIR 1590630648.489224641 0x0 t=[0xcc0045fd0:0x8e4b:0x0] p=[0xcc0036d90:0x1:0x0] 

So you always have object fid being acted on, and (parent fid + name
component) for source and destination if they matter (e.g. setattr won't
have any name, but create will have one, and rename both)


> It is not clear to me if Lustre Changelog provides the "extended"
> record for create/rename/delete, but we were not planning to do that.

Ok.

> There is one critical difference between a changelog and fanotify events.
> fanotify events are delivered a-synchronically and may be delivered out
> of order, so application must not rely on path information to update
> internal records without using fstatat(2) to check the actual state of the
> object in the filesystem.

lustre changelogs are asynchronous but the order is guaranteed so we
might rely on that for robinhood v4, but full path is not computed from
information in the changelogs. Instead the design plan is to have a
process scrub the database for files that got updated since the last
path update and fix paths with fstatat, so I think it might work ; but
that unfortunately hasn't been implemented yet.
(so db update would be done in multiple steps; but it should also be
possible to supplement informations in the pipeline, because lustre
changelogs doesn't have size etc which are in the db and that might also
be able to take care of path updates; I guess both models should work
for fanotify since the stat itself is synchronous and you can get path
from /proc/self/fd/x on local filesystems (it doesn't work on lustre;
there's a fid2path helper though))

robinhood v3 systematically does a stat and recomputes path from fid.

> For that reason, we defined the FAN_DIR_MODIFY event, which carries
> info of parent fid and name that can be used for fstatat(2).
> As of yesterday, FAN_DIR_MODIFY is disabled in master, so will not be
> available in v5.7. We are planning to re-able it in the future with an
> appropriate fanotify_init(2) flag for reporting file names.

Yes that started this thread :)
I'm happy to run tests with a custom branch if you need to; we run rhel
kernels normally so would need to recompile anyway.

Thanks!
-- 
Dominique
