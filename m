Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1232F155BF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGQjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 11:39:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726901AbgBGQjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581093540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3B0NGs/W84aAaWzmg3vv3+Dtgz3ksAr9b9eZvFXTsE=;
        b=E8mh0jbnMFvkdqb2aq6LeqXeK28+s0D3N0NBjKS1kJ87ji352nuFnUD41RID6ILP2Ts5mw
        12kh2LPtBI2ogAn13TkQH6YFmHV9fVDDQirErq1HPQ+/UTggJlU67HqeGZHW2KU1Xbrx5U
        xL6LjIL5rrLWo6/ZMUkxEYjlbRUItYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-p-TgbenOOESTjpZ8vNiTHw-1; Fri, 07 Feb 2020 11:38:57 -0500
X-MC-Unique: p-TgbenOOESTjpZ8vNiTHw-1
Received: by mail-wm1-f71.google.com with SMTP id t17so946896wmi.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 08:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3B0NGs/W84aAaWzmg3vv3+Dtgz3ksAr9b9eZvFXTsE=;
        b=johBQbSYk5WVu2d/zixeOUiBIzeGmhx2sw/fSWkmn5KQPbMfkS8uacRAtBwE2dP5wG
         aHr/S+okxRx+uW2WxRWSZ+js8LrKSJE1JI3pyifgGnPV0/7WPODQJqDHtEanUyOULMUn
         yYRCOU5UjHVjbX/zuS49CuJMifEnwKyIOvI8E/Ooy4VrLnvdRcxjpcs5ldCFyeMvO1kZ
         ho60+eRsBZ6q0uviz6ybsIHM7YjbHNkSBULzhKgrKvkIi6/oCueZOJsdJOFhpgLoE0bN
         XbbVauWEEAoSbKKmrpaQTLthBZdcObIl7Xk5U2oLq8kb1FIT22J2PILsK2yXWaVSqRm5
         02lQ==
X-Gm-Message-State: APjAAAVBWYqka0oJBp45DT575H3c1agu4MwVkyuF8wdKPzIghprB69ME
        gwEAgy21PuSVtL+ZxHT18dtZyW4vD2qHKMfclfNAR0e7VvNoufOLEf9YY734oMp5+7mpSVWwNYw
        4RRHAbwQcpuwlHw/l+UpDf5gxYw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5508475wmj.54.1581093536531;
        Fri, 07 Feb 2020 08:38:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzfXiEMRFxiSTWfBktKv/u3HPrByhX07ia/ebkul4WxGWtBDC2/WJGWlaoi2DsBrj0R/Rgng==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5508452wmj.54.1581093536325;
        Fri, 07 Feb 2020 08:38:56 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id e17sm3919212wma.12.2020.02.07.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:38:55 -0800 (PST)
Date:   Fri, 7 Feb 2020 17:38:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH] io_uring: flush overflowed CQ events in the
 io_uring_poll()
Message-ID: <20200207163853.bzfgn2mzpactehk3@steredhat>
References: <20200207121828.105456-1-sgarzare@redhat.com>
 <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acf040c-4b00-1647-e0c9-fc8b1c94685d@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 09:12:39AM -0700, Jens Axboe wrote:
> On 2/7/20 5:18 AM, Stefano Garzarella wrote:
> > In io_uring_poll() we must flush overflowed CQ events before to
> > check if there are CQ events available, to avoid missing events.
> > 
> > We call the io_cqring_events() that checks and flushes any overflow
> > and returns the number of CQ events available.
> > 
> > We can avoid taking the 'uring_lock' since the flush is already
> > protected by 'completion_lock'.
> 
> Thanks, applied. I dropped that last sentence, as a) it doesn't
> really matter, and b) we may very well already have it held here
> if someone is doing a poll on the io_uring fd itself.

Sure, indeed I was undecided whether to put it after the three dashes
as a response to your yesterday's request.

Thanks,
Stefano

