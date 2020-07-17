Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09B2236B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 10:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQINr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 04:13:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbgGQINq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594973624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AhK0Zzm0uakjm5OFnnhauntdAQG4ut12mfNiIODHdo=;
        b=gQaSFMz9/uXkzW1LXE9rrFMwHbPDqDbxvLGB1dqNcRW79x6DxBkESgkzrtzWZPHUHc+VJn
        QVLwidklEuunuIzRZr7IkffgYB8TnsjzKk/zMN5fifkXy/QNKdNruj3WcCgJXrxOY0pt9U
        WGw/zmEXG3yg0jyC6E45sgIgHjfmP9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-3kGFVM6oNnW-Kv3IO7MpUA-1; Fri, 17 Jul 2020 04:13:40 -0400
X-MC-Unique: 3kGFVM6oNnW-Kv3IO7MpUA-1
Received: by mail-wr1-f69.google.com with SMTP id d11so8285105wrw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 01:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AhK0Zzm0uakjm5OFnnhauntdAQG4ut12mfNiIODHdo=;
        b=cf1yr5ANsqrYqQ/TVSu9lSM+3whysuz9McYF7WBEmHOvkIiObgB9eDBRYz1Dgm8rQy
         ZoTF6FU1kyZ+DpCe9VnHB4pvyD4EBy7XoUoVimVI1Hu1gteiF3NxQyneNDeZq8gnv5uF
         KCiLwf3DTt7CS0oMss4TW1j4Lt1qKplbbvLEEzKLxRVa0esKJamj9ziOUmBeqV8PZdgZ
         YMTOAN2ocMdM2S02p1OQD2cAHZT+4nXB4NZ9PfEde238jinaJ22GvRzPtMMaAxXffQs0
         6yS5HaErzYJTOcSidpePgdJBnNwJivNu00PDLKyTxu3v/LPL9hxHwxbeH/hyybitcdZN
         KU0g==
X-Gm-Message-State: AOAM532yCbyw/KKHJma1Z2Nkq7Azu2encf2mBYTdgpNzu8JI7hH3l7fZ
        d0Hi3bkq/NmoHp5RPQIlw4qtYHsTNj+Nvc4pOuK0sjLK0QbMP/ltGb1jeJhh59XRG9AivBB6FNs
        YhXDHDDG0xdZNlEmOa8cG8hjepA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr8623602wme.177.1594973619425;
        Fri, 17 Jul 2020 01:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeW6RsdiE3kyUT5zs2nMNiDhKPd7zXn+E25Grakr6B0wzn0S3WYa0J8I4e51M3iaPMLfxKUA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr8623586wme.177.1594973619210;
        Fri, 17 Jul 2020 01:13:39 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id a4sm14353571wrg.80.2020.07.17.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:13:38 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:13:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
Message-ID: <20200717081333.6z6rtwx3jtktwdvp@steredhat.lan>
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-2-sgarzare@redhat.com>
 <ca242a15-576d-4099-a5f8-85c08985e3ff@gmail.com>
 <a2f109b2-adbf-147d-9423-7a1a4bf99967@kernel.dk>
 <20326d79-fb5a-2480-e52a-e154e056171f@gmail.com>
 <76879432-745d-a5ca-b171-b1391b926ea2@kernel.dk>
 <0357e544-d534-06d2-dc61-1169fc172d20@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0357e544-d534-06d2-dc61-1169fc172d20@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:20:53PM -0600, Jens Axboe wrote:
> On 7/16/20 2:51 PM, Jens Axboe wrote:
> > On 7/16/20 2:47 PM, Pavel Begunkov wrote:
> >> On 16/07/2020 23:42, Jens Axboe wrote:
> >>> On 7/16/20 2:16 PM, Pavel Begunkov wrote:
> >>>> On 16/07/2020 15:48, Stefano Garzarella wrote:
> >>>>> The enumeration allows us to keep track of the last
> >>>>> io_uring_register(2) opcode available.
> >>>>>
> >>>>> Behaviour and opcodes names don't change.
> >>>>>
> >>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>>>> ---
> >>>>>  include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
> >>>>>  1 file changed, 16 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >>>>> index 7843742b8b74..efc50bd0af34 100644
> >>>>> --- a/include/uapi/linux/io_uring.h
> >>>>> +++ b/include/uapi/linux/io_uring.h
> >>>>> @@ -253,17 +253,22 @@ struct io_uring_params {
> >>>>>  /*
> >>>>>   * io_uring_register(2) opcodes and arguments
> >>>>>   */
> >>>>> -#define IORING_REGISTER_BUFFERS		0
> >>>>> -#define IORING_UNREGISTER_BUFFERS	1
> >>>>> -#define IORING_REGISTER_FILES		2
> >>>>> -#define IORING_UNREGISTER_FILES		3
> >>>>> -#define IORING_REGISTER_EVENTFD		4
> >>>>> -#define IORING_UNREGISTER_EVENTFD	5
> >>>>> -#define IORING_REGISTER_FILES_UPDATE	6
> >>>>> -#define IORING_REGISTER_EVENTFD_ASYNC	7
> >>>>> -#define IORING_REGISTER_PROBE		8
> >>>>> -#define IORING_REGISTER_PERSONALITY	9
> >>>>> -#define IORING_UNREGISTER_PERSONALITY	10
> >>>>> +enum {
> >>>>> +	IORING_REGISTER_BUFFERS,
> >>>>> +	IORING_UNREGISTER_BUFFERS,
> >>>>> +	IORING_REGISTER_FILES,
> >>>>> +	IORING_UNREGISTER_FILES,
> >>>>> +	IORING_REGISTER_EVENTFD,
> >>>>> +	IORING_UNREGISTER_EVENTFD,
> >>>>> +	IORING_REGISTER_FILES_UPDATE,
> >>>>> +	IORING_REGISTER_EVENTFD_ASYNC,
> >>>>> +	IORING_REGISTER_PROBE,
> >>>>> +	IORING_REGISTER_PERSONALITY,
> >>>>> +	IORING_UNREGISTER_PERSONALITY,
> >>>>> +
> >>>>> +	/* this goes last */
> >>>>> +	IORING_REGISTER_LAST
> >>>>> +};
> >>>>
> >>>> It breaks userspace API. E.g.
> >>>>
> >>>> #ifdef IORING_REGISTER_BUFFERS
> >>>
> >>> It can, yes, but we have done that in the past. In this one, for
> >>
> >> Ok, if nobody on the userspace side cares, then better to do that
> >> sooner than later.
> 
> I actually don't think it's a huge issue. Normally if applications
> do this, it's because they are using it and need it. Ala:
> 
> #ifndef IORING_REGISTER_SOMETHING
> #define IORING_REGISTER_SOMETHING	fooval
> #endif
> 
> and that'll still work just fine, even if an identical enum is there.
> 

Thank you both for the review!

Then if you agree, I'll leave this patch as it is by introducing the enum.

Stefano

