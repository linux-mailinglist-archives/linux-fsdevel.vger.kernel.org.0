Return-Path: <linux-fsdevel+bounces-66288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D387BC1A844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF4BE586293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D03596FB;
	Wed, 29 Oct 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kakEeUXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00AD3590CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741596; cv=none; b=TZM1+0Lab24zauk3cETwE12y3eNwLFsF7JwL1jTfPszJ+dTeIOgPliYEKwrBsTpHXH4oVZHspK/7+lrw2SQDt6msGE9KOFfjKiM1rC5Vc3vrQS2x/JgJaEFgKzPsN/0KKKsotqKwQTrPOs9T/sWXLz50Y8Gq2HeJfQv143fVgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741596; c=relaxed/simple;
	bh=49uoYhGHfXMZ7fHW+QKE2oV//6ZJ+ZzysmMJi1Z6ags=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4ixNJVDO4sRMrJjQxCchXEYvZBfGOw4FdslePd7STlHIVwnJGSkz6S9Ij8dgkvC/ENk26Egb7HJbd0v66LDJqg0JGg6ZpFF3JSa/Ec8Pnzd1Eft+f00vHoHRCGcNm/gdFzrdB/VqoNTpPHeljwFuQY08s3rADRNSVEjc0Uxy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kakEeUXf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b70406feed3so55622166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761741592; x=1762346392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQxjbIg9YwIhwxVpY0QdcqzIhsWq2MPobbBZ+ikGI+Q=;
        b=kakEeUXfiq2w2kDBXLhgAs9SiU/+2WFLw8AfgILmBNIAi57+qumy8uSj6ej2nL7LM8
         WJT9S7E/4i5MLWtclWTgaBiugcpS76QaqE3urH1RxzwKaXryHS7SQZBQwEWdh04qp9gF
         cAuTjMHUGqcC208LHRZ2jEdLDrEoBHXeJetqHSMzRp+s0xkjqfi6eO10KubI0UDav+0C
         MZzY3EgFVjYfB5W45ujh0/EouOJ0qrtXTl6oluKVOyiSBkjcCZMXAfq6nlPS+S0ptEUQ
         rokXxDT7zUO+IjLKL4OofCmMaQAWjxOP52EFgBB/jeTw1OAJpgs5fi8yeMGs8Ktkem5c
         H7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741592; x=1762346392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQxjbIg9YwIhwxVpY0QdcqzIhsWq2MPobbBZ+ikGI+Q=;
        b=aYBVO5smWPDBSW/QL2WnQKfiYqhfI/dTtz4RiwhR6TbZ14oGCjOa7XdAVOoC4E/uw2
         rhHV4SQPgzGv2jUJiMdjboqkunoFBoc5HfoxLcRPR0nWGuMiy5iZWFmx18afsvV5EM3L
         OAPM4NLqQe13FL7AQvA1++dlOv37oV5slSsrVGPgTf1Df9R0hHts1mNf+6XOQmLKwWt8
         bdZ39HzMyFDMjYP2nBLUiha8VfUdjs00AmbfpHXLjHEZwaYivxRRnVeLIaS+FK+CGGpV
         HIRBuY5T5Ugz/csXUGkwyuBP4S8u4VDvQZIdODQexzvGjHrjxkFpKVvDjD8vOy9CP7H+
         vNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7eLvhO4vA9m8aXLjCtpklxehnvvVQKCwlqqc62YjfRcna6b6nBMZFDLpfHEYCZYYIwa5tGXcq5Z8kBkx@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnyNzISCKO4jawzSROFRIpgTZz1+r6hY4fzuS9FoaSTX8M/RA
	SIqdxhbAcCWoL00QXFStjcaB1lX/uC82oI3M/hTiMx4n5DuX0tShfuRX
X-Gm-Gg: ASbGncsJ8h9SwI7yhlrNexXufhgVpHsLRSzA8nuQuDW9BcYNRST74/6B4Zgf9AQTTHl
	S+BIIbIrXtvk1bZIlwED99hUGDFR1Tyf9bBVYqO6WbN2P/kShbbjouU29cLeS8ztzppsIJsYVq0
	Llr1PG7MrngFCmB6GWrMNnujFQiVD3s1I4wXZfC4+WICmmfiRdMPX9/1gy1ejS5gxHLRRyYGhjB
	kJzbQnt/yMf0wK5cd2spTfa82zPwHJmori9rlXNUjBYI0yTD3SAD1+pjfUe4vNnN6m7ozwTYBMw
	WKNQXb2WnooxG4jIQFIAsAahZgKNDb1xwhqtt5cvUD7j6yCGtjZSMgRi2mlMGPtlzmI2BUR+gIX
	rFFZrEBMYeSmS+uf5nkSHP1JYGlaFRP7fGapZoz/AMD/C2OXSHproQETj4JxAtVvqkRooR7KvNC
	cXKIMeevgr1Mj0FnV5rpvB8kloEZWgOyzrp3pRie+p/xBfg37mRESPUKPL7z98XrYaaHI+6AvEE
	I5HoQ==
X-Google-Smtp-Source: AGHT+IFsngk/ZlQIhI18Mif9/b0xuGaoAFM7gcHRok1LLBFKKKebUqlC+tev6r6ZeRr03qQ50LjyDQ==
X-Received: by 2002:a17:907:3f21:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b703d555a9bmr276600566b.57.1761741591895;
        Wed, 29 Oct 2025 05:39:51 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-762a-9cfa-f6a7-22df.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:762a:9cfa:f6a7:22df])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8538478fsm1427867566b.33.2025.10.29.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:39:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:39:50 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jan Kara <jack@suse.cz>, sfrench@samba.org, pc@manguebit.org,
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	bharathsm@microsoft.com, linux-cifs@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Stef Bon <stefbon@gmail.com>,
	Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
Message-ID: <aQILFtsVnpVBj-k-@amir-ThinkPad-T480>
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com>
 <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com>
 <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
 <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
 <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com>
 <CAOQ4uxjxG7KCwsHYv3Oi+t1pwjLS8jUoiAroXtzTatu3+11CWg@mail.gmail.com>
 <CABFDxMGyH9jek19qEzp-3cQiS=9CTXzvtVDZztouLeO6nYEP3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFDxMGyH9jek19qEzp-3cQiS=9CTXzvtVDZztouLeO6nYEP3w@mail.gmail.com>

On Wed, Oct 29, 2025 at 01:13:31AM +0900, Sang-Heon Jeon wrote:
> On Fri, Oct 24, 2025 at 12:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > ...
> > > > > Hello, Amir
> > > > >
> > > > > > First feedback (value):
> > > > > > -----------------------------
> > > > > > This looks very useful. this feature has been requested and
> > > > > > attempted several times in the past (see links below), so if you are
> > > > > > willing to incorporate feedback, I hope you will reach further than those
> > > > > > past attempts and I will certainly do my best to help you with that.
> > > > >
> > > > > Thanks for your kind comment. I'm really glad to hear that.
> > > > >
> > > > > > Second feedback (reviewers):
> > > > > > ----------------------------------------
> > > > > > I was very surprised that your patch doesn't touch any vfs code
> > > > > > (more on that on design feedback), but this is not an SMB-contained
> > > > > > change at all.
> > > > >
> > > > > I agree with your last comment. I think it might not be easy;
> > > > > honestly, I may know less than
> > > > > Ioannis or Vivek; but I'm fully committed to giving it a try, no
> > > > > matter the challenge.
> > > > >
> > > > > > Your patch touches the guts of the fsnotify subsystem (in a wrong way).
> > > > > > For the next posting please consult the MAINTAINERS entry
> > > > > > of the fsnotify subsystem for reviewers and list to CC (now added).
> > > > >
> > > > > I see. I'll keep it in my mind.
> > > > >
> > > > > > Third feedback (design):
> > > > > > --------------------------------
> > > > > > The design choice of polling i_fsnotify_mask on readdir()
> > > > > > is quite odd and it is not clear to me why it makes sense.
> > > > > > Previous discussions suggested to have a filesystem method
> > > > > > to update when applications setup a watch on a directory [1].
> > > > > > Another prior feedback was that the API should allow a clear
> > > > > > distinction between the REMOTE notifications and the LOCAL
> > > > > > notifications [2][3].
> > > > >
> > > > > Current design choice is a workaround for setting an appropriate add
> > > > > watch point (as well as remove). I don't want to stick to the RFC
> > > > > design. Also, The point that I considered important is similar to
> > > > > Ioannis' one: compatible with existing applications.
> > > > >
> > > > > > IMO it would be better to finalize the design before working on the
> > > > > > code, but that's up to you.
> > > > >
> > > > > I agree, although it's quite hard to create a perfect blueprint, but
> > > > > it might be better to draw to some extent.
> > > > >
> > > > > Based on my current understanding, I think we need to do the following things.
> > > > > - design more compatible and general fsnotify API for all network fs;
> > > > > should process LOCAL and REMOTE both smoothly.
> > > > > - expand inotify (if needed, fanotify both) flow with new fsnotify API
> > > > > - replace SMB2 change_notify start/end point to new API
> > > > >
> > > >
> > > > Yap, that's about it.
> > > > All the rest is the details...
> > > >
> > > > > Let me know if I missed or misunderstood something. And also please
> > > > > give me some time to read attached threads more deeply and clean up my
> > > > > thoughts and questions.
> > > > >
> > > >
> > > > Take your time.
> > > > It's good to understand the concerns of previous attempts to
> > > > avoid hitting the same roadblocks.
> > >
> > > Good to see you again!
> > >
> > > I read and try to understand previous discussions that you attached. I
> > > would like to ask for your opinion about my current step.
> > > I considered different places for new fsnotify API. I came to the same
> > > conclusion that you already suggested to Inoannis [1]
> > > After adding new API to `struct super_operations`, I tried to find the
> > > right place for API calls that would not break existing systems and
> > > have compatibility with inotify and fanotify.
> > >
> > > From my current perspective, I think the outside of fsnotify (like
> > > inotify_user.c/fanotify_user.c) is a better place to call new API.
> > > Also, it might lead some duplicate code with inotify and fanotify, but
> > > it seems difficult to create one unified logic that covers both
> > > inotify and fanotify.
> >
> >
> > Personally, I don't mind duplicating this call in the inotify and
> > fanotify backends.
> > Not sure if this feature is relevant to other backends like nfsd and audit.
> >
> > I do care about making this feature opt-in, which goes a bit against your
> > requirement that existing applications will get the REMOTE notifications
> > without opting in for them and without the notifications being clearly marked
> > as REMOTE notifications.
> >
> > If you do not make this feature opt-in (e.g. by fanotify flag FAN_MARK_REMOTE)
> > then it's a change of behavior that could be desired to some and surprising to
> > others.
> 
> You're right, Upon further reflection, my previous approach may create
> unexpected effects to the user program. But to achieve my requirement,
> inotify should be supported (also safely). I will revisit inotify with
> opt-in method after finishing the discussion about fanotify.
> 
> > Also when performing an operation on the local smb client (e.g. unlink)
> > you would get two notifications, one the LOCAL and one the REMOTE,
> > not being able to distinguish between them or request just one of them
> > is going to be confusing.
> >
> > > With this approach, we could start inotify first
> > > and then fanotify second that Inoannis and Vivek already attempted.
> > > Even if unified logic is possible, I don't think it is not difficult
> > > to merge and move them into inside of fsnotify (like mark.c)
> > >
> >
> > For all the reasons above I would prefer to support fanotify first
> > (with opt-in flag) and not support inotify at all, but if you want to
> > support inotify, better have some method to opt-in at least.
> > Could be a global inotify kob for all I care, as long as the default
> > does not take anyone by surprise.
> 
> Thanks for the detailed description. I understand the point of
> distinguishing remote and local notification better. And the way you
> prefer (fanotify first) is also reasonable to me because implementing
> fanotify would also help support inotify more safely.
> 
> > > Also, I have concerns when to call the new API. I think after updating
> > > the mark is a good moment to call API if we decide to ignore errors
> > > from new API; now, to me, it is affordable in terms of minimizing side
> > > effect and lower risk with user spaces. However, eventually, I believe
> > > the user should be able to decide whether to ignore the error or not
> > > of new API, maybe by config or flag else. In that case, we need to
> > > rollback update of fsnotify when new API fails. but it is not
> > > supported yet. Could you share your thoughts on this, too?
> > >
> >
> > If you update remote mask with explicit FAN_MARK_REMOTE
> > and update local mask without FAN_MARK_REMOTE, then
> > there is no problem is there?
> >
> > Either FAN_MARK_REMOTE succeeded or not.
> > If it did, remote fs could be expected to generate remote events.
> 
> I understand you mean splitting mask into a local and remote
> notification instead of sharing, is it right?

No, that's no what I meant.

> TBH, I never thought of that solution but it's quite clear and looks good to me.
> If I misunderstand, could you please explain a bit more?
> 

It is indeed clear, but inode space is quite expensive, so we cannot
add i_fsnotify_remote_mask field for all inodes and also its not
necessary.

TBH, I do have a final picture of the opt-in API and there are several
shapes that it could take.

I think that we anyway need an "event mask flag" FAN_REMOTE,
similar to FAN_ONDIR.

A remote notification is generated by the filesystem and this source
of notification always sets the FS_REMOTE in the event mask, which is
visible to users reading the events.

This makes it natural to also opt-in for remote events via the mask,
some as is done with FAN_ONDIR.

However, I would like to avoid the complexities involved with flipping
this FS_REMOTE bit in event mask, that's why I was thinking about
FAN_MARK_REMOTE that sets a flag in the mark, like FAN_MARK_EVICTABLE
and forces all mark updates to use the same flag.

But for your first RFC, I suggest that you make it simple and use
a group flag to request only remote notifications at fanotify_init
time.

This way you can take the existing cifs implementation of remote
notifications using an ioctl and "bind" it to use the fanotify API
with as little interferance with local notifications as possible.

> > > If my inspection is wrong or you might have better idea, please let me
> > > know about it. TBH, understanding new things is hard, but it's also a
> > > happy moment to me.
> > >
> >
> > I am relying on what I think you mean, but I may misunderstand you
> > because you did not sketch any code samples, so I don't believe
> > I fully understand all your concerns and ideas.
> >
> > Even an untested patch could help me understand if we are on the same page.
> 
> Thanks for your advice. I think we're getting closer to the same page.

Not quite there yet :)

> I also attached patch of my current sketch (not tested and cleaned),
> feel free to give your opinions.

This is not what I was looking for.

What I am looking for is a POC patch of binding cifs notifications
to fsnotify/fanotify:

- fanotify_mask() calls filesystem method to update server event mask
- filesystem calls fnsotify() hook with FS_REMOTE flag
- groups or marks that did not opt-in for remote notifications
  would drop this event

First milestone: be able to write program that listens to remote
notifications only.

Same program can use two groups remote and local with mask per type
to request a mixture of local and remote events.

Honestly, I don't think we need more than that?

Thanks,
Amir.



