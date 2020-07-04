Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CEF21484F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgGDTOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgGDTOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 15:14:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F1C061794;
        Sat,  4 Jul 2020 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F4iUDa3dtDRXZw/xT8rOR2vZ5fAZKoqf4RZc7OOfWV8=; b=YO/hA7aGz+aOl1sROiWsWS/Izd
        l/rue0A+a+DIVbtJC2Fxv28sJBNeRafUX7zbX/mrKJqMHhNOz4+RVgsKgTIyPNBsWlVH3oElhuYh3
        SzJ0nN5HjmQwXjRE7u9p4BhJThdcS8Vg0wk35nMyhTirZ9fQEFA31D3UffGa2h9R4utUFsvPckhuS
        Sd5BRL6Fj1Y2dU6PdhXDcNBNGG6C+fCn5MbhAbHkyDDo6cBVModkQBHFZRtZJUVnQbl1Gb/OUvpFd
        WOD3xnIJZQV/6U4Z4g8czBdmheverCxGJX/JT3wSzjKeFCWKQo8/sPs0bbYJUfA75PTn/IK1siWVB
        KLTNXZmw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrncA-0004qS-0a; Sat, 04 Jul 2020 19:14:18 +0000
Date:   Sat, 4 Jul 2020 20:14:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
Message-ID: <20200704191417.GQ25523@casper.infradead.org>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704140250.423345-2-gregkh@linuxfoundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 04:02:47PM +0200, Greg Kroah-Hartman wrote:
> +	/* only accept a small subset of O_ flags that make sense */
> +	if ((flags & (O_NOFOLLOW | O_NOATIME)) != flags)
> +		return -EINVAL;
> +
> +	/* add some needed flags to be able to open the file properly */
> +	flags |= O_RDONLY | O_LARGEFILE;

Should we also add O_NOCTTY to prevent any problems if this is called on
a tty?

