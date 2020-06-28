Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED9420C81A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 14:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgF1MyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgF1MyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:54:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F2C061794;
        Sun, 28 Jun 2020 05:54:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f23so14389228iof.6;
        Sun, 28 Jun 2020 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIUfBuwihE9oZhxwBlU0ORY9Yo39s3Byr/LCGR7VhVA=;
        b=LpvQMvE9EUGHHom0VP4xXyRQTolyfjNu+686DSRcje6vTchcjszyca3lgKzg5sSNMs
         Dtq9edm6hAqgUlZ5Vwexm8yjxeirv1ScPcnn58b9kq2UaWl9VytCdHqmuKtwaP8g7J8b
         lWSGSNMLYVgkrWi8f0TKDp7wHY4YoT0vwJbVCvwCYUTONcohoE60oeN/ZGVCxmfR4MV9
         Ihb7UzU3TWA2gvMLn91uYU3TL3rXHtTksv+7WzezCT3DE0OG7SFsNL6oJGhcIZjnf2u2
         zqwzqJ+7MM909fUivk039LWI/nlK3PD+QkPDzSmqLMau66vnQ/lrAiVpae1Ptm5vdiE9
         d1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIUfBuwihE9oZhxwBlU0ORY9Yo39s3Byr/LCGR7VhVA=;
        b=ROjDegMtIFw8G3VQsDDxmRyIIvhAiFrTyqae85TmEicMNHsDfBpBqUAWYMhUPPLOYI
         DuA16DumPClKPq7en7OIgGkP2VoaGSvbmRycIlQxI9U5eUUMnD9PC65ut0+msXOzUcBy
         h1l7M4Hv8+5dURkzcu844hlwKpoblKoQcwHWIaSwVBROPygJUw+YwQDyxeWiVpbpjEdZ
         QGc6RJroerKWHX3VJX3tHkiJJ0be938FdNgLmk76IN9q/60sGf3SzrygqP/wHnNJbaBE
         uB65KJqu08tHfQoK/cOI1wHHk/UwaW1UqhOncND5+DS7NltG7VSv8x0JwJqpsXqw+Ewz
         OqOg==
X-Gm-Message-State: AOAM532KXgigslTotUawV8nULt519rh7VPHqKhEnDBifLb59FaMVi4C2
        jPo5QsZmP5Re0JbhZps3taBUx4yNP9QF2AR5OZQsUR6X
X-Google-Smtp-Source: ABdhPJx1Gsy+POKMPDlft68FGDonPLFoGZr6pImz887pGcF7TeNxqC6Ed2A1KsImS2jDNj7rhYFZj1DX+pYa7u7roV4=
X-Received: by 2002:a05:6638:a0a:: with SMTP id 10mr9627755jan.30.1593348842934;
 Sun, 28 Jun 2020 05:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
In-Reply-To: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Jun 2020 15:53:51 +0300
Message-ID: <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on pseudo
 inodes' breaks chromium here
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/mixed; boundary="000000000000c9772605a9246f02"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000c9772605a9246f02
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 28, 2020 at 2:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Hi,
>
> I just did usual kernel update and now chromium crashes on startup.
> It happens both in a KVM's VM (with virtio-gpu if that matters) and natively with amdgpu driver.
> Most likely not GPU related although I initially suspected that it is.
>
> Chromium starts as a white rectangle, shows few white rectangles
> that resemble its notifications and then crashes.
>
> The stdout output from chromium:
>
[...]

> Received signal 6
> #0 0x55f6da0120d9 base::debug::CollectStackTrace()
> #1 0x55f6d9f75246 base::debug::StackTrace::StackTrace()
> #2 0x55f6da01170a base::debug::(anonymous namespace)::StackDumpSignalHandler()
> #3 0x55f6da011cfe base::debug::(anonymous namespace)::StackDumpSignalHandler()
> #4 0x7ff46643ab20 (/usr/lib64/libpthread-2.30.so+0x14b1f)
> #5 0x7ff462d87625 __GI_raise
> #6 0x7ff462d708d9 __GI_abort
> #7 0x55f6da0112d5 base::debug::BreakDebugger()
> #8 0x55f6d9f86405 logging::LogMessage::~LogMessage()
> #9 0x55f6d7ed5488 content::(anonymous namespace)::IntentionallyCrashBrowserForUnusableGpuProcess()
> #10 0x55f6d7ed8479 content::GpuDataManagerImplPrivate::FallBackToNextGpuMode()
> #11 0x55f6d7ed4eef content::GpuDataManagerImpl::FallBackToNextGpuMode()
> #12 0x55f6d7ee0f41 content::GpuProcessHost::RecordProcessCrash()
> #13 0x55f6d7ee105d content::GpuProcessHost::OnProcessCrashed()
> #14 0x55f6d7cbe308 content::BrowserChildProcessHostImpl::OnChildDisconnected()
> #15 0x55f6da8b511a IPC::ChannelMojo::OnPipeError()
> #16 0x55f6da13cd62 mojo::InterfaceEndpointClient::NotifyError()
> #17 0x55f6da8c1f9d IPC::(anonymous namespace)::ChannelAssociatedGroupController::OnPipeError()
> #18 0x55f6da138968 mojo::Connector::HandleError()
> #19 0x55f6da15bce7 mojo::SimpleWatcher::OnHandleReady()
> #20 0x55f6da15c0fb mojo::SimpleWatcher::Context::CallNotify()
> #21 0x55f6d78eaa73 mojo::core::WatcherDispatcher::InvokeWatchCallback()
> #22 0x55f6d78ea38f mojo::core::Watch::InvokeCallback()
> #23 0x55f6d78e6efa mojo::core::RequestContext::~RequestContext()
> #24 0x55f6d78db76a mojo::core::NodeChannel::OnChannelError()
> #25 0x55f6d78f232a mojo::core::(anonymous namespace)::ChannelPosix::OnFileCanReadWithoutBlocking()
> #26 0x55f6da03345e base::MessagePumpLibevent::OnLibeventNotification()
> #27 0x55f6da0f9b2d event_base_loop
> #28 0x55f6da03316d base::MessagePumpLibevent::Run()
> #29 0x55f6d9fd79c9 base::sequence_manager::internal::ThreadControllerWithMessagePumpImpl::Run()
> #30 0x55f6d9fada7a base::RunLoop::Run()
> #31 0x55f6d7ce6324 content::BrowserProcessSubThread::IOThreadRun()
> #32 0x55f6d9fe0cb8 base::Thread::ThreadMain()
> #33 0x55f6da024705 base::(anonymous namespace)::ThreadFunc()
> #34 0x7ff46642f4e2 start_thread
> #35 0x7ff462e4c6a3 __GI___clone
>   r8: 0000000000000000  r9: 00007ff44e6a58d0 r10: 0000000000000008 r11: 0000000000000246
>  r12: 00007ff44e6a6b40 r13: 00007ff44e6a6d00 r14: 000000000000006d r15: 00007ff44e6a6b30
>   di: 0000000000000002  si: 00007ff44e6a58d0  bp: 00007ff44e6a5b20  bx: 00007ff44e6a9700
>   dx: 0000000000000000  ax: 0000000000000000  cx: 00007ff462d87625  sp: 00007ff44e6a58d0
>   ip: 00007ff462d87625 efl: 0000000000000246 cgf: 002b000000000033 erf: 0000000000000000
>  trp: 0000000000000000 msk: 0000000000000000 cr2: 0000000000000000
> [end of stack trace]
> Calling _exit(1). Core file will not be generated.
>
>

I guess this answers our question whether we could disable fsnoitfy
watches on pseudo inodes....

From comments like these in chromium code:
https://chromium.googlesource.com/chromium/src/+/master/mojo/core/watcher_dispatcher.cc#77
https://chromium.googlesource.com/chromium/src/+/master/base/files/file_descriptor_watcher_posix.cc#176
https://chromium.googlesource.com/chromium/src/+/master/ipc/ipc_channel_mojo.cc#240

I am taking a wild guess that the missing FS_CLOSE event on anonymous pipes is
the cause for regression.

The motivation for the patch "fs: Do not check if there is a fsnotify
watcher on pseudo inodes"
was performance, but actually, FS_CLOSE and FS_OPEN events probably do
not impact
performance as FS_MODIFY and FS_ACCESS.

Mel,

Do your perf results support the claim above?

Jan/Linus,

Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
files as a general rule should be safe?

Maxim, can you try if the attached patch fixes the chromium regression.
It is expected to leave the FS_OPEN/FS_CLOSE events on anonymous pipes
but drop the FS_MODIFY/FS_ACCESS events.

Thanks,
Amir.

--000000000000c9772605a9246f02
Content-Type: text/plain; charset="US-ASCII"; 
	name="fsnotify-suppress-access-modify-events-on-stream-files.patch.txt"
Content-Disposition: attachment; 
	filename="fsnotify-suppress-access-modify-events-on-stream-files.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kbz2p2pl0>
X-Attachment-Id: f_kbz2p2pl0

RnJvbSBhODFjNzI5YTVjNTJkZGIyZDhkOTgyMjA0NzhlNDkyYjcxOTU2NTc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDI4IEp1biAyMDIwIDE1OjM2OjU2ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IHN1cHByZXNzIGFjY2Vzcy9tb2RpZnkgZXZlbnRzIG9uIHN0cmVhbSBmaWxlcwoKV2Ug
d2FudGVkIHRvIHN1cHByZXNzIGFsbCBmc25vdGlmeSBldmVudHMgb24gYW5vbnltb3VzIHBpcGVz
L3NvY2tldHMsCmJ1dCBjaHJvbWlvdW0gc2VlbXMgdG8gYmUgcmVseWluZyBvbiBzb21lIG9mIHRo
b3NlIGV2ZW50cy4KCkxldCdzIHRyeSB0byBzdXBwcmVzcyBvbmx5IGFjY2Vzcy9tb2RpZnkgZXZl
bnRzIG9uIHN0cmVhbSBmaWxlcy4KClJlcG9ydGVkLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0
c2tAcmVkaGF0LmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83YjRhYTFl
OTg1MDA3YzZkNTgyZmZmZTVlODQzNWY4MTUzZTI4ZTBmLmNhbWVsQHJlZGhhdC5jb20KRml4ZXM6
IGU5YzE1YmFkYmI3YiAoImZzOiBEbyBub3QgY2hlY2sgaWYgdGhlcmUgaXMgYSBmc25vdGlmeSB3
YXRjaGVyIG9uIHBzZXVkbyBpbm9kZXMiKQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8
YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL2ZpbGVfdGFibGUuYyAgICAgICAgICB8IDIgKy0K
IGluY2x1ZGUvbGludXgvZnNub3RpZnkuaCB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZpbGVfdGFibGUu
YyBiL2ZzL2ZpbGVfdGFibGUuYwppbmRleCA2NTYwMzUwMmZlZDYuLjY1NjY0N2Y5NTc1YSAxMDA2
NDQKLS0tIGEvZnMvZmlsZV90YWJsZS5jCisrKyBiL2ZzL2ZpbGVfdGFibGUuYwpAQCAtMjMwLDcg
KzIzMCw3IEBAIHN0cnVjdCBmaWxlICphbGxvY19maWxlX3BzZXVkbyhzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgdmZzbW91bnQgKm1udCwKIAkJZF9zZXRfZF9vcChwYXRoLmRlbnRyeSwgJmFu
b25fb3BzKTsKIAlwYXRoLm1udCA9IG1udGdldChtbnQpOwogCWRfaW5zdGFudGlhdGUocGF0aC5k
ZW50cnksIGlub2RlKTsKLQlmaWxlID0gYWxsb2NfZmlsZSgmcGF0aCwgZmxhZ3MgfCBGTU9ERV9O
T05PVElGWSwgZm9wcyk7CisJZmlsZSA9IGFsbG9jX2ZpbGUoJnBhdGgsIGZsYWdzLCBmb3BzKTsK
IAlpZiAoSVNfRVJSKGZpbGUpKSB7CiAJCWlob2xkKGlub2RlKTsKIAkJcGF0aF9wdXQoJnBhdGgp
OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oIGIvaW5jbHVkZS9saW51eC9m
c25vdGlmeS5oCmluZGV4IDVhYjI4ZjZjN2QyNi4uM2EwNzgyNDMzMmY1IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCkBA
IC0yNDYsNiArMjQ2LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X3JtZGlyKHN0cnVj
dCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpCiAgKi8KIHN0YXRpYyBpbmxpbmUg
dm9pZCBmc25vdGlmeV9hY2Nlc3Moc3RydWN0IGZpbGUgKmZpbGUpCiB7CisJaWYgKGZpbGUtPmZf
bW9kZSAmIEZNT0RFX1NUUkVBTSkKKwkJcmV0dXJuIDA7CisKIAlmc25vdGlmeV9maWxlKGZpbGUs
IEZTX0FDQ0VTUyk7CiB9CiAKQEAgLTI1NCw2ICsyNTcsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
ZnNub3RpZnlfYWNjZXNzKHN0cnVjdCBmaWxlICpmaWxlKQogICovCiBzdGF0aWMgaW5saW5lIHZv
aWQgZnNub3RpZnlfbW9kaWZ5KHN0cnVjdCBmaWxlICpmaWxlKQogeworCWlmIChmaWxlLT5mX21v
ZGUgJiBGTU9ERV9TVFJFQU0pCisJCXJldHVybiAwOworCiAJZnNub3RpZnlfZmlsZShmaWxlLCBG
U19NT0RJRlkpOwogfQogCi0tIAoyLjE3LjEKCg==
--000000000000c9772605a9246f02--
