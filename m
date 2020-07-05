Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E97214F5B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGEUfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 16:35:00 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:39218 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgGEUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:35:00 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id DF0791A402E6; Sun,  5 Jul 2020 13:34:59 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:34:59 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705203459.ojli5uruxqt2cq2s@shells.gnugeneration.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
 <20200705080714.76m64pwwpvlzji2v@shells.gnugeneration.com>
 <20200705114454.GB1224775@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eioqlffteccd2lzb"
Content-Disposition: inline
In-Reply-To: <20200705114454.GB1224775@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eioqlffteccd2lzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2020 at 01:44:54PM +0200, Greg KH wrote:
> On Sun, Jul 05, 2020 at 01:07:14AM -0700, Vito Caputo wrote:
> > On Sun, Jul 05, 2020 at 04:27:32AM +0100, Matthew Wilcox wrote:
> > > On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > > > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > You should probably take a look at io_uring.  That has the level of
> > > > > complexity of this proposal and supports open/read/close along with many
> > > > > other opcodes.
> > > > 
> > > > Then glibc can implement readfile using io_uring and there is no need
> > > > for a new single-file readfile syscall.
> > > 
> > > It could, sure.  But there's also a value in having a simple interface
> > > to accomplish a simple task.  Your proposed API added a very complex
> > > interface to satisfy needs that clearly aren't part of the problem space
> > > that Greg is looking to address.
> > 
> > I disagree re: "aren't part of the problem space".
> > 
> > Reading small files from procfs was specifically called out in the
> > rationale for the syscall.
> > 
> > In my experience you're rarely monitoring a single proc file in any
> > situation where you care about the syscall overhead.  You're
> > monitoring many of them, and any serious effort to do this efficiently
> > in a repeatedly sampled situation has cached the open fds and already
> > uses pread() to simply restart from 0 on every sample and not
> > repeatedly pay for the name lookup.
> 
> That's your use case, but many other use cases are just "read a bunch of
> sysfs files in one shot".  Examples of that are tools that monitor
> uevents and lots of hardware-information gathering tools.
> 
> Also not all tools sem to be as smart as you think they are, look at
> util-linux for loads of the "open/read/close" lots of files pattern.  I
> had a half-baked patch to convert it to use readfile which I need to
> polish off and post with the next series to show how this can be used to
> both make userspace simpler as well as use less cpu time.
> 
> > Basically anything optimally using the existing interfaces for
> > sampling proc files needs a way to read multiple open file descriptors
> > in a single syscall to move the needle.
> 
> Is psutils using this type of interface, or do they constantly open
> different files?
> 

When I last checked, psutils was not an optimal example, nor did I
suggest it was.

> What about fun tools like bashtop:
> 	https://github.com/aristocratos/bashtop.git
> which thankfully now relies on python's psutil package to parse proc in
> semi-sane ways, but that package does loads of constant open/read/close
> of proc files all the time from what I can tell.
> 
> And lots of people rely on python's psutil, right?

If python's psutil is constantly reopening the same files in /proc,
this is an argument to go improve python's psutil, especially if it's
popular.

Your proposed syscall doesn't magically make everything suboptimally
sampling proc more efficient.  It still requires going out and
modifying everything to use the new syscall.

In order to actually realize a gain comparable to what can be done
using existing interfaces, but with your new syscall, if the code
wasn't already reusing the open fd it still requires a refactor to do
so with your syscall, to eliminate the directory lookup on every
sample.

At the end of the day, if you did all this work, you'd have code that
only works on kernels with the new syscall, didn't enjoy a significant
performance gain over what could have been achieved using the existing
interfaces, and still required basically the same amount of work as
optimizing for the existing interfaces would have.  For what gain?

> 
> > This syscall doesn't provide that.  It doesn't really give any
> > advantage over what we can achieve already.  It seems basically
> > pointless to me, from a monitoring proc files perspective.
> 
> What "good" monitoring programs do you suggest follow the pattern you
> recommend?
> 

"Good" is not generally a word I'd use to describe software, surely
that's not me you're quoting... but I assume you mean "optimal".

I'm sure sysprof is at least reusing open files when sampling proc,
because we discussed the issue when Christian took over maintenance.

It appears he's currently using the lseek()->read() sequence:

https://gitlab.gnome.org/GNOME/sysprof/-/blob/master/src/libsysprof/sysprof-netdev-source.c#L223
https://gitlab.gnome.org/GNOME/sysprof/-/blob/master/src/libsysprof/sysprof-memory-source.c#L210
https://gitlab.gnome.org/GNOME/sysprof/-/blob/master/src/libsysprof/sysprof-diskstat-source.c#L185

It'd be more efficient to just use pread() and lose the lseek(), at
which point it'd be just a single pread() call per sample per proc
file.  Nothing your proposed syscall would improve upon, not that it'd
be eligible for software that wants to work on existing kernels from
distros like Debian and Centos/RHEL anyways.

If this were a conversation about providing something like a better
scatter-gather interface akin to p{read,write}v but with the fd in the
iovec, then we'd be talking about something very lucrative for proc
sampling. But like you've said elsewhere in this thread, io_uring()
may suffice as an alternative solution in that vein.

My personal interest in this topic stems from an experimental window
manager I made, and still use, which monitors every descendant process
for the X session at frequencies up to 60HZ.  The code opens a bunch
of proc files for every process, and keeps them open until the process
goes away or falls out of scope.  See the attachment for some idea of
what /proc/$(pidof wm)/fd looks like.  All those proc files are read
at up to 60HZ continuously.

All top-like tools are really no different, and already shouldn't be
reopening things on every sample.  They should be fixed if not - with
or without your syscall, it's equal effort, but the existing
interfaces... exist.

Regards,
Vito Caputo

--eioqlffteccd2lzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vwm-fds.txt"

total 0
lrwx------ 1 vcaputo vcaputo 64 Jul  5 13:16 0 -> /dev/tty1
l-wx------ 1 vcaputo vcaputo 64 Jul  5 13:16 1 -> /home/vcaputo/.xsession-errors
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 10 -> /proc/829/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 100 -> /proc/8427/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 101 -> /proc/8428/task/8428/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 102 -> /proc/8428/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 103 -> /proc/8428/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 104 -> /proc/8428/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 105 -> /proc/8428/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 106 -> /proc/8430/task/8430/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 107 -> /proc/8430/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 108 -> /proc/8430/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 109 -> /proc/8430/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 11 -> /proc/830/task/830/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 110 -> /proc/8430/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 111 -> /proc/8433/task/8433/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 112 -> /proc/8433/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 113 -> /proc/8433/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 114 -> /proc/8433/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 115 -> /proc/8433/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 116 -> /proc/8434/task/8434/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 117 -> /proc/8434/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 118 -> /proc/8434/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 119 -> /proc/8434/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 12 -> /proc/830/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 120 -> /proc/8434/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 121 -> /proc/12400/task/12400/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 122 -> /proc/12400/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 123 -> /proc/12400/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 124 -> /proc/12400/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 125 -> /proc/12400/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 126 -> /proc/11921/task/11921/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 127 -> /proc/11921/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 128 -> /proc/11921/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 129 -> /proc/11921/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 13 -> /proc/830/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 130 -> /proc/11921/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 131 -> /proc/30440/task/30440/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 132 -> /proc/30440/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 133 -> /proc/30440/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 134 -> /proc/30440/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 135 -> /proc/30440/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 136 -> /proc/5841/task/5841/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 137 -> /proc/5841/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 138 -> /proc/5841/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 139 -> /proc/5841/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 14 -> /proc/830/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 140 -> /proc/5841/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 141 -> /proc/25853/task/25853/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 142 -> /proc/25853/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 143 -> /proc/25853/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 144 -> /proc/25853/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 145 -> /proc/25853/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 146 -> /proc/25854/task/25854/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 147 -> /proc/25854/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 148 -> /proc/25854/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 149 -> /proc/25854/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 15 -> /proc/830/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 150 -> /proc/25854/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 151 -> /proc/25856/task/25856/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 152 -> /proc/25856/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 153 -> /proc/25856/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 154 -> /proc/25856/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 155 -> /proc/25856/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 156 -> /proc/25859/task/25859/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 157 -> /proc/25859/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 158 -> /proc/25859/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 159 -> /proc/25859/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 16 -> /proc/831/task/831/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 160 -> /proc/25859/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 161 -> /proc/5843/task/5843/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 162 -> /proc/5843/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 163 -> /proc/5843/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 164 -> /proc/5843/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 165 -> /proc/5843/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 166 -> /proc/5848/task/5848/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 167 -> /proc/5848/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 168 -> /proc/5848/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 169 -> /proc/5848/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 17 -> /proc/831/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 170 -> /proc/5848/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 171 -> /proc/5848/task
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 172 -> /proc/5848/task/5848/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 173 -> /proc/5848/task/5848/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 174 -> /proc/5848/task/5848/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 175 -> /proc/5848/task/5848/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 176 -> /proc/5849/task/5849/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 177 -> /proc/5849/task/5849/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 178 -> /proc/5849/task/5849/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 179 -> /proc/5849/task/5849/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 18 -> /proc/831/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 180 -> /proc/5850/task/5850/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 181 -> /proc/30441/task/30441/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 182 -> /proc/30441/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 183 -> /proc/30441/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 184 -> /proc/30441/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 185 -> /proc/30441/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 186 -> /proc/30443/task/30443/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 187 -> /proc/30443/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 188 -> /proc/30443/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 189 -> /proc/30443/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 19 -> /proc/831/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 190 -> /proc/30443/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 191 -> /proc/30446/task/30446/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 192 -> /proc/30446/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 193 -> /proc/30446/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 194 -> /proc/30446/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 195 -> /proc/30446/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 196 -> /proc/30447/task/30447/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 197 -> /proc/30447/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 198 -> /proc/30447/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 199 -> /proc/30447/wchan
l-wx------ 1 vcaputo vcaputo 64 Jul  5 13:16 2 -> /home/vcaputo/.xsession-errors
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 20 -> /proc/831/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 200 -> /proc/30447/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 201 -> /proc/30448/task/30448/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 202 -> /proc/30448/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 203 -> /proc/30448/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 204 -> /proc/30448/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 205 -> /proc/30448/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 206 -> /proc/30451/task/30451/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 207 -> /proc/30451/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 208 -> /proc/30451/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 209 -> /proc/30451/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 21 -> /proc/832/task/832/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 210 -> /proc/30451/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 211 -> /proc/30451/task
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 212 -> /proc/30451/task/30451/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 213 -> /proc/30451/task/30451/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 214 -> /proc/30451/task/30451/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 215 -> /proc/30451/task/30451/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 216 -> /proc/30452/task/30452/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 217 -> /proc/30452/task/30452/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 218 -> /proc/30452/task/30452/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 219 -> /proc/30452/task/30452/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 22 -> /proc/832/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 220 -> /proc/30453/task/30453/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 221 -> /proc/30453/task/30453/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 222 -> /proc/30453/task/30453/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 223 -> /proc/30453/task/30453/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 224 -> /proc/30454/task/30454/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 225 -> /proc/30454/task/30454/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 226 -> /proc/30454/task/30454/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 227 -> /proc/30454/task/30454/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 228 -> /proc/30455/task/30455/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 229 -> /proc/30455/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 23 -> /proc/832/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 230 -> /proc/30455/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 231 -> /proc/30455/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 232 -> /proc/30455/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 233 -> /proc/30458/task/30458/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 234 -> /proc/30458/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 235 -> /proc/30458/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 236 -> /proc/30458/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 237 -> /proc/30458/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 238 -> /proc/5850/task/5850/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 239 -> /proc/5850/task/5850/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 24 -> /proc/832/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 240 -> /proc/5850/task/5850/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 241 -> /proc/5851/task/5851/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 242 -> /proc/5851/task/5851/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 243 -> /proc/5851/task/5851/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 244 -> /proc/5851/task/5851/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 245 -> /proc/5853/task/5853/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 246 -> /proc/5853/task/5853/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 247 -> /proc/5853/task/5853/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 248 -> /proc/5853/task/5853/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 249 -> /proc/5856/task/5856/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 25 -> /proc/832/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 250 -> /proc/5856/task/5856/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 251 -> /proc/5856/task/5856/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 252 -> /proc/5856/task/5856/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 253 -> /proc/6844/task/6844/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 254 -> /proc/6844/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 255 -> /proc/6844/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 256 -> /proc/6844/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 257 -> /proc/6844/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 26 -> /proc/833/task/833/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 27 -> /proc/833/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 28 -> /proc/833/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 29 -> /proc/833/wchan
lrwx------ 1 vcaputo vcaputo 64 Jul  5 13:16 3 -> socket:[19590]
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 30 -> /proc/833/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 31 -> /proc/839/task/839/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 32 -> /proc/839/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 33 -> /proc/839/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 34 -> /proc/839/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 35 -> /proc/839/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 36 -> /proc/840/task/840/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 37 -> /proc/840/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 38 -> /proc/840/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 39 -> /proc/840/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 4 -> /proc
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 40 -> /proc/840/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 41 -> /proc/842/task/842/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 42 -> /proc/842/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 43 -> /proc/842/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 44 -> /proc/842/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 45 -> /proc/842/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 46 -> /proc/5858/task/5858/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 47 -> /proc/5858/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 48 -> /proc/5858/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 49 -> /proc/5858/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 5 -> /proc/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 50 -> /proc/5858/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 51 -> /proc/6841/task/6841/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 52 -> /proc/6841/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 53 -> /proc/6841/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 54 -> /proc/6841/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 55 -> /proc/6841/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 56 -> /proc/6842/task/6842/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 57 -> /proc/6842/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 58 -> /proc/6842/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 59 -> /proc/6842/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 6 -> /proc/829/task/829/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 60 -> /proc/6842/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 61 -> /proc/5840/task/5840/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 62 -> /proc/5840/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 63 -> /proc/5840/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 64 -> /proc/5840/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 65 -> /proc/5840/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 66 -> /proc/896/task/896/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 67 -> /proc/896/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 68 -> /proc/896/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 69 -> /proc/896/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 7 -> /proc/829/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 70 -> /proc/896/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 71 -> /proc/897/task/897/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 72 -> /proc/897/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 73 -> /proc/897/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 74 -> /proc/897/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 75 -> /proc/897/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 76 -> /proc/899/task/899/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 77 -> /proc/899/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 78 -> /proc/899/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 79 -> /proc/899/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 8 -> /proc/829/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 80 -> /proc/899/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 81 -> /proc/2293/task/2293/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 82 -> /proc/2293/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 83 -> /proc/2293/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 84 -> /proc/2293/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 85 -> /proc/2293/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 86 -> /proc/2294/task/2294/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 87 -> /proc/2294/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 88 -> /proc/2294/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 89 -> /proc/2294/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 9 -> /proc/829/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 90 -> /proc/2294/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 91 -> /proc/2296/task/2296/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 92 -> /proc/2296/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 93 -> /proc/2296/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 94 -> /proc/2296/wchan
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 95 -> /proc/2296/stat
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 96 -> /proc/8427/task/8427/children
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 97 -> /proc/8427/comm
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 98 -> /proc/8427/cmdline
lr-x------ 1 vcaputo vcaputo 64 Jul  5 13:16 99 -> /proc/8427/wchan

--eioqlffteccd2lzb--
