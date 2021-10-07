Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DA4252F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhJGM3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:29:02 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25310 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233135AbhJGM3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633609599; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=pbVwJUO76c5OfYRLmclbHoK69TAyZ5YoRXtcgY/bqEBmjPnVUq5lDuAX5JD0uKnqMRINYTR0slHr0idsqHUxXsFj9Pode4MrKMEaJXG2qCS1Ccl059aerxJKAlHPEaCF/dAmf/J7Q3KlyLObr6DENE69/vlAyqT9h6FHlnuymkE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1633609599; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=ZmDQWllWGjCMvtEuij8KJbKB+KItbbkjy4HSIF8fY/w=; 
        b=HaFm5YkJxmLKrToodDRb8aUqwVddH7KC7kao0e+i3TpeNw9/MlXk46f3yelj8fxTEdBmsAyuAU0Sg7Id+/t87OsT8gYTRPlccE+o7Dp55/AjdoHzU0Kln8yZbAEDKGun2de7bSz5lULNu/i9cNBsNq3fofvJX0hJvJsLx3SHjBA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633609599;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=ZmDQWllWGjCMvtEuij8KJbKB+KItbbkjy4HSIF8fY/w=;
        b=GeOvSt6R+tkMXJTQKpbnRvahIqsn55ytgPpB5ilePhrXK9obLeko2E6XKBbhIV3Z
        6kBisByT+sz1Tp4mRWUE5FUs4ifKPCyGWaFM+JKxTwON7bfTccnC43z7QWsXBJmNJFT
        /5OO78gyh6XAYCGnuwspIxcuuEXtc2jO/w8RmlMQ=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1633609596273981.3428858564824; Thu, 7 Oct 2021 20:26:36 +0800 (CST)
Date:   Thu, 07 Oct 2021 20:26:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17c5ab83d6d.10cdb35ab25883.3563739472838823734@mykernel.net>
In-Reply-To: <20211007090157.GB12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net> <20211007090157.GB12712@quack2.suse.cz>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 17:01:57 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 23-09-21 21:08:10, Chengguang Xu wrote:
 > > Implement overlayfs' ->write_inode to sync dirty data
 > > and redirty overlayfs' inode if necessary.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > ...
 >=20
 > > +static int ovl_write_inode(struct inode *inode,
 > > +               struct writeback_control *wbc)
 > > +{
 > > +    struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > > +    struct inode *upper =3D ovl_inode_upper(inode);
 > > +    unsigned long iflag =3D 0;
 > > +    int ret =3D 0;
 > > +
 > > +    if (!upper)
 > > +        return 0;
 > > +
 > > +    if (!ovl_should_sync(ofs))
 > > +        return 0;
 > > +
 > > +    if (upper->i_sb->s_op->write_inode)
 > > +        ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
 > > +
 >=20
 > I'm somewhat confused here. 'inode' is overlayfs inode AFAIU, so how is =
it
 > correct to pass it to ->write_inode function of upper filesystem? Should=
n't
 > you pass 'upper' there instead?

That's right!

 >=20
 > > +    if (mapping_writably_mapped(upper->i_mapping) ||
 > > +        mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
 > > +        iflag |=3D I_DIRTY_PAGES;
 > > +
 > > +    iflag |=3D upper->i_state & I_DIRTY_ALL;
 >=20
 > Also since you call ->write_inode directly upper->i_state won't be updat=
ed
 > to reflect that inode has been written out (I_DIRTY flags get cleared in
 > __writeback_single_inode()). So it seems to me overlayfs will keep writi=
ng
 > out upper inode until flush worker on upper filesystem also writes the
 > inode and clears the dirty flags? So you rather need to call something l=
ike
 > write_inode_now() that will handle the flag clearing and do writeback li=
st
 > handling for you?
 >=20

Calling ->write_inode directly upper->i_state won't be updated,=20
however, I don't think overlayfs will keep writing out upper inode since ->=
write_inode
will be called when only overlay inode itself marked dirty.  Am I missing s=
omething?


Thanks,
Chengguang


