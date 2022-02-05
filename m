Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCB4AA9E7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiBEQK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 11:10:27 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17145 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233316AbiBEQK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:10:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1644077387; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=RjNZQayxoGPaXXrZ1ftD6qh8ovCNXcz7Ov//aX/9oYdPnyizl+jAZD/wveGJZZ40LNRFREzZ3XTgMxhqmpFHpF32VEB/8vQPgg/0IqRlUo9BxtZpbQ8gEpLyeNfkhrIVkPnjh8+cUXMa4SYJmmSTW9B4K0pp3ujmEQexZlPGsoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1644077387; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZL/nqenoKCsAVEb0X9wysI1Nic97e3q2o8+TrCc2fZQ=; 
        b=bR1cgX2tEsAqk2kLGRSKvYyutQidFZWOssGlvrSA2uK5fyZebWExLQ6bfc1wVnclOv+zfzwIt8mPAeIMLK/OJ3gCTJ4vq+53t5ffREUQtQy54pR9GblS0JcKKmy7JzAEAcKP0OpmhXy1hbsenfGYGNf41xL2qBNoHKnn0OV8JlU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644077387;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:MIME-Version:Subject:To:Cc:References:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=ZL/nqenoKCsAVEb0X9wysI1Nic97e3q2o8+TrCc2fZQ=;
        b=RLgFK62k/bK64QydxKogZQkdmX5WhDQrFuluLJaMeHRcGE5NIGwYr8N0ns8X6mw7
        u1QPvMQIRtwBC5sjeNxM3fCe+EvwXFlBm0L9CIIIw5x0zU/IY7KZchYsqN7HxlsJTcF
        /m+wDM+UThrWNfjG2Kt0rWIuIvyoThX+nDGJjW6M=
Received: from [192.168.255.10] (116.30.192.113 [116.30.192.113]) by mx.zoho.com.cn
        with SMTPS id 1644077384521462.94265162596264; Sun, 6 Feb 2022 00:09:44 +0800 (CST)
Date:   Sun, 6 Feb 2022 00:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz>
 <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz>
 <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <17d8aeb19ac.f22523af26365.6531629287230366441@mykernel.net>
 <CAOQ4uxgwZoB5GQJZvpPLzRqrQA-+JSowD+brUwMSYWf9zZjiRQ@mail.gmail.com>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <362c02fa-2625-30c4-17a1-1a95753b6065@mykernel.net>
In-Reply-To: <CAOQ4uxgwZoB5GQJZvpPLzRqrQA-+JSowD+brUwMSYWf9zZjiRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E5=9C=A8 2021/12/7 13:33, Amir Goldstein =E5=86=99=E9=81=93:
> On Sun, Dec 5, 2021 at 4:07 PM Chengguang Xu <cgxu519@mykernel.net> wrote=
:
>>   ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 06:47:25 Amir G=
oldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>>   > On Wed, Dec 1, 2021 at 6:24 PM Chengguang Xu <cgxu519@mykernel.net> =
wrote:
>>   > >
>>   > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 J=
an Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
>>   > >  > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
>>   > >  > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykerne=
l.net> wrote:
>>   > >  > > > So the final solution to handle all the concerns looks like=
 accurately
>>   > >  > > > mark overlay inode diry on modification and re-mark dirty o=
nly for
>>   > >  > > > mmaped file in ->write_inode().
>>   > >  > > >
>>   > >  > > > Hi Miklos, Jan
>>   > >  > > >
>>   > >  > > > Will you agree with new proposal above?
>>   > >  > > >
>>   > >  > >
>>   > >  > > Maybe you can still pull off a simpler version by remarking d=
irty only
>>   > >  > > writably mmapped upper AND inode_is_open_for_write(upper)?
>>   > >  >
>>   > >  > Well, if inode is writeably mapped, it must be also open for wr=
ite, doesn't
>>   > >  > it? The VMA of the mapping will hold file open. So remarking ov=
erlay inode
>>   > >  > dirty during writeback while inode_is_open_for_write(upper) loo=
ks like
>>   > >  > reasonably easy and presumably there won't be that many inodes =
open for
>>   > >  > writing for this to become big overhead?
>>   >
>>   > I think it should be ok and a good tradeoff of complexity vs. perfor=
mance.
>>
>> IMO, mark dirtiness on write is relatively simple, so I think we can mar=
k the
>> overlayfs inode dirty during real write behavior and only remark writabl=
e mmap
>> unconditionally in ->write_inode().
>>
> If by "on write" you mean on write/copy_file_range/splice_write/...
> then yes I agree
> since we have to cover all other mnt_want_write() cases anyway.
>
>>   >
>>   > >  >
>>   > >  > > If I am not mistaken, if you always mark overlay inode dirty =
on ovl_flush()
>>   > >  > > of FMODE_WRITE file, there is nothing that can make upper ino=
de dirty
>>   > >  > > after last close (if upper is not mmaped), so one more inode =
sync should
>>   > >  > > be enough. No?
>>   > >  >
>>   > >  > But we still need to catch other dirtying events like timestamp=
 updates,
>>   > >  > truncate(2) etc. to mark overlay inode dirty. Not sure how reli=
ably that
>>   > >  > can be done...
>>   > >  >
>>   >
>>   > Oh yeh, we have those as well :)
>>   > All those cases should be covered by ovl_copyattr() that updates the
>>   > ovl inode ctime/mtime, so always dirty in ovl_copyattr() should be g=
ood.
>>
>> Currently ovl_copyattr() does not cover all the cases, so I think we sti=
ll need to carefully
>> check all the places of calling mnt_want_write().
>>
> Careful audit is always good, but if we do not have ovl_copyattr() in
> a call site
> that should mark inode dirty, then it sounds like a bug, because ovl inod=
e ctime
> will not get updated. Do you know of any such cases?

Sorry for my late response, I've been very busy lately.
For your question, for example, there is a case of calling=20
ovl_want_write() in ovl_cache_get_impure() and caller does not call=20
ovl_copyattr()
so I think we should explicitly mark ovl inode dirty in that case. Is=20
that probably a bug?


Thanks,
Chengguang



