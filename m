Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8E4652BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 17:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbhLAQao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 11:30:44 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25359 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239044AbhLAQan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638375842; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bsu7LQ2PoeLY0foZtF4JFW0yFeQvxbFUluNQXk3az6/4qMWdVyL7zq5fqzSRty2/3rjbqKl/iZNyBCNhJr7X9O+jJuzOC/W/dSR0YSjTiM5xf681ScJA/gx3VYEGp6HvKXDqAYnTOw15b+S5bHVBrb2P4S4QL9CJyz7oYI2imTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638375842; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=rcScbATqE6loxaDgQyPaD/4ZwjFVIqn67jJGI+uVyDw=; 
        b=kLVzGKVujfAPYvMR/1Aln8qXgt7I7DeIGLwEeDNcRIPuHOAKPPegdQDEvwjo/FdUnFxer/7EmAywcz/7eTABMuoNaA0a/hQln6vpLGIspCdm7ghgiS6Bh0wsBBANrAJKrzMCQ79xVb6bNNc5lZIFlRSB+jK9trn2YjiXaWuBSzQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638375842;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=rcScbATqE6loxaDgQyPaD/4ZwjFVIqn67jJGI+uVyDw=;
        b=dpjnOQbInxwEwa4T0nZRewxMfGWJLRZ28x+r7O48ol1Cf0DHFYU4LOvHSWV0fljR
        pX1G/6KwExjNjQeBgIUmeJgEz68+nayqn5npFifiTYswd6bxaezzNc+QUZ9xY4Lzida
        SUg7W/+5nn/FSPbsys3d/+Al3GXaDOU1HSR9Fx3M=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638375840259479.9473699389241; Thu, 2 Dec 2021 00:24:00 +0800 (CST)
Date:   Thu, 02 Dec 2021 00:24:00 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>,
        "Vivek Goyal" <vgoyal@redhat.com>
Message-ID: <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
In-Reply-To: <20211201134610.GA1815@quack2.suse.cz>
References: <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz>
 <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com> <20211201134610.GA1815@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
 > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
 > > > So the final solution to handle all the concerns looks like accurate=
ly
 > > > mark overlay inode diry on modification and re-mark dirty only for
 > > > mmaped file in ->write_inode().
 > > >
 > > > Hi Miklos, Jan
 > > >
 > > > Will you agree with new proposal above?
 > > >
 > >=20
 > > Maybe you can still pull off a simpler version by remarking dirty only
 > > writably mmapped upper AND inode_is_open_for_write(upper)?
 >=20
 > Well, if inode is writeably mapped, it must be also open for write, does=
n't
 > it? The VMA of the mapping will hold file open. So remarking overlay ino=
de
 > dirty during writeback while inode_is_open_for_write(upper) looks like
 > reasonably easy and presumably there won't be that many inodes open for
 > writing for this to become big overhead?
 >=20
 > > If I am not mistaken, if you always mark overlay inode dirty on ovl_fl=
ush()
 > > of FMODE_WRITE file, there is nothing that can make upper inode dirty
 > > after last close (if upper is not mmaped), so one more inode sync shou=
ld
 > > be enough. No?
 >=20
 > But we still need to catch other dirtying events like timestamp updates,
 > truncate(2) etc. to mark overlay inode dirty. Not sure how reliably that
 > can be done...
 >=20

To be honest I even don't fully understand what's the ->flush() logic in ov=
erlayfs.
Why should we open new underlying file when calling ->flush()?
Is it still correct in the case of opening lower layer first then copy-uped=
 case?=20


Thanks,
Chengguang






 =20
