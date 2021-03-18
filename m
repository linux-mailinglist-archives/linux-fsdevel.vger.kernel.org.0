Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DA340749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCRN41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhCRN4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ko6xEJyhnnBLHDhEhVPgbCcq/LQrGvYk0VGhLsquv74=;
        b=MYH4DRJ6HAdUXR5XXjsdwM85oV+rjh61fiUQ6OIPmeWl1ItTHTqKRHveGxZu+iJX09mnqN
        18E3cgFZT9+rxpETyC0JW2w2533omRiKIHtUziYfAbMCWAUD+dAzmmmGfPPoQII8FTf1Hw
        WLq9lOYJ+TA93jaPMG7GFewiM9xg2Iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-5YJ737J_MvWvKnd0OT_itg-1; Thu, 18 Mar 2021 09:56:08 -0400
X-MC-Unique: 5YJ737J_MvWvKnd0OT_itg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D7881622;
        Thu, 18 Mar 2021 13:56:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-48.rdu2.redhat.com [10.10.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4F95D9DE;
        Thu, 18 Mar 2021 13:56:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AD44B220BCF; Thu, 18 Mar 2021 09:56:00 -0400 (EDT)
Date:   Thu, 18 Mar 2021 09:56:00 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about sg_count_fuse_req() in linux/fs/fuse/virtio_fs.c
Message-ID: <20210318135600.GA368102@redhat.com>
References: <810089e0-3a09-0d8f-9f8e-be5b3ac70587@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810089e0-3a09-0d8f-9f8e-be5b3ac70587@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:12:01PM -0500, Connor Kuehl wrote:
> Hi,
> 
> I've been familiarizing myself with the virtiofs guest kernel module and I'm
> trying to better understand how virtiofs maps a FUSE request into
> scattergather lists.
> 
> sg_count_fuse_req() starts knowing that there will be at least one in
> header, as shown here (which makes sense):
> 
>         unsigned int size, total_sgs = 1 /* fuse_in_header */;
> 
> However, I'm confused about this snippet right beneath it:
> 
>         if (args->in_numargs - args->in_pages)
>                 total_sgs += 1;
> 
> What is the significance of the sg that is needed in the cases where this
> branch is taken? I'm not sure what its relationship is with args->in_numargs
> since it will increment total_sgs regardless args->in_numargs is 3, 2, or
> even 1 if args->in_pages is false.

Hi Conor,

I think all the in args are being mapped into a single scatter gather
element and that's why it does not matter whether in_numargs is 3, 2 or 1.
They will be mapped in a single element.

sg_init_fuse_args()
{
        len = fuse_len_args(numargs - argpages, args);
        if (len)
                sg_init_one(&sg[total_sgs++], argbuf, len);
}

        out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
                                     (struct fuse_arg *)args->in_args,
                                     args->in_numargs, args->in_pages,
                                     req->argbuf, &argbuf_used);

When we are sending some data in some pages, then we set args->in_pages
to true. And in that case, last element of args->in_args[] contains the
total size of bytes in additional pages we are sending and is not part
of in_args being mapped to scatter gather element. That's why this
check.

	if (args->in_numargs - args->in_pages)
		total_sgs += 1;

Not sure when we will have a case where args->in_numargs = 1 and
args->in_pages=true. Do we ever hit that.

Thanks
Vivek

> 
> Especially since the block right below it counts pages if args->in_pages is
> true:
> 
>         if (args->in_pages) {
>                 size = args->in_args[args->in_numargs - 1].size;
>                 total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
>                                                  size);
>         }
> 
> The rest of the routine goes on similarly but for the 'out' components.
> 
> I doubt incrementing 'total_sgs' in the first if-statement I showed above is
> vestigial, I just think my mental model of what is happening here is
> incomplete.
> 
> Any clarification is much appreciated!

> 
> Connor
> 

