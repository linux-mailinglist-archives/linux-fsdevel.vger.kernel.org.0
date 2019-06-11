Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DF41644
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406598AbfFKUmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 16:42:49 -0400
Received: from mail180-16.suw31.mandrillapp.com ([198.2.180.16]:12613 "EHLO
        mail180-16.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406534AbfFKUms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:42:48 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 16:42:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=NII9dUPZstPQzWQWcZ0kvkl2Xz8WPoKqKU56SNDW9Hs=;
 b=GzvjTqIcZ125Ub5isuaXAIKqodlApvePh4Bspf+e682j5KT3otq9jxOKCKAzkHq3wOG4Xp//6+f4
   NY5v9SOsqTWkm9WdjvoQl35Qe6g0tXx8Wcu88SxDHnP1A+nHw9Byo+m5aUUErkLJKoOywko215iq
   xhsgVZOJEugLfHTHQ9k=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-16.suw31.mandrillapp.com id h0094e22sc02 for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 20:27:45 +0000 (envelope-from <bounce-md_31050260.5d000ec1.v1-009b9b45c10841e3a4870e12842f7d7a@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560284865; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=NII9dUPZstPQzWQWcZ0kvkl2Xz8WPoKqKU56SNDW9Hs=; 
 b=MEbgxtTSbSGFe7a+58AgNN2E4o66jr3WhidFffFm9oDd49y77yxriHce4lBS4P8S86IrbO
 fft/+Rgci0P0gTneLV64xHjvfVR+mjqCl+7vyt6hGObB/zwxoxusPypzrHmFrYuMmGnIohJg
 jPqoncGQWDWLdDhLk9fC4ZGtEOc1w=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: Linux 5.2-RC regression bisected, mounting glusterfs volumes fails after commit: fuse: require /dev/fuse reads to have enough buffer capacity
Received: from [87.98.221.171] by mandrillapp.com id 009b9b45c10841e3a4870e12842f7d7a; Tue, 11 Jun 2019 20:27:45 +0000
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, <gluster-devel@gluster.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Message-Id: <20190611202738.GA22556@deco.navytux.spb.ru>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it> <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
In-Reply-To: <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.009b9b45c10841e3a4870e12842f7d7a
X-Mandrill-User: md_31050260
Date:   Tue, 11 Jun 2019 20:27:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 01:52:14PM +0200, Miklos Szeredi wrote:
> On Tue, Jun 11, 2019 at 1:03 PM Sander Eikelenboom <linux@eikelenboom.it> wrote:
> >
> > L.S.,
> >
> > While testing a linux 5.2 kernel I noticed it fails to mount my glusterfs volumes.
> >
> > It repeatedly fails with:
> >    [2019-06-11 09:15:27.106946] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
> >    [2019-06-11 09:15:27.106955] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
> >    [2019-06-11 09:15:27.106963] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
> >    [2019-06-11 09:15:27.106971] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
> >    etc.
> >    etc.
> >
> > Bisecting turned up as culprit:
> >     commit d4b13963f217dd947da5c0cabd1569e914d21699: fuse: require /dev/fuse reads to have enough buffer capacity
> >
> > The glusterfs version i'm using is from Debian stable:
> >     ii  glusterfs-client                3.8.8-1                      amd64        clustered file-system (client package)
> >     ii  glusterfs-common                3.8.8-1                      amd64        GlusterFS common libraries and translator modules
> >
> >
> > A 5.1.* kernel works fine, as does a 5.2-rc4 kernel with said commit reverted.
> 
> Thanks for the report, reverted the bad commit.

First of all I'm sorry for breaking things here. The diff of the guilty
commit is

	--- a/fs/fuse/dev.c
	+++ b/fs/fuse/dev.c
	@@ -1317,6 +1317,16 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
	        unsigned reqsize;
	        unsigned int hash;
	 
	+       /*
	+        * Require sane minimum read buffer - that has capacity for fixed part
	+        * of any request header + negotated max_write room for data. If the
	+        * requirement is not satisfied return EINVAL to the filesystem server
	+        * to indicate that it is not following FUSE server/client contract.
	+        * Don't dequeue / abort any request.
	+        */
	+       if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER, 4096 + fc->max_write))
	+               return -EINVAL;
	+
	  restart:
	        spin_lock(&fiq->waitq.lock);
	        err = -EAGAIN;

and it was essentially requesting that the filesystem server provide
4K+<negotiated_max_write> buffer for reads from /dev/fuse. That 4K was meant as
space for FUSE request header, citing commit:

    Before getting into operation phase, FUSE filesystem server and kernel
    client negotiate what should be the maximum write size the client will
    ever issue. After negotiation the contract in between server/client is
    that the filesystem server then should queue /dev/fuse sys_read calls with
    enough buffer capacity to receive any client request - WRITE in
    particular, while FUSE client should not, in particular, send WRITE
    requests with > negotiated max_write payload. FUSE client in kernel and
    libfuse historically reserve 4K for request header. This way the
    contract is that filesystem server should queue sys_reads with
    4K+max_write buffer.

I could reproduce the problem and as it turns out what broke here is that
glusterfs is using not 4K but a smaller room for header - 80 bytes for
gluster-3.8 being `sizeof(fuse_in_header) + sizeof(fuse_write_in)`:

https://github.com/gluster/glusterfs/blob/v3.8.15-0-gd174f021a/xlators/mount/fuse/src/fuse-bridge.c#L4894


Since

	`sizeof(fuse_in_header) + sizeof(fuse_write_in)` ==
	`sizeof(fuse_in_header) + sizeof(fuse_read_in)`

is the absolute minimum any sane filesystem should be using for header room, can
we please restore the patch with that value instead of 4K?

That patch was there in the first place to help diagnose stuck fuse
servers much more easier, citing commit:

    If the filesystem server does not follow this contract, what can happen
    is that fuse_dev_do_read will see that request size is > buffer size,
    and then it will return EIO to client who issued the request but won't
    indicate in any way that there is a problem to filesystem server.
    This can be hard to diagnose because for some requests, e.g. for
    NOTIFY_REPLY which mimics WRITE, there is no client thread that is
    waiting for request completion and that EIO goes nowhere, while on
    filesystem server side things look like the kernel is not replying back
    after successful NOTIFY_RETRIEVE request made by the server.

    We can make the problem easy to diagnose if we indicate via error return to
    filesystem server when it is violating the contract.  This should not
    practically cause problems because if a filesystem server is using shorter
    buffer, writes to it were already very likely to cause EIO, and if the
    filesystem is read-only it should be too following FUSE_MIN_READ_BUFFER
    minimum buffer size.

    Please see [1] for context where the problem of stuck filesystem was hit
    for real (because kernel client was incorrectly sending more than
    max_write data with NOTIFY_REPLY; see also previous patch), how the
    situation was traced and for more involving patch that did not make it
    into the tree.

    [1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2

so it would be a pity to loose that property.

Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
header room change be accepted?

Kirill
