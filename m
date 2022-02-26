Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAD4C560C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiBZNKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 08:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiBZNKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:10:13 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E428D3BE;
        Sat, 26 Feb 2022 05:09:38 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id g21so8329354vsp.6;
        Sat, 26 Feb 2022 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6mMH+g8JjJF6YXpdjy8a0QxVcZM5KBTzRXmny8JcnVc=;
        b=LlAaDGrjHbL3NSeXPo/tbi8/HxikWLoqUTS3ZTdpkSeJoY3W4guLK13IB01ViQHIzc
         1lsgGpiuuCBvxllSj3JY+uvDuX5cTqnGupDzqsZgu15SAK6Zn0lP4WWBva5/J/TzdWM/
         f+nKgRzUkQp+qITb/M+F4cNZMq6qYLkFhY3hEexltlxsSfnOds/9z4+pz1hjDynLKx3j
         ZC2OTz29C4hXekx4IxR2cmBsfaGt3EjDbV+6Jrs0CSkHwEjoXOKNXqXx84FYp54crlqQ
         rA0v3lo9rVHTO7D41lRMu+q/wh0gbN2/VN274HViYOpgCGp6obDfcXacQRi+YgwcJUns
         9T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6mMH+g8JjJF6YXpdjy8a0QxVcZM5KBTzRXmny8JcnVc=;
        b=tex1yjYQx+XNnpOVqamsGIdRKBKhhmU32yA9TKqYm+sV31lz7C18SAK8QrBoxDyPqg
         vAwD0Irx3k1N9eO7q2KdMIfS8KzBeiQeEF4zVvrEdunObeMwVUtPIkcluMEYKXsPcrEk
         3kOdZkMUTUtGAArL6YDidVo3y+szKfgY2/1na2UZ2Rgo/04ZEaF+lc9ZeoXXTuv6QiV6
         6+kLyayUN5gO9qiHq/3lCSg/khF5cj+3mQyOPJAqFgivZgnvOZZg/QnAJYywkw29oLfN
         lUEAAx4EvkHNURSde03KLRvpoPDXas+pDSl0U1sMNXfNH0jsSPeoQeuR0yfaCevtkTRb
         QtvQ==
X-Gm-Message-State: AOAM530EkSn8mIHkAZ/VviYHrVO5DYvKdl7ylnBpTy8SQolh97D9fHVg
        7eF4jDOoV4p4+eAkgEFmi2+hShAXydkZHr/8waM=
X-Google-Smtp-Source: ABdhPJzIi0XMX8hEWOr9DenUDWsZbRspjq/qs/JDGWdN0nvxgczGsswnyfs3EfIZL5NaQ191VTcjSL66cmhk45QB4zI=
X-Received: by 2002:a67:a204:0:b0:300:d105:c98c with SMTP id
 l4-20020a67a204000000b00300d105c98cmr5222327vse.24.1645880977433; Sat, 26 Feb
 2022 05:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20220216230319.6436-1-linkinjeon@kernel.org> <Yg7dMwEebkITEMI+@zeniv-ca.linux.org.uk>
 <CAKYAXd9CEDqfwNsVU=DkfBhmL2zmiRaTfALeDRt8KHqMVnQ=1w@mail.gmail.com>
In-Reply-To: <CAKYAXd9CEDqfwNsVU=DkfBhmL2zmiRaTfALeDRt8KHqMVnQ=1w@mail.gmail.com>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Sat, 26 Feb 2022 22:09:26 +0900
Message-ID: <CANFS6bbZffBk_OccvFEi4zE8+0LJcRPdpV9kNkm85YsPg_EUgQ@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix racy issue from using ->d_parent and ->d_name
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022=EB=85=84 2=EC=9B=94 18=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:02, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Al,
> 2022-02-18 8:41 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> > On Thu, Feb 17, 2022 at 08:03:19AM +0900, Namjae Jeon wrote:
> >> Al pointed out that ksmbd has racy issue from using ->d_parent and
> >> ->d_name
> >> in ksmbd_vfs_unlink and smb2_vfs_rename(). and he suggested changing f=
rom
> >> the way it start with dget_parent(), which can cause retry loop and
> >> unexpected errors, to find the parent of child, lock it and then look =
for
> >> a child in locked directory.
> >>
> >> This patch introduce a new helper(vfs_path_parent_lookup()) to avoid
> >> out of share access and export vfs functions like the following ones t=
o
> >> use
> >> vfs_path_parent_lookup() and filename_parentat().
> >>  - __lookup_hash().
> >>  - getname_kernel() and putname().
> >>  - filename_parentat()
> >
> > First of all, your vfs_path_parent_lookup() calling conventions are wro=
ng.
> > You have 3 callers:
> >       err =3D vfs_path_parent_lookup(share->vfs_path.dentry,
> >                                    share->vfs_path.mnt, filename_struct=
,
> >                                    LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
> >                                    &path, &last, &type);
> >       err =3D vfs_path_parent_lookup(share_conf->vfs_path.dentry,
> >                                    share_conf->vfs_path.mnt, to,
> >                                    lookup_flags | LOOKUP_BENEATH,
> >                                    &new_path, &new_last, &new_type);
> >       err =3D vfs_path_parent_lookup(share->vfs_path.dentry,
> >                                    share->vfs_path.mnt, filename_struct=
,
> >                                    LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
> >                                    &path, &last, &type);
> > Note that in all of them the first two arguments come from ->dentry and
> > ->mnt of the same struct path instance.  Now, look at the function itse=
lf:
> >
> > int vfs_path_parent_lookup(struct dentry *dentry, struct vfsmount *mnt,
> >                          struct filename *filename, unsigned int flags,
> >                          struct path *parent, struct qstr *last, int *t=
ype)
> > {
> >       struct path root =3D {.mnt =3D mnt, .dentry =3D dentry};
> >
> >       return  __filename_parentat(AT_FDCWD, filename, flags, parent, la=
st,
> >                                   type, &root);
> > }
> >
> > What about the __filename_parentat() last argument?  It's declared as
> > struct path *root and passed to set_nameidata().  No other uses.  And
> > set_nameidata() gets it via const struct path *root argument.  IOW,
> > it's not going to modify the contents of that struct path.  Since
> > you __filename_parentat() doesn't do anything else with its root
> > argument, there's no reason not to make _that_ const struct path *,
> > is there?
> Yep, No reason.
>
> >
> > Now, if you do that, you can safely turn vfs_path_parent_lookup()
> > take const struct path * instead of dentry/vfsmount pair of arguments
> > and drop the local struct path instance in the vfs_path_parent_lookup()
> > itself.
> Yes. I will change it.
>
> >
> > The fact that vfs_path_lookup() passes vfsmount and dentry separately
> > doesn't mean you need to do the same - look at the existing callers
> > of vfs_path_lookup() (outside of ksmbd itself) and you'll see the
> > difference.  Incidentally, this
> > fs/ksmbd/vfs.c:22:#include "../internal.h"      /* for vfs_path_lookup =
*/
> > had been a really bad idea.  And no, nfsd doing the same is not a good
> > thing either...
> >
> > General rule: if it's exported, it's *NOT* internal.
> Okay. Then as another patch, I will move vfs_path_lookup prototype in
> internal.h to linux/namei.h.
>
> >
> >
> > Next:
> >
> >> index 077b8761d099..b094cd1d4951 100644
> >> --- a/fs/ksmbd/oplock.c
> >> +++ b/fs/ksmbd/oplock.c
> >> @@ -1713,11 +1713,14 @@ int smb2_check_durable_oplock(struct ksmbd_fil=
e
> >> *fp,
> >>                      ret =3D -EBADF;
> >>                      goto out;
> >>              }
> >> +            down_read(&fp->filename_lock);
> >>              if (name && strcmp(fp->filename, name)) {
> >> +                    up_read(&fp->filename_lock);
> >>                      pr_err("invalid name reconnect %s\n", name);
> >>                      ret =3D -EINVAL;
> >>                      goto out;
> >>              }
> >> +            up_read(&fp->filename_lock);
> >
> > What assumptions do you make about those strings?  Note that opened fil=
e
> > is *NOT* guaranteed to have its pathname remain unchanged - having
> > /tmp/foo/bar/baz/blah opened will not prevent mv /tmp/foo /tmp/barf
> > and the file will remain opened (and working just fine).  AFAICS, you
> > only update it in smb2_rename(), which is not going to be called by
> > mv(1) called by admin on server.
> Whenever a FILE_ALL_INFORMATION request is received from a client,
> ksmbd need to call d_path(then, removing the share path in pathname is
> required) to obtain pathname for windows. To avoid the issue you
> mentioned, we can remove the all uses of ->filename and calling
> d_path() whenever pathname is need.
>
> >
> > BTW, while grepping through the related code, convert_to_nt_pathname()
> > is Not Nice(tm).  Seriously, strlen(s) =3D=3D 0 is not an idiomatic way=
 to
> > check that s is an empty string.  What's more, return value of that
> > function ends up passed to kfree().  Which is not a good thing to do
> > to a string constant.  That can be recovered by use of kfree_const() in
> > get_file_all_info(), but.. ouch.
> Okay.
>
> >
> > ksmbd_vfs_rename(): UGH.
> >       * you allocate a buffer
> >       * do d_path() into it
> >       * then use getname_kernel() to allocate another one and copy the =
contents
> > into it.  By that point the string might have nothing to do with the ac=
tual
> > location of object, BTW (see above)
> Can we use dget_parent() and take_dentry_name_snapshot() for source
> file instead of d_path(), getname_kernel() and filename_parentat()?
> Because ksmbd receive fileid(ksmbd_file) for source file from client.
> [See control flow the below]
>

As Namjae said, for the rename, a client sends FileId of a source file and
an absolute path of a destination file. ksmbd can only get a dentry of
the source file from FileId.
So I think we can use dget_parent() to get a parent dentry. And we
have to verify the parent dentry by locking the parent inode, and
calling take_dentry_name_snapshot() and lookup_one().

> >       * then you use filename_parentat() (BTW, the need to export both =
it and
> > vfs_path_parent_lookup() is an artefact of bad calling conventions -
> > passing
> > NULL as const struct path * would do the right thing, if not for the fa=
ct
> > that
> > with your calling conventions you have to pass a non-NULL pointer - tha=
t to
> > a local struct path in your vfs_path_parent_lookup()).
> Okay.
>
> >       * then you use vfs_path_parent_lookup() to find the new parent.  =
OK,
> > but...
> > you proceed to check if it has somehow returned you a symlink.  Huh?  H=
ow
> > does
> > one get a symlink from path_parentat() or anything that would use it?
> As security issues, We made it not to allow symlinks.
>
> > I would very much appreciate a reproducer for that.
> >       * you use lock_rename() to lock both parents.  Which relies upon =
the
> > caller having checked that they live on the same filesystem.  Neither o=
ld
> > nor
> > new version do that, which means relatively easy deadlocks.
> Okay. will add the check for this.
>
> >       * look the last components up.  NB: the old one might very well h=
ave
> > nothing to do with the path.dentry.
> Okay.
>
> >       * do usual checks re loop prevention (with slightly unusual error
> > values, but whatever)
> I understood that you pointed out to add retry_estale() check and retry.
>
> >       * call ksmbd_lookup_fd_inode() on the old parent.  Then dereferen=
ce
> > the return value (if non-NULL)... and never do anything else to it.  Ho=
w
> > can
> > that possibly work?  What's there to prevent freeing of that struct
> > ksmbd_file
> > just as ksmbd_lookup_fd_inode() returns it?  Looks like it's either a l=
eak
> > or
> > use-after-free, and looking at ksmbd_lookup_fd_inode() it's probably th=
e
> > latter.
> Right. Need to increase reference count of ksmbd_file. I will fix it.
>
> >       * proceed with vfs_rename(), drop the stuff you'd acquired and go
> > away.
> Okay.
>
> >
> > ksmbd_vfs_unlink():
> >       * const char *filename, please, unless you really modify it there=
.
> Okay.
> >       * what the hell is that ihold/iput pair for?
> I refered codes in do_unlinkat() for this. If this pair is not needed,
> I'll delete it,
> but could you please tell me why it's needed in unlinkat() ?
>
> >
> > I'm not sure that the set you'd exported is the right one, but that's
> > secondary - I'd really like to understand what assumptions are you
> > making about the ->filename contents, as well as the control flow
> > from protocol request that demands rename to the actual call of
> > vfs_rename().  Could you elaborate on that?  I am not familiar with
> > the protocol, other than bits and pieces I'd observed in fs/cifs
> > code.
> As I said above, the uses of ->filename can be replaced with d_path().
> control flow for rename is the following.
>
>  a. Receiving smb2 create(open) request from client.
>      - Getting struct file after calling vfs_path_lookup() and
> dentry_open() using pathname from client.
>      - create ksmbd_file and add struct file to fp->filp and generate
> fileid for struct ksmbd_file.
>      - send smb2 create response included fileid of ksmbd_file to client.
>  b. Receiving smb2_set_info file(FILE_RENAME_INFORMATION) request from cl=
ient.
>      - lookup ksmbd_file using fileid of request. This will source
> file for rename.
>      - get absolute pathname for destination fille in smb2 set info
> file for rename.
>      - find both parents of source and destination and lock and do rename=
...
>  c. Receiving smb2 close.
>
> Thanks for your review!
> >



--=20
Thanks,
Hyunchul
