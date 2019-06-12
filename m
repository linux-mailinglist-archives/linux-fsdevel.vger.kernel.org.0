Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69D42CEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfFLRDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 13:03:07 -0400
Received: from mail177-30.suw61.mandrillapp.com ([198.2.177.30]:35904 "EHLO
        mail177-30.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731013AbfFLRDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Hm2gC+regS6aFJ0Z5S9VnOE8zeLWgmtCRNQHokPDkY8=;
 b=qlDkCCC/dPk74baVrVBLmOyLG+QU2eZx1SW9cdMEM2vAaKwb3Uj1ZVjG9dQUHZG7CqHgOKn2opNw
   zmxoR6WyKbtWnRPy0A3ja3InFo6aPJahQB5TCVqrIi/05h1Z+SbKhFGfSjJMOoHXrKFtPRyDFNDs
   sGOxzYm5BnXaxI0RabQ=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-30.suw61.mandrillapp.com id h04o4k22rtkf for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 17:03:05 +0000 (envelope-from <bounce-md_31050260.5d013049.v1-5c098753ca0b48a9a0f1a7baec548156@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560358985; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Hm2gC+regS6aFJ0Z5S9VnOE8zeLWgmtCRNQHokPDkY8=; 
 b=gyUQ2OA+FpqROVGuWEuouAFmLCuyTSCFEJiHlRTKoqy65wnR2sJIcjFX6zHmJTmBUjJUBd
 tCnYKV/guLBZNJGm9WNTM8TzJc3brbd9Ugs71cZMXWAcHd8uowf6wkBR8w/0ePcRTlWG6AVs
 GdTomTrpwS3dagPdbDPvj+LIn55Rg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id 5c098753ca0b48a9a0f1a7baec548156; Wed, 12 Jun 2019 17:03:05 +0000
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <gluster-devel@gluster.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190612170259.GA27637@deco.navytux.spb.ru>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it> <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com> <20190611202738.GA22556@deco.navytux.spb.ru> <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com> <20190612112544.GA21465@deco.navytux.spb.ru> <f31ca7b5-0c9b-5fde-6a75-967265de67c6@eikelenboom.it> <20190612141220.GA25389@deco.navytux.spb.ru> <f79ff13f-701b-89d8-149c-e53bb880bb77@eikelenboom.it>
In-Reply-To: <f79ff13f-701b-89d8-149c-e53bb880bb77@eikelenboom.it>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.5c098753ca0b48a9a0f1a7baec548156
X-Mandrill-User: md_31050260
Date:   Wed, 12 Jun 2019 17:03:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 06:28:17PM +0200, Sander Eikelenboom wrote:
> On 12/06/2019 16:12, Kirill Smelkov wrote:
> > On Wed, Jun 12, 2019 at 03:03:49PM +0200, Sander Eikelenboom wrote:
> >> On 12/06/2019 13:25, Kirill Smelkov wrote:
> >>> On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
> >>>> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wr=
ote:
> >>>>
> >>>>> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)=
` for
> >>>>> header room change be accepted?
> >>>>
> >>>> Yes, next cycle.   For 4.2 I'll just push the revert.
> >>>
> >>> Thanks Miklos. Please consider queuing the following patch for 5.3.
> >>> Sander, could you please confirm that glusterfs is not broken with th=
is
> >>> version of the check?
> >>>
> >>> Thanks beforehand,
> >>> Kirill
> >>
> >>
> >> Hmm unfortunately it doesn't build, see below.
> >> [...]
> >> fs/fuse/dev.c:1336:14: error: =E2=80=98fuse_in_header=E2=80=99 undecla=
red (first use in this function)
> >>        sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write)=
)
> > 
> > Sorry, my bad, it was missing "struct" before fuse_in_header. I
> > originally compile-tested the patch with `make -j4`, was distracted ont=
o
> > other topic and did not see the error after returning due to long tail
> > of successful CC lines. Apologize for the inconvenience. Below is a
> > fixed patch that was both compile-tested and runtime-tested with my FUS=
E
> > workloads (non-glusterfs).
> > 
> > Kirill
> > 
> 
> Just tested and it works for me, thanks !

Thanks for feedback. Kirill

