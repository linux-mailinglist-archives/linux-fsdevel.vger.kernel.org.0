Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12832C8CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgK3SYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:24:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35256 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387922AbgK3SYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:24:42 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AUINqgZ011934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 13:23:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6346C420136; Mon, 30 Nov 2020 13:23:52 -0500 (EST)
Date:   Mon, 30 Nov 2020 13:23:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Race: data race between ext4_setattr() and acl_permission_check()
Message-ID: <20201130182352.GH5364@mit.edu>
References: <051AF232-4255-42B3-95AE-F8F64D66A6ED@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051AF232-4255-42B3-95AE-F8F64D66A6ED@purdue.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:55:20PM +0000, Gong, Sishuai wrote:
> Hi,
> 
> We found a data race in linux kernel 5.3.11 that we are able to
> reproduce in x86 under specific interleavings. Currently, we are not
> sure about the consequence of this race so we would like to confirm
> with the community if this can be a harmful bug.

What do you mean by "data race" in this context?  If you have one
process setting a file's group id, while another process is trying to
open that same file and that open is depending on the process's group
access vs the file's group id, the open might succeed or fail
depending on whether the chgrp(2) is executed before or after the
open(2).

I could see data race if in some other context of the file open, the
group id is read, and so the group id might be inconsistent during the
course of operating on a particular system call.  In which case, we
might need to cache the group id value, or take some kind of lock,
etc.

But if your automated tool can't distinguish whether or not this is
the case, I'll gently suggest that it's not particuarly useful....
Maybe this is something that should be the subject of further
research?  The whole point of automated tools, after all, is to save
developers' time.  And not asking them to chase down potential
questions like "so is this real or not"?

Cheers,

					- Ted

> 
> ------------------------------------------
> Writer site
> 
>  /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/ext4/inode.c:5599
>        5579              error = PTR_ERR(handle);
>        5580              goto err_out;
>        5581          }
>        5582
>        5583          /* dquot_transfer() calls back ext4_get_inode_usage() which
>        5584           * counts xattr inode references.
>        5585           */
>        5586          down_read(&EXT4_I(inode)->xattr_sem);
>        5587          error = dquot_transfer(inode, attr);
>        5588          up_read(&EXT4_I(inode)->xattr_sem);
>        5589
>        5590          if (error) {
>        5591              ext4_journal_stop(handle);
>        5592              return error;
>        5593          }
>        5594          /* Update corresponding info in inode so that everything is in
>        5595           * one transaction */
>        5596          if (attr->ia_valid & ATTR_UID)
>        5597              inode->i_uid = attr->ia_uid;
>        5598          if (attr->ia_valid & ATTR_GID)
>  ==>   5599              inode->i_gid = attr->ia_gid;
>        5600          error = ext4_mark_inode_dirty(handle, inode);
>        5601          ext4_journal_stop(handle);
>        5602      }
>        5603
>        5604      if (attr->ia_valid & ATTR_SIZE) {
>        5605          handle_t *handle;
>        5606          loff_t oldsize = inode->i_size;
>        5607          int shrink = (attr->ia_size < inode->i_size);
>        5608
>        5609          if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>        5610              struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>        5611
>        5612              if (attr->ia_size > sbi->s_bitmap_maxbytes)
>        5613                  return -EFBIG;
>        5614          }
>        5615          if (!S_ISREG(inode->i_mode))
>        5616              return -EINVAL;
>        5617
>        5618          if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
>        5619              inode_inc_iversion(inode);
> 
> ------------------------------------------
> Reader site
> 
> /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/namei.c:306
>         286
>         287      return -EAGAIN;
>         288  }
>         289
>         290  /*
>         291   * This does the basic permission checking
>         292   */
>         293  static int acl_permission_check(struct inode *inode, int mask)
>         294  {
>         295      unsigned int mode = inode->i_mode;
>         296
>         297      if (likely(uid_eq(current_fsuid(), inode->i_uid)))
>         298          mode >>= 6;
>         299      else {
>         300          if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
>         301              int error = check_acl(inode, mask);
>         302              if (error != -EAGAIN)
>         303                  return error;
>         304          }
>         305
>  ==>    306          if (in_group_p(inode->i_gid))
>         307              mode >>= 3;
>         308      }
>         309
>         310      /*
>         311       * If the DACs are ok we don't need any capability check.
>         312       */
>         313      if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) == 0)
>         314          return 0;
>         315      return -EACCES;
>         316  }
>         317
> ------------------------------------------
> Writer calling trace
> 
> - do_fchownat
> -- chown_common
> --- notify_change
> 
> ------------------------------------------
> Reader calling trace
> 
> - do_execve
> -- __do_execve_file
> --- do_open_execat
> ---- do_filp_open
> ----- path_openat
> ------ link_path_walk
> ------- inode_permission
> -------- generic_permission
> 
> 
> 
> Thanks,
> Sishuai
> 
