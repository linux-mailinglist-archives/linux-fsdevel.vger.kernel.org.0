Return-Path: <linux-fsdevel+bounces-20194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6058CF6ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FAB1F218C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893901C3D;
	Mon, 27 May 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GxXYoX1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F7161
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768384; cv=none; b=Qh2Zi7fqDt7M7XtZ8VVnfFsKSpBHkVFmbyxqkp7CsljJnIpi1zgJ9etlWWyp4UOcDgMb8cx9ifhUTg4ymtIQago+lZXwAnArY/oRBc6NRf5hOKNXGCIY/ricRjN128Yl0Nwirkw7CCjWTB5yYKZdlBq0gGmHWv8QxJ+8QYPgQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768384; c=relaxed/simple;
	bh=11eHXvJbkomQ88aqXsVVKUXVL2aEfafpgaZ7OZ1x9NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvaPAS3393jBBozgTlVoOqydVQveYmRXz+B4wmcUh6LotsMArWjdI6aE3FdlFagvZRJ5GdmZF/zLa5lU/WR/y5DBmqTzcmmrqBQhSf39ODt5UXycYU8ELxpOoJspQcpEptII+sBW2uhuOp3MLCEcVoFVqqsjnrZY7R0vgssZ1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GxXYoX1X; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so2958294b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716768381; x=1717373181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9R7bMtFEWMcWVXBnoMSh8LcpnoJ77tngWySOPXEB6M=;
        b=GxXYoX1XR8ByAxluTNPkg6iSpCLNA5DlxkRkHvbREdsyESVZKXz3J7b4xdLdoT89lk
         fsHSgkJPyr1TRg1kuwrfD6SJkGspoCEv3PYGjxE1zufxXbBNpwUWIjkx+RlX6bgXVgHg
         tjmp+yZq6VlEI1oiRPE52U/xkj387eKr2OL+v/JVVGtmEWPjQjumQvf60wHb+aVIFqiA
         dyoCe3PwR3wo2A54Q9uFNOri4hcOkHY4KkYke9CCvKELq9UyP8UiRYGJuxJU7EMWToe9
         FL9NTqrEeJHAuaUCD7HwEHjqehVaTqL1hE3iYxMwYhrGWPCHcOJYsTmP5BJ0SWCp83Qr
         8dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716768381; x=1717373181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9R7bMtFEWMcWVXBnoMSh8LcpnoJ77tngWySOPXEB6M=;
        b=DuAejy4xOHaNWcgISVlsuBteaqAwj5AizeE/yu328Gh4RfWqtDOISY1iSV4wnq64Hj
         WC0L/vL98jhrMrmTRKBRP244e58EXqJeKrHQeUq7U9i9jWpEayg0/5DH5wjBcU0fwKJu
         X3AyX2ssr4eb2icer5P1uTMySFxGNhZr5fRMDOL1kJK/HqBgq5aTg/hQNzDKF5u5crat
         +qyqXRiBjt+hA2KwUPysQ4mdbNtDdb/x7FbuSwLG/4+5IgxRvg2BBaNoQqIwGUQMrlOe
         ogtAi58+Pm56yBKexubCqAg2muCzpl6dBRxYs6Db3N+fTr2HAldZRO5CffMVsmv39XjR
         ciGg==
X-Forwarded-Encrypted: i=1; AJvYcCVocKquRwH9TLwNTHoYc0R5B09m/ZtvAFte7pRInLnAOx3gFSv36iIMylQUP/Davz/JhzNtU+kYQDg9BBPcdnu/eSOJFplzxlNP3SDWqg==
X-Gm-Message-State: AOJu0YzKo7iApqNznH4T2adkweE0DS+kF00mv+KjaTaID2AyemSn7sEi
	xNN1u6oHvnK/6z3RDrhqdbTvTGWxQBvNYDDYurj5WdbPw6PjjwSyhH53aq8+4Q0=
X-Google-Smtp-Source: AGHT+IFEqGxApp8I+g0v5ZYyes8YpL0Dz6P6/dAppaN4B2DlkRcDN/gTEyOeUegityO66ngJ2bvWFA==
X-Received: by 2002:a05:6a21:8193:b0:1af:ac96:f4bf with SMTP id adf61e73a8af0-1b212d1e48cmr8324171637.15.1716768380306;
        Sun, 26 May 2024 17:06:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe6666sm3904218b3a.163.2024.05.26.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:06:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBNsV-00Bhhe-2w;
	Mon, 27 May 2024 10:06:15 +1000
Date: Mon, 27 May 2024 10:06:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <ZlPOd0p7AUn7JqLu@dread.disaster.area>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
 <20240524-ahnden-danken-02a2e9b87190@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-ahnden-danken-02a2e9b87190@brauner>

On Fri, May 24, 2024 at 02:25:30PM +0200, Christian Brauner wrote:
> On Thu, May 23, 2024 at 09:52:20AM -0600, Aleksa Sarai wrote:
> > On 2024-05-21, Christian Brauner <brauner@kernel.org> wrote:
> > > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > > > provide a file handle and corresponding mount without needing to worry
> > > > about racing with /proc/mountinfo parsing.
> > > > 
> > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > > > that doesn't make sense for name_to_handle_at(2).
> > > > 
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > > 
> > > So I think overall this is probably fine (famous last words). If it's
> > > just about being able to retrieve the new mount id without having to
> > > take the hit of another statx system call it's indeed a bit much to
> > > add a revised system call for this. Althoug I did say earlier that I
> > > wouldn't rule that out.
> > > 
> > > But if we'd that then it'll be a long discussion on the form of the new
> > > system call and the information it exposes.
> > > 
> > > For example, I lack the grey hair needed to understand why
> > > name_to_handle_at() returns a mount id at all. The pitch in commit
> > > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
> > > the (old) mount id can be used to "lookup file system specific
> > > information [...] in /proc/<pid>/mountinfo".
> > 
> > The logic was presumably to allow you to know what mount the resolved
> > file handle came from. If you use AT_EMPTY_PATH this is not needed
> > because you could just fstatfs (and now statx(AT_EMPTY_PATH)), but if
> > you just give name_to_handle_at() almost any path, there is no race-free
> > way to make sure that you know which filesystem the file handle came
> > from.
> > 
> > I don't know if that could lead to security issues (I guess an attacker
> > could find a way to try to manipulate the file handle you get back, and
> > then try to trick you into operating on the wrong filesystem with
> > open_by_handle_at()) but it is definitely something you'd want to avoid.
> 
> So the following paragraphs are prefaced with: I'm not an expert on file
> handle encoding and so might be totally wrong.
> 
> Afaiu, the uniqueness guarantee of the file handle mostly depends on:
> 
> (1) the filesystem
> (2) the actual file handling encoding
> 
> Looking at file handle encoding to me it looks like it's fairly easy to
> fake them in userspace (I guess that's ok if you think about them like a
> path but with a weird permission model built around them.) for quite a
> few filesystems.

This is a feature specifically used by XFS utilities like xfs_fsr
and xfsdump to take pathless inode information retrieved by bulkstat
operations to a file handle to enable arbitrary inodes in the
filesystem to be opened.

i.e. they scan the filesystem by walking the filesystem's internal
inode index, not by walking paths to scan the filesytsem. This is
*much* faster than path walking, especially on seek-limited storage
hardware.

Knowing the inode number, generation and fs uuid, we can
construct a valid filehandle for that inode, and then do whatever
operations we need to do (defrag, backup, move offline (HSM), etc)
without needing to know the path to that inode....

> The problem is with what name_to_handle_at() returns imho. A mnt_id
> doesn't pin the filesystem and the old mnt_id isn't unique. That means
> the filesystem can be unmounted and go away and the mnt_id can be
> recycled almost immediately for another mount but the file handle is
> still there.

This is no different to the NFS server unexporting a filesystem -
all attempts to resolve the file handle the client holds for that
export must now fail. Hence the filehandle itself must have a
superblock specific identifier in it.

> So to guarantee that a (weakly encoded) file handle is interpreted in
> the right filesystem the file handle must either be accompanied by a
> file descriptor that pins the relevant mount or have any other guarantee
> that the filesystem doesn't go away (Or of course, the file handle
> encodes the uuid of the filesystem or something or uses some sort of
> hashing scheme.).

Yes, it does, and that's the superblock based identifier, not
something that is mount based. i.e.  the handle is valid regardless
of where the filesystem is mounted, even if the application does not
have visibility or permitted access to the given mount. And the
filehandle is persistent - it must work across unmount/mount,
reboots, change of mount location, etc.

That means that if you are using file handles, any filesystem that
is shared across multiple containers can by fully accessed by user
generated file handles from any container if no special permissions
are required. i.e. there are no real path or mount based security
boundaries for filehandles in existence righ now.

If filehandles are going to be restricted to a specific container
(e.g. a single mount) so that less permissions are needed to open
the filehandle, then the filehandle itself needs to encode those
restrictions. Decoding the filehandle needs to ensure that the
opening context has permission to access whatever the filehandle
points to in a restricted environment. This will prevent existing
persistent, global filehandles from being used as restricted
filehandles and vice versa.

Restricting filehandles for use as persistent filehandles is going
to be tricky - mount IDs are ephermeral and only valid while a mount
is active. I'd suggest that restricted filehandles should only be
ephemeral, too.  That would also allow restricted filehandles to use
kernel side crypto based encoding so nobody can ever construct them
from userspace. 

Hence I think we have to look at what we are encoding in the
filehandle itself to solve the "shared access from restricted
environments" problem, not try to add stuff around the outside of
the filehandle API to paper over the fact that filehandles
themselves have no permission/restriction model built into them.

This would also avoid the whole problem of "users can access any
file in the underlying filesystem by constructing their own handles" problem that
relaxed permissions on filehandle decoding creates, hence opening
the door for more extensive use of filehandles in untrusted
environments.

> One of the features of file handles is that they're globally usable so
> they're interesting to use as handles that can be shared. IOW, one can
> send around a file handle to another process without having to pin
> anything or have a file descriptor open that needs to be sent via
> AF_UNIX.
>
> But as stated above that's potentially risky so one might still have to
> send around an fd together with the file handle if sender and receiver
> don't share the filesystem for the handle.

Adding a trust context around the outside of an untrusted handle
isn't the right way to address this problem - define a filehandle
format that can be trusted and constrained within specific security
domains and the need for external permission contexts (whatever they
look like) to be passed with the filehandle to make it valid go away
entirely.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

