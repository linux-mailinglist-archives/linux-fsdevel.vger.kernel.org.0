Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65D20D3B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgF2TB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:01:26 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:35415 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729042AbgF2TBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:01:24 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id A1142FAE80
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 10:31:35 +0100 (IST)
Received: (qmail 402 invoked from network); 29 Jun 2020 09:31:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jun 2020 09:31:35 -0000
Date:   Mon, 29 Jun 2020 10:31:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on
 pseudo inodes' breaks chromium here
Message-ID: <20200629093134.GW3183@techsingularity.net>
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
 <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
 <bffe8da0944fad97c60bbd4e73dc970ee3a7a2c0.camel@redhat.com>
 <d805dc9c56918a1fab5056a68165d34421f95ce7.camel@redhat.com>
 <CAOQ4uxjy77SMM6+v2Hpu2i0zy_zQy0EGzY7Tj4wTgUu62TRFww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjy77SMM6+v2Hpu2i0zy_zQy0EGzY7Tj4wTgUu62TRFww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 28, 2020 at 04:34:51PM +0300, Amir Goldstein wrote:
> > > > > #0 0x55f6da0120d9 base::debug::CollectStackTrace()
> > > > > #1 0x55f6d9f75246 base::debug::StackTrace::StackTrace()
> > > > > #2 0x55f6da01170a base::debug::(anonymous namespace)::StackDumpSignalHandler()
> > > > > #3 0x55f6da011cfe base::debug::(anonymous namespace)::StackDumpSignalHandler()
> > > > > #4 0x7ff46643ab20 (/usr/lib64/libpthread-2.30.so+0x14b1f)
> > > > > #5 0x7ff462d87625 __GI_raise
> > > > > #6 0x7ff462d708d9 __GI_abort
> > > > > #7 0x55f6da0112d5 base::debug::BreakDebugger()
> > > > > #8 0x55f6d9f86405 logging::LogMessage::~LogMessage()
> > > > > #9 0x55f6d7ed5488 content::(anonymous namespace)::IntentionallyCrashBrowserForUnusableGpuProcess()
> > > > > #10 0x55f6d7ed8479 content::GpuDataManagerImplPrivate::FallBackToNextGpuMode()
> > > > > #11 0x55f6d7ed4eef content::GpuDataManagerImpl::FallBackToNextGpuMode()
> > > > > #12 0x55f6d7ee0f41 content::GpuProcessHost::RecordProcessCrash()
> > > > > #13 0x55f6d7ee105d content::GpuProcessHost::OnProcessCrashed()
> > > > > #14 0x55f6d7cbe308 content::BrowserChildProcessHostImpl::OnChildDisconnected()
> > > > > #15 0x55f6da8b511a IPC::ChannelMojo::OnPipeError()
> > > > > #16 0x55f6da13cd62 mojo::InterfaceEndpointClient::NotifyError()
> > > > > #17 0x55f6da8c1f9d IPC::(anonymous namespace)::ChannelAssociatedGroupController::OnPipeError()
> > > > > #18 0x55f6da138968 mojo::Connector::HandleError()
> > > > > #19 0x55f6da15bce7 mojo::SimpleWatcher::OnHandleReady()
> > > > > #20 0x55f6da15c0fb mojo::SimpleWatcher::Context::CallNotify()
> > > > > #21 0x55f6d78eaa73 mojo::core::WatcherDispatcher::InvokeWatchCallback()
> > > > > #22 0x55f6d78ea38f mojo::core::Watch::InvokeCallback()
> > > > > #23 0x55f6d78e6efa mojo::core::RequestContext::~RequestContext()
> > > > > #24 0x55f6d78db76a mojo::core::NodeChannel::OnChannelError()
> > > > > #25 0x55f6d78f232a mojo::core::(anonymous namespace)::ChannelPosix::OnFileCanReadWithoutBlocking()
> > > > > #26 0x55f6da03345e base::MessagePumpLibevent::OnLibeventNotification()
> > > > > #27 0x55f6da0f9b2d event_base_loop
> > > > > #28 0x55f6da03316d base::MessagePumpLibevent::Run()
> > > > > #29 0x55f6d9fd79c9 base::sequence_manager::internal::ThreadControllerWithMessagePumpImpl::Run()
> > > > > #30 0x55f6d9fada7a base::RunLoop::Run()
> > > > > #31 0x55f6d7ce6324 content::BrowserProcessSubThread::IOThreadRun()
> > > > > #32 0x55f6d9fe0cb8 base::Thread::ThreadMain()
> > > > > #33 0x55f6da024705 base::(anonymous namespace)::ThreadFunc()
> > > > > #34 0x7ff46642f4e2 start_thread
> > > > > #35 0x7ff462e4c6a3 __GI___clone
> > > > >   r8: 0000000000000000  r9: 00007ff44e6a58d0 r10: 0000000000000008 r11: 0000000000000246
> > > > >  r12: 00007ff44e6a6b40 r13: 00007ff44e6a6d00 r14: 000000000000006d r15: 00007ff44e6a6b30
> > > > >   di: 0000000000000002  si: 00007ff44e6a58d0  bp: 00007ff44e6a5b20  bx: 00007ff44e6a9700
> > > > >   dx: 0000000000000000  ax: 0000000000000000  cx: 00007ff462d87625  sp: 00007ff44e6a58d0
> > > > >   ip: 00007ff462d87625 efl: 0000000000000246 cgf: 002b000000000033 erf: 0000000000000000
> > > > >  trp: 0000000000000000 msk: 0000000000000000 cr2: 0000000000000000
> > > > > [end of stack trace]
> > > > > Calling _exit(1). Core file will not be generated.
> > > > >
> > > > >
> > > >
> > > > I guess this answers our question whether we could disable fsnoitfy
> > > > watches on pseudo inodes....
> > > >
> > > > From comments like these in chromium code:
> > > > https://chromium.googlesource.com/chromium/src/+/master/mojo/core/watcher_dispatcher.cc#77
> > > > https://chromium.googlesource.com/chromium/src/+/master/base/files/file_descriptor_watcher_posix.cc#176
> > > > https://chromium.googlesource.com/chromium/src/+/master/ipc/ipc_channel_mojo.cc#240
> > > >
> > > > I am taking a wild guess that the missing FS_CLOSE event on anonymous pipes is
> > > > the cause for regression.
> > > >
> > > > The motivation for the patch "fs: Do not check if there is a fsnotify
> > > > watcher on pseudo inodes"
> > > > was performance, but actually, FS_CLOSE and FS_OPEN events probably do
> > > > not impact
> > > > performance as FS_MODIFY and FS_ACCESS.
> > > >
> > > > Mel,
> > > >
> > > > Do your perf results support the claim above?
> > > >
> > > > Jan/Linus,
> > > >
> > > > Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
> > > > files as a general rule should be safe?
> > > >
> > > > Maxim, can you try if the attached patch fixes the chromium regression.
> > > > It is expected to leave the FS_OPEN/FS_CLOSE events on anonymous pipes
> > > > but drop the FS_MODIFY/FS_ACCESS events.
> > > Tested this (in the VM this time) and it works.
> >
> >
> > Note that this should be changed to 'return' since function returns void.
> >
> > +       if (file->f_mode & FMODE_STREAM)
> > +               return 0;
> >
> 
> Right sorry. Didn't pay attention to the build warnings.
> 
> Now only left to see if this approach is acceptable and if it also
> fixes the performance issue reported by Mel.
> 


Thanks Amir!

The performance seems fine and I think the patch is ok. If there is an
issue with special casing FMODE_STREAM then the alternative would be to
special case pipes with FMODE_NONOTIFY specifically as pipes appear to
be the pseudo inode that is most affected by fsnotify checks.

-- 
Mel Gorman
SUSE Labs
