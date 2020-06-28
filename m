Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E620C82A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgF1NOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 09:14:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53675 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbgF1NOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 09:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593350088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D80MHniFvVdP34Lif7QfAUEYjZEaAApyLQyjZ2F/dKc=;
        b=O3guhNgq3U5Agz0zbukWwyionDizyGgAUsJPVT8UEPyLyZRclOp5a/5Rbaf8LfNQkPzB1J
        jJlyEbKqneQRBpeulLUSOHD8fxC/gA5xhIVXW2ldOTRVgALOtw6UHfSyq998MuQY1ozQr/
        EpBYDhocR9h/TKIHJoYZ5ejLjIIs9Lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-chsEpeSbMFqmUuSsxSLDtQ-1; Sun, 28 Jun 2020 09:14:44 -0400
X-MC-Unique: chsEpeSbMFqmUuSsxSLDtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8348CBFC0;
        Sun, 28 Jun 2020 13:14:42 +0000 (UTC)
Received: from starship (unknown [10.35.206.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABBB94B40;
        Sun, 28 Jun 2020 13:14:40 +0000 (UTC)
Message-ID: <bffe8da0944fad97c60bbd4e73dc970ee3a7a2c0.camel@redhat.com>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on
 pseudo inodes' breaks chromium here
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 16:14:39 +0300
In-Reply-To: <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
         <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-06-28 at 15:53 +0300, Amir Goldstein wrote:
> On Sun, Jun 28, 2020 at 2:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Hi,
> > 
> > I just did usual kernel update and now chromium crashes on startup.
> > It happens both in a KVM's VM (with virtio-gpu if that matters) and natively with amdgpu driver.
> > Most likely not GPU related although I initially suspected that it is.
> > 
> > Chromium starts as a white rectangle, shows few white rectangles
> > that resemble its notifications and then crashes.
> > 
> > The stdout output from chromium:
> > 
> [...]
> 
> > Received signal 6
> > #0 0x55f6da0120d9 base::debug::CollectStackTrace()
> > #1 0x55f6d9f75246 base::debug::StackTrace::StackTrace()
> > #2 0x55f6da01170a base::debug::(anonymous namespace)::StackDumpSignalHandler()
> > #3 0x55f6da011cfe base::debug::(anonymous namespace)::StackDumpSignalHandler()
> > #4 0x7ff46643ab20 (/usr/lib64/libpthread-2.30.so+0x14b1f)
> > #5 0x7ff462d87625 __GI_raise
> > #6 0x7ff462d708d9 __GI_abort
> > #7 0x55f6da0112d5 base::debug::BreakDebugger()
> > #8 0x55f6d9f86405 logging::LogMessage::~LogMessage()
> > #9 0x55f6d7ed5488 content::(anonymous namespace)::IntentionallyCrashBrowserForUnusableGpuProcess()
> > #10 0x55f6d7ed8479 content::GpuDataManagerImplPrivate::FallBackToNextGpuMode()
> > #11 0x55f6d7ed4eef content::GpuDataManagerImpl::FallBackToNextGpuMode()
> > #12 0x55f6d7ee0f41 content::GpuProcessHost::RecordProcessCrash()
> > #13 0x55f6d7ee105d content::GpuProcessHost::OnProcessCrashed()
> > #14 0x55f6d7cbe308 content::BrowserChildProcessHostImpl::OnChildDisconnected()
> > #15 0x55f6da8b511a IPC::ChannelMojo::OnPipeError()
> > #16 0x55f6da13cd62 mojo::InterfaceEndpointClient::NotifyError()
> > #17 0x55f6da8c1f9d IPC::(anonymous namespace)::ChannelAssociatedGroupController::OnPipeError()
> > #18 0x55f6da138968 mojo::Connector::HandleError()
> > #19 0x55f6da15bce7 mojo::SimpleWatcher::OnHandleReady()
> > #20 0x55f6da15c0fb mojo::SimpleWatcher::Context::CallNotify()
> > #21 0x55f6d78eaa73 mojo::core::WatcherDispatcher::InvokeWatchCallback()
> > #22 0x55f6d78ea38f mojo::core::Watch::InvokeCallback()
> > #23 0x55f6d78e6efa mojo::core::RequestContext::~RequestContext()
> > #24 0x55f6d78db76a mojo::core::NodeChannel::OnChannelError()
> > #25 0x55f6d78f232a mojo::core::(anonymous namespace)::ChannelPosix::OnFileCanReadWithoutBlocking()
> > #26 0x55f6da03345e base::MessagePumpLibevent::OnLibeventNotification()
> > #27 0x55f6da0f9b2d event_base_loop
> > #28 0x55f6da03316d base::MessagePumpLibevent::Run()
> > #29 0x55f6d9fd79c9 base::sequence_manager::internal::ThreadControllerWithMessagePumpImpl::Run()
> > #30 0x55f6d9fada7a base::RunLoop::Run()
> > #31 0x55f6d7ce6324 content::BrowserProcessSubThread::IOThreadRun()
> > #32 0x55f6d9fe0cb8 base::Thread::ThreadMain()
> > #33 0x55f6da024705 base::(anonymous namespace)::ThreadFunc()
> > #34 0x7ff46642f4e2 start_thread
> > #35 0x7ff462e4c6a3 __GI___clone
> >   r8: 0000000000000000  r9: 00007ff44e6a58d0 r10: 0000000000000008 r11: 0000000000000246
> >  r12: 00007ff44e6a6b40 r13: 00007ff44e6a6d00 r14: 000000000000006d r15: 00007ff44e6a6b30
> >   di: 0000000000000002  si: 00007ff44e6a58d0  bp: 00007ff44e6a5b20  bx: 00007ff44e6a9700
> >   dx: 0000000000000000  ax: 0000000000000000  cx: 00007ff462d87625  sp: 00007ff44e6a58d0
> >   ip: 00007ff462d87625 efl: 0000000000000246 cgf: 002b000000000033 erf: 0000000000000000
> >  trp: 0000000000000000 msk: 0000000000000000 cr2: 0000000000000000
> > [end of stack trace]
> > Calling _exit(1). Core file will not be generated.
> > 
> > 
> 
> I guess this answers our question whether we could disable fsnoitfy
> watches on pseudo inodes....
> 
> From comments like these in chromium code:
> https://chromium.googlesource.com/chromium/src/+/master/mojo/core/watcher_dispatcher.cc#77
> https://chromium.googlesource.com/chromium/src/+/master/base/files/file_descriptor_watcher_posix.cc#176
> https://chromium.googlesource.com/chromium/src/+/master/ipc/ipc_channel_mojo.cc#240
> 
> I am taking a wild guess that the missing FS_CLOSE event on anonymous pipes is
> the cause for regression.
> 
> The motivation for the patch "fs: Do not check if there is a fsnotify
> watcher on pseudo inodes"
> was performance, but actually, FS_CLOSE and FS_OPEN events probably do
> not impact
> performance as FS_MODIFY and FS_ACCESS.
> 
> Mel,
> 
> Do your perf results support the claim above?
> 
> Jan/Linus,
> 
> Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
> files as a general rule should be safe?
> 
> Maxim, can you try if the attached patch fixes the chromium regression.
> It is expected to leave the FS_OPEN/FS_CLOSE events on anonymous pipes
> but drop the FS_MODIFY/FS_ACCESS events.
Tested this (in the VM this time) and it works.

Best regards,
	Maxim Levitsky

> 
> Thanks,
> Amir.


