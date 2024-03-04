Return-Path: <linux-fsdevel+bounces-13445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ADE8700EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A76B1F22C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CC3C468;
	Mon,  4 Mar 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHvAtaF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AA3C06A
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553997; cv=none; b=HErmKPv6b/1RTle85Mz2Zzjpd19IkS4hSXpDU64nDnoj1/oBwv3tmFVmlF25uprDr3HT9XD8AHA+SAeTBRLBkfhxMZxCtXFhsfi8M/eyudO/UOiiWa2HBZEZxWF1Or2D3twzXxPigDGkx/0kQ7rFFm07wQez+K4IOXxISD6NHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553997; c=relaxed/simple;
	bh=HRg4f3jd29etqSJqAtDdFT3rBpTJuPbhztBINNNMTwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS1sLM6EK80Z/NT/OqqGjS4vYPcfJ9fRMlktGyUP7ecTgM//6v2Gi0sgoCW2bJYWw9xD97i5m1DFY2b8REmfNtEdEkYBHJEli2Y7/1iRFytXE9jPnfXjK3ADZYXDIASfyZ42QJSNyqvaFcN4MZBXltMYyccjUYzRiWfV3Sq95E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHvAtaF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13716C433F1;
	Mon,  4 Mar 2024 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709553997;
	bh=HRg4f3jd29etqSJqAtDdFT3rBpTJuPbhztBINNNMTwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHvAtaF4cxjHlg30bXyGFnfQY/MjrAY/gzT9ACwapQqFv6TbXe5vPhgVkwScLb2Fi
	 D2sXk49Rrpo36SFrbQp0VZcr55LrFyRW+vciqKGaIZrmxf35GDghCOI7mxCWoAqTh3
	 7YOoeBjZft70s5A41ql+tBHKb1/ll144QWzftMpe2qJD2PaxjhAxj6XfI59yGYOvjo
	 EkhgdgEiY3a2ABsvZAP+r9/3LhWxd3au5wprABjoW8XjyT6/h4zg2Ca2+8fG362jKl
	 qPuwRTTA9yuS0ex+CRKzw1SJLIbLCt58aSCMhy/PQjh6Q6yFN3Znh5HRLAKrMrL/tJ
	 OKd7ZUR3Xzgqg==
Date: Mon, 4 Mar 2024 13:06:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240304-hohen-wesen-2544c12000ff@brauner>
References: <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3>
 <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
 <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
 <20240215115139.rq6resdfgqiezw4t@quack3>
 <CAOQ4uxh-zYN_gok2mp8jK6BysgDb+BModw+uixvwoHB6ZpiGww@mail.gmail.com>
 <20240219110121.moeds3khqgnghuj2@quack3>
 <CAOQ4uxizF_=PK9N9A8i8Q_QhpXe7MNrfUTRwR5jCVzgfSBm1dw@mail.gmail.com>
 <20240304103337.qdzkehmpj5gqrdcs@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304103337.qdzkehmpj5gqrdcs@quack3>

On Mon, Mar 04, 2024 at 11:33:37AM +0100, Jan Kara wrote:
> On Tue 27-02-24 21:42:37, Amir Goldstein wrote:
> > On Mon, Feb 19, 2024 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 15-02-24 17:40:07, Amir Goldstein wrote:
> > > > > > Last time we discussed this the conclusion was an API of a group-less
> > > > > > default mask, for example:
> > > > > >
> > > > > > 1. fanotify_mark(FAN_GROUP_DEFAULT,
> > > > > >                            FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > > > >                            FAN_PRE_ACCESS, AT_FDCWD, path);
> > > > > > 2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
> > > > > > 3. then HSM is started and subscribes to FAN_PRE_ACCESS
> > > > > > 4. and then the mount is moved or bind mounted into a path exported to users
> > > > >
> > > > > Yes, this was the process I was talking about.
> > > > >
> > > > > > It is a simple solution that should be easy to implement.
> > > > > > But it does not involve "register the HSM app with the filesystem",
> > > > > > unless you mean that a process that opens an HSM group
> > > > > > (FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
> > > > > > be given FMODE_NONOTIFY files?
> > > > >
> > > > > Two ideas: What you describe above seems like what the new mount API was
> > > > > intended for? What if we introduced something like an "hsm" mount option
> > > > > which would basically enable calling into pre-content event handlers
> > > >
> > > > I like that.
> > > > I forgot that with my suggestion we'd need a path to setup
> > > > the default mask.
> > > >
> > > > > (for sb without this flag handlers wouldn't be called and you cannot place
> > > > > pre-content marks on such sb).
> > > >
> > > > IMO, that limitation (i.e. inside brackets) is too restrictive.
> > > > In many cases, the user running HSM may not have control over the
> > > > mount of the filesystem (inside containers?).
> > > > It is true that HSM without anti-crash protection is less reliable,
> > > > but I think that it is still useful enough that users will want the
> > > > option to run it (?).
> > > >
> > > > Think of my HttpDirFS demo - it's just a simple lazy mirroring
> > > > of a website. Even with low reliability I think it is useful (?).
> > >
> > > Yeah, ok, makes sense. But for such "unpriviledged" usecases we don't have
> > > a deadlock-free way to fill in the file contents because that requires a
> > > special mountpoint?
> > 
> > True, unless we also keep the FMODE_NONOTIFY event->fd
> > for the simple cases. I'll need to think about this some more.
> 
> Well, but even creating new fds with FMODE_NONOTIFY or setting up fanotify
> group with HSM events need to be somehow priviledged operation (currently
> it requires CAP_SYS_ADMIN). So the more I think about it the less obvious
> the "unpriviledged" usecase seems to be.
> 
> > > > > These handlers would return EACCESS unless
> > > > > there's somebody handling events and returning something else.
> > > > >
> > > > > You could then do:
> > > > >
> > > > > fan_fd = fanotify_init()
> > > > > ffd = fsopen()
> > > > > fsconfig(ffd, FSCONFIG_SET_STRING, "source", device, 0)
> > > > > fsconfig(ffd, FSCONFIG_SET_FLAG, "hsm", NULL, 0)
> > > > > rootfd = fsconfig(ffd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)

Do you absolutely need that superblock to exist? It would probably be
better if you extended struct fs_context to carry the hsm information
and then you later attach it to the superblock once it's created.

> > > > > fanotify_mark(fan_fd, FAN_MARK_ADD, ... , rootfd, NULL)
> > > > > <now you can move the superblock into the mount hierarchy>
> > > >
> > > > Not too bad.
> > > > I think that "hsm_deny_mask=" mount options would give more flexibility,
> > > > but I could be convinced otherwise.
> > > >
> > > > It's probably not a great idea to be running two different HSMs on the same
> > > > fs anyway, but if user has an old HSM version installed that handles only
> > > > pre-content events, I don't think that we want this old version if it happens
> > > > to be run by mistake, to allow for unsupervised create,rename,delete if the
> > > > admin wanted to atomically mount a fs that SHOULD be supervised by a
> > > > v2 HSM that knows how to handle pre-path events.
> > > >
> > > > IOW, and "HSM bit" on sb is too broad IMO.
> > >
> > > OK. So "hsm_deny_mask=" would esentially express events that we require HSM
> > > to handle, the rest would just be accepted by default. That makes sense.
> > 
> > Yes.
> > 
> > > The only thing I kind of dislike is that this ties fanotify API with mount
> > > API. So perhaps hsm_deny_mask should be specified as a string? Like

Yeah. I don't consider that in itself a dealbreaker though. The messier
part is that the proposal above requires that the superblock exists
before you can set up fanotify. If you register an HSM during mount then
you should set everything as regular mount options before superblock
creation. If the superblock is created the HSM should go into effect
implicitly instead of requiring another fanotify call, imho.

But you could also do it the other way around:

fanotify_something_something(fan_fd, fs_context_fd, ...)
{
        fdget(fs_context_fd);
        if (f.file->f_op != &fscontext_fops)
                return -EINVAL;

        ret = mutex_lock_interruptible(&fc->uapi_mutex);
        if (ret == 0) {
                if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
                    fc->phase != FS_CONTEXT_RECONF_PARAMS)
                        return -EBUSY;

                /* do your thing */

                mutex_unlock(&fc->uapi_mutex);
        }
}

then you don't need to even use the mount api system calls and can go
through the regular fanotify system calls. You'd just need a sensible
helper that is exposed internally to fanotify to register events during
fscontext creation.

I'm not sure what would be better.

> > > preaccess,premodify,prelookup,... and transformed into a bitmask only
> > > inside the kernel? It gives us more maneuvering space for the future.
> > >
> > 
> > Urgh. I see what you are saying, but this seems so ugly to me.

Go look at what bpffs did for their delegation support... Exactly that iirc. :)

> > I have a strong feeling that we are trying to reinvent something
> > and that we are going to reinvent it badly.
> > I need to look for precedents, maybe in other OS.
> > I believe that in Windows, there is an API to register as a
> > Cloud Engine Provider, so there is probably a way to have multiple HSMs
> > working on different sections of the filesystem in some reliable
> > crash safe manner.
> 
> OK, let's see what other's have came up with :)

