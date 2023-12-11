Return-Path: <linux-fsdevel+bounces-5569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3180DB1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD727B214A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7E537F9;
	Mon, 11 Dec 2023 19:49:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFD5CF;
	Mon, 11 Dec 2023 11:49:39 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6497A31B; Mon, 11 Dec 2023 13:49:37 -0600 (CST)
Date: Mon, 11 Dec 2023 13:49:37 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Munehisa Kamata <kamatam@amazon.com>
Cc: serge@hallyn.com, adobriyan@gmail.com, akpm@linux-foundation.org,
	casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security
 attribute
Message-ID: <20231211194937.GA323128@mail.hallyn.com>
References: <20231210144530.GB295678@mail.hallyn.com>
 <20231211192723.28230-1-kamatam@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211192723.28230-1-kamatam@amazon.com>

On Mon, Dec 11, 2023 at 07:27:23PM +0000, Munehisa Kamata wrote:
> On Sun, 2023-12-10 06:45:30 -0800, "Serge E. Hallyn" wrote:
> >
> > On Sat, Dec 09, 2023 at 01:10:42AM +0000, Munehisa Kamata wrote:
> > > On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
> > > >
> > > > On 12/8/2023 3:32 PM, Paul Moore wrote:
> > > > > On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > > > >>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > > >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > > > >>> ..
> > > > >>>
> > > > >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> > > > >>>>> at the top.  However, before we go too much further on this, can we
> > > > >>>>> get clarification that Casey was able to reproduce this on a stock
> > > > >>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> > > > >>>>> this problem on Linux v6.5.
> > > > >>>>>
> > > > >>>>> However, for the moment I'm going to assume this is a real problem, is
> > > > >>>>> there some reason why the existing pid_revalidate() code is not being
> > > > >>>>> called in the bind mount case?  From what I can see in the original
> > > > >>>>> problem report, the path walk seems to work okay when the file is
> > > > >>>>> accessed directly from /proc, but fails when done on the bind mount.
> > > > >>>>> Is there some problem with revalidating dentrys on bind mounts?
> > > > >>>> Hi Paul,
> > > > >>>>
> > > > >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
> > > > >>>>
> > > > >>>> After reading this thread, I have doubt about solving this in VFS.
> > > > >>>> Honestly, however, I'm not sure if it's entirely relevant today.
> > > > >>> Have you tried simply mounting proc a second time instead of using a bind mount?
> > > > >>>
> > > > >>>  % mount -t proc non /new/location/for/proc
> > > > >>>
> > > > >>> I ask because from your description it appears that proc does the
> > > > >>> right thing with respect to revalidation, it only becomes an issue
> > > > >>> when accessing proc through a bind mount.  Or did I misunderstand the
> > > > >>> problem?
> > > > >> It's not hard to make the problem go away by performing some simple
> > > > >> action. I was unable to reproduce the problem initially because I
> > > > >> checked the Smack label on the bind mounted proc entry before doing
> > > > >> the cat of it. The problem shows up if nothing happens to update the
> > > > >> inode.
> > > > > A good point.
> > > > >
> > > > > I'm kinda thinking we just leave things as-is, especially since the
> > > > > proposed fix isn't something anyone is really excited about.
> > > > 
> > > > "We have to compromise the performance of our sandboxing tool because of
> > > > a kernel bug that's known and for which a fix is available."
> > > > 
> > > > If this were just a curiosity that wasn't affecting real development I
> > > > might agree. But we've got a real world problem, and I don't see ignoring
> > > > it as a good approach. I can't see maintainers of other LSMs thinking so
> > > > if this were interfering with their users.
> > >  
> > > We do bind mount to make information exposed to the sandboxed task as little
> > > as possible. We also create a separate PID namespace for each sandbox, but
> > 
> > If not exposing information is the main motivation, then could you simply do:
> > 
> > mount -t proc proc dir
> > mount --bind dir/$$ dir
> > 
> > ?
> 
> Hi Serge,
> 
> It doesn't work.
> 
>  [root@ip-10-0-32-198 ec2-user]# mount -t proc proc dir
>  [root@ip-10-0-32-198 ec2-user]# echo AAA > dir/$$/attr/current
>  [root@ip-10-0-32-198 ec2-user]# chsmack dir/$$
>  dir/11222 access="AAA"
>  [root@ip-10-0-32-198 ec2-user]# mount --bind dir/$$ dir
>  [root@ip-10-0-32-198 ec2-user]# echo BBB > dir/attr/current
>  [root@ip-10-0-32-198 ec2-user]# echo CCC > dir/attr/current
>  bash: dir/attr/current: Permission denied
>  [root@ip-10-0-32-198 ec2-user]# ls dir
>  ls: cannot access dir: Permission denied
>  [root@ip-10-0-32-198 ec2-user]# 
>  
> It would not revalidate dir/$$ anyway, so this result wasn't surprising to
> me. Maybe I'm missing something?

I see.  Yeah, that's an ugly wart.

> > > still want to bind mount even with it to hide system-wide and pid 1
> > > information from the task. 
> > > 
> > > So, yeah, I see this as a real problem for our use case and want to seek an
> > > opinion about a possibly better fix.
> > > 
> > > 
> > > Thanks,
> > > Munehisa 
> > 

