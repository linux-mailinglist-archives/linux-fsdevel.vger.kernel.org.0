Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A425E4255DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhJGO46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:56:58 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25387 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242165AbhJGO45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633618471; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HuRRC8o89jqXdAXVbjrxVI1PAXvlKBSNAc+uNFZjL2NgJJTRuAhMHQxm4V9zSoRmmCFC5iHxRFzT5VHy1kRI2Rdytn8jdGPewcR+jvZ9H3d759zvHDHmOiOqoTR5lAM1uD04z6rPgngkAHul2qsM9DRxYjnTXbyycX+G1fppE38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1633618471; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=xzGQg15CyPL9rja2MEzz8Q9NJqJTQGoAsftMpINsBoE=; 
        b=WGmzFrbfmQPRYihO2XT6A4obP8SSizg2eO7aXYZ1cZxNd2AxW6PRIlKd+JdVNiTBtVhkDVEvDOXwFaenP/ibpKtrux5PI1lKI/ORV7o6zRFrpDtoy0XefjTRYQhf7x5QoucpNDy7+qJ5y+/9fjXMgvqoCM7hP90+P4t0WaHnz78=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633618471;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=xzGQg15CyPL9rja2MEzz8Q9NJqJTQGoAsftMpINsBoE=;
        b=KP6fJyBuyrfbQcekxkh1j/JZXkWMrHSdsD/B/proBGV6DZaJr0WaNpP+ivrlB3FB
        uqoxOXLxitTySKnSebFh/tFElyQFKXI02/LJuaCLihozAgwoScjnoQ9KbfmNhBDAxDj
        CDizZCMUBEJDJXED9RNG8bD69lfU39zVPicganJ8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1633618469389517.6363333473703; Thu, 7 Oct 2021 22:54:29 +0800 (CST)
Date:   Thu, 07 Oct 2021 22:54:29 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17c5b3fa20a.ff02131b26074.9058176981832458952@mykernel.net>
In-Reply-To: <20211007144156.GK12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
 <20211007090157.GB12712@quack2.suse.cz>
 <17c5ab83d6d.10cdb35ab25883.3563739472838823734@mykernel.net> <20211007144156.GK12712@quack2.suse.cz>
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


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 22:41:56 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 07-10-21 20:26:36, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 17:01:57 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  >=20
 > >  > > +    if (mapping_writably_mapped(upper->i_mapping) ||
 > >  > > +        mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK=
))
 > >  > > +        iflag |=3D I_DIRTY_PAGES;
 > >  > > +
 > >  > > +    iflag |=3D upper->i_state & I_DIRTY_ALL;
 > >  >=20
 > >  > Also since you call ->write_inode directly upper->i_state won't be =
updated
 > >  > to reflect that inode has been written out (I_DIRTY flags get clear=
ed in
 > >  > __writeback_single_inode()). So it seems to me overlayfs will keep =
writing
 > >  > out upper inode until flush worker on upper filesystem also writes =
the
 > >  > inode and clears the dirty flags? So you rather need to call someth=
ing like
 > >  > write_inode_now() that will handle the flag clearing and do writeba=
ck list
 > >  > handling for you?
 > >  >=20
 > >=20
 > > Calling ->write_inode directly upper->i_state won't be updated, howeve=
r,
 > > I don't think overlayfs will keep writing out upper inode since
 > > ->write_inode will be called when only overlay inode itself marked dir=
ty.
 > > Am I missing something?
 >=20
 > Well, if upper->i_state is not updated, you are more or less guaranteed
 > upper->i_state & I_DIRTY_ALL !=3D 0 and thus even overlay inode stays di=
rty.
 > And thus next time writeback runs you will see dirty overlay inode and
 > writeback the upper inode again although it is not necessary.
 >=20

Hi Jan,

Yes, I get the point now. Thanks for the explanation.


Thanks,
Chengguang




