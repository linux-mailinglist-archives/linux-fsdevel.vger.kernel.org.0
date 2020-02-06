Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0215466F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBFOtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:49:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46274 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBFOtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:49:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so5706832qke.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJQnayg2t9HyzLdxg1/cTyDc+GhjfYN6AXv+5xX69wE=;
        b=ieV6ok887c2F2Q37B0Vs/T02DJAZZcWD4kKAITWhFRJBzU9zD4fBdyOHYhFshgnd2X
         mtQSUTQ4WyFmXpfVlBhWPc6sEpA7Owctef5O4VdScbMRViqIzj1/lNjm4z1xw3qBZKZU
         HT5kRPnInU2LA/Emeb7dXXnKZZlor7LkhlIQYcXwsdylT0Io18FiNHTIq59yjlqbodk6
         C9FtnaWNgEjqFqXc7KEkT45zerbRrFJDfMHcpa60ZKbkhJoLpXYqVbyfcHAxOnG6Qs0B
         yOFWG0sXcOcoZmmOW/Ielm+jdIMGIeLHUSJ3oQfLb1jahz7vJFxx6SLZsvalm/mGHjNv
         jQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJQnayg2t9HyzLdxg1/cTyDc+GhjfYN6AXv+5xX69wE=;
        b=hdVVz/qbhIFFwhc/Fbbt6uMzdPTv4ZuVKev/uhuyB60qqTdpR8+T0cn8Mephwe2m0g
         QONIvKP7tc+dcFVIboSaIocIob+5K6fq5X/TgSWWhh0BBwEKdPk3+nUNdA4Xy2UUQxSN
         xOWjuqJL8IK23BD1QYHpLNWXfiF1+1QdG3efLptZhkmki9Fe/KI8hMJqjoFJPnPcj4DL
         eK6lGSbP4Si+j6KupJ7s0qBnv9+ygZpZTEHmCSztqIP2YgGdVywovq8P9TIEZooQ5LOW
         XGCgUsoX7+t56IvOLKcoKZhkyABK6gE9Qe7GZ1RZxzKpZTRUrtjDhDwabOhhlPUyWqPJ
         s1Bg==
X-Gm-Message-State: APjAAAULiSB2n2keKE0dgpCXVMyQGqoMYlwfQAGdNmA65kKAbfRuXnD+
        Tkqwh/ls4soL9QmUvdYHvvwA/yITZ8w=
X-Google-Smtp-Source: APXvYqzl17RYyuUw116o46PwQutXSqSIbFwrWw1az9DYbQsBJA9hxWHyfEgOgpEuEGbHVCBOW/B/jw==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr2706428qki.200.1581000551158;
        Thu, 06 Feb 2020 06:49:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c186sm1493820qke.124.2020.02.06.06.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:49:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iziSs-0006Au-0h; Thu, 06 Feb 2020 10:49:10 -0400
Date:   Thu, 6 Feb 2020 10:49:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206144909.GH25297@ziepe.ca>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <20200205184344.GB28298@ziepe.ca>
 <20200205215904.GT8731@bombadil.infradead.org>
 <20200206134904.GD25297@ziepe.ca>
 <20200206143627.GA26114@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206143627.GA26114@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:36:27PM +0100, Jan Kara wrote:

> Yeah, that's why I'd prefer if NULL was not "special value" at all and if
> someone wanted to remove index from xarray he'd always have to use a
> special function. My patches go towards that direction but not the full way
> because there's still xa_cmpxchg() whose users use the fact that NULL is in
> fact 'erase'.

IMHO, this is more appealing. The fact that xa_store(NULL) on
non-allocating arrays changes marks seems very surprising/counter
intuitive. It feels wise to avoid subtle differences like this between
allocating/non-allocating mode.

So, it would be more uniform if xa_store and xa_cmpxchg never altered
marks. I suppose in practice this means that xa_store(NULL) has to
store a XA_ZERO_ENTRY even for non-allocating arrays, and related.

Perhaps xa_cmp_erase() could be introduced to take the place of
cmpxchg(NULL), and the distinction between erase and store NULL is
that erase has the mark-destroying property and guarentees the tree
can be pruned.

Jason
