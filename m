Return-Path: <linux-fsdevel+bounces-68717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590BC63E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECC914ED3E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210B328B7B;
	Mon, 17 Nov 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCOTva+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5336219A8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379750; cv=none; b=TjC6dOtZJ9tf0MGRfUNMlUMm2LqWQrWgwGY3VABAxjmUeibufAeGqFe8ZFz8buQyvCONzcTwfzEUUd1Y5vzIlxcsetITBuf+iRoCojDsNmGyRuWYMdWEGAVD0L0dxJlMDp/C4pdXKCyHdtDWUuB740ms95IMN24O8nvg55l8NHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379750; c=relaxed/simple;
	bh=DrDWvhIc7N1/SPrlaITwzd/VtRJq8MJIiZF/4gOQrs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB25mcxddXGYXfNWc4HZlzveWupDeVEBuUBHELlmfJh/+s5xfMdDeR90AGUI8AysADWkYewWDfCpigFlCTahwtzX4SiybbPb0QPc7MM6DzggMZpCTMlsvNmwGrOqnt5ZKCpAwEILLmwNpRg9dIyMuAcL3bmLyfmgwX5WEAGgt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCOTva+S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b736d883ac4so495098666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763379747; x=1763984547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLByek/00m1CKj+kC5ilafItJoPjq2T9oK+xnr6qUYg=;
        b=cCOTva+SLeZ+6sLekokOiQHnIPy2/o48YdSGAMYpf+h2Juej+hvh6dDyAL6z8pXWYR
         xq0DmUSKPhdVQ+5zzucgr5WNMGcT6f5D6/CCdwLCHAXBt748xRZq7cYLJZJcYki1aJKx
         ZWvZMrToq0vOFDlq1ej7yv+bejZySo0ZbtKPCxBf5zdstxl7PtwoI2FsFnuBVEnJsorV
         cZynwsFHeINYQSnA9IxMF9gB12ur4TQXOWsfEzwl7JQiGuGjVKbDzXERpO58+ctPqbl9
         70PksuUkSe+iycZvT8+H9xbyJs17SgnWKlajTONI+wxAKg4gi/Dr6w5W87jeg6DrK4NL
         BL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763379747; x=1763984547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLByek/00m1CKj+kC5ilafItJoPjq2T9oK+xnr6qUYg=;
        b=JO+TTT6o4Sodpav3wGLNqSladLlhGai0HHlC9nyb3vy++fe9v4/4+IEEoqrbYe2geg
         5FP+PGVdX1yCz2CQ9WXvpZ0mUN/YUJNAR6lM4DyiCvrLgKKMH0gc+E34k5/x0mclAgb0
         JSHJjEXX5CamEvQzyqgOEigLojPIX+zTg491zqaNhKEmxvGRQhtDb8tckjySPbk2F5wO
         Tah1mOw/A+H4eOrmM9wUJIqb0N8UlcYQDPqY4Xo9FcjiAtpHleWPMVrV2aVPUmr1+nCa
         sr/FNArikVe3P1qPNkEncuM1FlqwFRkgiSvrmkw1Ssor+SqsivqIVMS33AO5rZD+miJl
         IT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXigitbvCQw5GCNms2UH4Y1AoOTBJNF564rB9mJaYE4+3Hd2uwwQiPuZEeefW3fYJEhUYMncISMW151WDzJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QZQavleqvahFDTLizLfAzopDyjToxShQfF8CUzGDTyHPgd3X
	v+PRVucX/W8bw8P2DTOVSKA9rhMv8EfWA8oa9KFUAAT6K6FFcBRK7C7VSbfxl6J0J0RJwr/Z286
	a4+pgh9+sSqxQyS/ZDfrUeZbVwRrFH4A=
X-Gm-Gg: ASbGncs5i4QE7G/MzuYm+Am0RcuaxZT7/LK2B2ihVFJMyGfJnAPr/RQJTVA/zTzibcn
	XS1eYRAH5EuotGOmcHCez/yRqHEMLpsVu+7QB/Rb6oZehuE2ySgYNp+mvvzGVf8SxQlb6c/MG6s
	vkVUejOCQv3LR7Wx7B4GaiK/XfNvS3zW8RtI9m+XlMcHXOXsdfUBbCGBrhiEzm2xVSakTZIaXKW
	MUTHDYmA6VcNUJ9AQDhaq9g5GIKV62ujAtcRrKHMqYvd9AeJXpu7dFFDsdlDuUmC2lXz5MWr/+K
	skjsxrMTCBbXoNU=
X-Google-Smtp-Source: AGHT+IEMz1pZGeRCmDO84z5zBHCRYvIz6t+XVK/Tcz4Q2SDOXvfnD5p7amEncJuWUSE7VUtMLAKvuBSlA5WPOPIRyC0=
X-Received: by 2002:a17:906:ef0a:b0:b73:210a:44e with SMTP id
 a640c23a62f3a-b7367badf35mr1155691466b.30.1763379747060; Mon, 17 Nov 2025
 03:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu> <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
 <20250413124054.GA1116327@mit.edu> <CAGudoHFciRp7qJtaHSOhLAxpCfT1NEf0+MN0iprnOYORYgXKbw@mail.gmail.com>
 <CAGudoHHrUkcGvhE3kwc9+kgdia_NREEeTj=_UBtiHCpUGEYwZg@mail.gmail.com> <kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz>
In-Reply-To: <kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 17 Nov 2025 12:42:14 +0100
X-Gm-Features: AWmQ_bkp5BvsOjiXXaa5Aj-p35DXC0RODFdIzcv9D6Pi2YUWc3peCqwVjmYekmw
Message-ID: <CAGudoHFeS6GUxMdm9dJoswEViHHFvgV+FEbSqo4+RP4L_P84zw@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-11-25 12:51:16, Mateusz Guzik wrote:
> > On Wed, Nov 5, 2025 at 12:50=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > >
> > > On Sun, Apr 13, 2025 at 2:40=E2=80=AFPM Theodore Ts'o <tytso@mit.edu>=
 wrote:
> > > >
> > > > On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> > > > > This is the rootfs of the thing, so I tried it out with merely
> > > > > printing it. I got 70 entries at boot time. I don't think figurin=
g out
> > > > > what this is specifically is warranted (it is on debian though).
> > > >
> > > > Well, can you run:
> > > >
> > > > debugfs -R "stat <INO>" /dev/ROOT_DEV
> > > >
> > > > on say, two or three of the inodes (replace INO with a number, and
> > > > ROOT_DEV with the root file system device) and send me the result?
> > > > That would be really helpful in understanding what might be going o=
n.
> > > >
> > > > > So... I think this is good enough to commit? I had no part in wri=
ting
> > > > > the patch and I'm not an ext4 person, so I'm not submitting it my=
self.
> > > > >
> > > > > Ted, you seem fine with the patch, so perhaps you could do the ne=
edful(tm)?
> > > >
> > > > Sure, I'll put together a more formal patch and do full QA run and
> > > > checking of the code paths, as a supposed a fairly superficial revi=
ew
> > > > and hack.
> > > >
> > >
> > > It looks like this well through the cracks.
> > >
> > > To recount, here is the patch (by Linus, not me):
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index f386de8c12f6..3e0ba7c4723a 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block=
 *sb, unsigned long ino,
> > > >                 goto bad_inode;
> > > >         brelse(iloc.bh);
> > > >
> > > > +       if (test_opt(sb, DEBUG) &&
> > > > +           (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> > > > +            ei->i_file_acl))
> > > > +               ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode=
->i_ino);
> > > > +
> > > >         unlock_new_inode(inode);
> > > >         return inode;
> > >
> >
> > sigh, copy-pasto, the patch is:
> >   --- a/fs/ext4/inode.c
> >   +++ b/fs/ext4/inode.c
> >   @@ -5011,6 +5011,11 @@ struct inode *__ext4_iget(...
> >         }
> >
> >         brelse(iloc.bh);
> >   +
> >   +     /* Initialize the "no ACL's" state for the simple cases */
> >   +     if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_f=
ile_acl)
> >   +             cache_no_acl(inode);
> >   +
> >         unlock_new_inode(inode);
> >         return inode;
>
> This looks fine. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

ping?

the window to get this in 6.19 is closing (if not too late already),
would be a bummer if it did not make it

