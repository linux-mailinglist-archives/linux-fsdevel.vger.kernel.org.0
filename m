Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DCA7846
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 03:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfIDB45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 21:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfIDB45 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:56:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB49E8980F8;
        Wed,  4 Sep 2019 01:56:56 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327A319C4F;
        Wed,  4 Sep 2019 01:56:55 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:03:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?gb2312?B?0vy9o7rn?= <yin-jianhong@163.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfsprogs: io/copy_range: cover corner case (fd_in ==
 fd_out)
Message-ID: <20190904020357.GW7239@dhcp-12-102.nay.redhat.com>
References: <20190903105632.11667-1-yin-jianhong@163.com>
 <20190903115943.GU7239@dhcp-12-102.nay.redhat.com>
 <20190903131928.GV7239@dhcp-12-102.nay.redhat.com>
 <7689497e.d24e.16cf7f750d6.Coremail.yin-jianhong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7689497e.d24e.16cf7f750d6.Coremail.yin-jianhong@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 04 Sep 2019 01:56:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:31:16AM +0800, Òü½£ºç wrote:
> We need cover the scenario that fd_in == fd_out
> not just same path.

Please reply to mail list, not 'me' only, to get more review:)

The patch which you're trying to cover is commit 9ab70ca653 as below[1].
From the code, I really doubt if you need same `struct file`, looks like
you need same `struct inode`.

Have you tried to test on same inode but not same 'fd'? I'm not a CIFS
expert, can CIFS have same file with different inode?

Thanks,
Zorro

[1]
commit 9ab70ca653307771589e1414102c552d8dbdbbef
Author: Kovtunenko Oleksandr <alexander198961@gmail.com>
Date:   Tue May 14 05:52:34 2019 +0000

    Fixed https://bugzilla.kernel.org/show_bug.cgi?id=202935 allow write on the same file
    
    Copychunk allows source and target to be on the same file.
    For details on restrictions see MS-SMB2 3.3.5.15.6
    
    Signed-off-by: Kovtunenko Oleksandr <alexander198961@gmail.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index b1a5fcfa3ce1..d0cb042732cb 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1070,11 +1070,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 
        cifs_dbg(FYI, "copychunk range\n");
 
-       if (src_inode == target_inode) {
-               rc = -EINVAL;
-               goto out;
-       }
-
        if (!src_file->private_data || !dst_file->private_data) {
                rc = -EBADF;
                cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");

> 
> #Did you read the summary and commit log?
> 
> 
> | |
> Òü½£ºç
> |
> |
> ÓÊÏä£ºyin-jianhong@163.com
> |
> 
> Ç©ÃûÓÉ ÍøÒ×ÓÊÏä´óÊ¦ ¶¨ÖÆ
> 
> On 09/03/2019 21:19, Zorro Lang wrote:
> On Tue, Sep 03, 2019 at 07:59:43PM +0800, Zorro Lang wrote:
> > On Tue, Sep 03, 2019 at 06:56:32PM +0800, Jianhong.Yin wrote:
> > > Related bug:
> > >   copy_file_range return "Invalid argument" when copy in the same file
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=202935
> > >
> > > if argument of option -f is "-", use current file->fd as fd_in
> > >
> > > Usage:
> > >   xfs_io -c 'copy_range -f -' some_file
> > >
> > > Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> > > ---
> >
> > Hi,
> >
> > Actually, I'm thinking about if you need same 'fd' or same file path?
> > If you just need same file path, I think
> >
> >   # xfs_io -c "copy_range testfile" testfile
> >
> > already can help that. The only one problem stop you doing that is
> > "copy_dst_truncate()".
> >
> > If all above I suppose is right, we can turn to talk about if that
> > copy_dst_truncate() is necessary, or how can we skip it.
> 
> I just checked, the copy_dst_truncate() is only called when:
> 
>  if (src == 0 && dst == 0 && len == 0) {
> 
> So if you can give your reproducer a "length"(or offset), likes:
> 
>  # xfs_io -c "copy_range -l 64k testfile" testfile
> 
> You can avoid the copy_dst_truncate() too.
> 
> Is that helpful?
> 
> Thanks,
> Zorro
> 
> >
> > Thanks,
> > Zorro
> >
> > >  io/copy_file_range.c | 27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/io/copy_file_range.c b/io/copy_file_range.c
> > > index b7b9fd88..2dde8a31 100644
> > > --- a/io/copy_file_range.c
> > > +++ b/io/copy_file_range.c
> > > @@ -28,6 +28,7 @@ copy_range_help(void)
> > >                            at position 0\n\
> > >   'copy_range -f 2' - copies all bytes from open file 2 into the current open file\n\
> > >                            at position 0\n\
> > > + 'copy_range -f -' - copies all bytes from current open file append the current open file\n\
> > >  "));
> > >  }
> > >  
> > > @@ -114,11 +115,15 @@ copy_range_f(int argc, char **argv)
> > >                 }
> > >                 break;
> > >            case 'f':
> > > -               src_file_nr = atoi(argv[1]);
> > > -               if (src_file_nr < 0 || src_file_nr >= filecount) {
> > > -                    printf(_("file value %d is out of range (0-%d)\n"),
> > > -                         src_file_nr, filecount - 1);
> > > -                    return 0;
> > > +               if (strcmp(argv[1], "-"))
> > > +                    src_file_nr = (file - &filetable[0]) / sizeof(fileio_t);
> > > +               else {
> > > +                    src_file_nr = atoi(argv[1]);
> > > +                    if (src_file_nr < 0 || src_file_nr >= filecount) {
> > > +                         printf(_("file value %d is out of range (0-%d)\n"),
> > > +                              src_file_nr, filecount - 1);
> > > +                         return 0;
> > > +                    }
> > >                 }
> > >                 /* Expect no src_path arg */
> > >                 src_path_arg = 0;
> > > @@ -147,10 +152,14 @@ copy_range_f(int argc, char **argv)
> > >            }
> > >            len = sz;
> > >  
> > > -          ret = copy_dst_truncate();
> > > -          if (ret < 0) {
> > > -               ret = 1;
> > > -               goto out;
> > > +          if (fd != file->fd) {
> > > +               ret = copy_dst_truncate();
> > > +               if (ret < 0) {
> > > +                    ret = 1;
> > > +                    goto out;
> > > +               }
> > > +          } else {
> > > +               dst = sz;
> > >            }
> > >       }
> > >  
> > > --
> > > 2.17.2
> > >
