Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDB1660F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBTPbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:31:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56676 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgBTPbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:31:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFNwuY192733;
        Thu, 20 Feb 2020 15:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=u5fnLg75pU3mlFP0qdM0mNbAL16bOquMeO3QiE/+bWc=;
 b=ZZ/BBv7NVYMfNlRKwRU6X/B4HHodiV2/eQFu2I34Jr4vpdAHx03nFFYsOqiwc1H2lnvt
 bmC2ACr6p0PYtSVeR7ZUk9FFU8PkRceV9bvhSbIz+HDvUbh+lKlJC0IGWPoO8B5DOh7T
 5CJkWPXkBWmPcTDmumVC1yRbCAKPOykMeUWumdVS451Iuh5KmYOG7T61n1jMFugARKlC
 rrBuoEMzEhfghb+QmfJsExY8jvKwlLQN5JXw+One8IGv5RtX1kmtlA/NcoXd8KPxNxFF
 WsqFrCJpfkMm28YdRn7W3c/aD+s8uGFDFvEC3JruIzCfPwSn9hBL+vx1VL1Hs//ix2On 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udkjfxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:31:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFSOFx036989;
        Thu, 20 Feb 2020 15:31:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y8udcyyug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:31:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KFVJPs008924;
        Thu, 20 Feb 2020 15:31:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 07:31:19 -0800
Date:   Thu, 20 Feb 2020 07:31:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #16]
Message-ID: <20200220153118.GE9496@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
 <CAG48ez0o3iHjQJNvh8V2Ao77g0CqfqGsv6caMCOFDy7w-VdtkQ@mail.gmail.com>
 <584179.1582196636@warthog.procyon.org.uk>
 <CAG48ez00KA3tjeccDCeqmgHyppTLEr+UkrB=QaQ-FX-cTY3aCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez00KA3tjeccDCeqmgHyppTLEr+UkrB=QaQ-FX-cTY3aCA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=2 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=2
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:54:25PM +0100, Jann Horn wrote:
> On Thu, Feb 20, 2020 at 12:04 PM David Howells <dhowells@redhat.com> wrote:
> > Jann Horn <jannh@google.com> wrote:
> >
> > > > +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> > > ...
> > > Please add a check here to ensure that "ret" actually fits into the
> > > buffer (and use WARN_ON() if you think the check should never fire).
> > > Otherwise I think this is too fragile.
> >
> > How about:
> >
> >         int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> >         {
> >                 unsigned int len;
> >                 char *p = ctx->buffer;
> >                 int ret = 0;
> >                 if (s) {
> >                         len = strlen(s);
> >                         if (len > ctx->buf_size - 1)
> >                                 len = ctx->buf_size;
> >                         if (!ctx->want_size_only) {
> >                                 memcpy(p, s, len);
> >                                 p[len] = 0;
> 
> I think this is off-by-one? If len was too big, it is set to
> ctx->buf_size, so in that case this effectively becomes
> `ctx->buffer[ctx->buf_size] = 0`, which is one byte out of bounds,
> right?
> 
> Maybe use something like `len = min_t(size_t, strlen(s), ctx->buf_size-1)` ?
> 
> Looks good apart from that, I think.
> 
> >                         }
> >                         ret = len;
> >                 }
> >                 return ret;
> >         }
> [...]
> > > > +       return ctx->usage;
> > >
> > > It is kind of weird that you have to return the ctx->usage everywhere
> > > even though the caller already has ctx...
> >
> > At this point, it's only used and returned by fsinfo_attributes() and really
> > is only for the use of the attribute getter function.
> >
> > I could, I suppose, return the amount of data in ctx->usage and then preset it
> > for VSTRUCT-type objects.  Unfortunately, I can't make the getter return void
> > since it might have to return an error.
> 
> Yeah, then you'd be passing around the error separately from the
> length... I don't know whether that'd make things better or worse.
> 
> [...]
> > > > +struct fsinfo_attribute {
> > > > +       unsigned int            attr_id;        /* The ID of the attribute */
> > > > +       enum fsinfo_value_type  type:8;         /* The type of the attribute's value(s) */
> > > > +       unsigned int            flags:8;
> > > > +       unsigned int            size:16;        /* - Value size (FSINFO_STRUCT) */
> > > > +       unsigned int            element_size:16; /* - Element size (FSINFO_LIST) */
> > > > +       int (*get)(struct path *path, struct fsinfo_context *params);
> > > > +};
> > >
> > > Why the bitfields? It doesn't look like that's going to help you much,
> > > you'll just end up with 6 bytes of holes on x86-64:
> >
> > Expanding them to non-bitfields will require an extra 10 bytes, making the
> > struct 8 bytes bigger with 4 bytes of padding.  I can do that if you'd rather.
> 
> Wouldn't this still have the same total size?
> 
> struct fsinfo_attribute {
>   unsigned int attr_id;        /* 0x0-0x3 */
>   enum fsinfo_value_type type; /* 0x4-0x7 */
>   u8 flags;                    /* 0x8-0x8 */
>   /* 1-byte hole */
>   u16 size;                    /* 0xa-0xb */
>   u16 element_size;            /* 0xc-0xd */
>   /* 2-byte hole */
>   int (*get)(...);             /* 0x10-0x18 */
> };
> 
> But it's not like I really care about this detail all that much, feel
> free to leave it as-is.

I was thinking, why not just have unsigned int flags from the start?
That replaces the padding holes with usable flag space, though I guess
this is in-core only so I'm not that passionate.  I doubt we're going to
have millions of fsinfo attributes. :)

--D
