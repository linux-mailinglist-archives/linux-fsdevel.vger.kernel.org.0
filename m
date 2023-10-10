Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92A7C034E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjJJSVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjJJSVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:21:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571CAB0;
        Tue, 10 Oct 2023 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=5ZDcexWSa220cB9u7b7WMbNMuMkhl4u0eporNDdQoHU=; b=AqVv/bxGOUddmmjcdYlSAHvEHT
        F56fSgXuagyfKhKei88bUCwXlXkhEokuOuwfLPRtS9iYm46QR7sftI17evGqBEAM4+ArBSeCg5npO
        SVmUAn+QChqRY0MNGge3HvVgDEdNpeRDPW27gtFMIJYBIyWtfHfZrR4WfikWit/QoX7RsdRJ1RL0w
        mNmg6Dm1wqmIlgKW2ykkQLpRgjfxapoJt0GAzXO8eK6oYoT+hrr/iuNUzyb9ZGsZ33GtTQq/oSTG+
        ZlN0M8Y6/HBSD0mYajQxv8BNqditlMNypApT5Urqr2UrYDSs2GAETVBTY4rQVRtxI+DK3Ib1Yw+FX
        5JAk7ZJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqHMT-0001Jz-1I;
        Tue, 10 Oct 2023 18:21:41 +0000
Date:   Tue, 10 Oct 2023 19:21:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231010182141.GR800259@ZenIV>
References: <20231009153712.1566422-1-amir73il@gmail.com>
 <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV>
 <20231010174146.GQ800259@ZenIV>
 <CAOQ4uxjHKU0q8dSBQhGpcdp-Dg1Hx-zxs3AurXZBQnKBkV7PAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjHKU0q8dSBQhGpcdp-Dg1Hx-zxs3AurXZBQnKBkV7PAw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:57:21PM +0300, Amir Goldstein wrote:
> On Tue, Oct 10, 2023 at 8:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> > > On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > > > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > > Sorry, you asked about ovl mount.
> > > > > To me it makes sense that if users observe ovl paths in writable mapped
> > > > > memory, that ovl should not be remounted RO.
> > > > > Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> > > > > Is there?
> > > >
> > > > Agreed.
> > > >
> > > > But is preventing remount RO important enough to warrant special
> > > > casing of backing file in generic code?  I'm not convinced either
> > > > way...
> > >
> > > You definitely want to guarantee that remounting filesystem r/o
> > > prevents the changes of visible contents; it's not just POSIX,
> > > it's a fairly basic common assumption about any local filesystems.
> >
> > Incidentally, could we simply keep a reference to original struct file
> > instead of messing with path?
> >
> > The only caller of backing_file_open() gets &file->f_path as user_path; how
> > about passing file instead, and having backing_file_open() do get_file()
> > on it and stash the sucker into your object?
> >
> > And have put_file_access() do
> >         if (unlikely(file->f_mode & FMODE_BACKING))
> >                 fput(backing_file(file)->file);
> > in the end.
> >
> > No need to mess with write access in any special way and it's closer
> > to the semantics we have for normal mmap(), after all - it keeps the
> > file we'd passed to it open as long as mapping is there.
> >
> > Comments?
> 
> Seems good to me.
> It also shrinks backing_file by one pointer.
> 
> I think this patch can be an extra one after
> "fs: store real path instead of fake path in backing file f_path"
> 
> Instead of changing storing of real_path to storing orig file in
> one change?
> 
> If there are no objections, I will write it up.

Actually, now that I'd looked at it a bit more...  Look:
we don't need to do *anything* in put_file_access(); just
make file_free()
        if (unlikely(f->f_mode & FMODE_BACKING))
		fput(backing_file(f)->user_file);
instead of conditional path_put().  That + change of open_backing_file()
prototype + get_file() in there pretty much eliminates the work done
in 1/3 - you don't need to mess with {get,put}_file_write_access()
at all.

I'd start with this:

struct file *vm_user_file(struct vm_area_struct *vma)
{
	return vma->vm_file;
}
+ replace file = vma->vm_file; with file = vm_user_file(vma) in
the places affected by your 2/3.  That's the first (obviously
safe) commit.  Then the change of backing_file_open() combined
with making vm_user_file() do this:
	file = vma->vm_file;
	if (file && unlikely(file->f_mode & FMODE_BACKING))
		file = backing_file(file)->user_file;
	return file;

Voila.  Two-commit series, considerably smaller than your
variant...

