Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371DBF969A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKLRFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:05:44 -0500
Received: from mail177-7.suw61.mandrillapp.com ([198.2.177.7]:47390 "EHLO
        mail177-7.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfKLRFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:43 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 12:05:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=dB9gQo7DhQktmEfwuOIq3dC+ikcOfXLQWAybamgfJ84=;
 b=fyzgxPPN3KTVL5XWY9yazZ/bjUtSLfw1wNwAWVZQ6v4xbM+F8+ZCgZGiPsIAYUVJ/SokX6aviv5K
   F6kQcDLBrItmS/qdKlDGJc2rg3Pmmm+MgR+DzWYMdKU5qm9XnL0xXTxMOWpS61Ng01Cxvb6mtFO7
   Swp//e/2qaBCO2KZTIU=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-7.suw61.mandrillapp.com id hpbj6c22rtk8 for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:50:41 +0000 (envelope-from <bounce-md_31050260.5dcae2e1.v1-d1e5bcfef43d49bcbc3758fce8d7a4ba@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1573577441; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=dB9gQo7DhQktmEfwuOIq3dC+ikcOfXLQWAybamgfJ84=; 
 b=EwaukuHvGsJsgMWBULoDY/sec1c4d3XLhC/fpUmsWugAg377vehJUMAFPZRDpSMFbZZR+A
 cQFdlMVe+uZAz5tTEV0oRC8RtI0fBq9PvE3sWbuvfRa9dckHVjPh5fmghGXtBHcQxCAUwWLm
 WfORl28Z7ZqNmpcJy6EZRKjNgTIe4=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Received: from [87.98.221.171] by mandrillapp.com id d1e5bcfef43d49bcbc3758fce8d7a4ba; Tue, 12 Nov 2019 16:50:41 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Message-Id: <20191112165033.GA7905@deco.navytux.spb.ru>
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com> <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org> <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com> <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com> <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com> <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com> <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
In-Reply-To: <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.d1e5bcfef43d49bcbc3758fce8d7a4ba
X-Mandrill-User: md_31050260
Date:   Tue, 12 Nov 2019 16:50:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:51:03PM -0800, Linus Torvalds wrote:
> On Mon, Nov 11, 2019 at 11:00 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > > if (ppos) {
> > >      pos = *ppos; // data-race
> >
> > That code uses "fdget_pos().
> >
> > Which does mutual exclusion _if_ the file is something we care about
> > pos for, and if it has more than one process using it.
> 
> That said, the more I look at that code, the less I like it.
> 
> I have this feeling we really should get rid of FMODE_ATOMIC_POS
> entirely, now that we have the much nicer FMODE_STREAM to indicate
> that 'pos' really doesn't matter.
> 
> Also, the test for "file_count(file) > 1" really is wrong, in that it
> means that we protect against other processes, but not other threads.
> 
> So maybe we really should do the attached thing. Adding Al and Kirill
> to the cc for comments. Kirill did some fairly in-depth review of the
> whole locking on f_pos, it might be good to get his comments.
> 
> Al? Note the change from
> 
> -               if (file_count(file) > 1) {
> +               if ((v & FDPUT_FPUT) || file_count(file) > 1) {
> 
> in __fdget_pos(). It basically says that the threaded case also does
> the pos locking.
> 
> NOTE! This is entirely untested. It might be totally broken. It passes
> my "LooksSuperficiallyFine(tm)" test, but that's all I'm going to say
> about the patch.

Linus, thanks for asking. Here is my feedback after quickly rechecking
this topic:

Your patch does two things:

1) switch file->f_pos locking enable from N(processes-using-the-file) > 1
   to N("threads"-using-the-file) > 1.

2) switch `if FMODE_ATOMIC_POS` to `if !FMODE_STREAM`.

About "1": I think it should be a good thing to do with one of the
reasons being security: not to allow a processes to pass-by range
based access restrictions. Let me quote your email on this topic from
April: (https://lore.kernel.org/linux-fsdevel/CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com)

    """
    I do think that moving to a model where we wither have a
    (properly locked) file position or no pos pointer at all is the right
    model (ie I'd really like to get rid of the mixed case), but there
    might be some practical problem that makes it impractical.
    
    Because the *real* problem with the mixed case is not "insane people
    who do bad things might get odd results". No, the real problem with
    the mixed case is that it could be a security issue (ie: one process
    intentionally changes the file position just as another process is
    going a 'read' and then avoids some limit test because the limit test
    was done using the old 'pos' value but the actual IO was done using
    the new one).
    """

The same logic applies if it is not 2 processes, but 2 threads:
thread T2 adjusts file position racily to thread T1 while T1 is doing
read syscall with the end result that T1 read could access file range
that it should not be allowed to access.

So with that reasoning I think we should do "1" anyway now.

By the way on "1" topic I suspect there is a race of how
`N(file-users) > 1` check is done: file_count(file) is
atomic_long_read(&file->f_count), but let's think on how that atomic
read is positioned wrt another process creation: I did not studied in
detail, so I might be wrong here, but offhand it looks like there is no
synchronization. This way when another processes is being created,
things could align so that the check could be performed while
file->f_count=1 with second process being created right after that. The
end result is that the first process is doing sysread _without_ locking
f_pos_lock, while the second process could do syslseek/whatever in
parallel - it will be locking f_pos_lock, but since P1 did not took that
lock, P2 would be taking f_pos_lock without blocking. Yes, __fget_light
(called by fdget_pos) says that "You must not clone the current task in
between the calls to fget_light and fput_light", but if original process
is multithreaded, a second thread might call clone while the first
thread is in sysread. The task of the second thread is not task of T1,
but since, as I suspect, both T1 and T2 share file table, the invariant
of fdget_light will become broken with end result that the same
"race-to-bypass-range-based-access" scenario is possible.

Once again, maybe I'm wrong here and miss some detail and there is some
synchronization in between file_count() call and second process
creation, but for me it is not clear from just looking at __fdget_pos().

The situation a bit reminds me another race I fixed recently:
https://github.com/python/cpython/commit/c5abd63e94fc. There the code
was considered to be race-free for a long time, and original author
actually argued with someone defending it to be race-free. That code is
indeed race-free if all objects are created beforehand, but once objects
become allocated/deallocated dynamically (processes in our case) the
race starts to be there.

So talking about the kernel I would also review the possibility of
file_count wrt clone race once again.

----

About "2": I generally agree with the direction, but I think the kernel
is not yet ready for this switch. Let me quote myself:
(https://lore.kernel.org/linux-fsdevel/20190413184404.GA13490@deco.navytux.spb.ru)

    """
    And I appreciate if people could help at least somehow with "getting rid
    of mixed case entirely" (i.e. always lock f_pos_lock on !FMODE_STREAM),
    because this transition starts to diverge from my particular use-case
    too far. To me it makes sense to do that transition as follows:
    
    - convert nonseekable_open -> stream_open via stream_open.cocci;
    - audit other nonseekable_open calls and convert left users that truly
      don't depend on position to stream_open;
    - extend stream_open.cocci to analyze alloc_file_pseudo as well (this
      will cover pipes and sockets), or maybe convert pipes and sockets to
      FMODE_STREAM manually;
    - extend stream_open.cocci to analyze file_operations that use no_llseek
      or noop_llseek, but do not use nonseekable_open or alloc_file_pseudo.
      This might find files that have stream semantic but are opened
      differently;
    - extend stream_open.cocci to analyze file_operations whose .read/.write
      do not use ppos at all (independently of how file was opened);
    - ...
    - after that remove FMODE_ATOMIC_POS and always take f_pos_lock if
      !FMODE_STREAM;
    - gather bug reports for deadlocked read/write and convert missed cases
      to FMODE_STREAM, probably extending stream_open.cocci along the road
      to catch similar cases.
    
    i.e. always take f_pos_lock unless a file is explicitly marked as being
    stream, and try to find and cover all files that are streams.
    """

Basically there are at least several non-regular files - like e.g.
pipes, fifos, sockets, etc, that are currently not marked with
FMODE_STREAM but on which f_pos_lock is currently _not_ locked as your
original commit 9c225f2655e3 (vfs: atomic f_pos accesses as per POSIX)
added FMODE_ATOMIC_POS only to regular files, not those. So if we just
start locking on `!(f->f_mode & FMODE_STREAM)` without changing other
parts of the kernel, those pipes, fifos, sockets, etc will start to take
f_pos_lock on read/write, which e.g. for pipes would be "only"
performance regression, but for sockets - due to them being duplex
channels - could lead to read/write deadlocks similar to the deadlocks
described in 10dce8af3422 (fs: stream_open - opener for stream-like
files so that read and write can run simultaneously without deadlock).

The plan should be thus that we should go through the kernel and first
mark all those non-regular files that have stream semantic with
FMODE_STREAM. And only then we should be able to safely switch
`if FMODE_ATOMIC_POS` to `if !FMODE_STREAM` in IO syscalls.

I apologize for being silent on this stream_open conversion topic.
I'm currently busy fixing another deadlock related to Python GIL in my
wendelin.core filesystem client, where one client thread, in cooperation
with filesystem server, is responsible for providing isolated filesystem
views corresponding to different database states, while the pagecache is
practically shared for all views. You can check e.g. here, in case you are
curious, what this is about:
https://pypi.org/project/pygolang/#id24
https://pypi.org/project/pygolang/#cython-nogil-api

Hope it helps a bit,
Kirill


>  fs/file.c          | 4 ++--
>  fs/open.c          | 6 +-----
>  include/linux/fs.h | 2 --
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3da91a112bab..708e5c2b7d65 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -795,8 +795,8 @@ unsigned long __fdget_pos(unsigned int fd)
>  	unsigned long v = __fdget(fd);
>  	struct file *file = (struct file *)(v & ~3);
>  
> -	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> -		if (file_count(file) > 1) {
> +	if (file && !(file->f_mode & FMODE_STREAM)) {
> +		if ((v & FDPUT_FPUT) || file_count(file) > 1) {
>  			v |= FDPUT_POS_UNLOCK;
>  			mutex_lock(&file->f_pos_lock);
>  		}
> diff --git a/fs/open.c b/fs/open.c
> index b62f5c0923a8..5c68282ea79e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -771,10 +771,6 @@ static int do_dentry_open(struct file *f,
>  		f->f_mode |= FMODE_WRITER;
>  	}
>  
> -	/* POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))
> -		f->f_mode |= FMODE_ATOMIC_POS;
> -
>  	f->f_op = fops_get(inode->i_fop);
>  	if (WARN_ON(!f->f_op)) {
>  		error = -ENODEV;
> @@ -1256,7 +1252,7 @@ EXPORT_SYMBOL(nonseekable_open);
>   */
>  int stream_open(struct inode *inode, struct file *filp)
>  {
> -	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE | FMODE_ATOMIC_POS);
> +	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
>  	filp->f_mode |= FMODE_STREAM;
>  	return 0;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..a7c3f6dd5701 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -148,8 +148,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File is opened with O_PATH; almost nothing can be done with it */
>  #define FMODE_PATH		((__force fmode_t)0x4000)
>  
> -/* File needs atomic accesses to f_pos */
> -#define FMODE_ATOMIC_POS	((__force fmode_t)0x8000)
>  /* Write access to underlying fs */
>  #define FMODE_WRITER		((__force fmode_t)0x10000)
>  /* Has read method(s) */
